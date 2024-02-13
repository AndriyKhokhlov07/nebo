<?php

namespace Models;

use Libs\DBHelper\Model;

class Booking extends Model
{

    protected static string $table = '__bookings';

    public function booking_users(): array
    {
        $bookingUsers = BookingUser::getList(null, ["booking_id = {$this->id}"]);
        return $bookingUsers;
    }

    public function users()
    {
        $bookingUsers = $this->booking_users();
        $users_ids = [];
        foreach ($bookingUsers as $bookingUser){
            $users_ids[] = $bookingUser->user_id;
        }
        return User::getList(null, ['id in (' . implode(',', $users_ids) . ')']);
    }

    public function users_count(): int
    {
        return count($this->booking_users());
    }

    public function apartment(): ?Model
    {
        return Apartment::queryBuilder()->where('id', '=', $this->apartment_id)->getFirst();
    }

    public function house(): ?Model
    {
        return House::queryBuilder()->where('id', '=', $this->house_id)->getFirst();
    }
}