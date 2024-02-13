<?php
ini_set('error_reporting', E_ALL);
// session_start();

chdir('..');
require_once('api/Backend.php');

$path = __DIR__ . DIRECTORY_SEPARATOR;
$prefix = '';
while(!file_exists($path . $prefix . 'autoloader.php')){
    $prefix .= '..' . DIRECTORY_SEPARATOR;
}
define('ROOT_PATH', realpath($path . $prefix));
require_once (ROOT_PATH . DIRECTORY_SEPARATOR . 'autoloader.php');

use Models\Log;
use Models\Order;

class Init extends Backend
{

	function fetch()
	{
        /** todo
         * Need review dates
         */
		$date_today = date("Y-m-d", strtotime( '+5 days' ));
		$date_yesterday = date("Y-m-d", strtotime( '-1 days' ));

        $limit = 20;
        $completedIds = [];

        do{
            $query = Order::queryBuilder()
                ->where('type', '=', 1)
                ->andWhere('paid', '!=', 1)
                ->andWhere('paid', '!=', 1)
                ->andWhere('status', '=', 0)
                ->andWhere('sended', '!=', 1)
                ->andWhere('date_due', '>=', $date_yesterday)
                ->andWhere('date_due', '<=', $date_today)
                ->order('id')
                ->limit($limit);
            if(!empty($completedIds)){
                $query->andWhere('id', Order::CONDITION_OPERATOR_NOT_IN, $completedIds);
            }
            $orders = $query->get();

            /**
             * @var Order $order
             */
            foreach ($orders->getItems() as $order){
                $completedIds[] = $order->id;

                /** todo
                 * Need check filter by values from linked tables
                 */
                if(
                    (
                        $order->order_label === null
                        || !in_array($order->order_label->label_id, [8, 11])
                    )
                    && !in_array($order->booking->client_type_id, [2, 4, 6])
                    && $order->booking->house_id != 345
                    && $order->booking->apartment->type != 2
                ){
                    $users = $order->autocharge_users();
                    if($users->count()){
                        if (
                            $users->first()->block_notifies != 1
                            && $order->user_block_notifies != 1
                        ){
                            $user = $users->first();

                            /** todo
                             * Нужно дописать генерацию сообщения
                             */
                            $this->design->assign('user', $user);

                            $email_template = $this->design->fetch($this->config->root_dir . 'design/' . $this->settings->theme . '/html/email/autocharge_prior_notice.tpl');
                            $subject = $this->design->get_var('subject');

                            $this->notify->email($user->email, $subject, $email_template, $this->settings->notify_from_email);

                            $order->sended = 1;
                            $order->save();

                            Log::create([
                                'parent_id' => $order->id,
                                'type' => 3,
                                'subtype' => 2, // order sended
                                'sender_type' => 1
                            ]);
                            echo 'Order '.$order->id.' sended';
                        }
                    }
                }
            }
        }while($orders->count() == $limit);
	}
}

$init = new Init();
$init->fetch();
