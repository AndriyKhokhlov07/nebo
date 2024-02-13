<?php
// ini_set('error_reporting', E_ALL);

ini_set('error_reporting', 0);
session_start();

chdir('..');

require_once('api/Backend.php');

class Init extends Backend
{
	function fetch()
	{
		$dir = 'backend/files/backup/';

		$filename = $dir.'backup_'.date("Ymd_Gis").'.zip';
		
		$this->db->dump($dir.'db.sql');
		chmod($dir.'db.sql', 0777);

		$zip = new ZipArchive();
		$zip->open($filename, ZIPARCHIVE::CREATE);
		$zip->addFile($dir.'db.sql', 'backup_'.date("Ymd_Gis").'/db.sql');
		$zip->close();
	}
}


$init = new Init();
$init->fetch();
