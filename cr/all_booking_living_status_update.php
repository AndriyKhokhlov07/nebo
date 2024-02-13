<?php
//ini_set('error_reporting', E_ALL);


session_start();

chdir('..');
require_once('api/Backend.php');



class Init extends Backend
{
	function fetch()
	{

		$bookings = $this->beds->get_bookings();

		$today = date('Y-m-d');

		if(!empty($bookings))
		{
			$salesflows_ = $this->salesflows->get_salesflows(['booking_id'=>array_keys($bookings)]);
			foreach($salesflows_ as $s)
			{
				$salesflows[$s->booking_id][] = $s;  
			}

			foreach($bookings as $b)
			{
				foreach ($salesflows[$b->id] as $bs) 
				{
					if(!empty($bs->application_data))
					{
						$bs->application_data = unserialize($bs->application_data);
						if(!empty($bs->application_data))
							$b->living_status = 1; // pending
					}

					if($bs->approve == 1 && ($b->status == 2 || $b->status == 3))
						$b->living_status = 2; // approved
					elseif($bs->approve == 1)
						$b->living_status = 1; // pending
				}

				if(($b->arrive <= $today && $b->depart >= $today) && $b->status > 1)
					$b->living_status = 3; // guests

				if($b->depart < $today)
					$b->living_status = 4; // alumni

				if($b->status == 0)
					$b->living_status = 6; // canceled

				print_r($b);

echo '
';
				$this->beds->update_booking($b->id, ['living_status'=>$b->living_status]);
			}


			echo '
			Updated '.count($bookings).' bookings';
			exit;
		}




		// if(isset($filter['salesflow_status']))
		// {
		// 	// $salesflow_status_select = $this->db->placehold(' LEFT JOIN __salesflows s ON s.booking_id=b.id AND (s.application_data IS NOT NULL OR s.approve = 1)');

		// 	$salesflow_status_select = $this->db->placehold(' LEFT JOIN __salesflows s ON s.id = 
		// 		(SELECT ss.id 
		// 		FROM __salesflows ss 
		// 		WHERE ss.booking_id = b.id 
		// 			AND (ss.application_data IS NOT NULL OR ss.approve = 1)
		// 		ORDER BY ss.id 
		// 		LIMIT 1)');

		// 	if($filter['salesflow_status'] == 0) // new
		// 	{
		// 		$salesflow_status_filter = $this->db->placehold(' AND b.status = 1 AND s.application_data IS NULL AND s.approve IS NULL');
		// 	}
		// 	elseif($filter['salesflow_status'] == 1) // pending
		// 	{
		// 		$salesflow_status_filter = $this->db->placehold(' AND b.status != 0 AND s.application_data IS NOT NULL AND s.approve = 0');
		// 	}
		// 	elseif($filter['salesflow_status'] == 2) // approved
		// 	{
		// 		$salesflow_status_filter = $this->db->placehold(' AND b.status != 0 AND s.approve = 1 AND b.arrive > ?', date('Y-m-d'));
		// 	}
		// 	elseif($filter['salesflow_status'] == 3) // guest
		// 	{
		// 		$salesflow_status_filter = $this->db->placehold(' AND b.status != 0 AND s.approve = 1 AND (b.arrive<=? AND b.depart>=?)', date('Y-m-d'), date('Y-m-d'));
		// 	}
		// 	elseif($filter['salesflow_status'] == 4) // alumni
		// 	{
		// 		$salesflow_status_filter = $this->db->placehold(' AND b.status != 0 AND s.approve = 1 AND b.depart < ?', date('Y-m-d'));
		// 	}
		// 	elseif($filter['salesflow_status'] == 6) // canceled
		// 	{
		// 		$salesflow_status_filter = $this->db->placehold(' AND b.status = 0');
		// 	}
		// }

	}
}


$init = new Init();
$init->fetch();
