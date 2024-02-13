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
				b.id,
				b.status,
				b.arrive,
				b.depart,
				b.sp_group_id,
				b.client_type_id
			FROM __bookings b
			LEFT JOIN __orders AS o ON o.booking_id=b.id
			WHERE 
				(b.status!=0 AND b.status!=5 AND b.status!=6)
				AND b.client_type_id!=5
				AND b.arrive>'2022-12-31'
				AND (b.sp_group_id=b.id || b.sp_group_id IS NULL)
				AND (o.id=0 OR o.id IS NULL)
			GROUP BY b.id
		");

		$this->db->query($query);


		$bookings = $this->db->results();

		if(!empty($bookings))
		{
			header("Content-type: text/html; charset=UTF-8");

			$bookings_statuses = $this->beds->bookings_statuses;

			echo '<table border=1 cellpadding=5>';

				echo '<tr>';
					echo '<td>n</td>';
					echo '<td>Booking ID</td>';
					echo '<td>Status</td>';
					echo '<td>Client Type</td>';
					echo '<td>Arrive</td>';
					echo '<td>Depart</td>';
				echo '</tr>';

				$n=0;
				foreach($bookings as $b)
				{
					$n++;
					echo '<tr>';
						echo '<td>'.$n.'</td>';
						echo '<td><a href="'.$this->config->root_url.'/backend/?module=BedAdmin&item='.$b->id.'" target="_blank">'.$b->id.'</a></td>';
						echo '<td>'.$bookings_statuses[$b->status]['name'].'</td>';
						echo '<td>'.$this->users->get_client_type($b->client_type_id).'</td>';
						echo '<td>'.$b->arrive.'</td>';
						echo '<td>';
						if(is_null($b->sp_group_id))
							echo $b->depart;
						else
							echo '...';
						echo '</td>';
					echo '</tr>';
				}
			echo '</table>';
		}

		
	}
}


$init = new Init();
$init->fetch();
