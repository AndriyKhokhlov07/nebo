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
										b.id, 
										b.manager_login
									FROM __bookings b
									WHERE
										b.manager_upd = 0
									ORDER BY b.id DESC
									LIMIT 1000
									");
		$this->db->query($query);
		$bookings = $this->db->results();
		$bookings =  $this->request->array_to_key($bookings, 'id');

		$logs = $this->logs->get_logs(['parent_id'=>array_keys($bookings), 'type'=>1, 'subtype'=>1]);
		$logs = $this->request->array_to_key($logs, 'parent_id');

		foreach ($bookings as $b) {
            $this->beds->update_booking($b->id, ['manager_login' => $logs[$b->id]->sender, 'manager_upd' => 1]);
		}

	}
}


$test = new Test();
$test->fetch();
