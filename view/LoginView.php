<?PHP

require_once('View.php');

class LoginView extends View
{
	function fetch()
	{
		// Выход
		if($this->request->get('action') == 'logout')
		{
			unset($_SESSION['user_id']);
			header('Location: '.$this->config->root_url);
			exit();
		}
		// Вспомнить пароль
		elseif($this->request->get('action') == 'password_remind')
		{
			// Если запостили email
			if($this->request->method('post') && $this->request->post('email'))
			{
				$email = $this->request->post('email');
				$this->design->assign('email', $email);
				
				// Выбираем пользователя из базы
				$user = $this->users->get_user($email);
				if(!empty($user))
				{
					// Генерируем секретный код и сохраняем в сессии
					//$code = md5(uniqid($this->config->salt, true));

					//$code = md5($this->config->salt.$user->email);
					// $_SESSION['password_remind_code'] = $code;
					// $_SESSION['password_remind_user_id'] = $user->id;

					if(empty($user->auth_code))
					{
						$user->auth_code = md5(uniqid($this->config->salt, true));
						$this->users->update_user($user->id, array('auth_code'=>$user->auth_code));
					}
					$code = $user->auth_code;


					

					
					
					// Отправляем письмо пользователю для восстановления пароля
					$this->notify->email_password_remind($user->id, $code);
					$this->design->assign('email_sent', true);
				}
				else
				{
					$this->design->assign('error', 'user_not_found');
				}
			}
			// Если к нам перешли по ссылке для восстановления пароля
			elseif($this->request->get('code'))
			{
				// Проверяем существование сессии
				// if(!isset($_SESSION['password_remind_code']) || !isset($_SESSION['password_remind_user_id']))
				// 	return false;
				
				// Проверяем совпадение кода в сессии и в ссылке
				// if($this->request->get('code') != $_SESSION['password_remind_code'])
				// 	return false;
				
				// Выбераем пользователя из базы
				// $user = $this->users->get_user(intval($_SESSION['password_remind_user_id']));
				// if(empty($user))
				// 	return false;
				$code = trim($this->request->get('code'));

				$email = urldecode($this->request->get('e'));

				if(empty($email))
					return false;

				$query = $this->db->placehold('SELECT * FROM __users WHERE auth_code=? LIMIT 1', $code);
				$this->db->query($query);
				$user = $this->db->result();
				if(empty($user))
					return false;

				
				if($email != $user->email)
					return false;


				// $this->users->update_user($user->id, array('remind_code'=>''));

				// Залогиниваемся под пользователем и переходим в кабинет для изменения пароля
				$_SESSION['user_id'] = $user->id;
				header('Location: '.$this->config->root_url.'/user/profile');
			}
			return $this->design->fetch('password_remind.tpl');
		}
		// Вход
		elseif($this->request->method('post') && $this->request->post('login'))
		{
			$email			= $this->request->post('email');
			$password		= $this->request->post('password');
			
			$this->design->assign('email', $email);
		
			if($user_id = $this->users->check_password($email, $password))
			{
				$user = $this->users->get_user($email);
				if($user->enabled)
				{
					$_SESSION['user_id'] = $user_id;
					$this->users->update_user($user_id, array('last_ip'=>$_SERVER['REMOTE_ADDR']));
					
					// Перенаправляем пользователя на прошлую страницу, если она известна
					// if(!empty($_SESSION['last_visited_page']))
					// 	header('Location: '.$_SESSION['last_visited_page']);				
					// else
					// 	header('Location: '.$this->config->root_url.'/current-members');

					if(!empty($_GET['return']))
					{
						header('Location: '.$this->config->root_url.'/'.$_GET['return']);
						exit;
					}
					elseif($user->type == 3) // Cleaner
					{
						header('Location: '.$this->config->root_url.'/cleaner_cleaning');
						exit;
					}
					elseif($user->type == 4) // Landlord
					{
						if (!empty($user->permissions['tenants'])) {
                            // $ll_url = 'tenants';
                            $ll_url = 'stats';
                        }
						elseif(!empty($user->permissions['rentroll']))
							$ll_url = 'rentroll';
						elseif(!empty($user->permissions['bookings']))
							$ll_url = 'bookings';
						elseif(!empty($user->permissions['approve']))
							$ll_url = 'approve';

						header('Location: '.$this->config->root_url.'/landlord/'.$ll_url.'/');
						exit;
					}
					elseif($user->type == 5) // Handyman
					{
						header('Location: '.$this->config->root_url.'/notifications-journal/');
						exit;
					}
					else
					{
						header('Location: '.$this->config->root_url.'/current-members');
						exit;
					}
								
				}
				else
				{
					$this->design->assign('error', 'user_disabled');
				}
			}
			else
			{
				$this->design->assign('error', 'login_incorrect');
			}				
		}	
		return $this->design->fetch('login.tpl');
	}	
}
