<?PHP
require_once('api/Backend.php');

class UserAdmin extends Backend
{	
	public function fetch()
	{
		$user = new stdClass;
		$houseleaders_houses = array();
		$manager = $this->managers->get_manager();

		$approve = $this->request->get('approve', 'integer'); 
		$add_to_contract = $this->request->get('add_to_contract', 'integer'); 

		if(!empty($_POST['to_status']) || !empty($approve))
		{
			$user->id = $this->request->post('id', 'integer');
			$user->status = $this->request->post('to_status', 'integer');

			if(!empty($approve))
			{
				$user->id = $this->request->get('id', 'integer'); 
				$user->status = 2;

				$booking_id = $this->request->get('booking', 'integer'); 

				if(!empty($add_to_contract))
				{
					$add_to_contract = 1;
					$this->beds->update_booking($booking_id, array('add_to_contract'=>1));
				}

				$this->logs->add_log(array(
	                'parent_id' => $booking_id, 
	                'type' => 1, 
	                'subtype' => 11, // booking approved (airbnb)
	                'sender_type' => 2,
	                'sender' => $manager->login
	            ));
			}


			if($user->status == 4)
				$user->enabled = 0;
			elseif($user->status == 3)
				$user->enabled = 1;

			if(!empty($user->id))
				$this->users->update_user($user->id, $user);
		}
		if(!empty($_POST['add_log']))
		{
			$this->logs->add_log(array(
                'parent_id' => $this->request->post('add_log', 'integer'), 
                'type' => 2, 
                'subtype' => 1, // user note
                'sender_type' => 2,
                'sender' => $manager->login,
                'user_id' => $this->request->post('add_log', 'integer'),
                'value' => $this->request->post('log_text')
            ));
		}
		if(!empty($_POST['user_info']) && empty($_POST['add_log']))
		{
			$user->id = $this->request->post('id', 'integer');
			if($this->request->post('sku', 'integer'))
				$user->sku = $this->request->post('sku', 'integer');

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
			

			// $user->house_id = $this->request->post('house_id', 'integer');
			// $user->bed_name = trim($this->request->post('bed_name'));
			// $user->bed_id = trim($this->request->post('bed_id', 'integer'));
			// $user->inquiry_arrive = date('Y-m-d', strtotime($this->request->post('inquiry_arrive')));
			// $user->inquiry_depart   = date('Y-m-d', strtotime($this->request->post('inquiry_depart')));
			// $user->price_month = $this->request->post('price_month');
			// $user->price_deposit = $this->request->post('price_deposit');
			// $user->membership = $this->request->post('membership', 'integer');
			// $user->room_type = $this->request->post('room_type', 'integer');

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
			{
				$user_blocks_old_data = 0;
				if(!empty($user->id))
				{
					if($user_ = $this->users->get_user($user->id))
					{
						if(!empty($user_->blocks))
						{
							$user_blocks_old_data = unserialize($user_->blocks);
						}
					}

				}

				if(!empty($user_blocks_old_data))
				{
					$user->blocks = $user_blocks_old_data;
					foreach($this->request->post('blocks') as $k=>$value)
						$user->blocks[$k] = $value;
					
					$user->blocks = serialize($user->blocks);
				}
				else
				{
					$user->blocks = serialize($this->request->post('blocks'));
				}
			}


			if($this->request->post('password'))
			{
				$user->first_pass = $this->request->post('password');
				$user->password = $this->request->post('password');
			}


			if($user->status == 4 || $user->status == 5 || $user->status==6)
				$user->enabled = 0;

			if($user->status == 3)
				$user->enabled = 1;

			if(($user->status == 5 || $user->status==6) && !empty($user->id)) // Canceled (6) || Blacklist (5)
			{
				$note = 'Guest Status Changed - to ';
				if($user->status == 5)
					$note .= 'Blacklist';
				elseif($user->status == 6)
					$note .= 'Canceled';

				// Cancel bookings
				/*
				$user_bookings = $this->beds->get_bookings(array('user_id' => $user->id));

				if(!empty($user_bookings))
				{
					$aparnments_bookings_ids = array();
					$cancel_bookings = array();
					foreach($user_bookings as $b)
					{
						if($b->type == 2) // Apartment booking
							$aparnments_bookings_ids[$b->id] = $b->id;
						else
							$cancel_bookings[$b->id] = $b->id;
					}

					if(!empty($aparnments_bookings_ids))
					{
						$ab_users = $this->beds->get_bookings_users(array('booking_id'=>$aparnments_bookings_ids));
						if(!empty($ab_users))
						{
							$a_bookings_users = array();
							foreach($ab_users as $bu)
								$a_bookings_users[$bu->booking_id][$bu->user_id] = $bu->user_id;

							foreach($aparnments_bookings_ids as $booking_id)
							{
								if(isset($a_bookings_users[$booking_id]) && count($a_bookings_users[$booking_id]) < 2)
									$cancel_bookings[$booking_id] = $booking_id;
							}
						}
					}

					if(!empty($cancel_bookings))
					{
						$this->beds->cancel_booking(array(
							'id' => $cancel_bookings, 
							'note' => $note
						));
					}
				}
				*/
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
			elseif(!empty($user->sku) && ($u = $this->users->get_users(array('sku' => $user->sku, 'limit' => 1, 'count' => 1))) && $u->id != $user->id)
			{			
				$this->design->assign('message_error', 'sku_existed');
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
					// $email_template = $this->design->fetch($this->config->root_dir.'design/'.$this->settings->theme.'/html/email_user_pass.tpl');
					// $subject = $this->design->get_var('subject');

					// $this->notify->email($user->email, $subject, $email_template, $this->settings->notify_from_email);


					$user->auth_code = md5(uniqid($this->config->salt, true));

					$user->id = $this->users->add_user($user);
					$this->design->assign('message_success', 'added');
	   	    		$user = $this->users->get_user(intval($user->id));

	   	    		$this->logs->add_log(array(
	                    'parent_id' => $user->id, 
	                    'type' => 2, 
	                    'subtype' => 2, // user created
	                    'sender_type' => 2,
	                    'sender' => $manager->login
	                ));

	   	    		// Ekata
	   	    		/*
	   	    		$e = $this->ekata->identity_check(array(
						'user_id' => $user->id,
						'sender_type' => 1
					));
					*/

	   	    		$new_user = 1;
				}
				// Update user
				else
				{

					$files_dir = $this->config->root_dir.'/'.$this->config->users_files_dir.$user->id.'/files/';

					// $user->status == 5 || 
					if($user->status==6)
					{
						// --------- edit code ------------
						// переписать этот код после обновления связей множественные user_id и contract_id 
						// и множественные user_id и order_id (это под вопросом, еще не знаем логику реализации)
						// --------------------------------

						// Contracts to Canceled
						$contracts = $this->contracts->get_contracts(array('user_id'=>$user->id, 'status'=>array(1)));
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

				    	// ------- edit code (end) --------
					}

					if(empty($user->auth_code))
					{
						$user->auth_code = md5(uniqid($this->config->salt, true));
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


  	    		// Files
  	    		$files = $this->request->files('dropped_files');
  	    		if(!empty($files))
  	    		{
  	    			if(!file_exists($this->config->root_dir.'/'.$this->config->users_files_dir.$user->id.'/'))
  	    			{
						mkdir($this->config->root_dir.'/'.$this->config->users_files_dir.$user->id.'/', 0755);
						mkdir($files_dir, 0755);
  	    			}
  	    			elseif(!file_exists($files_dir))
  	    			{
  	    				mkdir($files_dir, 0755);
  	    			}


					for($i=0; $i<count($files['name']); $i++)
					{

						$uploaded_file = $new_name = pathinfo($files['name'][$i], PATHINFO_BASENAME);
						$base = pathinfo($uploaded_file, PATHINFO_FILENAME);
						$ext = pathinfo($uploaded_file, PATHINFO_EXTENSION);

						while(file_exists($files_dir.$new_name))
						{	
							$new_base = pathinfo($new_name, PATHINFO_FILENAME);
							if(preg_match('/_([0-9]+)$/', $new_base, $parts))
								$new_name = $base.'_'.($parts[1]+1).'.'.$ext;
							else
								$new_name = $base.'_1.'.$ext;
						}
						move_uploaded_file($files['tmp_name'][$i], $files_dir.$new_name);	
					}
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
			$files_dir = $this->config->root_dir.'/'.$this->config->users_files_dir.$user->id.'/files/';

			if(empty($user->auth_code))
			{
				$user->auth_code = md5(uniqid($this->config->salt, true));
				$this->users->update_user($user->id, array('auth_code'=>$user->auth_code));
			}

			if($this->request->post('to_checkr'))
			{
				if(empty($user->checkr_candidate_id))
				{
					$this->checkr->create_candidate($user->id);
					$user = $this->users->get_user(intval($id));
				}
			}

			if($this->request->post('to_transunion'))
			{
				if(empty($user->transunion_id))
				{
					$r = $this->transunion->create_application($user->id);
					if(is_object($r) && $r->status == 'succeeded')
					{
						$this->design->assign('message_success', 'Request to Transunion is succeeded');
						$user = $this->users->get_user(intval($id));
					}
					else
						$this->design->assign('message_error', $r);
					
				}
			}



			if(!empty($user->blocks))
			{
				$user->blocks = unserialize($user->blocks);

				if(!empty($user->blocks['rental_application']))
				{
					$ra_file_url = $this->config->users_files_dir.$user->id.'/rental_application_signature.png';
					if(file_exists($ra_file_url))
					{
						$user->blocks['ra_signature'] = $ra_file_url;
					}
				}
			}

			// move ins \ outs

			$moves = $this->houseleader->get_moveins(array('user_id'=>$user->id, 'status'=>1));
			foreach ($moves as $m) 
			{
				if(!empty($m->inputs))
				{
					$m->inputs = unserialize($m->inputs);
				}
			}
			$this->design->assign('moves', $moves);

			// move ins \ outs END


			$houseleaders_houses = $this->users->get_houseleaders_houses(array('user_id'=>$user->id));
			$housecleaners_houses = $this->users->get_housecleaners_houses(array('user_id'=>$user->id));
			$landlords_houses = $this->users->get_landlords_houses(array('user_id'=>$user->id));

			if(!empty($user->checker_options))
				$user->checker_options = unserialize($user->checker_options);


			$u_files = array();
			if(!empty($user->files))
				$u_files = unserialize($user->files);

			if($del_files = $this->request->post('delete_files'))
			{
				foreach($del_files as $filename)
				{
					if(!empty($filename))
						@unlink($files_dir.$filename);
				}
			}
		
			if(!empty($u_files))
			{

				foreach($u_files as $k=>$f)
				{

					if(is_int($k))
					{
						$user->move_in_files[] = $f;
					}
					elseif(in_array($k, array('usa_doc', 'usa_selfie', 'visa', 'passport', 'selfie', 'additional')))
					{
						$user->documents[$k] = $f;
					}
					elseif(in_array($k, array('from_move_in')))
					{
						if(is_array($f))
						{
							foreach ($f as $ff)
								$user->move_in_files[] = $ff;
						}
						else
							$user->move_in_files[] = $f;
					}
					elseif(in_array($k, array('from_move_out')))
					{
						if(is_array($f))
						{
							foreach ($f as $ff)
								$user->move_out_files[] = $ff;
						}
						else
							$user->move_out_files[] = $f;
					}
					

					elseif(is_array($f))
					{
					}
				}

			}

			// Files
			$user_files = array();
			if(file_exists($files_dir))
			{
				$files = array_diff(scandir($files_dir), array('..', '.'));
				if(!empty($files))
				{
					foreach($files as $k=>$filename)
					{
						$f = new stdClass;
						$f->filename = $filename;
						$f->date = filectime($files_dir.$filename);

						$f_size = filesize($files_dir.$filename);
						$f->size = $f_size.' B';
						if($f_size > 999)
							$f->size = round(($f_size / 1024), 2).' KB';
						if($f_size > 999000)
							$f->size = round(($f_size / 1024 / 1024), 2).' MB';

						$fn_arr = explode('.', $filename);
						$f->ext = strtolower(array_pop($fn_arr));


						$user_files[$f->date.$k] = $f;

					}
					if(!empty($user_files))
					{
						// krsort($user_files);
						ksort($user_files);
					}
				}
			}
			$this->design->assign('user_files', $user_files);


			

			if(!empty($user->social_number))
				$user->social_number = base64_decode(base64_decode($user->social_number));

			if(!empty($user->zip))
				$user->zip = base64_decode($user->zip);


			// ------------
			// --- BEDS ---
			// ------------


			// ----------------
			// --- old code ---
			// ----------------

			// Rooms
			$rooms2 = array();
			$old_bed_info_hide = true;
			if(!empty($user->house_id) && $old_bed_info_hide == false)
			{
				$rooms2_ = $this->beds->get_rooms([
					'house_id' => $user->house_id, 
					//'visible' => 1
				]);
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
			// --- old code (end) ---


			


			// BOOKINGS

			$bookings_ = $this->beds->get_bookings([
				'user_id' => $user->id
			]);
			if(!empty($bookings_))
			{
				$bookings = array();
				$bj_isset_canceled = false;
				$beds_ids = array();

				$beds = array();
				$apartments = array();
				$rooms = array();
				$rooms_types = array();

				$apartments_ids = array();

				

				$apartments_bookings = array();
				$beds_bookings = array();

				$sp_group_ids = [];
				$sp_group_bookings_ids = [];
				foreach($bookings_ as $k=>$b)
				{
					$b->u_arrive = strtotime($b->arrive);
		            $b->u_depart = strtotime($b->depart);

					if(!empty($b->sp_group_id))
					{
						$sp_group_ids[$b->sp_group_id] = $b->sp_group_id;
						$sp_group_bookings_ids[$b->sp_group_id][$b->id] = $b->id;
					}


					if($b->type == 1) // bed booking
					{
						$beds_bookings[$b->id] = $b;

						if(!empty($b->object_id))
							$beds_ids[$b->object_id] = $b->object_id;
					}
					elseif($b->type == 2) // apartment booking
					{
						$apartments_bookings[$b->id] = $b;
						$apartments_ids[$b->object_id] = $b->object_id;
					}
				}

				if(!empty($sp_group_ids))
				{
					$sp_group_bookings = $this->beds->get_bookings([
						'sp_group_id' => $sp_group_ids,
						'order_by' => 'b.arrive'
					]);

					if(!empty($sp_group_bookings))
					{
						foreach($sp_group_bookings as $b)
						{
							$b->u_arrive = strtotime($b->arrive);
		            		$b->u_depart = strtotime($b->depart);
							if(isset($sp_group_bookings_ids[$b->sp_group_id]))
							{
								foreach($sp_group_bookings_ids[$b->sp_group_id] as $b_id)
								{
									// if($b_id != $b->id)
									$bookings_[$b_id]->sp_bookings[$b->id] = $b;
									if($b->u_depart > $bookings_[$b_id]->u_depart)
									{
										$bookings_[$b_id]->u_depart = $b->u_depart;
										$bookings_[$b_id]->depart = date('Y-m-d', $b->u_depart);
									}

									if($user->active_booking_id == $b->id)
										$user->active_booking_id = $b_id;
								}
							}

							if($b->type == 1) // bed booking
							{
								$beds_bookings[$b->id] = $b;

								if(!empty($b->object_id))
									$beds_ids[$b->object_id] = $b->object_id;
							}
							elseif($b->type == 2) // apartment booking
							{
								$apartments_bookings[$b->id] = $b;
								$apartments_ids[$b->object_id] = $b->object_id;
							}


						}
					}
				}


				foreach($bookings_ as $bj)
				{
					
					

		            if(!empty($bj->due))
		            {
		                if(strtotime($bj->due) < strtotime(date('Y-m-d 00:00:00')))
		                    $bj->not_due = true;
		            }

		            $u_bj_interval = $bj->u_depart - $bj->u_arrive;

					$bj->days_count = ceil($u_bj_interval / (24 * 60 * 60) + 1);

	                if(!empty($bj->paid_to))
	                {
	                    $bj->u_paid_to = strtotime($bj->paid_to);
	                    $bj->paid_width = ($bj->u_paid_to - $bj->u_arrive) / $u_bj_interval * 100;
	                    if($bj->paid_width > 100)
	                    	$bj->paid_width = 100;
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

					$bookings[$bj->id] = $bj;

				}
				unset($bookings_);


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
								{
									$rooms[$room->id] = $room;
									if(!empty($room->apartment_id))
										$apartments_ids[$room->apartment_id] = $room->apartment_id;
								}
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


				if(!empty($apartments_ids))
				{
					$apartments_ = $this->beds->get_apartments(array(
                        'id' => $apartments_ids,
                        'limit' => count($apartments_ids) + 1
                    ));
                    if(!empty($apartments_))
                    {
                        foreach($apartments_ as $a)
                            $apartments[$a->id] = $a;
                        unset($apartments_);
                    }
				}

				if(!empty($apartments_bookings[$user->active_booking_id]))
					$current_booking = $apartments_bookings[$user->active_booking_id];
				elseif(!empty($beds_bookings[$user->active_booking_id]))
					$current_booking = $beds_bookings[$user->active_booking_id];

				if(!empty($current_booking))
				{
					if(!empty($current_booking->apartment_id))
					{

						$apt_bookings = $this->beds->get_bookings(array(
							'apartment_id' => $current_booking->apartment_id, 
							'not_canceled' => 1,
							'select_users' => true
						));
						if(!empty($apt_bookings))
						{
							foreach($apt_bookings as $b) 
							{
								if(!empty($b->users))
								{
									foreach ($b->users as $u) 
									{
										if($u->status == 3 && $user->id != $u->id)
											$apt_users[$u->id] = $u;
									}
								}
							}
						}

						$user->current_booking = $current_booking;
						$user->current_apt = $apartments[$current_booking->apartment_id];
						$user->current_bed = $beds[$current_booking->object_id];
						$user->house = $this->pages->get_page((int)$current_booking->house_id);
						if(!empty($user->house))
						{

							$user->house->blocks2 = unserialize($user->house->blocks2);
						}

						$houseleaders_ = $this->users->get_houseleaders_houses(array('house_id'=>$user->house->id));
						if(!empty($houseleaders_))
						{
							foreach ($houseleaders_ as $h) 
							{
								$houseleaders_ids[] = $h->user_id;
							}
							if(!empty($houseleaders_ids))
							{
								$houseleaders_users = $this->users->get_users(array('id'=>$houseleaders_ids));
								$houseleaders_users = $this->request->array_to_key($houseleaders_users, 'id');
							}
						}

						
					}
				}
				$this->design->assign('houseleaders', $houseleaders_users);

				
				$this->design->assign('apt_users', $apt_users);

				$this->design->assign('clients_types', $this->users->clients_types);
				$this->design->assign('bj_statuses', $this->beds->bookings_statuses);

				$this->design->assign('beds', $beds);
				$this->design->assign('apartments', $apartments);
				$this->design->assign('rooms', $rooms);

				$this->design->assign('rooms_types', $rooms_types);

				$this->design->assign('bj_isset_canceled', $bj_isset_canceled);
				$this->design->assign('bookings', $bookings);

			}

			if(!empty($user->state_code))
				$user->state = $this->users->get_state($user->state_code);



			


			$orders = array();
			$invoices = array();
			$security_deposits = array();
			$orders_ = $this->orders->get_orders(array('user_id'=>$user->id, 'sort'=>1, 'not_status'=>3));


			if(!empty($orders_))
			{
				foreach($orders_ as $o)
				{
					if($o->type != 2) // Invoices
					{
						if(!empty($o->date_from))
						{
							$o_interval = date_diff(date_create($o->date_from), date_create($o->date_to));
							$o->days_count = $o_interval->days + 1;
						}
						$invoices[$o->id] = $o;

						// Security Deposits
						if($o->deposit == 1)
							$security_deposits[$o->id] = $o;
					}
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
			$this->design->assign('security_deposits', $security_deposits);

			$contracts_ = $this->contracts->get_contracts(array('user_id'=>$user->id, 'status'=>array(1,2)));
			// print_r($contracts_); exit;
			$contracts = array();
			$reservs_contracts = array();
			if(!empty($contracts_))
			{
				foreach($contracts_ as $c)
				{
					$contracts[$c->id] = $c;

					if(!empty($c->date_from) && !empty($c->date_to) && $c->price_month > 0 && $c->total_price < 1)
					{
						$contract_calculate = $this->contracts->calculate($c->date_from, $c->date_to, $c->price_month);
						if(!empty($contract_calculate))
						{
							$contracts[$c->id]->total_price = $contract_calculate->total;
							$contracts[$c->id]->days_count = $contract_calculate->days;
						}
					}
					elseif(!empty($c->date_from) && !empty($c->date_to))
					{
						$interval = date_diff(date_create($c->date_from), date_create($c->date_to));
						$contracts[$c->id]->days_count = $interval->days + 1;
					}

					if(!empty($c->reserv_id))
						$reservs_contracts[$c->reserv_id] = $c->id;

				}
				unset($contracts_);
			}
			$this->design->assign('reservs_contracts', $reservs_contracts);
			$this->design->assign('contracts', $contracts);


		}


		$houses = $this->pages->get_pages(array('menu_id'=>5, 'not_tree'=>1));
		if(!empty($houses))
		{
			foreach($houses as $k=>$h)
            {
                if(!empty($h->blocks2))
                    $houses[$k]->blocks2 = unserialize($h->blocks2);
            }
            $this->design->assign('houses_all', $houses);
			$houses= $this->categories_tree->get_categories_tree('houses', $houses);
		}
		$this->design->assign('houses', $houses);


		$companies = $this->companies->get_companies();
		$this->design->assign('companies', $companies);
		


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


		$booking = false;
		$contract = false;
		if(!empty($user->active_booking_id))
		{
			if(empty($current_booking))
				$booking = $this->beds->get_bookings(array(
					'id' => $user->active_booking_id,
					'limit' => 1
				));
			else
				$booking = $current_booking;

			if(!empty($booking))
			{
				$contract = $this->contracts->get_contracts(array(
					'reserv_id' => $booking->id,
					'limit' => 1,
					'status' => 1
				));

				if(!empty($contract))
				{
					$contract = current($contract);
					$orders_filter['contract_id'] = $contract->id;
				}
				$orders_filter['deposit'] = 0;
				$orders_filter['not_status'] = 3;
				$orders_filter['sort_date_from'] = 1;
				$orders_filter['date_from'] = '2000-01-01';
				$orders_filter['booking_id'] = $booking->id;

				$booking->orders = $this->orders->get_orders($orders_filter);

				$orders_filter['deposit'] = 1;

				$booking->deposit = current($this->orders->get_orders($orders_filter));

				unset($orders_filter['date_from']);
				unset($orders_filter['deposit']);
				$orders_filter['type'] = 7;

				$booking->invoicefee = current($this->orders->get_orders($orders_filter));

			}
		}

		$this->design->assign('cur_booking', $booking);
		$this->design->assign('cur_contract', $contract);

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
				elseif(empty($user->active_booking_id))
					$this->design->assign('message_error', 'No active booking');
				elseif(empty($booking))
					$this->design->assign('message_error', 'No booking');
				elseif(empty($contract))
					$this->design->assign('message_error', 'No booking contract');
				elseif($contract->price_month < 1)
					$this->design->assign('message_error', 'Enter Price in Contract #'.$contract->id);
				elseif($contract->price_deposit < 1)
					$this->design->assign('message_error', 'Enter Deposit in Contract #'.$contract->id);



				// elseif(empty($user->inquiry_arrive))
				// 	$this->design->assign('message_error', 'Enter Inquiry Arrive');
				// elseif(empty($user->inquiry_depart))
				// 	$this->design->assign('message_error', 'Enter Inquiry Depart');
				// elseif(empty($user->price_month))
				// 	$this->design->assign('message_error', 'Enter Price');
				// elseif(empty($user->price_deposit))
				// 	$this->design->assign('message_error', 'Enter Deposit');
				// elseif(empty($user->house_id))
				// 	$this->design->assign('message_error', 'Select House');

				else
				{
					$house = $this->pages->get_page((int)$booking->house_id);

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

			// Send notification - Rental Application
			elseif($notification == 'rental_app')
			{
				$this->design->assign('user', $user);

				$email_template = $this->design->fetch($this->config->root_dir.'design/'.$this->settings->theme.'/html/email/rental_application.tpl');

				$subject = $this->design->get_var('subject');
				$this->notify->email($user->email, $subject, $email_template, $this->settings->notify_from_email);
				$this->design->assign('message_success', 'Rental Application email sent to the customer');


				// Add log
				$this->logs->add_log(array(
					'parent_id'=> $user->id, 
					'type' => 7, // Rental Application
					'subtype' => 1, // Sended
					'user_id' => $user->id, 
					'sender_type' => 2, // Admin
					'sender' => $manager->login
				));

			}

			// Send notification - Covid Form
			elseif($notification == 'covid_form')
			{
				$this->design->assign('user', $user);

				$email_template = $this->design->fetch($this->config->root_dir.'design/'.$this->settings->theme.'/html/email/covid_form.tpl');

				$subject = $this->design->get_var('subject');
				$this->notify->email($user->email, $subject, $email_template, $this->settings->notify_from_email);
				$this->design->assign('message_success', 'Covid Form email sent to the customer');


				// Add log
				$this->logs->add_log(array(
					'parent_id'=> $user->id, 
					'type' => 8, // Covid Form
					'subtype' => 1, // Sended
					'user_id' => $user->id, 
					'sender_type' => 2, // Admin
					'sender' => $manager->login
				));

			}


			// Send notification - Window Guards
			elseif($notification == 'window_guards')
			{
				$this->design->assign('user', $user);

				$email_template = $this->design->fetch($this->config->root_dir.'design/'.$this->settings->theme.'/html/email/window_guards.tpl');

				$subject = $this->design->get_var('subject');
				$this->notify->email($user->email, $subject, $email_template, $this->settings->notify_from_email);
				$this->design->assign('message_success', 'Window Guards email sent to the customer');


				// Add log
				$this->logs->add_log(array(
					'parent_id'=> $user->id, 
					'type' => 12, // Window Guards
					'subtype' => 1, // Sended
					'user_id' => $user->id, 
					'sender_type' => 2, // Admin
					'sender' => $manager->login
				));

			}

			// Send notification - Remote check-in
			elseif($notification == 'remote_move_in')
			{
				if($this->request->post('houseleader_mailto'))
					$houseleader_mailto = $houseleaders_users[$this->request->post('houseleader_mailto')];
				
				$this->design->assign('houseleader', $houseleader_mailto);
				$this->design->assign('user', $user);

				$email_template = $this->design->fetch($this->config->root_dir.'design/'.$this->settings->theme.'/html/email/remote_move_in.tpl');

				$subject = $this->design->get_var('subject');
				$this->notify->email($user->email, $subject, $email_template, $this->settings->notify_from_email);
				$this->design->assign('message_success', 'Remote move-in email sent to the customer');


				// Add log
				$this->logs->add_log(array(
					'parent_id'=> $user->id, 
					'type' => 10, // Remote check-in
					'subtype' => 1, // Sended
					'user_id' => $user->id, 
					'sender_type' => 2, // Admin
					'sender' => $manager->login
				));

			}
		}


		// Ekata
		if($this->request->post('ekata'))
		{
			$e = $this->ekata->identity_check(array(
				'user_id' => $user->id,
				'sender_type' => 2,
				'sender' => $manager->login
			));
		}


		if(!empty($user->id))
		{

			// Salesflows 
			if(!empty($user->active_salesflow_id))
			{
				$salesflows = $this->salesflows->get_salesflows(['user_id'=>$user->id]);

				$salesflows = $this->request->array_to_key($salesflows, 'id');

				if(!empty($salesflows))
				{
					foreach ($salesflows as $s) 
					{
						if(!empty($s->application_data))
							$s->application_data = unserialize($s->application_data);

						if(!empty($s->additional_files))
							$s->additional_files = unserialize($s->additional_files);

						if(!empty($s->ekata_status))
							$s->ekata_status = unserialize($active_salesflow->ekata_status);

						if(!empty($s->transunion_data))
						{
							$s->transunion_data = simplexml_load_string($s->transunion_data, 'SimpleXMLElement', LIBXML_NOCDATA);

							if(!empty($s->transunion_data->BackgroundReport))
							{

								$s->transunion_html = $s->transunion_data->BackgroundReport;
								$s->transunion_html = preg_replace("/(<!DOCTYPE[^>]*[>])|(<html[^>]*[>])|(<\/html>)|(<[\/]?head>)|(<[\/]?body>)|(<title>[^<]*<\/title>)|(<meta[^>]*[>])|(body[^}]*[}])|(h1\,[^}]*[}])|(p\s[^}]*[}])|(img\s[^}]*[}])/i", '', $s->transunion_html);

								$s->transunion_html = preg_replace("/\<a .*\>.*\<\/a\>/i", '', $s->transunion_html);
								$s->transunion_html = preg_replace("/header/i", 'header2', $s->transunion_html);
							}
						}
					}
					$this->design->assign('salesflows', $salesflows);
				}

			}




			// Hellorented
			if($this->request->post('hellorented_invite_tenant') && $this->request->post('hellorented_invite_tenant_booking_id'))
			{
				$hellorented_invite_tenant = $this->hellorented->invite_tenant($user->id, null, $this->request->post('hellorented_invite_tenant_booking_id'));
				// print_r($hellorented_invite_tenant); exit;

				if(!empty($hellorented_invite_tenant->errors[0]->code))
				{
					$this->design->assign('message_error', $hellorented_invite_tenant->errors[0]->code.' - '.$hellorented_invite_tenant->errors[0]->message);
				}
				else
				{
					$this->design->assign('message_error', $hellorented_invite_tenant);
				}
			}


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


			// Logs
			$hellorented_logs = array();
			$rental_app_logs = array();
			$covid_form_logs = array();
			$ekata_logs = array();
			$remote_move_in_logs = array();
			$window_guards_logs = [];

			$invoices_logs = array();
			$contracts_logs = array();
			$bookings_logs = array();

			$orders_keys = array_merge(array_keys($orders), array_keys($invoices));

			if(!empty($orders_keys))
				$invoices_logs = $this->logs->get_logs([
					'parent_id' => $orders_keys,
					'type' => [3], // invoices
				]);

			$this->design->assign('invoices_logs', $invoices_logs);

			$all_contracts = $this->contracts->get_contracts([
				'user_id' => $user->id
			]);

			$all_contracts = $this->request->array_to_key($all_contracts, 'id');

			if(!empty($all_contracts))
				$contracts_logs = $this->logs->get_logs([
					'parent_id' => array_keys($all_contracts),
					'type' => [4], // contracts
				]);

			$this->design->assign('all_contracts', $all_contracts);
			$this->design->assign('contracts_logs', $contracts_logs);

			if(!empty($bookings))
				$bookings_logs = $this->logs->get_logs([
					'parent_id' => array_keys($bookings),
					'type' => [1], // bookings
				]);

			foreach ($bookings_logs as $bl) 
			{
				if($bl->parent_id == $booking->id && $bl->subtype == 11)
				{
					$booking->approved = 1;
					$this->design->assign('cur_booking', $booking);
				}
			}

			$this->design->assign('bookings_logs', $bookings_logs);

			$logs = $this->logs->get_logs(array(
				'user_id' => $user->id,
				'type' => array(
					2, // User logs
					5, // Hellorented
					7, // Rental Application
					8, // Covid Form
					9, // Ekata
					12 // Window Guards
				)
			));
			if(!empty($logs))
			{
				foreach($logs as $log)
				{
					if($log->type == 5)
						$hellorented_logs[$log->id] = $log;
					elseif($log->type == 2)
						$user_logs_[$log->id] = $log;
					elseif($log->type == 7)
						$rental_app_logs[$log->id] = $log;
					elseif($log->type == 8)
						$covid_form_logs[$log->id] = $log;
					elseif($log->type == 9)
						$ekata_logs[$log->id] = $log;
					elseif($log->type == 10)
						$remote_move_in_logs[$log->id] = $log;
					elseif($log->type == 12)
						$window_guards_logs[$log->id] = $log;
				}
			}

			$this->design->assign('logs', $user_logs_);


			// Hellorented Logs
			if(!empty($user->hellorented_tenant_id))
			{	
				/*
				$hellorented_logs = $this->logs->get_logs(array(
					'user_id' => $user->id,
					'type' => 5 // 5 - Hellorented
				));
				*/

				if(!empty($hellorented_logs))
				{
					foreach($hellorented_logs as &$log)
					{
						if(!empty($log->data))
						{
							if(!empty($log->data->status_id))
							{
								if(isset($this->hellorented->application_statuses[$log->data->status_id]))
								{
									$application_status = $this->hellorented->application_statuses[$log->data->status_id];

									$log->value .= $application_status['description'];
								}

							}
						}
					}
				}

				$this->design->assign('hellorented_logs', $hellorented_logs);
			}

			//Sures
			$sures = $this->sure->get_sures(array('user_id'=>$user->id));
			if(!empty($sures))
				$this->design->assign('sures', $sures);

			if(!empty($user->active_salesflow_id))
				$active_salesflow = $this->salesflows->get_salesflows(['id'=>$user->active_salesflow_id, 'limit'=>1]);

			if(!empty($active_salesflow))
			{
				$active_salesflow->application_data = unserialize($active_salesflow->application_data);
				$active_salesflow->additional_files = unserialize($active_salesflow->additional_files);
				$active_salesflow->ekata_status = unserialize($active_salesflow->ekata_status);
			}

			// Transunion
			if(!empty($active_salesflow->transunion_id))
			{
				// $transunion_logs = $this->logs->get_logs(array(
				// 	'user_id' => $user->id,
				// 	'type' => 6 // 6 - transunion
				// ));

				if(!empty($active_salesflow->transunion_data))
				{
					$user->transunion_data = simplexml_load_string($active_salesflow->transunion_data, 'SimpleXMLElement', LIBXML_NOCDATA);

					if(!empty($user->transunion_data->BackgroundReport))
					{

						$user->transunion_html = $user->transunion_data->BackgroundReport;
						$user->transunion_html = preg_replace("/(<!DOCTYPE[^>]*[>])|(<html[^>]*[>])|(<\/html>)|(<[\/]?head>)|(<[\/]?body>)|(<title>[^<]*<\/title>)|(<meta[^>]*[>])|(body[^}]*[}])|(h1\,[^}]*[}])|(p\s[^}]*[}])|(img\s[^}]*[}])/i", '', $user->transunion_html);

						$user->transunion_html = preg_replace("/\<a .*\>.*\<\/a\>/i", '', $user->transunion_html);
						$user->transunion_html = preg_replace("/header/i", 'header2', $user->transunion_html);
					}
				}


				// $this->design->assign('transunion_logs', $transunion_logs);
			}

			// Rental Application
			// $rental_app_logs = $this->logs->get_logs(array(
			// 	'user_id' => $user->id,
			// 	'type' => 7 // 7 - Rental Application
			// ));
			$this->design->assign('rental_app_logs', $rental_app_logs);



			// Ekata
			if(!empty($ekata_logs))
			{
				$ekata_logs_ = array();
				foreach($ekata_logs as $k=>$ekata_log)
				{
					if(!empty($ekata_log->data))
					{
						$ekata_data = unserialize(unserialize($ekata_log->data));

						// print_r($ekata_data); exit;

						if(!empty($ekata_data))
						{
							$ekata = new stdClass;

							foreach($ekata_data as $d_key=>$d_val)
							{
								$d_name = ucfirst(str_replace(array('_','.'), ' ', $d_key));
								$ekata->$d_key = new stdClass;
								$ekata->$d_key->name = $d_name;

								if($d_key == 'identity_network_score')
								{
									$ekata->$d_key->value->score = $d_val; 

									$ekata->$d_key->value->pr = round($d_val * 100);
									$ekata->$d_key->value->status = $this->ekata->get_status(array(
										'value' => $d_val,
										'type' => $d_key
									));
								}
								elseif($d_key == 'identity_check_score')
								{
									$ekata->$d_key->value->score = $d_val; 

									$ekata->$d_key->value->pr = round(($d_val / 500) * 100);
									$ekata->$d_key->value->status = $this->ekata->get_status(array(
										'value' => $d_val,
										'type' => $d_key
									));
								}
								else
								{
									if(is_object($d_val))
									{
										foreach($d_val as $dd_key=>$dd_val)
										{

											$dd_name = ucfirst(str_replace(array('_','.'), ' ', $dd_key));
											$ekata->$d_key->value->$dd_key = new stdClass;
											$ekata->$d_key->value->$dd_key->name = $dd_name;

											if(is_object($dd_val))
											{
												foreach($dd_val as $dn=>$dv)
												{
													if($dn == 'name')
													{
														$ekata->$d_key->value->$dd_key->value->name = $dv;
													}
													else
													{
														$ekata->$d_key->value->$dd_key->value->value->$dn->name = ucfirst(str_replace(array('_','.'), ' ', $dn));
														$ekata->$d_key->value->$dd_key->value->value->$dn->value =$dv;
													}
												}
											}
											else
											{
												$ekata->$d_key->value->$dd_key->value = $dd_val;
											}
										}
									}
									else
									{
										$ekata->$d_key->value = $d_val;
									}
									
								}
							}
							if(!empty($ekata))
							{
								$ekata_logs[$k]->fdata = $ekata;
							}
							
						}
					}
				}
				// print_r($ekata_logs); exit;
				$this->design->assign('ekata_logs', $ekata_logs);
			}


			// $covid_form_logs = $this->logs->get_logs(array(
			// 	'user_id' => $user->id,
			// 	'type' => 8 // 8 - Covid Form
			// ));
			$this->design->assign('covid_form_logs', $covid_form_logs);
			$this->design->assign('remote_move_in_logs', $remote_move_in_logs);

			// window guards logs
			$this->design->assign('window_guards_logs', $window_guards_logs);


		}

		
		// if(!empty($user->image))
		// {
		// 	$img_url = $this->config->root_dir.$this->config->users_images_dir.$user->image;
		// 	$color_img = $this->image->Get_Color($img_url);
		// }

		$this->design->assign('order_types', $this->orders->types);


		$this->design->assign('user', $user);

		
 	  	return $this->design->fetch('user.tpl');
	}
	
}

