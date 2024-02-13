<?php

require_once('Backend.php');

class Companies extends Backend
{

	public function get_company($id)
	{
		$query = $this->db->placehold("SELECT 
				c.id, 
				c.group_id,
				c.landlord_id, 
				c.name, 
				c.address, 
				c.position 
			FROM __companies c 
			WHERE id=? 
			LIMIT 1", intval($id));

		if($this->db->query($query))
			return $this->db->result();
		else
			return false; 
	}
	
	public function get_companies($filter = array())
	{	
		// По умолчанию
		$limit = 0;
		$page = 1;
		$id_filter = '';
		$group_id_filter = '';
		$landlord_id_filter = '';
		$keyword_filter = '';

        if (!isset($filter['limit']) && !isset($filter['count'])) {
            $filter['limit'] = $filter['count'];
        }

		if (isset($filter['limit']))
			$limit = max(1, intval($filter['limit']));

		if(isset($filter['page']))
			$page = max(1, intval($filter['page']));

		if($limit)
			$sql_limit = $this->db->placehold(' LIMIT ?, ? ', ($page-1)*$limit, $limit);
		else
			$sql_limit = '';

		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND c.id in(?@)', (array)$filter['id']);

		if(!empty($filter['group_id']))
			$group_id_filter = $this->db->placehold('AND c.group_id in(?@)', (array)$filter['group_id']);

		if(!empty($filter['landlord_id']))
			$landlord_id_filter = $this->db->placehold('AND c.landlord_id in(?@)', (array)$filter['landlord_id']);

		if(!empty($filter['keyword']))
		{
			$keywords = explode(' ', $filter['keyword']);
			foreach($keywords as $keyword)
				$keyword_filter .= $this->db->placehold('AND c.name LIKE "%'.$this->db->escape(trim($keyword)).'%" OR c.address LIKE "%'.$this->db->escape(trim($keyword)).'%" ');
		}

			
		$sort='DESC';
		
		$query = $this->db->placehold("SELECT 
					c.id, 
					c.group_id,
					c.landlord_id, 
					c.name, 
					c.address, 
					c.position
				FROM __companies c 
				WHERE 1 
					$landlord_id_filter
					$id_filter 
					$group_id_filter
				ORDER BY id $sort $sql_limit");

		$this->db->query($query);

        if (isset($filter['count']) && $filter['count'] == 1) {
            return $this->db->result();
        }
		return $this->db->results();
	}
	
	public function count_companies($filter = array())
	{	
		$id_filter = '';
		$group_id_filter = '';
		$landlord_id_filter = '';
		$keyword_filter = '';

		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND c.id in(?@)', (array)$filter['id']);

		if(!empty($filter['group_id']))
			$group_id_filter = $this->db->placehold('AND c.group_id in(?@)', (array)$filter['group_id']);

		if(!empty($filter['landlord_id']))
			$landlord_id_filter = $this->db->placehold('AND c.landlord_id in(?@)', (array)$filter['landlord_id']);

		if(!empty($filter['keyword']))
		{
			$keywords = explode(' ', $filter['keyword']);
			foreach($keywords as $keyword)
				$keyword_filter .= $this->db->placehold('AND c.name LIKE "%'.$this->db->escape(trim($keyword)).'%" OR c.address LIKE "%'.$this->db->escape(trim($keyword)).'%" ');
		}

		$query = $this->db->placehold("SELECT 
					count(distinct c.id) as count
				FROM __companies c 
				WHERE 1 
					$id_filter 
					$group_id_filter 
					$landlord_id_filter 
					$keyword_filter");
	
		$this->db->query($query);	
		return $this->db->result('count');

	}
	
	public function add_company($company)
	{	
		$query = $this->db->placehold('INSERT INTO __companies
		SET ?%', $company);

		if(!$this->db->query($query))
			return false;

		$id = $this->db->insert_id();
		return $id;
	}
	
	public function update_company($id, $company)
	{
		$query = $this->db->placehold("UPDATE __companies SET ?% WHERE id in(?@) LIMIT 1", $company, (array)$id);
		$this->db->query($query);
		return $id;
	}

	public function delete_company($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __companies WHERE id=? LIMIT 1", intval($id));
			$this->db->query($query);
		}
	}	

	public function get_company_houses($filter = array())
	{
		$company_id_filter = '';
		$house_id_filter = '';

//		if (empty($filter['company_id']) && empty($filter['house_id']) && empty($filter['company_not_id']))
//			return array();

		if(!empty($filter['company_id']))
			$company_id_filter = $this->db->placehold('AND ch.company_id in(?@)', (array)$filter['company_id']);
		elseif(!empty($filter['company_not_id']))
			$company_id_filter = $this->db->placehold('AND ch.company_id NOT in(?@)', (array)$filter['company_not_id']);

		if(!empty($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND ch.house_id in(?@)', (array)$filter['house_id']);
				
		$query = $this->db->placehold("SELECT 
						ch.company_id, 
						ch.house_id 
					FROM __companies_houses ch
					WHERE 
						1
						$company_id_filter
						$house_id_filter       
					");
		
		$this->db->query($query);
		return $this->db->results();
	}
	
	public function add_company_houses($company_id, $house_id, $position=0)
	{
		$query = $this->db->placehold("INSERT IGNORE INTO __companies_houses SET company_id=?, house_id=?", $company_id, $house_id);
		$this->db->query($query);
		return $house_id;
	}
	
	public function delete_company_houses($company_id, $house_id)
	{
		$query = $this->db->placehold("DELETE FROM __companies_houses WHERE company_id=? AND house_id=? LIMIT 1", intval($company_id), intval($house_id));
		$this->db->query($query);
	}






	// GROUPS

	public function get_companies_groups($filter = array())
	{	
		// По умолчанию
		$limit = 0;
		$page = 1;
		$id_filter = '';
		$sort='cg.name';

		if(isset($filter['limit']))
			$limit = max(1, intval($filter['limit']));

		if(isset($filter['page']))
			$page = max(1, intval($filter['page']));

		if($limit)
			$sql_limit = $this->db->placehold(' LIMIT ?, ? ', ($page-1)*$limit, $limit);
		else
			$sql_limit = '';

		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND cg.id in(?@)', (array)$filter['id']);

		
		$query = $this->db->placehold("SELECT 
					cg.id, 
					cg.name,
					cg.description
				FROM __companies_groups cg
				WHERE 1 
					$id_filter 
				ORDER BY $sort $sql_limit");
		$this->db->query($query);

		if(isset($filter['count']) && $filter['count'] == 1)
			return $this->db->result();

		return $this->db->results();
	}
	
	public function count_companies_groups($filter = array())
	{	
		$id_filter = '';

		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND cg.id in(?@)', (array)$filter['id']);

		$query = $this->db->placehold("SELECT 
					count(distinct cg.id) as count
				FROM __companies_groups cg
				WHERE 1 
					$id_filter");
	
		$this->db->query($query);	
		return $this->db->result('count');

	}
	
	public function add_companies_group($group)
	{	
		if(isset($group->id))
			unset($group->id);
		$query = $this->db->placehold('INSERT INTO __companies_groups SET ?%', $group);

		if(!$this->db->query($query))
			return false;

		$id = $this->db->insert_id();
		return $id;
	}
	
	public function update_companies_group($id, $group)
	{
		$query = $this->db->placehold("UPDATE __companies_groups SET ?% WHERE id in(?@) LIMIT 1", $group, (array)$id);
		$this->db->query($query);
		return $id;
	}

	public function delete_companies_group($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __companies_groups WHERE id=? LIMIT 1", intval($id));
			$this->db->query($query);
		}
	}


}
