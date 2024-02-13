<?php

use Libs\DBHelper\Schema;

class UsersSeeds
{
    use Schema;

    public function seeding(): void
    {
        $users = [
            [0, 2, 1, 4, 'romcrazy13@gmail.com', '380963849824', '282ff44a5b2eec13a3ee3bd99e2e1167', '', null, 'Rom Hritsiuk', 'Rom', '', 'Hritsiuk', 3203, 211, 0, 298, 3, null, 390, 1, 4, 0, '127.0.0.1', '2018-10-17 16:51:39', 0, '', 'a:2:{s:9:"workphone";s:0:"";s:13:"window_guards";a:2:{s:6:"status";i:1;s:8:"child_no";i:1;}}', '1969-12-31', '1969-12-31', 6, 1550.00, 0.00, 3, 0, '', '1969-12-31', 2, 0, '', '', null, '', '', '', null, null, null, null, null, '', null, null, null, null, 'a:1:{s:13:"from_move_out";a:1:{i:0;s:36:"074518c35f1dadcca128d988dc782438.jpg";}}', '', 0, 0]
        ];

        $sql = "
            INSERT INTO `s_users` (sku, type, client_type_id, status, email, phone, password, first_pass,
                                       landlord_code, name, first_name, middle_name, last_name, active_booking_id,
                                       active_salesflow_id, group_id, house_id, apartment_id, bed_name, bed_id, enabled,
                                       moved_in, valid_email, last_ip, created, facebook_id, image, blocks,
                                       inquiry_arrive, inquiry_depart, room_type, price_month, price_deposit,
                                       membership, hide_ach, note, birthday, gender, us_citizen, social_number, zip,
                                       state_code, city, street_address, apartment, employment_status,
                                       employment_income, transunion_id, transunion_status, transunion_data,
                                       checker_options, checkr_candidate_id, hellorented_tenant_id,
                                       security_deposit_type, security_deposit_status, files, auth_code, dont_extend,
                                       block_notifies)
            values (#data#);
        ";

        self::init();

        foreach ($users as $user){
            foreach ($user as &$param){
                if($param === '') {
                    $param = '""';
                }elseif ($param === null){
                    $param = "NULL";
                }elseif (is_string($param)){
//                    $param = str_replace('"', '\"', $param);
                    $param = "'" . $param . "'";
                }
            }
            $query = str_replace('#data#', implode(',', $user), $sql);
            self::$db->query($query);
        }
    }
}