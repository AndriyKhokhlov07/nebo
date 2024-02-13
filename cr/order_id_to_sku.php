<?php
ini_set('error_reporting', E_ALL);


session_start();

chdir('..');
require_once('api/Backend.php');



class Test extends Backend
{
	function fetch()
	{
		$query = $this->db->placehold("SELECT 
										o.id, 
										o.sku
									FROM __orders o
									WHERE o.sku IS NULL
									ORDER BY o.id 
									LIMIT 1000");

		$this->db->query($query);
		$orders = $this->db->results();

		foreach ($orders as $o) {
			$this->orders->update_order($o->id, array('sku'=>$o->id));
		}


	}
}


$test = new Test();
$test->fetch();
