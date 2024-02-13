<?php
ini_set('error_reporting', E_ALL);


session_start();

chdir('..');
require_once('api/Backend.php');



class Test extends Backend
{
	function fetch()
	{
		
		$bookings = $this->beds->get_bookings([
            'house_id' => 366,
            'not_status' => [0, 5],
            'sp_group' => true,
            'sp_group_from_start' => true,
            'select_users' => true,
            'order_by' => 'b.arrive'
        ]);

        $rooms = $this->beds->get_rooms([
            'house_id' => 366
        ]);
        $rooms = $this->request->array_to_key($rooms, 'id');
        
        $beds = $this->beds->get_beds([
            'room_id' => array_keys($rooms)
        ]);
        $beds = $this->request->array_to_key($beds, 'id');

        // $bookings_types = [];
        // $beds_ids = [];
        // foreach ($bookings as $b) {
        //     // bed
        //     if ($b->type == 1) {
        //         $beds_ids[$b->object_id] = $b->object_id;
        //     }
        //     $bookings_types[$b->type]++;
        // }
        // print_r($bookings_types); exit;

		header("Content-type: text/csv"); 
		header("Content-Disposition: attachment; filename=bookings_cassa.csv"); 
		header("Pragma: no-cache"); 
		header("Expires: 0"); 

		$buffer = fopen('php://output', 'w'); 

		fputs($buffer, chr(0xEF) . chr(0xBB) . chr(0xBF));

        $val = [
            'n' => '',
            'tenant' => 'Tenant',
            'email' => 'Email',
            'arrive' => 'Arrive',
            'depart' => 'Depart',
            'days' => 'Days',
            'room' => 'Room',
            'payout' => 'Payout',
            'price_day' => 'Price day',
            'status' => 'Booking status',
            'client' => 'Client Type'
        ];
        fputcsv($buffer, $val, ';'); 
        
        $n = 0;
        foreach ($bookings as $b) {
            $n++;
            $u = current($b->users);

            $interval = date_diff(date_create($b->arrive), date_create($b->depart));
            $b->night_count = $interval->days;
            $b->days_count = $interval->days + 1;

            $room_name = $rooms[$beds[$b->object_id]->room_id]->name;

            if(substr(trim($room_name), 0, 5) == 'Room ')
                $room_name = substr(trim($room_name), 5);

            $val = [
                'n' => $n,
                'tenant' => $u->first_name.' '.$u->last_name,
                'email' => $u->email,
                'arrive' => $b->arrive,
                'depart' => $b->depart,
                'days' => $b->days_count,
                'room' => $room_name,
                'payout' => $b->total_price * 1,
                'price_day' => $b->price_day * 1,
                'status' => $this->beds->bookings_statuses[$b->status]['name'],
                'client' => $this->users->clients_types[$b->client_type_id]
            ];
            fputcsv($buffer, $val, ';'); 
        }



		fclose($buffer);
		exit;
		
	}
}


$test = new Test();
$test->fetch();
