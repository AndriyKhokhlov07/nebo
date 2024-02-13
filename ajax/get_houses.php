<?php
ini_set('error_reporting', 0);
session_start();

chdir('..');
require_once('api/Backend.php');

class Init extends Backend
{
	function fetch()
	{
        $prices_range = $this->request->get('prices_range', 'boolean');

        $houses = [];
		if($houses = $this->pages->getHouses()) {
            if ($prices_range && $rooms = $this->beds->get_rooms(['visible' => 1, 'limit' => 30000])) {
                foreach ($rooms as $r) {
                    if (isset($houses[$r->house_id])) {
                        if ($r->price1 > 0 && (!isset($houses[$r->house_id]->min_price) || $r->price1 < $houses[$r->house_id]->min_price)) {
                            $houses[$r->house_id]->min_price = $r->price1;
                        }
                        if ($r->price3 > 0 && (!isset($houses[$r->house_id]->max_price) || $r->price3 > $houses[$r->house_id]->max_price)) {
                            $houses[$r->house_id]->max_price = $r->price3;
                        }
                    }
                }
            }
            foreach ($houses as $house) {
                if (!empty($house->blocks2)) {
                    $house->blocks2 = unserialize($house->blocks2);
                }
            }
        }
		header("Content-type: application/json; charset=UTF-8");
		header("Cache-Control: must-revalidate");
		header("Pragma: no-cache");
		header("Expires: -1");
		echo json_encode($houses);
	}
}


$init = new Init();
$init->fetch();



	

