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

		// Фильтр по варианту оплаты
	  	$payment_method = $this->payment->get_payment_method($this->request->get('payment_method_id'));	  	
	  	if(!empty($payment_method))
	  	{
		  	$filter['payment_method_id'] = $payment_method->id;
		 	$this->design->assign('payment_method', $payment_method);
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
		  	if(empty($type) && $status == 0)
		  		$type = 1;
		  	if(!empty($type))
		  		$filter['type'] = $type;

		  	$this->design->assign('type', $type);

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
		  		$filter['sort_date'] = 1;
		  	}

		  	if($type == 1 && $filter['status'] == 2)
		  	{
		  		$filter['sort_payment_date'] = 1;
		  	}

		  	if(!empty($filter['sort_by_create']))
		  	{
		  		unset($filter['status']);
		  		$filter['not_status'] = 3;
		  		$filter['date_from'] = '2020-12-01'; // дата начиная с которой отображаем инвойсы
		  		$filter['past'] = 1;
		  		$this->design->assign('sort_by_create', 1);
		  	}
		  	
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
	 	



	 	// Все способы оплаты
	 	$payment_methods = array();
		$payment_methods_ = $this->payment->get_payment_methods();
		if(!empty($payment_methods_))
		{
			foreach($payment_methods_ as $pm)
				$payment_methods[$pm->id] = $pm;
			unset($payment_methods_);
		}
		$this->design->assign('payment_methods', $payment_methods);
	
		// Метки заказов
	  	$labels = $this->orders->get_labels();
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
	  	
		return $this->design->fetch('orders.tpl');
	}
}
