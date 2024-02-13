<?PHP

require_once('View.php');

class UserCheckView extends View
{

	private	$allowed_image_extentions = array('png', 'gif', 'jpg', 'jpeg', 'ico', 'pdf', 'heic', 'heif', 'webp');

	public $user;

	// Upload Images
	private function FileUpload($file, $type='')
	{
		if(empty($type) || empty($this->user))
			return false;

		if(!empty($file['name']) && in_array(strtolower(pathinfo($file['name'], PATHINFO_EXTENSION)), $this->allowed_image_extentions))
		{
			$file_name = md5(uniqid($this->config->salt, true));
			$ext = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
			if(!file_exists($this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/'))
				mkdir($this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/', 0755);
			elseif(!empty($this->user->files[$type]))
				@unlink($this->config->root_dir.$this->config->users_files_dir.$this->user->id.'/'.$this->user->files[$type]);

			move_uploaded_file($file['tmp_name'], $this->root_dir.$this->config->users_files_dir.$this->user->id.'/'.$file_name.'.'.$ext);

			// Resize image
			if(in_array($ext, ['png', 'gif', 'jpg', 'jpeg']))
			{
				$imagesize = getimagesize($this->root_dir.$this->config->users_files_dir.$this->user->id.'/'.$file_name.'.'.$ext);
		 		if($imagesize[0] > 1000)
		 		{
		 			$this->simpleimage->load($this->root_dir.$this->config->users_files_dir.$this->user->id.'/'.$file_name.'.'.$ext);
					$this->simpleimage->resizeToWidth(1000);
					$this->simpleimage->save($this->root_dir.$this->config->users_files_dir.$this->user->id.'/'.$file_name.'.'.$ext);
		 		}

			}
	 		

	 		return $file_name.'.'.$ext;
		}
		else
			return false;
	}


	function fetch()
	{
		$user = new stdclass;


		$hash = $this->request->get('h', 'string');
		$auth_code = $this->request->get('auth_code', 'string'); // guarantor upd
		$contract_id = $this->request->get('c');
		$user_id = $this->request->get('u');

		$success_status = $this->request->get('success');



		 // guarantor upd
		$user_type = 'tenant';
		$u_type = $this->request->get('type', 'string');
		if(!empty($u_type))
		{
			if($u_type == 'guarantor')
				$user_type = $u_type;
		}
		// guarantor upd (end)


		if($user_type == 'guarantor')
		{
			// echo $user_type; exit;
		}



		if(!empty($contract_id))
		{
			$contract = $this->contracts->get_contract(intval($contract_id));
		}
		if(!empty($user_id))
		{
			$_SESSION['user_id'] = $user_id;
		}

		if(!empty($hash))
		{
			// get notification item
			$notification = $this->notifications->get_notification($hash);
			if(!empty($notification))
			{
				// type 2 - background check notification type
				if($notification->type == 2 && !empty($notification->user_id))
				{
					$user = $this->users->get_user((int)$notification->user_id);

					if(!empty($user->files))
						$user->files = unserialize($user->files);

					if(!empty($user))
					{
						$notification = $this->notifications->update_notification($notification->id, array('date_viewed'=>'now'));

						$_SESSION['user_id'] = $user->id;

						$salesflow = $this->salesflows->get_salesflows(['id'=>$user->active_salesflow_id, 'limit'=>1]);

						if(!empty($salesflow))
						{
							$this->salesflows->check_salesflow_status(intval($salesflow->id));
						}

						if(!empty($salesflow->application_data))
							$salesflow->application_data = unserialize($salesflow->application_data);
			 
			 			if(!empty($salesflow->additional_files))
							$salesflow->additional_files = unserialize($salesflow->additional_files);

						if(!empty($salesflow->additional_files) && (!empty($salesflow->application_data) && isset($salesflow->application_data['employment_income'])))
							$success = '?success=sended&add_docs=sended';
						elseif(!empty($salesflow->application_data) && isset($salesflow->application_data['employment_income']))
							$success = '?success=sended';
						else
							$success = '?';


						// if($user->transunion_id || ($user->us_citizen==2 && !empty($user->files)))
						// 	$success = '?success=sended&add_docs=sended';
						// elseif(!empty($user->files['additional']) && !empty($user->transunion_id))
						// 	$success = '?add_docs=sended';
						// else
						// 	$success = '?';

						if(!empty($contract))
							header('Location: '.$this->config->root_url.'/user/check'.$success.'&c='.$contract->id);
						else
							header('Location: '.$this->config->root_url.'/user/check'.$success);
						exit;
					}
				}
			}
			return false;
		}
		 // guarantor upd
		elseif(!empty($auth_code))
		{
			$user = $this->users->get_user_code($auth_code);
			if(!empty($user))
			{
				$_SESSION['user_id'] = $user->id;

				if(empty($_SESSION['admin']))
				{
					// Add log
					$this->logs->add_log([
		                'parent_id' => $user->id, 
		                'type' => 14, // User Check
		                'subtype' => 2, // Viewed
		                'sender_type' => 3, // User
		                'user_id' => $user->id
		            ]);
				}
				if($user_type == 'guarantor')
					header('Location: '.$this->config->root_url.'/guarantor/application');
				else
					header('Location: '.$this->config->root_url.'/user/check');
				exit;
			}
			return false;
		}
		 // guarantor upd (end)
		

		
		
		if(isset($_SESSION['user_id']))
		{
			$user = $this->users->get_user(intval($_SESSION['user_id']));
			if(empty($user))
				return false;

			$this->user = $user;

			$salesflow = $this->salesflows->get_salesflows(['id'=>$user->active_salesflow_id, 'limit'=>1]);

			if(empty($salesflow) && $user_type == 'tenant')
			{
				$bookings_ = $this->beds->get_bookings([
					'user_id' => $user->id,
					'not_canceled' => 1
				]);

				if(!empty($bookings_))
				{
					$booking = current($bookings_);
					$salesflow = new stdClass;
					$saleflow->booking_id = $booking->id;
					$saleflow->user_id = $user->id;
					
					$saleflow->type = 0;
					$saleflow->application_type = 1;

					$saleflow_id = $this->salesflows->add_salesflow($saleflow);
					$this->users->update_user($user->id, array('active_salesflow_id'=>$saleflow_id));

					$salesflow = $this->salesflows->get_salesflows(['id'=>$saleflow_id, 'limit'=>1]);
				}
			}

			// Hotel UPD
			if(!empty($salesflow))
			{
				$booking = $this->beds->get_bookings(['id'=>$salesflow->booking_id, 'limit'=>1]);
				if(!empty($booking))
				{
					$house = $this->pages->get_page(intval($booking->house_id));
				}
			}
			// Hotel UPD end

			if(!empty($salesflow->application_data))
				$salesflow->application_data = unserialize($salesflow->application_data);
 
 			if(!empty($salesflow->additional_files))
				$salesflow->additional_files = unserialize($salesflow->additional_files);

			// if(!empty($user->transunion_id) || (!empty($user->files) && $user->us_citizen == 2) || !empty($user->checker_options))
			if(!empty($salesflow->application_data) || !empty($salesflow->additional_files))
			{
				$ra_invoice_filter = array();
				$ra_invoice_filter['user_id'] = $user->id;
				if(!empty($user->booking))
					$ra_invoice_filter['booking_id'] = $booking->id;
				$ra_invoice_filter['type'] = 7; // Application fee 
				$ra_invoice_filter['limit'] = 1;
				$ra_invoice_filter['count'] = 1;
				
				$ra_invoice = $this->orders->get_orders($ra_invoice_filter);
				if(!empty($ra_invoice))
				{
			    	$this->design->assign('invoicefee', $ra_invoice);
				}
				else
				{
					$invoices = $this->orders->get_orders(array('user_id'=>$user->id, 'automatically'=>1));
					if(!empty($invoices))
					{
						krsort($invoices);
						$new_invoice = current($invoices);
						$this->design->assign('deposit_invoice', $new_invoice);
					}
					
				}
			}

			if($salesflow->application_type == 1 && !empty($user->id) && (empty($salesflow->additional_files) || empty($salesflow->application_data)))
			{
				if(empty($salesflow->application_data))
				{
					$prev_salesflow = $this->salesflows->get_salesflows([
						'user_id' => $user->id, 
						'not_empty_data' => 1, 
						'limit' => 1
					]);
					if(!empty($prev_salesflow) && !empty($prev_salesflow->application_data))
						$salesflow->application_data = unserialize($prev_salesflow->application_data);
				}

				if(empty($salesflow->additional_files))
				{
					$prev_salesflow = $this->salesflows->get_salesflows([
						'user_id' => $user->id, 
						'not_empty_add_files' => 1, 
						'limit' => 1
					]);
					if(!empty($prev_salesflow) && !empty($prev_salesflow->application_files))
						$salesflow->additional_files = unserialize($prev_salesflow->additional_files);
				}
			}

			// guarantor upd
			if($user_type == 'guarantor')
			{
				$agreement_logs = $this->logs->get_logs([
	                'type' => 16, // Guarantor Agreement
	                'subtype' => [
	                	1,  // Sign
	                	2   // Uploaded
	                ],
	                'user_id' => $user->id
	            ]);
	            $agreement_logs = $this->request->array_to_key($agreement_logs, 'subtype');

	            if(!empty($agreement_logs[2])) // Agreement Uploaded
	            {
	            	// to Thank You Page
	            	header('Location: '.$this->config->root_url.'/guarantor/agreement?add_docs=sended');
					exit;
	            }
	            elseif(!empty($agreement_logs[1])) // Agreement Sign
	            {
	            	// to step 3
	            	header('Location: '.$this->config->root_url.'/guarantor/agreement?add_docs=f');
					exit;
	            }
				elseif(!empty($salesflow->application_data) && $success_status!='sended')
				{
					// to step 2
					header('Location: '.$this->config->root_url.'/guarantor/application?success=sended');
					exit;
				}




				$uu = $this->users->get_users_users([
					'type' => 1, // Guarantor
					'child_id' => $user->id,
					'order_by' => 'parent_id_desc',
					'limit' => 1,
					'count' => 1
				]);
				if(!empty($uu))
				{
					$user->tenant = $this->users->get_user((int)$uu->parent_id);
					if(!empty($user->tenant))
					{
						$booking = false;

						if(!empty($user->blocks))
						{
							$user->blocks = unserialize($user->blocks);
							if(!empty($user->blocks['salesflow_parent_id']))
							{
								$tenant_salesflow = $this->salesflows->get_salesflows([
									'id' => (int)$user->blocks['salesflow_parent_id'], 
									'limit' => 1
								]);

								if(!empty($tenant_salesflow))
								{
									$booking = $this->beds->get_bookings([
										'id' => $tenant_salesflow->booking_id,
										'limit' => 1
									]);	
								}
							}	
						}

						if(empty($booking))
						{
							$booking = $this->beds->get_bookings(array(
								'id' => $user->tenant->active_booking_id,
								'limit' => 1
							));
						}
						



						if(!empty($booking))
						{
							// House
							if(!empty($booking->house_id))
							{
								if($house = $this->pages->get_page((int)$booking->house_id))
								{
									if(!empty($house->blocks2))
										$house->blocks2 = unserialize($house->blocks2);
									$booking->house = $house;
									unset($house);
								}
							}

							// Apartment
							if(!empty($booking->apartment_id))
							{
								$booking->apartment = $this->beds->get_apartments(array(
									'id' => $booking->apartment_id, 
									'limit' => 1
								));
							}

							// Contract
							$contracts = $this->contracts->get_contracts(array(
								'reserv_id' => $booking->id, 
								'limit' => 1
							));
							if(!empty($contracts))
							{
								$user->contract = current($contracts);
								unset($contracts);
							}

							// Apartment booking
							// if($booking->type == 2)
							// {

								$price_month = 1000;
								if(!empty($user->contract) && !empty($user->contract->price_month))
									$price_month = $user->contract->price_month;
								elseif(!empty($booking->price_month))
									$price_month = $booking->price_month;
								$booking->calculate = $this->contracts->calculate($booking->arrive, $booking->depart, $price_month);


								if($bookings_users_ids = $this->beds->get_bookings_users(array('booking_id'=>$booking->id)))
								{
									$bookings_users = $this->request->array_to_key($bookings_users_ids, 'user_id');
									$booking->users_count = count($bookings_users_ids);
								}

								$user->price_month = 0;
								if(!empty($user->contract) && !empty($user->contract->price_month))
									$user->price_month = $user->contract->price_month;
								elseif(!empty($booking->price_month))
									$user->price_month = $booking->price_month;


							// }
							$user->booking = $booking;
						}
					}
				}
			}
			// guarantor upd (end)


			// Additional docs
			if($this->request->files('dropped_files'))
			{
				$add_files = $this->request->files('dropped_files');
				if(!empty($add_files))
				{
					// if(empty($salesflow->additional_files) || !is_array($salesflow->additional_files))
					$salesflow->additional_files = [];
					foreach ($add_files['name'] as $k => $file_name) 
					{
						$file = [];
						if(!empty($file_name))
						{
							$file['name'] = $file_name;
							$file['tmp_name'] = $add_files['tmp_name'][$k];
							$salesflow->additional_files[] = $this->FileUpload($file, 'additional');
						}
					}
					$salesflow->additional_files = serialize($salesflow->additional_files);

					// $this->users->update_user($user->id, array('files'=>$user->files));
					$this->salesflows->update_salesflow($salesflow->id, array('additional_files'=>$salesflow->additional_files));

					if(!empty($contract))
						header('Location: '.$this->config->root_url.'/user/check?add_docs=sended&c='.$contract->id);
					else
						header('Location: '.$this->config->root_url.'/user/check?add_docs=sended');
				}
			}
			elseif($this->request->method('post'))
			{
				$u = new stdclass;
				$u->first_name = trim($this->request->post('first_name'));
				$u->middle_name = trim($this->request->post('middle_name'));
				$u->last_name = trim($this->request->post('last_name'));

				if($user->status == 0)
					$u->status = 1;

				$birth_month = $this->request->post('birth_month', 'integer');
				$birth_day = $this->request->post('birth_day', 'integer');
				$birth_year = $this->request->post('birth_year', 'integer');
				if(!empty($birth_month) && !empty($birth_day) && !empty($birth_year))
					$u->birthday = $birth_year.'-'.$birth_month.'-'.$birth_day;

				$u->gender = $this->request->post('gender', 'integer');
				$u->phone = $this->request->post('phone');

				$u->us_citizen = $this->request->post('us_citizen', 'integer');

				$s = new stdclass;

				$social_number = $this->request->post('social_number');
				$s->application_data['social_number'] = base64_encode(base64_encode($social_number));

				$zip = $this->request->post('zip');
				$s->application_data['zip'] = base64_encode($zip);

				$s->application_data['state_code'] = trim($this->request->post('state_code'));
				$s->application_data['city'] = trim($this->request->post('city'));
				$s->application_data['street_address'] = trim($this->request->post('street_address'));
				$s->application_data['apartment'] = trim($this->request->post('apartment'));
				$s->application_data['employment_status'] = trim($this->request->post('employment_status'));
				$s->application_data['employment_income'] = trim($this->request->post('employment_income'));


				if($this->request->post('itin'))
					$s->application_data['itin'] = base64_encode(base64_encode($this->request->post('itin')));


				if($this->request->post('to_check', 'integer'))
					$s->application_data['to_check'] = $this->request->post('to_check', 'integer');
				else
					$s->application_data['to_check'] = $this->request->post('to_check_not_us', 'integer');

				$s->application_data['california_app'] = $this->request->post('california_app', 'integer');
				$s->application_data['washington_app'] = $this->request->post('washington_app', 'integer');

				if($blocks = $this->request->post('blocks'))
				{
					foreach($blocks as $k=>$value)
						$s->application_data[$k] = $value;
				}


				// $s->application_data['files'] = $user->files;

				// Files: Visa / Passport / Selfie
				$file_visa = $this->request->files('visa');
				if(!empty($file_visa['name']))
					$s->application_data['files']['visa'] = $this->FileUpload($file_visa, 'visa');

				// $file_passport = $this->request->files('passport');
				// if(!empty($file_passport['name']))
				// 	$u->files['passport'] = $this->FileUpload($file_passport, 'passport');

				$file_selfie = $this->request->files('selfie');
				if(!empty($file_selfie['name']))
					$s->application_data['files']['selfie'] = $this->FileUpload($file_selfie, 'selfie');



				// Files: USA Doc / Selfie
				$file_usa_doc = $this->request->files('usa_doc');
				if(!empty($file_usa_doc['name']))
					$s->application_data['files']['usa_doc'] = $this->FileUpload($file_usa_doc, 'usa_doc');

				$file_usa_selfie = $this->request->files('usa_selfie');
				if(!empty($file_usa_selfie['name']))
					$s->application_data['files']['usa_selfie'] = $this->FileUpload($file_usa_selfie, 'usa_selfie');
	

  	  //   		if(!empty($u->files))
					// $u->files = serialize($u->files);

				$s->application_data = serialize($s->application_data);

				$this->users->update_user($user->id, $u);
				$this->salesflows->update_salesflow($salesflow->id, $s);
				$this->beds->update_booking($salesflow->booking_id, ['living_status'=>1]); // pending

				$user = $this->users->get_user((int)$user->id);
				$salesflow = $this->salesflows->get_salesflows(['id'=>$salesflow->id, 'limit'=>1]);

				if(!empty($user->blocks))
				{
					$user->blocks = unserialize($user->blocks);
					if(!empty($user->blocks['covid_form']))
						$this->design->assign('covid_form', $user->blocks['covid_form']);
				}

				if(!empty($salesflow->application_data))
					$salesflow->application_data = unserialize($salesflow->application_data);

				if(!empty($_POST['signature']))
				{
					if(!file_exists($this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/'))
						mkdir($this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/', 0755);
					
					// Signature
					$img = $_POST['signature'];
					$img = str_replace('data:image/png;base64,', '', $img);
					$img = str_replace(' ', '+', $img);
					$data = base64_decode($img);
					$file = $this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/rental_application_signature.png';
					$success = file_put_contents($file, $data);
					chmod($this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/rental_application_signature.png', 0755);
				}

				// $user->us_citizen == 1 || 
				if(!empty($salesflow->application_data['social_number']))
				{
					// if(empty($user->checkr_candidate_id))
					// {
					// 	$this->checkr->create_candidate($user->id);
					// }
					// Повторно чекаем каждый сейлфлоу!
					// if(empty($user->transunion_id))
					// {
					// }
					$r = $this->transunion->create_application($user->id);

				}
				if(empty($contract))
				{
					$e = $this->ekata->identity_check(array(
						'user_id' => $user->id,
						'sender_type' => 1
					));
				}


				$mailto = 'customer.service@outpost-club.com, molchanov.eugeniy@gmail.com, vlada.sheerman@outpost-club.com';

				$mailfrom = $this->settings->notify_from_email;

				$this->design->assign('user', $user);

				$email_template = $this->design->fetch($this->config->root_dir.'backend/design/html/email_rental_apl_complete.tpl');
				$subject = $this->design->get_var('subject');
				$this->notify->email($mailto, $subject, $email_template, $mailfrom);


				// Add log
				$log_patent_id = $user->id;
				if(!empty($salesflow))
					$log_patent_id = $salesflow->id;
				$this->logs->add_log([
	                'parent_id' => $log_patent_id,
	                'type' => 14, // User Check
	                'subtype' => 3, // Sign
	                'sender_type' => 3, // User
	                'user_id' => $user->id
	            ]);

				// $this->design->assign('user', $user);

				//$this->design->assign('message_success', 'sended');
				if(!empty($contract))
				{
					if(!empty($contract->id))
					{
						$contract_users_ = $this->users->get_users(array('contract_id'=>$contract->id));
					}

					$contract_users = array();
					if(!empty($contract_users_))
					{
						foreach($contract_users_ as $c_user)
						{
							$contract_users[$c_user->id] = $c_user;
						}
					}

					$invoice_users = array();
					if($contract->type == 4)
						$invoice_users[] = $user->id;
					else
						$invoice_users = array_keys($contract_users);

					// Month count
					$d1 = date_create($contract->date_from);
					$d2 = date_create($contract->date_to);
					
					$interval = date_diff($d1, $d2);


					if(!empty($contract->house_id))
					{
						$house_id = $contract->house_id;
					}
					if(!empty($contract->reserv_id))
					{
						$booking = $this->beds->get_bookings(['id'=>$contract->reserv_id, 'limit'=>1]);

						if(empty($house_id) && !empty($booking->house_id))
							$house_id = $booking->house_id;
					}
					if(!empty($house_id))
					{
						$house = $this->pages->get_page(intval($house_id));
						$company_houses = current($this->companies->get_company_houses(array('house_id'=>$house_id)));
						$company = $this->companies->get_company($company_houses->company_id);

						if(!empty($company))
						{
							$last_invoice_id = $house->last_invoice;

							$new_sku = date('y', strtotime($contract->date_from)).'-'.str_pad($company->landlord_id, 2, "0", STR_PAD_LEFT).'-'.str_pad($house->sku, 3, "0", STR_PAD_LEFT);
						}
					}

					// Если букинг больше месяца и не екстеншн
					if($interval->days >= 28 && ($booking->sp_type == 0 || $booking->sp_type == null))
					{
						// Add invoice Application fee
						// ---------------------------
						$invoice_fee = new stdClass;
						$invoice_fee->user_id = $user->id;
			    		$invoice_fee->type = 7; // invoice
			    		$invoice_fee->ip = $_SERVER['REMOTE_ADDR'];
			    		$invoice_fee->sended = 1;
			    		$invoice_fee->contract_id = $contract->id;
			    		if(!empty($contract->reserv_id))
			    			$invoice_fee->booking_id = $contract->reserv_id;

			    		$last_invoice_id = ++$last_invoice_id;
						$invoice_fee->sku = $new_sku.'-'.str_pad($last_invoice_id, 4, "0", STR_PAD_LEFT);

			    		$invoice_fee_id = $this->orders->add_order($invoice_fee);

			    		$invoicefee = $this->orders->get_order((int)$invoice_fee_id);
			    		if(!empty($invoicefee))
			    		{
			    			$_SESSION['order_id'] = $invoicefee->id;

			    			$this->orders->add_purchase(array(
			    				'order_id' => $invoicefee->id, 
			    				'variant_id' => 0, 
			    				'product_name' => 'Application fee', 
			    				'price' => $this->contracts->application_fee
			    			));

			    			//5, // Application fee 

			    			$this->orders->add_order_labels($invoicefee->id, array(
			    				7  // Hide ACH
			    			));

			    			// Send email to user
			    			// $this->notify->email_order_user($invoicefee->id);
			    		}
			    		$this->design->assign('invoicefee', $invoicefee);
					}

					$outpost_deposit = $this->orders->get_orders(array('contract_id'=>$contract->id, 'deposit'=>1, 'limit'=>1));


					if($contract->outpost_deposit == 1 && $contract->price_deposit > 0 && empty($outpost_deposit))
			    	{
			    		$new_deposit = new stdClass;
				    	$new_deposit->contract_id = $contract->id;
				    	$new_deposit->booking_id = $contract->reserv_id;
						$new_deposit->user_id = $invoice_users;
			    		$new_deposit->type    = 1; // invoice
			    		$new_deposit->ip 	= $_SERVER['REMOTE_ADDR'];
			    		$new_deposit->sended = 1;
			    		$new_deposit->automatically = 1;
			    		$new_deposit->deposit = 1;
			    		// Добавляем заказ в базу

			    		$last_invoice_id = ++$last_invoice_id;
						$new_deposit->sku = $new_sku.'-'.str_pad($last_invoice_id, 4, "0", STR_PAD_LEFT);

			    		$new_deposit_id = $this->orders->add_order($new_deposit);

			    		$this->orders->add_purchase(array('order_id'=>$new_deposit_id, 'variant_id'=>0, 'product_name'=>'Security deposit', 'price'=>$contract->price_deposit, 1));
			    		
						$deposit_invoice = $this->orders->get_order($new_deposit_id);
						$this->design->assign('deposit_invoice', $deposit_invoice);

						if(is_null($user->security_deposit_type))
						{
			    // 			$this->users->update_user($user->id, array(
							// 	'security_deposit_type' => 1,  // Outpost
							// 	'security_deposit_status' => 1 // Created
							// ));
							$this->salesflows->update_salesflow($salesflow->id, [
								'deposit_type' => 1,  // Outpost
								'deposit_status' => 1 // Created
							]);
			    		}
			    	}
					$this->pages->update_page($house->id, array('last_invoice' => $last_invoice_id));


			    	$e = $this->ekata->identity_check(array(
						'user_id' => $user->id,
						'sender_type' => 1
					));
			    	
					header('Location: '.$this->config->root_url.'/user/check?success=sended&c='.$contract->id);
				}
				elseif($user_type == 'guarantor')
				{
					// Add invoice Application fee
					$invoice_fee = new stdClass;
					$invoice_fee->user_id = $user->id;
		    		$invoice_fee->type = 7; // invoice (Application fee)
		    		$invoice_fee->ip = $_SERVER['REMOTE_ADDR'];
		    		$invoice_fee->sended = 1;
		    		// $invoice_fee->contract_id = $contract->id;
		    		// if(!empty($contract->reserv_id))
		    		// 	$invoice_fee->booking_id = $contract->reserv_id;

		   			// $last_invoice_id = ++$last_invoice_id;
					// $invoice_fee->sku = $new_sku.'-'.str_pad($last_invoice_id, 4, "0", STR_PAD_LEFT);

		    		$invoice_fee_id = $this->orders->add_order($invoice_fee);

		    		$invoicefee = $this->orders->get_order((int)$invoice_fee_id);
		    		if(!empty($invoicefee))
		    		{
		    			$_SESSION['order_id'] = $invoicefee->id;

		    			$this->orders->add_purchase(array(
		    				'order_id' => $invoicefee->id, 
		    				'variant_id' => 0, 
		    				'product_name' => 'Application fee', 
		    				'price' => $this->contracts->application_fee
		    			));

		    			$this->orders->add_order_labels($invoicefee->id, array(
		    				7  // Hide ACH
		    			));

		    			// Send email to user
		    			// $this->notify->email_order_user($invoicefee->id);
		    		}
		    		$this->design->assign('invoicefee', $invoicefee);


					header('Location: '.$this->config->root_url.'/guarantor/application?success=sended');
				}
				else
					header('Location: '.$this->config->root_url.'/user/check?success=sended');
				exit;

				// elseif($salesflow->type == 3)
				// {
		  		// 		$this->design->assign('next_step_link', $invoicefee);

				// 	header('Location: '.$this->config->root_url.'/user/check?success=sended');
				// }
			}


			if(!empty($salesflow->application_data['social_number']))
				$salesflow->application_data['social_number'] = base64_decode(base64_decode($salesflow->application_data['social_number']));

			if(!empty($salesflow->application_data['itin']))
				$salesflow->application_data['itin'] = base64_decode(base64_decode($salesflow->application_data['itin']));

			if(!empty($salesflow->application_data['zip']))
				$salesflow->application_data['zip'] = base64_decode($salesflow->application_data['zip']);
		}
		else
			return false;


		// guarantor upd
		if(empty($salesflow->application_data))
		{
			$salesflow->application_data = [];
		}
		// guarantor upd (end)


		$this->design->assign('salesflow', $salesflow);

		$this->design->assign('states', $this->users->states);
		$this->design->assign('user', $user);

		$this->design->assign('user_type', $user_type);  // guarantor upd

		if(!empty($booking))
		{
			// Month count
			$d1 = date_create($booking->arrive);
			$d2 = date_create($booking->depart);
			
			$interval = date_diff($d1, $d2);

			$booking->interval = $interval->days + 1;
			$this->design->assign('booking', $booking);
		}
		if(!empty($contract))
		{
			// Month count
			$d1 = date_create($contract->date_from);
			$d2 = date_create($contract->date_to);
			
			$interval = date_diff($d1, $d2);

			$contract->interval = $interval->days + 1;
			$contract->reserv = $this->beds->get_bookings(array('id'=>$contract->reserv_id, 'limit'=>1));

			$this->design->assign('contract', $contract);
		}

		// hotel salesflow
		if($salesflow->type == 3)
			return $this->design->fetch('hotel/application.tpl');
		elseif($user_type == 'guarantor')
			return $this->design->fetch('guarantor/application.tpl');
		else
			return $this->design->fetch('user_check.tpl');
	}
}