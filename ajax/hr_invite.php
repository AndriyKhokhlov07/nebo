<?php
session_start();

require_once('../api/Backend.php');

chdir('..');
$backend = new Backend();

if($backend->request->get('id'))
{
	$user = $backend->users->get_user((int)$backend->request->get('id'));
	$contract_id = $backend->request->get('c_id');

	if(!empty($contract_id))
		$r = $backend->hellorented->invite_tenant($user->id);
	else
		$r = $backend->hellorented->invite_tenant($user->id, $contract_id);
	
	$backend->salesflows->update_salesflow($user->active_salesflow_id, array(
		'deposit_type' => 2,  // HelloRented
		'deposit_status' => 2 // Sending
	));
	
	if($r == 'succeeded')
	{
		if(is_null($user->security_deposit_type))
		{
			$backend->users->update_user($user->id, array(
				'security_deposit_type' => 2,  // HelloRented
				'security_deposit_status' => 2 // Sending
			));
		}
		$data_arr['content'] = 'User added.';
	}
	else
	{
		$data_arr['content'] = $r;

	}

}
else{
		$data_arr['content'] = 'No id.';
}



header("Content-type: application/json; charset=UTF-8");
header("Cache-Control: must-revalidate");
header("Pragma: no-cache");
header("Expires: -1");
echo json_encode($data_arr);

// Log 
if(!empty($user->name))
{
	logg('Hellorented invite: '.$user->name.' '.print_r($r));	
}
else
	logg('post empty');

function logg($str)
{
	file_put_contents('ajax/hr_log.txt', file_get_contents('ajax/hr_log.txt')."\r\n".date("m.d.Y H:i:s").' '.$_SERVER['REMOTE_ADDR'].' '.$str);
}