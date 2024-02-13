<?PHP

require_once('View.php');

class NotificationView extends View
{
	function fetch()
	{
		if(empty($this->user))
		{
			header('Location: '.$this->config->root_url.'/user/login');
			exit();
		}
		
		// Set default values
		$notification = new stdClass;
		if($this->request->method('post'))
		{	
			if($this->request->post('date'))
			{
				$post_type = $this->request->post('type');
				$house_id = $this->request->post('house_id');

				if($post_type == 9)
				{
					$notification->type = 9;
					$notification->subtype = 1;
				}
				elseif($post_type == 10)
				{
					$notification->type = 10;
					$notification->subtype = 2;
					$notification->object_id = $house_id;
				}
				elseif($post_type == 11)
				{
					$notification->type = 9;
					$notification->subtype = 2;
					$notification->object_id = $house_id;
				}
				elseif($post_type == 12)
				{
					$notification->type = 10;
					$notification->subtype = 1;
				}

	    		$notification->date = date('Y-m-d', strtotime($this->request->post('date')));

	    		if($this->request->post('time_from') != 0)
	    			$notification->time_from = $this->request->post('time_from');
	    		if($this->request->post('time_to') != 0)
		    		$notification->time_to = $this->request->post('time_to');

	    		if(empty($notification->object_id))
	    			$notification->object_id = $this->request->post('object_id');
	    		$notification->text = $this->request->post('text');

	    		$notification->creator = $this->user->name;
	    		$notification->id = $this->notifications->add_notification($notification);

				$this->design->assign('message_success', 'added');

	    		// Выхватить людей по апартеметну или дому с активными букингами и всем им отправить письмо

	    		if($notification->subtype == 1 && !empty($notification->object_id))
	    		{
	    			$bookings = $this->beds->get_bookings(array(
							'apartment_id'=>$notification->object_id, 
							'now'=>1, 
							'not_canceled' => 1,
							'select_users' => true
						));
	    		}
	    		elseif($notification->subtype == 2 && !empty($notification->object_id))
	    		{
					$bookings = $this->beds->get_bookings(array(
							'house_id'=>$notification->object_id, 
							'now'=>1, 
							'not_canceled' => 1,
							'select_users' => true
						));
	    		}
	    		$users = [];
				$mailfrom = $this->settings->notify_from_email;
	    		if(!empty($bookings))
	    		{
	    			foreach ($bookings as $b) 
	    			{
	    				if($b->users)
	    				{
	    					foreach ($b->users as $bu) 
	    					{
	    						$users[$bu->id] = $bu;
	    					}
	    				}
	    			}
	    			if(!empty($users))
	    			{
	    				foreach ($users as $u) 
	    				{
                            if (!in_array($post_type, [10, 11]) || $u->block_notifies != 1) {
                                $this->design->assign('user', $u);
                                $this->design->assign('notification', $notification);
                                $this->design->assign('house', $house);
                                $email_template = $this->design->fetch($this->config->root_dir.'design/outpost/html/email/email_notification.tpl');
                                $subject = $this->design->get_var('subject');
                                $this->notify->email($u->email, $subject, $email_template, $mailfrom);
                                // logg('Sent notify #'.$notification->id.' to: '.$u->name);
                            }

	    				}
	    			}
	    		}
			}
			elseif($this->request->post('check'))
			{

			}
			else
				$this->design->assign('message_error', 'Chose the date');				
    		

	    	$id = array();
			// Del notification
	    	if($this->request->post('check'))
	    	{
	    		$id = $this->request->post('check');
	    		if(!empty($id))
	    			$this->notifications->delete_notification($id);
	    	}
		}

		// Houses
		if($this->user->type == 2)
		{
			$hl_houses = $this->users->get_houseleaders_houses(array('user_id'=>$this->user->id));
			foreach ($hl_houses as $hl_h) 
			{
				$hl_h_ids[] = $hl_h->house_id;
			}

			$h_houses = $this->pages->get_pages(array('id'=>$hl_h_ids, 'menu_id'=>5, 'visible'=>1, 'not_tree'=>1));
		}
		else
			$houses = $this->pages->get_pages(array('menu_id'=>5, 'visible'=>1, 'not_tree'=>1));

		$houses_ids = [];
		foreach ($houses as $h) 
		{
			$houses_ids[] = $h->id;
		}
		if(!empty($houses))
			$houses= $this->categories_tree->get_categories_tree('houses', $houses);

		$apts_ = $this->beds->get_apartments(array('house_id'=>$houses_ids));
		if(!empty($apts_))
			foreach ($apts_ as $a) 
			{
				$houses_apts[$a->house_id][] = $a;
			}
			

		$this->design->assign('notifications', $notifications);
		if($this->user->type == 2)
			$this->design->assign('h_houses', $h_houses);
		else
			$this->design->assign('houses', $houses);
		$this->design->assign('apts', $houses_apts);
		

		$tmp = 'notifications/notification.tpl';

		return $this->design->fetch($tmp);
	}
	// public function logg($str)
	// {
	// 	file_put_contents('email_log.txt', file_get_contents('email_log.txt')."\r\n".date("m.d.Y H:i:s").' '.$_SERVER['REMOTE_ADDR'].' '.$str);
	// }
}
