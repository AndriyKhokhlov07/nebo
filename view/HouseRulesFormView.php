<?PHP
require_once('View.php');


require_once 'api/dompdf/lib/html5lib/Parser.php';
require_once 'api/dompdf/src/Autoloader.php';
Dompdf\Autoloader::register();

use Dompdf\Dompdf;
use Dompdf\Options;


class HouseRulesFormView extends View
{

	public $user;

	function fetch()
	{
		$user = new stdclass;

		$hash = $this->request->get('h', 'string');
		$status_success = $this->request->get('success', 'string');

		$salesflow_id = $this->request->get('s');
		if(!empty($salesflow_id))
		{
			$this->salesflows->check_salesflow_status(intval($salesflow_id));
			$salesflow = $this->salesflows->get_salesflows(['id'=>intval($salesflow_id), 'limit'=>1]);
			$this->design->assign('salesflow', $salesflow);
		}

		if(!empty($hash))
		{

			$user = $this->users->get_user_code($hash);
			if(!empty($user))
			{
				$_SESSION['user_id'] = $user->id;

				if(empty($_SESSION['admin']))
				{
				 	// Add log
					$this->logs->add_log(array(
						'parent_id'=> $user->id, 
						'type' => 17, // House Rules
						'subtype' => 2, // Viewed
						'user_id' => $user->id, 
						'sender_type' => 3 // User
					));
				}

				if(!empty($salesflow))
					header('Location: '.$this->config->root_url.'/user/house_rules_form?s='.$salesflow->id);
				else
					header('Location: '.$this->config->root_url.'/user/house_rules_form');

				exit;
			}
			return false;
		}
		

		
		
		if(isset($_SESSION['user_id']) || !empty($salesflow))
		{
			$user_id = $_SESSION['user_id'] ?? $salesflow->user_id;
			$user = $this->users->get_user(intval($user_id));

			if(empty($user))
				return false;

			$this->user = $user;

			if(!empty($user->blocks))
			{
				$user_blocks = (array) unserialize($user->blocks);

				// Form was submitted earlier
				if(!empty($user_blocks['house_rules_form']) && $status_success != 'sended')
				{
					if(!empty($salesflow))
						header('Location: '.$this->config->root_url.'/user/house_rules_form?success=sended&s='.$salesflow->id);
					else
						header('Location: '.$this->config->root_url.'/user/house_rules_form?success=sended');
					exit;
				}
			}


			$booking = current($this->beds->get_bookings([
				'id' => $salesflow->booking_id,
				'sp_group' => true,
				'sp_group_from_start' => true
			]));

			if (!empty($booking)) {
				if ($house = $this->pages->get_page((int)$booking->house_id)) {
					if (!empty($house->blocks)) {
						$house->blocks = @unserialize($house->blocks);
					}
					if (!empty($house->blocks2)) {
						$house->blocks2 = @unserialize($house->blocks2);
					}
					$this->design->assign('house', $house);
				}
                $booking->days_count = date_diff(date_create($booking->arrive), date_create($booking->depart))->days + 1;
                $this->design->assign('booking', $booking);


                // Invoice
                $invoices = $this->orders->get_orders([
                    'booking_id' => $booking->id,
                    'deposit' => 0,
                    'not_label'=> 5
                ]);
                if (!empty($invoices)) {
                    ksort($invoices);
                    foreach ($invoices as $inv)
                    {
                        if(!empty($inv->date_from) && empty($invoice))
                            $invoice = $inv;
                    }
                    $this->design->assign('invoice', $invoice);
                }

			}

			

			if($this->request->method('post'))
			{
				$u = new stdclass;
				
				if(!empty($user->blocks))
				{
					$u->blocks = (array) unserialize($user->blocks);
				}

				$u->blocks['house_rules_form'] = 1;

				$u->blocks = serialize($u->blocks);


				if(!empty($_POST['signature']))
				{
					if(!file_exists($this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/'))
						mkdir($this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/', 0755);
					
					// Signature
					$img = $_POST['signature'];
					$img = str_replace('data:image/png;base64,', '', $img);
					$img = str_replace(' ', '+', $img);
					$data = base64_decode($img);
					$file = $this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/house_rules_signature.png';
					$success = file_put_contents($file, $data);
					chmod($this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/house_rules_signature.png', 0755);
				}

				if(file_exists($this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/house_rules_signature.png'))
					$signature = $this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/house_rules_signature.png';

				$this->users->update_user($user->id, $u);

				$user = $this->users->get_user((int)$user->id);

				$options = new Options();
				$options->set('defaultFont', 'Helvetica');

				// instantiate and use the dompdf class
				$dompdf = new Dompdf($options);

				$this->design->assign('user', $user);
				$this->design->assign('signature', $signature);


				$pdf_html = $this->design->fetch('house_rules/html.tpl');

				$dompdf->loadHtml($pdf_html);

				// (Optional) Setup the paper size and orientation ("landscape" or "portrait")
				$dompdf->setPaper('A4', 'portrait'); 

				// Render the HTML as PDF
				$dompdf->render();

				// Output the generated PDF to Browser
				$stream_options = array();
				$stream_options['save_path'] = $this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/';
				$dompdf->stream('house_rules.pdf', $stream_options);


				// Add log
				$add_log_id = $this->logs->add_log(array(
					'parent_id'=> $user->id, 
					'type' => 17, // House Rules
					'subtype' => 3, // Sign
					'user_id' => $user->id, 
					'sender_type' => 3 // User
				));

				$this->salesflows->update_salesflow($user->active_salesflow_id, ['house_rules_status'=>1]);

				if (!empty($salesflow)) {

                    // hotel / deposit: hellorented (qira)
                    // if ($salesflow->type == 3 && $salesflow->deposit_type == 2) {
                    //    $q_deposit = $this->hellorented->invite_tenant($user->id, null, $salesflow->booking_id);
                    //}

                    header('Location: '.$this->config->root_url.'/user/house_rules_form?success=sended&s='.$salesflow->id);
                } else {
                    header('Location: '.$this->config->root_url.'/user/house_rules_form?success=sended');
                }
				exit;
			}

			if(file_exists($this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/house_rules_signature.png'))
				$signature = $this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/house_rules_signature.png';

		}
		else
			return false;


		if(!empty($user->blocks))
			$user->blocks = (array) unserialize($user->blocks);
		else
			$user->blocks = array();




		$this->design->assign('user', $user);
		if(!empty($signature))
			$this->design->assign('signature', $signature);

		echo $this->design->fetch('house_rules/page.tpl'); exit;
	}
}