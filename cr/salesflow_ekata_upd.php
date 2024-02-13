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
										s.ekata_status,
										s.ekata_upd
									FROM __salesflows s
									WHERE s.ekata_upd = 0
									ORDER BY s.id 
									");

		$this->db->query($query);
		$salesflows = $this->db->results();


		if(!empty($salesflows))
		{
			foreach ($salesflows as $salesflow) 
			{
				if(!empty($salesflow->ekata_status))
					$salesflow->ekata_status = unserialize($salesflow->ekata_status);
				if(!empty($salesflow->ekata_status))
				{
					if(isset($salesflow->ekata_status['ekata_network_score']) || isset($salesflow->ekata_status['ekata_check_score']))
					{
						if(isset($salesflow->ekata_status['ekata_network_score']))
						{
							$salesflow_ekata = $this->ekata->get_status(array(
								'type' => 'identity_network_score',
								'value' => $salesflow->ekata_status['ekata_network_score']
							));
						}

						if(isset($salesflow->ekata_status['ekata_check_score']))
						{
							$ekata_check_status = $this->ekata->get_status(array(
								'type' => 'identity_check_score',
								'value' => $salesflow->ekata_status['ekata_check_score']
							));
							if(!isset($salesflow_ekata) || (isset($salesflow_ekata) && $ekata_check_status->code > $salesflow_ekata->code))
								$salesflow_ekata = $ekata_check_status;
						}

						$salesflow->ekata_status['check_score_code'] = $salesflow_ekata->code;
					}
				}
				print_r($salesflow->ekata_status);
				$this->salesflows->update_salesflow($salesflow->id, ['ekata_status'=>serialize($salesflow->ekata_status), 'ekata_upd'=>1]);
			}
		}
		else{
			echo 'no salesflows more';
		}



	}
}


$test = new Test();
$test->fetch();
