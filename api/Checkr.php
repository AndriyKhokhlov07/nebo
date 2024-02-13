<?php

require_once('Backend.php');

class Checkr extends Backend
{
	// test keys
	// private $secret_key = 'dd27978f23660b619f5794f4f7112c9c3238cf37';
	// private $publishable_token = '352dfa1e7b8da7138960299bb3d91f20facac95e';

	// live keys
	private $secret_key = '6f6a72a73e7316a94492fdd52ada0633eaf4606f';
	private $publishable_token = 'd41ec3ed12a43caf402457cb286a4ff509ae6aa9';


	private $auth_token;


	public function __construct()
	{
		
	}


	public function authenticate()
	{
		$curl = curl_init();
		curl_setopt($curl, CURLOPT_URL, 'https://api.checkr.com');
		curl_setopt($curl, CURLOPT_USERPWD, $this->secret_key.":");
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_POST, true);
		curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);


		//curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($candidate_params));

		$json = curl_exec($curl);
		print_r($json); exit;

		$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);

		curl_close($curl);

		echo "status:" . $http_status . "\n" . $json . "\n\n";
		$response = json_decode($json);

		print_r($response); exit;
	}



	public function create_candidate($user_id)
	{
		if(empty($user_id))
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
					|| empty($user->zip)
					|| empty($user->birthday)
					|| empty($user->social_number)
					|| $user->us_citizen != 1
				)
					return false;


				if($user->us_citizen == 1)
				{
					$candidate_params = array();
					$candidate_params['first_name'] = $user->first_name;
					if(!empty($user->middle_name))
					{
						$candidate_params['middle_name'] = $user->middle_name;
						//$candidate_params['no_middle_name'] = false;
					}
					else
						$candidate_params['no_middle_name'] = true;
					$candidate_params['last_name'] = $user->last_name;
					$candidate_params['email'] = $user->email;
					$candidate_params['phone'] = $user->phone;
					$candidate_params['zipcode'] = base64_decode($user->zip);
					$candidate_params['dob'] = $user->birthday;
					$candidate_params['ssn'] = base64_decode(base64_decode($user->social_number));

					if(!empty($user->checker_options))
					{
						$user_upd = new stdClass;
						$user_checker_options = (array) unserialize($user->checker_options);
						if($user_checker_options['to_check'] == 1)
						{
							if($user_checker_options['california_app'] == 1 || $user_checker_options['washington_app'] == 1)
								$candidate_params['copy_requested'] = true;


							$curl = curl_init();
							//curl_setopt($curl, CURLOPT_URL, 'https://api.checkr.io/v1/candidates');
							curl_setopt($curl, CURLOPT_URL, 'https://api.checkr.com/v1/candidates');
							curl_setopt($curl, CURLOPT_USERPWD, $this->secret_key.":");
							curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
							curl_setopt($curl, CURLOPT_POST, true);
							curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);
							curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($candidate_params));
							$json = curl_exec($curl);

							$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
							curl_close($curl);

							if(($http_status == 200 || $http_status == 201) && !empty($json))
							{
								$response = json_decode($json);
								if(!empty($response->id))
								{
									
									$user_upd->checkr_candidate_id = $response->id;
									$user_checker_options['candidate_created_at'] = date('Y-m-d h:i:s', strtotime($response->created_at));

									$curl = curl_init();
									curl_setopt($curl, CURLOPT_URL, 'https://api.checkr.com/v1/reports');
									curl_setopt($curl, CURLOPT_USERPWD, $this->secret_key.":");
									curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
									curl_setopt($curl, CURLOPT_POST, true);
									curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);
									curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query(
										array(
											'package' => 'tenant_basic',
											'candidate_id' => $response->id
										)
									));

									$json = curl_exec($curl);
									$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
									curl_close($curl);
									if(($http_status == 200 || $http_status == 201) && !empty($json))
									{
										$response_report = json_decode($json);
										if(!empty($response_report->id))
										{
											// satuses: clear, consider, pending, suspended
											$user_checker_options['reports'][$response_report->id]['status'] = $response_report->status;
											if($response_report->status == 'pending')
											{
												$user_checker_options['reports'][$response_report->id]['pending_at'] = date('Y-m-d h:i:s', strtotime($response_report->created_at));
											}											
										}
										
									}

									if(!empty($user_checker_options))
										$user_upd->checker_options = serialize($user_checker_options);



									$this->users->update_user($user->id, $user_upd);


								}

							
								
							}
							elseif(!empty($_SESSION['admin']))
							{
								//echo $http_status; exit;
							}

						}
					}
					
					

				}

			
			}
		}
	}

	
}
