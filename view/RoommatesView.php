<?PHP
require_once('View.php');

class RoommatesView extends View
{
	function fetch()
	{
		if(empty($this->user))
		{
			header('Location: '.$this->config->root_url.'/user/login');
			exit();
		}


		$guest = new stdClass;

		if(!empty($this->user))
		{
			$guest = $this->user;

			// House Info
			if(!empty($guest->house_id))
			{
				$house = $this->pages->get_page((int)$guest->house_id);
				if(!empty($house))
				{
					if(!empty($house->blocks2))
						$house->blocks2 = unserialize($house->blocks2);

					$guest->house = $house;

					unset($house);
				}
			}

			$guest->booking = $this->beds->get_bookings(array(
				'id' => $guest->active_booking_id, 
				'not_canceled' => 1,
				'limit' => 1
			));



			
			if(!empty($guest->booking) && $guest->booking->type == 1)
			{
				$guest->bed = $this->beds->get_beds(array('id'=>$guest->booking->object_id, 'limit'=>1));
			    $guest->room = $this->beds->get_rooms(array('id'=>$guest->bed->room_id, 'limit'=>1));
			    $guest->apt = $this->beds->get_apartments(array('id'=>$guest->room->apartment_id, 'limit'=>1));
			}
			elseif(!empty($guest->booking))
			{
			    $guest->apt = $this->beds->get_apartments(array('id'=>$guest->booking->apartment_id, 'limit'=>1));
			}


			if(!empty($guest->apt))
			{
				$roommates = $this->beds->get_bookings(array(
					'apartment_id' => $guest->apt->id, 
					'not_canceled' => 1,
					'select_users' => true,
					'now' => 1
				));
			}



			if(!empty($roommates))
			foreach ($roommates as $booking) 
			{
				if($booking->type == 1)
				{
					$booking->bed = $this->beds->get_beds(array('id'=>$booking->object_id, 'limit'=>1));
			    	$booking->room = $this->beds->get_rooms(array('id'=>$booking->bed->room_id, 'limit'=>1));
				}
			}

			// Houseleader
			if($this->user->type == 2)
			{
				$hl_houses = $this->users->get_houseleaders_houses(array('user_id'=>$this->user->id));
				foreach ($hl_houses as $hl_h) 
				{
					$hl_h_ids[] = $hl_h->house_id;
				}
				$houses_filter = array(
		            'menu_id' => 5, 
		            'not_tree' => 1,
		            'visible' => 1
		        );
				$houses_filter['id'] = $hl_h_ids;


				$houses_arr = $this->pages->get_pages($houses_filter);


				// ROOMS TYPES
				$rooms_types_ = $this->beds->get_rooms_types(array('visible'=>1));
				$rooms_types = array();
				if(!empty($rooms_types_))
				{
					foreach($rooms_types_ as $rt)
						$rooms_types[$rt->id] = $rt;
					unset($rooms_types_);
				}


				$this->design->assign('rooms_types', $rooms_types);
				// LABELS
				$rooms_labels = $this->beds->get_labels();
				$this->design->assign('rooms_labels', $rooms_labels);

				$filter['house_id'] = $hl_h_ids;

				$beds = $this->beds->get_beds($filter); 

				if(!empty($beds))
			  	{	
			  		$rooms_ids = array();
			  		$beds_ids = array();
			        $rooms_beds_ids = array();
			  		foreach($beds as $b)
			  		{
			  			$beds_ids[$b->id] = $b->id;
			  			if(!isset($rooms[$b->room_id]))
			  				$rooms[$b->room_id] = array();

			  			if(!empty($b->group_id))
			  				$rooms[$b->room_id]['beds']['g'.$b->group_id][$b->id] = $b;
			  			else
			  				$rooms[$b->room_id]['beds'][$b->id] = $b;

			            $rooms_beds_ids[$b->room_id][$b->id] = $b->id;
			  		}
			  		unset($beds);

			  		foreach($rooms as $room_id=>$r)
			  		{
			  			if(isset($r['beds']))
			  			{
			  				foreach($r['beds'] as $group_id=>$b)
			  				{
			  					if(is_array($b) && count($b)<2)
			  					{
			  						$bad = current($b);
			  						$rooms[$room_id]['beds'][$bad->id] = $bad;
			  						unset($rooms[$room_id]['beds'][$group_id]);
			  					}
			  				}
			  			}
			  		}

			  		// Rooms
			  		if(!empty($rooms))
			  		{
			  			$rooms_ids = array_keys($rooms);
			            $apartments_ids = array();
			            //$apartments_rooms_ids = array();
			            
			  			$rooms_ = $this->beds->get_rooms(array(
			                'id'=>$rooms_ids, 
			                'visible'=>1
			                // sort'=>'price'
			            ));
			  			if(!empty($rooms_))
			  			{
			  				foreach($rooms_ as $r)
			  				{
			  					$r_arr = (array)$r;
			  					if(isset($rooms[$r->id]))
			  						$rooms[$r->id] = array_merge($rooms[$r->id], $r_arr);



			  					$houses_rooms[$r->house_id][$r->apartment_id][$r->id] = $r->id;

			  					if(isset($houses_arr[$r->house_id]))
			  					{
			  						if(isset($cities[$houses_arr[$r->house_id]->parent_id]))
			  							$cities_rooms[$houses_arr[$r->house_id]->parent_id] = 1;
			  					}

			                    if(!empty($r->apartment_id))
			                        $apartments_ids[$r->apartment_id] = $r->apartment_id;
			                    //$rooms_apartments[$r->apartment_id][$r->id] = $r->id;

			                    if(isset($rooms_beds_ids[$r->id]))
			                    {
			                        foreach($rooms_beds_ids[$r->id] as $bed_id)
			                            $apartments_beds_ids[$r->apartment_id][$bed_id] = $bed_id;
			                    }
			  				}
			  				foreach($rooms as $k=>$r)
			  					$rooms[$k] = (object)$rooms[$k];

			  				unset($rooms_);

			  				// Rooms labels
							$rooms_labels = array();
						  	foreach($this->beds->get_room_labels($rooms_ids) as $rl)
						  		$rooms[$rl->room_id]->labels[] = $rl;

			                // Apartments
			                if(!empty($apartments_ids))
			                {
			                    $apartments_ = $this->beds->get_apartments(array(
			                        'id' => $apartments_ids,
			                        'limit' => count($apartments_ids) + 1
			                    ));
			                    if(!empty($apartments_))
			                    {
			                        foreach($apartments_ as $a)
			                        {
			                            $a->to_booking = true;
			                            $apartments[$a->id] = $a;
			                        }
			                        unset($apartments_);
			                    }
			                }
			  			}	
			  		}
			  	}



				$bookings_hl = $this->beds->get_bookings(array(
					'house_id'=>$hl_h_ids, 
					'now'=>1, 
					'not_canceled' => 1,
					'select_users' => true
				));
				$bookings_hl = $this->request->array_to_key($bookings_hl, 'id');

				$contracts = $this->contracts->get_contracts(array('reserv_id'=>array_keys($bookings_hl)));
				foreach ($contracts as $c) 
				{
					$bookings_hl[$c->reserv_id]->contract = $c;
				}

				$beds_bookings = array();
				$apartments_bookings = array();
				foreach ($bookings_hl as $b) 
				{
					if($b->type == 1)
						$beds_bookings[$b->object_id][] = $b;
					else
						$apartments_bookings[$b->object_id][] = $b;
				}

            	$this->design->assign('apartments_bookings', $apartments_bookings);
            	$this->design->assign('beds_bookings', $beds_bookings);

				$this->design->assign('apartments', $apartments);
			 	$this->design->assign('rooms', $rooms);
			 	$this->design->assign('houses_rooms', $houses_rooms);
			 	$this->design->assign('houses_arr', $houses_arr);

			}

		}



		if(!empty($roommates))
			$this->design->assign('roommates', $roommates);	

		$this->design->assign('guest', $guest);	
		$this->design->assign('meta_title', $this->user->name);
		return $this->design->fetch('roommates.tpl');
	}
}
