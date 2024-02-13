<?php

require_once('Backend.php');

class Transunion extends Backend
{
	// Mode: sandbox, production
	private $mode = 'production'; 
	

	private $member_name = 'outpostclub';
	//private $password = 'd975!7yN1';
	private $password = 'hHDGydyejjYhweeXX2402';


	private $property_id = '1692e39f71'; 
	private $source_id = '1e';
	private $source_ref = 0;
	private $response_url;

	private $request_url = 'https://creditretriever.transunion.com/gateway/creditapp.ashx';
	private $complited_results_url = 'https://creditretriever.transunion.com/gateway/GetFullXmlHistorical.ashx';

	// private $request_url = 'https://residentscreening.transunion.com/gateway/creditapp.ashx';
	// private $complited_results_url = 'https://residentscreening.transunion.com/gateway/GetFullXmlHistorical.ashx';
	private $guest_info;
	// public $statuses;


	public function __construct()
	{
		$this->response_url = $this->config->root_url.'/request/transunion/callback.php';
		
		// local
		if($this->config->host == 'dev')
			$this->response_url = 'https://ne-bo.com/request/transunion/callback.php';

		if($this->mode == 'sandbox')
		{
			$this->request_url = 'https://crexternal.turss.com/gateway/creditapp.ashx';
			$this->complited_results_url = 'https://crexternal.turss.com/Gateway/GetFullXmlHistorical.ashx';

			$this->member_name = 'outpostclub';
			$this->password = '06.L8.Zoz0!';

			$this->property_id = '1b98eb9b';
			$this->source_id = '1e';
		}
	}



	public $statuses = array(
		1 => 'Accept',
		2 => 'Low Accept',
		3 => 'Conditional',
		4 => 'Decline',
		5 => 'Refer',
		6 => 'Pending',
		7 => 'Error'
	);


	public function get_xml()
	{


		$xml = '<gateway>';
    		$xml .= '<version>4</version>';
		    $xml .= '<agent>';
		        $xml .= '<memberName>'.$this->member_name.'</memberName>';
		        $xml .= '<password>'.$this->password.'</password>';
		        $xml .= '<propertyId>'.$this->property_id.'</propertyId>';
		        $xml .= '<sourceId>'.$this->source_id.'</sourceId>';
		        $xml .= '<responseURL>'.$this->response_url.'</responseURL>';
		    $xml .= '</agent>';
		    $xml .= '<application>';
		    	if(!empty($this->source_ref))
		        	$xml .= '<sourceRef>'.$this->source_ref.'</sourceRef>';
		        $xml .= '<rentAmount>'.($this->guest_info->price_month*1).'</rentAmount>';
		        $xml .= '<depositAmount>'.($this->guest_info->price_deposit*1).'</depositAmount>';
		        $xml .= '<leaseTerm>'.$this->guest_info->lease_term.'</leaseTerm>';
		        if(!empty($this->guest_info->booking->apartment))
		        	$xml .= '<unit>'.$this->guest_info->booking->apartment->name.'</unit>';

		        if($this->guest_info->booking->house->blocks2 && !empty($this->guest_info->booking->house->blocks2['street_address']))
		        {
		        	if(strlen($this->guest_info->booking->house->blocks2['street_address']) > 0 && strlen($this->guest_info->booking->house->blocks2['street_address']) < 21)
		        		$xml .= '<building>'.$this->guest_info->booking->house->blocks2['street_address'].'</building>';
		        }
		        
		        // $xml .= '<guestCard>19</guestCard>';
		        $xml .= '<photoIdVerified>1</photoIdVerified>';
		        $xml .= '<applicants>';
		            $xml .= '<applicant>';
		                $xml .= '<applicantType>1</applicantType>';

		                $xml .= '<firstName>'.$this->guest_info->first_name.'</firstName>';
		                if(!empty($this->guest_info->middle_name))
		                	$xml .= '<middleName>'.$this->guest_info->middle_name.'</middleName>';
		                $xml .= '<lastName>'.$this->guest_info->last_name.'</lastName>';
		                $xml .= '<dateOfBirth>'.$this->guest_info->birthday.'</dateOfBirth>';
		                $xml .= '<streetAddress>'.$this->guest_info->street_address.'</streetAddress>';
		                $xml .= '<city>'.$this->guest_info->city.'</city>';
		                $xml .= '<state>'.$this->guest_info->state_code.'</state>';
		                $xml .= '<postalCode>'.base64_decode($this->guest_info->zip).'</postalCode>';
		                $xml .= '<ssn>'.base64_decode(base64_decode($this->guest_info->social_number)).'</ssn>';
		                $xml .= '<employmentStatus>'.$this->guest_info->employment_status.'</employmentStatus>';
		                $xml .= '<employmentIncome>'.$this->guest_info->employment_income.'</employmentIncome>';
		                $xml .= '<employmentIncomePeriod>2</employmentIncomePeriod>';
		                // $xml .= '<otherIncome>0</otherIncome>';
		                // $xml .= '<otherIncomePeriod>1</otherIncomePeriod>';
		                // $xml .= '<assets>0</assets>';
		                
		            $xml .= '</applicant>';
		        $xml .= '</applicants>';
		    $xml .= '</application>';
		$xml .= '</gateway>';

		return $xml;
	}


	public function create_application($user_id)
	{
		$r = new stdClass;

		$result = false;

		if(empty($user_id))
			return false;

		$this->guest_info = $this->users->get_user((int)$user_id);
		if(empty($this->guest_info))
			return false;

		// if(!empty($this->guest_info->transunion_id))
		// 	return 'Guest data has already been sent before';


		if(empty($this->guest_info->active_booking_id))
			return 'No active booking';

		// elseif(!empty($this->guest_info->files))
		// {
		// 	$this->guest_info->files = unserialize($this->guest_info->files);

		// 	if(empty($this->guest_info->files['usa_doc']))
		// 		return 'Missing photo of Passport / ID / Driver licence';
		// 	elseif(empty($this->guest_info->files['usa_selfie']))
		// 		return 'Missing Selfie with doc';
		// }
		// else
		// 	return 'Missing photo of documents';

		// Old code
		// $booking = $this->beds->get_beds_journal(array(
		// 	'id' => $this->guest_info->active_booking_id, 
		// 	'limit' => 1
		// ));

		// New code
		$booking = $this->beds->get_bookings(array(
			'id' => $this->guest_info->active_booking_id, 
			'limit' => 1,
			'sp_group' => true,
			'sp_group_from_start' => true
		));

		if(empty($booking))
			return 'No booking';

		if(!isset($booking->type))
			$booking->type = 1;

		if(!empty($booking->arrive))
			$this->guest_info->arrive = $booking->arrive;

		if(!empty($booking->depart))
			$this->guest_info->depart = $booking->depart;

		if(!empty($booking->price_month))
			$this->guest_info->price_month = $booking->price_month;

		if(!empty($booking->total_price))
			$this->guest_info->total_price = $booking->total_price;

		if($booking->type == 1) // bed booking
		{
			$booking->bed = $this->beds->get_beds(array(
				// 'id' => $booking->bed_id, // Old code
				'id' => $booking->object_id, // New code
				'limit' => 1
			));

			if(!empty($booking->bed))
			{
				if(!empty($booking->bed->room_id))
				{
					$booking->room = $this->beds->get_rooms(array(
						'id' => $booking->bed->room_id,
						'limit' => 1
					));


					if(!empty($booking->room))
					{
						if(empty($this->guest_info->price_month) && !empty($booking->room->price3))
						{
							$this->guest_info->price_month = $booking->room->price3;
						}

						if(empty($booking->room->apartment_id))
						{
							$booking->apartment = $this->beds->get_apartments(array(
								'id' => $booking->room->apartment_id,
								'limit' => 1
							));
						}

					}
				}
				
			}
		}
		elseif($booking->type == 2) // apartment booking
		{
			$booking->apartment = $this->beds->get_apartments(array(
				'id' => $booking->object_id,
				'limit' => 1
			));

			if(!empty($booking->apartment))
			{
				if(empty($this->guest_info->price_month) && !empty($booking->apartment->price))
				{
					$this->guest_info->price_month = $booking->apartment->price;
				}
			}
		}


		if(!empty($booking->house_id))
		{
			$booking->house = $this->pages->get_page((int)$booking->house_id);
			if(!empty($booking->house) && !empty($booking->house->blocks2))
			{
				$booking->house->blocks2 = unserialize($booking->house->blocks2);
			}

		}

		if(empty($this->guest_info->employment_status))
			return 'Employment status not selected';

		if(is_null($this->guest_info->employment_income))
		{
			if($this->guest_info->employment_status == 1)
				$this->guest_info->employment_income = 1;
			else
				$this->guest_info->employment_income = 0;

		}

		$this->guest_info->booking = $booking;


		$contracts = $this->contracts->get_contracts(array(
			'reserv_id' => $this->guest_info->active_booking_id,
			'status' => 1,
			'limit' => 1
		));

		if(!empty($contracts))
		{
			$contract = current($contracts);
			
			if(!empty($contract))
			{
				$this->guest_info->contract = $contract;

				if(!empty($contract->date_from))
					$this->guest_info->arrive = $contract->date_from;

				if(!empty($contract->date_to))
					$this->guest_info->depart = $contract->date_to;

				if(!empty($contract->price_month))
					$this->guest_info->price_month = $contract->price_month;

				if(!empty($contract->total_price))
					$this->guest_info->total_price = $contract->total_price;

				$this->guest_info->price_deposit = $contract->price_deposit;

				if(empty($this->guest_info->price_deposit))
					$this->guest_info->price_deposit = $this->guest_info->price_month;


			}
		}


		$d1 = date_create($this->guest_info->arrive);
		$d2 = date_create($this->guest_info->depart);
		$interval = date_diff($d1, $d2);

		$this->guest_info->lease_term = $interval->m;
		if($interval->d > 27)
			$this->guest_info->lease_term += 1;
		if($interval->y > 0)
			$this->guest_info->lease_term += $interval->y * 12;

		if($this->guest_info->lease_term == 0)
			$this->guest_info->lease_term = 12;

		


		if($this->guest_info->price_month == 0)
			return 'Price/month in must be > 0. Look in: Booking, Contract, Bed/Apartment price';
		// if($this->guest_info->contract->price_deposit == 0)
		// 	return 'Deposit in Contract must be > 0';


		// $d1 = date_create($this->guest_info->inquiry_arrive);
		// $d2 = date_create($this->guest_info->inquiry_depart);
		// $interval = date_diff($d1, $d2);

		// $this->guest_info->inquiry_interval = $interval->m;
		// if($interval->d > 27)
		// 	$this->guest_info->inquiry_interval += 1;
		// if($interval->y > 0)
		// 	$this->guest_info->inquiry_interval += $interval->y * 12;



		// header("Content-Type: text/xml");
		// echo $this->get_xml(); 
		// exit;

		//Initiate cURL
		$curl = curl_init($this->request_url);
		 
		//Set the Content-Type to text/xml.
		curl_setopt ($curl, CURLOPT_HTTPHEADER, array("Content-Type: text/xml"));
		 
		//Set CURLOPT_POST to true to send a POST request.
		curl_setopt($curl, CURLOPT_POST, true);
		 
		//Attach the XML string to the body of our request.
		curl_setopt($curl, CURLOPT_POSTFIELDS, $this->get_xml());
		 
		//Tell cURL that we want the response to be returned as
		//a string instead of being dumped to the output.
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		 
		//Execute the POST request and send our XML.
		$res = curl_exec($curl);
		 
		//Do some basic error checking.
		if(curl_errno($curl)){
		    throw new Exception(curl_error($curl));
		}
		 
		//Close the cURL handle.
		curl_close($curl);
		 
		//Print out the response output.
		// return $result;



		if(!empty($res))
		{
			$result = simplexml_load_string($res, 'SimpleXMLElement', LIBXML_NOCDATA);




			if($result->status->statusCode == 1)
			{
				$r->status = 'succeeded';


				// Update Guest
				$user_upd = new stdClass;

				$user_upd->transunion_id = $result->application->applicationNumber;
				$user_upd->transunion_status = $result->application->scoreResult->applicationRecommendation;
				$user_upd->transunion_data = $res;


				if($user_upd->transunion_status == 1 && $this->guest_info->status < 2)
				{
					$contracts = $this->contracts->get_contracts(array('user_id'=>$this->guest_info->id, 'limit'=>1));
					if(!empty($contracts))
					{
						$contract = current($contracts);
						if($contract->signing == 1)
						{
							// Invoices
							$orders = $this->orders->get_orders(array('user_id'=>$this->guest_info->id, 'type'=>1, 'limit'=>1));
							if(!empty($orders))
							{
								$order = current($orders);
								if($order->status == 2) // Paid
								{
									$user_upd->status = 2;
								}
							}	
						}
					}
				}

				$this->users->update_user($this->guest_info->id, $user_upd);


				// Add log
				$log_value = 'Application Number: '.$result->application->applicationNumber;
				$this->logs->add_log(array(
					'parent_id' => $this->guest_info->id, 
					'type' => 6, 
					'subtype' => $user_upd->transunion_status, 
					'user_id' => $this->guest_info->id, 
					'sender_type' => 1,
					'value' => $log_value
				));
			}
			else
			{
				$r = $result->status->statusMessage;
			}
			
		}
		else
			$r = 'No request';



		


		//$user_upd->transunion_status = $result
		


		//echo $result->BackgroundReport; exit;

		// if(!empty($result->BackgroundReport))
		// {
		// 	// $html = $result->BackgroundReport;
		// 	// $html = preg_replace("/(<!DOCTYPE[^>]*[>])|(<html[^>]*[>])|(<\/html>)|(<[\/]?head>)|(<[\/]?body>)|(<title>[^<]*<\/title>)|(<meta[^>]*[>])|(body[^}]*[}])|(h1\,[^}]*[}])|(p\s[^}]*[}])|(img\s[^}]*[}])/i", '', $html);


		// 	$user_upd->transunion_data = $result;

		// }

		

		//echo $html; exit;


		return $r;
	}




}