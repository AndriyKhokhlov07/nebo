<?php
error_reporting(0);
chdir ('../../');

session_start();
require_once('api/Backend.php');



class CallbackCheckr extends Backend
{
	function fetch()
	{
		$postData = file_get_contents('php://input');
		$jdata = json_decode($postData, true);

		if(!empty($jdata))
		{
			if(!empty($jdata['type']))
			{
				if(in_array($jdata['type'], array('report.created, report.suspended', 'report.completed') ))
				// report.suspended
				// suspended
				if(!empty($jdata['data']))
				{
					if(!empty($jdata['data']['object']))
					{
						$d = $jdata['data']['object'];

						if(!empty($d['candidate_id']))
						{
							// get user
							$query = $this->db->placehold('SELECT * FROM __users WHERE checkr_candidate_id=?', $d['candidate_id']);
							$this->db->query($query);
							$user = $this->db->result();

							if(!empty($user))
							{
								$user_checker_options = array();
								if(!empty($user->checker_options))
									$user_checker_options = (array) unserialize($user->checker_options);

								$user_checker_options['reports'][$d['id']]['status'] = $d['status'];

								if($d['completed_at'] != null)
									$user_checker_options['reports'][$d['id']]['completed_at'] = date('Y-m-d h:i:s', strtotime($d['completed_at']));
								if($d['revised_at'] != null)
									$user_checker_options['reports'][$d['id']]['revised_at'] = date('Y-m-d h:i:s', strtotime($d['revised_at']));
								if($d['upgraded_at'] != null)
									$user_checker_options['reports'][$d['id']]['upgraded_at'] = date('Y-m-d h:i:s', strtotime($d['upgraded_at']));


								

								if($d['status'] == 'consider')
								{
									// assessment
									// null - нет записей отчета
									// pass - криминальные записи
									// fail - записи без судимости
									$user_checker_options['reports'][$d['id']]['assessment'] = $d['assessment'];
								}

								// update user
								if(!empty($user_checker_options))
								{
									$user_data = array();
									$user_data['checker_options'] = serialize($user_checker_options);



									if($d['status'] == 'clear')
									{

										// Delete user personal data;
										// $user_data['social_number'] = '';
										// $user_data['zip'] = '';

										// Contract
										$contracts = $this->contracts->get_contracts(array('user_id'=>$user->id, 'limit'=>1));
										if(!empty($contracts))
										{
											$contract = current($contracts);
											if($contract->signing == 1)
											{
												// Invoices
												$orders = $this->orders->get_orders(array('user_id'=>$user->id, 'type'=>1, 'limit'=>1));
												if(!empty($orders))
												{
													$order = current($orders);
													if($order->status == 2) // Paid
													{
														$user_data['status'] = 2;
													}
												}	
											}
										}
									}
									elseif($d['status'] == 'pass' || $d['status'] == 'fail')
									{
										// Delete user personal data;
										// $user_data['social_number'] = '';
										// $user_data['zip'] = '';
									}


									if(!empty($user_data))
										$this->users->update_user($user->id, $user_data);
								}

							}
						}
					}
				}
			}
		}
	}
}


$callback_checkr = new CallbackCheckr();
$callback_checkr->fetch();






// $postData = file_get_contents('php://input');
// Log 
if(!empty($postData))
{
	logg('json: '.$postData);	
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
	file_put_contents('request/checkr/log.txt', file_get_contents('request/checkr/log.txt')."\r\n".date("m.d.Y H:i:s").' '.$_SERVER['REMOTE_ADDR'].' '.$str);
}