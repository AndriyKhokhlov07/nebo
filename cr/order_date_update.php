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
										o.date_due
									FROM __orders o
									WHERE o.date IS NULL
									ORDER BY o.id 
									");

		$this->db->query($query);
		$orders = $this->db->results();


		foreach ($orders as &$o) {
			$date_creation = date_create($o->date_due);
			date_sub($date_creation, date_interval_create_from_date_string('4 days'));
			$o->date = $date_creation->format('Y-m-d');
			$this->orders->update_order($o->id, ['date'=>$o->date]);
		}




	}
}


$test = new Test();
$test->fetch();
