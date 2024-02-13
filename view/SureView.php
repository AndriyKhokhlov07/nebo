<?PHP

require_once('View.php');

class SureView extends View
{

	private	$allowed_image_extentions = array('png', 'gif', 'jpg', 'jpeg', 'ico');

	public $user;

	function fetch()
	{
		$user = new stdclass;

		$url = $this->request->get('url', 'string');
		if(!empty($url))
		{
			$sure = $this->sure->get_sure($url);
			if(!empty($sure))
			{
				$this->sure->update_sure($sure->id, array('date_viewed'=>'now'));
				$user = $this->users->get_user((int)$sure->user_id);

				if(!empty($user))
				{
					if($this->request->method('post'))
					{
						$u = new stdclass;
						$u->first_name = trim($this->request->post('first_name'));
						$u->last_name = trim($this->request->post('last_name'));

						$birth_month = $this->request->post('birth_month', 'integer');
						$birth_day = $this->request->post('birth_day', 'integer');
						$birth_year = $this->request->post('birth_year', 'integer');
						if(!empty($birth_month) && !empty($birth_day) && !empty($birth_year))
							$u->birthday = $birth_year.'-'.$birth_month.'-'.$birth_day;

						$u->phone = $this->request->post('phone');
						$u->token = $this->request->post('token');

						$this->users->update_user($user->id, $u);


						header('Location: '.$this->config->root_url.'/user/sure?success=sended');
						exit;
					}
				}
			}

		}
		elseif($this->request->get('u', 'integer'))
		{

			$sure_id = $this->sure->add_sure(array('user_id'=>$this->request->get('u', 'integer')));
			$sure = $this->sure->get_sure($sure_id);
			if($sure)
			{
				header('Location: '.$this->config->root_url.'/user/sure/'.$sure->url);
				exit;
			}
		}
		

		$this->design->assign('user', $user);


		return $this->design->fetch('sure.tpl');
	}
}