<?PHP
require_once('View.php');


require_once 'api/dompdf/lib/html5lib/Parser.php';
require_once 'api/dompdf/src/Autoloader.php';
Dompdf\Autoloader::register();

use Dompdf\Dompdf;
use Dompdf\Options;


class CovidFormView extends View
{

	public $user;

	function fetch()
	{
		$user = new stdclass;

		$hash = $this->request->get('h', 'string');
		$status_success = $this->request->get('success', 'string');
		$contract_id = $this->request->get('c');
		$salesflow_id = $this->request->get('s');

		if(!empty($contract_id))
		{
			$contract = $this->contracts->get_contract(intval($contract_id));
		}
		$salesflow = false;
		$booking = false;
		
		if(empty($salesflow_id) && !empty($contract) && !empty($contract->reserv_id)) {
			$booking = $this->beds->get_bookings([
				'id' => $contract->reserv_id,
				'limit' => 1
			]);
			if(!empty($booking)) {
				$salesflow = $this->salesflows->get_salesflows([
					'booking_id' => $booking->id, 
					'limit' => 1
				]);
				if(!empty($salesflow)) {
					$salesflow_id = $salesflow->id;
				}
			}
		}
		if(!empty($salesflow_id))
		{
			$this->salesflows->check_salesflow_status(intval($salesflow_id));
			if(empty($salesflow)) {
				$salesflow = $this->salesflows->get_salesflows([
					'id' => intval($salesflow_id), 
					'limit' => 1
				]);
			}

			if($salesflow->type == 3)
			{
				// hotel salesflow
				$deposit_invoice = current($this->orders->get_orders(['booking_id'=>$salesflow->booking_id, 'deposit'=>1, 'limit'=>1]));
				if(!empty($deposit_invoice))
				{
					$this->design->assign('deposit_invoice', $deposit_invoice);
				}
			}
			if(empty($booking)) {
				$booking = $this->beds->get_bookings([
					'id' => $salesflow->booking_id,
					'limit' => 1
				]);
			}
			


			$this->design->assign('salesflow', $salesflow);
			$this->design->assign('booking', $booking);
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
						'type' => 8, // Covid form
						'subtype' => 2, // Viewed
						'user_id' => $user->id, 
						'sender_type' => 3 // User
					));
				}

				if(!empty($contract))
					header('Location: '.$this->config->root_url.'/user/covid_form?c='.$contract->id);
				elseif(!empty($salesflow))
					header('Location: '.$this->config->root_url.'/user/covid_form?s='.$salesflow->id);
				else
					header('Location: '.$this->config->root_url.'/user/covid_form');

				exit;
			}
			return false;
		}
		

		
		
		if(isset($_SESSION['user_id']))
		{
			$user = $this->users->get_user(intval($_SESSION['user_id']));
			if(empty($user))
				return false;

			$this->user = $user;


			if(!empty($user->blocks))
			{
				$user_blocks = (array) unserialize($user->blocks);

				// Form was submitted earlier
				if(!empty($user_blocks['covid_form']) && $status_success != 'sended')
				{
					if(!empty($contract))
						header('Location: '.$this->config->root_url.'/user/covid_form?success=sended&c='.$contract->id);
					elseif(!empty($salesflow))
						header('Location: '.$this->config->root_url.'/user/covid_form?success=sended&s='.$salesflow->id);
					else
						header('Location: '.$this->config->root_url.'/user/covid_form?success=sended');
					exit;
				}
			}

			

			if($this->request->method('post'))
			{
				$u = new stdclass;

				
				if(!empty($user->blocks))
				{
					$u->blocks = (array) unserialize($user->blocks);
				}

				$u->blocks['covid_form'] = 1;

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
					$file = $this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/covid_form_signature.png';
					$success = file_put_contents($file, $data);
					chmod($this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/covid_form_signature.png', 0755);
				}

				if(file_exists($this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/covid_form_signature.png'))
					$signature = $this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/covid_form_signature.png';

				$this->users->update_user($user->id, $u);

				$user = $this->users->get_user((int)$user->id);

				$options = new Options();
				$options->set('defaultFont', 'Helvetica');

				// instantiate and use the dompdf class
				$dompdf = new Dompdf($options);

				$this->design->assign('user', $user);
				$this->design->assign('signature', $signature);


				$pdf_html = $this->design->fetch('covid_form_html.tpl');

				$dompdf->loadHtml($pdf_html);

				// (Optional) Setup the paper size and orientation ("landscape" or "portrait")
				$dompdf->setPaper('A4', 'portrait'); 

				// Render the HTML as PDF
				$dompdf->render();

				// Output the generated PDF to Browser
				$stream_options = array();
				$stream_options['save_path'] = $this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/';
				$dompdf->stream('covid.pdf', $stream_options);


				// Add log
				$add_log_id = $this->logs->add_log(array(
					'parent_id'=> $user->id, 
					'type' => 8, // Covid form
					'subtype' => 3, // Sign
					'user_id' => $user->id, 
					'sender_type' => 3 // User
				));

				// Cassa salesflow finish + airbnb
				if(!empty($salesflow->type == 1) && $booking->house_id == 340)
				{
					$this->notify->email_outpost_tenant_approve($salesflow->id, 0);
				}

				$this->salesflows->update_salesflow($user->active_salesflow_id, ['covid_form_status'=>1]);

				if(!empty($contract))
					header('Location: '.$this->config->root_url.'/user/covid_form?success=sended&c='.$contract->id);
				elseif(!empty($salesflow))
					header('Location: '.$this->config->root_url.'/user/covid_form?success=sended&s='.$salesflow->id);
				else
					header('Location: '.$this->config->root_url.'/user/covid_form?success=sended');
				exit;
			}

			if(file_exists($this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/covid_form_signature.png'))
				$signature = $this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/covid_form_signature.png';

		}
		else
			return false;


		if(!empty($user->blocks))
			$user->blocks = (array) unserialize($user->blocks);
		else
			$user->blocks = array();

		if($status_success == 'sended' && !empty($contract))
		{
			$invoices = $this->orders->get_orders(array('contract_id'=>$contract->id, 'deposit'=>0, 'not_label'=>5));
			ksort($invoices);
			foreach ($invoices as $inv) 
			{
				if(!empty($inv->date_from) && empty($invoice))
					$invoice = $inv;
			}
			// $invoice = current($invoices);
			$this->design->assign('invoice', $invoice);
		}

		
			
		$this->design->assign('user', $user);
		if(!empty($signature))
			$this->design->assign('signature', $signature);
		if(!empty($contract))
		{
			$notification = current($this->notifications->get_notifications(array('user_id'=>$user->id, 'type'=>2)));
			$this->design->assign('bg_check', $notification);
			$this->design->assign('contract', $contract);
		}

		echo $this->design->fetch('covid_form.tpl'); exit;
	}
}