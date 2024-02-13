<?PHP

use Models\Sure;
use Models\User;

require_once('view/View.php');

class SureRentersCheckoutView extends View
{
    private ?Sure $sureModel = null;

    function fetch()
    {
        $userHashCode = $this->request->get('user_hash_code');
        $this->sure->user = User::getByHashCode($userHashCode);
        $bookingId = (int)$this->request->get('booking_id');
        $this->sureModel = Sure::getByUserHash($userHashCode, $bookingId);

        switch (strtoupper($this->request->method())){
            case 'GET':
                return $this->get();
                break;
            case 'POST':
                $this->post();
                break;
        }
    }

    private function get()
    {
        $params = (object)$this->sureModel->toObject()->params;

        $rates = $this->sure->get_sure_rates((array)$params);
        $params->quote_id = $rates->quote_id;
        $cadences = $this->sure->get_sure_cadences((array)$params);
        $payments = [];
        foreach ($cadences->cadences as $cadence){
            $payments[$cadence->payment_cadence] = [
                'downpayment_amount' => number_format($cadence->downpayment_amount, 2),
                'installment_amount' => number_format($cadence->installment_amount, 2),
                'full_installment_amount' => number_format($cadence->full_installment_amount, 2),
            ];
        }

        $this->design->assign('params', $params);
        $this->design->assign('json_params', base64_encode(json_encode($params)));
        $this->design->assign('payments', $payments);
        $this->design->assign('personal_property', $rates->rates->personal_property);
        $this->design->assign('liability', $rates->rates->liability);

        return $this->design->fetch('sure/renters_checkout.tpl');
    }

    private function post()
    {
        $requestData = $_POST;

        $this->sureModel->save([
            'plan_id' => $requestData['plan_id'],
            'quote_id' => $requestData['quote_id'],
            'params' => (object)array_merge((array)$this->sureModel->params, $requestData),
        ]);

        header('Location: ' . $this->config->root_url . '/user/sure/purchase/' . $this->request->get('user_hash_code') . '/' . $this->request->get('booking_id'));
        exit;
    }
}