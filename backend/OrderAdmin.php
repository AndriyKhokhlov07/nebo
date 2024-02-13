<?PHP


require_once('api/Backend.php');

############################################
# Class Product - edit the static section
############################################
class OrderAdmin extends Backend
{
	public function valid_date($d, $m, $y)
	{
		if(!checkdate($m, $d, $y))
			return $this->valid_date($d-1, $m, $y);
		else
			return $d;
	}

	public function fetch()
	{
		$users = array();
		$user_id = $this->request->get('user_id', 'integer');
		$booking_id = $this->request->get('booking_id', 'integer');

		$refund_id = $this->request->get('refund_id', 'integer');

		$request_type = $this->request->get('request_type');


		$manager = $this->managers->get_manager();


		$message_success = false;

		$order = new stdClass;

		if(!empty($_POST['add_log']))
		{
			$this->logs->add_log(array(
                'parent_id' => $this->request->post('add_log', 'integer'), 
                'type' => 3, 
                'subtype' => 7, // order note
                'sender_type' => 2,
                'sender' => $manager->login,
                'value' => $this->request->post('log_text')
            ));
		}
		if($this->request->method('post') && empty($_POST['add_log']))
		{
			$order->id = $this->request->post('id', 'integer');
			$order->type = $this->request->post('type', 'integer');
			if($this->request->post('address'))
				$order->address = $this->request->post('address');
			if($this->request->post('comment'))
				$order->comment = $this->request->post('comment');
			// $order->note = $this->request->post('note');

			$order->discount = $this->request->post('discount', 'float');
            if (empty($order->discount)) {
                $order->discount = 0;
            }
			$order->discount_type = $this->request->post('discount_type', 'integer');
			$order->discount_description = $this->request->post('discount_description');
			if($order->discount*1 == 0 || empty($order->discount))
				$order->discount_description = '';

			$order->coupon_discount = $this->request->post('coupon_discount', 'float');
			$order->delivery_id = $this->request->post('delivery_id', 'integer');
			if($this->request->post('delivery_price', 'float'))
				$order->delivery_price = $this->request->post('delivery_price', 'float');
			$order->payment_method_id = $this->request->post('payment_method_id', 'integer');
			$order->paid = $this->request->post('paid', 'integer');
			if($order->paid == 1)
				$order->status = 2; // paid
			$order->separate_delivery = $this->request->post('separate_delivery', 'integer');
			$order->address = $this->request->post('address');
			$order->comment = $this->request->post('comment');
			$order->contract_id = $this->request->post('contract_id');
			if($this->request->post('booking_id'))
				$order->booking_id = $this->request->post('booking_id');


			// Refund invoice
			if($order->type == 4)
			{
				$order->parent_refund_id = $this->request->post('parent_refund_id');

				if(empty($order->id)) {
					$refund_note = $this->request->post('refund_note');

					if(empty($refund_note)) {
						$this->design->assign('message_error', 'Enter Refund note');
					}
				}
			}

			if($this->request->post('child_refund_id'))
				$order->child_refund_id = $this->request->post('child_refund_id');

			$order->deposit = $this->request->post('deposit', 'integer');

			if($this->request->post('created_date'))
				$created_date = $this->request->post('created_date');
			if(!empty($created_date))
				$order->date = date('Y-m-d', strtotime($created_date));

			$paid_date = $this->request->post('payment_date');
			if(!empty($paid_date))
				$order->payment_date = date('Y-m-d', strtotime($paid_date));

			$o_date_from = $this->request->post('o_date_from');
			if(!empty($o_date_from))
				$order->date_from = date('Y-m-d', strtotime($o_date_from));

			$o_date_to = $this->request->post('o_date_to');
			if(!empty($o_date_to))
				$order->date_to = date('Y-m-d', strtotime($o_date_to));

			$date_from = $this->request->post('date_from');
			if(!empty($date_from))
				$order->date_from = date('Y-m-d', strtotime($date_from));

			$date_to = $this->request->post('date_to');
			if(!empty($date_to))
				$order->date_to = date('Y-m-d', strtotime($date_to));

			$order->date_due = null;
			$date_due = $this->request->post('date_due');
			if(!empty($date_due))
				$order->date_due = date('Y-m-d', strtotime($date_due));


	 
	 		if(!$order_labels = $this->request->post('order_labels'))
	 			$order_labels = array();


	 		if(!empty($order->id))
    			$old_order = $this->orders->get_order($order->id);

			if(empty($order->id))
			{
				// Get Booking ID
				/*
				if($order->type == 1 && !empty($order->contract_id))
    			{
    				$o_contract = $this->contracts->get_contract(intval($order->contract_id));
    				if(!empty($o_contract))
    				{
    					if(!empty($o_contract->reserv_id))
    						$order->booking_id = $o_contract->reserv_id;
    				}
    			}*/
				
				$u_date_from = strtotime($order->date_from);
				$u_date_to = strtotime($order->date_to);
				
				// Type: 1 - Invoice
				if ($order->type == 1 && strtotime('today') > $u_date_from && !$this->managers->access('orders_edit')) {
					$this->design->assign('message_error', 'Please, select future dates. You cannot create a invoice with past dates.');
				}
				elseif ($order->type == 1 && !is_null($order->date_due) && (strtotime('today') > strtotime($order->date_due) && !$this->managers->access('orders_edit'))) {
					$this->design->assign('message_error', 'Please, select future dates. You cannot create a invoice with past dates.');
				}
				elseif ($order->type == 1 && $u_date_from > $u_date_to) {
					$this->design->assign('message_error', 'The Living date to must be later than the Living date from.');
				} else {
				
					// Refund
					if (!empty($order->parent_refund_id)) {
						if ($refunded_order = $this->orders->get_order(intval($order->parent_refund_id))) {

							$order->booking_id = $refunded_order->booking_id;
							$order->contract_id = $refunded_order->contract_id;
						}
					}


					$order->users = $this->request->post('users');

					if($order->deposit == 1)
					{
						if(!empty($order->booking_id))
						{
							$salesflows = $this->salesflows->get_salesflows(['booking_id'=>$order->booking_id]);

							if(!empty($salesflows))
							{
								foreach ($salesflows as $s) 
								{
									$this->salesflows->update_salesflow($s->id, array(
										'deposit_type' => 1,  // Outpost
										'deposit_status' => 1 // Created
									));
								}
							}
						}


						foreach ($order->users as $u_id) 
						{
							$this->users->update_user($u_id, array(
								'security_deposit_type' => 1,  // Outpost
								'security_deposit_status' => 1 // Created
							));
						}
					}


					$order->id = $this->orders->add_order($order);
					$message_success = 'added';
					$this->design->assign('message_success', 'added');

					if($order->type == 4 && !empty($order->parent_refund_id) && !empty($order->id))
					{
						$this->orders->update_order($order->parent_refund_id, ['child_refund_id'=>$order->id]);
					}

					$log_create = [
						'parent_id' => $order->id, 
						'type' => 3, 
						'subtype' => 1, // order created
						'sender_type' => 2,
						'sender' => $manager->login
					];
					if($order->type == 4 && !empty($order->id) && !empty($refund_note)) {
						$log_create['value'] = $refund_note;
					}

					$this->logs->add_log($log_create);


					if($order->type == 3)
					{
						$cleaning = new stdClass;
						$cleaning->order_id = $order->id;
						$this->cleaning->add_cleaning($cleaning);
					}
				}
  			}
    		else
    		{

    			// Update Booking ID
    			if($order->type == 1 && !empty($order->contract_id) && empty($order->booking_id))
    			{
    				$o_contract = $this->contracts->get_contract(intval($order->contract_id));
    				if(!empty($o_contract))
    				{
    					if(!empty($o_contract->reserv_id) && $o_contract->reserv_id != $old_order->booking_id)
    						$order->booking_id = $o_contract->reserv_id;
    				}
    			}

    			
    			// Update booking due
    			if($order->type == 1 && !empty($order->contract_id) && $order->paid == 1)
    			{
    				// order - old data
	    			$old_order = $this->orders->get_order($order->id);
	    			if(!empty($old_order))
	    			{
	    				if($old_order->paid != 1)
	    				{
	    					$o_contract = $this->contracts->get_contract(intval($order->contract_id));
							if(!empty($o_contract))
							{
								$o_labels = $this->orders->get_order_labels($order->id);
								$o_labels = $this->request->array_to_key($order_labels, 'id');

								$payment_method = new stdClass;
								if(!empty($order->payment_method_id)) {
									$payment_method = $this->payment->get_payment_method($order->payment_method_id);

									// Paypal | Not US Citizen
									if($payment_method->module == 'Paypal' && $user->us_citizen == 2) {
										$payment_method->currency_id = 7;
									}
								}
									

								// Orders labels
								// 5 - Application fee
								// 6 - Prepayment
								if(!empty($o_contract->reserv_id) && !isset($o_labels[5]) && !isset($o_labels[6]))
								{
									$due_booking_params = array(
										'initiator' => 'payment',
										'order_id' => $order->id,
										'sender_type' => 2,
										'payment_status' => 'succeeded' // succeeded, pending

									);
									if(!empty($payment_method))
										$due_booking_params['payment_method'] = $payment_method->name;
									$this->beds->update_due_booking($o_contract->reserv_id, $due_booking_params);
								}
							}
	    				}
	    			}
    			}
    			$br = '
';

    			$log_value = '';
    			if($order->payment_date != $old_order->payment_date && !empty($order->payment_date))
    			{
    				$log_value .= '"Payment date" edit from '.date('M d, Y', strtotime($old_order->payment_date)).' to '.date('M d, Y', strtotime($order->payment_date));
    			}
    			if($order->date_from != $old_order->date_from)
    			{
    					$log_value .= $br;
    				$log_value .= '"Living date from" edit from '.date('M d, Y', strtotime($old_order->date_from)).' to '.date('M d, Y', strtotime($order->date_from));
    			}
    			if($order->date_to != $old_order->date_to)
    			{
    				if(!empty($log_value))
    					$log_value .= $br;
    				$log_value .= '"Living date to" edit from '.date('M d, Y', strtotime($old_order->date_to)).' to '.date('M d, Y', strtotime($order->date_to));
    			}
    			if($order->contract_id != $old_order->contract_id)
    			{
    				if(!empty($log_value))
    					$log_value .= $br;
    				$log_value .= '"Contract id" edit from '.$old_order->contract_id.' to '.$order->contract_id;
    			}
    			if($order->booking_id != $old_order->booking_id && !empty($order->booking_id))
    			{
    				if(!empty($log_value))
    					$log_value .= $br;
    				$log_value .= '"Booking id" edit from '.$old_order->booking_id.' to '.$order->booking_id;
    			}

    			if(!empty($log_value))
				{
					$this->logs->add_log(array(
	                    'parent_id' => $order->id, 
	                    'type' => 3, 
	                    'subtype' => 6, // order edit
	                    'sender_type' => 2,
	                    'sender' => $manager->login,
	                    'value' => $log_value
	                ));
				}


    			// Update order
    			$this->orders->update_order($order->id, $order);
				$this->design->assign('message_success', 'updated');
    		}


	    	$this->orders->update_order_labels($order->id, $order_labels);
			
			if($order->id)
			{
				// Покупки
				$purchases = array();
				if($this->request->post('purchases'))
				{
					foreach($this->request->post('purchases') as $n=>$va) foreach($va as $i=>$v)
					{
						if(empty($purchases[$i]))
							$purchases[$i] = new stdClass;
						$purchases[$i]->$n = $v;
					}
				}		
				$posted_purchases_ids = array();
				foreach($purchases as $purchase)
				{
					$variant = $this->variants->get_variant($purchase->variant_id);

					if(!empty($purchase->id))
						if(!empty($variant))
							$this->orders->update_purchase($purchase->id, array('variant_id'=>$purchase->variant_id, 'variant_name'=>$variant->name, 'sku'=>$variant->sku,'price'=>$purchase->price, 'amount'=>$purchase->amount, 'product_name'=>$purchase->product_name));
						else
							$this->orders->update_purchase($purchase->id, array('price'=>$purchase->price, 'amount'=>$purchase->amount, 'product_name'=>$purchase->product_name));
					elseif(!$purchase->id = $this->orders->add_purchase(array('order_id'=>$order->id, 'variant_id'=>$purchase->variant_id, 'variant_name'=>$variant->name, 'price'=>$purchase->price, 'amount'=>$purchase->amount, 'product_name'=>$purchase->product_name)))
					{
						// $this->design->assign('message_error', 'error_closing');
					}
						
					$posted_purchases_ids[] = $purchase->id;			
				}
				
				// Удалить непереданные товары
				foreach($this->orders->get_purchases(array('order_id'=>$order->id)) as $p)
					if(!in_array($p->id, $posted_purchases_ids))
						$this->orders->delete_purchase($p->id);


				// Произвольные purchases
				$pitems = array();
				if($this->request->post('pitems'))
				{
					$pitems_ = $this->request->post('pitems');
					foreach($pitems_ as $n=>$va) foreach($va as $i=>$v)
					{
						if(!empty($pitems_['product_name'][$i]))
						{
							if(empty($pitems[$i]))
							{
								$pitems[$i] = new stdClass;
								$pitems[$i]->order_id = $order->id;
								$pitems[$i]->product_id = 0;
								$pitems[$i]->variant_id = 0;
								$pitems[$i]->amount = 1;
							}
							$pitems[$i]->$n = $v;
						}
						
					}
					if(!empty($pitems))
					{
						foreach($pitems as $pitem)
							$this->orders->add_purchase($pitem);
					}
				}	

				// ORDER USERS
				$order_users_ = $this->orders->get_orders_users(array('order_id'=>$order->id));

				$order_users = array();
				foreach ($order_users_ as $ou) 
				{
					$order_users[$ou->user_id] = $ou->user_id;
				}
				$o_users_ids = $this->request->post('users');

				$add_order_users = array();
				if(!empty($o_users_ids))
				{
					foreach ($o_users_ids as $ouid) 
					{
						if(!empty($order_users) && in_array($ouid, $order_users))
							unset($order_users[$ouid]);
						else
							$add_order_users[] = $ouid;
					}
				}
				if(!empty($order_users))
					foreach ($order_users as $user_id) {
					 	$this->orders->delete_order_user($order->id, $user_id);
					}

				if(!empty($add_order_users))
					foreach ($add_order_users as $user_id) {
					 	$this->orders->add_order_user($order->id, $user_id);
					}
						
				// Принять?
				if($this->request->post('status_new'))
					$new_status = 0;
				elseif($this->request->post('status_accept'))
					$new_status = 1;
				elseif($this->request->post('status_done'))
					$new_status = 2;
				elseif($this->request->post('status_deleted'))
					$new_status = 3;
				else
					$new_status = $this->request->post('status', 'string');
				$change_status_value = 'Change status from '.$this->orders->statuses[$old_order->status];
				$change_status_value2 = '';
				if($this->request->post('paid', 'integer') == 1)
				{
					$this->orders->update_order($order->id, array('status'=>2));
					$change_status_value2 .= ' to '.$this->orders->statuses[2];
				}
				elseif($new_status == 0)					
				{
					if(!$this->orders->open(intval($order->id)))
					{
						// $this->design->assign('message_error', 'error_open');
					}
					else
					{
						$this->orders->update_order($order->id, array('status'=>0));
						$change_status_value2 .= ' to '.$this->orders->statuses[0];
					}
				}
				elseif($new_status == 1)					
				{
					if(!$this->orders->close(intval($order->id)) && $order->type == 2)
					{
						// $this->design->assign('message_error', 'error_closing');
					}
					else
					{
						$this->orders->update_order($order->id, array('status'=>1));
						$change_status_value2 .= ' to '.$this->orders->statuses[1];
					}
				}
				elseif($new_status == 2)					
				{
					// if(!$this->orders->close(intval($order->id)))
					// {
					// 	// $this->design->assign('message_error', 'error_closing');
					// }
					// else
						$this->orders->update_order($order->id, array('status'=>2));
						$change_status_value2 .= ' to '.$this->orders->statuses[2];

				}
				elseif($new_status == 3)					
				{
					// if(!$this->orders->open(intval($order->id)))
					// {
					// 	// $this->design->assign('message_error', 'error_open');
					// }
					// else
						$this->orders->update_order($order->id, array('status'=>3));
						$change_status_value2 .= ' to '.$this->orders->statuses[3];

					header('Location: '.$this->request->get('return'));
				}
				elseif($new_status == 4)					
				{
					$this->orders->update_order($order->id, array('status'=>4));
					$change_status_value2 .= ' to '.$this->orders->statuses[4];
				}
				if(!empty($change_status_value2) && !empty($old_order) && $old_order->status != $new_status)
				{
					$this->logs->add_log(array(
	                    'parent_id' => $order->id, 
	                    'type' => 3, 
	                    'subtype' => 4, // order change status
	                    'sender_type' => 2,
	                    'sender' => $manager->login,
	                    'value' => $change_status_value.$change_status_value2
	                ));
				}

				$order = $this->orders->get_order($order->id);
	
				// Отправляем письмо пользователю
				if($this->request->post('notify_user'))
				{
					$this->notify->email_order_user($order->id);
					$this->orders->update_order($order->id, array('sended'=>1));
					$this->design->assign('message_success', 'notify_sended');

					$this->logs->add_log(array(
	                    'parent_id' => $order->id, 
	                    'type' => 3, 
	                    'subtype' => 2, // order sended
	                    'sender_type' => 2,
	                    'sender' => $manager->login
	                ));
				}
			}

		}
		else
		{
			$order->id = $this->request->get('id', 'integer');
			$order = $this->orders->get_order(intval($order->id));
			// Метки заказа
			$order_labels = array();
			if(isset($order->id))
			foreach($this->orders->get_order_labels($order->id) as $ol)
				$order_labels[] = $ol->id;			
		}


		$subtotal = 0;
		$purchases_count = 0;
		if(!empty($order->id) && $purchases = $this->orders->get_purchases(array('order_id'=>$order->id)))
		{
			// Покупки
			$products_ids = array();
			$variants_ids = array();
			foreach($purchases as $purchase)
			{
				$products_ids[] = $purchase->product_id;
				$variants_ids[] = $purchase->variant_id;
			}
			
			$products = array();
			foreach($this->products->get_products(array('id'=>$products_ids)) as $p)
				$products[$p->id] = $p;
	
			$images = $this->products->get_images(array('product_id'=>$products_ids));		
			foreach($images as $image)
				$products[$image->product_id]->images[] = $image;
			
			$variants = array();
			foreach($this->variants->get_variants(array('product_id'=>$products_ids)) as $v)
				$variants[$v->id] = $v;
			
			foreach($variants as $variant)
				if(!empty($products[$variant->product_id]))
					$products[$variant->product_id]->variants[] = $variant;
				
	
			foreach($purchases as &$purchase)
			{
				if(!empty($products[$purchase->product_id]))
					$purchase->product = $products[$purchase->product_id];
				if(!empty($variants[$purchase->variant_id]))
					$purchase->variant = $variants[$purchase->variant_id];
				$subtotal += $purchase->price*$purchase->amount;
				$purchases_count += $purchase->amount;				
			}			
			
		}
		else
		{
			$purchases = array();
		}
		
		// Если новый заказ и передали get параметры
		if(empty($order->id))
		{
			$order = new stdClass;
			// if(empty($order->phone))
			// 	$order->phone = $this->request->get('phone', 'string');
			// if(empty($order->name))
			// 	$order->name = $this->request->get('name', 'string');
			if(!empty($refund_id))  {
				$refunded_order = $this->orders->get_order($refund_id);
                if (!empty($refunded_order)) {
                    $users_ = $this->users->get_users(array('order_id'=>$refunded_order->id));
                    $users = array();
                    if (!empty($users_)) {
                        foreach ($users_ as $user) {
                            $users[$user->id] = $user;
                        }
                    }
                    $order->users = $users;
                    $order->status = 2;
                    $order->paid = 1;
                    $order->total_price = -$refunded_order->total_price;
                    $subtotal = -$refunded_order->total_price;

                    $this->design->assign('refunded_order', $refunded_order);
                }
			}


			if(empty($order->address))
				$order->address = $this->request->get('address', 'string');
			// if(empty($order->email))
			// 	$order->email = $this->request->get('email', 'string');
		}

		if(!empty($user_id))
		{
			$user = $this->users->get_user(intval($user_id));
			if(!empty($user))
			{
				if(!empty($user->house_id))
				{
					$user->house = $this->pages->get_page(intval($user->house_id));

					if(!empty($user->house) && !empty($user->house->blocks2))
						$user->house->blocks2 = unserialize($user->house->blocks2);
				}

				$order->user_id = $user->id;

				if(!empty($user->inquiry_arrive))
				{
					$date_now = date_create();
					$d_start = date_create($user->inquiry_arrive);
					$n_date  = $d_start->format('j');
					if($date_now < $d_start)
					{
						$n_month = $d_start->format('n');
						$n_year  = $d_start->format('Y');
					}
					else
					{
						$n_month = $date_now->format('n');
						$n_year  = $date_now->format('Y');

						if($n_date < $date_now->format('j'))
						{
							if($n_month == 12)
							{
								$n_month = 1;
								$n_year++;
							}
							else
							{
								$n_month++;
							}

						}
					}

					$n_date = $this->valid_date($n_date, $n_month, $n_year);
					$date_start = date_create("$n_year-$n_month-$n_date");
					$user->date_from = $date_start->format('M d, Y');
					$n_date = $d_start->format('j');
					if($n_month == 12)
					{
						$n_month = 1;
						$n_year++;
					}
					else
					{
						$n_month++;
					}
					$n_date = $this->valid_date($n_date, $n_month, $n_year);
					$date_end = date_create("$n_year-$n_month-$n_date");
					$user->date_to = $date_end->format('M d, Y');
				}
			}
			if(empty($users))
    			$users[$user->id] = $user;
			$this->design->assign('user', $user);
		}

		if(!empty($booking_id))
		{
			$booking = $this->beds->get_bookings(array('id'=>$booking_id, 'limit'=>1));
			$this->design->assign('booking', $booking);

			$house = $this->pages->get_page(intval($booking->house_id));
			$this->design->assign('house', $house);

			$contracts = $this->contracts->get_contracts(array('reserv_id'=>$booking_id));
			if(!empty($contracts))
			{
				$this->design->assign('contracts', $contracts);

				$contract = current($contracts);
				$order->contract_id = $contract->id;
			}

			$bookings[] = $booking;
			$this->design->assign('bookings', $bookings);	
			$order->booking_id = $booking_id;

			$users = $this->users->get_users(array('booking_id'=>$booking_id));
		}


		if(!empty($order->date_from) && !empty($order->date_to))
		{
			$d1 = date_create($order->date_from);
			$d2 = date_create($order->date_to);

			$interval = date_diff($d1, $d2);

			$this->design->assign('interval_days', $interval->days + 1);

		}


		$order->status_name = $this->orders->get_status($order->status);
		


		$this->design->assign('purchases', $purchases);
		$this->design->assign('purchases_count', $purchases_count);
		$this->design->assign('subtotal', $subtotal);
		$this->design->assign('order', $order);

		if(!empty($order->id))
		{
			// Способ доставки
			$delivery = $this->delivery->get_delivery($order->delivery_id);
			$this->design->assign('delivery', $delivery);
	
			// Способ оплаты
			$payment_method = $this->payment->get_payment_method($order->payment_method_id);
			
			if(!empty($payment_method))
			{
				$payment_method_houses_ids = $this->payment->get_payment_method_houses([
					'payment_method_id' => $payment_method->id
				]);
				$payment_method_houses_ids = $this->request->array_to_key($payment_method_houses_ids, 'house_id');
				if(!empty($payment_method_houses_ids)) {
					$payment_method->houses = $this->pages->get_pages([
						'id' => array_keys($payment_method_houses_ids), 
						'not_tree' => 1
					]);
					if(!empty($payment_method->houses)) {
						foreach($payment_method->houses as $ph)
						{
							if(!empty($ph->blocks2)) {
								$ph->blocks2 = unserialize($ph->blocks2);
							}
						}
					}
				}
				$this->design->assign('payment_method', $payment_method);
		
				// Валюта оплаты
				$payment_currency = $this->money->get_currency(intval($payment_method->currency_id));
				$this->design->assign('payment_currency', $payment_currency);
			}
			// Пользователь
			// if($order->user_id)
			// {
			// 	$user = $this->users->get_user(intval($order->user_id));
			// 	if(!empty($user))
			// 	{
			// 		if(!empty($user->house_id))
			// 		{
			// 			$user->house = $this->pages->get_page(intval($user->house_id));

			// 			if(!empty($user->house) && !empty($user->house->blocks2))
			// 				$user->house->blocks2 = unserialize($user->house->blocks2);
			// 		}
			// 	}
			// 	$this->design->assign('user', $user);
			// 	//$this->design->assign('user', $this->users->get_user(intval($order->user_id)));
			// }

			// взять так же ордеры и перенести там код в ордер админ
			$users_ = $this->users->get_users(array('order_id'=>$order->id));

			$users = array();
			if(!empty($users_))
			foreach ($users_ as $user) 
			{
				$users[$user->id] = $user;
                if (!empty($user->block_notifies)) {
                    $order->block_notifies = true;
                }
			}
			$order_logs_ = $this->logs->get_logs(array(
				'parent_id' => $order->id,
				'type' => 3
			));
			// print_r($order_logs_); exit;

			// $order_logs = array();
			// foreach ($order_logs_ as $log) 
			// {
			// 	$order_logs[$log->user_id][] = $log;
			// }

			// print_r($users); exit;


			$this->design->assign('logs', $order_logs_);

			
			if(!empty($users))
			{
				$contracts = $this->contracts->get_contracts(array('user_id'=>array_keys($users)));
				$this->design->assign('contracts', $contracts);

				$bookings = $this->beds->get_bookings(array('user_id' => array_keys($users)));
				$this->design->assign('bookings', $bookings);	
			}

			if(!empty($order->parent_refund_id))
			{
                if (empty($refunded_order)) {
                    $refunded_order = $this->orders->get_order(intval($order->parent_refund_id));
                }
				$this->design->assign('refunded_order', $refunded_order);
			}

			if(!empty($order->child_refund_id))
			{
				$refunded_order_child = $this->orders->get_order(intval($order->child_refund_id)); 
				$this->design->assign('refunded_order_child', $refunded_order_child);
			}


			// Booking 
			if(!empty($order->booking_id)) {
				$order_booking = $this->beds->get_bookings([
					'id' => $order->booking_id,
					'sp_group' => true
				]);
				if(!empty($order_booking)) {
					$order->booking = current($order_booking);

                    if (!empty($order->booking->client_type_id)) {
                        $order->booking->client_type = $this->users->get_client_type($order->booking->client_type_id);
                    }

					$order->booking->house = $this->pages->get_page((int)$order->booking->house_id);
					if(!empty($order->booking->house->blocks2))
						$order->booking->house->blocks2 = unserialize($order->booking->house->blocks2);

					$order->booking->u_arrive = strtotime($order->booking->arrive);
					$order->booking->u_depart = strtotime($order->booking->depart);


					if(!empty($order->booking->due))
					{
						if(strtotime($order->booking->due) < strtotime(date('Y-m-d 00:00:00')))
							$order->booking->not_due = true;
					}

					$u_bj_interval = $order->booking->u_depart - $order->booking->u_arrive;


					$order->booking->days_count = round($u_bj_interval / (24 * 60 * 60) + 1);

					// Airbnb
					if(in_array($order->booking->client_type_id, [2]))
					{

						unset($order->booking->price_month);

						$order->booking->calculate->price_30_days = round($order->booking->price_day * 30);
						$order->booking->calculate->total = round($order->booking->price_day * $order->booking->days_count);
					}



					if(!empty($order->booking->paid_to))
					{
						$order->booking->u_paid_to = strtotime($order->booking->paid_to);
						$order->booking->paid_width = ($order->booking->u_paid_to - $order->booking->u_arrive) / $u_bj_interval * 100;
						if($order->booking->paid_width > 100)
							$order->booking->paid_width = 100;
					}

					if(!empty($order->booking->due))
					{
						$order->booking->u_due = strtotime($order->booking->due);
						$order->booking->due_width = ($order->booking->u_due - $order->booking->u_arrive) / $u_bj_interval * 100;
						if($order->booking->due_width > 100)
							$order->booking->due_width = 100;
					}
					else
						$order->booking->due_width = 100;

					if($order->booking->status == 0 || (isset($order->booking->not_due) && $order->booking->not_due == true))
						$bj_isset_canceled = true;

					// $bookings[$bj->id] = $bj;

					$beds = [];
					$beds_ids = [];
					$rooms = [];
					$rooms_ids = [];
					$apartments = [];
					$apartments_ids = [];
					if(isset($order->booking->sp_bookings)) {
						foreach($order->booking->sp_bookings as $b) {
							if($order->booking->type == 1) {  // booking bed
								$beds_ids[$b->object_id] = $b->object_id;
							}
							$apartments_ids[$b->apartment_id] = $b->apartment_id;
						}
					}
					else {
						if($order->booking->type == 1) {  // booking bed
							$beds_ids[$order->booking->object_id] = $order->booking->object_id;
						}
						$apartments_ids[$order->booking->apartment_id] = $order->booking->apartment_id;
					}
					if(!empty($beds_ids)) {
						$beds = $this->beds->get_beds([
							'id' => $beds_ids
						]);
						$beds = $this->request->array_to_key($beds, 'id');
						if(!empty($beds)) {
							$rooms_ids = array_keys($this->request->array_to_key($beds, 'room_id'));
							if(!empty($rooms_ids)) {
								$rooms = $this->beds->get_rooms([
									'id' => $rooms_ids
								]);
								$rooms = $this->request->array_to_key($rooms, 'id');
							}
						}
					}
					$rooms_types = $this->beds->get_rooms_types();
					$rooms_types = $this->request->array_to_key($rooms_types, 'id');
					if(!empty($apartments_ids)) {
						$apartments = $this->beds->get_apartments([
							'id' => $apartments_ids
						]);
						$apartments = $this->request->array_to_key($apartments, 'id');
					}
					$this->design->assign('clients_types', $this->users->clients_types);
					$this->design->assign('bj_statuses', $this->beds->bookings_statuses);
					$this->design->assign('beds', $beds);
					$this->design->assign('rooms', $rooms);
					$this->design->assign('rooms_types', $rooms_types);
					$this->design->assign('apartments', $apartments);
					$this->design->assign('apartment_types', $this->beds->apartment_types);
				}
			}



			
	
			// Соседние заказы
			// $this->design->assign('next_order', $this->orders->get_next_order($order->id, $this->request->get('status', 'string')));
			// $this->design->assign('prev_order', $this->orders->get_prev_order($order->id, $this->request->get('status', 'string')));
		}

		$houses = $this->pages->get_pages(array('menu_id'=>5, 'not_tree'=>1));
		$houses = $this->request->array_to_key($houses, 'id');
		$this->design->assign('houses_all', $houses);
		if(!empty($houses))
			$houses = $this->categories_tree->get_categories_tree('houses', $houses);
		$this->design->assign('houses', $houses);
		
		// Все способы доставки
		$deliveries = $this->delivery->get_deliveries();
		$this->design->assign('deliveries', $deliveries);

		// Все способы оплаты
		$payment_methods = $this->payment->get_payment_methods();

		$this->design->assign('payment_methods', $payment_methods);

		$this->design->assign('types', $this->orders->types);

		

		// if(!empty($user))
		// {
		// 	$contracts = $this->contracts->get_contracts(array('user_id'=>$user->id, 'status'=>1));
		// 	$this->design->assign('contracts', $contracts);
		// }
		

		// print_r($order); exit;
		// Метки заказов
	  	$labels = $this->orders->get_labels();
	 	$this->design->assign('labels', $labels);

	 	$type = $this->request->get('type', 'integer');
	 	$this->design->assign('type', $type);
	  	
	 	$this->design->assign('order_labels', $order_labels);	

	 	$this->design->assign('users', $users);  
		 
		 
		if($request_type == 'ajax')
		{
			$result = new stdClass;
			$result->tpl = $this->design->fetch('invoices/bx/invoice.tpl');

			header("Content-type: application/json; charset=UTF-8");
			header("Cache-Control: must-revalidate");
			header("Pragma: no-cache");
			header("Expires: -1");		
			print json_encode($result);
			exit;
		}


		if(!empty($refund_id) && !empty($order->id) && $message_success == 'added') {
			header('Location: '.$this->config->root_url.'/backend/?module=OrderAdmin&id='.$order->id);
			exit;
		}
			
		
		if($this->request->get('view') == 'print')
 		  	return $this->design->fetch('order_print.tpl');
		if(empty($order->id) || $this->managers->access('orders_edit'))
			return $this->design->fetch('invoices/invoice_edit.tpl');
		else
			return $this->design->fetch('invoices/invoice_page.tpl');

			
		// elseif(!empty($order->id) || $backend->managers->access('orders_edit'))
			
 	  	// else
	 	//   	return $this->design->fetch('order.tpl');
	}
}