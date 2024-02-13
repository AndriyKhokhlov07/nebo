<?php
// <!-- // salesflows table
// id
// booking_id
// user_id
// active 0|1
// application_data + documents
// aplication_type
// additional files ?
// transunion ?
// ekata status ?
// RA fee status ? 
// deposit - status / type ?
// approve by alex 
// contract status
// covid form status
// first month payment status ?
// + может тип самого сейлфлоу (аирбнб или обычный, короткий, длинный)



// создать апи файл для сейлсфлоус или написать функции тут ++
// 1. обновлять статус активности при создании и кенселении букинга +
// 2. Создавать сейлфлоу при создании букинга +

// 3. понимать к какому шагу относится нужная инфа (по идее к текущему активному) + 
// 4. нужно в юзер чек вью и остальных файлах в которых есть сейлфлоу шаг выхватывать инфу с конкретного сейлфлоу +
// подумать делать это по юзер актив букинг или юзер актив сейлфлоу или как еще 

// во всех этапах относящихся к сейлфоу делать апдейт этого сейлфлоу 
// фулл апартмент - обновлять некоторые поля юзеров по букинг ид (инвойс, депозит, контракт)

// 5. разобраться с загрузкой файлов для разных селйфлоу в разные папки

// 6. понять как записывать статусы екаты и трансюниона, при их апдейте в калбеке, обновлять их в сейфлоу по актив_сейлфлоу_ид?
// так же с рентал апп и адишинал файлс
// в логах екаты парент ид это ид сейфлоу
// трансюнион и хелоурентед приходит со временем и данные там можно к одному юзеру запрашивать один раз!

// 7. пропускать какие-то шаги
// выхватывать данные предыдущих сейлсфлоу

// 8. отображать сейлсфлоу в привязке к букингу в кабинете юзера

// 9. создать текущим людям сейлфлоу по их активным букингам

// может привязывать мувин/аут к сейфлоу тоже?
// что делать при экстеншинах?


// Сделать в гет юзер фильтр гет_сейлфлоу_инфо и подменять по нему данные юзера !!!!! --> в нужных местах прописать фильтр по выбору этой инфы и проверить, понять в каких местах он нужен



// сменить функцию на get user с фильтром salesflow_info в тю и еще посмотреть в каких файлах  ++
// $user = current($this->users->get_users(['id'=>(int)$params['user_id'], 'salesflow_info'=>1])); ++
// запись данных нужно сделать в сейлфлоу а не в юзера (легко) +
// ТЮ посмотреть множественные отправки и запись в сейлфлоу тогда +
// попробовать загрузить файл документов и посмотреть затрет ли он предыдущий +
// еката обновлять данные в поле селйфлоу при калькулировании рейтинга в функции екаты (но делаю как раньше - записываю все 4 статуса екаты массивом)+ 
// сделать лонгтерм букинг и пройтись по нему + собрать аутпост депозит.  +
// там где сейчас выводятся данные тю  и екаты, нужно  просто подставить данные последнего сейлфлоу +
// решить проблему с мувинами через сейлфлоус (дополнительное поле или даже 2) + выхватывать на страницу мувинов через букинги или сейлфловы, а не по текущим данным ++

// для экстеншинов предлагать создавать сейлфлоу или нет ++
// по умолчанию для экстеншинов не создавать сейлфлоу а брать по актив сейлфлоу ид ++

// Екстеншн не выводим в мув ин (сразу мувед ин)

// сделать вывод данных в странице юзера и прописать им немного стилей! 
// пройти сейлфлоу

// может возможность привязывать селйфлоу к определенному букингу? 
// может возможность переноса старых данных чекбоксами?

// airbnb добавление в контракт для сейлфлоу? брать по активному сейлфлоу или парент букинг ид




// Подумать как для всех букингов создать сейлфлоу правильно и добавить данные которые пользователи уже ввели (особенно те люди, которые сейчас проходят его)


require_once('Backend.php');

class Salesflows extends Backend
{


	public $approve_houses_ids = [
		298, // The Newkirk House
		// 315  // The Bedford House
		306, // The Fort Greene House
		334, // The Williamsburg House
		337,  // The Williamsburg House (165 N 5th Street)
		// 307,  // The Lafayette House
		155, // Bushwick
		103, // East Bushwick
		157, // Ridgewood
		314, // Fresh pond
		365, // The Alexander House
        464, // The Avenue at East Falls
	];

	public $airbnb_contracts_houses_ids = [
		349,  // The Mason on Chestnut (Philadelphia)
		334,  // The Williamsburg House
		337,  // The Williamsburg House (165 N 5th Street)
		311,  // The Greenpoint House (107)
		316,  // The Greenpoint House (111)
		317,  // The Greenpoint House (115)
	];

	

	
	public $cassa_house_id = [
		366, // Cassa Studios - 9th Ave Hotel
		364 // The Gramercy Park Studios
	];

	// public $id_greater = 2570;
	// public $id_greater = 2954;
	public $booking_created_from = '2021-03-25 00:00:00';



	public function __construct()
	{
		// airbnb_contracts_houses_ids => all houses
		$houses = $this->pages->getHouses();

		if (!empty($houses)) {
			$houses_ids = [];
			foreach ($houses as $h) {
				// Not Hotel
				if ($h->type != 1) {
					$houses_ids[] = $h->id;
				}
			}
			$this->airbnb_contracts_houses_ids = $houses_ids;
		}
	}




	// Salesflow types:
	// 0 - outpost
	// 1 - airbnb
	// 2 - guarantor
	// 3 - hotel
	// 4 - outpost short

    // application_data - если не пустая то, зеленый цвет степа

	// Application types:
	// 0 - new
	// 1 - use old info 
	// Может и не надо? при заполнении предлагать все прошлые данные и клиент их апрувнет

	// ra_fee_status:
	// 0,1,2,3,4 - по статусам инвойсов

	// additional_files - записывать файлы прям в этот инпут и тоже смотреть старые данные как-то ? (предлагать для апрува старые файлы)

	// transunion_status - если есть, то не пустой цвет степа / смотреть по старой инфе всегда?
	// ekata_status - может быть это поле и не нужно, а нужно только логам екаты писать парент ид, хотя нет, чтобы не тащить всю инфу екаты постоянно, лучше записывать ее сюда
	// ra_fee_status - обновлять при создании и оплате этот статус

	// deposit_status - то что записывается в табличку юзера в это поле писать сюда теперь
	// deposit types:
	// 0 - использовать предыдущий (не выбран никакой)
	// 1 - аутпост
	// 2 - хелоурентед


	// approve / landlord_approve (statuses):
	// 0 - not approve
	// 1 - approve
	// 2 - more info
	// 3 - canceled

	// contract_status:
	// 0 - новый / отсутсвует 
	// 1 - подписан всеми
	// 2 - подписан не всеми
	// 4 - Need a Guarantor // guarantor upd
	
	// covid_form_status:
	// 0 - не подписана
	// 1 - подписана

	// invoice_status:
	// 0,1,2,3,4 - по статусам инвойсов


	public function get_salesflows($filter = array())
	{
		$id_filter = '';
		$user_id_filter = '';
		$booking_id_filter = '';
		$approve_filter = '';
		$to_approve_filter = '';
		$not_empty_data_filter = '';
		$not_empty_add_files_filter = '';
		$booking_select = '';
		$house_id_filter = '';
		$user_select = '';
		$user_not_status_filter = '';
		$id_greater_filter = '';
		$group_by = '';
		$limit = 1000;

		if(isset($filter['limit']))
			$limit = max(1, intval($filter['limit']));

		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND s.id in(?@)', (array)$filter['id']);

		if(!empty($filter['user_id']))
			$user_id_filter = $this->db->placehold('AND s.user_id in(?@)', (array)$filter['user_id']);

		if(!empty($filter['booking_id']))
			$booking_id_filter = $this->db->placehold('AND s.booking_id in(?@)', (array)$filter['booking_id']);


		if(isset($filter['approve']))
			$approve_filter = $this->db->placehold('AND s.approve in(?@)', (array)$filter['approve']);

		if(!empty($filter['house_id']))
		{
			$booking_created_from_filter = '';
			if(!empty($filter['booking_created_from']))
			{
				$booking_created_from_filter = $this->db->placehold('AND b.created>?', $filter['booking_created_from']);
			}

			$house_id_filter = $this->db->placehold('INNER JOIN __bookings b ON b.id=s.booking_id AND b.status!=0 AND b.house_id in(?@)'.$booking_created_from_filter, (array)$filter['house_id']);

			$booking_select = ', b.house_id';
			$group_by = "GROUP BY s.id";
		}
		if(!empty($filter['user_not_status']))
		{
			$user_not_status_filter = $this->db->placehold('INNER JOIN __users u ON u.id=s.user_id AND u.status not in(?@)', (array)$filter['user_not_status']);
			$user_select = ', u.status as user_status, u.name as user_name';
			$group_by = "GROUP BY s.id";
		}


		if(!empty($filter['to_approve']))
		{
			$to_approve_filter = $this->db->placehold('AND s.approve=0 AND s.landlord_approve=0 AND ((s.deposit_type=1 AND s.deposit_status=2) OR (s.deposit_type=2 AND s.deposit_status=4))');
		}

		if(!empty($filter['id_greater']))
   			$id_greater_filter = $this->db->placehold('AND s.id>?', (int)$filter['id_greater']);


		if(!empty($filter['not_empty_data']))
			$not_empty_data_filter = $this->db->placehold("AND s.application_data <> ''");

		if(!empty($filter['not_empty_add_files']))
			$not_empty_add_files_filter = $this->db->placehold("AND s.additional_files <> ''");

		$sql_limit = $this->db->placehold(' LIMIT ?', $limit);


		$query = $this->db->placehold("SELECT
				s.id,  
				s.user_id,
				s.booking_id,
				s.type,
				s.application_data,
				s.application_type,
				s.additional_files,
				s.transunion_id,
				s.transunion_status,
				s.transunion_data,
				s.ekata_status,
				s.ra_fee_status,
				s.deposit_status,
				s.deposit_type,
				s.transfer_deposit,
				s.approve,
				s.landlord_approve,
				s.contract_status,
				s.covid_form_status,
				s.invoice_status,
				s.house_rules_status
				$booking_select
				$user_select
			FROM __salesflows s
				$house_id_filter
				$user_not_status_filter
			WHERE 
				1
				$id_filter
				$user_id_filter
				$booking_id_filter
				$approve_filter
				$to_approve_filter
				$id_greater_filter
				$not_empty_data_filter
				$not_empty_add_files_filter
			$group_by
			ORDER BY s.id DESC
			$sql_limit");
		$this->db->query($query);

		if($filter['query'] == 'print') {
			echo $query; exit;
		}
		

		if(isset($filter['limit']) && $filter['limit'] == 1)
			return $this->db->result();
		else
			return $this->db->results();
	}

	public function add_salesflow($val)
	{	
		$query = $this->db->placehold('INSERT INTO __salesflows SET ?%', $val);

		if(!$this->db->query($query))
			return false;

		$id = $this->db->insert_id();	
		return $id;
	}

	public function update_salesflow($id, $val)
	{
		$query = $this->db->placehold("UPDATE __salesflows SET ?% WHERE id in(?@) LIMIT ?", $val, (array)$id, count((array)$id));
		$this->db->query($query);
		return $id;
	}

	public function delete_salesflow($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __salesflows WHERE id=? LIMIT 1", intval($id));
			$this->db->query($query);
		}
	}

	public function landlord_approve_salesflow($params) {

		$salesflow = $this->salesflows->get_salesflows([
			'id' => intval($params['salesflow_id']), 
			'limit' => 1
		]);

		if(!empty($salesflow) && ($salesflow->approve != 1 &&  $salesflow->landlord_approve != 1)) {

			$this->salesflows->update_salesflow($salesflow->id, [
				'landlord_approve' => $params['approve_type'] 
			]);
		
			// Log
			$log_params = [
				'user_id' => $salesflow->user_id,
				'parent_id' => $salesflow->id, 
				'type' => 13, 
				'subtype' => $params['approve_type'],
				'sender_type' => $params['sender_type'],
				'sender' => $params['sender']
			];
			if(isset($params['log_value']))
				$log_params['value'] = $params['log_value'];
			$this->logs->add_log($log_params);



			$booking = $this->beds->get_bookings([
				'id' => $salesflow->booking_id, 
				'limit' => 1
			]);

			$user = $this->users->get_user((int)$salesflow->user_id);


			$mailto = 'alex.kos@outpost-club.com, customer.service@outpost-club.com';
			$mailfrom = $this->settings->notify_from_email;

			if(!empty($booking) && !empty($booking->manager_login))
			{
				$booking_manager = $this->managers->get_manager($booking->manager_login);
				if(!empty($booking_manager->email))
				{
					$mailto .= ', ' . $booking_manager->email;
				}
			}

			$this->design->assign('user', $user);
			$this->design->assign('sender', $params['sender']);
			$this->design->assign('approve_type', $params['approve_type']);

			$email_template = $this->design->fetch($this->config->root_dir.'backend/design/html/email/tenant_landlord_approve.tpl');
			$subject = $this->design->get_var('subject');
			$this->notify->email($mailto, $subject, $email_template, $mailfrom);

		}
	}

	public function approve_salesflow($params)
	{
		if(!empty($params['salesflow_id']))
		{
			$salesflow = $this->salesflows->get_salesflows(['id'=>intval($params['salesflow_id']), 'limit'=>1]);
			if(!empty($salesflow) && $salesflow->approve != 1)
			{
				$booking = $this->beds->get_bookings(['id'=>$salesflow->booking_id, 'limit'=>1]);
				if(!empty($booking) && !empty($params['add_to_contract']))
					$this->beds->update_booking($booking->id, array('add_to_contract'=>1));

				if(empty($params['approve_type']))
					$params['approve_type'] = 1; // Approve
				
				if(!empty($booking))
					$contract = current($this->contracts->get_contracts(['reserv_id'=>$booking->id, 'limit'=>1]));

				// type 1 - outpost
				if(!empty($contract) && $contract->sellflow != 1)
				{
					$this->contracts->start_second_salesflow($contract->id, $salesflow->user_id, $params);
				}
				else
				{
					$salesflows = $this->salesflows->get_salesflows(['booking_id'=>$booking->id]);
					foreach($salesflows as $s)
					{
						if($s->id != $salesflow->id)
						{
							$this->salesflows->update_salesflow($s->id, [
								'approve' => $params['approve_type'] 
							]);
						}
					}
				}

				$this->salesflows->update_salesflow($salesflow->id, [
					'approve' => $params['approve_type'] 
				]);
			
				// Log
				$log_params = [
					'user_id' => $salesflow->user_id,
	                'parent_id' => $salesflow->id, 
	                'type' => 13, 
	                'subtype' => $params['approve_type'],
	                'sender_type' => $params['sender_type'],
	                'sender' => $params['sender']
				];
				if(isset($params['log_value']))
					$log_params['value'] = $params['log_value'];
				$this->logs->add_log($log_params);

				$user = $this->users->get_user((int)$salesflow->user_id);

				// Проверить апдейт!!!
				if($salesflow->type == 1)
				{
					if(!empty($booking) && $user->status !=  3)
						$booking_users = $this->beds->get_bookings_users(['booking_id'=>$booking->id]);

					if(!empty($booking_users))
					{
						foreach ($booking_users as $b_u) 
							$this->users->update_user($b_u->user_id, ['status'=>2]);
					}

					$this->beds->update_booking($booking->id, ['living_status'=>2]); // approved
				}
				// в апрувд уходят только после прихода оплаты по контракту
				// elseif($salesflow->type == 0 && $user->status != 3)
				// {
				// 	$this->users->update_user($user->id, ['status'=>2]);
				// }

	            $mailto = 'customer.service@outpost-club.com';
				$mailfrom = $this->settings->notify_from_email;

				if(!empty($booking) && !empty($booking->manager_login))
				{
					$booking_manager = $this->managers->get_manager($booking->manager_login);
					if(!empty($booking_manager->email))
					{
						$mailto .= ', ' . $booking_manager->email;
					}
				}

				$this->design->assign('user', $user);
				$this->design->assign('sender', $params['sender']);

				$email_template = $this->design->fetch($this->config->root_dir.'backend/design/html/email_alex_approve.tpl');
				$subject = $this->design->get_var('subject');
				$this->notify->email($mailto, $subject, $email_template, $mailfrom);
			}	
		}
	}

	public function check_salesflow_status($id)
	{
		if(!empty($id))
		{
			$salesflow = $this->get_salesflows(['id'=>intval($id), 'limit'=>1]);
			if(!empty($salesflow))
			{
				$booking = $this->beds->get_bookings(['id'=>$salesflow->booking_id, 'limit'=>1]);				
				if(empty($booking) || $booking->status == 0)
				{
					header('Location: '.$this->config->root_url.'/reservation-is-canceled');
					exit;
				}
			}
			else
			{
				header('Location: '.$this->config->root_url.'/reservation-is-canceled');
				exit;
			}	
		}
		else
		{
			header('Location: '.$this->config->root_url.'/reservation-is-canceled');
			exit;
		}
	}

	public function start_hotel_salesflow($salesflow, $user_id, $params)
	{
		$u = $this->users->get_user(intval($user_id));

		if(!empty($u) && !empty($salesflow) && $salesflow->type == 3)
		{
			$booking_users = $this->beds->get_bookings_users(['booking_id'=>intval($salesflow->booking_id)]);
			$booking_users = $this->request->array_to_key($booking_users, 'user_id');

			$users = $this->users->get_users(['id'=>array_keys($booking_users)]);

			// $deposit_invoice = current($this->orders->get_orders(['booking_id'=>$salesflow->booking_id, 'deposit'=>1, 'limit'=>1]));

			
			$this->logs->add_log(array(
	            'parent_id' => $u->active_salesflow_id, 
	            'type' => 2, 
	            'user_id' => $u->id, 
	            'subtype' => 9, // Hotel Salesflow Sent
	            'sender_type' => $params['sender_type'],
	            'sender' => $params['sender']
	        ));
	        $this->logs->add_log(array(
				'parent_id'=> $u->id, 
				'type' => 17, // House Rules
				'subtype' => 1, // Sended
				'user_id' => $u->id, 
				'sender_type' => $params['sender_type'], 
				'sender' => $params['sender']
			));
	        // $this->logs->add_log(array(
			// 	'parent_id'=> $u->id, 
			// 	'type' => 8, // Covid Form
			// 	'subtype' => 1, // Sended
			// 	'user_id' => $u->id, 
			// 	'sender_type' => $params['sender_type'], 
			// 	'sender' => $params['sender']
			// ));


			$notification_id = $this->notifications->add_notification(array('user_id'=>$u->id, 'type'=>2));
			if(!empty($notification_id))
			{
				$notification = $this->notifications->get_notification($notification_id);
			}

			$this->design->assign('user', $u);
			$this->design->assign('bg_check', $notification);


            // Booking
            $booking = current($this->beds->get_bookings([
                'id' => $salesflow->booking_id,
                'sp_group' => true
            ]));
            if (!empty($booking)) {
                $booking->days_count = date_diff(date_create($booking->arrive), date_create($booking->depart))->days + 1;
                $this->design->assign('interval_days', $booking->days_count);
            }

			$email_template = $this->design->fetch($this->config->root_dir.'design/'.$this->settings->theme.'/html/email/hotel_sellflow.tpl');

			$subject = $this->design->get_var('subject');
			$this->notify->email($u->email, $subject, $email_template, $this->settings->notify_from_email);
		}
		else
		{
			return false;
		}

	}

}