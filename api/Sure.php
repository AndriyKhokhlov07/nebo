<?php

require_once('Backend.php');

use Models\User as UserModel;
use Models\Sure as SureModel;
use Models\Log;
use Models\ExternalLog;

class Sure extends Backend
{
    const PARAMS_TYPE_INT = [
        'all_peril_deductible',
        'liability_limit',
        'personal_property_coverage'
    ];
    const PARAMS_TYPE_BOOL = [
        'has_mailing_address',
        'is_mobile_or_manufactured_home',
        'mandatory_insurance_requirement',
        'animal_injury',
        'has_sni',
        'has_intrested_party',
        'include_identity_fraud',
        'include_pet_damage',
        'include_replacement_cost',
        'include_water_backup',
    ];

    const PARAMS_PROPERTY_ADDRESS = [
        'street_address',
        'unit',
        'city',
        'region',
        'postal',
        'country_code',
    ];
    const PARAMS_DETAILS = [
        'pni_first_name',
        'pni_middle_name',
        'pni_last_name',
        'pni_suffix',
        'pni_phone_number',
        'pni_email',
        'has_mailing_address',
        'mailing_address_line1',
        'mailing_address_city',
        'mailing_address_state',
        'mailing_address_postal',
        'dwelling_type',
        'is_mobile_or_manufactured_home',
        'mandatory_insurance_requirement',
        'number_of_losses',
        'loss_date',
        'animal_injury',
        'has_sni',
        'sni_first_name',
        'sni_last_name',
        'property_special_city',
        'has_intrested_party',
        'intrested_party_name',
        'intrested_party_address_line1',
        'intrested_party_address_line2',
        'intrested_party_address_city',
        'intrested_party_address_state',
        'intrested_party_address_postal',
    ];
    const PARAMS_SETTINGS = [
        'all_peril_deductible',
        'hurricane_deductible',
        'include_identity_fraud',
        'include_pet_damage',
        'include_replacement_cost',
        'include_water_backup',
        'liability_limit',
        'medical_limit',
        'personal_property_coverage',
        'policy_effective_date',
    ];

    const PARAMS_FORMAT_PLANS = [
        'details' => self::PARAMS_DETAILS,
        'property_address' => self::PARAMS_PROPERTY_ADDRESS,
        'settings' => self::PARAMS_SETTINGS,
    ];
    const PARAMS_FORMAT_RATES = [
        'details' => self::PARAMS_DETAILS,
        'property_address' => self::PARAMS_PROPERTY_ADDRESS,
        'settings' => self::PARAMS_SETTINGS,
        'plan_id',
        'quote_id',
    ];
    const PARAMS_FORMAT_CHECKOUT = [
        'details' => self::PARAMS_DETAILS,
        'property_address' => self::PARAMS_PROPERTY_ADDRESS,
        'settings' => self::PARAMS_SETTINGS,
        'email',
        'payment_cadence',
        'plan_id',
        'quote_id',
    ];
    const PARAMS_FORMAT_CADENCES = [
        'property_address' => self::PARAMS_PROPERTY_ADDRESS,
        'quote_id'
    ];
    const PARAMS_FORMAT_CREATE_PAYMENT_METHOD = [
        'property_address' => self::PARAMS_PROPERTY_ADDRESS,
        'token',
    ];
    const PARAMS_FORMAT_PURCHASE = [
        'plan_id',
        'quote_id',
        'payment_method_id',
        'payment_cadence',
    ];

    // test keys
//    private $secret_key = 's4PLqXdGaTR0jhBDctniKxUCblF3u9Wg8ZYm2fF176JIeAwMN';
//    private $publishable_token = 'pOLdRe5pXFhlYSyHc4gEP0ar8fQ96mqWCwMsTxtZz7Nuok2F3';
//    private $stripe_key = 'pk_test_ D2bzH96t4WolPemRrrmHXjoT';
//    const REQUEST_PATH_BASE = 'https://api.tryfixsureapp.com/api/partner/v1.1/protections/renters';
//    const REQUEST_PATH_CREATE_PAYMENT_METHOD = 'https://api.tryfixsureapp.com/api/partner/v1/methods';


    // Prod keys
    private $secret_key = 'sMGqFrJiZYytTDHAeIQmfSjK0z1gXnwOfFp4PdcLuash5k9xW';
    private $publishable_token = 'pq30RolIFwAz571WLgQ8DGemthK6ybsFYnUPdcfHC4kuBfr9J';
    private $stripe_key = 'pk_live_OQ9AFCrUOup9fd7LrseHsKiS';
    const REQUEST_PATH_BASE = 'https://api.sureapp.com/api/partner/v1.1/protections/renters';
    const REQUEST_PATH_CREATE_PAYMENT_METHOD = 'https://api.sureapp.com/api/partner/v1/methods';


    const REQUEST_PATH_PLANS = self::REQUEST_PATH_BASE . '/plans';
    const REQUEST_PATH_RATES = self::REQUEST_PATH_BASE . '/rates';
    const REQUEST_PATH_CADENCES = self::REQUEST_PATH_BASE . '/cadences';
    const REQUEST_PATH_CHECKOUT = self::REQUEST_PATH_BASE . '/checkout';

    const REQUEST_PATH_PURCHASE = self::REQUEST_PATH_BASE . '/purchase';

    public $suffixes = [
        '' => 'Suffix (optional)',
        'Jr.' => 'Jr.',
        'Sr.' => 'Sr.',
        'II' => 'II',
        'III' => 'III',
        'IV' => 'IV',
        'V' => 'V',
        'VI' => 'VI',
        'VII' => 'VII',
        'VIII' => 'VIII',
        'IX' => 'IX',
        'X' => 'X',
    ];


    public $user;

    public function getStripeKey(): string
    {
        return $this->stripe_key;
    }

    public function get_sure(string $userHashCode, int $bookingId)
    {
        if (empty($this->user)) {
            $this->user = UserModel::getByHashCode($userHashCode);
        }
        $sure = SureModel::queryBuilder()
            ->where('user_id', '=', $this->user->id)
            ->andWhere('booking_id', '=', $bookingId)
            ->getFirst();

        return $sure;
    }

    public function get_sures($filter = array())
    {
        $user_id_filter = '';

        if(!empty($filter['user_hash_code']) && empty($filter['user_id'])){
            $userId = $this->users->get_user_id($filter['user_hash_code']);
        }

        if(!empty($filter['user_id']))
            $user_id_filter = $this->db->placehold('AND s.user_id in(?@)', (array)$filter['user_id']);

        $query = $this->db->placehold("SELECT
						s.*
					FROM __sures AS s
					WHERE 1
						$user_id_filter
					ORDER BY s.id DESC");
        $this->db->query($query);
        return $this->db->results();
    }

    public function get_sure_plans(array $params)
	{
        $response = $this->request(self::REQUEST_PATH_PLANS, $params);

        return $response;
	}

    public function get_sure_rates(array $params)
    {
        $response = $this->request(self::REQUEST_PATH_RATES, $params);

        return $response;
    }

    public function get_sure_checkout(array $params)
    {
        $response = $this->request(self::REQUEST_PATH_CHECKOUT, $params);

        return $response;
    }

    public function get_sure_cadences(array $params)
    {
        $response = $this->request(self::REQUEST_PATH_CADENCES, $params);

        return $response;
    }

    public function get_sure_create_payment_method(array $params)
    {
        $response = $this->request(self::REQUEST_PATH_CREATE_PAYMENT_METHOD, $params);

        return $response;
    }

    public function get_sure_purchase(array $params)
    {
        $response = $this->request(self::REQUEST_PATH_PURCHASE, $params);

        return $response;
    }

    private function clearEmptyParams(array $params): array
    {
        $tmpParams = $params;
        unset(
            $tmpParams['user_id'],
            $tmpParams['user_hash_code'],
            $tmpParams['booking_id']
        );
        if(in_array($tmpParams["has_mailing_address"], ['false', false])){
            unset(
                $tmpParams['mailing_address_line1'],
                $tmpParams['mailing_address_line2'],
                $tmpParams['mailing_address_city'],
                $tmpParams['mailing_address_state'],
                $tmpParams['mailing_address_postal']
            );
        }
        if($tmpParams['dwelling_type'] !== 'S'){
            unset($tmpParams['is_mobile_or_manufactured_home']);
        }
        if($tmpParams['number_of_losses'] === '0'){
            unset($tmpParams['loss_date']);
        }
        if(in_array($tmpParams['has_sni'], ['false', false])){
            unset(
                $tmpParams['sni_first_name'],
                $tmpParams['sni_last_name']
            );
        }
        if(in_array($tmpParams['has_intrested_party'], ['false', false])){
            unset(
                $tmpParams['intrested_party_name'],
                $tmpParams['intrested_party_address_line1'],
                $tmpParams['intrested_party_address_line2'],
                $tmpParams['intrested_party_address_city'],
                $tmpParams['intrested_party_address_state'],
                $tmpParams['intrested_party_address_postal']
            );
        }

        return $tmpParams;
    }

    private function formatRequestParams(array $format, array $params)
    {
        $result = [];
        foreach ($format as $key => $val) {
            if (is_array($val)) {
                $result[$key] = $this->formatRequestParams($val, $params);
            } else {
                if (isset($params[$val])) {
                    $result[$val] = $params[$val];
                }
            }
        }
        return $result;
    }

    private function prepareRequestParams(string $action, array $params)
    {
//        $tmpParams = $this->clearEmptyParams($params);
        $tmpParams = $params;

        foreach ($tmpParams as $key => $val) {
            if (is_string($val) && in_array($key, self::PARAMS_TYPE_INT)) {
                $tmpParams[$key] = (int)$val;
            }
            if (is_string($val) && in_array($key, self::PARAMS_TYPE_BOOL)) {
                $tmpParams[$key] = (bool)($val === 'true');
            }
        }

        switch ($action) {
            case self::REQUEST_PATH_PLANS:
                return $this->formatRequestParams(self::PARAMS_FORMAT_PLANS, $tmpParams);
            case self::REQUEST_PATH_RATES:
                return $this->formatRequestParams(self::PARAMS_FORMAT_RATES, $tmpParams);
            case self::REQUEST_PATH_CHECKOUT:
                return $this->formatRequestParams(self::PARAMS_FORMAT_CHECKOUT, $tmpParams);
            case self::REQUEST_PATH_CADENCES:
                return $this->formatRequestParams(self::PARAMS_FORMAT_CADENCES, $tmpParams);
            case self::REQUEST_PATH_PURCHASE:
                return $this->formatRequestParams(self::PARAMS_FORMAT_PURCHASE, $tmpParams);
            default:
                return $tmpParams;
        }
    }

    private function request(string $action, array $params)
    {
        $data = $this->prepareRequestParams($action, $params);

        if(!empty($data['details']['pni_phone_number'])){
//            $data['details']['pni_phone_number'] = substr(preg_replace('/[\D]+/', '', $data['details']['pni_phone_number']), -9);
            $data['details']['pni_phone_number'] = preg_replace('/[\D]+/', '', $data['details']['pni_phone_number']);
        }

        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $action);
        curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($data));
        curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type:application/json', 'Authorization: Token ' . $this->publishable_token));
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);

        $json = curl_exec($curl);

        $http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);

        curl_close($curl);

        $response = json_decode($json);

        $dataFieldName = 'response';
        if(isset($response->error)){
            $dataFieldName = 'error';
        }

        $log = ExternalLog::create([
            'user_id'       => $this->user->id ?? null,
            'provider'      => ExternalLog::PROVIDER_SURE,
            'method'        => 'POST',
            'url'           => $action,
            'status_code'   => $http_status,
            'request'       => [
                'content_type'  => ExternalLog::CONTENT_TYPE_JSON,
                'data'          => $data
            ],
            $dataFieldName  => [
                'content_type'  => ExternalLog::CONTENT_TYPE_JSON,
                'data'          => $response
            ],
        ]);


        return $response;
    }

	public function create_candidate($user_id, $token)
	{
		if(empty($user_id) || empty($token))
			return false;
		else
		{
			$user = $this->users->get_user((int)$user_id);
			if(empty($user))
				return false;
			else
			{
				if(
					empty($user->first_name)
					|| empty($user->last_name)
					|| empty($user->email)
					|| empty($user->phone)
					|| empty($user->birthday)
				)
					return false;


				$candidate_params = array();
				$candidate_params['first_name'] = $user->first_name;
				$candidate_params['last_name'] = $user->last_name;
				$candidate_params['email'] = $user->email;
				$candidate_params['phone'] = $user->phone;
				$candidate_params['dob'] = $user->birthday;
				$candidate_params['token'] = $token;

				$data = json_encode($candidate_params);

			
				$curl = curl_init();
				curl_setopt($curl, CURLOPT_URL, 'https://api.trysureapp.com/api/partner/v1/methods');
				curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
				curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type:application/json', 'Authorization: Token pOLdRe5pXFhlYSyHc4gEP0ar8fQ96mqWCwMsTxtZz7Nuok2F3'));
				curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
				curl_setopt($curl, CURLOPT_POST, true);
				curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);
				$json = curl_exec($curl);

				$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
				curl_close($curl);

				print_r($json); exit;

				// if(($http_status == 200 || $http_status == 201) && !empty($json))
				// {
				// 	$response = json_decode($json);
				// 	if(!empty($response->id))
				// 	{
				// 		$curl = curl_init();
				// 		curl_setopt($curl, CURLOPT_URL, 'https://api.checkr.io/v1/reports');
				// 		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
				// 		curl_setopt($curl, CURLOPT_POST, true);
				// 		curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);
						

				// 		$json = curl_exec($curl);
				// 		$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
				// 		curl_close($curl);
				// 		if(($http_status == 200 || $http_status == 201) && !empty($json))
				// 		{
				// 			// $response_report = json_decode($json);
				// 			// if(!empty($response_report->id))
				// 			// {
				// 			// 	// satuses: clear, consider, pending, suspended
				// 			// 	$user_checker_options['reports'][$response_report->id]['status'] = $response_report->status;
				// 			// 	if($response_report->status == 'pending')
				// 			// 	{
									
				// 			// 	}											
				// 			// }
							
				// 		}




				// 		// $this->users->update_user($user->id, $user_upd);


				// 	}
				// }
			}
		}
	}
}
