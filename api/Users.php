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
	// 4 - Landlords
	// 5 - Handyman
	// 6 - Guarantor
	// 7 - Сohabitant

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
	// 10 - Guarantors
	// 11 - Сohabitants


	// Security Deposit Types
	public $security_deposit_types = array(
		1 => 'Outpost',
		2 => 'Qira',
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
	
	function getUserFullName($u) {
		$user_name = '';
		if (empty($u)) {
			return false;
		}
        $user = (object)$u;
		if (empty($user->first_name) && empty($user->last_name) && !empty($user->name)) {
			$user_name = $user->name;
		} else {
			if (!empty($user->first_name)) {
				$user_name .= $user->first_name;
			}
			if (!empty($user->middle_name)) {
				$user_name .= ' ' . $user->middle_name;
			}
			if (!empty($user->last_name)) {
				$user_name .= ' ' . $user->last_name;
			}
			if ($is_duplicate = $this->isDuplicateEmail($user)) {
				$user_name .= ' ' . $is_duplicate;
			}
		}
		return $user_name;
	}
	
	function isDuplicateEmail($user) {
		$result = false;
		if (empty($user) || empty($user->email)) {
			return $result;
		}
		$user->email = trim($user->email);
		$email = $user->email;
		if (strpos($user->email, 'use the main account') !== false) {
			$arr = explode('[', $email);
			if (isset($arr[1])) {
				$result .= ' ['. $arr[1];
			}
		}
		return $result;
	}

	//////////////////////////////////

	function get_users($filter = array())
	{
		$limit = 1000;
		$page = 1;
		$id_filter = '';
        $hash_code_filter = '';
		$sku_filter = '';
		$type_filter = '';
		$in_type_filter = '';
		$status_filter = '';
		$not_status_filter = '';
		$enabled_filter = '';
		$email_filter = '';
		// $group_id_filter = '';
		$arrive_filter = '';
		$depart_filter = '';

		$booking_id_filter = '';
		$booking_id_select = '';


		$contract_id_filter = '';
		$contract_id_select = '';

		$order_id_filter = '';
		$order_id_select = '';

		$apartment_info_select = '';
		$apartment_info_filter = '';

		$user_code_filter = '';

        $airbnb_id_filter = '';
        $airbnb2_id_filter = '';

		$moved_in_filter = '';

		
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

		if(isset($filter['page']) && $filter['query'] != 'count')
			$page = max(1, intval($filter['page']));


		if(isset($filter['id']))
			$id_filter = $this->db->placehold('AND u.id in(?@)', (array)$filter['id']);

        if(isset($filter['hash_code']))
            $hash_code_filter = $this->db->placehold('AND u.hash_code in(?@)', (array)$filter['hash_code']);

        if(isset($filter['sku']))
			$sku_filter = $this->db->placehold('AND u.sku = ?', (int)$filter['sku']);

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

		if(isset($filter['not_status']))
			$not_status_filter = $this->db->placehold('AND u.status NOT in(?@)', (array)$filter['not_status']);

		if(isset($filter['enabled']))
			$enabled_filter = $this->db->placehold('AND u.enabled=?', intval($filter['enabled']));

		// if(isset($filter['group_id']))
		// 	$group_id_filter = $this->db->placehold('AND u.group_id in(?@)', (array)$filter['group_id']);

		if(isset($filter['arrive']))
			$arrive_filter = $this->db->placehold('AND u.inquiry_arrive <= ? AND u.inquiry_arrive >= ?', $filter['arrive'],  $filter['arrive_from']);
		
		if(isset($filter['depart']))
			$depart_filter = $this->db->placehold('AND u.inquiry_depart <= ? AND u.inquiry_depart >= ?', $filter['depart'],  $filter['depart_from']);

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
			$contract_join = 'LEFT JOIN __contracts c ON c.reserv_id = u.active_booking_id';
		}


		if(isset($filter['order_id']))
		{
			$order_id_filter = $this->db->placehold('INNER JOIN __orders_users ou ON ou.user_id = u.id AND ou.order_id in(?@)', (array)$filter['order_id']);
			$order_id_select = 'ou.order_id as order_id,';
		}


		
		if(!empty($filter['booking_id']))
		{
			$booking_id_filter = $this->db->placehold('
				INNER JOIN __bookings_users bu ON bu.user_id = u.id AND bu.booking_id in(?@)
				LEFT JOIN __bookings b ON b.id = bu.booking_id', (array)$filter['booking_id']);

			$booking_id_select = 'b.arrive, b.depart, bu.booking_id,';
		}

		if(isset($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND u.house_id in (?@)', (array)$filter['house_id']);

		if(isset($filter['client_type_id']))
			$client_type_id_filter = $this->db->placehold('AND u.client_type_id in (?@)', (array)$filter['client_type_id']);
			
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
		// (old code)
		if(isset($filter['ll_house_id__']))
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

		if(isset($filter['moved_in']))
			$moved_in_filter = $this->db->placehold('AND u.moved_in in(?@)', (array)$filter['moved_in']);

        if (isset($filter['airbnb_id'])) {
            $airbnb_id_filter = $this->db->placehold('AND u.airbnb_id in(?@)', (array)$filter['airbnb_id']);
        }
        if (isset($filter['airbnb2_id'])) {
            $airbnb2_id_filter = $this->db->placehold('AND u.airbnb2_id in(?@)', (array)$filter['airbnb2_id']);
        }
        if (isset($filter['airbnb_id_or']) && isset($filter['airbnb2_id_or'])) {
            $airbnb_id_filter = $this->db->placehold('AND (u.airbnb_id in(?@) OR u.airbnb2_id in(?@))', (array)$filter['airbnb_id_or'], (array)$filter['airbnb2_id_or']);
        }



		// Orders (old code)
		if(isset($filter['orders_status_']))
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
		
		// (old code)
		if(isset($filter['apartment_info__']))
		{
			$apartment_info_select = $this->db->placehold('a.name as apartment_name,');
			$apartment_info_filter = $this->db->placehold('LEFT JOIN __apartments a ON a.id=u.apartment_id');
			
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
				case 'apts':
					$order = 'u.apartment_id';
					break;
			}
		}

		if(!empty($filter['booking_id']) && $filter['move'] == 1)
			$order = 'b.arrive';
		elseif(!empty($filter['booking_id']) && $filter['move'] == 2)
			$order = 'b.depart';


		/*
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


		$bj_select = '
			bj.arrive as inquiry_arrive,
			'.$bj_depart_table.'.depart as inquiry_depart,
			bj.house_id as house_id,
			bj.client_type_id as client_type_id,
			bj.type as booking_type,
			bj.object_id as object_id,
			bj.apartment_id as apartment_id,
		';

		$bj_join = 'LEFT JOIN __bookings bj ON bj.id=u.active_booking_id';

		if(!empty($filter['only_users']))
		{
			$bj_select = '';
			$bj_join = '';
			$bj2_join = '';
		}


		$bj_select = '';*/


		// in move_in_out.tpl
		// user apartment_name


		$sql_limit = $this->db->placehold(' LIMIT ?, ? ', ($page-1)*$limit, $limit);

        if (isset($filter['count']) && $filter['count'] == 1) {
            $sql_limit = 'LIMIT 1';
        }

        if ($filter['limit'] == 'no') {
            $sql_limit = '';
        }


		// Выбираем пользователей
		$query = $this->db->placehold("SELECT 
					u.id, 
                    u.hash_code,
					u.sku,
					u.type,
					u.status,
					u.email, 
					u.phone,
					u.password, 
					u.first_pass,
					u.name, 
					u.landlord_code,
					u.first_name,
					u.middle_name,
					u.last_name,
					u.active_booking_id,
					u.active_salesflow_id,	

					u.birthday,
					u.gender,
					u.us_citizen,

					u.enabled, 
					u.moved_in, 

					u.house_id,
					u.apartment_id,
					u.bed_id,
					u.client_type_id,
					u.inquiry_arrive,
					u.inquiry_depart,

					$order_id_select
					$contract_id_select
					$contract_select
					$booking_id_select
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

					u.checkr_candidate_id,
					u.hellorented_tenant_id,
					u.security_deposit_type,
					u.security_deposit_status,
					u.airbnb_id,
					u.airbnb2_id,
					u.auth_code,
					u.hide_ach,
					u.dont_extend,
                    u.block_notifies,
                    u.payment_methods_details
				FROM __users u


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
                    $hash_code_filter
				    $sku_filter
					$type_filter
					$in_type_filter
					$email_filter
					$status_filter
					$not_status_filter
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
					$moved_in_filter
				    $airbnb_id_filter
				    $airbnb2_id_filter
					$keyword_filter 
				$group_by
				ORDER BY $order
				$sql_limit");



		if(isset($filter['return']) && $filter['return'] == 'query')
		{
			echo $query; exit;
		}


		$this->db->query($query);



		// if(!empty($filter['count']) && $filter['count'] == 1)
		// 	$result = $this->db->result();
		// else
		// 	$result = $this->db->results();
		// return $result;


		$users_ = $this->db->results();

        if(!empty($filter['query']) && $filter['query'] == 'count') {
            return count($users_);
        }

		if(!empty($users_))
		{
			$users = array();
			$users_apartments_ids = [];
			$users_salesflows_ids = [];
			foreach($users_ as $u)
			{
				$u->name = $this->getUserFullName($u);
				$u->is_duplicate = $this->isDuplicateEmail($u);
				$users[$u->id] = $u;

				if(!empty($u->apartment_id))
					$users_apartments_ids[$u->apartment_id][$u->id] = $u->id;

				if(!empty($u->active_salesflow_id))
					$users_salesflows_ids[$u->id] = $u->active_salesflow_id;

				if(!is_null($u->security_deposit_type) && isset($this->security_deposit_types[$u->security_deposit_type]))
					$users[$u->id]->security_deposit_type_name = $this->security_deposit_types[$u->security_deposit_type];

				if(!is_null($u->security_deposit_status) && isset($this->security_deposit_statuses[$u->security_deposit_status]))
					$users[$u->id]->security_deposit_status_name = $this->security_deposit_statuses[$u->security_deposit_status];

				if(!is_null($u->transunion_status) && isset($this->transunion->statuses[$u->transunion_status]))
					$users[$u->id]->transunion_status_name = $this->transunion->statuses[$u->transunion_status];

                if (!is_null($u->payment_methods_details) && !empty($u->payment_methods_details)) {
                    $users[$u->id]->payment_methods_details = json_decode($u->payment_methods_details);
                }
			}

			// Orders
			if(isset($filter['orders_status']))
			{
				$orders_users = $this->orders->get_orders_users([
					'user_id' => array_keys($users)
				]);

				if(!empty($orders_users))
				{
					$orders_users_ids = [];
					foreach($orders_users as $ou)
						$orders_users_ids[$ou->order_id][$ou->user_id] = $ou->user_id;
					
					if(!empty($orders_users_ids))
					{
						$query = $this->db->placehold("SELECT 
								o.id, 
								o.status
							FROM __orders AS o
							WHERE 
								o.id in (?@)
								AND o.type=1
								AND (o.date <= CURDATE() OR o.sended=1)
								AND o.deposit=0
							ORDER BY 
								o.payment_date DESC, 
								o.status, 
								o.id
						", array_keys($orders_users_ids));

						$this->db->query($query);
						$orders = $this->db->results();

						if(!empty($orders))
						{
							foreach($orders as $o)
							{
								if(isset($orders_users_ids[$o->id]))
								{
									foreach($orders_users_ids[$o->id] as $user_id)
									{
										if(isset($users[$user_id]) && !isset($users[$user_id]->order_id))
										{
											$users[$user_id]->order_id = $o->id;
											$users[$user_id]->order_status = $o->status;
										}
									}
								}
							}
						}
					}
				}
			}


			if(isset($filter['apartment_info']) && !empty($users_apartments_ids))
			{
				$query = $this->db->placehold("SELECT
						a.id,
						a.name
					FROM __apartments AS a
					WHERE a.id in (?@)
				", array_keys($users_apartments_ids));


				$this->db->query($query);
				$apartments = $this->db->results();

				if(!empty($apartments))
				{
					foreach($apartments as $a)
					{
						if(!empty($users_apartments_ids[$a->id]))
						{
							foreach($users_apartments_ids[$a->id] as $user_id)
							{
								if(isset($users[$user_id]))
									$users[$user_id]->apartment_name = $a->name;
							}
						}
					}
				}
			}



			if(isset($filter['salesflow_info']) && !empty($users_salesflows_ids))
			{
				$salesflows = $this->salesflows->get_salesflows([
					'id' => $users_salesflows_ids
				]);


				if(!empty($salesflows))
				{
					foreach($salesflows as $s) 
					{
                        if (!isset($users[$s->user_id])) {
                            $users[$s->user_id] = new stdClass;
                        }
						if(!empty($s->application_data))
						{

							$s->application_data = unserialize($s->application_data);
							$users[$s->user_id]->social_number = $s->application_data['social_number'];

							$users[$s->user_id]->zip = $s->application_data['zip'];
							$users[$s->user_id]->state_code = $s->application_data['state_code'];
							$users[$s->user_id]->city = $s->application_data['city'];
							$users[$s->user_id]->street_address = $s->application_data['street_address'];
							$users[$s->user_id]->apartment = $s->application_data['apartment'];
							$users[$s->user_id]->employment_status = $s->application_data['employment_status'];
							$users[$s->user_id]->employment_income = $s->application_data['employment_income'];
							
							$users[$s->user_id]->checker_options['to_check'] = $s->application_data['to_check'];



							
							if(!empty($users[$s->user_id]->blocks))
								$users[$s->user_id]->blocks = (array) unserialize($users[$s->user_id]->blocks);



							if(empty($users[$s->user_id]->blocks) || !is_array($users[$s->user_id]->blocks))
								$users[$s->user_id]->blocks = [];
							
							if(!empty($s->application_data))
								$users[$s->user_id]->blocks += $s->application_data;


							if(!empty($users[$s->user_id]->files)) {
                                $users[$s->user_id]->files = (array) unserialize($users[$s->user_id]->files);
                            }




							if(empty($users[$s->user_id]->files))
								$users[$s->user_id]->files = [];

							

							if(!empty($s->application_data['files']))
							{
								foreach($s->application_data['files'] as $k=>$f)
								{
									$users[$s->user_id]->files[$k] = $f;
								}
							}
						}
						if(!empty($s->ekata_status))
						{	
							$users_blocks = false;
							if(!empty($users[$s->user_id]->blocks)) {
								$users_blocks = (array) unserialize($users[$s->user_id]->blocks);
							}
								
							$s->ekata_status = unserialize($s->ekata_status);
							if(!empty($users[$s->user_id]->blocks) && is_array($users[$s->user_id]->blocks) && !empty($s->ekata_status)) {
								$users[$s->user_id]->blocks += $s->ekata_status;
							}	
							elseif (is_array($users_blocks) && !empty($s->ekata_status))
							{
								$users[$s->user_id]->blocks = (array) unserialize($users[$s->user_id]->blocks) + $s->ekata_status;
							}
							else {
								$users[$s->user_id]->blocks = $s->ekata_status;
							}
						}
						if(!empty($s->additional_files))
						{
							$s->additional_files = unserialize($s->additional_files);
							if (!empty($s->additional_files)) {
                                if (!isset($users[$s->user_id]->files)) {
                                    $users[$s->user_id]->files = [];
                                }
                                $users[$s->user_id]->files['additional'] = $s->additional_files;
                            }

						}
						if(!empty($users[$s->user_id]->blocks))
							$users[$s->user_id]->blocks = serialize($users[$s->user_id]->blocks);
						if(!empty($users[$s->user_id]->files))
							$users[$s->user_id]->files = serialize($users[$s->user_id]->files);
					}

				}

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
		$not_status_filter = '';
		$enabled_filter = '';
		$email_filter = '';
		// $group_id_filter = '';
		//$bj_select = '';
		//$bj2_select = '';

		$booking_id_filter = '';

		$arrive_filter = '';
		$depart_filter = '';

		$house_id_filter = '';
		$client_type_id_filter = '';
		$hellorented_tenant_id_filter = '';
		$transunion_id_filter = '';
		$security_deposit_type_filter = '';
		$security_deposit_status_filter = '';

        $airbnb_id_filter = '';
        $airbnb2_id_filter = '';

		$moved_in_filter = '';
		// $bed_name_filter = '';
		// $bed_id_filter = '';
		$keyword_filter = '';


		if(isset($filter['type']))
			$type_filter = $this->db->placehold('AND u.type=?', (int)$filter['type']);


		if(isset($filter['email']))
			$email_filter = $this->db->placehold('AND u.email in(?@)', (array)$filter['email']);

		if(isset($filter['status']))
			$status_filter = $this->db->placehold('AND u.status in(?@)', (array)$filter['status']);

		if(isset($filter['not_status']))
			$not_status_filter = $this->db->placehold('AND u.status NOT in(?@)', (array)$filter['not_status']);

		if(isset($filter['enabled']))
			$enabled_filter = $this->db->placehold('AND u.enabled=?', intval($filter['enabled']));

		// if(isset($filter['group_id']))
		// 	$group_id_filter = $this->db->placehold('AND u.group_id in(?@)', (array)$filter['group_id']);

		if(isset($filter['arrive']))
			$arrive_filter = $this->db->placehold('AND u.inquiry_arrive <= ? AND u.inquiry_arrive >= ?', $filter['arrive'],  $filter['arrive_from']);
		if(isset($filter['depart']))
		{
			$depart_filter = $this->db->placehold('AND u.inquiry_depart <= ? AND u.inquiry_depart >= ?', $filter['depart'],  $filter['depart_from']);
		}

		if(!empty($filter['booking_id']))
		{
			$booking_id_filter = $this->db->placehold('INNER JOIN __bookings_users bu ON bu.user_id = u.id AND bu.booking_id in(?@)', (array)$filter['booking_id']);
		}


		// if(isset($filter['house_id']) || isset($filter['client_type_id']) || isset($filter['arrive'])  || isset($filter['depart']))
		// 	$bj_select = $this->db->placehold('LEFT JOIN __bookings bj ON bj.id=u.active_booking_id');

		if(isset($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND u.house_id in (?@)', (array)$filter['house_id']);

		if(isset($filter['client_type_id']))
			$client_type_id_filter = $this->db->placehold('AND u.client_type_id in (?@)', (array)$filter['client_type_id']);

		if(!empty($filter['hellorented_tenant_id']))
			$hellorented_tenant_id_filter = $this->db->placehold('AND u.hellorented_tenant_id in(?@)', (array)$filter['hellorented_tenant_id']);

		if(!empty($filter['transunion_id']))
			$transunion_id_filter = $this->db->placehold('AND u.transunion_id in(?@)', (array)$filter['transunion_id']);

		if(isset($filter['security_deposit_type']))
			$security_deposit_type_filter = $this->db->placehold('AND u.security_deposit_type in(?@)', (array)$filter['security_deposit_type']);

		if(isset($filter['security_deposit_status']))
			$security_deposit_status_filter = $this->db->placehold('AND u.security_deposit_status in(?@)', (array)$filter['security_deposit_status']);

		if(!empty($filter['moved_in']))
			$moved_in_filter = $this->db->placehold('AND u.moved_in in(?@)', (array)$filter['moved_in']);

        if (isset($filter['airbnb_id'])) {
            $airbnb_id_filter = $this->db->placehold('AND u.airbnb_id in(?@)', (array)$filter['airbnb_id']);
        }
        if (isset($filter['airbnb2_id'])) {
            $airbnb2_id_filter = $this->db->placehold('AND u.airbnb2_id in(?@)', (array)$filter['airbnb2_id']);
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
							$booking_id_filter
							WHERE 1 
								$type_filter
								$status_filter
								$not_status_filter
								$enabled_filter
								$arrive_filter
								$depart_filter
								$email_filter
								$moved_in_filter

								$house_id_filter 
								$client_type_id_filter
								$hellorented_tenant_id_filter
								$transunion_id_filter
								$security_deposit_type_filter
								$security_deposit_status_filter
							    $airbnb_id_filter
							    $airbnb2_id_filter
								$keyword_filter
							ORDER BY u.name
							");
		$this->db->query($query);
		return $this->db->result('count');
	}


	function get_user($id)
	{
		//echo $id; exit;
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
										u.sku,
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
										u.active_salesflow_id,	

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
										u.hash_code,
										u.dont_extend,
                                        u.block_notifies,
                                        
                                        u.airbnb_id,
                                        u.airbnb2_id,
                                        
										u.house_id,
										u.apartment_id,
										u.bed_id,
										u.client_type_id,
										u.inquiry_arrive,
										u.inquiry_depart,
										u.payment_methods_details
									FROM __users u 
									$where
									GROUP BY u.id 
									LIMIT 1", $id);
		$this->db->query($query);
		$user = $this->db->result();
		if(empty($user))
			return false;
		//$user->discount *= 1; // Убираем лишние нули, чтобы было 5 вместо 5.00
		
		$user->name = $this->getUserFullName($user);
		$user->is_duplicate = $this->isDuplicateEmail($user);

		if(!empty($user->client_type_id))
			$user->client_type = $this->get_client_type($user->client_type_id);

		if(!is_null($user->security_deposit_type) && isset($this->security_deposit_types[$user->security_deposit_type]))
			$user->security_deposit_type_name = $this->security_deposit_types[$user->security_deposit_type];

		if(!is_null($user->security_deposit_status) && isset($this->security_deposit_statuses[$user->security_deposit_status]))
			$user->security_deposit_status_name = $this->security_deposit_statuses[$user->security_deposit_status];

		if(!is_null($user->transunion_status) && isset($this->transunion->statuses[$user->transunion_status]))
			$user->transunion_status_name = $this->transunion->statuses[$user->transunion_status];

        if (!is_null($user->payment_methods_details) && !empty($user->payment_methods_details)) {
            $user->payment_methods_details = json_decode($user->payment_methods_details);
        }

		// Landlord
		if($user->type == 4)  
		{
			$user->permissions = [
				'tenants' => 'tenants',
				'rentroll' => 'rentroll',
				'bookings' => 'bookings',
				'approve' => 'approve'
			];

			if(in_array($user->id, [
				9379, // Rebecca Ishmael
				9380, // Otto Hortsman III 
				9381, // Anthony M Modica
			]))
			{
				unset($user->permissions['tenants']);
				unset($user->permissions['rentroll']);
				unset($user->permissions['bookings']);
			}
		}

		return $user;
	}

    public function get_user_id(string $hashCode)
    {
        $query = $this->db->placehold('SELECT 
					u.id, 
					u.hash_code 
				FROM __users u 
				WHERE hash_code=? 
				LIMIT 1', $hashCode);
        $this->db->query($query);
        $result = $this->db->result();
        if(!empty($result->id)){
            return (int)$result->id;
        }

        return false;
    }

    public function get_user_by_hash_code(string $hashCode)
    {
        $result = $this->get_users(['hash_code' => $hashCode, 'limit' => 1]);

        if($result){
            return $result[array_key_first($result)];
        }

        return null;
    }

	function get_user_code($code)
	{
		if(empty($code))
			return false;

		$query = $this->db->placehold('SELECT 
					u.id, 
					u.sku,
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
					u.active_salesflow_id,	

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
					u.hide_ach,
					u.dont_extend,
					u.payment_methods_details
				FROM __users u 
				LEFT JOIN __bookings bj ON bj.id=u.active_booking_id
				WHERE auth_code=? 
				GROUP BY u.id 
				LIMIT 1', $code);
		$this->db->query($query);
		$user = $this->db->result();
		if (!empty($user)) {
			$user->name = $this->getUserFullName($user);

            if (!is_null($user->payment_methods_details) && !empty($user->payment_methods_details)) {
                $user->payment_methods_details = json_decode($user->payment_methods_details);
            }
		}
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
		$this->db->query($query);

        $id = $this->db->insert_id();
        $this->add_hash_code_by_user_id($id);
		return $id;
	}

    public function add_hash_code_by_user_id(int $id)
    {
        $user = $this->get_user($id);

        $hashCode = md5((string)$user->id . $user->created . (new DateTime())->format('Ymd His u'));
        $query = "UPDATE `s_users` SET `hash_code` = '{$hashCode}' WHERE `id` = {$user->id};";
        $this->db->query($query);
    }

    public function update_user($id, $user)
	{
		$user = (array)$user;
		if(isset($user['password']))
			$user['password'] = md5($this->salt.$user['password'].md5($user['password']));

        if (isset($user['first_name']) && $user['last_name'] && $user['email']) {
            $user['name'] = $this->getUserFullName($user);
        }

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
//		$query = $this->db->placehold("SELECT id FROM __users WHERE email=? AND password=? LIMIT 1", $email, $encpassword);
        $query = $this->db->placehold("SELECT id FROM __users WHERE email=? LIMIT 1", $email);
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
		//  house_id - Company ID


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
	public $clients_types = [
		1 => 'Outpost',
		
		2 => 'Airbnb',
		4 => 'Coliving',
		5 => 'House Leader',
		6 => 'VRBO',
		7 => 'Hotel client',
		
		14 => 'Rent-Stabilized',
        15 => 'Rent-Controlled',

        // Corporate
        3 => 'Corporate',
        8 => 'Corporate 4Stay',
        9 => 'Corporate ACS - College choice',
        10 => 'Corporate TIG',
        12 => 'Corporate Beyond Academy',
        13 => 'Corporate UPENN',
        16 => 'Corporate Wistar Institute',

        // Parking
        11 => 'Parking'
	];

	public function get_client_type($client_type_id)
	{
		if(empty($client_type_id))
			return false;

		if(!isset($this->clients_types[$client_type_id]))
			return false;

		return $this->clients_types[$client_type_id];
	}
	
	function getClientGroupByType(int $client_type_id) {		
		$client_group = new stdClass;
		
		if (in_array($client_type_id, [
			1, // Outpost
			14, // Rent-Stabilized
            15, // Rent-Controlled
		])) {
			$client_group->id = 1;
            $client_group->skey = 'outpost';
			$client_group->name = 'Outpost';
		}
		elseif (in_array($client_type_id, [
			2, // Airbnb
			4, // Coliving
			6, // VRBO
		])) {
			$client_group->id = 2;
            $client_group->skey = 'services3';
			$client_group->name = '3rd services';
		}
		// Hotel
		elseif ($client_type_id == 7) {
			$client_group->id = 3;
            $client_group->skey = 'hotel';
			$client_group->name = 'Hotel';
		}
		// House Leader
		elseif ($client_type_id == 5) {
			$client_group->id = 4;
            $client_group->skey = 'houseleader';
			$client_group->name = 'House Leader';
		}
		elseif (in_array($client_type_id, [
			3, // Corporate
			8, // Corporate 4Stay
			9, // Corporate ACS - College choice
			10, // Corporate TIG
			12, // Corporate Beyond Academy
			13, // Corporate UPENN
            16, // Corporate Wistar Institute
		])) {
			$client_group->id = 5;
            $client_group->skey = 'corporate';
			$client_group->name = 'Corporate';
		}
		// Parking
		elseif ($client_type_id == 11) {
			$client_group->id = 6;
            $client_group->skey = 'parking';
			$client_group->name = 'Parking';
		}		

		return isset($client_group->id)? $client_group : false;
	}



	// Users - Users
	// types:
	// 1 - Tenants - Guarantors
	// 2 - Tenants - Сohabitant
	public function get_users_users($params = [])
	{
		$type_filter = '';
		$parent_id_filter = '';
		$child_id_filter = '';
		$order_by = '';
		$limit = '';

		if(empty($params['type']))
			return false;

		if(empty($params['parent_id']) && empty($params['child_id']))
			return false;


		if(!empty($params['type']))
			$type_filter = $this->db->placehold('AND uu.type in(?@)', (array)$params['type']);

		if(!empty($params['parent_id']))
			$parent_id_filter = $this->db->placehold('AND uu.parent_id in(?@)', (array)$params['parent_id']);

		if(!empty($params['child_id']))
			$child_id_filter = $this->db->placehold('AND uu.child_id in(?@)', (array)$params['child_id']);

		if(!empty($params['order_by']))
		{
			if($params['order_by'] == 'parent_id')
				$order_by = 'ORDER BY parent_id';
			elseif($params['order_by'] == 'parent_id_desc')
				$order_by = 'ORDER BY parent_id DESC';
			elseif($params['order_by'] == 'child_id')
				$order_by = 'ORDER BY child_id';
			elseif($params['order_by'] == 'child_id_desc')
				$order_by = 'ORDER BY child_id DESC';
		}

		if(!empty($params['limit']))
			$limit = $this->db->placehold('LIMIT ?', (int)$params['limit']);

		$query = $this->db->placehold("SELECT * 
			FROM __users_users AS uu
			WHERE 1
				$type_filter
				$parent_id_filter
				$child_id_filter
			$order_by
			$limit
			");
		$this->db->query($query);

		if(!empty($params['count']) && $params['count'] == 1)
			return $this->db->result();
		else
			return $this->db->results();
	}

	public function add_users_users($type, $parent_id, $child_id)
	{
		$query = $this->db->placehold("INSERT IGNORE INTO __users_users SET type=?, parent_id=?, child_id=?", $type, $parent_id, $child_id);
		$this->db->query($query);
		return (object)[
			'type' => $type,
			'parent_id' => $parent_id,
			'child_id' => $child_id
		];
	}




	// Leads

    public $lead_form_types = [
        0 => 'Default',
        1 => 'QR'
    ];

	function get_leads($params = []) {
		$id_filter = '';
		$user_id_filter = '';
		$house_id_filter = '';
		$created_date_filter = '';

		if (empty($params['id']) && empty($params['user_id']) && empty($params['house_id'])) {
			return false;
		}
		if(!empty($params['id'])) {
			$id_filter = $this->db->placehold('AND l.id in(?@)', (array)$params['id']);
		}
		if(!empty($params['user_id'])) {
			$user_id_filter = $this->db->placehold('AND l.user_id in(?@)', (array)$params['user_id']);
		}
		if(!empty($params['house_id'])) {
			$house_id_filter = $this->db->placehold('INNER JOIN __leads_data ld ON ld.lead_id=l.id AND ld.type=1 AND ld.value_id in(?@)', (array)$params['house_id']);
		}
		if (isset($params['created_month']) && isset($params['created_year'])) {
			$created_date_filter = $this->db->placehold(' AND (MONTH(l.created)=? AND YEAR(l.created)=?)', $params['created_month'], $params['created_year']);
		}	
			
		$query = $this->db->placehold("SELECT 
				l.id,
				l.user_id,
				l.site,
				l.form_type,
				l.first_name,
				l.last_name,
				l.email,
				l.phone,
				l.gender,
				l.application_house_id,
				l.move_in_date,
				l.move_out_date,
				l.dates_flexible,
				l.living_period,
				l.budget,
				l.room_type,
				l.stay_alone,
				l.guest_first_name,
				l.guest_last_name,
				l.guest_email,
				l.guest_phone,
				l.listing_website,
				l.apartment_listing_website,
				l.friend_name,
				l.corporate_referral_code,
				l.code,
				l.additional_info,
				l.created
			FROM __leads AS l
				$house_id_filter
			WHERE 1
				$id_filter
				$user_id_filter
				$created_date_filter
			GROUP BY l.id
			");
		$this->db->query($query);
		

		if(!empty($params['count']) && $params['count'] == 1) {
            $lead = $this->db->result();
            if (!empty($lead)) {
                if (!isset($this->lead_form_types[$lead->form_type])) {
                    $lead->form_type = 0;
                }
                $lead->form_type = $this->lead_form_types[$lead->form_type];
            }
            return $lead;
        } else {
            $leads = $this->db->results();
            if (!empty($leads)) {
                foreach ($leads as $lead) {
                    if (!isset($this->lead_form_types[$lead->form_type])) {
                        $lead->form_type = 0;
                    }
                    $lead->form_type = $this->lead_form_types[$lead->form_type];
                }
            }
            return $leads;
        }

	}

	public function add_lead($lead) {
		$lead = (array)$lead;

		if (empty($lead['user_id'])) {
			return false;
		}

		$query = $this->db->placehold("INSERT INTO __leads SET ?%", $lead);
		$this->db->query($query);
		return $this->db->insert_id();
	}



	// Leads Data types:
	// 1 - Houses
	// 2 - Budgets
	// 3 - Refers
	function get_leads_data($params = []) {

		$id_filter = '';
		$lead_id_filter = '';
		$type_filter = '';


		if (empty($params['id']) && empty($params['lead_id'])) {
			return false;
		}

		if(!empty($params['id'])) {
			$id_filter = $this->db->placehold('AND l.id in(?@)', (array)$params['id']);
		}

		if(!empty($params['lead_id'])) {
			$lead_id_filter = $this->db->placehold('AND l.lead_id in(?@)', (array)$params['lead_id']);
		}

		if(!empty($params['type'])) {
			$type_filter = $this->db->placehold('AND l.type in(?@)', (array)$params['type']);
		}
		
		$query = $this->db->placehold("SELECT 
				l.id,
				l.lead_id,
				l.type,
				l.value_id,
				l.value
			FROM __leads_data AS l
			WHERE 1
				$id_filter
				$lead_id_filter
				$type_filter
			ORDER BY l.type, l.id
			");
		$this->db->query($query);

		if(!empty($params['count']) && $params['count'] == 1)
			return $this->db->result();
		else
			return $this->db->results();
	}

	public function add_lead_data($lead_data) {
		$lead_data = (array)$lead_data;

		if (empty($lead_data['lead_id'])) {
			return false;
		}

		$query = $this->db->placehold("INSERT INTO __leads_data SET ?%", $lead_data);
		$this->db->query($query);
		return $this->db->insert_id();
	}


	
}