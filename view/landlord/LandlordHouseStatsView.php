<?PHP

require_once('view/View.php');

class LandlordHouseStatsView extends View
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
			
			$strtotime_now = strtotime('now');
			if (!empty($month_year)) {
				list($month, $year) = explode('-', $month_year);
			} else {
				$month = date("m", $strtotime_now);
				$year = date("Y", $strtotime_now);
			}
        
			
			$stats = $this->house_stats->getStats([
				'house_id' => $selected_house_id,
				'month' => $month,
				'year' => $year,
				'landlord' => $this->user,
				'view' => 'landlord'
			]);


            $meta_title = 'House Stats';
            if(!empty($this->params->selected_house))
                $meta_title .= ' | '.$this->params->selected_house->name;
            $this->design->assign('meta_title', $meta_title);
            $this->design->assign('houses', $stats->params->houses);
            $this->selected_house->id = $stats->params->selected_house->main_id;
            $this->design->assign('selected_house', $stats->params->selected_house);
            $this->design->assign('cities_houses', $stats->params->cities_houses);

            $this->design->assign('params', $stats->params);
            $this->design->assign('stats', $stats->stats);
            $this->design->assign('occupancy_house', $stats->occupancy_house);
            $this->design->assign('leads_bookings', $stats->leads_bookings);
            $this->design->assign('leasings', $stats->leasings);

		}

		return $this->design->fetch('landlord/house_stats.tpl');
	}
}
