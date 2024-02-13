<?PHP

require_once('view/View.php');

class AddGuarantorFormView extends View
{

	public $user;

	public function fetch()
	{

		$user = new stdclass;

		$auth_code = $this->request->get('auth_code', 'string');
		$salesflow_id = $this->request->get('salesflow_id', 'integer');

		if(!empty($auth_code) && !empty($salesflow_id))
		{
			$user = $this->users->get_user_code($auth_code);
			$salesflow = $this->salesflows->get_salesflows([
				'id' => $salesflow_id,
				'limit' => 1
			]);
			if(!empty($user) && !empty($salesflow))
			{
				if($salesflow->user_id != $user->id)
					return false;
				
				$_SESSION['user_id'] = $user->id;
				$_SESSION['salesflow_id'] = $salesflow->id;
				if(empty($_SESSION['admin']))
				{
					// Add log
					$this->logs->add_log([
		                'parent_id' => $salesflow->id, 
		                'type' => 15, // Need a Guarantor
		                'subtype' => 2, // Viewed
		                'sender_type' => 3, // User
		                'user_id' => $user->id
		            ]);
				}

				header('Location: '.$this->config->root_url.'/user/add_guarantor/');
				exit;
			}
			return false;
		}


		

		if(isset($_SESSION['user_id']))
		{

			$message_errors = [];

			$user_id = (int)$_SESSION['user_id'];
			if(!empty($user_id))
			{
				$user = $this->users->get_user(intval($_SESSION['user_id']));
			}
			if(empty($user))
				 return false;
			
			$this->user = $user;

			if($this->request->method('post'))
			{
				$client_type = 'outpost';
				$u = new stdclass;
				$u->first_name = trim($this->request->post('first_name', 'string'));
				$u->last_name = trim($this->request->post('last_name', 'string'));
				$u->email = trim($this->request->post('email'));


				if(isset($_SESSION['salesflow_id']))
					$salesflow_id = (int)$_SESSION['salesflow_id'];

				if(!empty($salesflow_id))
				{
					$salesflow = $this->salesflows->get_salesflows([
						'id' => $salesflow_id,
						'limit' => 1
					]);

					if(!empty($salesflow))
					{
						if(!empty($salesflow->booking_id))
						{
							$booking = $this->beds->get_bookings([
								'id' => $salesflow->booking_id,
								'limit' => 1
							]);

							if(!empty($booking))
							{
								if($booking->client_type_id != 1) // not Outpost
									$client_type = 'airbnb';
							}
						}
					}
				}

				
				if(empty($u->first_name))
					$message_errors['first_name'] = true;
				elseif(empty($u->last_name))
					$message_errors['last_name'] = true;
				elseif(empty($u->email))
					$message_errors['email'] = true;
				
				
				if(!empty($u) && !empty($u->email))
				{
					$u->status = 10; // Guarantors
					$u->type = 6; // Guarantor
					$u->name = $u->first_name.' '.$u->last_name;

					if(!empty($salesflow))
					{
						$u->blocks['salesflow_parent_id'] = $salesflow->id;
						$u->blocks = serialize($u->blocks);
					}

					$guarantor_id = $this->users->add_user($u);

					if(!empty($guarantor_id))
					{
						$user->guarantor = $this->users->get_user($guarantor_id);

					
						if(!empty($user->guarantor))
						{
							$this->users->add_users_users(
								1, 		   // type: Tenants - Guarantors
								$user->id, // tenant
								$user->guarantor->id
							);

							// add guarantor salesflow
							$guarantor_salesflow_id = $this->salesflows->add_salesflow([
								'user_id' => $user->guarantor->id,
								'type' => 2 // guarantor
							]);

							if(!empty($guarantor_salesflow_id))
							{
								$user->guarantor->auth_code = md5(uniqid($this->config->salt, true));
								$this->users->update_user($user->guarantor->id, [
									'active_salesflow_id' => $guarantor_salesflow_id,
									'auth_code' => $user->guarantor->auth_code
								]);
							}


							$this->design->assign('salesflow', $salesflow);
							$this->design->assign('user', $user);

							// send email to guarantor
							$email_template = $this->design->fetch($this->config->root_dir.'design/'.$this->settings->theme.'/html/email/guarantor_check.tpl');
							$subject = $this->design->get_var('subject');
							$this->notify->email($user->guarantor->email, $subject, $email_template, $this->settings->notify_from_email);

							// send email to salesflow-manager
							$email_template = $this->design->fetch($this->config->root_dir.'backend/design/html/email/guarantor_added.tpl');
							$subject = $this->design->get_var('subject');

							$salesflow_manager_email = $this->settings->salesflow_manager_outpost_email;
							if($client_type == 'airbnb')
								$salesflow_manager_email = $this->settings->salesflow_manager_airbnb_email;

							$this->notify->email($salesflow_manager_email, $subject, $email_template, $this->settings->notify_from_email);


							header('Location: '.$this->config->root_url.'/user/add_guarantor/?success=sended');
							exit;

						}
						
					}
					else
					{
						$message_errors['isset_user'] = true;
					}
					
				}

			}

			$this->design->assign('u', $u);

			$this->design->assign('message_errors', $message_errors);

			return $this->design->fetch('tenant/add_guarantor_form.tpl');
		}
		
	}
}