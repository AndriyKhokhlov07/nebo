<?php
ini_set('error_reporting', 0);


session_start();

chdir('..');
require_once('api/Backend.php');



class Init extends Backend
{
	private $columns_names = array(
			'month'=>			'Date',
			'house'=>			'House',
			'nights'=>          'Nights in this month',
			'percent'=>         'Occupancy rate',
			'invoices'=>       	'Number of paid invoices',
			'money'=>         	'Amount of money',
			'contracts'=>       'Number of signed contracts'
			);
			
	private $column_delimiter = ';';
	private $export_files_dir = '/files/houses_stat/';

	public function fetch()
	{
	
		// Эксель кушает только 1251
		setlocale(LC_ALL, 'ru_RU.1251');
		$this->db->query('SET NAMES cp1251');

		$houses = $this->pages->get_pages([
            'menu_id' => 5,
            'visible' => 1,
            'not_tree' => 1,
            'not_parent_id' => 0
        ]);

		foreach ($houses as $house) 
		{
			// Открываем файл экспорта на добавление
			if (!file_exists($this->config->root_dir.$this->export_files_dir.'house_'.$house->id.'.csv'))
			{
				$f = fopen($this->config->root_dir.$this->export_files_dir.'house_'.$house->id.'.csv', 'w');
				// Добавим в первую строку названия колонок
				fputcsv($f, $this->columns_names, $this->column_delimiter);
			}
			else
			{
				$f = fopen($this->config->root_dir.$this->export_files_dir.'house_'.$house->id.'.csv', 'ab');
			}
					
			
			$filter = array();
			$filter['house_id'] = $house->id;
			$date = date("Y-m-d");

			$date_year = date("Y");
			$date_month_now = date("m");
			$date_day = "01";

			if(date('n')-1 == 0)
			{
				$date_year = $date_year-1;
				$date_month = 12;
			}
			else
			{
				$date_month = date('n')-1;
				if(date('n')-1 < 10)
					$date_month = "0".$date_month;
			}

			$filter['date_from'] = $date_year.'-'.$date_month.'-'.$date_day;
			$filter['date_to'] = date("Y").'-'.date("m").'-'.$date_day;

			$filter['is_due'] = 1;

			$beds = $this->beds->get_beds(array('house_id'=>$filter['house_id']));

			$reservs = $this->beds->get_bookings($filter);
			$nights = 0;
			foreach ($reservs as $r) 
			{
				$date_start = date_create($r->arrive);
				if($date_start->format('m') != $date_month || $date_start->format('Y') != $date_year)
				{
					$date_start = $filter['date_from'];
				}
				else
				{
					$date_start = $r->arrive;
				}

				$d1 = date_create($date_start);
				$d2 = date_create($filter['date_to']);
				
				$interval = date_diff($d1, $d2);

				$r->days = $interval->days;
				$nights += $interval->days;
			}

			$d1 = date_create($filter['date_from']);

			$interval_month = date_diff($d1, $d2);
			$month_nights = $interval_month->days;
			$beds_count = count($beds);

			if($beds_count != 0 && $month_nights != 0)
				$percent = ($nights*100)/($month_nights*$beds_count);
			else
				$percent = 0;


			// Выбираем пользователей этого
			$users = $this->users->get_users(array('house_id'=>$house->id));

			$users_ids = array();
			foreach ($users as $u) 
			{
				$users_ids[] = $u->id;
			}

			// Выбираем инвойсы
			$query = $this->db->placehold("SELECT o.id, o.type, o.paid, o.payment_date, o.total_price FROM __orders AS o WHERE o.payment_date >=? AND o.payment_date <? AND o.user_id in (?@) AND o.paid = 1 AND o.type = 1 GROUP BY o.id", $filter['date_from'], $filter['date_to'], (array)$users_ids);
			
			$this->db->query($query);


			$orders = $this->db->results();

			$month_profit = 0;

			foreach ($orders as $o) 
			{
				$month_profit += $o->total_price;
			}
			
			// Выбираем контракты
			$query = $this->db->placehold("SELECT 
							c.id, 
							c.date_signing,
							c.date_created
						FROM __contracts AS c
						WHERE c.house_id = ? AND c.date_signing >= ? AND c.date_signing < ?
						ORDER BY c.id DESC", $house->id, $filter['date_from'], $filter['date_to']);
			
			$this->db->query($query);

			$contracts = $this->db->results();


			$str = array();
			$str[0] = $d1->format('M').', '.$d1->format('Y');
			$str[1] = $house->name;
			$str[2] = $nights.' / '.($month_nights*$beds_count);
			$str[3] = round($percent, 2).' / 100%';
			$str[4] = count($orders);
			$str[5] = '$'.$month_profit;
			$str[6] = count($contracts);

			fputcsv($f, $str, $this->column_delimiter);

			fclose($f);
		}

	}
}


$init = new Init();
$init->fetch();
