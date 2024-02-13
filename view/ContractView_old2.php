<?PHP


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

	
	public function valid_date($d, $m, $y)
	{
		if(!checkdate($m, $d, $y))
			return $this->valid_date($d-1, $m, $y);
		else
			return $d;
	}



	function fetch()
	{
		$url = $this->request->get('url', 'string');

		$contract_info = $this->contracts->get_contract($url);

		if(!empty($contract_info->roomtype))
			$contract_info->roomtype = $this->beds->get_rooms_types(array('id'=>$contract_info->roomtype, 'limit'=>1));

		
		if(!empty($contract_info))
		{
			$viewed = $this->request->get('w', 'integer');
			if($viewed == 1 && empty($_SESSION['admin']))
			{
				$this->contracts->update_contract($contract_info->id, array('date_viewed'=>'now'));
				header('Location: '.$this->config->root_url.'/contract/'.$contract_info->url);
				exit;
			}



			if(!empty($contract_info->user_id))
			{
				$contract_user = $this->users->get_user(intval($contract_info->user_id));	
			}
			else
				return false;




			// Month count

			$d1 = date_create($contract_info->date_from);
			$d2 = date_create($contract_info->date_to);
			
			$main_date = $d1->format('j');

			$interval = date_diff($d1, $d2);


			$contract_info->invoices = array();
			$contract_info->invoices_total = 0;

			$date_start = date_create($contract_info->date_from);

			if($interval->y > 0)
				$interval->m += $interval->y * 12;
			if($interval->m > 0)
			{
				$month_count = $interval->m;
				for($n=0; $n<$month_count; $n++)
				{
					$invoice = new stdClass;
					$invoice->price = $contract_info->price_month;
					$contract_info->invoices_total += $invoice->price;

					$invoice->date_from = $date_start->format('Y-m-d');

					$n_date = $main_date;
					$n_month = $date_start->format('n');
					$n_year = $date_start->format('Y');


					$date_for_payment = date_create($date_start->format('Y-m-d'));
					date_add($date_for_payment, date_interval_create_from_date_string('- 10 days'));
					$invoice->date_for_payment = $date_for_payment->format('Y-m-d');

					if($n_month == 12)
					{
						$n_month = 1;
						$n_year++;
					}
					else
					{
						$n_month++;
					}

					$n_date = $this->valid_date($n_date, $n_month, $n_year);
					$date_end = date_create("$n_year-$n_month-$n_date");
					$date_start = $date_end;

					$date_to_m = date_create($date_end->format('Y-m-d'));
					date_sub($date_to_m, date_interval_create_from_date_string('1 days'));

					$invoice->date_to = $date_to_m->format('Y-m-d');
					$contract_info->invoices[] = $invoice;
				}
			}
			// Days count
			if($interval->d >= 0 && (strtotime($contract_info->date_to) >= strtotime($date_start->format('Y-m-d'))))
			{
				$invoice = new stdClass;

				$invoice->date_from = $date_start->format('Y-m-d');

				$date_for_payment = date_create($date_start->format('Y-m-d'));
				date_add($date_for_payment, date_interval_create_from_date_string('-10 days'));
				$invoice->date_for_payment = $date_for_payment->format('Y-m-d');

				$date_end = date_create($date_start->format('Y-m-d'));
				date_add($date_end, date_interval_create_from_date_string($interval->d.' days'));


				// || (date("m",strtotime($date_start->format('Y-m-d'))) != date("m",strtotime($date_end->format('Y-m-d'))))
				if($contract_info->date_to != $date_end->format('Y-m-d'))
				{
					$interval = date_diff($date_start, date_create($contract_info->date_to));
					$invoice->date_to = $contract_info->date_to;

					$date_end_interval = date_create($contract_info->date_to);
					date_add($date_end_interval, date_interval_create_from_date_string('1 days'));
					if((date("m",strtotime($date_end_interval->format('Y-m-d'))) == date("m",strtotime($invoice->date_to)) && $interval->d < 28 && $interval->m == 0) || ($interval->d < 27 && ($interval->m != 1 && $interval->d !=0)))
					{
						$invoice->price = ceil(ceil($contract_info->price_month * 12 / 365) * ($interval->d+1));
					}
					else
						$invoice->price = $contract_info->price_month;


					$invoice->interval = $interval->days;
				}
				else
				{

					$invoice->date_to = $date_end->format('Y-m-d');
					date_add($date_end, date_interval_create_from_date_string('1 days'));
					if((date("m",strtotime($date_end->format('Y-m-d'))) == date("m",strtotime($invoice->date_to)) && $interval->d < 28) || $interval->d < 27 || $interval->d == 0)
					{

						$invoice->price = ceil(ceil($contract_info->price_month * 12 / 365) * ($interval->d+1));
					}
					else
						$invoice->price = $contract_info->price_month;

					$invoice->interval = $interval->d;
				}

				
				$contract_info->invoices_total += $invoice->price;



				if($invoice->interval < 5 && count($contract_info->invoices) != 1)
				{
					$contract_info->invoices[count($contract_info->invoices)-1]->price += $invoice->price;
					$contract_info->invoices[count($contract_info->invoices)-1]->date_to = $invoice->date_to;
				}
				else
				{
					$contract_info->invoices[] = $invoice;
				}
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


			if($this->request->method('post') && !empty($_POST))
			{
				if(!empty($_POST['signature']))
				{
					// Add date signing
					$contract_info->signing = 1;
					$contract_info->date_signing = date("Y-m-d H:i:s");
					$this->contracts->update_contract($contract_info->id, array('date_signing'=>$contract_info->date_signing, 'signing'=>1));

					if($contract_user->status == 0) // User: New to Pending
						$this->users->update_user($contract_user->id, array('status'=>1));

					elseif($contract_user->status == 1) // User: Pending to Approved
					{
						// Invoice
						$orders = $this->orders->get_orders(array('user_id'=>$contract_user->id, 'type'=>1, 'limit'=>1));
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

					if(!file_exists($this->config->root_dir.'/'.$this->config->contracts_dir.$contract_info->url.'/'))
						mkdir($this->config->root_dir.'/'.$this->config->contracts_dir.$contract_info->url.'/', 0755);


					// Signature: file 1
					$img = $_POST['signature'];
					$img = str_replace('data:image/png;base64,', '', $img);
					$img = str_replace(' ', '+', $img);
					$data = base64_decode($img);
					$file = $this->config->contracts_dir.$contract_info->url.'/signature.png';
					$success = file_put_contents($file, $data);
					chmod($this->config->contracts_dir.$contract_info->url.'/signature.png', 0755);

					if($contract_info->type != 2)
					{
						// Signature: file 2
						$img2 = $_POST['signature2'];
						$img2 = str_replace('data:image/png;base64,', '', $img2);
						$img2 = str_replace(' ', '+', $img2);
						$data2 = base64_decode($img2);
						$file2 = $this->config->contracts_dir.$contract_info->url.'/signature2.png';
						$success2 = file_put_contents($file2, $data2);
						chmod($this->config->contracts_dir.$contract_info->url.'/signature2.png', 0755);

						// Signature: file 3
						$img3 = $_POST['signature3'];
						$img3 = str_replace('data:image/png;base64,', '', $img3);
						$img3 = str_replace(' ', '+', $img3);
						$data3 = base64_decode($img3);
						$file3 = $this->config->contracts_dir.$contract_info->url.'/signature3.png';
						$success3 = file_put_contents($file3, $data3);
						chmod($this->config->contracts_dir.$contract_info->url.'/signature3.png', 0755);


						// Signature: file 4
						$img4 = $_POST['signature4'];
						$img4 = str_replace('data:image/png;base64,', '', $img4);
						$img4 = str_replace(' ', '+', $img4);
						$data4 = base64_decode($img4);
						$file4 = $this->config->contracts_dir.$contract_info->url.'/signature4.png';
						$success4 = file_put_contents($file4, $data4);
						chmod($this->config->contracts_dir.$contract_info->url.'/signature4.png', 0755);
					}


					if(file_exists($this->config->contracts_dir.$contract_info->url.'/signature.png'))
					{
						$contract_info->signature = true;

						if($contract_info->type != 2)
						{
							if(file_exists($this->config->contracts_dir.$contract_info->url.'/signature2.png'))
								$contract_info->signature2 = true;

							if(file_exists($this->config->contracts_dir.$contract_info->url.'/signature3.png'))
								$contract_info->signature3 = true;

							if(file_exists($this->config->contracts_dir.$contract_info->url.'/signature4.png'))
								$contract_info->signature4 = true;
						}
						


						$options = new Options();
						$options->set('defaultFont', 'Helvetica');

						// instantiate and use the dompdf class
						$dompdf = new Dompdf($options);

						$this->design->assign('contract_info', $contract_info);
						$this->design->assign('contract_user', $contract_user);

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
						else
						{
							$contract_html_singed = $this->design->fetch('contracts/contract_landlord.tpl');
							$contract_html = $this->design->fetch('contracts/contract_landlord.tpl');
						}

						//$dompdf->setBasePath(dirname(dirname(__FILE__)).'/design/'.$this->settings->theme.'/css/contracts.css');

						$dompdf->loadHtml($contract_html_singed);

						// (Optional) Setup the paper size and orientation ("landscape" or "portrait")
						$dompdf->setPaper('A4', 'portrait'); 

						// Render the HTML as PDF
						$dompdf->render();

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


					if($contract_info->sellflow == 1)
					{
						// Sellflow (invoice create)
						$new_invoice = new stdClass;
						$new_invoice->contract_id = $contract_info->id;
						$new_invoice->user_id = $contract_user->id;
			    		$new_invoice->email   = $contract_user->email;
			    		$new_invoice->type    = 1; // invoice
			    		$new_invoice->ip 		= $_SERVER['REMOTE_ADDR'];
			    		$new_invoice->name 	= $contract_user->name;
			    		$new_invoice->sended = 1;
			    		//Говорим, что инвойс отправлен
			    		$new_invoice->automatically = 1;
				    	// Создан автоматически. Этим определяем, что нужно передать в ссылке после успешной оплаты метку об оплате депозита 

				    	$cur_invoice = current($contract_info->invoices);
				    	$price = $contract_info->price_month;
				    	$days = ($cur_invoice->date_from - $cur_invoice->date_to)/60/60/24;
				    	if($days == 0)
				    		$days = 30;

				    	$cur_invoice_date_from = date('M d, Y', strtotime($cur_invoice->date_from));
				    	$cur_invoice_date_to = date('M d, Y', strtotime($cur_invoice->date_to));

				    	$new_invoice->date_from = date('Y-m-d', strtotime($cur_invoice->date_from));
				    	$new_invoice->date_to = date('Y-m-d', strtotime($cur_invoice->date_to));


				    	$new_deposit = new stdClass;
				    	$new_deposit->contract_id = $contract_info->id;
						$new_deposit->user_id = $contract_user->id;
			    		$new_deposit->email   = $contract_user->email;
			    		$new_deposit->type    = 1; // invoice
			    		$new_deposit->ip 		= $_SERVER['REMOTE_ADDR'];
			    		$new_deposit->name 	= $contract_user->name;
			    		$new_deposit->sended = 1;
			    		$new_deposit->automatically = 1;
			    		$new_deposit->deposit = 1;
			    		$new_deposit->date_to = $new_invoice->date_to;



			    		// Добавляем заказ в базу
			    		$new_deposit_id = $this->orders->add_order($new_deposit);
				    	$new_invoice_id = $this->orders->add_order($new_invoice);
				    	$_SESSION['order_id'] = $new_invoice_id;

				    	if(!empty($landlord) && !empty($landlord->landlord_code))
				    	{
							$new_deposit->sku = $new_deposit_id.'/'.$landlord->landlord_code;
							$this->orders->update_order($new_deposit_id, $new_deposit);

							$new_invoice->sku = $new_invoice_id.'/'.$landlord->landlord_code;
							$this->orders->update_order($new_invoice_id, $new_invoice);
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


				    	

				    	$pur_name = '1 tenant at '.$room_type.' - '.$contract_info->rental_name.' - Outpost Club from '.$cur_invoice_date_from.' and to '.$cur_invoice_date_to;

				    	$this->orders->add_purchase(array('order_id'=>$new_invoice_id, 'variant_id'=>0, 'product_name'=>$pur_name, 'price'=>$price, 1));


				    	if($contract_info->membership == 2)
						{
							$membership_price = 29;
							$pur_membership_name = 'Silver Membership one time annual payment';
						}
						elseif($contract_info->membership == 1)
						{
							$membership_price = 690;
							$pur_membership_name = 'Gold Membership one time annual payment';
						}

						if($contract_info->membership != 3)
				    		$this->orders->add_purchase(array('order_id'=>$new_invoice_id, 'variant_id'=>0, 'product_name'=>$pur_membership_name, 'price'=>$membership_price, 1));


				    	$this->orders->add_purchase(array('order_id'=>$new_deposit_id, 'variant_id'=>0, 'product_name'=>'Security deposit', 'price'=>$contract_info->price_deposit, 1));


				    	$new_invoice = $this->orders->get_order($new_invoice_id);
						$this->design->assign('invoice', $new_invoice);


						$new_invoice = new stdClass;
						$new_invoice->contract_id = $contract_info->id;
						$new_invoice->user_id = $contract_user->id;
			    		$new_invoice->email   = $contract_user->email;
			    		$new_invoice->type    = 1; // invoice
			    		$new_invoice->ip 		= $_SERVER['REMOTE_ADDR'];
			    		$new_invoice->name 	= $contract_user->name;
						// Отключаем селсфлов (в файлах платежек), для будущих инвойсов
			    		$new_invoice->automatically = 0;
			    		$new_invoice->sended = 0;

						//Создание всех инвойсов для пользователя 
						foreach ($contract_info->invoices as $k=>$inv) 
						{
							if($k != 0)
							{
								$creation_date = date_create($inv->date_from);
								date_sub($creation_date, date_interval_create_from_date_string('10 days'));
								$new_invoice->date = $creation_date->format('Y-m-d');

				    			$new_invoice->date_from = date('Y-m-d', strtotime($inv->date_from));
				    			$new_invoice->date_to = date('Y-m-d', strtotime($inv->date_to));


								if(!isset($inv->interval) || $inv->interval > 5)
								{
									$new_invoice_id = $this->orders->add_order($new_invoice);

									if(!empty($landlord) && !empty($landlord->landlord_code))
									{
										$new_invoice->sku = $new_invoice_id.'/'.$landlord->landlord_code;
										$this->orders->update_order($new_invoice_id, $new_invoice);
									}
								}

								

								$pur_name = '1 tenant at '.$room_type.' - '.$contract_info->rental_name.' - Outpost Club from '.$inv->date_from.' and to '.$inv->date_to;

				    			$this->orders->add_purchase(array('order_id'=>$new_invoice_id, 'variant_id'=>0, 'product_name'=>$pur_name, 'price'=>$inv->price, 1));
							}
						}
						// добавить флажек, что инвойс отправлен!!!!!
					}
					else
					{

						$new_deposit = new stdClass;
						$new_deposit->contract_id = $contract_info->id;
						$new_deposit->user_id = $contract_user->id;
			    		$new_deposit->email   = $contract_user->email;
			    		$new_deposit->type    = 1; // invoice
			    		$new_deposit->ip 		= $_SERVER['REMOTE_ADDR'];
			    		$new_deposit->name 	= $contract_user->name;
			    		$new_deposit->sended = 0;
			    		$new_deposit->automatically = 0;
			    		$new_deposit->deposit = 0;

			    		// Добавляем заказ в базу
			    		if($contract_info->type != 2)
						{
				    		$new_deposit_id = $this->orders->add_order($new_deposit);
				    		if(!empty($landlord) && !empty($landlord->landlord_code))
							{
								$new_deposit->sku = $new_deposit_id.'/'.$landlord->landlord_code;
								$this->orders->update_order($new_deposit_id, $new_deposit);
							}

				    		$this->orders->add_purchase(array('order_id'=>$new_deposit_id, 'variant_id'=>0, 'product_name'=>'Security deposit', 'price'=>$contract_info->price_deposit, 1));
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


						$new_invoice = new stdClass;
						$new_invoice->contract_id = $contract_info->id;
						$new_invoice->user_id = $contract_user->id;
			    		$new_invoice->email   = $contract_user->email;
			    		$new_invoice->type    = 1; // invoice
			    		$new_invoice->ip 		= $_SERVER['REMOTE_ADDR'];
			    		$new_invoice->name 	= $contract_user->name;
						// Отключаем селсфлов (в файлах платежек), для будущих инвойсов
			    		$new_invoice->automatically = 0;
			    		$new_invoice->sended = 0;

						//Создание всех инвойсов для пользователя 
						foreach ($contract_info->invoices as $k=>$inv) 
						{
							$creation_date = date_create($inv->date_from);

							date_sub($creation_date, date_interval_create_from_date_string('10 days'));
							if($k != 0)
								$new_invoice->date = $creation_date->format('Y-m-d');

							$new_invoice->date_from = date('Y-m-d', strtotime($inv->date_from));
				    		$new_invoice->date_to = date('Y-m-d', strtotime($inv->date_to));

							if(!isset($inv->interval) || $inv->interval > 5)
							{
								$new_invoice_id = $this->orders->add_order($new_invoice);
								if(!empty($landlord) && !empty($landlord->landlord_code))
								{
									$new_invoice->sku = $new_invoice_id.'/'.$landlord->landlord_code;
									$this->orders->update_order($new_invoice_id, $new_invoice);
								}
							}
								

							$pur_name = '1 tenant at '.$room_type.' - '.$contract_info->rental_name.' - Outpost Club from '.$inv->date_from.' and to '.$inv->date_to;

			    			$this->orders->add_purchase(array('order_id'=>$new_invoice_id, 'variant_id'=>0, 'product_name'=>$pur_name, 'price'=>$inv->price, 1));
			    		}	
			    	}

			    	// после оплаты депозита сгенерить бекграундчек прям в платежке





			    	

					header('Location: '.$this->config->root_url.'/contract/'.$contract_info->url);
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

			if(file_exists($this->config->contracts_dir.$contract_info->url.'/signature.png'))
				$contract_info->signature = true;

			if($contract_info->type != 2)
			{
				if(file_exists($this->config->contracts_dir.$contract_info->url.'/signature2.png'))
					$contract_info->signature2 = true;

				if(file_exists($this->config->contracts_dir.$contract_info->url.'/signature3.png'))
					$contract_info->signature3 = true;

				if(file_exists($this->config->contracts_dir.$contract_info->url.'/signature4.png'))
					$contract_info->signature4 = true;
			}
			
		}
		else
			return false;


		if($contract_info->sellflow == 1)
		{
			$new_invoice = current($this->orders->get_orders(array('user_id'=>$contract_user->id, 'deposit'=>0, 'automatically'=>1)));
			$this->design->assign('invoice', $new_invoice);
		}


// выхватить дом и комнату, по ним выхватить апартамент, по апартаменту его жителей и их контакты, отправить контракты в шаблон, тот у кого самый ранний контракт значит подписал первым
// - в кабинете генерить пдф на лету??? или отдавать не пдф, а страницу контракта на сайте

			


		if($contract_info->type != 1 && $contract_info->type != 2)
		{
			$download = $this->request->get('download');

			$reverv = current($this->beds->get_beds_journal(array('user_id'=>$contract_user->id, 'not_canceled'=>1)));

			$bed = current($this->beds->get_beds(array('id'=>$reverv->bed_id)));
			if(!empty($bed))
				$room = current($this->beds->get_rooms(array('id'=>$bed->room_id)));
			if($room->apartment_id != 0)
			{
				$apartment = current($this->beds->get_apartments(array('id'=>$room->apartment_id)));
				if(!empty($apartment))
					$this->design->assign('apartment', $apartment);

				$rooms = $this->beds->get_rooms(array('apartment_id'=>$apartment->id));
				$rooms_ids = array();
				foreach ($rooms as $r) 
				{
					$rooms_ids[] = $r->id;
				}
				$beds = $this->beds->get_beds(array('room_id'=>$rooms_ids));
				$beds_ids = array();
				foreach ($beds as $b) 
				{
					$beds_ids[] = $b->id;
				}
				$users_ = $this->users->get_users(array('bed_id'=>$beds_ids));
				if(!empty($users_))
				{
					$users = array();
					$users_ids = array();
					foreach ($users_ as $u) 
					{
						$users[$u->id] = $u;
						$users_ids[] = $u->id;
					}
					$contracts = $this->contracts->get_contracts(array('house_id'=>$contract_user->house_id, 'user_id'=>$users_ids, 'status'=>1));
					if($contracts)
					{
						$contracts_ = array();
						foreach ($contracts as $c) 
						{
							if($c->signing == 1 && strtotime($c->date_to) > strtotime(date('Y-m-d H:i:s')))
								$contracts_[] = $c;
						}
						$this->design->assign('users', $users);
						$this->design->assign('guests', $contracts_);
					}
				}
				if($download == 1)
				{
					$this->design->assign('contract_info', $contract_info);
					$this->design->assign('contract_user', $contract_user);
					$this->design->assign('meta_title', 'Contract');

					$options = new Options();
					$options->set('defaultFont', 'Helvetica');

					$dompdf = new Dompdf($options);

					$contract_html_singed = $this->design->fetch('contracts/contract_landlord.tpl');

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
		}


		$this->design->assign('contract_info', $contract_info);
		$this->design->assign('contract_user', $contract_user);
		
		$this->design->assign('meta_title', 'Contract');


		$tpl = 'contracts/contract_page.tpl';

		echo $this->design->fetch($tpl); exit;
	}
}