<?PHP

require_once('view/View.php');

require_once 'services/generateXls/GenerateRentRoll5Admin.php';

require_once 'api/dompdf/lib/html5lib/Parser.php';
// require_once 'api/dompdf/lib/php-font-lib/src/FontLib/Autoloader.php';
// require_once 'api/dompdf/lib/php-svg-lib/src/autoload.php';
require_once 'api/dompdf/src/Autoloader.php';
Dompdf\Autoloader::register();
use Dompdf\Dompdf;
use Dompdf\Options;


class LandlordRentRoll5View extends View
{
	private $params;
	private $data;

	private function generate_pdf($filename)
	{
		$html = $this->design->fetch('landlord/bx/rentroll/rr5_html.tpl');
		$options = new Options();
		$options->set('defaultFont', 'Helvetica');
		$dompdf = new Dompdf($options);
		$dompdf->loadHtml($html);
		$dompdf->setPaper('A4', 'portrait');
		$dompdf->render();
		$dompdf->stream($filename);
		exit;
	}

	function fetch()
	{

		if (empty($this->user)) {
			header("HTTP/1.1 301 Moved Permanently"); 
			header('Location: '.$this->config->root_url.'/user/login');
			exit();
		}

		if ($this->user->type != 4) {
			return false;
		}

		if (empty($this->user->permissions['rentroll']) && !empty($this->user->permissions)) {
			header("HTTP/1.1 301 Moved Permanently"); 
			header('Location: '.$this->config->root_url.'/landlord/'.current($this->user->permissions));
			exit();
		}

		$landlord = new stdClass;

		if (!empty($this->user->email)) {
			if(!empty($this->user->main_info)) {
				$landlord->main_info = $this->user->main_info;
			}

			$houses = [];
			$selected_house_id = $this->request->get('house_id', 'integer');

			// The Mason on Chestnut - Philadelphia
			if($this->selected_house->id == 349) {
				header("HTTP/1.1 301 Moved Permanently"); 
				header('Location: '.$this->config->root_url.'/landlord/rentroll2/'.$this->selected_house->id);
				exit();	
			}
			$month_year = $this->request->get('month', 'string');
			$date = $this->request->get('date', 'string');
			$this->params->show_empty_rows = $this->request->get('sr', 'integer');
			$f = $this->request->get('f', 'string');

			if (!empty($this->user->landlords_companies)) {
			}
			elseif ($this->user->id == 4714 || $this->user->id == 4715) {
				$this->user->houses_ids[] = 185; // The Central Park Manhattan House for owners
			}
			
			$strtotime_lastmonth = strtotime('- 1 month');
			if (!empty($month_year)) {
				list($month, $year) = explode('-', $month_year);
			} else {
				$month = date("m", $strtotime_lastmonth);
				$year = date("Y", $strtotime_lastmonth);
			}
        
			
			$rentroll5 = $this->rentroll->getRR5([
				'house_id' => $selected_house_id,
				'month' => $month,
				'year' => $year,
				'show_empty_rows' => $show_empty_rows,
				'landlord' => $this->user,
				'active_status' => 'active_future',
				'select_leases_data' => true,
				'action' => $action,
				'view' => 'landlord'
			]);

			$houseName = $rentroll5->params->selected_house->name;
	        $houseAddress = $rentroll5->params->selected_house->blocks2['address'];
	        $filename = "lender_".$houseName.'_'.$houseAddress.'.pdf';
	        // Removing commas
	        $filename = str_replace(',', '', $filename);
	        // Replacing spaces with underscores
	        $filename = preg_replace('/\s+/', '_', $filename);
			
			if (!empty($rentroll5)) {
				$meta_title = 'Lender';
				if(!empty($rentroll5->params->selected_house)) {
					$meta_title .= ' | '.$rentroll5->params->selected_house->name;
				}
				$this->design->assign('meta_title', $meta_title);
				$this->design->assign('houses', $rentroll5->params->houses);
				$this->design->assign('cities_houses', $rentroll5->params->cities_houses);
				if (is_array($rentroll5->params->selected_house->id)) {
					$rentroll5->params->selected_house->id = current($rentroll5->params->selected_house->id);
				}
				// Hotel
				if ($rentroll5->params->selected_house->type == 1) {
					$this->design->assign('days_units', $rentroll5->params->data->days_units);
				}
				$this->design->assign('selected_house', $rentroll5->params->selected_house);
				$this->design->assign('landlord', $landlord);
				$this->design->assign('params', $rentroll5->params);
				$this->design->assign('data', $rentroll5->data);
				$this->design->assign('namePage', $namePage = 'landlordRR5');
			}
		}

		if($f == 'xls'){
            $generateXls = new GenerateRentRoll5Admin();
            $generateXls->generate_xls($rentroll5);
        }
        elseif($f == 'pdf'){
            $this->generate_pdf($filename);
        }

		return $this->design->fetch('landlord/rentroll5.tpl');
	}
}
