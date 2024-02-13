<?PHP
ini_set('error_reporting', 0);
require_once('View.php');


require_once 'api/dompdf/lib/html5lib/Parser.php';
// require_once 'api/dompdf/lib/php-font-lib/src/FontLib/Autoloader.php';
// require_once 'api/dompdf/lib/php-svg-lib/src/autoload.php';
require_once 'api/dompdf/src/Autoloader.php';
Dompdf\Autoloader::register();

use Dompdf\Dompdf;
use Dompdf\Options;



class ContractView extends View
{

	// public function onRequestStart() {
 //        $dat = getrusage();
 //        define('PHP_TUSAGE', microtime(true));
 //        define('PHP_RUSAGE', $dat["ru_utime.tv_sec"]*1e6+$dat["ru_utime.tv_usec"]);
 //    }
     
 //    public function getCpuUsage() {
 //        $dat = getrusage();
 //        $dat["ru_utime.tv_usec"] = ($dat["ru_utime.tv_sec"]*1e6 + $dat["ru_utime.tv_usec"]) - PHP_RUSAGE;
 //        $time = (microtime(true) - PHP_TUSAGE) * 1000000;
     
 //        // cpu per request
 //        if($time > 0) {
 //            $cpu = sprintf("%01.2f", ($dat["ru_utime.tv_usec"] / $time) * 100);
 //        } else {
 //            $cpu = '0.00';
 //        }
     
 //        return $cpu;
 //    }
    

	
	public function valid_date($d, $m, $y)
	{
		if(!checkdate($m, $d, $y))
			return $this->valid_date($d-1, $m, $y);
		else
			return $d;
	}

	// Отправить инвойсы когда подпишут все


	function fetch()
	{
		$landlord = false;
		$room_type = '';


		$url = $this->request->get('url', 'string');

		$contract_info = $this->contracts->get_contract($url);

		if(!empty($contract_info->options))
			$contract_info->options = unserialize($contract_info->options);
		
		$user_id = $this->request->get('user_id', 'integer');

		// if($contract_info->type == 3 && empty($user_id))
		// 	return false;

		if(!empty($contract_info->roomtype))
			$contract_info->roomtype = $this->beds->get_rooms_types(array('id'=>$contract_info->roomtype, 'limit'=>1));

		
		if(!empty($contract_info))
		{
			$viewed = $this->request->get('w', 'integer');
			if($viewed == 1 && empty($_SESSION['admin']))
			{
				$this->contracts->update_contract($contract_info->id, array('date_viewed'=>'now'));
				header('Location: '.$this->config->root_url.'/contract/'.$contract_info->url.'/'.$user_id);
				exit;
			}

			if(!empty($contract_info->id))
			{
				$contract_users_ = $this->users->get_users(array('contract_id'=>$contract_info->id));
			}

			$contract_users = array();
			if(!empty($contract_users_))
			{
				foreach($contract_users_ as $c_user)
				{
					$contract_users[$c_user->id] = $c_user;
				}
			}


			if(!empty($user_id))
			{
				$contract_user = $this->users->get_user(intval($user_id));	
			}
			elseif(!empty($contract_users))
			{
				$contract_user = current($contract_users);
			}
			else				
				return false;




			// Calculate monthly payments
			$contract_calculate = $this->contracts->calculate($contract_info->date_from, $contract_info->date_to, $contract_info->price_month);

			if(!empty($contract_calculate))
			{
				$contract_info->invoices = $contract_calculate->invoices;
				$contract_info->invoices_total = $contract_calculate->total;
			}
			

			if(!empty($contract_info->house_id))
			{
				$house = $this->pages->get_page(intval($contract_info->house_id));

				if(!empty($house) && !empty($house->blocks2))
				{
					$house->blocks2 = unserialize($house->blocks2);
					if($house->blocks2['contract_side'] != 0)
					{
						$landlord = $this->users->get_user(intval($house->blocks2['contract_side']));
						$this->design->assign('house', $house);
						$this->design->assign('landlord', $landlord);
					}
				}
			}



			if(!empty($contract_info->reserv_id))
			{
				$reverv = $this->beds->get_bookings(array(
					'id' => $contract_info->reserv_id, 
					'not_canceled' => 1,
					'limit' => 1
				));
			}
			elseif(!empty($contract_user->active_booking_id))
			{
				$reverv = $this->beds->get_bookings(array(
					'id' => $contract_user->active_booking_id, 
					'not_canceled' => 1,
					'limit' => 1
				));
			}
			
			if(!empty($reverv))
			{
				// Bed booking
				if($reverv->type == 1)
				{
					$bed = $this->beds->get_beds(array(
						'id' => $reverv->object_id,
						'limit' => 1
					));
					if(!empty($bed))
					{
						$this->design->assign('bed', $bed);

						$room = $this->beds->get_rooms(array(
							'id' => $bed->room_id,
							'limit' => 1
						));


						if(!empty($room) && $room->apartment_id != 0)
						{
							$apartment = $this->beds->get_apartments(array(
								'id' => $room->apartment_id,
								'limit' => 1
							));
							$this->design->assign('apartment', $apartment);


							$rooms = $this->beds->get_rooms(array('apartment_id'=>$apartment->id));
							$rooms_ids = array();
							foreach($rooms as $r) 
								$rooms_ids[] = $r->id;

							$beds = $this->beds->get_beds(array('room_id'=>$rooms_ids));
							$beds_ids = array();
							foreach($beds as $b) 
							{
								$beds_ids[] = $b->id;
							}



							// Landlord Contracts
							if($contract_info->type > 5)
							{

								$bjs = $this->beds->get_bookings(array(
									'object_id' => $beds_ids, 
									'type' => 1, 
									'now' => 1, 
									'not_canceled' => 1
								));
								$bjs = $this->request->array_to_key($bjs, 'id');


								if(!empty($bjs))
								{
									$beds_bookings_users = $this->beds->get_bookings_users(array('booking_id'=>array_keys($bjs)));
									$bb_users_by_user = $this->request->array_to_key($beds_bookings_users, 'user_id');

									if(!empty($bb_users_by_user))
									{
										$users = $this->users->get_users(array('id'=>array_keys($bb_users_by_user)));
										$users = $this->request->array_to_key($users, 'id');	
									}
									if(!empty($users))
										$contracts = $this->contracts->get_contracts(array(
											'house_id' => $reverv->house_id, 
											'user_id' => array_keys($users), 
											'status' => 1,
											'select_users' => true
										));


									if($contracts)
									{
										foreach($contracts as $k=>$c) 
										{
											if($c->signing == 1 && $c->type > 5 && strtotime($c->date_to) > strtotime(date('Y-m-d H:i:s')))
											{
												if(!empty($c->users))
												{
													foreach($c->users as $u)
													{
														if(file_exists($this->config->contracts_dir.$c->url.'/signature.png') )
															$c->signature = $this->config->contracts_dir.$c->url.'/signature.png';
														elseif(file_exists($this->config->contracts_dir.$c->url.'/signature-'.$u->id.'.png'))
															$c->signature = $this->config->contracts_dir.$c->url.'/signature-'.$u->id.'.png';

														$users[$u->id]->contract = $c;
													}
												}
											}
											else
												unset($contracts[$k]);
										}
										ksort($contracts); 
										$this->design->assign('users', $users); // Landlord Apartment Guests
										$this->design->assign('guests', $contracts);
									}
								}

							}
							
						}



					}

				}

				// Apt booking
				elseif($reverv->type == 2)
				{
					$apartment = $this->beds->get_apartments(array(
						'id' => $reverv->object_id,
						'limit' => 1
					));
					$this->design->assign('apartment', $apartment);
				}	

					
			}


			$step = $this->request->post('step', 'integer');

			if($this->request->method('post') && !empty($_POST))
			{
				if(!empty($_POST['signature']) || !empty($step))
				{

					if(!isset($step) || $step == 1)
					{

						// Add date signing
						$contract_info->date_signing = date("Y-m-d H:i:s");

						$this->logs->add_log(array(
	                        'parent_id' => $contract_info->id, 
	                        'type' => 4, 
	                        'subtype' => 4, // contract signed
	                        'user_id' => $contract_user->id, 
	                        'sender_type' => 3
	                    ));

					}

	                $contract_logs = $this->logs->get_logs(array(
						'parent_id' => $contract_info->id,
						'type' => 4, // Contracts
						'subtype' => 4 // Sign
					));

	                $signers = array();
					if(!empty($contract_logs))
					{
						foreach($contract_logs as $log)
						{
							if($contract_users[$log->user_id])
							{
								$contract_users[$log->user_id]->log = $log;
								$signers[$log->user_id] = $log->user_id;
							}
						}
					}


					if(!isset($step) || $step == 1)
					{

						if($this->request->post('children'))
						{
							if(empty($contract_info->options))
								$contract_info->options = array();
							$contract_info->options['children'] = $this->request->post('children', 'integer');

							if(!empty($contract_info->options))
							{
								$contract_info_options = serialize($contract_info->options);
								$this->contracts->update_contract($contract_info->id, array('options'=>$contract_info_options));
							}
							
						}

						if(count($signers) >= count($contract_users))
						{
							$contract_info->signing = 1;
							$this->contracts->update_contract($contract_info->id, array('date_signing'=>$contract_info->date_signing, 'signing'=>1));
						}
						else
						{
							$contract_info->signing = 2;
							$this->contracts->update_contract($contract_info->id, array('date_signing'=>$contract_info->date_signing, 'signing'=>2));
						}


						if($contract_user->status == 0) // User: New to Pending
							$this->users->update_user($contract_user->id, array('status'=>1));

						elseif($contract_user->status == 1) // User: Pending to Approved
						{
							// Invoice
							$orders = $this->orders->get_orders(array(
								'user_id' => $contract_user->id,
								'type' => 1, 
								'limit' => 1
							));
							if(!empty($orders))
							{
								$order = current($orders);

								if($order->status == 2) // Paid
								{
									// User: Pending to Approved
									$this->users->update_user($contract_user->id, array('status'=>2));

									// User checkr
									/*if($contract_user->checkr_candidate_id && !empty($contract_user->checker_options))
									{
										$contract_user->checker_options = unserialize($contract_user->checker_options);
										if($contract_user->checker_options['reports'])
										{
											$checker_report = current($contract_user->checker_options['reports']);
											if($checker_report['status'])
											{
												if($checker_report['status'] == 'clear')
												{
													// User: Pending to Approved
													$this->users->update_user($contract_user->id, array('status'=>2));
												}
											}
										}
									}*/
								}
							}
						}

						// ----------------
						// --- INVOICES ---
						// ----------------

						$invoice_users = array();
						if($contract_info->type == 4)
							$invoice_users[] = $contract_user->id;
						else
							$invoice_users = array_keys($contract_users);

						if($contract_info->type == 3)
						{
							$prepayment = $this->orders->get_orders(array(
								'contract_id' => $contract_info->id,
								'label' => 6,
								'count' => 1
							));
					    }

						if($contract_info->sellflow == 1)
						{
							if(count($signers) == 1 || $contract_info->type == 4)
							{

								// Sellflow (invoice create)
								$new_invoice = new stdClass;
								$new_invoice->contract_id = $contract_info->id;
								$new_invoice->booking_id = $contract_info->reserv_id;
								$new_invoice->user_id = $invoice_users;
					    		//$new_invoice->email   = $contract_user->email;
					    		$new_invoice->type    = 1; // invoice
					    		$new_invoice->ip 		= $_SERVER['REMOTE_ADDR'];
					    		//$new_invoice->name 	= $contract_user->name;
					    		$new_invoice->sended = 1;
					    		//Говорим, что инвойс отправлен
					    		$new_invoice->automatically = 1;
						    	// Создан автоматически. Этим определяем, что нужно передать в ссылке после успешной оплаты метку об оплате депозита 
					    		// 15.05.2020 - депозит оплачивается через хеллорентед

						    	$cur_invoice = current($contract_info->invoices);

						    	// if($contract_info->type == 4)
						    	// 	$price = ceil($contract_info->price_month / count($contract_users));
						    	// else
						    		$price = $contract_info->price_month;

						    	$days = ($cur_invoice->date_from - $cur_invoice->date_to)/60/60/24;
						    	if($days == 0)
						    		$days = 30;


						    	$cur_invoice_date_from = date('M d, Y', strtotime($cur_invoice->date_from));
						    	$cur_invoice_date_to = date('M d, Y', strtotime($cur_invoice->date_to));

						    	$new_invoice->date_from = date('Y-m-d', strtotime($cur_invoice->date_from));
						    	$new_invoice->date_to = date('Y-m-d', strtotime($cur_invoice->date_to));

						    	
						    	// 04.11.2020 Депозит создается в бекграунд чеке (новый сейлфлоу)

						   //  	if($contract_info->outpost_deposit == 1 && $contract_info->price_deposit > 0)
						   //  	{
						   //  		$new_deposit = new stdClass;
							  //   	$new_deposit->contract_id = $contract_info->id;
									// $new_deposit->user_id = $invoice_users;
						   //  		//$new_deposit->email   = $contract_user->email;
						   //  		$new_deposit->type    = 1; // invoice
						   //  		$new_deposit->ip 	= $_SERVER['REMOTE_ADDR'];
						   //  		//$new_deposit->name 	= $contract_user->name;
						   //  		$new_deposit->sended = 1;
						   //  		$new_deposit->automatically = 1;
						   //  		$new_deposit->deposit = 1;
						   //  		$new_deposit->date_to = $new_invoice->date_to;
						   //  		// Добавляем заказ в базу

						   //  		// if(!empty($landlord) && !empty($landlord->landlord_code))
							  //   	// {
							  //   	// 	if(!empty($new_deposit))
							  //   	// 	{
							  //   	// 		$new_deposit->sku = $new_deposit_id.'/'.$landlord->landlord_code;
							  //   	// 	}
							  //   	// }
						   //  		$new_deposit_id = $this->orders->add_order($new_deposit);
						   //  		if(!empty($new_deposit_id) && !empty($landlord) && !empty($landlord->landlord_code))
							  //   	{
									// 	$new_deposit_sku = $new_deposit_id.'/'.$landlord->landlord_code;
									// 	$this->orders->update_order($new_deposit_id, array('sku'=>$new_deposit_sku));
									// }


						   //  		if(is_null($contract_user->security_deposit_type))
						   //  		{
						   //  			$this->users->update_user($contract_user->id, array(
									// 		'security_deposit_type' => 1,  // Outpost
									// 		'security_deposit_status' => 1 // Created
									// 	));
						   //  		}
						   //  	}
						    	
						    	
						    	$new_invoice_id = $this->orders->add_order($new_invoice);

						    	if(!empty($new_invoice_id) && !empty($landlord) && !empty($landlord->landlord_code))
						    	{
									$new_invoice_sku = $new_invoice_id.'/'.$landlord->landlord_code;
									$this->orders->update_order($new_invoice_id, array('sku'=>$new_invoice_sku));
								}

						    	$_SESSION['order_id'] = $new_invoice_id;

						    	
								// elseif(!empty($new_invoice->deposit))
								// {
								// 	$this->orders->update_order($new_invoice_id, array('deposit' => 1));
								// }

						    	if(!empty($contract_info->roomtype))
						    		$room_type = $contract_info->roomtype->name;
						    	elseif($contract_info->room_type==1)
									$room_type = '2-people room';
								elseif ($contract_info->room_type==2)
									$room_type = '3-people room';
								elseif ($contract_info->room_type==3)
									$room_type = '4-people room';
								elseif ($contract_info->room_type==4)
									$room_type = '3-people shared room';
								elseif ($contract_info->room_type==5)
									$room_type = '4-people shared room';
								elseif ($contract_info->room_type==6)
									$room_type = 'Private room';
								elseif ($contract_info->room_type==7)
									$room_type = 'Private room with bathroom';


						    	
								if($contract_info->type == 3 && !empty($apartment))
							    	$pur_name = $apartment->name.' - '.$contract_info->rental_name.' - Outpost Club from '.date('d F Y', strtotime($cur_invoice_date_from)).' and to '.date('d F Y', strtotime($cur_invoice_date_to));
							    else
							    	$pur_name = '1 tenant at '.$room_type.' - '.$contract_info->rental_name.' - Outpost Club from '.date('d F Y', strtotime($cur_invoice_date_from)).' and to '.date('d F Y', strtotime($cur_invoice_date_to));


						    	if($contract_info->type == 3 && !empty($prepayment))
						    		$price = intval($price) - intval($this->contracts->deposit_firs_part); 

						    	$this->orders->add_purchase(array('order_id'=>$new_invoice_id, 'variant_id'=>0, 'product_name'=>$pur_name, 'price'=>$price));


						  //   	$membership_invoive = new stdClass;
								// $membership_invoive->contract_id = $contract_info->id;
								// $membership_invoive->user_id = $invoice_users;
					   //  		//$new_invoice->email   = $contract_user->email;
					   //  		$membership_invoive->type    = 1; // invoice
					   //  		$membership_invoive->ip 		= $_SERVER['REMOTE_ADDR'];
					   //  		//$new_invoice->name 	= $contract_user->name;
					   //  		$membership_invoive->sended = 1;
					   //  		$membership_invoive->membership = 1;
					   //  		$membership_invoive->date_from = $contract_info->date_from;

					   //  		$date_membership_end = date_create(date('Y-m-d', strtotime($contract_info->date_from)));
								// date_add($date_membership_end, date_interval_create_from_date_string('1 year'));

					   //  		$membership_invoive->date_to = $date_membership_end->format('Y-m-d');

					   //  		$membership_invoive_id = $this->orders->add_order($membership_invoive);

						  //   	if($contract_info->membership == 2)
								// {
								// 	$membership_price = 79;
								// 	$pur_membership_name = 'Silver Membership one time annual payment';
								// }
								// elseif($contract_info->membership == 4)
								// {
								// 	$membership_price = 29;
								// 	$pur_membership_name = 'Silver Membership one time annual payment';
								// }
								// elseif($contract_info->membership == 1)
								// {
								// 	$membership_price = 690;
								// 	$pur_membership_name = 'Gold Membership one time annual payment';
								// }

								// if($contract_info->membership != 3)
						  //   		$this->orders->add_purchase(array('order_id'=>$membership_invoive_id, 'variant_id'=>0, 'product_name'=>$pur_membership_name, 'price'=>$membership_price, 1));


						    	// if($contract_info->outpost_deposit == 1 && $contract_info->price_deposit > 0)
						    	// {
						    	// 	// if($contract_info->type == 4)
							    // 	// 	$price_deposit = ceil($contract_info->price_deposit / count($contract_users));
							    // 	// else
							    // 		$price_deposit = $contract_info->price_deposit;

						    	// 	$this->orders->add_purchase(array('order_id'=>$new_deposit_id, 'variant_id'=>0, 'product_name'=>'Security deposit', 'price'=>$price_deposit, 1));
						    	// }


						    	$new_invoice = $this->orders->get_order($new_invoice_id);
								$this->design->assign('invoice', $new_invoice);


								


								// Создание всех инвойсов для пользователя 
								$n_invoice_id = 0;
								foreach($contract_info->invoices as $k=>$inv) 
								{
									if($k != 0)
									{
										$n_invoice = new stdClass;
										$n_invoice->contract_id = $contract_info->id;
										$n_invoice->booking_id = $contract_info->reserv_id;
										$n_invoice->user_id = $invoice_users;
							    		$n_invoice->type    = 1; // invoice
							    		$n_invoice->ip 		= $_SERVER['REMOTE_ADDR'];

										// Отключаем селсфлов (в файлах платежек), для будущих инвойсов
							    		$n_invoice->automatically = 0;
							    		$n_invoice->sended = 0;


										$creation_date = date_create($inv->date_from);
										date_sub($creation_date, date_interval_create_from_date_string('2 days'));
										$n_invoice->date = $creation_date->format('Y-m-d');

						    			$n_invoice->date_from = date('Y-m-d', strtotime($inv->date_from));
						    			$n_invoice->date_to = date('Y-m-d', strtotime($inv->date_to));


										if(!isset($inv->interval) || $inv->interval > 5)
										{
											$new_invoice_id = $this->orders->add_order($n_invoice);
											if(!empty($new_invoice_id) && !empty($landlord) && !empty($landlord->landlord_code))
									    	{
												$n_invoice_sku = $new_invoice_id.'/'.$landlord->landlord_code;
												$this->orders->update_order($new_invoice_id, array('sku'=>$n_invoice_sku));
											}
											
										}

										
										if(!empty($new_invoice_id))
										{
											if($contract_info->type == 3 && !empty($apartment))
										    	$pur_name = $apartment->name.' - '.$contract_info->rental_name.' - Outpost Club from '.date('d F, Y', strtotime($inv->date_from)).' and to '.date('d F, Y', strtotime($inv->date_to));
										    else
												$pur_name = '1 tenant at '.$room_type.' - '.$contract_info->rental_name.' - Outpost Club from '.date('d F, Y', strtotime($inv->date_from)).' and to '.date('d F, Y', strtotime($inv->date_to));

											// if($contract_info->type == 4)
									  		//  $inv_price = ceil($inv->price / count($contract_users));
									 		// else
									    		$inv_price = $inv->price;

							    			$this->orders->add_purchase(array('order_id'=>$new_invoice_id, 'variant_id'=>0, 'product_name'=>$pur_name, 'price'=>$inv_price, 1));

										}
										
									}
								}
							}
							// добавить флажек, что инвойс отправлен!!!!!

				    		// после оплаты депозита сгенерить бекграундчек прям в платежке (устарело 15.05.2020, теперь бекграунд генерится в этом файле) 

				    		// Создаем бекграундчек, как последний шаг sellflow

							// $notification_id = $this->notifications->add_notification(array('user_id'=>$contract_user->id, 'type'=>2));
							// if(!empty($notification_id))
							// {
							// 	$notification = $this->notifications->get_notification($notification_id);
							// 	$this->design->assign('bg_check', $notification);
							// }

						}
						elseif(count($signers) == 1 || $contract_info->type == 4)
						{

							if($contract_info->outpost_deposit == 1 && $contract_info->price_deposit > 0 && $contract_info->first_sellflow != 1)
					    	{
								$new_deposit = new stdClass;
								$new_deposit->contract_id = $contract_info->id;
								$new_deposit->user_id = $invoice_users;
					    		$new_deposit->email   = $contract_user->email;
					    		$new_deposit->type    = 1; // invoice
					    		$new_deposit->ip 		= $_SERVER['REMOTE_ADDR'];
					    		$new_deposit->name 	= $contract_user->name;
					    		$new_deposit->sended = 0;
					    		$new_deposit->automatically = 0;
					    		$new_deposit->deposit = 1;

					    		//Добавляем заказ в базу
					    		if($contract_info->type != 2 && $contract_info->price_deposit > 0)
								{
									// if(!empty($landlord) && !empty($landlord->landlord_code))
									// {
									// 	$new_deposit->sku = $new_deposit_id.'/'.$landlord->landlord_code;
									// }

						    		$new_deposit_id = $this->orders->add_order($new_deposit);
						    		if(!empty($new_deposit_id) && !empty($landlord) && !empty($landlord->landlord_code))
							    	{
										$new_deposit_sku = $new_deposit_id.'/'.$landlord->landlord_code;
										$this->orders->update_order($new_deposit_id, array('sku'=>$new_deposit_sku));
									}

									// if($contract_info->type == 4)
							  //   		$price_deposit = ceil($contract_info->price_deposit / count($contract_users));
							  //   	else
							    		$price_deposit = $contract_info->price_deposit;
						    		
						    		$this->orders->add_purchase(array('order_id'=>$new_deposit_id, 'variant_id'=>0, 'product_name'=>'Security deposit', 'price'=>$price_deposit, 1));
					    		}
					    	}


				    		if(!empty($contract_info->roomtype))
					    		$room_type = $contract_info->roomtype->name;

							elseif($contract_info->room_type==1)
								$room_type = '2-people room';
							elseif ($contract_info->room_type==2)
								$room_type = '3-people room';
							elseif ($contract_info->room_type==3)
								$room_type = '4-people room';
							elseif ($contract_info->room_type==4)
								$room_type = '3-people shared room';
							elseif ($contract_info->room_type==5)
								$room_type = '4-people shared room';
							elseif ($contract_info->room_type==6)
								$room_type = 'Private room';
							elseif ($contract_info->room_type==7)
								$room_type = 'Private room with bathroom';


							

							// if($contract_info->membership == 2)
							// {
							// 	$membership_price = 79;
							// 	$pur_membership_name = 'Silver Membership one time annual payment';
							// }
							// elseif($contract_info->membership == 4)
							// {
							// 	$membership_price = 29;
							// 	$pur_membership_name = 'Silver Membership one time annual payment';
							// }
							// elseif($contract_info->membership == 1)
							// {
							// 	$membership_price = 690;
							// 	$pur_membership_name = 'Gold Membership one time annual payment';
							// }
					    	// $membership_added = 0;
					    	
							// Создание всех инвойсов для пользователя 
							foreach($contract_info->invoices as $k=>$inv) 
							{
								$new_invoice = new stdClass;
								$new_invoice->contract_id = $contract_info->id;
								$new_invoice->booking_id = $contract_info->reserv_id;
								$new_invoice->user_id = $invoice_users;
					    		//$new_invoice->email   = $contract_user->email;
					    		$new_invoice->type    = 1; // invoice
					    		$new_invoice->ip 		= $_SERVER['REMOTE_ADDR'];
					    		//$new_invoice->name 	= $contract_user->name;
								// Отключаем селсфлов (в файлах платежек), для будущих инвойсов
					    		$new_invoice->automatically = 0;
					    		$new_invoice->sended = 0;

								$creation_date = date_create($inv->date_from);

								date_sub($creation_date, date_interval_create_from_date_string('2 days'));
								if($k != 0)
									$new_invoice->date = $creation_date->format('Y-m-d');

								$new_invoice->date_from = date('Y-m-d', strtotime($inv->date_from));
					    		$new_invoice->date_to = date('Y-m-d', strtotime($inv->date_to));

								if(!isset($inv->interval) || $inv->interval > 5)
								{
									// if(!empty($landlord) && !empty($landlord->landlord_code))
									// {
									// 	$new_invoice->sku = $new_invoice_id.'/'.$landlord->landlord_code;
									// }
									$new_invoice_id = $this->orders->add_order($new_invoice);
									if(!empty($new_invoice_id) && !empty($landlord) && !empty($landlord->landlord_code))
							    	{
										$new_invoice_sku = $new_invoice_id.'/'.$landlord->landlord_code;
										$this->orders->update_order($new_invoice_id, array('sku'=>$new_invoice_sku));
									}
								}
									
								if($contract_info->type == 3 && !empty($apartment))
									$pur_name = $apartment->name.' - '.$contract_info->rental_name.' - Outpost Club from '.date('d F, Y', strtotime($inv->date_from)).' and to '.date('d F, Y', strtotime($inv->date_to));
								else
									$pur_name = '1 tenant at '.$room_type.' - '.$contract_info->rental_name.' - Outpost Club from '.date('d F, Y', strtotime($inv->date_from)).' and to '.date('d F, Y', strtotime($inv->date_to));

								if($contract_info->type == 3 && $k==0)
								{
									if(!empty($prepayment))
										$inv_price = intval($inv->price) - intval($this->contracts->deposit_firs_part);
									else
										$inv_price = intval($inv->price);
								}
						    	else
						    		$inv_price = $inv->price;

						    	// elseif($contract_info->type == 4)
						    	// 	$inv_price = ceil($inv->price / count($contract_users));

				    			$this->orders->add_purchase(array('order_id'=>$new_invoice_id, 'variant_id'=>0, 'product_name'=>$pur_name, 'price'=>$inv_price, 1));

				    	// 		if($membership_added == 0)
				    	// 		{
									// if($contract_info->membership != 3)
					    // 				$this->orders->add_purchase(array('order_id'=>$new_invoice_id, 'variant_id'=>0, 'product_name'=>$pur_membership_name, 'price'=>$membership_price, 1));
					    // 			$membership_added = 1;
				    	// 		}

				    		}
				    	}



						// --- INVOICES (end)






						if(!file_exists($this->config->root_dir.'/'.$this->config->contracts_dir.$contract_info->url.'/'))
							mkdir($this->config->root_dir.'/'.$this->config->contracts_dir.$contract_info->url.'/', 0755);

						// Signature: file 1
						if(!empty($_POST['signature']))
						{
							$img = $_POST['signature'];
							$img = str_replace('data:image/png;base64,', '', $img);
							$img = str_replace(' ', '+', $img);
							$data = base64_decode($img);
							$file = $this->config->contracts_dir.$contract_info->url.'/signature-'.$contract_user->id.'.png';
							$success = file_put_contents($file, $data);
							chmod($this->config->contracts_dir.$contract_info->url.'/signature-'.$contract_user->id.'.png', 0755);
						}

						if($contract_info->type != 2)
						{
							if(!empty($_POST['signature2']))
							{
								// Signature: file 2
								$img2 = $_POST['signature2'];
								$img2 = str_replace('data:image/png;base64,', '', $img2);
								$img2 = str_replace(' ', '+', $img2);
								$data2 = base64_decode($img2);
								$file2 = $this->config->contracts_dir.$contract_info->url.'/signature2-'.$contract_user->id.'.png';
								$success2 = file_put_contents($file2, $data2);
								chmod($this->config->contracts_dir.$contract_info->url.'/signature2-'.$contract_user->id.'.png', 0755);
							}

							if($contract_info->type != 3)
							{
								if(!empty($_POST['signature3']))
								{
									// Signature: file 3
									$img3 = $_POST['signature3'];
									$img3 = str_replace('data:image/png;base64,', '', $img3);
									$img3 = str_replace(' ', '+', $img3);
									$data3 = base64_decode($img3);
									$file3 = $this->config->contracts_dir.$contract_info->url.'/signature3-'.$contract_user->id.'.png';
									$success3 = file_put_contents($file3, $data3);
									chmod($this->config->contracts_dir.$contract_info->url.'/signature3-'.$contract_user->id.'.png', 0755);
								}

								if(!empty($_POST['signature4']))
								{
									// Signature: file 4
									$img4 = $_POST['signature4'];
									$img4 = str_replace('data:image/png;base64,', '', $img4);
									$img4 = str_replace(' ', '+', $img4);
									$data4 = base64_decode($img4);
									$file4 = $this->config->contracts_dir.$contract_info->url.'/signature4-'.$contract_user->id.'.png';
									$success4 = file_put_contents($file4, $data4);
									chmod($this->config->contracts_dir.$contract_info->url.'/signature4-'.$contract_user->id.'.png', 0755);
								}
							}
						}

						if($step == 1)
				    	{
				    		echo 'success'; 
				    		exit;
				    	}

			    	}


			    	if(!isset($step) || $step == 2)
			    	{
			    		

						if(file_exists($this->config->contracts_dir.$contract_info->url.'/signature-'.$contract_user->id.'.png'))
						{
							$contract_info->signature = $this->config->contracts_dir.$contract_info->url.'/signature-'.$contract_user->id.'.png';

							if($contract_info->type != 2)
							{
								if(file_exists($this->config->contracts_dir.$contract_info->url.'/signature2-'.$contract_user->id.'.png'))
									$contract_info->signature2 = $this->config->contracts_dir.$contract_info->url.'/signature2-'.$contract_user->id.'.png';
								else
									$contract_info->signature2 = $contract_info->signature;

								if($contract_info->type != 3)
								{
									if(file_exists($this->config->contracts_dir.$contract_info->url.'/signature3-'.$contract_user->id.'.png'))
										$contract_info->signature3 = $this->config->contracts_dir.$contract_info->url.'/signature3-'.$contract_user->id.'.png';
									else
										$contract_info->signature3 = $contract_info->signature;

									if(file_exists($this->config->contracts_dir.$contract_info->url.'/signature4-'.$contract_user->id.'.png'))
										$contract_info->signature4 = $this->config->contracts_dir.$contract_info->url.'/signature4-'.$contract_user->id.'.png';
									else
										$contract_info->signature4 = $contract_info->signature;
								}
							}
							


							$options = new Options();
							$options->set('defaultFont', 'Helvetica');

							// instantiate and use the dompdf class
							$dompdf = new Dompdf($options);


							$this->design->assign('contract_info', $contract_info);
							$this->design->assign('contract_user', $contract_user);
							$this->design->assign('contract_users', $contract_users);


							/*if($contract_info->membership == 1) // 1 - Gold
								$contract_html = $this->design->fetch('contracts/contract_gold_html.tpl');
							else // 2 - Silver; 3 - Bronze
								$contract_html = $this->design->fetch('contracts/contract_silver_html.tpl');*/


							if($contract_info->type == 1)
							{
								$contract_html_singed = $this->design->fetch('contracts/contract_html_singed.tpl');
								$contract_html = $this->design->fetch('contracts/contract_html.tpl');
							}
							elseif($contract_info->type == 2)
							{
								$contract_html_singed = $this->design->fetch('contracts/dop_contract_html_singed.tpl');
								$contract_html = $this->design->fetch('contracts/dop_contract_html.tpl');
							}
							elseif($contract_info->type == 3)
							{
								$contract_html_singed = $this->design->fetch('contracts/contract_full_apt_signed.tpl');
								$contract_html = $this->design->fetch('contracts/contract_full_apt.tpl');
							}
							elseif($contract_info->type == 4)
							{
								$contract_html_singed = $this->design->fetch('contracts/contract_html_singed_short_term.tpl');
								$contract_html = $this->design->fetch('contracts/contract_html_short_term.tpl');
							}
							else
							{
								$contract_html_singed = $this->design->fetch('contracts/contract_landlord.tpl');
								$contract_html = $this->design->fetch('contracts/contract_landlord.tpl');
							}

							// $dompdf->setBasePath(dirname(dirname(__FILE__)).'/design/'.$this->settings->theme.'/css/contracts.css');

							$dompdf->loadHtml($contract_html_singed);

							// (Optional) Setup the paper size and orientation ("landscape" or "portrait")
							$dompdf->setPaper('A4', 'portrait'); 

							// Render the HTML as PDF
							$dompdf->render();

							$canvas = $dompdf->get_canvas();
							$font = $dompdf->getFontMetrics()->get_font("helvetica", "italic");

							$canvas->page_text(35, 800, "{PAGE_NUM}    -    ".substr($contract_user->first_name, 0, 1).'. '.substr($contract_user->last_name, 0, 1).'.', $font, 10, array(0,0,0));


							// Output the generated PDF to Browser
							$stream_options = array();
							$stream_options['save_path'] = $this->config->contracts_dir.$contract_info->url.'/';
							$dompdf->stream('contract.pdf', $stream_options);

							//сhmod($stream_options['save_path'].'/contract.pdf', 0755);

							// admin notify
							$this->design->assign('contract', $contract_info);
							$this->design->assign('contract_user', $contract_user);
							$email_template = $this->design->fetch($this->config->root_dir.'backend/design/html/contracts/email_contract_admin.tpl');
							$subject = $this->design->get_var('subject');
							$this->notify->email($this->settings->order_email, $subject, $email_template, $this->settings->notify_from_email);

						}

						if($step == 1)
				    	{
				    		echo 'success'; 
				    		exit;
				    	}
				    	

						header('Location: '.$this->config->root_url.'/contract/'.$contract_info->url.'/'.$user_id);

					}
				}

				elseif(!empty($_POST['email_notify']))
				{

					// $email_notify = $_POST['email_notify'];
					// $this->design->assign('contract', $contract_info);
					// $email_template = $this->design->fetch($this->config->root_dir.'design/'.$this->settings->theme.'/html/contracts/email_contract.tpl');
					// $subject = $this->design->get_var('subject');
					// $this->notify->email($email_notify, $subject, $email_template, $this->settings->notify_from_email);

					// $this->design->assign('sended', true);
					
				}
			}

			if(file_exists($this->config->contracts_dir.$contract_info->url.'/signature.png') )
				$contract_info->signature = $this->config->contracts_dir.$contract_info->url.'/signature.png';
			elseif(file_exists($this->config->contracts_dir.$contract_info->url.'/signature-'.$contract_user->id.'.png'))
				$contract_info->signature = $this->config->contracts_dir.$contract_info->url.'/signature-'.$contract_user->id.'.png';


			if($contract_info->type != 2)
			{
				if(file_exists($this->config->contracts_dir.$contract_info->url.'/signature2.png'))
					$contract_info->signature2 = $this->config->contracts_dir.$contract_info->url.'/signature2.png';
				elseif(file_exists($this->config->contracts_dir.$contract_info->url.'/signature2-'.$contract_user->id.'.png'))
					$contract_info->signature2 = $this->config->contracts_dir.$contract_info->url.'/signature2-'.$contract_user->id.'.png';
				elseif(!empty($contract_info->signature))
					$contract_info->signature2 = $contract_info->signature;

				if($contract_info->type != 3)
				{

					if(file_exists($this->config->contracts_dir.$contract_info->url.'/signature3.png'))
						$contract_info->signature3 = $this->config->contracts_dir.$contract_info->url.'/signature3.png';
					elseif(file_exists($this->config->contracts_dir.$contract_info->url.'/signature3-'.$contract_user->id.'.png'))
						$contract_info->signature3 = $this->config->contracts_dir.$contract_info->url.'/signature3-'.$contract_user->id.'.png';
					elseif(!empty($contract_info->signature))
						$contract_info->signature3 = $contract_info->signature;

					if(file_exists($this->config->contracts_dir.$contract_info->url.'/signature4.png'))
						$contract_info->signature4 = $this->config->contracts_dir.$contract_info->url.'/signature4.png';
					elseif(file_exists($this->config->contracts_dir.$contract_info->url.'/signature4-'.$contract_user->id.'.png'))
						$contract_info->signature4 = $this->config->contracts_dir.$contract_info->url.'/signature4-'.$contract_user->id.'.png';
					elseif(!empty($contract_info->signature))
						$contract_info->signature4 = $contract_info->signature;

				}

			}
			
		}
		else
			return false;


		if($contract_info->sellflow == 1 && !empty($contract_info->signature))
		{
			if($contract_info->type == 3 || $this->config->sellflow_covid == true)
			{
				$new_invoice = current($this->orders->get_orders(array('contract_id'=>$contract_info->id, 'user_id'=>$contract_user->id, 'deposit'=>0, 'automatically'=>1, 'limit' => 1)));
				$this->design->assign('invoice', $new_invoice);
			}
			else
			{
				$new_invoice = current($this->orders->get_orders(array('contract_id'=>$contract_info->id, 'user_id'=>$contract_user->id, 'deposit'=>0, 'automatically'=>1, 'limit' => 1)));

				$this->design->assign('invoice', $new_invoice);
				// $notification = current($this->notifications->get_notifications(array('user_id'=>$contract_user->id, 'type'=>2)));
				// $this->design->assign('bg_check', $notification);
			}
			
		}


		if(!isset($contract_logs))
		{
			$contract_logs = $this->logs->get_logs(array(
				'parent_id' => $contract_info->id,
				'type' => 4,
				'subtype' => 4
			));
		}
		
		if(!empty($contract_logs))
		{
			foreach ($contract_logs as $log) {
				if($contract_users[$log->user_id])
				{
					$contract_users[$log->user_id]->log = $log;
				}
			}
		}




// выхватить дом и комнату, по ним выхватить апартамент, по апартаменту его жителей и их контакты, отправить контракты в шаблон, тот у кого самый ранний контракт значит подписал первым
// - в кабинете генерить пдф на лету??? или отдавать не пдф, а страницу контракта на сайте


		// if($contract_info->type != 1 && $contract_info->type != 2)
		// {
			$download = $this->request->get('download');

			if(!empty($reverv))
			{	
				if($download == 1)
				{
					$this->design->assign('contract_info', $contract_info);
					$this->design->assign('contract_user', $contract_user);
					$this->design->assign('contract_users', $contract_users);
					$this->design->assign('meta_title', 'Contract');
					$this->design->assign('pdf_style', 1);


					$options = new Options();
					$options->set('defaultFont', 'Helvetica');

					$dompdf = new Dompdf($options);

					$contract_html_singed = $this->design->fetch('contracts/contract_full_apt_signed.tpl');

					$dompdf->loadHtml($contract_html_singed);

					// (Optional) Setup the paper size and orientation ("landscape" or "portrait")
					$dompdf->setPaper('A4', 'portrait'); 

					// Render the HTML as PDF
					$dompdf->render();

					$canvas = $dompdf->get_canvas();
					$font = $dompdf->getFontMetrics()->get_font("helvetica");

					$canvas->page_text(35, 800, "{PAGE_NUM}", $font, 10, array(0,0,0));

					// Output the generated PDF to Browser
					$dompdf->stream();
				}
			}
		// }

		$_SESSION['user_id'] = $contract_user->id;


		$this->design->assign('contract_users', $contract_users);

		if($contract_info->id == 1000000000000000)
		{
			if($contract_info->outpost_deposit == 1 && $contract_info->price_deposit > 0)
	    	{
				$new_deposit = new stdClass;
				$new_deposit->contract_id = $contract_info->id;
				$new_deposit->user_id = $invoice_users;
	    		$new_deposit->email   = $contract_user->email;
	    		$new_deposit->type    = 1; // invoice
	    		$new_deposit->ip 		= $_SERVER['REMOTE_ADDR'];
	    		$new_deposit->name 	= $contract_user->name;
	    		$new_deposit->sended = 0;
	    		$new_deposit->automatically = 0;
	    		$new_deposit->deposit = 1;

	    		//Добавляем заказ в базу
	    		if($contract_info->type != 2 && $contract_info->price_deposit > 0)
				{
					// if(!empty($landlord) && !empty($landlord->landlord_code))
					// {
					// 	$new_deposit->sku = $new_deposit_id.'/'.$landlord->landlord_code;
					// }

		    		$new_deposit_id = $this->orders->add_order($new_deposit);
		    		if(!empty($new_deposit_id) && !empty($landlord) && !empty($landlord->landlord_code))
			    	{
						$new_deposit_sku = $new_deposit_id.'/'.$landlord->landlord_code;
						$this->orders->update_order($new_deposit_id, array('sku'=>$new_deposit_sku));
					}

					// if($contract_info->type == 4)
			  //   		$price_deposit = ceil($contract_info->price_deposit / count($contract_users));
			  //   	else
			    		$price_deposit = $contract_info->price_deposit;
		    		
		    		$this->orders->add_purchase(array('order_id'=>$new_deposit_id, 'variant_id'=>0, 'product_name'=>'Security deposit', 'price'=>$price_deposit, 1));
	    		}
	    	}


    		if(!empty($contract_info->roomtype))
	    		$room_type = $contract_info->roomtype->name;

			elseif($contract_info->room_type==1)
				$room_type = '2-people room';
			elseif ($contract_info->room_type==2)
				$room_type = '3-people room';
			elseif ($contract_info->room_type==3)
				$room_type = '4-people room';
			elseif ($contract_info->room_type==4)
				$room_type = '3-people shared room';
			elseif ($contract_info->room_type==5)
				$room_type = '4-people shared room';
			elseif ($contract_info->room_type==6)
				$room_type = 'Private room';
			elseif ($contract_info->room_type==7)
				$room_type = 'Private room with bathroom';


			

			// if($contract_info->membership == 2)
			// {
			// 	$membership_price = 79;
			// 	$pur_membership_name = 'Silver Membership one time annual payment';
			// }
			// elseif($contract_info->membership == 4)
			// {
			// 	$membership_price = 29;
			// 	$pur_membership_name = 'Silver Membership one time annual payment';
			// }
			// elseif($contract_info->membership == 1)
			// {
			// 	$membership_price = 690;
			// 	$pur_membership_name = 'Gold Membership one time annual payment';
			// }


	  //   	$membership_added = 0;
			// Создание всех инвойсов для пользователя 
			foreach($contract_info->invoices as $k=>$inv) 
			{
				$new_invoice = new stdClass;
				$new_invoice->contract_id = $contract_info->id;
				$new_invoice->booking_id = $contract_info->reserv_id;
				$new_invoice->user_id = $invoice_users;
	    		//$new_invoice->email   = $contract_user->email;
	    		$new_invoice->type    = 1; // invoice
	    		$new_invoice->ip 		= $_SERVER['REMOTE_ADDR'];
	    		//$new_invoice->name 	= $contract_user->name;
				// Отключаем селсфлов (в файлах платежек), для будущих инвойсов
	    		$new_invoice->automatically = 0;
	    		$new_invoice->sended = 0;

				$creation_date = date_create($inv->date_from);

				date_sub($creation_date, date_interval_create_from_date_string('2 days'));
				if($k != 0)
					$new_invoice->date = $creation_date->format('Y-m-d');

				$new_invoice->date_from = date('Y-m-d', strtotime($inv->date_from));
	    		$new_invoice->date_to = date('Y-m-d', strtotime($inv->date_to));

				if(!isset($inv->interval) || $inv->interval > 5)
				{
					// if(!empty($landlord) && !empty($landlord->landlord_code))
					// {
					// 	$new_invoice->sku = $new_invoice_id.'/'.$landlord->landlord_code;
					// }
					$new_invoice_id = $this->orders->add_order($new_invoice);
					if(!empty($new_invoice_id) && !empty($landlord) && !empty($landlord->landlord_code))
			    	{
						$new_invoice_sku = $new_invoice_id.'/'.$landlord->landlord_code;
						$this->orders->update_order($new_invoice_id, array('sku'=>$new_invoice_sku));
					}
				}
					
				if($contract_info->type == 3 && !empty($apartment))
					$pur_name = $apartment->name.' - '.$contract_info->rental_name.' - Outpost Club from '.date('d F, Y', strtotime($inv->date_from)).' and to '.date('d F, Y', strtotime($inv->date_to));
				else
					$pur_name = '1 tenant at '.$room_type.' - '.$contract_info->rental_name.' - Outpost Club from '.date('d F, Y', strtotime($inv->date_from)).' and to '.date('d F, Y', strtotime($inv->date_to));

				if($contract_info->type == 3 && $k==0)
				{
					if(!empty($prepayment))
						$inv_price = intval($inv->price) - intval($this->contracts->deposit_firs_part);
					else
						$inv_price = intval($inv->price);
				}
		    	else
		    		$inv_price = $inv->price;

		    	// elseif($contract_info->type == 4)
		    	// 	$inv_price = ceil($inv->price / count($contract_users));

    			$this->orders->add_purchase(array('order_id'=>$new_invoice_id, 'variant_id'=>0, 'product_name'=>$pur_name, 'price'=>$inv_price, 1));

    	// 		if($membership_added == 0)
    	// 		{
					// if($contract_info->membership != 3)
	    // 				$this->orders->add_purchase(array('order_id'=>$new_invoice_id, 'variant_id'=>0, 'product_name'=>$pur_membership_name, 'price'=>$membership_price, 1));
	    // 			$membership_added = 1;
    	// 		}

    		}

    		// $options = new Options();
						// 	$options->set('defaultFont', 'Helvetica');

						// 	// instantiate and use the dompdf class
						// 	$dompdf = new Dompdf($options);


						// 	$this->design->assign('contract_info', $contract_info);
						// 	$this->design->assign('contract_user', $contract_user);
						// 	$this->design->assign('contract_users', $contract_users);


						// 	/*if($contract_info->membership == 1) // 1 - Gold
						// 		$contract_html = $this->design->fetch('contracts/contract_gold_html.tpl');
						// 	else // 2 - Silver; 3 - Bronze
						// 		$contract_html = $this->design->fetch('contracts/contract_silver_html.tpl');*/


						// 	if($contract_info->type == 1)
						// 	{
						// 		$contract_html_singed = $this->design->fetch('contracts/contract_html_singed.tpl');
						// 		$contract_html = $this->design->fetch('contracts/contract_html.tpl');
						// 	}
						// 	elseif($contract_info->type == 2)
						// 	{
						// 		$contract_html_singed = $this->design->fetch('contracts/dop_contract_html_singed.tpl');
						// 		$contract_html = $this->design->fetch('contracts/dop_contract_html.tpl');
						// 	}
						// 	elseif($contract_info->type == 3)
						// 	{
						// 		$contract_html_singed = $this->design->fetch('contracts/contract_full_apt_signed.tpl');
						// 		$contract_html = $this->design->fetch('contracts/contract_full_apt.tpl');
						// 	}
						// 	elseif($contract_info->type == 4)
						// 	{
						// 		$contract_html_singed = $this->design->fetch('contracts/contract_html_singed_short_term.tpl');
						// 		$contract_html = $this->design->fetch('contracts/contract_html_short_term.tpl');
						// 	}
						// 	else
						// 	{
						// 		$contract_html_singed = $this->design->fetch('contracts/contract_landlord.tpl');
						// 		$contract_html = $this->design->fetch('contracts/contract_landlord.tpl');
						// 	}

						// 	// $dompdf->setBasePath(dirname(dirname(__FILE__)).'/design/'.$this->settings->theme.'/css/contracts.css');

						// 	$dompdf->loadHtml($contract_html_singed);

						// 	// (Optional) Setup the paper size and orientation ("landscape" or "portrait")
						// 	$dompdf->setPaper('A4', 'portrait'); 

						// 	// Render the HTML as PDF
						// 	$dompdf->render();

						// 	$canvas = $dompdf->get_canvas();
						// 	$font = $dompdf->getFontMetrics()->get_font("helvetica", "italic");

						// 	$canvas->page_text(35, 800, "{PAGE_NUM}    -    ".substr($contract_user->first_name, 0, 1).'. '.substr($contract_user->last_name, 0, 1).'.', $font, 10, array(0,0,0));


						// 	// Output the generated PDF to Browser
						// 	$stream_options = array();
						// 	$stream_options['save_path'] = $this->config->contracts_dir.$contract_info->url.'/';
						// 	$dompdf->stream('contract.pdf', $stream_options);

		}


		$this->design->assign('contract_info', $contract_info);
		$this->design->assign('contract_user', $contract_user);
		
		$this->design->assign('meta_title', 'Contract');


		$tpl = 'contracts/contract_page.tpl';

		echo $this->design->fetch($tpl); exit;
	}
}