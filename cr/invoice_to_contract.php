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
										u.id, 
										u.status,
										u.name, 
										u.email,
										u.auto_invoice
									FROM __users u
									WHERE u.status=3 AND u.auto_invoice=0
									ORDER BY u.id 
									LIMIT 100");

		$this->db->query($query);
		$users_ = $this->db->results();

		if(!empty($users_))
		{
			$users_contracts = array();
			$users_ids = array();

			foreach ($users_ as $u) 
			{
				$users[$u->id] = $u;
				$this->users->update_user($u->id, array('auto_invoice'=>1));
				$users_ids[] = $u->id;
			}

			$user_id_filter = $this->db->placehold('AND c.user_id in(?@)', (array)$users_ids);

			$query = $this->db->placehold("SELECT 
							c.id, 
							c.url,
							c.type,
							c.user_id,
							c.reserv_id,
							c.house_id,
							c.rental_name,
							c.rental_address,
							c.date_from,
							c.date_to,
							c.price_month,
							c.price_deposit,
							c.split_deposit,
							c.membership,
							c.signing,
							c.date_signing,
							c.date_created,
							c.date_viewed,
							c.roomtype,
							c.room_type,
							c.link1_type,
							c.note1,
							c.sellflow,
							c.status
						FROM __contracts AS c
						WHERE 1
							$user_id_filter
							AND c.status=1
							AND c.signing=1
							AND c.date_signing < '2020-01-31 00:00:00'
							AND c.date_to > '2020-06-01 00:00:00'
						ORDER BY c.id DESC
						");
			$this->db->query($query);	

			$users_contracts = $this->db->results();


			$n = 0;
			foreach($users_contracts as $uc)
			{
				$n++;

				// Calculate monthly payments
				$contract_calculate = $this->contracts->calculate($uc->date_from, $uc->date_to, $uc->price_month);
				if(!empty($contract_calculate))
				{
					$uc->invoices = $contract_calculate->invoices;
				}

				$new_invoice = new stdClass;
				$new_invoice->contract_id = $uc->id;
				$new_invoice->user_id = $uc->user_id;
	    		$new_invoice->email   = $users[$uc->user_id]->email;
	    		$new_invoice->type    = 1; // invoice
	    		$new_invoice->ip 		= $_SERVER['REMOTE_ADDR'];
	    		$new_invoice->name 	= $users[$uc->user_id]->name;
	    		$new_invoice->automatically = 0;
	    		$new_invoice->sended = 0;

				if(!empty($uc->roomtype))
		    		$room_type = $uc->roomtype->name;
				elseif($uc->room_type==1)
					$room_type = '2-people room';
				elseif ($uc->room_type==2)
					$room_type = '3-people room';
				elseif ($uc->room_type==3)
					$room_type = '4-people room';
				elseif ($uc->room_type==4)
					$room_type = '3-people shared room';
				elseif ($uc->room_type==5)
					$room_type = '4-people shared room';
				elseif ($uc->room_type==6)
					$room_type = 'Private room';
				elseif ($uc->room_type==7)
					$room_type = 'Private room with bathroom';

				//Создание всех инвойсов для пользователя 
				foreach ($uc->invoices as $k=>$inv) 
				{
					if(strtotime($inv->date_from) >= strtotime('2020-06-01 00:00:00'))
					{
						$creation_date = date_create($inv->date_from);
						date_sub($creation_date, date_interval_create_from_date_string('10 days'));
						if($k != 0)
							$new_invoice->date = $creation_date->format('Y-m-d');

						$new_invoice->date_from = date('Y-m-d', strtotime($inv->date_from));
			    		$new_invoice->date_to = date('Y-m-d', strtotime($inv->date_to));

						if(!isset($inv->interval) || $inv->interval > 5)
						{
							$new_invoice_id = $this->orders->add_order($new_invoice);
						}

						$pur_name = '1 tenant at '.$room_type.' - '.$uc->rental_name.' - Outpost Club from '.date('d F Y', strtotime($inv->date_from)).' and to '.date('d F Y', strtotime($inv->date_to));

		    			$this->orders->add_purchase(array('order_id'=>$new_invoice_id, 'variant_id'=>0, 'product_name'=>$pur_name, 'price'=>$inv->price, 1));

						echo $n.'. User #'.$uc->user_id.' => add invoice #'.$new_invoice_id.' to contract #'.$uc->id.'<br>';

					}
					
	    		}


			}	
		}
		else{
			echo 'no users more';
		}



	}
}


$test = new Test();
$test->fetch();
