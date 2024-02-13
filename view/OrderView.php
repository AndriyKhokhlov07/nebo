<?PHP

require_once('View.php');

use Qira;

class OrderView extends View
{
	public function __construct()
	{
		parent::__construct();
		$this->design->smarty->registerPlugin("function", "checkout_form", array($this, 'checkout_form'));
	}

	//////////////////////////////////////////
	// Основная функция
	//////////////////////////////////////////
	function fetch()
	{
		// Скачивание файла
		if($this->request->get('file'))
		{
			return $this->download();
		}
		else
		{
			return $this->fetch_order();
		}
	
	}
	
	function fetch_order()
	{
		// пройтись по всем шаблонам писем и страниц с ордером
		// подправить ссылки, добавить в них юзер ид и форичить юзеров в выводе имени билинг ту
		if($url = $this->request->get('url', 'string'))
			$order = $this->orders->get_order((string)$url);
		elseif(!empty($_SESSION['order_id']))
			$order = $this->orders->get_order(intval($_SESSION['order_id']));
		else
			return false;
			
		if(!$order)
			return false;
						
		$purchases = $this->orders->get_purchases(array('order_id'=>intval($order->id)));
		if(!$purchases)
			return false;

		$salesflow_id = $this->request->get('s');
		if(!empty($salesflow_id))
		{
			$this->salesflows->check_salesflow_status(intval($salesflow_id));

			$salesflow = $this->salesflows->get_salesflows(['id'=>intval($salesflow_id), 'limit'=>1]);
			$this->design->assign('salesflow', $salesflow);

			// Hotel salesflow
			if($salesflow->type == 3 && $order->deposit == 1 && ($order->status == 1 || $order->status == 2 || $order->paid == 1))
			{
				$first_month_invoice = current($this->orders->get_orders(['booking_id'=>$salesflow->booking_id, 'deposit'=>0, 'limit' => 1, 'sort' => 1]));

				$this->design->assign('first_month_invoice', $first_month_invoice);
			}
		}

		if(!empty($order->booking_id))
		{
			$booking = $this->beds->get_bookings(['id'=>$order->booking_id, 'limit'=>1]);
			
			$hide_salesflow_steps = false;
			if(!empty($booking)) {
				if($booking->sp_type == 1 && $booking->parent_id != $booking->id && !empty($booking->parent_id)) {
					$hide_salesflow_steps = true;
				}
				else {
					$booking_invoices_paid = $this->orders->get_orders([
						'booking_id' => $booking->id,
						'type' => 1,
						'deposit' => 0,
						'paid' => 1
					]);
					if(count($booking_invoices_paid) > 1) {
						$hide_salesflow_steps = true;
					}
					elseif(count($booking_invoices_paid) == 1) {
						$booking_invoice_paid = current($booking_invoices_paid);
						if($booking_invoice_paid->id != $order->id) {
							// $hide_salesflow_steps = true;
						}
					}
				}
			}
			$this->design->assign('hide_salesflow_steps', $hide_salesflow_steps);

		}

		$order_users = $this->orders->get_orders_users(array('order_id'=>$order->id));
		$users_ids = array();
		foreach ($order_users as $u) 
		{
			$users_ids[] = $u->user_id;
		}
		if(!empty($users_ids))
			$users_ = $this->users->get_users(array('id'=>$users_ids));
		$users = array();
		foreach ($users_ as $u) 
		{
			$users[$u->id] = $u;
		}
		$user_id = $this->request->get('u', 'integer');
		if(!empty($user_id) && isset($users[intval($user_id)]))
		{
			$user = $users[intval($user_id)];
			if(!empty($user))
				$_SESSION['user_id'] = $user->id;
		}
		elseif(!empty($this->user) && isset($users[intval($this->user->id)]))
			$user = $this->user;
		elseif(!empty($users))
		{
			$user = current($users);
			$_SESSION['user_id'] = $user->id;
		}


		$order->labels = $this->orders->get_order_labels(intval($order->id));
		$order->labels = $this->request->array_to_key($order->labels, 'id');	

		if(!empty($order->labels) && !empty($user))
		{
			// 7 - Application fee
			if($order->type == 7)
			{
				$order->application_fee = 1;

				$this->design->assign('active_step', 1);

				if(!empty($order->contract_id))
				{
					$deposit_invoice = $this->orders->get_orders(array(
	    				'contract_id' => $order->contract_id,
	    				'deposit' => 1, // Deposit
	    				'limit' => 1,
	    				'count' => 1
	    			));
	    			if(!empty($deposit_invoice))
	    			{
						$this->design->assign('deposit_invoice', $deposit_invoice);
	    			}
				}
				
			}

			// 6 - Prepayment for the first month
			if(isset($order->labels[6]))
			{
				$order->prepayment_invpice = 1;

				$this->design->assign('active_step', 2);
				if(in_array($order->status, array(1,2)) || $order->paid == 1)
					$this->design->assign('active_step', 3);

			}

			// 7 - Hide ACH
			if(isset($order->labels[7]))
				$user->hide_ach = 1;
		}

		// Если это первый инвойс человека!!! 
		$paid_order = $this->orders->get_orders(['user_id'=>$user->id, 'paid'=>1, 'count'=>1, 'limit'=>1]);
		if(!empty($order->date_from) && $user->id > 2167 && empty($paid_order) && strtotime($order->date_from) <= (strtotime(date("Y-m-d")) + (7*24*60*60)))
		{
			$user->hide_ach = 1;
		}

		$viewed = $this->request->get('w', 'integer');
		if($viewed == 1 && empty($_SESSION['admin']))
		{
			$this->orders->update_order(intval($order->id), array('date_viewed'=>date("Y-m-d H:i:s")));
			header('Location: '.$this->config->root_url.'/order/'.$order->url);
			exit;
		}

		$deposit = $this->request->get('tp', 'integer');
		if($deposit == 1)
		{
			if(empty($_SESSION['admin']))
				$this->orders->update_order(intval($order->id), array('date_viewed'=>date("Y-m-d H:i:s")));

			// $deposit_id = intval($order->id) - 1;
			// $deposit_invoice = $this->orders->get_order(intval($deposit_id));

			$this->design->assign('tp', '1');
		}

		$back = $this->request->get('b', 'integer');
		if($back)
		{
			if(empty($_SESSION['admin']))
				$this->orders->update_order(intval($order->id), array('date_viewed'=>date("Y-m-d H:i:s")));

			$back_id = intval($order->id) + 1;
			$back_invoice = $this->orders->get_order(intval($back_id));

			if(!empty($back_invoice))
				$this->design->assign('back_invoice', $back_invoice);
		}

		$notification_id = $this->request->get('n', 'integer');
		if($notification_id)
		{
			if(empty($_SESSION['admin']))
				$this->orders->update_order(intval($order->id), array('date_viewed'=>date("Y-m-d H:i:s")));

			$back_id = intval($order->id) + 1;
			$back_invoice = $this->orders->get_order(intval($back_id));

			if(!empty($back_invoice))
				$this->design->assign('back_invoice', $back_invoice);

			$notification = $this->notifications->get_notification($notification_id);

			if($notification)
				$this->design->assign('notification', $notification);

		}


		$notifications_ = $this->request->get('ns', 'integer');
		if($notifications_)
		{
			if(empty($_SESSION['admin']))
				$this->orders->update_order(intval($order->id), array('date_viewed'=>date("Y-m-d H:i:s")));

			// $back_id = intval($order->id) + 1;
			// $back_invoice = $this->orders->get_order(intval($back_id));

			// if(!empty($back_invoice))
			// 	$this->design->assign('back_invoice', $back_invoice);

			// переписать на сейлфлоу/букинг ид.

			// $deposit_id = intval($order->id) - 1;
			// $deposit_invoice = $this->orders->get_order(intval($deposit_id));

			$deposit_invoice = $this->orders->get_orders(['deposit'=>1, 'booking_id'=>$order->booking_id, 'limit'=>1, 'count'=>1]);

			if($deposit_invoice->deposit == 1)
				$this->design->assign('deposit_invoice', $deposit_invoice);

			$notification = current($this->notifications->get_notifications(array('user_id'=>$user->id)));

			if($notification)
				$this->design->assign('notification', $notification);

		}
		

			
		if($this->request->method('post'))
		{
			$coupon_code = trim($this->request->post('coupon_code', 'string'));
	    	if(empty($coupon_code))
	    	{
	    		$this->cart->apply_coupon('');
	    	}
	    	else
	    	{
				$coupon = $this->coupons->get_coupon((string)$coupon_code);
				if(empty($coupon) || !$coupon->valid)
				{
		    		$this->cart->apply_coupon($coupon_code);
					$this->design->assign('coupon_error', 'invalid');
				}
				else
				{
					$this->cart->apply_coupon($coupon_code);
					// Скидка по купону
					if(isset($_SESSION['coupon_code']))
					{
						$coupon = $this->coupons->get_coupon($_SESSION['coupon_code']);
						if($coupon && $coupon->valid && $order->total_price>=$coupon->min_order_price)
						{
							if($coupon->type=='absolute')
							{
								// Абсолютная скидка не более суммы заказа
								$coupon_discount = $order->total_price>$coupon->value?$coupon->value:$order->total_price;
								$order->total_price = max(0, $order->total_price-$coupon_discount);
							}
							else
							{
								$coupon_discount = $order->total_price * ($coupon->value)/100;
								$order->total_price = $order->total_price-$coupon_discount;
							}
						}
						else
						{
							unset($_SESSION['coupon_code']);
						}
						$order->coupon_discount = $coupon_discount;
						$order->coupon_code = $coupon->code;

						$this->orders->update_order($order->id, $order);
						$order = $this->orders->get_order((integer)$order->id);
					}
					$this->coupons->update_coupon($coupon->id, array('usages'=>$coupon->usages+1));
				}
	    	}
			


			if($payment_method_id = $this->request->post('payment_method_id', 'integer'))
			{
				$this->orders->update_order($order->id, array('payment_method_id'=>$payment_method_id));
				$order = $this->orders->get_order((integer)$order->id);
			}
			elseif($this->request->post('reset_payment_method'))
			{
				$this->orders->update_order($order->id, array('payment_method_id'=>null));
				$order = $this->orders->get_order((integer)$order->id);
			}
		}
		
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
			$variants[$v->id] = $v;
			
		foreach($variants as $variant)
			$products[$variant->product_id]->variants[] = $variant;

		foreach($purchases as &$purchase)
		{
			if(!empty($products[$purchase->product_id]))
				$purchase->product = $products[$purchase->product_id];
			if(!empty($variants[$purchase->variant_id]))
			{
				$purchase->variant = $variants[$purchase->variant_id];
			}
		}

		$contract = $this->contracts->get_contract(intval($order->contract_id));
		$this->design->assign('contract', $contract);

		// Month count
		$d1 = date_create($contract->date_from);
		$d2 = date_create($contract->date_to);
		
		$interval = date_diff($d1, $d2);

		$this->design->assign('contract_interval', $interval->days);


		// if(!empty($contract))
		// {
		// 	$membership_inv = current($this->orders->get_orders(array('contract_id'=>$contract->id, 'membership'=>1)));
		// 	if(!empty($membership_inv))
		// 	{
		// 		$this->design->assign('membership', $membership_inv);
		// 	}
		// }

		// Способ доставки
		$delivery = $this->delivery->get_delivery($order->delivery_id);
		$this->design->assign('delivery', $delivery);
			
		$this->design->assign('order', $order);
		$this->design->assign('purchases', $purchases);


		// $user = $this->users->get_user(intval($order->user_id));
		$this->user = $user;
		$this->design->assign('user', $user);
		$this->design->assign('users', $users);


		// Способ оплаты
		if($order->payment_method_id)
		{
			$payment_method = $this->payment->get_payment_method($order->payment_method_id);

			// Paypal | Not US Citizen
			if($payment_method->module == 'Paypal' && $user->us_citizen == 2) {
				$payment_method->currency_id = 7;
			}
		}


			
		// Варианты оплаты
		$payment_methods_ids = [];
		if(!empty($booking))
		{
			$house_payment_methods = $this->payment->get_payment_method_houses(['house_id'=>$booking->house_id]);
			if(!empty($house_payment_methods))
			{
				foreach($house_payment_methods as $hpm)
				{
					$payment_methods_ids[] = $hpm->payment_method_id;
				}
			}
		}




        // Brokerage
        if ($order->type == 13) {
            $payment_methods = $this->payment->get_payment_methods([
                'id' => [
                    90, // Credit Card (BRKRG)
                    91, // Debit Card (BRKRG)
                    92  // ACH (BRKRG)
                ],
            ]);
        }
        // 7 - Application fee type, 12 - Landlord invoice type
		elseif (!empty($payment_methods_ids) && $order->type != 7 && $order->type != 12) {
			$payment_methods = $this->payment->get_payment_methods(['id'=>$payment_methods_ids, 'for_all_houses'=>1, 'delivery_id'=>$order->delivery_id, 'enabled'=>1]);
		}
		else {
			$payment_methods = $this->payment->get_payment_methods(['without_houses'=>1, 'delivery_id'=>$order->delivery_id, 'enabled'=>1]);
		}
        if($order->id == 24694 || $order->url == "749767276c0963950ddf92f55e944639")
        {
            $qira_fees = (new Qira())->getProcessingFee($order->total_price);

            var_dump($qira_fees); exit;
            $qira_fees->Fees = $this->request->array_to_key($qira_fees->Fees, 'PaymentMethodType');

        }


        $qira_fees = (new Qira)->getProcessingFee($order->total_price);
        $qira_fees->Fees = $this->request->array_to_key($qira_fees->Fees, 'PaymentMethodType');


        // First invoice and deposit - PayPal, Stripe, Stripe ACH
        $op_houses_ids = [
            349, // The Mason on Chestnut
            311, // The Greenpoint House (107)
            316, // The Greenpoint House (111)
            317, // The Greenpoint House (115)
            307, // The Lafayette House
            422, // The Rectory House
        ];
        if (!empty($booking) && in_array($booking->house_id, $op_houses_ids)) {
            if ($booking_invoices_paid == false || $order->deposit == 1) {
                $payment_methods_ids = [
                    4, // PayPal
                    6, // Stripe
                ];

                if ($order->deposit != 1 && empty($user->hide_ach) && (!empty($order->date_from) && strtotime($order->date_from) > (strtotime(date("Y-m-d")) + (7*24*60*60)))) {
                    $payment_methods_ids[] = 7;  // Stripe ACH
                }

                $payment_methods = $this->payment->get_payment_methods([
                    'id' => $payment_methods_ids
                ]);
            }
        }


        foreach($payment_methods as $pm)
        {	
			// Paypal | Not US Citizen
			if($pm->module == 'Paypal' && $user->us_citizen == 2) {
				$pm->currency_id = 7;
			}

        	$pm->settings = unserialize($pm->settings);

		    if($pm->module == 'Qira')
            {
                $payment_settings = $this->payment->get_payment_settings($pm->id);
                $pm->payment_method_type = intval($payment_settings['payment_method_type']);
                $pm->fee = $qira_fees->Fees[$pm->payment_method_type]->TotalFeeAmount;
            }
        }
        if(!empty($payment_method))
        {
            $payment_settings = $this->payment->get_payment_settings($payment_method->id);
            $payment_method->payment_method_type = intval($payment_settings['payment_method_type']);
            $payment_method->fee = $qira_fees->Fees[$payment_method->payment_method_type]->TotalFeeAmount;
        }


        if($this->request->get('q'))
        {
        	print_r($payment_methods);
        }

        

		$this->design->assign('payment_methods', $payment_methods);
        $this->design->assign('payment_method', $payment_method);


        // Все валюты
		$this->design->assign('all_currencies', $this->money->get_currencies());

		//$this->notify->email_order_user($order->id);

		// Выводим заказ
		$tpl = 'invoice.tpl';
		if($order->type==2)
			$tpl = 'order.tpl';
		return $this->design->fetch($tpl);
	}
	
	private function download()
	{
		$file = $this->request->get('file');
		
		if(!$url = $this->request->get('url', 'string'))
			return false;
			
		$order = $this->orders->get_order((string)$url);
		if(!$order)
			return false;
			
		if(!$order->paid)
			return false;
						
		// Проверяем, есть ли такой файл в покупках	
		$query = $this->db->placehold("SELECT p.id FROM __purchases p, __variants v WHERE p.variant_id=v.id AND p.order_id=? AND v.attachment=?", $order->id, $file);		$this->db->query($query);
		if($this->db->num_rows()==0)
			return false;
		
		header("Content-type: application/force-download");
		header("Content-Disposition: attachment; filename=\"$file\"");
		header("Content-Length: ".filesize($this->config->root_dir.$this->config->downloads_dir.$file));
		readfile($this->config->root_dir.$this->config->downloads_dir.$file);
		
		exit();
	}
	
	public function checkout_form($params, &$smarty)
	{
		$module_name = preg_replace("/[^A-Za-z0-9]+/", "", $params['module']);

		$form = '';
		if(!empty($module_name) && is_file("payment/$module_name/$module_name.php"))
		{
			include_once("payment/$module_name/$module_name.php");
			$module = new $module_name();
			$form = $module->checkout_form($params['order_id'], $params['button_text']);
		}
		return $form;
	}

}