<?PHP

require_once('view/View.php');

require_once 'services/generateXls/GenerateRentRoll6Admin.php';

require_once 'api/dompdf/lib/html5lib/Parser.php';
// require_once 'api/dompdf/lib/php-font-lib/src/FontLib/Autoloader.php';
// require_once 'api/dompdf/lib/php-svg-lib/src/autoload.php';
require_once 'api/dompdf/src/Autoloader.php';
Dompdf\Autoloader::register();
use Dompdf\Dompdf;
use Dompdf\Options;


class LandlordRentRoll6View extends View
{
	private $params;
	private $data;

	private function generate_pdf($filename)
	{
		$html = $this->design->fetch('landlord/bx/rentroll/rr6_html.tpl');
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
			if (!empty($this->user->main_info)) {
				$landlord->main_info = $this->user->main_info;
			}
			if (!empty($this->user->landlords_companies)) {
			}
			elseif ($this->user->id == 4714 || $this->user->id == 4715) {
				$this->user->houses_ids[] = 185; // The Central Park Manhattan House for owners
			}
			
			
			$house_id = $this->request->get('house_id', 'integer');
	        $month_year = $this->request->get('month', 'string');
	        $show_empty_rows = $this->request->get('sr', 'integer');
	        $action = $this->request->post('a', 'string');
	        $f = $this->request->get('f', 'string');
	        
	        $strtotime_lastmonth = strtotime('- 1 month');
	        if (!empty($month_year)) {
				list($month, $year) = explode('-', $month_year);
			} else {
				$month = date("m", $strtotime_lastmonth);
				$year = date("Y", $strtotime_lastmonth);
			}
        
			
			$rentroll6 = $this->rentroll->getRR6([
	        	'house_id' => $house_id,
	        	'month' => $month,
	        	'year' => $year,
	        	'landlord' => $this->user,
	        	'show_empty_rows' => $show_empty_rows,
	        	'action' => $action,
	        	'view' => 'landlord'
	        ]);
			
			if (!empty($rentroll6)) {
				if ((int)$year < 2021 && (int)$month < 12) {
					unset($rentroll6->params->prev_month);
				}
				
				$this->design->assign('apartments', $rentroll6->data->apartments);
				
				if (!empty($rentroll6->logs_save)) {
					$this->design->assign('logs_save', $rentroll6->logs_save);
					$this->design->assign('log_save', current($rentroll6->logs_save));
				}
				
				$houseName = $rentroll6->params->selected_house->name;
		        $houseAddress = $rentroll6->params->selected_house->blocks2['address'];
		        $filename = "broker-fee_".$houseName.'_'.$houseAddress.'.pdf';
		        // Removing commas
		        $filename = str_replace(',', '', $filename);
		        // Replacing spaces with underscores
		        $filename = preg_replace('/\s+/', '_', $filename);

				$meta_title = 'Broker Fee';
				if(!empty($rentroll6->params->selected_house)) {
					$meta_title .= ' | '.$rentroll6->params->selected_house->name;
				}
				$this->design->assign('meta_title', $meta_title);
				$this->design->assign('houses', $rentroll6->params->houses);
				$this->selected_house->id = $rentroll6->params->selected_house->main_id;
				$this->design->assign('selected_house', $rentroll6->params->selected_house);
				$this->design->assign('cities_houses', $rentroll6->params->cities_houses);
				$this->design->assign('landlord', $landlord);
				$this->design->assign('params', $rentroll6->params);
				$this->design->assign('data', $rentroll6->data);
				$this->design->assign('namePage', $namePage = 'landlordRR6');
			}
		}
		if($f == 'xls'){
            $generateXls = new GenerateRentRoll6Admin();
            $generateXls->generate_xls($rentroll6);
        }
        elseif($f == 'pdf'){
            $this->generate_pdf($filename);
        }

		return $this->design->fetch('landlord/rentroll6.tpl');
	}
}
