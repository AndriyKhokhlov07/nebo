<?php

namespace Models;

use Libs\DBHelper\Model;

class OrderUser extends Model
{
    protected static string $table = '__orders_users';

    public function orders()
    {
        return Order::queryBuilder()->where('id', '=', $this->order_id)->get();
    }

    public function users()
    {
        return User::queryBuilder()->where('id', '=', $this->user_id)->get();
    }
}