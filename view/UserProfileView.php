<?PHP
require_once('View.php');

class UserProfileView extends View
{
	function fetch()
	{
		if(empty($this->user))
		{
			header('Location: '.$this->config->root_url.'/user/login');
			exit();
		}


		$contract_url = $this->request->get('h', 'string');


		$guest = new stdClass;

		if(!empty($this->user))
		{
			$guest = $this->user;

			// House Info
			if(!empty($guest->house_id))
			{
				$house = $this->pages->get_page((int)$guest->house_id);
				if(!empty($house))
				{
					if(!empty($house->blocks2))
						$house->blocks2 = unserialize($house->blocks2);

					$guest->house = $house;

					unset($house);
				}
			}

			$guest->booking = $this->beds->get_bookings(array(
				'id' => $this->user->active_booking_id, 
				'not_canceled' => 1,
				'limit' => 1
			));

			
			if(!empty($guest->booking) && $guest->booking->type == 1)
			{
				$guest->bed = $this->beds->get_beds(array('id'=>$guest->booking->object_id, 'limit'=>1));
			    $guest->room = $this->beds->get_rooms(array('id'=>$guest->bed->room_id, 'limit'=>1));
			    $guest->apt = $this->beds->get_apartments(array('id'=>$guest->booking->apartment_id, 'limit'=>1));
			}
			elseif(!empty($guest->booking))
			{
			    $guest->apt = $this->beds->get_apartments(array('id'=>$guest->booking->apartment_id, 'limit'=>1));
			}


			$orders = array();
			$invoices = array();

			// type:
			// 1 - invoices
			// 2 - orders


			// status:
			// 0 - new
			// 1 - pending
			// 2 - paid
			// 4 - failed
			$orders_ = $this->orders->get_orders(array('user_id'=>$this->user->id, 'status'=>array(0,1,2,4), 'past'=>1));

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

				if(!empty($invoices))
				{
					$purchases = $this->orders->get_purchases(array('order_id'=>array_keys($invoices)));
					if(!empty($purchases))
					{
						foreach($purchases as $purchase)
						{
							if(isset($invoices[$purchase->order_id]))
								$invoices[$purchase->order_id]->purchases[$purchase->id] = $purchase;
							elseif(isset($orders[$purchase->order_id]))
								$orders[$purchase->order_id]->purchases[$purchase->id] = $purchase;
						}
					}
				}
			}


			$this->design->assign('orders', $orders);
			$this->design->assign('invoices', $invoices);

			if(!empty($this->user->id))
			{
				$contracts = $this->contracts->get_contracts(array('user_id'=>$this->user->id, 'status'=>array('1')));

				if(!empty($this->user->checker_options))
				{
					$this->user->checker_options = unserialize($this->user->checker_options);
					if(!empty($report))
						$report = current($this->user->checker_options['reports']);
				}
				if(!empty($this->user->files))
				{
					$this->user->files = unserialize($this->user->files);
				}

				foreach ($contracts as $contract) 
				{
					$contract_order = "";
					$contract_order = current($this->orders->get_orders(array(
						'contract_id' => $contract->id, 
						'status' => array(2),
						'limit'=> 1
					)));	


                    if(!is_array($this->user->files)){
                        $this->user->files = (array)$this->user->files;
                    }
					if(
                        !empty($contract_order)
                        && (
                            (
                                (!empty($this->user->checkr_candidate_id) && $report['status']=='clear')
                                || ($this->user->us_citizen==2 && $this->user->files['visa'] && $this->user->files['selfie'])
                            ) || !is_null($this->user->checkr_candidate_id) || !empty($this->user->transunion_id)))
					{
						if($contract_order->paid == 1)
							$contract->show = 1;		
					}
					
					if($contract->date_created <= "2020-02-10 00:00:00")
						$contract->show = 1;
				}

				if(!empty($contract_url))
				{
					if(!empty($contracts))
					{
						foreach ($contracts as $contract) 
						{
							if($contract->url == $contract_url && $contract->show == 1)
							{
								$this->logs->add_log(array(
			                        'parent_id' => $contract->id, 
			                        'type' => 4, 
			                        'subtype' => 7, // contract downloaded
			                        'user_id' => $this->user->id, 
			                        'sender_type' => 3
			                    ));
								header('Location: '.$this->config->root_url.'/files/contracts/'.$contract->url.'/contract.pdf');
								exit();
							}
						}
					}
					header('Location: '.$this->config->root_url.'/user/profile/');
					exit();
				}

				$this->design->assign('contracts', $contracts);
			}


		}



		if(!empty($this->user->email))
		{
			//$billing = $this->tokeet->get_billing(array('email'=>$this->user->email));
			//print_r($billing); exit;

			if(!empty($this->user->main_info))
				$guest->main_info = $this->user->main_info;
			// tokeet off
			// else
			// 	$guest->main_info = $this->tokeet->get_guest(array('email'=>$this->user->email));


			

			if(!empty($guest->main_info))
			{
				$guest->booking_invoices = array();

				if(!empty($guest->main_info['bookings']))
				{
					foreach($guest->main_info['bookings'] as $booking_key)
					{
						// tokeet off
						// $booking = $this->tokeet->get_booking(array('key'=>$booking_key));

						// $rental = $this->tokeet->get_rental(array('key'=>$booking['rental_id']));
						if(!empty($booking['cost']))
							$booking['cost'] = json_decode($booking['cost']);
						// if(!empty($rental))
						// 		$booking['rental'] = $rental;

						$guest->bookings[] = $booking;

						if(!empty($booking['invoices']))
						{
							foreach($booking['invoices'] as $bi)
								$guest->booking_invoices[] = $bi;
						}
					}
				}
				// tokeet off
				// $guest->tokeet_account = $this->tokeet->account;
			}
		}





		// $rental = $this->tokeet->get_rental(array('key'=>'1297f469-9fd7-4050-883d-0a6e366942fa'));
		// print_r($rental); exit;
		// print_r($guest); exit;

		// if(!empty($guest['bookings']))
		// {
		//  	$booking_key = current($guest['bookings']);
		//  	$booking = $backend->tokeet->get_booking(array('key'=>$booking_key));
		//  	print_r($booking);
		// }
		//if(empty($guest))
		//	return false;	
		$this->design->assign('guest', $guest);	

	
		if($this->request->method('post') && $this->request->post('password'))
		{
			//$name			= $this->request->post('name');
			//$email			= $this->request->post('email');
			$password		= $this->request->post('password');
			
			//$this->design->assign('name', $name);
			//$this->design->assign('email', $email);
			
			// $this->db->query('SELECT count(*) as count FROM __users WHERE email=? AND id!=?', $email, $this->user->id);
			// $user_exists = $this->db->result('count');

			// if($user_exists)
			// 	$this->design->assign('error', 'user_exists');
			// elseif(empty($name))
			// 	$this->design->assign('error', 'empty_name');
			// elseif(empty($email))
			// 	$this->design->assign('error', 'empty_email');
			// elseif($user_id = $this->users->update_user($this->user->id, array('name'=>$name, 'email'=>$email)))
			// {
			// 	$this->user = $this->users->get_user(intval($user_id));
			// 	$this->design->assign('name', $this->user->name);
			// 	$this->design->assign('user', $this->user);
			// 	$this->design->assign('email', $this->user->email);				
			// }
			// else
			// 	$this->design->assign('error', 'unknown error');
			
			if(!empty($password))
			{
				$this->users->update_user($this->user->id, array('password'=>$password));
			}
	
		}
		else
		{
			// Передаем в шаблон
			$this->design->assign('name', $this->user->name);
			$this->design->assign('email', $this->user->email);		
		}
	
		// $orders = $this->orders->get_orders(array('user_id'=>$this->user->id));
		// $this->design->assign('orders', $orders);
		if(!empty($guest->main_info['name']))
			$this->design->assign('meta_title', $guest->main_info['name']);
		else
			$this->design->assign('meta_title', $this->user->name);
		return $this->design->fetch('user_profile.tpl');
	}
}
