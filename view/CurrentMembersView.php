<?PHP


 
require_once('View.php');

class CurrentMembersView extends View
{
	function fetch()
	{
		if(empty($this->user))
		{
			header("HTTP/1.1 301 Moved Permanently"); 
			header('Location: '.$this->config->root_url.'/user/login');
			exit();
		}

		$guest = new stdClass;

		if(!empty($this->user->email))
		{
				$guest = $this->user;

			// tokeet off
			// else
			// 	$guest->main_info = $this->tokeet->get_guest(array('email'=>$this->user->email));

			/*if(!empty($guest->main_info))
			{
				$guest->booking_invoices = array();
				$guest->booking_new_invoices = array();

				if(!empty($guest->main_info['bookings']))
				{
					foreach($guest->main_info['bookings'] as $booking_key)
					{
						$booking = $this->tokeet->get_booking(array('key'=>$booking_key));
						if(!empty($booking['cost']))
							$booking['cost'] = json_decode($booking['cost']);

						$guest->bookings[] = $booking;

						if(!empty($booking['invoices']))
						{
							foreach($booking['invoices'] as $bi)
							{
								$guest->booking_invoices[] = $bi;
								if($bi['status'] == 0 || $bi['status'] == 1)
									$guest->booking_new_invoices[] = $bi;
							}
						}
					}
				}
				$guest->tokeet_account = $this->tokeet->account;
			}*/


			//$orders = array();
			$invoices = array();
			$cleanings = array();
			// type 1 - invoices
			// status:
			// 0 - new
			// 1 - pending
			// 4 - failed
			$orders_ = $this->orders->get_orders(array('user_id'=>$this->user->id, 'status'=>array(0,1,4), 'sort'=>'date', 'not_label'=>8));

			if(!empty($orders_))
			{
				foreach($orders_ as $o)
				{
					if($o->type == 2) 
						$orders[$o->id] = $o; // Orders
					elseif($o->type == 3) 
						$cleanings[$o->id] = $o; // Cleanings
					else 
						$invoices[$o->id] = $o; // All Invoices
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
							{
								$invoices[$purchase->order_id]->purchases[$purchase->id] = $purchase;
							}
						}
					}
				}
				if(!empty($cleanings))
				{
					$purchases = $this->orders->get_purchases(array('order_id'=>array_keys($cleanings)));
					if(!empty($purchases))
					{
						foreach($purchases as $p)
						{
							if(isset($cleanings[$p->order_id]))
							{
								$cleanings[$p->order_id]->purchases[$p->id] = $p;
							}
						}
					}
				}

				// Все способы оплаты
			 	/*
			 	$payment_methods = array();
				$payment_methods_ = $this->payment->get_payment_methods();
				if(!empty($payment_methods_))
				{
					foreach($payment_methods_ as $pm)
						$payment_methods[$pm->id] = $pm;
					unset($payment_methods_);
				}
				$this->design->assign('payment_methods', $payment_methods);
				*/
			}


			//$this->design->assign('orders', $orders);
			$this->design->assign('cleanings', $cleanings);
			$this->design->assign('invoices', $invoices);

			// if(!empty($user->id))
			// {
			// 	$contracts = $this->contracts->get_contracts(array('user_id'=>$user->id));
			// 	$this->design->assign('contracts', $contracts);
			// }


			$notifications = array();
			$guest->booking = $this->beds->get_bookings(array(
					'id' => $this->user->active_booking_id, 
					'not_canceled' => 1,
					'limit' => 1
				));

			$date_month_ago = date_create(date("Y-m-d"));
			date_sub($date_month_ago, date_interval_create_from_date_string('1 month'));
			$date_now = date_create(date("Y-m-d"));
			
			if(!empty($guest->booking) || $guest->type != 1)
			{
				if($guest->type == 1)
				{
					$guest->booking->users = $this->users->get_users(array(
								'booking_id' => $guest->booking->id,
							));
					$guest->booking->users = $this->request->array_to_key($guest->booking->users, 'id');
					$guest->house = $this->pages->get_page(intval($guest->booking->house_id));

					// Bed booking
					if($guest->booking->type == 1)
					{
						$guest->bed = $this->beds->get_beds(array(
							'id' => $guest->booking->object_id,
							'limit' => 1
						));
					}
					elseif($guest->booking->type == 2)
					{
						$guest->apt = $this->beds->get_apartments(array(
							'id' => $guest->booking->object_id,
							'limit' => 1
						));
					}
						
					if(!empty($guest->bed))
						$guest->room = $this->beds->get_rooms(array(
							'id' => $guest->bed->room_id,
							'limit' => 1
						));
				}

				if((!empty($guest->room) && $guest->room->apartment_id !=0) || !empty($guest->apt) || $guest->type != 1)
				{
					if(empty($guest->apt) && !empty($guest->room))
					{
						$guest->apt = $this->beds->get_apartments(array(
							'id' => $guest->room->apartment_id,
							'limit' => 1
						));
					}
					
					// $rooms = $this->beds->get_rooms(array('apartment_id'=>$guest->apt->id));
					// $rooms = $this->request->array_to_key($rooms, 'id');
					// if(empty($guest->apt))
					// {
					// 	$beds = $this->beds->get_beds(array('house_id'=>$guest->apt->id));
					// 	$beds = $this->request->array_to_key($beds, 'id');
					// }
					// print_r($guest); exit;

					if($guest->booking->type == 1 && !empty($guest->apt))
					{
						$bjs = $this->beds->get_bookings(array(
							'apartment_id'=>$guest->apt->id, 
							'type' => 1, 
							'now'=>1, 
							'not_canceled' => 1,
							'select_users' => true
						));
					}
					else
					{
						$bjs[] = $guest->booking;
					}

					$bjs = $this->request->array_to_key($bjs, 'id');

					if($this->user->type == 2)
					{
						$hl_houses = $this->users->get_houseleaders_houses(array('user_id'=>$this->user->id));
						foreach ($hl_houses as $hl_h) 
						{
							$hl_h_ids[] = $hl_h->house_id;
						}
						$bjs_hl = $this->beds->get_bookings(array(
							'house_id'=>$hl_h_ids, 
							// 'now'=>1, 
							'is_due' => 1,
							'select_users' => true
						));
						foreach ($bjs_hl as $bj) 
						{
							$bjs[$bj->id] = $bj;
						}

					}
					

					if(!empty($bjs))
					{
						$users = array();



						foreach($bjs as $b) 
						{
							$house_ids[$b->house_id] = $b->house_id;
							if($this->user->type != 1)
							{
								$apts_ids[] = $b->house_id;
							}
						}

						$hl_apts = $this->beds->get_apartments(array(
							'house_id' => $house_ids
						));

						// $users_ids[$this->user->id] = $this->user->id;
						// if(!empty($users_ids))
						// {
						// 	$users_ = $this->users->get_users(array('id'=>$users_ids));
						// }
						$houses_ = $this->pages->get_pages(array('id'=>$house_ids));
						foreach ($houses_ as $h) 
						{
							$houses[$h->id] = $h;
						}

						foreach ($bjs as $b) 
						{
							if(!empty($b->users))
							{
								foreach ($b->users as $u) 
								{
									$u->house = $houses[$b->house_id];
									$users[$u->id] = $u;
								}
							}
						}
						$this->design->assign('users', $users);

						$notify = array();

						$apts_ids = array();

						if(!empty($guest->apt))
							$apts_ids[] = $guest->apt->id;
						if(!empty($guest->booking))
							$apts_ids[] = $guest->booking->house_id;

						if($this->user->type == 2)
						{
							foreach ($hl_apts as $a) 
							{
								$apts_ids[] = $a->id;
							}
						}
						$apts_ids_keys = array_keys($apts_ids);


						// выводить хауслидеру правильный букинг в мувинах !!

						$notifications_ = $this->notifications->get_notifications(array('type'=>array('9', '10'), 'object_id'=>$apts_ids));

						foreach ($notifications_ as $n) 
						{
							if(($n->type == 10 && in_array($n->subtype, array(0,2)) && in_array($n->object_id, array_keys($houses))) || ($n->type == 10 && $n->subtype == 1 && in_array($n->object_id, $apts_ids_keys)))
							{
								if($n->date >= date_format($date_month_ago, 'Y-m-d') && $n->date < date_format($date_now, 'Y-m-d') && $this->request->get('tpl', 'integer') != 1)
								{
									$n->active = 0;
									$alerts[] = $n;
								}
								elseif($n->date >= date_format($date_now, 'Y-m-d'))
								{
									$n->active = 1;
									$alerts[] = $n;
								}
							}
							elseif(($n->type == 9 && in_array($n->subtype, array(0,1)) && in_array($n->object_id, $apts_ids_keys)) || ($n->type == 9 && $n->subtype == 2 && in_array($n->object_id, array_keys($houses))))
							{
								if($n->date >= date_format($date_month_ago, 'Y-m-d') && $n->date < date_format($date_now, 'Y-m-d') && $this->request->get('tpl', 'integer') != 1)
								{
									$n->active = 0;
									$visits[] = $n;
								}
								elseif($n->date >= date_format($date_now, 'Y-m-d'))
								{
									$n->active = 1;
									$visits[] = $n;
								}
							}
						}

						// сделать выборку через мувины конкретно по букингам этого дома
						$moves_ = $this->houseleader->get_moveins(array('booking_id'=>array_keys($bjs)));

						foreach ($moves_ as $m) 
						{
							$moves[$m->notify_id] = $m;
							// $moves_notify_ids[] = $m->notify_id;
						}

						if($this->request->get('tpl', 'integer') == 1)
							$plus_date = 1*24*60*60;
						else
							$plus_date = 7*24*60*60;

						$notify_ = $this->notifications->get_notifications(array('id'=>array_keys($moves), 'type'=>array('5', '6')));
						foreach ($notify_ as $n) 
						{
							$n->status = $moves[$n->id]->status;
							if($n->type == 5)
							{
								if($users[$n->object_id]->inquiry_arrive >= date_format($date_month_ago, 'Y-m-d') && $users[$n->object_id]->inquiry_arrive < date_format($date_now, 'Y-m-d') && $this->request->get('tpl', 'integer') != 1)
								{
									$n->active = 0;
									$notify[] = $n;
								}
								elseif($users[$n->object_id]->inquiry_arrive >= date_format($date_now, 'Y-m-d') && strtotime($users[$n->object_id]->inquiry_arrive) <= strtotime(date_format($date_now, 'Y-m-d'))+($plus_date))
								{
									$n->active = 1;
									$notify[] = $n;
								}
							}
							elseif($n->type == 6)
							{

								if($users[$n->object_id]->inquiry_depart >= date_format($date_month_ago, 'Y-m-d') && $users[$n->object_id]->inquiry_depart < date_format($date_now, 'Y-m-d') && $this->request->get('tpl', 'integer') != 1)
								{
									$n->active = 0;
									$notify[] = $n;
								}
								elseif($users[$n->object_id]->inquiry_depart >= date_format($date_now, 'Y-m-d') && strtotime($users[$n->object_id]->inquiry_depart) <= strtotime(date_format($date_now, 'Y-m-d'))+($plus_date))
								{
									$n->active = 1;
									$notify[] = $n;
								}
							}

						}

						if(!empty($notify))
							$this->design->assign('notify', $notify);
						if(!empty($visits))
							$this->design->assign('visits', $visits);
						if(!empty($alerts))
							$this->design->assign('alerts', $alerts);


					}
				}
			}

			if(!empty($guest->house))
				$cleanings_ = $this->cleaning->get_cleanings(array('house_id'=>$guest->house->id));
			if(!empty($cleanings_))
				foreach ($cleanings_ as $cl) 
				{
					if($cl->status==0 && $cl->bed=='Common Area' && $cl->type==2 && $cl->desired_date > date_format($date_month_ago, 'Y-m-d'))
					{	
						if($cl->desired_date >= date_format($date_month_ago, 'Y-m-d') && $cl->desired_date < date_format($date_now, 'Y-m-d') && $this->request->get('tpl', 'integer') != 1)
						{
							$cl->active = 0;
							$cleaning_com_area[] = $cl;
						}
						elseif($cl->desired_date >= date_format($date_now, 'Y-m-d'))
						{
							$cl->active = 1;
							$cleaning_com_area[] = $cl;
						}
					}
				}
			if(!empty($cleaning_com_area))
				$this->design->assign('cleaning_com_area', $cleaning_com_area);


			// if(empty($guest->room) && !empty($guest->apt))
			// 	$guest->room = $this->beds->get_rooms(array(
			// 		'apartament_id' => $guest->apt->id,
			// 		'limit' => 1
			// 	));

			// $room_beds = $this->beds->get_beds(array('room_id'=>$guest->room->id));
			// $room_beds_ids = array();
			// if($room_beds)
			// foreach ($room_beds as $rb) 
			// {
			// 	$room_beds_ids[] = $rb->id;
			// }

			// $rb_bookings = $this->beds->get_beds_journal(array('bed_id'=>$room_beds_ids, 'now'=>1, 'not_canceled' => 1));
			// $room_users_ids = array();
			// if($rb_bookings)
			// foreach ($rb_bookings as $rbb) {
			// 	if($rbb->user_id != $this->user->id)
			// 		$room_users_ids[] = $rbb->user_id;
			// }

			if(!empty($guest->booking->users))
				$cleanings_by_room = $this->cleaning->get_cleanings(array('user_id'=>array_keys($guest->booking->users)));


			$all_notifications = array();

			if(!empty($invoices))
			foreach ($invoices as $i) 
			{
				$i->notify_type = 'invoice';
				$all_notifications[$i->date][] = $i;
			}
			if(!empty($cleanings))
			foreach ($cleanings as $c) 
			{
				$c->notify_type = 'cleaning';
				$all_notifications[$c->date][] = $c;
			}
			if(!empty($notify))
			foreach ($notify as $n) 
			{
				$n->notify_type = 'move';
				if($n->type == 5)
					$all_notifications[$users[$n->object_id]->inquiry_arrive][] = $n;
				else
					$all_notifications[$users[$n->object_id]->inquiry_depart][] = $n;
			}
			if(!empty($alerts))
			foreach ($alerts as $a) 
			{
				$a->notify_type = 'alert';
				$all_notifications[$a->date][] = $a;
			}
			if(!empty($visits))
			foreach ($visits as $v) 
			{
				$v->notify_type = 'visit';
				$all_notifications[$v->date][] = $v;
			}
			if(!empty($cleaning_com_area))
			foreach ($cleaning_com_area as $c) 
			{
				$c->notify_type = 'cleaning_com_area';
				$all_notifications[$c->desired_date][] = $c;
			}

			krsort($all_notifications);
			$this->design->assign('all_notifications', $all_notifications);

		}



		// Technical issues
		if(!empty($this->user->house_id))
		{
			$issues = $this->issues->get_issues(array('house_id'=>$this->user->house_id, 'visible'=>1, 'status'=>array(0, 1)));
			$this->design->assign('issues_statuses', array('Not started', 'In progress', 'Done'));
			$this->design->assign('issues', $issues);


			$house_laeders = array();
			// type: 2 - houseleader
			$house_laeders_ = $this->users->get_users(array('hl_house_id'=>$this->user->house_id, 'type'=>2, 'status'=>7, 'visible'=>1));
			if(!empty($house_laeders_))
			{
				foreach($house_laeders_ as $k=>$hl)
				{
					$house_laeders[$k] = $hl;
					if(!empty($hl->blocks))
						$house_laeders[$k]->blocks = (array) unserialize($hl->blocks);
				}
			}
			$this->design->assign('house_laeders', $house_laeders);
			
		}

		// New Event and Product
		$products_ids = array();

		$new_event = $this->products->get_products(array('category_id'=>1, 'featured'=>1, 'visible'=>1, 'limit'=>1));
		if(!empty($new_event))
		{
			$new_event = current($new_event);
			$products_ids[] = $new_event->id;
		}

		$new_product = $this->products->get_products(array('category_id'=>2, 'featured'=>1, 'visible'=>1, 'limit'=>1));
		if(!empty($new_product))
		{
			$new_product = current($new_product);
			$products_ids[] = $new_product->id;
		}

		if(!empty($products_ids))
		{
			// Выбираем варианты
			$variants = $this->variants->get_variants(array('product_id'=>$products_ids, 'in_stock'=>true));
			if(!empty($variants))
			{
				foreach($variants as $variant)
				{
					if(!empty($new_event) && $new_event->id == $variant->product_id)
						$new_event->variants[] = $variant;
					if(!empty($new_product) && $new_product->id == $variant->product_id)
						$new_product->variants[] = $variant;
				}

			}
			
			// Выбираем изображения
			$images = $this->products->get_images(array('product_id'=>$products_ids));
			if(!empty($images))
			{
				foreach($images as $image)
				{
					if(!empty($new_event) && $new_event->id == $image->product_id)
						$new_event->images[] = $image;
					if(!empty($new_product) && $new_product->id == $image->product_id)
						$new_product->images[] = $image;
				}
			}

			if(!empty($new_event))
			{
				if(isset($new_event->variants[0]))
					$new_event->variant = $new_event->variants[0];
				if(isset($new_event->images[0]))
					$new_event->image = $new_event->images[0];
			}
			if(!empty($new_product))
			{
				if(isset($new_product->variants[0]))
					$new_product->variant = $new_product->variants[0];
				if(isset($new_product->images[0]))
					$new_product->image = $new_product->images[0];
			}

			//print_r($new_event); exit;

			$this->design->assign('new_event', $new_event);
			$this->design->assign('new_product', $new_product);
		}




		$this->design->assign('guest', $guest);

		if($this->request->get('tpl', 'integer') == 1)
			return $this->design->fetch('current_members.tpl');
		else
			return $this->design->fetch('notifications.tpl');

	}
}
