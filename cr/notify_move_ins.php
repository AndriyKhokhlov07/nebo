<?php
ini_set('error_reporting', E_ALL);


session_start();

chdir('..');
require_once('api/Backend.php');



class Test extends Backend
{
	function fetch()
	{
		// взять все нотификейшены тип 5 и 6, если у юзера есть мувины, то привязать их и сделать статус 1, если нет, то добавить и сделать статус 0 

		// мы оставим все нотификейшены чтобы они работали в статистиках и будем добавлять мувины чтобы брать инфу по букингу для которого этот мувин и постатусу выполнения + заполненые поля и фото

		// Сделать ссылки на форму мувина.аута с привязкой к конкретному мувину



		$query = $this->db->placehold("SELECT 
										n.id,
										n.type,
										n.url,
										n.user_id,
										n.object_id,
										n.date_created,
										n.date,
										n.auto_move
									FROM __notifications AS n
									WHERE n.type in (?@) AND n.auto_move = 0
									ORDER BY n.id 
									LIMIT 100
									", array(5,6));

		$this->db->query($query);
		$notifications_ = $this->db->results();


		if(!empty($notifications_))
		{
			foreach ($notifications_ as $n) 
			{
				$this->notifications->update_notification($n->id, array('auto_move'=>1));
				$notifications[$n->id] = $n;
				$users_ids[] = $n->object_id;
			}

			$user_id_filter = $this->db->placehold('AND u.id in(?@)', (array)$users_ids);

			$query = $this->db->placehold("SELECT 
							u.id, 
							u.name,
							u.active_booking_id
						FROM __users AS u
						WHERE 1
						$user_id_filter
						ORDER BY u.id
						");
			$this->db->query($query);	

			$users_ = $this->db->results();
			if(!empty($users_))
			{
				foreach ($users_ as $u) 
				{
					$users[$u->id] = $u;			
				}
			}

			$moves = $this->houseleader->get_moveins(array('user_id'=>$users_ids));
			if(!empty($moves))
			{
				foreach ($moves as $m) 
				{
					if($m->type == 1 || $m->type == 2)
						$moves_ins[$m->user_id] = $m;
					elseif($m->type == 3)
						$moves_outs[$m->user_id] = $m;
				}
			}


			foreach ($notifications as $n) 
			{
				// move in
				if($n->type == 5 && !empty($users[$n->object_id]))
				{
					if(!empty($moves_ins[$n->object_id]))
					{
						$move = $moves_ins[$n->object_id];
						$move->status = 1;
						$move->notify_id = $n->id;
						$move->booking_id = $users[$n->object_id]->active_booking_id;
						$this->houseleader->update_movein($move->id, $move);
						echo 'updated: n_id:'.$n->id.', move_in_id:'.$move->id.', user:'.$users[$n->object_id]->active_booking_id.'<br>';
					}
					else
					{
						$move = new stdClass;

						$move->user_id = $n->object_id;
						$move->type  = 1;
						$move->status = 0;
						$move->notify_id = $n->id;
						$move->booking_id = $users[$n->object_id]->active_booking_id;

						$move->id = $this->houseleader->add_movein($move);

						echo 'added: n_id:'.$n->id.', move_in_id:'.$move->id.', user:'.$users[$n->object_id]->active_booking_id.'<br>';
					}
				}
				elseif($n->type == 6 && !empty($users[$n->object_id]))
				{
					if(!empty($moves_outs[$n->object_id]))
					{
						$move = $moves_outs[$n->object_id];
						$move->status = 1;
						$move->notify_id = $n->id;
						$move->booking_id = $users[$n->object_id]->active_booking_id;
						$this->houseleader->update_movein($move->id, $move);
						echo 'updated: n_id:'.$n->id.', move_out_id:'.$move->id.', user:'.$users[$n->object_id]->active_booking_id.'<br>';
					}
					else
					{
						$move = new stdClass;

						$move->user_id = $n->object_id;
						$move->type  = 3;
						$move->status = 0;
						$move->notify_id = $n->id;
						$move->booking_id = $users[$n->object_id]->active_booking_id;

						$move->id = $this->houseleader->add_movein($move);

						echo 'added: n_id:'.$n->id.', move_out_id:'.$move->id.', user:'.$users[$n->object_id]->active_booking_id.'<br>';
					}
				}
			}


			
		}
		else{
			echo 'no notify more';
		}



	}
}


$test = new Test();
$test->fetch();
