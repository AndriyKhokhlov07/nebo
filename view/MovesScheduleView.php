<?PHP

require_once('view/View.php');

class MovesScheduleView extends View
{
	private $params;


	function fetch()
	{
		// if(empty($this->user))
		// {
		// 	header("HTTP/1.1 301 Moved Permanently"); 
		// 	header('Location: '.$this->config->root_url.'/user/login');
		// 	exit();
		// }

		$house_id = $this->request->get('house_id', 'integer');

		if(!empty($house_id))
		{
			$moves_params = [
				'house_id' => $house_id,
				'date_from' => date('Y-m-d'),
				'date_to' => date('Y-m-d', strtotime(date('Y-m-d')) + strtotime('2 days'))
			];

			$moves_days = [
				date('Y-m-d'),
				date('Y-m-d', strtotime(date('Y-m-d')) + 24*60*60),
				date('Y-m-d', strtotime(date('Y-m-d')) + 2*24*60*60)
			];

			$moves = $this->houseleader->get_moveins($moves_params);

			$apartments = $this->beds->get_apartments(['house_id' => $house_id]);

			// Apartments
			$apartments = $this->beds->get_apartments([
				'house_id' => $house_id,
				'visible' => 1,
				'sort' => 'name'
			]);
			$apartments = $this->request->array_to_key($apartments, 'id');

			// Rooms
			$rooms_ = $this->beds->get_rooms([
				'house_id' => $house_id,
				'visible' => 1
			]);

			$rooms_apartments_ids = [];
			if(!empty($rooms_))
			{
				foreach($rooms_ as $r)
				{
					if(substr(trim($r->name), 0, 5) == 'Room ')
						$r->name = substr(trim($r->name), 5);

					if(!empty($r->apartment_id) && isset($apartments[$r->apartment_id]))
					{
						$apartments[$r->apartment_id]->rooms[$r->id] = $r;

						$rooms[$r->id] = $r;
						$rooms_apartments_ids[$r->id] = $r->apartment_id;
						if($r->visible == 1)
							$apartments[$r->apartment_id]->rooms_visible = 1;
					}

					
				}
			}

			// Beds
			$beds = $this->beds->get_beds([
				'room_id' => array_keys($rooms),
				'visible' => 1
			]);
			$beds = $this->request->array_to_key($beds, 'id');

			if(!empty($moves))
			{
				foreach($moves as $move)
				{
					if($move->booking_type == 1)
					{
						if($move->type == 1)
							$beds[$move->object_id]->moves_in[$move->arrive] = $move;
						elseif($move->type == 3)
							$beds[$move->object_id]->moves_out[$move->depart] = $move;
					}
					elseif($move->booking_type == 2)
					{
						if($move->type == 1)
							$apartments[$move->object_id]->moves_in[$move->arrive] = $move;
						elseif($move->type == 3)
							$apartments[$move->object_id]->moves_out[$move->depart] = $move;
					}
				}
			}

			if(!empty($beds))
			{
				foreach($beds as $b)
				{
					$beds_rooms_ids[$b->id] = $b->room_id;

					$apartment_id = $rooms[$b->room_id]->apartment_id;

					if(!empty($apartments[$apartment_id]->moves_in))
						$b->moves_in = $apartments[$apartment_id]->moves_in;

					if(!empty($apartments[$apartment_id]->moves_out))
						$b->moves_out = $apartments[$apartment_id]->moves_out;

					$apartments[$apartment_id]->rooms[$b->room_id]->beds[$b->id] = $b;

					if($b->visible == 1)
						$apartments[$apartment_id]->beds_visible = 1;
				}
			}

			// ROOMS TYPES
			$rooms_types_ = $this->beds->get_rooms_types(['visible'=>1]);
			$rooms_types = [];
			if(!empty($rooms_types_))
			{
				foreach($rooms_types_ as $rt)
					$rooms_types[$rt->id] = $rt;
				unset($rooms_types_);
			}

			$this->design->assign('rooms_types', $rooms_types);

			


		}

		$meta_title = 'Dashboard';
		$this->design->assign('meta_title', $meta_title);

		$this->design->assign('moves_days', $moves_days);

		$this->design->assign('apartments', $apartments);
		$this->design->assign('moves', $moves);

		return $this->design->fetch('moves_list.tpl');
	}
}
