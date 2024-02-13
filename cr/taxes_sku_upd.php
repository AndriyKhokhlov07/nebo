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
										o.date,
										o.date_due
									FROM __orders o
									WHERE 
										o.type = 11
										AND o.date_due = '0000-00-00 00:00:00'
									ORDER BY o.id 
									");

		$this->db->query($query);
		$orders = $this->db->results();

		foreach ($orders as $o) {
			$date_due = date_create($o->date);
			date_add($date_due, date_interval_create_from_date_string('2 days'));

			$o->date_due = $date_due->format('Y-m-d');
			
			$this->orders->update_order($o->id, array('date_due'=>$o->date_due));
		}


	}
}


$test = new Test();
$test->fetch();
