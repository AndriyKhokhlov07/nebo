<?php

require_once('Backend.php');

class RentRoll extends Backend
{
	private $params;
	private $data;
	private $rentroll1;
	private $rentroll2;
	private $rentroll4;
	private $rentroll5;
	private $rentroll6;

	public function __construct()
	{
		$this->params = new stdClass;
		$this->params->manager = $this->managers->get_manager();
		
		$this->rentroll1 = new stdClass;
		$this->rentroll2 = new stdClass;
		$this->rentroll4 = new stdClass;
		$this->rentroll5 = new stdClass;
		$this->rentroll6 = new stdClass;
	}
	
	
	public function getHouses(array $params)
	{
		$selected_house_id = $params['selected_house_id'];
		$landlord = false;
		if ($params['view'] == 'landlord' && !empty($params['landlord'])) {
			$landlord = $params['landlord'];
		}
		
		$houses_params = [
			'menu_id' => 5,
            'not_tree' => 1,
            'visible' => 1
		];
		if ($landlord) {
			$houses_params['id'] = $landlord->houses_ids;
		}
		$this->params->cities_houses = $this->pages->get_pages($houses_params);
        if (!empty($this->params->cities_houses)) {
            foreach($this->params->cities_houses as $ch) {
                if ($ch->parent_id > 0) {
                    if (!empty($ch->blocks2)) {
                        $ch->blocks2 = unserialize($ch->blocks2);
                    }
                    if ($ch->id == 311) {
                    	$ch->name = 'The Greenpoint House';
                    }
                    $this->params->houses[$ch->id] = $ch;
                }
            }
        }
        $this->params->cities_houses = $this->categories_tree->get_categories_tree('ch', $this->params->cities_houses);
        if (!empty($this->params->houses)) {
            if (!empty($selected_house_id) && isset($this->params->houses[$selected_house_id])) {
                $this->params->selected_house = $this->params->houses[$selected_house_id];
            } else {
                $this->params->selected_house = current($this->params->houses);
            }
            $this->params->houses[$this->params->selected_house->id]->selected = 1;
        }

        if (!empty($this->params->selected_house)) {
            $ll_companies = [];
            $ll_company = $this->companies->get_companies([
                'house_id' => $this->params->selected_house->id,
                'count' => 1
            ]);

            if (!empty($ll_company)) {
                if (!empty($ll_company->group_id)) {
                    $ll_companies = $this->companies->get_companies([
                        'group_id' => $ll_company->group_id
                    ]);
                    $ll_companies = $this->request->array_to_key($ll_companies, 'id');
                } else {
                    $ll_companies = [
                        $ll_company->id => $ll_company
                    ];
                }
                if (!empty($ll_companies)) {
                    $companies_houses_ids = $this->companies->get_company_houses([
                        'company_id' => array_keys($ll_companies)
                    ]);
                    $companies_houses_ids = $this->request->array_to_key($companies_houses_ids, 'house_id');
                }
            }
            
            // LLC Name
			if ($landlord && isset($landlord->companies[$landlord->company_houses_ids[$this->params->selected_house->id]->company_id])) {
				$this->params->selected_house->llc_name = $landlord->companies[$landlord->company_houses_ids[$this->params->selected_house->id]->company_id]->name;
			}
            
            $this->params->is_house_cassa = false;

            // The Williamsburg House
            if (in_array($this->params->selected_house->id, [334, 337])) {
                $this->params->selected_house->id = [
                    334,  // The Williamsburg House
                    337   // The Williamsburg House (165 N 5th Street)
                ];
            }
            // The Greenpoint House
            elseif (in_array($this->params->selected_house->id, [311, 316, 317])) {
                $this->params->selected_house->id = [
                    311,  // The Greenpoint House
                    316,  // The Greenpoint House (111)
                    317   // The Greenpoint House (115)
                ];
            }
            // 340 - Cassa Studio
			// 366 - Cassa Studios - 9th Ave Hotel
			elseif (in_array($this->params->selected_house->id, [340, 366])) {
				$this->params->is_house_cassa = true;
				if ($this->params->selected_house->id == 366) {
					$this->params->selected_house->id = [
						$this->params->selected_house->id,
						340
					];
				}
			}
			
			$this->params->selected_house_addr = [];
			if (is_array($this->params->selected_house->id)) {
				foreach ($this->params->selected_house->id as $h_id) {
					if (isset($this->params->houses[$h_id]) && !empty($this->params->houses[$h_id]->blocks2)) {
						$house_blocks2 = $this->params->houses[$h_id]->blocks2;
						if(!empty($house_blocks2['address'])) {
							$this->params->selected_house_addr[$h_id] = $house_blocks2['address'];
						}
					}	
				}
				if (!empty($this->params->selected_house_addr)) {
					$this->params->selected_house->blocks2['address'] = implode(' / ', $this->params->selected_house_addr);
				}
			}
			
			
			
			

            // Companies / Groups
            $houses_ids_by_groups = [];
            $company = $this->companies->get_companies([
                'house_id' => $this->params->selected_house->id,
                'limit' => 1,
                'count' => 1
            ]);

            if (!empty($company) && !empty($company->group_id)) {
                $companies_by_group = $this->companies->get_companies([
                    'group_id' => $company->group_id
                ]);
                $companies_by_group = $this->request->array_to_key($companies_by_group, 'id');

                if (!empty($companies_by_group)) {
                    $houses_ids_by_groups = $this->companies->get_company_houses([
                        'company_id' => array_keys($companies_by_group)
                    ]);
                    $houses_ids_by_groups = $this->request->array_to_key($houses_ids_by_groups, 'house_id');
                }
            }
		}
		
		$this->params->selected_house->main_id = current((array)$this->params->selected_house->id);
	}
	
	
	public function initDateParams(array $params)
	{
        $strtotime_now = strtotime('now');
		$strtotime_lastmonth = strtotime('- 1 month');
		
		$this->params->selected_date = date('Y-m-d', $strtotime_now);

		$this->params->month = $params['month'];
		$this->params->year = $params['year'];
		
		$this->params->now_month = new DateTime($this->params->year.'-'.$this->params->month.'-01');

		$this->params->next_month = new DateTime($this->params->year.'-'.$this->params->month.'-01');
		$this->params->next_month->modify('+1 month');
		
		$this->params->next_2month = new DateTime($this->params->year.'-'.$this->params->month.'-01');
		$this->params->next_2month->modify('+2 month');

		$this->params->prev_month = new DateTime($this->params->year.'-'.$this->params->month.'-01');
		$this->params->prev_month->modify('-1 month');

		$this->params->days_in_month = date("t", strtotime($this->params->year.'-'.$this->params->month.'-01'));
		$this->params->now_month_last_day = $this->params->year.'-'.$this->params->month.'-'.$this->params->days_in_month;

		if (strtotime($this->params->year.'-'.$this->params->month.'-01') > strtotime(date("Y-m", $strtotime_now).'-01')) {
			$this->params->hide_debt = true;
		}
		$this->params->rent_roll_id = $this->params->year.$this->params->month.$this->params->selected_house->main_id;
		
		if ($params['view'] == 'landlord' && (int)$this->params->year < 2021 && (int)$this->params->month < 12) {
			unset($this->params->prev_month);
		}
	}
	
	public function owner()
	{
        $br = '
';
		
		$owner = $this->request->post('owner');
		if (!empty($owner)) {
			$to_owner = (object)[
				'sum' => 0,
				'invoices' => []
			];
			foreach ($owner as $order_id=>$o) {
				if (!empty($order_id) && !empty($o['sended'])) {
					$order_upd = new stdClass;
					$order_upd->sended_owner = 1;
					$order_upd->sended_owner_price = $o['sended'];
					if (!empty($o['date'])) {
						$order_upd->sended_owner_date = date("Y-m-d", strtotime($o['date']));
					} else {
						$order_upd->sended_owner_date = date("Y-m-d");
					}
					$to_owner->sum += $order_upd->sended_owner_price;
					$to_owner->invoices[] = $order_id;
					if ($this->orders->update_order($order_id, $order_upd)) {
						$this->logs->add_log([
							'parent_id' => $order_id,
							'type' => 3, 	// Invoices (Orders)
							'subtype' => 8, // Sent to owner
							'sender_type' => 2,
							'sender' => $this->params->manager->login,
							'value' => 'Sum: $ '.($order_upd->sended_owner_price*1).$br.'Date: '.date_format(date_create($order_upd->sended_owner_date), 'M d, Y')
						]);
					}
				}
			}
			if ($to_owner->sum > 0 && !empty($this->params->rent_roll_id)) {
				$this->logs->add_log([
					'parent_id' => $this->params->rent_roll_id,
					'type' => 11, 	// Sent to owner
					'subtype' => 1, // Invoices
					'sender_type' => 2,
					'sender' => $this->params->manager->login,
					'value' => $to_owner->sum,
					'data' => $to_owner->invoices
				]);
				header('Location: '.$this->config->root_url.$_SERVER[REQUEST_URI]);
				exit;
			}
		}
	}
	
	
	public function tableRR2()
	{
		// Main Rant Roll table
		$this->rentroll2->table = [];
		$this->rentroll2->table_other_period = [];
		$this->rentroll2->table_debt = [];
		$apartment_tr = [];
		$room_tr = [];
		$bed_tr = [];
		$n = 1;
		foreach ($this->rentroll2->data->apartments as $apartment_id=>$a) {
			// The Greenpoint House
			if ($this->params->selected_house->main_id == 311) {
				$a->name = $this->params->houses[$a->house_id]->blocks2['street_number'].' – '.$a->name;
			}
			if ($this->rentroll2->data->apartments_invoices[$a->id]) {
				$a->invoices = $this->rentroll2->data->apartments_invoices[$a->id];
				$a->rows += count($this->rentroll2->data->apartments_invoices[$a->id]);
			}
			if (isset($a->rooms)) {
				$beds_count = 0;
				foreach ($a->rooms as $r) {
					if (isset($r->beds)) {
						foreach ($r->beds as $b) {
							$beds_count ++;
							$tr = new stdClass;
							$tr->type = 'data';
							if ($this->rentroll2->data->beds_invoices[$b->id]) {
								$tr->invoices = $this->rentroll2->data->beds_invoices[$b->id];
								$this->rentroll2->data->apartments[$a->id]->rooms[$r->id]->beds_invoices_count += count($this->rentroll2->data->beds_invoices[$b->id]);
							} else {
								$tr->invoices = [1];
								if($this->params->show_empty_rows==0) {
									$tr->empty = true;
								}
							}
							$tr->apartment->id = $a->id;
							$tr->apartment->name = $a->name;
							if (!$tr->empty && !isset($apartment_tr[$a->id])) {
								$apartment_tr[$a->id] = $n + 1;
							}
							if (!$tr->empty && !isset($room_tr[$a->id])) {
								$room_tr[$r->id] = $n + 1;
							}
							if (isset($a->invoices)) {
								$tr->apartment->invoices = $a->invoices;
							}
							if ($n > 0 && $this->rentroll2->table[$n]->type == 'data' && $this->rentroll2->table[$n]->apartment->id == $a->id) {
								unset($tr->apartment->name);
								unset($tr->apartment->invoices);
							}
							$tr->apartment->rows = $a->rows;
							$tr->room->id = $r->id;
							$tr->room->name = $r->name;
							$tr->room->rows = $r->rows;
							if ($n > 0 && $this->rentroll2->table[$n]->type == 'data' && $this->rentroll2->table[$n]->room->id == $r->id
								&& ($this->rentroll2->table[$n]->empty != true)) {
								unset($tr->room->name);
							}
							if ($tr->empty) {
								$row_n_apartment = $apartment_tr[$a->id];
								if (isset($this->rentroll2->data->apartments[$apartment_id])) {
									$this->rentroll2->data->apartments[$apartment_id]->rows--;
								}
								if (isset($this->rentroll2->table[$row_n_apartment]->apartment)) {
									$this->rentroll2->table[$row_n_apartment]->apartment->rows --;
								}
								$row_n_room = $room_tr[$r->id];
								if (isset($this->rentroll2->data->apartments[$a->id]->rooms[$r->id])) {
									$this->rentroll2->data->apartments[$a->id]->rooms[$r->id]->rows--;
								}
								if (isset($this->rentroll2->table[$row_n_room]->room)) {
									$this->rentroll2->table[$row_n_room]->room->rows --;
								}
							}
							$tr->bed->id = $b->id;
							$tr->bed->name = $b->name;
							$tr->bed->rows = $b->rows;
							$bed_tr[$b->id] = $n;
							if (!$tr->empty) {
								$n++;
								$this->rentroll2->table[$n] = $tr;
							}
						}
					}
				}
				if (($this->rentroll2->table[$n]->type == 'total' || $n==1) && isset($a->invoices)) {
					$tr = new stdClass;
					$tr->apartment->id = $a->id;
					$tr->apartment->name = $a->name;
					$tr->apartment->invoices = $a->invoices;
					$tr->apartment->rows = count($a->invoices);
					$n++;
					$this->rentroll2->table[$n] = $tr;
				}
				if (($this->rentroll2->table[$n]->type != 'total' && $n>1) || isset($a->invoices)) {
					$tr_total = new stdClass;
					$tr_total->booking = new stdClass;
					$tr_total->booking->broker_fee = $a->broker_fee;
					$tr_total->booking->broker_fee_paid = $a->broker_fee_paid;
					$tr_total->total_price = $a->total_invices_price;
					$tr_total->month = 'this';
					$tr_total->paid = 1;
					$tr_total->paid_m = 'this_month';
					if (!empty($tr_total->booking->broker_fee)) {
						$tr_total->isset_broker_fee = true;
					}
					if ($a->total_invices_paid_price > 0) {
						$tr_total->total_paid_price = $a->total_invices_paid_price;
					}
					$tr = new stdClass;
					$tr->type = 'total';
					$tr->class = 'tr_total';
					$tr->apartment->name = 'Total';
					$tr->apartment->id = $a->id;
					$tr->room->name = count($a->rooms);
					$tr->bed->name = $beds_count;
					$tr->invoices = [
						1 => $tr_total
					];

					$n++;
					$this->rentroll2->table[$n] = $tr;
				}

			}
		}
	}
	
	// ----------------------
	// RENTROLL 1
	// Tenant Directory
	// ----------------------
	public function getRR1($params = [])
    {
    	$result = new stdClass;
        
        $houses_params = [
        	'selected_house_id' => $params['house_id'],
        	'view' => $params['view'],
        ];
        if (isset($params['landlord'])) {
        	$houses_params['landlord'] = $params['landlord'];
        }
        $this->getHouses($houses_params);

		$this->rentroll1->data = $this->initRR1Data();
        
        $this->rentroll1->params = $this->params;
        return $this->rentroll1;
    }

    //directory
    public function initRR1Data($params = [])
    {
    	$data = new stdClass;

        if (!empty($this->params->selected_house)) {

            if ($data->bookings = $this->beds->get_bookings([
                'house_id' => $this->params->selected_house->id,
                'status' => [
                    // 2, // Pending
                    3  // Confirmed
                ],
                'now' => true,
                'sp_group' => true,
                //'sp_group_from_start' => true,
                'select_users' => true,
            ])) {
                $beds_ids = [];
                $bookingsIds = [];
                foreach($data->bookings as $booking) {
                    // Booking type: Bed
                    if ($booking->type == 1) {
                        $beds_ids[$booking->object_id] = $booking->object_id;
                    }
                    $bookingsIds[$booking->id] = $booking->id;
                }

                $data->apartments = $this->beds->get_apartments([
                    'house_id' => $this->params->selected_house->id
                ]);

                $data->apartments = $this->request->array_to_key($data->apartments, 'id');
                if (!empty($beds_ids)) {
                    $beds = $this->beds->get_beds([
                        'id' => $beds_ids
                    ]);
                    $beds = $this->request->array_to_key($beds, 'id');
                }

                $data->contracts = $this->contracts->get_contracts([
                    'reserv_id' => $bookingsIds,
                    'status' => [1, 2]
                ]);

                $data->contracts = $this->request->array_to_key($data->contracts, 'reserv_id');

                $users_ids = [];
                $users_bookings = [];
                foreach($data->bookings as $booking) {

                    $booking_client_group = $this->users->getClientGroupByType($booking->client_type_id);
                    if($booking_client_group->id != 1){
                        $booking->price_month = 0;
                    }

                    if (isset($data->apartments[$booking->apartment_id])) {
                        $booking->apartment = $data->apartments[$booking->apartment_id];
                    }
                    if (isset($data->contracts[$booking->id])) {
                        $booking->contract = $data->contracts[$booking->id];
                    }
                    // Bed
                    if ($booking->type == 1 && isset($beds[$booking->object_id])) {
                        $booking->bed = $beds[$booking->object_id];
                    }
                    if (!empty($booking->users)) {
                        $booking_user = current($booking->users);
                        $users_ids[$booking_user->id] = $booking_user->id;
                        $users_bookings[$booking_user->id] = $booking->id;
                    }

                    $booking->u_arrive = strtotime($booking->arrive);
                    $booking->u_depart = strtotime($booking->depart);

                    $booking->date_from = $booking->arrive;
                    $booking->date_to = $booking->depart;

                    $booking->u_date_from = strtotime($booking->date_from);
                    $booking->u_date_to = strtotime($booking->date_to);

                    if($booking->price_month == 0){
                    	$booking->price_month = $booking->contract->price_month;
                    }
                    if($booking->price_month == 0 && !empty($booking->price_day)){
                    	$booking->price_month = $booking->price_day * 30;
                    }

                }

                $bookings_all = $this->beds->get_bookings([
                    'house_id' => $this->params->selected_house->id,
                    'status' => [
                        // 2, // Pending
                        3  // Confirmed
                    ],
                    'select_users' => true,
					'sp_group' => true,
                    'user_id' => $users_ids,
                    'order_by' => 'b.arrive'
                ]);

                // Sort bookings by date
                if (!empty($bookings_all)) {
                    $prev_booking = [];
                    $interval_off = 2 * (60 * 60 * 24);
                    foreach ($bookings_all as $booking) {
                    	$booking_user = current($booking->users);
		        		$booking->user_id = $booking_user->id;
                        $booking_id = $users_bookings[$booking->user_id];
                        if (isset($data->bookings[$booking_id])) {
                            $booking->u_arrive = strtotime($booking->arrive);
                            $booking->u_depart = strtotime($booking->depart);

                            if (!isset($prev_booking[$booking->user_id])) {
                                $data->bookings[$booking_id]->u_date_from_tmp = $booking->u_arrive;
                                $data->bookings[$booking_id]->u_date_to_tmp = $booking->u_depart;
                                $prev_booking[$booking->user_id] = $booking;
                            }
                            elseif (($booking->u_arrive - $prev_booking[$booking->user_id]->u_depart) < $interval_off) {
                                $data->bookings[$booking_id]->u_date_to_tmp = $booking->u_depart;
                                $prev_booking[$booking->user_id] = $booking;
                            }
                            elseif ($booking->u_arrive <= $data->bookings[$booking_id]->u_arrive) {
                                $data->bookings[$booking_id]->u_date_from_tmp = $booking->u_arrive;
                                $data->bookings[$booking_id]->u_date_to_tmp = $booking->u_depart;
                                $prev_booking[$booking->user_id] = $booking;
                            }

                            if (isset($data->bookings[$booking_id]->u_date_from_tmp) && isset($data->bookings[$booking_id]->u_date_to_tmp)) {
                                if ($data->bookings[$booking_id]->u_date_from_tmp <= $data->bookings[$booking_id]->u_arrive && $data->bookings[$booking_id]->u_date_to_tmp >= $data->bookings[$booking_id]->u_depart) {
                                    $data->bookings[$booking_id]->date_from = date('Y-m-d', $data->bookings[$booking_id]->u_date_from_tmp);
                                    $data->bookings[$booking_id]->date_to = date('Y-m-d', $data->bookings[$booking_id]->u_date_to_tmp);
                                }
                            }
                        }
                    }
                }
            }
        }

        usort($data->bookings, function ($booking1, $booking2) {
            // Sort by field apartment->name
            $apartmentNameComparison = strcmp($booking1->apartment->name, $booking2->apartment->name);
            if ($apartmentNameComparison !== 0) {
                return $apartmentNameComparison;
            }
            // Sort by field bed->name
            return strcmp($booking1->bed->position, $booking2->bed->position);
        });

        return $data->bookings;
    }

	// ----------------------
	// RENTROLL 2
	// Invoice Based
	// ----------------------
	public function getRR2($params = [])
    {
    	$result = new stdClass;
        
        $houses_params = [
        	'selected_house_id' => $params['house_id'],
        	'view' => $params['view'],
        ];
        if (isset($params['landlord'])) {
        	$houses_params['landlord'] = $params['landlord'];
        }
        $this->params->show_empty_rows = $params['show_empty_rows'];
        $this->getHouses($houses_params);
        $this->initDateParams($params);
		$this->owner();

		$this->params->payments_qira = false;
		$payments_houses_ids = $this->payment->get_payment_method_houses([
			'house_id' => $this->params->selected_house->id
		]);
		$payments_houses_ids = $this->request->array_to_key($payments_houses_ids, 'payment_method_id');
		if (!empty($payments_houses_ids)) {
			$payments_houses = $this->payment->get_payment_methods([
				'id' => array_keys($payments_houses_ids)
			]);
			if (!empty($payments_houses)) {
				foreach ($payments_houses as $ph) {
					if ($ph->module == 'Qira') {
						$this->params->payments_qira = true;
					}
				}
			}
		}

		if ($this->params->payments_qira === true) {
			$this->params->payments_methods_qira = $this->payment->get_payment_methods([
				'module' => 'Qira'
			]);
			$this->params->payments_methods_qira = $this->request->array_to_key($this->params->payments_methods_qira, 'id');
		}
				
		$this->rentroll2->data = $this->getRRData('rr2');
		
		if ($this->managers->access('rentroll_save') && !empty($this->rentroll2->data) && empty($this->rentroll2->data->is_cache) && $params['action'] == 'save') {
			$this->saveRR2();
		}
		
		$this->tableRR2();
		
		
		
		if (!empty($this->params->rent_roll_id)) {
            if ($logs = $this->logs->get_logs([
                'parent_id' => $this->params->rent_roll_id,
                'type' => 20 // Rent Roll 2
            ])) {
                $this->rentroll2->logs_save = [];
                foreach ($logs as $l) {
                    // Log: Rent Roll Save
                    if ($l->type == 20 && $l->subtype == 1) {
                        $this->rentroll2->logs_save[] = $l;
                    }
                }
            }
        }
        
        // Invoices Sum Sended Owner
		$query = $this->db->placehold("SELECT 
				o.sended_owner_date as date,
				COUNT(*) AS count,
				SUM(o.total_price) AS price
			FROM __orders AS o 
			INNER JOIN  __bookings b ON b.id=o.booking_id AND b.house_id in(?@)
			WHERE 
				o.sended_owner=1
				AND o.status!=3
				AND (MONTH(o.sended_owner_date)=? AND YEAR(o.sended_owner_date)=?)
			GROUP BY o.sended_owner_date
			ORDER BY o.sended_owner_date DESC
			", 
			(array)$this->params->selected_house->id,
			$this->params->month,
			$this->params->year
		);
		$this->db->query($query);
		$sended_owner_ = $this->db->results();
		if (!empty($sended_owner_)) {
			$sended_owner = new stdClass;
			foreach ($sended_owner_ as $so) {
				$sended_owner->items[] = $so;
				$sended_owner->sum += $so->price;
				$sended_owner->count += $so->count;
			}
			unset($sended_owner_);
			$this->rentroll2->sended_owner = $sended_owner;
		}

        $this->rentroll2->params = $this->params;
        
        
        unset($this->params->houses[337]); // The Williamsburg House (165 N 5th Street)
		unset($this->params->houses[316]); // The Greenpoint House (111)
		unset($this->params->houses[317]); // The Greenpoint House (115)
		
		foreach ($this->params->cities_houses as $c_key=>$c) {
			// NYC
			if ($c->id == 253) {
				foreach ($c->subcategories as $h_key=>$h) {
					if (in_array($h->id, [337, 316, 317])) {
						unset($this->params->cities_houses[$c_key]->subcategories[$h_key]);
					}
				}
			}
		}
        
        
        return $this->rentroll2;
    }
    
    
    // ----------------------
	// RENTROLL 4
	// Prorated Monthly Rent Roll
	// ----------------------
	public function getRR4($params = [])
    {
    	$result = new stdClass;
        
        $houses_params = [
        	'selected_house_id' => $params['house_id'],
        	'view' => $params['view'],
        ];
        if (isset($params['landlord'])) {
        	$houses_params['landlord'] = $params['landlord'];
        }
        $this->getHouses($houses_params);
        $this->initDateParams($params);


		$this->rentroll4->data = $this->getRRData('rr4');
		
		if ($this->managers->access('rentroll_save') && !empty($this->rentroll4->data) && empty($this->rentroll4->data->is_cache) && $params['action'] == 'save') {
			$this->saveRR4();
		}
				
        unset($this->params->houses[337]); // The Williamsburg House (165 N 5th Street)
		unset($this->params->houses[316]); // The Greenpoint House (111)
		unset($this->params->houses[317]); // The Greenpoint House (115)
		
		foreach ($this->params->cities_houses as $c_key=>$c) {
			// NYC
			if ($c->id == 253) {
				foreach ($c->subcategories as $h_key=>$h) {
					if (in_array($h->id, [337, 316, 317])) {
						unset($this->params->cities_houses[$c_key]->subcategories[$h_key]);
					}
				}
			}
		}
		
		if (!empty($this->params->rent_roll_id)) {
            if ($logs = $this->logs->get_logs([
                'parent_id' => $this->params->rent_roll_id,
                'type' => 21 // Rent Roll 4
            ])) {
                $this->rentroll2->logs_save = [];
                foreach ($logs as $l) {
                    // Log: Rent Roll Save
                    if ($l->type == 21 && $l->subtype == 1) {
                        $this->rentroll4->logs_save[] = $l;
                    }
                }
            }
        }
        
        $this->rentroll4->params = $this->params;
        return $this->rentroll4;
    }

    // ----------------------
	// RENTROLL 5
	// Rent Roll 5
	// ----------------------
	public function getRR5($params = [])
    {
    	$result = new stdClass;
        
        $houses_params = [
        	'selected_house_id' => $params['house_id'],
        	'view' => $params['view'],
        ];
        if (isset($params['landlord'])) {
        	$houses_params['landlord'] = $params['landlord'];
        }
        $this->getHouses($houses_params);
        $this->initDateParams($params);

		$this->rentroll5->data = $this->initRR5Data($params);
				
        unset($this->params->houses[337]); // The Williamsburg House (165 N 5th Street)
		unset($this->params->houses[316]); // The Greenpoint House (111)
		unset($this->params->houses[317]); // The Greenpoint House (115)
		
		foreach ($this->params->cities_houses as $c_key=>$c) {
			// NYC
			if ($c->id == 253) {
				foreach ($c->subcategories as $h_key=>$h) {
					if (in_array($h->id, [337, 316, 317])) {
						unset($this->params->cities_houses[$c_key]->subcategories[$h_key]);
					}
				}
			}
		}
        
        $this->rentroll5->params = $this->params;
        return $this->rentroll5;
    }

    // ----------------------
	// RENTROLL 6
	// Rent Roll 6
	// ----------------------
	public function getRR6($params = [])
    {
    	$result = new stdClass;
        
        $houses_params = [
        	'selected_house_id' => $params['house_id'],
        	'view' => $params['view'],
        ];
        if (isset($params['landlord'])) {
        	$houses_params['landlord'] = $params['landlord'];
        }
        $this->getHouses($houses_params);
        $this->initDateParams($params);

		$this->rentroll6->data = $this->initRR6Data($params);
		$this->rentroll6->data = $this->getRRData('rr6');

		if ($this->managers->access('rentroll_save') && !empty($this->rentroll6->data) && empty($this->rentroll6->data->is_cache) && $params['action'] == 'save') {
			$this->saveRR6();
		}
				
        unset($this->params->houses[337]); // The Williamsburg House (165 N 5th Street)
		unset($this->params->houses[316]); // The Greenpoint House (111)
		unset($this->params->houses[317]); // The Greenpoint House (115)
		
		foreach ($this->params->cities_houses as $c_key=>$c) {
			// NYC
			if ($c->id == 253) {
				foreach ($c->subcategories as $h_key=>$h) {
					if (in_array($h->id, [337, 316, 317])) {
						unset($this->params->cities_houses[$c_key]->subcategories[$h_key]);
					}
				}
			}
		}
		if (!empty($this->params->rent_roll_id)) {
            if ($logs = $this->logs->get_logs([
                'parent_id' => $this->params->rent_roll_id,
                'type' => 25 // Rent Roll 6
            ])) {
                $this->rentroll6->logs_save = [];
                foreach ($logs as $l) {
                    // Log: Rent Roll Save
                    if ($l->type == 25 && $l->subtype == 1) {
                        $this->rentroll6->logs_save[] = $l;
                    }
                }
            }
        }
        
        $this->rentroll6->params = $this->params;
        return $this->rentroll6;
    }
    
    
    function getRRData($type)
    {
        $data = $this->cache->get_data($type, [
            'month' => $this->params->month,
            'year'  => $this->params->year,
            'house_id' => $this->params->selected_house->main_id
        ]);
        if (empty($data)) {
        	if ($type == 'rr2') {
        		$data = $this->initRR2Data();
        	}
        	elseif ($type == 'rr4') {
        		$data = $this->initRR4Data();
        	}
        	if ($type == 'rr6') {
        		$data = $this->initRR6Data();
        	}
        }
		return $data;
	}
	
	public function saveRR2 ()
	{
		$this->cache->set_data(
			'rr2',
			[
				'month' => $this->params->month,
				'year'  => $this->params->year,
				'house_id' => $this->params->selected_house->main_id
			],
			$this->rentroll2->data
		);
		$this->rentroll2->data->is_cache = true;
		$this->logs->add_log([
			'parent_id' => $this->params->rent_roll_id,
			'type' => 20, 	// Rent Roll 2
			'subtype' => 1, // Save
			'sender_type' => 2,
			'sender' => $this->params->manager->login
		]);
	}
	
	public function saveRR4 ()
	{
		$this->cache->set_data(
			'rr4',
			[
				'month' => $this->params->month,
				'year'  => $this->params->year,
				'house_id' => $this->params->selected_house->main_id
			],
			$this->rentroll4->data
		);
		$this->rentroll4->data->is_cache = true;
		$this->logs->add_log([
			'parent_id' => $this->params->rent_roll_id,
			'type' => 21, 	// Rent Roll 4
			'subtype' => 1, // Save
			'sender_type' => 2,
			'sender' => $this->params->manager->login
		]);
	}

	public function saveRR6 ()
	{
		$this->cache->set_data(
			'rr6',
			[
				'month' => $this->params->month,
				'year'  => $this->params->year,
				'house_id' => $this->params->selected_house->main_id
			],
			$this->rentroll6->data
		);
		$this->rentroll6->data->is_cache = true;
		$this->logs->add_log([
			'parent_id' => $this->params->rent_roll_id,
			'type' => 25, 	// Rent Roll 6
			'subtype' => 1, // Save
			'sender_type' => 2,
			'sender' => $this->params->manager->login
		]);
	}
	
	public function initRR2Data($params = [])
    {
        $data = new stdClass;
		$beds_rooms_ids = [];
		$rooms = [];

		$data->grand_total = new stdClass;

		$data->grand_total->price_invoices = 0;
		$data->grand_total->price_paid_invoices = 0;
		$data->grand_total->total_price_paid_invoices = 0;
		$data->grand_total->total_price_unpaid_invoices = 0;

		// Apartments
		$data->apartments = $this->beds->get_apartments([
			'house_id' => $this->params->selected_house->id,
			'visible' => 1,
			'sort' => 'name'
		]);
		$data->apartments = $this->request->array_to_key($data->apartments, 'id');

		// Rooms
		$rooms_ = $this->beds->get_rooms([
			'house_id' => $this->params->selected_house->id,
			'visible' => 1
		]);
		
		$rooms_apartments_ids = [];
		if (!empty($rooms_)) {
			foreach ($rooms_ as $r) {
				if (substr(trim($r->name), 0, 5) == 'Room ') {
                    $r->name = substr(trim($r->name), 5);
                }

				if (!empty($r->apartment_id) && isset($data->apartments[$r->apartment_id])) {
					if (trim($r->name) != 'Transfer room') {
						$data->apartments[$r->apartment_id]->rooms[$r->id] = $r;

						$rooms[$r->id] = $r;
						$data->apartments[$r->apartment_id]->rows ++;
						$rooms_apartments_ids[$r->id] = $r->apartment_id;
					}
				}
			}
		}

		// Beds
		$beds = $this->beds->get_beds([
			'room_id' => array_keys($rooms)
		]);
		if (!empty($beds)) {
			foreach($beds as $b) {
				$beds_rooms_ids[$b->id] = $b->room_id;
				$apartment_id = $rooms[$b->room_id]->apartment_id;
				if (isset($data->apartments[$apartment_id]->rooms[$b->room_id]->beds)) {
					$data->apartments[$apartment_id]->rows ++;
				}
				if (isset($data->apartments[$apartment_id]->rooms[$b->room_id])) {
                    $data->apartments[$apartment_id]->rooms[$b->room_id]->rows++;
                }
				$b->rows = 1;
				$data->apartments[$apartment_id]->rooms[$b->room_id]->beds[$b->id] = $b;
				$data->apartments[$apartment_id]->beds_count++;
			}
		}

		$bookings_ids = [];

		$data->houseleaders = $this->users->get_users([
			'type' => 2,
			'house_id' => $this->params->selected_house->id,
			'enabled' => 1
		]);
		$data->houseleaders = $this->request->array_to_key($data->houseleaders, 'active_booking_id');
		if (!empty($data->houseleaders)) {
            $bookings_ids = array_keys($data->houseleaders);
        }


		// Invoices / Bookings
		$orders_params = [
			'house_id' => $this->params->selected_house->id,
			'date_month_from_to' => $this->params->month,
			'date_year_from_to' => $this->params->year,
			// 'date_from_month' => $this->params->month,
			// 'date_from_year' => $this->params->year,
			'or_paid_month' => true,
			'type' => [
				1, // Invoices
				14 // Parking
			],
			'deposit' => 0,
			'not_status' => 3,
			'select_labels' => 1,
			'limit' => 3000,
			'sort_date_from' => true
		];
		if (empty($this->params->hide_debt)) {
            $orders_params['debt'] = true;
        }
		$invoices = $this->orders->get_orders($orders_params);

		// Костыль для Cassa Studios - 9th Ave Hotel
		if (in_array(366, (array)$this->params->selected_house->id) && $this->params->year == 2022 && $this->params->month == 3) {
			foreach($invoices as $k=>$i) {
				if (strtotime($i->date_from) < strtotime('2022-03-16')) {
					unset($invoices[$k]);
				}
			}
		}

		// Deposits
		$deposits_params = [
			'house_id' => $this->params->selected_house->id,
			'type' => [
				1, // Invoices
				14 // Parking
			],
			'deposit' => 1,
			'paid' => 1,
			'paid_month' => $this->params->month,
			'paid_year' => $this->params->year,
			'select_labels' => 1,
			'not_status' => 3,
			'limit' => 3000
		];
		$deposits = $this->orders->get_orders($deposits_params);
		if (!empty($deposits)) {
			foreach ($deposits as $d) {
                $invoices[$d->id] = $d;
            }
		}

		if (!empty($invoices)) {
			$bookings_invoices_ids = [];
			$contracts_invoices_ids = [];
			foreach ($invoices as $i) {
				$i->days_count = round((strtotime($i->date_to) - strtotime($i->date_from))/ (24 * 60 * 60) + 1);
				$invoices[$i->id]->days_count = $i->days_count;
				$invoices[$i->id]->price = $i->total_price;
				if ($this->params->payments_qira === true) {
					if ($i->payment_method_id == 0 || is_null($i->payment_method_id) || isset($this->params->payments_methods_qira[$i->payment_method_id])) {
						$i->payment_method_name = 'Qira';
						if (isset($this->params->payments_methods_qira[$i->payment_method_id])) {
							$i->payment_method = $this->params->payments_methods_qira[$i->payment_method_id];
						}
						elseif ($i->paid == 1) {
							$i->payment_method_name = 'Not selected PM';
						}
					}
				}
				if (!empty($i->booking_id)) {
					$bookings_ids[$i->booking_id] = $i->booking_id;
					$bookings_invoices_ids[$i->booking_id][$i->id] = $i->id;
				}
				if (!empty($i->contract_id)) {
                    $contracts_invoices_ids[$i->contract_id][$i->id] = $i->id;
                }
			}

			// Contracts
			if (!empty($contracts_invoices_ids)) {
				$contracts = $this->contracts->get_contracts([
					'id' => array_keys($contracts_invoices_ids),
					'limit' => count($contracts_invoices_ids)
				]);
				if (!empty($contracts)) {
					foreach ($contracts as $c) {
						$c->days_count = round((strtotime($c->date_to) - strtotime($c->date_from)) / (24 * 60 * 60) + 1);
						if (isset($contracts_invoices_ids[$c->id])) {
							foreach($contracts_invoices_ids[$c->id] as $invoice_id) {
								if (isset($invoices[$invoice_id])) {
									$invoices[$invoice_id]->contract = $c;
								}
							}
						}
					}
				}
			}

			// Bookings

			// Main rent roll invoices
			$data->beds_invoices = [];
			$data->apartments_invoices = [];

			// Other period invoices
			$data->other_period_total->price = 0;
			$data->other_period_total->price_paid = 0;
			$data->past_paid_total_price = 0;

			// debt invoices
			$data->debt_invoices = [];
			$data->debt_invoices->price = 0;

			// deposit invoices
			$data->deposit_invoices = [];
			$data->deposit_invoices->price = 0;

			if (!empty($bookings_ids)) {
				$bookings_ = $this->beds->get_bookings([
					'id' => $bookings_ids,
					'select_users' => true,
					'sp_group' => true,
					'sp_group_from_start' => true,
					'order_by' => 'b.object_id, b.arrive, b.id'
				]);

				$bookings = [];

				$bookings_status_new = [];
				$bookings_status_new_users = [];

				$bookings_status_ext = [];
				$bookings_status_ext_users = [];

				$bookings_status_new_ext = [];
				$bookings_status_new_ext_users = [];

				foreach ($bookings_ as $k=>$b) {
					// Костыль для Cassa Studios / Cassa Studios - 9th Ave Hotel
					if ($is_house_cassa) {
						if (!empty($b->sp_bookings) && count($b->sp_bookings) > 1) {
							foreach ($b->sp_bookings as $sb) {
								if ((($sb->u_arrive >= strtotime($this->params->year.'-'.$this->params->month.'-01') && $sb->u_arrive <= strtotime($this->params->now_month_last_day))) || ($sb->u_arrive <= strtotime($this->params->year.'-'.$this->params->month.'-01') &&  $sb->u_depart >= strtotime($this->params->year.'-'.$this->params->month.'-01') )) 
								{
									$b->object_id = $sb->object_id;
									$b->apartment_id = $sb->apartment_id;
									$b->house_id = $sb->house_id;
									$b->sptr = 1;
								}
							}
						}
					}
					// Костыль (end)

					$b->client_type = $this->users->get_client_type($b->client_type_id);
                    $b->client_group = $this->users->getClientGroupByType($b->client_type_id);

					// Price Night
					$u_arrive = strtotime($b->arrive);
					$u_depart = strtotime($b->depart);
					$b->nights_count = round(($u_depart - $u_arrive) / (24 * 60 * 60));
					if ($b->price_night < 1) {
						$b->price_night = round(($b->total_price / $b->nights_count), 2);
					}
                    // Booking type: Bed
					if ($b->type == 1) {
						$room_id = $beds_rooms_ids[$b->object_id];
						if (!empty($room_id)) {
							$apartment_id = $rooms_apartments_ids[$room_id];
							if(!empty($apartment_id) && $b->apartment_id != $apartment_id) {
                                $b->apartment_id = $apartment_id;
                            }
						}
						if (!empty($b->sp_bookings)) {
							foreach($b->sp_bookings as $k=>$sp_booking) {
								$sp_booking->u_arrive -= 10;
								$sp_booking->arrive = date('Y-m-d', $b->sp_bookings[$k]->u_arrive);
								$sp_room_id = $beds_rooms_ids[$sp_booking->object_id];
								$sp_booking->room_id = $sp_room_id;
								$sp_booking->apartment_id = $rooms[$sp_room_id]->apartment_id;
								if ($sp_booking->u_arrive <= strtotime($this->params->now_month_last_day.' 23:59:59') && $sp_booking->u_depart >= strtotime($this->params->now_month_last_day.' 23:59:59')) {
									$b->object_id = $sp_booking->object_id;
									$b->room_id = $sp_booking->room_id;
									$b->apartment_id = $sp_booking->apartment_id;
								}
							}
						}
						if (isset($data->apartments[$b->apartment_id])) {
							$bookings[$k] = $b;
						}
					}
                    // Booking type: Apartment
					elseif ($b->type == 2) {
						if (isset($data->apartments[$b->object_id])) {
							$bookings[$k] = $b;
						}	
					}

					if (!isset($data->houseleaders[$b->id]) && isset($bookings_invoices_ids[$b->id])) {
						foreach($bookings_invoices_ids[$b->id] as $invoice_id) {
							if (isset($invoices[$invoice_id])) {
								$invoice = $invoices[$invoice_id];
								if ($invoice->date_from <= $b->arrive) {
									$date_group = date("Y-m-t", strtotime($b->arrive));
									if ($b->parent_id == 0) {
										$invoice->new = true;
									}
									elseif ($b->parent_id > 0) {
										$invoice->extension = true;
									}
									if (!empty($b->users)) {
										$b_user = current($b->users);
										if ($b->parent_id == 0) {
											$bookings_status_new[$date_group][$b->id] = $b;
											$bookings_status_new_users[$date_group][$b_user->id][$b->id] = $invoice->id;
										}
										elseif ($b->parent_id > 0) {
											$bookings_status_ext[$date_group][$b->id] = $b;
											$bookings_status_ext_users[$date_group][$b_user->id][$b->id] = $invoice->id;
										}
									}
									$bookings_status_new_ext[$date_group][$b->id] = $b->id;
									$bookings_status_new_ext_users[$date_group][$b_user->id][$b->id] = $invoice->id;
								}
							}
						}
					}
				}

				// bookings new or not 
				// ext
				if(!empty($bookings_status_new_ext_users) && !empty($bookings_status_new_ext) && !empty($companies_houses_ids))
				{
					foreach($bookings_status_new_ext as $date_group=>$bs)
					{
						$p_bookings = $this->beds->get_bookings([
							'not_id' => array_keys($bs),
							'user_id' => array_keys($bookings_status_new_ext_users[$date_group]),
							'house_id' => array_keys($companies_houses_ids),
							'is_due' => true,
							'depart' => $date_group,
							'select_users' => true,
							'sp_group' => true,
							'sp_group_from_start' => true
							// 'print_query' => true
						]);

						if(!empty($p_bookings))
						{
							foreach($p_bookings as $b)
							{
								$b->client_type = $this->users->get_client_type($b->client_type_id);
								if(!empty($b->users))
								{
									foreach($b->users as $u)
									{
										// new (to ext)
										if(isset($bookings_status_new_users[$date_group][$u->id]))
										{
											foreach($bookings_status_new_users[$date_group][$u->id] as $booking_id=>$invoice_id)
											{
												$b_interv = (strtotime($bookings[$booking_id]->arrive) - strtotime($b->depart)) / (24* 60 * 60);
												if($b_interv >= 0 && $b_interv < 30)
												{
													$invoices[$invoice_id]->new = false;
													$invoices[$invoice_id]->extension = true;
												}
											}
										}
										// ext
										if(isset($bookings_status_ext_users[$date_group][$u->id]))
										{
											foreach($bookings_status_ext_users[$date_group][$u->id] as $booking_id=>$invoice_id)
											{
												$b_interv = (strtotime($bookings[$booking_id]->arrive) - strtotime($b->depart)) / (24* 60 * 60);
												if($b_interv >= 0 && $b_interv < 30)
												{
													$invoices[$invoice_id]->new = false;
													$invoices[$invoice_id]->extension = true;
													$invoices[$invoice_id]->is_extension = true;
												}
												elseif(empty($invoices[$invoice_id]->is_extension))
												{
													$invoices[$invoice_id]->new = true;
												}
											}

										}
									}
								}
							} 
						}
					}
				}

				foreach ($bookings as $b) {
					// Houseleaders
                    /*
					if (isset($data->houseleaders[$b->id])) {
						$u_arrive = strtotime($b->arrive);
						$u_depart = strtotime($b->depart);

						if(
							($u_arrive <= $this->params->now_month->getTimestamp() && $u_depart > $this->params->now_month->getTimestamp())
							||
							($u_depart >= strtotime($this->params->now_month_last_day) && $u_arrive <= strtotime($this->params->now_month_last_day))
						) {
							$invoice = new stdClass;
							$invoice_id = 'b'.$b->id;
							$houseleader = $data->houseleaders[$b->id];
							$b_interval = $u_depart - $u_arrive;
							$b->days_count = round($b_interval / (24 * 60 * 60) + 1);
							$apartment_id = $houseleader->apartment_id;
                            // booking: bed
							if ($b->type == 1) {
								 $b->price_month = 0;
								 $b->price_day = 0;
								 $b->total_price = 0;
								 $b->price_month_airbnb = 0;

								$invoice->month = 'this';
								$invoice->paid_m = 'this_month';
								$invoice->type = 'houseleader';
								$invoice->booking = $b;

								$data->beds_invoices[$b->object_id][$invoice_id] = $invoice;

								$room_id = $beds_rooms_ids[$b->object_id];
								$apartment_id = $rooms[$room_id]->apartment_id;

								if (count($data->beds_invoices[$b->object_id]) > 1) {
									if (isset($data->apartments[$apartment_id])) {
                                        $data->apartments[$apartment_id]->rows++;
                                    }
									if (isset($data->apartments[$apartment_id]->rooms[$room_id]) && isset($data->apartments[$apartment_id]->rooms[$room_id]->beds[$b->object_id])) {
										$data->apartments[$apartment_id]->rooms[$room_id]->rows ++;
									}
									if (isset($data->apartments[$apartment_id]->rooms[$room_id]->beds[$b->object_id])) {
                                        $data->apartments[$apartment_id]->rooms[$room_id]->beds[$b->object_id]->rows = count($data->beds_invoices[$b->object_id]);
                                    }
								}
							}
						}
					}
					else
                    */
                    if (isset($bookings_invoices_ids[$b->id])) {
						foreach ($bookings_invoices_ids[$b->id] as $invoice_id) {
							if(isset($invoices[$invoice_id])) {
								$invoice = $invoices[$invoice_id];

                                if (isset($data->houseleaders[$b->id])) {
                                    $u_arrive = strtotime($b->arrive);
                                    $u_depart = strtotime($b->depart);

                                    if (
                                        ($u_arrive <= $this->params->now_month->getTimestamp() && $u_depart > $this->params->now_month->getTimestamp())
                                        ||
                                        ($u_depart >= strtotime($this->params->now_month_last_day) && $u_arrive <= strtotime($this->params->now_month_last_day))
                                    ) {
                                        $invoice->type = 'houseleader';
                                    }
                                }

								// days count
								$u_arrive = strtotime($b->arrive);
								$u_depart = strtotime($b->depart);
								$b_interval = $u_depart - $u_arrive;
								$b->days_count = round($b_interval / (24 * 60 * 60) + 1);


								if ($b->price_month == 0 && isset($invoices[$invoice_id]->contract) && $invoices[$invoice_id]->contract->price_month > 0) {
									$b->price_month = $invoices[$invoice_id]->contract->price_month;
								}
                                // airbnb
								if ($b->client_type_id == 2 && $b->price_day > 0) {
									$b->total_price = round($b->price_day * $b->days_count);
								}
								elseif (!empty($b->arrive) && !empty($b->depart) && $b->price_month > 0 && $b->total_price < 1) {
									$price_calculate = $this->contracts->calculate($b->arrive, $b->depart, $b->price_month);
									if (!empty($price_calculate)) {
										$b->total_price = $price_calculate->total; 
									}
								}

                                // Corporate
                                // if ($b->client_group->id == 5) {
                                //    $b->days_count = 30;
                                //    $b->nights_count = 30;
                                //    $b->total_price = $b->price_month;
                                // }


								if ($b->price_day == 0 && $b->price_month > 0) {
									$b->price_day = round(($b->price_month) / 30, 5);
								}

								$free_rental_amount = 0;
								if (!empty($invoices[$invoice_id]->contract->free_rental_amount)) {
                                    $free_rental_amount = $invoices[$invoice_id]->contract->free_rental_amount;
                                }

                                // booking: bed
								if ($b->type == 1) {
									$room_id = $beds_rooms_ids[$b->object_id];
									$apartment_id = $rooms[$room_id]->apartment_id;
								}
                                // booking: apartment
								elseif ($b->type == 2) {
									$apartment_id = $b->object_id;
								}

								if (date('Y-m', strtotime($invoice->date_from.' 00:00:00')) == ($this->params->year.'-'.$this->params->month)) {
									$invoice->month = 'this';
								}
								elseif ($this->params->now_month->getTimestamp() > strtotime($invoice->date_from)) {
									$invoice->month = 'past';
								}
								$apartment_id = $b->apartment_id;
								
								if (!empty($apartment_id) && isset($data->apartments[$apartment_id])) {
									if ($invoice->deposit != 1) {

                                        // paid month
                                        if ($invoice->paid == 1 && substr(trim($invoice->payment_date), 0, 4) != '0000') {
                                            if (strtotime($this->params->now_month_last_day.' 23:59:59') < strtotime($invoice->payment_date)) {
                                                $invoice->paid_m = 'future';
                                            }
                                            elseif ($this->params->now_month->getTimestamp() > strtotime($invoice->payment_date)) {
                                                $invoice->paid_m = 'past';
                                            } else {
                                                $invoice->paid_m = 'this_month';
                                            }
                                        }
                                        elseif ($invoice->paid == 1 && substr(trim($invoice->payment_date), 0, 4) == '0000') {
                                            if ($invoice->month == 'past') {
                                                $invoice->payment_date = $invoice->date_from;
                                                $invoice->payment_date_generated = true;
                                                $invoice->paid_m = 'past';
                                            } else {
                                                $invoice->paid_m = 'this_month';
                                            }
                                        }

                                        if ($invoice->paid == 1 && ($invoice->paid_m == 'this_month') && !empty($invoice->sended_owner)) {
                                            $data->sended_owner_count ++;
                                            if (!empty($invoice->sended_owner_price)) {
                                                $data->sended_owner_sum += $invoice->sended_owner_price;
                                            } else {
                                                $data->sended_owner_sum += $invoice->total_price;
                                            }
                                        }
                                        // inv fix
                                        if (!in_array($invoice->id, [
                                            21260,
                                            21637,
                                            21638,
                                            // 21639
                                        ])) {
                                            if ($invoice->new == true) {

                                                if ($invoice->paid == 1 && $invoice->paid_m == 'this_month' && in_array($invoice->month, ['this', 'past']) && $invoice->child_refund_id == 0) {
                                                    $broker_fee_type = 1;
                                                    if($this->params->selected_house->id == 315) {
                                                        $broker_fee_type = 2;
                                                    }
                                                    $b->broker_fee = $this->beds->getBrokerFee([
                                                        'price' => ($b->total_price - $free_rental_amount),
                                                        'invoice' => $invoice,
                                                        'booking' => $b,
                                                        'house' => $this->params->selected_house,
                                                        'contract' => $invoice->contract ?? false
                                                    ]);


                                                    $b->broker_fee_paid = $b->broker_fee - ($b->broker_fee * $b->brokerfee_discount / 100);
                                                    $b->broker_fee_paid = number_format($b->broker_fee_paid, 2,'.','');

                                                    if ($invoice->month == 'this') {
                                                        $data->apartments[$apartment_id]->broker_fee += $b->broker_fee;
                                                        $data->grand_total->broker_fee += $b->broker_fee;
                                                        $data->apartments[$apartment_id]->broker_fee_paid += $b->broker_fee_paid;
                                                        $data->grand_total->broker_fee_paid += $b->broker_fee_paid;

                                                        $data->summ->broker_fee_paid += $b->broker_fee_paid;
                                                    }


                                                }
                                            }
                                            elseif ($invoice->extension == true) {
                                                if ($invoice->paid == 1 && $invoice->paid_m == 'this_month' && $invoice->month == 'this' && $invoice->child_refund_id == 0) {
                                                    $broker_fee_type = 1;
                                                    if($this->params->selected_house->id == 315) {
                                                        $broker_fee_type = 2;
                                                    }
                                                    $b->broker_fee = $this->beds->getBrokerFee([
                                                        'price' => ($b->total_price - $free_rental_amount),
                                                        'invoice' => $invoice,
                                                        'booking' => $b,
                                                        'house' => $this->params->selected_house,
                                                        'contract' => $invoice->contract ?? false
                                                    ]);


                                                    $b->broker_fee_paid = $b->broker_fee - ($b->broker_fee * $b->brokerfee_discount / 100);
                                                    $b->broker_fee_paid = number_format($b->broker_fee_paid, 2,'.','');

                                                    if ($invoice->month == 'this') {
                                                        $data->apartments[$apartment_id]->broker_fee += $b->broker_fee;
                                                        $data->grand_total->broker_fee += $b->broker_fee;

                                                        $data->apartments[$apartment_id]->broker_fee_paid += $b->broker_fee_paid;
                                                        $data->grand_total->broker_fee_paid += $b->broker_fee_paid;

                                                        $data->summ->broker_fee_paid += $b->broker_fee_paid;
                                                    }


                                                }
                                            }
                                        }
                                        // inv fix (end)

                                        if ($invoice->deposit == 1 || $invoice->month != 'this') {
                                            // booking: bed
                                            if ($b->type == 1) {
                                                $b->room_id = $room_id;
                                                $b->apartment_id = $apartment_id;
                                            }
                                        }
									}

									// Deposits
									if ($invoice->deposit == 1) {
										$data->deposit_invoices[$invoice->id] = $invoice;
										$data->deposit->price += $invoice->total_price;
									}
									elseif ($invoice->month != 'this' &&
										(
											(   strtotime($invoice->date_from) > strtotime($this->params->now_month_last_day.' 23:59:59') // || 
												// (strtotime($invoice->date_to) < $this->params->now_month->getTimestamp())
											)
											//|| ($invoice->paid == 0 && strtotime($invoice->date_to) < $this->params->now_month->getTimestamp())
                                            || (strtotime($invoice->date_to) < $this->params->now_month->getTimestamp())
										)
									) {
										/*if($b->type == 1) // booking: bed
										{
											$invoice->booking->room_id = $room_id;
											$invoice->booking->apartment_id = $apartment_id;
										}*/
										$opi_key = $invoice_id;
										if (!is_null($invoice->date_from)) {
                                            $opi_key = (strtotime($invoice->date_from)) . $invoice_id;
                                        }
										// debt
										if ($invoice->paid == 0) {
											$data->debt_invoices[$opi_key] = $invoice;
											$data->debt_invoices->price += $invoice->total_price;
										}
										// Other period invoices
										else {
											$invoice->show_price = 0;
											$data->other_period_invoices[$opi_key] = $invoice;
											if ($this->params->now_month->getTimestamp() < strtotime($invoice->date_from)) {
												$invoice->show_price = 1;
												$data->other_period_total->price += $invoice->total_price;
											}
											$data->other_period_total->price_paid += $invoice->total_price;

											// if(($invoice->new === true || ($invoice->extension==true && $b->days_count > 180)) && $invoice->paid == 1 && $invoice->child_refund_id == 0)
											if (($invoice->new === true || ($invoice->extension==true)) && $invoice->paid == 1 && $invoice->child_refund_id == 0) {
												$broker_fee_type = 1;
												if ($this->params->selected_house->id == 315) {
                                                    $broker_fee_type = 2;
                                                }
												$b->broker_fee = $this->beds->getBrokerFee([
													'price' => ($b->total_price - $free_rental_amount),
													'invoice' => $invoice,
													'booking' => $b,
													'house' => $this->params->selected_house,
													'contract' => $invoice->contract ?? false
												]);
												$b->broker_fee_paid = $b->broker_fee - ($b->broker_fee * $b->brokerfee_discount / 100);
												$b->broker_fee_paid = number_format($b->broker_fee_paid, 2,'.','');

												$data->other_period_total->broker_fee += $b->broker_fee;
												$data->other_period_total->broker_fee_paid += $b->broker_fee_paid;

												$data->summ->broker_fee_paid += $b->broker_fee_paid;
											}
										}
									} else {
										if ($invoice->month == 'this' && $invoice->paid_m == 'past' && $invoice->paid == 1) {
											$k = date('Y-m-01', strtotime($invoice->payment_date));
											$data->past_paid[$k]->amount ++;
											$data->past_paid[$k]->total_price += $invoice->total_price;
											$data->past_paid_total_price += $invoice->total_price;
										}
										if ($invoice->paid_m == 'past') {
                                            $invoice->total_price = 0;
                                        }
										$adr_count = 1;
										$anr_count = 1;
                                        /*
										if ($invoice->type != 'houseleader') {
											$data->grand_total->adr_sum += $b->price_day;
											$data->grand_total->anr_sum += $b->price_night;
										}
                                        */
                                        // booking: bed
										if ($b->type == 1) {
											$data->beds_invoices[$b->object_id][$invoice_id] = $invoice;
											// $room_id = $beds_rooms_ids[$b->object_id];
											// $apartment_id = $rooms[$room_id]->apartment_id;
											if (count($data->beds_invoices[$b->object_id]) > 1) {
												if (isset($data->apartments[$apartment_id])) {
                                                    $data->apartments[$apartment_id]->rows++;
                                                }
												if (isset($data->apartments[$apartment_id]->rooms[$room_id]) && isset($data->apartments[$apartment_id]->rooms[$room_id]->beds[$b->object_id])) {
													$data->apartments[$apartment_id]->rooms[$room_id]->rows ++;
												}
												if(isset($data->apartments[$apartment_id]->rooms[$room_id]->beds[$b->object_id])) {
													$data->apartments[$apartment_id]->rooms[$room_id]->beds[$b->object_id]->rows = count($data->beds_invoices[$b->object_id]);
												}
											}
											if ($invoice->month == 'this') {
												if ($invoice->paid_m != 'past') {
                                                    $data->apartments[$apartment_id]->total_invices_price += $invoice->total_price;
                                                }
											}
											if ($invoice->paid == 1 && (!isset($invoice->paid_m) || $invoice->paid_m == 'this_month')) {
												if ($invoice->paid_m != 'past') {
                                                    $data->apartments[$apartment_id]->total_invices_paid_price += $invoice->total_price;
                                                }
											}
										}
                                        // booking: apartment
										elseif ($b->type == 2) {
											if ($invoice->month == 'this') {
												if ($invoice->paid_m != 'past') {
                                                    $data->apartments[$b->object_id]->total_invices_price += $invoice->total_price;
                                                }
											}
											if ($invoice->paid == 1) {
												if (!isset($invoice->paid_m) || $invoice->paid_m == 'this_month') {
													if ($invoice->paid_m != 'past') {
                                                        $data->apartments[$b->object_id]->total_invices_paid_price += $invoice->total_price;
                                                    }
												}
											}
											$adr_count = $adr_count * $data->apartments[$b->object_id]->beds_count;
											$anr_count = $anr_count * $data->apartments[$b->object_id]->beds_count;
											$data->apartments_invoices[$b->object_id][$invoice_id] = $invoice;
										}
                                        /*
										if ($invoice->type != 'houseleader') {
											$data->grand_total->adr_count += $adr_count;
											$data->grand_total->anr_count += $anr_count;
										}
                                        */
										if ($invoice->month == 'this') {
											if ($invoice->paid_m != 'past') {
                                                $data->grand_total->price_invoices += $invoice->total_price;
                                                $data->grand_total->sent_invoices_amount ++;
                                            }
										}
										if ($invoice->paid == 1 && (!isset($invoice->paid_m) || $invoice->paid_m == 'this_month')) {
											if ($invoice->paid_m != 'past') {
												$data->grand_total->price_paid_invoices += $invoice->total_price;
												$data->grand_total->paid_invoices_amount ++;
											}
										}
										if (($invoice->paid == 0 || $invoice->paid_m == 'future') && $invoice->month == 'this') {
											$data->grand_total->price_unpaid_invoices += $invoice->total_price;
											$data->grand_total->unpaid_invoices_amount ++;
										}
									}
									if (!empty($b->broker_fee) && ($invoice->new == true || ($invoice->extension == true))) {
										$invoice->isset_broker_fee = true;
									}
									$invoice->booking = $b;
								}
							}
						}
					}
				}
				if (!empty($data->grand_total->adr_count)) {
					$data->grand_total->adr_adv = round($data->grand_total->adr_sum / $data->grand_total->adr_count, 5);
				}
				if (!empty($data->grand_total->anr_count)) {
					$data->grand_total->anr_adv = round($data->grand_total->anr_sum / $data->grand_total->anr_count, 5);
				}

				$data->cost = $this->costs->get_costs([
					'date_from' => $this->params->now_month->format('Y-m-d'),
					'date_to' => $this->params->now_month->format('Y-m-d'),
					'house_id' => $this->params->selected_house->id,
					'type' => 9, // Expenses
					'count' => 1
				]);
				if (empty($data->cost)) {
					$data->cost = 0;
                }
				$data->net_operating_income = ($data->grand_total->price_paid_invoices + ($data->other_period_total->price_paid?round($data->other_period_total->price_paid,2):0)) - $data->cost->price;
			}
		}
		if (!empty($data->past_paid)) {
			krsort($data->past_paid);
		}
		$data->grand_total->total_price_paid_invoices = $data->past_paid_total_price + $data->grand_total->price_paid_invoices;

		// Taxes
		$taxes_params = [
			'house_id' => $this->params->selected_house->id,
			'type' => 11, // taxes
			// 'deposit' => 1,
			// 'paid' => 1,
			'date_created_month' => $this->params->month,
			'date_created_year' => $this->params->year,
			'select_labels' => 1,
			'not_status' => 3,
			'limit' => 1000
		];
		$data->taxes_invoices = $this->orders->get_orders($taxes_params);
		if (!empty($data->taxes_invoices)) {
			$data->taxes_total_price = 0;
			foreach ($data->taxes_invoices as $taxes_invoice) {
				$data->taxes_total_price += $taxes_invoice->total_price;
				if ($taxes_invoice->paid == 1) {
                    $data->taxes_paid_total_price += $taxes_invoice->total_price;
                }
			}					
		}

        // Occupancy
        $occupancy = $this->occupancy->init_occupancy([
            'house_id' => $this->params->selected_house->id,
            'month' => $this->params->month,
            'year'  => $this->params->year,
            'landlord_view' => 1
        ]);

        if (!empty($occupancy)) {
            $data->occupancy = $occupancy->occupancy;
        }

		return $data;
    }
    
    
    
    public function initRR4Data($params = [])
    {
    	$data = new stdClass;
		$beds_rooms_ids = [];
		$rooms = [];

		$data->grand_total = new stdClass;
		// $data->grand_total->price_month_income = 0;
		// $data->grand_total->price_rent_month = 0;
		// $data->grand_total->price_rent_day = 0;
		$data->grand_total->price_invoices = 0;
		$data->grand_total->price_paid_invoices = 0;
		$data->months_summ = [];

		// Hotel
		if ($this->params->selected_house->type == 1) {
			$data->days_units = 'nights';
		}

		// Apartments
		$data->apartments = $this->request->array_to_key($this->beds->get_apartments([
			'house_id' => $this->params->selected_house->id,
			'visible' => 1,
			'sort' => 'name'
		]), 'id');


		// Rooms
		$rooms_ = $this->beds->get_rooms([
			'house_id' => $this->params->selected_house->id,
			'visible' => 1
		]);
		$rooms_apartments_ids = [];
		if (!empty($rooms_)) {
			foreach ($rooms_ as $r) {
				if (!empty($r->apartment_id) && isset($data->apartments[$r->apartment_id])) {
                    if (trim($r->name) != 'Transfer room') {
                        $data->apartments[$r->apartment_id]->rooms[$r->id] = $r;
                        $rooms[$r->id] = $r;
                        $data->apartments[$r->apartment_id]->rows ++;
                        $rooms_apartments_ids[$r->id] = $r->apartment_id;
                    }
				}
			}
			unset($rooms_);
		}

        // Rooms Types
        $rooms_types =$this->request->array_to_key($this->beds->get_rooms_types(), 'id');

		// Beds
		$beds = $this->beds->get_beds(array(
			'room_id' => array_keys($rooms),
			'visible' => 1
		));
		if (!empty($beds)) {
			foreach ($beds as $b) {
				$beds_rooms_ids[$b->id] = $b->room_id;
				$apartment_id = $rooms[$b->room_id]->apartment_id;
				if (isset($data->apartments[$apartment_id]->rooms[$b->room_id]->beds)) {
					$data->apartments[$apartment_id]->rows ++;
				}
				if (isset($data->apartments[$apartment_id]->rooms[$b->room_id])) {
                    $data->apartments[$apartment_id]->rooms[$b->room_id]->rows++;
                    if (isset($rooms_types[$data->apartments[$apartment_id]->rooms[$b->room_id]->type_id])) {
                        $b->room_type = $rooms_types[$data->apartments[$apartment_id]->rooms[$b->room_id]->type_id];
                    }
                    $b->rows = 1;
                    $data->apartments[$apartment_id]->rooms[$b->room_id]->beds[$b->id] = $b;
                    $data->apartments[$apartment_id]->beds[$b->id] = $b;
                    $data->apartments[$apartment_id]->beds_count++;
                    $data->total_beds++;
                }
			}
		}

		$data->apartments_count = 0;
		if (!empty($data->apartments)) {
			foreach ($data->apartments as $a_id=>$a) {
				if (!empty($a->beds)) {
					if (!empty($a->property_price)) {
						$data->apartments[$a_id]->price = $a->property_price;
					}
					$data->apartments_types[$a->type] ++;
					//  Not Stabilized
					if ($a->type != 2) {
						$data->apartments_count ++;
					}
				}	
			}
		}

		foreach ($data->apartments as $apartment_id=>$a) {
			if(substr(trim($a->name), 0, 5) == 'Unit ')
				$a->name = substr(trim($a->name), 5);
			elseif(substr(trim($a->name), 0, 4) == 'Apt ')
				$a->name = substr(trim($a->name), 4);
			
			if($a->house_id == 311) // The Greenpoint House
				$a->name = '107/'.$a->name;
			elseif($a->house_id == 316) // The Greenpoint House (111)
				$a->name = '111/'.$a->name;
			elseif($a->house_id == 317) // The Greenpoint House (115)
				$a->name = '115/'.$a->name;

			if (!empty($a->beds)) {
				$data->total_market_rent += $a->price;
			}
			else {
				unset($data->apartments[$a->id]);
			}
			// stabilized is not counted
			if($a->type != 2) {
				$data->beds_count += $a->beds_count;
			}
		}
		$data->apartnents_count = count($data->apartments);


		// Bookings
		$bookings_ = $this->beds->get_bookings([
			'house_id' => $this->params->selected_house->id,
			'date_from2' => $this->params->now_month->format('Y-m-d'),
			'date_to2' => $this->params->now_month->format('Y-m-t'),
			'status' => 3, // Contract / Invoice
			// 'select_users' => true,
			'sp_group' => true,
			// 'sp_group_from_start' => true,
			'order_by' => 'b.arrive, b.depart'
		]);
		if (!empty($bookings_)) {
			$bookings = [];
			$sp_groups_ids = [];
			foreach ($bookings_ as $b) {
                $b->client_group = $this->users->getClientGroupByType($b->client_type_id);
				if (!empty($b->sp_group_id)) {
					$bookings[$b->sp_group_id] = $b;
					$sp_groups_ids[$b->sp_group_id][$b->id] = $b->id;
					foreach ($b->sp_bookings as $sb) {
						if (($sb->u_arrive <= strtotime($this->params->year.'-'.$this->params->month.'-01') && $sb->u_depart >= strtotime($this->params->now_month_last_day) && isset($data->apartments[$sb->apartment_id])) ||  (isset($data->apartments[$sb->apartment_id]) && !isset($data->apartments[$b->apartment_id]))) {
							$bookings[$b->sp_group_id]->house_id = $sb->house_id;
							$bookings[$b->sp_group_id]->apartment_id = $sb->apartment_id;
							$bookings[$b->sp_group_id]->object_id = $sb->object_id;
						}
					}
				}
				else {
					$bookings[$b->id] = $b;
				}
			}
			$bookings_ids = array_keys($bookings);
			$contracts = $this->contracts->get_contracts([
				'reserv_id' => $bookings_ids,
				'status' => [
					1, // active
					2  // finished
				],
				'limit' => 1000
			]);
			if (!empty($contracts)) {
				foreach ($contracts as $c) {
					if (isset($bookings[$c->reserv_id])) {
						$bookings[$c->reserv_id]->contract = $c;
					}
					if (isset($sp_groups_ids[$c->reserv_id])) {
						foreach ($sp_groups_ids[$c->reserv_id] as $b_id) {
							$bookings[$b_id]->contract = $c;
						}
					}
				}
			}

			$invoices_params = [
				'booking_id' => $bookings_ids,
				'date_month_from_to' => $this->params->month,
				'date_year_from_to' => $this->params->year,
                'type' => [
                    1, // Invoices
                    14 // Parking
                ],
				'deposit' => 0,
				'not_status' => 3,
				'select_users' => true,
				'select_labels' => 1,
				'limit' => 1000,
				'sort_date_from' => true
			];
			$invoices = $this->orders->get_orders($invoices_params);
			if (!empty($invoices)) {
				// Purchases
				$purchases = $this->orders->get_purchases([
					'order_id' => array_keys($invoices)
				]);
				if (!empty($purchases)) {
					foreach($purchases as $p) {
						if (isset($invoices[$p->order_id])) {
							$invoices[$p->order_id]->purchases_total += $p->price;
						}
					}
				}
				foreach ($invoices as $i){
					$invoice_booking = false;
					if (isset($bookings[$i->booking_id])) {
                        $invoice_booking = $bookings[$i->booking_id];
                    }
					$i->order_total = $i->total_price;
					$i->total_price = $i->purchases_total;

					$i->u_date_from = strtotime($i->date_from);
					$i->u_date_to = strtotime($i->date_to);

					$i->nights_count = round(($i->u_date_to - $i->u_date_from) / (24 * 60 * 60));
					$i->days_count = $i->nights_count + 1;


					$i->month_u_date_from = $i->u_date_from;
					$i->month_u_date_to = $i->u_date_to;

					if ($i->month_u_date_from < $this->params->now_month->getTimestamp()) {
						$i->month_u_date_from = $this->params->now_month->getTimestamp();
					}
					if ($i->month_u_date_to > strtotime($this->params->now_month_last_day)) {
						$i->month_u_date_to = strtotime($this->params->now_month_last_day);
					}
					$i->month_nights_count = round(($i->month_u_date_to - $i->month_u_date_from) / (24 * 60 * 60));
					$i->month_days_count = $i->month_nights_count + 1;
					if ($i->month_u_date_to == strtotime($this->params->now_month_last_day) && strtotime($invoice_booking->depart) > $i->month_u_date_to && ($i->u_date_to > $i->month_u_date_to)) {
						$i->month_nights_count ++;
					}

					$i->nights_koef = $i->month_nights_count / $i->nights_count;
					$i->days_koef = $i->month_days_count / $i->days_count;

					$i->nights_total_price = round($i->total_price * $i->nights_koef, 2);
					$i->days_total_price = round($i->total_price * $i->days_koef, 2);

					$i->nights_paid_price = round($i->order_total * $i->nights_koef, 2);
					$i->days_paid_price = round($i->order_total * $i->days_koef, 2);

					// discount $
					if ($i->discount_type == 2) {
						$i->discount_sum = $i->discount;
                        $i->discount_sum_left = $i->discount;
					} 
					// discount %
					else  {
						$i->discount_sum = round(($i->total_price * $i->discount / 100), 2);
					}

					$i->nights_discount_sum = round($i->discount_sum * $i->nights_koef, 2);
					$i->days_discount_sum = round($i->discount_sum * $i->days_koef, 2);

					

					$i->nights_total_price -= $i->nights_discount_sum;
					$i->days_total_price -= $i->days_discount_sum;

					$i->nights_paid_price += $i->nights_discount_sum;
					$i->days_paid_price += $i->days_discount_sum;


					if ($i->paid) {
						$month_key = date('Y-m-01', strtotime($i->payment_date));
						$data->months_summ[$month_key]->count ++;
						$data->months_summ[$month_key]->sum += round($data->days_units == 'nights' ? $i->nights_paid_price : $i->days_paid_price, 2);

						$data->months_summ[$month_key]->month_nights_count += $i->month_nights_count;
						

						$data->months_summ[$month_key]->month_days_count += $i->month_days_count;
				
						$data->months_summ_total += $data->days_units == 'nights' ? $i->nights_paid_price : $i->days_paid_price;
					}
					

					if (!empty($i->users)) {
						$i_users_names = [];
                        $i_users = [];
						foreach ($i->users as $u) {
							$i_users_names[$u->id] = $u->name;
                            $i_users[$u->id] = (object) [
                                'id' => $u->id,
                                'name' => $u->name
                            ];
						}
						$i->users_names = implode(', ', $i_users_names);
                        $i->users = $i_users;
					}
				}

				// Purchases
				if (!empty($purchases)) {

                    foreach ($purchases as $p) {
                        if (isset($invoices[$p->order_id])) {
                            $p->type = 'default';
                            if (stripos($p->product_name, 'Utility Allowance Fee') !== false || stripos($p->product_name, 'Telecom fee') !== false || stripos($p->product_name, 'Telecom') !== false) {
                                $p->type = 'utilities';
                            }
                            if ($p->type == 'default') {
                                $invoices[$p->order_id]->rent_price += $p->price;
                            }
                        }
                    }


					foreach ($purchases as $p) {
						if (isset($invoices[$p->order_id])) {
							// Purchases with discount
                            if ($invoices[$p->order_id]->discount > 0) {
                                // discount $
                                if ($invoices[$p->order_id]->discount_type == 2) {
                                    if ($p->type == 'default') {
                                        if ($p->price <= $invoices[$p->order_id]->discount_sum_left) {
                                            $invoices[$p->order_id]->discount_sum_left -= $p->price;
                                            $p->price = 0;
                                        } else {
                                            $p->price -= $invoices[$p->order_id]->discount_sum_left;
                                            $invoices[$p->order_id]->discount_sum_left = 0;
                                        }
                                    }
                                    elseif ($p->type == 'utilities') {
                                        // if ($invoices[$p->order_id]->discount > $invoices[$p->order_id]->rent_price) {
                                        //     $p->price = $p->price - ($invoices[$p->order_id]->discount - $invoices[$p->order_id]->rent_price);
                                        // }
                                        if ($p->price <= $invoices[$p->order_id]->discount_sum_left) {
                                            $invoices[$p->order_id]->discount_sum_left -= $p->price;
                                            $p->price = 0;
                                        } else {
                                            $p->price -= $invoices[$p->order_id]->discount_sum_left;
                                            $invoices[$p->order_id]->discount_sum_left = 0;
                                        }
                                        if ($p->price < 0) {
                                            $p->price = 0;
                                        }
                                    }
                                }
                                // discount %
                                else  {
                                    $p->price = $p->price * (100 - $invoices[$p->order_id]->discount) / 100;
                                }
                            }
                            $p->price = round($p->price, 2);
							
							$p->month_nights_price = round($p->price * $invoices[$p->order_id]->nights_koef, 2);
							$p->month_days_price = round($p->price * $invoices[$p->order_id]->days_koef, 2);

							if ($p->type == 'utilities') {
								$invoices[$p->order_id]->purchases_utilites[$p->id] = $p;
								$invoices[$p->order_id]->purchases_utilites_price += $p->price;
								$invoices[$p->order_id]->purchases_utilites_nights_price += $p->month_nights_price;
								$invoices[$p->order_id]->purchases_utilites_days_price += $p->month_days_price;
							} else {
								$invoices[$p->order_id]->purchases[$p->id] = $p;
								$invoices[$p->order_id]->purchases_price += $p->price;
								$invoices[$p->order_id]->purchases_nights_price += $p->month_nights_price;
								$invoices[$p->order_id]->purchases_days_price += $p->month_days_price;
							}
						}
					}
				}
				foreach ($invoices as $i) {
					if (isset($bookings[$i->booking_id])) {
						// Apartment
						if ($bookings[$i->booking_id]->type == 2) {
							$beds_count = $data->apartments[$bookings[$i->booking_id]->object_id]->beds_count;
							$i->purchases_nights_price = round($i->purchases_nights_price / $beds_count, 2);
							$i->purchases_days_price = round($i->purchases_days_price / $beds_count, 2);
							$i->purchases_utilites_nights_price = round($i->purchases_utilites_nights_price / $beds_count, 2);
							$i->purchases_utilites_days_price = round($i->purchases_utilites_days_price / $beds_count, 2);
							$i->nights_total_price = round($i->nights_total_price / $beds_count, 2);
							$i->days_total_price = round($i->days_total_price / $beds_count, 2);
							$i->nights_paid_price = round($i->nights_paid_price / $beds_count, 2);
							$i->days_paid_price = round($i->days_paid_price / $beds_count, 3); // 3 - for correct rounding
							$i->nights_discount_sum = round($i->nights_discount_sum / $beds_count, 2);
							$i->days_discount_sum = round($i->days_discount_sum / $beds_count, 2);
						}
						$bookings[$i->booking_id]->invoices[$i->id] = $i;
					}
				}
			}

			$leased_rent_discount = [];
			$leased_rent = [];
			$data->occupied_beds_ids = [];
			foreach ($bookings as $k=>$b) {
				if (empty($b->invoices)) {
					unset($bookings[$k]);
				} else {
					$b->u_arrive = strtotime($b->arrive);
		            $b->u_depart = strtotime($b->depart);
		            $b_interval = $b->u_depart - $b->u_arrive;
		            $b->nights_count =  round($b_interval / (24 * 60 * 60));
					$b->days_count = $b->nights_count + 1;

					if ($b->u_depart >= strtotime($this->params->now_month_last_day)) {
						$b->rr_status = 'Current';
					} else {
						$b->rr_status = 'Alumni';
					}
					// airbnb
					if ($b->client_type_id == 2 && $b->price_day > 0) {
						$b->total_price = round($b->price_day * $b->days_count);
						$b->leased_rent = round($b->price_day * 30);
					} else  {
						if ($b->price_day > 0) {
							$b_total_price = round($b->price_day * $b->days_count);
							$c_total_price = $b->total_price / $b_total_price;
							if ($c_total_price > 1.05 || $c_total_price < 0.95) {
								$b->total_price = $b_total_price;
							}
						}
						$b->leased_rent = $b->price_month;
						if (isset($b->contract) && $b->contract->price_month > 0) {
							$b->leased_rent = $b->contract->price_month;
							if ($b->contract->price_utilites > 0 && strtotime($this->params->year.'-'.$this->params->month.'-01') >= strtotime('2022-04-01')) {
								$b->leased_rent += $b->contract->price_utilites;
							}
						}
					}
					if ($b->total_price == 0 && $b->price_month > 0) {
						$bcalc = $this->contracts->calculate($b->arrive, $b->depart, $b->price_month);
						$b->total_price = $bcalc->total;
					}


					// booking bed
					if ($b->type == 1) {
						$room_id = $beds_rooms_ids[$b->object_id];
						if (isset($rooms[$room_id]) && !empty($rooms[$room_id]->apartment_id) && $rooms[$room_id]->apartment_id != $b->apartment_id) {
							$b->apartment_id = $rooms[$room_id]->apartment_id;
						}
					}
					// booking apartment
					elseif ($b->type == 2) {
						$b->leased_rent = round($b->leased_rent / $data->apartments[$b->object_id]->beds_count, 2);
					}

					// booking bed
					if ($b->type == 1) {
						$apartment_id = $b->apartment_id;
						if (isset($data->apartments[$apartment_id])) {	
							// считаем 1 раз занятую bed && not stabilized apt
							if (!isset($data->apartments[$apartment_id]->beds[$b->object_id]->bookings) && $data->apartments[$apartment_id]->type != 2) {
								$data->occupied_beds_ids[$b->object_id] = $b->object_id;
							}
							$data->apartments[$apartment_id]->beds[$b->object_id]->bookings[$b->id] = $b;
							foreach ($b->invoices as $i) {
								// - discount sum
								$b->leased_rent -= ($data->days_units == 'nights' ? $i->nights_discount_sum : $i->days_discount_sum);
				
								// Utilites
								// if ((empty($b->contract) || $b->contract->price_utilites < 1) && $b->client_group->id != 5) {
                                if (empty($b->contract) || $b->contract->price_utilites < 1) {
									$utilites_price_month = $i->purchases_utilites_days_price / $i->days_count * $this->params->days_in_month;
									$b->leased_rent += $i->purchases_utilites_days_price / $i->days_count * $this->params->days_in_month;
								}
								if (!isset($data->apartments[$apartment_id]->beds[$b->object_id]->current_invoice) || $data->apartments[$apartment_id]->beds[$b->object_id]->current_invoice->u_date_to < $i->u_date_to) {
									$data->apartments[$apartment_id]->beds[$b->object_id]->current_invoice = $i;
								}
								if ($data->days_units == 'nights') {
									$data->apartments[$apartment_id]->rent_prorated += $i->nights_total_price;
									$data->total_rent_prorated += $i->nights_total_price;
									if ($i->paid == 1) {
										$data->apartments[$apartment_id]->paid_prorated += $i->nights_paid_price;
										$data->total_paid_prorated += $i->nights_paid_price;
										$data->apartments[$apartment_id]->paid_utilites += $i->purchases_utilites_nights_price;
										$data->total_paid_utilites += $i->purchases_utilites_nights_price;
									}
									$data->apartments[$apartment_id]->discount_sum += $i->nights_discount_sum;
									$data->total_discount_sum += $i->nights_discount_sum;
									// $b->leased_rent += $i->purchases_utilites_nights_price;
								} else {
									$data->apartments[$apartment_id]->rent_prorated += $i->days_total_price;
									$data->total_rent_prorated += $i->days_total_price;
									if ($i->paid == 1) {
										$data->apartments[$apartment_id]->paid_prorated += $i->days_paid_price;
										$data->total_paid_prorated += $i->days_paid_price;
										$data->apartments[$apartment_id]->paid_utilites += $i->purchases_utilites_days_price;
										$data->total_paid_utilites += $i->purchases_utilites_days_price;
									}
									$data->apartments[$apartment_id]->discount_sum += $i->days_discount_sum;
									$data->total_discount_sum += $i->days_discount_sum;
									// $b->leased_rent += $i->purchases_utilites_days_price;
								}
							}
						}
					}
					// booking apartment
					elseif ($b->type == 2) {
						$apartment_id = $b->object_id;
						if (isset($data->apartments[$apartment_id]->beds)) {
							foreach ($data->apartments[$apartment_id]->beds as $k=>$bed) {
								// считаем 1 раз занятую bed && not stabilized apt
								if (!isset($beds->bookings) && $data->apartments[$apartment_id]->type != 2) {
									$data->occupied_beds_ids[$bed->id] = $bed->id;
								}
								$data->apartments[$apartment_id]->beds[$k]->bookings[$b->id] = $b;
								foreach ($b->invoices as $i) {

									// - discount sum
									$b->leased_ren-= round(($data->days_units == 'nights' ? $i->nights_discount_sum : $i->days_discount_sum) / $data->apartments[$apartment_id]->beds_count, 2);

									if (!isset($data->apartments[$apartment_id]->beds[$k]->current_invoice) || $data->apartments[$apartment_id]->beds[$k]->current_invoice->u_date_to < $i->u_date_to) {
										$data->apartments[$apartment_id]->beds[$k]->current_invoice = $i;
									}
									if ($data->days_units == 'nights') {
										$data->apartments[$apartment_id]->rent_prorated += $i->nights_total_price;
										$data->total_rent_prorated += $i->nights_total_price;
										if ($i->paid == 1) {
											$data->apartments[$apartment_id]->paid_prorated += $i->nights_paid_price;
											$data->total_paid_prorated += $i->nights_paid_price;
											$data->apartments[$apartment_id]->paid_utilites += $i->purchases_utilites_nights_price;
											$data->total_paid_utilites += $i->purchases_utilites_nights_price;
										}
										$data->apartments[$apartment_id]->discount_sum += $i->nights_discount_sum;
										$data->total_discount_sum += $i->nights_discount_sum;
										// $b->leased_rent += $i->purchases_utilites_nights_price;
									} else {
										$data->apartments[$apartment_id]->rent_prorated += $i->days_total_price;
										$data->total_rent_prorated += $i->days_total_price;
										if ($i->paid == 1) {
											$data->apartments[$apartment_id]->paid_prorated += $i->days_paid_price;
											$data->total_paid_prorated += $i->days_paid_price;
											$data->apartments[$apartment_id]->paid_utilites += $i->purchases_utilites_days_price;
											$data->total_paid_utilites += $i->purchases_utilites_days_price;
										}
										$data->apartments[$apartment_id]->discount_sum += $i->days_discount_sum;
										$data->total_discount_sum += $i->days_discount_sum;
										// $b->leased_rent += $i->purchases_utilites_days_price;
									}
								}
							}
						}
					}
					$data->occupied_apartnents_ids[$apartment_id] = $apartment_id;

					// booking bed
					if ($b->type == 1)  {
						if(empty($leased_rent[$b->apartment_id][$b->object_id]) || $leased_rent[$b->apartment_id][$b->object_id]->status > $b->rr_status_code || ($leased_rent[$b->apartment_id][$b->object_id]->status == $b->rr_status_code && $leased_rent[$b->apartment_id][$b->object_id]->booking_u_arrive < $b->u_arrive)) {
							if (!isset($leased_rent[$b->apartment_id][$b->object_id])) {
								$leased_rent[$b->apartment_id][$b->object_id] = new stdClass;
							}
							$leased_rent[$b->apartment_id][$b->object_id]->status = $b->rr_status_code;
							$leased_rent[$b->apartment_id][$b->object_id]->booking_id = $b->id;
							$leased_rent[$b->apartment_id][$b->object_id]->booking_type = $b->type;
							$leased_rent[$b->apartment_id][$b->object_id]->booking_u_arrive = $b->u_arrive;
							$leased_rent[$b->apartment_id][$b->object_id]->price = $b->leased_rent;
						} else {
							$leased_rent[$b->apartment_id][$b->object_id]->error = 1;
						}
					}
					// booking apartment
					elseif ($b->type == 2) {
						foreach ($data->apartments[$b->object_id]->beds as $bed) {
							if (empty($leased_rent[$b->object_id][$bed->id]) || $leased_rent[$b->object_id][$bed->id]->status > $b->rr_status_code || ($leased_rent[$b->object_id][$bed->id]->status == $b->rr_status_code && $leased_rent[$b->object_id][$bed->id]->booking_u_arrive < $b->u_arrive)) {
								$leased_rent[$b->object_id][$bed->id]->status = $b->rr_status_code;
								$leased_rent[$b->object_id][$bed->id]->booking_id = $b->id;
								$leased_rent[$b->object_id][$bed->id]->booking_type = $b->type;
								$leased_rent[$b->object_id][$bed->id]->booking_u_arrive = $b->u_arrive;
								$leased_rent[$b->object_id][$bed->id]->price = $b->leased_rent;
							}
						}
					}
				}
			}
			if (!empty($leased_rent)) {
				foreach ($leased_rent as $a_id=>$lss) {
					foreach ($lss as $ls) {
                        if (isset($data->apartments[$a_id])) {
                            $data->apartments[$a_id]->leased_rent += $ls->price;
                            $data->total_leased_rent += $ls->price;
                        }
					}
				}
			}

			ksort($data->months_summ);


			$data->occupied_beds = count($data->occupied_beds_ids);

			// $data->occupied_beds_pr = ceil($data->occupied_beds / $data->beds_count * 100);
            $occupancy = $this->occupancy->init_occupancy([
                'house_id' => $this->params->selected_house->id,
                'month' => $this->params->month,
                'year'  => $this->params->year,
                'landlord_view' => 1
            ]);
            $data->occupied_beds_pr = $occupancy->occupancy;

			if($data->occupied_beds_pr > 100)
				$data->occupied_beds_pr = 100;
			if($data->occupied_beds_pr < 0)
				$data->occupied_beds_pr = 0;
			$data->occupied_apartnents = count($data->occupied_apartnents_ids);
			$data->occupied_apartnents_pr = ceil($data->occupied_apartnents / $data->apartments_count * 100);
			if($data->occupied_apartnents_pr > 100) {
				$data->occupied_apartnents_pr = 100;
			}
			if ($data->occupied_apartnents_pr < 0) {
				$data->occupied_apartnents_pr = 0;
			}
			
			$data->leased_rent = $leased_rent;
		}
		return $data;
    }
    
    public function initRR5Data($params = [])
    {	
    	$data = new stdClass;
    	$beds_rooms_ids = [];
    	$data->total_beds = 0;

    	$data->total_market_rent = 0;
    	$data->total_lease_amount = 0;
		$rooms = [];

        $selected_house = $this->params->selected_house->id;

        if (!empty($selected_house)) {
            $params['house_id'] = $this->params->selected_house->id;

            // Apartments
            $data->apartments = $this->beds->get_apartments([
                'house_id' => $this->params->selected_house->id,
                'visible' => 1
            ]);
            $data->apartments = $this->request->array_to_key($data->apartments, 'id');


				
            
            //Leases
            if ($data->leases = $this->contracts->get_leases($params)) {
                $tenants_ids = [];
                foreach($data->leases as $l)
                {
                    if (!empty($l->data)) {
                        foreach($l->data as $d) {
                            if (!empty($d->user_id)) {
                                $tenants_ids[$d->user_id] = $d->user_id;
                            }
                        }
                    }

                    $data->apartments[$l->apartment_id]->leases[$l->active_status] = $l;
                    if (!isset($data->apartments[$l->apartment_id]->lease) || ($data->apartments[$l->apartment_id]->lease->active_status == 'Future' && $l->active_status == 'Active')) {
                    	$data->apartments[$l->apartment_id]->lease = $l;
                    }
            	}

            	if (!empty($tenants_ids)) {
	                $data->tenants = $this->users->get_users([
	                    'id' => $tenants_ids,
	                    'limit' => count($tenants_ids)
	                ]);
	            }
	            $data->apartments_types = $this->beds->apartment_types;
	            foreach($data->apartments as $apartment)
                {
                	$data->total_beds += $apartment->bed;
                	$data->apartments_types[$apartment->type]['count'] ++;
                	if(isset($apartment->lease)){
                		$data->total_market_rent += $apartment->property_price;
                		$data->total_lease_amount += $apartment->lease->price;

                		if (isset($data->apartments_types[$apartment->type])) {
                			$data->apartments_types[$apartment->type]['market_rent'] += $apartment->property_price;
                			$data->apartments_types[$apartment->type]['lease_amount'] += $apartment->lease->price;
                		}
                	}
                	if(substr(trim($apartment->name), 0, 5) == 'Unit ')
						$apartment->name = substr(trim($apartment->name), 5);
					elseif(substr(trim($apartment->name), 0, 4) == 'Apt ')
							$apartment->name = substr(trim($apartment->name), 4);
					
					if($apartment->house_id == 311) // The Greenpoint House
						$apartment->name = '107-'.$apartment->name;
					elseif($apartment->house_id == 316) // The Greenpoint House (111)
						$apartment->name = '111-'.$apartment->name;
					elseif($apartment->house_id == 317) // The Greenpoint House (115)
						$apartment->name = '115-'.$apartment->name;
                }
            }
        }
        
	 	return $data;
    }

    public function initRR6Data($params = [])
    {
        
    	$data = new stdClass();

		// Invoices / Bookings
		$orders_params = [
		    'house_id' => $this->params->selected_house->id,
		    'paid' => 1,
		    'paid_month' => $this->params->month,
		    'paid_year' => $this->params->year,
		    'type' => [
		        1, // Invoices
		        14 // Parking
		    ],
		    'deposit' => 0,
		    'not_status' => 3,
		    'select_labels' => 1,
		    'limit' => 3000,
		    'sort_date_from' => true,
		    'first_inv_in_book' => true
		];

		$data->invoices = $this->orders->get_orders($orders_params);

		if (isset($data->invoices)) {
			$bookingsIds = [];
			$bookingsInvoicesIds = [];
			$contractsIds = [];
			$bedsIds = [];
			$usersIds = [];
			$usersBookings = [];

			$apartments = $this->request->array_to_key($this->beds->get_apartments([
		        'house_id' => $this->params->selected_house->id,
		        'visible' => 1,
		        'sort' => 'name',
		    ]), 'id');

			foreach ($data->invoices as $i) {
				if (!empty($i->booking_id)) {
					$bookingsInvoicesIds[$i->booking_id] = $i->id;
					$bookingsIds[$i->booking_id] = $i->booking_id;
				}
				if (!empty($i->contract_id)) {
					$contractsIds[$i->contract_id] = $i->contract_id;
				}
			}

			if (!empty($bookingsIds)) {
				$bookings = $this->beds->get_bookings([
		            'id' => $bookingsIds,
		            'select_users' => true,
		            'sp_group' => true,
		            //'sp_group_from_start' => true,
	            ]);
	            if (!empty($bookings)) {
	            	foreach($bookings as $b) {
	            		$b->u_invoice_first_payment_date = strtotime($data->invoices[$bookingsInvoicesIds[$b->id]]->payment_date);
	            		// Type 1 = bed
	            		if ($b->type == 1) {
	            			$bedsIds[$b->object_id] = $b->object_id; 
	            		}
	            		if (!empty($b->users)) {
	                        $booking_user = current($b->users);
	                        $usersIds[$booking_user->id] = $booking_user->id;
	                        $usersBookings[$booking_user->id] = $b->id;
	                    }
	                    $b->u_arrive = strtotime($b->arrive);
		                $b->u_depart = strtotime($b->depart);
		           		$b->daysCount = round(($b->u_depart - $b->u_arrive) / (24 * 60 * 60) + 1);
	                    $b->date_from = $b->arrive;
	                    $b->date_to = $b->depart;
	                    $b->feePrevDays = 0;
	                    $b->feePrevSum = 0;
	            	}
	            }
	            if (!empty($bedsIds)) {
		            $beds = $this->request->array_to_key($this->beds->get_beds([
		            	'id' => $bedsIds
		            ]), 'id');
		        }
	            $contracts = $this->contracts->get_contracts([
					'id' => $contractsIds,
					'limit' => count($contractsIds)
				]);
			}



			$allBookings = $this->beds->get_bookings([
				'house_id' => $this->params->selected_house->id,
				'user_id' => $usersIds,
				'status' => 3, // Confirmed
				'sp_group' => true,
				'select_users' => true,
				'first_inv_in_book' => true,
				'order_by' => 'b.arrive',
				// 'print_query' => 1
			]);
			
			
		    if (!empty($allBookings)) {

		        $prev_booking = [];
		        $interval_off = 2 * (60 * 60 * 24);
		        foreach ($allBookings as $booking) {
		        	$booking_user = current($booking->users);
		        	$booking->user_id = $booking_user->id;
		            $booking_id = $usersBookings[$booking->user_id];
		            if (isset($bookings[$booking_id]) && $bookings[$booking_id]->type == $booking->type) {

		                $booking->u_arrive = strtotime($booking->arrive);
		                $booking->u_depart = strtotime($booking->depart);
		                $booking->u_invoice_first_payment_date = strtotime($booking->invoice_first_payment_date);
		                
		                $booking->daysCount = round(($booking->u_depart - $booking->u_arrive) / (24 * 60 * 60) + 1);

		                if (!isset($prev_booking[$booking->user_id])) {
		                	$bookings[$booking_id]->bookings_ids_tmp[$booking->u_invoice_first_payment_date] = $booking->id;
		                    $bookings[$booking_id]->u_date_from_tmp = $booking->u_arrive;
		                    $bookings[$booking_id]->u_date_to_tmp = $booking->u_depart;
		                    $prev_booking[$booking->user_id] = $booking;
		                }
		                elseif (($booking->u_arrive - $prev_booking[$booking->user_id]->u_depart) < $interval_off) {
		                	$bookings[$booking_id]->bookings_ids_tmp[$booking->u_invoice_first_payment_date] = $booking->id;
		                    $bookings[$booking_id]->u_date_to_tmp = $booking->u_depart;
		                    $prev_booking[$booking->user_id] = $booking;
		                }
		                elseif ($booking->u_arrive <= $bookings[$booking_id]->u_arrive) {
		                	$bookings[$booking_id]->bookings_ids_tmp[$booking->u_invoice_first_payment_date] = $booking->id;
		                    $bookings[$booking_id]->u_date_from_tmp = $booking->u_arrive;
		                    $bookings[$booking_id]->u_date_to_tmp = $booking->u_depart;
		                    $prev_booking[$booking->user_id] = $booking;
		                }

		                if (isset($bookings[$booking_id]->u_date_from_tmp) && isset($bookings[$booking_id]->u_date_to_tmp)) {
		                	$bookings[$booking_id]->date_from_tmp = date('Y-m-d', $bookings[$booking_id]->u_date_from_tmp);
		                    $bookings[$booking_id]->date_to_tmp = date('Y-m-d', $bookings[$booking_id]->u_date_to_tmp);
		                    if (
		                    	$bookings[$booking_id]->u_date_from_tmp <= $bookings[$booking_id]->u_arrive && 
		                    	$bookings[$booking_id]->u_date_to_tmp >= $bookings[$booking_id]->u_depart
		                    ) {
		                    	$bookings[$booking_id]->bookings_ids = $bookings[$booking_id]->bookings_ids_tmp;
		                        $bookings[$booking_id]->date_from = date('Y-m-d', $bookings[$booking_id]->u_date_from_tmp);
		                        $bookings[$booking_id]->date_to = date('Y-m-d', $bookings[$booking_id]->u_date_to_tmp);
		                    }
		                }
		            }
		        }
		        foreach ($bookings as $booking) {
		        	if (isset($booking->bookings_ids)) {
		        		ksort($booking->bookings_ids);
		        		foreach ($booking->bookings_ids as $b_id) {
		        			$pBooking = $allBookings[$b_id];
		        			if ($pBooking->u_invoice_first_payment_date < $booking->u_invoice_first_payment_date) {
		        				$booking->feePrevDays += $pBooking->daysCount;
                    			$booking->feePrevSumm += $this->beds->getBrokerFee([
				                    'daysCount' => $pBooking->daysCount,
				                    'price' => $pBooking->total_price + $pBooking->price_utility_total,
				                    'invoice' => true,
				                    'booking' => $booking,
				                    'house' => $this->params->selected_house
				                ]);
		        			}
		        		}
		        	}
		        }
		    }

			foreach ($data->invoices as $i) {
				$feeDaysCount = 0;
				
				if (!empty($i->booking_id) && isset($bookings[$i->booking_id])) {
					$i->booking = $bookings[$i->booking_id];
					$i->total_amount = $i->booking->total_price;
					$i->monthly_amount = $i->booking->price_month;

					
					if ($i->booking->type == 1 && isset($beds[$i->booking->object_id])) {
						$i->bed = $beds[$i->booking->object_id];
					}
					
					if (isset($apartments[$i->booking->apartment_id])) {
						$i->apartment = $apartments[$i->booking->apartment_id];
					}

					
				}
				if (!empty($i->contract_id) && isset($contracts[$i->contract_id])) {
					$i->contract = $contracts[$i->contract_id];
					$i->total_amount = $i->contract->total_price;
					$i->monthly_amount = $i->contract->price_month;
					
					if (!empty($i->contract->free_rental_amount)) {
                        $i->total_amount -= $i->contract->free_rental_amount;
                    }
				}

				$priceForFee = $i->total_amount;
				if ($i->contract) {
					$priceForFee += $i->contract->price_utility_total;
				}

				if (isset($i->booking)) {
					$feeDaysCount = $i->booking->daysCount;
					if (!empty($i->booking->feePrevDays)) {
						$feeDaysRem = $this->beds->brokerFeeMaxPeriod - $i->booking->feePrevDays;
						if ($feeDaysRem < 0) {
							$feeDaysRem = 0;
						}
						if ($feeDaysRem < $feeDaysCount) {
							$feeDaysCount = $feeDaysRem;
						}
						$feeDaysCount = min($this->beds->brokerFeeMaxPeriod, $feeDaysCount);
						$priceForFee = $feeDaysCount / $i->booking->daysCount * $priceForFee;
					}
					$i->feeDaysCount = $feeDaysCount;
				}

				if (!empty($i->booking_id) && isset($bookings[$i->booking_id])) {
					$i->total_amount = $i->booking->total_price + $i->booking->price_utility_total;
					$i->monthly_amount = $i->booking->price_month + $i->contract->price_utilites;
				}
				if (!empty($i->contract_id) && isset($contracts[$i->contract_id])) {
					$i->total_amount = $i->contract->total_price + $i->booking->price_utility_total;
					$i->monthly_amount = $i->contract->price_month + $i->contract->price_utilites;
				}

                $brokerFeeParams = [
                    'daysCount' => $feeDaysCount,
                    'price' => $priceForFee,
                    'invoice' => $i,
                    'booking' => $i->booking,
                    'house' => $this->params->selected_house,
                    'contract' => $i->contract ?? false
                ];

                $i->broker_fee = 0;

                if ($feeDaysCount > 0) {
                    $i->broker_fee = $this->beds->getBrokerFee($brokerFeeParams);
                    $i->broker_fee_formula = $this->beds->getBrokerFee(array_merge($brokerFeeParams, ['getFormula' => true]));
                }

				if (empty($i->broker_fee)) {
					unset($data->invoices[$i->id]);
				}
				$data->total_broker_fee += $i->broker_fee;

			}

			usort($data->invoices, function ($invoices1, $invoices2) {
	            // Sort by field apartment->name
	            $invoicesApartmentNameComparison = strcmp($invoices1->apartment->name, $invoices2->apartment->name);
	            if ($invoicesApartmentNameComparison !== 0) {
	                return $invoicesApartmentNameComparison;
	            }
	            // Sort by field bed->name
	            return strcmp($invoices1->bed->name, $invoices2->bed->name);
        	});
		}

		return $data;
    }

}
