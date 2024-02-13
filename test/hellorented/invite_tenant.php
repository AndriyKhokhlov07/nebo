<?php
ini_set('error_reporting', E_ALL);


session_start();

chdir('../../');
require_once('api/Backend.php');



class Test extends Backend
{


	function fetch()
	{
		$r = $this->hellorented->invite_tenant(2416);
		print_r($r);
	}
}


$test = new Test();
$test->fetch();
