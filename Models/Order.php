<?php

namespace Models;

use Libs\Collection\Collection;
use Libs\DBHelper\Model;

class Order extends Model
{
    protected static string $table = 's_orders';

    public function order_user(): Collection
    {
        return OrderUser::queryBuilder()->where('order_id', '=', $this->id)->get();
    }

    public function users(): Collection
    {
        if($this->order_user && $this->order_user->count()){
            $userIds = $this->order_user->column('user_id')->toArray();
            return User::queryBuilder()->where('id', self::CONDITION_OPERATOR_IN, $userIds)->get();
        }
        return new Collection();
    }

    public function booking(): ?Model
    {
        return Booking::queryBuilder()->where('id', '=', $this->booking_id)->getFirst();
    }

    public function order_label(): ?Model
    {
        return OrderLabel::queryBuilder()->where('order_id', '=', $this->id)->getFirst();
    }

    public function purchases(): Collection
    {
        return Purchase::queryBuilder()->where('order_id', '=', $this->id)->get();
    }

    public function autocharges(): Collection
    {
        $result = new Collection();

        foreach ($this->users->getItems() as $user){
            if(!empty($paymentMethodsDetails = $user->payment_methods_details)){
                foreach ($paymentMethodsDetails as $paymentMethodDetails){
                    $payment_method = $this->booking->house->payment_methods((int)$paymentMethodDetails->payment_method_type)->first();
                    if(
                        $payment_method
                        && $paymentMethodDetails->payee_id == $payment_method->settings->payee_id
                    ){
                        $this->save(['payment_method_id' => $payment_method->id]);

                        $result->push((object)[
                            'order' => $this,
                            'user' => $user,
                            'payment_method_details' => (object)$paymentMethodDetails
                        ]);
                    }
                }
            }
        }

        return $result;
    }

    public function autocharge_users(): Collection
    {
        $result = new Collection();
        foreach ($this->users->getItems() as $user){
            if(!empty($paymentMethodsDetails = $user->payment_methods_details)){
                foreach ($paymentMethodsDetails as $paymentMethodDetails){
                    $payment_method = $this->booking->house->payment_methods((int)$paymentMethodDetails->payment_method_type)->first();
                    if(
                        $payment_method
                        && $paymentMethodDetails->payee_id == $payment_method->settings->payee_id
                    ){
                        $result->push($user);
                    }
                }
            }
        }

        return $result;
    }
}