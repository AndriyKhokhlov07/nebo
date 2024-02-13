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
										s.booking_id,
										s.contract_status
									FROM __salesflows s
									ORDER BY s.id 
									");

		$this->db->query($query);
		$salesflows = $this->db->results();


		if(!empty($salesflows))
		{
			$bookings_contracts = array();
			$bookings_ids = array();

			foreach ($salesflows as $s) 
			{
				$bookings_ids[] = $s->booking_id;
			}

			if(!empty($bookings_ids))
			{
				$query = $this->db->placehold("SELECT 
							c.id,
							c.reserv_id,
							c.status,
							c.signing
						FROM __contracts AS c
						WHERE 1
							AND c.status = 1 OR c.status = 2
 							AND c.reserv_id in (?@)
						", $bookings_ids);

				$this->db->query($query);
				$bookings_contracts = $this->db->results();
			}
			$bookings_contracts = $this->request->array_to_key($bookings_contracts, 'reserv_id');

			foreach ($salesflows as $s) 
			{
				if($bookings_contracts[$s->booking_id])
				{
					$contract = $bookings_contracts[$s->booking_id];
					if(empty($contract->signing))
					{
						$contract->signing = 0;
					}
					if($contract->signing != $s->contract_status)
					{
						$this->salesflows->update_salesflow($s->id, ['contract_status'=>$contract->signing]);
						echo $s->id . '  /  old - ' . $s->contract_status . ' new - ' . $contract->signing . '
						'; 
					}
				}	

			}
		}
		else
		{
			echo 'no salesflows more';
		}



	}
}


$test = new Test();
$test->fetch();
