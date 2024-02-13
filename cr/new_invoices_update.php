<?php
ini_set('error_reporting', E_ALL);


session_start();

chdir('..');
require_once('api/Backend.php');



class Test extends Backend
{
	function fetch()
	{
		$query = $this->db->placehold("SELECT 
							c.id,
							c.url,
							c.sku,
							c.type,
							c.user_id,
							c.reserv_id,
							c.house_id,
							c.rental_name,
							c.rental_address,
							c.date_from,
							c.date_to,
							c.price_month,
							c.total_price,
							c.price_deposit,
							c.signing,
							c.date_signing,
							c.date_created,
							c.date_viewed,
							c.roomtype,
							c.room_type,
							c.link1_type,
							c.note1,
							c.first_sellflow,
							c.sellflow,
							c.outpost_deposit,
							c.status,
							c.options,
							c.approve,
							c.new_lease,
							c.approve_first_salesflow,
							c.invoice_recreate
						FROM __contracts AS c
						WHERE 1
							AND c.invoice_recreate=0
							AND c.status=1
							AND c.signing=1
							AND c.date_to >= '2021-06-01 00:00:00'
							AND c.date_signing <= '2021-04-28 00:00:00'
						ORDER BY c.id
						LIMIT 10
						");
		$this->db->query($query);	

		$contracts = $this->db->results();

		$contracts = $this->request->array_to_key($contracts, 'id');

		$query = $this->db->placehold("SELECT 
							o.id,
							o.contract_id,
							o.date_from,
							o.date_to
						FROM __orders AS o
						WHERE 1
							AND o.type = 1
							AND o.paid != 1
							AND o.status = 0
 							AND o.date_from >= '2021-05-03 00:00:00'
 							AND o.contract_id in (?@)
						ORDER BY o.id
						", array_keys($contracts));
		$this->db->query($query);	

		$orders_to_cancel = $this->db->results();

		foreach ($orders_to_cancel as $o_c) 
		{
			$contracts[$o_c->contract_id]->old_invoices[] = $o_c;
		}

		foreach ($contracts as $c) 
		{
			if(!empty($c->old_invoices))
			{
				$c->first_inv_to_create = current($c->old_invoices);
				if($c->first_inv_to_create->date_from != $c->date_from)
				{
					$date_from = date_create($c->first_inv_to_create->date_from);
					date_sub($date_from, date_interval_create_from_date_string('1 month'));
					$c->invoices = $this->contracts->calculate($date_from->format('Y-m-d'), $c->date_to, $c->price_month);
				}
				else
				{
					$c->invoices = $this->contracts->calculate($c->date_from, $c->date_to, $c->price_month);
				}
				foreach ($c->invoices->invoices as $k => $c_inv) 
				{
					if($c_inv->date_from < $c->first_inv_to_create->date_from)
						$c_inv->create = 0;
					else
						$c_inv->create = 1;
				}
			}

			$invoice_users_ = $this->contracts->get_contracts_users(['contract_id'=>$c->id]);
			$invoice_users = [];
			foreach ($invoice_users_ as $i) 
			{
				$invoice_users[] = $i->user_id;
			}

			if(!empty($c->roomtype))
				$c->roomtype = $this->beds->get_rooms_types(array('id'=>$c->roomtype, 'limit'=>1));

			if(!empty($c->roomtype))
				$room_type = $c->roomtype->name;
			elseif($c->room_type==1)
				$room_type = '2-people room';
			elseif ($c->room_type==2)
				$room_type = '3-people room';
			elseif ($c->room_type==3)
				$room_type = '4-people room';
			elseif ($c->room_type==4)
				$room_type = '3-people shared room';
			elseif ($c->room_type==5)
				$room_type = '4-people shared room';
			elseif ($c->room_type==6)
				$room_type = 'Private room';
			elseif ($c->room_type==7)
				$room_type = 'Private room with bathroom';
	    	

			if(!empty($c->house_id))
			{
				$house_id = $c->house_id;
			}
			if(empty($house_id) && !empty($c->reserv_id))
			{
				$booking = $this->beds->get_bookings(array('id'=>$c->reserv_id, 'limit'=>1));
				if(!empty($booking->house_id))
					$house_id = $booking->house_id;
			}
			if(!empty($house_id))
			{
				$house = $this->pages->get_page(intval($house_id));
				$company_houses = current($this->companies->get_company_houses(array('house_id'=>$house_id)));
				if(!empty($company_houses))
					$company = $this->companies->get_company($company_houses->company_id);

				if(!empty($company))
				{
					$last_invoice_id = $house->last_invoice;
					$this->pages->update_page($house->id, array('last_invoice' => $house->last_invoice + count($c->invoices->invoices)));

					// перед добавлением инвойсов обновить дому поле last_invoice_id на то количество инвойсов, что добавляют, а с предыдущего числа делать +1 для всех инвойсов
					$new_sku = date('y', strtotime($c->date_from)).'-'.str_pad($company->landlord_id, 2, "0", STR_PAD_LEFT).'-'.str_pad($house->sku, 3, "0", STR_PAD_LEFT);
				}
			}

			$reverv = $this->beds->get_bookings(array(
				'id' => $c->reserv_id, 
				'not_canceled' => 1,
				'limit' => 1
			));


			if($reverv->type == 1)
			{
				$bed = $this->beds->get_beds(array(
					'id' => $reverv->object_id,
					'limit' => 1
				));
			}
			elseif($reverv->type == 2)
			{
				$apartment = $this->beds->get_apartments(array(
					'id' => $reverv->object_id,
					'limit' => 1
				));
			}	


			// Создание всех инвойсов для пользователя 
			if(!empty($c->invoices->invoices))
			foreach($c->invoices->invoices as $k=>$inv) 
			{
				if($inv->create == 1)
				{
					$new_invoice = new stdClass;
					$new_invoice->contract_id = $c->id;
					$new_invoice->booking_id = $c->reserv_id;
					$new_invoice->user_id = $invoice_users;
		    		$new_invoice->type    = 1; // invoice
		    		$new_invoice->ip 		= $_SERVER['REMOTE_ADDR'];
					// Отключаем селсфлов (в файлах платежек), для будущих инвойсов
		    		$new_invoice->automatically = 0;
		    		$new_invoice->sended = 0;
		    		if(!empty($new_invoice->date_due))
		    			unset($new_invoice->date_due);

					$creation_date = date_create($inv->date_for_payment);

					date_sub($creation_date, date_interval_create_from_date_string('2 days'));
					if($k != 0)
						$new_invoice->date = $creation_date->format('Y-m-d');
					else
					{
						if(!empty($reverv) && $reverv->sp_type == 1) // extention
				    	{
				    		$new_invoice->date_due = $reverv->arrive;
				    	}
					}

					$new_invoice->date_from = date('Y-m-d', strtotime($inv->date_from));
		    		$new_invoice->date_to = date('Y-m-d', strtotime($inv->date_to));
			    	$new_invoice->date_due = date('Y-m-d', strtotime($inv->date_for_payment));
					
					if(!empty($last_invoice_id) && !empty($new_sku))
					{
						$last_invoice_id = ++$last_invoice_id;
		    			$new_invoice->sku = $new_sku.'-'.str_pad($last_invoice_id, 4, "0", STR_PAD_LEFT);
					}

					$new_invoice_id = $this->orders->add_order($new_invoice);

					if(count($invoice_users) > 1)
						$template_tenants = count($invoice_users).' tenants';
					else 
						$template_tenants = count($invoice_users).' tenant';
						
					if($c->type == 3 && !empty($apartment))
						$pur_name = $apartment->name.' - '.$c->rental_name.' - Outpost Club from '.date('d F, Y', strtotime($inv->date_from)).' and to '.date('d F, Y', strtotime($inv->date_to));
					else
						$pur_name = $template_tenants.' at '.$room_type.' - '.$c->rental_name.' - Outpost Club from '.date('d F, Y', strtotime($inv->date_from)).' and to '.date('d F, Y', strtotime($inv->date_to));

					$inv_price = $inv->price;

			    	if($c->house_id == 334)
			 		{
			 			if($inv->interval <= 28)
		 					$utility_price = ceil(((75 * 12) / 365) * $inv->interval);
		 				else
		 					$utility_price = 75;
			 			$utility_pur = 'Utility Allowance Fee* (electricity, gas, where applicable, WiFi, water)';
			 		}
			 		else
			 		{
			 			if($inv->interval <= 28)
		 					$utility_price = ceil(((50 * 12) / 365) * $inv->interval);
		 				else
		 					$utility_price = 50;

		 				$inv_price = $inv_price - $utility_price;
			 			$utility_pur = 'Utility Allowance Fee* (electricity, gas, where applicable, WiFi, water)';
			 		}

	    			$this->orders->add_purchase(array('order_id'=>$new_invoice_id, 'variant_id'=>0, 'product_name'=>$pur_name, 'price'=>$inv_price));
				    $this->orders->add_purchase(array('order_id'=>$new_invoice_id, 'variant_id'=>0, 'product_name'=>$utility_pur, 'price'=>$utility_price));

					// echo 'Added invoice #'.$new_invoice_id.'<br>';

    			}
			}
			if(!empty($c->old_invoices))
				foreach($c->old_invoices as $c_o_s)
					$this->orders->update_order($c_o_s->id, array('status'=>3));

			$this->contracts->update_contract($c->id, array('invoice_recreate'=>1));
			echo 'Updated booking #'.$c->reserv_id.'<br>';
		}


		// +    Выхватить все активные контракты у которых дата окончания позже 1 июня
		// + выхватить их будущие ордеры у которых дата начала позже 1 мая
		// откенселить эти ордеры
		// + понять даты с которой нужно начать создание первого инвойса (первый инвойс будет обрезан по конец этого месяца и смотреть до какого числа человек уже оплатил (запендил) и тогда резать по томк числу)
		// + сделать им калькулейт новой функцией с даты начала будущего ордера 
		// + если это первый инвойс контракты, то оставить его месячным (если у контракта есть оплаченые или предыдущие месяцы или же если дата инвойса текущего не совпадает с датой начала контракта)
		// + если второй и т.д. - обрезаем до 30-31-го числа и дата выставления первое число месяца
		// + создать эти инвойсы



	}
}


$test = new Test();
$test->fetch();
