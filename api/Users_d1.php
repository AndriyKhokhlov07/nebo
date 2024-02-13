<?php

 
require_once('Backend.php');

class Users extends Backend
{	
	// осторожно, при изменении соли испортятся текущие пароли пользователей
	private $salt = 'fhkjrr65jdia85hgfocje65javnvjh434hy2';



	//////////////////////////////////

	// User types:
	// 1 - Guests
	// 2 - House Leaders
	// 3 - Cleaners

	// Statuses:
	// 0 - New
	// 1 - Pending
	// 2 - Approved
	// 3 - Guests
	// 4 - Alumni
	// 5 - Blacklist
	// 6 - Canceled
	// 7 - Team
	// 8 - Corporate
	// 9 - Landlords


	// Security Deposit Types
	public $security_deposit_types = array(
		1 => 'Outpost',
		2 => 'HelloRented',
		3 => 'Not needed'
	);

	// Security Deposit Statuses
	public $security_deposit_statuses = array(
		1 => 'Created',
		2 => 'Sending',
		3 => 'Pending',
		4 => 'Paid',
		5 => 'Failed'
	);

	//////////////////////////////////

	function get_users($filter = array())
	{
		$limit = 1000;
		$page = 1;
		$id_filter = '';
		$type_filter = '';
		$in_type_filter = '';
		$status_filter = '';
		$enabled_filter = '';
		$email_filter = '';
		// $group_id_filter = '';
		$arrive_filter = '';
		$depart_filter = '';

		$booking_id_filter = '';

		$contract_id_filter = '';
		$contract_id_select = '';

		$order_id_filter = '';
		$order_id_select = '';

		$apartment_info_select = '';
		$apartment_info_filter = '';

		$user_code_filter = '';

		$bj_depart_table = 'bj2';
		
		$house_id_filter = '';
		$client_type_id_filter = '';
		// $bed_name_filter = '';
		// $bed_id_filter = '';
		$keyword_filter = '';
		$hc_house_id_filter = '';
		$hl_house_id_filter = '';
		$ll_house_id_filter = '';
		$hellorented_tenant_id_filter = '';
		$transunion_id_filter = '';
		$security_deposit_type_filter = '';
		$security_deposit_status_filter = '';
		$order_status_select = '';
		$orders_filter = '';
		$group_by = 'GROUP BY u.id';

		if(isset($filter['limit']))
			$limit = max(1, intval($filter['limit']));

		if(isset($filter['page']))
			$page = max(1, intval($filter['page']));


		if(isset($filter['bj2']) && $filter['bj2'] == 0)
			$bj_depart_table = 'bj';

		if(isset($filter['id']))
			$id_filter = $this->db->placehold('AND u.id in(?@)', (array)$filter['id']);

		if(isset($filter['email']))
			$email_filter = $this->db->placehold('AND u.email in(?@)', (array)$filter['email']);

		if(isset($filter['type']))
			$type_filter = $this->db->placehold('AND u.type=?', (int)$filter['type']);

		if(isset($filter['user_code']))
			$user_code_filter = $this->db->placehold('AND u.auth_code=?', $filter['user_code']);

		if(isset($filter['in_type']))
			$type_filter = $this->db->placehold('AND u.type in(?@)', (array)$filter['in_type']);

		if(isset($filter['status']))
			$status_filter = $this->db->placehold('AND u.status in(?@)', (array)$filter['status']);

		if(isset($filter['enabled']))
			$enabled_filter = $this->db->placehold('AND u.enabled=?', intval($filter['enabled']));

		// if(isset($filter['group_id']))
		// 	$group_id_filter = $this->db->placehold('AND u.group_id in(?@)', (array)$filter['group_id']);

		if(isset($filter['arrive']))
			$arrive_filter = $this->db->placehold('AND bj.arrive <= ? AND bj.arrive >= ?', $filter['arrive'],  $filter['arrive_from']);
		
		if(isset($filter['depart']))
			$depart_filter = $this->db->placehold('AND '.$bj_depart_table.'.depart <= ? AND '.$bj_depart_table.'.depart >= ?', $filter['depart'],  $filter['depart_from']);


		

		if(isset($filter['contract_id']))
		{
			$contract_id_filter = $this->db->placehold('INNER JOIN __contracts_users cu ON cu.user_id = u.id AND cu.contract_id in(?@)', (array)$filter['contract_id']);
			$contract_id_select = 'cu.contract_id as contract_id,';
		}

		// Contract info by active booking
		$contract_select = '';
		$contract_join = '';
		if(!empty($filter['select_contract_info']))
		{
			$contract_select = 'c.membership as membership, c.id as order_id,';
			$contract_join = 'LEFT JOIN __contracts c ON c.reserv_id = bj.id';
		}


		if(isset($filter['order_id']))
		{
			$order_id_filter = $this->db->placehold('INNER JOIN __orders_users ou ON ou.user_id = u.id AND ou.order_id in(?@)', (array)$filter['order_id']);
			$order_id_select = 'ou.order_id as order_id,';
		}


		
		if(!empty($filter['booking_id']))
		{
			$booking_id_filter = $this->db->placehold('INNER JOIN __bookings_users bu ON bu.user_id = u.id AND bu.booking_id in(?@)', (array)$filter['booking_id']);
		}

		if(isset($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND bj.house_id in (?@)', (array)$filter['house_id']);

		if(isset($filter['client_type_id']))
			$client_type_id_filter = $this->db->placehold('AND bj.client_type_id in (?@)', (array)$filter['client_type_id']);

		// if(isset($filter['bed_name']))
		// 	$bed_name_filter = $this->db->placehold('AND u.bed_name in (?@)', (array)$filter['bed_name']);

		// if(isset($filter['bed_id']))
		// 	$bed_id_filter = $this->db->placehold('AND u.bed_id in (?@)', (array)$filter['bed_id']);

        // House of House Leader
		if(isset($filter['hl_house_id']))
		{
			$hl_house_id_filter = $this->db->placehold('INNER JOIN __houseleaders_houses hl ON hl.user_id = u.id AND hl.house_id in(?@)', (array)$filter['hl_house_id']);
			//$group_by = "GROUP BY u.id";
		}

		 // House of House Cleaner
		if(isset($filter['hc_house_id']))
		{
			$hc_house_id_filter = $this->db->placehold('INNER JOIN __housecleaners_houses hc ON hc.user_id = u.id AND hc.house_id in(?@)', (array)$filter['hc_house_id']);
			//$group_by = "GROUP BY u.id";
		}

		// House of Landlord
		if(isset($filter['ll_house_id']))
		{
			$ll_house_id_filter = $this->db->placehold('INNER JOIN __landlords_houses ll ON ll.user_id = u.id AND ll.house_id in(?@)', (array)$filter['ll_house_id']);
			// $group_by = "GROUP BY u.id";
		}


		if(!empty($filter['hellorented_tenant_id']))
			$hellorented_tenant_id_filter = $this->db->placehold('AND u.hellorented_tenant_id in(?@)', (array)$filter['hellorented_tenant_id']);

		if(!empty($filter['transunion_id']))
			$transunion_id_filter = $this->db->placehold('AND u.transunion_id in(?@)', (array)$filter['transunion_id']);


		if(isset($filter['security_deposit_type']))
			$security_deposit_type_filter = $this->db->placehold('AND u.security_deposit_type in(?@)', (array)$filter['security_deposit_type']);

		if(isset($filter['security_deposit_status']))
			$security_deposit_status_filter = $this->db->placehold('AND u.security_deposit_status in(?@)', (array)$filter['security_deposit_status']);

		

		// Orders
		if(isset($filter['orders_status']))
		{
			$order_status_select = 'o.id as order_id, o.status as order_status,';
			$orders_filter = $this->db->placehold('LEFT JOIN __orders_users ou ON ou.user_id = u.id LEFT JOIN __orders o ON o.type=1 AND o.id=(SELECT id FROM __orders WHERE id=ou.order_id AND (date <= CURDATE() OR sended=1) ORDER BY payment_date DESC, status, id DESC LIMIT 1)');
			// $orders_filter = $this->db->placehold('INNER JOIN __orders_users ou ON ou.user_id = u.id INNER JOIN __orders o ON o.type=1 AND o.id=ou.order_id AND (o.date <= CURDATE() OR o.sended=1) ORDER BY o.payment_date DESC, o.status, id DESC LIMIT 1');
			//$group_by = "GROUP BY u.id";
		}

		// if(isset($filter['orders_status']))
		// {
		// 	$order_status_select = 'o.id as order_id, o.status as order_status,';
		// 	$orders_filter = $this->db->placehold('LEFT JOIN __orders o ON o.user_id = u.id AND o.type=1 AND o.id=(SELECT id FROM __orders WHERE user_id=u.id ORDER BY payment_date DESC, status, id DESC LIMIT 1)');
		// 	$group_by = "GROUP BY u.id";
		// }
		
		if(isset($filter['apartment_info']))
		{
			$apartment_info_select = $this->db->placehold('a.name as apartment_name,');
			$apartment_info_filter = $this->db->placehold('LEFT JOIN __apartments a ON a.id=bj.apartment_id');
			
		}

		
		if(isset($filter['keyword']))
		{
			$keywords = explode(' ', $filter['keyword']);
			foreach($keywords as $keyword)
				$keyword_filter .= $this->db->placehold('AND (u.name LIKE "%'.$this->db->escape(trim($keyword)).'%" OR u.email LIKE "%'.$this->db->escape(trim($keyword)).'%"  OR u.last_ip LIKE "%'.$this->db->escape(trim($keyword)).'%")');
		}
		
		$order = 'u.name';
		if(!empty($filter['sort']))
		{
			switch ($filter['sort'])
			{
				case 'date':
					$order = 'u.created DESC';
					break;
				case 'name':
					$order = 'u.name';
					break;
				case 'inquiry_arrive':
					$order = 'bj.arrive';
					break;
				case 'inquiry_depart':
					$order = $bj_depart_table.'.depart';
					break;
				case 'apts':
					$order = 'a.id';
					break;
			}
		}


		$bj2_join = $this->db->placehold("LEFT JOIN __bookings bj2
					ON bj2.id=
					(
					    SELECT 
					    	id
					    FROM __bookings
					    WHERE
					    	((due IS NULL OR due>=NOW()) 
					    	AND status>0
					    	AND group_id=bj.group_id) OR id=bj.id
					    ORDER BY depart DESC 
					    LIMIT 1
					)");
		if(isset($filter['bj2']) && $filter['bj2'] == 0)
			$bj2_join = '';


		$sql_limit = $this->db->placehold(' LIMIT ?, ? ', ($page-1)*$limit, $limit);
		// Выбираем пользователей
		$query = $this->db->placehold("SELECT 
					u.id, 
					u.type,
					u.status,
					u.email, 
					u.phone,
					u.password, 
					u.name, 
					u.landlord_code,
					u.first_name,
					u.last_name,
					u.active_booking_id,	
					u.enabled, 
					u.moved_in, 

					bj.arrive as inquiry_arrive,
					".$bj_depart_table.".depart as inquiry_depart,
					bj.house_id as house_id,
					bj.client_type_id as client_type_id,
					bj.type as booking_type,
					bj.object_id as object_id,
					bj.apartment_id as apartment_id,

					$order_id_select
					$contract_id_select
					$contract_select
					u.last_ip, 
					u.created, 
					u.image,
					u.blocks,
					u.note,
					u.us_citizen,
					u.files,
					u.checker_options,
					u.transunion_id,
					u.transunion_status,
					$order_status_select
					$apartment_info_select
					u.checkr_candidate_id,
					u.hellorented_tenant_id,
					u.security_deposit_type,
					u.security_deposit_status,
					u.auth_code,
					u.hide_ach
					
				FROM __users u

				LEFT JOIN __bookings bj ON bj.id=u.active_booking_id
				$bj2_join
				
				$contract_join
				$hl_house_id_filter
				$hc_house_id_filter
				$ll_house_id_filter
				$orders_filter
				$booking_id_filter
				$contract_id_filter
				$order_id_filter
				$apartment_info_filter
				WHERE 1 
					$id_filter
					$type_filter
					$in_type_filter
					$email_filter
					$status_filter
					$enabled_filter
					$arrive_filter
					$depart_filter
					$house_id_filter
					$user_code_filter
					$client_type_id_filter
					$hellorented_tenant_id_filter
					$transunion_id_filter
					$security_deposit_type_filter
					$security_deposit_status_filter
					$keyword_filter 
				$group_by
				ORDER BY $order
				$sql_limit");


		// echo $query; exit;


		$this->db->query($query);




		// if(!empty($filter['count']) && $filter['count'] == 1)
		// 	$result = $this->db->result();
		// else
		// 	$result = $this->db->results();
		// return $result;

		$users_ = $this->db->results();
		if(!empty($users_))
		{
			$users = array();
			foreach($users_ as $u)
			{
				$users[$u->id] = $u;

				if(!is_null($u->security_deposit_type) && isset($this->security_deposit_types[$u->security_deposit_type]))
					$users[$u->id]->security_deposit_type_name = $this->security_deposit_types[$u->security_deposit_type];

				if(!is_null($u->security_deposit_status) && isset($this->security_deposit_statuses[$u->security_deposit_status]))
					$users[$u->id]->security_deposit_status_name = $this->security_deposit_statuses[$u->security_deposit_status];

				if(!is_null($u->transunion_status) && isset($this->transunion->statuses[$u->transunion_status]))
					$users[$u->id]->transunion_status_name = $this->transunion->statuses[$u->transunion_status];
			}

			if(!empty($filter['count']) && $filter['count'] == 1)
				return current($users);
			else
				return $users;

			unset($users_);
		}
		return false;	
	}


	function count_users($filter = array())
	{
		$type_filter = '';
		$status_filter = '';
		$enabled_filter = '';
		$email_filter = '';
		// $group_id_filter = '';
		$bj_select = '';
		$bj2_select = '';

		$arrive_filter = '';
		$depart_filter = '';

		$house_id_filter = '';
		$client_type_id_filter = '';
		$hellorented_tenant_id_filter = '';
		$transunion_id_filter = '';
		$security_deposit_type_filter = '';
		$security_deposit_status_filter = '';
		// $bed_name_filter = '';
		// $bed_id_filter = '';
		$keyword_filter = '';


		if(isset($filter['type']))
			$type_filter = $this->db->placehold('AND u.type=?', (int)$filter['type']);


		if(isset($filter['email']))
			$email_filter = $this->db->placehold('AND u.email in(?@)', (array)$filter['email']);

		if(isset($filter['status']))
			$status_filter = $this->db->placehold('AND u.status in(?@)', (array)$filter['status']);

		if(isset($filter['enabled']))
			$enabled_filter = $this->db->placehold('AND u.enabled=?', intval($filter['enabled']));

		// if(isset($filter['group_id']))
		// 	$group_id_filter = $this->db->placehold('AND u.group_id in(?@)', (array)$filter['group_id']);

		if(isset($filter['arrive']))
			$arrive_filter = $this->db->placehold('AND bj.arrive <= ? AND bj.arrive >= ?', $filter['arrive'],  $filter['arrive_from']);
		if(isset($filter['depart']))
		{
			if(isset($filter['bj2']) && $filter['bj2'] == 0)
			{
				$depart_filter = $this->db->placehold('AND bj.depart <= ? AND bj.depart >= ?', $filter['depart'],  $filter['depart_from']);
			}
			else
			{
				$depart_filter = $this->db->placehold('AND bj2.depart <= ? AND bj2.depart >= ?', $filter['depart'],  $filter['depart_from']);

				$bj2_select = $this->db->placehold('LEFT JOIN __bookings bj2
										ON bj2.id=
										(
										    SELECT 
										    	id
										    FROM __bookings
										    WHERE
										    	((due IS NULL OR due>=NOW()) 
										    	AND status>0
										    	AND group_id=bj.group_id) OR id=bj.id
										    ORDER BY depart DESC 
										    LIMIT 1
										)');
			}
			
		}

		if(isset($filter['house_id']) || isset($filter['client_type_id']) || isset($filter['arrive'])  || isset($filter['depart']))
			$bj_select = $this->db->placehold('LEFT JOIN __bookings bj ON bj.id=u.active_booking_id');

		if(isset($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND bj.house_id in (?@)', (array)$filter['house_id']);

		if(isset($filter['client_type_id']))
			$client_type_id_filter = $this->db->placehold('AND bj.client_type_id in (?@)', (array)$filter['client_type_id']);

		if(!empty($filter['hellorented_tenant_id']))
			$hellorented_tenant_id_filter = $this->db->placehold('AND u.hellorented_tenant_id in(?@)', (array)$filter['hellorented_tenant_id']);

		if(!empty($filter['transunion_id']))
			$transunion_id_filter = $this->db->placehold('AND u.transunion_id in(?@)', (array)$filter['transunion_id']);

		if(isset($filter['security_deposit_type']))
			$security_deposit_type_filter = $this->db->placehold('AND u.security_deposit_type in(?@)', (array)$filter['security_deposit_type']);

		if(isset($filter['security_deposit_status']))
			$security_deposit_status_filter = $this->db->placehold('AND u.security_deposit_status in(?@)', (array)$filter['security_deposit_status']);

		// if(isset($filter['bed_name']))
		// 	$bed_name_filter = $this->db->placehold('AND u.bed_name in (?@)', (array)$filter['bed_name']);

		// if(isset($filter['bed_id']))
		// 	$bed_id_filter = $this->db->placehold('AND u.bed_id in (?@)', (array)$filter['bed_id']);
		
		// if(isset($filter['keyword']))
		// {
		// 	$keywords = explode(' ', $filter['keyword']);
		// 	foreach($keywords as $keyword)
		// 		$keyword_filter .= $this->db->placehold('AND u.name LIKE "%'.$this->db->escape(trim($keyword)).'%" OR u.email LIKE "%'.$this->db->escape(trim($keyword)).'%"');
		// }


		if(isset($filter['keyword']))
		{
			$keywords = explode(' ', $filter['keyword']);
			foreach($keywords as $keyword)
				$keyword_filter .= $this->db->placehold('AND (u.name LIKE "%'.$this->db->escape(trim($keyword)).'%" OR u.email LIKE "%'.$this->db->escape(trim($keyword)).'%"  OR u.last_ip LIKE "%'.$this->db->escape(trim($keyword)).'%")');
		}

		// Выбираем пользователей
		$query = $this->db->placehold("SELECT count(*) as count 
							FROM __users u
							$bj_select
							$bj2_select

							WHERE 1 
								$type_filter
								$status_filter
								$enabled_filter
								$arrive_filter
								$depart_filter
								$email_filter

								$house_id_filter 
								$client_type_id_filter
								$hellorented_tenant_id_filter
								$transunion_id_filter
								$security_deposit_type_filter
								$security_deposit_status_filter
								$keyword_filter
							ORDER BY u.name");
		$this->db->query($query);
		return $this->db->result('count');
	}


	function get_user($id)
	{
		if(gettype($id) == 'string')
			$where = $this->db->placehold(' WHERE u.email=? ', $id);
		else
			$where = $this->db->placehold(' WHERE u.id=? ', intval($id));


		/*
		u.inquiry_arrive,
		u.inquiry_depart,
		u.room_type,
		u.price_month,
		u.price_deposit,
		u.membership,
		u.house_id, 
		u.group_id, 
		u.bed_name,
		u.bed_id,
		*/
	
		// Выбираем пользователя
		$query = $this->db->placehold("SELECT 
										u.id, 
										u.type,
										u.status,
										u.email, 
										u.phone,
										u.password, 
										u.first_pass,
										u.landlord_code,
										u.name,
										u.first_name,
										u.middle_name,
										u.last_name,
										u.active_booking_id,
										u.enabled, 
										u.moved_in, 
										u.last_ip, 
										u.created, 
										u.image,
										u.blocks,
										u.note,
										u.birthday,
										u.gender,
										u.us_citizen,
										u.social_number,
										u.zip,
										u.state_code,
										u.city,
										u.street_address,
										u.apartment,
										u.employment_status,
										u.employment_income,

										u.transunion_id,
										u.transunion_status,
										u.transunion_data,

										u.checker_options,
										u.checkr_candidate_id,
										u.hellorented_tenant_id,
										u.security_deposit_type,
										u.security_deposit_status,
										u.files,
										u.hide_ach,
										u.auth_code,

										bj.house_id as house_id,
										bj.arrive as inquiry_arrive,
										bj2.depart as inquiry_depart,
										bj.client_type_id,
										bj.type as booking_type
									FROM __users u 
									LEFT JOIN __bookings bj ON bj.id=u.active_booking_id
									LEFT JOIN __bookings bj2
										ON bj2.id=
										(
										    SELECT 
										    	id
										    FROM __bookings
										    WHERE
										    	((due IS NULL OR due>=NOW()) 
										    	AND status>0
										    	AND group_id=bj.group_id) OR id=bj.id
										    ORDER BY depart DESC 
										    LIMIT 1
										)
									$where
									GROUP BY u.id 
									LIMIT 1", $id);
		$this->db->query($query);
		$user = $this->db->result();
		if(empty($user))
			return false;
		//$user->discount *= 1; // Убираем лишние нули, чтобы было 5 вместо 5.00

		if(!empty($user->client_type_id))
			$user->client_type = $this->get_client_type($user->client_type_id);

		if(!is_null($user->security_deposit_type) && isset($this->security_deposit_types[$user->security_deposit_type]))
			$user->security_deposit_type_name = $this->security_deposit_types[$user->security_deposit_type];

		if(!is_null($user->security_deposit_status) && isset($this->security_deposit_statuses[$user->security_deposit_status]))
			$user->security_deposit_status_name = $this->security_deposit_statuses[$user->security_deposit_status];

		if(!is_null($user->transunion_status) && isset($this->transunion->statuses[$user->transunion_status]))
			$user->transunion_status_name = $this->transunion->statuses[$user->transunion_status];

		return $user;
	}



	function get_user_code($code)
	{
		if(empty($code))
			return false;

		$query = $this->db->placehold('SELECT 
					u.id, 
					u.type,
					u.status,
					u.email, 
					u.phone,
					u.password, 
					u.name, 
					u.landlord_code,
					u.first_name,
					u.last_name,
					u.active_booking_id,	
					u.enabled, 

					bj.arrive as inquiry_arrive,
					bj.depart as inquiry_depart,
					bj.house_id as house_id,

					u.last_ip, 
					u.created, 
					u.image,
					u.blocks,
					u.note,
					u.us_citizen,
					u.files,
					u.checker_options,
					u.checkr_candidate_id,
					u.hellorented_tenant_id,
					u.hide_ach
				FROM __users u 
				LEFT JOIN __bookings bj ON bj.id=u.active_booking_id
				WHERE auth_code=? 
				GROUP BY u.id 
				LIMIT 1', $code);
		$this->db->query($query);
		return $this->db->result();
	}



	
	public function add_user($user)
	{
		$user = (array)$user;
		if(isset($user['password']))
			$user['password'] = md5($this->salt.$user['password'].md5($user['password']));

		$count_users = $this->count_users();
			
		$query = $this->db->placehold("SELECT count(*) as count FROM __users WHERE email=?", $user['email']);
		$this->db->query($query);
		
		if($this->db->result('count') > 0 && $count_users > 0)
			return false;
		
		$query = $this->db->placehold("INSERT INTO __users SET ?%", $user);
		//echo $query; exit;
		$this->db->query($query);
		return $this->db->insert_id();
	}
		
	public function update_user($id, $user)
	{
		$user = (array)$user;
		if(isset($user['password']))
			$user['password'] = md5($this->salt.$user['password'].md5($user['password']));

		$query = $this->db->placehold("UPDATE __users SET ?% WHERE id=? LIMIT 1", $user, intval($id));
		$this->db->query($query);
		return $id;
	}
	
	/*
	*
	* Удалить пользователя
	* @param $post
	*
	*/	
	public function delete_user($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("UPDATE __orders SET user_id=NULL WHERE id=? LIMIT 1", intval($id));
			$this->db->query($query);

			// Del Houses of HouseLeader
    		$query = $this->db->placehold('DELETE FROM __houseleaders_houses WHERE user_id=?', intval($id));
    		$this->db->query($query);

    		// Del Notifications
    		$query = $this->db->placehold('DELETE FROM __notifications WHERE user_id=?', intval($id));
    		$this->db->query($query);


    		$this->delete_image($id);
			
			$query = $this->db->placehold("DELETE FROM __users WHERE id=? LIMIT 1", intval($id));
			if($this->db->query($query))
				return true;
		}
		return false;
	}		
	
	function get_groups()
	{
		// Выбираем группы
		$query = $this->db->placehold("SELECT g.id, g.name, g.discount FROM __groups AS g ORDER BY g.discount");
		$this->db->query($query);
		return $this->db->results();
	}	
	
	function get_group($id)
	{
		// Выбираем группу
		$query = $this->db->placehold("SELECT * FROM __groups WHERE id=? LIMIT 1", $id);
		$this->db->query($query);
		$group = $this->db->result();

		return $group;
	}	
	
	
	public function add_group($group)
	{
		$query = $this->db->placehold("INSERT INTO __groups SET ?%", $group);
		$this->db->query($query);
		return $this->db->insert_id();
	}
		
	public function update_group($id, $group)
	{
		$query = $this->db->placehold("UPDATE __groups SET ?% WHERE id=? LIMIT 1", $group, intval($id));
		$this->db->query($query);
		return $id;
	}
	
	public function delete_group($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("UPDATE __users SET group_id=NULL WHERE group_id=? LIMIT 1", intval($id));
			$this->db->query($query);
			
			$query = $this->db->placehold("DELETE FROM __groups WHERE id=? LIMIT 1", intval($id));
			if($this->db->query($query))
				return true;
		}
		return false;
	}		
	
	public function check_password($email, $password)
	{
		$encpassword = md5($this->salt.$password.md5($password));
		$query = $this->db->placehold("SELECT id FROM __users WHERE email=? AND password=? LIMIT 1", $email, $encpassword);
		$this->db->query($query);
		if($id = $this->db->result('id'))
			return $id;
		return false;
	}



	// ---------------------------
	// --- Guests Deposit Info ---
	// ---------------------------

	// Types:
	// 1 - Hellorented

	// id
	// type
	// user_id
	// status
	// substatus
	// service_status
	// service_substatus
	// service_data











	public function get_houseleaders_houses($filter = array())
	{
		$user_id_filter = '';
		$house_id_filter = '';

		if(empty($filter['user_id']) && empty($filter['house_id']))
			return array();

		if(!empty($filter['user_id']))
			$user_id_filter = $this->db->placehold('AND hl.user_id in(?@)', (array)$filter['user_id']);

		if(!empty($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND hl.house_id in(?@)', (array)$filter['house_id']);
				
		$query = $this->db->placehold("SELECT 
						hl.user_id, 
						hl.house_id, 
						hl.position
					FROM __houseleaders_houses hl
					WHERE 
						1
						$user_id_filter
						$house_id_filter  
					ORDER BY position       
					");
		
		$this->db->query($query);
		return $this->db->results();
	}
	
	public function add_houseleaders_houses($user_id, $house_id, $position=0)
	{
		$query = $this->db->placehold("INSERT IGNORE INTO __houseleaders_houses SET user_id=?, house_id=?, position=?", $user_id, $house_id, $position);
		$this->db->query($query);
		return $house_id;
	}
	
	public function delete_houseleaders_houses($user_id, $house_id)
	{
		$query = $this->db->placehold("DELETE FROM __houseleaders_houses WHERE user_id=? AND house_id=? LIMIT 1", intval($user_id), intval($house_id));
		$this->db->query($query);
	}


	public function get_housecleaners_houses($filter = array())
	{
		$user_id_filter = '';
		$house_id_filter = '';


		if(empty($filter['user_id']) && empty($filter['house_id']))
			return array();

		if(!empty($filter['user_id']))
			$user_id_filter = $this->db->placehold('AND user_id in(?@)', (array)$filter['user_id']);

		if(!empty($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND house_id in(?@)', (array)$filter['house_id']);
				
		$query = $this->db->placehold("SELECT user_id, house_id, position
					FROM __housecleaners_houses
					WHERE 
					1
					$user_id_filter
					$house_id_filter  
					ORDER BY position       
					");
		
		$this->db->query($query);
		return $this->db->results();
	}
	
	public function add_housecleaners_houses($user_id, $house_id, $position=0)
	{
		$query = $this->db->placehold("INSERT IGNORE INTO __housecleaners_houses SET user_id=?, house_id=?, position=?", $user_id, $house_id, $position);
		$this->db->query($query);
		return $house_id;
	}
	
	public function delete_housecleaners_houses($user_id, $house_id)
	{
		$query = $this->db->placehold("DELETE FROM __housecleaners_houses WHERE user_id=? AND house_id=? LIMIT 1", intval($user_id), intval($house_id));
		$this->db->query($query);
	}



	public function get_landlords_houses($filter = array())
	{
		$user_id_filter = '';
		$house_id_filter = '';


		if(empty($filter['user_id']) && empty($filter['house_id']))
			return array();

		if(!empty($filter['user_id']))
			$user_id_filter = $this->db->placehold('AND user_id in(?@)', (array)$filter['user_id']);

		if(!empty($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND house_id in(?@)', (array)$filter['house_id']);
				
		$query = $this->db->placehold("SELECT user_id, house_id, position
					FROM __landlords_houses
					WHERE 
					1
					$user_id_filter
					$house_id_filter  
					ORDER BY position       
					");
		
		$this->db->query($query);
		return $this->db->results();
	}
	
	public function add_landlords_houses($user_id, $house_id, $position=0)
	{
		$query = $this->db->placehold("INSERT IGNORE INTO __landlords_houses SET user_id=?, house_id=?, position=?", $user_id, $house_id, $position);
		$this->db->query($query);
		return $house_id;
	}
	
	public function delete_landlords_houses($user_id, $house_id)
	{
		$query = $this->db->placehold("DELETE FROM __landlords_houses WHERE user_id=? AND house_id=? LIMIT 1", intval($user_id), intval($house_id));
		$this->db->query($query);
	}

	


	// Удалить изображение
	public function delete_image($users_ids)
	{
		$users_ids = (array) $users_ids;
		$query = $this->db->placehold("SELECT image FROM __users WHERE id in(?@)", $users_ids);
		$this->db->query($query);
		$filenames = $this->db->results('image');
		if(!empty($filenames))
		{
			$query = $this->db->placehold("UPDATE __users SET image=NULL WHERE id in(?@)", $users_ids);
			$this->db->query($query);
			foreach($filenames as $filename)
			{
				$query = $this->db->placehold("SELECT count(*) as count FROM __users WHERE image=?", $filename);
				$this->db->query($query);
				$count = $this->db->result('count');
				if($count == 0)
				{
					$file = pathinfo($filename, PATHINFO_FILENAME);
					$ext = pathinfo($filename, PATHINFO_EXTENSION);
					
					// Удалить все ресайзы
					$rezised_images = glob($this->config->root_dir.$this->config->resized_users_images_dir.$file.".*x*.".$ext);
					if(is_array($rezised_images))
					foreach (glob($this->config->root_dir.$this->config->resized_users_images_dir.$file.".*x*.".$ext) as $f)
						@unlink($f);

					@unlink($this->config->root_dir.$this->config->users_images_dir.$filename);		
				}
			}	
		}
	}


	public $states = array(
		'AK' => 'Alaska',
		'AL' => 'Alabama',
		'AR' => 'Arkansas',
		'AZ' => 'Arizona',
		'CA' => 'California',
		'CO' => 'Colorado',
		'CT' => 'Connecticut',
		'DC' => 'District of Columbia',
		'DE' => 'Delaware',
		'FL' => 'Florida',
		'GA' => 'Georgia',
		'HI' => 'Hawaii',
		'IA' => 'Iowa',
		'ID' => 'Idaho',
		'IL' => 'Illinois',
		'IN' => 'Indiana',
		'KS' => 'Kansas',
		'KY' => 'Kentucky',
		'LA' => 'Louisiana',
		'MA' => 'Massachusetts',
		'MD' => 'Maryland',
		'ME' => 'Maine',
		'MI' => 'Michigan',
		'MN' => 'Minnesota',
		'MO' => 'Missouri',
		'MS' => 'Mississippi',
		'MT' => 'Montana',
		'NC' => 'North Carolina',
		'ND' => 'North Dakota',
		'NE' => 'Nebraska',
		'NH' => 'New Hampshire',
		'NJ' => 'New Jersey',
		'NM' => 'New Mexico',
		'NV' => 'Nevada',
		'NY' => 'New York',
		'OH' => 'Ohio',
		'OK' => 'Oklahoma',
		'OR' => 'Oregon',
		'PA' => 'Pennsylvania',
		'PR' => 'Puerto Rico',
		'RI' => 'Rhode Island',
		'SC' => 'South Carolina',
		'SD' => 'South Dakota',
		'TN' => 'Tennessee',
		'TX' => 'Texas',
		'UT' => 'Utah',
		'VA' => 'Virginia',
		'VT' => 'Vermont',
		'WA' => 'Washington',
		'WI' => 'Wisconsin',
		'WV' => 'West Virginia',
		'WY' => 'Wyoming',
		'AA' => 'Armed Forces America',
		'AE' => 'Armed Forces',
		'AP' => 'Armed Forces Pacific'
	);

	public function get_state($state_code)
	{
		if(empty($state_code))
			return false;

		if(!isset($this->states[$state_code]))
			return false;

		$state = new stdClass;
		$state->code = $state_code;
		$state->name = $this->states[$state_code];

		return $state;
	}


	// Types of customers
	public $clients_types = array(
		1 => 'Outpost',
		2 => 'Airbnb',
		3 => 'Corporate',
		4 => 'Coliving',
		5 => 'House Leader'
	);

	public function get_client_type($client_type_id)
	{
		if(empty($client_type_id))
			return false;

		if(!isset($this->clients_types[$client_type_id]))
			return false;

		return $this->clients_types[$client_type_id];
	}



	
}