<?PHP


require_once('api/Backend.php');

// Этот класс выбирает модуль в зависимости от параметра Section и выводит его на экран
class IndexAdmin extends Backend
{
    // Соответсвие модулей и названий соответствующих прав
    private $modules_permissions = array(
        'UsersAdmin' => 'users',
        'UserAdmin' => 'users',
        'MoveInAdmin' => 'users',
        'FarewellAdmin' => 'users',
        'ChangeBookingAdmin' => 'users',
        'FaqAdmin' => 'users',


        'ContractAdmin' => 'contracts',
        'ContractsAdmin' => 'contracts',
        'ContractsDownloadsAdmin' => 'contracts',

        'LeasesListAdmin' => 'leases',
        'LeasesAdmin' => 'leases_edit',
        'LeaseAdmin' => 'leases_edit',

        'PagesAdmin' => 'pages',
        'PageAdmin' => 'pages',


        'BlogAdmin' => 'blog',
        'PostAdmin' => 'blog',
        'BlogTagsAdmin' => 'blog',
        'BlogTagAdmin' => 'blog',
        'AuthorsAdmin' => 'blog',
        'AuthorAdmin' => 'blog',
        'CategoriesGalleriesAdmin' => 'galleries',
        'CategoryGalleriesAdmin' => 'galleries',
        'GalleriesAdmin' => 'galleries',
        'GalleryAdmin' => 'galleries',
        'ImageGalleryAdmin' => 'galleries',
        'CommentsAdmin' => 'comments',
        'FeedbacksAdmin' => 'feedbacks',
        'ThemeAdmin' => 'design',
        'StylesAdmin' => 'design',
        'TemplatesAdmin' => 'design',
        'ImagesAdmin' => 'design',
        'SettingsAdmin' => 'settings',
        'ExternalLogsAdmin' => 'settings',
        'ManagersAdmin' => 'managers',
        'ManagerAdmin' => 'managers',
        'LicenseAdmin' => 'license',

        'GroupsAdmin' => 'groups',
        'GroupAdmin' => 'groups',
        'IssuesAdmin' => 'issues',
        'IssueAdmin' => 'issues',

        'ProductsAdmin' => 'products',
        'ProductAdmin' => 'products',
        'CategoriesAdmin' => 'categories',
        'CategoryAdmin' => 'categories',
        'BrandsAdmin' => 'brands',
        'BrandAdmin' => 'brands',
        'FeaturesAdmin' => 'features',
        'FeatureAdmin' => 'features',
        'OrdersAdmin' => 'orders',
        'OrderAdmin' => 'orders',
        'OrdersStatAdmin' => 'orders_stats',
        'OrdersDebtAdmin' => 'orders_debt',
        'OrdersLabelsAdmin' => 'labels',
        'OrdersLabelAdmin' => 'labels',
        'CouponsAdmin' => 'coupons',
        'CouponAdmin' => 'coupons',
        'ImportAdmin' => 'import',
        'ExportAdmin' => 'users',
        'ExportCleaningsAdmin' => 'users',

        'BackupAdmin' => 'backup',



        'CurrencyAdmin' => 'currency',
        'DeliveriesAdmin' => 'delivery',
        'DeliveryAdmin' => 'delivery',
        'PaymentMethodAdmin' => 'payment',
        'PaymentMethodsAdmin' => 'payment',

        'InventoriesHousesAdmin' => 'inventories',
        'InventoryAdmin' => 'inventories',
        'InventoriesItemsAdmin' => 'inventories',
        'InventoriesItemAdmin' => 'inventories',
        'InventoriesGroupsAdmin' => 'inventories',
        'InventoriesGroupAdmin' => 'inventories',
        'InventoriesAdmin' => 'inventories',
        'CleaningHousesAdmin' => 'cleaning',
        'CleaningAdmin' => 'cleaning',
        'CleaningJournalAdmin' => 'cleaning',
        'CleaningStatAdmin' => 'cleaning',


        'ApartmentsAdmin' => 'beds',
        'ApartmentAdmin' => 'beds',
        'RoomsAdmin' => 'beds',
        'RoomAdmin' => 'beds',
        'PriceUpdateAdmin' => 'beds',
        'RoomsTypesAdmin' => 'beds',
        'RoomsTypeAdmin' => 'beds',
        'RoomsLabelsAdmin' => 'beds',
        'RoomsLabelAdmin' => 'beds',
        'NeighborhoodsAdmin' => 'beds',
        'NeighborhoodAdmin' => 'beds',
        'DistrictsAdmin' => 'beds',
        'DistrictAdmin' => 'beds',

        'BedsAdmin' => 'beds_journal',
        'BedAdmin' => 'beds_journal',
        'AddBookingAdmin' => 'beds_journal',
        'BookingAdmin' => 'beds_journal_edit',

        'BookingsAdmin' => 'beds_journal',

        'BedsCalendarAdmin' => 'beds_journal',

        'AddBedJournalAdmin' => 'beds_journal', // to del
        'BedJournalAdmin' => 'beds_journal_edit', // to del

        'NotificationsHousesAdmin' => 'notifications',
        'NotificationAdmin' => 'notifications',
        'NotificationJournalAdmin' => 'notifications',
        'MoveInOutStatAdmin' => 'notifications',

        'CostsHousesAdmin' => 'costs',
        'CostAdmin' => 'costs',
        'CostJournalAdmin' => 'costs',

        'CompaniesAdmin' => 'companies',
        'CompanyAdmin' => 'companies',
        'CompaniesGroupsAdmin' => 'companies',
        'CompaniesGroupAdmin' => 'companies',

        'RentRollAdmin' => 'rentroll',
        'RentRoll1Admin' => 'rentroll',
        'RentRoll2Admin' => 'rentroll',
        'RentRoll3Admin' => 'rentroll',
        'RentRoll4Admin' => 'rentroll',
        'RentRoll5Admin' => 'rentroll',
        'RentRoll6Admin' => 'rentroll',
        // 'RentRoll21Admin'  => 'rentroll',
        'DepositsAdmin' => 'rentroll',
        'TenantsAdmin' => 'tenants',

        'HouseAdmin' => 'houses',
        'HousesAdmin' => 'houses',

        'PropertiesAdmin' => 'houses',

        'OccupancyAdmin2' => 'tenants',
        'OccupancyYearAdmin' => 'tenants',

        'StatsAdmin' => 'stats',
        'HouseStatsAdmin' => 'stats_house',

        'OccupancyAdmin' => 'stats_occupancy',
        'SalesAdmin' => 'stats_sales',
        'SalesTeamAdmin' => 'stats_sales_team',
        'PrebookingsAdmin' => 'prebookings',
        'ResidentLedgerAdmin' => 'ledger',
    );


    // Конструктор
    public function __construct()
    {
        // Вызываем конструктор базового класса
        parent::__construct();

        $menus = $this->pages->get_menus();
        if (!empty($menus)) {
            foreach ($menus as $m) {
                $this->modules_permissions['menu_' . $m->id] = 'menu_' . $m->id;
            }
        }




        $l->domains = explode(',', $l->domains);
        $h = getenv("HTTP_HOST");
        if (substr($h, 0, 4) == 'www.') $h = substr($h, 4);
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

        $this->design->assign('settings', $this->settings);
        $this->design->assign('config', $this->config);

        // Администратор
        $this->manager = $this->managers->get_manager();
        $this->design->assign('manager', $this->manager);
        $_SESSION['admin_login'] = $this->manager->login;


        // Берем название модуля из get-запроса
        $module = $this->request->get('module', 'string');
        $module = preg_replace("/[^A-Za-z0-9]+/", "", $module);

        $module_dir = '';


        // Если не запросили модуль - используем модуль первый из разрешенных
        if (empty($module)) {
            foreach ($this->modules_permissions as $m => $p) {
                if ($this->managers->access($p)) {
                    $module = $m;
                    break;
                }
            }
        }
        if (empty($module))
            $module = 'PagesAdmin';


        // Module Dir
        if (isset($this->modules_permissions[$module])) {
            switch ($this->modules_permissions[$module]) {
                case 'coupons':
                case 'currency':
                case 'delivery':
                case 'payment':
                case 'settings':
                case 'managers':
                case 'design':
                case 'backup':
                    $module_dir = 'settings';
                    break;
                case 'users':
                case 'ledger':
                    $module_dir = 'users';
                    break;
                case 'inventories':
                    $module_dir = 'inventories';
                    break;
                case 'blog':
                    $module_dir = 'blog';
                    break;
                case 'contracts':
                case 'leases':
                case 'leases_edit':
                    $module_dir = 'contracts';
                    break;
                case 'cleaning':
                    $module_dir = 'cleaning';
                    break;
                case 'notifications':
                    $module_dir = 'notifications';
                    break;
                case 'beds':
                case 'beds_journal':
                    $module_dir = 'bookings';
                    break;
                case 'houses':
                    $module_dir = 'houses';
                    break;
                case 'rentroll':
                case 'tenants':
                case 'sales':

                case 'stats':
                case 'stats_occupancy':
                case 'stats_house':
                case 'stats_sales':
                case 'stats_sales_team':
                    $module_dir = 'statistics';
                    break;
                case 'companies':
                    $module_dir = 'companies';
                    break;
                case 'costs':
                    $module_dir = 'costs';
                    break;
                case 'prebookings':
                    $module_dir = 'prebookings';
                    break;
            }
        }


        // New restokings
        /*
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
        */


        if (!empty($module_dir))
            $module_dir = 'view/' . $module_dir . '/';

        // Если не запросили модуль - используем модуль первый из разрешенных
        if (empty($module) || !is_file('backend/' . $module_dir . $module . '.php')) {
            foreach ($this->modules_permissions as $m => $p) {
                if ($this->managers->access($p)) {
                    $module = $m;
                    break;
                }
            }
        }
        if (empty($module))
            $module = 'PagesAdmin';


        // Подключаем файл с необходимым модулем
        require_once('backend/' . $module_dir . $module . '.php');

        // Создаем соответствующий модуль
        if (class_exists($module))
            $this->module = new $module();
        else
            die("Error creating $module class");

    }

    function fetch()
    {
        $currency = $this->money->get_currency();
        $this->design->assign("currency", $currency);

        $this->design->assign('house_types', $this->pages->house_types);
        $this->design->assign('apartment_types', $this->beds->apartment_types);

        if (!isset($_COOKIE['opened_sidebar'])) {
            $_COOKIE['opened_sidebar'] = 'opened';
        }

        // Проверка прав доступа к модулю
        if (isset($this->modules_permissions[get_class($this->module)])
            && $this->managers->access($this->modules_permissions[get_class($this->module)])) {
            $content = $this->module->fetch();
            $this->design->assign("content", $content);
        } else {
            $this->design->assign("content", "Permission denied");
        }

        // Счетчики для верхнего меню
        // $new_orders_counter = $this->orders->count_orders(array('status'=>0));
        // $this->design->assign("new_orders_counter", $new_orders_counter);

        // $new_comments_counter = $this->comments->count_comments(array('approved'=>0));
        // $this->design->assign("new_comments_counter", $new_comments_counter);

        // Создаем текущую обертку сайта (обычно index.tpl)
        $wrapper = $this->design->smarty->getTemplateVars('wrapper');
        if (is_null($wrapper))
            $wrapper = 'index.tpl';

        if (!empty($wrapper))
            return $this->body = $this->design->fetch($wrapper);
        else
            return $this->body = $content;
    }
}