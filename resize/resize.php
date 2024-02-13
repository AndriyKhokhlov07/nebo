<?php

require_once('../api/Backend.php');

$filename = $_GET['file'];
$type = $_GET['type'];
$token = $_GET['token'];

$filename = str_replace('%2F', '/', $filename);

$backend = new Backend();

/*if(!$backend->config->check_token($filename, $token))
	exit('bad token');*/		

$resized_filename =  $backend->image->resize($filename, $type);

if(is_readable($resized_filename))
{
	header('Content-type: image');
	print file_get_contents($resized_filename);
}
