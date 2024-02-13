<?php
ini_set('error_reporting', E_ERROR);
// session_start();

$path = __DIR__ . DIRECTORY_SEPARATOR;
$prefix = '';
while(!file_exists($path . $prefix . 'autoloader.php')){
    $prefix .= '..' . DIRECTORY_SEPARATOR;
}
define('ROOT_PATH', realpath($path . $prefix));
require_once (ROOT_PATH . DIRECTORY_SEPARATOR . 'autoloader.php');

use Libs\DBHelper\ModelInterface;
use Models\Log;
use Models\Order;
use Qira;

class Init extends Backend
{

    function fetch()
    {
        $requestMethod = strtolower($_SERVER["REQUEST_METHOD"]);
        $requestOrders = $this->request->$requestMethod('orders') ? explode(',', $this->request->$requestMethod('orders')) : null;

        $date_today = date("Y-m-d");
        $date_yesterday = date("Y-m-d", strtotime( '-3 day' ));

        $limit = 20;
        $completedIds = [];

        do{
            $query = Order::queryBuilder();

            if($requestOrders){
                $query->andWhere('id', ModelInterface::CONDITION_OPERATOR_IN, $requestOrders);
            }else{
                $query->where('type', '=', 1)
                    ->andWhere('paid', '!=', 1)
                    ->andWhere('status', '=', 0)
                    ->andWhere('sended', '=', 1)
                    ->andWhere('date_due', '>=', $date_yesterday)
                    ->andWhere('date_due', '<=', $date_today);
            }

            $query->order('id')
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
                    $autocharge = $order->autocharges->first();
                    if($autocharge){

                        $qira = new Qira();
                        $qira->autocharge($autocharge);

                        Log::create([
                            'parent_id' => $order->id,
                            'type' => 3,
                            'subtype' => 10, // Autocharge
                            'sender_type' => 1
                        ]);
                        echo 'Order '.$order->id.' charge';
                    }
                }
            }
        }while($orders->count() == $limit);

        Log::create([
            'parent_id' => -1,
            'type'      => 3,
            'subtype'   => 13,
            'data'      => json_encode([
                'message' => '!!! autocharge_payment.php was finished !!!'
            ]),
        ]);
    }
}

$init = new Init();
$init->fetch();
