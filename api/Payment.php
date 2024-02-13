<?php


require_once('Backend.php');

class Payment extends Backend
{
	public function get_payment_methods($filter = array())
	{	
		$id_filter = '';
		if(!empty($filter['id']))
		{
			$id_filter = $this->db->placehold('AND pm.id in(?@)', (array)$filter['id']);
		}

        $for_all_houses_filter = '';
        if(!empty($filter['id']) && !empty($filter['for_all_houses'])) {
            $id_filter = $this->db->placehold('AND (pm.id in(?@) OR pm.for_all_houses = 1)', (array)$filter['id']);
        }
        elseif(!empty($filter['for_all_houses'])) {
            $for_all_houses_filter = $this->db->placehold('AND pm.for_all_houses = 1');
        }

		$delivery_filter = '';
		if(!empty($filter['delivery_id'])) {
            $delivery_filter = $this->db->placehold('AND pm.id in (SELECT payment_method_id FROM __delivery_payment dp WHERE dp.delivery_id=?)', intval($filter['delivery_id']));
        }

		$enabled_filter = '';
 		if(!empty($filter['enabled'])) {
            $enabled_filter = $this->db->placehold('AND pm.enabled=?', intval($filter['enabled']));
        }

        $module_filter = '';
 		if(!empty($filter['module'])) {
            $module_filter = $this->db->placehold('AND pm.module=?', $filter['module']);
        }

		$without_houses_filter = '';
		$without_houses_select = '';
		if(!empty($filter['without_houses'])) {
			$without_houses_select = 'LEFT JOIN __payment_methods_houses AS pmh ON pm.id=pmh.payment_method_id';
			$without_houses_filter = $this->db->placehold('AND pmh.payment_method_id IS NULL');
		}


		$query = "SELECT pm.id,
						 pm.module, 
						 pm.name, 
						 pm.description, 
						 pm.currency_id, 
						 pm.settings, 
						 pm.enabled, 
                         pm.for_all_houses,
						 pm.position
					FROM __payment_methods AS pm 
						$without_houses_select
					WHERE 1 
						$id_filter 
						$delivery_filter 
						$module_filter
						$enabled_filter 
						$without_houses_filter
                        $for_all_houses_filter
					ORDER BY position";
	
		$this->db->query($query);
		return $this->db->results();
	}
	
	function get_payment_method($id)
	{
		$query = $this->db->placehold("SELECT * FROM __payment_methods WHERE id=? LIMIT 1", intval($id));
		$this->db->query($query);
		$payment_method = $this->db->result();
  		return $payment_method;
	}
	
	function get_payment_settings($method_id)
	{
		$query = $this->db->placehold("SELECT settings FROM __payment_methods WHERE id=? LIMIT 1", intval($method_id));
		$this->db->query($query);
		$settings = $this->db->result('settings');
 
		$settings = unserialize($settings);
		return $settings;
	}
	
	function get_payment_modules()
	{
		$modules_dir = $this->config->root_dir.'payment/';
		
		$modules = array();
		$handler = opendir($modules_dir);		
		while ($dir = readdir($handler))
		{
			$dir = preg_replace("/[^A-Za-z0-9]+/", "", $dir);
			if (!empty($dir) && $dir != "." && $dir != ".." && is_dir($modules_dir.$dir))
			{
				
				if(is_readable($modules_dir.$dir.'/settings.xml') && $xml = simplexml_load_file($modules_dir.$dir.'/settings.xml'))
				{
					$module = new stdClass;
					
					$module->name = (string)$xml->name;
					$module->settings = array();
	
					foreach($xml->settings as $setting)
					{
						$module->settings[(string)$setting->variable] = new stdClass;
						$module->settings[(string)$setting->variable]->name = (string)$setting->name;
						$module->settings[(string)$setting->variable]->variable = (string)$setting->variable;
					 	$module->settings[(string)$setting->variable]->variable_options = array();
					 	foreach($setting->options as $option)
					 	{
					 		$module->settings[(string)$setting->variable]->options[(string)$option->value] = new stdClass;
					 		$module->settings[(string)$setting->variable]->options[(string)$option->value]->name = (string)$option->name;
					 		$module->settings[(string)$setting->variable]->options[(string)$option->value]->value = (string)$option->value;
					 	}
					}
					$modules[$dir] = $module;
				}

			}
		}
    	closedir($handler);
    	return $modules;

	}
	
	public function get_payment_deliveries($id)
	{
		$query = $this->db->placehold("SELECT delivery_id FROM __delivery_payment WHERE payment_method_id=?", intval($id));
		$this->db->query($query);
		return $this->db->results('delivery_id');
	}		
	
	public function update_payment_method($id, $payment_method)
	{
		$query = $this->db->placehold("UPDATE __payment_methods SET ?% WHERE id in(?@)", $payment_method, (array)$id);
		$this->db->query($query);
		return $id;
	}
	
	public function update_payment_settings($method_id, $settings)
	{
		if(!is_string($settings))
		{
			$settings = serialize($settings);
		}
		$query = $this->db->placehold("UPDATE __payment_methods SET settings=? WHERE id in(?@) LIMIT 1", $settings, (array)$method_id);
		$this->db->query($query);
		return $method_id;
	}
	
	public function update_payment_deliveries($id, $deliveries_ids)
	{
		$query = $this->db->placehold("DELETE FROM __delivery_payment WHERE payment_method_id=?", intval($id));
		$this->db->query($query);
		if(is_array($deliveries_ids))
		foreach($deliveries_ids as $d_id)
			$this->db->query("INSERT INTO __delivery_payment SET payment_method_id=?, delivery_id=?", $id, $d_id);
	}		
	
	public function add_payment_method($payment_method)
	{	
		$query = $this->db->placehold('INSERT INTO __payment_methods
		SET ?%',
		$payment_method);

		if(!$this->db->query($query))
			return false;

		$id = $this->db->insert_id();
		$this->db->query("UPDATE __payment_methods SET position=id WHERE id=?", $id);	
		return $id;
	}

	public function delete_payment_method($id)
	{
		// Удаляем связь метода оплаты с достаками
		$query = $this->db->placehold("DELETE FROM __delivery_payment WHERE payment_method_id=?", intval($id));
		$this->db->query($query);
		$query = $this->db->placehold("DELETE FROM __payment_methods_houses WHERE payment_method_id=?", intval($id));
		$this->db->query($query);
	
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __payment_methods WHERE id=? LIMIT 1", intval($id));
			$this->db->query($query);
		}
	}	


	public function get_payment_method_houses($filter = array())
	{
		$payment_method_id_filter = '';
		$house_id_filter = '';

		if(empty($filter['payment_method_id']) && empty($filter['house_id']) && empty($filter['payment_method_not_id']))
			return array();

		if(!empty($filter['payment_method_id']))
			$payment_method_id_filter = $this->db->placehold('AND pmh.payment_method_id in(?@)', (array)$filter['payment_method_id']);
		elseif(!empty($filter['payment_method_not_id']))
			$payment_method_id_filter = $this->db->placehold('AND pmh.payment_method_id NOT in(?@)', (array)$filter['payment_method_not_id']);

		if(!empty($filter['house_id']))
			$house_id_filter = $this->db->placehold('AND pmh.house_id in(?@)', (array)$filter['house_id']);
				
		$query = $this->db->placehold("SELECT 
						pmh.payment_method_id, 
						pmh.house_id 
					FROM __payment_methods_houses pmh
					WHERE 
						1
						$payment_method_id_filter
						$house_id_filter       
					");
		
		$this->db->query($query);
		return $this->db->results();
	}
	
	public function add_payment_method_houses($payment_method_id, $house_id, $position=0)
	{
		$query = $this->db->placehold("INSERT IGNORE INTO __payment_methods_houses SET payment_method_id=?, house_id=?", $payment_method_id, $house_id);
		$this->db->query($query);
		return $house_id;
	}
	
	public function delete_payment_method_houses($payment_method_id, $house_id)
	{
		$query = $this->db->placehold("DELETE FROM __payment_methods_houses WHERE payment_method_id=? AND house_id=? LIMIT 1", intval($payment_method_id), intval($house_id));
		$this->db->query($query);
	}

	
}
