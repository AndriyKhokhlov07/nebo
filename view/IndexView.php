<?PHP


require_once('View.php');

class IndexView extends View
{	
	public $modules_dir = 'view/';

	public function __construct()
	{
		parent::__construct();
	}

		
	/**
	 *
	 * Отображение
	 *
	 */
	function fetch()
	{
		// Устанавливаем куку, чтоб показать всплывающее окно на подписку 1 раз
		SetCookie('md_subscription', 1);
		
		// SetCookie('md_subscription', 1, time() + 3600, '/', $this->config->root_url);
		
		// Страницы
		$pages = $this->pages->get_pages(array('visible'=>1));
		$pages = $this->pages->get_pages_tree();		
		$this->design->assign('pages', $pages);

		if(!empty($this->user))
		{
			// Категории товаров
			$this->design->assign('categories', $this->categories->get_categories_tree());
		}
		

		
		//$this->design->assign('plus14days', strtotime('+14 day'));
		$unixtime = time(); // your date in unix format 
		$this->design->assign('lastday', date('t', $unixtime));
							
		// Текущий модуль (для отображения центрального блока)
		$module = $this->request->get('module', 'string');
		$module = preg_replace("/[^A-Za-z0-9]+/", "", $module);

		if($this->request->this_url)
		{
			if(in_array($this->request->this_url, array('blog', 'tag', 'author')))
				$module = 'BlogView';
			elseif($this->page)
				$module = 'PageView';

			/*elseif($this->categories->get_category((string)$this->request->this_url))
				$module = 'ProductsView';
			
			elseif($this->products->get_product((int)( ((int)substr($this->request->this_url, 1) - (int)$this->config->staff_number) )))
				$module = 'ProductView';*/
		}
		elseif(empty($module))
			$module = 'MainView';

		$this->design->assign('this_url', $this->request->this_url);

		// Если не задан - берем из настроек
		if(empty($module))
			return false;
		//$module = $this->settings->main_module;



		switch($module)
		{
			case 'LandlordView':
			case 'LandlordTenantsView':
			case 'LandlordRentRollView':
			case 'LandlordRentRoll2View':
			case 'LandlordRentRollWView':
			case 'LandlordRentRoll30View':
			case 'LandlordRentRoll32View':
			case 'LandlordRentRoll33View':
			case 'LandlordRentRoll4View':
			case 'LandlordRentRoll5View':
			case 'LandlordRentRoll6View':
			case 'LandlordBookingsView':
			case 'LandlordApproveView':
			case 'LandlordTenantDirectoryView':
            case 'LandlordHouseStatsView':
				$this->modules_dir .= 'landlord/';
				break;
			case 'AddGuarantorFormView':
            case 'DepositQiraView':
				$this->modules_dir .= 'tenant/';
				break;
			case 'GuarantorAgreementView':
				$this->modules_dir .= 'guarantor/';
				break;
            case 'SureRentersPlansView':
            case 'SureRentersCheckoutView':
            case 'SureRentersPurchaseView':
            case 'SureThankYouView':
                $this->modules_dir .= 'sure/';
                break;
		}


		// if($_SESSION['admin'])
		// {
		// 	print "<!--\r\n";
		// 	print_r($module);
		// 	print "\r\n";
		// 	print " -->";
		// }



		// Создаем соответствующий класс
		if(is_file($this->modules_dir.$module.".php"))
		{
            include_once($this->modules_dir.$module.".php");

            if(class_exists($module))
                $this->main = new $module($this);
            else
                return false;
		}
		else 
			return false;

		// Создаем основной блок страницы
		if (!$content = $this->main->fetch())
		{
			return false;
		}



		// Передаем основной блок в шаблон
		$this->design->assign('content', $content);		
		

		// Передаем название модуля в шаблон, это может пригодиться
		$this->design->assign('module', $module);
				
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
