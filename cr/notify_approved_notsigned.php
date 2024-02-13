<?php
ini_set('error_reporting', 0);


chdir('..');
require_once('api/Backend.php');



class Init extends Backend {
	function fetch() {

        // hours after approve
        $hours = 48;

        $log_value  = 'Email notification sent: 24 hours notification after 2 sales flow starts (Approve contract)';

        $br = '
 ';


        $this->design->assign('config', $this->config);
        $this->design->assign('settings',	$this->settings);
        $managers = $this->managers->get_managers();

        $query = $this->db->placehold("SELECT
                b.id
            FROM __bookings b
            LEFT JOIN __salesflows s ON s.booking_id=b.id
            LEFT JOIN __logs l ON l.parent_id=s.id
            WHERE
                b.status=1
                AND s.approve=1
                AND s.contract_status=0
                AND l.type=13
                AND l.subtype=1
                AND l.date<=?
            GROUP BY b.id
        ", date("Y-m-d H:i:s", time() - (3600 * $hours)));

        $this->db->query($query);
        $b = $this->db->results();

        if (empty($b)) {
            exit;
        }

        $booking_ids = array_keys($this->request->array_to_key($b, 'id'));

        $bookings = $this->beds->get_bookings([
            'id' => $booking_ids,
            'sp_group' => true,
            'select_users' => true,
            // 'sp_group_from_start' => true,
            // 'print_query' => 1
        ]);

        if (!empty($bookings)) {
            $bookings_ids = array_keys($bookings);

            $bookings_users = [];
            $sent_tenant_n = 0;
            $sent_manager_n = 0;
            foreach ($bookings as $b) {
                $booking_user_id = 0;
                if (is_array($b->users)) {
                    $booking_user = current($b->users);
                    $booking_user_id = $booking_user->id;
                    $bookings_users[$b->id] = $booking_user_id;


                    $b->users_names = [];
                    foreach($b->users as $user) {
                        if (!empty($user->email)) {
                            if ($user->block_notifies != 1) {
                                // Send Email notification to client
                                $this->design->assign('user', $user);
                                $email_template = $this->design->fetch($this->config->root_dir.'design/'.$this->settings->theme.'/html/email/salesflow2_24hours.tpl');
                                $subject = $this->design->get_var('subject');
                                $this->notify->email($user->email, $subject, $email_template, $this->settings->notify_from_email);

                                // Tenant: Add log
                                $log_value2 = $br.'Booking: #'.$b->id;
                                $this->logs->add_log([
                                    'parent_id' => $b->id,
                                    'type' => 2, // Tenant
                                    'subtype' => 13, // Notification
                                    'user_id' => $user->id,
                                    'sender_type' => 1,
                                    'value' => $log_value.$log_value2
                                ]);

                                $sent_tenant_n++;
                                echo $sent_tenant_n.') Tenant: #'.$user->id.' - '.$user->email.' Booking  #'.$b->id.'<br>';
                            }

                            $user_name = $user->first_name;
                            if (!empty($user->middle_name)) {
                                $user_name .= ' '.$user->middle_name;
                            }
                            if (!empty($user->last_name)) {
                                $user_name .= ' '.$user->last_name;
                            }
                            if (empty($user_name)) {
                                $user_name = $user->name;
                            }
                            $b->users_names[$user->id] = $user_name;
                            $user->full_name = $user_name;
                        }
                    }
                    if (!empty($b->manager_login) && isset($managers[$b->manager_login])) {
                        if (!empty($managers[$b->manager_login]->email)) {
                            $this->design->assign('manager', $managers[$b->manager_login]);
                            $this->design->assign('booking', $b);

                            // Send Email notification to manager
                            $email_template = $this->design->fetch($this->config->root_dir.'backend/design/html/email/salesflow2_24hours.tpl');
                            $subject = $this->design->get_var('subject');
                            $this->notify->email($managers[$b->manager_login]->email, $subject, $email_template, $this->settings->notify_from_email);

                            $sent_manager_n++;
                            echo $sent_manager_n.') Manager: '.$b->manager_login.' Booking  #'.$b->id.'<br>';
                        }
                    }
                    echo '-------------------------<br>';
                }

                // Booking: Add log
                $this->logs->add_log(array(
                    'parent_id' => $b->id,
                    'type' => 1, // Booking
                    'subtype' => 13, // Notification
                    'user_id' => $booking_user_id,
                    'sender_type' => 1,
                    'value' => $log_value
                ));
            }

            // Contracts
            $contracts = $this->contracts->get_contracts([
                'reserv_id' => $bookings_ids,
                'status' => 1, // Active
                'limit' => 10000
            ]);
            if (!empty($contracts)) {
                foreach ($contracts as $contract) {
                    // Contract: Add log
                    $this->logs->add_log(array(
                        'parent_id' => $contract->id,
                        'type' => 4, // Contracts
                        'subtype' => 14, // Notification
                        'user_id' => $bookings_users[$contract->reserv_id],
                        'sender_type' => 1, // System
                        'value' => $log_value
                    ));
                }
            }

        }

	}
}


$init = new Init();
$init->fetch();
