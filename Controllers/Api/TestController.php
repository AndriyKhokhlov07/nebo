<?php

namespace Controllers\Api;

use Models\User;
use Qira;
use Models\Log;

class TestController
{
    public function hasPaymentMethod(string $userHash, int $orderId){
        /**
         * @var User $user
         */
        $user = User::getByHashCode($userHash);
        $bool = $user->hasPaymentMethodByOrder($orderId);
        return $user->hasPaymentMethodByOrder($orderId);
    }
}