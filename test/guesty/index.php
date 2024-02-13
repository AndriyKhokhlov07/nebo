<?php
ini_set('error_reporting', E_ALL);


session_start();

chdir('../../');
require_once('api/Backend.php');



class Init extends Backend
{
    function fetch() {


//        $g = $this->guesty->get_webhooks();
//        print_r($g);
        $this->prebookings->params->prebookings_on_page = 1000;
        $prebookings = $this->prebookings->get_prebookings();
        if (!empty($prebookings)) {
            foreach($prebookings as $p) {
                $name = false;
                if (!empty($p->guest_first_name)) {
                    $name = $p->guest_first_name;
                }
                if (!empty($p->guest_last_name)) {
                    if (!empty($name)) {
                        $name .= ' ';
                    }
                    $name .= $p->guest_last_name;
                }
                if ($name) {
                    $this->prebookings->update_prebookings($p->id, [
                        'guest_name' => $name
                    ]);
                }
            }
        }
    }
}


$init = new Init();
$init->fetch();
