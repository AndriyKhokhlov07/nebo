<?php
ini_set('error_reporting', E_ALL);


// session_start();

chdir('../');
require_once('api/Backend.php');



class Init extends Backend
{
	function fetch()
	{
		$this->notify->email_landlord_tenant_approve(1957);
        // $this->notify->email_landlord_tenant_approve(3816);
	}
}


$init = new Init();
$init->fetch();
