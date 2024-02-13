<?php
error_reporting(E_ALL);
chdir ('../../');

session_start();
require_once('api/Backend.php');



class Callback extends Backend
{
	function fetch()
	{
		$postData = file_get_contents('php://input');
		
		if(!empty($postData))
		{
			$jdata = json_decode($postData, true);

			if(!empty($jdata['tenant_id']))
			{
				$user = $this->users->get_users(array(
					'hellorented_tenant_id' => $jdata['tenant_id'],
					'count' => 1
				));

				if(empty($user) && !empty($jdata['email']))
				{
					$u = $this->users->get_users(array(
						'email' => $jdata['email'],
						'count' => 1
					));

					if(!empty($u))
					{
						if(empty($u->hellorented_tenant_id))
						{
							$user = $u;
							$u_new = new stdClass;
							$u_new->hellorented_tenant_id = $jdata['tenant_id'];

							$user->hellorented_tenant_id = $jdata['tenant_id'];

							$salesflow = $this->salesflows->get_salesflows(['id'=>$u->active_salesflow_id, 'limit'=>1]);
							if(!empty($salesflow))
								$salesflows = $this->salesflows->get_salesflows(['booking_id'=>$salesflow->booking_id]);

							if(!empty($salesflows))
								foreach ($salesflows as $s) 
								{
									if(!in_array($s->deposit_status, array(3, 4)))
									{
										$this->salesflows->update_salesflow($s->id, array(
											'deposit_type' => 2, // HelloRented
											'deposit_status' => 2 // Sending
										));
									}
								}
							
							if(!in_array($u->security_deposit_status, array(3, 4))) // 3 - Pending, 4 -Paid
							{
								$u_new->security_deposit_type = 2;  // HelloRented
								$u_new->security_deposit_status = 2; // Sending

								$user->security_deposit_type = 2;
								$user->security_deposit_status = 2;
							}
							$this->users->update_user($u->id, $u_new);

							$log_value = 'Tenant ID: '.$jdata['tenant_id'];
							// Add log
							$this->logs->add_log(array(
								'parent_id' => $u->active_salesflow_id, 
								'type' => 5, 
								'subtype' => 1, 
								'user_id' => $u->id, 
								'sender_type' => 4,
								'value' => $log_value
							));
						}
						
					}
				}

				if(!empty($user))
				{
					$log_value = '';


					$log_subtype = 6; // Other

					if(!empty($jdata['status_id']))
					{
						$log_data = array();
						$log_data['status_id'] = $jdata['status_id'];

						if(!empty($jdata['application_id']))
							$log_data['application_id'] = $jdata['application_id'];

						if(!empty($jdata['tenant_id']))
							$log_data['tenant_id'] = $jdata['tenant_id'];
												

						if(isset($this->hellorented->application_statuses[$jdata['status_id']]))
						{
							$hellorented_status = $this->hellorented->application_statuses[$jdata['status_id']];
							// Deposit founded
							// if($jdata['status_id'] == 'S_17')
							// {
							// 	$mailto = 'alex.kos@outpost-club.com, customer.service@outpost-club.com, molchanov.eugeniy@gmail.com, falko0jun@gmail.com';

							// 	$mailfrom = $this->settings->notify_from_email;

							// 	$this->design->assign('user', $user);
							// 	$this->design->assign('type', 'Hellorented');

							// 	$email_template = $this->design->fetch($this->config->root_dir.'backend/design/html/email_first_salsflow_complete.tpl');
							// 	$subject = $this->design->get_var('subject');
							// 	$this->notify->email($mailto, $subject, $email_template, $mailfrom);
							// }
						}
						else
						{
							if(!empty($jdata['status_description']))
								$log_value = $jdata['status_description'];
						}

						if(!empty($hellorented_status))
							$log_subtype = $hellorented_status['status_id'];
					}

					if(!empty($log_data) || !empty($log_value))
					{
						$this->logs->add_log(array(
	                        'parent_id' => $user->active_salesflow_id, 
	                        'type' => 5, // Hellorented
	                        'subtype' => $log_subtype, 
	                        'user_id' => $user->id, 
	                        'sender_type' => 4, // Callback
	                        'value' => $log_value,
	                        'data' => $log_data
	                    ));


	                    if($log_subtype == 1) // Invite Tenant added
	                    	$security_deposit_status = 2; // Sending
	                    elseif($log_subtype == 5) // Funded
	                    	$security_deposit_status = 4; // Paid
	                    else
	                    	$security_deposit_status = 3; // Pending

	                    if(empty($salesflows))
	                    {
	                    	$salesflow = $this->salesflows->get_salesflows(['id'=>$user->active_salesflow_id, 'limit'=>1]);
							if(!empty($salesflow))
								$salesflows = $this->salesflows->get_salesflows(['booking_id'=>$salesflow->booking_id]);
	                    }

	                    if(!empty($salesflows))
	                    {
	                    	foreach ($salesflows as $s) 
	                    	{
	                    		$this->salesflows->update_salesflow($s->id, array(
									'deposit_type' => 2, // HelloRented
									'deposit_status' => $security_deposit_status
								));

	                    		if($security_deposit_status == 4 && ($s->deposit_type != 2 || ($s->deposit_type == 2 && $s->deposit_status != $security_deposit_status)))
								{
									$sent_to_landlord = $this->notify->email_landlord_tenant_approve($s->id);
									$this->notify->email_outpost_tenant_approve($s->id, $sent_to_landlord);
								}
	                    	}
	                    }
	                    

	                    $this->users->update_user($user->id, array(
							'security_deposit_type' => 2, // HelloRented
							'security_deposit_status' => $security_deposit_status
						));

					}
				}
			}
			
			logg('post_data: '.$postData);	
		}
	}
}


$callback = new Callback();
$callback->fetch();




// Log 

if(!empty($postData))
{
	// logg('post_data: '.$postData);	
}
elseif(!empty($_POST))
{
	foreach($_POST as $key=>$value)
		logg('post: '.$key.' => '.$value);
}
else
{
	// logg('post empty');
}


function logg($str)
{
	file_put_contents('request/hellorented/log.txt', file_get_contents('request/hellorented/log.txt')."\r\n".date("m.d.Y H:i:s").' '.$_SERVER['REMOTE_ADDR'].' '.$str);
}