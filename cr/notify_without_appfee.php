<?php
ini_set('error_reporting', 0);


chdir('..');
require_once('api/Backend.php');



class Init extends Backend {
	function fetch() {

        // hours after create booking
        $hours = 48;
        $log_value  = 'Email notification sent: 24 hours notification after 1 sales flow starts';

        $br = '
 ';
        $this->design->assign('config', $this->config);
        $this->design->assign('settings',	$this->settings);
        $managers = $this->managers->get_managers();

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
                                    $email_template = $this->design->fetch($this->config->root_dir . 'design/' . $this->settings->theme . '/html/email/salesflow1_24hours.tpl');
                                    $subject = $this->design->get_var('subject');
                                    $this->notify->email($user->email, $subject, $email_template, $this->settings->notify_from_email);

                                    // Tenant: Add log
                                    $log_value2 = $br . 'Booking: #' . $b->id;
                                    $this->logs->add_log([
                                        'parent_id' => $b->id,
                                        'type' => 2, // Tenant
                                        'subtype' => 13, // Notification
                                        'user_id' => $user->id,
                                        'sender_type' => 1,
                                        'value' => $log_value . $log_value2
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
                                $email_template = $this->design->fetch($this->config->root_dir.'backend/design/html/email/salesflow1_24hours.tpl');
                                $subject = $this->design->get_var('subject');
                                $this->notify->email($managers[$b->manager_login]->email, $subject, $email_template, $this->settings->notify_from_email);

                                $sent_manager_n++;
                                echo $sent_manager_n.') Manager: '.$b->manager_login.' Booking  #'.$b->id.'<br>';
                            }
                        }
                        echo '-------------------------<br>';

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
                }
            }
        }
	}
}


$init = new Init();
$init->fetch();
