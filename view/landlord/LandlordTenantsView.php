<?PHP

require_once('view/View.php');

class LandlordTenantsView extends View
{
	private $params;
	private $selected_house;
	private $bookings_contracts;
	private $apartments;



	private function get_bookings_data($bookings_, $params = [])
	{
		if(empty($bookings_))
			return false;

		$bookings = [];
		$bookings_ids = [];
		
		$this->params->sp_group_bookings_ids = [];
		$this->params->sp_bookings_group_ids = [];
		$this->params->bookings_u_ids = [];

		foreach($bookings_ as $b)
		{
			$bookings_ids[] = $b->id;
			$bookings[$b->id] = $b;
			if(!empty($b->sp_group_id))
			{
				$this->params->sp_group_bookings_ids[$b->sp_group_id][$b->id] = $b->id;
				$this->params->sp_bookings_group_id[$b->id] = $b->sp_group_id;
				$this->params->bookings_u_ids[] = $b->sp_group_id;
			}
			else
				$this->params->bookings_u_ids[] = $b->id;
		}

		if(isset($params['contracts']))
		{
			// Contracts
			$this->bookings_contracts = $this->contracts->get_contracts([
				'reserv_id' => $this->params->bookings_u_ids,
				'is_signing' => 1,
                'limit' => 1000
			]);
			if(!empty($this->bookings_contracts))
			{
				$this->selected_house->has_contracts = true;
				
				foreach($this->bookings_contracts as $c)
				{
					
					if(!empty($c->date_from) && !empty($c->date_to) && $c->price_month > 0 && $c->total_price < 1)
					{
						$price_calculate = $this->contracts->calculate($c->date_from, $c->date_to, $c->price_month);
						if(!empty($price_calculate))
							$c->total_price = $price_calculate->total; 
					}
					

					if(!empty($c->reserv_id) && isset($bookings[$c->reserv_id]))
					{	
						if(!isset($bookings[$c->reserv_id]->contract) || $bookings[$c->reserv_id]->contract->status > $c->status)
						{
							$bookings[$c->reserv_id]->contract = $c;

							if(!empty($bookings[$c->reserv_id]->sp_group_id) && !empty($this->params->sp_group_bookings_ids[$bookings[$c->reserv_id]->sp_group_id]))
							{
								foreach($this->params->sp_group_bookings_ids[$bookings[$c->reserv_id]->sp_group_id] as $b_id)
								{
									$bookings[$b_id]->contract = $c;
								}
							}
						}

					}
					elseif(isset($this->params->sp_group_bookings_ids[$c->reserv_id]))
					{
						foreach($this->params->sp_group_bookings_ids[$c->reserv_id] as $b_id)
						{
							if(isset($bookings[$b_id]))
							{
								$bookings[$b_id]->contract = $c;
							}
						}
					}
				}
			}
		}
		
		if(isset($params['users']))
		{
			// Bookings users
			$bookings_users_ids = $this->beds->get_bookings_users([
				'booking_id' => $this->params->bookings_u_ids
			]);
			if(!empty($bookings_users_ids))
			{
				$users_ids = [];
				foreach($bookings_users_ids as $bu)
					$users_ids[$bu->user_id] = $bu->user_id;

				$users = $this->users->get_users([
					'id' => $users_ids,
					'only_users' => true
				]);

				if(!empty($users))
				{
					foreach($bookings_users_ids as $bu)
					{
						if(isset($users[$bu->user_id]) && isset($bookings[$bu->booking_id]))
						{
							$bookings[$bu->booking_id]->users[$bu->user_id] = $users[$bu->user_id];
							if(!empty($bookings[$bu->booking_id]->sp_group_id) && !empty($this->params->sp_group_bookings_ids[$bookings[$bu->booking_id]->sp_group_id]))
							{
								foreach($this->params->sp_group_bookings_ids[$bookings[$bu->booking_id]->sp_group_id] as $b_id)
								{
									$bookings[$b_id]->users[$bu->user_id] = $users[$bu->user_id];
								}
							}
						}
						elseif(isset($users[$bu->user_id]) && isset($this->params->sp_group_bookings_ids[$bu->booking_id]))
						{
							foreach($this->params->sp_group_bookings_ids[$bu->booking_id] as $b_id)
							{
								if(isset($bookings[$b_id]))
								{
									$bookings[$b_id]->users[$bu->user_id] = $users[$bu->user_id];
								}
							}
						}
					} 
				}
			}
		}

		foreach($bookings as $b)
		{
			$u_arrive = strtotime($b->arrive);
            // $u_depart = strtotime($b->depart) + 86399;
            $u_depart = strtotime($b->depart);
            //$u_depart += (24 * 60 * 60);
            $b_interval = $u_depart - $u_arrive;
			$b->days_count = round($b_interval / (24 * 60 * 60)) + 1;

			
			if($b->price_month == 0 && $b->price_day > 0)
				$b->price_month = $b->price_day * 30;

			if($b->client_type_id == 2 && $b->price_day > 0) // airbnb
			{
				$b->price_30_days = round($b->price_day * 30);
				$bookings[$b->id]->price_30_days = $b->price_30_days;

				$b->total_price = round($b->price_day * $b->days_count);
				$bookings[$b->id]->total_price = $b->total_price;
			}
			elseif(!empty($b->arrive) && !empty($b->depart) && $b->price_month > 0 && $b->total_price < 1)
			{
				$price_calculate = $this->contracts->calculate($b->arrive, $b->depart, $b->price_month);
				if(!empty($price_calculate))
				{
					$b->total_price = $price_calculate->total; 
					$bookings[$b->id]->total_price = $b->total_price;
				}
			}



			


			if(!empty($b->paid_to))
			{
                $u_paid_to = strtotime($b->paid_to);
                $b->paid_width = ($u_paid_to - $u_arrive) / $b_interval * 100;
                if($b->paid_width > 100)
                	$b->paid_width = 100;
            }

            $b->u_live_to = strtotime('now');
            $b->live_width = ($b->u_live_to - $u_arrive) / $b_interval * 100;
            if($b->live_width > 100)
            	$b->live_width = 100;



			if(date("n-Y", $u_arrive) == (int)$this->params->month.'-'.$this->params->year)
				$b->movein = true;
			
			if(date("n-Y", $u_depart) == (int)$this->params->month.'-'.$this->params->year)
				$b->moveout = true;



			// calendar |  width / left
			$u_bj_arrive = $u_arrive;
            $u_bj_depart = $u_depart + 86399;

            if($u_bj_arrive < $this->params->u_from)
                $u_bj_arrive = $this->params->u_from;

            if($u_bj_depart > $this->params->u_to)
                $u_bj_depart = $this->params->u_to;


            $u_bj_interval = $u_bj_depart - $u_bj_arrive;

            if($u_bj_interval > 0)
            {
                $b->width =  $u_bj_interval / $this->params->u_interval  * 100;
                if($b->width > 100)
                	$b->width = 100;
                $b->start = ($u_bj_arrive - $this->params->u_from) / $this->params->u_interval * 100;
            }
            // ----

            $b->client_type = $this->users->get_client_type($b->client_type_id);


			// Occupancy
			$bm_from = $u_arrive;
			if($u_arrive < $this->params->now_month->getTimestamp())
				$bm_from = $this->params->now_month->getTimestamp();

			$bm_to = $u_depart;
			if($u_depart > strtotime($this->params->now_month_last_day))
				$bm_to = strtotime($this->params->now_month_last_day);

			$b->month_days = round(($bm_to - $bm_from) / (24 * 60 * 60)) + 1;


			if($b->client_type_id != 5) // 5 - houseleader
			{
			}

			// $b->month_bdays = (int)$b->month_days;

			// if($b->type == 2) // Apartment
			// {
			// 	$b->month_bdays *= (int)$this->apartments[$b->object_id]->beds_count;
			// }
			// $this->params->occupancy_bdays += $b->month_bdays;


			// echo '['.$b->month_bdays.']';

			
			// Price this month
			if(!empty($b->contract->price_month))
				$price_month = $b->contract->price_month;
			else
				$price_month = $b->price_month;

			if($b->client_type_id != 5) // 5 - houseleader
			{
				$b->price_this_month = round(($price_month / $this->params->days_in_month) * $b->month_days);
				$this->params->total_price_this_month += $b->price_this_month;

				$this->params->total_price_month += $price_month;
			}
			

            $bookings[$b->id] = $b;
        }

		return $bookings;
	}









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

		if(empty($this->user->permissions['tenants']) && !empty($this->user->permissions))
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

			$users = [];
			$invoices = [];
			$houses = [];

			$type_view = 'calendar';


			$selected_house_id = $this->request->get('house_id', 'integer');
			$tenant_status = $this->request->get('tenant_status', 'integer');
			$month = $this->request->get('month', 'string');

			$w = $this->request->get('w', 'string');
			if($w == 'list')
				$type_view = $w;


			// $ll_houses = $this->users->get_landlords_houses(array('user_id'=>$this->user->id));

			/*$landlords_companies = $this->users->get_landlords_houses([
				'user_id' => $this->user->id
			]);
			$landlords_companies = $this->request->array_to_key($landlords_companies, 'house_id');

			// LLC
			$houses_ids = [];
			if(!empty($landlords_companies))
			{
				$this->params->companies = $this->companies->get_companies([
					'id' => array_keys($landlords_companies)
				]);
			}
			elseif($this->user->id == 4714 || $this->user->id == 4715)
			{
				$houses_ids[] = 185; // The Central Park Manhattan House for owners
			}*/


			if(!empty($this->user->landlords_companies))
			{

			}
			elseif($this->user->id == 4714 || $this->user->id == 4715)
			{
				$this->user->houses_ids[] = 185; // The Central Park Manhattan House for owners
			}
				
			


			/*$this->params->companies = $this->request->array_to_key($this->params->companies, 'id');
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
			}*/


			if(!empty($this->user->houses_ids))
			{
				// $houses_ids = [];
				// foreach($ll_houses as $h)
				// 	$houses_ids[$h->house_id] = $h->house_id;

				$houses = $this->pages->get_pages(array(
					'id' => $this->user->houses_ids,
					'menu_id' => 5,
					//'visible' => 1
				));


				if(!empty($houses))
				{
					if(!empty($selected_house_id) && isset($houses[$selected_house_id]))
						$this->selected_house = $houses[$selected_house_id];
					else
						$this->selected_house = current($houses);

					$houses[$this->selected_house->id]->selected = 1;

				}

				if(!empty($this->selected_house))
				{
					$beds_ids = [];
					$bookings_beds = [];
					$bookings_ataprments = [];
					$beds_rooms_ids = [];
					$rooms = [];
					$bookings_users = [];

					// $this->params->occupancy_bdays = 0;

					if(!empty($this->selected_house->blocks2))
						$this->selected_house->blocks2 = unserialize($this->selected_house->blocks2);

					// Apartments
					$this->apartments = $this->beds->get_apartments([
						'house_id' => $this->selected_house->id,
						'visible' => 1,
						'sort' => 'name'
					]);
					$this->apartments = $this->request->array_to_key($this->apartments, 'id');

					// Rooms
					$rooms_ = $this->beds->get_rooms(array(
						'house_id' => $this->selected_house->id,
						'visible' => 1
					));
					
					$rooms_apartments_ids = [];
					if(!empty($rooms_))
					{
						foreach($rooms_ as $r)
						{
							if(substr(trim($r->name), 0, 5) == 'Room ')
								$r->name = substr(trim($r->name), 5);

							

							if(!empty($r->apartment_id) && isset($this->apartments[$r->apartment_id]))
							{
								$this->apartments[$r->apartment_id]->rooms[$r->id] = $r;

								$rooms[$r->id] = $r;
								$rooms_apartments_ids[$r->id] = $r->apartment_id;
								if($r->visible == 1)
									$this->apartments[$r->apartment_id]->rooms_visible = 1;
							}

							
						}
					}

					// Beds
					$beds = $this->beds->get_beds(array(
						'room_id' => array_keys($rooms),
						'visible' => 1
					));
					if(!empty($beds))
					{
						foreach($beds as $b)
						{
							$beds_rooms_ids[$b->id] = $b->room_id;

							$apartment_id = $rooms[$b->room_id]->apartment_id;
							$this->apartments[$apartment_id]->rooms[$b->room_id]->beds[$b->id] = $b;
							$this->apartments[$apartment_id]->beds_count++;

							if($b->visible == 1)
								$this->apartments[$apartment_id]->beds_visible = 1;
						}
					}



					// BOOKINGS

					// Current
					// Month
					if(empty($tenant_status) || $tenant_status == 1 || $tenant_status == 4)
					{

						$booking_patrams = [
							'house_id' => $this->selected_house->id,
							'now' => true,
							// 'is_due' => true,
							'status' => [
								3, // Contract / Invoice
								5  // Canceled Bed/Apt
							],
							'order_by' => 'b.depart',
							'no_to_key' => true
						];

						

						// Month
						if(empty($tenant_status) || $tenant_status == 4)
						{
							if(!empty($month))
							{
								list($this->params->month, $this->params->year) = explode('-', $month);
							}
							else
							{
								$strtotime_now = strtotime('now');
								$this->params->month = date("m", $strtotime_now);
								$this->params->year = date("Y", $strtotime_now);
							}

							$this->params->now_month = new DateTime($this->params->year.'-'.$this->params->month.'-01');

							

							$this->params->next_month = clone $this->params->now_month;
							$this->params->next_month->modify('+1 month');


							$this->params->prev_month = clone $this->params->now_month;
							$this->params->prev_month->modify('-1 month');


							if((int)$this->params->year < 2021 && (int)$this->params->month < 12)
								unset($this->params->prev_month);


							$this->params->days_in_month = date("t", strtotime($this->params->year.'-'.$this->params->month.'-01'));

							// $this->params->days_beds_count = $this->params->days_in_month * count($beds);

							$this->params->now_month_last_day = $this->params->year.'-'.$this->params->month.'-'.$this->params->days_in_month;
							
							$booking_patrams['date_from2'] = $this->params->year.'-'.$this->params->month.'-01';
							$booking_patrams['date_to2'] = $this->params->now_month_last_day;




							

							// Beds-deys count

							$this->params->days_beds_count = 0;

							$this->params->u_from = $this->params->now_month->getTimestamp();
							$this->params->u_to = strtotime($this->params->now_month_last_day) + 86399;
							$this->params->u_interval = $this->params->u_to - $this->params->u_from;

							$u_from = $this->params->now_month->getTimestamp();
							$u_to = strtotime($this->params->now_month_last_day);

							if(!empty($this->apartments))
							{
								foreach($this->apartments as $a)
								{
									$a_d_count = null;

									// Показываем окупенси ледлордам вильямсбурга and cassa hotel upd - Rostik
									if($a->house_id == 334 || $a->house_id == 337 || $a->house_id == 340)
									{
										$a->date_added = null;
									}
									// Показываем окупенси ледлордам вильямсбурга upd (END)


									// не учитываем даты открытия и закрытия
									$a->date_added = null;
									$a->date_shutdown = null;


									$a_days = $this->beds->calculate_bedsdays($a->date_added, $a->date_shutdown, $a->visible, $u_from, $u_to);


									if(!is_null($a->date_added) && strtotime($a->date_added) > $u_to)
									{
										// $this->apartments[$a->id]->visible = 0;
										$this->apartments[$a->id]->rooms_visible = 0;
									}

									if(!empty($a_days))
									{
										if($a_days->d_count !== 0 && !empty($a->rooms))
										{
											foreach($a->rooms as $r)
											{
												// не учитываем даты открытия и закрытия
												$r->date_added = null;
												$r->date_shutdown = null;

												$r_days = $this->beds->calculate_bedsdays($r->date_added, $r->date_shutdown, $r->visible, $a_days->from, $a_days->to);

												if($r_days->d_count !== 0 && !empty($r->beds))
												{
													foreach($r->beds as $b)
													{
														// не учитываем даты открытия и закрытия
														$b->date_added = null;
														$b->date_shutdown = null;

														$b_days = $this->beds->calculate_bedsdays($b->date_added, $b->date_shutdown, $b->visible, $r_days->from, $r_days->to);

														if($b_days->d_count !== 0)
															$this->params->days_beds_count += $b_days->d_count;

														$b_days->to += 86399;
														$b_days_interval = $b_days->to - $b_days->from;

											            if($b_days_interval > 0)
											            {
											                $b->width =  $b_days_interval / $this->params->u_interval * 100;
											                if($b->width > 100)
											                	$b->width = 100;
											                $b->start = ($b_days->from - $this->params->u_from) / $this->params->u_interval * 100;
											            }
													}
												}
											}
										}
									}
								}
							}




						}

						// Current
						elseif($tenant_status == 1)
							$booking_patrams['now'] = true;



						$bookings_ = $this->beds->get_bookings($booking_patrams);



						if(!empty($bookings_))
						{
							/*
							$bookings = [];
							foreach($bookings_ as $k=>$b)
							{
								if($b->type == 1) // Booking type: Bed
								{
									$room_id = $beds_rooms_ids[$b->object_id];
									if(!empty($room_id))
									{
										$apartment_id = $rooms_apartments_ids[$room_id];
										if(!empty($apartment_id) && $b->apartment_id != $apartment_id)
											$b->apartment_id = $apartment_id;
									}
								}
								elseif($b->type == 2) // Booking type: Apartment
								{
									$b->apartment_id = $b->object_id;
								}

								if(!empty($b->apartment_id) && isset($this->apartments[$b->apartment_id ]))
								{
									$bookings[$k] = $b;
								}
							}
							*/

							// Closed Beds/Apt
							$bookings_closed_ids = [];

							$bookings = [];
							foreach($bookings_ as $k=>$b)
							{
								if($b->type == 1) // Booking type: Bed
								{
									if(isset($beds_rooms_ids[$b->object_id]))
									{
										$b->room_id = $beds_rooms_ids[$b->object_id];
									}
									if(!empty($b->room_id))
									{
										$apartment_id = $rooms_apartments_ids[$b->room_id];
										if(!empty($apartment_id) && $b->apartment_id != $apartment_id)
											$b->apartment_id = $apartment_id;
									}
									if(isset($this->apartments[$b->apartment_id]))
									{
										if(isset($rooms[$b->room_id]))
										{
											if(isset($beds_rooms_ids[$b->object_id]))
											{
												$bookings[$k] = $b;
											}
										}
									}	
								}
								elseif($b->type == 2) // Booking type: Apartment
								{
									if(isset($this->apartments[$b->object_id]))
									{
										$bookings[$k] = $b;
									}	
								}
								if($b->status == 5) // Closed Beds/Apt
								{
									$bookings_closed_ids[$b->id] = $b->id;
								}
							}
							unset($bookings_);

							// Closed Beds/Apt
							if(!empty($bookings_closed_ids))
							{
								$b_logs = $this->logs->get_logs([
									'type' => 1, // Booking
									'subtype' => 12, // Note
									'parent_id' => $bookings_closed_ids
								]);

								if(!empty($b_logs))
								{
									foreach($b_logs as $l)
									{
										if(isset($bookings[$l->parent_id]))
										{
											$bookings[$l->parent_id]->note_logs[$l->id] = $l;
										}
									}
								}
							}



							$bookings = $this->get_bookings_data($bookings, [
								'contracts' => true,
								'users' => true
							]);

							// echo count($bookings); exit;

							foreach($bookings as $b)
							{
								if($b->type == 1) // Booking type: Bed
								{
									$bookings_beds[$b->id] = $b;
								}
								elseif($b->type == 2) // Booking type: Apartment
								{
									if(isset($this->apartments[$b->object_id]))
									{
										$bookings_ataprments[$b->id] = $b;
										$this->apartments[$b->object_id]->isset_bookings = true;
										$this->apartments[$b->object_id]->apartment_bookings = true;
										$this->apartments[$b->object_id]->bookings[$b->id] = $b;

										if(empty($this->apartments[$b->object_id]->max_booking_users) || $this->apartments[$b->object_id]->max_booking_users < count($b->users))
										{
											$this->apartments[$b->object_id]->max_booking_users = count($b->users);
										}
									}
									
								}
							}


							if(!empty($bookings_beds))
							{
								foreach($bookings_beds as $b)
								{
									$room_id = $beds_rooms_ids[$b->object_id];
									if(!empty($room_id))
									{
										$apartment_id = $rooms_apartments_ids[$room_id];
										if(!empty($apartment_id) && $b->apartment_id != $apartment_id)
											$b->apartment_id = $apartment_id;
									}
									if(isset($this->apartments[$b->apartment_id]))
									{
										$this->apartments[$b->apartment_id]->bed_bookings = true;
										$this->apartments[$b->apartment_id]->isset_bookings = true;
										$this->apartments[$b->apartment_id]->rooms[$room_id]->isset_bookings = true;
										$this->apartments[$b->apartment_id]->rooms[$room_id]->beds[$b->object_id]->bookings[$b->id] = $b;
									}


									
								}
							}


							// Occupancy
							$occupancy = $this->occupancy->init_occupancy([
								'house_id' => $this->selected_house->id,
								'month' => $this->params->month,
								'year'  => $this->params->year,
								'landlord_view' => 1
							]);
							$this->design->assign("occupancy", $occupancy);
						}
					}


					// Future / Arcive
					if($tenant_status == 2 || $tenant_status == 3)
					{

						$bookings_params = [
							'house_id' => $this->selected_house->id,
							'is_due' => true,
							'status' => 3 // 2 - Payment Pending, 3 - Contract / Invoice
						];

						if($tenant_status == 2) // Future
						{
							$bookings_params['future'] = true;
							$bookings_params['order_by'] = 'b.arrive';
						}
						elseif($tenant_status == 3) // Archive
						{
							$bookings_params['archive'] = true;
							$bookings_params['order_by'] = 'b.depart DESC';
						}

						$bookings = $this->beds->get_bookings($bookings_params);

						if(!empty($bookings))
						{
							$bookings = $this->get_bookings_data($bookings, [
								'contracts' => true,
								'users' => true
							]);

							$date_bookings = [];
							foreach($bookings as $b)
							{
								if($tenant_status == 2) // Future
									$u_date = strtotime($b->arrive);
								elseif($tenant_status == 3) // Archive
									$u_date = strtotime($b->depart);

								if($b->type == 1) // Booking type: Bed
								{
									if(isset($beds_rooms_ids[$b->object_id]))
										$b->room_id = $beds_rooms_ids[$b->object_id];
								}

								$date_bookings[date('Y-m', $u_date)][$b->id] = $b;
							}

							$this->design->assign('bookings', $date_bookings);
						}
					}




					// Download contracts (ZIP)
					if($this->request->post('download_contracts'))
					{
						if(!empty($this->bookings_contracts))
						{
							$file_name = '';
							if($tenant_status == 2)
								$file_name = 'future-';
							elseif($tenant_status == 3)
								$file_name = 'archive-';

							$file_name .= 'contracts-'.$this->selected_house->url.'-'.date("Y-m-d").'.zip';

							$zip = new ZipArchive();
							if($zip->open($this->config->contracts_dir.$file_name, ZIPARCHIVE::CREATE)!==TRUE)
								exit('Sorry ZIP creation failed at this time');

							foreach($this->bookings_contracts as $contract)
							{
								if(file_exists($this->config->contracts_dir.$contract->url.'/contract.pdf'))
									$zip->addFile($this->config->contracts_dir.$contract->url.'/contract.pdf', 'contract-'.$contract->id.'.pdf');
							}
							$zip->close();

							if(file_exists($this->config->contracts_dir.$file_name))
							{
								header('Content-type: application/zip');
								header('Content-Disposition: attachment; filename="'.$file_name.'"');
								readfile($this->config->contracts_dir.$file_name);

								unlink($this->config->contracts_dir.$file_name);
							}
						}
					}

					$this->design->assign('apartments', $this->apartments);
				}
				
			}

		}

		// $this->params->day_width = 100 / $this->params->days_in_month;

		// print_r($this->apartments); exit;


		$this->design->assign('bookings_all', $bookings);


		$meta_title = 'Tenants';
		if(!empty($this->selected_house))
			$meta_title .= ' | '.$this->selected_house->name;
		$this->design->assign('meta_title', $meta_title);

		$this->design->assign('landlord', $landlord);
		$this->design->assign('houses', $houses);
		$this->design->assign('selected_house', $this->selected_house);

		if($this->selected_house->type == 1) // Hotel
			$this->design->assign('days_units', 'nights');

		$this->design->assign('type_view', $type_view);

		$this->design->assign('tenant_status', $tenant_status);
		$this->design->assign('params', $this->params);

		return $this->design->fetch('landlord/tenants.tpl');
	}
}
