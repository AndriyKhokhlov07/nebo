<?PHP

// ini_set('error_reporting', E_ALL);
require_once('View.php');


require_once 'api/dompdf/lib/html5lib/Parser.php';
require_once 'api/dompdf/src/Autoloader.php';
Dompdf\Autoloader::register();

use Dompdf\Dompdf;
use Dompdf\Options;


class WindowGuardsView extends View
{



	public $user;

	function fetch()
	{
		$user = new stdclass;

		$hash = $this->request->get('h', 'string');
		$status_success = $this->request->get('success', 'string');
		// $contract_id = $this->request->get('c');
		$contract_id = false;
		$contract = false;

		if(!empty($contract_id))
			$contract = $this->contracts->get_contract(intval($contract_id));
			

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
						'type' => 12, // Window Guards
						'subtype' => 2, // Viewed
						'user_id' => $user->id, 
						'sender_type' => 3 // User
					));
				}

				if(!empty($contract))
					header('Location: '.$this->config->root_url.'/user/window_guards?c='.$contract->id);
				else
					header('Location: '.$this->config->root_url.'/user/window_guards');

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

				if($user_blocks['window_guards']['status'] == 1 && $status_success != 'sended')
				{
					if(!empty($contract))
						header('Location: '.$this->config->root_url.'/user/window_guards?success=sended&c='.$contract->id);
					else
						header('Location: '.$this->config->root_url.'/user/window_guards?success=sended');
					exit;
				}
			}



			if(!empty($user->house_id))
			{
				if($house = $this->pages->get_page((int)$user->house_id))
				{
					if(!empty($house->blocks2))
					{
						$house->blocks2 = unserialize($house->blocks2);

						if(!empty($house->blocks2['street_address']))
							$user->house_street_address = $house->blocks2['street_address'];

						if(!empty($house->blocks2['city']))
							$user->house_city = $house->blocks2['city'];

						if(!empty($house->blocks2['region']))
							$user->house_region = $house->blocks2['region'];


						if(!empty($house->blocks2['postal']))
							$user->house_postal = $house->blocks2['postal'];


						
					}
				}	
			}
			if(!empty($user->apartment_id))
			{
				$apartment = $this->beds->get_apartments([
					'id' => $user->apartment_id,
					'limit' => 1
				]);

				if(!empty($apartment))
					$user->apartment_name = $apartment->name;
			}

			

			if($this->request->method('post'))
			{
				$u = new stdclass;

				
				if(!empty($user->blocks))
				{
					$u->blocks = (array) unserialize($user->blocks);
				}

				$u->blocks['window_guards']['status'] = 1;





				if($this->request->post('child5', 'integer'))
					$u->blocks['window_guards']['child5'] = 1;

				if($this->request->post('child10', 'integer'))
				{
					$u->blocks['window_guards']['child10'] = 1;

					if($this->request->post('installed', 'integer'))
						$u->blocks['window_guards']['installed'] = 1;

					if($this->request->post('needrepair', 'integer'))
						$u->blocks['window_guards']['needrepair'] = 1;

					if($this->request->post('notinstalled', 'integer'))
						$u->blocks['window_guards']['notinstalled'] = 1;
				}

				if($this->request->post('child_no', 'integer'))
				{
					$u->blocks['window_guards']['child_no'] = 1;

					if($this->request->post('installed_anyway', 'integer'))
						$u->blocks['window_guards']['installed_anyway'] = 1;
					
					if($this->request->post('needrepair2', 'integer'))
						$u->blocks['window_guards']['needrepair2'] = 1;
				}

				$user->blocks = $u->blocks;
				

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
					$file = $this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/window_guards_signature.png';
					$success = file_put_contents($file, $data);
					chmod($this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/window_guards_signature.png', 0755);
				}

				if(file_exists($this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/window_guards_signature.png'))
					$signature = $this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/window_guards_signature.png';

				$this->users->update_user($user->id, $u);

				// $user = $this->users->get_user((int)$user->id);

				// if(!empty($user->blocks))
				// {
				// 	$user->blocks = unserialize($user->blocks);
				// }

				$options = new Options();
				$options->set('defaultFont', 'Helvetica');
				// $options->set('dpi', 120);


				// instantiate and use the dompdf class
				$dompdf = new Dompdf($options);

				$this->design->assign('user', $user);
				$this->design->assign('signature', $signature);


				$pdf_html = $this->design->fetch('window_guards/html.tpl');

				$dompdf->loadHtml($pdf_html);

				// (Optional) Setup the paper size and orientation ("landscape" or "portrait")
				$dompdf->setPaper('A4', 'portrait'); 

				// Render the HTML as PDF
				$dompdf->render();

				// Output the generated PDF to Browser
				$stream_options = array();
				$stream_options['save_path'] = $this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/';
				$dompdf->stream('window_guards.pdf', $stream_options);


				// Add log
				$add_log_id = $this->logs->add_log(array(
					'parent_id'=> $user->id, 
					'type' => 12, // window guards
					'subtype' => 3, // Sign
					'user_id' => $user->id, 
					'sender_type' => 3 // User
				));

				if(!empty($contract))
					header('Location: '.$this->config->root_url.'/user/window_guards?success=sended&c='.$contract->id);
				else
					header('Location: '.$this->config->root_url.'/user/window_guards?success=sended');
				exit;
			}

			if(file_exists($this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/window_guards_signature.png'))
				$signature = $this->config->root_dir.'/'.$this->config->users_files_dir.$this->user->id.'/window_guards_signature.png';

		}
		else
			return false;


		if(!empty($user->blocks))
			$user->blocks = (array) unserialize($user->blocks);
		else
			$user->blocks = [];

		/*
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
		*/


		

		
			
		$this->design->assign('user', $user);
		if(!empty($signature))
			$this->design->assign('signature', $signature);
		/*
		if(!empty($contract))
		{
			$notification = current($this->notifications->get_notifications(array('user_id'=>$user->id, 'type'=>2)));
			$this->design->assign('bg_check', $notification);
			$this->design->assign('contract', $contract);
		}
		*/

		echo $this->design->fetch('window_guards/page.tpl'); exit;
	}
}