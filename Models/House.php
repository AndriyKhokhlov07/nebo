<?php

namespace Models;

use Libs\Collection\Collection;
use Libs\DBHelper\Model;

class House extends Model
{

    protected static string $table = '__bookings';

    public function payment_methods($paymentMethodType = null): Collection
    {
        $paymentMethodsHousesIds = PaymentMethodHouse::queryBuilder()->where('house_id', '=', $this->id)->get()->column('payment_method_id')->toArray();
        $paymentMethods = PaymentMethod::queryBuilder()->where('id', 'in', $paymentMethodsHousesIds)->get();

        if($paymentMethodType === null){
            return $paymentMethods;
        }

        $result = new Collection();
        foreach ($paymentMethods->getItems() as $paymentMethod){
            if($paymentMethod->settings->payment_method_type == $paymentMethodType){
                $result->push($paymentMethod);
            }
        }

        return $result;
    }

}