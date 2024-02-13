<?php


require_once('Backend.php');

class Occupancy extends Backend
{

	private $result;
	private $params;


	public function __construct()
	{
		$this->result = new stdClass;
		$this->params = new stdClass;
        $this->setHousesTypes();
	}
    private function setHousesTypes() {
        $this->params->houses_types = [
            0 => 'All houses',
            1 => 'Outpost',
            2 => 'LandLord'
        ];
    }


	public function get_occupancy($params = [])
	{
		if (!isset($params['month']) || !isset($params['year']))
			return false;

		$result = $this->cache->get_data('occupancy', [
			'month' => $params['month'],
			'year'  => $params['year']
		]);
		if (!empty($result->city_houses)) {
			$city_houses = [];
			foreach ($result->city_houses as $k=>$v) {
				$v->id = (int)$v->id;
				$v->parent_id = (int)$v->parent_id;
				$city_houses[(int)$k] = $v;
                if (isset($params['house_id']) && (int)$params['house_id'] == $v->id) {
                    $result->house = $v;
                }
			}
			$result->city_houses = $city_houses;

		}
		if (!empty($result->days_groups)) {
			$days_groups = [];
			foreach($result->days_groups as $k=>$v)
				$days_groups[(int)$k] = $v;
			$result->days_groups = $days_groups;
		}



		if(empty($result))
			$result = $this->init_occupancy($params);

		$result->houses_types = $this->params->houses_types;
        unset($this->categories_tree->categories_tree['chouses']);
		$result->city_houses = $this->categories_tree->get_categories_tree('chouses', $result->city_houses);


		return $result;
	}



    public function init_occupancy($params = [])
    {
        if(!isset($params['month']) || !isset($params['year']))
            return false;

        $this->result = new stdClass;
        $this->params = new stdClass;
        $this->setHousesTypes();

        $this->params->month = $params['month'];
        $this->params->year = $params['year'];

        $this->result->occupancy_bdays = 0;



        $strtotime_now = strtotime('now');

        $this->params->stoday = strtotime(date('Y-m-d', $strtotime_now));

        $this->params->now_month = new DateTime($this->params->year.'-'.$this->params->month.'-01');

        $this->params->next_month = clone $this->params->now_month;
        $this->params->next_month->modify('+1 month');

        $this->params->prev_month = clone $this->params->now_month;
        $this->params->prev_month->modify('-1 month');


        $this->params->days_in_month = date("t", strtotime($this->params->year.'-'.$this->params->month.'-01'));
        $this->params->now_month_last_day = $this->params->year.'-'.$this->params->month.'-'.$this->params->days_in_month;

        $this->params->u_now_month_last_day = strtotime($this->params->now_month_last_day);


        if(!empty($params['day']))
            $this->params->day = new DateTime($this->params->year.'-'.$this->params->month.'-'.$params['day']);


        if($this->params->year.'-'.$this->params->month == date('Y-m', $strtotime_now))
            $this->params->selected_month = 'now';
        elseif($this->params->now_month->getTimestamp() >  $strtotime_now)
            $this->params->selected_month = 'future';
        else
            $this->params->selected_month = 'past';


        // Selected house
        if(!empty($params['house_id']))
        {
            $houses_ids = [
                $params['house_id'] => $params['house_id']
            ];
        }
        // Selected houses type
        elseif(!empty($params['houses_type']) && isset($this->params->houses_types[$params['houses_type']]))
        {
            $this->result->selected_houses_type = (object)[
                'id' => $params['houses_type'],
                'name' => $this->params->houses_types[$params['houses_type']]
            ];
        }
        else
        {
            $this->result->selected_houses_type = (object)[
                'id' => 0,
                'name' => $this->params->houses_types[0]
            ];
        }


        if(!empty($this->result->selected_houses_type->id))
        {
            // Outpost
            if($this->result->selected_houses_type->id == 1)
            {
                $this->result->company_houses = $this->companies->get_company_houses([
                    'company_id' => 1
                ]);
            }
            // LandLord
            elseif($this->result->selected_houses_type->id == 2)
            {
                $this->result->company_houses = $this->companies->get_company_houses([
                    'company_not_id' => 1
                ]);
            }


            if(!empty($this->result->company_houses))
            {
                $houses_ids = [];
                foreach($this->result->company_houses as $ch)
                    $houses_ids[$ch->house_id] = $ch->house_id;
            }
        }

        $houses_id_filter = '';
        if(!empty($houses_ids))
        {
            $houses_id_filter = $this->db->placehold('AND (id in(?@) OR parent_id=0)', array_keys($houses_ids));
        }

        $query = $this->db->placehold("SELECT 
								id,
								parent_id,
								name
							FROM __pages 
							WHERE 
								menu_id=5 
								AND visible=1 
								$houses_id_filter 
							ORDER BY position");
        $this->db->query($query);
        $this->result->city_houses = $this->db->results();
        $this->result->city_houses = $this->request->array_to_key($this->result->city_houses, 'id');


        if(!empty($this->result->city_houses))
        {
            foreach($this->result->city_houses as $house_id=>$h)
            {
                if($h->parent_id > 0 && isset($this->result->city_houses[$h->parent_id]))
                {
                    $h->bedscount = 0;
                    $h->occupancy_bdays = 0;
                    $this->params->houses[$h->id] = $h;
                    $this->params->houses_ids[$h->id] = $h->id;
                }
            }
        }


        // Apartments
        $apartments = $this->beds->get_apartments([
            'house_id' => $this->params->houses_ids,
            'limit' => 10000,
            'visible' => 1
        ]);
        $this->params->apartments = $this->request->array_to_key($apartments, 'id');


        $houses_apartments_ids = [];
        $apartments_ids = [];
        if(!empty($this->params->apartments))
        {
            foreach($this->params->apartments as $a)
            {
                $this->params->apartments[$a->id]->beds_count = 0;

                if(!empty($a->house_id) && isset($this->params->houses[$a->house_id]))
                {
                    $houses_apartments_ids[$a->house_id][$a->id] = $a->id;
                    $apartments_ids[$a->id] = $a->id;
                }
            }
        }

        // Rooms
        $rooms_ = $this->beds->get_rooms([
            'apartment_id' => $apartments_ids,
            'limit' => 10000,
            'visible' => 1
        ]);


        $rooms_apartments_ids = [];
        if(!empty($rooms_))
        {
            foreach($rooms_ as $r)
            {
                if(isset($this->params->apartments[$r->apartment_id]))
                {
                    $this->params->rooms[$r->id] = $r;
                    if(!empty($r->apartment_id) && isset($this->params->apartments[$r->apartment_id]))
                        $this->params->apartments[$r->apartment_id]->rooms[$r->id] = $r;

                    $rooms_apartments_ids[$r->id] = $r->apartment_id;

                    if($r->visible == 1)
                        $this->params->apartments[$r->apartment_id]->rooms_visible = 1;
                }
            }
        }


        // Beds
        $this->params->beds = $this->beds->get_beds([
            'room_id' => array_keys($this->params->rooms),
            'visible' => 1
        ]);
        $this->params->beds = $this->request->array_to_key($this->params->beds, 'id');

        $beds_rooms_ids = [];
        if(!empty($this->params->beds))
        {
            foreach($this->params->beds as $b)
            {
                if(isset($this->params->rooms[$b->room_id]))
                {
                    $beds_rooms_ids[$b->id] = $b->room_id;
                    if(!empty($this->params->rooms[$b->room_id]->apartment_id))
                    {
                        $apartment_id = $this->params->rooms[$b->room_id]->apartment_id;

                        $this->params->apartments[$apartment_id]->rooms[$b->room_id]->beds[$b->id] = $b;
                        $this->params->apartments[$apartment_id]->beds_count++;

                        if(isset($this->params->houses[$this->params->apartments[$apartment_id]->house_id]))
                            $this->params->houses[$this->params->apartments[$apartment_id]->house_id]->beds_tcount += $this->params->days_in_month;

                        if($b->visible == 1)
                            $this->params->apartments[$apartment_id]->beds_visible = 1;
                    }
                }
            }
        }

        // BOOKINGS
        $booking_patrams = [
            'house_id' => $this->params->houses_ids,
            'status' => [
                3,  // Contract / Invoice
                5   // Closed
            ]
        ];

        $booking_patrams['date_from2'] = $this->params->year.'-'.$this->params->month.'-01';
        $booking_patrams['date_to2'] = $this->params->now_month_last_day;

        $this->params->max_days = 0;
        $this->params->days = [];

        $d_selected = 0;
        for($i = 1; $i <= $this->params->days_in_month; $i++)
        {
            $d = new stdClass();
            $d->beds = 0;
            $d->beds_filled = 0;
            $d->occupancy = 0;
            $d->strtotime = strtotime($this->params->year.'-'.$this->params->month.'-'.$i);

            $d->oc_days = [];

            if($d_selected == 1)
                $d->after_selected = true;

            if(!empty($params['day']) && $params['day'] == $i)
            {
                $d_selected = 1;
                $d->selected = true;
            }


            if($this->params->stoday == $d->strtotime)
            {
                $d->today = true;
            }

            elseif($this->params->stoday < $d->strtotime)
                $d->future = true;

            $this->params->days[$i] = $d;
        }





        $this->result->history = [];

        $this->result->history[0] = (object)[
            'strtotime' => strtotime($this->params->year.'-'.$this->params->month.'-01') - (24 * 3600),
            'oc_days' => [],
            'beds' => 0,
            'beds_filled' => 0,
            'occupancy' => 0,
            'occupancy_bdays' => 0
        ];


        if($this->params->selected_month != 'future')
        {
            for($i = 1; $i <= $this->params->days_in_month; $i++)
            {
                $d = $this->params->days[$i];
                $d->occupancy_bdays = 0;
                $this->result->history[$i] = $d;
            }
        }


        // Beds-deys count
        $this->result->days_beds_count = 0;

        $this->params->u_from = $this->params->now_month->getTimestamp();
        $this->params->u_to = strtotime($this->params->now_month_last_day);

        $u_from = $this->params->now_month->getTimestamp();
        $u_to = strtotime($this->params->now_month_last_day);


        if(!empty($houses_apartments_ids))
        {
            foreach($houses_apartments_ids as $house_id=>$apartments_ids)
            {
                if(!empty($apartments_ids) && isset($this->params->houses[$house_id]))
                {

                    $this->params->houses[$house_id]->days_beds_count = 0;

                    foreach($apartments_ids as $apartment_id)
                    {

                        if(isset($this->params->apartments[$apartment_id]))
                        {
                            $a = $this->params->apartments[$apartment_id];



                            // Показываем окупенси ледлордам вильямсбурга upd - Rostik
                            if((($a->house_id == 334 || $a->house_id == 337 || $a->house_id == 340) && $params['landlord_view'] == 1))
                            {
                                $a->occupancy_start = null;
                                $a->occupancy_end = null;
                            }
                            // Показываем окупенси ледлордам вильямсбурга upd (END)

                            if($params['landlord_view'] == 1)
                            {
                                $a->occupancy_start = null;
                                $a->occupancy_end = null;
                            }

                            $a_d_count = null;
                            $a_days = $this->beds->calculate_bedsdays($a->occupancy_start, $a->occupancy_end, $a->visible, $u_from, $u_to);

                            if(!is_null($a->occupancy_start) && strtotime($a->occupancy_start) > $u_to)
                            {
                                $this->params->apartments[$a->id]->rooms_visible = 0;
                            }

                            if(!empty($a_days))
                            {
                                if($a_days->d_count > 0 && !empty($a->rooms))
                                {
                                    foreach($a->rooms as $r)
                                    {
                                        // не учитываем даты открытия и закрытия
                                        if($params['landlord_view'] == 1)
                                        {
                                            $r->date_added = null;
                                            $r->date_shutdown = null;
                                        }


                                        $r_days = $this->beds->calculate_bedsdays($r->date_added, $r->date_shutdown, $r->visible, $a_days->from, $a_days->to);

                                        if($r_days->d_count > 0 && !empty($r->beds))
                                        {
                                            foreach($r->beds as $b)
                                            {
                                                // не учитываем даты открытия и закрытия
                                                if($params['landlord_view'] == 1)
                                                {
                                                    $b->date_added = null;
                                                    $b->date_shutdown = null;
                                                }

                                                $b_days = $this->beds->calculate_bedsdays($b->date_added, $b->date_shutdown, $b->visible, $r_days->from, $r_days->to);


                                                if($b_days->d_count > 0)
                                                {
                                                    $this->params->houses[$house_id]->days_beds_count += (int)$b_days->d_count;
                                                    $this->result->days_beds_count += (int)$b_days->d_count;


                                                    $this->params->houses[$house_id]->bedscount ++;


                                                    // City
                                                    if(isset($this->result->city_houses[$this->params->houses[$house_id]->parent_id]))
                                                    {
                                                        $this->result->city_houses[$this->params->houses[$house_id]->parent_id]->days_beds_count += (int)$b_days->d_count;
                                                    }


                                                    // in Day
                                                    foreach($this->params->days as $n=>$d)
                                                    {
                                                        if($d->strtotime >= $b_days->from && $d->strtotime <= $b_days->to)
                                                        {
                                                            $this->params->days[$n]->beds ++;
                                                        }
                                                    }

                                                }

                                            }
                                        }
                                    }
                                }
                            }

                        }

                    }
                }

            }
            $bookings_ = $this->beds->get_bookings($booking_patrams);

            if(!empty($bookings_))
            {
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
                        if(isset($this->params->apartments[$b->apartment_id]))
                        {
                            if(isset($this->params->rooms[$b->room_id]))
                            {
                                if(isset($this->params->beds[$b->object_id]))
                                {
                                    $bookings[$k] = $b;
                                }
                            }
                        }
                    }
                    elseif($b->type == 2) // Booking type: Apartment
                    {
                        if(isset($this->params->apartments[$b->object_id]))
                        {
                            $bookings[$k] = $b;
                        }
                    }
                }
                unset($bookings_);

                foreach($bookings as $b_id=>$b)
                {
                    $b->month_days = 0;
                    /*
                    if($b->type == 1) // booking: beds
                    {
                        if(isset($beds_rooms_ids[$b->object_id]))
                        {
                            $b->room_id = $beds_rooms_ids[$b->object_id];
                        }
                        if(!empty($b->room_id))
                        {
                            $apartment_id = $rooms_apartments_ids[$b->room_id];
                            if(!empty($apartment_id) && $b->apartment_id != $apartment_id)
                            {
                                $b->apartment_id = $apartment_id;
                            }
                        }

                    }
                    elseif($b->type == 2) // booking: apartments
                    {
                        $b->apartment_id = $b->object_id;
                    }
                    */





                    if($this->params->apartments[$b->apartment_id]->house_id != $b->house_id)
                        $b->house_id = $this->params->apartments[$b->apartment_id]->house_id;


                    $b->u_date_created = strtotime(date('Y-m-d', strtotime($b->created)));

                    $b->u_arrive = strtotime($b->arrive);
                    $b->u_depart = strtotime($b->depart);
                    $b->interval = $b->u_depart - $b->u_arrive;
                    $b->days_count = round($b->interval / (24 * 60 * 60));


                    $b->bm_from = $b->u_arrive;
                    $b->bm_from2 = $b->u_arrive;
                    if($b->u_arrive < $u_from)
                    {
                        $b->bm_from = $u_from;
                        $b->bm_from2 = $u_from;
                    }



                    //if($this->params->apartments[$b->apartment_id]->date_added)



                    $b->bm_to = $b->u_depart;
                    $b->bm_to2 = $b->u_depart;
                    if($b->u_depart > $u_to)
                    {
                        $b->bm_to = $u_to;
                        $b->bm_to2 = $u_to;
                    }




                    if($b->status == 5) // closed
                    {


                        // if($this->params->houses[$b->house_id]->days_beds_count > 0)
                        // {
                        // 	$this->params->houses[$b->house_id]->days_beds_count -= $b->month_days;
                        // 	$this->result->days_beds_count -= $b->month_days;


                        // 	$this->result->city_houses[$this->params->houses[$b->house_id]->parent_id]->days_beds_count -= $b->month_days;
                        // }
                        // $b->month_days *= 0;
                        // $b->month_days2 *= 0;
                    }
                    else
                    {




                        // Arrive/Deppart -> Apartaments Added/Shutdown
                        if(!is_null($this->params->apartments[$b->apartment_id]->occupancy_start))
                        {
                            $apartment_u_added = strtotime($this->params->apartments[$b->apartment_id]->occupancy_start);
                            if($apartment_u_added > $u_to)
                            {
                                $b->disabled = 1;
                            }
                            elseif($apartment_u_added > $u_from && ($apartment_u_added > $b->bm_from && $apartment_u_added <= $b->bm_to))
                            {
                                $b->bm_from = $apartment_u_added;
                            }
                        }
                        if(!is_null($this->params->apartments[$b->apartment_id]->occupancy_end))
                        {
                            $apartment_u_shutdown = strtotime($this->params->apartments[$b->apartment_id]->occupancy_end);
                            if($apartment_u_shutdown < $u_from)
                            {
                                $b->disabled = 1;
                            }
                            elseif($apartment_u_shutdown < $u_to && ($apartment_u_shutdown < $b->bm_to && $apartment_u_shutdown > $b->bm_from))
                            {
                                $b->bm_to = $apartment_u_shutdown;
                            }
                        }


                        if($b->type == 1) // Bed
                        {
                            //print_r($this->params->apartments[$b->apartment_id]); exit;
                            // if($this->params->apartments[$b->apartment_id]->id == 93)
                            // {
                            // 	echo $this->params->apartments[$b->apartment_id]->date_added; exit;
                            // }




                            // Arrive/Deppart -> Rooms Added/Shutdown
                            if(!is_null($this->params->rooms[$b->room_id]->date_added))
                            {
                                $room_u_added = strtotime($this->params->rooms[$b->room_id]->date_added);
                                if($room_u_added > $u_to)
                                {
                                    $b->disabled = 1;
                                }
                                elseif($room_u_added > $u_from && ($room_u_added > $b->bm_from && $room_u_added <= $b->bm_to))
                                {
                                    $b->bm_from = $room_u_added;
                                }
                            }
                            if(!is_null($this->params->rooms[$b->room_id]->date_shutdown))
                            {
                                $room_u_shutdown = strtotime($this->params->rooms[$b->room_id]->date_shutdown);
                                if($room_u_shutdown < $u_from)
                                {
                                    $b->disabled = 1;
                                }
                                elseif($room_u_shutdown < $u_to && ($room_u_shutdown < $b->bm_to && $room_u_shutdown > $b->bm_from))
                                {
                                    $b->bm_to = $room_u_shutdown;
                                }
                            }

                            // Arrive/Deppart -> Beds Added/Shutdown
                            if(!is_null($this->params->beds[$b->object_id]->date_added))
                            {
                                $bed_u_added = strtotime($this->params->beds[$b->object_id]->date_added);
                                if($bed_u_added > $u_to)
                                {
                                    $b->disabled = 1;
                                }
                                elseif($bed_u_added > $u_from && ($bed_u_added > $b->bm_from && $bed_u_added <= $b->bm_to))
                                {
                                    $b->bm_from = $bed_u_added;
                                }
                            }
                            if(!is_null($this->params->beds[$b->object_id]->date_shutdown))
                            {
                                $bed_u_shutdown = strtotime($this->params->beds[$b->object_id]->date_shutdown);
                                if($bed_u_shutdown < $u_from)
                                {
                                    $b->disabled = 1;
                                }
                                elseif($bed_u_shutdown < $u_to && ($bed_u_shutdown < $b->bm_to && $bed_u_shutdown > $b->bm_from))
                                {
                                    $b->bm_to = $bed_u_shutdown;
                                }
                            }

                            $b->month_days = round(($b->bm_to - $b->bm_from) / (24 * 60 * 60)) + 1;
                            $b->month_days2 = round(($b->bm_to2 - $b->bm_from2) / (24 * 60 * 60)) + 1;
                            // $b->month_bdays = (int)$b->month_days;

                            $b->b_beds_count = 1;
                            $b->b_beds_count2 = 1;

                        }
                        elseif($b->type == 2) // Apartment
                        {

                            // print_r($this->params->apartments[$b->object_id]); exit;

                            if(!empty($this->params->apartments[$b->object_id]->rooms) && empty($b->disabled))
                            {

                                // print_r($this->params->apartments[$b->object_id]); exit;
                                foreach($this->params->apartments[$b->object_id]->rooms as $room)
                                {
                                    $room->bm_from = $b->bm_from;
                                    $room->bm_to = $b->bm_to;

                                    if(!is_null($room->date_added))
                                    {
                                        $room_u_added = strtotime($room->date_added);
                                        if($room_u_added > $u_to)
                                        {
                                            $room->disabled = 1;
                                        }
                                        elseif($room_u_added > $u_from && ($room_u_added > $room->bm_from && $room_u_added <= $room->bm_to))
                                        {
                                            $room->bm_from = $room_u_added;
                                        }
                                    }
                                    if(!is_null($room->date_shutdown))
                                    {
                                        $room_u_shutdown = strtotime($room->date_shutdown);
                                        if($room_u_shutdown < $u_from)
                                        {
                                            $room->disabled = 1;
                                        }
                                        elseif($room_u_shutdown < $u_to && ($room_u_shutdown < $room->bm_to && $room_u_shutdown > $room->bm_from))
                                        {
                                            $room->bm_to = $room_u_shutdown;
                                        }
                                    }

                                    if(empty($room->disabled) && !empty($room->beds))
                                    {
                                        foreach($room->beds as $bed)
                                        {
                                            $bed->bm_from = $room->bm_from;
                                            $bed->bm_to = $room->bm_to;

                                            if(!is_null($bed->date_added))
                                            {
                                                $bed_u_added = strtotime($bed->date_added);
                                                if($bed_u_added > $u_to)
                                                {
                                                    $bed->disabled = 1;
                                                }
                                                elseif($bed_u_added > $u_from && ($bed_u_added > $bed->bm_from && $bed_u_added <= $bed->bm_to))
                                                {
                                                    $bed->bm_from = $bed_u_added;
                                                }
                                            }
                                            if(!is_null($bed->date_shutdown))
                                            {
                                                $bed_u_shutdown = strtotime($bed->date_shutdown);
                                                if($bed_u_shutdown < $u_from)
                                                {
                                                    $bed->disabled = 1;
                                                }
                                                elseif($bed_u_shutdown < $u_to && ($bed_u_shutdown < $bed->bm_to && $room_u_shutdown > $bed->bm_from))
                                                {
                                                    $bed->bm_to = $bed_u_shutdown;
                                                }
                                            }

                                            if(empty($bed->disabled))
                                            {
                                                $b->month_days += round(($bed->bm_to - $bed->bm_from) / (24 * 60 * 60)) + 1;
                                                $b->b_beds_count ++;
                                            }

                                            // $b->month_days2 += round(($b->bm_to2 - $b->bm_from2) / (24 * 60 * 60)) + 1;
                                            // $b->b_beds_count2 ++;


                                        }
                                    }

                                }
                            }
                            if(!empty($b->disabled) || !empty($room->disabled) || !empty($bed->disabled))
                            {
                                $b->b_beds_count2 = (int)$this->params->apartments[$b->object_id]->beds_count;
                                $b->month_days2 = (round(($b->bm_to2 - $b->bm_from2) / (24 * 60 * 60)) + 1) * $b->b_beds_count2;
                            }


                            // 						echo '['.$b->month_days.']
                            // ';

                            // $b->month_days = round(($b->bm_to - $b->bm_from) / (24 * 60 * 60)) + 1;
                            // $b->month_bdays = (int)$b->month_days;

                            // $b->month_bdays *= (int)$this->params->apartments[$b->object_id]->beds_count;


                            // $b->b_beds_count = (int)$this->params->apartments[$b->object_id]->beds_count;
                        }


                    }







                    // if($b->type == 2) // Apartment
                    // {

                    // }

                    if($b->disabled || $b->month_days < 0)
                        $b->month_days = 0;


                    $b->month_bdays = (int)$b->month_days;
                    $b->month_bdays2 = (int)$b->month_days2;

                    // print_r([
                    // 	'b' => $b->id,
                    // 	'count' => $b->month_days
                    // ]);


                    // if($this->params->apartments[$b->apartment_id]->visible == 0)
                    // {
                    // 	// $b->month_bdays = 0;
                    // }


                    $bookings[$b_id] = $b;

                    if(empty($this->params->day) || ($b->u_date_created <= $this->params->day->getTimestamp() || $b->u_date_created >= $this->params->u_now_month_last_day))
                    {

                        $this->params->houses[$b->house_id]->occupancy_bdays += $b->month_bdays;

                        $this->params->houses[$b->house_id]->occupancy_bdays2 += $b->month_bdays2;

                        if($this->params->houses[$b->house_id]->days_beds_count > 0)
                        {

                            $this->result->occupancy_bdays += (int)$b->month_bdays;

                            // City
                            if(isset($this->result->city_houses[$this->params->houses[$b->house_id]->parent_id]))
                                $this->result->city_houses[$this->params->houses[$b->house_id]->parent_id]->occupancy_bdays += $b->month_bdays;


                            // in Day
                            foreach($this->params->days as $n=>$d)
                            {
                                if($d->strtotime >= $b->u_arrive && $d->strtotime <= $b->u_depart)
                                    $this->params->days[$n]->beds_filled += $b->b_beds_count;

                                if($d->beds > $this->params->max_days)
                                    $this->params->max_days = $d->beds;
                            }
                        }





                    }


                    // history stat
                    if(!empty($this->result->history))
                    {
                        foreach($this->result->history as $n=>$d)
                        {
                            if($b->u_date_created <= $d->strtotime || $b->u_date_created > $this->params->u_now_month_last_day)
                            {
                                if($this->params->houses[$b->house_id]->days_beds_count > 0)
                                    $this->result->history[$n]->occupancy_bdays += $b->month_bdays;

                                // in day
                                // foreach($d->days as $nn=>$dd)
                                // {
                                // 	if($dd->strtotime >= $b->u_arrive && $dd->strtotime <= $b->u_depart)
                                // 	{
                                // 		$this->result->history[$n]->days[$nn]->beds_filled += $b->b_beds_count;

                                // 		if($dd->future == true)
                                // 		{
                                // 			$this->result->history[$n]->max_beds += $this->params->days[$nn]->beds;
                                // 		}
                                // 		else
                                // 		{
                                // 			$this->result->history[$n]->max_beds += $dd_b_beds_count;
                                // 		}

                                // 	}
                                // }
                            }
                        }

                    }
                }

            }

        }


        // in Days Occupancy
        foreach($this->params->days as $n=>$d)
        {
            if($n > 0)
            {
                $this->params->days[$n]->col_height = ceil($d->beds / $this->params->max_days * 100);
                $this->params->days[$n]->occupancy = ceil($d->beds_filled / $d->beds * 100);

                if(!empty($this->params->day))
                {
                    if($d->selected === true || $d->after_selected === true)
                    {
                        $this->result->max_beds += $d->beds;
                    }
                    else
                    {
                        $this->result->max_beds += $d->beds_filled;
                    }
                }
                else
                {
                    if($d->today == true || $d->future == true)
                        $this->result->max_beds += $d->beds;
                    else
                        $this->result->max_beds += $d->beds_filled;
                }
            }
        }



        // history stats
        if(!empty($this->result->history))
        {
            foreach($this->result->history as $n=>$d)
            {
                $this->result->history[$n]->occupancy = ceil($d->occupancy_bdays / $this->result->days_beds_count * 100);

                if($n < 8)
                    $group_id = 1;
                elseif($n > 7 && $n < 15)
                    $group_id = 2;
                elseif($n > 14 && $n < 22)
                    $group_id = 3;
                elseif($n > 21 )
                    $group_id = 4;

                if($group_id > 1 && !isset($this->result->days_groups[$group_id]->start) && !empty($this->result->days_groups[$group_id-1]->end))
                    $this->result->days_groups[$group_id]->start = $this->result->days_groups[$group_id-1]->end;

                if(!isset($this->result->days_groups[$group_id]->start))
                    $this->result->days_groups[$group_id]->start = $this->result->history[$n]->occupancy;

                $this->result->days_groups[$group_id]->end = $this->result->history[$n]->occupancy;

                if(isset($this->result->days_groups[$group_id]->start) && isset($this->result->days_groups[$group_id]->end))
                    $this->result->days_groups[$group_id]->growth = $this->result->days_groups[$group_id]->end - $this->result->days_groups[$group_id]->start;


                if(!isset($this->result->growth->start))
                    $this->result->growth->start = $this->result->history[$n]->occupancy;

                $this->result->growth->end = $this->result->history[$n]->occupancy;
            }


            if(isset($this->result->growth->start) && isset($this->result->growth->end))
                $this->result->growth->sum = $this->result->growth->end - $this->result->growth->start;
        }



        $this->result->occupancy = ceil($this->result->occupancy_bdays / $this->result->days_beds_count * 100);


        // Max occupancy
        $this->result->max_occupancy = ceil($this->result->max_beds / $this->result->days_beds_count * 100);
        if($this->result->max_occupancy > 100)
            $this->result->max_occupancy = 100;


        $this->result->occupancy_average = 0;
        $this->result->occupancy_average_sum = 0;
        $this->result->occupancy_average_houses = 0;
        foreach($this->params->houses as $h)
        {
            if(isset($this->params->houses[$h->id]->days_beds_count))
                $this->params->houses[$h->id]->occupancy = ceil($this->params->houses[$h->id]->occupancy_bdays / $this->params->houses[$h->id]->days_beds_count * 100);

            if($this->params->houses[$h->id]->occupancy > 100)
                $this->params->houses[$h->id]->occupancy = 100;
            elseif(empty($this->params->houses[$h->id]->occupancy))
                $this->params->houses[$h->id]->occupancy = 0;

            if(empty($this->params->houses[$h->id]->days_beds_count) && !empty($this->params->houses[$h->id]->beds_tcount) && !empty($this->params->houses[$h->id]->occupancy_bdays2))
            {
                $this->params->houses[$h->id]->occupancy2 = ceil($this->params->houses[$h->id]->occupancy_bdays2 / $this->params->houses[$h->id]->beds_tcount * 100);
            }
            elseif(!empty($this->params->houses[$h->id]->beds_tcount) && !empty($this->params->houses[$h->id]->days_beds_count))
                unset($this->params->houses[$h->id]->beds_tcount);


            if($h->parent_id > 0 && isset($this->result->city_houses[$h->parent_id]) && $h->days_beds_count > 0)
            {
                $this->result->occupancy_average_houses ++;
                $this->result->occupancy_average_sum += $this->params->houses[$h->id]->occupancy;

                $this->result->city_houses[$h->parent_id]->houses ++;
                $this->result->city_houses[$h->parent_id]->occupancy_average_sum += $this->params->houses[$h->id]->occupancy;
            }


            if(isset($this->result->city_houses[$h->id]))
            {
                $this->result->city_houses[$h->id] = $this->params->houses[$h->id];

            }
        }

        $this->result->occupancy_average = ceil($this->result->occupancy_average_sum / $this->result->occupancy_average_houses);


        foreach($this->result->city_houses as $city_id=>$c)
        {
            if($c->parent_id == 0 && $c->days_beds_count > 0)
            {
                $this->result->city_houses[$city_id]->occupancy = ceil($c->occupancy_bdays / $c->days_beds_count * 100);
                $this->result->city_houses[$city_id]->occupancy_average = ceil($c->occupancy_average_sum / $c->houses);

                if($this->result->city_houses[$city_id]->occupancy > 100)
                    $this->result->city_houses[$city_id]->occupancy = 100;
            }

            if (isset($params['house_id']) && (int)$params['house_id'] == $city_id) {
                $this->result->house = $this->result->city_houses[$city_id];
            }
        }





        if(!empty($params['save_cache']) && !empty($this->result))
        {
            $this->cache->set_data(
                'occupancy',
                [
                    'month' => $params['month'],
                    'year'  => $params['year']
                ],
                $this->result
            );
        }

        return $this->result;


    }

}
