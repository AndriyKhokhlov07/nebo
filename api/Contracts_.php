<?php

require_once('Backend.php');



//  CONTRACTS

class Contracts extends Backend
{

	// Statuses:
	// 1 - Active
	// 9 - Canceled
	public function get_contracts($filter = array())
	{
		$limit = 100;
		$page = 1;		
		$user_id_filter = '';
		$reserv_id_filter = '';
		$user_filter = '';
		$house_id_filter = '';
		$status_filter = '';
		$group_by = '';

		if(!empty($filter['group_by']))
		{
			if($filter['group_by'] == 'user_id')
				$group_by = 'GROUP BY c.user_id';
		}
		
		if(!empty($filter['user_id']))
			$user_id_filter = $this->db->placehold('AND c.user_id in(?@)', (array)$filter['user_id']);

		if(!empty($filter['reserv_id']))
			$reserv_id_filter = $this->db->placehold('AND c.reserv_id in(?@)', (array)$filter['reserv_id']);
		elseif(!empty($filter['empty_reserv_id']))
			$reserv_id_filter = $this->db->placehold('AND (c.reserv_id=0 OR c.reserv_id IS NULL)');

		if(!empty($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND c.house_id in(?@)', (array)$filter['house_id']);

		if(!empty($filter['status']))
			$status_filter = $this->db->placehold('AND c.status in(?@)', (array)$filter['status']);

		if(isset($filter['limit']))
			$limit = max(1, intval($filter['limit']));

		if(isset($filter['page']))
			$page = max(1, intval($filter['page']));

		$sql_limit = $this->db->placehold(' LIMIT ?, ? ', ($page-1)*$limit, $limit);


		if(!empty($filter['keyword']))
		{
			$keywords = explode(' ', $filter['keyword']);
			foreach($keywords as $keyword)
			{
				$user_filter .= $this->db->placehold('AND c.user_id in (SELECT u.id FROM __users AS u WHERE u.name LIKE "%'.$this->db->escape(trim($keyword)).'%" OR REPLACE(u.phone, "-", "")  LIKE "%'.$this->db->escape(str_replace('-', '', trim($keyword))).'%" OR u.email LIKE "%'.$this->db->escape(trim($keyword)).'%" ) ');
			}
		}

		
		$query = $this->db->placehold("SELECT 
						c.id, 
						c.url,
						c.type,
						c.user_id,
						c.reserv_id,
						c.house_id,
						c.rental_name,
						c.rental_address,
						c.date_from,
						c.date_to,
						c.price_month,
						c.total_price,
						c.price_deposit,
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
						c.sellflow,
						c.status
					FROM __contracts AS c
					WHERE 1
						$user_id_filter
						$user_filter
						$reserv_id_filter
						$house_id_filter
						$status_filter
					ORDER BY c.id DESC
					$group_by
					$sql_limit");
		$this->db->query($query);	
		return $this->db->results();
	}

	public function count_contracts($filter = array())
	{
		$user_id_filter = '';
		$user_filter = '';
		$reserv_id_filter = '';
		$house_id_filter = '';
		$status_filter = '';

		
		if(!empty($filter['user_id']))
			$user_id_filter = $this->db->placehold('AND c.user_id in(?@)', (array)$filter['user_id']);

		if(!empty($filter['reserv_id']))
			$reserv_id_filter = $this->db->placehold('AND c.reserv_id in(?@)', (array)$filter['reserv_id']);

		if(!empty($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND c.house_id in(?@)', (array)$filter['house_id']);

		if(!empty($filter['status']))
			$status_filter = $this->db->placehold('AND c.status in(?@)', (array)$filter['status']);

		if(!empty($filter['keyword']))
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
				WHERE 1
					$user_id_filter
					$user_filter
					$reserv_id_filter
					$house_id_filter
					$status_filter";
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
						c.type,
						c.user_id,
						c.reserv_id,
						c.house_id,
						c.rental_name,
						c.rental_address,
						c.date_from,
						c.date_to,
						c.price_month,
						c.total_price,
						c.price_deposit,
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
						c.sellflow,
						c.status
					FROM __contracts c
						$where
					LIMIT 1", $id);
		
		$this->db->query($query);
		return $this->db->result();
	}
	
	public function update_contract($id, $contract)
	{
		$contract = (array)$contract;
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
			if($contract['status'] == 9)
			{
				$contract = $this->get_contract(intval($id));

				if(!empty($contract))
				{
					// Cancel Reserv
					if(!empty($contract->reserv_id))
						$this->beds->cancel_bed_journal(array('id'=>$contract->reserv_id));

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

		$query = $this->db->placehold("INSERT INTO __contracts SET ?% $date_created_query", $contract);
		$this->db->query($query);
		return $this->db->insert_id();
	}

	public function delete_contract($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __contracts WHERE id = ? LIMIT 1", intval($id));
			$this->db->query($query);
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


		// Month count
		$d1 = date_create($date_from);
		$d2 = date_create($date_to);
		
		$main_date = $d1->format('j');

		$interval = date_diff($d1, $d2);

		$result->days = $interval->days;

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
				date_add($date_for_payment, date_interval_create_from_date_string('- 10 days'));
				$invoice->date_for_payment = $date_for_payment->format('Y-m-d');

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
			date_add($date_for_payment, date_interval_create_from_date_string('-10 days'));
			$invoice->date_for_payment = $date_for_payment->format('Y-m-d');

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
				if((date("m",strtotime($date_end->format('Y-m-d'))) == date("m",strtotime($invoice->date_to)) && (($interval->d+1 < 30 && date("m",strtotime($invoice->date_to)) != '02') || ($interval->d < 29  && date("m",strtotime($invoice->date_to)) != '02')) || $interval->d+1 < 28 || $interval->d < 27 || $interval->d == 0))
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

		$result->days ++;

		return $result;
	}



	
}