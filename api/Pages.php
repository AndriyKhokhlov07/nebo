<?php


require_once('Backend.php');

class Pages extends Backend
{
    public const HOUSES_MENU_ID = 5;
	
	public $all_pages;

	/*
	*
	* Функция возвращает массив страниц, удовлетворяющих фильтру
	* @param $filter
	*
	*/

	public $house_types = array(
		0 => 'Coliving',
		1 => 'Hotel',
        2 => 'Brokerage',
        3 => 'Space / Parking'
	);

	public function get_pages($filter = array())
	{
		$limit = 1000;
		$page_id_filter = '';	
		$page_sku_filter = '';
		$menu_filter = '';
		$parent_id_filter = '';
		$parent2_id_filter = '';
        $parent3_id_filter = '';
		$not_parent_id_filter = '';
		$old_url_filter = '';
		$keyword_filter = '';
		$visible_filter = '';
        $order_by = 'ORDER BY position';
		$pages = array();

		if(isset($filter['limit']))
			$limit = max(1, intval($filter['limit']));
		
		if(!empty($filter['id']))
			$page_id_filter = $this->db->placehold('AND id in(?@)', (array)$filter['id']);

		if(!empty($filter['sku']))
			$page_sku_filter = $this->db->placehold('AND sku = ?', (int)$filter['sku']);

		if(isset($filter['menu_id']))
			$menu_filter = $this->db->placehold('AND menu_id in (?@)', (array)$filter['menu_id']);
			
		if(isset($filter['parent_id']))
			$parent_id_filter = $this->db->placehold('AND parent_id in (?@)', (array)$filter['parent_id']);

		if(isset($filter['parent2_id']))
		{
			if(isset($filter['parent_id']) && in_array(0, $filter['parent_id']))
				$parent2_id_filter = $this->db->placehold('AND (parent2_id in (?@) OR parent_id=0)', (array)$filter['parent2_id']);
			else
				$parent2_id_filter = $this->db->placehold('AND parent2_id in (?@)', (array)$filter['parent2_id']);
		}

        if (isset($filter['parent3_id'])) {
            $parent3_id_filter = $this->db->placehold('AND parent3_id in (?@)', (array)$filter['parent3_id']);
        }

		if(isset($filter['not_parent_id']))
			$not_parent_id_filter = $this->db->placehold('AND parent_id!=?', (int)$filter['not_parent_id']);

		if(!empty($filter['old_url']))
			$old_url_filter = $this->db->placehold('AND old_url!=""');	

		if(isset($filter['visible']))
			$visible_filter = $this->db->placehold('AND visible = ?', intval($filter['visible']));


		if(!empty($filter['keyword']))
		{
			$keywords = explode(' ', $filter['keyword']);
			foreach($keywords as $k)
			{
				$kw = $this->db->escape(trim($k));
				if($kw!=='')
				{
					if(!empty($keyword_filter))
						$keyword_filter .= 'AND ';
					else
						$keyword_filter .= 'AND(';
					$keyword_filter .= $this->db->placehold("name LIKE '%$kw%' ");

				}
			}
			$keyword_filter .= ')';
		}


        if(isset($filter['order_by'])) {
            $order_by = $this->db->placehold('ORDER BY ?', $filter['order_by']);
        }

				
		$query = "SELECT 
					id, 
					sku,
					parent_id,
					parent2_id,
					parent3_id,
					url, 
					old_url,
					header, 
					name, 
					meta_title, 
					meta_description, 
					meta_keywords, 
					annotation, 
					bg_text,
					body, 
					menu_id, 
					service_ids,
					image, 
					bg_image,
					icon,
					position, 
					visible,
					rating,
					votes,
					move_in,
					blocks,
					blocks2,
					blocks3,
					related,
					last_invoice,
					last_contract,
					type
		          FROM __pages 
				  WHERE 1 
				  	$page_id_filter
				  	$page_sku_filter
				  	$menu_filter 
					$parent_id_filter
					$parent2_id_filter
                    $parent3_id_filter
					$not_parent_id_filter 
					$old_url_filter
					$keyword_filter
					$visible_filter 
				  $order_by
				  LIMIT $limit";

		$this->db->query($query);

		
		foreach($this->db->results() as $page)
			$pages[$page->id] = $page;
		
		if(
            empty($filter['id'])
            && empty($filter['sku'])
            && (
                !isset($filter['not_parent_id'])
                || $filter['not_parent_id']!==0
            )
            && empty($filter['old_url'])
            && empty($filter['not_tree'])
        )
			$this->categories_tree->get_categories_tree('pages', $pages);
			
		return $pages;
	}
	
	public function get_pages_tree()
	{
		if(!isset($this->categories_tree->categories_tree['pages']))
			$this->get_pages();

		return $this->categories_tree->categories_tree['pages'];
	}
	
	

	/*
	*
	* Функция возвращает страницу по ее id или url (в зависимости от типа)
	* @param $id id или url страницы
	*
	*/
	public function get_page($id)
	{
		if(gettype($id) == 'string')
			$where = $this->db->placehold(' WHERE url=? ', $id);
		else
			$where = $this->db->placehold(' WHERE id=? ', intval($id));
		
		$query = "SELECT id, sku, parent_id, parent2_id, parent3_id, url, old_url, header, name, meta_title, meta_description, meta_keywords, annotation, bg_text, body, menu_id, service_ids, image, bg_image, icon, position, visible, rating, votes, move_in, blocks, blocks2, blocks3, related, last_invoice, last_contract, type
		          FROM __pages $where LIMIT 1";

		$this->db->query($query);
		return $this->db->result();
	}

	public function get_page_init($id){
		if(empty($this->all_pages))
			$this->get_pages();
		if(is_int($id) && array_key_exists(intval($id), $this->all_pages))
			return $page = $this->all_pages[intval($id)];
		elseif(is_string($id) || $id==''){
			foreach ($this->all_pages as $p){
				if ($p->url == $id)
					return $this->get_page_init((int)$p->id);
			}
		}
		return false;
	}

	/*
	*
	* Создание страницы
	*
	*/	
	public function add_page($page)
	{	
		$query = $this->db->placehold('INSERT INTO __pages SET ?%', $page);
		//echo $query; exit;
		if(!$this->db->query($query))
			return false;

		$id = $this->db->insert_id();
		$this->db->query("UPDATE __pages SET position=id WHERE id=?", $id);	
		return $id;
	}
	
	/*
	*
	* Обновить страницу
	*
	*/
	public function update_page($id, $page)
	{	
		$query = $this->db->placehold('UPDATE __pages SET ?% WHERE id in (?@)', $page, (array)$id);
		if(!$this->db->query($query))
			return false;
		return $id;
	}
	
	/*
	*
	* Удалить страницу
	*
	*/	
	public function delete_page($id)
	{
		if(!empty($id))
		{

			$blocks_images = array();

			$page = $this->pages->get_page(intval($id));
			if(!empty($page))
			{
				$page_blocks = unserialize($page->blocks);
				if(!empty($page_blocks))
				{
					foreach ($page_blocks as $pb) 
					{
						if(!empty($pb->images))
						{
							foreach ($pb->images as $img_name) 
							{
								$blocks_images[] = $img_name;
							}								
						}
					}
				}

				// Delete chains (for houses)
				if($page->menu_id == 5)
					$this->inventories->delete_items_chains(array('parent_id'=>$page->id, 'type'=>'house'));

			}
			if(!empty($blocks_images))
			{
				foreach($blocks_images as $i)
				{
					$file = pathinfo($i, PATHINFO_FILENAME);
					$ext = pathinfo($i, PATHINFO_EXTENSION);
					
					// Удалить все ресайзы
					$rezised_images = glob($this->config->root_dir.$this->resized_galleries_images_dir.$file.".*x*.".$ext);
					if(is_array($rezised_images))
					{
						foreach (glob($this->config->root_dir.$this->config->resized_galleries_images_dir.$file.".*x*.".$ext) as $f)
							@unlink($f);
					}
					@unlink($this->config->root_dir.$this->config->galleries_images_dir.$i);	
				}
			}

			$this->delete_image($id);

			// Del Houses of HouseLeader
    		$query = $this->db->placehold('DELETE FROM __houseleaders_houses WHERE house_id=?', intval($id));
    		$this->db->query($query);


			$query = $this->db->placehold("DELETE FROM __pages WHERE id=? LIMIT 1", intval($id));
			if($this->db->query($query))
				return true;
		}
		return false;
	}	
	
	/*
	*
	* Функция возвращает массив меню
	*
	*/
	public function get_menus()
	{
		$menus = array();
		$query = "SELECT * FROM __menu ORDER BY position";
		$this->db->query($query);
		foreach($this->db->results() as $menu)
			$menus[$menu->id] = $menu;
		return $menus;
	}
	
	/*
	*
	* Функция возвращает меню по id
	* @param $id
	*
	*/
	public function get_menu($menu_id)
	{	
		$query = $this->db->placehold("SELECT * FROM __menu WHERE id=? LIMIT 1", intval($menu_id));
		$this->db->query($query);
		return $this->db->result();
	}
	
	// Удалить изображение
	public function delete_image($pages_ids){
		$pages_ids = (array) $pages_ids;
		$query = $this->db->placehold("SELECT image FROM __pages WHERE id in(?@)", $pages_ids);
		$this->db->query($query);
		$filenames = $this->db->results('image');
		if(!empty($filenames)){
			$query = $this->db->placehold("UPDATE __pages SET image=NULL WHERE id in(?@)", $pages_ids);
			$this->db->query($query);
			foreach($filenames as $filename){
				$query = $this->db->placehold("SELECT count(*) as count FROM __pages WHERE image=?", $filename);
				$this->db->query($query);
				$count = $this->db->result('count');
				if($count == 0){
					$file = pathinfo($filename, PATHINFO_FILENAME);
					$ext = pathinfo($filename, PATHINFO_EXTENSION);
			
					// Удалить все ресайзы
					$rezised_images = glob($this->config->root_dir.$this->config->resized_pages_images_dir.$file."*.".$ext);
					if(is_array($rezised_images))
						foreach (glob($this->config->root_dir.$this->config->resized_pages_images_dir.$file."*.".$ext) as $f)
							@unlink($f);

					@unlink($this->config->root_dir.$this->config->pages_images_dir.$filename);	
				}
			}	
		}
	}
	// Удалить изображение бекграунда
	public function delete_bg_image($pages_ids){
		$pages_ids = (array) $pages_ids;
		$query = $this->db->placehold("SELECT bg_image FROM __pages WHERE id in(?@)", $pages_ids);
		$this->db->query($query);
		$filenames = $this->db->results('bg_image');
		if(!empty($filenames)){
			$query = $this->db->placehold("UPDATE __pages SET bg_image=NULL WHERE id in(?@)", $pages_ids);
			$this->db->query($query);
			foreach($filenames as $filename){
				$query = $this->db->placehold("SELECT count(*) as count FROM __pages WHERE bg_image=?", $filename);
				$this->db->query($query);
				$count = $this->db->result('count');
				if($count == 0){
					@unlink($this->config->root_dir.$this->config->pages_bg_images_dir.$filename);	
				}
			}	
		}
	}

	public static function getHouses($notTree = 1, $visible = 1)
    {
        return self::backendApp()->pages->get_pages([
			'menu_id' => self::HOUSES_MENU_ID, 
			'not_tree' => $notTree,
			'visible' => $visible
		]);
    }


    public $activeCitiesIds = [
        253, // New York
        348, // Philadelphia
    ];
    public function getCities($visible = 1) {
        return $this->get_pages([
            'id' => $this->activeCitiesIds,
            'visible' => $visible,
            'limit' => 2
        ]);
    }
}
