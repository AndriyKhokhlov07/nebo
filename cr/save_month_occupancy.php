<?php
ini_set('error_reporting', E_ALL);

// ini_set('error_reporting', 0);
session_start();

chdir('..');
require_once('api/Backend.php');



class Init extends Backend
{
	function fetch()
	{
		$date = new DateTime("first day of last month");

		$this->occupancy->init_occupancy([
			'month' => $date->format('m'),
			'year'  => $date->format('Y'),
			'save_cache' => true
		]);
	}
}


$init = new Init();
$init->fetch();
