<?php

namespace Models;

use Libs\DBHelper\Model;

class Contract extends Model
{

    protected static string $table = '__contracts';

    public function contract_users(): array
    {
        $contractUsers = ContractUser::getList(null, ["contract_id = {$this->id}"]);
        return $contractUsers;
    }

    public function users()
    {
        $contractUsers = $this->contract_users();
        $users_ids = [];
        foreach ($contractUsers as $contractUser){
            $users_ids[] = $contractUser->user_id;
        }
        return User::getList(null, ['id in (' . implode(',', $users_ids) . ')']);
    }

    public function users_count(): int
    {
        return count($this->contract_users());
    }
}