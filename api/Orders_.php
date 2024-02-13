<?php


require_once('Backend.php');

class Orders extends Backend
{

	public $statuses = array(
		0 => 'New',
		1 => 'Pending',
		2 => 'Paid',
		4 => 'Failed',
		3 => 'Calceled'
	);

// 2 => ['name' => 'Order'],
	public $types = array(
		1 => ['name' => 'Invoice'],
		3 => ['name' => 'Cleaning'],
		4 => ['name' => 'Refund'],
		5 => ['name' => 'Damage'],
		6 => ['name' => 'Bedding'],
		7 => ['name' => 'Application Fee'],
		9 => ['name' => 'Fee'],
		8 => ['name' => 'Other']
	);

	public function get_status($id)
	{
		if(!isset($id))
			return false;

		if(!isset($this->statuses[$id]))
			return false;

		return $this->statuses[$id];
	}


	public function get_order($id)
	{
		if(is_int($id))
			$where = $this->db->placehold(' WHERE o.id=? ', intval($id));
		else
			$where = $this->db->placehold(' WHERE o.url=? ', $id);
		
		$query = $this->db->placehold("SELECT  
						o.id, 
						o.sku,
						o.type, 
						o.contract_id,
						o.booking_id,
						o.delivery_id, 
						o.delivery_price, 
						o.separate_delivery,
						o.payment_method_id, 
						o.paid, 
						o.date, 
						o.date_due,
						o.payment_date, 
						o.payer_id,
						o.date_viewed,
						o.date_from,
						o.date_to,
						o.closed, 
						o.discount, 
						o.coupon_code, 
						o.coupon_discount,
						o.user_id,
						o.name, 
						o.address, 
						o.phone, 
						o.email, 
						o.comment, 
						o.status,
						o.url, 
						o.total_price, 
						o.note, 
						o.automatically,
						o.deposit,
						o.membership,
						o.sended,
						o.ip,
						o.child_refund_id,
						o.parent_refund_id,
						o.sended_owner,
						o.sended_owner_date,
						o.sended_owner_price
					FROM __orders o 
					$where 
					LIMIT 1");

		if($this->db->query($query))
			return $this->db->result();
		else
			return false; 
	}
	
	function get_orders($filter = array())
	{
		// По умолчанию
		$limit = 200;
		$page = 1;
		$type_filter = '';
		$sku_filter = '';
		$keyword_filter = '';
		$label_select = '';	
		$label_filter = '';	
		$not_label_filter = '';
		$status_filter = '';
		$not_status_filter = '';
		$payment_method_filter = '';
		$user_filter = '';	
		$user_id_filter = '';	
		$future_filter = '';
		$automatically_filter = '';
		$deposit_filter = '';
		$membership_filter = '';

		$modified_since_filter = '';	
		$id_filter = '';
		$paid_filter = '';
		$contract_id_filter = '';
		$booking_id_filter = '';
		$contract_booking_id_filter = '';
		$date_from_filter = '';
		$date_to_filter = '';

		
		if(isset($filter['limit']))
			$limit = max(1, intval($filter['limit']));

		if(isset($filter['page']))
			$page = max(1, intval($filter['page']));

		$sql_limit = $this->db->placehold(' LIMIT ?, ? ', ($page-1)*$limit, $limit);

		$order_by = 'o.payment_date DESC, o.status, o.id DESC';
		
			
		if(isset($filter['status']))
			$status_filter = $this->db->placehold('AND o.status in(?@)', (array)$filter['status']);
		elseif(isset($filter['not_status']))
			$not_status_filter = $this->db->placehold('AND o.status NOT in(?@)', (array)$filter['not_status']);

		if(isset($filter['type']))
			$type_filter = $this->db->placehold('AND o.type = ?', intval($filter['type']));

		if(isset($filter['date_from']))
		{
			$date_from = date('Y-m-d', strtotime($filter['date_from']));
			$date_from_filter = $this->db->placehold('AND o.date_from>=?', $date_from.' 00:00:00');
		}

		if(isset($filter['date_to']))
		{
			$date_to = date('Y-m-d', strtotime($filter['date_to']));
			$date_to_filter = $this->db->placehold('AND o.date_from<=?', $date_to.' 23:59:59');
		}

		if(isset($filter['future']))
		{
			$order_by = 'date_due';
			$future_filter = $this->db->placehold('AND o.sended=0', $filter['future']);
		}
		
		if(isset($filter['past']))
		{
			$order_by = 'date_from DESC';
			$future_filter = $this->db->placehold('AND o.sended=1');
		}

		if(isset($filter['paid']))
		{
			$paid_filter = $this->db->placehold('AND o.paid = ?', intval($filter['paid']));
			if(isset($filter['paid_month']) && isset($filter['paid_year']))
			{
				$paid_filter .= $this->db->placehold(' AND ((MONTH(o.payment_date)=? AND YEAR(o.payment_date)=?) OR (YEAR(o.payment_date)=0000 AND (MONTH(o.date_from)=? AND YEAR(o.date_from)=?) ))', $filter['paid_month'], $filter['paid_year'], $filter['paid_month'], $filter['paid_year']);
			}
		}


		if(isset($filter['automatically']))
			$automatically_filter = $this->db->placehold('AND o.automatically = ?', intval($filter['automatically']));

		if(isset($filter['deposit']))
			$deposit_filter = $this->db->placehold('AND o.deposit = ?', intval($filter['deposit']));

		if(isset($filter['membership']))
			$membership_filter = $this->db->placehold('AND o.membership = ?', intval($filter['membership']));

		if(isset($filter['id']))
			$id_filter = $this->db->placehold('AND o.id in(?@)', (array)$filter['id']);

		if(isset($filter['sku']))
			$sku_filter = $this->db->placehold('AND o.sku = ?', $filter['sku']);

		
		// if(isset($filter['user_id']))
		// 	$user_filter = $this->db->placehold('AND o.user_id in(?@)', (array)$filter['user_id']);

		if(!empty($filter['user_id']))
		{
			$user_id_filter = $this->db->placehold('INNER JOIN  __orders_users ou ON ou.order_id = o.id AND ou.user_id in(?@)', (array)$filter['user_id']);
			$group_by = 'GROUP BY o.id';
		}

		if(isset($filter['contract_id']) && isset($filter['booking_id']))
			$contract_booking_id_filter = $this->db->placehold('AND (o.contract_id in(?@) OR o.booking_id in(?@))', (array)$filter['contract_id'], (array)$filter['booking_id']);
		elseif(isset($filter['contract_id']))
			$contract_id_filter = $this->db->placehold('AND o.contract_id in(?@)', (array)$filter['contract_id']);
		elseif(isset($filter['booking_id']))
			$booking_id_filter = $this->db->placehold('AND o.booking_id in(?@)', (array)$filter['booking_id']);

		if(isset($filter['payment_method_id']))
			$payment_method_filter = $this->db->placehold('AND o.payment_method_id = ?', intval($filter['payment_method_id']));
		
		if(isset($filter['modified_since']))
			$modified_since_filter = $this->db->placehold('AND o.modified > ?', $filter['modified_since']);
		
		if(isset($filter['label']))
		{
			$label_select = 'LEFT JOIN __orders_labels AS ol ON o.id=ol.order_id';
			$label_filter = $this->db->placehold('AND ol.label_id in (?@)', (array)$filter['label']);
		}
		elseif(isset($filter['not_label']))
		{
			$label_select = 'LEFT JOIN __orders_labels AS ol ON o.id=ol.order_id';
			$not_label_filter = $this->db->placehold('AND (ol.label_id != ? OR ol.label_id IS NULL)', $filter['not_label']);
		}
		
		if(!empty($filter['keyword']))
		{
			$keywords = explode(' ', $filter['keyword']);
			foreach($keywords as $keyword)
				$keyword_filter .= $this->db->placehold('AND (o.id = "'.$this->db->escape(trim($keyword)).'" OR o.name LIKE "%'.$this->db->escape(trim($keyword)).'%" OR REPLACE(o.phone, "-", "")  LIKE "%'.$this->db->escape(str_replace('-', '', trim($keyword))).'%" OR o.email = "'.trim($keyword).'" OR o.address LIKE "%'.$this->db->escape(trim($keyword)).'%" OR o.sku = "'.$this->db->escape(trim($keyword)).'" )');
		}

		// --------- <off
		if(isset($filter['date_month_from_to__']) && isset($filter['date_year_from_to__']))
		{
			$debt = '';
			if(isset($filter['debt']))
				$debt = $this->db->placehold(' OR (o.paid=0 AND o.date_from IS NOT NULL AND o.date_from<=?)', $filter['date_year_from_to'].'-'.$filter['date_month_from_to'].'-01' );

			$or_paid_month = '';
			if(isset($filter['or_paid_month']))
				$or_paid_month = $this->db->placehold(' OR (MONTH(o.payment_date)=? AND YEAR(o.payment_date)=? AND o.date_from IS NOT NULL)', $filter['date_month_from_to'], $filter['date_year_from_to']);


			$date_from_filter = $this->db->placehold('AND ( (MONTH(o.date_from)=? AND YEAR(o.date_from)=?) OR (MONTH(o.date_to)=? AND YEAR(o.date_to)=?) '.$or_paid_month.$debt.')', $filter['date_month_from_to'], $filter['date_year_from_to'], $filter['date_month_from_to'], $filter['date_year_from_to']);
		}

		// --------- off>

		// ---------
		if(isset($filter['date_month_from_to']) && isset($filter['date_year_from_to']))
		{
			$debt = '';
			if(isset($filter['debt']))
				$debt = $this->db->placehold(' OR (o.paid=0 AND o.date_from IS NOT NULL AND o.date_from<=?)', $filter['date_year_from_to'].'-'.$filter['date_month_from_to'].'-01' );

			$or_paid_month = '';
			if(isset($filter['or_paid_month']))
				$or_paid_month = $this->db->placehold(' OR (MONTH(o.payment_date)=? AND YEAR(o.payment_date)=? AND o.date_from IS NOT NULL)', $filter['date_month_from_to'], $filter['date_year_from_to']);

			$date_from = $filter['date_year_from_to'].'-'.$filter['date_month_from_to'].'-01';
			$date_to = date("Y-m-t", strtotime($date_from));

			$date_from_filter = $this->db->placehold('AND ((o.date_from<=? && o.date_to>=?) '.$or_paid_month.$debt.')', $date_to, $date_from);
		}

		elseif(isset($filter['date_from_month']) && isset($filter['date_from_year']))
		{
			$debt = '';
			if(isset($filter['debt']))
				$debt = $this->db->placehold(' OR (o.paid=0 AND o.date_from IS NOT NULL AND o.date_from<=?)', $filter['date_from_year'].'-'.$filter['date_from_month'].'-01' );


			$or_paid_month = '';
			if(isset($filter['or_paid_month']))
				$or_paid_month = $this->db->placehold(' OR (MONTH(o.payment_date)=? AND YEAR(o.payment_date)=? AND o.date_from IS NOT NULL)', $filter['date_from_month'], $filter['date_from_year']);


			$date_from_filter = $this->db->placehold('AND ((MONTH(o.date_from)=? AND YEAR(o.date_from)=?) '.$or_paid_month.$debt.')', $filter['date_from_month'], $filter['date_from_year']);
		}
		// ---------


		$house_id_filter = '';
		if(!empty($filter['house_id']))
		{
			$house_id_filter = $this->db->placehold('INNER JOIN  __bookings b ON b.id=o.booking_id AND b.house_id in(?@)', (array)$filter['house_id']);
			$group_by = 'GROUP BY o.id';
		}


		
		if(!empty($filter['sort']))
		{
			$order_by = 'o.date, o.id';
		}
		if(!empty($filter['sort_date']))
		{
			$order_by = 'o.date DESC, o.id';
		}
		if(!empty($filter['sort_date_from']))
		{
			$order_by = 'o.date_from, o.id';
		}
		if(!empty($filter['sort_payment_date']))
		{
			$order_by = 'o.payment_date DESC, o.id DESC';
		}

		
		// Выбираем заказы
		$query = $this->db->placehold("SELECT 
							o.id, 
							o.sku, 
							o.type, 
							o.contract_id,
							o.booking_id,
							o.delivery_id, 
							o.delivery_price, 
							o.separate_delivery,
							o.payment_method_id, 
							o.paid, 
							o.payment_date, 
							o.payer_id,
							o.closed, 
							o.discount, 
							o.coupon_code, 
							o.coupon_discount,
							o.date, 
							o.date_due,
							o.date_viewed, 
							o.date_from, 
							o.date_to, 
							o.user_id, 
							o.name, 
							o.address, 
							o.phone, 
							o.email, 
							o.comment, 
							o.status,
							o.url, 
							o.total_price, 
							o.note, 
							o.deposit, 
							o.membership,
							o.sended, 
							o.automatically,
							o.child_refund_id,
							o.parent_refund_id,
							o.sended_owner,
							o.sended_owner_date,
							o.sended_owner_price
						FROM __orders AS o 
							$label_select
							$user_id_filter
							$house_id_filter
						WHERE 1
							$id_filter 
							$sku_filter
							$type_filter 
							$contract_id_filter 
							$booking_id_filter
							$contract_booking_id_filter
							$status_filter 
							$not_status_filter 
							$payment_method_filter 
							$user_filter 
							$future_filter 
							$date_from_filter 
							$date_to_filter 
							$keyword_filter 
							$label_filter
							$not_label_filter 
							$modified_since_filter 
							$deposit_filter 
							$paid_filter
							$membership_filter
							$automatically_filter
						GROUP BY o.id 
						ORDER BY $order_by 
						$sql_limit", "%Y-%m-%d");

		// print_r($query); exit;
		$this->db->query($query);


		if(isset($filter['count']) && $filter['count'] == 1)
		{
			return $this->db->result();
		}
		else
		{
			$orders = $this->db->results();
			$orders = $this->request->array_to_key($orders, 'id');

			if(!empty($orders))
			{
				$orders_ids = array_keys($orders);

				if(isset($filter['select_users']))
				{
					$orders_users = $this->get_orders_users(array('order_id'=>$orders_ids));
					$orders_users_ = $this->request->array_to_key($orders_users, 'user_id');
					if(!empty($orders_users))
					{
						$users = $this->users->get_users(array(
							'id' => array_keys($orders_users_),
							'limit' => count($orders_users_)
						));
						if(!empty($users))
						{
							foreach($orders_users as $ou)
							{
								if(isset($orders[$ou->order_id]) && isset($users[$ou->user_id]))
									$orders[$ou->order_id]->users[$ou->user_id] = $users[$ou->user_id];
							}
						}
					}
				}

				if(isset($filter['select_labels']))
				{
					$order_labels = $this->get_order_labels($orders_ids);
					if(!empty($order_labels))
					{
						foreach($order_labels as $l)
						{
							if(isset($orders[$l->order_id]))
								$orders[$l->order_id]->labels[$l->id] = $l;
						}
					}
				}

			}
			
			return $orders;
		}
		return false;

	}

	function count_orders($filter = array())
	{
		$keyword_filter = '';	
		$label_filter = '';	
		$not_label_filter = '';
		$status_filter = '';
		$not_status_filter = '';
		$type_filter = '';
		$future_filter = '';
		$date_from_filter = '';
		$date_to_filter = '';
		$payment_method_filter = '';
		$user_filter = '';	
		$user_id_filter = '';	
		$contract_id_filter = '';
		$booking_id_filter = '';
		$contract_booking_id_filter = '';

		if(isset($filter['status']))
			$status_filter = $this->db->placehold('AND o.status in(?@)', (array)$filter['status']);
		elseif(isset($filter['not_status']))
			$not_status_filter = $this->db->placehold('AND o.status NOT in(?@)', (array)$filter['not_status']);

		if(isset($filter['type']))
			$type_filter = $this->db->placehold('AND o.type = ?', intval($filter['type']));
		
		if(isset($filter['date_from']))
			$date_from_filter = $this->db->placehold('AND o.date_from>=?', $filter['date_from']);

		if(isset($filter['date_to']))
		{
			$date_to = date('Y-m-d', strtotime($filter['date_to']));
			$date_to_filter = $this->db->placehold('AND o.date_from<=?', $date_to.' 23:59:59');
		}

		if(isset($filter['future']))
		{
			$future_filter = $this->db->placehold('AND o.sended=0', $filter['future']);
		}
		
		if(isset($filter['past']))
			$future_filter = $this->db->placehold('AND o.sended=1');

		// if(isset($filter['user_id']))
		// 	$user_filter = $this->db->placehold('AND o.user_id = ?', intval($filter['user_id']));

		if(!empty($filter['user_id']))
		{
			$user_id_filter = $this->db->placehold('INNER JOIN  __orders_users ou ON ou.order_id = o.id AND ou.user_id in(?@)', (array)$filter['user_id']);
			$group_by = 'GROUP BY o.id';
		}

		if(isset($filter['contract_id']) && isset($filter['booking_id']))
			$contract_booking_id_filter = $this->db->placehold('AND (o.contract_id in(?@) OR o.booking_id in(?@))', (array)$filter['contract_id'], (array)$filter['booking_id']);
		elseif(isset($filter['contract_id']))
			$contract_id_filter = $this->db->placehold('AND o.contract_id in(?@)', (array)$filter['contract_id']);
		elseif(isset($filter['booking_id']))
			$booking_id_filter = $this->db->placehold('AND o.booking_id in(?@)', (array)$filter['booking_id']);

		if(isset($filter['payment_method_id']))
			$payment_method_filter = $this->db->placehold('AND o.payment_method_id = ?', intval($filter['payment_method_id']));


		
		
		if(isset($filter['label']))
			$label_filter = $this->db->placehold('AND ol.label_id = ?', $filter['label']);
		elseif(isset($filter['not_label']))
			$not_label_filter = $this->db->placehold('AND (ol.label_id != ?  OR ol.label_id IS NULL)', $filter['not_label']);
		
		if(!empty($filter['keyword']))
		{
			$keywords = explode(' ', $filter['keyword']);
			foreach($keywords as $keyword)
				$keyword_filter .= $this->db->placehold('AND (o.name LIKE "%'.$this->db->escape(trim($keyword)).'%" OR REPLACE(o.phone, "-", "")  LIKE "%'.$this->db->escape(str_replace('-', '', trim($keyword))).'%" OR o.email = "'.trim($keyword).'" OR o.address LIKE "%'.$this->db->escape(trim($keyword)).'%" )');
		}
		
		// Выбираем заказы
		$query = $this->db->placehold("SELECT COUNT(DISTINCT id) as count
						FROM __orders AS o 
						LEFT JOIN __orders_labels AS ol ON o.id=ol.order_id 
						$user_id_filter
						WHERE 1
							$status_filter 
							$not_status_filter 
							$type_filter 
							$contract_id_filter 
							$booking_id_filter
							$contract_booking_id_filter
							$future_filter 
							$date_from_filter 
							$date_to_filter 
							$payment_method_filter 
							$user_filter 
							$label_filter 
							$not_label_filter
							$keyword_filter");
		
		$this->db->query($query);
		return $this->db->result('count');
	}

	public function update_order($id, $order)
	{
		$order = (array)$order;

		$order_ =  $this->orders->get_order(intval($id));
		if(!empty($order['booking_id']) && $order['booking_id'] != $order_->booking_id)
			$order_->booking_id = $order['booking_id'];

		$modified_query = ', modified=now()';
		if(isset($order['empty_modified']))
			$modified_query = '';

		$query = $this->db->placehold("UPDATE __orders SET ?% $modified_query WHERE id=? LIMIT 1", $order, intval($id));
		$this->db->query($query);
		$this->update_total_price(intval($id));

		if(!empty($order_->booking_id))
		{
			$salesflows = $this->salesflows->get_salesflows(['booking_id'=>intval($order_->booking_id)]);
			if($order['deposit'] == 1 || $order_->deposit == 1)
			{
				if(!empty($order['status']) && $order['status'] != $order_->status)
				{
					foreach ($salesflows as $salesflow) 
					{
						$this->salesflows->update_salesflow($salesflow->id, ['deposit_status'=>$order['status']]);

						$sent_to_landlord = $this->notify->email_landlord_tenant_approve($salesflow->id);
						
						$this->notify->email_outpost_tenant_approve($salesflow->id, $sent_to_landlord);
					}

				}
			}
			elseif((!empty($order['type']) && $order['type'] == 7) || (empty($order['type']) && $order_->type == 7))
			{
				if(!empty($order['status']) && $order['status'] != $order_->status)
				{
					foreach ($salesflows as $salesflow) 
					{
						$this->salesflows->update_salesflow($salesflow->id, ['ra_fee_status'=>$order['status']]);
					}
				}
			}
			else
			{
				if(!empty($order['status']))
				{
					foreach ($salesflows as $salesflow) 
					{
						if($salesflow->invoice_status != 2)
						{
							$this->salesflows->update_salesflow($salesflow->id, ['invoice_status'=>$order['status']]);

							// approve users after payment
							if($order['status'] == 2)
							{
								$booking_users = $this->beds->get_bookings_users(['booking_id'=>intval($order_->booking_id)]);
								$booking_users = $this->request->array_to_key($booking_users, 'user_id');
								$users = $this->users->get_users(array(
									'id' => array_keys($booking_users),
									'limit' => count($booking_users)
								));
								foreach ($users as $u) 
								{
									if($u->status < 2) // New or Pending
										$this->users->update_user($u->id, ['status'=>2]);
								}
							}
						}
					}
				}
			}
		}

		return $id;
	}

	public function delete_order($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __purchases WHERE order_id=?", $id);
			$this->db->query($query);

			$query = $this->db->placehold("DELETE FROM __orders_labels WHERE order_id=?", $id);
			$this->db->query($query);
 			
			$query = $this->db->placehold("DELETE FROM __orders WHERE id=? LIMIT 1", $id);
			$this->db->query($query);
		}
	}
	
	public function add_order($order)
	{
		$order = (object)$order;
		$order->url = md5(uniqid($this->config->salt, true));
		$set_curr_date = '';
		if(empty($order->date) && empty($order->date_due))
		{
			$date_creation = date_create(date('Y-m-d'));
			if(!empty($order->date_from))
				$order->date_due = $order->date_from;
			else
			{
				date_add($date_creation, date_interval_create_from_date_string('4 days'));
				$order->date_due = $date_creation->format('Y-m-d');
			}
			$set_curr_date = ', date=now()';
		}
		elseif(empty($order->date_due))
		{
			$date_creation = date_create($order->date);
			date_add($date_creation, date_interval_create_from_date_string('4 days'));
			$set_curr_date = ', date_due="'.$date_creation->format('Y-m-d  H:i:s').'"';
		}

		$users_ids = array();
		if(!empty($order->user_id))
		{
			$users_ids = (array)$order->user_id;
			unset($order->user_id);
		}
		elseif(!empty($order->users) && !in_array($order->type, array('1', '3')))
		{
			$users_ids = (array)$order->users;
			unset($order->users);
		}

		// ЭТО ЕСЛИ ДЕЛАЮТ НАПРЯМУЮ ЧЕРЕЗ БЕКЕНД или клининг инвойс, в другом случае эти данные добавляются при создании всей группы инвойсов
		// если есть юзер взять его активный букинг, по нему взять ид лендлорда и дома и сделать новый ску

		if((!empty($users_ids) || !empty($order->users))  && empty($order->sku) && in_array($order->type, array('1', '3')))
		{
			if(!empty($users_ids))
				$user = $this->users->get_user(intval(current($users_ids)));
			elseif(!empty($order->users))
			{
				$user = $this->users->get_user(intval(current($order->users)));
				unset($order->users);
			}
			if(!empty($order->booking_id))
			{
				$booking = $this->beds->get_bookings(array('id'=>$order->booking_id, 'limit'=>1));
				if(!empty($booking->house_id))
					$house_id = $booking->house_id;
			}
			elseif(!empty($user->active_booking_id))
			{
				$booking = $this->beds->get_bookings(array('id'=>$user->active_booking_id, 'limit'=>1));
				if(!empty($booking->house_id))
					$house_id = $booking->house_id;
			}
			if(!empty($house_id))
			{
				$house = $this->pages->get_page(intval($house_id));
				$company_houses = current($this->companies->get_company_houses(array('house_id'=>$house_id)));
				$company = $this->companies->get_company($company_houses->company_id);

				if(!empty($company) && !empty($house))
				{
					// $landlord = $this->users->get_user(intval($company->landlord_id));

					// if(!empty($landlord))
					// {
					// }
					$last_invoice_id = $house->last_invoice;
					$this->pages->update_page($house->id, array('last_invoice'=> $last_invoice_id + 1));
					$order->sku = date('y').'-'.str_pad($company->landlord_id, 2, "0", STR_PAD_LEFT).'-'.str_pad($house->sku, 3, "0", STR_PAD_LEFT).'-'.str_pad($last_invoice_id+1, 4, "0", STR_PAD_LEFT);
					
				}
			}
		}

		unset($order->id);

		$query = $this->db->placehold("INSERT INTO __orders SET ?%$set_curr_date", $order);


		$this->db->query($query);
		$id = $this->db->insert_id();	

		if(empty($order->sku))
		{
			$order->sku = $id;
			$this->orders->update_order($id, ['sku'=>$order->sku]);
		}

		if(!empty($users_ids))
		{
			foreach($users_ids as $user_id) 
			{
				$this->orders->add_order_user($id, $user_id);
			}
		}	
		return $id;
	}

	// --- Orders Users ---

	public function get_orders_users($filter = array())
	{
		if(empty($filter['order_id']) && empty($filter['user_id']))
			return false;

		$order_id_filter = '';
		if(!empty($filter['order_id']))
			$order_id_filter = $this->db->placehold('AND order_id in(?@)', (array)$filter['order_id']);

		$user_id_filter = '';
		if(!empty($filter['user_id']))
			$user_id_filter = $this->db->placehold('AND user_id in(?@)', (array)$filter['user_id']);

		$query = $this->db->placehold("SELECT 
				order_id, 
				user_id 
			FROM __orders_users
			WHERE 1
				$order_id_filter
				$user_id_filter
			");
		$this->db->query($query);
		return $this->db->results();
	}


	public function add_order_user($order_id, $user_id)
	{
		if(empty($order_id) || empty($user_id))
			return false;

		$query = $this->db->placehold("INSERT IGNORE INTO __orders_users SET order_id=?, user_id=?", $order_id, $user_id);

		if(!$this->db->query($query))
			return false;

		return true;
	}

	public function delete_order_user($order_id, $user_id)
	{
		$query = $this->db->placehold("DELETE FROM __orders_users WHERE order_id=? AND user_id=? LIMIT 1", intval($order_id), intval($user_id));
		$this->db->query($query);
	}


	// --- Orders Users (end) ---

	public function get_label($id)
	{
		$query = $this->db->placehold("SELECT * FROM __labels WHERE id=? LIMIT 1", intval($id));
		$this->db->query($query);
		return $this->db->result();
	}

	public function get_labels()
	{
		$query = $this->db->placehold("SELECT * FROM __labels ORDER BY position");
		$this->db->query($query);
		return $this->db->results();
	}

	/*
	*
	* Создание метки заказов
	* @param $label
	*
	*/	
	public function add_label($label)
	{	
		$query = $this->db->placehold('INSERT INTO __labels SET ?%', $label);
		if(!$this->db->query($query))
			return false;

		$id = $this->db->insert_id();
		$this->db->query("UPDATE __labels SET position=id WHERE id=?", $id);	
		return $id;
	}
	
	
	/*
	*
	* Обновить метку
	* @param $id, $label
	*
	*/	
	public function update_label($id, $label)
	{
		$query = $this->db->placehold("UPDATE __labels SET ?% WHERE id in(?@) LIMIT ?", $label, (array)$id, count((array)$id));
		$this->db->query($query);
		return $id;
	}

	/*
	*
	* Удалить метку
	* @param $id
	*
	*/	
	public function delete_label($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __orders_labels WHERE label_id=?", intval($id));
			if($this->db->query($query))
			{
				$query = $this->db->placehold("DELETE FROM __labels WHERE id=? LIMIT 1", intval($id));
				return $this->db->query($query);
			}
			else
			{
				return false;
			}
		}
	}	
	
	public function get_order_labels($order_id = array())
	{
		if(empty($order_id))
			return array();

		$label_id_filter = $this->db->placehold('AND order_id in(?@)', (array)$order_id);
				
		$query = $this->db->placehold("SELECT ol.order_id, l.id, l.name, l.color, l.position
					FROM __labels l LEFT JOIN __orders_labels ol ON ol.label_id = l.id
					WHERE 
					1
					$label_id_filter   
					ORDER BY position       
					");
		
		$this->db->query($query);
		return $this->db->results();
	}
	
	public function update_order_labels($id, $labels_ids)
	{
		$labels_ids = (array)$labels_ids;
		$query = $this->db->placehold("DELETE FROM __orders_labels WHERE order_id=?", intval($id));
		$this->db->query($query);
		if(is_array($labels_ids))
		foreach($labels_ids as $l_id)
			$this->db->query("INSERT INTO __orders_labels SET order_id=?, label_id=?", $id, $l_id);
	}

	public function add_order_labels($id, $labels_ids)
	{
		$labels_ids = (array)$labels_ids;
		if(is_array($labels_ids))
		foreach($labels_ids as $l_id)
		{
			$this->db->query("INSERT IGNORE INTO __orders_labels SET order_id=?, label_id=?", $id, $l_id);
		}
	}

	public function delete_order_labels($id, $labels_ids)
	{
		$labels_ids = (array)$labels_ids;
		if(is_array($labels_ids))
		foreach($labels_ids as $l_id)
			$this->db->query("DELETE FROM __orders_labels WHERE order_id=? AND label_id=?", $id, $l_id);
	}


	public function get_purchase($id)
	{
		$query = $this->db->placehold("SELECT * FROM __purchases WHERE id=? LIMIT 1", intval($id));
		$this->db->query($query);
		return $this->db->result();
	}

	public function get_purchases($filter = array())
	{
		$order_id_filter = '';
		if(!empty($filter['order_id']))
			$order_id_filter = $this->db->placehold('AND order_id in(?@)', (array)$filter['order_id']);

		$query = $this->db->placehold("SELECT * FROM __purchases WHERE 1 $order_id_filter ORDER BY id");
		$this->db->query($query);
		return $this->db->results();
	}
	
	public function update_purchase($id, $purchase)
	{	
		$purchase = (object)$purchase;
		$old_purchase = $this->get_purchase($id);
		if(!$old_purchase)
			return false;
			
		$order = $this->get_order(intval($old_purchase->order_id));
		if(!$order)
			return false;
		
		// Не допустить нехватки на складе
		if(!empty($purchase->variant_id))
		{
			$variant = $this->variants->get_variant($purchase->variant_id);
			if($order->closed && !empty($purchase->amount) && !empty($variant) && !$variant->infinity && $variant->stock<($purchase->amount-$old_purchase->amount))
				return false;
		}
		
		
		// Если заказ закрыт, нужно обновить склад при изменении покупки
		if($order->closed && !empty($purchase->amount))
		{
			if($old_purchase->variant_id != $purchase->variant_id)
			{
				if(!empty($old_purchase->variant_id))
				{
					$query = $this->db->placehold("UPDATE __variants SET stock=stock+? WHERE id=? AND stock IS NOT NULL LIMIT 1", $old_purchase->amount, $old_purchase->variant_id);
					$this->db->query($query);
				}
				if(!empty($purchase->variant_id))
				{
					$query = $this->db->placehold("UPDATE __variants SET stock=stock-? WHERE id=? AND stock IS NOT NULL LIMIT 1", $purchase->amount, $purchase->variant_id);
					$this->db->query($query);
				}
			}
			elseif(!empty($purchase->variant_id))
			{
				$query = $this->db->placehold("UPDATE __variants SET stock=stock+(?) WHERE id=? AND stock IS NOT NULL LIMIT 1", $old_purchase->amount - $purchase->amount, $purchase->variant_id);
				$this->db->query($query);
			}
		}
		
		$query = $this->db->placehold("UPDATE __purchases SET ?% WHERE id=? LIMIT 1", $purchase, intval($id));
		$this->db->query($query);
		$this->update_total_price($order->id);		
		return $id;
	}
	
	public function add_purchase($purchase)
	{
		$purchase = (object)$purchase;
		if(!empty($purchase->variant_id))
		{
			$variant = $this->variants->get_variant($purchase->variant_id);
			if(empty($variant))
				return false;
			$product = $this->products->get_product(intval($variant->product_id));
			if(empty($product))
				return false;
		}			

		$order = $this->get_order(intval($purchase->order_id));

		if(empty($order))
			return false;				
	

		// Не допустить нехватки на складе
		// if($order->closed && !empty($purchase->amount) && !$variant->infinity && $variant->stock<$purchase->amount)
		// 	return false;
		
		if(!isset($purchase->product_id) && isset($variant))
			$purchase->product_id = $variant->product_id;
				
		if(!isset($purchase->product_name)  && !empty($product))
			$purchase->product_name = $product->name;
			
		if(!isset($purchase->sku) && !empty($variant))
			$purchase->sku = $variant->sku;
			
		if(!isset($purchase->variant_name) && !empty($variant))
			$purchase->variant_name = $variant->name;
			
		if(!isset($purchase->price) && !empty($variant))
			$purchase->price = $variant->price;

		if(empty($purchase->price))
			$purchase->price = 0;
			
		if(!isset($purchase->amount))
			$purchase->amount = 1;

		// Если заказ закрыт, нужно обновить склад при добавлении покупки
		// if($order->closed && !empty($purchase->amount) && !empty($variant->id))
		// {
		// 	$stock_diff = $purchase->amount;
		// 	$query = $this->db->placehold("UPDATE __variants SET stock=stock-? WHERE id=? AND stock IS NOT NULL LIMIT 1", $stock_diff, $variant->id);
		// 	$this->db->query($query);
		// }



		$query = $this->db->placehold("INSERT INTO __purchases SET ?%", $purchase);

		$this->db->query($query);
		$purchase_id = $this->db->insert_id();
		
		$this->update_total_price($order->id);		
		return $purchase_id;
	}

	public function delete_purchase($id)
	{
		$purchase = $this->get_purchase($id);
		if(!$purchase)
			return false;
			
		$order = $this->get_order(intval($purchase->order_id));
		if(!$order)
			return false;

		// Если заказ закрыт, нужно обновить склад при изменении покупки
		if($order->closed && !empty($purchase->amount))
		{
			$stock_diff = $purchase->amount;
			$query = $this->db->placehold("UPDATE __variants SET stock=stock+? WHERE id=? AND stock IS NOT NULL LIMIT 1", $stock_diff, $purchase->variant_id);
			$this->db->query($query);
		}
		
		$query = $this->db->placehold("DELETE FROM __purchases WHERE id=? LIMIT 1", intval($id));
		$this->db->query($query);
		$this->update_total_price($order->id);				
		return true;
	}

	
	public function close($order_id)
	{
		$order = $this->get_order(intval($order_id));
		if(empty($order))
			return false;
		
		if(!$order->closed)
		{
			$variants_amounts = array();
			$purchases = $this->get_purchases(array('order_id'=>$order->id));
			foreach($purchases as $purchase)
			{
				if(isset($variants_amounts[$purchase->variant_id]))
					$variants_amounts[$purchase->variant_id] += $purchase->amount;
				else
					$variants_amounts[$purchase->variant_id] = $purchase->amount;
			}

			foreach($variants_amounts as $id=>$amount)
			{
				$variant = $this->variants->get_variant($id);
				if(empty($variant) || ($variant->stock<$amount))
					return false;
			}
			foreach($purchases as $purchase)
			{	
				$variant = $this->variants->get_variant($purchase->variant_id);
				if(!$variant->infinity)
				{
					$new_stock = $variant->stock-$purchase->amount;
					$this->variants->update_variant($variant->id, array('stock'=>$new_stock));
				}
			}				
			$query = $this->db->placehold("UPDATE __orders SET closed=1, modified=NOW() WHERE id=? LIMIT 1", $order->id);
			$this->db->query($query);
		}
		return $order->id;
	}

	public function open($order_id)
	{
		$order = $this->get_order(intval($order_id));
		if(empty($order))
			return false;
		
		if($order->closed)
		{
			$purchases = $this->get_purchases(array('order_id'=>$order->id));
			foreach($purchases as $purchase)
			{
				$variant = $this->variants->get_variant($purchase->variant_id);				
				if($variant && !$variant->infinity)
				{
					$new_stock = $variant->stock+$purchase->amount;
					$this->variants->update_variant($variant->id, array('stock'=>$new_stock));
				}
			}				
			$query = $this->db->placehold("UPDATE __orders SET closed=0, modified=NOW() WHERE id=? LIMIT 1", $order->id);
			$this->db->query($query);
		}
		return $order->id;
	}
	
	public function pay($order_id)
	{
		$order = $this->get_order(intval($order_id));
		if(empty($order))
			return false;
		
		if(!$this->close($order->id))
		{
			return false;
		}
		$query = $this->db->placehold("UPDATE __orders SET payment_status=1, payment_date=NOW(), modified=NOW() WHERE id=? LIMIT 1", $order->id);
		$this->db->query($query);
		return $order->id;
	}
	
	private function update_total_price($order_id)
	{
		$order = $this->get_order(intval($order_id));
		if(empty($order))
			return false;
		
		$query = $this->db->placehold("UPDATE __orders o SET o.total_price=IFNULL((SELECT SUM(p.price*p.amount)*(100-o.discount)/100 FROM __purchases p WHERE p.order_id=o.id), 0)+o.delivery_price*(1-o.separate_delivery)-o.coupon_discount, modified=NOW() WHERE o.id=? LIMIT 1", $order->id);
		$this->db->query($query);
		return $order->id;
	}
	

	public function get_next_order($id, $status = null)
	{
		$f = '';
		if($status!==null)
			$f = $this->db->placehold('AND status=?', $status);
		$this->db->query("SELECT MIN(id) as id FROM __orders WHERE id>? $f LIMIT 1", $id);
		$next_id = $this->db->result('id');
		if($next_id)
			return $this->get_order(intval($next_id));
		else
			return false; 
	}
	
	public function get_prev_order($id, $status = null)
	{
		$f = '';
		if($status !== null)
			$f = $this->db->placehold('AND status=?', $status);
		$this->db->query("SELECT MAX(id) as id FROM __orders WHERE id<? $f LIMIT 1", $id);
		$prev_id = $this->db->result('id');
		if($prev_id)
			return $this->get_order(intval($prev_id));
		else
			return false; 
	}
}
