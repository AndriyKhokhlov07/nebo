<?php
ini_set('error_reporting', E_ALL);


// session_start();

chdir('../../');
require_once('api/Backend.php');



class Init extends Backend {
    function fetch() {


        if ($bookings = $this->beds->get_bookings([
            'house_id' => 307, // The Lafayette House
            'status' => [
                2, // Pending
                3  // Confirmed
            ],
            'date_start_from' => '2021-08-01',
            'sp_group' => true,
            'sp_group_from_start' => true,
            'select_users' => true,
            'limit' => 100
        ])) {
            $bookings_ids = array_keys($bookings);


            if ($salesflows = $this->salesflows->get_salesflows([
                'booking_id' => $bookings_ids
            ])) {
                foreach ($salesflows as $s) {
                    if (isset($bookings[$s->booking_id])) {
                        $bookings[$s->booking_id]->salesflows[$s->id] = $s;
                    }
                }
            }

            print_r($bookings);
        } else {
            echo 'empty bookings';
        }





        /// $calculate = $this->contracts->calculate_hotel($booking->arrive, $booking->depart, $booking->price_night);

        // print_r($booking);
        // print_r($calculate);
    }
}


$init = new Init();
$init->fetch();