<?php

 
require_once('Backend.php');

class Houseleader extends Backend
{
	public function get_moveins($filter = array())
	{
		$id_filter = '';
		$type_filter = '';
		$hl_id_filter = '';
		$user_id_filter = '';
		$date_filter = '';
		$date_from_filter = '';
		$date_to_filter = '';
		$notify_id_filter = '';
		$house_id_filter = '';
		$status_filter = '';
		$booking_id_filter = '';

		$limit = '';
		$sql_limit = '';
		$page = 1;
		$order_by = '';

		if(isset($filter['limit']))
			$limit = max(1, intval($filter['limit']));

		if(isset($filter['page']))
			$page = max(1, intval($filter['page']));


		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND m.id in(?@)', (array)$filter['id']);


		/**
		 * type:
		 * 1 - move in,
		 * 3 - move out
		 **/
		if(!empty($filter['type']))
		{
			$type_filter = $this->db->placehold('AND m.type in(?@)', (array)$filter['type']);
			if((int)$filter['type'] == 1)
				$order_by = 'b.arrive DESC,';
			else
				$order_by = 'b.depart DESC,';

		}

		if(!empty($filter['hl_id']))
			$hl_id_filter = $this->db->placehold('AND m.hl_id=?', (int)$filter['hl_id']);

		if(!empty($filter['user_id']))
			$user_id_filter = $this->db->placehold('AND m.user_id in(?@)', (array)$filter['user_id']);

		if(!empty($filter['notify_id']))
			$notify_id_filter = $this->db->placehold('AND m.notify_id in(?@)', (array)$filter['notify_id']);

		if(isset($filter['date']))
		{
			if($filter['date'] == 'today')
				$date_filter = 'AND m.date>=CURDATE()';
			else
				$date_filter = $this->db->placehold('AND m.date>=?', $filter['date']);
		}

		if(isset($filter['date_from']))
		{
			$date_from_filter = $this->db->placehold('AND ((b.arrive>=? AND m.type = 1) OR (b.depart>=? AND m.type = 3))', $filter['date_from'], $filter['date_from']);
		}
		if(isset($filter['date_to']))
		{
			$date_to_filter = $this->db->placehold('AND ((b.arrive<=? AND m.type = 1) OR (b.depart<=? AND m.type = 3))', $filter['date_to'], $filter['date_to']);
		}

		if(!empty($filter['house_id']))
		{
			$house_id_filter = $this->db->placehold(' AND b.house_id in(?@)', (array)$filter['house_id']);
		}

		if(!empty($filter['booking_id']))
		{
			$booking_id_filter = $this->db->placehold(' AND m.booking_id in(?@)', (array)$filter['booking_id']);
		}

		/**
		 * status:
		 * 0 - new,
		 * 1 - done
		 **/

		if(!empty($filter['status']))
		{
			$status_filter = $this->db->placehold(' AND m.status = ?', (int)$filter['status']);
		}

		if(!empty($limit))
			$sql_limit = $this->db->placehold(' LIMIT ?, ? ', ($page-1)*$limit, $limit);

		$query = $this->db->placehold("SELECT 
							m.id, 
							m.type,
							m.hl_id,
							m.user_id,
							m.inputs,
							m.date,
							m.status,
							m.notify_id,
							m.booking_id,
							b.object_id,
							b.type as booking_type,
							b.arrive,
							b.depart
						FROM __move_ins AS m
						INNER JOIN __bookings b 
						ON b.id = m.booking_id
						$house_id_filter
						WHERE 1
							$id_filter 
							$type_filter
							$hl_id_filter
							$user_id_filter
							$notify_id_filter
							$date_filter
							$date_from_filter
							$date_to_filter
							$status_filter
							$booking_id_filter
						ORDER BY $order_by m.id DESC
						$sql_limit");

		$this->db->query($query);

		if(isset($filter['limit']) && $filter['limit'] == 1 && empty($filter['return_results']))
			return $this->db->result();
		else
			return $this->db->results();
	}


	public function count_moveins($filter = array())
	{
		$id_filter = '';
		$type_filter = '';
		$hl_id_filter = '';
		$user_id_filter = '';
		$notify_id_filter = '';
		$house_id_filter = '';
		$date_filter = '';


		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND m.id in(?@)', (array)$filter['id']);

		if(!empty($filter['type']))
			$type_filter = $this->db->placehold('AND m.type in(?@)', (array)$filter['type']);

		if(!empty($filter['hl_id']))
			$hl_id_filter = $this->db->placehold('AND m.hl_id=?', (int)$filter['hl_id']);

		if(!empty($filter['user_id']))
			$user_id_filter = $this->db->placehold('AND m.user_id=?', (int)$filter['user_id']);

		if(!empty($filter['notify_id']))
			$notify_id_filter = $this->db->placehold('AND m.notify_id in(?@)', (array)$filter['notify_id']);


		if(!empty($filter['house_id']))
		{
			$house_id_filter = $this->db->placehold('INNER JOIN __bookings b ON b.id = m.booking_id AND b.house_id in(?@)', (array)$filter['house_id']);
		}

		if(isset($filter['date']))
		{
			if($filter['date'] == 'today')
				$date_filter = 'AND m.date>=CURDATE()';
			else
				$date_filter = $this->db->placehold('AND m.date>=?', $filter['date']);
		}


		$query = $this->db->placehold("SELECT 
							COUNT(distinct m.id) as count
						FROM __move_ins AS m
						$house_id_filter
						WHERE 1
							$id_filter 
							$type_filter
							$hl_id_filter
							$user_id_filter
							$notify_id_filter
							$date_filter
						");

		if($this->db->query($query))
			return $this->db->result('count');
		else
			return false;
	}


	public function add_movein($value)
	{
		$value = (object)$value;
		$set_curr_date = '';
		if(empty($value->date))
			$set_curr_date = ', date=now()';

		$query = $this->db->placehold("INSERT INTO __move_ins SET ?%$set_curr_date", $value);
		$this->db->query($query);
		return $this->db->insert_id();
	}

	public function update_movein($id, $value)
	{
		$value = (object)$value;
		$set_curr_date = '';
		if(empty($value->date))
			$set_curr_date = ', date=now()';

		$query = $this->db->placehold("UPDATE __move_ins SET ?%$set_curr_date WHERE id in(?@) LIMIT ?", (array)$value, (array)$id, count((array)$id));
		$this->db->query($query);
		return $id;
	}

	public function delete_movein($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __move_ins WHERE id=? LIMIT 1", intval($id));
			$this->db->query($query);
		}
	}


}
