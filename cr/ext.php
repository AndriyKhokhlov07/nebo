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
                                        *
									FROM __bookings as b
 									WHERE 
                                        b.house_id=349
                                        AND b.parent_id>0
                                        AND b.created>='2022-01-01'
									ORDER BY b.created DESC
									LIMIT 20000");
		$this->db->query($query);
		$bookings = $this->db->results();


        $bookings = $this->request->array_to_key($bookings, 'id');
        $bookings_ids = array_keys($bookings);

        $filter['sp_group_from_start'] = true;

        if(!empty($bookings))
        {
            $sp_group_ids = [];
            foreach($bookings as $k=>$b)
            {
                if(!empty($b->client_type_id) && isset($filter['client_type']))
                    $b->client_type = $this->users->get_client_type($b->client_type_id);

                if(!empty($b->sp_group_id))
                {
                    if(empty($filter['sp_group_from_start']) || $b->sp_group_id == $b->id)
                    {
                        $sp_group_ids[$b->sp_group_id] = $b->sp_group_id;
                    }

                    if(isset($bookings[$b->sp_group_id]))
                    {
                        $bookings[$b->sp_group_id]->sp_bookings[$b->id] = $b;

                        $b->u_depart = strtotime($b->depart);

                        if($b->sp_group_id != $b->id && strtotime($b->depart) > strtotime($bookings[$b->sp_group_id]->depart))
                        {
                            $bookings[$b->sp_group_id]->depart = $b->depart;
                        }
                    }
                    else
                    {
                        // $sp_group_ids[$b->sp_group_id] = $b->sp_group_id;
                    }
                    if(!empty($b->sp_group_id) && $b->sp_group_id != $b->id)
                    {
                        unset($bookings[$b->id]);
                    }
                    $sp_bookings[$b->sp_group_id][$b->id] = $b;


                }
            }

            if(!empty($sp_group_ids))
            {
                $sp_bookings_p_params = [
                    'sp_group_id' => $sp_group_ids
                ];

                if(!empty($filter['is_due']))
                    $sp_bookings_p_params['is_due'] = $filter['is_due'];

                if(!empty($filter['status']))
                    $sp_bookings_p_params['status'] = $filter['status'];

                $sp_bookings_p = $this->beds->get_bookings($sp_bookings_p_params);

                if(!empty($sp_bookings_p))
                {
                    $spbookings = [];
                    $u_today = strtotime('today midnight');
                    foreach($sp_bookings_p as $b)
                    {
                        $b->u_arrive = strtotime($b->arrive);
                        $b->u_depart = strtotime($b->depart);

                        if($b->sp_group_id == $b->id)
                        {
                            foreach($b as $n=>$v)
                            {
                                if(!isset($spbookings[$b->sp_group_id]->$n))
                                    $spbookings[$b->sp_group_id]->$n = $v;
                            }

                        }
                        
                        if(!isset($spbookings[$b->sp_group_id]) || (isset($spbookings[$b->sp_group_id]) && $b->u_depart > $spbookings[$b->sp_group_id]->u_depart))
                        {
                            $spbookings[$b->sp_group_id]->u_depart = $b->u_depart;
                            $spbookings[$b->sp_group_id]->depart = date('Y-m-d', $b->u_depart);
                        }

                        if(!isset($spbookings[$b->sp_group_id]) || (isset($spbookings[$b->sp_group_id]) && $b->u_arrive < $spbookings[$b->sp_group_id]->u_arrive))
                        {
                            $spbookings[$b->sp_group_id]->u_arrive = $b->u_arrive;
                            $spbookings[$b->sp_group_id]->arrive = date('Y-m-d', $b->u_arrive);
                        }


                        if($u_today >= $b->u_arrive && $u_today <= $b->u_depart)
                        {
                            $b->active = 1;
                        }
                        $spbookings[$b->sp_group_id]->sp_bookings_ids[$b->id] = $b->id;
                        $spbookings[$b->sp_group_id]->sp_bookings[$b->id] = $b;
                    }


                    if(!empty($spbookings))
                    {
                        foreach($spbookings as $b_id=>$b)
                        {

                            $bookings[$b_id] = $b;
                        }
                    }

                    unset($sp_bookings_p);
                }
            }
        }







        $query = $this->db->placehold("SELECT 
                                        u.id,
                                        u.first_name,
                                        u.last_name,
                                        bu.booking_id as booking_id
									FROM __users as u
                                    LEFT JOIN __bookings_users bu ON bu.user_id = u.id
 									WHERE 
                                        bu.booking_id in(?@)
									LIMIT 20000", $bookings_ids);

        // echo $query; exit;
		$this->db->query($query);

		$users = $this->db->results();





        // $users = $this->users->get_users([
        //     'booking_id' => $bookings_ids,
        //     'limit' => 10000
        // ]);


        // $bookings = [
        //     1034 => .....,
        //     1045 => ......
        // ];

        if(!empty($users)) {
            foreach($users as $u) {
                // if(isset($bookings[$u->booking_id])) {
                    $bookings[$u->booking_id]->users[$u->id] = $u;
                // }
            }
        }

        // print_r($bookings); exit;






		// $users = $this->request->array_to_key($users, 'id');


		// if(!empty($a_users)) {
		// 	foreach($a_users as $u) {
		// 		if(isset($users[$u->id])) {
		// 			unset($users[$u->id]);
		// 		}
		// 	}
		// }


		// print_r($users); exit;


		header("Content-type: text/csv"); 
		header("Content-Disposition: attachment; filename=file.csv"); 
		header("Pragma: no-cache"); 
		header("Expires: 0"); 

		$buffer = fopen('php://output', 'w'); 

		fputs($buffer, chr(0xEF) . chr(0xBB) . chr(0xBF));

        $val = [
            'id' => 'Booking ID',
            'created' => 'Created',
            'from' => 'Arrive',
            'to' => 'Depart',
            'tenant' => 'Tenants'
        ];
        fputcsv($buffer, $val, ';'); 

        foreach ($bookings as $b) {
            $b->tenant = [];
            if (!empty($b->users)) {
                foreach ($b->users as $u) {
                    $b->tenant[] = $u->first_name.' '.$u->last_name;
                }
            }
            $b->tenant = implode(', ', $b->tenant);

            $val = [
                'id' => $b->id,
                'created' => $b->created,
				'from' => $b->arrive,
                'to' => $b->depart,
                'tenant' => $b->tenant
			];
			fputcsv($buffer, $val, ';'); 
        }
		fclose($buffer);
		exit;
		
	}
}


$test = new Test();
$test->fetch();
