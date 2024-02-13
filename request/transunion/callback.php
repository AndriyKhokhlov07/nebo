<?php
ini_set('error_reporting', 0;
chdir ('../../');

session_start();
require_once('api/Backend.php');


class CallbackTransunion extends Backend
{
	public function fetch()
	{
		$postData = file_get_contents('php://input');

		if(!empty($postData))
		{
			$result = simplexml_load_string($postData, 'SimpleXMLElement', LIBXML_NOCDATA);
			if($result->status->statusCode == 1 && !empty($result->application->applicationNumber))
			{
				$user = $this->users->get_users(array(
					'transunion_id' => $result->application->applicationNumber,
					'count' => 1
				));

				if(!empty($user))
				{
					// Update Guest
					$user_upd = new stdClass;
					$user_upd->transunion_status = $result->application->scoreResult->applicationRecommendation;
					$user_upd->transunion_data = $postData;

					$salesflow_upd = new stdClass;
					$salesflow_upd->transunion_status = $result->application->scoreResult->applicationRecommendation;
					$salesflow_upd->transunion_data = $postData;

					if($user_upd->transunion_status == 1 && $user->status < 2)
					{
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
										$user_upd->status = 2;
									}
								}	
							}
						}
					}
					
					$this->users->update_user($user->id, $user_upd);

					$this->salesflows->update_salesflow($user->active_salesflow_id, $salesflow_upd);

					// Add log
					$log_value = 'Application Number: '.$result->application->applicationNumber;
					$this->logs->add_log(array(
						'parent_id' => $user->id, 
						'type' => 6, 
						'subtype' => $user_upd->transunion_status, 
						'user_id' => $user->id, 
						'sender_type' => 4,
						'value' => $log_value
					));


					// file_put_contents('request/transunion/log.txt', file_get_contents('request/transunion/log.txt')."\r\n".date("m.d.Y H:i:s").' '.$_SERVER['REMOTE_ADDR'].' '.$postData);
				}
			}
		}
		else
		{
			// file_put_contents('request/transunion/log.txt', file_get_contents('request/transunion/log.txt')."\r\n".date("m.d.Y H:i:s").' '.$_SERVER['REMOTE_ADDR'].' empty post data');
		}
		
	}
}


$callback_transunion = new CallbackTransunion();
$callback_transunion->fetch();