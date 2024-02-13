<?php
ini_set('error_reporting', E_ALL);


session_start();

chdir('..');
require_once('api/Backend.php');



class Test extends Backend
{
	function fetch()
	{
		$query = $this->db->placehold("SELECT u.id
									FROM __users as u 
 									WHERE 1
										AND u.status = 0
										AND u.created < '2022-01-01'
									ORDER BY u.id DESC
									LIMIT 500");

		$this->db->query($query);
		$users = $this->db->results();

        if(!empty($users)) {
            $users = $this->request->array_to_key($users, 'id');
            $users_ids = array_keys($users);

            if(!empty($users_ids)) {
                $query = $this->db->placehold("DELETE FROM __users WHERE id in(?@)", $users_ids);
		        $this->db->query($query);

                $query = $this->db->placehold("DELETE FROM __logs WHERE user_id in(?@)", $users_ids);
		        $this->db->query($query);
            }

            

            // $query = $this->db->placehold("SELECT l.id FROM __logs as l WHERE l.user_id in(?@)", $users_ids);
            // $this->db->query($query);
		    // $logs = $this->db->results();
            // if(!empty($logs)) {
            //     echo count($logs);
            //     print_r($logs);
            //     exit;
            // }
        }
		
		
	}
}


$test = new Test();
$test->fetch();
