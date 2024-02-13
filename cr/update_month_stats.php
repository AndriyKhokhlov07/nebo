<?php
ini_set('error_reporting', E_ALL);
session_start();

chdir('..');
require_once('api/Backend.php');



class Init extends Backend
{
	function fetch()
	{
		// Generate Sales Stats Cache
		$date = new DateTime("first day of last month");
 		$stats = $this->sales_statistics->get_stats($date->format('m'), $date->format('Y'), true, false);
	}
}


$init = new Init();
$init->fetch();
