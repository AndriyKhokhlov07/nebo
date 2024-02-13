<?PHP

require_once('view/View.php');

class HouseleaderCalendarView extends View
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

			if(date("Y-m-d", $u_arrive) >= $this->params->date_from && date("Y-m-d", $u_arrive) <= $this->params->date_to)
				$b->movein = true;
			
			if(date("Y-m-d", $u_depart) >= $this->params->date_from && date("Y-m-d", $u_depart) <= $this->params->date_to)
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

		if($this->user->type != 2)
			return false;

		// if(empty($this->user->permissions['calendar']) && !empty($this->user->permissions))
		// {
		// 	header("HTTP/1.1 301 Moved Permanently"); 
		// 	header('Location: '.$this->config->root_url.'/current-members');
		// 	exit();
		// }

		$houseleader = new stdClass;

		if(!empty($this->user->email))
		{
			if(!empty($this->user->main_info))
				$houseleader->main_info = $this->user->main_info;

			$users = [];
			$invoices = [];
			
			// HOUSES
	        $houses_filter = [
	            'menu_id' => 5, 
	            'not_tree' => 1,
	            'visible' => 1
	        ];
	        
	        $houses_filter['parent_id'] = 253;

			$houses = $this->pages->get_pages($houses_filter);

			$type_view = 'calendar';

			$selected_house_id = $this->request->get('house_id', 'integer');

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
				// 5 days back and 10 days forward
				if(empty($tenant_status) || $tenant_status == 1 || $tenant_status == 4)
				{

					$booking_params = [
						'house_id' => $this->selected_house->id,
						'now' => true,
						'status' => [
						    1,
                            2,
							3, // Contract / Invoice
							5  // Canceled Bed/Apt
						],
						'order_by' => 'b.depart',
						'no_to_key' => true
					];

					if(empty($tenant_status) || $tenant_status == 4)
					{
						$date_from = strtotime(date("Y-m-d")) - (5 * 24 * 3600);
						$this->params->date_from = date("Y-m-d", $date_from);

						$date_to = strtotime(date("Y-m-d")) + (10 * 24 * 3600);
						$this->params->date_to = date("Y-m-d", $date_to);

						$this->params->days_to_show = 15;
	
						for ($i = 0; $i < $this->params->days_to_show; $i++)
						{
							$day = $date_from + ($i * 24 * 3600);
							$this->params->calendar_days[] = date('M d', $day);
						}

						$booking_params['date_from2'] = $this->params->date_from;
						$booking_params['date_to2'] = $this->params->date_to;

						// Beds-days count
						$this->params->days_beds_count = 0;

						$this->params->u_from = $date_from;
						$this->params->u_to = $date_to;
						$this->params->u_interval = $this->params->u_to - $this->params->u_from;

						$u_from = $this->params->u_from;
						$u_to = $this->params->u_to;

						if(!empty($this->apartments))
						{
							foreach($this->apartments as $a)
							{
								$a_d_count = null;

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
											$r_days = $this->beds->calculate_bedsdays($r->date_added, $r->date_shutdown, $r->visible, $a_days->from, $a_days->to);

											if($r_days->d_count !== 0 && !empty($r->beds))
											{
												foreach($r->beds as $b)
												{
													$b_days = $this->beds->calculate_bedsdays($b->date_added, $b->date_shutdown, $b->visible, $r_days->from, $r_days->to);

													if($b_days->d_count !== 0)
														$this->params->days_beds_count += $b_days->d_count;

													$b_days->to += 86399;
													$b_days_interval = $b_days->to - $b_days->from - (24*3600);

										            if($b_days_interval > 0)
										            {
										                $b->width =  $b_days_interval / $this->params->u_interval * 100;
										                if($b->width > 100)
										                	$b->width = 100;
										                $b->start = ($b_days->from - $this->params->u_from) / $this->params->u_interval * 100;
										            }
										            else {
                                                        $b->width = 100;
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
						$booking_params['now'] = true;



					$bookings_ = $this->beds->get_bookings($booking_params);



					if(!empty($bookings_))
					{
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

					}
				}

				$this->design->assign('apartments', $this->apartments);
				
			}

		}

		$this->design->assign('bookings_all', $bookings);


		$meta_title = 'Tenants';
		if(!empty($this->selected_house))
			$meta_title .= ' | '.$this->selected_house->name;
		$this->design->assign('meta_title', $meta_title);

		$this->design->assign('houses', $houses);
		$this->design->assign('selected_house', $this->selected_house);

		$this->design->assign('type_view', $type_view);

		$this->design->assign('tenant_status', $tenant_status);
		$this->design->assign('params', $this->params);

		return $this->design->fetch('houseleader/tenants.tpl');
	}
}
