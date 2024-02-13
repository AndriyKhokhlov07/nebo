<?php
ini_set('error_reporting', E_ALL);


// session_start();

chdir('../');
require_once('api/Backend.php');



class Init extends Backend
{
	function fetch()
	{
		// $this->notify->email_guarantor_agreement(15565);	
		echo 1;	 	
	}
}


$init = new Init();
$init->fetch();
