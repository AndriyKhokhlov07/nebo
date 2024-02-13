<?php

namespace Models;

use Libs\DBHelper\Model;

class Log extends Model
{

    protected static string $table = '__logs';

    protected array $casts = [
        'data' => 'object',
    ];

}