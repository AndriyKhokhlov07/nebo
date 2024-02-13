<?php

require_once('Backend.php');


class Notifications extends Backend
{
	// type 
	// 1 - hellorented
	// 2 - background check
	// ....



	// Priorities:
	// 1 - Info
	// 2 - Warning
	// 3 - Inortant
	// 4 - Critically

	public $notifications_types = array(
		1 => array('name' => 'Hellorented'), // Now not working
		2 => array(
			'name' => 'Background Check',
			'priority' => 2
		),
		3 => array(
			'name' => 'Contract',
			'priority' => 2
		),
		4 => array(
			'name' => 'Invoice',
			'subtypes' => array(
				1 => array(
					'name' => 'To Pay',
					'priority' => 2
				),
				1 => array(
					'name' => 'To urgent Pay',
					'priority' => 4
				)
			)
		),
		5 => array(
			'name' => 'Move-In',
			'subtypes' => array(
				1 => array(
					'name' => 'Guest | Info',
					'priority' => 1
				),
				2 => array(
					'name' => 'Guest | Access',
					'priority' => 2
				),
				3 => array(
					'name' => 'Houseleader | Guest Info',
					'priority' => 2
				)
			)
		),
		6 => array(
			'name' => 'Move-Out',
			'subtypes' => array(
				1 => array(
					'name' => 'Guest',
					'priority' => 2
				),
				2=> array(
					'name' => 'Houseleader | Guest Info',
					'priority' => 2
				)
			)
		),
		7 => array(
			'name' => 'Cleaning',
			'subtypes' => array()
		),
		8 => array(
			'name' => 'Text'
		),
		9 => array(
			'name' => 'Visit of Outpost Team',
			'subtypes' => array(
				1 => array(
					'name' => 'Apartament',
					'priority' => 2
				),
				2=> array(
					'name' => 'House',
					'priority' => 2
				)
			)
		),
		10 => array(
			'name' => 'Alert',
			'subtypes' => array(
				1 => array(
					'name' => 'Apartament',
					'priority' => 2
				),
				2=> array(
					'name' => 'House',
					'priority' => 2
				)
			)
		)

	);

	// Move In To Houseleader
	// $this->notifications->add_notification(array(
	// 	'type' => 5,
	// 	'subtype' => 3,
	// 	'user_id' => 1187, // Houseleader ID
	//	'object_id' => 1258, // Guest ID
	// ));

	public function get_notifications($filter = array())
	{
		$id_filter = '';
		$user_id_filter = '';
		$type_filter = '';
		$object_id_filter = '';
		$subtype_filter = '';
		
		
		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND n.id in(?@)', (array)$filter['id']);

		if(!empty($filter['user_id']))
			$user_id_filter = $this->db->placehold('AND n.user_id in(?@)', (array)$filter['user_id']);

		if(!empty($filter['object_id']))
			$object_id_filter = $this->db->placehold('AND n.object_id in(?@)', (array)$filter['object_id']);

		if(isset($filter['type']))
			$type_filter = $this->db->placehold('AND n.type in (?@)', (array)$filter['type']);

		if(isset($filter['subtype']))
			$subtype_filter = $this->db->placehold('AND n.subtype in (?@)', (array)$filter['subtype']);

		$query = $this->db->placehold("SELECT 
						n.id,
						n.type,
						n.subtype,
						n.url,
						n.user_id,
						n.object_id,
						n.creator,
						n.date_created,
						n.date_viewed,
						n.priority,
						n.date,
						n.time_from,
						n.time_to,
						n.text,
						n.auto_move
					FROM __notifications AS n
					WHERE 1
						$id_filter
						$user_id_filter
						$type_filter
						$subtype_filter
						$object_id_filter
					ORDER BY n.id DESC");
		$this->db->query($query);	
		return $this->db->results();
	}


	public function get_notification($id)
	{	
		if(empty($id))
			return false;

		if(is_int($id))
			$where = $this->db->placehold(' WHERE n.id=? ', intval($id));
		else
			$where = $this->db->placehold(' WHERE n.url=? ', $id);
			
		$query = $this->db->placehold("SELECT
						n.id,
						n.type,
						n.subtype,
						n.url,
						n.user_id,
						n.object_id,
						n.creator,
						n.date_created,
						n.date_viewed,
						n.priority,
						n.date,
						n.time_from,
						n.time_to,
						n.text,
						n.auto_move
					FROM __notifications n
						$where
					LIMIT 1", $id);
		
		$this->db->query($query);
		return $this->db->result();
	}
	
	public function update_notification($id, $notification)
	{
		$notification = (array)$notification;
		$viewed_now_query = '';
		if(isset($notification['date_viewed']) && $notification['date_viewed'] == 'now')
		{
			unset($notification['date_viewed']);
			if(!empty($notification))
				$viewed_now_query .= ', ';
			$viewed_now_query .= 'date_viewed=NOW()';
		}

		$query = $this->db->placehold("UPDATE 
					__notifications 
				SET 
					?% 
					$viewed_now_query
				WHERE id=? 
				LIMIT 1", $notification, intval($id));

		$this->db->query($query);
		return $id;
	}
	
	public function add_notification($notification)
	{
		$notification = (array)$notification;

		$notification['url'] = md5(uniqid($this->config->salt, true));

		$date_created_query = '';
		if(!isset($notification['date_created']))
			$date_created_query = ', date_created=NOW()';

		$query = $this->db->placehold("INSERT INTO __notifications SET ?% $date_created_query", $notification);
		$this->db->query($query);
		return $this->db->insert_id();
	}

	public function delete_notification($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __notifications WHERE id = ? LIMIT 1", intval($id));
			$this->db->query($query);
		}
	}


	
}