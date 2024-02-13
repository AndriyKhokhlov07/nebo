<?PHP


 
require_once('view/View.php');

class LandlordView extends View
{
	function fetch()
	{
		if(empty($this->user))
		{
			header("HTTP/1.1 301 Moved Permanently"); 
			header('Location: '.$this->config->root_url.'/user/login');
			exit();
		}

		header("HTTP/1.1 301 Moved Permanently"); 
		header('Location: '.$this->config->root_url.'/landlord/tenants/');
		exit();

		$landlord = new stdClass;

		if(!empty($this->user->email))
		{
			if(!empty($this->user->main_info))
				$landlord->main_info = $this->user->main_info;

			$users = array();
			$invoices = array();
			$houses = array();

			$houses_ids = $this->users->get_landlords_houses(array('user_id'=>$this->user->id));

			foreach ($houses_ids as $h_id) 
			{
				$houses[$h_id->house_id] = $this->pages->get_page(intval($h_id->house_id));
			}

			if(!empty($houses))
			{
				foreach ($houses as $house) 
				{
					if(!empty($house->blocks2))
						$house->blocks2 = unserialize($house->blocks2);

					$users_ = array();
					$users_ = $this->users->get_users(array('house_id'=>$house->id, 'sort'=>'inquiry_depart'));

					if(!empty($users_))
					{
						foreach ($users_ as $u) 
						{
							$u->contracts = "";
							$u->contracts = $this->contracts->get_contracts(array('user_id'=>$u->id, 'status'=>1, 'house_id'=>$house->id));

							$contracts_ids = array();
							foreach ($u->contracts as $u_c) 
							{
								$contracts_ids[] = $u_c->id;
							}



							$u_orders = $this->orders->get_orders(array('user_id'=>$u->id, 'status'=>array(0,1,2,4), 'type'=>1, 'contract_id'=>$contracts_ids));
							$invoices = array();
							foreach($u_orders as $o)
							{
								$invoices[$o->id] = $o;
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
							}
							$u->invoices = $invoices;

							$u->bed_journal = "";
							if(!empty($u->active_booking_id))
							$u->bed_journal = $this->beds->get_bookings(array('id'=>$u->active_booking_id, 'limit'=>1));

							if($u->status==3)
								$house->guests[$u->id] = $u;
							elseif($u->status==4 || $u->status==6)
								$house->archive[$u->id] = $u;
							elseif($u->status==1 || $u->status==2)
							{
								$house->future[$u->inquiry_arrive][$u->id] = $u;

							}
						}
						ksort($house->future);
						// foreach ($house_future as $hf) {
						// 	foreach ($hf as $u) {
						// 		$house->future[] = $u;
						// 	}
						// }
					}

				}


			}


		}


		$this->design->assign('landlord', $landlord);
		$this->design->assign('houses', $houses);

		return $this->design->fetch('landlord.tpl');
	}
}
