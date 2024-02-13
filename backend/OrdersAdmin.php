<?PHP 

require_once('api/Backend.php');

########################################
class OrdersAdmin extends Backend
{
	public function fetch()
	{
	 	$filter = array();
	  	$filter['page'] = max(1, $this->request->get('page', 'integer'));
	  	
	  	if($this->request->get('first') == 1)
	  		$filter['limit'] = 100000;
	  	else
		  	$filter['limit'] = 40;

	  	if($this->request->get('sort_by_create') == 1)
	  		$filter['sort_by_create'] = 1;

	  	$datesModel = new DatesOrderModel();
	  	$datesModel->addToFilter($filter);


        $purchasesParam = $this->request->get('purchases', 'string');

	    // Поиск
	  	//$keyword = $this->request->get('keyword', 'string');
	  	if(isset($_GET['keyword']))
	  	{
	  		$keyword = $_GET['keyword'];
		  	if(!empty($keyword))
		  	{
			  	$filter['keyword'] = $keyword;
		 		$this->design->assign('keyword', $keyword);
			}
	  	}
	  	

		// Фильтр по метке
	  	$label = $this->orders->get_label($this->request->get('label'));	  	
	  	if(!empty($label))
	  	{
		  	$filter['label'] = $label->id;
		 	$this->design->assign('label', $label);
		}


        $payment_methods = [];
        $payment_methods_all = $this->request->array_to_key($this->payment->get_payment_methods(), 'id');
        if (!empty($payment_methods_all)) {
            foreach ($payment_methods_all as $pm) {
                if ($pm->module == 'Qira') {
                    $pm->title = $pm->module;
                    $module_key = 'qira';
                    if (preg_match_all('/(Debit)/', $pm->name, $matches)) {
                        $pm->title .= ' (Debit Card)';
                        $module_key .= '_dc';
                    } elseif (preg_match_all('/(Credit)/', $pm->name, $matches)) {
                        $pm->title .= ' (Credit Card)';
                        $module_key .= '_cc';
                    } elseif (preg_match_all('/(ACH)/', $pm->name, $matches)) {
                        $pm->title .= ' (ACH)';
                        $module_key .= '_ach';
                    }
                }
                elseif (preg_match_all('/(Stripe)/', $pm->module, $matches)) {
                    $pm->title = 'Stripe';
                    $module_key = 'stripe';
                    if (in_array($pm->module, ['StripeACH', 'StripeACHv2'])) {
                        $pm->title .= ' (ACH)';
                        $module_key .= '_ach';
                    }
                }
                elseif ($pm->module != 'null') {
                    $pm->title = $pm->name;
                    $module_key = $pm->module;
                }
                else {
                    $pm->title = $pm->name;
                    $module_key = $pm->id;
                }

                $payment_methods[$module_key]->title = $pm->title;
                $payment_methods[$module_key]->id = $module_key;
                $payment_methods[$module_key]->children[$pm->id] = $pm;
                $payment_methods[$module_key]->ids[$pm->id] = $pm->id;

            }
        }
        // Payment method (by type)
        $selected_payment_method = $this->request->get('payment_method');
        if (!empty($selected_payment_method) && $payment_methods[$selected_payment_method]) {
            $selected_payment_method = $payment_methods[$selected_payment_method];
            $filter['payment_method_id'] = $selected_payment_method->ids;
            $this->design->assign('selected_payment_method', $selected_payment_method);
        }

		// Payment method (by id) 
        // -- old --
	  	$payment_method = $this->payment->get_payment_method($this->request->get('payment_method_id'));	  	
	  	if(!empty($payment_method))
	  	{
		  	$filter['payment_method_id'] = $payment_method->id;
		 	$this->design->assign('payment_method', $payment_method);
		}

	  	// Фильтр по дому
        if(!empty($house_id = $this->request->get('house_id')))
        {
            $filter['house_id'] = $house_id;
        }


		// Обработка действий
		if($this->request->method('post'))
		{

			// Действия с выбранными
			$ids = $this->request->post('check');
			if(is_array($ids))
			switch($this->request->post('action'))
			{
				case 'delete':
				{
					foreach($ids as $id)
					{
						$o = $this->orders->get_order(intval($id));
						if($o->status<3)
						{
							$this->orders->update_order($id, array('status'=>3));
							$this->orders->open($id);							
						}
						else
							$this->orders->delete_order($id);
					}
					break;
				}
				case 'set_status_0':
				{
					foreach($ids as $id)
					{
						if($this->orders->open(intval($id)))
							$this->orders->update_order($id, array('status'=>0));	
					}
					break;
				}
				case 'set_status_1':
				{
					foreach($ids as $id)
					{
						// if(!$this->orders->close(intval($id)))
						// 	$this->design->assign('message_error', 'error_closing');
						// else
							$this->orders->update_order($id, array('status'=>1));	
					}
					break;
				}
				case 'set_status_2':
				{
					foreach($ids as $id)
					{
						// if(!$this->orders->close(intval($id)))
						// 	$this->design->assign('message_error', 'error_closing');
						// else
							$this->orders->update_order($id, array('status'=>2));	
					}
					break;
				}
				case 'set_status_4':
				{
					foreach($ids as $id)
					{
						$this->orders->update_order($id, array('status'=>4));	
					}
					break;
				}
				case(preg_match('/^set_label_([0-9]+)/', $this->request->post('action'), $a) ? true : false):
				{
					$l_id = intval($a[1]);
					if($l_id>0)
					foreach($ids as $id)
					{
						$this->orders->add_order_labels($id, $l_id);
					}
					break;
				}
				case(preg_match('/^unset_label_([0-9]+)/', $this->request->post('action'), $a) ? true : false):
				{
					$l_id = intval($a[1]);
					if($l_id>0)
					foreach($ids as $id)
					{
						$this->orders->delete_order_labels($id, $l_id);
					}
					break;
				}
			}
		}		

		if(empty($keyword))
		{
			if($this->request->get('first') == 1)
			{
				$status = 0;
				$filter['status'] = array(1, 2); 
				$filter['not_label'] = 8;
				$filter['date_from'] = '2001-01-01';
			}
			else
			{
				$status = $this->request->get('status', 'integer');
				$filter['status'] = $status;
			 	$this->design->assign('status', $status);
			}

		 	$type = $this->request->get('type', 'integer');
		  	if(empty($type) && $status == 0) {
                $type = 1;
            }

		  	if (!empty($type)) {
                $filter['type'] = $type;
                if (!isset($_GET['status'])) {
                   unset($filter['status']);
                }

            }


		  	$this->design->assign('type', $type);


			// Deposits
			if ($deposit = $this->request->get('deposit', 'integer')) {
				// $filter['status'] = 2; 
				$filter['deposit'] = 1;
				$this->design->assign('deposit', $deposit);
			}


		  	if($this->request->get('future') == 1)
		  	{
				$filter['future'] = date("Y-m-d"." 00:00:00");
				$filter['not_label'] = 8;
				$this->design->assign('future', 1);
		  	}
		  	elseif($type == 1 && $status == 0)
		  	{
		  		$filter['past'] = 1;
		  	}
		  	else{
		  		$filter['all'] = 1;
		  	}

		  	if($type == 1 && !isset($filter['future']))
		  	{
		  		// $filter['sort_date'] = 1;
		  	}

		  	if($type == 1 && $filter['status'] == 2)
		  	{
		  		$filter['sort_payment_date'] = 1;
		  	}

		  	if(!empty($filter['sort_by_create']))
		  	{
		  		unset($filter['status']);
		  		$filter['not_status'] = 3;
		  		if($type == 1)
		  			$filter['date_from'] = '2020-12-01'; // дата начиная с которой отображаем инвойсы
		  		$filter['past'] = 1;
				// unset($filter['past']);
		  		$filter['all_invoices'] = 1;

		  		$this->design->assign('sort_by_create', 1);
		  	}
		}

        if(!empty($this->request->get('notlabel')))
        {
            $filter['not_label'] = $this->request->get('notlabel');
            $this->design->assign('not_label_id', $this->request->get('notlabel'));
        }


				  	
	  	$orders_count = $this->orders->count_orders($filter);
		// Показать все страницы сразу
		if($this->request->get('page') == 'all')
			$filter['limit'] = $orders_count;	

		/// вывод юзеров контракту
		$filter['select_users'] = 1;

		// Отображение
		// $orders = array();
		// foreach($this->orders->get_orders($filter) as $o)
		// 	$orders[$o->id] = $o;
		$orders = $this->orders->get_orders($filter);
		$orders = $this->request->array_to_key($orders, 'id');

        if (!empty($purchasesParam) && $purchasesParam == 'show' && !empty($orders)) {
            if ($purchases = $this->orders->get_purchases(['order_id' => array_keys($orders)])) {
                foreach ($purchases as $purchase) {
                    if (isset($orders[$purchase->order_id])) {
                        $orders[$purchase->order_id]->purchases[$purchase->id] = $purchase;
                    }
                }
            }
        }

        $contract_ids = [];
        foreach ($orders as $o) {
            if($o->deposit == 0 && !is_null($o->date_from) && !is_null($o->date_to))
            {
                $interval = date_diff(date_create($o->date_from), date_create($o->date_to));
                $o->days_count = $interval->days + 1;
            }

            if (!empty($o->contract_id)) {
                $contract_ids[$o->contract_id] = $o->contract_id;
            }
        }

        $contracts = [];
        if (!empty($contract_ids)) {
            $contracts = $this->contracts->get_contracts([
                'id' => $contract_ids
            ]);
        }

		// Метки заказов
		$orders_labels = array();
		if(!empty($orders))
		{
			$ols = $this->orders->get_order_labels(array_keys($orders));
			if(!empty($ols))
			{
				foreach($ols as $ol)
	  				$orders[$ol->order_id]->labels[] = $ol;
			}
		}
	  	
	 	$this->design->assign('pages_count', ceil($orders_count/$filter['limit']));
	 	$this->design->assign('current_page', $filter['page']);





	
		// Метки заказов
	  	$labels = $this->orders->get_labels();
        $labels = $this->request->array_to_key($labels, 'id');
	 	$this->design->assign('labels', $labels);

		$this->design->assign('types', $this->orders->types);
	 	

	 	if($this->request->get('first') == 1)
	  	{
	  		$date_from = date("Y-m");
		  	$filter_date_from = $date_from.'-01';

		  	$date_to = date("Y-m");
		  	$filter_date_to = $date_to.'-31';

		  	if($this->request->get('date_from'))
			{
				$filter_date_from = $this->request->get('date_from');
			}

			if($this->request->get('date_to'))
			{
				$filter_date_to = $this->request->get('date_to');
			}

	  		foreach ($orders as $order) 
	  		{
	  			if(!empty($order->users))
	  				$orders_by_user[current($order->users)->id][$order->payment_date] = $order;
	  			else
	  				$orders_by_user[$order->user_id][$order->payment_date] = $order;
	  		}
	  		$orders_by_date_count = 0;
            $orders_by_date = [];
	  		foreach ($orders_by_user as $obu) 
	  		{
	  			ksort($obu);

  				$day = current($obu)->payment_date;
  				if(strtotime($day) >= strtotime($filter_date_from) && strtotime($day) <= strtotime($filter_date_to))
  				{
  					$orders_by_date_count++;
  					$orders_by_date[date('Y-m-d', strtotime($day))][] = current($obu);
  				}
	  		}
	  		krsort($orders_by_date);

	  		$this->design->assign('orders_count', $orders_by_date_count);
	
	 		$this->design->assign('orders', $orders_by_date);
	 		$this->design->assign('date_from', $filter_date_from);
			$this->design->assign('date_to', $filter_date_to);

			return $this->design->fetch('orders_by_date.tpl'); exit;

		}
		else
		{
			$this->design->assign('orders_count', $orders_count);
	
	 		$this->design->assign('orders', $orders);
		}

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
                // $this->selected_house = current($houses);
            }



        }

        $this->design->assign('cities_houses', $cities_houses);
        $this->design->assign('selected_house', $selected_house);

        $this->design->assign('payment_methods_all', $payment_methods_all);
        $this->design->assign('payment_methods', $payment_methods);
        $this->design->assign('orders_statuses', $this->orders->statuses);

        $this->design->assign('contracts', $contracts);

	  	
		return $this->design->fetch('invoices/invoices.tpl');
	}
}
