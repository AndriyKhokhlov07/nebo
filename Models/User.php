<?php

namespace Models;

use Libs\Collection\Collection;
use Libs\DBHelper\Model;
use Qira;
use Models\Order;

class User extends Model
{
    protected static string $table = '__users';

    protected array $guarded = [
        'id',
    ];

    protected array $casts = [
        'blocks' => 'object',
        'payment_methods_details' => 'object',
        'checker_options' => 'object',
        'files' => 'object',
    ];

    public static function getByHashCode(string $hashCode): ?Model
    {
        return User::queryBuilder()->where('hash_code', '=', $hashCode)->getFirst();
    }

    public function bookings()
    {
        $bookingIds = BookingUser::queryBuilder()->where('user_id', '=', $this->id)->get()->column('booking_id')->toArray();
        return Booking::queryBuilder()->where('id', self::CONDITION_OPERATOR_IN, $bookingIds)->get();
    }

    public function getPaymentMethodDetails(): Collection
    {
        $result = new Collection();

        if(!empty($paymentMethodsDetails = $this->payment_methods_details)){
            foreach ($paymentMethodsDetails as $paymentMethodsDetail){
                $order = Order::find($paymentMethodsDetail->order_id);
                $payment_method = ($order->booking->house) ? $order->booking->house->payment_methods((int)$paymentMethodsDetail->payment_method_type)->first() : null;

                if(
                    $payment_method
                    && $paymentMethodsDetail->payee_id == $payment_method->settings->payee_id
                ){
                    $paymentMethodsDetail->order = $order;
                    $paymentMethodsDetail->booking = $order->booking;
                    $result->push($paymentMethodsDetail);
                }
            }
        }

        return $result;
    }

    public function addPaymentMethodDetails($paymentMethodDetails): self
    {
        $array = (array)$this->payment_methods_details;
        $array[] = (object)$paymentMethodDetails;
        $this->payment_methods_details = $array;
        return $this;
    }

    public function hasPaymentMethodByOrder(int $orderId): bool
    {
        $needleBookingId = Order::find($orderId)->booking->id ?? null;
        foreach ($this->getPaymentMethodDetails()->getItems() as $item){
            $currentBookingId = $item->booking_id ?? Order::find($item->order_id)->booking->id ?? null;
            if($needleBookingId === $currentBookingId){
                return true;
            }
        }
        return false;
    }
}