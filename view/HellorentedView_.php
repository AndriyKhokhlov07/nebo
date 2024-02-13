<?PHP


require_once('View.php');


class HellorentedView extends View
{
	function fetch()
	{
		$url = $this->request->get('url');

		// to hellorented site
		if(!empty($url) && $this->request->get('action') == 'link')
		{
			// get notification item
			$notification = $this->notifications->get_notification($url);

			if(!empty($notification))
			{
				// type 1 - hellorented notification type
				if($notification->type == 1 && !empty($notification->user_id))
				{
					$user = $this->users->get_user((int)$notification->user_id);


					if(!empty($user))
					{
						if(
							   !empty($user->first_name)
							&& !empty($user->last_name)
							&& !empty($user->phone)
							&& !empty($user->email)
							&& !empty($user->inquiry_arrive)
							&& !empty($user->inquiry_depart)
							&& !empty($user->price_month)
							&& !empty($user->price_deposit)
							&& !empty($user->house_id)
						)
						{
							$house = $this->pages->get_page((int)$user->house_id);

							if(!empty($house->blocks2))
							{
								$house->blocks2 = unserialize($house->blocks2);
								if(!empty($house->blocks2['hellorented_link']))
								{
									$hellorented_url = trim($house->blocks2['hellorented_link']).'?';
									$hellorented_url .= 'fname='.urlencode($user->first_name);
									$hellorented_url .= '&lname='.urlencode($user->last_name);
									$hellorented_url .= '&email='.urlencode($user->email);
									$hellorented_url .= '&phone='.urlencode($user->phone);

									$d1 = date_create($user->inquiry_arrive);
									$d2 = date_create($user->inquiry_depart);
									$interval = date_diff($d1, $d2);
									$lterm = $interval->m;
									if($interval->y > 0)
										$lterm += $interval->y * 12;
									$hellorented_url .= '&lterm='.$lterm;

									$hellorented_url .= '&rent='.$user->price_month*1;
									$hellorented_url .= '&sd_amount='.$user->price_deposit*1;
									$hellorented_url .= '&move_in_date='.urlencode(date_create($user->inquiry_arrive)->format('Y-m-d'));

									// update notification linked datetime
									$notification = $this->notifications->update_notification($notification->id, array('date_viewed'=>'now'));

									header('Location: '.$hellorented_url);
									exit;
								}
							}

						}
					}
				}
			}
		}
		return false;		
	}
}