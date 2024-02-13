<?php
ini_set('error_reporting', E_ERROR);
session_start();

chdir('..');
require_once('api/Backend.php');

class Init extends Backend
{

    function fetch()
    {
        $requestMethod = strtolower($_SERVER["REQUEST_METHOD"]);
        $requestOrders = $this->request->$requestMethod('orders') ? explode(',', $this->request->$requestMethod('orders')) : null;

        $dateFrom = date('Y-m-d', strtotime( '-5 days' ));
        $dateTo = date('Y-m-d', strtotime( '-4 day' ));

        $priceFrom = 150;

        $limit = 20;
        $completedIds = [];


        // Payment Methods
        $housesPaymentMethods = [];
        $housesPayeeIds = [];

        $sentCount = 0;
        $sentAutochargeCount = 0;
        $n = 0;


        $paymentMethods = $this->request->array_to_key($this->payment->get_payment_methods(), 'id');

        $this->db->query("SELECT * FROM __payment_methods_houses");
        $housesPaymentMethods_ = $this->db->results();


        if (!empty($paymentMethods) && !empty($housesPaymentMethods_)) {

            foreach ($paymentMethods as $pm) {
                $pm->settings = unserialize($pm->settings);
            }

            foreach($housesPaymentMethods_ as $pm) {
                if (isset($paymentMethods[$pm->payment_method_id])) {
                    if (!isset($housesPaymentMethods[$pm->house_id])) {
                        $housesPaymentMethods[$pm->house_id] = [];
                    }
                    if (!in_array($pm->payment_method_id, $housesPaymentMethods[$pm->house_id])) {
                        array_push($housesPaymentMethods[$pm->house_id], $pm->payment_method_id);
                    }

                    $paymentMethod = $paymentMethods[$pm->payment_method_id];
                    if ($paymentMethod->module == 'Qira' && !empty($paymentMethod->settings['payee_id'])) {
                        $housesPayeeIds[$pm->house_id][$paymentMethod->settings['payment_method_type']] = $paymentMethod->settings['payee_id'];
                    }
                }

            }
        }


        $this->design->assign('config', $this->config);
        $currencies = $this->money->get_currencies(array('enabled'=>1));
        if (!empty($currencies)) {
            $this->design->assign('currency', reset($currencies));
        }

        do{
            if ($requestOrders) {
                $where = $this->db->placehold("AND o.id IN (?@)", (array) $requestOrders);
            } else {
                $where = $this->db->placehold("
                        AND o.type = 1
                        AND o.paid != 1
                        AND o.status in (0, 4)
                        AND o.date_due >= ?
                        AND o.date_due >= ?
                        AND o.date_due <= ?
                        AND ((ol.label_id != 8 AND ol.label_id != 11) OR ol.label_id IS NULL)
                        AND b.client_type_id in (1)
                        AND b.house_id != 345
                        AND u.block_notifies != 1
                        AND log.id IS NULL
                        AND o.total_price >= ?
                        AND (o.date_from != b.arrive OR b.parent_id > 0)
				", '2023-07-01', $dateFrom, $dateTo, $priceFrom);
            }

            if (!empty($completedIds)) {
                $where .= $this->db->placehold("AND o.id NOT IN (?@)", (array) $completedIds);
            }


            $query = $this->db->placehold("SELECT 
							o.id,
							o.url,
							o.type,
							o.paid,
							o.total_price,
							o.sku,
							o.discount,
							o.discount_type,
							o.date,
							o.date_from,
							o.date_to,
							o.date_due,
							o.contract_id,
							o.booking_id,
							o.status,
							b.client_type_id,
							b.house_id,
							u.block_notifies as user_block_notifies
						FROM __orders AS o
						LEFT JOIN __orders_labels AS ol ON o.id=ol.order_id
						LEFT JOIN __bookings AS b ON o.booking_id=b.id
                        LEFT JOIN __orders_users AS ou ON o.id=ou.order_id
                        LEFT JOIN __users AS u ON ou.user_id=u.id
						LEFT JOIN s_logs AS log ON log.parent_id=o.id AND log.type=3 AND log.subtype IN (16, 17)
						WHERE 1
						    $where
                        GROUP BY o.id
						ORDER BY o.date_due, o.id
						LIMIT $limit
			");

            $this->db->query($query);
            $orders = $this->db->results();
            $orders = $this->request->array_to_key($orders, 'id');



            if (!empty($orders)) {

                $ordersIds = array_keys($orders);

                // Purchases
                $purchases = $this->orders->get_purchases([
                    'order_id' => $ordersIds
                ]);
                if (!empty($purchases)) {
                    foreach ($purchases as $purchase) {
                        if (isset($orders[$purchase->order_id])) {
                            if (!isset($orders[$purchase->order_id]->purchases)) {
                                $orders[$purchase->order_id]->purchases = [];
                            }
                            $orders[$purchase->order_id]->purchases[$purchase->id] = $purchase;

                            // Order Has Late Payment Fee
                            if ($purchase->type == 8) {
                                $orders[$purchase->order_id]->hasLatePaymentFee = true;
                            }
                        }
                    }
                }

                // Orders Users
                $ordersUsers_ = $this->orders->get_orders_users([
                    'order_id' => $ordersIds
                ]);
                if (!empty($ordersUsers_)) {
                    $ordersUsers = [];
                    foreach ($ordersUsers_ as $ou) {
                        $ordersUsers[$ou->user_id][$ou->order_id] = $ou->order_id;
                    }
                    $users = $this->users->get_users([
                        'id' => array_keys($ordersUsers)
                    ]);
                    if (!empty($users)) {
                        foreach ($users as $user) {
                            if (isset($ordersUsers[$user->id])) {
                                foreach ($ordersUsers[$user->id] as $orderID) {
                                    if (isset($orders[$orderID])) {
                                        if (!isset($orders[$orderID]->users)) {
                                            $orders[$orderID]->users = [];
                                        }
                                        $orders[$orderID]->users[$user->id] = $user;
                                    }
                                }
                            }
                        }
                    }
                }


                foreach ($orders as $order){
                    $completedIds[] = $order->id;
                    $order->autocharge = false;

                    $this->design->assign('order', $order);
                    $this->design->assign('purchases', $order->purchases);


                    if ($order->user_block_notifies != 1 && !isset($order->hasLatePaymentFee)) {
                        if (!empty($order->users)) {
                            $this->design->assign('users', $order->users);
                            foreach($order->users as $user) {
                                if (
                                    $user->block_notifies != 1 &&
                                    !empty($user->payment_methods_details) &&
                                    isset($housesPayeeIds[$order->house_id])
                                ) {
                                    foreach ($user->payment_methods_details as $pm) {
                                        if ($pm->response->Success == 1 && in_array($pm->payee_id, $housesPayeeIds[$order->house_id])) {
                                            $order->autocharge = true;

                                            $this->design->assign('user', $user);

                                            $email_template = $this->design->fetch($this->config->root_dir . 'design/' . $this->settings->theme . '/html/email/invoice/autocharge_dont_charge.tpl');

                                            if (empty($subject)) {
                                                $subject = $this->design->get_var('subject');
                                            }
                                            $this->notify->email($user->email, $subject, $email_template, $this->settings->notify_from_email);

                                            $this->logs->add_log([
                                                'parent_id'   => $order->id,
                                                'type'        => 3,  // Invoice
                                                'subtype'     => 17, // Sent notice about don't pay (Autocharge)
                                                'sender_type' => 1,  // System
                                            ]);

                                            $sentAutochargeCount ++;
                                            echo ++$n . '. User ID ' . $user->id . ' | Invoice ID ' . $order->id . ': email sent (autocharge) <br>';
                                        }
                                    }
                                }
                            }

                            if (!$order->autocharge) {
                                foreach($order->users as $user) {
                                    $this->design->assign('user', $user);

                                    $email_template = $this->design->fetch($this->config->root_dir . 'design/' . $this->settings->theme . '/html/email/invoice/late_payment_fee_info.tpl');

                                    if (empty($subject)) {
                                        $subject = $this->design->get_var('subject');
                                    }
                                    $this->notify->email($user->email, $subject, $email_template, $this->settings->notify_from_email);

                                    $this->logs->add_log([
                                        'parent_id'   => $order->id,
                                        'type'        => 3,  // Invoice
                                        'subtype'     => 16, // Sent notice about Late Payment Fee
                                        'sender_type' => 1,  // System
                                    ]);

                                    $sentCount ++;
                                    echo ++$n . '. User ID ' . $user->id . ' | Invoice ID ' . $order->id . ': email sent <br>';
                                }
                            }
                        }
                    }
                }
            }

        } while (count($orders) == $limit);


        echo 'Sent autochatge: ' . $sentAutochargeCount . '<br>';
        echo 'Sent inv: ' . $sentCount . '<br>';

    }
}

$init = new Init();
$init->fetch();
