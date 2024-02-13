<?PHP

require_once('view/View.php');

use Models\Page;
use Models\Sure;
use Models\User;
use Models\Log;
use Models\Booking;

class SureRentersPlansView extends View
{
    private ?Sure $sureModel = null;
    private ?Booking $bookingModel = null;

    function fetch()
	{

        $userHashCode = $this->request->get('user_hash_code');
        $bookingId = (int) $this->request->get('booking_id');
        $this->bookingModel = Booking::find($bookingId);
        $userModel = User::getByHashCode($userHashCode);
        $this->sure->user = $userModel;
        $this->sureModel = Sure::getByUserHash($userHashCode, $bookingId) ?? new Sure([
            'user_id' => $userModel->id,
            'booking_id' => $bookingId,
        ]);

//        $sureStartLog = $this->logs->get_logs([
//            'type'    => 24, // Sure
//            'subtype' => 1,  // Viewed Start Form
//            'user_id' => $userModel->id
//        ]);
//        if (empty($sureStartLog)) {
            Log::create([
                'parent_id' => $this->sureModel->id,
                'type' => 24,   // Sure
                'subtype' => 1, // Viewed Start Form
                'user_id' => $userModel->id,
                'sender_type' => 3
            ]);
//        }

        if(!$this->sureModel->isExisting()){
            if(!empty($userModel) && !empty($this->bookingModel)){
                $this->sureModel->params = (object)[
                    'user_hash_code' => $userModel->hash_code,
                    'user_id' => $userModel->id,
                    'booking_id' => $bookingId,

                    'pni_first_name' => $userModel->first_name,
                    'pni_middle_name' => $userModel->middle_name,
                    'pni_last_name' => $userModel->last_name,
                    'pni_phone_number' => '',
                    'pni_email' => $userModel->email,

                    'has_mailing_address' => 'false',
                    'dwelling_type' => 'A',
                    'mandatory_insurance_requirement' => 'false',
                    'number_of_losses' => '0',
                    'animal_injury' => 'false',
                    'has_sni' => 'false',
                    'has_intrested_party' => 'false',
                ];
                $this->sureModel->save();
            }
        }

        $pageData = Page::find($this->bookingModel->house_id);
        $propertyAddress = $pageData->blocks2;
        $params = (object)$this->sureModel->params;
        $params->street_address = (!empty($propertyAddress->street_number) ? $propertyAddress->street_number . ' ' : '') . $propertyAddress->street_address;
        $params->unit = '';
        $params->city = $propertyAddress->city;
        $params->region = $propertyAddress->region;
        $params->postal = $propertyAddress->postal;
        $params->country_code = $propertyAddress->country_code ?? 'US';

        $policyEffectiveDate = (new DateTime($this->bookingModel->arrive ?? null) < (new DateTime('NOW'))->modify('+1 day'))
            ? (new DateTime('NOW'))->modify('+1 day')->format('Y-m-d')
            : $this->bookingModel->arrive;

        $params->policy_effective_date = $policyEffectiveDate;
        $this->sureModel->save();

        $this->sureModel->params = $params;
        $this->sureModel->save();

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
        $this->design->assign('errors', $_COOKIE['sure-errors'] ?? '');
        setcookie('sure-errors', '', time() - 1);

        $this->design->assign('params', $this->sureModel->params);
        $this->design->assign('regions', $this->users->states);
        $this->design->assign('suffixes', $this->sure->suffixes);

        return $this->design->fetch('sure/renters_plans.tpl');
    }

    private function post()
    {
        $requestData = $_POST;

        $params = array_merge((array)$this->sureModel->params, $requestData);
        $this->sureModel->params = $params;
        $this->sureModel->save();

        $plans = $this->sure->get_sure_plans($params);
        if(isset($plans->error)){
            $this->design->assign('errors', json_encode($plans->error));
            $this->design->assign('params', $params);
            $this->design->assign('regions', $this->users->states);
            $this->design->assign('suffixes', $this->sure->suffixes);

//            return $this->design->fetch('sure/renters_plans.tpl');
            setcookie('sure-errors', $plans->error);
            header('Location: ' . $this->config->root_url . '/user/sure/plans/' . $this->request->get('user_hash_code') . '/' . $this->request->get('booking_id'));
            exit;
        }
        $params['plan_id'] = $plans->plans[0]->plan_id;

        $rates = $this->sure->get_sure_rates($params);
        if(isset($rates->error)){
//            return $this->design->fetch('sure/renters_plans.tpl');
            setcookie('sure-errors', $rates->error);
            header('Location: ' . $this->config->root_url . '/user/sure/plans/' . $this->request->get('user_hash_code') . '/' . $this->request->get('booking_id'));
            exit;
        }

        $params['quote_id'] = $rates->quote_id;
        $params['email'] = $params['pni_email'];

        $params['payment_cadence'] = $params['payment_cadence'] ?? 'annual';
        $params['all_peril_deductible'] = $params['all_peril_deductible'] ?? $rates->rates->defaults->all_peril_deductible;
        $params['liability_limit'] = $params['liability_limit'] ?? $rates->rates->defaults->liability_limit;
        $params['personal_property_coverage'] = $params['personal_property_coverage'] ?? $rates->rates->defaults->personal_property_coverage;
        $params['hurricane_deductible'] = $params['hurricane_deductible'] ?? $rates->rates->defaults->hurricane_deductible;
        $params['medical_limit'] = $params['medical_limit'] ?? $rates->rates->defaults->medical_limit;
        $params['include_pet_damage'] = $params['include_pet_damage'] ?? $rates->rates->defaults->include_pet_damage;
        $params['include_water_backup'] = $params['include_water_backup'] ?? $rates->rates->defaults->include_water_backup;
        $params['include_identity_fraud'] = $params['include_identity_fraud'] ?? $rates->rates->defaults->include_identity_fraud;
        $params['include_replacement_cost'] = $params['include_replacement_cost'] ?? $rates->rates->defaults->include_replacement_cost;

        $this->sureModel->save([
            'plan_id' => $params['plan_id'],
            'quote_id' => $params['quote_id'],
            'params' => $params,
        ]);

        header('Location: ' . $this->config->root_url . '/user/sure/checkout/' . $this->request->get('user_hash_code') . '/' . $this->request->get('booking_id'));
        exit;
    }
}