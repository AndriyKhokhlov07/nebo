<?PHP

require_once('api/Backend.php');

############################################
# Class Properties displays a list of product parameters
############################################
class UsersAdmin extends Backend
{
	function fetch()
	{	

		$users = array();

		if($this->request->method('post'))
		{
			// Действия с выбранными
			$ids = $this->request->post('check');
			if(is_array($ids))
			{
				switch($this->request->post('action'))
				{
				    case 'disable':
				    {
				    	foreach($ids as $id)
							$this->users->update_user($id, array('enabled'=>0));    
						break;
				    }
				    case 'enable':
				    {
				    	foreach($ids as $id)
							$this->users->update_user($id, array('enabled'=>1));    
				        break;
				    }
				    case 'delete':
				    {
				    	foreach($ids as $id)
				    	{
							$this->users->update_user($id, array('status'=>6, 'enabled'=>0));  
				    	}


				    	// Invoices to Canceled
				    	$users_orders = $this->orders->get_orders(array('type'=>1, 'status'=>0, 'paid'=>0, 'user_id'=>$ids));
				    	if(!empty($users_orders))
				    	{
				    		foreach($users_orders as $uo)
				    		{
				    			$this->orders->update_order($uo->id, array('status'=>3));
				    		}
				    	}

						// Cancel booking
						// $this->beds->cancel_booking(array('user_id'=>$id, 'note'=>'Guest Status Changed - to Canceled'));


						


				        break;
				    }
				    case 'set_status_0':
					{
						foreach($ids as $id)
							$this->users->update_user($id, array('status'=>0)); 	
						break;
					}
				    case 'set_status_1':
					{
						foreach($ids as $id)
							$this->users->update_user($id, array('status'=>1)); 	
						break;
					}
					case 'set_status_2':
					{
						foreach($ids as $id)
							$this->users->update_user($id, array('status'=>2)); 	
						break;
					}
					case 'set_status_3':
					{
						foreach($ids as $id)
							$this->users->update_user($id, array('status'=>3)); 	
						break;
					}
					// Alumni
					case 'set_status_4':
					{
						foreach($ids as $id)
							$this->users->update_user($id, array('status'=>4, 'enabled'=>0)); 	
						break;
					}
					// blacklist
					case 'set_status_5':
					{
						foreach($ids as $id)
							$this->users->update_user($id, array('status'=>5, 'enabled'=>0));

						// Invoices to Canceled
				    	$users_orders = $this->orders->get_orders(array('type'=>1, 'status'=>0, 'paid'=>0, 'user_id'=>$ids));
				    	if(!empty($users_orders))
				    	{
				    		foreach($users_orders as $uo)
				    		{
				    			$this->orders->update_order($uo->id, array('status'=>3));
				    		}
				    	}

				    	// Cancel booking
						$this->beds->cancel_booking(array('user_id'=>$id, 'note'=>'Guest Status Changed - to Blacklist'));

						break;
					}


				   //  case 'delete':
				   //  {
				   //  	foreach($ids as $id)
							// $this->users->delete_user($id);    
				   //      break;
				   //  }
				}	



				// Cancel bookings
				/*
				$users_bookings = $this->beds->get_bookings(array('user_id'=>$id));

				if(!empty($users_bookings))
				{
					$aparnments_bookings_ids = array();
					$cancel_bookings = array();
					foreach($users_bookings as $b)
					{
						if($b->type == 2) // Apartment booking
							$aparnments_bookings_ids[$b->id] = $b->id;
						else
							$cancel_bookings[$b->id] = $b->id;
					}

					if(!empty($aparnments_bookings_ids))
					{
						$ab_users = $this->beds->get_bookings_users(array('booking_id'=>$aparnments_bookings_ids));
						if(!empty($ab_users))
						{
							$a_bookings_users = array();
							foreach($ab_users as $bu)
								$a_bookings_users[$bu->booking_id][$bu->user_id] = $bu->user_id;

							foreach($aparnments_bookings_ids as $booking_id)
							{
								if(isset($a_bookings_users[$booking_id]) && count($a_bookings_users[$booking_id]) < 2)
									$cancel_bookings[$booking_id] = $booking_id;
							}
						}
					}

					if(!empty($cancel_bookings))
					{
						$this->beds->cancel_booking(array(
							'id' => $cancel_bookings, 
							'note' => $note
						));
					}
				}
				*/



			}

		}  

		$groups = array();
		foreach($this->users->get_groups() as $g)
			$groups[$g->id] = $g;
		
		
		$group = null;
		$filter = array();
		$filter['page'] = max(1, $this->request->get('page', 'integer')); 		
		$filter['limit'] = 25;

		$group_id = $this->request->get('group_id', 'integer');
		if($group_id)
		{
			$group = $this->users->get_group($group_id);
			$filter['group_id'] = $group->id;
		}
		
		// Поиск
		$keyword = $this->request->get('keyword');
		if(!empty($keyword))
		{
			$filter['keyword'] = $keyword;
			$this->design->assign('keyword', $keyword);
		}
		else
		{
			$status = $this->request->get('status', 'integer');
			$filter['status'] = $status;
		 	$this->design->assign('status', $status);
		}


		//print_r($filter); exit;

		$house_id = $this->request->get('house_id', 'integer');
		if(!empty($house_id))
		{
			$filter['house_id'] = $house_id;
			$this->design->assign('house_id', $house_id);
		}

		$bed_name = $this->request->get('bed_name');
		if(!empty($bed_name))
		{
			$filter['bed_name'] = $bed_name;
			$this->design->assign('bed_name', $bed_name);

			$filter['status'] = null;
			$this->design->assign('status', null);
		}

		$type = $this->request->get('type', 'integer');
		if(!empty($type))
		{
			$filter['type'] = $type;
			$this->design->assign('type', $type);
		}

		$client_type = $this->request->get('client_type', 'integer');
		if(!empty($client_type))
		{
			$filter['client_type_id'] = $client_type;
			$this->design->assign('client_type', $client_type);
		}

		$move_in_out = $this->request->get('move');
		if(!empty($move_in_out))
		{

			$arrive_date = date_create(date("Y-m-d"));
			date_add($arrive_date, date_interval_create_from_date_string('7 days'));

			$current_date = date_create(date("Y-m-d"));
			date_sub($current_date, date_interval_create_from_date_string('7 days'));

			if($move_in_out == 'in')
			{
				$filter['not_status'] = array('0', '1', '6', '7');
				$filter['arrive'] = date_format($arrive_date, 'Y-m-d');
				$filter['arrive_from'] = date_format($current_date, 'Y-m-d');
				$filter['moved_in'] = array('0', '2', '4');

			}
			elseif($move_in_out == 'out')
			{
				$filter['not_status'] = array('0', '1', '6', '7');
				$filter['depart'] = date_format($arrive_date, 'Y-m-d');
				$filter['depart_from'] = date_format($current_date, 'Y-m-d');
				$filter['moved_in'] = array('0', '1', '3');
				$filter['sp_group'] = true;
			}

			unset($filter['status']);

			$this->design->assign('move_in_out', $move_in_out);
		}
		
		// Сортировка пользователей, сохраняем в сессии, чтобы текущая сортировка не сбрасывалась
		if($sort = $this->request->get('sort', 'string'))
			$_SESSION['users_admin_sort'] = $sort;		
		if (!empty($_SESSION['users_admin_sort']))
			$filter['sort'] = $_SESSION['users_admin_sort'];			
		else
			$filter['sort'] = 'date';	

		if($move_in_out == 'in')
			$filter['sort'] = 'inquiry_arrive';
		if($move_in_out == 'out')
			$filter['sort'] = 'inquiry_depart';	

		$this->design->assign('sort', $filter['sort']);
		
		$users_count = $this->users->count_users($filter);
		// Показать все страницы сразу
		if($this->request->get('page') == 'all')
			$filter['limit'] = $users_count;

		$houses = $this->pages->get_pages(array('menu_id'=>5, 'not_tree'=>1));

		if($this->request->get('move'))
			$this->design->assign('rooms', $houses);
		// if(!empty($houses))
			// $houses= $this->categories_tree->get_categories_tree('houses', $houses);

		$houses = $this->request->array_to_key($houses, 'id');
		// print_r($houses); exit;
		$this->design->assign('houses', $houses);

		$filter['apartment_info'] = true;
		if(!empty($status) || !empty($keyword))
			$filter['orders_status'] = true;

		// $filter['only_users'] = true;

		$users_ = $this->users->get_users($filter);
// 
		// if($filter['keyword'])
		if(!empty($users_))
		{
			$users = array();
			$users_ids = array();
			$users_hellorented_ids = array();
			$beds_ids = array();
			$apts_ids = array();
			$house_ids = array();

			foreach($users_ as $u)
			{
				$users[$u->id] = $u;
				$users_ids[$u->id] = $u->id;


				// to update
				if($u->bed_id > 0)
				{
					$beds_ids[$u->bed_id] = $u->bed_id;
				}
				// to update (end)

				$house_ids[$u->house_id] = $u->house_id;

				if(!empty($u->checker_options))
					$users[$u->id]->checker_options = unserialize($u->checker_options);
				if(!empty($u->files))
					$users[$u->id]->files = unserialize($u->files);
				if(!empty($u->blocks))
				{
					$users[$u->id]->blocks = unserialize($u->blocks);

					// Ekata
					if(isset($users[$u->id]->blocks['ekata_network_score']) || isset($users[$u->id]->blocks['ekata_check_score']))
					{
						if(isset($users[$u->id]->blocks['ekata_network_score']))
						{
							$users[$u->id]->ekata = $this->ekata->get_status(array(
								'type' => 'identity_network_score',
								'value' => $users[$u->id]->blocks['ekata_network_score']
							));
						}

						if(isset($users[$u->id]->blocks['ekata_check_score']))
						{
							$ekata_check_status = $this->ekata->get_status(array(
								'type' => 'identity_check_score',
								'value' => $users[$u->id]->blocks['ekata_check_score']
							));
							if(!isset($users[$u->id]->ekata) || (isset($users[$u->id]->ekata) && $ekata_check_status->code > $users[$u->id]->ekata->code))
								$users[$u->id]->ekata = $ekata_check_status;
						}

						if(isset($users[$u->id]->blocks['ekata_phone_check']))
						{
							if(in_array($users[$u->id]->blocks['ekata_phone_check'], array('not_valid', 'non-fixed-voip', 'fixed-voip')))
							{
								if($ekata_check_status->code != 3)
									$ekata_check_status->code = 2;
							}
						}
					}

				}

				if(!empty($u->hellorented_tenant_id))
					$users_hellorented_ids[$u->id] = $u->id;


				


			}
			unset($users_);

			
			if(!empty($beds_ids))
			{
				$beds = $this->beds->get_beds(array('id'=>$beds_ids));
				$beds = $this->request->array_to_key((array)$beds, 'id');
				$this->design->assign('beds', $beds);
			}
			
			/*foreach($users as $k=>$u)
			{
				if(!empty($u->checker_options))
					$users[$k]->checker_options = unserialize($u->checker_options);
				if(!empty($u->files))
					$users[$k]->files = unserialize($u->files);
			}*/


			// Contracts
			$contracts_users = $this->contracts->get_contracts_users(array('user_id'=>$users_ids));
			if(!empty($contracts_users))
			{
				$contracts_ids = array();
				foreach($contracts_users as $cu) 
					$contracts_ids[$cu->contract_id] = $cu->contract_id;

					$contracts = $this->contracts->get_contracts(array(
						'id' => $contracts_ids,
						'status' => array(1,2),
						'limit' => count($contracts_ids)
					));

					$contracts = $this->request->array_to_key($contracts, 'id');

					if(!empty($contracts))
					{
						foreach($contracts_users as $cu)
						{
							if(isset($contracts[$cu->contract_id]) && isset($users[$cu->user_id]))
							{
								$contract = $contracts[$cu->contract_id];

								// 
								if($contract->signing == 1)
									$users[$cu->user_id]->contract_status = 'allsigning';
								elseif($contract->signing == 2)
									$users[$cu->user_id]->contract_status = 'signing';
								else
									$users[$cu->user_id]->contract_status = 'pending';
									

								if($contract->outpost_deposit == 1 && $contract->price_deposit > 0)
									$users[$cu->user_id]->deposit_type = 1; // Outpost
								else
									$users[$cu->user_id]->deposit_type = 2; // Hellorented

								// print_r($contract); 
							}
						}

						// exit;
						unset($contracts);
					}
			}

			$users_logs = $this->logs->get_logs([
					'parent_id' => $users_ids,
					'type' => [
						2, // Users (Guests)
						12 // Window Guards 
					],
					'subtype' => 1,
					'sort' => 1
				]);

			if(!empty($users_logs))
			{
				foreach($users_logs as $log) 
				{
					if($log->type == 2) // Users (Guests)
					{
						if(!empty($users[$log->parent_id]))
							$users[$log->parent_id]->logs[] = $log;
					}
					elseif($log->type == 12) // Window Guards 
					{
						if(!empty($users[$log->parent_id]))
							$users[$log->parent_id]->window_guards_sent = true;
					}
					
				}
			}



			/*
			$contracts = $this->contracts->get_contracts(array('user_id'=>$users_ids, 'status'=>1));
			if(!empty($contracts))
			{
				foreach($contracts as $c)
				{
					if(!empty($c->user_id) && isset($users[$c->user_id]) && !isset($users[$c->user_id]->contract_status))
					{
						if($c->signing==1)
							$users[$c->user_id]->contract_status = 'signing';
						else
							$users[$c->user_id]->contract_status = 'pending';

						if($c->outpost_deposit == 1 && $c->price_deposit > 0)
							$users[$c->user_id]->deposit_type = 1; // Outpost
						else
							$users[$c->user_id]->deposit_type = 2; // Hellorented

					}
				}
				unset($contracts);
			}
			*/


			// Hellorented Logs
			/*
			if(!empty($users_hellorented_ids))
			{
				$hellorented_logs = $this->logs->get_logs(array(
					'user_id' => $users_hellorented_ids,
					'type' => 5
				));
				if(!empty($hellorented_logs))
				{
					$users_hellorented_logs = array();
					foreach($hellorented_logs as $log)
						$users_hellorented_logs[$log->user_id][$log->id] = $log;


					foreach($users_hellorented_logs as $user_id=>$logs)
					{
						if(isset($users[$user_id]) && !isset($users[$user_id]->hellorented_log))
							$users[$user_id]->hellorented_log = current($logs);
					}
				}
			}
			*/


		}
		

		



		$this->design->assign('pages_count', ceil($users_count/$filter['limit']));
		$this->design->assign('current_page', $filter['page']);
		$this->design->assign('groups', $groups);		
		$this->design->assign('group', $group);
		$this->design->assign('users', $users);
		$this->design->assign('users_count', $users_count);
		$this->design->assign('clients_types', $this->users->clients_types);

		if($this->request->get('move'))
			return $this->body = $this->design->fetch('move_in_out.tpl');
		else
			return $this->body = $this->design->fetch('users.tpl');
	}
}
