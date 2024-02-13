<?php
ini_set('error_reporting', 0);
// session_start();
chdir('..');
require_once('api/Backend.php');

class Init extends Backend
{
	function fetch()
	{
		$date_today = date("Y-m-d", strtotime( '+5 days' ));
		$date_yesterday = date("Y-m-d", strtotime( '-5 days' ));

		$query = $this->db->placehold("SELECT 
							o.id,
							o.date,
							o.date_due,
							o.contract_id,
							o.booking_id,
							o.status,
							b.apartment_id,
							u.block_notifies as user_block_notifies
						FROM __orders AS o
						LEFT JOIN __orders_labels AS ol ON o.id=ol.order_id
						LEFT JOIN __bookings AS b ON o.booking_id=b.id
						LEFT JOIN __apartments AS a ON b.apartment_id=a.id
                        LEFT JOIN __orders_users AS ou ON o.id=ou.order_id
                        LEFT JOIN __users AS u ON ou.user_id=u.id
						WHERE 1
							AND o.type = 1
							AND o.paid != 1
							AND o.status = 0
							AND o.sended != 1
 							AND o.date_due >= ?
 							AND o.date_due <= ?
 							AND ((ol.label_id != 8 AND ol.label_id != 11) OR ol.label_id IS NULL)
 							AND b.client_type_id NOT in (2, 4, 6)
 							AND b.house_id != 345
 							AND a.type != 2
                            AND u.block_notifies != 1
                        GROUP BY o.id
						ORDER BY o.id
						LIMIT 200
						", $date_yesterday, $date_today);
		
		$this->db->query($query);
		$orders = $this->db->results();

		$orders = $this->request->array_to_key($orders, 'id');

		foreach ($orders as $order) {

            if ($order->user_block_notifies != 1) {

                $this->notify->email_order_user($order->id, false, [
                    'block_notifies' => true,
                    'autocharge' => 'prior_notice',
                    'add_log' => true,
                    'sender_type' => 1 // System
                ]);

                $this->orders->update_order($order->id, array('sended'=>1));

                echo 'Order '.$order->id.' sended';
            }
		}
	}
}

$init = new Init();
$init->fetch();
