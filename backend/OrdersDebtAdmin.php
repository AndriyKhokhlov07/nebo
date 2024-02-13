<?PHP 


require_once('api/Backend.php');

########################################
class OrdersDebtAdmin extends Backend
{
	public function fetch()
	{
	 	$filter = array();
        $filter['page'] = max(1, $this->request->get('page', 'integer'));
	  		
	  	$filter['limit'] = 50;

		$filter['not_label'] = [
			8 => 8,  // not airbnb
			18 => 18, 19 => 19, 20 => 20 // no collections
		];
		// Filter labels
	  	$label = $this->orders->get_label($this->request->get('label'));	  	
	  	if(!empty($label))
	  	{
		  	$filter['label'] = $label->id;
			// if collections (18) show airbnb (8)
			if (in_array($label->id, [18, 19, 20])) {
				unset($filter['not_label'][8]);
                unset($filter['not_label'][18]);
                unset($filter['not_label'][19]);
                unset($filter['not_label'][20]);
			}
		 	$this->design->assign('label', $label);
		}


        // Search
        if (isset($_GET['keyword'])) {
            $keyword = $_GET['keyword'];
            if (!empty($keyword)) {
                $filter['keyword'] = $keyword;
                $this->design->assign('keyword', $keyword);
            }
        }


		$status = [0, 1, 4];
		if($this->request->get('status'))
		{
			if($this->request->get('status') == 'new')
				$status = 0;
			else
				$status = $this->request->get('status', 'integer');
	 		$this->design->assign('status', $status);
		}
		$filter['status'] = $status;

        $type = $this->request->get('type');
        if ($type == 'other') {
            $filter['not_type'] = [
                1,  // Invoices
                11, // Taxes
                5   // Damages
            ];
        }
        else {
            $type = (int)$type;
            if(empty($type))
                $type = 1;
            if(!empty($type))
                $filter['type'] = $type;
            // invoices
            if ($type == 1) {
                $filter['deposit'] = 0;
            }
        }
        $this->design->assign('type', $type);

        if (isset($_GET['deposit'])) {
            $deposit = $this->request->get('deposit', 'integer');
            $filter['deposit'] = $deposit;
            $this->design->assign('deposit', $deposit);
        }





	  	$date_to = date_create(date("Y-m-d"));
	  	$date_from = date_create(date("Y-m-d"));

	  	$days = $this->request->get('days');
	  	if(in_array($label->id, [
            8,  // airbnb
            11, // vrbo
            18, 19, 20 // collections
        ])) {
	  		$date_from_days = '';
	  	}
	  	elseif($days == 30)
	  	{
	  		$date_to_days = '30 days';
	  		$date_from_days = '11 days';
	  	}
	  	elseif($days == 31)
	  	{
	  		$date_from_days = '31 days';
	  	}
	  	else
	  	{
	  		$date_to_days = '10 days';
	  		// $date_from_days = '2 days';
			// $date_from_days = '1 day';
			$date_from_days = '';
	  	}
	  	$this->design->assign('days', $days);


        if (!empty($filter['keyword'])) {
            $date_from_days = '';
            $date_to_days = '';
        }


	  	if(!empty($date_to_days))
	  	{
	  		date_sub($date_to, date_interval_create_from_date_string($date_to_days));
			$filter_date_to = $date_to->format('Y-m-d');
	  		$filter['date_from'] = $filter_date_to;
	  	}
	  	
		date_sub($date_from, date_interval_create_from_date_string($date_from_days));
		$filter_date_from = $date_from->format('Y-m-d');
	  	$filter['date_to'] = $filter_date_from;

		// Houses
        /*
		$houses = $this->pages->get_pages(array('menu_id'=>5, 'not_tree'=>1));
		if(!empty($houses))
			$houses= $this->categories_tree->get_categories_tree('houses', $houses);
        */


        $house_id = $this->request->get('house_id', 'integer');

        $houses = [];
        $cities_houses = $this->pages->get_pages([
            // 'id' => $houses_ids,
            'menu_id' => 5,
            'not_tree' => 1,
            'visible' => 1
        ]);

        if (!empty($cities_houses)) {
            foreach ($cities_houses as $ch) {
                if ($ch->parent_id > 0) {
                    if(!empty($ch->blocks2))
                        $ch->blocks2 = unserialize($ch->blocks2);
                    $houses[$ch->id] = $ch;
                }
            }
        }
        $cities_houses = $this->categories_tree->get_categories_tree('chouses', $cities_houses);

        if(!empty($houses))
        {
            if(!empty($house_id) && isset($houses[$house_id])) {
                $selected_house = $houses[$house_id];
                $houses[$selected_house->id]->selected = 1;
            }
            else {
                $selected_house = (object) [
                    'id' => 0,
                    'name' => 'All houses'
                ];
            }
        }
        $this->design->assign('cities_houses', $cities_houses);
        $this->design->assign('selected_house', $selected_house);



		// $house = null;
		// $house_id = $this->request->get('house_id', 'integer');
		if ($selected_house->id > 0) {
			//$house = $this->pages->get_page($house_id);
			$contracts_ids = array();
			$bookings_ids = array();
			$contracts = $this->contracts->get_contracts(array('status'=>array(1,2), 'house_id'=>$selected_house->id));
			$bookings = $this->beds->get_bookings(array('status'=>array(1,2,3), 'house_id'=>$selected_house->id));

			if(!empty($contracts))
			foreach ($contracts as $c) 
			{
				$contracts_ids[] = $c->id;
			}

			if(!empty($bookings))
			foreach ($bookings as $b) 
			{
				$bookings_ids[] = $b->id;
			}

			$filter['contract_id'] = $contracts_ids;
			$filter['booking_id'] = $bookings_ids;

		}
		$filter['select_users'] = 1;
				  	
	  	$orders_count = $this->orders->count_orders($filter);
		// Показать все страницы сразу
		if($this->request->get('page') == 'all')
			$filter['limit'] = $orders_count;	


		
        // print_r($filter); exit;
		// Отображение
		$orders_ = $this->orders->get_orders($filter);

		// Метки заказов
		$orders_labels = array();
	  	foreach($this->orders->get_order_labels(array_keys($orders_)) as $ol)
	  		$orders_[$ol->order_id]->labels[$ol->id] = $ol;

		$orders = array();
	  	foreach($orders_ as $o)
		{
			$interval = '';
			$interval = date_diff(date_create($o->date_from), date_create(date("Y-m-d")));
			if(!isset($o->labels[11]) || $filter['label'] == 11)
				$orders[$interval->days][$o->id] = $o;
		}
		ksort($orders);
	  	
	 	$this->design->assign('pages_count', ceil($orders_count/$filter['limit']));
	 	$this->design->assign('current_page', $filter['page']);
	  	
	 	$this->design->assign('orders_count', $orders_count);
	
	 	$this->design->assign('orders', $orders);
        $this->design->assign('orders_types', $this->orders->types);

		$this->design->assign('date_to', $filter['date_to']);

		$this->design->assign('houses', $houses);
		$this->design->assign('house',  $house);

	 	
	  	$labels = $this->orders->get_labels();
	 	$this->design->assign('labels', $labels);
	  	
		return $this->design->fetch('invoices/orders_debt.tpl');
	}
}
