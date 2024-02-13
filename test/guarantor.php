<?php
ini_set('error_reporting', E_ALL);


// session_start();

chdir('../');
require_once('api/Backend.php');



class Init extends Backend
{
	function fetch()
	{


		$query = $this->db->placehold("SELECT
				u.id,
				u.name,
				u.created
			FROM __users u
			LEFT JOIN __orders_users ou ON ou.user_id=u.id
			LEFT JOIN __orders o ON o.id=ou.order_id
			LEFT JOIN __salesflows s ON s.user_id=u.id
			WHERE 
				u.type=6
				AND o.status in(1,2)
			GROUP BY u.id
		");

		$this->db->query($query);

		$guarantors = $this->db->results();
		$guarantors = $this->request->array_to_key($guarantors, 'id');

		if(!empty($guarantors))
		{

			$guarantors_logs = $this->logs->get_logs([
				'user_id' => array_keys($guarantors),
				'type' => [
					// 14,  // User Check
					16  // Guarantor Agreement
				]
			]);

			if(!empty($guarantors_logs))
			{
				foreach($guarantors_logs as $l)
				{
					if(isset($guarantors[$l->user_id]))
						unset($guarantors[$l->user_id]);
				}
			}

			if(!empty($guarantors))
			{
				foreach($guarantors as $g)
				{
					
					echo $g->name.' [id '.$g->id.'] creted '.$g->created;
					/*if($g->id == 9080)
					{
					 	$this->notify->email_guarantor_agreement(intval($g->id));
					 	echo '[sent]';
					}*/
					echo '<br>';
				}
			}

		}
	}
}


$init = new Init();
$init->fetch();
