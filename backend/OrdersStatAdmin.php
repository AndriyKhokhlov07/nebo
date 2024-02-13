<?PHP 

require_once('api/Backend.php');

########################################
class OrdersStatAdmin extends Backend
{
	public function fetch()
	{
	 	$filter = array();
	  	$filter['page'] = max(1, $this->request->get('page', 'integer'));
	  		
	  	$filter['limit'] = 500;


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


		$status = $this->request->get('status', 'integer');
		$filter['status'] = $status;
	 	$this->design->assign('status', $status);

	 	$type = $this->request->get('type', 'integer');
	  	if(empty($type) && $status == 0)
	  		$type = 1;
	  	if(!empty($type))
	  		$filter['type'] = $type;

	  	$this->design->assign('type', $type);

	  	$date_from = date("Y-m");
	  	$filter['date_from'] = $date_from.'-01';

	  	$date_to = date("Y-m");
	  	$filter['date_to'] = $date_to.'-31';

	  	if($this->request->get('date_from'))
		{
			$filter['date_from'] = $this->request->get('date_from');
		}

		if($this->request->get('date_to'))
		{
			$filter['date_to'] = $this->request->get('date_to');
		}

		// Houses
		$houses = $this->pages->get_pages(array('menu_id'=>5, 'not_tree'=>1));
		if(!empty($houses))
			$houses= $this->categories_tree->get_categories_tree('houses', $houses);
		$house = null;
		$house_id = $this->request->get('house_id', 'integer');
		if(!empty($house_id))
		{
			$house = $this->pages->get_page($house_id);
			$contracts_ids = array();
			$contracts = $this->contracts->get_contracts(array('status'=>array(1,2), 'house_id'=>$house->id));
			if(!empty($contracts))
			foreach ($contracts as $c) 
			{
				$contracts_ids[] = $c->id;
			}

			$filter['contract_id'] = $contracts_ids;
		}


				  	
	  	$orders_count = $this->orders->count_orders($filter);
		// Показать все страницы сразу
		if($this->request->get('page') == 'all')
			$filter['limit'] = $orders_count;	


		

		// Отображение
		$orders = array();
		foreach($this->orders->get_orders($filter) as $o)
			$orders[$o->id] = $o;
	 	
		// Метки заказов
		$orders_labels = array();
	  	foreach($this->orders->get_order_labels(array_keys($orders)) as $ol)
	  		$orders[$ol->order_id]->labels[] = $ol;
	  	
	 	$this->design->assign('pages_count', ceil($orders_count/$filter['limit']));
	 	$this->design->assign('current_page', $filter['page']);
	  	
	 	$this->design->assign('orders_count', $orders_count);
	
	 	$this->design->assign('orders', $orders);

		$this->design->assign('date_from', $filter['date_from']);
		$this->design->assign('date_to', $filter['date_to']);

		$this->design->assign('houses', $houses);
		$this->design->assign('house',  $house);

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
	  	
		return $this->design->fetch('orders_stat.tpl');
	}
}
