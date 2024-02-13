<?php

require_once('Backend.php');

class Properties extends Backend
{

	public const BATHROOM_LABEL_ID = 4;

	public function get_houses()
	{
		$houses = $this->pages->get_pages([
			'menu_id' => 5,
			'visible' => 1,
			'not_parent_id' => 0
		]);

		return $this->build_houses_json($houses);
	}

	public function build_houses_json($houses)
	{
		if(!empty($houses))
		{
			$json = [];

			foreach($houses as $h)
			{
				$json[$h->id] = [
					'id' => $h->id,
					'name' => $h->name
				];
			}

			return json_encode([
				"houses" => $json
			]);
		}

		return false;
	}

	public function get_properties($houseId, $receiver)
	{
		if(!empty($houseId))
		{
			$house = $this->pages->get_page(intval($houseId));
			if(!empty($house))
			{
				if(!empty($house->blocks2))
				{
					$house->blocks2 = unserialize($house->blocks2);
				}

				$apts = $this->beds->get_apartments([
					'house_id' => $houseId,
					'visible' => 1
				]);
				$apts = $this->request->array_to_key($apts, 'id');				

				$rooms = $this->beds->get_rooms([
					'house_id' => $houseId,
					'visible' => 1
				]);
				$rooms = $this->request->array_to_key($rooms, 'id');

				$beds = $this->beds->get_beds([
					'house_id' => $houseId,
					'visible' => 1
				]);
				$beds = $this->request->array_to_key($beds, 'id');

				foreach($beds as $bed)
				{
					$rooms[$bed->room_id]->beds[$bed->id] = $bed;
				}

				$rooms_labels = $this->beds->get_room_labels(array_keys($rooms));
				foreach($rooms_labels as $rl)
				{
					$rooms[$rl->room_id]->labels[$rl->id] = $rl;
				}

				foreach($rooms as $room)
				{
					if(isset($room->labels[static::BATHROOM_LABEL_ID]))
					{
						$room->bathroom = 1;
					}
					else
					{
						$room->bathroom = 0;
					}
					$apts[$room->apartment_id]->rooms[$room->id] = $room;
				}

				$apt_bookings = $this->beds->get_bookings([
					'object_id' => array_keys($apts),
					'type' => 2,
					'is_due' => 1
				]);

				foreach($apt_bookings as $a_b)
				{
					$apts[$a_b->object_id]->bookings[$a_b->id] = $a_b;
					if((!isset($apts[$a_b->object_id]->free_from) || $a_b->depart > $apts[$a_b->object_id]->free_from) && $a_b->depart >= date('Y-m-d'))
					{
						$apts[$a_b->object_id]->free_from = $a_b->depart;
					}
				}

				$beds_bookings = $this->beds->get_bookings([
					'object_id' => array_keys($beds),
					'type' => 1,
					'is_due' => 1
				]);

				foreach($beds_bookings as $b_b)
				{
					$apts[$rooms[$beds[$b_b->object_id]->room_id]->apartment_id]->rooms[$beds[$b_b->object_id]->room_id]->beds[$b_b->object_id]->bookings[$b_b->id] = $b_b;

					if((!isset($apts[$rooms[$beds[$b_b->object_id]->room_id]->apartment_id]->rooms[$beds[$b_b->object_id]->room_id]->free_from) || $b_b->depart > $apts[$rooms[$beds[$b_b->object_id]->room_id]->apartment_id]->rooms[$beds[$b_b->object_id]->room_id]->free_from) && $b_b->depart >= date('Y-m-d'))
					{
						$apts[$rooms[$beds[$b_b->object_id]->room_id]->apartment_id]->rooms[$beds[$b_b->object_id]->room_id]->free_from = $b_b->depart;
					}
				}

				return $this->build_properties_json($house, $apts, $receiver);
			}
		}
	}

	public function build_properties_json($house, $apts, $receiver)
	{
		if($receiver == "Philadelphia")
		{
			foreach($apts as $apt)
			{
				foreach($apt->rooms as $property)
				{
					$properties[] = [
					    'id' => $property->id,
					    'copy' => [
					    	'title' => [
					    		'en' => $property->title
					    	],
					    	'description' => [
					    		'en' => $property->description
					    	]
					    ],
					    'stay' => [
			                "max_days" => "240",
			                "min_days" => "150"
			            ],
					    'type' => 'apartment',
					    'status' => 'active',
					    'pricing' => [
					    	'bills' => [
					    		[
					    			'name' => 'wifi',
					    			'value' => $house->blocks2['wifi_bill'] ?? 0,
					    			'option' => $house->blocks2['wifi_bill'] > 0 ? 'not_included' : 'included'
					    		],
					    		[
					    			'name' => 'water',
					    			'value' => $house->blocks2['water_bill'] ?? 0,
					    			'option' => $house->blocks2['water_bill'] > 0 ? 'not_included' : 'included'
					    		],
					    		[
					    			'name' => 'gas',
					    			'value' => $house->blocks2['gas_bill'] ?? 0,
					    			'option' => $house->blocks2['gas_bill'] > 0 ? 'not_included' : 'included'
					    		],
					    		[
					    			'name' => 'electricity',
					    			'value' => $house->blocks2['electricity_bill'] ?? 0,
					    			'option' => $house->blocks2['electricity_bill'] > 0 ? 'not_included' : 'included'
					    		]
					    	],
					    	'deposit' => $property->price3,
					    	'monthly' => $property->price3
					    ],
					    'location' => [
					    	'city' => $house->blocks2['city'],
					    	'address' => $house->blocks2['street_address'],
					    	'country' => 'USA',
					    	'latitude' => $house->blocks2['latitude'],
					    	'longitude' => $house->blocks2['longitude'],
					    	'postal_code' => $house->blocks2['postal'],
					    	'street_number' => $house->blocks2['street_number']
					    ]
					];
				}
			}
		}
		elseif($receiver == 'Alpaca')
		{
			$root_apt_url = $this->config->root_url.'/'.$this->config->apartments_files_dir;
			$root_room_url = $this->config->root_url.'/'.$this->config->rooms_files_dir;

			foreach($apts as $apt)
			{
				if(!isset($apt->free_from))
				{
					$apt->free_from = date('Y-m-d');
				}

				foreach($apt->rooms as $property)
				{
					if(!isset($property->free_from))
					{
						$property->free_from = date('Y-m-d');
					}

					if($apt->free_from >= $property->free_from)
						$free_from = $apt->free_from;
					else
						$free_from = $property->free_from;

					$properties[$property->id] = [
					    'id' => $property->id,
					    'title' =>  $property->title,
					    'description' => $property->description,
					    'total_rent' => $property->price3 . '.00',
					    'lease_term' => 6,
					    'bedrooms' => count($property->beds) . '.0',
					    'bathrooms' => $property->bathroom . '.0',
                        'total_room_count' => count($apt->rooms) . '.0',
					    'free_from' => $free_from,
					    'address' => [
					    	'city' => $house->blocks2['city'],
					    	'district' => $house->blocks2['district'],
					    	'street' => $house->blocks2['street_address'],
					    	'street_number' => $house->blocks2['street_number'],
					    	'unit_number' => $apt->name,
					    	'coordinates' => [$house->blocks2['longitude'], $house->blocks2['latitude']]
					    ],
					    'tour_url' => $apt->tour_3d,
					    'furnished' => $apt->furnished == 1 ? 'true' : 'false'
					];

					if(!empty($property->images))
					{
						$property->images = unserialize($property->images);
						foreach ($property->images as $img) 
						{
							$properties[$property->id]['images'][] = $root_room_url . $property->id . '/' . $img;
						}
					}
					elseif(!empty($apt->images))
					{
						$apt->images = unserialize($apt->images);
						foreach ($apt->images as $img) 
						{
							$properties[$property->id]['images'][] = $root_apt_url . $apt->id . '/' . $img;
						}
					}
				}
			}
		}

		$result = json_encode([
			"properties" => $properties
		]);

		return $result;
	}
}
