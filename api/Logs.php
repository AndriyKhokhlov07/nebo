<?php


use Models\Log;

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
				11=> array('name' => 'First sales flow Approved'),
				12=> array('name' => 'Note'),
                13=> array('name' => 'Notification'),
                14 => ['name' => 'Move to another house'],
                15 => ['name' => 'Move to another apartment'],
				// 11=> array('name' => 'Early Move out')
			)
		),
		2 => array(
			'name' => 'Users (Guests)',
			'subtypes' => array(
				1 => array('name' => 'Note'),
				2 => array('name' => 'Create'),
				9 => array('name' => 'Hotel Salesflow Sent'),
				10 => array('name' => 'Airbnb Salesflow Sent'),
				11 => array('name' => 'Set status "Do not extend"'),
				12 => array('name' => 'Unset status "Do not extend"'),
                13 => array('name' => 'Notification'),
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
				8 => array('name' => 'Sent to owner'),
                9 => array('name' => 'Sent notice about future charge'),
                10 => array('name' => 'Autocharge'),
                13 => ['name' => 'Autocharge Data'],

                14 => ['name' => 'Add Late Payment Fee'],

                15 => ['name' => "Sent notice about don't pay (Autocharge)"],

                16 => ['name' => 'Sent notice about Late Payment Fee'],
                17 => ['name' => 'Sent notice about Late Payment Fee (Autocharge)'],

                18 => ['name' => 'Sent notice about Added Late Payment Fee'],
                19 => ['name' => 'Sent notice about Added Late Payment Fee (Autocharge)'],


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
				13 => array('name' => 'Copy link'),
                14 => array('name' => 'Notification')
			)
		),
		5 => array(
			'name' => 'Qira', // Hellorented
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
		],
		16 => [  
			'name' => 'Guarantor Argeement',
			'subtypes' => [
				1 => ['name' => 'Sign'],
				2 => ['name' => 'Uploaded'],
			]
		],
		17 => [
			'name' => 'House Rules Form',
			'subtypes' => [
				1 => ['name' => 'Sent'],
				2 => ['name' => 'Viewed'],
				3 => ['name' => 'Sign']
			]
		],
		18 => [
			'name' => 'Master Leases',
			'subtypes' => [
				1 => ['name' => 'Note for House'],
				2 => ['name' => 'Note for City']
			]
		],
        19 => [
            'name' => 'Onboarding Form',
            'subtypes' => [
                1 => ['name' => 'Update']
            ]
        ],
        20 => [
            'name' => 'Rent Roll 2', // Invoice Based Rent Roll
            'subtypes' => [
                1 => ['name' => 'Save']
            ]
        ],
        21 => [
            'name' => 'Rent Roll 4', // Rent Roll 4
            'subtypes' => [
                1 => ['name' => 'Save']
            ]
        ],
        22 => [
            'name' => 'Contracts List',
            'subtypes' => [
                1 => ['name' => 'Note for House'],
                2 => ['name' => 'Note for City']
            ]
        ],
        23 => [
            'name' => 'Prebookings',
            'subtypes' => [
                1 => ['name' => 'Created'],
                2 => ['name' => 'Viewed'],
                3 => ['name' => 'Change status']
            ]
        ],
        24 => [
            'name' => 'Sure',
            'subtypes' => [
                1 => ['name' => 'Viewed Start Form'],
                2 => ['name' => 'Viewed Payment Form'],
                3 => ['name' => 'Payment request'],
                4 => ['name' => 'Payment: Success'],
                5 => ['name' => 'Payment: Failed'],
            ]
        ],
        25 => [
            'name' => 'Rent Roll 6', // Rent Roll 6
            'subtypes' => [
                1 => ['name' => 'Save']
            ]
        ],
        100 => [
            'name' => 'Test',
            'subtypes' => [
                100 => ['name' => 'Note'],
            ]
        ],

    );

	public $sender_types = [
		1 => 'System',
		2 => 'Admin',
		3 => 'User',
		4 => 'Callback',
        5 => 'TestLog'
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

				if(!empty($log->data) && $log->type == 16)
					$log->data = (object)unserialize($log->data);
				elseif(!empty($log->data) && $log->type != 9)
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
			return array_shift($logs);

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
        $log = (array) $log;

        if(!empty($log['data']))
            $log['data'] = serialize($log['data']);

        $log['ip'] = $_SERVER['REMOTE_ADDR'];

        $query = $this->db->placehold('INSERT INTO __logs SET ?%', $log);

        if(!$this->db->query($query))
            return false;

        return $this->db->insert_id();
    }


	public function create_log($log)
	{
        $log = (array) $log;
        return Log::create(array_merge($log, [
            'data' => !empty($log['data']) ? serialize($log['data']) : null,
            'ip' => $_SERVER['REMOTE_ADDR'],
        ]))->id;
	}

}
