<?php
ini_set('error_reporting', E_ALL);


// session_start();

chdir('../../');
require_once('api/Backend.php');



class Init extends Backend
{
	function fetch()
	{
        $selected_house_id = $this->request->get('house_id', 'integer');
        $month_year = $this->request->get('month', 'string');

        $strtotime_now = strtotime('now');
        if (!empty($month_year)) {
            list($month, $year) = explode('-', $month_year);
        } else {
            $month = date("m", $strtotime_now);
            $year = date("Y", $strtotime_now);
        }


        $stats = $this->house_stats->getStats([
            'house_id' => $selected_house_id,
            'month' => $month,
            'year' => $year,
            'view' => 'backend'
        ]);

        if (!empty($stats->stats->managers)) {
            echo '<table>';
            echo '<tr><td>Manager</td><td>New</td><td>Ext</td></tr>';
            foreach($stats->stats->managers as $manager_login=>$b) {
                echo '<tr><td>'.$manager_login.'</td><td>'.$b->new.'</td><td>'.$b->ext.'</td></tr>';
            }
            echo '</table>';
        }




	}
}


$init = new Init();
$init->fetch();
