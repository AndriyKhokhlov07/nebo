<?php


require_once('View.php');

class CleaningView extends View
{
	public function fetch()
	{
		if(empty($this->user))
		{
			header('Location: '.$this->config->root_url.'/user/login');
			exit();
		}

		
		$cleaning = new stdClass;
		$order = new stdClass;
		if($this->request->method('post'))
		{
			$order->user_id = $this->user->id;
    		// $order->email   = $this->user->email;
    		$order->type    = 3; // Cleaning
    		$order->ip 		= $_SERVER['REMOTE_ADDR'];
    		// $order->name 	= $this->user->name;
    		// if(!$this->request->post('sheet_towel') && !$this->request->post('sheet_towel_plus'))
    		// {
    		// 	$order->paid 	= 1;
    		// 	$order->status 	= 2; // Paid
    		// }

    		if(!empty($this->user->house_id))
	    	{
				$house = $this->pages->get_page((int)$this->user->house_id);
				if(!empty($house))
				{
					$order->address = $house->header;
				}
	    	}

			$order->comment = $this->request->post('comment');
			$cleaning->desired_date = date('Y-m-d', strtotime($this->request->post('desired_date')));



			


			// Добавляем заказ в базу
	    	$order_id = $this->orders->add_order($order);
	    	$_SESSION['order_id'] = $order_id;

	    	$cleaning_price = $this->request->post('price_cleaning');
	    	$sheet_towel_price = $this->request->post('sheet_towel');
	    	$sheet_towel_plus_price = $this->request->post('sheet_towel_plus');

	    	$total_price = $cleaning_price + $sheet_towel_price + $sheet_towel_plus_price;

			$cleaning->order_id = $order_id;
			$cleaning->house_id = $this->user->house_id;

			$this->user->booking = $this->beds->get_bookings([
				'id' => $this->user->active_booking_id, 
				'not_canceled' => 1,
				//'limit' => 1,
				'sp_group' => true
			]);
			if(!empty($this->user->booking))
			{
				$this->user->booking = current($this->user->booking);
				if(!empty($this->user->booking->sp_bookings) && count($this->user->booking->sp_bookings) > 1)
				{
					foreach($this->user->booking->sp_bookings as $b)
					{
						if(!empty($b->active))
						{
							$this->user->booking->object_id = $b->object_id;
						}
					}
				}
			}

			if(!empty($this->user->booking))
			{
				if($this->user->booking->type == 1)
				{
					$this->user->bed = $this->beds->get_beds(array(
						'id' => $this->user->booking->object_id, 
						'limit' => 1
					));
					if(!empty($this->user->bed))
						$this->user->room = $this->beds->get_rooms(array(
							'id' => $this->user->bed->room_id, 
							'limit' => 1
						));
					if(!empty($this->user->room))
						$this->user->apt = $this->beds->get_apartments(array(
							'id' => $this->user->room->apartment_id, 
							'limit' => 1
						));
				}
				else
				{
					$this->user->apt = $this->beds->get_apartments(array(
						'id' => $this->user->booking->object_id, 
						'limit' => 1
					));

					$this->user->room = $this->beds->get_rooms(array(
						'apartment_id' => $this->user->apt->id,
						'limit' => 1
					));
					
					$this->user->bed = $this->beds->get_beds(array(
						'room_id' => $this->user->room->id,
						'limit' => 1
					));
				}
				// $user_bed = $this->beds->get_beds(array('id'=>$this->user->booking->object_id, 'limit'=>1));
			}
			if(!empty($this->user->bed))
				$cleaning->bed = $this->user->bed->name;
			$this->cleaning->add_cleaning($cleaning);

			if (!empty($cleaning_price))
	    		$this->orders->add_purchase(array('order_id'=>$order_id, 'variant_id'=>0, 'product_name'=>'Cleaning', 'price'=>$cleaning_price, 1));
	    	if (!empty($sheet_towel_price))
	    		$this->orders->add_purchase(array('order_id'=>$order_id, 'variant_id'=>0, 'product_name'=>'Bed Sheet Set and Bath Towel', 'price'=>$sheet_towel_price, 1));
	    	if (!empty($sheet_towel_plus_price))
	    		$this->orders->add_purchase(array('order_id'=>$order_id, 'variant_id'=>0, 'product_name'=>'Bed Sheet Set, Bath Towel, Comforter, Pillows, Mattress Protector', 'price'=>$sheet_towel_plus_price, 1));

	    	$order = $this->orders->get_order($order_id);

	    	// Отправляем письмо пользователю
			$this->notify->email_order_user($order->id);

			$house_cleaners = $this->users->get_users(array('hc_house_id'=>$this->user->house_id));
			
	    	// Send Email
			if(!empty($house_cleaners))
			{
				$email_template = '<h2 style="font-family:arial;">Request for cleaning: '.$house->name.'</h2><p style="font-family:arial;">Desired date: '.$cleaning->desired_date.'</p><p style="font-family:arial;">Check it in <a href="https://ne-bo.com/user/login">backend</a></p>';
				$subject = 'New cleaning: '.$house->name;

				foreach ($house_cleaners as $cleaner) {
					if($cleaner->type = 2 || $cleaner->type = 3)
					{
						$mail_to = $cleaner->email;
						$this->notify->email($mail_to, $subject, $email_template, $this->settings->notify_from_email);
					}
				}
			}

			// Перенаправляем на страницу заказа
			header('Location: '.$this->config->root_url.'/order/'.$order->url);
		}	

		$filter = array();
		if(!empty($this->user->house_id))
		{
			$filter['house_id'] = $this->user->house_id;
			$ca_cleanings_ = $this->cleaning->get_cleanings($filter);
			$filter['user_id'] = $this->user->id;
		}

		$cleaning_days_ = $this->cleaning->get_cleaning_days($filter['house_id']);
		foreach ($cleaning_days_ as $cd) {
			if($cd->type == 0)
				$cleaning_days[] = $cd;
		}

		foreach ($ca_cleanings_ as $cac) 
		{
			if($cac->status==0 && $cac->bed=='Common Area' && $cac->type==2)
				$ca_cleanings[] = $cac;
		}


		$cleanings = $this->cleaning->get_cleanings($filter);
		$purchases = array();
		$order_ids = array();
		if(!empty($cleanings))
		{
			foreach ($cleanings as $cl) {
				$order_ids[] = $cl->order_id;
				$cl->images = unserialize($cl->images);
			}
			$purchases_ = $this->orders->get_purchases(array('id'=>$order_ids));
			if($purchases_)
			foreach ($purchases_ as $pur) {
				$purchases[$pur->order_id][] = $pur;
			}
		}
		

		if(empty($this->user->house_id))
		{
			$rooms_ = $this->pages->get_pages(array('menu_id'=>5, 'visible'=>1));
			if(!empty($rooms_))
			{
				$rooms = array();
				foreach($rooms_ as $r)
					$rooms[$r->id] = $r;
				unset($rooms_);

				$this->design->assign('rooms', $rooms);
			}

		}

		$contract = current($this->contracts->get_contracts(array('user_id'=>$this->user->id, 'status'=>array(1, 2))));


		$houseleaders_houses = $this->users->get_housecleaners_houses(array('house_id'=>$this->user->house_id));

		$cleaners_ = array();
		$cleaners_ = $this->users->get_users(array('in_type'=>array('2', '3'), 'hc_house_id'=>$this->user->house_id));

		if(!empty($houseleaders_houses)) 
		{
			$users_ids = array();
			$cleaners = array();
			
			foreach ($cleaners_ as $c) {
				$cleaners[$c->id] = $c;
				$users_ids[] = $c->id;
			}

			foreach ($houseleaders_houses as $k=>$hl) 
			{
				if(in_array($hl->user_id, $users_ids))
				{
					$houseleaders_houses_[] = $hl;
				}
			}
		}


		$this->design->assign('contract', $contract);

		if(empty($houseleaders_houses_))
			$houseleaders_houses_ = array(0);
		$this->design->assign('houseleaders_houses', $houseleaders_houses_);
		$this->design->assign('cleaners', $cleaners);

		$this->design->assign('cleaning_days', $cleaning_days);

		// $this->design->assign('ca_cleanings', $ca_cleanings);
		$this->design->assign('cleanings', $cleanings);
		$this->design->assign('purchases', $purchases);
		return $this->design->fetch('cleaning/cleaning.tpl');
	}
}
