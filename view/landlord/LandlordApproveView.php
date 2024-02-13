<?PHP

require_once('view/View.php');

class LandlordApproveView extends View
{
	private $params;



	function approve_list()
	{
		// Approve List
		$salesflows_ = $this->salesflows->get_salesflows([
			//'id_greater' => $this->salesflows->id_greater,
			'to_approve' => true,
			'house_id' => $this->user->landlord_approve_houses_ids, 
			'booking_created_from' => $this->salesflows->booking_created_from,
			'user_not_status' => [
				6, // Canceled
				5, // Blacklist
				9  // Landlords
			],
			// 'query' => 'print'
		]);

		if(!empty($salesflows_))
		{
			$salesflows = [];
			$bookings_salesflows_ids = [];
			foreach($salesflows_ as $s)
			{
				$bookings_salesflows_ids[$s->booking_id][$s->id] = $s->id;
				$salesflows[$s->id] = $s;
			}
			unset($salesflows_);


			$bookings_ids = array_keys($bookings_salesflows_ids);
			$bookings = $this->beds->get_bookings([
				'id' => $bookings_ids,
				'sp_group' => true,
				'sp_group_from_start' => true
			]);

			if(!empty($bookings))
			{
				foreach($bookings as $b)
				{
					if(isset($bookings_salesflows_ids[$b->id]))
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
								$b->total_price = $price_calculate->total;
							}
						}

						foreach($bookings_salesflows_ids[$b->id] as $s_id)
						{
							$salesflows[$s_id]->booking = $b;
						}
					}
				}

				$contracts = $this->contracts->get_contracts([
					'reserv_id' => $bookings_ids,
					'status' => 1
				]);
				if(!empty($contracts))
				{
					foreach($contracts as $c)
					{
						if(isset($bookings_salesflows_ids[$c->reserv_id]))
						{
							foreach($bookings_salesflows_ids[$c->reserv_id] as $s_id)
							{
								$salesflows[$s_id]->contract = $c;
							}
						}
					}
				}
			}
			$houses = $this->pages->get_pages([
				'id' => $this->user->landlord_approve_houses_ids,
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
			}


			$apartments = $this->beds->get_apartments([
				'house_id' => $this->user->landlord_approve_houses_ids,
				'visible' => 1
			]);
			$apartments = $this->request->array_to_key($apartments, 'id');

			$rooms = $this->beds->get_rooms([
				'house_id' => $this->user->landlord_approve_houses_ids,
				'visible' => 1
			]);
			$rooms = $this->request->array_to_key($rooms, 'id');

			$beds = false;
			if(!empty($rooms))
			{
				$beds = $this->beds->get_beds([
					'room_id' => array_keys($rooms),
					'visible' => 1
				]);
				$beds = $this->request->array_to_key($beds, 'id');
			}
		}


		$meta_title = 'For Approval';
		$this->design->assign('meta_title', $meta_title);

		$this->design->assign('salesflows', $salesflows);

		$this->design->assign('houses', $houses);
		$this->design->assign('apartments', $apartments);
		$this->design->assign('beds', $beds);

		if(isset($this->params->landlord))
			$this->design->assign('landlord', $this->params->landlord);
		$this->design->assign('params', $this->params);

		return $this->design->fetch('landlord/approve_list.tpl');
	}


	function approve_item($salesflow_id)
	{
		// if($salesflow_id < $this->salesflows->id_greater)
		// 	return false;

		$salesflow = $this->salesflows->get_salesflows([
			'id' => $salesflow_id,
			'to_approve' => true,
			'limit' => 1
		]);
		if(empty($salesflow))
			return false;


		// email test
		// $this->notify->email_landlord_tenant_approve($salesflow->id);



		$salesflow->tenant = $this->users->get_users([
			'id' => $salesflow->user_id,
			'not_status' => [
				6, // Canceled
				5, // Blacklist
				9  // Landlords
			],
			'limit' => 1,
			'count' => 1
		]);
		if(empty($salesflow->tenant))
			return false;


		$bookings = $this->beds->get_bookings([
			'id' => $salesflow->booking_id,
			'sp_group' => true,
			'sp_group_from_start' => true
		]);
		if(empty($bookings))
			return false;

		$salesflow->booking = $bookings[$salesflow->booking_id];
		if($salesflow->booking->status == 0)
			return false;


		// 


		$approve_action = $this->request->post('approve', 'integer');
		$approve_note = $this->request->post('note');

		if($approve_action == 1) // Approve
		{
			$this->salesflows->landlord_approve_salesflow([
				'salesflow_id' => $salesflow->id, 
				'sender' => $this->user->id, 
				'sender_type' => 3,
				'approve_type' => 1 // Approve
			]);
		}
		elseif($approve_action == 2) // More docs
		{
			$salesflow_params = [
				'salesflow_id' => $salesflow->id, 
				'sender' => $this->user->id, 
				'sender_type' => 3,
				'approve_type' => 2 // More docs
			];
			if(!empty($approve_note))
				$salesflow_params['log_value'] = $approve_note;
			$this->salesflows->landlord_approve_salesflow($salesflow_params);
		}
		elseif($approve_action == 3) // Reject
		{
			$salesflow_params = [
				'salesflow_id' => $salesflow->id, 
				'sender' => $this->user->id, 
				'sender_type' => 3,
				'approve_type' => 3 // Reject
			];
			if(!empty($approve_note))
				$salesflow_params['log_value'] = $approve_note;
			$this->salesflows->landlord_approve_salesflow($salesflow_params);

		}

		if(!empty($approve_action))
		{
			return false;
		}




		// Contract

		$salesflow_contracts = $this->contracts->get_contracts([
			'reserv_id' => $salesflow->booking_id,
			'status' => 1
		]);
		if(!empty($salesflow_contracts))
			$salesflow->contract = current($salesflow_contracts);
		elseif($salesflow->deposit_type == 1) // Outpost deposit
		{
			$salesflow->deposit_invoice = $this->orders->get_orders([
				'booking_id' => $salesflow->booking_id,
				'deposit' => 1,
				'count' => 1
			]);
		}


		// Documents

		if(!empty($salesflow->application_data))
			$salesflow->application_data = unserialize($salesflow->application_data);
		if(empty($salesflow->application_data))
		{
			$salesflow_application_data = $this->salesflows->get_salesflows([
				'user_id' => $salesflow->user_id,
				'not_empty_data' => true,
				'limit' => 1
			]);
			if(!empty($salesflow_application_data))
			{
				if($salesflow_application_data->id != $salesflow->id && !empty($salesflow_application_data->application_data))
				{
					$salesflow->application_data = unserialize($salesflow_application_data->application_data);
				}
			}
		}

		if(!empty($salesflow->additional_files))
			$salesflow->additional_files = unserialize($salesflow->additional_files);
		if(empty($salesflow->additional_files))
		{
			$salesflow_additional_files = $this->salesflows->get_salesflows([
				'user_id' => $salesflow->user_id,
				'not_empty_add_files' => true,
				'limit' => 1
			]);
			if(!empty($salesflow_additional_files))
			{
				if($salesflow_additional_files->id != $salesflow->id && !empty($salesflow_additional_files->additional_files))
				{
					$salesflow->additional_files = unserialize($salesflow_additional_files->additional_files);
				}
			}
		}

		if(!empty($salesflow->additional_files))
		{
			$additional_files_ = [];
			foreach($salesflow->additional_files as $filename)
			{
				$f = new stdClass;
				$f->filename = $filename;
				$fn_arr = explode('.', $filename);
				$f->ext = strtolower(array_pop($fn_arr));
				$additional_files_[] = $f;
			}
			$salesflow->additional_files = $additional_files_;
		}



		// Files
		$files_dir = $this->config->root_dir.'/'.$this->config->users_files_dir.$salesflow->user_id.'/files/';

		$user_files = array();
		if(file_exists($files_dir))
		{
			$files = array_diff(scandir($files_dir), array('..', '.'));
			if(!empty($files))
			{

				$additional_files = [];
				foreach($files as $k=>$filename)
				{
					$f = new stdClass;
					$f->filename = $filename;
					$f->date = filectime($files_dir.$filename);

					$f_size = filesize($files_dir.$filename);
					$f->size = $f_size.' B';
					if($f_size > 999)
						$f->size = round(($f_size / 1024), 2).' KB';
					if($f_size > 999000)
						$f->size = round(($f_size / 1024 / 1024), 2).' MB';

					$fn_arr = explode('.', $filename);
					$f->ext = strtolower(array_pop($fn_arr));

					if(stripos($filename, 'CreditReport'))
					{
						$salesflow->isset_creditreport_file = true;
						$f->name = 'Credit Report';
						$user_files[$f->date.$k] = $f;
					}
					else
					{
						$additional_files[$f->date.$k] = $f;
					}
				}
				if(!empty($user_files))
				{
					// krsort($user_files);
					ksort($user_files);
				}
			}
		}
		$this->design->assign('user_files', $user_files);

		if(!empty($additional_files))
		{
			ksort($additional_files);
			$this->design->assign('additional_files', $additional_files);
		}



		// Ekata
		if(!empty($salesflow->application_data))
		{
			if(isset($salesflow->application_data['ekata_network_score']))
			{
				$salesflow->ekata = new stdClass;
				$salesflow->ekata->network_score = new stdClass;
				$salesflow->ekata->network_score->score = $salesflow->application_data['ekata_network_score'];
				$salesflow->ekata->network_score->pr = round($salesflow->ekata->network_score->score * 100);
				$salesflow->ekata->network_score->status = $this->ekata->get_status([
					'value' => $salesflow->ekata->network_score->score,
					'type' => 'identity_network_score'
				]);
			}

			if(isset($salesflow->application_data['ekata_check_score']))
			{
				$salesflow->ekata->check_score = new stdClass;
				$salesflow->ekata->check_score->score = $salesflow->application_data['ekata_check_score'];
				$salesflow->ekata->check_score->pr = round(($salesflow->ekata->check_score->score / 500) * 100);
				$salesflow->ekata->check_score->status = $this->ekata->get_status([
					'value' => $salesflow->ekata->check_score->score,
					'type' => 'identity_check_score'
				]);
			}
		}


		$salesflow->booking->client_type = $this->users->get_client_type($salesflow->booking->client_type_id);


		$u_arrive = strtotime($salesflow->booking->arrive);
        $u_depart = strtotime($salesflow->booking->depart);
        $b_interval = $u_depart - $u_arrive;
		$salesflow->booking->days_count = round($b_interval / (24 * 60 * 60)) + 1;

		if(!empty($salesflow->booking->arrive) && !empty($salesflow->booking->depart) && $salesflow->booking->price_month > 0 && $salesflow->booking->total_price < 1)
		{
			$price_calculate = $this->contracts->calculate($salesflow->booking->arrive, $salesflow->booking->depart, $salesflow->booking->price_month);
			if(!empty($price_calculate))
			{
				$salesflow->booking->total_price = $price_calculate->total;
			}
		}



		$salesflow->house = $this->pages->get_page((int)$salesflow->booking->house_id);
		if(!empty($salesflow->house->blocks2))
			$salesflow->house->blocks2 = unserialize($salesflow->house->blocks2);


		$beds_ids = [];
		$apartments_ids = [];
		if($salesflow->booking->type == 1) // Beds booking
		{
			if(isset($salesflow->booking->sp_bookings) && count($salesflow->booking->sp_bookings) > 1)
			{
				foreach($salesflow->booking->sp_bookings as $sb)
				{
					$apartments_ids[$sb->apartment_id] = $sb->apartment_id;
					$beds_ids[$sb->object_id] = $sb->object_id;
				}
			}
			else
			{
				$apartments_ids[$salesflow->booking->apartment_id] = $salesflow->booking->apartment_id;
				$beds_ids[$salesflow->booking->object_id] = $salesflow->booking->object_id;
			}
		}
		elseif($salesflow->booking->type == 2) // Apartment booking
		{
			$apartments_ids[$salesflow->booking->object_id] = $salesflow->booking->object_id;
		}

		if(!empty($apartments_ids))
		{
			$apartments = $this->beds->get_apartments([
				'id' => $apartments_ids
			]);
			$apartments = $this->request->array_to_key($apartments, 'id');
			// print_r($apartments); exit;
			$this->design->assign('apartments', $apartments);
		}

		if(!empty($beds_ids))
		{
			$beds = $this->beds->get_beds([
				'id' => $beds_ids
			]);
			$beds = $this->request->array_to_key($beds, 'id');
			$this->design->assign('beds', $beds);
		}
		

		// print_r($salesflow->house); exit;





		$meta_title = 'For Approval';
		$this->design->assign('meta_title', $meta_title);

		$this->design->assign('salesflow', $salesflow);

		// $this->design->assign('houses', $houses);
		// $this->design->assign('apartments', $apartments);
		// $this->design->assign('beds', $beds);

		if(isset($this->params->landlord))
			$this->design->assign('landlord', $this->params->landlord);
		$this->design->assign('params', $this->params);

		return $this->design->fetch('landlord/approve_item.tpl');
	}






	function fetch()
	{
		$this->params = new stdClass;

		if(empty($this->user))
		{
			header("HTTP/1.1 301 Moved Permanently"); 
			header('Location: '.$this->config->root_url.'/user/login');
			exit();
		}

		if($this->user->type != 4)
			return false;


		if(empty($this->user->permissions['approve']) && !empty($this->user->permissions))
		{
			header("HTTP/1.1 301 Moved Permanently"); 
			header('Location: '.$this->config->root_url.'/landlord/'.current($this->user->permissions));
			exit();
		}

		
		$salesflow_id = $this->request->get('salesflow_id', 'integer');


		//$landlord_approve_houses_ids = [];
		//$this->params->landlord = new stdClass;

		if(!empty($this->user->main_info))
			$this->params->landlord->main_info = $this->user->main_info;

		// Outpost Club / Landlords Houses
		if($this->user->id == 3164)
		{
			// $this->salesflows->id_greater = 0;
			$this->salesflows->booking_created_from = '2019-01-01 00:00:00';
			// $this->user->landlord_approve_houses_ids = $this->user->houses_ids;
		}






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
					$houses_ids = [];
					foreach($company_houses_ids as $house_id=>$ch)
					{
						$houses_ids[$house_id] = $house_id;
						if(in_array($house_id, $this->salesflows->approve_houses_ids))
							$this->params->landlord_approve_houses_ids[$house_id] = $house_id;
					}
				}
			}
		}
		*/



		if(empty($this->user->landlord_approve_houses_ids))
			return false;



		if(!empty($salesflow_id))
		{
			$approve_result = $this->approve_item($salesflow_id);
			if(empty($approve_result))
			{
				header("HTTP/1.1 301 Moved Permanently"); 
				header('Location: '.$this->config->root_url.'/landlord/approve/');
				exit();
			}
			return $approve_result;
		}
		else
			return $this->approve_list();		
	}
}
