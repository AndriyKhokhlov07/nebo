<?php
ini_set('error_reporting', E_ALL);


session_start();

chdir('..');
require_once('api/Backend.php');



class Test extends Backend
{
	function fetch()
	{
		// SKU FIX
		// $orders = $this->orders->get_orders(array('id'=>array('7921', '7922', '7923', '7924', '7925', '7926', '7927', '7928', '7929', '7930', '7931', '7932', '7933', '7934', '7935', '7936', '7937', '7938', '7939', '7940', '7941', '7942', '7943', '7944', '7945', '7946', '7947', '7948', '7949', '7950', '7951', '7952', '7953', '7954', '7955', '7956', '7957', '7958', '7959', '7960', '7961', '7962', '7963', '7964', '7965', '7966', '7967')));

		// if(!empty($orders))
		// {
		// 	foreach ($orders as $o) 
		// 	{
		// 		$bj = current($this->beds->get_bookings(array('id'=>$o->booking_id)));
		// 		$house = $this->pages->get_page((int)$bj->house_id);
		// 		if(!empty($house) && !empty($house->blocks2))
		// 		{
		// 			$house->blocks2 = unserialize($house->blocks2);
		// 			if($house->blocks2['contract_side'] != 0)
		// 			{
		// 				$landlord = $this->users->get_user(intval($house->blocks2['contract_side']));
		// 				$new_invoice_sku = $o->id.'/'.$landlord->landlord_code;
		// 				$this->orders->update_order($o->id, array('sku'=>$new_invoice_sku));
		// 			}
		// 			else
		// 			{
		// 				$this->orders->update_order($o->id, array('sku'=>$o->id));
		// 			}
		// 		}
		// 	}
		// }

		// AIRBNB INVOICES 
		// $query = $this->db->placehold("SELECT 
		// 								b.id, 
		// 								b.price_month,
		// 								b.client_type_id, 
		// 								b.arrive,
		// 								b.depart,
		// 								b.object_id,
		// 								b.type,
		// 								b.house_id,
		// 								u.user_id
		// 							FROM __bookings b
		// 							LEFT JOIN __bookings_users u ON u.booking_id = b.id
		// 							WHERE b.client_type_id = 2 AND b.status != 0 AND b.due IS NULL AND b.depart > NOW()
		// 							ORDER BY b.id 
		// 							LIMIT 100");

		// $this->db->query($query);
		// $bookings_ = $this->db->results();

		// if(!empty($bookings_))
		// {
		// 	foreach ($bookings_ as $bj) 
		// 	{
		// 		echo "booking #".$bj->id.' updated';
		// 		if($bj->client_type_id == 2) // Coliving, Airbnb
		// 		{
		// 			// Create invoices
		// 			if(!empty($bj->price_month))
		// 			{
		// 				$invoces_calculate = $this->contracts->calculate($bj->arrive, $bj->depart, $bj->price_month);

		// 				if(!empty($invoces_calculate))
		// 				{
		// 					if(count($invoces_calculate->invoices) >= 1)
		// 					{
		// 						// Not create first invoce
		// 						// unset($invoces_calculate->invoices[0]);

		// 						$new_invoice = new stdClass;
		// 						$new_invoice->booking_id = $bj->id;
		// 						$new_invoice->user_id   = $bj->user_id;
		// 						$new_invoice->type    = 1; // invoice
		// 						$new_invoice->ip 	= $_SERVER['REMOTE_ADDR'];
								
		// 						// Отключаем селсфлов (в файлах платежек), для будущих инвойсов
		// 						$new_invoice->automatically = 0;
		// 						$new_invoice->sended = 0;

		// 						// Room type
		// 						$room_type_name = '';

		// 						if($bj->type == 1) // bed booking
		// 						{
		// 							$room_type = $this->beds->get_rooms_types(array(
		// 								'bed_id' => $bj->object_id,
		// 								'limit' => 1
		// 							));
		// 						}
								
		// 						if(!empty($room_type))
		// 						{
		// 							$room_type_name = trim($room_type->name);

		// 							$rt_str_end = 'room';
		// 							if(substr($room_type_name, strlen($room_type_name) - strlen($rt_str_end)) != $rt_str_end)
		// 								$room_type_name = 'Private room ('.$room_type_name.')';

		// 							$room_type_name .= ' - ';
		// 						}

								

		// 						// House
		// 						$house = $this->pages->get_page((int)$bj->house_id);
		// 						if(!empty($house) && !empty($house->blocks2))
		// 						{
		// 							$house->blocks2 = unserialize($house->blocks2);
		// 							if($house->blocks2['contract_side'] != 0)
		// 								$landlord = $this->users->get_user(intval($house->blocks2['contract_side']));
		// 						}

		// 						// Create invoices
		// 						foreach($invoces_calculate->invoices as $k=>$inv) 
		// 						{
		// 							if($inv->date_from >= '2020-11-01')
		// 							{
		// 								$new_invoice->user_id = $bj->user_id;
		// 								if($k == 1)
		// 								{
		// 									$this->beds->update_booking($bj->id, array('due'=>$inv->date_from));
		// 								}

		// 								$creation_date = date_create($inv->date_from);
		// 								date_sub($creation_date, date_interval_create_from_date_string('10 days'));
		// 								$new_invoice->date = $creation_date->format('Y-m-d');

		// 				    			$new_invoice->date_from = $inv->date_from;
		// 				    			$new_invoice->date_to = $inv->date_to;

		// 				    			if(!isset($inv->interval) || $inv->interval > 5)
		// 								{
		// 									$new_invoice_id = $this->orders->add_order($new_invoice);

		// 									if($bj->client_type_id == 2)
		// 										$this->orders->add_order_labels($new_invoice_id, 8); // airbnb
		// 									else
		// 										$this->orders->add_order_labels($new_invoice_id, 9); // coliving

		// 									if(!empty($landlord) && !empty($landlord->landlord_code))
		// 									{
		// 										$new_invoice_sku = $new_invoice_id.'/'.$landlord->landlord_code;
		// 										$this->orders->update_order($new_invoice_id, array('sku'=>$new_invoice_sku));
		// 									}
		// 								}

		// 								$pur_name = '1 tenant at '.$room_type_name.$house->name.' - Outpost Club from '.date('M j, Y', strtotime($inv->date_from)).' and to '.date('M j, Y', strtotime($inv->date_to));

		// 					    			$this->orders->add_purchase(array('order_id'=>$new_invoice_id, 'variant_id'=>0, 'product_name'=>$pur_name, 'price'=>$inv->price, 1));
		// 							}

		// 						}

		// 					}

		// 				}

						
		// 			}

		// 		}	
		// 	}

		// }
		// else{
		// 	echo 'no users more';
		// }



	}
}


$test = new Test();
$test->fetch();
