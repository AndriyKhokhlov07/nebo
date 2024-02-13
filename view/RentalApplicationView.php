<?PHP

require_once('View.php');

class RentalApplicationView extends View
{

	public $user;


	private	$allowed_image_extentions = array('png', 'gif', 'jpg', 'jpeg', 'ico');

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
	 		$imagesize = getimagesize($this->root_dir.$this->config->users_files_dir.$this->user->id.'/'.$file_name.'.'.$ext);
	 		if($imagesize[0] > 1000)
	 		{
	 			$this->simpleimage->load($this->root_dir.$this->config->users_files_dir.$this->user->id.'/'.$file_name.'.'.$ext);
				$this->simpleimage->resizeToWidth(1000);
				$this->simpleimage->save($this->root_dir.$this->config->users_files_dir.$this->user->id.'/'.$file_name.'.'.$ext);
	 		}

	 		return $file_name.'.'.$ext;
		}
		else
			return false;
	}


	function fetch()
	{
		$user = new stdclass;
		$booking = new stdclass;
		$bookings_users = array();

		/*
		$auth_code = $this->request->get('h', 'string');
		$email = urldecode($this->request->get('e'));

		if(!empty($auth_code) && !empty($email))
		{
			$user = $this->users->get_user_code($auth_code);
			if(empty($user))
				return false;

			if($user->email != $email)
				return false;

			$_SESSION['user_id'] = $user->id;
			header('Location: '.$this->config->root_url.'/user/check/');
		}
		*/

		$hash = $this->request->get('h', 'string');
		$status_success = $this->request->get('success', 'string');
		$pdf_download = $this->request->get('p', 'integer');

		if(!empty($hash))
		{

			$user = $this->users->get_user_code($hash);
			if(!empty($user))
			{
				$_SESSION['user_id'] = $user->id;

				if(empty($_SESSION['admin']))
				{
					// Add log
					$this->logs->add_log(array(
						'parent_id'=> $user->id, 
						'type' => 7, // Rental Application
						'subtype' => 2, // Viewed
						'user_id' => $user->id, 
						'sender_type' => 3 // User
					));
				}
				if($pdf_download == 1)
					header('Location: '.$this->config->root_url.'/user/rental_application?p=1');
				else
					header('Location: '.$this->config->root_url.'/user/rental_application');
				exit;
			}
			return false;
		}
		

		
		
		if(isset($_SESSION['user_id']))
		{
			// $user = $this->users->get_user(intval($_SESSION['user_id']));
			$user = current($this->users->get_users(['id'=>intval($_SESSION['user_id']), 'salesflow_info'=>1]));
			if(empty($user))
				return false;

			$this->user = $user;


			if(!empty($user->files))
				$user->files = (array) unserialize($user->files);
			else
				$user->files = array();



			if(!empty($user->blocks))
			{
				$user_blocks = (array) unserialize($user->blocks);

				// Form was submitted earlier
				if(!empty($user_blocks['rental_application']) && $status_success != 'sended' && $pdf_download != 1)
				{
					header('Location: '.$this->config->root_url.'/user/rental_application?success=sended');
					exit;
				}
			}



			
			if(!empty($user->active_booking_id))
			{
				

				$booking = $this->beds->get_bookings(array(
					'id' => $user->active_booking_id,
					'limit' => 1
				));
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
					// unset($booking);
				}
			}

			if($status_success == 'sended')
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
					$this->design->assign('next_step_link', $this->config->root_url.'/order/'.$ra_invoice->url.'?u='.$user->id.'&ra_ns=1');
				}


				$fm_invoice = $this->orders->get_orders(array(
    				'booking_id' => $booking->id,
    				'label' => 6, // Prepayment
    				'limit' => 1,
    				'count' => 1
    			));
    			if(!empty($fm_invoice))
    			{
    				if(in_array($fm_invoice->status, array(1,2)) || $fm_invoice->paid == 1)
    				{
    					$this->design->assign('steps_count', 2);
    				}
    			}
			}
			


			if($this->request->method('post'))
			{
				$u = new stdclass;
				$u->first_name = trim($this->request->post('first_name'));
				$u->middle_name = trim($this->request->post('middle_name'));
				$u->last_name = trim($this->request->post('last_name'));

				$birth_month = $this->request->post('birth_month', 'integer');
				$birth_day = $this->request->post('birth_day', 'integer');
				$birth_year = $this->request->post('birth_year', 'integer');
				if(!empty($birth_month) && !empty($birth_day) && !empty($birth_year))
					$u->birthday = $birth_year.'-'.$birth_month.'-'.$birth_day;

				$u->phone = $this->request->post('phone');
				$u->gender = $this->request->post('gender', 'integer');
				$u->us_citizen = $this->request->post('us_citizen', 'integer');

				$social_number = $this->request->post('social_number');
				$u->social_number = base64_encode(base64_encode($social_number));

				$zip = $this->request->post('zip');
				$u->zip = base64_encode($zip);

				// $u->city = trim($this->request->post('city'));
				// $u->street_address = trim($this->request->post('street_address'));
				// $u->apartment = trim($this->request->post('apartment'));



				$u->state_code = trim($this->request->post('state_code'));
				$u->city = trim($this->request->post('city'));
				$u->street_address = trim($this->request->post('street_address'));
				$u->apartment = trim($this->request->post('apartment'));
				$u->employment_status = trim($this->request->post('employment_status'));
				$u->employment_income = trim($this->request->post('employment_income'));

				if($blocks = $this->request->post('blocks'))
				{
					$user_blocks_old_data = 0;

					if(!empty($user->blocks))
					{
						$user_blocks_old_data = (array) unserialize($user->blocks);
					}


					$blocks['rental_application'] = 1;


					if(!empty($user_blocks_old_data))
					{
						$u->blocks = $user_blocks_old_data;
						foreach($blocks as $k=>$value)
							$u->blocks[$k] = $value;
						
						$u->blocks = serialize($u->blocks);
					}
					else
					{
						$u->blocks = serialize($blocks);
					}
				}


				$u->files = $user->files;

				// Files: Visa / Passport / Selfie
				$file_visa = $this->request->files('visa');
				if(!empty($file_visa['name']))
					$u->files['visa'] = $this->FileUpload($file_visa, 'visa');

				// $file_passport = $this->request->files('passport');
				// if(!empty($file_passport['name']))
				// 	$u->files['passport'] = $this->FileUpload($file_passport, 'passport');

				$file_selfie = $this->request->files('selfie');
				if(!empty($file_selfie['name']))
					$u->files['selfie'] = $this->FileUpload($file_selfie, 'selfie');



				// Files: USA Doc / Selfie
				$file_usa_doc = $this->request->files('usa_doc');
				if(!empty($file_usa_doc['name']))
					$u->files['usa_doc'] = $this->FileUpload($file_usa_doc, 'usa_doc');

				$file_usa_selfie = $this->request->files('usa_selfie');
				if(!empty($file_usa_selfie['name']))
					$u->files['usa_selfie'] = $this->FileUpload($file_usa_selfie, 'usa_selfie');
	


  	    		if(!empty($u->files))
					$u->files = serialize($u->files);




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




				$this->users->update_user($user->id, $u);

				// $user = $this->users->get_user((int)$user->id);
				$user = current($this->users->get_users(['id'=>(int)$user->id, 'salesflow_info'=>1]));


				if(!empty($user->files))
					$user->files = (array) unserialize($user->files);
				else
					$user->files = array();



				// Add invoice Application fee
				// ---------------------------
				$invoice_fee = new stdClass;
				$invoice_fee->user_id = $user->id;
	    		$invoice_fee->type = 1; // invoice
	    		$invoice_fee->ip = $_SERVER['REMOTE_ADDR'];
	    		$invoice_fee->sended = 1;
	    		if(!empty($booking))
	    			$invoice_fee->booking_id = $booking->id;


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
	    			$this->notify->email_order_user($invoicefee->id);
	    		}


	    		// Prepayment for the first month
	    		// ------------------------------
	    		if(!empty($booking))
	    		{
	    			$fm_invoice = $this->orders->get_orders(array(
	    				'booking_id' => $booking->id,
	    				'label' => 6, // Prepayment
	    				'limit' => 1,
	    				'count' => 1
	    			));


	    			if(empty($fm_invoice))
	    			{
	    				// Add Prepayment
	    				$fm_invoice_id = $this->orders->add_order(array(
	    					'user_id' => array_keys($bookings_users),
	    					'type' => 1,
	    					'booking_id' => $booking->id,
	    					'ip' => $_SERVER['REMOTE_ADDR'],
	    					'sended' => 1
	    				));
	    				if(!empty($fm_invoice_id))
	    				{
	    					$fm_invoice = $this->orders->get_order(intval($fm_invoice_id));
	    					$this->orders->add_purchase(array(
			    				'order_id' => $fm_invoice_id, 
			    				'variant_id' => 0, 
			    				'product_name' => 'Prepayment for the first month', 
			    				'price' => $this->contracts->deposit_firs_part
			    			));

			    			$this->orders->add_order_labels($fm_invoice_id, array(
			    				6 // Prepayment
			    				//7  // Hide ACH
			    			));
	    				}	
	    			}
	    			// else{
	    			// 	if(in_array($fm_invoice->status, array(1,2)) || $fm_invoice->paid == 1)
	    			// 	{
	    			// 		$this->design->assign('steps_count', 2);
	    			// 	}
	    			// }

	    			if(!empty($fm_invoice))
	    			{
	    				if(in_array($fm_invoice->status, array(1,2)) || $fm_invoice->paid == 1)
	    				{
	    					$this->design->assign('steps_count', 2);
	    				}
	    				else
	    				{
	    					// Send email to user
	    					$this->notify->email_order_user($fm_invoice->id, $user->id);
	    				}
	    				
	    			}
	    		}
	    		



				// $this->design->assign('user', $user);

				//$this->design->assign('message_success', 'sended');

				if($user->us_citizen == 1)
				{
					if(empty($user->transunion_id))
					{
						$r = $this->transunion->create_application($user->id);
					}
				}

				// Add log
				$add_log_id = $this->logs->add_log(array(
					'parent_id'=> $user->id, 
					'type' => 7, // Rental Application
					'subtype' => 3, // Sign
					'user_id' => $user->id, 
					'sender_type' => 3 // User
				));

				header('Location: '.$this->config->root_url.'/user/rental_application?success=sended');
				exit;
			}


			if(!empty($user->social_number))
				$user->social_number = base64_decode(base64_decode($user->social_number));

			if(!empty($user->zip))
				$user->zip = base64_decode($user->zip);
		}
		else
			return false;


		if(!empty($user->blocks))
			$user->blocks = (array) unserialize($user->blocks);
		else
			$user->blocks = array();

		if(file_exists($this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/rental_application_signature.png'))
			$signature = '/'.$this->config->users_files_dir.$this->user->id.'/rental_application_signature.png';

		$this->design->assign('signature', $signature);


		// if(!empty($user->files))
		// 	$user->files = unserialize($user->files);
		// else
		// 	$user->files = array();

		$this->design->assign('states', $this->users->states);
		$this->design->assign('user', $user);


		if($pdf_download == 1)
		{
			echo $this->design->fetch('rental_application_pdf.tpl'); exit;
		}
		else
			return $this->design->fetch('rental_application.tpl');
	}
}