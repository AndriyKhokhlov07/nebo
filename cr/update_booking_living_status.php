<?php
//ini_set('error_reporting', E_ALL);


session_start();

chdir('..');
require_once('api/Backend.php');



class Init extends Backend
{
	function fetch()
	{
		$this->beds->update_living_status();
	}
}


$init = new Init();
$init->fetch();
