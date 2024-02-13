<?PHP


require_once('api/Backend.php');

class View extends Backend
{
	/* Смысл класса в доступности следующих переменных в любом View */
	public $currency;
	public $currencies;
	public $page;
	public $user;
	
	/* Класс View похож на синглтон, храним статически его инстанс */
	private static $view_instance;
	
	public function __construct()
	{
		parent::__construct();
		
		// Если инстанс класса уже существует - просто используем уже существующие переменные
		if(self::$view_instance)
		{
			$this->currency     = &self::$view_instance->currency;
			$this->currencies   = &self::$view_instance->currencies;
			$this->page = &self::$view_instance->page;	
			$this->user         = &self::$view_instance->user;
			// $this->group        = &self::$view_instance->group;	
		}
		else
		{
			// Сохраняем свой инстанс в статической переменной,
			// чтобы в следующий раз использовать его
			self::$view_instance = $this;

			// Все валюты
			$this->currencies = $this->money->get_currencies(array('enabled'=>1));
	
			// Выбор текущей валюты
			if($currency_id = $this->request->get('currency_id', 'integer'))
			{
				$_SESSION['currency_id'] = $currency_id;
				header("Location: ".$this->request->url(array('currency_id'=>null)));
			}
			
			// Берем валюту из сессии
			if(isset($_SESSION['currency_id']))
				$this->currency = $this->money->get_currency($_SESSION['currency_id']);
			// Или первую из списка
			else
				$this->currency = reset($this->currencies);



			// Пользователь, если залогинен
			if(isset($_SESSION['user_id']))
			{
				$u = $this->users->get_user(intval($_SESSION['user_id']));
				if($u && $u->enabled)
				{
					$this->user = $u;
					//$this->user->main_info = $this->tokeet->get_guest(array('email'=>$this->user->email));
					if(empty($_SESSION['user_name']) || $_SESSION['user_name'] != $this->user->name)
					{
						// tokeet off
						// $this->user->main_info = $this->tokeet->get_guest(array('email'=>$this->user->email));
						if(!empty($this->user->main_info['name']))
							$_SESSION['user_name'] =  $this->user->main_info['name'];
						else
							$_SESSION['user_name'] =  $this->user->name;
						if(!empty($this->user->main_info['phones']))
							$_SESSION['user_phone'] = current($this->user->main_info['phones']);
						elseif(!empty($this->user->main_info['phone']))
							$_SESSION['user_phone'] =  $this->user->main_info['phone'];
					}

					$this->user->booking = $this->beds->get_bookings([
					    'id' => $this->user->active_booking_id,
                        'limit' => 1
                    ]);

                    $this->user->contract = current($this->contracts->get_contracts([
                        'reserv_id' => $this->user->booking->id,
                        'limit' => 1
                    ]));

					if($this->user->type == 4) // LandLord
					{
						$this->user->landlords_companies = $this->users->get_landlords_houses([
							'user_id' => $this->user->id
						]);
						$this->user->landlords_companies = $this->request->array_to_key($this->user->landlords_companies, 'house_id');

						if(!empty($this->user->landlords_companies))
						{
							
							// LLC
							$this->user->houses_ids = [];
							$this->user->companies = $this->companies->get_companies([
								'id' => array_keys($this->user->landlords_companies)
							]);
							$this->user->companies = $this->request->array_to_key($this->user->companies, 'id');
							if(!empty($this->user->companies))
							{
								$this->user->company_houses_ids = $this->companies->get_company_houses([
									'company_id' => array_keys($this->user->companies)
								]);
								$this->user->company_houses_ids = $this->request->array_to_key($this->user->company_houses_ids, 'house_id');

								if(!empty($this->user->company_houses_ids))
								{									
									foreach($this->user->company_houses_ids as $house_id=>$ch)
									{
										$this->user->houses_ids[$house_id] = $house_id;
										if(in_array($house_id, $this->salesflows->approve_houses_ids))
										{
											$this->user->tenant_approve = true;
											$this->user->landlord_approve_houses_ids[$house_id] = $house_id;
										}
									}
								}
							}
						}

					}


					//$this->group = $this->users->get_group($this->user->group_id);
				
				}
			}	

			$url_parts = explode('?', $_SERVER['REQUEST_URI'], 2);
			$url_part = $url_parts[0];


			$trailed = $_SERVER['REQUEST_URI'];
			if (preg_match('/[[:upper:]]/', $trailed)) {
				$trailed = strtolower($trailed);
				header('HTTP/1.1 301 Moved Permanently'); 
				header('Location: https://'. $_SERVER["SERVER_NAME"] . $trailed);
				exit;
			}

			// Posts redirects 
			$bc_301 = $this->blog->get_posts(array('old_url'=>1));
			if(!empty($bc_301))
			{
				foreach($bc_301 as $pc)
				{
					if($url_part == '/'.$pc->old_url)
					{
						header("HTTP/1.1 301 Moved Permanently");
						header("Location: ".$this->config->root_url."/blog/".$pc->url);
						exit;
					}
				}			
			}

			// Pages redirects 
			$pr_301 = $this->pages->get_pages(array('old_url'=>1));
			if(!empty($pr_301))
			{
				foreach($pr_301 as $pr)
				{
					if($url_part == '/'.$pr->old_url)
					{
						header("HTTP/1.1 301 Moved Permanently");
						header("Location: ".$this->config->root_url."/".$pr->url);
						exit;
					}
				}			
			}
			

			// Текущая страница (если есть)
			$subdir = substr(dirname(dirname(__FILE__)), strlen($_SERVER['DOCUMENT_ROOT']));
			$page_url = trim(substr($_SERVER['REQUEST_URI'], strlen($subdir)),"/");
			if(strpos($page_url, '?') !== false)
				$page_url = substr($page_url, 0, strpos($page_url, '?'));
			$this->page = $this->pages->get_page((string)$page_url);
			$this->design->assign('page', $this->page);	

			$this->design->assign('currencies',	$this->currencies);
			$this->design->assign('currency',	$this->currency);

			$this->design->assign('config',		$this->config);
			$this->design->assign('settings',	$this->settings);
			$this->design->assign('user',       $this->user);

			$this->design->assign('airbnb_contracts_houses_ids', $this->salesflows->airbnb_contracts_houses_ids);

			// Настраиваем плагины для смарти
			$this->design->smarty->registerPlugin("function", "get_pages", array($this, 'get_pages_plugin'));
			$this->design->smarty->registerPlugin("function", "get_posts", array($this, 'get_posts_plugin'));
			$this->design->smarty->registerPlugin("function", "get_partners", array($this, 'get_partners_plugin'));
		}
	}
		
	/**
	 *
	 * Отображение
	 *
	 */
	function fetch()
	{
		return false;
	}
	
	/**
	 *
	 * Плагины для смарти
	 *
	 */	
	public function get_pages_plugin($params, &$smarty)
	{
		if(!isset($params['visible']))
			$params['visible'] = 1;
		if(!empty($params['var']))
			$smarty->assign($params['var'], $this->pages->get_pages($params));
	}
	public function get_posts_plugin($params, &$smarty)
	{
		if(!isset($params['visible']))
			$params['visible'] = 1;
		if(!empty($params['var']))
			$smarty->assign($params['var'], $this->blog->get_posts($params));
	}
	public function get_partners_plugin($params, &$smarty)
	{
		if(!isset($params['visible']))
			$params['visible'] = 1;
		if(!empty($params['var']))
			$smarty->assign($params['var'], $this->galleries->get_images(array('gallery_id'=>2)));

	}
}
