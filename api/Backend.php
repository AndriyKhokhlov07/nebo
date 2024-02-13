<?php

/**
 * Class Backend
 *
 * @property DatabasePDO $dbPdo
 * @property Database $db
 * @property Users $users
 * @property Orders $orders
 * @property Design $design
 * @property Payment $payment
 * @property Pages $pages
 * @property CategoriesTree $categories_tree
 * @property Beds $beds
 * @property Sure $sure
 * @property Request $request
 */
class Backend
{
    private static $instanceObj;

	// Свойства - Классы API
	private $classes = array(
		'config'     => 'Config',
		'request'    => 'Request',
		'db'         => 'Database',
		'settings'   => 'Settings',
		'design'     => 'Design',
		'categories_tree' => 'CategoriesTree',
		'galleries'	 => 'Galleries',
		'pages'      => 'Pages',
		'cleaning'   => 'Cleaning',
		'loans'		 => 'Loans',

        'houses'     => 'Houses',

        'blog'       => 'Blog',
		'simpleimage'=> 'SimpleImage',
		'image'      => 'Image',
		'comments'   => 'Comments',
		'feedbacks'  => 'Feedbacks',
		'issues'     => 'Issues',
		'notify'     => 'Notify',
		'managers'   => 'Managers',
		'users'      => 'Users',
		'tokeet' 	 => 'Tokeet',
		'products'   => 'Products',
		'variants'   => 'Variants',
		'categories' => 'Categories',
		'brands'     => 'Brands',
		'features'   => 'Features',
		'money'      => 'Money',
		'cart'       => 'Cart',
		'delivery'   => 'Delivery',
		'payment'    => 'Payment',
		'orders'     => 'Orders',
		'coupons'    => 'Coupons',
		'inventories'=> 'Inventories',
		'houseleader'=> 'Houseleader',
		'contracts'  => 'Contracts',
		'notifications' => 'Notifications',
		'checkr' => 'Checkr',
		'transunion' => 'Transunion',
		'hellorented' => 'Hellorented',
		'beds' => 'Beds',
		'logs' => 'Logs',
		'sure' => 'Sure',
		'ekata' => 'Ekata',
		'guesty' => 'Guesty',
		'costs' => 'Costs',
		'companies' => 'Companies',
		'sales_statistics' => 'SalesStatistics',
		'cache' => 'Cache',
		'occupancy' => 'Occupancy',
		'rentroll' => 'RentRoll',
        'house_stats' => 'HouseStats',
		'salesflows' => 'Salesflows',
		'properties' => 'Properties',
		'prebookings' => 'Prebookings',
		'forms' => 'Forms',
        'dbPdo' => 'DatabasePDO',
	);
	
	// Созданные объекты
	private static $objects = array();
	
	/**
	* Конструктор оставим пустым, но определим его на случай обращения parent::__construct() в классах API
	*/
	public function __construct()
	{
		//error_reporting(E_ALL & !E_STRICT);

        spl_autoload_register([$this, 'autoload']);

        if(!defined('ROOT_PATH')){
            $path = __DIR__ . DIRECTORY_SEPARATOR;
            $prefix = '';
            while(!file_exists($path . $prefix . 'autoloader.php')){
                $prefix .= '..' . DIRECTORY_SEPARATOR;
            }
            define('ROOT_PATH', realpath($path . $prefix));
            require_once (ROOT_PATH . DIRECTORY_SEPARATOR . 'autoloader.php');
        }
        spl_autoload_register(function($className) {
            $file = ROOT_PATH . DIRECTORY_SEPARATOR . $className . '.php';
            $file = str_replace('\\', DIRECTORY_SEPARATOR, $file);
            if (file_exists($file)) {
                include_once $file;
            }
        });
	}

	/**
	 * Магический метод, создает нужный объект API
	 */
	public function __get($name)
	{
	    $object = self::$objects[$name] ?? null;

	    if (!$object) {
	        $class = $this->classes[$name] ?? null;

            return $class ? self::$objects[$name] = new $class() : null;
        }

	    return $object;
	}

	private function autoload($className)
    {
        $class = dirname(__FILE__) . "/{$className}.php";
        $trait = dirname(__FILE__) . "/traits/{$className}.php";
        $model = dirname(__FILE__) . "/models/{$className}.php";

        if (file_exists($class)) {
            include_once($class);
        }

        if (file_exists($trait)) {
            include_once($trait);
        }

        if (file_exists($model)) {
            include_once($model);
        }
    }

    public static function backendApp(): self
    {
        if (!self::$instanceObj) {
            self::$instanceObj = new static();
        }

        return self::$instanceObj;
    }
}