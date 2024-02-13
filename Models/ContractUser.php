<?php

namespace Models;

use Libs\DBHelper\Model;

class ContractUser extends Model
{

    protected static string $table = '__contracts_users';

    public function users()
    {
        return User::getList(null, ["id = {$this->user_id}"]);
    }

    public function contracts()
    {
        return Contract::getList(null, ["id = {$this->contract_id}"]);
    }
}