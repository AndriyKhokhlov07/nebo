<?php

 
require_once('Backend.php');

class Managers extends Backend
{

    public $permissions = [
        'pages'      => [
            'name' => 'Pages'
        ],
        'houses'  	 => [
            'name' => 'Houses'
        ],
        'blog'       => [
            'name' => 'Blog'
        ],
        'galleries'  => [
            'name' => 'Galleries'
        ],
        'comments'   => [
            'name' => 'Comments'
        ],
        'feedbacks'  => [
            'name' => 'Feedbacks'
        ],
        'design'     => [
            'name' => 'Design'
        ],
        'settings'   => [
            'name' => 'Settings'
        ],
        'managers'   => [
            'name' => 'Managers'
        ],
        'backup'  	 => [
            'name' => 'Backup'
        ],
        'issues' 	 => [
            'name' => 'Issues'
        ],
        'products'   => [
            'name' => 'Products'
        ],
        'categories' => [
            'name' => 'Categories'
        ],
        'brands'     => [
            'name' => 'Brands'
        ],
        'features'   => [
            'name' => 'Features'
        ],
        'orders'     => [
            'name' => 'Orders'
        ],
        'orders_edit' => [
            'name' => 'Orders (edit)'
        ],
        'orders_stats' => [
            'name' => 'Order Stats'
        ],
        'orders_first_invoice' => [
            'name' => 'First Invoice'
        ],
        'orders_all_invoices' => [
            'name' => 'All Invoices'
        ],
        'labels'     => [
            'name' => 'Orders labels'
        ],
        'orders_debt' => [
            'name' => 'Debt'
        ],
        'currency'   => [
            'name' => 'Currencies'
        ],
        'delivery'   => [
            'name' => 'Shipping'
        ],
        'payment'    => [
            'name' => 'Payment'
        ],
        'users'      => [
            'name' => 'Guests'
        ],
        'users_safety' => [
            'name' => 'Guests (Safety)'
        ],
        'users_delete_files' => [
            'name' => 'Guests (Files Delete)'
        ],
        'ledger' => [
            'name' => 'Resident Ledger'
        ],
        'move_inout' => [
            'name' => 'Move In/Out'
        ],
        'inventories'=> [
            'name' => 'Restocking'
        ],
        'contracts'  => [
            'name' => 'Contracts'
        ],
        'contracts_edit'  => [
            'name' => 'Contracts (edit)'
        ],
        'contracts_approve'  => [
            'name' => 'Contracts approve'
        ],
        'leases' => [
            'name' => 'Master Leases Lists'
        ],
        'leases_edit' => [
            'name' => 'Master Lease | Edit'
        ],
        'cleaning'   => [
            'name' => 'Cleaning'
        ],
        'prebookings' => [
            'name' => 'Prebookings'
        ],
        'beds_journal' => [
            'name' => 'Bookings'
        ],
        'beds_journal_edit' => [
            'name' => 'Bookings | Edit'
        ],
        'bookings_change_bed' => [
            'name' => 'Bookings | Change bed'
        ],
        'bookings_cancel' => [
            'name' => 'Bookings | Cancel'
        ],
        'bookings_add_past' => [
            'name' => 'Bookings | Book Past date'
        ],
        'beds' => [
            'name' => 'Beds'
        ],
        'bookings_closed' => [
            'name' => 'Bookings Closed'
        ],
        'bookings_reserv' => [
            'name' => 'Bookings Reserv'
        ],
        'bookings_airbnb_reserv' => [
            'name' => 'Bookings Airbnb Reserv'
        ],
        'dont_extend' => [
            'name' => 'Don`t extend'
        ],
        'notifications' => [
            'name' => 'Notifications'
        ],
        'rentroll' => [
            'name' => 'Rent Roll'
        ],
        'rentroll_save' => [
            'name' => 'Rent Roll | Archive'
        ],
        'tenants' => [
            'name' => 'Tenants'
        ],
        'stats_occupancy' => [
            'name' => 'Stats | Occupancy'
        ],
        'stats_house' => [
            'name' => 'Stats | House KPIs'
        ],
        'stats_sales' => [
            'name' => 'Stats | Sales (Permission)'
        ],
        'stats_sales_menu' => [
            'name' => 'Stats | Sales (Menu)'
        ],
        'stats_sales_team' => [
            'name' => 'Stats | Team Results'
        ],
        'companies' => [
            'name' => 'Companies / Landlords'
        ],
        'costs' => [
            'name' => 'Costs'
        ]
    ];

    public $permissions_list;

	public $permissions_list_ = array(
		'galleries', 
		'pages',

        'houses',

        'blog',
		'comments', 
		'feedbacks', 
		'issues', 
		'design', 
		'settings', 
		'managers', 
		'users', 
		'users_safety',
		'users_delete_files',
        'move_inout',
		'groups', 
		'tokeet', 
		'products', 
		'categories', 
		'brands', 
		'features', 
		'orders',
		'orders_edit',
		'labels', 
		'coupons', 
		'currency', 
		'delivery', 
		'payment',
		'inventories', 
		'contracts',
        'contracts_edit',
		'contracts_approve',
		'leases',
		'dont_extend',
		'cleaning', 
		'beds', 
		'beds_journal', 
		'beds_journal_edit',
        'bookings_change_bed',
        'bookings_cancel',
		'bookings_closed',
		'bookings_reserv',
        'bookings_add_past',
        'bookings_airbnb_reserv',
		'notifications',
		'costs',
		'companies',
		'rentroll',
		'rentroll_save',
		'tenants',
        'stats_occupancy',
        'stats_house',
        'stats_sales',
        'stats_sales_manager',
		'stats_sales_team',
		'stats',
		'backup',
		'prebookings'
	);

	public $manager_types = [
		1 => 'Admin', 
		2 => 'Developer',
		3 => 'Customer service',
		4 => 'Sales',
		5 => 'Finance'
	];




		
	public $passwd_file = "backend/.passwd";

	public function __construct()
	{
        foreach($this->permissions as $k=>$p) {
            $this->permissions[$k] = (object) $p;
        }
        $this->permissions_list = array_keys($this->permissions);

		$menus = $this->pages->get_menus();
		if(!empty($menus)){
			foreach($menus as $m)
				$this->permissions_list[] = 'menu_'.$m->id;
		}


		// Для совсестимости с режимом CGI
		if (isset($_SERVER['REDIRECT_REMOTE_USER']) && empty($_SERVER['PHP_AUTH_USER']))
		{
		    $_SERVER['PHP_AUTH_USER'] = $_SERVER['REDIRECT_REMOTE_USER'];
		}	
		elseif(empty($_SERVER['PHP_AUTH_USER']) && !empty($_SERVER["REMOTE_USER"]))
		{
		    $_SERVER['PHP_AUTH_USER'] = $_SERVER["REMOTE_USER"];
		}
	}

	public function get_managers($filter = array())
	{
		$lines = explode("\n", @file_get_contents(dirname(dirname(__FILE__)).'/'.$this->passwd_file));
		$managers = array();
		foreach($lines as $line)
		{
			if(!empty($line))
			{
				$manager = null;
				$fields = explode(":", $line);
				$manager = new stdClass();
				$manager->login = trim($fields[0]);
				$manager->permissions = array();
				if(isset($fields[2]))
				{
					$manager->permissions = explode(",", $fields[2]);
					foreach($manager->permissions as &$permission)
						$permission = trim($permission);
				}
				else {
                    $manager->permissions = $this->permissions_list;
                    $manager->permissions_all = true;
                }


				$managers[$manager->login] = $manager;
			}
		}

		$type_filter = '';
		

		if(isset($filter['type']))
			$type_filter = $this->db->placehold('AND m.type in (?@)', (array)$filter['type']);

		$query = $this->db->placehold("SELECT 
						m.id,
						m.login,
						m.type,
						m.email
					FROM __managers AS m
					WHERE 1
						$type_filter
					ORDER BY m.id DESC");
		$this->db->query($query);	
		// if(isset($filter['type']))
		// {
		// 	print_r($query); exit;
		// }
		$bd_managers = $this->db->results();

		if(!empty($bd_managers))
		{
			foreach($bd_managers as $bm)
			{
			    if (isset($managers[$bm->login])) {
                    $managers[$bm->login]->type = $bm->type;
					if (!empty($bm->type) && isset($this->manager_types[$bm->type])) {
						$managers[$bm->login]->type_name = $this->manager_types[$bm->type];
					}
                    $managers[$bm->login]->email = $bm->email;
                    $result_managers[$bm->login] = $managers[$bm->login];
                }
			}
			return $result_managers;
		}
		// else
		// {
		// 	return $managers;
		// }

	}
		
	public function count_managers($filter = array())
	{
		return count($this->get_managers());
	}
		
	public function get_manager($login = null)
	{
		// Если не запрашивается по логину, отдаём текущего менеджера или false
		if(empty($login))
			if(!empty($_SERVER['PHP_AUTH_USER']))
				$login = $_SERVER['PHP_AUTH_USER'];
			else
			{
				// Тестовый менеджер, если отключена авторизация
				$m = new stdClass();
				$m->login = 'manager';
				$m->permissions = $this->permissions_list;
				return $m;
			}
				
		foreach($this->get_managers() as $manager)
		{
			if($manager->login == $login)
			{
				$query = $this->db->placehold("SELECT id, login, type, email
					FROM __managers
					WHERE 
					login = ?
					LIMIT 1        
					", $login);
	
				$this->db->query($query);
				$bd_manager = $this->db->result();
				$manager->type = $bd_manager->type;
				$manager->email = $bd_manager->email;
				return $manager;
			}
		}		
		return false;	
	}
	
	public function add_manager($manager)
	{
		$manager = (object)$manager;
		if(!empty($manager->login))
			$m[0] = $manager->login;
		if(!empty($manager->password))
		{
			// захешировать пароль
			$m[1] = $this->crypt_apr1_md5($manager->password);
		}
		else
		{
			$m[1] = "";
		}
		if(is_array($manager->permissions))
		{
			if(count(array_diff($this->permissions_list, $manager->permissions))>0)
			{
				$m[2] = implode(",", $manager->permissions);
			}
			else
			{
				unset($m[2]);
			}
		}
 		$line = implode(":", $m);
		file_put_contents($this->passwd_file, @file_get_contents($this->passwd_file)."\n".$line);
		
		$query = $this->db->placehold("INSERT IGNORE INTO __managers SET login=?, type=?, email=?", $manager->login, $manager->type, $manager->email);
		$this->db->query($query);

		if($m = $this->get_manager($manager->login))
		{
			return $m->login;
		}
		else
			return false;
	}
		
	public function update_manager($login, $manager)
	{
		$manager = (object)$manager;
		// Не допускаем двоеточия в логине
		if(!empty($manager->login))
			$manager->login = str_replace(":", "", $manager->login);
		
		$lines = explode("\n", @file_get_contents($this->passwd_file));
		$updated_flag = false;
		foreach($lines as &$line)
		{
			$m = explode(":", $line);
			if($m[0] == $login)
			{
				if(!empty($manager->login))
					$m[0] = $manager->login;
				if(!empty($manager->password))
				{
					// захешировать пароль
					$m[1] = $this->crypt_apr1_md5($manager->password);
				}
				if(isset($manager->permissions) && is_array($manager->permissions))
				{
					if(count(array_diff($this->permissions_list, $manager->permissions))>0)
					{
						$m[2] = implode(",", array_intersect($this->permissions_list, $manager->permissions));
					}
					else
					{
						unset($m[2]);
					}
				}
				$line = implode(":", $m);
				$updated_flag = true;
			}
		}
		if($updated_flag)
		{
			unset($manager->old_login);
			unset($manager->permissions);
			$query = $this->db->placehold("UPDATE __managers SET ?% WHERE login = ? LIMIT 1", $manager, $login);
			$this->db->query($query);

			file_put_contents($this->passwd_file, implode("\n", $lines));
			if($m = $this->get_manager($manager->login))
				return $m->login;
		}
		return false;
	}
	
	public function delete_manager($login)
	{
		$lines = explode("\n", @file_get_contents($this->passwd_file));
		foreach($lines as $i=>$line)
		{
			$m = explode(":", $line);
			if($m[0] == $login)
				unset($lines[$i]);
		}
		file_put_contents($this->passwd_file, implode("\n", $lines));

		$query = $this->db->placehold("DELETE FROM __managers WHERE login=? LIMIT 1", $login);
		$this->db->query($query);

		return true;
	}
	
	private function crypt_apr1_md5($plainpasswd) {
		$salt = substr(str_shuffle("abcdefghijklmnopqrstuvwxyz0123456789"), 0, 8);
		$len = strlen($plainpasswd);
		$text = $plainpasswd.'$apr1$'.$salt;
		$bin = pack("H32", md5($plainpasswd.$salt.$plainpasswd));
		for($i = $len; $i > 0; $i -= 16) { $text .= substr($bin, 0, min(16, $i)); }
		for($i = $len; $i > 0; $i >>= 1) { $text .= ($i & 1) ? chr(0) : $plainpasswd[0]; }
		$bin = pack("H32", md5($text));
		for($i = 0; $i < 1000; $i++) {
			$new = ($i & 1) ? $plainpasswd : $bin;
			if ($i % 3) $new .= $salt;
			if ($i % 7) $new .= $plainpasswd;
			$new .= ($i & 1) ? $bin : $plainpasswd;
			$bin = pack("H32", md5($new));
		}
		$tmp = '';
		for ($i = 0; $i < 5; $i++) {
			$k = $i + 6;
			$j = $i + 12;
			if ($j == 16) $j = 5;
			$tmp = $bin[$i].$bin[$k].$bin[$j].$tmp;
		}
		$tmp = chr(0).chr(0).$bin[11].$tmp;
		$tmp = strtr(strrev(substr(base64_encode($tmp), 2)),
		"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/",
		"./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz");
		return "$"."apr1"."$".$salt."$".$tmp;
	}

	public function access($module)
	{
		$manager = $this->get_manager();
		if(is_array($manager->permissions))
			return in_array($module, $manager->permissions);
		else
			return false;
	}
}