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

	//////////////////////////////////
	
	function get_users_i($filter = array())
	{
		$limit = 1000;
		$page = 1;
		$id_filter = '';
		$type_filter = '';
		$in_type_filter = '';
		$status_filter = '';
		$group_id_filter = '';
		$house_id_filter = '';
		$bed_name_filter = '';
		$bed_id_filter = '';
		$keyword_filter = '';
		$hc_house_id_filter = '';
		$hl_house_id_filter = '';
		$ll_house_id_filter = '';
		$order_status_select = '';
		$orders_filter = '';
		$group_by = '';

		if(isset($filter['limit']))
			$limit = max(1, intval($filter['limit']));

		if(isset($filter['page']))
			$page = max(1, intval($filter['page']));

		if(isset($filter['id']))
			$id_filter = $this->db->placehold('AND u.id in(?@)', (array)$filter['id']);

		if(isset($filter['type']))
			$type_filter = $this->db->placehold('AND u.type=?', (int)$filter['type']);

		if(isset($filter['in_type']))
			$type_filter = $this->db->placehold('AND u.type in(?@)', (array)$filter['in_type']);

		if(isset($filter['status']))
			$status_filter = $this->db->placehold('AND u.status=?', (int)$filter['status']);

		if(isset($filter['group_id']))
			$group_id_filter = $this->db->placehold('AND u.group_id in(?@)', (array)$filter['group_id']);

		if(isset($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND u.house_id in (?@)', (array)$filter['house_id']);

		if(isset($filter['bed_name']))
			$bed_name_filter = $this->db->placehold('AND u.bed_name in (?@)', (array)$filter['bed_name']);

		if(isset($filter['bed_id']))
			$bed_id_filter = $this->db->placehold('AND u.bed_id in (?@)', (array)$filter['bed_id']);

        // House of House Leader
		if(isset($filter['hl_house_id']))
		{
			$hl_house_id_filter = $this->db->placehold('INNER JOIN __houseleaders_houses hl ON hl.user_id = u.id AND hl.house_id in(?@)', (array)$filter['hl_house_id']);
			$group_by = "GROUP BY u.id";
		}

		 // House of House Cleaner
		if(isset($filter['hc_house_id']))
		{
			$hc_house_id_filter = $this->db->placehold('INNER JOIN __housecleaners_houses hc ON hc.user_id = u.id AND hc.house_id in(?@)', (array)$filter['hc_house_id']);
			$group_by = "GROUP BY u.id";
		}


		// House of Landlord
		if(isset($filter['ll_house_id']))
		{
			$ll_house_id_filter = $this->db->placehold('INNER JOIN __landlords_houses ll ON ll.user_id = u.id AND ll.house_id in(?@)', (array)$filter['ll_house_id']);
			$group_by = "GROUP BY u.id";
		}

		// Orders
		if(isset($filter['orders_status']))
		{
			$order_status_select = 'o.id as order_id, o.status as order_status,';
			$orders_filter = $this->db->placehold('LEFT JOIN __orders o ON o.user_id = u.id AND o.type=1 AND o.id=(SELECT id FROM __orders WHERE user_id=u.id ORDER BY payment_date DESC, status, id DESC LIMIT 1)');
			$group_by = "GROUP BY u.id";
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
					$order = 'u.inquiry_arrive';
					break;
				case 'inquiry_depart':
					$order = 'u.inquiry_depart';
					break;
			}
		}
		

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
										u.group_id, 
										u.house_id, 
										u.bed_name,
										u.bed_id,
										u.enabled, 
										u.last_ip, 
										u.created, 
										u.image,
										u.blocks,
										u.inquiry_arrive,
										u.inquiry_depart,
										u.room_type,
										u.price_month,
										u.price_deposit,
										u.membership,
										u.note,
										u.us_citizen,
										u.files,
										u.checker_options,
										u.checkr_candidate_id,
										g.discount, 
										$order_status_select
										g.name as group_name 
									FROM __users u
									$hl_house_id_filter
									$hc_house_id_filter
									$ll_house_id_filter
									$orders_filter
	                                LEFT JOIN __groups g ON u.group_id=g.id 
									WHERE 1 
										$id_filter
										$type_filter
										$in_type_filter
										$status_filter
										$group_id_filter 
										$house_id_filter 
										$bed_name_filter
										$bed_id_filter
										$keyword_filter 
									$group_by
									ORDER BY $order
									$sql_limit");

		$this->db->query($query);
		return $this->db->results();
	}
		
	function count_users_i($filter = array())
	{
		$type_filter = '';
		$status_filter = '';
		$group_id_filter = '';	
		$house_id_filter = '';
		$bed_name_filter = '';
		$bed_id_filter = '';
		$keyword_filter = '';


		if(isset($filter['type']))
			$type_filter = $this->db->placehold('AND u.type=?', (int)$filter['type']);

		if(isset($filter['status']))
			$status_filter = $this->db->placehold('AND u.status=?', (int)$filter['status']);

		if(isset($filter['group_id']))
			$group_id_filter = $this->db->placehold('AND u.group_id in(?@)', (array)$filter['group_id']);

		if(isset($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND u.house_id in (?@)', (array)$filter['house_id']);

		if(isset($filter['bed_name']))
			$bed_name_filter = $this->db->placehold('AND u.bed_name in (?@)', (array)$filter['bed_name']);

		if(isset($filter['bed_id']))
			$bed_id_filter = $this->db->placehold('AND u.bed_id in (?@)', (array)$filter['bed_id']);
		
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
                            LEFT JOIN __groups g ON u.group_id=g.id 
							WHERE 1 
								$type_filter
								$status_filter
								$group_id_filter 
								$house_id_filter 
								$bed_name_filter
								$bed_id_filter
								$keyword_filter 
							ORDER BY u.name");
		$this->db->query($query);
		return $this->db->result('count');
	}
		
	function get_user_i($id)
	{
		if(gettype($id) == 'string')
			$where = $this->db->placehold(' WHERE u.email=? ', $id);
		else
			$where = $this->db->placehold(' WHERE u.id=? ', intval($id));
	
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
										u.group_id, 
										u.house_id, 
										u.bed_name,
										u.bed_id,
										u.enabled, 
										u.last_ip, 
										u.created, 
										u.image,
										u.blocks,
										u.inquiry_arrive,
										u.inquiry_depart,
										u.room_type,
										u.price_month,
										u.price_deposit,
										u.membership,
										u.note,
										u.birthday,
										u.gender,
										u.us_citizen,
										u.social_number,
										u.zip,
										u.checker_options,
										u.checkr_candidate_id,
										u.files,
										g.discount,
										g.name as group_name 
									FROM __users u 
									LEFT JOIN __groups g ON u.group_id=g.id 
									$where 
									LIMIT 1", $id);
		$this->db->query($query);
		$user = $this->db->result();
		if(empty($user))
			return false;
		$user->discount *= 1; // Убираем лишние нули, чтобы было 5 вместо 5.00
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
										u.hide_ach
									FROM __users u 
									LEFT JOIN __beds_journal bj ON bj.id=u.active_booking_id
									WHERE auth_code=? 
									GROUP BY u.id 
									LIMIT 1', $code);
		$this->db->query($query);
		return $this->db->result();
	}








	function get_users($filter = array())
	{
		$limit = 1000;
		$page = 1;
		$id_filter = '';
		$type_filter = '';
		$in_type_filter = '';
		$status_filter = '';
		// $group_id_filter = '';
		$house_id_filter = '';
		// $bed_name_filter = '';
		// $bed_id_filter = '';
		$keyword_filter = '';
		$hc_house_id_filter = '';
		$hl_house_id_filter = '';
		$ll_house_id_filter = '';
		$order_status_select = '';
		$orders_filter = '';
		$group_by = 'GROUP BY u.id';

		if(isset($filter['limit']))
			$limit = max(1, intval($filter['limit']));

		if(isset($filter['page']))
			$page = max(1, intval($filter['page']));

		if(isset($filter['id']))
			$id_filter = $this->db->placehold('AND u.id in(?@)', (array)$filter['id']);

		if(isset($filter['type']))
			$type_filter = $this->db->placehold('AND u.type=?', (int)$filter['type']);

		if(isset($filter['in_type']))
			$type_filter = $this->db->placehold('AND u.type in(?@)', (array)$filter['in_type']);

		if(isset($filter['status']))
			$status_filter = $this->db->placehold('AND u.status=?', (int)$filter['status']);

		// if(isset($filter['group_id']))
		// 	$group_id_filter = $this->db->placehold('AND u.group_id in(?@)', (array)$filter['group_id']);

		if(isset($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND bj.house_id in (?@)', (array)$filter['house_id']);

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

		// Orders
		if(isset($filter['orders_status']))
		{
			$order_status_select = 'o.id as order_id, o.status as order_status,';
			$orders_filter = $this->db->placehold('LEFT JOIN __orders o ON o.user_id = u.id AND o.type=1 AND o.id=(SELECT id FROM __orders WHERE user_id=u.id AND (date <= CURDATE() OR sended=1) ORDER BY payment_date DESC, status, id DESC LIMIT 1)');
			//$group_by = "GROUP BY u.id";
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
					//$order = 'u.inquiry_arrive';
					$order = 'bj.arrive';
					break;
				case 'inquiry_depart':
					//$order = 'u.inquiry_depart';
					$order = 'bj.depart';
					break;
			}
		}


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
										$order_status_select
										u.checkr_candidate_id,
										u.hide_ach
										
									FROM __users u

									LEFT JOIN __beds_journal bj ON bj.id=u.active_booking_id

									$hl_house_id_filter
									$hc_house_id_filter
									$ll_house_id_filter
									$orders_filter
									WHERE 1 
										$id_filter
										$type_filter
										$in_type_filter
										$status_filter
										$house_id_filter
										$keyword_filter 
									$group_by
									ORDER BY $order
									$sql_limit");


		//echo $query; exit;

		$this->db->query($query);
		return $this->db->results();
	}


	function count_users($filter = array())
	{
		$type_filter = '';
		$status_filter = '';
		// $group_id_filter = '';
		$house_select = '';
		$house_id_filter = '';
		// $bed_name_filter = '';
		// $bed_id_filter = '';
		$keyword_filter = '';


		if(isset($filter['type']))
			$type_filter = $this->db->placehold('AND u.type=?', (int)$filter['type']);

		if(isset($filter['status']))
			$status_filter = $this->db->placehold('AND u.status=?', (int)$filter['status']);

		// if(isset($filter['group_id']))
		// 	$group_id_filter = $this->db->placehold('AND u.group_id in(?@)', (array)$filter['group_id']);

		if(isset($filter['house_id']))
		{
			$house_select = $this->db->placehold('LEFT JOIN __beds_journal bj ON bj.id=u.active_booking_id');
			$house_id_filter = $this->db->placehold('AND bj.house_id in (?@)', (array)$filter['house_id']);
		}

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
							$house_select
							WHERE 1 
								$type_filter
								$status_filter
								$house_id_filter 
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
										u.checker_options,
										u.checkr_candidate_id,
										u.files,
										u.hide_ach,

										u.inquiry_arrive,
										u.inquiry_depart,
										u.room_type,
										u.price_month,
										u.price_deposit,
										u.membership,


										bj.house_id as house_id,
										bj.arrive as inquiry_arrive,
										bj.depart as inquiry_depart
									FROM __users u 
									LEFT JOIN __beds_journal bj ON bj.id=u.active_booking_id
										$where
									GROUP BY u.id 
									LIMIT 1", $id);
		$this->db->query($query);
		$user = $this->db->result();
		if(empty($user))
			return false;
		//$user->discount *= 1; // Убираем лишние нули, чтобы было 5 вместо 5.00
		return $user;
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



	public function get_houseleaders_houses($filter = array())
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
					FROM __houseleaders_houses
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
	
}