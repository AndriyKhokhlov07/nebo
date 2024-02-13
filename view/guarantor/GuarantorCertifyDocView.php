<?PHP

require_once('view/View.php');



require_once 'api/dompdf/lib/html5lib/Parser.php';
// require_once 'api/dompdf/lib/php-font-lib/src/FontLib/Autoloader.php';
// require_once 'api/dompdf/lib/php-svg-lib/src/autoload.php';
require_once 'api/dompdf/src/Autoloader.php';
Dompdf\Autoloader::register();

use Dompdf\Dompdf;
use Dompdf\Options;


class GuarantorCertifyDocView extends View
{

	public $user;

	private function download_doc()
	{

		$this->design->assign('states', $this->users->states);
		$this->design->assign('user', $this->user);

		$this->design->assign('user_type', 'guarantor');
		$user_check_html = $this->design->fetch('guarantor/application_pdf.tpl');

		



		
		$options = new Options();
		$options->set('defaultFont', 'Helvetica');

		// instantiate and use the dompdf class
		$dompdf = new Dompdf($options);


		$dompdf->loadHtml($user_check_html);

		// (Optional) Setup the paper size and orientation ("landscape" or "portrait")
		$dompdf->setPaper('A4', 'portrait'); 

		// Render the HTML as PDF
		$dompdf->render();
		// $dompdf->stream();

		$canvas = $dompdf->get_canvas();
		$font = $dompdf->getFontMetrics()->get_font("helvetica", "italic");

		// Output the generated PDF to Browser
		$stream_options = [
			'save_path' => $this->config->users_files_dir.$this->user->id.'/'
		];
		$dompdf->stream('guarantor_application.pdf', $stream_options);

		echo '<base href="'.$this->config->root_url.'"/>';
		echo $user_check_html; exit;


		//return $this->design->fetch('guarantor/download_application.tpl');
	}

	public function fetch()
	{
		$user = new stdclass;
		$auth_code = $this->request->get('auth_code', 'string');
		$action = $this->request->get('a', 'string');

		if(!empty($auth_code))
		{
			$user = $this->users->get_user_code($auth_code);
			if(!empty($user))
			{
				header('Location: '.$this->config->root_url.'/guarantor/certify_doc');
				exit;
			}
			return false;
		}
		

		if(isset($_SESSION['user_id']))
		{
			$user_id = (int)$_SESSION['user_id'];
			if(!empty($user_id))
			{
				$user = $this->users->get_user(intval($_SESSION['user_id']));
			}
			if(empty($user))
				 return false;


			$salesflow = $this->salesflows->get_salesflows([
				'id' => $user->active_salesflow_id, 
				'limit' => 1
			]);

			if(!empty($salesflow))
			{
				if(!empty($salesflow->application_data))
					$salesflow->application_data = unserialize($salesflow->application_data);
	 
	 			if(!empty($salesflow->additional_files))
					$salesflow->additional_files = unserialize($salesflow->additional_files);


				if($salesflow->application_type == 1 && !empty($user->id) && (empty($salesflow->additional_files) || empty($salesflow->application_data)))
				{
					if(empty($salesflow->application_data))
					{
						$prev_salesflow = $this->salesflows->get_salesflows([
							'user_id' => $user->id, 
							'not_empty_data' => 1, 
							'limit' => 1
						]);
						if(!empty($prev_salesflow) && !empty($prev_salesflow->application_data))
							$salesflow->application_data = unserialize($prev_salesflow->application_data);
					}

					if(empty($salesflow->additional_files))
					{
						$prev_salesflow = $this->salesflows->get_salesflows([
							'user_id' => $user->id, 
							'not_empty_add_files' => 1, 
							'limit' => 1
						]);
						if(!empty($prev_salesflow) && !empty($prev_salesflow->application_files))
							$salesflow->additional_files = unserialize($prev_salesflow->additional_files);
					}
				}


				if(!empty($salesflow->application_data['social_number']))
					$salesflow->application_data['social_number'] = base64_decode(base64_decode($salesflow->application_data['social_number']));

				if(!empty($salesflow->application_data['zip']))
					$salesflow->application_data['zip'] = base64_decode($salesflow->application_data['zip']);





				$uu = $this->users->get_users_users([
					'type' => 1, // Guarantor
					'child_id' => $user->id,
					'order_by' => 'parent_id_desc',
					'limit' => 1,
					'count' => 1
				]);
				if(!empty($uu))
				{
					$user->tenant = $this->users->get_user((int)$uu->parent_id);
					if(!empty($user->tenant))
					{
						$booking = $this->beds->get_bookings(array(
							'id' => $user->tenant->active_booking_id,
							'limit' => 1
						));



						if(!empty($booking))
						{
							// House
							if(!empty($booking->house_id))
							{
								if($house = $this->pages->get_page((int)$booking->house_id))
								{
									if(!empty($house->blocks2))
										$house->blocks2 = unserialize($house->blocks2);
									$booking->house = $house;
									unset($house);
								}
							}

							// Apartment
							if(!empty($booking->apartment_id))
							{
								$booking->apartment = $this->beds->get_apartments(array(
									'id' => $booking->apartment_id, 
									'limit' => 1
								));
							}

							// Contract
							$contracts = $this->contracts->get_contracts(array(
								'reserv_id' => $booking->id, 
								'limit' => 1
							));
							if(!empty($contracts))
							{
								$user->contract = current($contracts);
								unset($contracts);
							}

							// Apartment booking
							// if($booking->type == 2)
							// {

								$price_month = 1000;
								if(!empty($user->contract) && !empty($user->contract->price_month))
									$price_month = $user->contract->price_month;
								elseif(!empty($booking->price_month))
									$price_month = $booking->price_month;
								$booking->calculate = $this->contracts->calculate($booking->arrive, $booking->depart, $price_month);


								if($bookings_users_ids = $this->beds->get_bookings_users(array('booking_id'=>$booking->id)))
								{
									$bookings_users = $this->request->array_to_key($bookings_users_ids, 'user_id');
									$booking->users_count = count($bookings_users_ids);
								}

								$user->price_month = 0;
								if(!empty($user->contract) && !empty($user->contract->price_month))
									$user->price_month = $user->contract->price_month;
								elseif(!empty($booking->price_month))
									$user->price_month = $booking->price_month;


							// }

							$user->booking = $booking;
							// unset($booking);
						}



					}
				}

			}

			$user->sign_log = $this->logs->get_logs([
	            'type' => 14, // User Check
	            'subtype' => 3, // Sign
	            'user_id' => $user->id,
	            'sort' => true,
	            'count' => 1
			]);



			
			$this->user = $user;

			$this->design->assign('salesflow', $salesflow);

			if($action == 'upload')
			{

			}
			else
			{
				return $this->download_doc();
			}

		}
		
	}
}