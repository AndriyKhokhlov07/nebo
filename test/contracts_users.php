<?php
ini_set('error_reporting', E_ALL);


session_start();

chdir('../');
require_once('api/Backend.php');



class Init extends Backend
{
	function fetch()
	{

		/*
		$bookings = $this->beds->get_bookings(array(
			'limit' => 2000
		));
		*/


		$query = $this->db->placehold("SELECT c.id, c.user_id FROM __contracts c");
		$this->db->query($query);
		$contracts = $this->db->results();


		if(!empty($contracts))
		{
			$n = 0;
			$n_upd = 0;
			foreach($contracts as $contract)
			{
				$n++;
				echo $n.'. ';
				echo 'Contract:'.$contract->id;
				echo '  User:'.$contract->user_id;


				if($this->contracts->add_contract_user($contract->id, $contract->user_id))
				{
					$n_upd++;
					echo ' [added]';
				}


				echo '<br>';
			}
			echo '<br>-------------------------------<br>';
			echo 'Total: '.$n.'<br>';
			echo 'Total added: '.$n_upd;
		}

	}
}


$init = new Init();
$init->fetch();
