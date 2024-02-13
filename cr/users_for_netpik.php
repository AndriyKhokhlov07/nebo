<?php
ini_set('error_reporting', E_ALL);


session_start();

chdir('..');
require_once('api/Backend.php');



class Test extends Backend
{
	function fetch()
	{
		$query = $this->db->placehold("SELECT u.email,
									 	LOWER(u.first_name) as 'first_name',
									  	LOWER(u.last_name) as 'last_name',
									  	u.us_citizen,
									  	u.phone,
									  	u.created,
									  	s.application_data
									FROM s_users as u 
									LEFT JOIN s_salesflows as s ON s.id = u.active_salesflow_id
 									WHERE 1
										-- AND u.us_citizen = 1
										AND u.created >= '2021-09-01'
									ORDER BY u.id DESC
									LIMIT 5000");

		$this->db->query($query);
		$users = $this->db->results();

		foreach ($users as $u) {
			if(!empty($u->phone))
			{
				$u->phone = preg_replace('/[^0-9]+/', '', $u->phone);
				$u->phone = preg_replace('/^1?(\d*)/', '1' . "$1", $u->phone);
			}
			$u->application_data = unserialize($u->application_data);
			// if(!empty($u->application_data['zip']))
			// {
				echo $u->email . '	' . $u->first_name . '	' . $u->last_name . '	' . 'us'  . '	' . $u->phone .  '	' . base64_decode($u->application_data['zip']) . PHP_EOL;
			// }
		}
		exit;
		
	}
}


$test = new Test();
$test->fetch();
