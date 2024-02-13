<?php


require_once('Backend.php');

class Beds extends Backend
{
	// House ID by Bed ID
	public function get_house_id($filter = array())
	{
		if(!empty($filter['bed_id']))
		{
			$query = $this->db->placehold('SELECT 
					r.house_id
				FROM __rooms r
				LEFT JOIN __beds b ON b.room_id=r.id
				WHERE b.id=?
				LIMIT 1
			', intval($filter['bed_id']));
		}

		if(empty($query))
			return false;

		$this->db->query($query);
		return $this->db->result('house_id');
	}


	// -----------------------
	// ---- neighborhoods ----
	// -----------------------

	public function get_neighborhoods($filter = array())
	{
		$id_filter = '';
		$city_id_filter = '';
		$group_by = '';
		$limit = 1000;
		$page = 1;

		if(isset($filter['limit']))
			$limit = max(1, intval($filter['limit']));

		if(isset($filter['page']))
			$page = max(1, intval($filter['page']));

		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND n.id in(?@)', (array)$filter['id']);

		if(!empty($filter['city_id']))
			$city_id_filter = $this->db->placehold('AND n.city_id in(?@)', (array)$filter['city_id']);

		$sql_limit = $this->db->placehold(' LIMIT ?, ? ', ($page-1)*$limit, $limit);


		$query = $this->db->placehold("SELECT
				n.id,  
				n.city_id,
				n.name,
				n.position
			FROM __neighborhoods n
			WHERE 
				1
				$id_filter
				$city_id_filter
			$group_by
			ORDER BY n.position
			$sql_limit");

		$this->db->query($query);

		if(isset($filter['limit']) && $filter['limit'] == 1)
			return $this->db->result();
		else
			return $this->db->results();
	}

	public function count_neighborhoods($filter = array())
	{
		$id_filter = '';
		$city_id_filter = '';

		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND n.id in(?@)', (array)$filter['id']);

		if(!empty($filter['city_id']))
			$city_id_filter = $this->db->placehold('AND n.city_id in(?@)', (array)$filter['city_id']);

		$query = "SELECT 
				COUNT(distinct n.id) as count
		    FROM __neighborhoods n
		    WHERE 1 
	          	$id_filter 
	          	$city_id_filter";

		if($this->db->query($query))
			return $this->db->result('count');
		else
			return false;
	}

	public function add_neighborhood($neighborhood)
	{	
		$query = $this->db->placehold('INSERT INTO __neighborhoods SET ?%', $neighborhood);
		if(!$this->db->query($query))
			return false;

		$id = $this->db->insert_id();
		$this->db->query("UPDATE __neighborhoods SET position=id WHERE id=?", $id);	
		return $id;
	}

	public function update_neighborhood($id, $neighborhood)
	{
		$query = $this->db->placehold("UPDATE __neighborhoods SET ?% WHERE id in(?@) LIMIT ?", $neighborhood, (array)$id, count((array)$id));
		$this->db->query($query);
		return $id;
	}

	public function delete_neighborhood($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __neighborhoods WHERE id=? LIMIT 1", intval($id));
			$this->db->query($query);
		}
	}


    // -----------------------
    // ---- districts ----
    // -----------------------

    public function get_districts($filter = array())
    {
        $id_filter = '';
        $city_id_filter = '';
        $group_by = '';
        $limit = 1000;
        $page = 1;

        if(isset($filter['limit']))
            $limit = max(1, intval($filter['limit']));

        if(isset($filter['page']))
            $page = max(1, intval($filter['page']));

        if(!empty($filter['id']))
            $id_filter = $this->db->placehold('AND d.id in(?@)', (array)$filter['id']);

        if(!empty($filter['city_id']))
            $city_id_filter = $this->db->placehold('AND d.city_id in(?@)', (array)$filter['city_id']);

        $sql_limit = $this->db->placehold(' LIMIT ?, ? ', ($page-1)*$limit, $limit);


        $query = $this->db->placehold("SELECT
				d.id,  
				d.city_id,
				d.name,
				d.position
			FROM __districts d
			WHERE 
				1
				$id_filter
				$city_id_filter
			$group_by
			ORDER BY d.position
			$sql_limit");

        $this->db->query($query);

        if(isset($filter['limit']) && $filter['limit'] == 1)
            return $this->db->result();
        else
            return $this->db->results();
    }

    public function count_districts($filter = array())
    {
        $id_filter = '';
        $city_id_filter = '';

        if(!empty($filter['id']))
            $id_filter = $this->db->placehold('AND d.id in(?@)', (array)$filter['id']);

        if(!empty($filter['city_id']))
            $city_id_filter = $this->db->placehold('AND d.city_id in(?@)', (array)$filter['city_id']);

        $query = "SELECT 
				COUNT(distinct d.id) as count
		    FROM __districts d
		    WHERE 1 
	          	$id_filter 
	          	$city_id_filter";

        if($this->db->query($query))
            return $this->db->result('count');
        else
            return false;
    }

    public function add_district($district){
        $query = $this->db->placehold('INSERT INTO __districts SET ?%', $district);
        if(!$this->db->query($query))
            return false;

        $id = $this->db->insert_id();
        $this->db->query("UPDATE __districts SET position=id WHERE id=?", $id);
        return $id;
    }

    public function update_district($id, $district){
        $query = $this->db->placehold("UPDATE __districts SET ?% WHERE id in(?@) LIMIT ?", $district, (array)$id, count((array)$id));
        $this->db->query($query);
        return $id;
    }

    public function delete_district($id) {
        if (!empty($id)) {
            $query = $this->db->placehold("DELETE FROM __districts WHERE id=? LIMIT 1", intval($id));
            $this->db->query($query);
        }
    }



	// -----------------------
	// ----- apartments -----
	// -----------------------

	public $apartment_types = array(
		1 => ['name' => 'Coliving'],
		2 => ['name' => 'Stabilized'],
		3 => ['name' => 'Traditional']
	);

	public function get_apartments($filter = array())
	{
		$id_filter = '';
		$house_id_filter = '';
		$floor_filter = '';
		$visible_filter = '';
		$rent_apartment_filter = '';
		$order = 'a.house_id, a.name';
		$group_by = '';
		$limit = 1000;
		$page = 1;

		if(isset($filter['limit']))
			$limit = max(1, intval($filter['limit']));

		if(isset($filter['page']))
			$page = max(1, intval($filter['page']));

		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND a.id in(?@)', (array)$filter['id']);

		if(!empty($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND a.house_id in(?@)', (array)$filter['house_id']);

		if(!empty($filter['floor']))
			$floor_filter = $this->db->placehold('AND a.floor in(?@)', (array)$filter['floor']);

		if(isset($filter['rent_apartment']))
			$rent_apartment_filter = $this->db->placehold('AND a.rent_apartment=?', intval($filter['rent_apartment']));

		if(isset($filter['visible']))
			$visible_filter = $this->db->placehold('AND a.visible=?', intval($filter['visible']));



		if(!empty($filter['sort']))
		{
			switch($filter['sort'])
			{
				case 'position':
					$order = 'a.position';
					break;
				case 'name':
					$order = 'a.house_id, a.name';
					break;
			}
		}
		$order_by = 'ORDER BY '.$order;

		$sql_limit = $this->db->placehold(' LIMIT ?, ? ', ($page-1)*$limit, $limit);


		$query = $this->db->placehold("SELECT
				a.id,
				a.bed,
				a.bathroom,  
				a.floor,
				a.house_id,
				a.name,
				a.note,
				a.price,
				a.property_price,
				a.rent_apartment,
				a.tour_3d,
				a.visible,
				a.position,
				a.date_added,
				a.date_shutdown,
				a.occupancy_start,
				a.occupancy_end,
				a.furnished,
				a.utility,
				a.utility_price,
				a.blocks,
				a.images,
				a.type
			FROM __apartments a
			WHERE 
				1
				$id_filter
				$house_id_filter
				$floor_filter
				$rent_apartment_filter
				$visible_filter
			$group_by
			$order_by
			$sql_limit");

		$this->db->query($query);

		if(isset($filter['count']) && $filter['count'] == 1)
			return $this->db->result();

		if(isset($filter['limit']) && $filter['limit'] == 1)
			return $this->db->result();
		else
			return $this->db->results();
	}

	public function count_apartments($filter = array())
	{
		$id_filter = '';
		$floor_filter = '';
		$house_id_filter = '';
		$floor_filter = '';
		$rent_apartment_filter = '';
		$visible_filter = '';

		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND a.id in(?@)', (array)$filter['id']);

		if(!empty($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND a.house_id in(?@)', (array)$filter['house_id']);

		if(!empty($filter['floor']))
			$floor_filter = $this->db->placehold('AND a.floor in(?@)', (array)$filter['floor']);

		if(isset($filter['rent_apartment']))
			$rent_apartment_filter = $this->db->placehold('AND a.rent_apartment=?', intval($filter['rent_apartment']));

		if(isset($filter['visible']))
			$visible_filter = $this->db->placehold('AND a.visible = ?', intval($filter['visible']));

		$query = "SELECT 
				COUNT(distinct a.id) as count
		    FROM __apartments a
		    WHERE 1 
	          	$id_filter 
	          	$house_id_filter
	          	$floor_filter
	          	$rent_apartment_filter
	          	$visible_filter";

		if($this->db->query($query))
			return $this->db->result('count');
		else
			return false;
	}

	public function add_apartment($apartment)
	{	
		$query = $this->db->placehold('INSERT INTO __apartments SET ?%', $apartment);
		if(!$this->db->query($query))
			return false;

		$id = $this->db->insert_id();
		$this->db->query("UPDATE __apartments SET position=id WHERE id=?", $id);	
		return $id;
	}

	public function update_apartment($id, $apartment)
	{
		$query = $this->db->placehold("UPDATE __apartments SET ?% WHERE id in(?@) LIMIT ?", $apartment, (array)$id, count((array)$id));
		$this->db->query($query);
		return $id;
	}

	public function delete_apartment($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __apartments WHERE id=? LIMIT 1", intval($id));
			$this->db->query($query);
		}
	}







	// -----------------
	// ----- ROOMS -----
	// -----------------

	public function get_rooms($filter = array())
	{
		$id_filter = '';
		$house_id_filter = '';
		$type_id_filter = '';
		$apartment_id_filter = '';
		$label_select = '';
		$label_filter = '';
		$visible_filter = '';
		$is_price_filter = '';
		$is_open_filter = '';
		$apartment_select = '';
		$order_by = '';
		$group_by = '';
		$limit = 1000;
		$page = 1;

		if(isset($filter['limit']))
			$limit = max(1, intval($filter['limit']));

		if(isset($filter['page']))
			$page = max(1, intval($filter['page']));

		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND r.id in(?@)', (array)$filter['id']);

		if(!empty($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND r.house_id in(?@)', (array)$filter['house_id']);

		if(!empty($filter['type_id']))
			$type_id_filter = $this->db->placehold('AND r.type_id in(?@)', (array)$filter['type_id']);

		if(!empty($filter['apartment_id']))
			$apartment_id_filter = $this->db->placehold('AND r.apartment_id in(?@)', (array)$filter['apartment_id']);

		if(isset($filter['label']))
		{
			$label_select = 'LEFT JOIN __rooms_rlabels AS rl ON r.id=rl.room_id';
			$label_filter = $this->db->placehold('AND rl.label_id = ?', $filter['label']);
		}

		if(isset($filter['visible']))
			$visible_filter = $this->db->placehold('AND r.visible = ?', intval($filter['visible']));


		if(isset($filter['sort']))
		{
			if($filter['sort'] == 'price')
			{
				$order_by = 'r.price1, ';
			}
			elseif($filter['sort'] == 'apartment_name')
			{
				$apartment_select = 'LEFT JOIN __apartments AS a ON r.apartment_id=a.id';
				$order_by = 'a.house_id, a.name, ';
			}

		}
		


		if(isset($filter['is_price']))
			$is_price_filter = 'AND r.price1 IS NOT NULL ';

		if(isset($filter['is_open_from']) && isset($filter['is_open_to']))
		{
			$is_open_filter = $this->db->placehold('AND (r.date_added IS NULL OR r.date_added <= ?) AND (r.date_shutdown IS NULL OR r.date_shutdown >= ?)', $filter['is_open_from'], $filter['is_open_to']);
		}

		$sql_limit = $this->db->placehold(' LIMIT ?, ? ', ($page-1)*$limit, $limit);

		$query = $this->db->placehold("SELECT
				r.id,  
				r.type_id,
				r.house_id,
				r.apartment_id,
				r.name,
				r.note,
				r.price1,
				r.price2,
				r.price3,
				r.square,
				r.visible,
				r.position,
				r.color,
				r.date_added,
				r.date_shutdown,
				r.images,
				r.title,
				r.description
			FROM __rooms r
				$label_select
				$apartment_select
			WHERE 
				1
				$id_filter
				$type_id_filter
				$house_id_filter
				$apartment_id_filter
				$label_filter
				$visible_filter
				$is_price_filter
				$is_open_filter
			$group_by
			ORDER BY $order_by r.position
			$sql_limit");

		$this->db->query($query);

		if(isset($filter['limit']) && $filter['limit'] == 1)
			return $this->db->result();
		else
			return $this->db->results();
	}

	public function count_rooms($filter = array())
	{
		$id_filter = '';
		$house_id_filter = '';
		$type_id_filter = '';
		$apartment_id_filter = '';
		$visible_filter = '';
		$label_select = '';
		$label_filter = '';
		$is_open_filter = '';


		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND r.id in(?@)', (array)$filter['id']);

		if(!empty($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND r.house_id in(?@)', (array)$filter['house_id']);

		if(!empty($filter['type_id']))
			$type_id_filter = $this->db->placehold('AND r.type_id in(?@)', (array)$filter['type_id']);

		if(!empty($filter['apartment_id']))
			$apartment_id_filter = $this->db->placehold('AND r.apartment_id in(?@)', (array)$filter['apartment_id']);

		if(isset($filter['label']))
		{
			$label_select = 'LEFT JOIN __rooms_rlabels AS rl ON r.id=rl.room_id';
			$label_filter = $this->db->placehold('AND rl.label_id = ?', $filter['label']);
		}

		if(isset($filter['visible']))
			$visible_filter = $this->db->placehold('AND r.visible = ?', intval($filter['visible']));

		if(isset($filter['is_open_from']) && isset($filter['is_open_to']))
		{
			$is_open_filter = $this->db->placehold('AND (r.date_added IS NULL OR r.date_added <= ?) AND (r.date_shutdown IS NULL OR r.date_shutdown >= ?)', $filter['is_open_from'], $filter['is_open_to']);
		}

		$query = "SELECT 
				COUNT(distinct r.id) as count
		    FROM __rooms r 
		    	$label_select
		    WHERE 1 
	          	$id_filter 
	          	$house_id_filter
	          	$type_id_filter
	          	$apartment_id_filter
	          	$label_filter
	          	$visible_filter
	          	$is_open_filter";

		if($this->db->query($query))
			return $this->db->result('count');
		else
			return false;
	}


	public function count_rooms_beds($filter = array())
	{
		$id_filter = '';
		$house_id_filter = '';
		$type_id_filter = '';
		$apartment_id_filter = '';
		$visible_filter = '';
		$label_select = '';
		$label_filter = '';

		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND r.id in(?@)', (array)$filter['id']);

		if(!empty($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND r.house_id in(?@)', (array)$filter['house_id']);

		if(!empty($filter['type_id']))
			$type_id_filter = $this->db->placehold('AND r.type_id in(?@)', (array)$filter['type_id']);

		if(!empty($filter['apartment_id']))
			$apartment_id_filter = $this->db->placehold('AND r.apartment_id in(?@)', (array)$filter['apartment_id']);

		if(isset($filter['label']))
		{
			$label_select = 'LEFT JOIN __rooms_rlabels AS rl ON r.id=rl.room_id';
			$label_filter = $this->db->placehold('AND rl.label_id = ?', $filter['label']);
		}

		if(isset($filter['visible']))
			$visible_filter = $this->db->placehold('AND r.visible = ?', intval($filter['visible']));

		$query = "SELECT 
				COUNT(distinct b.id) as count
		    FROM __beds b
		    LEFT JOIN __rooms AS r ON r.id=b.room_id
		    	$label_select
		    WHERE 1 
	          	$id_filter 
	          	$house_id_filter
	          	$type_id_filter
	          	$apartment_id_filter
	          	$label_filter
	          	$visible_filter";

		if($this->db->query($query))
			return $this->db->result('count');
		else
			return false;
	}

	public function add_room($room)
	{	
		$query = $this->db->placehold('INSERT INTO __rooms SET ?%', $room);

		if(!$this->db->query($query))
			return false;

		$id = $this->db->insert_id();
		$this->db->query("UPDATE __rooms SET position=id WHERE id=?", $id);	
		return $id;
	}

	public function update_room($id, $room)
	{
		$query = $this->db->placehold("UPDATE __rooms SET ?% WHERE id in(?@) LIMIT ?", $room, (array)$id, count((array)$id));
		$this->db->query($query);
		return $id;
	}

	public function delete_room($id)
	{
		if(!empty($id))
		{
			// Delete beds
			$beds = $this->get_beds(array('room_id'=>$id));
			if(!empty($beds))
				foreach($beds as $bed)
					$this->delete_bed($bed->id);


			// Delele Romm Labels
			$room_labels = $this->get_room_labels($id);
			if($room_labels)
				foreach($room_labels as $rl)
					$this->delete_room_labels($rl->room_id, $rl->id);

			$query = $this->db->placehold("DELETE FROM __rooms WHERE id=? LIMIT 1", intval($id));
			$this->db->query($query);
		}
	}



	// -----------------------
	// ----- ROOMS TYPES -----
	// -----------------------

	public function get_rooms_types($filter = array())
	{
		$id_filter = '';
		$room_id_filter = '';

		$bed_select = '';
		$bed_id_filter = '';

		$group_by = '';
		$limit = '';

		if(isset($filter['limit']))
			$limit = $this->db->placehold('LIMIT ?', (int)$filter['limit']);

		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND rt.id in(?@)', (array)$filter['id']);

		if(!empty($filter['room_id']))
		{
			$room_id_filter = $this->db->placehold('INNER JOIN __rooms r ON r.type_id=rt.id AND r.id in(?@)', (array)$filter['room_id']);
			$group_by = "GROUP BY rt.id";
		}

		if(!empty($filter['bed_id']))
		{
			$bed_select = ', b.id as bed_id';
			$bed_id_filter = $this->db->placehold('
				JOIN __rooms r ON r.type_id=rt.id
				JOIN __beds b ON r.id=b.room_id AND b.id in(?@)
			',(array)$filter['bed_id']);

			$group_by = "GROUP BY b.id";
		}

		$query = $this->db->placehold("SELECT
				rt.id,
				rt.name,
				rt.position
				$bed_select
			FROM __rooms_types rt
				$room_id_filter
				$bed_id_filter
			WHERE 
				1
				$id_filter
			$group_by
			ORDER BY rt.position
			$limit");
		$this->db->query($query);

		if(isset($filter['limit']) && $filter['limit'] == 1)
			return $this->db->result();
		else
			return $this->db->results();
	}

	public function add_rooms_type($rooms_type)
	{	
		$query = $this->db->placehold('INSERT INTO __rooms_types SET ?%', $rooms_type);
		if(!$this->db->query($query))
			return false;

		$id = $this->db->insert_id();
		$this->db->query("UPDATE __rooms_types SET position=id WHERE id=?", $id);	
		return $id;
	}

	public function update_rooms_type($id, $rooms_type)
	{
		$query = $this->db->placehold("UPDATE __rooms_types SET ?% WHERE id in(?@) LIMIT ?", $rooms_type, (array)$id, count((array)$id));
		$this->db->query($query);
		return $id;
	}

	public function delete_rooms_type($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __rooms_types WHERE id=? LIMIT 1", intval($id));
			$this->db->query($query);
		}
	}


	// -----------------------
	// ----- ROOMS LABELS -----
	// -----------------------

	public function get_label($id)
	{
		$query = $this->db->placehold("SELECT * FROM __rlabels WHERE id=? LIMIT 1", intval($id));
		$this->db->query($query);
		return $this->db->result();
	}

	public function get_labels()
	{
		$query = $this->db->placehold("SELECT * FROM __rlabels ORDER BY position");
		$this->db->query($query);
		$labels = array();
		$result = $this->db->results();
		if(!empty($result))
			foreach($result as $r)
				$labels[$r->id] = $r;
		return $labels;
	}

	public function add_label($label)
	{	
		$query = $this->db->placehold('INSERT INTO __rlabels SET ?%', $label);
		if(!$this->db->query($query))
			return false;

		$id = $this->db->insert_id();
		$this->db->query("UPDATE __rlabels SET position=id WHERE id=?", $id);	
		return $id;
	}
	
	public function update_label($id, $label)
	{
		$query = $this->db->placehold("UPDATE __rlabels SET ?% WHERE id in(?@) LIMIT ?", $label, (array)$id, count((array)$id));
		$this->db->query($query);
		return $id;
	}

	public function delete_label($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __rooms_rlabels WHERE label_id=?", intval($id));
			if($this->db->query($query))
			{
				$query = $this->db->placehold("DELETE FROM __rlabels WHERE id=? LIMIT 1", intval($id));
				return $this->db->query($query);
			}
			else
			{
				return false;
			}
		}
	}	
	
	public function get_room_labels($room_id = array())
	{
		if(empty($room_id))
			return array();

		$room_id_filter = $this->db->placehold('AND rl.room_id in(?@)', (array)$room_id);
				
		$query = $this->db->placehold("SELECT 
						rl.room_id, 
						l.id, 
						l.name, 
						l.color, 
						l.position
					FROM __rlabels l LEFT JOIN __rooms_rlabels rl ON rl.label_id = l.id
					WHERE 
						1
						$room_id_filter   
					ORDER BY position       
					");
		
		$this->db->query($query);
		return $this->db->results();
	}
	
	public function update_room_labels($id, $labels_ids)
	{
		$labels_ids = (array)$labels_ids;
		$query = $this->db->placehold("DELETE FROM __rooms_rlabels WHERE room_id=?", intval($id));
		$this->db->query($query);
		if(is_array($labels_ids))
		foreach($labels_ids as $l_id)
			$this->db->query("INSERT INTO __rooms_rlabels SET room_id=?, label_id=?", $id, $l_id);
	}

	public function add_room_labels($id, $labels_ids)
	{
		$labels_ids = (array)$labels_ids;
		if(is_array($labels_ids))
		foreach($labels_ids as $l_id)
		{
			$this->db->query("INSERT IGNORE INTO __rooms_rlabels SET room_id=?, label_id=?", $id, $l_id);
		}
	}

	public function delete_room_labels($id, $labels_ids)
	{
		$labels_ids = (array)$labels_ids;
		if(is_array($labels_ids))
		foreach($labels_ids as $l_id)
			$this->db->query("DELETE FROM __rooms_rlabels WHERE room_id=? AND label_id=?", $id, $l_id);
	}




	// ----------------
	// ----- BEDS -----
	// ----------------

	// Clean statuses:
	// 1 => ['name' => 'Clean'],
	// 2 => ['name' => 'Dirty'],
	// 3 => ['name' => 'Checked']
	public function get_beds($filter = array())
	{
		$rooms_join = '';
		$labels_join = '';
		$id_filter = '';
		$group_id_filter = '';
		$room_id_filter = '';
		$house_id_filter = '';
		$room_type_id_filter = '';
		$room_label_filter = '';
		$price_from_filter = '';
		$price_to_filter = '';
		$floor_filter = '';
		$journal_filter = '';
		$rooms_order_by = '';
		$apartment_price_select = '';
		$apartments_join = '';
		$rent_type_filter = '';
		$visible_filter = '';
		$room_visible_filter = '';
		$group_by = '';
		$limit = '';

		if(isset($filter['limit']))
			$limit = $this->db->placehold('LIMIT ?', (int)$filter['limit']);

		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND b.id in(?@)', (array)$filter['id']);

		if(!empty($filter['group_id']))
			$group_id_filter = $this->db->placehold('AND b.group_id in(?@)', (array)$filter['group_id']);

		if(!empty($filter['room_id']))
			$room_id_filter = $this->db->placehold('AND b.room_id in(?@)', (array)$filter['room_id']);

		// rooms join
		if(!empty($filter['house_id']) || !empty($filter['room_type_id']) || !empty($filter['price_from']) || !empty($filter['price_to']) || (isset($filter['rent_type']) && $filter['rent_type']>1) || isset($filter['room_visible']))
		{
			if(isset($filter['sort']) && $filter['sort'] == 'price')
				$rooms_order_by .= 'r.price1, ';

			$rooms_join = 'LEFT JOIN __rooms AS r ON r.id=b.room_id';
			$rooms_order_by .= 'r.position, ';
		}


		if(!empty($filter['rent_type']))
		{
			// Rent type: Apartments
			if($filter['rent_type'] == 2)
			{
				$apartment_price_select = ', a.price as apartment_price';
				$apartments_join = 'LEFT JOIN __apartments AS a ON a.id=r.apartment_id';
				$rent_type_filter = 'AND a.rent_apartment=1';
			}
			
		}

		if(!empty($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND r.house_id in(?@)', (array)$filter['house_id']);

		if(!empty($filter['room_type_id']))
			$room_type_id_filter = $this->db->placehold('AND r.type_id in(?@)', (array)$filter['room_type_id']);

		if(!empty($filter['room_label']))
		{

			foreach((array)$filter['room_label'] as $label_id)
				$room_label_filter .= $this->db->placehold('AND b.id in (
					SELECT 
						bb.id 
					FROM __beds bb
					LEFT JOIN __rooms_rlabels AS bb_rl ON bb_rl.room_id=bb.room_id WHERE bb_rl.label_id=? GROUP BY bb.id)', $label_id);

		}

		if(!empty($filter['price_from']))
			$price_from_filter = $this->db->placehold('AND r.price3>=?', $filter['price_from']);

		if(!empty($filter['price_to']))
			$price_to_filter = $this->db->placehold('AND r.price3<=? AND r.price3>0', $filter['price_to']);


		if(!empty($filter['floor']))
			$floor_filter = $this->db->placehold('AND b.floor in(?@)', (array)$filter['floor']);


		if(!empty($filter['date_from']) || !empty($filter['date_to']))
		{
			$date_from = '';
			$date_to = '';
			$is_due_filter = '';
			if(!empty($filter['date_from']))
			{
				$date_from = $this->db->placehold('bj.depart>?', $filter['date_from']);
			}
			if(!empty($filter['date_to']))
			{
				if(!empty($date_from))
					$date_from .= ' AND';
				$date_to = $this->db->placehold('bj.arrive<?', $filter['date_to']);
			}

			if(!empty($filter['is_due']))
			{
				$is_due_filter = $this->db->placehold('AND (bj.due IS NULL OR bj.due>=?) AND bj.status in(1,2,3,5,6,7)', date('Y-m-d'));
			}
            elseif(!empty($filter['status_on']))
            {
                $is_due_filter = $this->db->placehold('AND bj.status in(1,2,3,5,6,7,8)');
            }
			
			$journal_filter = $this->db->placehold("AND 0=(SELECT count(bj.id) FROM __bookings bj WHERE b.id=bj.object_id AND bj.type=1 AND ($date_from $date_to) $is_due_filter LIMIT 1)");
		}

		if(isset($filter['visible']))
			$visible_filter = $this->db->placehold('AND b.visible = ?', intval($filter['visible']));

		if(isset($filter['room_visible']))
			$room_visible_filter = $this->db->placehold('AND r.visible = ?', intval($filter['room_visible']));


		$query = $this->db->placehold("SELECT
				b.id,  
				b.group_id,
				b.room_id,
				b.floor,
				b.name,
				b.note,
				b.date_added,
				b.date_shutdown,
				b.visible,
				b.position,
				b.clean_status,
				b.clean_date
				$apartment_price_select
			FROM __beds b
				$rooms_join
				$labels_join
				$apartments_join
			WHERE 
				1
				$id_filter
				$group_id_filter
				$room_id_filter
				$house_id_filter
				$rent_type_filter
				$room_type_id_filter
				$room_label_filter
				$price_from_filter
				$price_to_filter
				$floor_filter
				$journal_filter
				$visible_filter
				$room_visible_filter
			$group_by
			ORDER BY $rooms_order_by b.position
			$limit");

		$this->db->query($query);


		if(isset($filter['limit']) && $filter['limit'] == 1)
			return $this->db->result();
		else
			return $this->db->results();
	}



	

	public function add_bed($bed)
	{	
		$query = $this->db->placehold('INSERT INTO __beds SET ?%', $bed);
		if(!$this->db->query($query))
			return false;

		$id = $this->db->insert_id();
		$this->db->query("UPDATE __beds SET position=id WHERE id=?", $id);	
		return $id;
	}

	public function update_bed($id, $bed)
	{
		$query = $this->db->placehold("UPDATE __beds SET ?% WHERE id in(?@) LIMIT ?", $bed, (array)$id, count((array)$id));
		$this->db->query($query);
		return $id;
	}

	public function delete_bed($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __beds WHERE id=? LIMIT 1", intval($id));
			$this->db->query($query);
		}
	}




	// ------------------
	// ---- BOOKINGS ----
	// ------------------
	
	public $bookings_statuses = [
		0 => [
			'name' => 'Canceled',
			'icon' => 'fa-trash',
			'substatuses' => [
				0 => 'Cancel',
				1 => 'Early move out',
				2 => 'Pause of stay',
				3 => 'Change the house',
                4 => 'Move to another house',
                5 => 'Move to another apartment',
				9 => 'Other'
			]
		],
		1 => [
			'name' => 'New',
			'icon' => 'fa-tag'
		],
		2 => [
			'name' => 'Payment Pending',
			'icon' => 'fa-clock-o',
		],
		3 => [
			'name' => 'Contract / Invoice',
			'icon' => 'fa-check',
			'substatuses' => [
				1 => 'Early Move-out',
				2 => 'Early Move-in',
			]
		],
		4 => [
			'name' => 'Paid | Without living',
			'icon' => 'fa-check'
		],
		5 => [
			'name' => 'Bed/Apt Closed',
			'icon' => 'fa-times'
		],
		6 => [
			'name' => 'Reserve for sale (Ask Alex Kos)',
			'icon' => 'fa-bookmark'
		],
        7 => [
            'name' => 'Reserve for Airbnb',
            'icon' => 'fa-bookmark'
        ],
        8 => [
            'name' => 'For Summer',
            'icon' => 'fa-bookmark'
        ]
	];

	// 0 new - новые, только сделаные букинги
	// 1 pending - по ним начался сейлфлоу (человек заполнил апликейшн)
	// 2 approved - апрув влады или саши 
	// 3 guest - сделали мувин по этому букингу
	// 4 alumni - выселили
	// 6 canceled - отмененные

	public $bookings_living_statuses = array(
		0 => array(
			'name' => 'New',
			'icon' => 'fa-tag'
		),
		1 => array(
			'name' => 'Pending',
			'icon' => 'fa-clock-o'
		),
		2 => array(
			'name' => 'Approved',
			'icon' => 'fa-check'
		),
		3 => array(
			'name' => 'Guest',
			'icon' => 'fa-check'
		),
		4 => array(
			'name' => 'Alumni',
			'icon' => 'fa-check'
		),
		6 => array(
			'name' => 'Canceled',
			'icon' => 'fa-trash'
		)
	);

	public function get_booking_status($status_key, $substatus_key=null)
	{
		if(!isset($status_key))
			return false;

		if(isset($this->bookings_statuses[$status_key]) && is_null($substatus_key))
			return $this->bookings_statuses[$status_key]['name'];
		elseif(isset($this->bookings_statuses[$status_key]) && !empty($this->bookings_statuses[$status_key]['substatuses']))
		{
			if(isset($this->bookings_statuses[$status_key]['substatuses'][$substatus_key]))
				return $this->bookings_statuses[$status_key]['substatuses'][$substatus_key];
			else
				return false;
		}
		else 
			return false;
	}

    public $bookings_types = [
        1 => [
            'id' => 1,
            'name' => 'Room', // Room / Bed
        ],
        2 => [
            'id' => 2,
            'name' => 'Apartment',
        ],
    ];
    public function get_booking_type($type_id) {
        if (!isset($type_id)) {
            return false;
        }
        if (isset($this->bookings_types[$type_id])) {
            return (object) $this->bookings_types[$type_id];
        }
        return false;
    }

	public function get_bookings($filter = array())
	{
		
		// ****** Important!!! ******
		// ----------------------------------------
		// ----------------------------------------
		// Delete user_id on s_bookings table
		// after update s_bookings_users table
		// ----------------------------------------
		// ----------------------------------------


		// Types:
		// 1 - Bed
		// 2 - Apartment

		// Statuses:
		// 0 - Canceled
		// 1 - New
		// 2 - Payment Pending
		// 3 - Contract / Invoice
		// 5 - Closed
		// 6 - Reserve

		// sp_type
		// 0 || null - standart
		// 1 - extension
		// 2 - change bed
		// 3 - Early Move in Rider

		// moved:
		// 0 - не заселен
		// 1 - отправлен мувин
		// 2 - отправлен муваут
		// 3 - мувин подтвержден хауслидером
		// 4 - муваут подтвержден хауслидером



		$id_filter = '';
		$not_id_filter = '';
		$type_filter = '';
		$sp_type_filter = '';
		$sp_group_id_filter = '';
		$parent_id_filter = '';
		$object_id_filter = '';
		$house_id_filter = '';
		$not_house_id_filter = '';
		$apartment_id_filter = '';
		$client_type_id_filter = '';
		$is_due_filter = '';
		$not_canceled_filter = '';
		$date_filter = '';
		$date_from_filter = '';
		$date_to_filter = '';
		$arrive_filter = '';
		$depart_filter = '';
		$status_filter = '';
		$substatus_filter = '';
		$not_status_filter = '';
		$living_status_filter = '';
		$not_living_status_filter = '';
		$manager_login_filter = '';

		$house_type_filter = '';
        $city_id_filter = '';
		$house_select = '';

		$created_date_filter = '';
		$created_by_filter = '';
		$moved_filter = '';

		$keyword_select = '';
		$keyword_filter = '';
		$keyword_where_filter = '';

		$group_by = '';
		$order_by = 'b.id DESC';
		$limit = '';
		$page = 1;

		if(isset($filter['limit']))
			$limit = $this->db->placehold('LIMIT ?', (int)$filter['limit']);

		if(isset($filter['page']))
		{
			$limit = 10;
			if(isset($filter['limit']))
				$limit = max(1, intval($filter['limit']));

			$page = max(1, intval($filter['page']));
			$limit = $this->db->placehold(' LIMIT ?, ? ', ($page-1)*$limit, $limit);
		}

		

		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND b.id in(?@)', (array)$filter['id']);

		if(!empty($filter['not_id']))
			$not_id_filter = $this->db->placehold('AND b.id not in(?@)', (array)$filter['not_id']);

		if(!empty($filter['type']))
			$type_filter = $this->db->placehold('AND b.type in(?@)', (array)$filter['type']);

		if(isset($filter['sp_type']))
		{
			if($filter['sp_type'] == 0)
				$sp_type_filter = $this->db->placehold('AND (b.sp_type = 0 OR b.sp_type IS NULL)');
			else
				$sp_type_filter = $this->db->placehold('AND b.sp_type in(?@)', (array)$filter['sp_type']);
		}

		if(!empty($filter['sp_group_id']))
			$sp_group_id_filter = $this->db->placehold('AND b.sp_group_id in(?@)', (array)$filter['sp_group_id']);
		elseif(!empty($filter['id_sp_group_id']))
			$sp_group_id_filter = $this->db->placehold('AND (b.id in(?@) OR b.sp_group_id in(?@))', (array)$filter['id_sp_group_id'], (array)$filter['id_sp_group_id']);

		if(!empty($filter['parent_id']))
			$parent_id_filter = $this->db->placehold('AND b.parent_id in(?@)', (array)$filter['parent_id']);

		if(!empty($filter['object_id']))
			$object_id_filter = $this->db->placehold('AND b.object_id in(?@)', (array)$filter['object_id']);

		if(!empty($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND b.house_id in(?@)', (array)$filter['house_id']);

		if(!empty($filter['not_house_id']))
			$not_house_id_filter = $this->db->placehold('AND b.house_id NOT in(?@)', (array)$filter['not_house_id']);


        if (!empty($filter['house_type']) || !empty($filter['city_id'])) {
            $house_select = $this->db->placehold('LEFT JOIN __pages h ON h.id=b.house_id');
        }

		if (!empty($filter['house_type'])) {
			$house_type_filter = $this->db->placehold('AND h.type in(?@)', (array)$filter['house_type']);
		}

        if (!empty($filter['city_id'])) {
            $city_id_filter = $this->db->placehold('AND h.parent_id in(?@)', (array)$filter['city_id']);
        }

		if(!empty($filter['apartment_id']))
			$apartment_id_filter = $this->db->placehold('AND b.apartment_id in(?@)', (array)$filter['apartment_id']);

		/*
		if(!empty($filter['user_id']))
			$user_id_filter = $this->db->placehold('AND b.user_id in(?@)', (array)$filter['user_id']);
		*/

		$user_id_select = '';
		$user_id_filter = '';
		if(!empty($filter['user_id']))
		{
			$user_id_select = ', bu.user_id as user_id';
			$user_id_filter = $this->db->placehold('INNER JOIN __bookings_users bu ON bu.booking_id=b.id AND bu.user_id in(?@)', (array)$filter['user_id']);
			$group_by = "GROUP BY b.id";
		}

		if(!empty($filter['client_type_id']))
			$client_type_id_filter = $this->db->placehold('AND b.client_type_id in(?@)', (array)$filter['client_type_id']);

		elseif(!empty($filter['client_type_not_id']))
			$client_type_id_filter = $this->db->placehold('AND b.client_type_id NOT in(?@)', (array)$filter['client_type_not_id']);

		if(!empty($filter['is_due']))
			$is_due_filter = $this->db->placehold('AND (b.due IS NULL OR b.due>=?) AND b.status>0 AND b.status!=4', date('Y-m-d'));
		elseif(!empty($filter['not_canceled']))
			$not_canceled_filter = 'AND b.status>0 AND b.status!=4';

        $prebooking_id_filter = '';
        if (!empty($filter['prebooking_id'])) {
            $prebooking_id_filter = $this->db->placehold('AND b.prebooking_id in(?@)', (array)$filter['prebooking_id']);
        }


		if(isset($filter['status']))
			$status_filter = $this->db->placehold('AND b.status in(?@)', (array)$filter['status']);

		if(!empty($filter['substatus']))
			$substatus_filter = $this->db->placehold('AND b.substatus in(?@)', (array)$filter['substatus']);

		if(isset($filter['not_status']))
			$not_status_filter = $this->db->placehold('AND b.status NOT in(?@)', (array)$filter['not_status']);

		if(!empty($filter['moved']))
			$moved_filter = $this->db->placehold('AND b.moved in(?@)', (array)$filter['moved']);

		if(!empty($filter['date_start_from']))
		{
			$date_from_filter = $this->db->placehold('AND b.arrive>?', $filter['date_start_from']);
			$order_by = 'b.arrive';
		}
		if(!empty($filter['date_start_from2']))
		{
			$date_from_filter = $this->db->placehold('AND b.arrive>=?', $filter['date_start_from2']);
			$order_by = 'b.arrive';

			if(!empty($filter['date_start_to2'])) {
				$date_from_filter = $this->db->placehold('AND b.depart<=?', $filter['date_start_to2']);
			}
		}

		if(isset($filter['arrive']))
			$arrive_filter = $this->db->placehold('AND b.arrive <= ? AND b.arrive >= ?', $filter['arrive'],  $filter['arrive_from']);
		
		if(isset($filter['depart']))
		{
			// $depart_filter = $this->db->placehold('AND b.depart <= ? AND b.depart >= ?', $filter['depart'],  $filter['depart_from']);
			$depart_filter = $this->db->placehold('AND b.depart <= ?', $filter['depart']);
			if(isset($filter['depart_from']))
				$depart_filter .= $this->db->placehold('AND b.depart >= ?', $filter['depart_from']);
		}


		if(!empty($filter['date_from']) && !empty($filter['date_to']))
		{
			$date_filter = $this->db->placehold('AND ( (b.arrive<? AND b.depart>?) OR (b.arrive<? AND b.depart>?))', $filter['date_from'], $filter['date_from'], $filter['date_to'], $filter['date_from']);
		}
		elseif(!empty($filter['date_from2']) && !empty($filter['date_to2']))
		{
			$date_filter = $this->db->placehold('AND ( (b.arrive<=? AND b.depart>=?) OR (b.arrive<=? AND b.depart>=?))', $filter['date_from2'], $filter['date_from2'], $filter['date_to2'], $filter['date_from2']);
		}
		elseif(!empty($filter['date_from']))
		{
			$date_filter = $this->db->placehold('AND b.arrive>=?', $filter['date_from']);
		}
		elseif(!empty($filter['future']))
		{
			$date_filter = $this->db->placehold('AND b.arrive>?', date("Y-m-d"));
			$is_due_filter = $this->db->placehold('AND (b.due IS NULL OR b.due>?) AND b.status>0 AND b.status!=4', date('Y-m-d'));
		}
		elseif(!empty($filter['archive']))
		{
			$date_filter = $this->db->placehold('AND b.depart<?', date("Y-m-d"));
			$is_due_filter = $this->db->placehold('AND (b.due IS NULL OR b.due>=b.arrive) AND b.status>0 AND b.status!=4');
		}
		elseif(!empty($filter['now']))
		{
			$date_filter = $this->db->placehold('AND (b.arrive<=? AND b.depart>=?)', date('Y-m-d'), date('Y-m-d'));
		}

		
		if (isset($filter['created_month']) && isset($filter['created_year'])) {
			$created_date_filter = $this->db->placehold(' AND (MONTH(b.created)=? AND YEAR(b.created)=?)', $filter['created_month'], $filter['created_year']);
		}
        elseif (isset($filter['created_from']) || isset($filter['created_to'])) {
        	$created_date_filter = '';
        	if (isset($filter['created_from'])) {
            	$created_date_filter .= $this->db->placehold(' AND b.created>=?', $filter['created_from']);
			}
        	if (isset($filter['created_to'])) {
            	$created_date_filter .= $this->db->placehold(' AND b.created<=?', $filter['created_to']);
			}
        }

        $firstInvInBookSelect = '';
        $firstInvInBookJoin = '';
        $firstInvInBookFilter = '';
        if (isset($filter['first_inv_in_book'])) {
        	$firstInvInBookSelect = $this->db->placehold(', o.payment_date AS invoice_first_payment_date');
        	$firstInvInBookJoin = $this->db->placehold('LEFT JOIN __orders o ON o.booking_id=b.id');
        	$firstInvInBookFilter = $this->db->placehold('
        		AND o.paid=1 
        		AND o.deposit=0 
        		AND o.status!=3
        		AND o.date_from=b.arrive
    		');
        }

		if(isset($filter['living_status']))
		{
			$living_status_filter = $this->db->placehold('AND b.living_status in(?@)', (array)$filter['living_status']);
		}

		if(isset($filter['not_living_status']))
		{
			$not_living_status_filter = $this->db->placehold('AND b.living_status NOT in(?@)', (array)$filter['not_living_status']);
		}

		if(isset($filter['manager_login']))
		{
			$manager_login_filter = $this->db->placehold('AND b.manager_login = ?', $filter['manager_login']);
		}

		if(isset($filter['keyword']))
		{
			$keywords = explode(' ', $filter['keyword']);
			$keyword_select = ', u.name as user_name, u.id as user_id';

			$user_id_filter = $this->db->placehold('LEFT JOIN __bookings_users bu ON bu.booking_id=b.id');
			$keyword_filter = $this->db->placehold('LEFT JOIN __users u ON u.id = bu.user_id');

			foreach($keywords as $keyword)
				$keyword_where_filter .= $this->db->placehold(' AND (u.name LIKE "%'.$this->db->escape(trim($keyword)).'%" OR u.email LIKE "%'.$this->db->escape(trim($keyword)).'%" OR b.airbnb_reservation_id LIKE "%'.$this->db->escape(trim($keyword)).'%" OR u.last_ip LIKE "%'.$this->db->escape(trim($keyword)).'%")');
		}


		$created_by_select = '';
		if(!empty($filter['created_by']))
		{
			$created_by_select = ', l.sender as created_by';
			$created_by_filter = $this->db->placehold('INNER JOIN __logs l ON 
				l.parent_id=b.id 
				AND l.type=1
				AND l.subtype=1
				AND l.sender_type=2
				AND l.sender in(?@)', (array)$filter['created_by']);
			$group_by = "GROUP BY b.id";
		}

		if(!empty($filter['order_by']))
			$order_by = $filter['order_by'];

		$order_by = 'ORDER BY '.$order_by;

		if(!empty($filter['count']))
		{
			// Count users
			$query = $this->db->placehold("SELECT count(*) as count 
					FROM __bookings b
					$user_id_filter
					$created_by_filter
					$house_select
					$keyword_filter
					WHERE 1 
						$id_filter
						$not_id_filter
						$type_filter
						$sp_type_filter
						$sp_group_id_filter
						$parent_id_filter
						$object_id_filter
						$house_id_filter
						$not_house_id_filter
						$apartment_id_filter
						$client_type_id_filter
						$is_due_filter
						$not_canceled_filter
						$status_filter
						$substatus_filter
						$not_status_filter
						$date_filter
						$date_from_filter
						$arrive_filter
						$depart_filter
						$created_date_filter
						$moved_filter
						$keyword_where_filter
						$living_status_filter
						$not_living_status_filter
						$house_type_filter
					    $city_id_filter
					    $prebooking_id_filter
						$manager_login_filter
					ORDER BY b.id");
		}
		else
		{
			$query = $this->db->placehold("SELECT
					b.id,
					b.type,
					b.sp_type,
					b.sp_group_id,
					b.parent_id,
					b.group_id,
					b.object_id,
					b.house_id,
					b.apartment_id,
					b.client_type_id,
					b.contract_type,
					b.prebooking_id,
					b.airbnb_reservation_id,
					b.price_month,
					b.price_month_airbnb,
					b.price_day,
					b.price_night,
					b.price_utility_total,
					b.total_price,
					b.arrive,
					b.depart,
					b.due,
					b.paid_to,
					b.created,
					b.status,
					b.substatus,
					b.living_status,
					b.brokerfee_discount,
					b.add_to_contract,
					b.moved,
					b.manager_login
					$user_id_select
					$created_by_select
					$keyword_select
					$firstInvInBookSelect
				FROM __bookings b
					$user_id_filter
					$created_by_filter
					$house_select
					$keyword_filter
					$firstInvInBookJoin
				WHERE 
					1
					$id_filter
					$not_id_filter
					$type_filter
					$sp_type_filter
					$sp_group_id_filter
					$parent_id_filter
					$object_id_filter
					$house_id_filter
					$not_house_id_filter
					$apartment_id_filter
					$client_type_id_filter
					$is_due_filter
					$not_canceled_filter
					$status_filter
					$substatus_filter
					$not_status_filter
					$date_filter
					$date_from_filter
					$arrive_filter
					$depart_filter
					$created_date_filter
					$moved_filter
					$keyword_where_filter
					$living_status_filter
					$not_living_status_filter
					$house_type_filter
				    $city_id_filter
				    $prebooking_id_filter
					$manager_login_filter
					$firstInvInBookFilter
				$group_by
				$order_by
				$limit");
		}


		if(isset($filter['print_query']))
		{
			echo $query; exit;
		}


		$this->db->query($query);

		if(!empty($filter['count']))
		{
			return $this->db->result('count');
		}
		elseif(isset($filter['limit']) && $filter['limit'] == 1)
		{
			$bj = $this->db->result();
			if(!empty($bj->client_type_id))
				$bj->client_type = $this->users->get_client_type($bj->client_type_id);
			return $bj;
		}
		else
		{
			$bookings = $this->db->results();

			if((!isset($filter['select_users']) || !isset($filter['no_to_key'])) || isset($filter['sp_group']) || isset($filter['select_notes']))
			{
				$bookings = $this->request->array_to_key($bookings, 'id');
			}
			

			if(!empty($bookings))
			{
				if(isset($filter['sp_group']))
				{
					$sp_group_ids = [];
					foreach($bookings as $k=>$b)
					{
						if(!empty($b->client_type_id) && isset($filter['client_type']))
							$b->client_type = $this->users->get_client_type($b->client_type_id);

						if(!empty($b->sp_group_id))
						{
							if(empty($filter['sp_group_from_start']) || $b->sp_group_id == $b->id)
							{
								$sp_group_ids[$b->sp_group_id] = $b->sp_group_id;
							}

							// if(!empty($filter['sp_group_b_dates']))
							// {
							// 	if($b->sp_group_id == $b->id)
							// 	{
							// 		$bookings[$b->sp_group_id]->arrive = $b->arrive;
							// 	}
							// 	if($b->sp_group_id != $b->id && strtotime($b->depart) > strtotime($bookings[$b->sp_group_id]->depart))
							// 	{
							// 		$bookings[$b->sp_group_id]->depart = $b->depart;
							// 	}
							// }
							

							if(isset($bookings[$b->sp_group_id]))
							{
								$bookings[$b->sp_group_id]->sp_bookings[$b->id] = $b;

								$b->u_depart = strtotime($b->depart);

								if($b->sp_group_id != $b->id && strtotime($b->depart) > strtotime($bookings[$b->sp_group_id]->depart))
								{
									$bookings[$b->sp_group_id]->depart = $b->depart;
								}

								// if($b->sp_group_id != $b->id)
								// 	unset($bookings[$b->id]);
							}
							else
							{
								// $sp_group_ids[$b->sp_group_id] = $b->sp_group_id;
							}
							if(!empty($b->sp_group_id) && $b->sp_group_id != $b->id)
							{
								unset($bookings[$b->id]);
							}
							$sp_bookings[$b->sp_group_id][$b->id] = $b;


						}
					}

					if(!empty($sp_group_ids))
					{
						$sp_bookings_p_params = [
							'sp_group_id' => $sp_group_ids,
                            'order_by' => 'b.arrive'
						];

						if(!empty($filter['is_due']))
							$sp_bookings_p_params['is_due'] = $filter['is_due'];

						if(!empty($filter['status']))
							$sp_bookings_p_params['status'] = $filter['status'];

						$sp_bookings_p = $this->get_bookings($sp_bookings_p_params);

						if(!empty($sp_bookings_p))
						{
							$spbookings = [];
							$u_today = strtotime('today midnight');
							foreach($sp_bookings_p as $b)
							{
								$b->u_arrive = strtotime($b->arrive);
								$b->u_depart = strtotime($b->depart);

								if($b->sp_group_id == $b->id)
								{
									foreach($b as $n=>$v)
									{
										if(!isset($spbookings[$b->sp_group_id]->$n))
											$spbookings[$b->sp_group_id]->$n = $v;
									}

								}
								
								if(!isset($spbookings[$b->sp_group_id]) || (isset($spbookings[$b->sp_group_id]) && $b->u_depart > $spbookings[$b->sp_group_id]->u_depart))
								{
									$spbookings[$b->sp_group_id]->u_depart = $b->u_depart;
									$spbookings[$b->sp_group_id]->depart = date('Y-m-d', $b->u_depart);
								}

								if(!isset($spbookings[$b->sp_group_id]) || (isset($spbookings[$b->sp_group_id]) && $b->u_arrive < $spbookings[$b->sp_group_id]->u_arrive))
								{
									$spbookings[$b->sp_group_id]->u_arrive = $b->u_arrive;
									$spbookings[$b->sp_group_id]->arrive = date('Y-m-d', $b->u_arrive);
								}


								if($u_today >= $b->u_arrive && $u_today <= $b->u_depart)
								{
									$b->active = 1;
								}
								$spbookings[$b->sp_group_id]->sp_bookings_ids[$b->id] = $b->id;
								$spbookings[$b->sp_group_id]->sp_bookings[$b->id] = $b;
							}


							if(!empty($spbookings))
							{
								foreach($spbookings as $b_id=>$b)
								{

									$bookings[$b_id] = $b;
								}
							}

							unset($sp_bookings_p);
						}
					}

				}

				// Rider-bookings: Early Move in
				if( !empty($filter['earlymovein_group'])) {

					$earlymovein_bookings = $this->get_bookings([
						'parent_id' => array_keys($bookings),
						'sp_type' => 3 // Early Move in
					]);
					if (!empty($earlymovein_bookings)) {
						foreach ($earlymovein_bookings as $b) {
							if (isset($bookings[$b->parent_id])) {
								$b->u_arrive = strtotime($b->arrive);
								// $b->u_depart = strtotime($b->depart);
								// ....
							}
						}
					}

					$earlymovein_parents_ids = [];
					$earlymovein_parents_bookings = [];
					foreach($bookings as $k=>$b) {
						if ($b->sp_type == 3 && !empty($b->parent_id)) {
							if (isset($bookings[$b->parent_id])) {
								$earlymovein_parents_bookings[$b->id] = $b;
								// ... добавить id earlymovein-booking
							}
							else {
								$earlymovein_parents_ids[$b->parent_id] = $b->id;
							}
							
						}
					}
				}




				if(isset($filter['select_users']))
				{

					$bookings_ids = [];

					$sp_group_bookings_ids = [];
					foreach($bookings as $b)
					{
						$bookings_ids[$b->id] = $b->id;

						if(!empty($b->sp_group_id))
						{
							$bookings_ids[$b->sp_group_id] = $b->sp_group_id;
							$sp_group_bookings_ids[$b->sp_group_id][$b->id] = $b->id;
						}
					}


					$bookings_users = $this->beds->get_bookings_users([
						'booking_id' => $bookings_ids,
                        'limit' => 'no'
					]);
					
					$bookings_users_ = $this->request->array_to_key($bookings_users, 'user_id');

					if(!empty($bookings_users))
					{
						$users = $this->users->get_users([
							'id' => array_keys($bookings_users_),
							'limit' => count($bookings_users_)
						]);

						if(!empty($users))
						{
							foreach($bookings_users as $bu)
							{
								if(isset($bookings[$bu->booking_id]) && isset($users[$bu->user_id]))
								{
									$bookings[$bu->booking_id]->users[$bu->user_id] = $users[$bu->user_id];

									if(!empty($bookings[$bu->booking_id]->sp_group_id) && !empty($sp_group_bookings_ids[$bookings[$bu->booking_id]->sp_group_id]))
									{
										foreach($sp_group_bookings_ids[$bookings[$bu->booking_id]->sp_group_id] as $b_id)
										{
											$bookings[$b_id]->users[$bu->user_id] = $users[$bu->user_id];
										}
									}
								}
								elseif(isset($users[$bu->user_id]) && isset($sp_group_bookings_ids[$bu->booking_id]))
								{
									foreach($sp_group_bookings_ids[$bu->booking_id] as $b_id)
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

				if(isset($filter['select_notes']))
				{
					$bookings_ids = [];

					$sp_group_bookings_ids = [];
					foreach($bookings as $b)
					{
						$bookings_ids[$b->id] = $b->id;

						if(!empty($b->sp_group_id))
						{
							$bookings_ids[$b->sp_group_id] = $b->sp_group_id;
							$sp_group_bookings_ids[$b->sp_group_id][$b->id] = $b->id;
						}
					}

					$notes = $this->logs->get_logs([
						'parent_id' => $bookings_ids,
						'type' => 1, // bookings
						'subtype' => 12 // notes
					]);

					if(!empty($notes))
					{
						foreach($notes as $n)
						{
							$bookings[$n->parent_id]->notes[$n->id] = $n;

							if(isset($bookings[$n->parent_id]))
							{
								$bookings[$n->parent_id]->notes[$n->id] = $n;
							}
							elseif(isset($sp_group_bookings_ids[$n->parent_id]))
							{
								foreach($sp_group_bookings_ids[$n->parent_id] as $b_id)
								{
									if(isset($bookings[$b_id]))
									{
										$bookings[$b_id]->notes[$n->id] = $n;
									}
								}
							}
						}
					}

				}

				if(isset($filter['select_houses']))
				{
					$houses = $this->pages->get_pages([
						'not_parent_id' => 0,
						'menu_id' => 5,
						'not_tree' => 1
					]);
					$houses = $this->request->array_to_key($houses, 'id');
					if(!empty($houses))
					{
						foreach($bookings as $b)
						{
							if(isset($houses[$b->house_id]))
							{
								$b->house = $houses[$b->house_id];
							}
						}
					}
				}


			}

			return $bookings;
		}

	}


	public function prev_booking($filter = array())
	{
		$object_id_filter = '';
		$type_filter = '';
		$is_due_filter = '';
		$date_filter = '';
		$limit = '';

		if(isset($filter['limit']))
			$limit = $this->db->placehold('LIMIT ?', (int)$filter['limit']);

		if(!empty($filter['object_id']))
			$object_id_filter = $this->db->placehold('AND b.object_id in(?@)', (array)$filter['object_id']);

		if(!empty($filter['type']))
			$type_filter = $this->db->placehold('AND b.type in(?@)', (array)$filter['type']);

		if(!empty($filter['is_due']))
			$is_due_filter = $this->db->placehold('AND (b.due IS NULL OR b.due>=?) AND b.status>0 AND b.status!=4', date('Y-m-d'));

		if(!empty($filter['date_to']))
		{
			$date_filter = $this->db->placehold('AND b.depart<=?', $filter['date_to']);
		}
		else
			return false;


		// b.user_id,
		$query = $this->db->placehold("SELECT
				b.id,
				b.parent_id,
				b.group_id,
				b.object_id,
				b.house_id,
				b.client_type_id,
				b.arrive,
				b.depart,
				b.due,
				b.status,
				b.living_status
			FROM __bookings b
			INNER JOIN
			(
			    SELECT max(depart) max_depart, b.object_id, b.id
			    FROM __bookings b
			    WHERE
			    	1
					$object_id_filter
					$type_filter
					$is_due_filter
					$date_filter
			    GROUP BY b.object_id
			) b2
			ON b.object_id=b2.object_id AND b.depart=b2.max_depart
			GROUP BY b.id
			ORDER BY b.depart DESC, b.id DESC
			$limit");


		$this->db->query($query);


		return $this->db->results();
	}

	public function next_booking($filter = array())
	{
		$object_id_filter = '';
		$type_filter = '';
		$is_due_filter = '';
		$date_filter = '';


		if(isset($filter['limit']))
			$limit = $this->db->placehold('LIMIT ?', (int)$filter['limit']);

		if(!empty($filter['object_id']))
			$object_id_filter = $this->db->placehold('AND b.object_id in(?@)', (array)$filter['object_id']);

		if(!empty($filter['type']))
			$type_filter = $this->db->placehold('AND b.type in(?@)', (array)$filter['type']);

		if(!empty($filter['is_due']))
			$is_due_filter = $this->db->placehold('AND (b.due IS NULL OR b.due>=?) AND b.status>0 AND b.status!=4', date('Y-m-d'));

		if(!empty($filter['date_from']))
			$date_filter = $this->db->placehold('AND b.arrive>=?', $filter['date_from']);
		else
			return false;


		// b.user_id,
		$query = $this->db->placehold("SELECT
				b.id,
				b.parent_id,
				b.group_id,
				b.object_id,
				b.house_id,
				b.client_type_id,
				b.arrive,
				b.depart,
				b.due,
				b.status,
				b.living_status
			FROM __bookings b
			INNER JOIN
			(
			    SELECT min(arrive) min_arrive, b.object_id, b.id
			    FROM __bookings b
			    WHERE
			    	1
					$object_id_filter
					$type_filter
					$is_due_filter
					$date_filter
			    GROUP BY b.object_id
			) b2
			ON b.object_id=b2.object_id AND b.arrive=b2.min_arrive
			GROUP BY b.id
			ORDER BY b.arrive DESC, b.id DESC
			$limit");

		$this->db->query($query);


		return $this->db->results();
		
	}




	public function add_booking($val)
	{	
		$query = $this->db->placehold('INSERT INTO __bookings SET ?%', $val);
		if(!$this->db->query($query))
			return false;

		$id = $this->db->insert_id();	
		return $id;
	}

	public function update_booking($id, $val)
	{
		$query = $this->db->placehold("UPDATE __bookings SET ?% WHERE id in(?@) LIMIT ?", $val, (array)$id, count((array)$id));
		$this->db->query($query);
		return $id;
	}

	public function delete_booking($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __bookings WHERE id=? LIMIT 1", intval($id));
			$this->db->query($query);
		}
	}


	public function cancel_booking($filter = array())
	{
		if(empty($filter['id']) && empty($filter['object_id']) && empty($filter['user_id']))
			return false;

		$filter['not_canceled'] = true;

		$bookings = array();
		$beds_bookings = array();
		$bookings_users = array();
		$aparnments_bookings_ids = array();

		$bookings_ = $this->get_bookings($filter);

		$user_id = 0;



		if(!empty($bookings_))
		{
			foreach($bookings_ as $b)
			{
				$bookings[$b->id] = $b;

				if($b->type == 2) // Apartment booking
					$aparnments_bookings_ids[$b->id] = $b->id;
				else
					$beds_bookings[$b->id] = $b;
			}


			if(!empty($filter['user_id']) && is_numeric($filter['user_id']))
				$user_id = $filter['user_id'];

			if(empty($user_id))
			{
				$bookings_users = $this->beds->get_bookings_users(array('booking_id'=>array_keys($bookings)));

				if(!empty($bookings_users))
				{
					$bookings_users_1 = current($bookings_users);
					$user_id = $bookings_users_1->user_id;
				}
			}


			if(!empty($filter['user_id']))
			{
				$cancellation_bookings = $beds_bookings;

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
								$cancellation_bookings[$booking_id] = $bookings[$booking_id];
						}
					}
				}

			}
			else
			{
				$cancellation_bookings = $bookings;
			}

		}



		if(!empty($cancellation_bookings))
		{
			$manager = $this->managers->get_manager();
			$br = '
';
			/*$c_users = $this->beds->get_bookings_users(array('booking_id'=>array_keys($cancellation_bookings)));
			if(!empty($c_users))
			{

			}*/


			$bookings_ids = array();
			foreach($cancellation_bookings as $bj)
			{
				$bookings_ids[] = $bj->id;

				$bj_upd = array();
				$bj_upd['status'] = 0;
				$bj_upd['living_status'] = 6;
				// if(!empty($filter['user_id']))
				// 	$bj_upd['substatus'] = 0;
				
				$this->update_booking($bj->id, $bj_upd);

				$log_value  = 'Booking status: '.$this->get_booking_status($bj->status).' &rarr; '.$this->get_booking_status(0);
				$log_value  .= $br.'Living status: '.$this->bookings_living_statuses[$bj->living_status]['name'].' &rarr; '.$this->bookings_living_statuses[6]['name'];


				if(!empty($filter['note']))
	            	$log_value .= $br.'System note: '.$filter['note'];

                $log_data = [
                    'parent_id' => $bj->id,
                    'type' => 1,
                    'subtype' => 2, // Change status
                    'user_id' => $user_id,
                    'sender_type' => 2,
                    'sender' => $manager->login,
                    'value' => $log_value
                ];

                if (!empty($filter['sender_type'])) {
                    $log_data['sender_type'] = $filter['sender_type'];
                }
                if (!empty($filter['sender'])) {
                    $log_data['sender'] = $filter['sender'];
                }

	            $this->logs->add_log($log_data);

			}

			// Cancel Booking Invoices
			if(!empty($bookings_ids))
			{
				$invoices = $this->orders->get_orders(array(
                    'booking_id' => $bookings_ids,
                    'type' => 1, // invoices
                    'status' => 0, // new invoices
                    'paid' => 0
                ));
                if(!empty($invoices))
                {
                    foreach($invoices as $invoice)
                        $this->orders->update_order($invoice->id, array('status'=>3));    
                }

			}
		}
	}

	// --- Bookings (end) ---

	// --- Bookings Users ---

	public function get_bookings_users($filter = array())
	{
		if(empty($filter['booking_id']) && empty($filter['user_id']))
			return false;

		$booking_id_filter = '';
		if(!empty($filter['booking_id']))
			$booking_id_filter = $this->db->placehold('AND booking_id in(?@)', (array)$filter['booking_id']);

		$user_id_filter = '';
		if(!empty($filter['user_id']))
			$user_id_filter = $this->db->placehold('AND user_id in(?@)', (array)$filter['user_id']);

		$query = $this->db->placehold("SELECT 
				booking_id, 
				user_id 
			FROM __bookings_users
			WHERE 1
				$booking_id_filter
				$user_id_filter
			");
		$this->db->query($query);
		return $this->db->results();
	}


	public function add_booking_user($booking_id, $user_id)
	{
		if(empty($booking_id) || empty($user_id))
			return false;

		$query = $this->db->placehold("INSERT IGNORE INTO __bookings_users SET booking_id=?, user_id=?", $booking_id, $user_id);

		if(!$this->db->query($query))
			return false;

		return true;
	}

	public function delete_booking_user($booking_id, $user_id)
	{
		$query = $this->db->placehold("DELETE FROM __bookings_users WHERE booking_id=? AND user_id=? LIMIT 1", intval($booking_id), intval($user_id));
		$this->db->query($query);
	}


	// --- Bookings Users (end) ---

	/*
	params - array:
		initiator (important): payment
		order_id (important)
		payment_status (important): pending, succeeded
		payment_method: StripeACH, Stripe, Paypal
	*/

	public function update_due_booking($id, $params = [])
	{
		if(empty($id) && !empty($params['initiator']))
			return false;

		if(!empty($params['extension_booking']))
			$booking = $params['extension_booking'];
		else	
			$booking = $this->get_bookings([
				'id' => (int)$id, 
				'limit' => 1
			]);

		if(empty($booking))
			return false;

		if(!isset($booking->user_id))
		{
			$booking_users = $this->beds->get_bookings_users([
				'booking_id' => $booking->id
			]);
			if(!empty($booking_users))
			{
				$booking_user = current($booking_users);
				$booking->user_id = $booking_user->user_id;
			}
		}


		$sp_bookings_ids = false;
		//$booking->sp_type == 2 && 
		if(!is_null($booking->sp_group_id))
        {
            $sp_bookings = $this->beds->get_bookings([
                'sp_group_id' => $booking->sp_group_id
            ]);
            if(!empty($sp_bookings))
                $sp_bookings_ids = array_keys($sp_bookings);
        }

		$br = '
';
		$log_value = '';
		
		if($params['initiator'] == 'payment' && !empty($params['order_id']) && !empty($params['payment_status']))
		{
			$booking_upd = new stdClass;

			if($params['payment_status'] == 'pending' && in_array($booking->status, [1]))
			{
				$booking_upd->status = 2; // Payment Pending

				$log_subtype = 2;  // 2 - Change status
				$log_value  .= 'Booking status: '.$this->get_booking_status($booking->status).' &rarr; '.$this->get_booking_status($booking_upd->status).$br;
			}
			elseif($params['payment_status'] == 'succeeded' && in_array($booking->status, [1,2]))
			{
				$booking_upd->status = 3; // Contract / Invoice

				$log_subtype = 2;  // 2 - Change status
				//$log_subtype = 4; // 4 - Payment
				$log_value  .= 'Booking status: '.$this->get_booking_status($booking->status).' &rarr; '.$this->get_booking_status($booking_upd->status).$br;
			}


			$order = $this->orders->get_order((int)$params['order_id']);
			if(!empty($order)) {
				if($params['payment_status'] == 'pending') {
					if($params['payment_method'] == 'ACH' || $params['payment_method'] == 'Qira')
					{
						if(!is_null($booking->due) && (strtotime("+1 week") > strtotime($booking->due)))
						{
							$booking_upd->due = date("Y-m-d", strtotime("+1 week"));
							$log_value  .= 'Due: '.date_format(date_create($booking->due), 'M d, Y').' &rarr; '.date_format(date_create($booking_upd->due), 'M d, Y').$br;
						}
					}
				}
				elseif($params['payment_status'] == 'succeeded')
				{
                    // Booking living status: 0 - New; 1- Pending
					if (($order->type == 1 && $order->deposit == 0) && in_array($booking->living_status, [0, 1])) {
						$booking_upd->living_status = 2; // approved
						$log_value .= 'Living status: '.$this->bookings_living_statuses[$booking->living_status]['name'].' &rarr; '.$this->bookings_living_statuses[$booking_upd->living_status]['name'].$br;
					}

					if(!empty($order->date_to))
					{
						if($booking->status == 3)
							$log_subtype = 4; // 4 - Payment

						if(!is_null($booking->due) && (strtotime($order->date_to) > strtotime($booking->due)))
						{
							$booking_upd->due = $order->date_to;
							$log_value  .= 'Due: '.date_format(date_create($booking->due), 'M d, Y').' &rarr; '.date_format(date_create($booking_upd->due), 'M d, Y').$br;
						}

						if(is_null($booking->paid_to) || (strtotime($order->date_to) > strtotime($booking->paid_to)))
						{
							$booking_upd->paid_to = $order->date_to;
							$old_paid_to = '';
							if(!empty($booking->paid_to))
								$old_paid_to = date_format(date_create($booking->paid_to), 'M d, Y').' &rarr; ';

							$log_value  .= 'Paid to: '.$old_paid_to.date_format(date_create($booking_upd->paid_to), 'M d, Y').$br;
						}	
					}
				}


				$sender_type = 1; // System
				if(isset($params['sender_type']))
				{
					$sender_type = $params['sender_type'];

					if($sender_type == 2) // Admin
					{
						$manager = $this->managers->get_manager();
						$sender = $manager->login;
					}
				}

				$log_value .= 'Invoice ID: '.$order->id;
				if(!empty($params['payment_method']))
					$log_value .= ' ('.$params['payment_method'].')';

				if(!empty($params['extension_booking']))
					$log_value .= ' - Extended';


				if(!empty($booking_upd))
				{
					$update_booking_ids = $booking->id;
					if(!empty($sp_bookings_ids))
						$update_booking_ids = $sp_bookings_ids;
					$this->update_booking($update_booking_ids, $booking_upd);

					$log_params = array(
						'parent_id' => $booking->id, 
		                'type' => 1, 
		                'subtype' => $log_subtype,
		                'user_id' => $booking->user_id, 
		                'sender_type' => $sender_type,
		                'value' => $log_value
		            );
		            if($sender_type == 2 && !empty($sender))
		            	$log_params['sender'] = $sender;

					$this->logs->add_log($log_params);
				}

				if(empty($params['extension_booking']))
				{
					$extension_booking = $this->get_bookings(array(
						'parent_id' => $booking->id,
						'type' => $booking->type,
						'not_canceled' => true,
						'limit' => 1
					));

					if(!empty($extension_booking))
					{
						$params['extension_booking'] = $extension_booking;
						$this->update_due_booking($extension_booking->id, $params);

						$log_params = array(
							'parent_id' => $booking->id, 
			                'type' => 1, 
			                'subtype' => 7, // Update Extension
			                'user_id' => $booking->user_id, 
			                'sender_type' => $sender_type,
			                'value' => 'Extended Booking ID: '.$extension_booking->id
			            );
			            if($sender_type == 2 && !empty($sender))
		            		$log_params['sender'] = $sender;
						$this->logs->add_log($log_params);
					}
				}
													
			}
		}
	}

	// ------
	// просмотреть users bookings
	// ------
	public function update_user_active_booking($user_id=0)
	{
		$u_date = strtotime(date('Y-m-d 00:00:00'));

		$params = [];
		$sp_group_ids = [];
		$sp_group_bookings_ids = [];
		$sp_bookings = [];
		$params['not_canceled'] = true;
		$params['no_to_key'] = true;
		if(!empty($user_id))
			$params['user_id'] = $user_id;

		$bookings_ = $this->get_bookings($params);
		//$bookings = $this->request->array_to_key($bookings, 'id');


		if(!empty($bookings_))
		{
			$bookings = [];
			foreach($bookings_ as $b)
			{
				if(!empty($user_id) && !empty($b->sp_group_id))
				{
					$sp_group_ids[$b->sp_group_id] = $b->sp_group_id;
					$sp_group_bookings_ids[$b->sp_group_id][$b->id] = $b->id;
				}
				elseif(!empty($b->sp_group_id))
				{
					$sp_group_bookings[$b->id] = $b;

					if($b->sp_group_id == $b->id)
						$sp_group_bookings_ids[$b->sp_group_id][$b->id] = $b->id;
				}

				if(!empty($user_id) || (empty($b->sp_group_id) || $b->sp_group_id == $b->id))
				{
					$b->u_arrive = strtotime($b->arrive);
					$b->u_depart = strtotime($b->depart);
					$bookings[$b->id] = $b;
				}
			}
			if(!empty($sp_group_ids))
			{
				$sp_group_bookings = $this->beds->get_bookings([
					'sp_group_id' => $sp_group_ids,
					'no_to_key' => true,
					'order_by' => 'b.arrive'
				]);
			}

			if(!empty($sp_group_bookings))
			{
				$u_today = strtotime('today midnight');
				foreach($sp_group_bookings as $b)
				{
					$b->u_arrive = strtotime($b->arrive);
            		$b->u_depart = strtotime($b->depart);
					if(isset($sp_group_bookings_ids[$b->sp_group_id]))
					{
						foreach($sp_group_bookings_ids[$b->sp_group_id] as $b_id)
						{
							$bookings[$b_id]->sp_bookings[$b->id] = $b;
							if($b->u_depart > $bookings[$b_id]->u_depart)
							{
								$bookings[$b_id]->u_depart = $b->u_depart;
								$bookings[$b_id]->depart = date('Y-m-d', $b->u_depart);
							}

							if($b->u_arrive <= $u_today && $b->u_depart >= $u_today)
							{
								$bookings[$b_id]->house_id = $b->house_id;
								$bookings[$b_id]->apartment_id = $b->apartment_id;
								$bookings[$b_id]->object_id = $b->object_id;
							}
						}
					}
				}
			}


			$bookings_ids = array_keys($bookings);

			$bookings_users_ = $this->get_bookings_users([
				'booking_id' => $bookings_ids
			]);
			// $bookings_users_ids = array();
			// $users_bookings_ids = array();
			// $users_ids = array();

			// print_r($bookings_users_); exit;



			$users_bookings = array();
			if(!empty($bookings_users_))
			{

				foreach($bookings_users_ as $bu)
				{
					// $bookings_users_ids[$bu->booking_id][$bu->user_id] = $bu->user_id;
					// $users_bookings_ids[$bu->user_id][$bu->booking_id] = $bu->booking_id;
					// $users_ids[$bu->user_id] = $bu->user_id;

					if(isset($bookings[$bu->booking_id]))
						$users_bookings[$bu->user_id][$bu->booking_id] = $bookings[$bu->booking_id];
				}
			}
			unset($bookings_users_);
			unset($bookings);


			// $users_bookings = array();
			// foreach($bookings as $b)
			// {
			// 	if(isset($bookings_users_ids[$b->id]))
			// 	{

			// 	}

			// 	if(!empty($b->user_id))
			// 	{
			// 		$users_bookings[$b->user_id][$b->id] = $b;
			// 	}
			// }
			// unset($bookings);

			$n = 0;
			foreach($users_bookings as $user_id=>$ub)
			{
				if(count($ub) == 1)
				{
					$n++;
					$active_booking = current($ub);

					$user_upd = [
						'active_booking_id' => $active_booking->id,
						'inquiry_arrive' => $active_booking->arrive,
						'inquiry_depart' => $active_booking->depart,
						'house_id' => $active_booking->house_id,
						'apartment_id' => $active_booking->apartment_id,
						'client_type_id' => $active_booking->client_type_id
					];

					if($active_booking->type == 1) // Booking: Bed
						$user_upd['bed_id'] = $active_booking->object_id;
					elseif($active_booking->type == 2) // Booking: Apartment
						$user_upd['bed_id'] = 0;


					$u_id = $this->users->update_user($user_id, $user_upd);
					//echo $n.'. User #'.$user_id.' => add active booking: #'.$active_booking->id.'<br>';
				}
				else{
					$active_booking = false;

					$booking_now = false;
					$booking_future = false;
					$booking_past = false;

					foreach($ub as $b)
					{
						//$u_arrive = strtotime($b->arrive);
						//$u_depart = strtotime($b->depart);


						if(!empty($b->due))
							$u_due = strtotime($b->due);
						else
							$u_due = false;

						if(empty($u_due) || $u_due >= $u_date)
							$b->is_due = true;
						else
							$b->is_due = false;

						// now
						if($u_date >= $b->u_arrive && $u_date <= $b->u_depart)
						{
							if( 
								empty($booking_now) || 
								($booking_now->is_due == false && $b->is_due == true && $booking_now->status == $b->status) ||
								(($booking_now->is_due == $b->is_due || ($booking_now->is_due == false && $b->is_due == true)) && $booking_now->status < $b->status)
							)
							{
								$booking_now = $b;
							}
						}

						elseif($u_date > $b->u_depart)
						{
							// if( empty($booking_past) || ($booking_past->is_due == false && $b->is_due == true) )
							// 	$booking_past = $b;
							if( 
								empty($booking_past) || 
								($booking_past->is_due == false && $b->is_due == true && $booking_past->status == $b->status) ||
								($booking_past->is_due == $b->is_due && $booking_past->status < $b->status) ||
								($b->status > 0 && $b->u_depart > strtotime($booking_past->depart) && ($b->status > 1 || (!empty($b->due) || strtotime($b->due) >= strtotime($b->depart) )))
							)
							{
								$booking_past = $b;
							}
						}

						elseif($u_date < $b->u_arrive)
						{
							//if( empty($booking_future) || ($booking_future->is_due == false && $b->is_due == true) )
							if( 
								empty($booking_future) || 
								(strtotime($booking_future->arrive) > $b->u_arrive && $b->status >= $booking_future->status && ($b->is_due == true || $b->is_due == $booking_future->is_due) ) ||
								($booking_future->is_due == false && $b->is_due == true && $booking_future->status == $b->status) ||
								($booking_future->is_due == $b->is_due && $booking_future->status < $b->status)
							)
							{
								$booking_future = $b;
							}
						}
					}


					// Statuses:
					// 0 - Canceled
					// 1 - New
					// 2 - Payment Pending
					// 3 - Contract / Invoice
					if(
						!empty($booking_now) && 
						( 
							($booking_now->is_due == true && $booking_now->status > 0) || 
							empty($booking_future) ||
							(!empty($booking_future) && ($booking_future->is_due == false || $booking_now->status > $booking_future->status))
						)
					)
					{
						$active_booking = $booking_now;
					}
					elseif(!empty($booking_future))
					{
						$active_booking = $booking_future;
					}
					elseif(!empty($booking_past))
					{
						$active_booking = $booking_past;
					}
					else
					{
						$active_booking = current($ub);

					}

					if(
						!empty($booking_past) && 
						($booking_past->status > $booking_now->status && $booking_now->status == 0) && 
						(empty($booking_future) || ($booking_future->is_due == false) )
					)
					{
						$active_booking = $booking_past;

						// echo ' - booking_past2'; exit;
					}


					if(!empty($active_booking))
					{
						$n++;

						$main_u_depart = strtotime($active_booking->depart);
						foreach($ub as $b)
						{
							if($b->group_id == $active_booking->group_id && $b->status > 0)
							{
								$b->u_depart = strtotime($b->depart);
								if($b->u_depart > $main_u_depart)
									$main_u_depart = $b->u_depart;
							}
						}

						$user_upd = [
							'active_booking_id' => $active_booking->id,
							'inquiry_arrive' => $active_booking->arrive,
							'inquiry_depart' => date('Y-m-d', $main_u_depart),
							'house_id' => $active_booking->house_id,
							'apartment_id' => $active_booking->apartment_id,
							'client_type_id' => $active_booking->client_type_id
						];

						if($active_booking->type == 1) // Booking: Bed
							$user_upd['bed_id'] = $active_booking->object_id;
						elseif($active_booking->type == 2) // Booking: Apartment
							$user_upd['bed_id'] = 0;

						$u_id = $this->users->update_user($user_id, $user_upd);
						// echo $n.'. User #'.$user_id.' => add active booking #'.$active_booking->id.'<br>';
					}
					else
					{
						$n++;
						// echo $n.'. User #'.$user_id.' => [no active booking] <br>';

					}
				}
			}
		}
	}



	public function calculate_bedsdays($from, $to, $visible, $parent_from, $parent_to)
	{
		$result = new stdClass;

		$result->from = $parent_from;
		$result->to = $parent_to;
		//$result->d_count = 0;

		$d_count = round(($parent_to - $parent_from) / (24 * 60 * 60)) + 1;

		if($visible == 1 && (is_null($from) && is_null($to)))
			$result->d_count = $d_count;

		elseif(!is_null($from) || !is_null($to))
		{
			if(!is_null($from))
			{
				$u_from = strtotime($from);
				$result->from = $u_from;

				if($u_from > $parent_to)
					$result->d_count = 0;

				elseif($u_from <= $parent_from)
					$result->from = $parent_from;
			}
			if(!is_null($to) && $result->d_count !== 0)
			{
				$u_to = strtotime($to);
				$result->to = $u_to;

				if($u_to < $parent_from)
					$result->d_count = 0;

				elseif($u_to > $parent_to)
					$result->to = $parent_to;
			}
		}
		elseif($visible == 0)
			$result->d_count = 0;

		if($result->d_count !== 0)
			$result->d_count = round(($result->to - $result->from) / (24 * 60 * 60)) + 1;

		return $result;
	}


	// ------------
	//   Utilites
	// ------------
	public $utility_price_williamsburg_apt = 596;
	public $utility_price_williamsburg = 149;

	public $utility_price_per_room = 99;
	public $utility_price_per_room_ny = 149;

	public $utility_price_per_room_mason_chestnut = 99;

	public $houses_utility_price_per_room = [
		349 => 149, // The Mason on Chestnut
        368 => 149, // The Temple House
        464 => 149 // The Avenue at East Falls
	];

	public function get_house_utility_price_per_room($house_id) {

		$house = $this->pages->get_page_init((int)$house_id);

		$utility_price = $this->utility_price_per_room;

		// NYC
		if ($house->parent_id == 253) {
			$utility_price =  $this->utility_price_per_room_ny;
		}

		// williamsburg
		if (in_array($house_id, [334, 337])) {
			$utility_price = $this->utility_price_williamsburg;
		}

		if (isset($this->houses_utility_price_per_room[$house_id])) {
			$utility_price = $this->houses_utility_price_per_room[$house_id];
		}

		return $utility_price;
	}


	public function get_house_month_price($house_id, $booking_type, $apartment, $contract_type) {
		$utility_price_val = 0;
		// Free market lease or second Willamsburg house
		if($house_id == 337 || $contract_type == 3)
 		{
 			$utility_price_val = 0;
 		}
 		else
 		{
 			// if($house_id == 334 && $booking_type == 2)
    		//   $utility_price_val = $this->utility_price_williamsburg_apt;
 			if(in_array($house_id, [334, 337])) // williamsburg
 			{
 				if($booking_type == 1) {
					// $utility_price_val =  $this->utility_price_williamsburg;
					
					// NYC
					// if ($house->parent_id == 253) {
					// 	$utility_price_val =  $this->utility_price_per_room_ny;
					// }

					$utility_price_val = $this->get_house_utility_price_per_room($house_id);
				}
 					
 				elseif($booking_type == 2) {
					if (!empty($apartment->utility_price)) {
						$utility_price_val = $apartment->utility_price;
					}
					else
					{
						$utility_price_val = $this->utility_price_williamsburg_apt;
					}
				}
 					
 			}
        	elseif($booking_type == 2)
        	{
        		if(!empty($apartment->utility_price)) {
					$utility_price_val = $apartment->utility_price;
				}
        		else
        		{
        			$active_rooms = $this->get_rooms([
						'apartment_id' => $apartment->id,
						'is_open_from' => $date_from,
						'is_open_to' => $date_from
					]);
        			if(!empty($active_rooms)) {
						// $utility_price_val = count($active_rooms) * $this->utility_price_per_room;
						$utility_price_val = count($active_rooms) * $this->get_house_utility_price_per_room($house_id);
					}
        				
        		}
        	}
			else {
				// $utility_price_val = $this->utility_price_per_room;
				// // NYC
				// if ($house->parent_id == 253) {
				// 	$utility_price_val =  $this->utility_price_per_room_ny;
				// }
				$utility_price_val = $this->get_house_utility_price_per_room($house_id);
			}
		}

		return $utility_price_val;
		
	}


	public function get_utility_price(
        $house_id,
        $booking_type,
        $date_from,
        $date_to,
        $apartment,
        $contract_type = 1,
        $utility_price_month = 'auto'
    ) {
		//$house = $this->pages->get_page_init((int)$house_id);

		// Free market lease or second Willamsburg house
		if ($house_id == 337 || $contract_type == 3) {
 			$utility_price = 0;
 		} else {
 			if (is_numeric($utility_price_month)) {
                $utility_price_val = $utility_price_month;
            } else {
                $utility_price_val = $this->get_house_month_price($house_id, $booking_type, $apartment, $contract_type);
            }

            $days_count = 31;
            if (!empty($date_from) && !empty($date_to)) {
                $interval = date_diff(date_create($date_from), date_create($date_to));
                $days_count = $interval->days;
            }

 			if ($days_count < 27) {
				$utility_price = round((($utility_price_val * 12) / 365) * $days_count, 1);
				$utility_price = $utility_price != 0 ? $utility_price : round(($utility_price_val * 12) / 365, 1);
 			} else {
                $utility_price = $utility_price_val;
            }
 		}

		return $utility_price;
	}

	public function update_living_status()
	{
		$today = date('Y-m-d');
		$params = [];

		$params['not_living_status'] = 4;
		$params['not_canceled'] = 1;

		// to alumni
		$params['archive'] = 1;
		
		$archive_bookings = $this->get_bookings($params);

		if(!empty($archive_bookings))
		{
			foreach($archive_bookings as $ab)
			{
				// cassa and montroe
				if(in_array($ab->house_id, [340, 366, 344]))
				{
					$to_alumni_users = $this->get_bookings_users(['booking_id'=>$ab->id]);
					if(!empty($to_alumni_users))
					{
						foreach($to_alumni_users as $bu)
						{
							$this->users->update_user($bu->user_id, ['status'=>4]);
						}
					}
				}
			}
			
			$this->update_booking(array_keys($archive_bookings), ['living_status'=>4]);

			echo '
			Updated to alumni '.count($archive_bookings).' bookings';
		}

		// to guests
		$params['not_living_status'] = 3;
		unset($params['archive']);
		$params['now'] = 1;

		$now_bookings = $this->get_bookings($params);

		if(!empty($now_bookings))
		{
			foreach($now_bookings as $nb)
			{
				// cassa and montroe
				if(in_array($nb->house_id, [340, 344]))
				{
					$to_guest_users = $this->get_bookings_users(['booking_id'=>$nb->id]);
					if(!empty($to_guest_users))
					{
						foreach($to_guest_users as $bu)
						{
							$this->users->update_user($bu->user_id, ['status'=>3]);
						}
					}
				}
			}

			$this->update_booking(array_keys($now_bookings), ['living_status'=>3]);
			echo '
			Updated to guests '.count($now_bookings).' bookings';
		}

	}




    /**
     *  Broker Fee
     * params (array):
     * price
     * invoice
     * booking
     * house
     * contract
    */
    public $brokerFeeMaxPeriod = 365;
    public function getBrokerFee ($params = []) {
        extract($params);

        // Def 8%
        $broker_fee_percent = 8;
        $broker_fee_sum1 = 0;

        $is_extention = false;
		
		if ($contract && !isset($daysCount)) {
			$price = $contract->total_price + $contract->price_utility_total;
		}


        if (empty($price) || empty($invoice) || empty($booking) || empty($house))
            return 0;

        if (!empty($invoice->labels[14]))
            return 0;

        //House Leader
        if ($booking->client_type_id == 5) {
            return 0;
        }



        $booking->u_arrive = strtotime($booking->arrive);
        $booking->u_depart = strtotime($booking->depart);
        $booking->days_count = round(($booking->u_depart - $booking->u_arrive)/ (24 * 60 * 60) + 1);
        $days_count = $booking->days_count;

        if ($contract) {
            if (!isset($contract->days_count)) {
                $contract->days_count = round((strtotime($contract->date_to) - strtotime($contract->date_from)) / (24 * 60 * 60) + 1);
            }
            $days_count = $contract->days_count;
        }

        if (isset($daysCount)) {
        	if ($daysCount == 0) {
        		return 0;
        	}
        	$days_count = $daysCount;
        }

        // Fee no more than price/year
        if ($days_count > $this->brokerFeeMaxPeriod) {
            $price = round(($price / $days_count * $this->brokerFeeMaxPeriod), 2);
        }

        // Is Extention
        if ($booking->sp_type == 1 && $booking->parent_id != 0) {
            $is_extention = true;
        }



        // 8.5%
        $houses_type1 = [
            368,  // The Temple House
            301,  // The Stuyvesant Heights House
            300,  // The Knickerbocker House
        ];

        // 10.5%
        $houses_type2 = [
            365  // The Alexander House
        ];

        // $300 + 5%
        $houses_type3 = [
            306,  // The Fort Greene
            298, // The Newkirk House
            102  // The Bed-Stuy House
        ];

        // $300 + 5% / $150 + 2.5% / $150
        $houses_type4 = [
            336, // The Crown Heights House
            315  // The Bedford House
        ];

        // 8%
        // ext: < 6 month - 4%; > 6 month - 8%;
        $houses_type5 = [
            294, // The Lexington House
            339  // The Kensington House
        ];


        if (in_array($house->id, $houses_type1)) {
            $broker_fee_percent = 8.5;
        }
        elseif (in_array($house->id, $houses_type2)) {
            $broker_fee_percent = 10.5;
        }
        elseif (in_array($house->id, $houses_type3)) {
            $broker_fee_sum1 = 300;
            $broker_fee_percent = 5;
            // The Fort Greene
            if ($house->id == 306 && ($price / 100 * $broker_fee_percent) < 150) {
                $broker_fee_percent = 0;
            }
        }
        elseif (in_array($house->id, $houses_type4)) {
            $price_month = $booking->price_month;
            if (empty($price_month) && !empty($booking->price_day)) {
                $price_month = $booking->price_day * 30;
            }
            if ($price_month <= 1150) {
                $broker_fee_sum1 = 150;
                $broker_fee_percent = 0;
            }
            elseif ($price_month > 1150 && $price_month <= 1450) {
                $broker_fee_sum1 = 150;
                $broker_fee_percent = 2.5;
            }
            else {
                $broker_fee_sum1 = 300;
                $broker_fee_percent = 5;
            }
        }
        elseif (in_array($house->id, $houses_type5)) {
            // ext: < 6 month
            if ($is_extention && $days_count < (30 * 6)) {
                $broker_fee_percent = 4;
            }
        }

        // Calc result
        $broker_fee_result = $broker_fee_sum1 + ($price / 100 * $broker_fee_percent);

        //echo '( '.$broker_fee_sum1.' + ('.$price.' * '.$broker_fee_percent.' ) = '.$broker_fee_result.' )';

        if (isset($getFormula)) {
            $brokerFeeFormula = '$' . number_format($price, 2,'.',',') . ' * '.$broker_fee_percent.'%';
            if ($broker_fee_sum1 > 0) {
                $brokerFeeFormula = '$' . $broker_fee_sum1 . ' + (' . $brokerFeeFormula . ')';
            }
            return $brokerFeeFormula;
        }


        // airbnb
        /*
        if ($booking->client_type_id == 2 || (!empty($booking->price_day) && empty($booking->price_month))) {
            $price_month = $booking->price_day * 30;
        }
        elseif (!empty($booking->price_month)) {
            $price_month = $booking->price_month;
        }

        if($price_month > 0 && $price_month < $broker_fee_result) {
            $broker_fee_result = $price_month;
        }
        */

        $broker_fee_result = number_format($broker_fee_result, 2,'.','');



        return $broker_fee_result;
    }
    

}
