<?PHP
require_once('api/Backend.php');

class UserAdmin extends Backend
{	
	public function fetch()
	{
		$user = new stdClass;
		$houseleaders_houses = array();
		if(!empty($_POST['to_status']))
		{
			$user->id = $this->request->post('id', 'integer');
			$user->status = $this->request->post('to_status', 'integer');

			if($user->status == 4)
				$user->enabled = 0;

			if(!empty($user->id))
				$this->users->update_user($user->id, $user);

		}
		if(!empty($_POST['user_info']))
		{
			$user->id = $this->request->post('id', 'integer');
			$user->type = $this->request->post('type', 'integer');
			$user->status = $this->request->post('status', 'integer');
			$user->enabled = $this->request->post('enabled', 'integer');
			$user->hide_ach = $this->request->post('hide_ach', 'integer');
			$user->name = trim($this->request->post('name'));
			$user->landlord_code = trim($this->request->post('landlord_code'));
			$user->first_name = trim($this->request->post('first_name'));
			$user->middle_name = trim($this->request->post('middle_name'));
			$user->last_name = trim($this->request->post('last_name'));
			$user->email = trim($this->request->post('email'));
			$user->phone = trim($this->request->post('phone'));
			$user->group_id = $this->request->post('group_id', 'integer');
			

			$user->house_id = $this->request->post('house_id', 'integer');
			$user->bed_name = trim($this->request->post('bed_name'));
			$user->bed_id = trim($this->request->post('bed_id', 'integer'));
			$user->inquiry_arrive = date('Y-m-d', strtotime($this->request->post('inquiry_arrive')));
			$user->inquiry_depart   = date('Y-m-d', strtotime($this->request->post('inquiry_depart')));
			$user->price_month = $this->request->post('price_month');
			$user->price_deposit = $this->request->post('price_deposit');
			$user->membership = $this->request->post('membership', 'integer');
			$user->room_type = $this->request->post('room_type', 'integer');

			$user->gender = $this->request->post('gender', 'integer');

			$user->birthday = null;
			$birthday = $this->request->post('birthday');
			if(!empty($birthday))
				$user->birthday = date('Y-m-d', strtotime($birthday));
			$user->note = trim($this->request->post('note'));

			// $user->us_citizen = $this->request->post('us_citizen', 'integer');

			// $social_number = $this->request->post('social_number');
			// $user->social_number = base64_encode(base64_encode($social_number));
			// $zip = $this->request->post('zip');
			// $user->zip = base64_encode($zip);

			if($this->request->post('blocks'))
				$user->blocks = serialize($this->request->post('blocks'));


			if($this->request->post('password'))
			{
				$user->first_pass = $this->request->post('password');
				$user->password = $this->request->post('password');
			}


			if($user->status == 4 || $user->status == 5 || $user->status==6)
				$user->enabled = 0;

			if(($user->status == 5 || $user->status==6) && !empty($user->id)) // Canceled (6) || Blacklist (5)
			{
				$note = 'Guest Status Changed - to ';
				if($user->status == 5)
					$note .= 'Blacklist';
				elseif($user->status == 6)
					$note .= 'Canceled';

				// Cancel reserv
				$this->beds->cancel_bed_journal(array('user_id'=>$user->id, 'note'=>$note));
			}


			// $count_users = $this->users->count_users();

			if(!empty($user->name) && empty($user->first_name) && empty($user->last_name))
			{
				$u_name = explode(' ', trim($user->name));
				if(!isset($u_name[2]))
				{
					if(isset($u_name[0]))
						$user->first_name = $u_name[0];
					if(isset($u_name[1]))
						$user->last_name = $u_name[1];
				}
			}

			if(!empty($user->name) && empty($user->first_name))
			{
				$u_name = explode(' ', trim($user->name));
				if(isset($u_name[0]))
					$user->first_name = $u_name[0];
			}

			if(!empty($user->name) && empty($user->last_name))
			{
				$u_name = explode(' ', trim($user->name));
				if(isset($u_name[1]) && !isset($u_name[2]))
					$user->last_name = $u_name[1];
			}
	
			## Не допустить одинаковые email пользователей.
			if(empty($user->name))
			{			
				$this->design->assign('message_error', 'empty_name');
			}
			elseif(empty($user->email))
			{			
				$this->design->assign('message_error', 'empty_email');
			}
			elseif(($u = $this->users->get_user($user->email)) && $u->id != $user->id)
			{			
				$this->design->assign('message_error', 'login_existed');
			}
			else
			{
				// Add user
				if(empty($user->id))
				{
					// Отправляем email пользователю с логином и паролем 
					$this->design->assign('email', $user->email);
					$this->design->assign('pass', $user->password);
					// Отправляем письмо
					$email_template = $this->design->fetch($this->config->root_dir.'design/'.$this->settings->theme.'/html/email_user_pass.tpl');
					$subject = $this->design->get_var('subject');

					$this->notify->email($user->email, $subject, $email_template, $this->settings->notify_from_email);


					$user->auth_code = md5(uniqid($this->config->salt, true));

					$user->id = $this->users->add_user($user);
					$this->design->assign('message_success', 'added');
	   	    		$user = $this->users->get_user(intval($user->id));

	   	    		$new_user = 1;
				}
				// Update user
				else
				{
					
					if($user->status == 5 || $user->status==6)
					{
						// Contracts to Canceled
						$contracts = $this->contracts->get_contracts(array('user_id'=>$user->id, 'status'=>1));
						if(!empty($contracts))
						{
							foreach($contracts as $c)
								$this->contracts->update_contract($c->id, array('status'=>9));
						}

						// Invoices to Canceled
				    	$users_orders = $this->orders->get_orders(array('type'=>1, 'status'=>0, 'paid'=>0, 'user_id'=>$user->id, 'all'=>1));
				    	if(!empty($users_orders))
				    	{
				    		foreach($users_orders as $uo)
				    			$this->orders->update_order($uo->id, array('status'=>3));
				    	}
					}


					$user->id = $this->users->update_user($user->id, $user);
	  				$this->design->assign('message_success', 'updated');
	   	    		$user = $this->users->get_user(intval($user->id));


	   	    		// Del Houses of HouseLeader
	   	    		if(empty($new_user))
	   	    		{
	   	    			$query = $this->db->placehold('DELETE FROM __houseleaders_houses WHERE user_id=?', $user->id);
	   	    			$this->db->query($query);
	   	    		}
	   	    		




	   	    		
				}


				// Удаление изображения
  	    		if($this->request->post('delete_image'))
  	    			$this->users->delete_image($user->id);

  	    		// Загрузка изображения
  	    		$image = $this->request->files('image');
  	    		if(!empty($image['name']))
  	    		{
  	    			$this->users->delete_image($user->id);
  	    			$image_name = $this->image->upload_image($image['tmp_name'], $image['name'], 'user');
  	    			$this->users->update_user($user->id, array('image'=>$image_name));
  	    			$user->image = $image_name;
  	    		}


  	    		if($user->type == 2)
				{
	  	    		if(is_array($this->request->post('hl_houses')))
					{
						$hl = array();
						foreach($this->request->post('hl_houses') as $h)
						{
							if(!empty($h))
							{
								$hl[$h] = new stdClass;
								$hl[$h]->user_id = $user->id;
								$hl[$h]->house_id = $h;
							}
						}
						$houseleaders_houses = $hl;
					}
	  	    		if(!empty($houseleaders_houses) && is_array($houseleaders_houses))
		  		    {
		  		    	$pos = 0;
		  		    	foreach($houseleaders_houses as $i=>$hl)
	   	    				$this->users->add_houseleaders_houses($user->id, $hl->house_id, $pos++);
	  	    		}
	  	    	}

  	    		if($user->type == 3)
				{
	  	    		$query = $this->db->placehold('DELETE FROM __housecleaners_houses WHERE user_id=?', $user->id);
			   	    $this->db->query($query);

			   	    if(is_array($this->request->post('hl_houses')))
					{
						$hc = array();
						foreach($this->request->post('hl_houses') as $h)
						{
							if(!empty($h))
							{
								$hc[$h] = new stdClass;
								$hc[$h]->user_id = $user->id;
								$hc[$h]->house_id = $h;
							}
						}
						$house_cleaners = $hc;
					}
			    	if(!empty($house_cleaners) && is_array($house_cleaners))
		  		    {
		  		    	$pos = 0;
		  		    	foreach($house_cleaners as $i=>$hc)
			    			$this->users->add_housecleaners_houses($hc->user_id, $hc->house_id, $pos++);
			    	}
			    }

			    if($user->type == 4)
				{
	  	    		$query = $this->db->placehold('DELETE FROM __landlords_houses WHERE user_id=?', $user->id);
			   	    $this->db->query($query);

			   	    if(is_array($this->request->post('hl_houses')))
					{
						$ll = array();
						foreach($this->request->post('hl_houses') as $h)
						{
							if(!empty($h))
							{
								$ll[$h] = new stdClass;
								$ll[$h]->user_id = $user->id;
								$ll[$h]->house_id = $h;
							}
						}
						$landlords_houses = $ll;
					}
			    	if(!empty($landlords_houses) && is_array($landlords_houses))
		  		    {
		  		    	$pos = 0;
		  		    	foreach($landlords_houses as $i=>$lh)
			    			$this->users->add_landlords_houses($lh->user_id, $lh->house_id, $pos++);
			    	}
			    }

				

				
			}
		}
		elseif($this->request->post('check'))
		{ 
			// Действия с выбранными
			$ids = $this->request->post('check');
			if(is_array($ids))
			switch($this->request->post('action'))
			{
				case 'delete':
				{
					foreach($ids as $id)
					{
						$o = $this->orders->get_order(intval($id));
						if($o->status<3)
						{
							$this->orders->update_order($id, array('status'=>3, 'user_id'=>null));
							$this->orders->open($id);							
						}
						else
							$this->orders->delete_order($id);
					}
					break;
				}
			}
 		}
 		elseif($this->request->post('check_contract'))
		{ 
			$ids = $this->request->post('check_contract');
			if(is_array($ids))
			switch($this->request->post('action_contract'))
			{
				case 'delete':
				{
					foreach($ids as $id)
					{
						$this->contracts->delete_contract($id);
					}
					break;
				}
			}
 		}

		$id = $this->request->get('id', 'integer');
		if(!empty($id))
			$user = $this->users->get_user(intval($id));			

		if(!empty($user->id))
		{
			if(!empty($user->blocks))
				$user->blocks = unserialize($user->blocks);

			$houseleaders_houses = $this->users->get_houseleaders_houses(array('user_id'=>$user->id));
			$housecleaners_houses = $this->users->get_housecleaners_houses(array('user_id'=>$user->id));
			$landlords_houses = $this->users->get_landlords_houses(array('user_id'=>$user->id));

			if(!empty($user->checker_options))
				$user->checker_options = unserialize($user->checker_options);

			if(!empty($user->files))
				$user->files = unserialize($user->files);

			if(!empty($user->social_number))
				$user->social_number = base64_decode(base64_decode($user->social_number));

			if(!empty($user->zip))
				$user->zip = base64_decode($user->zip);


			// ------------
			// --- BEDS ---
			// ------------
			// Rooms
			$rooms2 = array();
			if(!empty($user->house_id))
			{
				$rooms2_ = $this->beds->get_rooms(array('house_id'=>$user->house_id, 'visible'=>1));
				if(!empty($rooms2_))
				{
					// Rooms Types
					$rooms_types2 = array();
					$rooms_types2_ = $this->beds->get_rooms_types();
					if(!empty($rooms_types2_))
					{
						foreach($rooms_types2_ as $rt)
							$rooms_types2[$rt->id] = $rt;
						unset($rooms_types2_);
					}
					

					foreach($rooms2_ as $r)
					{
						$rooms2[$r->id] = $r;
						if(!empty($r->type_id) && isset($rooms_types2[$r->type_id]))
							$rooms2[$r->id]->type = $rooms_types2[$r->type_id];
					}
					$rooms2_ids = array_keys($rooms2);
					// Rooms Labels
					$room_labels2 = $this->beds->get_room_labels($rooms2_ids);
					if(!empty($room_labels2))
					{
						foreach($room_labels2 as $rl)
						{
							if(isset($rooms2[$rl->room_id]))
							{
								if(!isset($rooms2[$rl->room_id]->labels))
									$rooms2[$rl->room_id]->labels = array();
								$rooms2[$rl->room_id]->labels[$rl->id] = $rl;
							}
						}
					}
					// Beds
					$beds2 = $this->beds->get_beds(array('room_id'=>$rooms2_ids));
					if(!empty($beds))
					{
						foreach($beds2 as &$b)
						{
							if(isset($rooms2[$b->room_id]))
								$b->room = $rooms2[$b->room_id];
						}
					}
					$this->design->assign('beds2', $beds2);
				}
			}



			// RESERVS

			$beds_journal_ = $this->beds->get_beds_journal(array('user_id'=>$user->id));
			if(!empty($beds_journal_))
			{
				$beds_journal = array();
				$bj_isset_canceled = false;
				$beds_ids = array();

				$beds = array();
				$rooms = array();
				$rooms_types = array();
				foreach($beds_journal_ as $bj)
				{
					if(!empty($bj->bed_id))
						$beds_ids[$bj->bed_id] = $bj->bed_id;

					$bj->u_arrive = strtotime($bj->arrive);
		            $bj->u_depart = strtotime($bj->depart);

		            if(!empty($bj->due))
		            {
		                if(strtotime($bj->due) < strtotime(date('Y-m-d 00:00:00')))
		                    $bj->not_due = true;
		            }

		            $u_bj_interval = $bj->u_depart - $bj->u_arrive;

	                if(!empty($bj->paid_to))
	                {
	                    $bj->u_paid_to = strtotime($bj->paid_to);
	                    $bj->paid_width = ($bj->u_paid_to - $bj->u_arrive) / $u_bj_interval * 100;
	                }

	                if(!empty($bj->due))
	                {
	                    $bj->u_due = strtotime($bj->due);
	                    $bj->due_width = ($bj->u_due - $bj->u_arrive) / $u_bj_interval * 100;
	                    if($bj->due_width > 100)
	                        $bj->due_width = 100;
	                }
	                else
	                    $bj->due_width = 100;

	                if($bj->status == 0 || (isset($bj->not_due) && $bj->not_due == true))
	                	$bj_isset_canceled = true;

					$beds_journal[$bj->id] = $bj;

				}
				unset($beds_journal_);


				if(!empty($beds_ids))
				{
					$beds_ = $this->beds->get_beds(array('id'=>$beds_ids));

					if(!empty($beds_))
					{
						$rooms_ids = array();
						foreach($beds_ as $bed)
						{
							$beds[$bed->id] = $bed;
							if(!empty($bed->room_id))
								$rooms_ids[$bed->room_id] = $bed->room_id;
						}
						unset($beds_);

						if(!empty($rooms_ids))
						{
							$rooms_ = $this->beds->get_rooms(array('id'=>$rooms_ids));
							if(!empty($rooms_))
							{
								foreach($rooms_ as $room)
									$rooms[$room->id] = $room;
								unset($rooms_);
							}
						}


					}


					$rooms_types_ = $this->beds->get_rooms_types();
					if(!empty($rooms_types_))
					{
						foreach($rooms_types_ as $rt)
							$rooms_types[$rt->id] = $rt;
						unset($rooms_types_);
					}


				}

				$this->design->assign('beds', $beds);
				$this->design->assign('rooms', $rooms);
				$this->design->assign('rooms_types', $rooms_types);

				$this->design->assign('bj_isset_canceled', $bj_isset_canceled);
				$this->design->assign('beds_journal', $beds_journal);
			}




			$this->design->assign('user', $user);


			$orders = array();
			$invoices = array();
			$orders_ = $this->orders->get_orders(array('user_id'=>$user->id));

			if(!empty($orders_))
			{
				foreach($orders_ as $o)
				{
					if($o->type == 1) // Invoices
						$invoices[$o->id] = $o;
					elseif($o->type == 2) // Orders
						$orders[$o->id] = $o;
				}
				unset($orders_);

				// Все способы оплаты
			 	$payment_methods = array();
				$payment_methods_ = $this->payment->get_payment_methods();
				if(!empty($payment_methods_))
				{
					foreach($payment_methods_ as $pm)
						$payment_methods[$pm->id] = $pm;
					unset($payment_methods_);
				}
				$this->design->assign('payment_methods', $payment_methods);
			}


			$this->design->assign('orders', $orders);
			$this->design->assign('invoices', $invoices);

			$contracts_ = $this->contracts->get_contracts(array('user_id'=>$user->id, 'status'=>1));
			$contracts = array();
			$reservs_contracts = array();
			if(!empty($contracts_))
			{
				foreach($contracts_ as $contract)
				{
					$contracts[$contract->id] = $contract;

					if(!empty($contract->reserv_id))
						$reservs_contracts[$contract->reserv_id] = $contract->id;

				}
				unset($contracts_);
			}
			$this->design->assign('reservs_contracts', $reservs_contracts);
			$this->design->assign('contracts', $contracts);


		}


		$houses = $this->pages->get_pages(array('menu_id'=>5, 'not_tree'=>1));
		$this->design->assign('houses_all', $houses);
		if(!empty($houses))
			$houses= $this->categories_tree->get_categories_tree('houses', $houses);
		$this->design->assign('houses', $houses);
		
 	  	$groups = $this->users->get_groups();
		$this->design->assign('groups', $groups);


		if(empty($housecleaners_houses))
			$housecleaners_houses = array(0);
		$this->design->assign('housecleaners_houses', $housecleaners_houses);

		if(empty($houseleaders_houses))
			$houseleaders_houses = array(0);
		$this->design->assign('houseleaders_houses', $houseleaders_houses);

		if(empty($landlords_houses))
			$landlords_houses = array(0);
		$this->design->assign('landlords_houses', $landlords_houses);




		if($this->request->post('notification'))
		{
			$notification = $this->request->post('notification');

			if($notification == 'hellorented')
			{
				if(empty($user->first_name) && empty($user->last_name))
					$this->design->assign('message_error', 'Enter First and Last Name');
				elseif(empty($user->email))
					$this->design->assign('message_error', 'Enter Email');
				elseif(empty($user->phone))
					$this->design->assign('message_error', 'Enter phone number');
				elseif(empty($user->inquiry_arrive))
					$this->design->assign('message_error', 'Enter Inquiry Arrive');
				elseif(empty($user->inquiry_depart))
					$this->design->assign('message_error', 'Enter Inquiry Depart');
				elseif(empty($user->price_month))
					$this->design->assign('message_error', 'Enter Price');
				elseif(empty($user->price_deposit))
					$this->design->assign('message_error', 'Enter Deposit');
				elseif(empty($user->house_id))
					$this->design->assign('message_error', 'Select House');
				else
				{
					$house = $this->pages->get_page((int)$user->house_id);

					if(empty($house->blocks2))
						$this->design->assign('message_error', 'Enter Hellorented in House');
					else
					{
						$house->blocks2 = unserialize($house->blocks2);

						if(empty($house->blocks2['hellorented_link']))
							$this->design->assign('message_error', 'Enter Hellorented in House');
						else
						{
							//$this->design->assign('hellorented_link', $house->blocks2['hellorented_link']);

							$notification_id = $this->notifications->add_notification(array('user_id'=>$user->id, 'type'=>1));
							if(!empty($notification_id))
							{
								$notification = $this->notifications->get_notification($notification_id);
								if(!empty($notification))
									$this->design->assign('notification', $notification);
							}
							

							$email_template = $this->design->fetch($this->config->root_dir.'design/'.$this->settings->theme.'/html/email/hellorented.tpl');

							$subject = $this->design->get_var('subject');
							$this->notify->email($user->email, $subject, $email_template, $this->settings->notify_from_email);
							$this->design->assign('message_success', 'Hellorented notification sent to the customer');

						}

					}
	
				}
			}
			elseif($notification == 'bgcheck')
			{
				if(empty($user->first_name) && empty($user->last_name))
					$this->design->assign('message_error', 'Enter First and Last Name');
				elseif(empty($user->email))
					$this->design->assign('message_error', 'Enter Email');
				else
				{
					$notification_id = $this->notifications->add_notification(array('user_id'=>$user->id, 'type'=>2));
					if(!empty($notification_id))
					{
						$notification = $this->notifications->get_notification($notification_id);
						if(!empty($notification))
							$this->design->assign('notification', $notification);
					}
					

					$email_template = $this->design->fetch($this->config->root_dir.'design/'.$this->settings->theme.'/html/email/background_check.tpl');

					$subject = $this->design->get_var('subject');
					$this->notify->email($user->email, $subject, $email_template, $this->settings->notify_from_email);
					$this->design->assign('message_success', 'Background check notification sent to the customer');
				}
			}
			elseif($notification == 'sure')
			{
				if(empty($user->first_name) && empty($user->last_name))
					$this->design->assign('message_error', 'Enter First and Last Name');
				elseif(empty($user->email))
					$this->design->assign('message_error', 'Enter Email');
				else
				{
					$sure_id = $this->sure->add_sure(array('user_id'=>$user->id));

					if(!empty($sure_id))
					{
						$sure = $this->sure->get_sure($sure_id);
						if(!empty($sure))
							$this->design->assign('sure', $sure);
					}
					

					$email_template = $this->design->fetch($this->config->root_dir.'design/'.$this->settings->theme.'/html/email/sure.tpl');

					$subject = $this->design->get_var('subject');
					$this->notify->email($user->email, $subject, $email_template, $this->settings->notify_from_email);
					$this->design->assign('message_success', 'Sure email sent to the customer');
				}
			}
		}

		if($this->request->post('to_checkr'))
		{
			if(empty($user->checkr_candidate_id))
				$this->checkr->create_candidate($user->id);
		}
		


		if(!empty($user->id))
		{
			// Notifications
			$notifications = $this->notifications->get_notifications(array('user_id'=>$user->id));
			if(!empty($notifications))
			{
				$notifications_hellorented = array();
				$notifications_bgcheck = array();

				foreach($notifications as $notification)
				{
					if($notification->type == 1)
						$notifications_hellorented[] = $notification;
					elseif($notification->type == 2)
						$notifications_bgcheck[] = $notification;
				}

				$this->design->assign('notifications_hellorented', $notifications_hellorented);
				$this->design->assign('notifications_bgcheck', $notifications_bgcheck);
			}

			//Sures
			$sures = $this->sure->get_sures(array('user_id'=>$user->id));
			if(!empty($sures))
				$this->design->assign('sures', $sures);
		}

		



		// if(!empty($user->image))
		// {
		// 	$img_url = $this->config->root_dir.$this->config->users_images_dir.$user->image;
		// 	$color_img = $this->image->Get_Color($img_url);
		// }

		
 	  	return $this->design->fetch('user.tpl');
	}
	
}

