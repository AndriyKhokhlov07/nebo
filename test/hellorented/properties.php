<?php
ini_set('error_reporting', E_ALL);


session_start();

chdir('../../');
require_once('api/Backend.php');



class Test extends Backend
{


	function fetch()
	{
		$r = $this->hellorented->get_properties();
	}
}


$test = new Test();
$test->fetch();
