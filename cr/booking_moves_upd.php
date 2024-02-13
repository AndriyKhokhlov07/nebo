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
										u.active_booking_id,
										u.moved_in,
										u.auto_move
									FROM __users u
									WHERE u.auto_move = 1
									ORDER BY u.id 
									LIMIT 1000");

		$this->db->query($query);
		$users = $this->db->results();

		foreach ($users as $u) 
		{
			$this->beds->update_booking($u->active_booking_id, array('moved'=>$u->moved_in));
			$this->users->update_user($u->id, array('auto_move'=>0));

			echo('User: '.$u->id.', Booking: '.$u->active_booking_id.', Moved: '.$u->moved_in.'
				');
		}
		exit;


	}
}


$test = new Test();
$test->fetch();
