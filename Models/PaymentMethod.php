<?php

namespace Models;

use Libs\DBHelper\Model;

class PaymentMethod extends Model
{

    protected static string $table = '__payment_methods';

    protected array $casts = [
        'settings' => 'object',
    ];

}