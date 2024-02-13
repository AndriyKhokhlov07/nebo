<?PHP

require_once('View.php');

class HouseFormView extends View
{
    private function unset_empty_val($input){
        foreach ($input as &$value){
            if (is_array($value) || is_object($value)) {
                $value = $this->unset_empty_val($value);
            }
        }
        if (is_array($input)) {
            return array_filter($input);
        }
        elseif (is_object($input)) {
            return (object)array_filter((array)$input);
        }
    }

    function arrayRecursiveDiff($hf_new, $hf_old, $type): array
    { // вилучаю відмінності між новими та старими даними
        $hf_upd = [];

        foreach ($hf_new as $k => $v) {
            if (array_key_exists($k, $hf_old)) {
                if (is_array($v)) {
                    $aRecursiveDiff = $this->arrayRecursiveDiff($v, $hf_old[$k], $type);
                    if (count($aRecursiveDiff)) {
                        $hf_upd[$k] = $aRecursiveDiff;
                    }
                } else {
                    if ($v != $hf_old[$k]) {
                        $hf_upd[$k] = $type==1?$v:$hf_old[$k];
                    }
                }
            } else {
                $hf_upd[$k] = $type==1?$v:$hf_old[$k];
            }
        }
        return $hf_upd;
    }


    function fetch()
    {
        if(empty($this->user) && empty($_SESSION['admin'])) {
            header('Location: '.$this->config->root_url.'/user/login');
            exit();
        }

        $url = $this->request->get('house_url', 'string');
        $house = $this->pages->get_page($url);

        if (empty($house)) {
            return false;
        }
        if ($house->menu_id != 5 ) {
            return false;
        }

        $house_form = $this->forms->get_forms_data([
            'type' => 1, // House
            'parent_id' => $house->id,
            'count' => 1
        ]);

        if($this->request->method('POST')) {

            $hf = new stdClass;
            $hf->name_house = $this->request->post('name_house', 'string');
            $hf->address_house = $this->request->post('address_house');
            $hf->house_id = $this->request->post('house_id', 'string');
            $hf->house_code = $this->request->post('house_code', 'string');

            $hf->company_owner = $this->request->post('company_owner', 'string');
            $hf->company_address = $this->request->post('company_address', 'string');
            $hf->person_name = $this->request->post('person_name', 'string');
            $hf->person_email = $this->request->post('person_email');
            $hf->landlord_id = $this->request->post('landlord_id', 'string');
            $hf->landlord_group = $this->request->post('landlord_group', 'string');

            $prices = $this->request->post('price');
            if (!empty($prices)) {
                $hf->prices = [];
                foreach ($prices as $k => $p) {
                    $price = (object)$p;
                    $hf->prices[$k] = $price;
                }
            }

            $apartments = $this->request->post('apart');
            if (!empty($apartments)) {
                $hf->apartments = [];
                foreach ($apartments as $k => $a) {
                    $apartment = (object)$a;
                    $hf->apartments[$k] = $apartment;
                }
            }
            $rooms = $this->request->post('room');
            if (!empty($rooms)) {
                foreach ($rooms as $k => $r) {
                    $room = (object)$r;
                    if (isset($hf->apartments[$room->apartment_key])) {
                        $hf->apartments[$room->apartment_key]->rooms[$k] = $room;
                    }
                }
            }

            $medias = $this->request->post('media');
            if (!empty($medias)) {
                $hf->medias = [];
                foreach ($medias as $k => $m) {
                    $media = (object)$m;
                    $hf->medias[$k] = $media;
                }
                $hf->media_pictures = $this->request->post('media_pictures');
                $hf->media_copy_pictures = $this->request->post('media_copy_pictures');
            }


            $hf->list_of_tenants = $this->request->post('list_of_tenants');
            $hf->ladger_each_tenant = $this->request->post('ladger_each_tenant');

            $hf->application = $this->request->post('application', 'string');
            $hf->deposit = $this->request->post('deposit', 'string');

            $hf->finance_docs = $this->request->post('finance_docs');
            $hf->brokarage = $this->request->post('brokarage', 'string');
            $hf->pm_fee = $this->request->post('pm_fee', 'string');
            $hf->bank = $this->request->post('bank', 'string');
            $hf->lender = $this->request->post('lender', 'string');
            $hf->morgage = $this->request->post('morgage', 'string');
            $hf->identifier = $this->request->post('identifier', 'string');
            $hf->deposit_account = $this->request->post('deposit_account', 'string');

            $hf->utility = $this->request->post('utility', 'string');

            $accounts = $this->request->post('account_item');
            if (!empty($accounts)) {
                $hf->accounts = [];
                foreach ($accounts as $k => $ai) {
                    $account = (object)$ai;
                    $hf->accounts[$k] = $account;
                }
            }

            $access_codes = $this->request->post('access_code_item');
            if (!empty($access_codes)) {
                $hf->access_codes = [];
                foreach ($access_codes as $k => $ac) {
                    $access_code = (object)$ac;
                    $hf->access_codes[$k] = $access_code;
                }
            }

            $hf = $this->unset_empty_val($hf);

            $house_form_old = $this->forms->get_forms_data([
                'parent_id' => $house->id,
                'type' =>  1,
                'count' => 1
            ]);
            $hf_old = new stdClass;
            if (!empty($house_form_old)) {
                $hf_old = json_decode(json_encode($house_form_old->value), true);
            }
            $hf_new = json_decode(json_encode($hf), true);

            $hf_upd1 = $this->arrayRecursiveDiff($hf_new, $hf_old, 1);
            $hf_upd2 = $this->arrayRecursiveDiff($hf_old, $hf_new, 2);
            $hf_upd = array_replace_recursive($hf_upd1, $hf_upd2);



            if (empty($house_form)) {
                //Add
                $house_form->id = $this->forms->add_form_data([
                    'type' => 1, // House form
                    'parent_id' => $house->id,
                    'value' => $hf
                ]);
                $this->design->assign('message_success', 'added');
            } else {
                // Update
                $this->forms->update_form_data($house_form->id, [
                    'value' => $hf
                ]);
                $this->design->assign('message_success', 'updated');
            }

            // Add log
            if ($hf_upd) {
                $log_data = new stdClass;
                $log_data->parent_id = $house_form->id;
                $log_data->type = 19; // Onboarding form
                $log_data->subtype = 1; // Updated
                $log_data->data = $hf_upd;
                if ($this->user) {
                    $log_data->sender_type = 3;
                    $log_data->sender = $this->user->first_name.' '.$this->user->last_name;
                }
                elseif ($_SESSION['admin']) {
                    $log_data->sender_type = 2;
                    $manager = $this->managers->get_manager($_SESSION['admin_login']);
                    $log_data->sender = $manager->login;
                }
                $this->logs->add_log($log_data);
            }
        }


        if ($house) {
            $house_form_value = new stdClass;


            $house_form = $this->forms->get_forms_data([
                'parent_id' => $house->id,
                'type' =>  1,
                'count' => 1
            ]);


            if (isset($house_form->value)) {
                $house_form_value = (object)$house_form->value;
            }

            if (empty($house_form_value->prices)) {
                $house_form_value->prices = [1];
            }
            if (empty($house_form_value->apartments)) {
                $house_form_value->apartments = [
                    0 => (object)[
                        'rooms' => [1]
                    ]
                ];
            }
            else {
                foreach ($house_form_value->apartments as $k=>$a) {
                    if (empty($a->rooms)) {
                        $house_form_value->apartments[$k]->rooms = [1];
                    }
                }
            }
            if (empty($house_form_value->accounts)) {
                $house_form_value->accounts = [1];
            }
            if (empty($house_form_value->medias)) {
                $house_form_value->medias = [1];
            }
            if (empty($house_form_value->access_codes)) {
                $house_form_value->access_codes = [1];
            }

//            print_r($house_form_value);exit;

            $this->design->assign('house_form', $house_form_value);
            $this->design->assign('house', $house);

            $this->design->assign('room_types', $this->beds->get_rooms_types());

        }

        return $this->design->fetch('forms/house_form.tpl');
    }
}
