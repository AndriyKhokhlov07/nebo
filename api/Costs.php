<?php


require_once('Backend.php');

class Costs extends Backend
{

	public $cost_types = array(
		1 => array(
			'name' => 'Moves bedsheets',
			'subtypes' => array(
				1 => array('name' => 'bedsheet', 'price' => 39),
				2 => array('name' => 'bedsheet 2', 'price' => 25)
			)
		),
		2 => array(
			'name' => 'Professional Cleaning / Flips',
			'subtypes' => array(
				1 => array('name' => 'Regular cleaning', 'price' => 38),
				2 => array('name' => 'Common Area cleaning', 'price' => 38),
				3 => array('name' => 'Room cleaning', 'price' => 25),
				4 => array('name' => 'Cleaning request', 'price' => 25),
				5 => array('name' => 'Flip' ,'price' => 25),
			)
		),
		3 => array(
			'name' => 'PM / Handyman / Super',
			'subtypes' => array(
				1 => array('name' => 'PM'),
				2 => array('name' => 'Handyman'),
				3 => array('name' => 'Super'),
				4 => array('name' => 'Other Labor')
			)
		),
		4 => array(
			'name' => 'Materials / Supply'
		),
		5 => array(
			'name' => 'Contracts / Payments'
		),
		6 => array(
			'name' => 'Utilities / Insurance'
		),
		7 => array(
			'name' => 'Sales'
		),
		9 => [
			'name' => 'Expenses SUM (Rent Roll)'
		],
		20 => [
			'name' => 'Other'
		]
	);
	
	public $sender_types = array(
		1 => 'System',
		2 => 'Admin',
		3 => 'User',
		4 => 'Callback'
	);


	public function get_costs($filter = array())
	{
		$id_filter = '';
		$parent_id_filter = '';
		$house_id_filter = '';

		$date_from_filter = '';
		$date_to_filter = '';


		$type_filter = '';
		$subtype_filter = '';
		$limit = 1000;
		$page = 1;

		if(isset($filter['limit']))
			$limit = max(1, intval($filter['limit']));

		if(isset($filter['page']))
			$page = max(1, intval($filter['page']));

		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND c.id in(?@)', (array)$filter['id']);

		if(!empty($filter['parent_id']))
			$parent_id_filter = $this->db->placehold('AND c.parent_id in(?@)', (array)$filter['parent_id']);

		if(!empty($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND c.house_id in(?@)', (array)$filter['house_id']);

		if(!empty($filter['type']))
			$type_filter = $this->db->placehold('AND c.type in(?@)', (array)$filter['type']);

		if(!empty($filter['subtype']))
			$subtype_filter = $this->db->placehold('AND c.subtype in(?@)', (array)$filter['subtype']);

		if(!empty($filter['date_from']))
			$date_from_filter = $this->db->placehold('AND c.date >= ?', $filter['date_from']);
		if(!empty($filter['date_to']))
			$date_to_filter = $this->db->placehold('AND c.date <= ?', $filter['date_to']);

		$sql_limit = $this->db->placehold(' LIMIT ?, ? ', ($page-1)*$limit, $limit);


		$query = $this->db->placehold("SELECT
				c.id,  
				c.parent_id,
				c.house_id,
				c.type,
				c.subtype,
				c.price,
				c.name,
				c.date,
				c.sender_type,
				c.sender,
				c.data,
				c.note,
				c.ip
			FROM __costs c
			WHERE
				1
				$id_filter
				$parent_id_filter
				$house_id_filter
				$type_filter
				$subtype_filter
				$date_from_filter
				$date_to_filter
			ORDER BY c.date
			$sql_limit");

		$this->db->query($query);

		$costs = $this->db->results();
		if(!empty($costs))
		{
			foreach($costs as &$cost)
			{
				if(!empty($cost->type) && isset($this->cost_types[$cost->type]))
				{
					$cost->type_name = $this->cost_types[$cost->type]['name'];

					if(!empty($cost->subtype) && isset($this->cost_types[$cost->type]['subtypes'][$cost->subtype]))
						$cost->subtype_name = $this->cost_types[$cost->type]['subtypes'][$cost->subtype]['name'];
				}
				if(!empty($cost->sender_type) && isset($this->sender_types[$cost->sender_type]))
					$cost->sender_type_name = $this->sender_types[$cost->sender_type];

				if(!empty($cost->data) && $cost->type!=9)
					$cost->data = (object)unserialize($cost->data);
			}
		}
		
		if(isset($filter['count']) && $filter['count'] == 1)
			$costs = $costs[0];

		return $costs;
	}


	public function add_cost($cost)
	{	
		$cost = (array)$cost;

		if(!empty($cost['data']))
			$cost['data'] = serialize($cost['data']);

		$cost['ip'] = $_SERVER['REMOTE_ADDR'];

		$query = $this->db->placehold('INSERT INTO __costs SET ?%', $cost);
		if(!$this->db->query($query))
			return false;


		return $this->db->insert_id();
	}


	public function update_cost($id, $cost)
	{
		$cost = (array)$cost;

		if(empty($id))
		{
			return $this->add_cost($cost);
		}
		else
		{
			if(empty($cost['ip']))
				$cost['ip'] = $_SERVER['REMOTE_ADDR'];

			$query = $this->db->placehold("UPDATE __costs SET ?% WHERE id=? LIMIT 1", $cost, intval($id));
			$this->db->query($query);
			return $id;
		}
		
	}

}
