<?
require_once('../api/Backend.php');

use Models\User;
use Models\Sure;

$backend = new Backend();

function getParams()
{
    global $backend;
    $userHashCode = $backend->request->get('user_hash_code');
    $bookingId = $backend->request->get('booking_id');
    if(!empty($userHashCode) && !empty($bookingId)){
        $userData = User::getFirst(null, ["`hash_code` = $userHashCode"])->toObject();
        $sureData = Sure::getFirst(null, ["`user_id` = $userData", "`booking_id` = $bookingId"])->toObject();
        return $sureData->params;
    }
    return null;
}

function getSureRates()
{
    global $backend;
    $params = $_GET;
    $result = $backend->sure->get_sure_rates($params);
    return $result;
}

function getSureCheckout()
{
    global $backend;
    $params = $_GET;
    $result = $backend->sure->get_sure_checkout($params);
    return $result;
}

function getSureCadences()
{
    global $backend;
    $params = $_GET;
    $result = $backend->sure->get_sure_cadences($params);
    return $result;
}

$result = [];
switch (strtoupper($backend->request->method())){
    case 'GET':
        if($method = $backend->request->get('method')){
            try{
                $result = call_user_func($method);
            }catch (Exception $exception){
                $a=1;
            }
        }
        break;
    case 'POST':
        break;
}

header("Content-type: application/json; charset=UTF-8");
header("Cache-Control: must-revalidate");
header("Pragma: no-cache");
header("Expires: -1");
echo json_encode($result);
