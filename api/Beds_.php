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
	// ----- apartments -----
	// -----------------------

	public function get_apartments($filter = array())
	{
		$id_filter = '';
		$house_id_filter = '';
		$floor_filter = '';
		$visible_filter = '';
		$rent_apartment_filter = '';
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

		$sql_limit = $this->db->placehold(' LIMIT ?, ? ', ($page-1)*$limit, $limit);


		$query = $this->db->placehold("SELECT
				a.id,  
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
				a.furnished
			FROM __apartments a
			WHERE 
				1
				$id_filter
				$house_id_filter
				$floor_filter
				$rent_apartment_filter
				$visible_filter
			$group_by
			ORDER BY a.position
			$sql_limit");

		$this->db->query($query);

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


		if(isset($filter['sort']) && $filter['sort'] == 'price')
			$order_by = 'r.price1, ';


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
				r.visible,
				r.position,
				r.color,
				r.date_added,
				r.date_shutdown
			FROM __rooms r
				$label_select
			WHERE 
				1
				$id_filter
				$type_id_filter
				$house_id_filter
				$apartment_id_filter
				$label_filter
				$visible_filter
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
				COUNT(distinct r.id) as count
		    FROM __rooms r 
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
	
	function get_room_labels($room_id = array())
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
		if(!empty($filter['house_id']) || !empty($filter['room_type_id']) || !empty($filter['price_from']) || !empty($filter['price_to']) || (isset($filter['rent_type']) && $filter['rent_type']>1) )
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

			// $labels_join = 'LEFT JOIN __rooms_rlabels AS rl ON rl.room_id=b.room_id';

			// $room_label_filter_s = '';
			// foreach((array)$filter['room_label'] as $rl)
			// {
			// 	if(!empty($room_label_filter_s))
			// 		$room_label_filter_s .= 'AND ';

			// 	$room_label_filter_s .= $this->db->placehold('rl.label_id=?', $rl);

			// }
			// $room_label_filter = 'AND ('.$room_label_filter_s.')';


			//$room_label_filter = $this->db->placehold('AND rl.label_id in(?@)', (array)$filter['room_label']);



			foreach((array)$filter['room_label'] as $label_id)
				$room_label_filter .= $this->db->placehold('AND b.id in (
					SELECT 
						bb.id 
					FROM __beds bb
					LEFT JOIN __rooms_rlabels AS bb_rl ON bb_rl.room_id=bb.room_id WHERE bb_rl.label_id=? GROUP BY bb.id)', $label_id);

		}

		/*if(!empty($filter['price_from']) || !empty($filter['price_to']))
		{

		}*/

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
				$is_due_filter = $this->db->placehold('AND (bj.due IS NULL OR bj.due>=?) AND bj.status>0 AND bj.status!=4', date('Y-m-d'));
			}
			
			$journal_filter = $this->db->placehold("AND 0=(SELECT count(bj.id) FROM __bookings bj WHERE b.id=bj.object_id AND bj.type=1 AND ($date_from $date_to) $is_due_filter LIMIT 1)");
		}

		if(isset($filter['visible']))
			$visible_filter = $this->db->placehold('AND b.visible = ?', intval($filter['visible']));


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
				b.position
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



	// ------------------------
	// ----- BEDS JOURNAL -----
	// ------------------------

	public $beds_journal_statuses = array(
		0 => array(
			'name' => 'Canceled',
			'icon' => 'fa-trash',
			'substatuses' => array(
				0 => 'Cancel',
				1 => 'Early move out',
				2 => 'Pause of stay',
				3 => 'Change the house',
				9 => 'Other'
			)
		),
		1 => array(
			'name' => 'New',
			'icon' => 'fa-tag'
		),
		2 => array(
			'name' => 'Payment Pending',
			'icon' => 'fa-clock-o'
		),
		3 => array(
			'name' => 'Contract / Invoice',
			'icon' => 'fa-check'
		),
		4 => array(
			'name' => 'Paid | Without living',
			'icon' => 'fa-check'
		)
	);


	public function get_beds_journal_status($status_key, $substatus_key=null)
	{
		if(!isset($status_key))
			return false;

		if(isset($this->beds_journal_statuses[$status_key]) && is_null($substatus_key))
			return $this->beds_journal_statuses[$status_key]['name'];
		elseif(isset($this->beds_journal_statuses[$status_key]) && !empty($this->beds_journal_statuses[$status_key]['substatuses']))
		{
			if(isset($this->beds_journal_statuses[$status_key]['substatuses'][$substatus_key]))
				return $this->beds_journal_statuses[$status_key]['substatuses'][$substatus_key];
			else
				return false;
		}
		else 
			return false;
	}



	// Types:
	// 1 - Beds
	// 2 - Apartments
	public function get_beds_journal($filter = array())
	{
		// Statuses:
		// 0 - Canceled
		// 1 - New
		// 2 - Payment Pending
		// 3 - Contract / Invoice


		$id_filter = '';
		$parent_id_filter = '';
		$bed_id_filter = '';
		$house_id_filter = '';
		$user_id_filter = '';
		$is_due_filter = '';
		$not_canceled_filter = '';
		$date_filter = '';
		$date_from_filter = '';
		$date_to_filter = '';
		$status_filter = '';
		$substatus_filter = '';

		$group_by = '';
		$limit = '';

		if(isset($filter['limit']))
			$limit = $this->db->placehold('LIMIT ?', (int)$filter['limit']);

		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND bj.id in(?@)', (array)$filter['id']);

		if(!empty($filter['parent_id']))
			$parent_id_filter = $this->db->placehold('AND bj.parent_id in(?@)', (array)$filter['parent_id']);

		if(!empty($filter['bed_id']))
			$bed_id_filter = $this->db->placehold('AND bj.bed_id in(?@)', (array)$filter['bed_id']);

		if(!empty($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND bj.house_id in(?@)', (array)$filter['house_id']);

		if(!empty($filter['user_id']))
			$user_id_filter = $this->db->placehold('AND bj.user_id in(?@)', (array)$filter['user_id']);

		if(!empty($filter['is_due']))
			$is_due_filter = $this->db->placehold('AND (bj.due IS NULL OR bj.due>=?) AND bj.status>0', date('Y-m-d'));
		elseif(!empty($filter['not_canceled']))
			$not_canceled_filter = 'AND bj.status>0';


		if(!empty($filter['status']))
			$status_filter = $this->db->placehold('AND bj.status in(?@)', (array)$filter['status']);

		if(!empty($filter['substatus']))
			$substatus_filter = $this->db->placehold('AND bj.substatus in(?@)', (array)$filter['substatus']);


		if(!empty($filter['date_from']) && !empty($filter['date_to']))
		{
			// $date_from_filter = $this->db->placehold('AND (bj.depart<?)', $filter['date_from']);
			// $date_to_filter = $this->db->placehold('AND (bj.arrive>?)', $filter['date_to']);

			//$date_filter = $this->db->placehold('AND ( (bj.arrive<=? AND bj.depart>=?) OR (bj.arrive<=? AND bj.depart>=?))', $filter['date_from'], $filter['date_from'], $filter['date_to'], $filter['date_to']);

			//echo date("Y-m-d", $filter['date_to']); exit;


			// $date_from = new DateTime($filter['date_from']);
			// $date_from->modify('-1 day');

			// $date_to = new DateTime($filter['date_to']);
			// $date_to->modify('-1 day');

			//echo $date_to->format('Y-m-d'); exit;


			// $date_filter = $this->db->placehold('AND ( (bj.arrive<=? AND bj.depart>=?) OR (bj.arrive<=? AND bj.depart>=?))', $filter['date_from'], $filter['date_from'], $filter['date_to'], $filter['date_from']);
			$date_filter = $this->db->placehold('AND ( (bj.arrive<? AND bj.depart>?) OR (bj.arrive<? AND bj.depart>?))', $filter['date_from'], $filter['date_from'], $filter['date_to'], $filter['date_from']);

			// $date_filter = $this->db->placehold('AND ( (bj.arrive<=? AND bj.depart>=?) OR (bj.arrive<=? AND bj.depart>=?))', $filter['date_from'], $filter['date_from'], $date_to->format('Y-m-d'), $date_from->format('Y-m-d'));
		}
		elseif(!empty($filter['now']))
		{
			$date_filter = $this->db->placehold('AND (bj.arrive<=? AND bj.depart>=?)', date('Y-m-d'), date('Y-m-d'));
		}


		$query = $this->db->placehold("SELECT
				bj.id,
				bj.type,
				bj.parent_id,
				bj.group_id,
				bj.bed_id,
				bj.house_id,
				bj.user_id,
				bj.client_type_id,
				bj.price_month,
				bj.price_day,
				bj.total_price,
				bj.arrive,
				bj.depart,
				bj.due,
				bj.paid_to,
				bj.created,
				bj.status,
				bj.substatus
			FROM __beds_journal bj
			WHERE 
				1
				$id_filter
				$parent_id_filter
				$bed_id_filter
				$house_id_filter
				$user_id_filter
				$is_due_filter
				$not_canceled_filter
				$status_filter
				$substatus_filter
				$date_filter
			$group_by
			ORDER BY bj.id DESC
			$limit");

		$this->db->query($query);


		if(isset($filter['limit']) && $filter['limit'] == 1)
		{
			$bj = $this->db->result();
			if(!empty($bj->client_type_id))
				$bj->client_type = $this->users->get_client_type($bj->client_type_id);
			return $bj;
		}
		else
			return $this->db->results();

	}

	// SELECT * FROM (SELECT * FROM s_beds_journal WHERE bed_id in('7','8') ORDER BY id) bj GROUP BY bj.bed_id ORDER BY bj.id DESC
	public function prev_beds_journal($filter = array())
	{
		$bed_id_filter = '';
		$is_due_filter = '';
		$date_filter = '';
		$limit = '';

		if(isset($filter['limit']))
			$limit = $this->db->placehold('LIMIT ?', (int)$filter['limit']);

		if(!empty($filter['bed_id']))
			$bed_id_filter = $this->db->placehold('AND bj.bed_id in(?@)', (array)$filter['bed_id']);

		if(!empty($filter['is_due']))
			$is_due_filter = $this->db->placehold('AND (bj.due IS NULL OR bj.due>=?) AND bj.status>0', date('Y-m-d'));

		if(!empty($filter['date_to']))
		{
			// $date_to = new DateTime($filter['date_to']);
			//$date_to->modify('-1 day');
			//echo $date_to->format('Y-m-d'); exit;
			// $date_filter = $this->db->placehold('AND bj.depart<=?', $date_to->format('Y-m-d'));
			$date_filter = $this->db->placehold('AND bj.depart<=?', $filter['date_to']);
		}
		else
			return false;


		/*$query = $this->db->placehold("SELECT
				bj.id,
				bj.parent_id,
				bj.group_id,
				bj.bed_id,
				bj.house_id,
				bj.user_id,
				bj.arrive,
				bj.depart,
				bj.due,
				bj.status
			FROM __beds_journal bj
			WHERE 
				1
				$bed_id_filter
				$is_due_filter
				$date_filter
			GROUP BY bj.id
			ORDER BY bj.depart DESC, bj.id DESC
			$limit");*/

		$query = $this->db->placehold("SELECT
				bj.id,
				bj.parent_id,
				bj.group_id,
				bj.bed_id,
				bj.house_id,
				bj.user_id,
				bj.client_type_id,
				bj.arrive,
				bj.depart,
				bj.due,
				bj.status
			FROM __beds_journal bj
			INNER JOIN
			(
			    SELECT max(depart) max_depart, bj.bed_id, bj.id
			    FROM __beds_journal bj
			    WHERE
			    	1
					$bed_id_filter
					$is_due_filter
					$date_filter
			    GROUP BY bj.bed_id
			) bj2
			ON bj.bed_id=bj2.bed_id AND bj.depart=bj2.max_depart
			GROUP BY bj.id
			ORDER BY bj.depart DESC, bj.id DESC
			$limit");

		// $bed_id_filter
		// 		$is_due_filter
		// 		$date_filter


		/*
		SELECT bj.id, bj.parent_id, bj.group_id, bj.bed_id, bj.house_id, bj.user_id, bj.arrive, bj.depart, bj.due, bj.status FROM s_beds_journal bj INNER JOIN ( SELECT max(bj.depart) max_depart, bj.bed_id, bj.id FROM s_beds_journal bj WHERE 1 AND bj.bed_id in('1','2','6','7','8','10','11','12') AND (bj.due IS NULL OR bj.due>='2020-03-10') AND bj.status>0 AND bj.depart<='2021-09-30' GROUP BY bj.bed_id ) bj2 ON bj.bed_id = bj2.bed_id AND bj2.max_depart=bj.depart WHERE 1 GROUP BY bj.id ORDER BY bj.depart DESC, bj.id DESC LIMIT 8
		*/



		//print_r($query); exit;

		$this->db->query($query);


		return $this->db->results();
	}

	public function next_beds_journal($filter = array())
	{
		$bed_id_filter = '';
		$is_due_filter = '';
		$date_filter = '';


		if(isset($filter['limit']))
			$limit = $this->db->placehold('LIMIT ?', (int)$filter['limit']);

		if(!empty($filter['bed_id']))
			$bed_id_filter = $this->db->placehold('AND bj.bed_id in(?@)', (array)$filter['bed_id']);

		if(!empty($filter['is_due']))
			$is_due_filter = $this->db->placehold('AND (bj.due IS NULL OR bj.due>=?) AND bj.status>0', date('Y-m-d'));

		if(!empty($filter['date_from']))
			$date_filter = $this->db->placehold('AND bj.arrive>=?', $filter['date_from']);
		else
			return false;

		/*$query = $this->db->placehold("SELECT
				bj.id,
				bj.parent_id,
				bj.group_id,
				bj.bed_id,
				bj.house_id,
				bj.user_id,
				bj.arrive,
				bj.depart,
				bj.due,
				bj.status
			FROM __beds_journal bj
			WHERE 
				1
				$bed_id_filter
				$is_due_filter
				$date_filter
			GROUP BY bj.bed_id
			ORDER BY bj.id
			$limit");*/


		$query = $this->db->placehold("SELECT
				bj.id,
				bj.parent_id,
				bj.group_id,
				bj.bed_id,
				bj.house_id,
				bj.user_id,
				bj.client_type_id,
				bj.arrive,
				bj.depart,
				bj.due,
				bj.status
			FROM __beds_journal bj
			INNER JOIN
			(
			    SELECT min(arrive) min_arrive, bj.bed_id, bj.id
			    FROM __beds_journal bj
			    WHERE
			    	1
					$bed_id_filter
					$is_due_filter
					$date_filter
			    GROUP BY bj.bed_id
			) bj2
			ON bj.bed_id=bj2.bed_id AND bj.arrive=bj2.min_arrive
			GROUP BY bj.id
			ORDER BY bj.arrive DESC, bj.id DESC
			$limit");

		$this->db->query($query);


		return $this->db->results();
		
	}




	public function add_bed_journal($val)
	{	
		$query = $this->db->placehold('INSERT INTO __beds_journal SET ?%', $val);
		if(!$this->db->query($query))
			return false;

		$id = $this->db->insert_id();	
		return $id;
	}

	public function update_bed_journal($id, $val)
	{
		$query = $this->db->placehold("UPDATE __beds_journal SET ?% WHERE id in(?@) LIMIT ?", $val, (array)$id, count((array)$id));
		$this->db->query($query);
		return $id;
	}

	public function delete_bed_journal($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __beds_journal WHERE id=? LIMIT 1", intval($id));
			$this->db->query($query);
		}
	}


	public function cancel_bed_journal($filter = array())
	{
		if(empty($filter['id']) && empty($filter['bed_id']) && empty($filter['user_id']))
			return false;

		$filter['not_canceled'] = true;

		$bjs = $this->get_beds_journal($filter);

		if(!empty($bjs))
		{
			$manager = $this->managers->get_manager();
			$br = '';
			$bookings_ids = array();
			foreach($bjs as $bj)
			{
				$bookings_ids[] = $bj->id;

				$bj_upd = array();
				$bj_upd['status'] = 0;
				// if(!empty($filter['user_id']))
				// 	$bj_upd['substatus'] = 0;
				
				$this->update_bed_journal($bj->id, $bj_upd);

				$log_value  = 'Status: '.$this->get_beds_journal_status($bj->status).' &rarr; '.$this->get_beds_journal_status(0);

				if(!empty($filter['note']))
	            	$log_value .= $br.'System note: '.$filter['note'];

	            $this->logs->add_log(array(
	                'parent_id' => $bj->id, 
	                'type' => 1, 
	                'subtype' => 2, // Change status
	                'user_id' => $bj->user_id, 
	                'sender_type' => 2,
	                'sender' => $manager->login, 
	                'value' => $log_value
	            ));	            

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


	// ------------------
	// ---- BOOKINGS ----
	// ------------------
	public $bookings_statuses = array(
		0 => array(
			'name' => 'Canceled',
			'icon' => 'fa-trash',
			'substatuses' => array(
				0 => 'Cancel',
				1 => 'Early move out',
				2 => 'Pause of stay',
				3 => 'Change the house',
				9 => 'Other'
			)
		),
		1 => array(
			'name' => 'New',
			'icon' => 'fa-tag'
		),
		2 => array(
			'name' => 'Payment Pending',
			'icon' => 'fa-clock-o',
		),
		3 => array(
			'name' => 'Contract / Invoice',
			'icon' => 'fa-check',
			'substatuses' => array(
				1 => 'Early move out'
			)
		),
		4 => array(
			'name' => 'Paid | Without living',
			'icon' => 'fa-check'
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

		// sp_type
		// 0 || null - standart
		// 1 - extension
		// 2 - change bed

		// moved:
		// 0 - не заселен
		// 1 - отправлен мувин
		// 2 - отправлен муваут
		// 3 - мувин подтвержден хауслидером
		// 4 - муваут подтвержден хауслидером

		$id_filter = '';
		$type_filter = '';
		$sp_type_filter = '';
		$sp_group_id_filter = '';
		$parent_id_filter = '';
		$object_id_filter = '';
		$house_id_filter = '';
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
		$created_date_filter = '';
		$created_by_filter = '';
		$moved_filter = '';

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

		if(!empty($filter['parent_id']))
			$parent_id_filter = $this->db->placehold('AND b.parent_id in(?@)', (array)$filter['parent_id']);

		if(!empty($filter['object_id']))
			$object_id_filter = $this->db->placehold('AND b.object_id in(?@)', (array)$filter['object_id']);

		if(!empty($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND b.house_id in(?@)', (array)$filter['house_id']);


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


		if(!empty($filter['status']))
			$status_filter = $this->db->placehold('AND b.status in(?@)', (array)$filter['status']);

		if(!empty($filter['substatus']))
			$substatus_filter = $this->db->placehold('AND b.substatus in(?@)', (array)$filter['substatus']);

		if(!empty($filter['moved']))
			$moved_filter = $this->db->placehold('AND b.moved in(?@)', (array)$filter['moved']);

		if(!empty($filter['date_start_from']))
		{
			$date_from_filter = $this->db->placehold('AND b.arrive>?', $filter['date_start_from']);
			$order_by = 'b.arrive';
		}

		if(isset($filter['arrive']))
			$arrive_filter = $this->db->placehold('AND b.arrive <= ? AND b.arrive >= ?', $filter['arrive'],  $filter['arrive_from']);
		
		if(isset($filter['depart']))
			$depart_filter = $this->db->placehold('AND b.depart <= ? AND b.depart >= ?', $filter['depart'],  $filter['depart_from']);


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

		
		if(isset($filter['created_month']) && isset($filter['created_year']))
		{
			$created_date_filter = $this->db->placehold(' AND (MONTH(b.created)=? AND YEAR(b.created)=?)', $filter['created_month'], $filter['created_year']);
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
				b.airbnb_reservation_id,
				b.price_month,
				b.price_month_airbnb,
				b.price_day,
				b.total_price,
				b.arrive,
				b.depart,
				b.due,
				b.paid_to,
				b.created,
				b.status,
				b.substatus,
				b.brokerfee_discount,
				b.add_to_contract,
				b.moved
				$user_id_select
				$created_by_select
			FROM __bookings b
				$user_id_filter
				$created_by_filter
			WHERE 
				1
				$id_filter
				$type_filter
				$sp_type_filter
				$sp_group_id_filter
				$parent_id_filter
				$object_id_filter
				$house_id_filter
				$apartment_id_filter
				$client_type_id_filter
				$is_due_filter
				$not_canceled_filter
				$status_filter
				$substatus_filter
				$date_filter
				$date_from_filter
				$arrive_filter
				$depart_filter
				$created_date_filter
				$moved_filter
			$group_by
			$order_by
			$limit");



		$this->db->query($query);


		if(isset($filter['limit']) && $filter['limit'] == 1)
		{
			$bj = $this->db->result();
			if(!empty($bj->client_type_id))
				$bj->client_type = $this->users->get_client_type($bj->client_type_id);
			return $bj;
		}
		else
		{
			$bookings = $this->db->results();

			if((!isset($filter['select_users']) || !isset($filter['no_to_key'])) || isset($filter['sp_group']))
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
						if(!empty($b->sp_group_id))
						{
							if(empty($filter['sp_group_from_start']) || $b->sp_group_id == $b->id)
								$sp_group_ids[$b->sp_group_id] = $b->sp_group_id;

							if(isset($bookings[$b->sp_group_id]))
							{
								$bookings[$b->sp_group_id]->sp_bookings[$b->id] = $b;

								$b->u_depart = strtotime($b->depart);

								if($b->sp_group_id != $b->id && strtotime($b->depart) > strtotime($bookings[$b->sp_group_id]))
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
							'sp_group_id' => $sp_group_ids
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
								
								if($b->u_depart > $spbookings[$b->sp_group_id]->u_depart)
								{
									$spbookings[$b->sp_group_id]->u_depart = $b->u_depart;
									$spbookings[$b->sp_group_id]->depart = date('Y-m-d', $b->u_depart);
								}


								if($u_today >= $b->u_arrive && $u_today <= $b->u_depart)
								{
									$b->active = 1;
								}

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
						'booking_id' => $bookings_ids
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
				b.status
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
				b.status
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
				// if(!empty($filter['user_id']))
				// 	$bj_upd['substatus'] = 0;
				
				$this->update_booking($bj->id, $bj_upd);

				$log_value  = 'Status: '.$this->get_booking_status($bj->status).' &rarr; '.$this->get_booking_status(0);

				if(!empty($filter['note']))
	            	$log_value .= $br.'System note: '.$filter['note'];

	            $this->logs->add_log(array(
	                'parent_id' => $bj->id, 
	                'type' => 1, 
	                'subtype' => 2, // Change status
	                'user_id' => $user_id, 
	                'sender_type' => 2,
	                'sender' => $manager->login, 
	                'value' => $log_value
	            ));	            

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

			if($params['payment_status'] == 'pending' && in_array($booking->status, array(0,1)))
			{
				$booking_upd->status = 2; // Payment Pending

				$log_subtype = 2;  // 2 - Change status
				$log_value  .= 'Status: '.$this->get_booking_status($booking->status).' &rarr; '.$this->get_booking_status($booking_upd->status).$br;
			}
			elseif($params['payment_status'] == 'succeeded' && in_array($booking->status, array(0,1,2)))
			{
				$booking_upd->status = 3; // Contract / Invoice

				$log_subtype = 2;  // 2 - Change status
				//$log_subtype = 4; // 4 - Payment
				$log_value  .= 'Status: '.$this->get_booking_status($booking->status).' &rarr; '.$this->get_booking_status($booking_upd->status).$br;
			}


			$order = $this->orders->get_order((int)$params['order_id']);
			if(!empty($order))
			{
				if($params['payment_status'] == 'pending')
				{
					if($params['payment_method'] == 'ACH')
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



}
