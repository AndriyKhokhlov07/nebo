<?php
ini_set('error_reporting', 0);


chdir('..');
require_once('api/Backend.php');



class Init extends Backend {
	function fetch() {

        // hours after create booking
        $hours = 72;

        $br = '
 ';

        $bookings = $this->beds->get_bookings([
            'status' => 1, // New
            'client_type_id' => 1, // Tenant: Outpost
            'created_to' => date("Y-m-d H:i:s", time() - (3600 * $hours)),
            'sp_group' => true,
            'select_users' => true,
            // 'sp_group_from_start' => true,
            // 'print_query' => 1
        ]);

        if (!empty($bookings)) {
            $bookings_ids = array_keys($bookings);


            $invoices_application_fee = $this->orders->get_orders([
                'booking_id' => $bookings_ids,
                'type' => 7, // Application Fee
                'status' => 2, // Paid
                'paid' => 1,
            ]);

            if (!empty($invoices_application_fee)) {
                foreach ($invoices_application_fee as $i) {
                    if (!empty($i->booking_id) &&  isset($bookings[$i->booking_id])) {
                        unset($bookings[$i->booking_id]);
                    }
                }
            }

            if (!empty($bookings)) {
                $canceled_n = 0;
                $cancel_bookings_ids = [];
                $bookings_users = [];
                foreach ($bookings as $b) {
                    $cancel_bookings_ids[$b->id] = $b->id;
                    if (!empty($b->sp_bookings_ids)) {
                        foreach($b->sp_bookings_ids as $sb_id) {
                            $cancel_bookings_ids[$sb_id] = $sb_id;
                        }
                    }
                    $canceled_n ++;

                    $booking_user_id = 0;
                    if (is_array($b->users)) {
                        $booking_user = current($b->users);
                        $booking_user_id = $booking_user->id;
                        $bookings_users[$b->id] = $booking_user_id;
                    }


                    // Add log

                    $log_value  = 'Booking status: '.$this->beds->get_booking_status($b->status).' &rarr; '.$this->beds->get_booking_status(0);
                    $log_value  .= $br.'Living status: '.$this->beds->bookings_living_statuses[$b->living_status]['name'].' &rarr; '.$this->beds->bookings_living_statuses[6]['name'];
                    $log_value .= $br.'System note: Application Fee not paid within '.$hours.' hours';

                    $this->logs->add_log(array(
                        'parent_id' => $b->id,
                        'type' => 1,
                        'subtype' => 2, // Change status
                        'user_id' => $booking_user_id,
                        'sender_type' => 1,
                        'value' => $log_value
                    ));

                    echo $canceled_n.') '.$b->id.'<br>';
                }


                if (!empty($cancel_bookings_ids)) {

                    // Cancel bookings
                    $this->beds->update_booking($cancel_bookings_ids, [
                        'status' => 0, // Cancel
                        'living_status' => 6, // Canceled
                    ]);

                    // Cancel Contracts
                    $contracts = $this->contracts->get_contracts([
                        'reserv_id' => $cancel_bookings_ids,
                        'status' => 1 // Active
                    ]);
                    if (!empty($contracts)) {
                        // Cancel
                        $query = $this->db->placehold("UPDATE __contracts SET ?% WHERE id in (?@) LIMIT ?",
                            ['status' => 9],
                            array_keys($contracts),
                            count($contracts)
                        );
                        $this->db->query($query);

                        foreach ($contracts as $contract) {
                            // log
                            $log_value  = 'Contract status: Active &rarr; Canceled';
                            $this->logs->add_log(array(
                                'parent_id' => $contract->id,
                                'type' => 4, // Contracts
                                'subtype' => 5, // Change status
                                'user_id' => $bookings_users[$contract->reserv_id],
                                'sender_type' => 1, // System
                                'value' => $log_value
                            ));
                        }
                    }

                    // Cancel Invoices
                    $invoices = $this->orders->get_orders(array(
                        'booking_id' => $cancel_bookings_ids,
                        'type' => 1, // invoices
                        'status' => 0, // new invoices
                        'paid' => 0
                    ));
                    if(!empty($invoices)) {
                        foreach($invoices as $invoice) {
                            $this->orders->update_order($invoice->id, [
                                'status' => 3 // cancel
                            ]);
                            // log
                            $log_value  = 'Invoice status: '.$this->orders->get_status($invoice->status).' &rarr; '.$this->orders->get_status(3);
                            $this->logs->add_log(array(
                                'parent_id' => $invoice->id,
                                'type' => 3, // Invoices
                                'subtype' => 4, // Change status
                                'user_id' => $bookings_users[$invoice->booking_id],
                                'sender_type' => 1, // System
                                'value' => $log_value
                            ));
                        }
                    }
                }
            }

        }

	}
}


$init = new Init();
$init->fetch();
