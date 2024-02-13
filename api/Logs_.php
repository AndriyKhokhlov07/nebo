<?php


require_once('Backend.php');

class Logs extends Backend
{

	public $log_types = array(
		1 => array(
			'name' => 'Booking',
			'subtypes' => array(
				1 => array('name' => 'Create'),
				2 => array('name' => 'Change status'),
				3 => array('name' => 'Early move out'),
				4 => array('name' => 'Payment'),
				5 => array('name' => 'Change bed'),
				6 => array('name' => 'Contract added'),
				7 => array('name' => 'Update Extension'),
				8 => array('name' => 'Change Guest type'),
				9 => array('name' => 'Change contract'),
				10=> array('name' => 'Edit'),
				11=> array('name' => 'First sales flow Approved')
				// 11=> array('name' => 'Early Move out')
			)
		),
		2 => array(
			'name' => 'Users (Guests)',
			'subtypes' => array(
				1 => array('name' => 'Note'),
				2 => array('name' => 'Create'),
				10 => array('name' => 'Airbnb Salesflow Sent')

			)
		),
		3 => array(
			'name' => 'Invoices (Orders)',
			'subtypes' => array(
				1 => array('name' => 'Create'),
				2 => array('name' => 'Sent'),
				3 => array('name' => 'Viewed'),
				4 => array('name' => 'Change status'),
				5 => array('name' => 'Payment'),
				6 => array('name' => 'Edit'),
				7 => array('name' => 'Note'),
				8 => array('name' => 'Sent to owner')
			)
		),
		4 => array(
			'name' => 'Contracts',
			'subtypes' => array(
				1 => array('name' => 'Created'),
				2 => array('name' => 'Start second sales flow'),
				3 => array('name' => 'Viewed'),
				4 => array('name' => 'Sign'),
				5 => array('name' => 'Change status'),
				6 => array('name' => 'Edit'),
				7 => array('name' => 'Downloaded'),
				8 => array('name' => 'Send contract to customer'),
				9 => array('name' => 'Send first sales flow'),
				10 => array('name' => 'Contract approved'),
				11 => array('name' => 'First sales flow Approved'),
				12 => array('name' => 'Transfer deposit'),
				13 => array('name' => 'Copy link')

			)
		),
		5 => array(
			'name' => 'Hellorented',
			'subtypes' => array(
				1 => array('name' => 'Invite Tenant added'),
				2 => array('name' => 'Pending'),
				3 => array('name' => 'Declined'),
				4 => array('name' => 'Closed'),
				5 => array('name' => 'Funded'),
				6 => array('name' => 'Other')
			)
		),
		6 => array(
			'name' => 'TransUnion',
			'subtypes' => array(
				1 => array('name' => 'Accept'),
				2 => array('name' => 'Low Accept'),
				3 => array('name' => 'Conditional'),
				4 => array('name' => 'Decline'),
				5 => array('name' => 'Refer'),
				6 => array('name' => 'Pending'),
				7 => array('name' => 'Error')
			)
		),
		7 => array(
			'name' => 'Rental Application',
			'subtypes' => array(
				1 => array('name' => 'Sent'),
				2 => array('name' => 'Viewed'),
				3 => array('name' => 'Sign')
			)
		),
		8 => array(
			'name' => 'Covid Form',
			'subtypes' => array(
				1 => array('name' => 'Sent'),
				2 => array('name' => 'Viewed'),
				3 => array('name' => 'Sign')
			)
		),
		9 => array(
			'name' => 'Ekata',
			'subtypes' => array(
				1 => array('name' => 'Request')
			)
		),
		10 => array(
			'name' => 'Remote check-in',
			'subtypes' => array(
				1 => array('name' => 'Sent')
			)
		),
		11 => [
			'name' => 'Sent to owner',
			'subtypes' => [
				1 => ['name' => 'Invoices']
			]
		],
		12 => [
			'name' => 'Window Guards Form',
			'subtypes' => [
				1 => ['name' => 'Sent'],
				2 => ['name' => 'Viewed'],
				3 => ['name' => 'Sign']
			]
		],
		13 => [
			'name' => 'Salesflow',
			'subtypes' => [
				1 => ['name' => 'Approved'],
				2 => ['name' => 'More docs'],
				3 => ['name' => 'Reject'],
				4 => ['name' => 'Need a Guarantor'] // guarantor upd
			]
		],
		// guarantor upd
		14 => [
			'name' => 'User Check',
			'subtypes' => [
				1 => ['name' => 'Sent'],
				2 => ['name' => 'Viewed'],
				3 => ['name' => 'Sign']
			]
		],
		15 => [  
			'name' => 'Need a Guarantor',
			'subtypes' => [
				1 => ['name' => 'Sent Email'],
				2 => ['name' => 'Viewed'],
				3 => ['name' => 'Guarantor is indicated']
			]
		]
		// guarantor upd (end)
	);

	public $sender_types = [
		1 => 'System',
		2 => 'Admin',
		3 => 'User',
		4 => 'Callback'
	];


	public function get_logs($filter = array())
	{
		$id_filter = '';
		$parent_id_filter = '';
		$user_id_filter = '';
		$type_filter = '';
		$subtype_filter = '';
		$sender_type_filter = '';
		$sender_filter = '';
		$limit = 1000;
		$page = 1;

		if(isset($filter['limit']))
			$limit = max(1, intval($filter['limit']));

		if(isset($filter['page']))
			$page = max(1, intval($filter['page']));

		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND l.id in(?@)', (array)$filter['id']);

		if(!empty($filter['parent_id']))
			$parent_id_filter = $this->db->placehold('AND l.parent_id in(?@)', (array)$filter['parent_id']);

		if(!empty($filter['user_id']))
			$user_id_filter = $this->db->placehold('AND l.user_id in(?@)', (array)$filter['user_id']);

		if(!empty($filter['type']))
			$type_filter = $this->db->placehold('AND l.type in(?@)', (array)$filter['type']);

		if(!empty($filter['subtype']))
			$subtype_filter = $this->db->placehold('AND l.subtype in(?@)', (array)$filter['subtype']);

		if(!empty($filter['sender_type']))
			$sender_type_filter = $this->db->placehold('AND l.sender_type in(?@)', (array)$filter['sender_type']);

		if(!empty($filter['sender']))
			$sender_filter = $this->db->placehold('AND l.sender in(?@)', (array)$filter['sender']);

		$sql_limit = $this->db->placehold(' LIMIT ?, ? ', ($page-1)*$limit, $limit);

		if(!empty($filter['sort']))
			$order_by = 'ORDER BY l.date DESC';
		else
			$order_by = 'ORDER BY l.id DESC';

		$query = $this->db->placehold("SELECT
				l.id,  
				l.user_id,
				l.parent_id,
				l.type,
				l.subtype,
				l.date,
				l.sender_type,
				l.sender,
				l.name,
				l.value,
				l.data,
				l.ip
			FROM __logs l
			WHERE
				1
				$id_filter
				$parent_id_filter
				$user_id_filter
				$type_filter
				$subtype_filter
				$sender_type_filter
				$sender_filter
			$order_by
			$sql_limit");


		$this->db->query($query);

		$logs = $this->db->results();
		if(!empty($logs))
		{
			$logs = $this->request->array_to_key($logs, 'id');
			$sender_users_logs_ids = [];
			foreach($logs as &$log)
			{
				if(!empty($log->type) && isset($this->log_types[$log->type]))
				{
					$log->type_name = $this->log_types[$log->type]['name'];

					if(!empty($log->subtype) && isset($this->log_types[$log->type]['subtypes'][$log->subtype]))
						$log->subtype_name = $this->log_types[$log->type]['subtypes'][$log->subtype]['name'];
				}
				if(!empty($log->sender_type) && isset($this->sender_types[$log->sender_type]))
					$log->sender_type_name = $this->sender_types[$log->sender_type];

				if(!empty($log->data) && $log->type!=9)
					$log->data = (object)unserialize($log->data);

				if($log->sender_type == 3 && is_numeric($log->sender)) // User
				{
					$user_id = (int)$log->sender;
					if(!empty($user_id))
						$sender_users_logs_ids[(int)$user_id][$log->id] = $log->id;					
				}
			}
			if(!empty($sender_users_logs_ids))
			{
				$log_users = $this->users->get_users([
					'id' => array_keys($sender_users_logs_ids)
				]);
				if(!empty($log_users))
				{
					foreach($log_users as $u)
					{
						if(isset($sender_users_logs_ids[$u->id]))
						{
							foreach($sender_users_logs_ids[$u->id] as $l)
							{
								if(isset($logs[$l]))
									$logs[$l]->sender = $u->name;
							}
						}
					}
				}
			}
		}
		
		if(isset($filter['count']) && $filter['count'] == 1)
			$logs = $logs[0];

		return $logs;
	}

	public function count_logs($filter = array())
	{
		$parent_id_filter = '';
		$user_id_filter = '';
		$type_filter = '';
		$subtype_filter = '';

		if(!empty($filter['parent_id']))
			$parent_id_filter = $this->db->placehold('AND l.parent_id in(?@)', (array)$filter['parent_id']);

		if(!empty($filter['user_id']))
			$user_id_filter = $this->db->placehold('AND l.user_id in(?@)', (array)$filter['user_id']);

		if(!empty($filter['type']))
			$type_filter = $this->db->placehold('AND l.type in(?@)', (array)$filter['type']);

		if(!empty($filter['subtype']))
			$subtype_filter = $this->db->placehold('AND l.subtype in(?@)', (array)$filter['subtype']);

		$query = "SELECT 
						count(distinct l.id) as count
					FROM __logs AS l
				WHERE 1
					$parent_id_filter
					$user_id_filter
					$type_filter
					$subtype_filter
					";
		$this->db->query($query);	
		return $this->db->result('count');
	}


	public function add_log($log)
	{	
		$log = (array)$log;

		if(!empty($log['data']))
			$log['data'] = serialize($log['data']);

		$log['ip'] = $_SERVER['REMOTE_ADDR'];

		$query = $this->db->placehold('INSERT INTO __logs SET ?%', $log);
		if(!$this->db->query($query))
			return false;


		return $this->db->insert_id();
	}

}
