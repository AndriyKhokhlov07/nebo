<?php
ini_set('error_reporting', E_ALL);


// session_start();

chdir('../../');
require_once('api/Backend.php');



class Init extends Backend
{
	function fetch()
	{
		$query = $this->db->placehold("SELECT 
					o.id
				FROM __orders o
				LEFT JOIN __bookings AS b ON o.booking_id=b.id
				LEFT JOIN __orders_labels AS ol ON o.id=ol.order_id AND ol.label_id=8
				WHERE
					b.client_type_id=2 OR ol.label_id=8
				GROUP BY o.id
				ORDER BY o.date_from, o.id
		");
		$this->db->query($query);

		if(!empty($invoices = $this->db->results())) {

			$invoices = $this->request->array_to_key($invoices, 'id');

			$purchases = $this->orders->get_purchases([
				'order_id' => array_keys($invoices)
			]);
			if(!empty($purchases)) {
				//echo 'purchases count: '.count($purchases).'';
				foreach($purchases as $p) {
					if(isset($invoices[$p->order_id])) {
						$invoices[$p->order_id]->purchases[$p->id] = $p; 
					}
				}
			}

			foreach($invoices as $i) {
				if(!isset($i->purchases)) {
					echo $i->id.' [no purchases]
';
				}
				elseif(count($i->purchases) > 1) {
					echo $i->id.' [purchases '.count($i->purchases).']
';
				}
			}

			//echo 'invoices count: '.count($invoices);
			// print_r($invoices); exit;

		}		
	}
}


$init = new Init();
$init->fetch();
