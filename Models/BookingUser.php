<?php

namespace Models;

use Libs\DBHelper\Model;

class BookingUser extends Model
{

    protected static string $table = '__bookings_users';

    public function users()
    {
        return User::getList(null, ["id = {$this->user_id}"]);
    }

    public function bookings()
    {
        return Booking::getList(null, ["id = {$this->booking_id}"]);
    }
}