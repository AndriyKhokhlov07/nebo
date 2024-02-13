<?php

class Notify extends Backend
{
    function email($to, $subject, $message, $from = '', $reply_to = '')
    {
		if ($this->config->host == 'dev') {
			$this->save_eml($to, $subject, $message, $from);
		}

    	$headers = "MIME-Version: 1.0\n" ;
    	$headers .= "Content-type: text/html; charset=utf-8; \r\n"; 
    	$headers .= "From: $from\r\n";
    	if(!empty($reply_to))
	    	$headers .= "reply-to: $reply_to\r\n";
    	
    	$subject = "=?utf-8?B?".base64_encode($subject)."?=";

    	@mail($to, $subject, $message, $headers);
    }


	private $tmp_email_tpl = 'From: TEMPLATE_FROM_ADDRESS
MIME-Version: 1.0
To: TEMPLATE_TO_ADDRESS
Subject: TEMPLATE_SUBJECT
Content-Type: multipart/mixed; boundary="080107000800000609090108"

--080107000800000609090108
Content-Transfer-Encoding: base64
Content-Type: text/html; charset=utf-8

TEMPLATE_ATTACH_CONTENT
--080107000800000609090108';

// TEMPLATE_BODY
// --080107000800000609090108
// Content-Type: application/octet-stream;name="TEMPLATE_ATTACH_FILENAME"
// Content-Transfer-Encoding: base64
// Content-Disposition: attachment;filename="TEMPLATE_ATTACH_FILENAME"
// Content-Transfer-Encoding: base64

	function save_eml($to, $subject, $message, $from) {

		$content = $this->tmp_email_tpl;
		$content = str_replace("TEMPLATE_FROM_ADDRESS", $from, $content);
		$content = str_replace("TEMPLATE_TO_ADDRESS", $to, $content);
		$content = str_replace("TEMPLATE_SUBJECT", $subject, $content);
		$content = str_replace("TEMPLATE_ATTACH_CONTENT", base64_encode($message), $content);

		$tmp_email_url = $this->config->root_dir.$this->config->email_tmp_dir.date('Y-m-d_H-i-s_').microtime(true).'.eml';

		$f = fopen($tmp_email_url, 'w');
		fwrite($f, $content);
		fclose($f);
	}

	public function email_order_user($order_id, $user_id = '', $params = [])
	{
		if(!($order = $this->orders->get_order(intval($order_id)))) {
            return false;
        }

        $notify_type = 'default';

		$purchases = $this->orders->get_purchases(array('order_id'=>$order->id));

        $this->design->assign('purchases', $purchases);

		$products_ids = array();
		$variants_ids = array();
		foreach($purchases as $purchase)
		{
			$products_ids[] = $purchase->product_id;
			$variants_ids[] = $purchase->variant_id;
		}
		
		$products = array();
		foreach($this->products->get_products(array('id'=>$products_ids)) as $p) {
            $products[$p->id] = $p;
        }
			
		$images = $this->products->get_images(array('product_id'=>$products_ids));
		foreach($images as $image) {
            $products[$image->product_id]->images[] = $image;
        }
		
		$variants = array();
		foreach($this->variants->get_variants(array('id'=>$variants_ids)) as $v)
		{
			$variants[$v->id] = $v;
			$products[$v->product_id]->variants[] = $v;
		}
			
		foreach($purchases as &$purchase)
		{
			if(!empty($products[$purchase->product_id]))
				$purchase->product = $products[$purchase->product_id];
			if(!empty($variants[$purchase->variant_id]))
				$purchase->variant = $variants[$purchase->variant_id];
		}
		
		// Способ доставки
		$delivery = $this->delivery->get_delivery($order->delivery_id);
		$this->design->assign('delivery', $delivery);

		$this->design->assign('order', $order);
		$this->design->assign('purchases', $purchases);

		// Отправляем письмо
		// Если в шаблон не передавалась валюта, передадим
		if ($this->design->smarty->getTemplateVars('currency') === null) 
		{
			$currencies = $this->money->get_currencies(array('enabled'=>1));
			if(!empty($currencies))
			{
				$this->design->assign('currency', reset($currencies));
			}
			
		}

		if(!empty($purchases))
		{
			$main_purchase = reset($purchases);
			if(!empty($main_purchase->product))
			{
				$main_purchase->product->id;

				$product_categories = $this->categories->get_categories(array('product_id'=>$main_purchase->product->id));	
				$product_category = reset($product_categories);

				// $menu = $this->pages->get_pages(array('visible'=>1, 'menu_id'=>1));
				// $this->design->assign('menu', $menu);

			}
		}
		$subject = $this->design->get_var('subject');
		

		$order_users_filter = array();
		$order_users_filter['order_id'] = $order->id;
		if(!empty($user_id))
			$order_users_filter['user_id'] = (array)$user_id;

		$order_users = $this->orders->get_orders_users($order_users_filter);
		$order_users = $this->request->array_to_key($order_users, 'user_id');
		if(!empty($order_users))
			$users = $this->users->get_users(array('id'=>array_keys($order_users)));

		if (!empty($users)) {
            if (isset($params['autocharge']) && $params['autocharge'] == 'prior_notice' && !empty($order->booking_id)) {
                $booking = $this->beds->get_bookings([
                    'id' => $order->booking_id,
                    'limit' => 1
                ]);
                if (!empty($booking) && !empty($booking->house_id)) {
                    $payment_methods_ids = [];
                    $payee_ids = [];
                    $house_payment_methods = $this->payment->get_payment_method_houses([
                        'house_id' => $booking->house_id
                    ]);
                    if (!empty($house_payment_methods)) {
                        foreach($house_payment_methods as $hpm) {
                            $payment_methods_ids[] = $hpm->payment_method_id;
                        }
                        $payment_methods = $this->payment->get_payment_methods([
                            'id' => $payment_methods_ids
                        ]);
                        foreach ($payment_methods as $pm) {
                            $pm->settings = unserialize($pm->settings);
                            if ($pm->module == 'Qira' && !empty($pm->settings['payee_id'])) {
                                $payee_ids[$pm->settings['payment_method_type']] = $pm->settings['payee_id'];
                            }
                        }
                    }

                    foreach ($users as $user) {
                        if ((!isset($params['block_notifies']) || $user->block_notifies != 1) && !empty($user->payment_methods_details)) {
                            foreach ($user->payment_methods_details as $pm) {
                                if ($pm->response->Success == 1 && in_array($pm->payee_id, $payee_ids)) {
                                    $notify_type = 'autocharge_prior_notice';

                                    $this->design->assign('config', $this->config);

                                    $this->design->assign('user', $user);
                                    $this->design->assign('users', $users);

                                    $email_template = $this->design->fetch($this->config->root_dir . 'design/' . $this->settings->theme . '/html/email/autocharge_prior_notice.tpl');

                                    if (empty($subject))
                                        $subject = $this->design->get_var('subject');

                                    $this->email($user->email, $subject, $email_template, $this->settings->notify_from_email);

                                    if (isset($params['add_log']) && isset($params['sender_type'])) {
                                        $this->logs->add_log(array(
                                            'parent_id' => $order->id,
                                            'type' => 3, // Invoice
                                            'subtype' => 9, // Sent notice about future charge
                                            'sender_type' => $params['sender_type']
                                        ));
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if ($notify_type == 'default') {
                foreach ($users as $user) {
                    if (!isset($params['block_notifies']) || $user->block_notifies != 1) {

                        $this->design->assign('config', $this->config);

                        $this->design->assign('user', $user);
                        $this->design->assign('users', $users);

                        // $email_template = $this->design->fetch($this->config->root_dir.'design/'.$this->settings->theme.'/html/email_order.tpl');
                        if (isset($product_category)) {
                            if ($product_category->url == 'events') {
                                $email_template = $this->design->fetch($this->config->root_dir . 'design/' . $this->settings->theme . '/html/email_order_event.tpl');
                            }
                        }
                        $email_template = $this->design->fetch($this->config->root_dir . 'design/' . $this->settings->theme . '/html/email_invoice.tpl');

                        if (empty($subject))
                            $subject = $this->design->get_var('subject');

                        $this->email($user->email, $subject, $email_template, $this->settings->notify_from_email);

                        if (isset($params['add_log']) && isset($params['sender_type'])) {
                            $this->logs->add_log(array(
                                'parent_id' => $order->id,
                                'type' => 3, // Invoice
                                'subtype' => 2, // order sended
                                'sender_type' => $params['sender_type']
                            ));
                        }
                    }
                }
            }

		}
		
	
	}


	public function email_order_admin($order_id, $user_id = '')
	{
			if(!($order = $this->orders->get_order(intval($order_id))))
				return false;
			
			$purchases = $this->orders->get_purchases(array('order_id'=>$order->id));
			$this->design->assign('purchases', $purchases);			

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
			foreach($this->variants->get_variants(array('id'=>$variants_ids)) as $v)
			{
				$variants[$v->id] = $v;
				$products[$v->product_id]->variants[] = $v;
			}
	
			foreach($purchases as &$purchase)
			{
				if(!empty($products[$purchase->product_id]))
					$purchase->product = $products[$purchase->product_id];
				if(!empty($variants[$purchase->variant_id]))
					$purchase->variant = $variants[$purchase->variant_id];
			}
			
			// Способ доставки
			$delivery = $this->delivery->get_delivery($order->delivery_id);
			$this->design->assign('delivery', $delivery);

			// Пользователь
			$order_users = $this->orders->get_orders_users(array('order_id'=>$order->id));
			$users_ids = array();
			foreach ($order_users as $u) 
			{
				$users_ids[] = $u->user_id;
			}
			if(!empty($users_ids))
				$users = $this->users->get_users(array('id'=>$users_ids));
			$this->design->assign('users', $users);

			$this->design->assign('order', $order);
			$this->design->assign('purchases', $purchases);

			// В основной валюте
			$this->design->assign('main_currency', $this->money->get_currency());

			// Отправляем письмо
			$email_template = $this->design->fetch($this->config->root_dir.'backend/design/html/email_order_admin.tpl');
			$subject = $this->design->get_var('subject');
			$this->email($this->settings->order_email, $subject, $email_template, $this->settings->notify_from_email);
	
	}

	

	public function email_comment_admin($comment_id)
	{ 
			if(!($comment = $this->comments->get_comment(intval($comment_id))))
				return false;
			
			if($comment->type == 'product')
				$comment->product = $this->products->get_product(intval($comment->object_id));
			if($comment->type == 'blog')
				$comment->post = $this->blog->get_post(intval($comment->object_id));

			$this->design->assign('comment', $comment);

			// Отправляем письмо
			$email_template = $this->design->fetch($this->config->root_dir.'backend/design/html/email_comment_admin.tpl');
			$subject = $this->design->get_var('subject');
			$this->email($this->settings->comment_email, $subject, $email_template, $this->settings->notify_from_email);
	}

	public function email_password_remind($user_id, $code)
	{
			if(!($user = $this->users->get_user(intval($user_id))))
				return false;
			
			$this->design->assign('user', $user);
			$this->design->assign('code', $code);

			// Отправляем письмо
			$email_template = $this->design->fetch($this->config->root_dir.'design/'.$this->settings->theme.'/html/email_password_remind.tpl');
			$subject = $this->design->get_var('subject');
			$this->email($user->email, $subject, $email_template, $this->settings->notify_from_email);
			
			$this->design->smarty->clearAssign('user');
			$this->design->smarty->clearAssign('code');
	}

	public function email_feedback_admin($feedback_id)
	{ 
			if(!($feedback = $this->feedbacks->get_feedback(intval($feedback_id))))
				return false;

			$this->design->assign('feedback', $feedback);

			// Отправляем письмо
			$email_template = $this->design->fetch($this->config->root_dir.'backend/design/html/email_feedback_admin.tpl');
			$subject = $this->design->get_var('subject');
			$this->email($this->settings->comment_email, $subject, $email_template, "$feedback->name <$feedback->email>", "$feedback->name <$feedback->email>");
	}

	public function email_outpost_tenant_approve($salesflow_id, $sent_to_landlord)
	{
		if(empty($salesflow_id))
			return false;

		$salesflow = $this->salesflows->get_salesflows([
			'id' => $salesflow_id,
			'limit' => 1
		]);

		if(empty($salesflow))
			return false;

		$user = $this->users->get_user(intval($salesflow->user_id));
		
		if(empty($user))
			return false;

		$mailfrom = $this->settings->notify_from_email;
		$this->design->assign('user', $user);

		if($salesflow->deposit_type == 1)
			$this->design->assign('type', 'Outpost');
		elseif($salesflow->deposit_type == 2)
			$this->design->assign('type', 'Hellorented');

		if($sent_to_landlord == 'sent')
			$this->design->assign('sent_to_landlord', 'sent');

		$booking = $this->beds->get_bookings([
			'id' => $salesflow->booking_id,
			'limit' => 1
		]);

		// Cassa house + airbnb
		if($booking->house_id == 340 && $salesflow->type == 1)
		{
			$mailto = 'jacob.shapiro@outpost-club.com, customer.service@outpost-club.com';
			$email_template = $this->design->fetch($this->config->root_dir.'backend/design/html/email_cassa_salesflow_complete.tpl');
		}
		else
		{
			$mailto = 'alex.kos@outpost-club.com, jacob.shapiro@outpost-club.com, customer.service@outpost-club.com';
			$email_template = $this->design->fetch($this->config->root_dir.'backend/design/html/email_first_salsflow_complete.tpl');
		}

		if(!empty($booking) && !empty($booking->manager_login))
		{
			$booking_manager = $this->managers->get_manager($booking->manager_login);
			if(!empty($booking_manager->email))
			{
				$mailto .= ', ' . $booking_manager->email;
			}
		}


		$subject = $this->design->get_var('subject');
		$this->notify->email($mailto, $subject, $email_template, $mailfrom);
	}
	
	public function email_landlord_tenant_approve($salesflow_id)
	{
		$result = false;
		if(empty($salesflow_id))
			return false;

		if($salesflow_id < $this->salesflows->id_greater)
			return false;

		$salesflow = $this->salesflows->get_salesflows([
			'id' => $salesflow_id,
			'limit' => 1
		]);

		if(empty($salesflow))
			return false;

		$bookings = $this->beds->get_bookings([
			'id' => $salesflow->booking_id,
			'sp_group' => true,
			'sp_group_from_start' => true,
			'client_type' => true
		]);
		if(empty($bookings))
			return false;
		else
		{
			$booking = current($bookings);
			$booking->users = $this->users->get_users(['booking_id'=>$booking->id]);
		}

		if(!empty($booking->house_id) && in_array($booking->house_id, $this->salesflows->approve_houses_ids))
		{
			// Testing

			/*$result = 'sent';

			$this->design->assign('salesflow_id', $salesflow->id);

			$landlord = new stdClass;
			$landlord->name = 'Landlord Name';
			$this->design->assign('landlord', $landlord);
			$email_template = $this->design->fetch($this->config->root_dir.'design/'.$this->settings->theme.'/html/email/landlord_tenant_approve.tpl');
			$subject = $this->design->get_var('subject');

			$this->email('dmitriiy.kozik@gmail.com', $subject, $email_template, $this->settings->notify_from_email);

			$this->email('jack.molchanov@outpost-club.com', $subject, $email_template, $this->settings->notify_from_email);
			$this->email('alex.kos@outpost-club.com', $subject, $email_template, $this->settings->notify_from_email);
			$this->email('ss@outpost-club.com', $subject, $email_template, $this->settings->notify_from_email);*/

			if($booking->type == 1)
			{
				$room_type = $this->beds->get_rooms_types([
					'bed_id' => $booking->object_id,
					'limit' => 1
				]);
				$booking->bed = $this->beds->get_beds([
					'id'=>$booking->object_id,
					'limit' => 1
				]);	
			}

			$date_arrive = new DateTime($booking->arrive);
			$date_depart = new DateTime($booking->depart);
			$date_depart->modify('+1 day');
			$booking->period = date_diff($date_arrive, $date_depart);


			// Lafayette
			if($booking->house_id == 307)
			{
				$booking->house = $this->pages->get_page(intval($booking->house_id));
				if(!empty($booking->house))
				{
					if(!empty($booking->house->blocks))
						$booking->house->blocks = unserialize($booking->house->blocks);
					if(!empty($booking->house->blocks2))
						$booking->house->blocks2 = unserialize($booking->house->blocks2);

					$booking->house->loan_number = 10211547;
				}

				if(!empty($booking->bed))
				{
					$booking->room = $this->beds->get_rooms([
						'id' => $booking->bed->room_id,
						'limit' => 1
					]);

					if(!empty($booking->room))
					{
						$booking->room->labels = $this->beds->get_room_labels($booking->room->id);
						$booking->room->labels = $this->request->array_to_key($booking->room->labels, 'id');
					}
				}				
			}
		
			$booking->apt = $this->beds->get_apartments([
				'id'=>$booking->apartment_id,
				'limit' => 1
			]);

			if(!empty($booking->apt))
			{
				$booking->apt->number = $booking->apt->name;
				if(substr(trim($booking->apt->name), 0, 5) == 'Unit ')
					$booking->apt->number = substr(trim($booking->apt->name), 5);
				elseif(substr(trim($booking->apt->name), 0, 4) == 'Apt ')
					$booking->apt->number = substr(trim($booking->apt->name), 4);

				if(!empty($booking->apt->note))
				{
					$booking->apt->note = implode(' / ', array_map('trim', explode('/', $booking->apt->note)));
				}
					
			}

			$company_houses = $this->companies->get_company_houses([
				'house_id' => $booking->house_id
			]);
			if(!empty($company_houses))
			{
				$companies_ids = [];
				foreach($company_houses as $ch)
					$companies_ids[$ch->company_id] = $ch->company_id;
				
				if(!empty($companies_ids))
				{
					$companies_landlords = $this->users->get_landlords_houses([
						'house_id' => $companies_ids
					]);
					if(!empty($companies_landlords))
					{
						$landlords_ids = [];
						foreach($companies_landlords as $cl)
							$landlords_ids[$cl->user_id] = $cl->user_id;

						if(!empty($landlords_ids))
						{
							$landlords = $this->users->get_users([
								'id' => $landlords_ids,
								'enabled' => 1
							]);

							if(!empty($landlords))
							{
								$this->design->assign('salesflow_id', $salesflow->id);
								

								foreach($landlords as $landlord)
								{
									if(!empty($landlord->email && stripos($landlord->email, '@')))
									{
										$result = 'sent';
										$this->design->assign('booking', $booking);
										if(!empty($room_type))
										{
											$this->design->assign('room_type', $room_type);
										}
										$this->design->assign('landlord', $landlord);
										$email_template = $this->design->fetch($this->config->root_dir.'design/'.$this->settings->theme.'/html/email/landlord_tenant_approve.tpl');
										$subject = $this->design->get_var('subject');
										$this->email($landlord->email, $subject, $email_template, $this->settings->notify_from_email);
									}
								}

							}
						}
					}
				}
			}
			
		}
		return $result;
	}


	public function email_guarantor_agreement($user_id)
	{ 
		if(!($user = $this->users->get_user(intval($user_id))))
			return false;

		$this->design->assign('user', $user);


		$email_template = $this->design->fetch($this->config->root_dir.'design/'.$this->settings->theme.'/html/email/guarantor_agreement.tpl');
		$subject = $this->design->get_var('subject');
		$this->notify->email($user->email, $subject, $email_template, $this->settings->notify_from_email);

	}


}