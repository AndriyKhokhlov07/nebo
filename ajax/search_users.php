<?php
	require_once('../api/Backend.php');
	$backend = new Backend();
	$limit = 100;
	
	$keyword = $backend->request->get('query', 'string');
	$get_house_info = $backend->request->get('get_house_info', 'integer');
	$get_booking_info = $backend->request->get('get_booking_info', 'integer');
	$get_house_houseleaders = $backend->request->get('get_house_houseleaders', 'integer');
	$house_id = $backend->request->get('search_house_id', 'integer');

	$group_by = 'GROUP BY u.id';
	$house_select = '';
	$house_filter = '';
	if(!empty($get_house_info))
	{
		$house_select = 'p.name as house_name, p.blocks2 as blocks2, ';
		$house_filter = $backend->db->placehold('LEFT JOIN __pages p ON p.id=u.house_id');
	}

	$bj_house_filter = '';
	$bj_filter = '';
	if(!empty($get_booking_info))
	{
		if(!empty($house_id))
			$bj_house_filter = ' AND bj.house_id='.$house_id;
		$bj_filter = $backend->db->placehold('LEFT JOIN __bookings bj ON bj.id=u.active_booking_id');
	}
	

	$query = $backend->db->placehold('SELECT
				'.$house_select.'
				u.id, 
				u.name,
				u.first_name,
				u.middle_name,
				u.last_name,
				u.email,
				u.phone,

				bj.house_id as house_id,
				bj.object_id as bed_id,
				bj.client_type_id as client_type_id
			FROM __users u
				'.$bj_filter.'
			WHERE 1
				'.$bj_house_filter.' 
				AND (u.name LIKE "%'.$backend->db->escape($keyword).'%" OR u.email LIKE "%'.$backend->db->escape($keyword).'%")
			'.$group_by.'
			ORDER BY u.name
			LIMIT ?', $limit);


	$backend->db->query($query);
	

	$users_ = $backend->db->results();
	
	$suggestions = array();

	if(!empty($users_))
	{
		/*foreach($users as $user)
		{
			$suggestion = new stdClass();

			$suggestion->value = $user->first_name;	
			if(!empty($user->middle_name))	
				$suggestion->value .= ' '.$user->middle_name;
			if(!empty($user->last_name))	
				$suggestion->value .= ' '.$user->last_name;
			if(!empty($user->email))	
				$suggestion->value .= ' ('.$user->email.')';

			if(!empty($user->bed_id))
			{
				$user->bed = current($backend->beds->get_beds(array('id'=>$user->bed_id)));
				$user->room = current($backend->beds->get_rooms(array('id'=>$user->bed->room_id)));
				if(!empty($user->room->apartment_id))
					$user->apartment = current($backend->beds->get_apartments(array('id' => $user->room->apartment_id)));
			}

			$suggestion->data = $user;
			if(!empty($suggestion->data->blocks2))
				$suggestion->data->blocks2 = unserialize($suggestion->data->blocks2);

			$suggestions[] = $suggestion;
		}*/


		$users = array();
		$beds = array();
		$rooms = array();
		$apartments = array();
		$houses_users_ids = array();
		$beds_users_ids = array();
		$rooms_beds_ids = array();
		$apartments_rooms_ids = array();
		foreach($users_ as $user)
		{
			$users[$user->id] = $user;

			if(!empty($user->bed_id))
				$beds_users_ids[$user->bed_id][$user->id] = $user->id;

			if(!empty($user->house_id))
				$houses_users_ids[$user->house_id][$user->id] = $user->id;

		}
		unset($users_);


		if(!empty($beds_users_ids) && !empty($get_booking_info))
		{
			// Beds
			$beds_ = $backend->beds->get_beds(array('id'=>array_keys($beds_users_ids)));
			if(!empty($beds_))
			{
				foreach($beds_ as $bed)
				{
					$beds[$bed->id] = $bed;
					$rooms_beds_ids[$bed->room_id][$bed->id] = $bed->id;

				}
				unset($beds_);

				// Rooms
				if(!empty($rooms_beds_ids))
				{
					$rooms_ = $backend->beds->get_rooms(array(
						'id' => array_keys($rooms_beds_ids),
						'visible' => 1
					));
					if(!empty($rooms_))
					{
						foreach($rooms_ as $room)
						{
							$rooms[$room->id] = $room;
							if(!empty($room->apartment_id))
								$apartments_rooms_ids[$room->apartment_id][$room->id] = $room->id;
						}
					}
					unset($rooms_);

					// Apartments
					if(!empty($apartments_rooms_ids))
					{
						$apartments_ = $backend->beds->get_apartments(array(
							'id' => array_keys($apartments_rooms_ids),
							'visible' => 1
						));

						if(!empty($apartments_))
						{
							foreach($apartments_ as $apartment)
							{
								if(!empty($apartments_rooms_ids[$apartment->id]))
								{
									foreach($apartments_rooms_ids[$apartment->id] as $room_id)
									{
										if(isset($rooms[$room_id]))
											$rooms[$room_id]->apartment = $apartment;
									}
								}
							}
						}
						unset($apartments_);
					}

					if(!empty($rooms))
					{
						foreach($rooms as $room)
						{
							if(!empty($rooms_beds_ids[$room->id]))
							{
								foreach($rooms_beds_ids[$room->id] as $bed_id)
								{
									if(isset($beds[$bed_id]))
									{
										$beds[$bed_id]->room = $room;
									}
								}
							}
						}
					}
				}

				if(!empty($beds))
				{
					foreach($beds as $bed)
					{
						if(!empty($beds_users_ids[$bed->id]))
						{
							foreach($beds_users_ids[$bed->id] as $user_id)
							{
								if(isset($users[$user_id]))
								{
									$users[$user_id]->bed = $bed;

									if(!empty($bed->room))
									{
										$users[$user_id]->room = $bed->room;
										unset($users[$user_id]->bed->room);

										if(!empty($users[$user_id]->room->apartment))
										{
											$users[$user_id]->apartment = $users[$user_id]->room->apartment;
											unset($users[$user_id]->room->apartment);
										}
									}
								}
							}
						}
					}
				}
			}
		}


		// Houseleaders in houses
		if(!empty($get_house_houseleaders) && !empty($houses_users_ids))
		{
			$houseleaders_houses_ = $backend->users->get_houseleaders_houses(array('house_id'=>array_keys($houses_users_ids)));
			if(!empty($houseleaders_houses_))
			{
				$houses_houseleaders_ids = array(); 
				$houseleaders_ids = array();
				foreach($houseleaders_houses_ as $h)
				{
					$houses_houseleaders_ids[$h->user_id][$h->house_id] = $h->user_id;
					$houseleaders_ids[$h->user_id] = $h->user_id;
				}
				unset($houseleaders_houses_);

				$houseleaders_ = $backend->users->get_users(array(
					'id' => $houseleaders_ids,
					'enabled' => 1
				));

				if(!empty($houseleaders_))
				{
					$houseleaders = array();
					foreach($houseleaders_ as $hl)
						$houseleaders[$hl->id] = $hl;
					unset($houseleaders_);

					foreach($houses_houseleaders_ids as $h_user_id=>$h_houses)
					{
						if(!empty($h_houses))
						{
							foreach($h_houses as $h_house_id=>$u_id)
							{
								if(isset($houseleaders[$h_user_id]) && isset($houses_users_ids[$h_house_id]))
								{
									foreach($houses_users_ids[$h_house_id] as $user_id)
									{
										if(!empty($users[$user_id]))
											$users[$user_id]->houseleaders[$h_user_id] = $houseleaders[$h_user_id];
									}
								}
							}
						}	
					}
				}
			}

		}

		foreach($users as $user)
		{
			$suggestion = new stdClass();

			$suggestion->value = $user->first_name;	
			if(!empty($user->middle_name))	
				$suggestion->value .= ' '.$user->middle_name;
			if(!empty($user->last_name))	
				$suggestion->value .= ' '.$user->last_name;
			if(!empty($user->email))	
				$suggestion->value .= ' ('.$user->email.')';

			$suggestion->data = $user;
			if(!empty($suggestion->data->blocks2))
				$suggestion->data->blocks2 = unserialize($suggestion->data->blocks2);

			$suggestions[] = $suggestion;
		}
		
	}
	

	$res = new stdClass;
	$res->query = $keyword;
	$res->suggestions = $suggestions;
	header("Content-type: application/json; charset=UTF-8");
	header("Cache-Control: must-revalidate");
	header("Pragma: no-cache");
	header("Expires: -1");		
	print json_encode($res);
