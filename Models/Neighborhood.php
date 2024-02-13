<?php

namespace Models;

use Libs\DBHelper\Model;

class Neighborhood extends Model
{
    protected static string $table = '__neighborhoods';

    public static array $orders = ['position'];
}