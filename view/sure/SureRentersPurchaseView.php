<?PHP

require_once('view/View.php');

use Models\Sure;
use Models\Log;

class SureRentersPurchaseView extends View
{
    private ?Sure $sureModel = null;

    function fetch()
    {
        $userHashCode = $this->request->get('user_hash_code');
        $this->sure->user = \Models\User::getByHashCode($userHashCode);
        $bookingId = (int)$this->request->get('booking_id');
        $this->sureModel = Sure::getByUserHash($userHashCode, $bookingId);

        switch (strtoupper($this->request->method())){
            case 'GET':
                return $this->get();
            case 'POST':
                $this->post();
                break;
        }
    }

    private function get()
    {
        Log::create([
            'parent_id' => $this->sureModel->id,
            'type' => 24,   // Sure
            'subtype' => 2, // Viewed Payment Form
            'user_id' => $this->sureModel->user_id,
            'sender_type' => 3
        ]);
        $this->design->assign('stripe_key', $this->sure->getStripeKey());
        return $this->design->fetch('sure/renters_purchase.tpl');
    }

    private function post()
    {
        $requestData = $_POST;

        $params = (array)$this->sureModel->params;
        $result = $this->sure->get_sure_create_payment_method([
//            'cardName' => $requestData['cardName'],
//            'streetAddress' => $requestData['streetAddress'],
//            'unit' => $requestData['unit'],
//            'city' => $requestData['city'],
//            'region' => $requestData['region'],

            'first_name' => $requestData['first_name'],
            'last_name' => $requestData['last_name'],
            'email' => $requestData['email'],
            'token' => $requestData['stripe_token'],
        ]);



        if (!is_object($result) || empty($result->payment_method_id)) {
            $this->design->assign('error', 'not_create_payment_method');
        } else {
            $params['payment_method_id'] = $result->payment_method_id;
            $this->sureModel->save([
                'payment_method_id' => $params['payment_method_id'],
                'params' => $params,
            ]);

        }



        $log_value = 'Stripe token: ' . $requestData['stripe_token'];
        if (!empty($result->payment_method_id)) {
            $log_value .= "\r\nPayment Method ID: " . $result->payment_method_id;
        }
        if (is_object($result->error) && !empty($result->error)) {
            if (!empty($result->error->code)) {
                $log_value .= "\r\nError code: " . $result->error->code;
            }
            if (!empty($result->error->message)) {
                $log_value .= "\r\nError message: " . $result->error->message;
            }
        }
        Log::create([
            'parent_id' => $this->sureModel->getAttribute('id'),
            'type' => 24,   // Sure
            'subtype' => 3, // Payment request
            'user_id' => $this->sureModel->getAttribute('user_id'),
            'sender_type' => 3,
            'value' => $log_value,
        ]);

        if (!empty($params['payment_method_id'])) {
            $result = $this->sure->get_sure_purchase($params);
            if (!is_object($result) || empty($result->policy_number)) {
                $this->design->assign('error', 'not_policy_number');
            }

            if (is_object($result)) {
                if (!empty($result->policy_number)) {

                    $this->sureModel->save([
                        'agreement_id' => $result->agreement_id,
                        'status_code' => $result->status_code,
                        'policy_number' => $result->policy_number,
                    ]);

                    Log::create([
                        'parent_id' => $this->sureModel->getAttribute('id'),
                        'type' => 24,   // Sure
                        'subtype' => 4, // Payment: Success
                        'user_id' => $this->sureModel->getAttribute('user_id'),
                        'sender_type' => 3,
                        'value' => "Policy number: " . $result->policy_number . "\r\nAccount ID: " . $result->account_id . "\r\nAgreement ID: " . $result->agreement_id . "\r\nStatus code: " . $result->status_code,
                    ]);

                    header('Location: ' . $this->config->root_url . '/user/sure/thank-you/' . $this->request->get('user_hash_code') . '/' . $this->request->get('booking_id'));
                    exit;

                } else {
                    $log_value = '';
                    if (is_object($result->error) && !empty($result->error)) {
                        if (!empty($result->error->code)) {
                            $log_value .= (empty($log_value) ? '' : "\r\n");
                            $log_value .= 'Error code: ' . $result->error->code;
                        }
                        if (!empty($result->error->message)) {
                            $log_value .= (empty($log_value) ? '' : "\r\n");
                            $log_value .= 'Error message: ' . $result->error->message;
                        }
                    }
                    Log::create([
                        'parent_id' => $this->sureModel->getAttribute('id'),
                        'type' => 24,   // Sure
                        'subtype' => 5, // Payment: Failed
                        'user_id' => $this->sureModel->getAttribute('user_id'),
                        'sender_type' => 3,
                        'value' => $log_value
                    ]);
                }
            }
        }


        $this->design->assign('stripe_key', $this->sure->getStripeKey());
        return $this->design->fetch('sure/renters_purchase.tpl');
    }
}