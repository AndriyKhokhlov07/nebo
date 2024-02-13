<?PHP


 
require_once('View.php');

class LandlordTenantsView extends View
{
	function fetch()
	{
		if(empty($this->user))
		{
			header("HTTP/1.1 301 Moved Permanently"); 
			header('Location: '.$this->config->root_url.'/user/login');
			exit();
		}

		$landlord = new stdClass;

		if(!empty($this->user->email))
		{
			if(!empty($this->user->main_info))
				$landlord->main_info = $this->user->main_info;

			$users = array();
			$invoices = array();
			$houses = array();


			$selected_house_id = $this->request->get('house_id', 'integer');
			$tenant_status = $this->request->get('tenant_status', 'integer');


			$ll_houses = $this->users->get_landlords_houses(array('user_id'=>$this->user->id));

			if(!empty($ll_houses))
			{
				$houses_ids = array();
				foreach($ll_houses as $h)
					$houses_ids[$h->house_id] = $h->house_id;

				$houses = $this->pages->get_pages(array(
					'id' => $houses_ids,
					'visible' => 1
				));


				if(!empty($houses))
				{
					if(!empty($selected_house_id) && isset($houses[$selected_house_id]))
						$selected_house = $houses[$selected_house_id];
					else
						$selected_house = current($houses);

					$houses[$selected_house->id]->selected = 1;

				}

				if(!empty($selected_house))
				{

					// Apartments
					$apartments = $this->beds->get_apartments(array(
						'house_id' => $selected_house->id,
						'visible' => 1
					));
					$apartments = $this->request->array_to_key($apartments, 'id');

					// Rooms
					/*$rooms_ = $this->beds->get_rooms(
						'house_id' => $selected_house->id,
						'visible' => 1
					);
					//$rooms = $this->request->array_to_key($rooms, 'id');
					$rooms = array();
					if(!empty($rooms_))
					{
						foreach($rooms_ as $r)
						{
							$rooms[$r->id] = $r;
							if(!empty($r->apartment_id) && isset($apartments[$r->apartment_id]))
								$apartments[$r->apartment_id]->rooms[$r->id] = $r;
						}
					}*/


					


					$users_filter = array(
						'house_id'=> $selected_house->id,
						'bj2' => 0,
						'sort' => 'inquiry_depart'
					);

					if(empty($tenant_status) || $tenant_status == 1) // Current
						$users_filter['status'] = 3;
					elseif($tenant_status == 2) // Future
						$users_filter['status'] = array(1, 2);
					elseif($tenant_status == 3) // Archive
						$users_filter['status'] = array(4);

					$users = $this->users->get_users($users_filter);


					$apartments_users = array();
					if(!empty($users))
					{
						if(empty($apartments))
							$apartments_users['no_apartment'] = $users;
						else
						{
							foreach($users as $u)
							{
								if(isset($apartments[$u->apartment_id]))
									$apartments_users[$u->apartment_id][$u->id] = $u;
								else
									$apartments_users['no_apartment'][$u->id] = $u;
							}
						}
					}


					$counts = new stdClass;
					if(empty($tenant_status) || $tenant_status == 1) // Current
					{
						if(!empty($users))
							$counts->current = count($users);
					}
					else
					{
						$users_filter['status'] = 3;
						$counts->current = $this->users->count_users($users_filter);
					}

					if($tenant_status == 2) // Future
					{
						if(!empty($users))
							$counts->future = count($users);
					}
					else
					{
						$users_filter['status'] = array(1, 2);
						$counts->future = $this->users->count_users($users_filter);
					}


					$this->design->assign('counts', $counts);
					$this->design->assign('apartments', $apartments);
					$this->design->assign('apartments_users', $apartments_users);

				}
				

			}





			// ---------
			// Old code 
			// --------



			// foreach($houses_ids as $h_id) 
			// {
			// 	$houses[$h_id->house_id] = $this->pages->get_page(intval($h_id->house_id));
			// }

			if(!empty($houses___))
			{
				// --- test 1 house 
				// $h = current($houses);
				// // $h->selected = 1;
				// $houses_ = array();
				// $houses_[] = $h;
				// ------

				//foreach($houses as $house) 
				if(!empty($selected_house__))
				{
					$house = $selected_house;
					if(!empty($house->blocks2))
						$house->blocks2 = unserialize($house->blocks2);

					$users_ = array();
					$users_ = $this->users->get_users(array('house_id'=>$house->id, 'sort'=>'inquiry_depart'));

					if(!empty($users_))
					{
						foreach ($users_ as $u) 
						{
							$u->contracts = "";
							$u->contracts = $this->contracts->get_contracts(array('user_id'=>$u->id, 'status'=>1, 'house_id'=>$house->id));

							$contracts_ids = array();
							foreach ($u->contracts as $u_c) 
							{
								$contracts_ids[] = $u_c->id;
							}

							$u_orders = $this->orders->get_orders(array('user_id'=>$u->id, 'status'=>array(0,1,2,4), 'type'=>1, 'contract_id'=>$contracts_ids));
							$invoices = array();
							foreach($u_orders as $o)
							{
								$invoices[$o->id] = $o;
								if(!empty($invoices))
								{
									$purchases = $this->orders->get_purchases(array('order_id'=>array_keys($invoices)));
									if(!empty($purchases))
									{
										foreach($purchases as $purchase)
										{
											if(isset($invoices[$purchase->order_id]))
											{
												$invoices[$purchase->order_id]->purchases[$purchase->id] = $purchase;
											}
										}
									}
								}
							}
							$u->invoices = $invoices;

							$u->bed_journal = "";
							if(!empty($u->active_booking_id))
							$u->bed_journal = $this->beds->get_beds_journal(array('id'=>$u->active_booking_id, 'limit'=>1));

							if($u->status==3)
								$house->guests[$u->id] = $u;
							elseif($u->status==4 || $u->status==6)
								$house->archive[$u->id] = $u;
							elseif($u->status==1 || $u->status==2)
							{
								$house->future[$u->inquiry_arrive][$u->id] = $u;

							}
						}
						ksort($house->future);
						// foreach ($house_future as $hf) {
						// 	foreach ($hf as $u) {
						// 		$house->future[] = $u;
						// 	}
						// }
					}

				}


			}

			// ---------
			// Old code  (end)
			// --------


		}



		$this->design->assign('landlord', $landlord);
		$this->design->assign('houses', $houses);
		$this->design->assign('selected_house', $selected_house);

		$this->design->assign('tenant_status', $tenant_status);
		// $this->design->assign('users', $users);

		return $this->design->fetch('landlord/tenants.tpl');
	}
}
