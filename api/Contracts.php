<?php

require_once('Backend.php');



//  CONTRACTS

class Contracts extends Backend
{

	// Fee and other payments
	public $deposit_firs_part = 1000;
	public $application_fee = 20;
    public $phila_application_fee = 99;
	public $application_fee_temple_house = 99;
    public $telecom_fee = 99;

    public $latePaymentFee = 50;
    public $latePaymentFeeApertments = 100;



	public $contract_types = [
        // Vermont Coliving Lease (The George Collision House)
        10 => [
            'name' => 'Vermont Coliving Lease',
            'house_id' => 461,
            'booking_type' => [
                1, // Coliving,
                2, // Apartments
            ],
            'tpl' => 'contract_vermont'
        ],
		1 => [
			'name' => 'Outpost coliving',
			'type' => 'main',
			'tpl' => 'contract_outpost_new'
		],
		3 => [
			'name' => 'Free Market Lease', 
			'type' => 'main',
			'tpl' => 'contract_full_apt',
			'tpl_singed' => 'contract_full_apt_signed'
		],
		5 => [
			'name' => 'Landlords coliving',
			'type' => 'main',
			'tpl' => 'contract_landlord_new'
		],
		6 => [
			'name' => 'Philadelphia Houses',
			'house_id' => [
				349, // The Mason on Chestnut 
				368  // Temple House
			],
			'booking_type' => [
				1, // Coliving
				2, // Apartments
			],
			'tpl' => 'contract_phila'
		],
		7 => [
			'name' => 'Unfurnished apartment',
			'booking_type' => [
				2 // Apartment
			], 
			'apartment_furnished' => 0,
			'tpl' => 'contract_full_apt',
			'tpl_singed' => 'contract_full_apt_signed'
		],
        /*
		8 => [
			'name' => 'Williamsburg Houses | Coliving',
			'house_id' => [
				334, // The Williamsburg House
				337  // The Williamsburg House (165 N 5th Street)
			],
			'booking_type' => [
				1 // Coliving
			],
			'tpl' => 'contract_williamsburg'
		],

		9 => [
			'name' => 'Williamsburg Houses | Furnished apartment',
			'house_id' => [
				334, // The Williamsburg House
				337  // The Williamsburg House (165 N 5th Street)
			],
			'booking_type' => [
				2 // Apartment
			], 
			'apartment_furnished' => 1,
			'tpl' => 'contract_williamsburg_furnished_apt'
		],
        */


	];


	/*
		$params: array
		house_id
		booking_type: 1 - coliving || 2 - apartment
		apartment_furnished: 0 || 1
		// contract_type
	*/
	public function get_contract_types($params = []) {

		$contract_types = $this->contract_types;

		$houses_contract_types = [];
		foreach($contract_types as $k=>$t) {
			if (!isset($t['tpl_singed'])) {
				$contract_types[$k]['tpl_singed'] = $t['tpl'];
			}

			if (!empty($t['house_id']) && is_array($t['house_id'])) {
				foreach($t['house_id'] as $h_id) {
					$houses_contract_types[$h_id][$k] = $k;
				}
			}
		}

		$contract_types_result = $contract_types;

		$remove_contract_types = [];
		foreach ($contract_types as $k=>$t) {

			// houses filter
			if (
				(!empty($params['house_id']) && 
					(
						(isset($houses_contract_types[$params['house_id']]) && !in_array($params['house_id'], $t['house_id'])) 
						|| 
						(!isset($houses_contract_types[$params['house_id']]) && !empty($t['house_id']))
					)
				)
				||
				(empty($params['house_id']) && !empty($t['house_id']))
			) {
				$remove_contract_types[$k] = $k;
			}


			if (
                !empty($params['house_id']) &&
                isset($params['booking_type']) &&
                is_array($t['booking_type']) &&
                !in_array($params['booking_type'], $t['booking_type'])
            ) {

                $remove_contract_types[$k] = $k;
			}




            // Williamsburg Houses | Coliving = Landlords coliving
            if (!empty($params['house_id']) && in_array($params['house_id'], $contract_types[9]['house_id']) && $k == 5 && isset($params['booking_type']) && $params['booking_type'] == 1) {
                unset($remove_contract_types[5]);
            }




			// apartment: unfurnished
			// if ((!empty($params['booking_type']) && $params['booking_type'] == 2) && isset($params['apartment_furnished']) && (!isset($t['apartment_furnished']) || $t['apartment_furnished'] != $params['apartment_furnished'] )) {

			if ((!empty($params['booking_type']) && $params['booking_type'] == 2) && isset($params['apartment_furnished']) && $params['apartment_furnished'] == 0 && (!isset($t['apartment_furnished']) || $t['apartment_furnished'] != $params['apartment_furnished'] )) {
				// $remove_contract_types[$k] = $k;
			}

		}

        // Vermont Coliving Lease (The George Collision House)
        if (
            !empty($params['house_id']) &&
            $params['house_id'] == $contract_types[10]['house_id']
        ) {
            $remove_contract_types[5] = 5;
            unset($remove_contract_types[10]);
        }

		// Dont remove Outpost coliving 
		if ($params['view'] == 'list' && isset($remove_contract_types[1])) {
			// unset($remove_contract_types[1]);
		}

		// apartment: unfurnished
		if ((!empty($params['booking_type']) && $params['booking_type'] == 2) && isset($params['apartment_furnished']) && $params['apartment_furnished'] == 0) {
			unset($contract_types_result);			
			$remove_contract_types[1] = 1;
			unset($remove_contract_types[7]);
			$contract_types_result[7] = $contract_types[7];
		}
		else {
			unset($contract_types_result[7]);
		}

		if (!empty($remove_contract_types)) {
			foreach($remove_contract_types as $k=>$t) {
				if (isset($contract_types_result[$k])) {
					unset($contract_types_result[$k]);
				}
			}
		}

		// Philadelphia Houses
		if (!empty($params['house_id']) && in_array($params['house_id'], $this->contract_types[6]['house_id'])) {
			unset($contract_types_result[7]);
		}



		
		// if ($params['view'] == 'list' && isset($remove_contract_types[1])) {
		if (isset($remove_contract_types[1])) {
			$contract_types_result[1] = $contract_types[1];
		}

		
		return $contract_types_result;


	}

	public function get_contract_type($params = []) {

		$contract_type_key = false;

		// Outpost Contract
		if (isset($params['type']) && $params['type'] == 1) {
			$contract_type_key = 1;
		}
		// Philadelphia Houses
		elseif (!empty($params['house_id']) && in_array($params['house_id'], $this->contract_types[6]['house_id'])) {
			$contract_type_key = 6;
		}
		// Apartment: unfurnished
		elseif ((!empty($params['booking_type']) && $params['booking_type'] == 2) && isset($params['apartment_furnished']) && $params['apartment_furnished'] == 0) {
			$contract_type_key = 7;
		}
		// Williamsburg Houses
		elseif (!empty($params['house_id']) && in_array($params['house_id'], $this->contract_types[8]['house_id'])) {
			if ((!empty($params['booking_type']) && $params['booking_type'] == 1)) {
				// $contract_type_key = 8;
                $contract_type_key = 3;
			}
			elseif ((!empty($params['booking_type']) && $params['booking_type'] == 2) && isset($params['apartment_furnished']) && $params['apartment_furnished'] == 1) {
				$contract_type_key = 9;
			}
		}

		elseif (
            isset($params['type']) &&
            in_array($params['type'], [
                3,  // Free Market Lease
                10, // Vermont Coliving Lease (The George Collision House)
            ])
        ) {
			$contract_type_key = $params['type'];
		}
		// Landlords coliving
		else {
			$contract_type_key = 5;
		}

		// Result
		if ($contract_type_key && isset($this->contract_types[$contract_type_key])) {
			$contract_type = $this->contract_types[$contract_type_key];
			if (!isset($contract_type['tpl_singed'])) {
				$contract_type['tpl_singed'] = $contract_type['tpl'];
			}
			return $contract_type;
		}

		return false;
	}


    // DELETE USER_ID FROM CONTRACTS sql table !

	/*
	    Statuses:
	    1 - Active
	    9 - Canceled

	    utility_initiator:
	    0 - auto
	    1 - manual
    */
	public function get_contracts($filter = array())
	{
		$limit = 100;
		$page = 1;		
		$user_id_filter = '';

		$id_filter = '';
		$reserv_id_filter = '';
		$user_filter = '';
		$house_id_filter = '';
		$status_filter = '';
		$signing_filter = '';
		$signing_date_filter = '';
		$new_lease_filter = '';
		$date_to_range_filter = '';

		$select_users = '';

		$group_by = '';

		// if(!empty($filter['group_by']))
		// {
		// 	if($filter['group_by'] == 'user_id')
		// 		$group_by = 'GROUP BY c.user_id';
		// }
		
		if(!empty($filter['user_id']))
		{
			$user_id_filter = $this->db->placehold('INNER JOIN  __contracts_users cu ON cu.contract_id = c.id AND cu.user_id in(?@)', (array)$filter['user_id']);
			$group_by = 'GROUP BY c.id';
		}

		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND c.id in(?@)', (array)$filter['id']);

		if(!empty($filter['reserv_id']))
			$reserv_id_filter = $this->db->placehold('AND c.reserv_id in(?@)', (array)$filter['reserv_id']);
		elseif(!empty($filter['empty_reserv_id']))
			$reserv_id_filter = $this->db->placehold('AND (c.reserv_id=0 OR c.reserv_id IS NULL)');

		if(!empty($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND c.house_id in(?@)', (array)$filter['house_id']);

		if(!empty($filter['status']))
			$status_filter = $this->db->placehold('AND c.status in(?@)', (array)$filter['status']);

		if(!empty($filter['is_signing']))
			$signing_filter = $this->db->placehold('AND c.signing=1');

		if(!empty($filter['signing_date']))
			$signing_date_filter = $this->db->placehold('AND c.date_signing >= ?', $filter['signing_date']);

		if(!empty($filter['new_lease']))
			$new_lease_filter = $this->db->placehold('AND c.new_lease=1');
		
		if(!empty($filter['date_to_start']) && !empty($filter['date_to_end'])) {
			$date_to_range_filter = $this->db->placehold('AND c.date_to >= ? AND c.date_to >= ?', $filter['date_to_start'], $filter['date_to_end']);
		}
			

		if(isset($filter['limit']))
			$limit = max(1, intval($filter['limit']));

		if(isset($filter['page']))
			$page = max(1, intval($filter['page']));

		$sql_limit = $this->db->placehold(' LIMIT ?, ? ', ($page-1)*$limit, $limit);
		
		if ($filter['limit'] == 'no') {
			$sql_limit = '';
		}

		$order_by = 'ORDER BY c.id DESC';
		if(!empty($filter['sort_by_signing_date']))
		{
			$order_by = 'ORDER BY c.date_signing DESC';
		}


		if(!empty($filter['keyword']))
		{
			$keywords = explode(' ', $filter['keyword']);
			foreach($keywords as $keyword)
			{
				$user_filter .= $this->db->placehold('AND c.sku = "'.$this->db->escape(trim($keyword)).'" OR c.user_id in (SELECT u.id FROM __users AS u WHERE u.name LIKE "%'.$this->db->escape(trim($keyword)).'%" OR REPLACE(u.phone, "-", "")  LIKE "%'.$this->db->escape(str_replace('-', '', trim($keyword))).'%" OR u.email LIKE "%'.$this->db->escape(trim($keyword)).'%" ) ');
			}
		}

		
		$query = $this->db->placehold("SELECT 
						c.id, 
						c.url,
						c.sku,
						c.type,
						c.user_id,
						c.reserv_id,
						c.house_id,
						c.apartment_id,
						c.bed_id,
						c.rental_name,
						c.rental_address,
						c.date_from,
						c.date_to,
						c.price_month,
						c.total_price,
						c.price_deposit,
						c.utility_initiator,
						c.price_utilites,
						c.price_utility_total,
						c.split_deposit,
						c.membership,
						c.signing,
						c.date_signing,
						c.date_created,
						c.date_viewed,
						c.roomtype,
						c.room_type,
						c.link1_type,
						c.note1,
						c.first_sellflow,
						c.sellflow,
						c.outpost_deposit,
						c.status,
						c.options,
						c.approve,
						c.new_lease,
						c.approve_first_salesflow,
						c.rider_type,
						c.rider_data,
						c.free_rental_amount
					FROM __contracts AS c
					$user_id_filter
					WHERE 1
						$id_filter
						$user_filter
						$reserv_id_filter
						$house_id_filter
						$status_filter
						$signing_filter
						$signing_date_filter
						$new_lease_filter
						$date_to_range_filter
					$group_by
					$order_by
					$sql_limit");

		$this->db->query($query);	



		$contracts = $this->db->results();

		$contracts = $this->request->array_to_key($contracts, 'id');



		if(!empty($contracts))
		{
			foreach($contracts as $k=>$c) {
				$contracts[$k]->rider_data = json_decode($c->rider_data);
			}

			if(isset($filter['select_users']))
			{
				$contracts_users = $this->contracts->get_contracts_users(array('contract_id'=>array_keys($contracts)));
				$contracts_users_ = $this->request->array_to_key($contracts_users, 'user_id');

				if(!empty($contracts_users))
				{
					$users = $this->users->get_users(array(
					  'id' => array_keys($contracts_users_),
					  'limit' => count($contracts_users_)
					)); 

					if(!empty($users))
					{
						foreach($contracts_users as $cu)
						{
							if(isset($contracts[$cu->contract_id]) && isset($users[$cu->user_id]))
								$contracts[$cu->contract_id]->users[$cu->user_id] = $users[$cu->user_id];
						}
					}
				}
			}
		}



		// Подписи в виде signature_1-1312.png + 
		// дата подписания в таблицу связей (теперь через логи) + 

		// три статуса подписаности и их обновление +-
		// добавление\удаление пользователей с контракта и связь с связями букингов +-

		// - новый html файл для контрактов
		// - вытащить все подписи в контракт и сохранять файл с ними
		// - смотреть существуют ли подписи по логам
		// - проверить работоспособность проперти менеджмент контрактов
		// - другие логи для контракта
		// - связь с букингами
		// - отображение статусов контаркта в бекенде
		

		return $contracts;
	}

	public function count_contracts($filter = array())
	{
		$user_id_filter = '';
		$user_filter = '';
		$reserv_id_filter = '';
		$house_id_filter = '';
		$status_filter = '';
		$signing_filter = '';

		
		// if(!empty($filter['user_id']))
		// 	$user_id_filter = $this->db->placehold('AND c.user_id in(?@)', (array)$filter['user_id']);

		if(!empty($filter['user_id']))
		{
			$user_id_filter = $this->db->placehold('LEFT JOIN  __contracts_users cu ON cu.contract_id = c.id AND cu.user_id in(?@)', (array)$filter['user_id']);
			$group_by = 'GROUP BY c.id';
		}

		if(!empty($filter['reserv_id']))
			$reserv_id_filter = $this->db->placehold('AND c.reserv_id in(?@)', (array)$filter['reserv_id']);

		if(!empty($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND c.house_id in(?@)', (array)$filter['house_id']);

		if(!empty($filter['status']))
			$status_filter = $this->db->placehold('AND c.status in(?@)', (array)$filter['status']);

		if(!empty($filter['is_signing']))
			$signing_filter = $this->db->placehold('AND c.signing=1');

		if(!empty($filter['keyword_________']))
		{
			$keywords = explode(' ', $filter['keyword']);
			foreach($keywords as $keyword)
			{
				$user_filter .= $this->db->placehold('AND c.user_id in (SELECT u.id FROM __users AS u WHERE u.name LIKE "%'.$this->db->escape(trim($keyword)).'%" OR REPLACE(u.phone, "-", "")  LIKE "%'.$this->db->escape(str_replace('-', '', trim($keyword))).'%" OR u.email LIKE "%'.$this->db->escape(trim($keyword)).'%" ) ');
			}
		}

		$query = "SELECT 
						count(distinct c.id) as count
					FROM __contracts AS c
					$user_id_filter
				WHERE 1
					$user_filter
					$reserv_id_filter
					$house_id_filter
					$status_filter
					$signing_filter";
		$this->db->query($query);	
		return $this->db->result('count');
	}

	public function get_contract($id)
	{	
		if(empty($id))
			return false;

		if(is_int($id))
			$where = $this->db->placehold(' WHERE c.id=? ', intval($id));
		else
			$where = $this->db->placehold(' WHERE c.url=? ', $id);
			
		$query = $this->db->placehold("SELECT
						c.id,
						c.url,
						c.sku,
						c.type,
						c.user_id,
						c.reserv_id,
						c.house_id,
						c.apartment_id,
						c.bed_id,
						c.rental_name,
						c.rental_address,
						c.date_from,
						c.date_to,
						c.price_month,
						c.total_price,
						c.price_deposit,
						c.utility_initiator,
						c.price_utilites,
						c.price_utility_total,
						c.split_deposit,
						c.membership,
						c.signing,
						c.date_signing,
						c.date_created,
						c.date_viewed,
						c.roomtype,
						c.room_type,
						c.link1_type,
						c.note1,
						c.first_sellflow,
						c.sellflow,
						c.outpost_deposit,
						c.status,
						c.options,
						c.approve,
						c.new_lease,
						c.approve_first_salesflow,
						c.rider_type,
						c.rider_data,
						c.free_rental_amount
					FROM __contracts c
						$where
					LIMIT 1", $id);
		
		$this->db->query($query);
		$contract = $this->db->result();
		$contract->rider_data = json_decode($contract->rider_data);
		return $contract;
	}
	
	public function update_contract($id, $contract)
	{
		$contract = (array)$contract;

		if (isset($contract['rider_data'])) {
			$contract['rider_data'] = json_encode($contract['rider_data']);
		}

		$viewed_now_query = '';
		if(isset($contract['date_viewed']) && $contract['date_viewed'] == 'now')
			$viewed_now_query = ', date_viewed=NOW()';

		$signing_now_query = '';
		if(isset($contract['date_signing']) &&  $contract['date_signing'] == 'now')
			$signing_now_query = ', date_signing=NOW()';


		

		$query = $this->db->placehold("UPDATE 
					__contracts 
				SET 
					?% 
					$viewed_now_query
					$signing_now_query
				WHERE id=? 
				LIMIT 1", $contract, intval($id));
		$this->db->query($query);


		if(isset($contract['status']))
		{
			// Cancel
			if($contract['status'] == 9 || $contract['status'] == 2)
			{
				$contract = $this->get_contract(intval($id));

				if(!empty($contract))
				{
					// Cancel Reserv
					if(!empty($contract->reserv_id) && $contract->status == 9)
						$this->beds->cancel_booking(array('id'=>$contract->reserv_id));

					// Cancel invoices
					$orders = $this->orders->get_orders(array('contract_id'=>$contract->id, 'type'=>1, 'status'=>0, 'paid'=>0, 'all'=>1));
					if(!empty($orders))
					{
						foreach($orders as $order)
							$this->orders->update_order($order->id, array('status'=>3));	
					}
				}
				
			}
		}


		return $id;
	}
	
	public function add_contract($contract)
	{
		$contract->url = md5(uniqid($this->config->salt, true));

		$date_created_query = '';
		if(!isset($contract->date_created))
			$date_created_query = ', date_created=NOW()';

		if (isset($contract->rider_data)) {
			$contract->rider_data = json_encode($contract->rider_data);
		}

		if(!empty($contract->house_id))
		{
			$house = $this->pages->get_page(intval($contract->house_id));
			$company_houses = current($this->companies->get_company_houses(array('house_id'=>$contract->house_id)));
			$company = $this->companies->get_company($company_houses->company_id);

			$last_contract_id = $house->last_contract;
			$this->pages->update_page($house->id, array('last_contract' => $house->last_contract + 1));

			if(!empty($company))
			// 	$landlord = $this->users->get_user(intval($company->landlord_id));

			// if(!empty($landlord))
				$contract->sku = str_pad($company->landlord_id, 2, "0", STR_PAD_LEFT).'-'.str_pad($house->sku, 3, "0", STR_PAD_LEFT).'-'.str_pad($last_contract_id + 1, 4, "0", STR_PAD_LEFT);
 		}

		$query = $this->db->placehold("INSERT INTO __contracts SET ?% $date_created_query", $contract);
		$this->db->query($query);
		$id = $this->db->insert_id();

		if($contract->type == 3 && !empty($contract->reserv_id))
		{
			$invoices = $this->orders->get_orders(array(
				'booking_id' => $contract->reserv_id,
				'label' => array(5, 6)
			));
			if(!empty($invoices))
			{
				foreach ($invoices as $inv) 
				{
					$this->orders->update_order($inv->id, array('contract_id' => $id));
				}
			}
		}
		return $id;
	}

	public function delete_contract($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __contracts WHERE id = ? LIMIT 1", intval($id));
			$this->db->query($query);
		}
	}

	// --- Contracts Users ---

	public function get_contracts_users($filter = array())
	{
		if(empty($filter['contract_id']) && empty($filter['user_id']))
			return false;

		$contract_id_filter = '';
		if(!empty($filter['contract_id']))
			$contract_id_filter = $this->db->placehold('AND contract_id in(?@)', (array)$filter['contract_id']);

		$user_id_filter = '';
		if(!empty($filter['user_id']))
			$user_id_filter = $this->db->placehold('AND user_id in(?@)', (array)$filter['user_id']);

		$query = $this->db->placehold("SELECT 
				contract_id, 
				user_id 
			FROM __contracts_users
			WHERE 1
				$contract_id_filter
				$user_id_filter
			");
		$this->db->query($query);
		return $this->db->results();
	}


	public function add_contract_user($contract_id, $user_id)
	{
		if(empty($contract_id) || empty($user_id))
			return false;

		$query = $this->db->placehold("INSERT IGNORE INTO __contracts_users SET contract_id=?, user_id=?", $contract_id, $user_id);

		if(!$this->db->query($query))
			return false;

		return true;
	}

	public function delete_contract_user($contract_id, $user_id)
	{
		$query = $this->db->placehold("DELETE FROM __contracts_users WHERE contract_id=? AND user_id=? LIMIT 1", intval($contract_id), intval($user_id));
		$this->db->query($query);
	}


	// --- Contracts Users (end) ---

	public function start_first_salesflow($contract_id, $user_id, $params)
	{
		if($contract_id != 0) // 0 это когда не Аутпост клиент
			$contract = $this->contracts->get_contract(intval($contract_id));
		$user = $this->users->get_user(intval($user_id));

		if(!empty($user))
		{
			if(!empty($contract))
			{
				$this->logs->add_log(array(
		            'parent_id' => $contract->id, 
		            'type' => 4, 
		            'subtype' => 9, // Send first sales flow
		            'sender_type' => $params['sender_type'],
		            'sender' => $params['sender']
		        ));
			}
			else
			{
				$this->logs->add_log(array(
		            'parent_id' => $params['salesflow_id'], 
		            'type' => 2, 
		            'user_id' => $user->id, 
		            'subtype' => 10, // Airbnb Salesflow Sent
		            'sender_type' => $params['sender_type'],
		            'sender' => $params['sender']
		        ));

				// $this->logs->add_log(array(
				// 	'parent_id'=> $user->id, 
				// 	'type' => 8, // Covid Form
				// 	'subtype' => 1, // Sended
				// 	'user_id' => $user->id, 
				// 	'sender_type' => $params['sender_type'], 
				// 	'sender' => $params['sender']
				// ));
			}

			$salesflow = false;
			if (!empty($params['salesflow_id'])) {
				$salesflow = $this->salesflows->get_salesflows([
					'id' => $params['salesflow_id'],
					'limit' => 1
				]);
			}

			// $notification = current($this->notifications->get_notifications(array('user_id'=>$user->id, 'type'=>2)));
			// if(empty($notification))
			// {
				$notification_id = $this->notifications->add_notification(array('user_id'=>$user->id, 'type'=>2));
				if(!empty($notification_id))
				{
					$notification = $this->notifications->get_notification($notification_id);
				}
			// }

			//	Если отправили с контракта, то нужно переделать на отправку всем юзерам контракта
			$this->design->assign('bg_check', $notification);
			$this->design->assign('user', $user);
			$this->design->assign('salesflow', $salesflow);
			if(!empty($contract))
			{
				$this->design->assign('contract', $contract);
				// $this->design->assign('interval_days', $interval_days);
				$email_template = $this->design->fetch($this->config->root_dir.'design/'.$this->settings->theme.'/html/email/background_check_sellflow.tpl');
			}
			else
			{
                if (!empty($salesflow)) {
                    $bookings = $this->beds->get_bookings([
                        'id' => $salesflow->booking_id,
                        'sp_group' => true
                    ]);
                    if (!empty($bookings)) {
                        $booking = current($bookings);
                        $interval_days = date_diff(date_create($booking->arrive), date_create($booking->depart))->days + 1;
                        $this->design->assign('interval_days', $interval_days);
                    }
                }
				$email_template = $this->design->fetch($this->config->root_dir.'design/'.$this->settings->theme.'/html/email/airbnb_sellflow.tpl');
			}

			$subject = $this->design->get_var('subject');
			$this->notify->email($user->email, $subject, $email_template, $this->settings->notify_from_email);
		}
		else
		{
			return false;
		}

	}

	public function start_second_salesflow($contract_id, $user_id, $params)
	{
		$contract = $this->contracts->get_contract(intval($contract_id));
		$user = $this->users->get_user(intval($user_id));

		if(!empty($contract) && !empty($user))
		{
			$this->logs->add_log(array(
				'user_id' => $user->id,
	            'parent_id' => $contract->id, 
	            'type' => 4, 
	            'subtype' => 2, // contract sended
	            'sender_type' => $params['sender_type'],
		        'sender' => $params['sender']
	        ));

			$is_airbnb_contract = false;
			if(!empty($contract->house_id)) {
				if(in_array($contract->house_id, $this->salesflows->airbnb_contracts_houses_ids)) {
					if(!empty($contract->reserv_id)) {
						$booking = $this->beds->get_bookings([
							'id' => $contract->reserv_id, 
							'limit' => 1
						]);
					}
					// 2 - Airbnb Client type 
					if(!empty($booking) && $booking->client_type_id == 2) { 
						$is_airbnb_contract = true;
					}
				}
			}
			$this->design->assign('is_airbnb_contract', $is_airbnb_contract);

			// interval calc
			$d1 = date_create($contract->date_from);
			$d2 = date_create($contract->date_to);
			$interval = date_diff($d1, $d2);

			$this->design->assign('interval_days', $interval->days);
			$this->design->assign('user', $user);
			$this->design->assign('contract', $contract);

			$email_template = $this->design->fetch($this->config->root_dir.'design/'.$this->settings->theme.'/html/email/background_check_sellflow2.tpl');

			$subject = $this->design->get_var('subject');
			$this->notify->email($user->email, $subject, $email_template, $this->settings->notify_from_email);

			// Add log
			// $this->logs->add_log(array(
			// 	'parent_id' => $user->id, 
			// 	'type' => 8, // Covid Form
			// 	'subtype' => 1, // Sended
			// 	'user_id' => $user->id, 
			// 	'sender_type' => $params['sender_type'],
			// 	'sender' => $params['sender']
			// ));

			$this->contracts->update_contract($contract->id, ['sellflow'=>1]);
			$contract->sellflow = 1;
				
			$message_success = 'The second sales flow started for '.$user->name;

			return $message_success;
		}
		else
		{
			return false;
		}

	}


	public function valid_date($d, $m, $y)
	{
		if(!checkdate($m, $d, $y))
			return $this->valid_date($d-1, $m, $y);
		else
			return $d;
	}


	// Calculate monthly payments
	public function calculate($date_from, $date_to, $price_month)
	{
		if(empty($date_from) || empty($date_to) || empty($price_month))
			return false;

		$result = new stdClass;
		$result->invoices = array();
		$result->days = 0;
		$result->total = 0;
		$result->lease_term = 0;

		$u_now = strtotime(date('Y-m-d'));

		// Month count
		$d1 = date_create($date_from);
		$d2 = date_create($date_to);
		
		$main_date = $d1->format('j');

		$interval = date_diff($d1, $d2);

		$result->days = $interval->days;

		$result->lease_term = $interval->m;
		if($interval->d > 27)
		$result->lease_term += 1;
		if($interval->y > 0)
		$result->lease_term += $interval->y * 12;

		$date_start = date_create($date_from);



		if($interval->y > 0)
			$interval->m += $interval->y * 12;
		if($interval->m > 0)
		{
			$month_count = $interval->m;
			
			for($n=0; $n<=$month_count; $n++)
			{
				$invoice = new stdClass;

				$invoice->date_from = $date_start->format('Y-m-d');

				$invoice->days = $interval->d;

				if($n == 0)
				{
					$n_date = $main_date;
					$date_for_payment = date_create(date('Y-m-d'));
					date_add($date_for_payment, date_interval_create_from_date_string('2 days'));
					$invoice->date_for_payment = $date_for_payment->format('Y-m-d');
				}
				else
				{
					$n_date = 1;
					$date_for_payment = date_create($date_start->format('Y-m-d'));
					$invoice->date_for_payment = $date_for_payment->format('Y-m').'-01';
				}
				$n_month = $date_start->format('n');
				$n_year = $date_start->format('Y');
				
				if(strtotime($date_for_payment->format('Y-m-d')) >= $u_now)
					$invoice->future = true;

				if($n_month == 12)
				{
					$n_month = 1;
					$n_year++;
				}
				else
				{
					$n_month++;
				}

				$n_date = $this->valid_date($n_date, $n_month, $n_year);
				$date_end = date_create("$n_year-$n_month-$n_date");


				$date_to_m = date_create($date_end->format('Y-m-d'));
				date_sub($date_to_m, date_interval_create_from_date_string('1 days'));

				if($n == $month_count && date("m",strtotime($date_start->format('Y-m-d'))) == date("m",strtotime($d2->format('Y-m-d'))))
				{
					$interval_1_m = date_diff($date_start, $d2);
				}
				else
					$interval_1_m = date_diff($date_start, $date_to_m);

				$invoice->interval = $interval_1_m->days;
				if(($n == 1 && $invoice->interval <= 28) || ($n == $month_count && $invoice->interval <= 28))
				{
					$invoice->price = ceil(ceil($price_month * 12 / 365) * ($interval_1_m->d+1));
				}
				else
					$invoice->price = $price_month;

				if($n == $month_count && date("m",strtotime($date_start->format('Y-m-d'))) == date("m",strtotime($d2->format('Y-m-d'))))
				{
					// $n_date_end = $this->valid_date($main_date, $n_month, $n_year);
					// $date_final_end = date_create("$n_year-$n_month-$n_date_end");
					// date_sub($date_final_end, date_interval_create_from_date_string('1 days'));

					$invoice->date_to = $d2->format('Y-m-d');
				}
				else
					$invoice->date_to = $date_to_m->format('Y-m-d');

				if(strtotime($date_to) >= strtotime($date_start->format('Y-m-d')))
				{
					$result->total += $invoice->price;
					$result->invoices[] = $invoice;
				}

				$date_start = $date_end;

				
			}
			$interval = date_diff($date_start, $d2);

		}

		// Days count
		if($interval->d >= 0 && (strtotime($date_to) >= strtotime($date_start->format('Y-m-d'))))
		{
			$invoice = new stdClass;

			$invoice->date_from = $date_start->format('Y-m-d');

			$date_for_payment = date_create($date_start->format('Y-m-d'));

			// first invoice in booking
			if(empty($result->invoices))
			{
				$date_for_payment = date_create(date('Y-m-d'));
				date_add($date_for_payment, date_interval_create_from_date_string('2 days'));
				$invoice->date_for_payment = $date_for_payment->format('Y-m-d');
			}
			else
				$invoice->date_for_payment = $date_for_payment->format('Y-m').'-01';


			if(strtotime($date_for_payment->format('Y-m-d')) >= $u_now)
				$invoice->future = true;

			$date_end = date_create($date_start->format('Y-m-d'));
			date_add($date_end, date_interval_create_from_date_string($interval->d.' days'));

			if($date_to != $date_end->format('Y-m-d'))
			{
				$interval = date_diff($date_start, date_create($date_to));

				$invoice->date_to = $date_to;

				$date_end_interval = date_create($date_to);
				date_add($date_end_interval, date_interval_create_from_date_string('1 days'));
				if($interval->m == 1)
				{
					$invoice->price = $price_month + (ceil(ceil($price_month * 12 / 365) * ($interval->d+1)));

				}
				elseif((date("m",strtotime($date_end_interval->format('Y-m-d'))) == date("m",strtotime($invoice->date_to)) && $interval->d < 28 && $interval->m == 0) || ($interval->d < 27 && ($interval->m != 1 && $interval->d !=0)))
				{
					$invoice->price = ceil(ceil($price_month * 12 / 365) * ($interval->days+1));

				}
				else
					$invoice->price = $price_month;


				$invoice->interval = $interval->days;
			}
			else
			{
				$invoice->date_to = $date_end->format('Y-m-d');
				date_add($date_end, date_interval_create_from_date_string('1 days'));
				if($interval->m == 1)
				{
					$invoice->price = $price_month + (ceil(ceil($price_month * 12 / 365) * ($interval->d+1)));


				}
				elseif((date("m",strtotime($date_end->format('Y-m-d'))) == date("m",strtotime($invoice->date_to)) && (($interval->d+1 < 29 && date("m",strtotime($invoice->date_to)) != '02' && date("m",strtotime($invoice->date_to)) != '03') || ($interval->d < 28  && date("m",strtotime($invoice->date_to)) != '02' && date("m",strtotime($invoice->date_to)) != '03')) || $interval->d+1 < 28 || $interval->d < 27 || $interval->d == 0))
				{
					$invoice->price = ceil(ceil($price_month * 12 / 365) * ($interval->days+1));
				}
				else
					$invoice->price = $price_month;

				$invoice->interval = $interval->d + 1;
			}


			$result->total += $invoice->price;

			// if($invoice->interval < 5 && count($result->invoices) != 1)
			// {
			// 	if(isset($result->invoices[count($result->invoices)-1]))
			// 	{
			// 		$result->invoices[count($result->invoices)-1]->price += $invoice->price;
			// 		$result->invoices[count($result->invoices)-1]->date_to = $invoice->date_to;
			// 	}
			// }
			// else
			// {
			// }

			$result->invoices[] = $invoice;

		}

		$result->days++;
		return $result;
	}

	// Calculate monthly payments
	public function calculate_old($date_from, $date_to, $price_month)
	{
		if(empty($date_from) || empty($date_to) || empty($price_month))
			return false;

		$result = new stdClass;
		$result->invoices = array();
		$result->days = 0;
		$result->total = 0;
		$result->lease_term = 0;

		$u_now = strtotime(date('Y-m-d'));

		// Month count
		$d1 = date_create($date_from);
		$d2 = date_create($date_to);
		
		$main_date = $d1->format('j');

		$interval = date_diff($d1, $d2);

		$result->days = $interval->days;

		$result->lease_term = $interval->m;
		if($interval->d > 27)
		$result->lease_term += 1;
		if($interval->y > 0)
		$result->lease_term += $interval->y * 12;

		$date_start = date_create($date_from);

		if($interval->y > 0)
			$interval->m += $interval->y * 12;
		if($interval->m > 0)
		{
			$month_count = $interval->m;
			
			for($n=0; $n<$month_count; $n++)
			{
				$invoice = new stdClass;
				$invoice->price = $price_month;
				$result->total += $invoice->price;

				$invoice->date_from = $date_start->format('Y-m-d');

				$n_date = $main_date;
				$n_month = $date_start->format('n');
				$n_year = $date_start->format('Y');

				$date_for_payment = date_create($date_start->format('Y-m-d'));
				date_add($date_for_payment, date_interval_create_from_date_string('- 2 days'));
				$invoice->date_for_payment = $date_for_payment->format('Y-m-d');

				
				if(strtotime($date_for_payment->format('Y-m-d')) >= $u_now)
					$invoice->future = true;

				if($n_month == 12)
				{
					$n_month = 1;
					$n_year++;
				}
				else
				{
					$n_month++;
				}

				$n_date = $this->valid_date($n_date, $n_month, $n_year);
				$date_end = date_create("$n_year-$n_month-$n_date");
				$date_start = $date_end;

				$date_to_m = date_create($date_end->format('Y-m-d'));
				date_sub($date_to_m, date_interval_create_from_date_string('1 days'));

				$invoice->date_to = $date_to_m->format('Y-m-d');
				$result->invoices[] = $invoice;
			}
		}

		// Days count
		if($interval->d >= 0 && (strtotime($date_to) >= strtotime($date_start->format('Y-m-d'))))
		{
			$invoice = new stdClass;

			$invoice->date_from = $date_start->format('Y-m-d');

			$date_for_payment = date_create($date_start->format('Y-m-d'));
			date_add($date_for_payment, date_interval_create_from_date_string('- 2 days'));
			$invoice->date_for_payment = $date_for_payment->format('Y-m-d');

			if(strtotime($date_for_payment->format('Y-m-d')) >= $u_now)
				$invoice->future = true;

			$date_end = date_create($date_start->format('Y-m-d'));
			date_add($date_end, date_interval_create_from_date_string($interval->d.' days'));

			if($date_to != $date_end->format('Y-m-d'))
			{
				$interval = date_diff($date_start, date_create($date_to));

				$invoice->date_to = $date_to;

				$date_end_interval = date_create($date_to);
				date_add($date_end_interval, date_interval_create_from_date_string('1 days'));
				if((date("m",strtotime($date_end_interval->format('Y-m-d'))) == date("m",strtotime($invoice->date_to)) && $interval->d < 28 && $interval->m == 0) || ($interval->d < 27 && ($interval->m != 1 && $interval->d !=0)))
				{
					$invoice->price = ceil(ceil($price_month * 12 / 365) * ($interval->d+1));
				}
				else
					$invoice->price = $price_month;


				$invoice->interval = $interval->days;
			}
			else
			{
				$invoice->date_to = $date_end->format('Y-m-d');
				date_add($date_end, date_interval_create_from_date_string('1 days'));
				if((date("m",strtotime($date_end->format('Y-m-d'))) == date("m",strtotime($invoice->date_to)) && (($interval->d+1 < 29 && date("m",strtotime($invoice->date_to)) != '02' && date("m",strtotime($invoice->date_to)) != '03') || ($interval->d < 28  && date("m",strtotime($invoice->date_to)) != '02' && date("m",strtotime($invoice->date_to)) != '03')) || $interval->d+1 < 28 || $interval->d < 27 || $interval->d == 0))
				{
					$invoice->price = ceil(ceil($price_month * 12 / 365) * ($interval->d+1));
				}
				else
					$invoice->price = $price_month;

				$invoice->interval = $interval->d + 1;
			}

			$result->total += $invoice->price;

			if($invoice->interval < 5 && count($result->invoices) != 1)
			{
				if(isset($result->invoices[count($result->invoices)-1]))
				{
					$result->invoices[count($result->invoices)-1]->price += $invoice->price;
					$result->invoices[count($result->invoices)-1]->date_to = $invoice->date_to;
				}
			}
			else
			{
				$result->invoices[] = $invoice;
			}
		}

		$result->days++;

		return $result;
	}


	/**
	 * Calculate Hotel monthly payments
	 * @param string $date_from 
	 * @param string $date_to
	 * @param float $price_night
	 * @return object
	 **/

	public function calculate_hotel($date_from, $date_to, $price_night)
	{
		if(empty($date_from) || empty($date_to) || empty($price_night))
			return false;

		$result = new stdClass;
		$result->invoices = [];
		$result->nights = 0;
		$result->total = 0;
		$result->lease_term = 0;

		$u_now = strtotime(date('Y-m-d'));

		// Month count
		$d1 = date_create($date_from);
		$d2 = date_create($date_to);
		
		$main_date = $d1->format('j');

		$interval = date_diff($d1, $d2);

		$result->nights = $interval->days;
		$interval->lease_term = floor($interval->days / 25);

		$interval->d = $interval->days - ($interval->lease_term * 25);

		$result->lease_term = $interval->lease_term;
		
		$date_start = date_create($date_from);

		if($interval->lease_term > 0)
		{
			$month_count = $interval->lease_term;
			
			for($n=0; $n<$month_count; $n++)
			{
				$invoice = new stdClass;

				$invoice->date_from = $date_start->format('Y-m-d');

				$invoice->nights = 25;

				if($n == 0)
				{
					$n_date = $main_date;
					$date_for_payment = date_create(date('Y-m-d'));
					date_add($date_for_payment, date_interval_create_from_date_string('2 days'));
					$invoice->date_for_payment = $date_for_payment->format('Y-m-d');
				}
				else
				{
					$date_for_payment = date_create($date_start->format('Y-m-d'));
					$invoice->date_for_payment = $date_for_payment->format('Y-m-d');
				}
				$n_month = $date_start->format('n');
				$n_year = $date_start->format('Y');

				if(strtotime($date_for_payment->format('Y-m-d')) >= $u_now)
					$invoice->future = true;

				$date_end = date_create($date_start->format('Y-m-d'));
				date_add($date_end, date_interval_create_from_date_string('25 days'));

				$invoice->price = $invoice->nights * $price_night;

				$invoice->date_to = $date_end->format('Y-m-d');

				if(strtotime($date_to) >= strtotime($date_start->format('Y-m-d')))
				{
					$result->total += $invoice->price;
					$result->invoices[] = $invoice;
				}

				$date_start = $date_end;
			}
		}

		// Days count
		if($interval->d >= 0 && (strtotime($date_to) >= strtotime($date_start->format('Y-m-d'))))
		{
			$invoice = new stdClass;

			$invoice->date_from = $date_start->format('Y-m-d');

			$invoice->nights = $interval->d;

			$date_for_payment = date_create($date_start->format('Y-m-d'));

			// first invoice in booking
			if(empty($result->invoices))
			{
				$date_for_payment = date_create(date('Y-m-d'));
				date_add($date_for_payment, date_interval_create_from_date_string('2 days'));
				$invoice->date_for_payment = $date_for_payment->format('Y-m-d');
			}
			else
				$invoice->date_for_payment = $date_for_payment->format('Y-m-d');



			if(strtotime($date_for_payment->format('Y-m-d')) >= $u_now)
				$invoice->future = true;

			$date_end = date_create($date_start->format('Y-m-d'));
			date_add($date_end, date_interval_create_from_date_string($interval->d.' days'));

			if($date_to != $date_end->format('Y-m-d'))
			{
				$interval = date_diff($date_start, date_create($date_to));

				$invoice->date_to = $date_to;

				$date_end_interval = date_create($date_to);
				date_add($date_end_interval, date_interval_create_from_date_string('1 days'));

				$invoice->price = $price_night * $interval->d;

				$invoice->interval = $invoice->nights;
			}
			else
			{
				$invoice->date_to = $date_end->format('Y-m-d');
				date_add($date_end, date_interval_create_from_date_string('1 days'));
					
				$invoice->price = $price_night * $interval->d;

				$invoice->interval = $interval->d;
			}

			$result->total += $invoice->price;

			$result->invoices[] = $invoice;
		}

		// $result->days++;
		return $result;
	}

	/**
	 * Calculate Hotel monthly payments
	 * @param string $date_from 
	 * @param string $date_to
	 * @param float $price_day 
	 * @return object
	 **/
	public function calculate_hotel_old___($date_from, $date_to, $price_day)
	{
		if(empty($date_from) || empty($date_to) || empty($price_day))
			return false;

		$result = new stdClass;
		$result->invoices = array();
		$result->days = 0;
		$result->total = 0;
		$result->lease_term = 0;

		$u_now = strtotime(date('Y-m-d'));

		// Month count
		$d1 = date_create($date_from);
		$d2 = date_create($date_to);
		
		$main_date = $d1->format('j');

		$interval = date_diff($d1, $d2);

		$result->days = $interval->days;
		$interval->lease_term = floor($interval->days / 25);

		$interval->d = $interval->days - ($interval->lease_term * 25) + 1;

		$result->lease_term = $interval->lease_term;
		
		$date_start = date_create($date_from);

		if($interval->lease_term > 0)
		{
			$month_count = $interval->lease_term;
			
			for($n=0; $n<$month_count; $n++)
			{
				$invoice = new stdClass;

				$invoice->date_from = $date_start->format('Y-m-d');

				$invoice->days = 25;

				if($n == 0)
				{
					$n_date = $main_date;
					$date_for_payment = date_create(date('Y-m-d'));
					date_add($date_for_payment, date_interval_create_from_date_string('1 days'));
					$invoice->date_for_payment = $date_for_payment->format('Y-m-d');
				}
				else
				{
					$date_for_payment = date_create($date_start->format('Y-m-d'));
					$invoice->date_for_payment = $date_for_payment->format('Y-m-d');
				}
				$n_month = $date_start->format('n');
				$n_year = $date_start->format('Y');

				if(strtotime($date_for_payment->format('Y-m-d')) >= $u_now)
					$invoice->future = true;

				$date_end = date_create($date_start->format('Y-m-d'));
				date_add($date_end, date_interval_create_from_date_string('25 days'));

				$invoice->price = 25 * $price_day;

				$invoice->date_to = $date_end->format('Y-m-d');

				if(strtotime($date_to) >= strtotime($date_start->format('Y-m-d')))
				{
					$result->total += $invoice->price;
					$result->invoices[] = $invoice;
				}

				$date_start = $date_end;
			}
		}

		// Days count
		if($interval->d >= 0 && (strtotime($date_to) >= strtotime($date_start->format('Y-m-d'))))
		{
			$invoice = new stdClass;

			$invoice->date_from = $date_start->format('Y-m-d');

			$invoice->days = $interval->d;

			$date_for_payment = date_create($date_start->format('Y-m-d'));

			// first invoice in booking
			if(empty($result->invoices))
			{
				$date_for_payment = date_create(date('Y-m-d'));
				date_add($date_for_payment, date_interval_create_from_date_string('1 days'));
				$invoice->date_for_payment = $date_for_payment->format('Y-m-d');
			}
			else
				$invoice->date_for_payment = $date_for_payment->format('Y-m-d');



			if(strtotime($date_for_payment->format('Y-m-d')) >= $u_now)
				$invoice->future = true;

			$date_end = date_create($date_start->format('Y-m-d'));
			date_add($date_end, date_interval_create_from_date_string($interval->d.' days'));

			if($date_to != $date_end->format('Y-m-d'))
			{
				$interval = date_diff($date_start, date_create($date_to));

				$invoice->date_to = $date_to;

				$date_end_interval = date_create($date_to);
				date_add($date_end_interval, date_interval_create_from_date_string('1 days'));

				$invoice->price = $price_day * $interval->d;

				$invoice->interval = $interval->days;
			}
			else
			{
				$invoice->date_to = $date_end->format('Y-m-d');
				date_add($date_end, date_interval_create_from_date_string('1 days'));
					
				$invoice->price = $price_day * $interval->d;

				$invoice->interval = $interval->d + 1;
			}

			$result->total += $invoice->price;

			$result->invoices[] = $invoice;
		}

		$result->days++;
		return $result;
	}

	/**
	 * Calculate Airbnb monthly payments
	 * @param string $date_from 
	 * @param string $date_to
	 * @param float $price_day 
	 * @return object
	 **/
	public function calculate_airbnb($date_from, $date_to, $price_day)
	{
		if(empty($date_from) || empty($date_to) || empty($price_day))
			return false;

		$result = new stdClass;
		$result->invoices = array();
		$result->days = 0;
		$result->total = 0;
		$result->lease_term = 0;

		$u_now = strtotime(date('Y-m-d'));

		// Month count
		$d1 = date_create($date_from);
		$d2 = date_create($date_to);
		
		$main_date = $d1->format('j');

		$interval = date_diff($d1, $d2);

		$result->days = $interval->days;

		$result->lease_term = $interval->m;
		if($interval->y > 0)
		{
			$result->lease_term += $interval->y * 12;
		}

		$date_start = date_create($date_from);

		if($interval->y > 0)
			$interval->m += $interval->y * 12;
		if($interval->m > 0)
		{
			$month_count = $interval->m;
			
			for($n=0; $n<$month_count; $n++)
			{
				$invoice = new stdClass;
				$invoice->date_from = $date_start->format('Y-m-d');

				$n_date = $main_date;
				$n_month = $date_start->format('n');
				$n_year = $date_start->format('Y');

				$date_for_payment = date_create($date_start->format('Y-m-d'));
				date_add($date_for_payment, date_interval_create_from_date_string('- 2 days'));
				$invoice->date_for_payment = $date_for_payment->format('Y-m-d');
				
				if(strtotime($date_for_payment->format('Y-m-d')) >= $u_now)
					$invoice->future = true;

				if($n_month == 12)
				{
					$n_month = 1;
					$n_year++;
				}
				else
				{
					$n_month++;
				}

				$n_date = $this->valid_date($n_date, $n_month, $n_year);
				$date_end = date_create("$n_year-$n_month-$n_date");
				$date_to_m = date_create($date_end->format('Y-m-d'));
				date_sub($date_to_m, date_interval_create_from_date_string('1 days'));

				$inv_interval = date_diff($date_start, $date_to_m);

				$date_start = $date_end;

				$invoice->price = ceil($price_day * ($inv_interval->days+1));

				$result->total += $invoice->price;
				$invoice->date_to = $date_to_m->format('Y-m-d');
				$result->invoices[] = $invoice;
			}
		}

		// Days count
		if($interval->d >= 0 && (strtotime($date_to) >= strtotime($date_start->format('Y-m-d'))))
		{
			$invoice = new stdClass;

			$invoice->date_from = $date_start->format('Y-m-d');

			$date_for_payment = date_create($date_start->format('Y-m-d'));
			date_add($date_for_payment, date_interval_create_from_date_string('- 2 days'));
			$invoice->date_for_payment = $date_for_payment->format('Y-m-d');

			if(strtotime($date_for_payment->format('Y-m-d')) >= $u_now)
				$invoice->future = true;

			$date_end = date_create($date_start->format('Y-m-d'));
			date_add($date_end, date_interval_create_from_date_string($interval->d.' days'));

			$interval = date_diff($date_start, date_create($date_to));

			$invoice->date_to = $date_to;

			$date_end_interval = date_create($date_to);
			date_add($date_end_interval, date_interval_create_from_date_string('1 days'));
			
			$invoice->price = ceil($price_day * ($interval->d+1));

			$invoice->interval = $interval->days + 1;

			$result->total += $invoice->price;

			$result->invoices[] = $invoice;
		}

		$result->days++;

		return $result;
	}








	/**
	 * -----------------------
	 * ---- MASTER LEASES ----
	 * -----------------------
	**/


	/**
	 * Get Leases
	 * 
	 * @param array $params
	 * id
	 * type: 1 - coliving; 2 - apartment
	 * contract_type
	 * house_id
	 * apartment_id
	 * date_from
	 * date_to
	 * @return array
	**/
	public function get_leases($params = []) {

		$id_filter = '';
		$type_filter = '';
		$house_id_filter = '';
		$apartment_id_filter = '';
		$arrive_range_filter = '';
		$contract_id_filter = '';
		$active_status_filter = '';

		$select = '';
		$group_by = '';
		$limit = 20;
		$page = 1;

		if (isset($params['limit']))
			$limit = max(1, intval($params['limit']));

		if (isset($params['page']))
			$page = max(1, intval($params['page']));

		$sql_limit = $this->db->placehold(' LIMIT ?, ? ', ($page-1)*$limit, $limit);

		if (!empty($params['id']))
			$id_filter = $this->db->placehold('AND l.id in(?@)', (array)$params['id']);

		if (!empty($params['type']))
			$type_filter = $this->db->placehold('AND l.type in(?@)', (array)$params['type']);

		if (!empty($params['house_id']))
			$house_id_filter = $this->db->placehold('AND l.house_id in(?@)', (array)$params['house_id']);

		if (!empty($params['apartment_id']))
			$apartment_id_filter = $this->db->placehold('AND l.apartment_id in(?@)', (array)$params['apartment_id']);

		if (!empty($params['arrive_range'])) {
			$arrive_range_filter = $this->db->placehold('AND l.date_from <= ? AND l.date_to >= ?', $params['arrive_range'], $params['arrive_range']);
		}

		if (!empty($params['contract_id'])) {
			$contract_id_filter = $this->db->placehold('INNER JOIN __leases_data ld ON ld.lease_id = l.id AND ld.contract_id in(?@)', (array)$params['contract_id']);
			$group_by = "GROUP BY l.id";
		}

		if (!empty($params['active_status'])) {
			switch ($params['active_status']) {
				case 'active':
					$active_status_filter = $this->db->placehold('AND (l.date_from <= NOW() AND l.date_to >= NOW())');
					break;
				case 'future':
					$active_status_filter = $this->db->placehold('AND l.date_from > NOW()');;
					break;
				case 'active_future':
					$active_status_filter = $this->db->placehold('AND ((l.date_from <= NOW() AND l.date_to >= NOW()) OR l.date_from > NOW())');
					break;
				case 'archive':
					$active_status_filter = $this->db->placehold('AND l.date_to < NOW()');;
					break;
			}
		}


		if(!empty($params['query']) && $params['query'] == 'count') {
			$select = 'COUNT(distinct l.id) as count';
		}
		else {
			$select = '
				l.id,  
				l.type,
				l.contract_type,
				l.house_id,
				l.apartment_id,
				l.date_from,
				l.date_to,
				l.price,
				l.note
			';
		}
		

		$query = $this->db->placehold("SELECT
				$select
			FROM __leases l
				$contract_id_filter
			WHERE 
				1
				$id_filter
				$type_filter
				$house_id_filter
				$apartment_id_filter
				$arrive_range_filter
				$active_status_filter
			$group_by
			ORDER BY l.date_from DESC, l.id DESC
			$sql_limit");


		if(isset($params['print_query']))
		{
			echo $query; exit;
		}

		$this->db->query($query);

		if($this->db->query($query)) {
			if(!empty($params['query']) && $params['query'] == 'count') {
				return $this->db->result('count');
			}
			else {
				if ($leases = $this->db->results()) {
					$leases = $this->request->array_to_key($leases, 'id');
					$leases_ids = array_keys($leases);

					$u_now = strtotime('today');

					foreach ($leases as $k=>$lease) {
						$leases[$k]->type_name = $this->get_lease_type($lease->type);
        				if(file_exists($this->config->master_leases_dir.$lease->id.'/master_lease.pdf')) {
							$leases[$k]->has_doc = true;
						}
						// Active status
						$lease->u_date_from = strtotime($lease->date_from);
						$lease->u_date_to = strtotime($lease->date_to);
						
						$lease_active_status = false;
						if ($lease->u_date_from <= $u_now && $lease->u_date_to >= $u_now) {
							$lease_active_status = 'Active';
						}	
						elseif ($lease->u_date_from > $u_now) {
							$lease_active_status = 'Future';
						}
						elseif ($lease->u_date_to < $u_now) {
							$lease_active_status = 'Archive';
						}
						$leases[$k]->active_status = $lease_active_status;
					}

					if (!empty($params['select_leases_data'])) {
						if ($leases_data = $this->get_leases_data(['lease_id' => $leases_ids])) {
							foreach ($leases_data as $d) {
								if (isset($leases[$d->lease_id])) {
									$leases[$d->lease_id]->data[$d->id] = $d;
									$leases[$d->lease_id]->data[$d->id]->client_type = $this->users->get_client_type($d->client_type_id);
									if (!empty($d->new)) {
										$leases[$d->lease_id]->data_new[$d->id] = $d;
									}
								}
							}
						}
					}
					if (isset($params['count']) && $params['count'] == 1) {
						$leases = current($leases);
					}
					return $leases;
				}
				else {
					return false;
				}
			}
		}
		else {
			return false;
		}
	}

	public function count_leases($params = []) {
		$count_leases_params = (array)$params;
		$count_leases_params['query'] = 'count';

		return $this->get_leases($count_leases_params);
	}


	public $leases_types = [
		1 => 'Coliving',
		2 => 'Full apartment'
	];
	public function get_lease_type($type_id = 1) {
		if (empty($type_id)) {
			$type_id = 1;
		}
		if (isset($this->leases_types[$type_id])) {
			return $this->leases_types[$type_id];
		}
		return false;
	}

	public function add_lease($lease) {	
		$query = $this->db->placehold('INSERT INTO __leases SET ?%', $lease);
		if(!$this->db->query($query))
			return false;

		$id = $this->db->insert_id();
		return $id;
	}

	public function update_lease($id, $lease) {
		$query = $this->db->placehold("UPDATE __leases SET ?% WHERE id in(?@) LIMIT ?", $lease, (array)$id, count((array)$id));
		$this->db->query($query);
		return $id;
	}

	public function delete_lease($id)
	{
		if(!empty($id))
		{
            $leases_data = $this->get_leases_data([
                'lease_id' => intval($id)
            ]);
            if (!empty($leases_data)) {
                foreach ($leases_data as $ld) {
                    $this->delete_lease_data($ld->id);
                }
            }
			$query = $this->db->placehold("DELETE FROM __leases WHERE id=? LIMIT 1", intval($id));
			$this->db->query($query);
            return $id;
		}
	}




	/**
	 * Get Leases Data
	**/
	public function get_leases_data($params = []) {

		$id_filter = '';
		$type_filter = '';
		$lease_id_filter = '';
		$user_id_filter = '';
		$client_type_id_filter = '';


		if(!empty($params['id']))
			$id_filter = $this->db->placehold('AND l.id in(?@)', (array)$params['id']);

		if(!empty($params['type']))
			$type_filter = $this->db->placehold('AND l.type in(?@)', (array)$params['type']);

		if(!empty($params['lease_id']))
			$lease_id_filter = $this->db->placehold('AND l.lease_id in(?@)', (array)$params['lease_id']);

		if(!empty($params['user_id']))
			$user_id_filter = $this->db->placehold('AND l.user_id in(?@)', (array)$params['user_id']);

		if(!empty($params['client_type_id']))
			$client_type_id_filter = $this->db->placehold('AND l.client_type_id in(?@)', (array)$params['client_type_id']);


		$query = $this->db->placehold("SELECT
				l.id,  
				l.type,
				l.lease_id,
				l.user_id,
				l.bed_id,
				l.date_from,
				l.date_to,
				l.price,
				l.date_sign,
				l.client_type_id,
				l.airbnb_id,
				l.booking_id,
				l.contract_id,
				l.new
			FROM __leases_data l
			WHERE 
				1
				$id_filter
				$type_filter
				$lease_id_filter
				$user_id_filter
				$client_type_id_filter
			ORDER BY l.date_sign, l.date_from, l.id
			");


		$this->db->query($query);

		if($this->db->query($query)) {
			if(isset($params['count']) && $params['count'] == 1)
				return $this->db->result();
			else
				return $this->db->results();
		}
		else {
			return false;
		}
	}

	public function add_lease_data($lease_data) {	
		$query = $this->db->placehold('INSERT INTO __leases_data SET ?%', $lease_data);
		if(!$this->db->query($query))
			return false;

		$id = $this->db->insert_id();
		return $id;
	}

	public function update_lease_data($id, $lease_data) {
		$query = $this->db->placehold("UPDATE __leases_data SET ?% WHERE id in(?@) LIMIT ?", $lease_data, (array)$id, count((array)$id));
		$this->db->query($query);
		return $id;
	}

	public function delete_lease_data($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __leases_data WHERE id=? LIMIT 1", intval($id));
			$this->db->query($query);
		}
	}





	
}