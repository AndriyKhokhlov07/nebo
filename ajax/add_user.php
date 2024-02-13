<?
session_start();

require_once('../api/Backend.php');

$backend = new Backend();

if($backend->request->post('name'))
{
	$user = new stdClass;
	$user->name = $backend->request->post('name');
	$user->first_name = $backend->request->post('first_name');
	$user->last_name = $backend->request->post('last_name');
	$user->email = $backend->request->post('email');
	$user->phone = $backend->request->post('phone');
	$user->type = 1;
	$user->status = 0;
	$user->enabled = 0;
	$user->blocks['auto_added'] = 1;
	$user->blocks = serialize($user->blocks);

    if ($backend->request->post('airbnb_id')) {
        $user->airbnb_id = $backend->request->post('airbnb_id');
    }
    if ($backend->request->post('airbnb2_id')) {
        $user->airbnb2_id = $backend->request->post('airbnb2_id');
    }

	$id = $backend->users->add_user($user);

	$backend->logs->add_log(array(
        'parent_id' => $id, 
        'type' => 2, 
        'subtype' => 2, // user created
        'sender_type' => 1 // System
    ));

    // hotel_upd
	if($backend->request->post('guest_name'))
	{
		$guest_user = new stdClass;
		$guest_user->name = $backend->request->post('guest_name');
		$guest_user->first_name = $backend->request->post('guest_first_name');
		$guest_user->last_name = $backend->request->post('guest_last_name');
		$guest_user->email = $backend->request->post('guest_email');
		$guest_user->phone = $backend->request->post('guest_phone');
		$guest_user->type = 1;
		$guest_user->status = 0;
		$guest_user->enabled = 0;
		$guest_user->blocks['auto_added'] = 1;
		$guest_user->blocks = serialize($user->blocks);

		$g_id = $backend->users->add_user($guest_user);

		$backend->logs->add_log(array(
	        'parent_id' => $g_id, 
	        'type' => 2, 
	        'subtype' => 2, // user created
	        'sender_type' => 1 // System
	    ));
	}
	// hotel_upd END

	$data_arr['content'] = 'User added.';
}
else{
	$data_arr['content'] = 'User not added.';
}







header("Content-type: application/json; charset=UTF-8");
header("Cache-Control: must-revalidate");
header("Pragma: no-cache");
header("Expires: -1");
echo json_encode($data_arr);

// Log
/*
if(!empty($user->name))
{
	logg('json: '.$backend->request->post('name'));	
}
elseif(!empty($_POST))
{
	foreach($_POST as $key=>$value)
		logg('post: '.$key.' => '.$value);
}
else
	logg('post empty');

function logg($str)
{
	file_put_contents('log.txt', file_get_contents('log.txt')."\r\n".date("m.d.Y H:i:s").' '.$_SERVER['REMOTE_ADDR'].' '.$str);
}
*/