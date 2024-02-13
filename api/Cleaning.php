<?php

require_once('Backend.php');

class Cleaning extends Backend
{
	

public function get_cleaning_days($house_id = array())
{
	if(empty($house_id))
		return array();

	$house_id_filter = $this->db->placehold('AND house_id in(?@)', (array)$house_id);
			
	$query = $this->db->placehold("SELECT house_id, type, day
				FROM __houses_cleaning_days
				WHERE 
				1
				$house_id_filter   
				ORDER BY house_id       
				");
	
	$this->db->query($query);
	return $this->db->results();
}

// Функция возвращает день уборки
public function add_cleaning_day($house_id, $day, $type)
{
	$query = $this->db->placehold("INSERT IGNORE INTO __houses_cleaning_days SET house_id=?, day=?, type=?", $house_id, $day, $type);
	$this->db->query($query);
	return $day;
}

// Удаление дня уборки
public function delete_cleaning_day($house_id, $day, $type)
{
	$query = $this->db->placehold("DELETE FROM __houses_cleaning_days WHERE house_id=? AND day=? AND $type=? LIMIT 1", intval($house_id), intval($day), intval($type));
	$this->db->query($query);
}


// Журнал уборок
public function get_cleanings($filter = array())
{
	$id_filter = '';
	$order_id_filter = '';
	$house_id_filter = '';
	$house_ids_filter = '';
	$house_id_select = '';
	$user_id_filter = '';
	$status_filter = '';

	$cleaner_id_filter = '';
	$date_from_filter = '';
    $date_to_filter = '';

	$limit = 300;

	$order_by = 'c.desired_date DESC';
	if(isset($filter['id']))
		$id_filter = $this->db->placehold('AND  c.id in(?@)', intval($filter['id']));
	if(isset($filter['order_id']))
		$order_id_filter = $this->db->placehold('AND c.order_id in(?@)', intval($filter['order_id']));

	$house_id_select = $this->db->placehold('LEFT JOIN __orders AS o ON o.id=c.order_id LEFT JOIN  __orders_users ou ON ou.order_id = o.id LEFT JOIN __users AS u ON u.id=ou.user_id');

	if(isset($filter['house_id']) || isset($filter['house_ids']))
	{

		if(isset($filter['house_id']))
		$house_id_filter = $this->db->placehold('AND c.house_id = ?', $filter['house_id']);
		if(isset($filter['house_ids']))
		$house_ids_filter = $this->db->placehold('AND c.house_id in(?@)', $filter['house_ids']);
	}

	if(isset($filter['user_id']))
		$user_id_filter = $this->db->placehold('AND u.id in (?@)', (array)$filter['user_id']);
	if(isset($filter['cleaner_id']))
		$cleaner_id_filter = $this->db->placehold('AND c.cleaner_id in(?@)', intval($filter['cleaner_id']));
	if(isset($filter['date_from']))
		$date_from_filter = $this->db->placehold('AND c.desired_date>=?', $filter['date_from']);
    if(isset($filter['date_to']))
        $date_from_filter .= $this->db->placehold('AND c.desired_date<=?', $filter['date_to']);

	if(isset($filter['status']))
	{
		$status_filter = $this->db->placehold('AND c.status=?', $filter['status']);
		$order_by = 'c.desired_date';
	}

			
	$query = $this->db->placehold("SELECT 
					c.id,
					c.type,
					c.order_id,
					c.house_id,
					c.bed,
					c.date_from,
				
					c.desired_date,
					c.completion_date,
					c.status,
					c.cleaner_id,
					c.note,
					c.images,
					c.images1,
					c.images2,
					c.images3,
					u.name,
					u.id as user_id,
					o.total_price,
					o.address,
					o.paid
				FROM __cleaning_journal c
				$house_id_select
				WHERE 
				1
				$order_id_filter   
				$house_id_filter 
				$house_ids_filter 
				$user_id_filter
				$cleaner_id_filter
				$date_from_filter
				$status_filter
				GROUP BY c.id 
				ORDER BY $order_by
				LIMIT $limit     
				");

	$this->db->query($query);


	return $this->db->results();
}
public function get_cleaning($id)
{
	$query = $this->db->placehold("SELECT 
					c.id,
					c.order_id,
					c.images,
					c.images1,
					c.images2,
					c.images3
				FROM __cleaning_journal c
				WHERE id=? LIMIT 1    
				", intval($id));

	$this->db->query($query);
	return $this->db->result();
}

public function update_cleaning($id, $cleaning)
{
	$cleaning = (array)$cleaning;

	$query = $this->db->placehold("UPDATE __cleaning_journal SET ?% WHERE id=? LIMIT 1", $cleaning, intval($id));
	$this->db->query($query);
	return $id;
}

public function delete_cleaning($id)
{
	if(!empty($id))
	{
		$delete_cleaning = $this->cleaning->get_cleaning($id);
		$delete_cleaning->images = unserialize($delete_cleaning->images);

		if(!empty($delete_cleaning->images))
		{
			foreach ($delete_cleaning->images as $filename) {
				@unlink($this->config->root_dir.$this->config->cleaning_images_dir.$filename);
			}
		}

		$delete_cleaning->images1 = unserialize($delete_cleaning->images1);

		if(!empty($delete_cleaning->images1))
		{
			foreach ($delete_cleaning->images1 as $filename) {
				@unlink($this->config->root_dir.$this->config->cleaning_images_dir.$filename);
			}
		}

		$delete_cleaning->images2 = unserialize($delete_cleaning->images2);

		if(!empty($delete_cleaning->images2))
		{
			foreach ($delete_cleaning->images2 as $filename) {
				@unlink($this->config->root_dir.$this->config->cleaning_images_dir.$filename);
			}
		}

		$delete_cleaning->images3 = unserialize($delete_cleaning->images3);

		if(!empty($delete_cleaning->images3))
		{
			foreach ($delete_cleaning->images3 as $filename) {
				@unlink($this->config->root_dir.$this->config->cleaning_images_dir.$filename);
			}
		}

		if($delete_cleaning->order_id != 0)
			$this->orders->delete_order((int)$delete_cleaning->order_id);

		$query = $this->db->placehold("DELETE FROM __cleaning_journal WHERE id=? LIMIT 1", $id);
		$this->db->query($query);
	}
}

public function add_cleaning($cleaning)
{
	$cleaning = (object)$cleaning;
	
	$query = $this->db->placehold("INSERT INTO __cleaning_journal SET ?%", $cleaning);
	$this->db->query($query);
	$id = $this->db->insert_id();		
	return $id;
}



}