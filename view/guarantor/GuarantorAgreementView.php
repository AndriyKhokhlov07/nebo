<?PHP

require_once('view/View.php');

require_once 'api/dompdf/lib/html5lib/Parser.php';
require_once 'api/dompdf/src/Autoloader.php';
Dompdf\Autoloader::register();
use Dompdf\Dompdf;
use Dompdf\Options;


class GuarantorAgreementView extends View
{

	public $user;

	private	$allowed_image_extentions = array('png', 'gif', 'jpg', 'jpeg', 'ico', 'pdf', 'heic', 'heif', 'webp');

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


	private function form()
	{
		if(!empty($this->user->booking))
		{
			$company_houses = $this->companies->get_company_houses([
				'house_id' => $this->user->booking->house_id
			]);
			if(!empty($company_houses))
			{
				$company_house = current($company_houses);

				$this->user->llc_company = $this->companies->get_company($company_house->company_id);
			}

			$contracts = $this->contracts->get_contracts([
				'reserv_id' => $this->user->booking->id,
				'status' => 1
			]);
			if(!empty($this->user->contract))
				$this->user->contract = current($contracts);
		}

		$this->design->assign('user', $this->user);



		// $this->design->assign('this_page', 'pdf');
		// $agreement_html = $this->design->fetch('guarantor/agreement/html.tpl');
		// echo $agreement_html; exit;



		// Uploaded docs
		if($this->request->files('dropped_files'))
		{
			$add_files = $this->request->files('dropped_files');
			if(!empty($add_files))
			{
				foreach($add_files['name'] as $k => $file_name) 
				{
					$file = [];
					if(!empty($file_name))
					{
						$file['name'] = $file_name;
						$file['tmp_name'] = $add_files['tmp_name'][$k];
						$additional_files[] = $this->FileUpload($file, 'Agreement');
					}
				}

				if(!empty($this->user->salesflow))
				{
					$salesflow->additional_files = serialize($additional_files);
					// $this->users->update_user($user->id, array('files'=>$user->files));
					$this->salesflows->update_salesflow($this->user->salesflow->id, [
						'additional_files' => $salesflow->additional_files
					]);
				}

				$log_patent_id = $this->user->id;
				if(!empty($this->user->salesflow))
					$log_patent_id = $this->user->salesflow->id;
				$this->logs->add_log([
	                'parent_id' => $log_patent_id,
	                'type' => 16, // Guarantor Agreement
	                'subtype' => 2, // Uploaded
	                'sender_type' => 3, // User
	                'user_id' => $this->user->id,
	                'data' => $additional_files
	            ]);

	            // send email to salesflow-manager
				$email_template = $this->design->fetch($this->config->root_dir.'backend/design/html/email/guarantor_ageement_uploaded.tpl');
				$subject = $this->design->get_var('subject');

				$salesflow_manager_email = str_replace(', alex.kos@outpost-club.com', '', $this->settings->salesflow_manager_outpost_email);

				if($client_type == 'airbnb')
					$salesflow_manager_email = $this->settings->salesflow_manager_airbnb_email;

				$this->notify->email($salesflow_manager_email, $subject, $email_template, $this->settings->notify_from_email);



				header('Location: '.$this->config->root_url.'/guarantor/agreement?add_docs=sended');
				exit;
			}
		}
		elseif(!empty($_POST['signature']))
		{
			if(!file_exists($this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/'))
				mkdir($this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/', 0755);
			
			// Signature
			$img = $_POST['signature'];
			$img = str_replace('data:image/png;base64,', '', $img);
			$img = str_replace(' ', '+', $img);
			$data = base64_decode($img);
			$file = $this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/guarantor_agreement_signature.png';
			$success = file_put_contents($file, $data);
			chmod($this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/guarantor_agreement_signature.png', 0755);


			// Save PDF
			$this->design->assign('this_page', 'pdf');
			$agreement_html = $this->design->fetch('guarantor/agreement/html.tpl');

			$options = new Options();
			$options->set('defaultFont', 'Helvetica');

			$dompdf = new Dompdf($options);
			$dompdf->loadHtml($agreement_html);
			$dompdf->setPaper('A4', 'portrait'); 
			$dompdf->render();
			// $dompdf->stream();

			$canvas = $dompdf->get_canvas();
			// $font = $dompdf->getFontMetrics()->get_font("helvetica", "italic");
			$stream_options = [
				'save_path' => $this->config->users_files_dir.$this->user->id.'/'
			];
			$dompdf->stream('guarantor_agreement.pdf', $stream_options);


			// Add log
			$log_patent_id = $this->user->id;
			if(!empty($this->user->salesflow))
				$log_patent_id = $this->user->salesflow->id;
			$this->logs->add_log([
                'parent_id' => $log_patent_id,
                'type' => 16, // Guarantor Agreement
                'subtype' => 1, // Sign
                'sender_type' => 3, // User
                'user_id' => $this->user->id
            ]);


            // send email to salesflow-manager
			$email_template = $this->design->fetch($this->config->root_dir.'backend/design/html/email/guarantor_ageement_uploaded.tpl');
			$subject = $this->design->get_var('subject');

			$salesflow_manager_email = $this->settings->salesflow_manager_outpost_email;
			if($client_type == 'airbnb')
				$salesflow_manager_email = $this->settings->salesflow_manager_airbnb_email;

			if(!empty($this->user->booking) && !empty($this->user->booking->manager_login))
			{
				$booking_manager = $this->managers->get_manager($this->user->booking->manager_login);
				if(!empty($booking_manager->email))
				{
					$salesflow_manager_email .= ', ' . $booking_manager->email;
				}
			}

			$this->notify->email($salesflow_manager_email, $subject, $email_template, $this->settings->notify_from_email);


            header('Location: '.$this->config->root_url.'/guarantor/agreement?success=sended');
            exit;

		}

		

		return $this->design->fetch('guarantor/agreement/form.tpl');
	}


	private function application_to_pdf()
	{

		$this->design->assign('states', $this->users->states);
		$this->design->assign('user', $this->user);

		$this->design->assign('user_type', 'guarantor');
		$user_check_html = $this->design->fetch('guarantor/application_pdf.tpl');


		$options = new Options();
		$options->set('defaultFont', 'Helvetica');

		// instantiate and use the dompdf class
		$dompdf = new Dompdf($options);


		$dompdf->loadHtml($user_check_html);

		// (Optional) Setup the paper size and orientation ("landscape" or "portrait")
		$dompdf->setPaper('A4', 'portrait'); 

		// Render the HTML as PDF
		$dompdf->render();
		// $dompdf->stream();

		$canvas = $dompdf->get_canvas();
		$font = $dompdf->getFontMetrics()->get_font("helvetica", "italic");

		// Output the generated PDF to Browser
		$stream_options = [
			'save_path' => $this->config->users_files_dir.$this->user->id.'/'
		];
		$dompdf->stream('application.pdf', $stream_options);

		// echo '<base href="'.$this->config->root_url.'"/>';
		// echo $user_check_html; exit;

		//return $this->design->fetch('guarantor/download_application.tpl');
	}

	public function fetch()
	{
		// echo 123; exit;


		$user = new stdclass;
		$auth_code = $this->request->get('auth_code', 'string');
		$add_docs = $this->request->get('add_docs', 'string');
		$success = $this->request->get('success', 'string');
		$action = $this->request->get('a', 'string');

		if(!empty($auth_code))
		{
			$user = $this->users->get_user_code($auth_code);
			if(!empty($user))
			{
				$_SESSION['user_id'] = $user->id;
				header('Location: '.$this->config->root_url.'/guarantor/agreement');
				exit;
			}
			return false;
		}
		

		if(isset($_SESSION['user_id']))
		{
			$user_id = (int)$_SESSION['user_id'];
			if(!empty($user_id))
			{
				$user = $this->users->get_user(intval($_SESSION['user_id']));
			}
			if(empty($user))
				 return false;


			$agreement_logs = $this->logs->get_logs([
                'type' => 16, // Guarantor Agreement
                'subtype' => [
                	1,  // Sign
                	2   // Uploaded
                ],
                'user_id' => $user->id
            ]);
            $agreement_logs = $this->request->array_to_key($agreement_logs, 'subtype');

            if(!empty($agreement_logs[2]) && $add_docs != 'sended') // Agreement Uploaded
            {
            	// to Thank You Page
            	header('Location: '.$this->config->root_url.'/guarantor/agreement?add_docs=sended');
				exit;
            }
            elseif(!empty($agreement_logs[1]) && $add_docs != 'f' && empty($agreement_logs[2]) && $success != 'sended') // Agreement Sign
            {
            	// to step 3
            	header('Location: '.$this->config->root_url.'/guarantor/agreement?add_docs=f');
				exit;
            }


			$salesflow = $this->salesflows->get_salesflows([
				'id' => $user->active_salesflow_id, 
				'limit' => 1
			]);

			if(!empty($salesflow))
			{
				if(!empty($salesflow->application_data))
					$salesflow->application_data = unserialize($salesflow->application_data);
	 
	 			if(!empty($salesflow->additional_files))
					$salesflow->additional_files = unserialize($salesflow->additional_files);


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


				if(!empty($salesflow->application_data['social_number']))
					$salesflow->application_data['social_number'] = base64_decode(base64_decode($salesflow->application_data['social_number']));

				if(!empty($salesflow->application_data['itin']))
					$salesflow->application_data['itin'] = base64_decode(base64_decode($salesflow->application_data['itin']));

				if(!empty($salesflow->application_data['zip']))
					$salesflow->application_data['zip'] = base64_decode($salesflow->application_data['zip']);



				$user->salesflow = $salesflow;

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
							$user->blocks = (array) unserialize($user->blocks);
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
                                if (!empty($booking->apartment)) {
                                    $booking->apartment->name = trim(str_replace(['Unit', 'Apt.', 'Apt'], '', $booking->apartment->name));
                                }
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
				}

			}


			

			



			
			$this->user = $user;

			$this->design->assign('salesflow', $salesflow);



			if(!file_exists($this->config->users_files_dir.$this->user->id.'/application.pdf'))
			{
				$this->user->sign_log = $this->logs->get_logs([
		            'type' => 14, // User Check
		            'subtype' => 3, // Sign
		            'user_id' => $user->id,
		            'sort' => true,
		            'count' => 1
				]);

				// $this->application_to_pdf();
			}


			// $this->application_to_pdf();

			/*if($action == 'upload')
			{

			}
			elseif($action == 'download')
			{
				// return $this->download_application();
			}
			else
			{
				return $this->form();
			}*/

			return $this->form();

		}
		
	}
}