<?php

use Models\Booking;
use Models\Contract;

require_once('Backend.php');

class Hellorented extends Backend
{

	// Mode: sandbox, production
	private $mode = 'production';

	// Production keys
	private $company_id = '0a20b945af7382';
	private $client_id = '183_8peox567y7wg8so0k8wgwk4k00wk88g840csoos4sgw084g40';
	private $client_secret = '657nojt102gwc4k0wc4488sk8wsccoosgook8ok4oo0wcwog8o';

//	private $request_url = 'https://www.hellorented.com';
    private $request_url = 'https://hr.qira.com';
	private $response_url;
	private $guest_info;

	// private $auth_token = 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Im54ZWNYamw3ejhWTFJfMVByMWJBbWQ1dlNqSUNwcHVxZnh4YXg3RVY2dDQifQ.eyJqdGkiOiJlMjBkZjI0My1mOTNmLTQwYmQtOTIwMC1iZjE5MWIxODJhMTYiLCJyb2xlIjoicmVudGlnby12Mi1hcGktY2xpZW50Iiwib3JnYW5pemF0aW9uLWlkIjoiRkUwRkVDMTgtMjE2NC00N0Q1LThBMzktMkYzNkExMTAyNDc5IiwibmJmIjoxNjg0ODU5NzE2LCJleHAiOjE3MTkyNjI4MDAsImlhdCI6MTY4NDg1OTcxNiwiaXNzIjoiUmVudGlnbyBBdXRob3JpemF0aW9uIFNlcnZlciBJc3N1cmUiLCJhdWQiOiJSZW50aWdvLVYyLTEifQ.wETLFyyLzWt2TpUsQpMtEvoQWy10CLKeyOWb8IVtB1RF-fEJ7UC4rjGYCOWEs-MWDeEWZrZYp8GPb_zqlWeR78O7yx0MgWVn-vmKXRdaDcF5Mi81wxwZxZI_6Lj-vjGRJfhk8bw_COeJqLZhxOJYcpyuJWRGx33oFytLZclLuql7E1iZGMrRv-xoJ9bYmpWqxluPw-hTnrutIvxd52pvpfMrYYeZqtt_NzqW3c9Ljg5DlpYz4G2aejzLAoqNlcwavteEBaJir94iGjaHeDyErTKfTypn3rmLiZZlcj0mUcS7zxV2N1dB_IKE5Lr-dBSHa1Wm1dHfvg9DNkPW1nVqzVTuoh1nhQF1jIS5DUIhq0rUJmJM6cC_pG3V_bbPRmv_tQMKtFsoDuARz8AktqO0E6UTRfL9U9xxsw7UBsvDDcVqiHX_dP5zoLA1QlvMq6AD3fQbfLRFmvtv0acUn3ifkK9O3grErwpcHYg94Isg45t3jhF4A6I3gH-yEdtQ48o85VAXIERtDVHI_ksehKmigpp0YTo2yNSSr88jxmL81_NFXIdtcTRfxSSO2qw4r3Rxno2_-6M_qcdIRFIBznkyj9MaRDVumcM9mQP8GHzi9uOi4RnSff9-lunpgCJCaHyKzmaLME0Zonu0hZCqvUN-eswIwB-l6p746WS9nz3DYq4';
    private $auth_token;
	private $auth_token_file = 'api/tokens/hellorented_auth.token';




	public function __construct()
	{
		$this->response_url = $this->config->root_url.'/request/hellorented/callback.php';

		if($this->mode == 'sandbox')
		{
			// Sandbox keys
			$this->company_id = 'b687aad707a5d3';
			$this->client_id = '183_5ppg0c3fju88okscsookkog0ss8g8404skcskwo0o04kgsgccs';
			$this->client_secret = '50z2l56d7qkoggc84wskw0wgks0ooc88gk8s8wkckwcc04wwg8';

			$this->request_url = 'https://stage.hellorented.com';	
		}
		
		$this->get_auth_token();
	}



	private function authenticate()
	{

		$auth_params = array(
			'client_id' 	=> $this->client_id,
			'client_secret' => $this->client_secret,
			'grant_type'    => 'client_credentials'
		);

		$curl = curl_init();
		curl_setopt($curl, CURLOPT_URL, $this->request_url.'/oauth/v2/token');
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_POST, true);
		curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);
		curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($auth_params));

		$json = curl_exec($curl);
		$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);

		if($http_status == 200)
		{
			$response = json_decode($json);
			if(!empty($response->access_token))
				return $response->access_token;
		}
		//echo "status:" . $http_status . "\n" . $json . "\n\n";
		//print_r($response); exit;
	}

	private function get_new_auth_token()
	{
		// Authenticate
		$auth_token = $this->authenticate();
		if(empty($auth_token))
			return false;

		// Save token
		$f = fopen($this->auth_token_file,'w');
		fwrite($f, base64_encode($auth_token));
		fclose($f);

		return $auth_token;
	}


	public function get_auth_token()
	{
		if(!empty($this->auth_token))
			return $this->auth_token;

		if(!file_exists($this->auth_token_file))
			return $this->get_new_auth_token();

		$f_time = filectime($this->auth_token_file);

		// The access token has an expiration time of one hour
		if(strtotime('now') < ($f_time + (59 * 60)))
			$this->auth_token = base64_decode(file_get_contents($this->auth_token_file));
		else
			$this->auth_token = $this->get_new_auth_token();

		return $this->auth_token;
	}

	

	public function get_properties()
	{
		$curl = curl_init();
		curl_setopt($curl, CURLOPT_URL, $this->request_url.'/api/rest_v1/landlords/'.$this->company_id.'/properties');

		
		$headers[] = 'Content-Type: application/json';
		$headers[] = 'Accept: application/json';
		$headers[] = 'Authorization: Bearer '.$this->auth_token;
		curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);

		// $json = curl_exec($curl);
		// $http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		// curl_close($curl);
		// $response = json_decode($json);




		header('Content-Type: application/json');
		$json = curl_exec($curl);
		curl_close($curl);
	}




	


	public function invite_tenant($user_id, $contract_id = null, $booking_id = null) {

        $params = [];
        
		if(empty($user_id))
			return false;

		$this->guest_info = $this->users->get_user((int)$user_id);
		if(empty($this->guest_info))
			return false;

		if(!empty($this->guest_info->files))
			$this->guest_info->files = (array) unserialize($this->guest_info->files);

		if(empty($this->guest_info->active_booking_id))
			return 'No guest active booking';

		if(empty($this->guest_info->first_name))
			return 'Empty guest first name';

		if(empty($this->guest_info->last_name))
			return 'Empty guest last name';

		if(empty($this->guest_info->email))
			return 'Empty guest email';

		if(empty($this->guest_info->phone))
			return 'Empty guest phone';

		/*
		elseif(!empty($this->guest_info->files))
		{
			$this->guest_info->files = unserialize($this->guest_info->files);

			if(empty($this->guest_info->files['usa_doc']))
				return 'Missing photo of Passport / ID / Driver licence';
			elseif(empty($this->guest_info->files['usa_selfie']))
				return 'Missing Selfie with doc';
		}
		else
			return 'Missing photo of documents';
		*/

		if (!is_null($contract_id)) {
			$contract = $this->contracts->get_contracts(array(
				'id' => intval($contract_id),
				'status' => 1,
                'select_users' => true,
				'limit' => 1
			));
		}
		elseif (!is_null($booking_id)) {
			$contract = $this->contracts->get_contracts(array(
				'reserv_id' => intval($booking_id),
				'status' => 1,
                'select_users' => true,
				'limit' => 1
			));
		} else {
			$contract = $this->contracts->get_contracts(array(
				'reserv_id' => $this->guest_info->active_booking_id,
				'status' => 1,
                'select_users' => true,
				'limit' => 1
			));
		}

        $booking = false;
        if (!is_null($booking_id)) {
            $booking = current($this->beds->get_bookings([
                'id' => $booking_id,
                'sp_group' => true,
                'select_users' => true
            ]));

        }

		
		if (empty($contract) && empty($booking))
			return 'No contract and booking';

        if (!empty($contract)) {
            $this->guest_info->contract = current($contract);

            if (!empty($this->guest_info->contract->house_id)) {
                $this->guest_info->house_id = $this->guest_info->contract->house_id;
            }

            $this->guest_info->inquiry_arrive = $this->guest_info->contract->date_from;
            $this->guest_info->inquiry_depart = $this->guest_info->contract->date_to;

            if ($this->guest_info->contract->price_month == 0)
                return 'Price/month in Contract must be > 0';

            // if($this->guest_info->contract->price_deposit == 0)
            // 	return 'Deposit in Contract must be > 0';

            $users_count = count($this->guest_info->contract->users) ?? 1;

            if ($users_count > 1){
                foreach ($this->guest_info->contract->users as $u) {
                    if (!isset($this->guest_info->co_applicant_email) && $u->email != $this->guest_info->email) {
                        $this->guest_info->co_applicant_email = $u->email;
                    }
                }
                $params['co_applicant'] = $this->guest_info->co_applicant_email;
            }

            if($this->guest_info->contract->price_deposit > 0) {
                $params['security_deposit_amount'] = round($this->guest_info->contract->price_deposit / $users_count, 2);
            } else {
                $params['security_deposit_amount'] = round($this->guest_info->contract->price_month / $users_count, 2);
            }

            $params['monthly_rent'] = round($this->guest_info->contract->price_month / $users_count, 2);

        }
        elseif (!empty($booking)) {
            $booking->nights_count = date_diff(date_create($booking->arrive), date_create($booking->depart))->days;
            $booking->days_count = $booking->nights_count + 1;
            $b_house = $this->pages->get_page((int)$booking->house_id);

            $users_count = count($booking->users) ?? 1;
            if ($users_count > 1) {
                foreach ($booking->users as $u) {
                    if (!isset($this->guest_info->co_applicant_email) && $u->email != $this->guest_info->email) {
                        $this->guest_info->co_applicant_email = $u->email;
                    }
                }
                $params['co_applicant'] = $this->guest_info->co_applicant_email;
            }

            $house = $b_house;
            $this->guest_info->house_id = $booking->house_id;
            $this->guest_info->inquiry_arrive = $booking->arrive;
            $this->guest_info->inquiry_depart = $booking->depart;

            $security_deposit_amount = $booking->price_month * 1;
            // House type 1 - Hotel
            // > 30 days
            if (!empty($b_house) && $b_house->type == 1 && $booking->days_count >= 30) {
                $security_deposit_amount = 1000;
            }
            $params['security_deposit_amount'] = round($security_deposit_amount / $users_count, 2);
            $params['monthly_rent'] = round($booking->price_month * 1 / $users_count, 2);
        }

        $interval = date_diff(date_create($this->guest_info->inquiry_arrive), date_create($this->guest_info->inquiry_depart));

		$this->guest_info->inquiry_interval = $interval->m;
		if($interval->d > 27)
			$this->guest_info->inquiry_interval += 1;
		if($interval->y > 0)
			$this->guest_info->inquiry_interval += $interval->y * 12;

		if(empty($this->guest_info->house_id))
			return 'Empty House ID';

        if (!isset($house)) {
            $house = $this->pages->get_page((int)$this->guest_info->house_id);
        }

		if(empty($house))
			return 'Empty House';

		if(empty($house->blocks2))
			return 'Empty Qira info in House page';

		$house->blocks2 = unserialize($house->blocks2);

		if(empty($house->blocks2['hellorented_property']))
			return 'Empty Qira Property ID in House page';

		// if(empty($house->blocks2['hellorented_landlord']))
		// 	return 'Empty Hellorented Landlord ID in House page';

		$this->guest_info->property_id = $house->blocks2['hellorented_property'];
		// $this->guest_info->landlord_id = $house->blocks2['hellorented_landlord'];


		$params['first_name'] = $this->guest_info->first_name;
		$params['last_name'] = $this->guest_info->last_name;
		$params['email'] = $this->guest_info->email;
		$params['contact_number'] = $this->guest_info->phone;
		$params['lease_term'] = $this->guest_info->inquiry_interval;
        $params['move_in_date'] = date_create($this->guest_info->inquiry_arrive)->format('Y-m-d');


		$params['pre_existing_tenant'] = false;

		if($this->guest_info->us_citizen == 1)
		{
			$params['us_citizen'] = true;
			if(!empty($this->guest_info->street_address))
			{
				$params['current_address'] = $this->guest_info->street_address;
				if(!empty($this->guest_info->apartment))
					$params['current_apt'] = $this->guest_info->apartment;
			}
			if(!empty($this->guest_info->zip))
				$params['current_zip_code'] = base64_decode($this->guest_info->zip);

		}
		elseif($this->guest_info->us_citizen == 2)
			$params['us_citizen'] = false;


		// Test property_ids:
		//   2da70fad74babf
		//   a9b14a8454f58d

		$curl = curl_init();
		curl_setopt($curl, CURLOPT_URL, $this->request_url.'/api/rest_v1/landlords/'.$this->company_id.'/properties/'.$this->guest_info->property_id.'/tenants');

		$headers[] = 'Content-Type: application/json';
		$headers[] = 'Authorization: Bearer '.$this->auth_token;
		curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_POST, true);
		curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);
		curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($params));

		$json = curl_exec($curl);
		$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);

		curl_close($curl);
		$response = json_decode($json);

		if($http_status == 200)
		{
			if(!empty($response->id))
			{
				$this->users->update_user($this->guest_info->id, array('hellorented_tenant_id'=>$response->id));
                $br = PHP_EOL;
				$log_value = 'Tenant ID: '.$response->id.$br;
				if(!empty($booking_id))
					$log_value .= 'Booking id: '.$booking_id.$br;
				if(!empty($manager))
					$log_value .= 'Sended by: '.$manager->login.$br;
 
				// Upload Document
				if(!empty($this->guest_info->files))
				{
					$file_path = '';
					if($this->guest_info->us_citizen == 1 && !empty($this->guest_info->files['usa_selfie']))
						$file_path = 'files/users_files/'.$this->guest_info->id.'/'.$this->guest_info->files['usa_selfie'];

					elseif($this->guest_info->us_citizen == 2 && !empty($this->guest_info->files['selfie']))
						$file_path = 'files/users_files/'.$this->guest_info->id.'/'.$this->guest_info->files['selfie'];


					/*if(!empty($file_path))
					{
						$r = $this->upload_tenant_document($response->id, $file_path);

						if($r->uploaded == true)
						{
							$log_value .= 'Tenant Document: Uploaded';
						}						
					}*/
				}

				// Add log
				$this->logs->add_log(array(
					'parent_id' => $this->guest_info->id, 
					'type' => 5, 
					'subtype' => 1, 
					'user_id' => $this->guest_info->id, 
					'sender_type' => 1,
					'value' => $log_value
				));


			}


			

			//return $response->id;
			return 'Data sent successfully';
		}
		else
		{
			// if(isset($response->errors))
			// 	return $response->errors['message'];

			// return false;
		}
		return $response;
	}


	public function get_ongoing_applications()
	{
		$curl = curl_init();

		// $params = array(
		// 	'limit' => 100,
		// 	//'tenantName' => 'ALex Guesterson'
		// 	'search' => array(
		// 		'email' => 'alex_g@hard.code'
		// 	)
		// );

		curl_setopt($curl, CURLOPT_URL, $this->request_url.'/api/rest_v1/landlords/'.$this->company_id.'/ongoing-applications?limit=100&search[email]=adewoleadediwura@gmail.com');
		$headers[] = 'Content-Type: application/json';
		$headers[] = 'Authorization: Bearer '.$this->auth_token;
		curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		// curl_setopt($curl, CURLOPT_POST, true);
		curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);

		//curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($params));
		$json = curl_exec($curl);
		$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);

		curl_close($curl);
		$response = json_decode($json);

		print_r($response); exit;
	}


	public function get_under_lease_tenants()
	{
		$curl = curl_init();

		// $params = array(
		// 	'limit' => 100
		// );



		curl_setopt($curl, CURLOPT_URL, $this->request_url.'/api/rest_v1/landlords/'.$this->company_id.'/under-lease-tenants?limit=100');
		$headers[] = 'Content-Type: application/json';
		$headers[] = 'Authorization: Bearer '.$this->auth_token;
		curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		// curl_setopt($curl, CURLOPT_POST, true);
		curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);

		//curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($params));
		$json = curl_exec($curl);
		$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);

		//print_r($http_status); exit;

		curl_close($curl);
		$response = json_decode($json);

		print_r($response); exit;

	}


	public function get_tenants_post_lease()
	{
		$curl = curl_init();

		// $params = array(
		// 	'limit' => 100
		// );

		curl_setopt($curl, CURLOPT_URL, $this->request_url.'/api/rest_v1/landlords/'.$this->company_id.'/post-lease-tenants?limit=100');
		$headers[] = 'Content-Type: application/json';
		$headers[] = 'Authorization: Bearer '.$this->auth_token;
		curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		// curl_setopt($curl, CURLOPT_POST, true);
		curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);

		//curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($params));
		$json = curl_exec($curl);
		$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);

		//print_r($http_status); exit;

		curl_close($curl);
		$response = json_decode($json);

		print_r($response); exit;

	}


	public function get_legacy_lease_tenants()
	{

		$curl = curl_init();

		// $params = array(
		// 	'limit' => 100
		// );

		curl_setopt($curl, CURLOPT_URL, $this->request_url.'/api/rest_v1/landlords/'.$this->company_id.'/legacy-lease-tenants?limit=100');
		$headers[] = 'Content-Type: application/json';
		$headers[] = 'Authorization: Bearer '.$this->auth_token;
		curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		// curl_setopt($curl, CURLOPT_POST, true);
		curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);

		//curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($params));
		$json = curl_exec($curl);
		$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);

		//print_r($http_status); exit;

		curl_close($curl);
		$response = json_decode($json);

		print_r($response); exit;

	}

	
	public function upload_tenant_document($tenant_id, $file_path)
	{
		if(empty($file_path) || empty($tenant_id))
			return false;

		if(!file_exists($file_path))
			return false;

		$img = file_get_contents($file_path); 
		$data = base64_encode($img);

		$params = array(
			'type' => 'selfie',
			'document' => $data
		);

		$curl = curl_init();
		curl_setopt($curl, CURLOPT_URL, $this->request_url.'/api/rest_v1/landlords/'.$this->company_id.'/tenants/'.$tenant_id.'/documents');

		$headers[] = 'Content-Type: application/json';
		$headers[] = 'Authorization: Bearer '.$this->auth_token;
		curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_POST, true);
		curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);
		curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($params));

		$json = curl_exec($curl);
		$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);

		curl_close($curl);
		$response = json_decode($json);

		/*if($http_status == 200)
		{
			return $response;
		}
		else
		{
			return $response;
		}*/
		return $response;

	}


	public function get_tenant($tenant_id)
	{
		if(empty($tenant_id))
			return false;

		// 6654daabdaf2f2


		$params = array();
		$params['id'] = $tenant_id;

		$curl = curl_init();
		//curl_setopt($curl, CURLOPT_URL, $this->request_url.'/api/rest_v1/landlords/'.$this->company_id.'/tenants/'.$tenant_id.'');


		curl_setopt($curl, CURLOPT_URL, $this->request_url.'/api/rest_v1/landlords/'.$this->company_id.'/properties/2da70fad74babf/tenants');

		$headers[] = 'Content-Type: application/json';
		$headers[] = 'Authorization: Bearer '.$this->auth_token;
		curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_POST, true);
		curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);
		curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($params));

		$json = curl_exec($curl);
		$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);

		curl_close($curl);
		$response = json_decode($json);

		/*if($http_status == 200)
		{
			return $response;
		}
		else
		{
			return $response;
		}*/
		return $response;

	}


	public $application_statuses = array(
		'S_00' => array(
			'status' => 'Pending',
			'status_id' => 2,
			'description' => 'In Progress'
		),
		'S_01' => array(
			'status' => 'Pending',
			'status_id' => 2,
			'description' => 'Pending'
		),
		'S_02' => array(
			'status' => 'Declined',
			'status_id' => 3,
			'description' => 'Security Deposit Declined'
		),
		'S_03' => array(
			'status' => 'Closed',
			'status_id' => 4,
			'description' => 'Closed - Tenant not interested'
		),
		'S_04' => array(
			'status' => 'Closed',
			'status_id' => 4,
			'description' => 'Closed - Tenant took different apartment'
		),
		'S_05' => array(
			'status' => 'Closed',
			'status_id' => 4,
			'description' => 'Closed - Tenant is not responding'
		),
		'S_06' => array(
			'status' => 'Closed',
			'status_id' => 4,
			'description' => 'Closed - NA'
		),
		'S_07' => array(
			'status' => 'Closed',
			'status_id' => 4,
			'description' => 'Closed - Tenant was refunded'
		),
		'S_08' => array(
			'status' => 'Closed',
			'status_id' => 4,
			'description' => 'Closed - Declined by Landlord'
		),
		'S_09' => array(
			'status' => 'Closed',
			'status_id' => 4,
			'description' => 'Closed - Application not affordable'
		),
		'S_10' => array(
			'status' => 'Pending',
			'status_id' => 2,
			'description' => 'Pending Tenant Pmt. Details'
		),
		'S_11' => array(
			'status' => 'Pending',
			'status_id' => 2,
			'description' => 'Pending Tenant Signature Agreement'
		),
		'S_12' => array(
			'status' => 'Pending',
			'status_id' => 2,
			'description' => 'Pending Approval'
		),
		'S_13' => array(
			'status' => 'Pending',
			'status_id' => 2,
			'description' => 'Pending Tenant Plan Review'
		),
		'S_14' => array(
			'status' => 'Pending',
			'status_id' => 2,
			'description' => 'Withdrawing Tenant Funds'
		),
		'S_15' => array(
			'status' => 'Pending',
			'status_id' => 2,
			'description' => 'Pending Security Deposit Deployment'
		),
		'S_16' => array(
			'status' => 'Pending',
			'status_id' => 2,
			'description' => 'Deploying Landlord Funds'
		),
		'S_17' => array(
			'status' => 'Funded',
			'status_id' => 5,
			'description' => 'Security Deposit Funded'
		),
		'S_18' => array(
			'status' => 'Closed',
			'status_id' => 4,
			'description' => 'Lease Ended'
		),
		'S_19' => array(
			'status' => 'Closed',
			'status_id' => 4,
			'description' => 'Contract Ended'
		),
		'S_20' => array(
			'status' => 'Declined',
			'status_id' => 3,
			'description' => 'Declined'
		)
		
	);

}