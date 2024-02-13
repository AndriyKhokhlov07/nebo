<?php

namespace Controllers\Api;

use Models\User;
use Qira;
use Models\Log;

class QiraController
{
    public function deletePaymentMethod(string $userHash, string $paymentMethodId)
    {
        Log::create([
            'patent_id' => 0,
            'type' => 100,
            'subtype' => 100,
            'user_id' => 0,
            'sender' => 'qira-test',
            'sender_type' => 5,
            'value' => 'QiraController',
            'data' => null,
        ]);

        return (new Qira())->deletePaymentMethod($userHash, $paymentMethodId);
    }

    public function hasPaymentMethod(string $userHash, int $orderId){
        /**
         * @var User $user
         */
        $user = User::getByHashCode($userHash);
        $bool = $user->hasPaymentMethodByOrder($orderId);
        return $user->hasPaymentMethodByOrder($orderId);
    }
}