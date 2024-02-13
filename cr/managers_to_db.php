<?php
ini_set('error_reporting', E_ALL);


session_start();

chdir('..');
require_once('api/Backend.php');

class Test extends Backend
{
	function fetch()
	{
		$managers = $this->managers->get_managers();

		foreach ($managers as $m) {
			$query = $this->db->placehold("INSERT IGNORE INTO __managers SET login=?, type=?", $m->login, 0);
			$this->db->query($query);
		}

	}
}


$test = new Test();
$test->fetch();
