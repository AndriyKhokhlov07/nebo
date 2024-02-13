<?PHP
require_once('view/View.php');

class DepositQiraView extends View{

	public $user;

	public function fetch() {

        $hash = $this->request->get('h', 'string');

        if ($salesflow_id = $this->request->get('s')) {
            $this->salesflows->check_salesflow_status(intval($salesflow_id));
            $salesflow = $this->salesflows->get_salesflows([
                'id' => intval($salesflow_id),
                'limit' => 1
            ]);
            $this->design->assign('salesflow', $salesflow);

            $booking = current($this->beds->get_bookings([
                'id' => $salesflow->booking_id,
                'sp_group' => true,
                'sp_group_from_start' => true
            ]));

            if (!empty($booking)) {
                if ($house = $this->pages->get_page((int)$booking->house_id)) {
                    if (!empty($house->blocks)) {
                        $house->blocks = @unserialize($house->blocks);
                    }
                    if (!empty($house->blocks2)) {
                        $house->blocks2 = @unserialize($house->blocks2);
                    }
                    $this->design->assign('house', $house);
                }
                $booking->days_count = date_diff(date_create($booking->arrive), date_create($booking->depart))->days + 1;
                $this->design->assign('booking', $booking);


                // Invoice
                $invoices = $this->orders->get_orders([
                    'booking_id' => $booking->id,
                    'deposit' => 0,
                    'not_label'=> 5
                ]);
                if (!empty($invoices)) {
                    ksort($invoices);
                    $invoice = false;
                    foreach ($invoices as $inv) {
                        if(!empty($inv->date_from) && empty($invoice))
                            $invoice = $inv;
                    }
                    if (!empty($invoice)) {
                        // Send invoice to customer
                        // $this->notify->email_order_user($invoice->id, false, ['block_notifies' => true]);
                        // $this->orders->update_order($invoice->id, ['sended' => 1]);
                    }
                    $this->design->assign('invoice', $invoice);
                }
            }
        }

        if (!empty($hash)) {
            $user = $this->users->get_user_code($hash);
            if (!empty($user)) {
                $_SESSION['user_id'] = $user->id;

                // deposit: hellorented (qira)
                $q_deposit = $this->hellorented->invite_tenant($user->id, null, $salesflow->booking_id);

                if (!empty($salesflow)) {
                    header('Location: ' . $this->config->root_url . '/user/deposit_qira?success=sended&s=' . $salesflow->id);
                } else {
                    header('Location: ' . $this->config->root_url . '/user/deposit_qira?success=sended');
                }
                exit;
            }
            return false;
        }

        if (isset($_SESSION['user_id']) || !empty($salesflow)) {
            $user_id = $_SESSION['user_id'] ?? $salesflow->user_id;
            $user = $this->users->get_user(intval($user_id));

            if (empty($user))
                return false;

            $this->user = $user;

            if (!empty($user->blocks)) {
                $user_blocks = (array) unserialize($user->blocks);
            }



        }


        $this->design->assign('user', $user);

        return $this->design->fetch('tenant/deposit_qira.tpl');
	}
}