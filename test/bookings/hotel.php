<?php
ini_set('error_reporting', E_ALL);


// session_start();

chdir('../../');
require_once('api/Backend.php');



class Init extends Backend
{
	function fetch()
	{
		$booking = $this->beds->get_bookings([
			'id' => 9695,
			'limit' => 1
		]);

		$calculate = $this->contracts->calculate_hotel($booking->arrive, $booking->depart, $booking->price_night);

		print_r($booking);
		print_r($calculate);
	}
}


$init = new Init();
$init->fetch();
