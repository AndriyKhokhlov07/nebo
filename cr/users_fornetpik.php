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
										u.id,
										u.email,
									 	LOWER(u.first_name) as 'first_name',
									  	LOWER(u.last_name) as 'last_name',
									  	u.us_citizen,
									  	u.phone,
									  	u.created,
									  	s.application_data,
										s.type as 'stype'
									FROM s_users as u 
									LEFT JOIN s_salesflows as s ON s.id = u.active_salesflow_id
 									WHERE 1
										-- AND u.us_citizen = 1
										AND u.created >= '2022-06-01' AND u.created < '2022-07-01'
									ORDER BY u.id DESC
									LIMIT 20000");
		$this->db->query($query);
		$users = $this->db->results();

		$users = $this->request->array_to_key($users, 'id');



		// Airbnb and Guarantors
		$query = $this->db->placehold("SELECT 
										u.id,
										u.email,
									 	LOWER(u.first_name) as 'first_name',
									  	LOWER(u.last_name) as 'last_name',
									  	u.us_citizen,
									  	u.phone,
									  	u.created,
									  	s.application_data
									FROM s_users as u 
									LEFT JOIN s_salesflows as s ON s.id = u.active_salesflow_id
 									WHERE 1
										AND u.created >= '2022-06-01' AND u.created < '2022-07-01'
										AND s.type in(?@)
									ORDER BY u.id DESC
									LIMIT 20000", [1,2]);
		$this->db->query($query);
		$a_users = $this->db->results();

		if(!empty($a_users)) {
			foreach($a_users as $u) {
				if(isset($users[$u->id])) {
					unset($users[$u->id]);
				}
			}
		}



		header("Content-type: text/csv"); 
		header("Content-Disposition: attachment; filename=leads_06_22.csv"); 
		header("Pragma: no-cache"); 
		header("Expires: 0"); 

		$buffer = fopen('php://output', 'w'); 

		fputs($buffer, chr(0xEF) . chr(0xBB) . chr(0xBF));

		foreach ($users as $u) {
			if(!empty($u->phone))
			{
				$u->phone = preg_replace('/[^0-9]+/', '', $u->phone);
				$u->phone = preg_replace('/^1?(\d*)/', '1' . "$1", $u->phone);
			}
			$u->application_data = unserialize($u->application_data);
			// if(!empty($u->application_data['zip']))
			// {
				//echo $u->email . '	' . $u->first_name . '	' . $u->last_name . '	' . 'us'  . '	' . $u->phone .  '	' . base64_decode($u->application_data['zip']) . PHP_EOL;
			// }
			$us_citizen = '';
			if($u->us_citizen == 2)
				$us_citizen = 'Not US';
			elseif($u->us_citizen == 1)
				$us_citizen = 'US';

			$val = [
				'email' => $u->email,
				'first_name' => $u->first_name,
				'last_name' => $u->last_name,
				'phone' => $u->phone,
				'us' => $us_citizen,
				'zip' => base64_decode($u->application_data['zip']),
				//'airbnb' => $u->stype==1?'airbnb':'',
				'date' => $u->created
			];

			fputcsv($buffer, $val, ';'); 
		}
		fclose($buffer);
		exit;
		
	}
}


$test = new Test();
$test->fetch();
