<?php
ini_set('error_reporting', E_ALL);

session_start();

chdir('..');
require_once('api/Backend.php');

class Test extends Backend
{
	function fetch()
	{
		$secret_key = 'e3da59312a0870c24e55d9a18db26c53590701518e5f57b64c8a972c799149e5';

		$curl = curl_init();
		$headers = [
		    'Content-Type: application/json',
		    'Authorization: Bearer ' . $secret_key
		];
		curl_setopt($curl, CURLOPT_URL, 'https://ne-bo.com/get/properties/306');
		curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);

		$json = curl_exec($curl);

		header("Content-type: application/json; charset=UTF-8");
		header("Access-Control-Allow-Origin: *");
		header("Cache-Control: must-revalidate");
		header("Pragma: no-cache");
		header("Expires: -1");

		echo $json; exit;
	}
}


$test = new Test();
$test->fetch();
