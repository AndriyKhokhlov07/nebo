<?php
ini_set('error_reporting', E_ALL);


session_start();

chdir('..');
require_once('api/Backend.php');


class Test extends Backend
{
	function fetch()
	{
		$query = $this->db->placehold("SELECT 
										u.id,
										bu.booking_id
									FROM __users u
									INNER JOIN __bookings_users bu ON  bu.user_id = u.id
									WHERE u.active_salesflow_id IS NULL AND u.active_booking_id IS NULL
									ORDER BY u.id 
									LIMIT 10");

		$this->db->query($query);
		$users = $this->db->results();

		print_r($users); exit;

		foreach ($users as $u) 
		{
			$this->beds->update_booking($u->active_booking_id, array('moved'=>$u->moved_in));

			$s = new stdClass();
			$s->user_id = $u->id;
			$s->booking_id = $u->active_booking_id;
			$s->type = 0 | 1;

			$s->application_data['social_number'] = $u->social_number;
			$s->application_data['zip'] = $u->zip;
			$s->application_data['state_code'] = $u->state_code;
			$s->application_data['city'] = $u->city;
			$s->application_data['street_address'] = $u->street_address;
			$s->application_data['apartment'] = $u->apartment;
			$s->application_data['employment_status'] = $u->employment_status;
			$s->application_data['employment_income'] = $u->employment_income;
			if(!empty($u->checker_options))
				$s->application_data = $s->application_data + (array) unserialize($u->checker_options);

			$u->blocks = (array) unserialize($u->blocks);
			if(!empty($u->blocks))
				$s->application_data = $s->application_data + $u->blocks;

			$u->files = (array) unserialize($u->files);
			$s->application_data['files'] = $u->files;

			$s->application_data = serialize($s->application_data);

			$s->application_type = 0;

			if(!empty($u->files['additional']))
				$s->additional_files = $u->files['additional'];
			else
				$s->additional_files = '';

			$s->additional_files = serialize($s->additional_files);


			if(!empty($u->transunion_id))
				$s->transunion_id = $u->transunion_id;
			if(!empty($u->transunion_status))
				$s->transunion_status = $u->transunion_status;
			if(!empty($u->transunion_data))
				$s->transunion_data = $u->transunion_data;

			if(!empty($u->blocks['ekata_network_score']))
				$s->ekata_status['ekata_network_score'] = $u->blocks['ekata_network_score'];
			if(!empty($u->blocks['ekata_check_score']))
				$s->ekata_status['ekata_check_score'] = $u->blocks['ekata_check_score'];
			if(!empty($u->blocks['ekata_phone_check']))
				$s->ekata_status['ekata_phone_check'] = $u->blocks['ekata_phone_check'];

			$s->ekata_status = serialize($s->ekata_status);

			$ra_invoice_filter['user_id'] = $u->id;
			$ra_invoice_filter['type'] = 7; // Application fee 
			$ra_invoice_filter['limit'] = 1;
			$ra_invoice_filter['count'] = 1;

			$ra_invoice = $this->orders->get_orders($ra_invoice_filter);

			if(empty($ra_invoice))
				$s->ra_fee_status = 0;
			else
				$s->ra_fee_status = $ra_invoice->status;

			if(!empty($u->security_deposit_status))
				$s->deposit_status = $u->security_deposit_status;
			if(!empty($u->security_deposit_type))
				$s->deposit_type = $u->security_deposit_type;

			if($u->client_type_id == 1)
			{
				$contract = current($this->contracts->get_contracts(['user_id'=>$u->id, 'limit'=>1]));
				if(!empty($contract) && !empty($contract->approve))
					$s->approve = $contract->approve;
				else
					$s->approve = 0;
			}
			else
			{
				$bookings = $this->beds->get_bookings(['user_id'=>$u->id]);
				$bookings = $this->request->array_to_key($bookings, 'id');
				if(!empty($bookings))
				{
					$approve_logs = $this->logs->get_logs(['parent_id'=>array_keys($bookings), 'type'=>1, 'subtype'=>11]);
					if(!empty($approve_logs))
						$s->approve = 1;
					else
						$s->approve = 0;
				}
				else
					$s->approve = 0;
			}

			$contract = current($this->contracts->get_contracts(['reserv_id'=>$u->active_booking_id, 'limit'=>1]));

			if($contract && !empty($contract->signing))
				$s->contract_status = $contract->signing;
			else
				$s->contract_status = 0;


			if(isset($u->blocks['covid_form']))
				$s->covid_form_status = $u->blocks['covid_form'];
			else
				$s->covid_form_status = 0;

			$paid_order = $this->orders->get_orders(['user_id'=>$u->id, 'paid'=>1, 'count'=>1, 'limit'=>1, 'type'=>1, 'deposit'=>0]);
			if(!empty($paid_order))
				$s->invoice_status = $paid_order->status;
			else
				$s->invoice_status = 0;


			$id = $this->salesflows->add_salesflow($s);

			echo 'Salesflow added: '.$id.' tu id: '.$u->transunion_id.' 

			';

			$this->users->update_user($u->id, array('salesflow_created'=>1, 'active_salesflow_id'=>$id));
		}
		exit;


	}
}


$test = new Test();
$test->fetch();
