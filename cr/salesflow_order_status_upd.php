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
										s.id, 
										s.booking_id
									FROM __salesflows s
									ORDER BY s.id 
									");

		$this->db->query($query);
		$salesflows = $this->db->results();


		if(!empty($salesflows))
		{
			$bookings_orders = array();
			$bookings_ids = array();


			foreach ($salesflows as $s) 
			{
				$bookings_ids[] = $s->booking_id;
			}

			if(!empty($bookings_ids))
			{
				$query = $this->db->placehold("SELECT 
							o.id,
							o.booking_id,
							o.status
						FROM __orders AS o
						WHERE 1
							AND o.type = 1
							AND o.status = 1 OR o.status = 2
 							AND o.booking_id in (?@)
						ORDER BY o.id
						", $bookings_ids);

				$this->db->query($query);
				$bookings_orders = $this->db->results();
			}
			$bookings_orders = $this->request->array_to_key($bookings_orders, 'booking_id');

			foreach ($salesflows as $s) 
			{
				if($bookings_orders[$s->booking_id])
				{
					$order = $bookings_orders[$s->booking_id];
					$this->salesflows->update_salesflow($s->id, ['invoice_status'=>$order->status]);
				}	
			}

		}
		else{
			echo 'no salesflows more';
		}



	}
}


$test = new Test();
$test->fetch();
