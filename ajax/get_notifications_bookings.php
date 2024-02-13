<?php
ini_set('error_reporting', 0);

session_start();

require_once('../api/Backend.php');

class Sc extends Backend
{
	public $user;
	public $params;

	function fetch()
	{

		if(isset($_SESSION['user_id']))
		{
			$u = $this->users->get_user(intval($_SESSION['user_id']));
			if($u && $u->enabled)
				$this->user = $u;
			else
				return false;
		}
		else
			return false;


		$this->params = new stdClass;

		// $this->design->set_templates_dir('../design/html');
		// $this->design->set_compiled_dir('../design/compiled');


		$currencies = $this->money->get_currencies(array('enabled'=>1));
		if(isset($_SESSION['currency_id']))
			$currency = $this->money->get_currency($_SESSION['currency_id']);
		else
			$currency = reset($currencies);

		$this->design->assign('currency', $currency);

		

		$result = new stdClass;
		$result->items = 0;


		$landlords_companies = $this->users->get_landlords_houses([
			'user_id' => $this->user->id
		]);
		$landlords_companies = $this->request->array_to_key($landlords_companies, 'house_id');

		if(!empty($landlords_companies))
		{
			// LLC
			$houses_ids = [];
			$this->params->companies = $this->companies->get_companies([
				'id' => array_keys($landlords_companies)
			]);
			$this->params->companies = $this->request->array_to_key($this->params->companies, 'id');
			if(!empty($this->params->companies))
			{
				$company_houses_ids = $this->companies->get_company_houses([
					'company_id' => array_keys($this->params->companies)
				]);
				$company_houses_ids = $this->request->array_to_key($company_houses_ids, 'house_id');

				if(!empty($company_houses_ids))
				{
					$houses_ids = array_keys($company_houses_ids);
				}
			}

		}
		elseif($this->user->id == 4714 || $this->user->id == 4715)
		{
			$houses_ids[] = 185; // The Central Park Manhattan House for owners
		}


		if(!empty($houses_ids))
		{
			$houses = $this->pages->get_pages([
				'id' => $houses_ids,
				'menu_id' => 5,
				'visible' => 1
			]);

			if(!empty($houses))
			{
				foreach($houses as $k=>$h)
				{
					if(!empty($h->blocks2))
						$houses[$k]->blocks2 = unserialize($h->blocks2);
				}
				if(!empty($selected_house_id) && isset($houses[$selected_house_id]))
					$this->selected_house = $houses[$selected_house_id];
				else
					$this->selected_house = current($houses);

				$houses[$this->selected_house->id]->selected = 1;

			}

			if(!empty($this->selected_house))
			{
				// if(!empty($this->selected_house->blocks2))
				// 	$this->selected_house->blocks2 = unserialize($this->selected_house->blocks2);

				// LLC Name
				if(isset($this->params->companies[$company_houses_ids[$this->selected_house->id]->company_id]))
					$this->selected_house->llc_name = $this->params->companies[$company_houses_ids[$this->selected_house->id]->company_id]->name;
			}


			$bookinfs_params = [
				'house_id' => $houses_ids,
				'status' => 3,
				'client_type_not_id' => 5, // 5 - houseleader
				'date_from' => '2021-03-01',
				'sp_group' => true,
				'select_users' => true,
				'sp_group_from_start' => true,
				'limit' => 15,
				'page' => 1
			];

			$page = $this->request->get('page', 'integer');
			if(!empty($page))
			{
				$bookinfs_params['page'] = $page;
			}

			$notifications_bookings = $this->beds->get_bookings($bookinfs_params);

			if($notifications_bookings)
			{
				foreach($notifications_bookings as $k=>$b)
				{
					if($b->id == 3853)
					{
						unset($notifications_bookings[$k]);
					}
					else
					{
						$result->items ++;

						$u_arrive = strtotime($b->arrive);
			            $u_depart = strtotime($b->depart);
			            $b_interval = $u_depart - $u_arrive;
						$b->days_count = ceil($b_interval / (24 * 60 * 60)) + 1;

						if(!empty($b->arrive) && !empty($b->depart) && $b->price_month > 0 && $b->total_price < 1)
						{
							$price_calculate = $this->contracts->calculate($b->arrive, $b->depart, $b->price_month);
							if(!empty($price_calculate))
							{
								$notifications_bookings[$k]->total_price = $price_calculate->total;
							}
						}
					}
				}
			}

			// print_r($notifications_bookings); exit;

			$this->design->assign('notifications_bookings', $notifications_bookings);
			$this->design->assign('houses', $houses);

			$result->tpl = $this->design->fetch('landlord/bx/notifications_bookings.tpl');

		}

		header("Content-type: application/json; charset=UTF-8");
		header("Cache-Control: must-revalidate");
		header("Pragma: no-cache");
		header("Expires: -1");		
		print json_encode($result);
	}
}


$sc = new Sc();
$sc->fetch();