<?php

namespace Models;

use Libs\DBHelper\Model;

class District extends Model
{
    protected static string $table = '__districts';

    public static array $orders = ['position'];
}