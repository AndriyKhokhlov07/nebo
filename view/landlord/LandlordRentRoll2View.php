<?PHP

require_once('view/View.php');

class LandlordRentRoll2View extends View
{
	private $params;
	private $data;
	private $table;



	public function fetch()
	{

		if (empty($this->user)) {
			header("HTTP/1.1 301 Moved Permanently"); 
			header('Location: '.$this->config->root_url.'/user/login');
			exit();
		}

		if ($this->user->type != 4) {
			return false;
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
			
			
			$selected_house_id = $this->request->get('house_id', 'integer');
			$month_year = $this->request->get('month', 'string');
			$show_empty_rows = $this->request->get('sr', 'integer');
			
			$strtotime_lastmonth = strtotime('- 1 month');
			if (!empty($month_year)) {
				list($month, $year) = explode('-', $month_year);
			} else {
				$month = date("m", $strtotime_lastmonth);
				$year = date("Y", $strtotime_lastmonth);
			}
        
			
			$rentroll = $this->rentroll->getRR2([
				'house_id' => $selected_house_id,
				'month' => $month,
				'year' => $year,
				'show_empty_rows' => $show_empty_rows,
				'landlord' => $this->user,
				'view' => 'landlord'
			]);
			
			if (!empty($rentroll)) {
				if ((int)$year < 2021 && (int)$month < 12) {
					unset($rentroll->params->prev_month);
				}
				
				
				$this->design->assign('table', $rentroll->table);
				$this->design->assign('apartments', $rentroll->data->apartments);

				ksort($rentroll->data->other_period_invoices);
				$this->design->assign('other_period_invoices', $rentroll->data->other_period_invoices);

				ksort($rentroll->data->debt_invoices);
				$this->design->assign('debt_invoices', $rentroll->data->debt_invoices);

				$this->design->assign('deposit_invoices', $rentroll->data->deposit_invoices);
				
				if (!empty($rentroll->logs_save)) {
					$this->design->assign('logs_save', $rentroll->logs_save);
					$this->design->assign('log_save', current($rentroll->logs_save));
				}
				
				$meta_title = 'Rent Roll';
				if(!empty($rentroll->params->selected_house)) {
					$meta_title .= ' | '.$rentroll->params->selected_house->name;
				}
				$this->design->assign('meta_title', $meta_title);

				$this->design->assign('houses', $rentroll->params->houses);
		
				$this->selected_house->id = $rentroll->params->selected_house->main_id;
				$this->design->assign('selected_house', $rentroll->params->selected_house);

				$this->design->assign('cities_houses', $rentroll->params->cities_houses);

				$this->design->assign('landlord', $landlord);
				$this->design->assign('params', $rentroll->params);
				$this->design->assign('data', $rentroll->data);
			}
		}

		$tpl = 'landlord/rentroll2.tpl';
		// Hotel
		if ($rentroll->params->selected_house->type == 1) {
			$tpl = 'landlord/rentroll2_hotel.tpl';
		}
		return $this->design->fetch($tpl);
	}
}
