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
									FROM __contracts o
									WHERE 1
									ORDER BY o.id 
									LIMIT 100000");

		$this->db->query($query);
		$contracts = $this->db->results();

		foreach ($contracts as $o) {
			$this->contracts->update_contract($o->id, array('sku'=>$o->id));
		}


	}
}


$test = new Test();
$test->fetch();
