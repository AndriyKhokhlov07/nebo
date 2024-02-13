<?php

require_once('Backend.php');

class Ekata extends Backend
{
	private $apikey = 'dd642958ab6b4a11b5c9698fc83722ef';
	// private $apikey = '387e084de6ce4f9eaaeab78599f4fdf8';


	public $statuses = array(
		1 => 'Accept',
		2 => 'Low Accept',
		3 => 'Decline'
	);


	public function get_status($params = array())
	{
		if(isset($params['value']) && isset($params['type']))
		{
			$status = new stdClass;
			$val = (float)$params['value'];
			if($params['type'] == 'identity_network_score')
			{
				if($val >= 0.9)
					$status->code = 3;
				// elseif($val > 0.65)
				// 	$status->code = 2;
				else
					$status->code = 1;
			}
			elseif($params['type'] == 'identity_check_score')
			{
				if($val >= 400)
					$status->code = 3;
				// elseif($val > 300)
				// 	$status->code = 2;
				else
					$status->code = 1;
			}
			$status->name = $this->statuses[$status->code];

			return $status;
		}
	}


	// Identity Check
	public function identity_check($params = array())
	{

		if(empty($params['user_id']))
			return false;

		$user = $this->users->get_user((int)$params['user_id']);

		if(!empty($user))
		{
			if(empty($user->first_name) || empty($user->last_name) || (empty($user->phone) && empty($user->email)))
			{
				return false;
			}

			if(!empty($user->blocks))
				$user->blocks = unserialize($user->blocks);
			else
				$user->blocks = array();


			$user_name = $user->first_name;
			if(!empty($user->middle_name))
				$user_name .= ' '.$user->middle_name;
			$user_name .= ' '.$user->last_name;


			

			// Name
			$url_params = '&primary.name='.urlencode($user_name);

			// Phone
			if(!empty($user->phone))
				$url_params .= '&primary.phone='.urlencode($user->phone);

			// Email
			$isset_email = 0;
			if(!empty($user->email))
			{
				if(!strpos($user->email, '@guest.airbnb.com'))
				{
					$url_params .= '&primary.email_address='.urlencode($user->email);
					$isset_email = 1;
				}
			}

			// Address
			if(!empty($user->street_address))
			{
				$url_params .= '&primary.address.street_line_1='.urlencode($user->street_address);

				if(!empty($user->apartment))
					$url_params .= '&primary.address.street_line_2='.urlencode($user->apartment);
			}

			// City
			if(!empty($user->city))
				$url_params .= '&primary.address.city='.urlencode($user->city);

			// State code
			if(!empty($user->state_code))
				$url_params .= '&primary.address.state_code='.urlencode($user->state_code);


			// ZIP
			if(!empty($user->zip))
				$url_params .= '&primary.address.postal_code='.urlencode(base64_decode($user->zip));

			// Country code (US)
			if($user->us_citizen == 1)
				$url_params .= '&primary.address.country_code=US';
			




			if($isset_email == 1 || !empty($user->phone))
			{

				$ch = curl_init();
				curl_setopt($ch, CURLOPT_URL, 'https://api.ekata.com/3.3/identity_check?api_key='.$this->apikey.$url_params);
				//curl_setopt($ch, CURLOPT_URL, 'https://api.ekata.com/4.0/location_intel?api_key='.$this->apikey.$url_params);

				curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);


				if(!$result_data = curl_exec($ch))
				   trigger_error(curl_error($ch));
				curl_close($ch);

				$result = json_decode($result_data);

				if(!empty($result))
				{
					// Add log
					$br = '
';		
					$log_value = 'Network score: '.$result->identity_network_score.$br;
					$log_value .= 'Check score: '.$result->identity_check_score;

					if(!empty($user->phone))
					{
						$log_value .= $br;
						$log_value .= 'Phone check: ';
						if($result->primary_phone_checks->is_valid != 1)
							$log_value .= 'Not valid';
						else
						{
							$log_value .= $result->primary_phone_checks->country_code.' ';
							$log_value .= $result->primary_phone_checks->line_type;
						}
						
					}

					
					$log_params = array();
					$log_params['parent_id'] = $user->id;
					$log_params['type'] = 9;
					$log_params['subtype'] = 1;
					$log_params['user_id'] = $user->id;
					$log_params['sender_type'] = 1; // System
					$log_params['value'] = $log_value;
					$log_params['data'] = serialize($result);

					if(!empty($params['sender_type']))
					{
						$log_params['sender_type'] = $params['sender_type'];
						if(!empty($params['sender']))
							$log_params['sender'] = $params['sender'];
					}

					$this->logs->add_log($log_params);


					$user->blocks['ekata_network_score'] = $result->identity_network_score;
					$user->blocks['ekata_check_score'] = $result->identity_check_score;
					if(!empty($user->phone))
					{
						if($result->primary_phone_checks->is_valid != 1)
							$user->blocks['ekata_phone_check'] = 'not_valid';
						else
							$user->blocks['ekata_phone_check'] = strtolower($result->primary_phone_checks->line_type);
					}

					$this->users->update_user($user->id, array(
						'blocks' => serialize($user->blocks)
					));

					return $result;
				}

			}

		}
		else
		{
			// echo 'no user';
		}

	}

	
}