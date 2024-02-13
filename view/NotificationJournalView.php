<?PHP

require_once('View.php');


class NotificationJournalView extends View
{
	function fetch()
	{
		// Houses
		$houses = $this->pages->get_pages(array('menu_id'=>5, 'not_parent_id'=>0, 'visible'=>1));

		$notifications_by_house = array();
		$house_ids = array();
		foreach ($houses as $h) {
			$house_ids[] = $h->id;
		}

		$today = date('Y-m-d');

		$date = time();
		$day = 60 * 60 * 24;

		$notifications = array();

		

		$notify = array();

		$date_month_ago = date_create(date("Y-m-d"));
		date_sub($date_month_ago, date_interval_create_from_date_string('1 month'));
		$date_now = date_create(date("Y-m-d"));
		$date_week_plus = date_create(date("Y-m-d"));
		date_add($date_week_plus, date_interval_create_from_date_string('2 week'));
		if($this->user->type == 2)
		{
			$hl_houses = $this->users->get_houseleaders_houses(array('user_id'=>$this->user->id));
			foreach ($hl_houses as $hl_h) 
			{
				$hl_h_ids[] = $hl_h->house_id;
			}
			$hl_apts = $this->beds->get_apartments(array(
				'house_id' => $hl_h_ids
			));
			foreach ($hl_apts as $a) 
			{
				$apts_ids[] = $a->id;
			}
			$notifications_h = $this->notifications->get_notifications(array('type'=>array('9', '10'), 'subtype'=>2, 'object_id'=>$hl_h_ids));
			$notifications_a = $this->notifications->get_notifications(array('type'=>array('9', '10'), 'subtype'=>1, 'object_id'=>$apts_ids));

			$notifications_ = array_merge($notifications_h, $notifications_a);
		}
		else
			$notifications_ = $this->notifications->get_notifications(array('type'=>array('9', '10')));

		foreach ($notifications_ as $n) 
		{
			if($n->subtype == 2 || ($n->type == 10 && $n->subtype == 0))
			{
				if($n->date >= date_format($date_month_ago, 'Y-m-d') && $n->date < date_format($date_now, 'Y-m-d'))
				{
					$n->active = 0;
					$alerts[] = $n;
				}
				elseif($n->date >= date_format($date_now, 'Y-m-d') && $n->date <= date_format($date_week_plus, 'Y-m-d'))
				{
					$n->active = 1;
					$alerts[] = $n;
				}
				$houses_ids[] = $n->object_id;
			}
			elseif($n->subtype == 1 || ($n->type == 9 && $n->subtype == 0))
			{
				if($n->date >= date_format($date_month_ago, 'Y-m-d') && $n->date < date_format($date_now, 'Y-m-d'))
				{
					$n->active = 0;
					$visits[] = $n;
				}
				elseif($n->date >= date_format($date_now, 'Y-m-d') && $n->date <= date_format($date_week_plus, 'Y-m-d'))
				{
					$n->active = 1;
					$visits[] = $n;
				}
				$apts_ids[] =  $n->object_id;
			}
		}
		$houses_ = $this->pages->get_pages(array('id'=>$houses_ids));
		foreach ($houses_ as $h) 
		{
			$houses[$h->id] = $h;
		}
		$this->design->assign('houses', $houses);

		$apts_ = $this->beds->get_apartments(array('id'=>$apts_ids));
		foreach ($apts_ as $h) 
		{
			$apts[$h->id] = $h;
		}
		$this->design->assign('apts', $apts);

		
		foreach ($alerts as $a) 
		{
			$a->notify_type = 'alert';
			$all_notifications[$a->date][] = $a;
		}
		foreach ($visits as $v) 
		{
			$v->notify_type = 'visit';
			$all_notifications[$v->date][] = $v;
		}

		krsort($all_notifications);
		$this->design->assign('all_notifications', $all_notifications);

		$this->design->assign('notifications_journal', 1);


		$tmp = 'notifications.tpl';

		return $this->design->fetch($tmp);
	}
}
