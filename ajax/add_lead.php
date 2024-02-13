<?php
session_start();


require_once('../api/Backend.php');

class Sc extends Backend
{
	function fetch() {

        $data_arr = [];
        $data_arr['content'] = 'Lead not added';

		$lead = new stdClass;
        $lead->site = $this->request->post('site');
        $lead->form_type = $this->request->post('form_type', 'integer');

		$lead->first_name = $this->request->post('first_name');
		$lead->last_name = $this->request->post('last_name');
		$lead->email = $this->request->post('email');
		$lead->phone = $this->request->post('phone');
        if ($this->request->post('gender')) {
            $lead->gender = $this->request->post('gender', 'string');
        }

		$lead->application_house_id = $this->request->post('application_house_id', 'integer');
		

        $lead->move_in_date = $this->request->post('move_in_date', 'string');
        if ($this->request->post('move_out_date')) { 
            $lead->move_out_date = $this->request->post('move_out_date', 'string');
        }
        if ($this->request->post('dates_flexible')) { 
            $lead->dates_flexible = $this->request->post('dates_flexible', 'string');
            $lead->dates_flexible = ($lead->dates_flexible == 'Yes')?1:0;
        }
        if ($this->request->post('living_period')) { 
            $lead->living_period = $this->request->post('living_period');
        }
        if ($this->request->post('budget')) { 
            $lead->budget = $this->request->post('budget', 'string');
        }


        $lead_budgets = $this->request->post('budgets'); // array
        $lead_refers = $this->request->post('refers'); // array

        

        if ($this->request->post('stay_alone')) {
            $lead->stay_alone = $this->request->post('stay_alone');

            if ($lead->stay_alone == 'No') {
                if ($this->request->post('guest_first_name')) {
                    $lead->guest_first_name = $this->request->post('guest_first_name');
                }
                if ($this->request->post('guest_last_name')) {
                    $lead->guest_last_name = $this->request->post('guest_last_name');
                }
                if ($this->request->post('guest_email')) {
                    $lead->guest_email = $this->request->post('guest_email');
                }
                if ($this->request->post('guest_phone')) {
                    $lead->guest_phone = $this->request->post('guest_phone');
                }
            }

            $lead->stay_alone = ($lead->stay_alone == 'Yes')?1:0;
        }

        if ($this->request->post('room_type')) {
            $lead->room_type = $this->request->post('room_type');
        }

        if ($this->request->post('listing_website')) {
            $lead->listing_website = $this->request->post('listing_website');
        }

        if ($this->request->post('apartment_listing_website')) {
            $lead->apartment_listing_website = $this->request->post('apartment_listing_website');
        }

        if ($this->request->post('friend_name')) {
            $lead->friend_name = $this->request->post('friend_name');
        }

        if ($this->request->post('corporate_referral_code')) {
            $lead->corporate_referral_code = $this->request->post('corporate_referral_code');
        }

        if ($this->request->post('code')) {
            $lead->code = $this->request->post('code');
        }

        

        if ($this->request->post('additional_info')) {
            $lead->additional_info = $this->request->post('additional_info');
        }
        
        $selected_houses = [];
        $selected_houses_ids = $this->request->post('selected_houses_ids'); // array
        $selected_houses_names = $this->request->post('selected_houses_names'); // array
        $houses_names_ids = [];

        if (!empty($selected_houses_ids) || !empty( $selected_houses_names)) {
            $houses_pages = $this->pages->get_pages([
                'menu_id' => 5,
                'not_parent_id' => 0,
                'not_tree' => true
            ]);
            
            if (!empty($houses_pages)) {
                foreach($houses_pages as $h) {
                    $houses_names_ids[strtolower(trim($h->header))] = $h->id;
                }
            }
        }

        if (!empty($selected_houses_ids)) {
            foreach ($selected_houses_ids as $house_id=>$house_name) {
                $house = new stdClass;
                if (isset($houses_pages[$house_id])) {
                    $house->id = $house_id;
                }
                elseif (isset($houses_names_ids[strtolower(trim($house_name))])) {
                    $house->id = $houses_names_ids[strtolower(trim($house_name))];
                }
                else {
                    $house->name = trim($house_name);
                }
                $selected_houses[] = $house;

                if (empty($lead->application_house_id) && isset($house->id)) {
                    $lead->application_house_id = $house->id;
                }
            }
        }
        if (!empty($selected_houses_names)) {
            foreach ($selected_houses_names as $house_name) {
                $house = new stdClass;
                if (isset($houses_names_ids[strtolower(trim($house_name))])) {
                    $house->id = $houses_names_ids[strtolower(trim($house_name))];
                }
                else {
                    $house->name = trim($house_name);
                }
                $selected_houses[] = $house;

                if (empty($lead->application_house_id) && isset($house->id)) {
                    $lead->application_house_id = $house->id;
                }
            }
        }

        
        
		foreach ($lead as $k_l=>$l) {
            if (is_array($l)) {
                foreach($l as $k_ll=>$ll) {
                    $lead->$k_l[$k_ll] = trim($ll);
                }
            }
            else {
                $lead->$k_l = trim($l);
            }
        }



        // Add Tenant

        $user = new stdClass;
        
        $user->first_name = $lead->first_name;
        $user->last_name = $lead->last_name;
        $user->name = $lead->first_name.' '.$lead->last_name;

        $user->email = $lead->email;
        $user->phone = $lead->phone;
        $user->house_id = $lead->application_house_id;
        $user->type = 1;
        $user->status = 0;
        $user->enabled = 0;
        $user->blocks['auto_added'] = 1;
        $user->blocks = serialize($user->blocks);

        if (!empty($lead->gender)) {
            if ($lead->gender == 'Female') {
                $user->gender = 1;
            }
            elseif ($lead->gender == 'Male') {
                $user->gender = 2;
            }
            elseif ($lead->gender == 'Neither') {
                $user->gender = 3;
            }
        }

        if (!empty($lead->email)) {
            $u = $this->users->get_users([
                'email' => $lead->email,
                'limit' => 1,
                'count' => 1
            ]);
            if (!empty($u)) {
                $user->name .= ' [Please, use the main account '.$u->id.']';
                $user->email .= ' [Please, use the main account '.$u->id.']';
            }
        }

        if (!empty($user->email)) {
            if ($user_id = $this->users->add_user($user)) {

                $this->logs->add_log([
                    'parent_id' => $user_id, 
                    'type' => 2, 
                    'subtype' => 2, // User created
                    'sender_type' => 1 // System
                ]);


                // Add Lead Info
                $lead->user_id = $user_id;
                if ($lead_id = $this->users->add_lead($lead)) {
                    // Add Lead Data

                    // Houses
                    if (!empty($selected_houses)) {
                        foreach ($selected_houses as $h) {
                            $lead_data = new stdClass;
                            $lead_data->type = 1; // House
                            $lead_data->lead_id = $lead_id;

                            if (!empty($h->id)) {
                                $lead_data->value_id = $h->id;
                            }
                            elseif (!empty($h->name)) {
                                $lead_data->value = $h->name;
                            }
                            $this->users->add_lead_data($lead_data);
                        }
                    }

                    // Budgets
                    if (!empty($lead_budgets)) {
                        foreach ($lead_budgets as $b) {
                            $lead_data = new stdClass;
                            $lead_data->type = 2; // Budgets
                            $lead_data->lead_id = $lead_id;
                            $lead_data->value = $b;
                            $this->users->add_lead_data($lead_data);
                        }
                    }

                    // Refers
                    if (!empty($lead_refers)) {
                        foreach ($lead_refers as $r) {
                            $lead_data = new stdClass;
                            $lead_data->type = 3; // Refers
                            $lead_data->lead_id = $lead_id;
                            $lead_data->value = $r;
                            $this->users->add_lead_data($lead_data);
                        }
                    }


                    $data_arr['content'] = 'Lead added';
                }


                // Сohabitant
                if (!empty($lead->guest_email)) {
                    $cohabitant = new stdClass;
                    $cohabitant->first_name = $lead->guest_first_name;
                    $cohabitant->last_name = $lead->guest_last_name;
                    $cohabitant->name = $lead->guest_first_name.' '.$lead->guest_last_name;

                    $cohabitant->email = $lead->guest_email;
                    $cohabitant->phone = $lead->guest_phone;
                    $cohabitant->house_id = $lead->application_house_id;
                    $cohabitant->type = 7; // Сohabitant
                    $cohabitant->status = 11; // Сohabitant
                    $cohabitant->enabled = 0;
                    $cohabitant->blocks['auto_added'] = 1;
                    $cohabitant->blocks = serialize($cohabitant->blocks);

                    $c = $this->users->get_users([
                        'email' => $cohabitant->email,
                        'limit' => 1,
                        'count' => 1
                    ]);
                    if (!empty($c)) {
                        $cohabitant->name .= ' [Please, use the main account '.$c->id.']';
                        $cohabitant->email .= ' [Please, use the main account '.$c->id.']';
                    }

                    if ($cohabitant_id = $this->users->add_user($cohabitant)) {
                        $this->logs->add_log([
                            'parent_id' => $cohabitant_id, 
                            'type' => 2, 
                            'subtype' => 2, // User created
                            'sender_type' => 1 // System
                        ]);

                        $this->users->add_users_users(
                            2, 		   // type: Tenants - Сohabitant
                            $user_id, // tenant
                            $cohabitant_id
                        );
                    }


                }
            }
        }

        // $this->add_log();

		$this->echo_json($data_arr);
	}


	function echo_json($data) {
		header("Content-type: application/json; charset=UTF-8");
		header("Cache-Control: must-revalidate");
		header("Pragma: no-cache");
		header("Expires: -1");
		echo json_encode($data);
	}



	// Log in file
	function logg($str)
	{
		file_put_contents('log.txt', file_get_contents('log.txt')."\r\n".date("m.d.Y H:i:s").' '.$_SERVER['REMOTE_ADDR'].' '.$str);
	}
	function add_log($data = false) {
		// $postData = file_get_contents('php://input');
		if(!empty($postData)) {
			// $this->logg('json: '.http_build_query($postData));	
		}
        elseif(!empty($data)) {
            foreach((array)$data as $key=>$value) {
                if (is_array($value)) {
                    foreach($value as $k=>$v) {
                        $this->logg('log: '.$key.'['.$k.'] => ('.$v.')');
                    }
                }
                else {
                    $this->logg('log: '.$key.' => ('.$value.')');
                }	
			}
        }
		elseif (!empty($_POST)) {
			foreach($_POST as $key=>$value) {
                if (is_array($value)) {
                    foreach($value as $k=>$v) {
                        $this->logg('post: '.$key.'['.$k.'] => ('.$v.')');
                    }
                }
                else {
                    $this->logg('post: '.$key.' => ('.$value.')');
                }	
			}	
		}
		else {
			$this->logg('post empty');
		}	
	}


}


$sc = new Sc();
$sc->fetch();

