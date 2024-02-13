<?php

require_once('Backend.php');

class HouseStats extends Backend
{
	private $params;
	private $data;

	public function __construct()
	{
		$this->params = new stdClass;
	}


    private function nanTo0 ($v)
    {
        return is_nan($v) ? 0 : $v;
    }

    private function FromTo ($u_from, $u_to, $added, $shutdown)
    {
        $result = new stdClass;
        $result->u_from = $u_from;
        $result->u_to = $u_to;
        if (!is_null($added) && $u_from < strtotime($added)) {
            $result->u_from = strtotime($added);
        }
        if (!is_null($shutdown) && $u_to > strtotime($shutdown)) {
            $result->u_to = strtotime($shutdown);
        }
        return $result;
    }
	
	
	public function getHouses(array $params)
	{
		$selected_house_id = $params['selected_house_id'];
		$landlord = false;

        if (isset($params['view'])) {
            $this->params->view = $params['view'];
        }

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
//                    if ($ch->id == 311) {
//                    	$ch->name = 'The Greenpoint House';
//                    }
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
//            if (in_array($this->params->selected_house->id, [334, 337])) {
//                $this->params->selected_house->id = [
//                    334,  // The Williamsburg House
//                    337   // The Williamsburg House (165 N 5th Street)
//                ];
//            }
            // The Greenpoint House
//            elseif (in_array($this->params->selected_house->id, [311, 316, 317])) {
//                $this->params->selected_house->id = [
//                    311,  // The Greenpoint House
//                    316,  // The Greenpoint House (111)
//                    317   // The Greenpoint House (115)
//                ];
//            }
            // 340 - Cassa Studio
			// 366 - Cassa Studios - 9th Ave Hotel
//			elseif (in_array($this->params->selected_house->id, [340, 366])) {
//				$this->params->is_house_cassa = true;
//				if ($this->params->selected_house->id == 366) {
//					$this->params->selected_house->id = [
//						$this->params->selected_house->id,
//						340
//					];
//				}
//			}
			
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
        $this->params->strtotime_now = strtotime('now');
		$strtotime_lastmonth = strtotime('- 1 month');
		
		$this->params->selected_date = date('Y-m-d', $this->params->strtotime_now);

		$this->params->month = $params['month'];
		$this->params->year = $params['year'];
		
		$this->params->now_month = new DateTime($this->params->year.'-'.$this->params->month.'-01');

		$this->params->next_month = new DateTime($this->params->year.'-'.$this->params->month.'-01');
		$this->params->next_month->modify('+1 month');

		$this->params->prev_month = new DateTime($this->params->year.'-'.$this->params->month.'-01');
		$this->params->prev_month->modify('-1 month');

        $this->params->s1now = strtotime(date('Y-m-01', $this->params->strtotime_now));

		$this->params->days_in_month = date("t", strtotime($this->params->year.'-'.$this->params->month.'-01'));
		$this->params->now_month_last_day = $this->params->year.'-'.$this->params->month.'-'.$this->params->days_in_month;

        $this->params->u_from = $this->params->now_month->getTimestamp();
        // $this->params->u_to = strtotime($this->params->now_month_last_day);
        $this->params->u_to = strtotime($this->params->now_month_last_day) + 86399;
        $this->params->u_interval = $this->params->u_to - $this->params->u_from;


        if (strtotime($this->params->year.'-'.$this->params->month.'-01') > strtotime(date("Y-m", $this->params->strtotime_now).'-01')) {
			$this->params->hide_debt = true;
		}
		$this->params->rent_roll_id = $this->params->year.$this->params->month.$this->params->selected_house->main_id;

        if ($this->params->s1now == $this->params->now_month->getTimestamp()) {
            $this->params->selected_month = 'now';
        }
		if ($params['view'] == 'landlord' && (int)$this->params->year < 2021 && (int)$this->params->month < 12) {
			unset($this->params->prev_month);
		}
	}


	public function getStats($params = [])
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



        // Move In/Out
        $bookings = $this->beds->get_bookings([
            'house_id' => $this->params->selected_house->id,
            'status' => 3,
            'client_type_not_id' => 5, // // Not HouseLeaders
            'date_from2' => $this->params->year.'-'.$this->params->month.'-01',
            'date_to2' => $this->params->now_month_last_day,
            'order_by' => 'b.arrive',
            'sp_group' => true
        ]);

        $leasings = [];
        if (!empty($bookings)) {
            $b_ids = [];
            // for ext
            $groups_ids = [];
            // Contracts End
// 			$this->params->contracts_end = 0;
// 			$contracts = $this->contracts->get_contracts([
// 				'reserv_id' => array_keys($bookings),
// 				'status' => [1, 2],
// 				'limit' => (count($bookings)>1) ? count($bookings) : 2
// 			]);

            foreach ($bookings as $b) {
                $b->client_type = $this->users->get_client_type($b->client_type_id);
                $b->u_arrive = strtotime($b->arrive);
                $b->u_depart = strtotime($b->depart);
                $b->days_count = round(($b->u_depart - $b->u_arrive) / (24 * 60 * 60)) + 1;
                if (!isset($leasings[$b->group_id]) || $b->u_arrive < $leasings[$b->group_id]->u_arrive) {
                    $leasings[$b->group_id]->u_arrive = $b->u_arrive;
                    $leasings[$b->group_id]->arrive = $b->arrive;
                }
                if (!isset($leasings[$b->group_id]) || $b->u_depart > $leasings[$b->group_id]->u_depart) {
                    $leasings[$b->group_id]->u_depart = $b->u_depart;
                    $leasings[$b->group_id]->depart = $b->depart;
                }
                $leasings[$b->group_id]->days_count += $b->days_count;
                $leasings[$b->group_id]->bookings[$b->u_arrive.$b->id] = $b;
                $leasings[$b->group_id]->movein = ($leasings[$b->group_id]->u_arrive >= $this->params->u_from)?1:0;
                $leasings[$b->group_id]->moveout = ($leasings[$b->group_id]->u_depart < $this->params->u_to)?1:0;

                $b_ids[$b->id] = $b->id;

                if (!empty($b->group_id)) {
                    $groups_ids[$b->group_id] = $b->group_id;
                }

                if (!empty($b->sp_bookings)){
                    $b_ids += $b->sp_bookings_ids;

                    foreach($b->sp_bookings as $sb) {
                        if (!empty($sb->group_id)) {
                            $groups_ids[$sb->group_id] = $sb->group_id;
                        }
                    }
                }
            }
            $this->params->bookings_count = count($bookings);
            $this->params->leasings_count = count($leasings);
        }
        if (!empty($groups_ids)) {
            $g_bookings = $this->beds->get_bookings([
                // 'house_id' => $this->params->selected_house->id,
                'group_id' => $groups_ids,
                'not_id' => $b_ids,
                'status' => 3,
                'sp_group' => 1
            ]);
            if (!empty($g_bookings)) {
                foreach ($g_bookings as $b) {
                    if (!isset($bookings[$b->id]) && isset($leasings[$b->group_id])) {
                        $b->client_type = $this->users->get_client_type($b->client_type_id);
                        $b->u_arrive = strtotime($b->arrive);
                        $b->u_depart = strtotime($b->depart);
                        $b->days_count = round(($b->u_depart - $b->u_arrive) / (24 * 60 * 60)) + 1;
                        if ($b->u_arrive < $leasings[$b->group_id]->u_arrive) {
                            $leasings[$b->group_id]->u_arrive = $b->u_arrive;
                            $leasings[$b->group_id]->arrive = $b->arrive;
                        }
                        if ($b->u_depart > $leasings[$b->group_id]->u_depart) {
                            $leasings[$b->group_id]->u_depart = $b->u_depart;
                            $leasings[$b->group_id]->depart = $b->depart;
                        }
                        $leasings[$b->group_id]->days_count += $b->days_count;
                        $leasings[$b->group_id]->bookings[$b->u_arrive.$b->id] = $b;

                        $leasings[$b->group_id]->movein = ($leasings[$b->group_id]->u_arrive >= $this->params->u_from)?1:0;
                        $leasings[$b->group_id]->moveout = ($leasings[$b->group_id]->u_depart < $this->params->u_to)?1:0;
                    }
                }
            }
        }
        $this->params->movein_count = 0;
        $this->params->moveout_count = 0;
        if (!empty($leasings)) {
            foreach($leasings as $l) {
                ksort($l->bookings);
                $this->params->movein_count += $l->movein;
                $this->params->moveout_count += $l->moveout;
            }
        }


        // APARTMENTS
        $this->params->apartments = $this->request->array_to_key($this->beds->get_apartments([
            'house_id' => $this->params->selected_house->id,
            'visible' => 1,
            'sort' => 'name'
        ]), 'id');

        // ROOMS
        $this->params->rooms = $this->request->array_to_key($this->beds->get_rooms([
            'house_id' => $this->params->selected_house->id,
            'visible' => 1
        ]), 'id');

        // BEDS
        if (!empty($this->params->rooms)) {
            $this->params->beds = $this->request->array_to_key($this->beds->get_beds([
                'room_id' => array_keys($this->params->rooms)
            ]), 'id');
        }

        // Apartments types
        if (!empty($this->params->apartments)) {
            foreach ($this->beds->apartment_types as $k=>$at) {
                $this->params->apartments_types[$k] = (object)[
                    'id' => $k,
                    'name' => $at['name'],
                    'count' => 0,
                    'leasable' => 0,
                    'occupied' => 0,
                    'vacant' => 0
                ];
            }
            foreach ($this->params->apartments as $k=>$a) {
                // $this->params->apartments_types[$a->type]->id = $a->type;
                // $this->params->apartments_types[$a->type]->name = $this->beds->apartment_types[$a->type]['name'];
                $this->params->apartments_types[$a->type]->count ++;
            }
        }

        // Rooms types
        if (!empty($this->params->rooms)) {
            $all_room_types = $this->request->array_to_key($this->beds->get_rooms_types(), 'id');
            foreach ($this->params->rooms as $k=>$r) {
                $this->params->rooms_types[$r->type_id]->id = $r->type_id;
                $this->params->rooms_types[$r->type_id]->name = $all_room_types[$r->type_id]->name;
                $this->params->rooms_types[$r->type_id]->count ++;
            }
        }

        if (!empty($this->params->beds)) {
            foreach ($this->params->beds as $b) {
                if (!empty($b->room_id) && isset($this->params->rooms[$b->room_id])) {
                    $this->params->rooms[$b->room_id]->beds[$b->id] = $b;
                    $b->apartment_id = $this->params->rooms[$b->room_id]->apartment_id;
                    if (isset($this->params->apartments[$b->apartment_id])) {
                        $this->params->apartments[$b->apartment_id]->beds[$b->id] = $b;
                    }
                }
            }
            foreach ($this->params->rooms as $r) {
                if (!empty($r->apartment_id) && isset($this->params->apartments[$r->apartment_id])) {
                    $this->params->apartments[$r->apartment_id]->rooms[$r->id] = $r;
                }
            }
        }




        // Laeds
        $stats->leads_outpost = 0;
        $stats->leads_3_services = 0;
        $stats->leads_corporate = 0;

        $stats->created_bookings_outpost = 0;
        $stats->created_bookings_3_services = 0;
        $stats->created_bookings_corporate = 0;

        $stats->enabled_bookings_outpost = 0;
        $stats->enabled_bookings_3_services = 0;
        $stats->enabled_bookings_corporate = 0;

        $stats->contracted_outpost = 0;
        $stats->contracted_3_services = 0;
        $stats->contracted_corporate = 0;

        $leads_bookings = $this->beds->get_bookings([
            'house_id' => $this->params->selected_house->id,
            'created_month' => $this->params->month,
            'created_year' => $this->params->year,
            'sp_group' => true,
            'sp_group_from_start' => true,
            'select_users' => true
        ]);
        $leads = $this->request->array_to_key($this->users->get_leads([
            'house_id' => $this->params->selected_house->id,
            'created_month' => $this->params->month,
            'created_year' => $this->params->year
        ]), 'user_id');


        if (!empty($leads_bookings)) {
            $leads_bookings_users_ids = [];
            foreach ($leads_bookings as $b) {
                if (!empty($b->users)) {
                    foreach ($b->users as $u) {
                        if (!isset($leads[$u->id])) {
                            $leads_bookings_users_ids[$u->id] = $u->id;
                        }
                    }
                }
            }
            if (!empty($leads_bookings_users_ids)) {
                $b_leads = $this->request->array_to_key($this->users->get_leads([
                    'user_id' => $leads_bookings_users_ids
                ]), 'user_id');
                if (!empty($b_leads)) {
                    foreach ($b_leads as $l) {
                        $leads[$l->user_id] = $l;
                    }
                }
            }
        }
        if (!empty($leads)) {
            $stats->leads_outpost += count($leads);
        }

        if ($this->params->month == 10 && $this->params->year == 2022) {
            $d_leads = $this->cache->get_data(false, [
                'path' => 'october_leads.json'
            ]);
            if (isset($d_leads[$this->params->selected_house->id])) {
                $stats->leads_outpost = $d_leads[$this->params->selected_house->id];
            }
        }


        // The Greenpoint House
        if (in_array($this->params->selected_house->id, [311, 316, 317])) {
            $stats->leads_outpost = ceil($stats->leads_outpost / 3);
        }


        if (!empty($leads_bookings)) {
            $leads_bookings_outpost_ids = [];
            $leads_bookings_offline_ids = [];
            foreach ($leads_bookings as $b) {
                $b->lead_type = false;
                $b->client_type = $this->users->get_client_type($b->client_type_id);
                $b->client_group = $this->users->getClientGroupByType($b->client_type_id);
                // Outpost
                if ($b->client_group->id == 1) {
                    $leads_bookings_outpost_ids[$b->id] = $b->id;
                }
                // Not ext
                if ($b->parent_id == 0 && $b->sp_type != 1) {
                    // Outpost
                    if ($b->client_group->id == 1) {
                        $b->lead_type = 'site';
                        if (!empty($b->users)) {
                            $booking_user = current($b->users);
                            if (!isset($leads[$booking_user->id])) {
                                $b->lead_type = 'offline';
                                $leads_bookings_offline_ids[$b->id] = $b->id;
                                $stats->leads_offline ++;
                                $stats->created_bookings_offline ++;
                            }
                        }
                        if ($b->lead_type == 'site') {
                            $stats->created_bookings_outpost ++;
                            if ($b->status == 3) {
                                $stats->enabled_bookings_outpost ++;
                            }
                        }
                    }
                    // 3rd services
                    elseif ($b->client_group->id == 2) {
                        $stats->leads_3_services ++;
                        $stats->created_bookings_3_services ++;
                        if ($b->status == 3) {
                            $stats->enabled_bookings_3_services ++;
                        }
                    }
                    // Corporate
                    elseif ($b->client_group->id == 5) {
                        $stats->leads_corporate ++;
                        $stats->created_bookings_corporate ++;
                        if ($b->status == 3) {
                            $stats->enabled_bookings_corporate ++;
                        }
                    }
                }
            }

            // Contracts / Leads bookings
            $stats->contracts = new stdClass;
            if (!empty($leads_bookings)) {
                $leads_contracts = $this->contracts->get_contracts([
                    // 'reserv_id' => $leads_bookings_outpost_ids,
                    'reserv_id' => array_keys($leads_bookings),
                    'status' => [1, 2],
                    'is_signing' => true,
                    'limit' => (count($leads_bookings) > 1) ? count($leads_bookings) : 2
                ]);
                if (!empty($leads_contracts)) {
                    foreach ($leads_contracts as $c) {
                        if (isset($leads_bookings[$c->reserv_id])) {
                            $leads_bookings[$c->reserv_id]->contract = $c;
                        }
                    }
                }

                $c_def = (object)[
                    'new' => 0,
                    'ext' => 0,
                    'total' => 0
                ];

                $stats->contracts->short = clone $c_def;
                $stats->contracts->middle = clone $c_def;
                $stats->contracts->long = clone $c_def;
                $stats->contracts->all_term = clone $c_def;
                $stats->contracts->days = clone $c_def;
                $stats->contracts->price_month_sum = clone $c_def;
                $stats->contracts->av_price = clone $c_def;
                $stats->contracts->sum = clone $c_def;
                $stats->contracts->adr = clone $c_def;
                $stats->leases_count = 0;
                $stats->ext = 0;
                $stats->new = 0;
                $stats->managers = [];

                foreach ($leads_bookings as $k=>$b) {
                    if (isset($b->contract) || $b->status == 3) {
                        $b->lease_total_price = $b->total_price;

                        $laese_date_from = strtotime($b->arrive);
                        $laese_date_to = strtotime($b->depart);

                        if (isset($b->contract)) {
                            $laese_date_from = strtotime($b->contract->date_from);
                            $laese_date_to = strtotime($b->contract->date_to);
                            $b->price_month = $b->contract->price_month;
                            $b->lease_total_price = $b->contract->total_price;
                            $b->is_contract = true;
                        }
                        $b->lease_date_from = date('Y-m-d', $laese_date_from);
                        $b->lease_date_to = date('Y-m-d', $laese_date_to);
                        $b->lease_days_count = round(($laese_date_to - $laese_date_from) / (24 * 60 * 60)) + 1;

                        if (empty($b->manager_login)) {
                            $b->manager_login = '[no manager]';
                        }
                        if (empty($stats->managers[$b->manager_login])) {
                            $stats->managers[$b->manager_login] = (object) [
                                'new' => 0,
                                'ext' => 0
                            ];
                        }
                        $stats->leases_count ++;
                        // Extension
                        if ($b->parent_id != 0 && $b->sp_type == 1) {
                            $b->is_extension = true;
                            $stats->ext ++;
                            $stats->managers[$b->manager_login]->ext ++;
                        } else {
                            $b->is_extension = false;
                            $stats->new ++;
                            $stats->managers[$b->manager_login]->new ++;

                            if (isset($leads_bookings_offline_ids[$b->id])) {
                                $stats->contracted_offline ++;
                            }
                            elseif ($b->client_group->id == 1) {
                                $stats->contracted_outpost ++;
                            }
                        }

                        // Short
                        if ($b->lease_days_count < (31 * 4)) {
                            if ($b->is_extension) {
                                $stats->contracts->short->ext ++;
                            } else {
                                $stats->contracts->short->new ++;
                            }
                            $stats->contracts->short->total ++;
                        }
                        // Middle
                        elseif ($b->lease_days_count < (31 * 7)) {
                            if ($b->is_extension) {
                                $stats->contracts->middle->ext ++;
                            } else {
                                $stats->contracts->middle->new ++;
                            }
                            $stats->contracts->middle->total ++;
                        }
                        // Long
                        else {
                            if ($b->is_extension) {
                                $stats->contracts->long->ext ++;
                            } else {
                                $stats->contracts->long->new ++;
                            }
                            $stats->contracts->long->total ++;
                        }

                        if ($b->is_extension) {
                            $stats->contracts->all_term->ext ++;
                            $stats->contracts->days->ext += $b->lease_days_count;
                            $stats->contracts->price_month_sum->ext += $b->price_month;
                            $stats->contracts->sum->ext += $b->lease_total_price;
                        } else {
                            $stats->contracts->all_term->new ++;
                            $stats->contracts->days->new += $b->lease_days_count;
                            $stats->contracts->price_month_sum->new += $b->price_month;
                            $stats->contracts->sum->new += $b->lease_total_price;
                        }
                        $stats->contracts->all_term->total ++;
                        $stats->contracts->price_month_sum->total += $b->price_month;
                        $stats->contracts->days->total += $b->lease_days_count;
                        $stats->contracts->sum->total += $b->lease_total_price;
                    } else {
                        unset($leads_bookings[$k]);
                    }
                }

                $stats->contracts->av_price->new = $this->nanTo0(round($stats->contracts->price_month_sum->new / $stats->contracts->all_term->new, 2));
                $stats->contracts->av_price->ext = $this->nanTo0(round($stats->contracts->price_month_sum->ext / $stats->contracts->all_term->ext, 2));
                $stats->contracts->av_price->total = $this->nanTo0(round($stats->contracts->price_month_sum->total / $stats->contracts->all_term->total, 2));

                $stats->contracts->adr->new = $this->nanTo0(round($stats->contracts->sum->new / $stats->contracts->days->new, 2));
                $stats->contracts->adr->ext = $this->nanTo0(round($stats->contracts->sum->ext / $stats->contracts->days->ext, 2));
                $stats->contracts->adr->total = $this->nanTo0(round($stats->contracts->sum->total / $stats->contracts->days->total, 2));
            }

        }
        $stats->contracted_3_services = $stats->enabled_bookings_3_services;
        $stats->contracted_corporate = $stats->enabled_bookings_corporate;

        $stats->leads_total = $stats->leads_outpost + $stats->leads_3_services + $stats->leads_corporate + $stats->leads_offline;
        $stats->created_bookings_total = $stats->created_bookings_outpost + $stats->created_bookings_3_services + $stats->created_bookings_corporate + $stats->created_bookings_offline;
        $stats->enabled_bookings_total = $stats->enabled_bookings_outpost + $stats->enabled_bookings_3_services + $stats->enabled_bookings_corporate + $stats->enabled_bookings_offline;
        $stats->contracted_total = $stats->contracted_outpost + $stats->contracted_3_services + $stats->contracted_corporate + $stats->contracted_offline;



        // Occupancy
        $occupancy_house = [];
        $now_month = new DateTime($this->params->year.'-'.$this->params->month.'-01');
        $months_count = 15;
        if (isset($params['landlord'])) {
            $months_count = 13;
        } else {
            $now_month->modify('+2 month');
        }
        $this->params->days_beds_count = 0;
        $this->params->occupancy_bdays = 0;
        for ($i = 0; $i < $months_count; $i++) {
            $occupancy = new stdClass;
            if ($i > 0) {
                $now_month->modify('-1 month');
            }
            $occupancy->month = $now_month->format('Y-m-d');

            if ($now_month->getTimestamp() == $this->params->now_month->getTimestamp()) {
                $occupancy->selected = true;
            }

            if ($now_month->getTimestamp() == $this->params->s1now) {
                $occupancy->now = true;
            }
            elseif ($now_month->getTimestamp() > $this->params->s1now) {
                $occupancy->future = true;
            }

            // if ($now_month->getTimestamp() < $this->params->s1now) {
            $occupancy_data = $this->occupancy->get_occupancy([
                'month' => $now_month->format('m'),
                'year'  => $now_month->format('Y'),
                'house_id' => $this->params->selected_house->id
            ]);
            if (!empty($occupancy_data) && $occupancy_data->house) {
                $occupancy->data = $occupancy_data->house;
                if ($occupancy->data->occupancy > 0) {
                    $this->params->days_beds_count += $occupancy->data->days_beds_count;
                    $this->params->occupancy_bdays += $occupancy->data->occupancy_bdays;
                }
            }
            if ($occupancy->selected) {
                $this->params->selected_occupancy = $occupancy->data;
            }

            $occupancy_house[] = $occupancy;
        }
        if ($this->params->days_beds_count > 0 && $this->params->occupancy_bdays > 0) {
            $this->params->occupancy = ceil($this->params->occupancy_bdays / $this->params->days_beds_count * 100);
            if ($this->params->occupancy > 100) {
                $this->params->occupancy = 100;
            }
        }



        // Available / Ready to sell

        $this->params->apartments_property_key_data = (object)[
            'leasable' => 0,
            'occupied' => 0,
            'vacant' => 0
        ];

        $t_bookings_params_date_to2 = clone $this->params->next_month;
        $t_bookings_params_date_to2->modify('+30 days');

        $t_bookings_params = [
            'house_id' => $this->params->selected_house->id,
            // 'is_due' => true,
            'date_from2' => $this->params->now_month->format('Y-m-d'),
            'date_to2' => $t_bookings_params_date_to2->format('Y-m-d'),
            'status' => [
                3, // Contract / Invoice
                5  // Closed
            ],
            'order_by' => 'b.depart',
            'no_to_key' => true
        ];
        $t_bookings = $this->beds->get_bookings($t_bookings_params);

        if (!empty($t_bookings)) {
            foreach ($t_bookings as $b) {
                $b->u_arrive = strtotime($b->arrive);
                $b->u_depart = strtotime($b->depart);

                // Bed
                if ($b->type == 1) {
                    if (isset($this->params->beds[$b->object_id])) {
                        $apartment_id = $this->params->beds[$b->object_id]->apartment_id;
                        if (isset($this->params->apartments[$apartment_id]->beds[$b->object_id])) {
                            $this->params->apartments[$apartment_id]->beds[$b->object_id]->bookings[$b->id] = $b;
                        }
                    }
                }
                // Apartment
                elseif ($b->type == 2) {
                    if (isset($this->params->apartments[$b->object_id]->beds)) {
                        foreach ($this->params->apartments[$b->object_id]->beds as $bed_id=>$bed) {
                            $bed->bookings[$b->id] = $b;
                        }
                    }
                }
            }
        }


        $u_from = $this->params->now_month->getTimestamp();
        $u_to = $t_bookings_params_date_to2->getTimestamp();
        $u_now_month_last_day = strtotime($this->params->now_month_last_day);


        $stats->beds_available = 0;
        $stats->beds_ready_to_sell = 0;
        $stats->beds_available_now = 0;
        $stats->beds_ready_to_sell_now = 0;
        if (!empty($this->params->apartments)) {
            foreach ($this->params->apartments as $a) {
                $from_to = $this->FromTo($u_from, $u_to, $a->date_added, $a->date_shutdown);
                $from_to_month = $this->FromTo($u_from, $u_now_month_last_day, $a->date_added, $a->date_shutdown);
                $a->u_from = $from_to->u_from;
                $a->u_to = $from_to->u_to;
                $a->u_to_month = $from_to_month->u_to;
                $a->vacant = true;
                $a->occupied = false;
                $a->opened_days = 31;
                $a->closed_days = 0;

                foreach ($a->rooms as $r) {
                    $from_to = $this->FromTo($a->u_from, $a->u_to, $r->date_added, $r->date_shutdown);
                    $from_to_month = $this->FromTo($a->u_from, $a->u_to_month, $r->date_added, $r->date_shutdown);
                    $r->u_from = $from_to->u_from;
                    $r->u_to = $from_to->u_to;
                    $r->u_to_month = $from_to_month->u_to;

                    foreach ($r->beds as $b) {
                        $b->vacant = true;
                        $b->vacant_now = true;

                        $from_to = $this->FromTo($r->u_from, $r->u_to, $b->date_added, $b->date_shutdown);
                        $from_to_month = $this->FromTo($r->u_from, $r->u_to_month, $b->date_added, $b->date_shutdown);
                        $b->u_from = $from_to->u_from;
                        $b->u_to = $from_to->u_to;
                        $b->u_to_month = $from_to_month->u_to;

                        $b->v_days_in_month = round(($b->u_to_month - $b->u_from) / (24 * 60 * 60)) + 1;

                        $a->u_opened_from = $b->u_from;
                        $a->u_opened_to = $b->v_days_in_month;
                        if ($a->opened_days > $b->v_days_in_month) {
                            $a->opened_days = $b->v_days_in_month;
                        }

                        $b->set_depart = $b->u_from;
                        $b->set_arrive = $b->u_to;

                        if ($b->u_from > $u_now_month_last_day || $b->u_to < $u_now_month_last_day) {
                            $b->vacant = false;
                        }
                        if ($this->params->selected_month == 'now') {
                            $b->set_depart_now = $b->u_from;
                            $b->set_arrive_now = $b->u_to;
                            if ($b->u_from > $this->params->strtotime_now || $b->u_to < $this->params->strtotime_now) {
                                $b->vacant_now = false;
                            }
                        }
                        foreach ($b->bookings as $booking) {
                            if ($booking->u_arrive <= $u_now_month_last_day && $booking->u_depart >= $u_now_month_last_day) {
                                $b->vacant = false;
                            }
                            if ($booking->u_depart < $u_now_month_last_day && $b->set_depart < $booking->u_depart) {
                                $b->set_depart = $booking->u_depart;
                            }
                            if ($booking->u_arrive > $u_now_month_last_day && $b->set_arrive > $booking->u_arrive) {
                                $b->set_arrive = $booking->u_arrive;
                            }
                            if ($booking->u_arrive <= $u_now_month_last_day) {
                                $a->vacant = false;
                                // Contract / Invoice
                                if ($booking->status == 3) {
                                    $a->occupied = true;
                                }
                            }
                            if ($this->params->selected_month == 'now') {
                                if ($booking->u_arrive <= $this->params->strtotime_now && $booking->u_depart >= $this->params->strtotime_now) {
                                    $b->vacant_now = false;
                                }
                                if ($booking->u_depart < $this->params->strtotime_now && $b->set_depart_now < $booking->u_depart) {
                                    $b->set_depart_now = $booking->u_depart;
                                }
                                if ($booking->u_arrive > $this->params->strtotime_now && $b->set_arrive_now > $booking->u_arrive) {
                                    $b->set_arrive_now = $booking->u_arrive;
                                }
                            }
                            // Closed
                            if ($booking->status == 5) {
                                $booking_from_to = $this->FromTo($b->u_from, $b->u_to_month, $booking->arrive, $booking->depart);
                                $days_off = round(($booking_from_to->u_to - $booking_from_to->u_from) / (24 * 60 * 60)) + 1;
                                if ($a->closed_days < $days_off) {
                                    $a->closed_days = $days_off;
                                }
                            }
                        }
                        if ($b->vacant) {
                            $stats->beds_available ++;
                        }
                        if ((($b->set_arrive - $b->set_depart) / (60 * 60 * 24)) > 30 && $b->vacant) {
                            $stats->beds_ready_to_sell ++;
                        }

                        if ($this->params->selected_month == 'now') {
                            if ($b->vacant_now) {
                                $stats->beds_available_now ++;
                            }
                            if ((($b->set_arrive_now - $b->set_depart_now) / (60 * 60 * 24)) > 30 && $b->vacant_now) {
                                $stats->beds_ready_to_sell_now ++;
                            }
                        }
                    }
                }
                $a->opened_days -= $a->closed_days;

                if ($a->vacant) {
                    $this->params->apartments_types[$a->type]->vacant ++;
                    $this->params->apartments_property_key_data->vacant ++;
                }
                if ($a->occupied) {
                    $this->params->apartments_types[$a->type]->occupied ++;
                    $this->params->apartments_property_key_data->occupied ++;
                }
                if ($a->opened_days >= 2) {
                    $this->params->apartments_types[$a->type]->leasable ++;
                    $this->params->apartments_property_key_data->leasable ++;
                }
            }
        }


        $this->data->params =  $this->params;
        $this->data->stats = $stats;
        $this->data->occupancy_house = $occupancy_house;
        $this->data->leads_bookings = $leads_bookings;
        $this->data->leasings = $leasings;


        return $this->data;
    }
    
    

    
    

}
