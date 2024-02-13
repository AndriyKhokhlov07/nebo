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
							o.date_due,
							o.contract_id
						FROM __orders AS o
						WHERE 1
							AND o.type = 1
							AND o.paid != 1
							AND o.status = 0
 							AND o.date_due >= '2021-05-01 00:00:00'
						ORDER BY o.id
						");

		$this->db->query($query);
		$orders = $this->db->results();

		foreach ($orders as $o) 
		{
			if(date('d', strtotime($o->date_due)) == '01')
			{
				$new_date = date('Y-m', strtotime($o->date_due)).'-02';
				// print_r($o);
				// print_r($new_date);
				// exit;
				$this->orders->update_order($o->id, array('date_due'=>$new_date));
			}
		}


	}
}


$test = new Test();
$test->fetch();
