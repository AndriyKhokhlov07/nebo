<?PHP


require_once('api/Backend.php');

// Этот класс выбирает модуль в зависимости от параметра Section и выводит его на экран
class IndexAdmin extends Backend
{
	// Соответсвие модулей и названий соответствующих прав
	private $modules_permissions = array(
		'UsersAdmin'          => 'users',
		'UserAdmin'           => 'users',
		'MoveInAdmin'         => 'users',
		'FarewellAdmin'       => 'users',
		'ChangeBookingAdmin'  => 'users',
		'FaqAdmin'  	 	  => 'users',


		'ContractAdmin'       => 'contracts',
		'ContractsAdmin' 	  => 'contracts',
		'ContractsDownloadsAdmin'   => 'contracts',

		'PagesAdmin'          => 'pages',
		'PageAdmin'           => 'pages',
		'BlogAdmin'           => 'blog',
		'PostAdmin'           => 'blog',
		'BlogTagsAdmin' 	  => 'blog',
		'BlogTagAdmin' 		  => 'blog',
		'AuthorsAdmin'   	  => 'blog',
		'AuthorAdmin'   	  => 'blog',
		'CategoriesGalleriesAdmin'  => 'galleries',
		'CategoryGalleriesAdmin'	=> 'galleries',
		'GalleriesAdmin'			=> 'galleries',
		'GalleryAdmin'				=> 'galleries',
		'ImageGalleryAdmin'	  => 'galleries',
		'CommentsAdmin'       => 'comments',
		'FeedbacksAdmin'      => 'feedbacks',
		'ThemeAdmin'          => 'design',
		'StylesAdmin'         => 'design',
		'TemplatesAdmin'      => 'design',
		'ImagesAdmin'         => 'design',
		'SettingsAdmin'       => 'settings',
		'ManagersAdmin'       => 'managers',
		'ManagerAdmin'        => 'managers',
		'LicenseAdmin'        => 'license',
		
		'GroupsAdmin'         => 'groups',
		'GroupAdmin'          => 'groups',
		'IssuesAdmin' 		  => 'issues',
		'IssueAdmin' 		  => 'issues',

		'ProductsAdmin'       => 'products',
		'ProductAdmin'        => 'products',
		'CategoriesAdmin'     => 'categories',
		'CategoryAdmin'       => 'categories',
		'BrandsAdmin'         => 'brands',
		'BrandAdmin'          => 'brands',
		'FeaturesAdmin'       => 'features',
		'FeatureAdmin'        => 'features',
		'OrdersAdmin'         => 'orders',
		'OrderAdmin'          => 'orders',
		'OrdersStatAdmin'     => 'orders',
		'OrdersDebtAdmin'     => 'orders',
		'OrdersLabelsAdmin'   => 'labels',
		'OrdersLabelAdmin'    => 'labels',
		'CouponsAdmin'        => 'coupons',
		'CouponAdmin'         => 'coupons',
		'ImportAdmin'         => 'import',
		'ExportAdmin'         => 'users',
		'ExportCleaningsAdmin' => 'users',

		'BackupAdmin'         => 'backup',
		'StatsAdmin'          => 'stats',
		'CurrencyAdmin'       => 'currency',
		'DeliveriesAdmin'     => 'delivery',
		'DeliveryAdmin'       => 'delivery',
		'PaymentMethodAdmin'  => 'payment',
		'PaymentMethodsAdmin' => 'payment',

		'InventoriesHousesAdmin'=> 'inventories',
		'InventoryAdmin' 		=> 'inventories',
		'InventoriesItemsAdmin' => 'inventories',
		'InventoriesItemAdmin'  => 'inventories',
		'InventoriesGroupsAdmin'=> 'inventories',
		'InventoriesGroupAdmin' => 'inventories',
		'InventoriesAdmin' 		=> 'inventories',
		'CleaningHousesAdmin'   => 'cleaning',
		'CleaningAdmin' 		=> 'cleaning',
		'CleaningJournalAdmin'  => 'cleaning',
		'CleaningStatAdmin'     => 'cleaning',


		'ApartmentsAdmin'  		=> 'beds',
		'ApartmentAdmin'    	=> 'beds',
		'RoomsAdmin'  			=> 'beds',
		'RoomAdmin'    			=> 'beds',
		'RoomsTypesAdmin' 		=> 'beds',
		'RoomsTypeAdmin'    	=> 'beds',
		'RoomsLabelsAdmin'   	=> 'beds',
		'RoomsLabelAdmin'    	=> 'beds',
		'NeighborhoodsAdmin'    => 'beds',
		'NeighborhoodAdmin'     => 'beds',
        'DistrictsAdmin'        => 'beds',

		'BedsAdmin'      		=> 'beds_journal',
		'BedAdmin'    	 		=> 'beds_journal',
		'AddBookingAdmin'    	=> 'beds_journal',
		'BookingAdmin'    		=> 'beds_journal_edit',

		'AddBedJournalAdmin'    => 'beds_journal', // to del
		'BedJournalAdmin'    	=> 'beds_journal_edit', // to del

		'NotificationsHousesAdmin' => 'notifications',
		'NotificationAdmin' => 'notifications',
		'NotificationJournalAdmin' => 'notifications',
		'MoveInOutStatAdmin'  => 'users',

		'CostsHousesAdmin' => 'costs',
		'CostAdmin' => 'costs',
		'CostJournalAdmin' => 'costs',

		'CompaniesAdmin' => 'companies',
		'CompanyAdmin' 	 => 'companies',

		'RentRollAdmin'  => 'rentroll',
		'TenantsAdmin' 	 => 'tenants',
		'OccupancyAdmin' => 'tenants',
		'SalesAdmin' 	 => 'tenants'
	);


	// Конструктор
	public function __construct()
	{
	    // Вызываем конструктор базового класса
		parent::__construct();

		$menus = $this->pages->get_menus();
		if(!empty($menus)){
			foreach($menus as $m)
			{
				$this->modules_permissions['menu_'.$m->id] = 'menu_'.$m->id;
			}
		}
		
				
		$p=11; $g=2; $x=7; $r = ''; $s = $x;
		$bs = explode(' ', $this->config->license);		
		foreach($bs as $bl){
			for($i=0, $m=''; $i<strlen($bl)&&isset($bl[$i+1]); $i+=2){
				$a = base_convert($bl[$i], 36, 10)-($i/2+$s)%26;
				$b = base_convert($bl[$i+1], 36, 10)-($i/2+$s)%25;
				$m .= ($b * (pow($a,$p-$x-1) )) % $p;}
			$m = base_convert($m, 10, 16); $s+=$x;
			for ($a=0; $a<strlen($m); $a+=2) $r .= @chr(hexdec($m{$a}.$m{($a+1)}));}

		@list($l->domains, $l->expiration, $l->comment) = explode('#', $r, 3);

		$l->domains = explode(',', $l->domains);
		$h = getenv("HTTP_HOST");
		if(substr($h, 0, 4) == 'www.') $h = substr($h, 4);
		/*if((!in_array($h, $l->domains) || (strtotime($l->expiration)<time() && $l->expiration!='*')) && $this->request->get('module')!='LicenseAdmin')
			header('location: '.$this->config->root_url.'/backend/index.php?module=LicenseAdmin');
 		else
 		{*/
 			$l->valid = true;
			$this->design->assign('license', $l);
		//}
		
		$this->design->assign('license', $l);

		$this->design->set_templates_dir('backend/design/html');
		$this->design->set_compiled_dir('backend/design/compiled');
		
		$this->design->assign('settings',	$this->settings);
		$this->design->assign('config',	$this->config);
		
		// Администратор
		$this->manager = $this->managers->get_manager();
		$this->design->assign('manager', $this->manager);

 		// Берем название модуля из get-запроса
		$module = $this->request->get('module', 'string');
		$module = preg_replace("/[^A-Za-z0-9]+/", "", $module);

		$module_dir = '';


		// Если не запросили модуль - используем модуль первый из разрешенных
		if(empty($module))
		{
			foreach($this->modules_permissions as $m=>$p)
			{
				if($this->managers->access($p))
				{
					$module = $m;
					break;
				}
			}
		}
		if(empty($module))
			$module = 'PagesAdmin';


		// Module Dir
		if(isset($this->modules_permissions[$module]))
		{
			if($this->modules_permissions[$module] == 'inventories')
				$module_dir = 'inventories';
			elseif($this->modules_permissions[$module] == 'blog')
				$module_dir = 'blog';
			elseif($this->modules_permissions[$module] == 'contracts')
				$module_dir = 'contracts';
			elseif($this->modules_permissions[$module] == 'cleaning')
				$module_dir = 'cleaning';
			elseif($this->modules_permissions[$module] == 'notifications')
				$module_dir = 'notifications';
			elseif($this->modules_permissions[$module] == 'beds' || $this->modules_permissions[$module] == 'beds_journal')
				$module_dir = 'bookings';
			elseif($this->modules_permissions[$module] == 'costs')
				$module_dir = 'costs';
			elseif(in_array($this->modules_permissions[$module], ['rentroll', 'tenants', 'sales']))
				$module_dir = 'statistics';
		}


		// New restokings
		$new_inventories_counter = $this->inventories->count_inventories(array('view'=>0, 'is_default'=>0));
		if(!empty($new_inventories_counter) && $this->modules_permissions[$module] == 'inventories')
		{
			$new_inventories = $this->inventories->get_inventories(array('view'=>0, 'is_default'=>0));
			$new_restokings = array();
			if(!empty($new_inventories))
			{
				foreach($new_inventories as $ni)
				{
					if(!isset($new_restokings[$ni->type][$ni->house_id]))
						$new_restokings[$ni->type][$ni->house_id] = 0;
					$new_restokings[$ni->type][$ni->house_id]++;

					if(!isset($new_restokings[$ni->type]['count']))
						$new_restokings[$ni->type]['count'] = 0;
					$new_restokings[$ni->type]['count']++;
				}
				$this->design->assign("new_restokings",  $new_restokings);
				unset($new_inventories);
			}	
		}
		$this->design->assign("new_inventories_counter", $new_inventories_counter);

		

		if(!empty($module_dir))
			$module_dir = 'view/'.$module_dir.'/';
		
		// Если не запросили модуль - используем модуль первый из разрешенных
		if(empty($module) || !is_file('backend/'.$module_dir.$module.'.php'))
		{
			foreach($this->modules_permissions as $m=>$p)
			{
				if($this->managers->access($p))
				{
					$module = $m;
					break;
				}
			}
		}
		if(empty($module))
			$module = 'PagesAdmin';

		// Подключаем файл с необходимым модулем
		require_once('backend/'.$module_dir.$module.'.php');  
		
		// Создаем соответствующий модуль
		if(class_exists($module))
			$this->module = new $module();
		else
			die("Error creating $module class");

	}

	function fetch()
	{
		$currency = $this->money->get_currency();
		$this->design->assign("currency", $currency);
		
		// Проверка прав доступа к модулю
		if(isset($this->modules_permissions[get_class($this->module)])
		&& $this->managers->access($this->modules_permissions[get_class($this->module)]))
		{
			$content = $this->module->fetch();
			$this->design->assign("content", $content);
		}
		else
		{
			$this->design->assign("content", "Permission denied");
		}

		// Счетчики для верхнего меню
		$new_orders_counter = $this->orders->count_orders(array('status'=>0));
		$this->design->assign("new_orders_counter", $new_orders_counter);
		
		$new_comments_counter = $this->comments->count_comments(array('approved'=>0));
		$this->design->assign("new_comments_counter", $new_comments_counter);

		
		// Создаем текущую обертку сайта (обычно index.tpl)
		$wrapper = $this->design->smarty->getTemplateVars('wrapper');
		if(is_null($wrapper))
			$wrapper = 'index.tpl';
			
		if(!empty($wrapper))
			return $this->body = $this->design->fetch($wrapper);
		else
			return $this->body = $content;
	}
}