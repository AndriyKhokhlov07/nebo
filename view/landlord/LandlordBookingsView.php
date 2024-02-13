<?PHP

require_once('view/View.php');

class LandlordBookingsView extends View
{
	private $params;


	function fetch()
	{
		if(empty($this->user))
		{
			header("HTTP/1.1 301 Moved Permanently"); 
			header('Location: '.$this->config->root_url.'/user/login');
			exit();
		}

		if($this->user->type != 4)
			return false;

		if(empty($this->user->permissions['bookings']) && !empty($this->user->permissions))
		{
			header("HTTP/1.1 301 Moved Permanently"); 
			header('Location: '.$this->config->root_url.'/landlord/'.current($this->user->permissions));
			exit();
		}

		$landlord = new stdClass;

		if(!empty($this->user->email))
		{
			if(!empty($this->user->main_info))
				$landlord->main_info = $this->user->main_info;

			$houses = [];
			$selected_house_id = $this->request->get('house_id', 'integer');




			/*
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
			*/


			if(!empty($this->user->landlords_companies))
			{

			}
			elseif($this->user->id == 4714 || $this->user->id == 4715)
			{
				$this->user->houses_ids[] = 185; // The Central Park Manhattan House for owners
			}

			


			if(!empty($this->user->houses_ids))
			{
				$houses = $this->pages->get_pages([
					'id' => $this->user->houses_ids,
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
					if(isset($this->user->companies[$this->user->company_houses_ids[$this->selected_house->id]->company_id]))
						$this->selected_house->llc_name = $this->user->companies[$this->user->company_houses_ids[$this->selected_house->id]->company_id]->name;


				}



				$bookinfs_params = [
					'house_id' => $this->user->houses_ids,
					'status' => 3,
					'client_type_not_id' => 5, // 5 - houseleader
					'date_from' => '2021-03-01',
					'sp_group' => true,
					'select_users' => true,
					'sp_group_from_start' => true,
					'limit' => 15,
					'page' => 1
				];

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
							$u_arrive = strtotime($b->arrive);
				            $u_depart = strtotime($b->depart);
				            $b_interval = $u_depart - $u_arrive;
							$b->days_count = round($b_interval / (24 * 60 * 60)) + 1;


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
			}
		}


		$meta_title = 'Bookings';
		if(!empty($this->selected_house))
			$meta_title .= ' | '.$this->selected_house->name;
		$this->design->assign('meta_title', $meta_title);


		$this->design->assign('houses', $houses);
		$this->design->assign('selected_house', $this->selected_house);
		$this->design->assign('landlord', $landlord);
		$this->design->assign('params', $this->params);

		return $this->design->fetch('landlord/bookings.tpl');
	}
}
