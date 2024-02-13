<?PHP

require_once('View.php');

class MoveInFormView extends View
{
	function fetch()
	{
		$url = $this->request->get('url', 'string');
		$notify_code = $this->request->get('user_code', 'string'); // Теперь это урл нотификейшина, а не юзер код
		$type_move = $this->request->get('type', 'integer');

		// выхватить по нотификейшн урл все, если старые и там юзеркод, то взять последний нофикейшн этого юзера и выхватить по нему

		$page = $this->pages->get_page($url);

		if(!empty($notify_code))
		{

			$notify = $this->notifications->get_notification($notify_code);
			if(empty($notify))
			{
				$guest = current($this->users->get_users(array('user_code'=>$notify_code)));
				if(!empty($guest))
					$notify = current($this->notifications->get_notifications(array('object_id'=>$guest->id, 'type'=>$type_move)));

			}
			
			if(!empty($notify))
			{
				$move = $this->houseleader->get_moveins(array('notify_id'=>$notify->id, 'limit'=>1));

				$guest = $this->users->get_user(intval($move->user_id));



				$guest->booking = $this->beds->get_bookings(array(
					'id' => $move->booking_id, 
					'limit' => 1
				));
				if($guest->booking->type == 1)
				{
					$guest->bed = $this->beds->get_beds(array(
						'id' => $guest->booking->object_id, 
						'limit' => 1
					));
					if(!empty($guest->bed))
						$guest->room = $this->beds->get_rooms(array(
							'id' => $guest->bed->room_id, 
							'limit' => 1
						));
					if(!empty($guest->room))
						$guest->apt = $this->beds->get_apartments(array(
							'id' => $guest->room->apartment_id, 
							'limit' => 1
						));
				}
				else
				{
					$guest->apt = $this->beds->get_apartments(array(
						'id' => $guest->booking->object_id, 
						'limit' => 1
					));

					$guest->room = $this->beds->get_rooms(array(
						'apartment_id' => $guest->apt->id,
						'limit' => 1
					));
					
					$guest->bed = $this->beds->get_beds(array(
						'room_id' => $guest->room->id,
						'limit' => 1
					));
				}
			}

		}
		else
		{
			$this->design->assign('error', 'no_notify');
		}

		// Отображать скрытые страницы только админу
		if(empty($page) || (!$page->visible && empty($_SESSION['admin'])))
			return false;
			
		// House Leader
		if($page->menu_id == 12)
		{
			if(empty($this->user))
			{
				header('Location: '.$this->config->root_url.'/user/login?return='.$url.'/'.$notify_code);
				exit();
			}
			
			if(!empty($this->user->house_id))
			{
				$user_house = $this->pages->get_page((int)$this->user->house_id);
				if(!empty($user_house))
					$this->design->assign('user_house', $user_house);
			}

			if(!empty($_COOKIE['mmr']))
			{
				$mmr = array();
				foreach(explode('__', $_COOKIE['mmr']) as $vv_)
				{
					$vv = explode('--', $vv_);
					$mmr[$vv[0]] = $vv[1];
				}
				$this->design->assign('mmr', $mmr);
			}

		}
		
		if(!empty($page->blocks))
		{
			$page->blocks = unserialize($page->blocks);
		}


		if($this->request->method('post'))
		{
			// if($this->request->post('user_id'))
			// 	$move->user_id = $this->request->post('user_id');
			// elseif(!empty($guest))
			// 	$move_in->user_id = $guest->id;
			// $move_in->hl_id  = $this->user->id;
			// $move_in->type 	 = $type_move;
			// if(!empty($type_move))
			// 	$move_in->type = $type_move;


			if(empty($guest))
				$guest = $this->users->get_user(intval($move->user_id));


			$guest->files = (array) unserialize($guest->files);

			$data = array();
			if($this->request->post('name')){

				foreach($this->request->post('name') as $n=>$v)
				{
					if(!isset($data[$n]))
					{
						$data[$n] = new stdClass;
					}
					$data[$n]->name = $v;
				}
			}
			if($this->request->post('value')){
				foreach($this->request->post('value') as $n=>$v)
				{
					if(!isset($data[$n]))
					{
						$data[$n] = new stdClass;
					}
					$data[$n]->value = $v;
				}
			}


			$type = $this->request->post('type');
			$mail_to = $this->request->post('mail_to');

			if(!empty($data))
			{
				$files_arr = $this->request->files('files');
				if(!empty($files_arr))
				{	
					$guest_id = $guest->id;

					foreach ($files_arr['name'] as $k=>$files)
					{
						for($i=0; $i<count($files); $i++)
						{
							if(!empty($files_arr['name'][$k][$i]))
							{
								$file_name = md5(uniqid($this->config->salt, true));
								$ext = strtolower(pathinfo($files_arr['name'][$k][$i], PATHINFO_EXTENSION));
								if(!file_exists($this->config->root_dir.'/'.$this->config->users_files_dir.$guest_id.'/'))
									mkdir($this->config->root_dir.'/'.$this->config->users_files_dir.$guest_id.'/', 0755);

								move_uploaded_file($files_arr['tmp_name'][$k][$i], $this->config->root_dir.$this->config->users_files_dir.$guest_id.'/'.$file_name.'.'.$ext);

								// Resize image
						 		$imagesize = getimagesize($this->config->root_dir.$this->config->users_files_dir.$guest_id.'/'.$file_name.'.'.$ext);
						 		if($imagesize[0] > 1000)
						 		{
						 			$this->simpleimage->load($this->config->root_dir.$this->config->users_files_dir.$guest_id.'/'.$file_name.'.'.$ext);
									$this->simpleimage->resizeToWidth(1000);
									$this->simpleimage->save($this->config->root_dir.$this->config->users_files_dir.$guest_id.'/'.$file_name.'.'.$ext);
						 		}
								$data[$k]->images[] = $this->config->root_dir.$this->config->users_files_dir.$guest_id.'/'.$file_name.'.'.$ext;

								if($type_move == 3)
									$guest->files['from_move_out'][] = $file_name.'.'.$ext;
								else
									$guest->files['from_move_in'][] = $file_name.'.'.$ext;
							}
						}
					}

					$guest->files = serialize($guest->files);
					$this->users->update_user($guest->id, array('files'=>$guest->files));
				}

				foreach($data as $k=>$d)
				{
					if(empty($d->value) && empty($d->images))
						unset($data[$k]);
				}
				$this->design->assign('data', $data);

				$upd_move = new stdClass();
				$upd_move->hl_id  = $this->user->id;
				$upd_move->inputs = serialize($data);
				$upd_move->date = date("Y-m-d H:i:s");
				$upd_move->status = 1;

				// Добавить Кост с нужной ценой по выбраному варианту постели ( подумать как выбирать постель правильно )

				$this->costs->add_cost(array(
                    'parent_id' => $move->id,
                    'house_id' => $guest->booking->house_id,
                    'type' => 1, // move 
                    'subtype' => 1, // выбраный вариант постели 
                    'price' => $this->costs->cost_types[1]['subtypes'][1]['price'],
                    'sender_type' => 3,
                    'sender' => $this->user->name
                ));


				$this->houseleader->update_movein($move->id, $upd_move);

				if($type_move == 1 || $type_move == 2)
				{
					$this->beds->update_booking(intval($move->booking_id), ['moved'=>3]);
					// $this->users->update_user(intval($guest->id), array('moved_in'=>3));
				}
				elseif($type_move == 3)
				{
					$this->beds->update_booking(intval($move->booking_id), ['moved'=>4]);
					// $this->users->update_user(intval($guest->id), array('moved_in'=>4));
				}

				$this->design->assign('message_success', 'added');

				// TO
				$mailto = $this->settings->comment_email;
				// FROM
				$mailfrom = $this->settings->notify_from_email;
				// HouseLeader Checklist
				if($type == 'hl_checklist')
				{
					$this->design->assign('subject_', $data[1]->value);
					$mailto = $this->settings->checklists_email;
					$data_arr['content'] = 'Thank You!';
				}

				if(!empty($mail_to))
					$mailto = $mail_to;

				
				$email_template = $this->design->fetch($this->config->root_dir.'backend/design/html/email_forms_admin.tpl');
				$subject = $this->design->get_var('subject');

				// если чекнут чекбокс с рум чендж то в тайтл дописать Атеншн
				if($data['c_17']->value == 'Checked')
					$subject = 'Attention! Room changed. '.$subject;

				$this->notify->email($mailto, $subject, $email_template, $mailfrom);
			}

			
		}
		$this->design->assign('move', $move);

		$this->design->assign('page', $page);
		if(!empty($guest))
			$this->design->assign('guest', $guest);
		$this->design->assign('meta_title', $page->meta_title);
		$this->design->assign('meta_keywords', $page->meta_keywords);
		$this->design->assign('meta_description', $page->meta_description);



		$tpl = 'houseleader_page.tpl';

		if($page->id == 275)
			$tpl = 'page_checklist.tpl';


		return $this->design->fetch($tpl);
	}
}