<?php

namespace Models;

use Libs\DBHelper\Model;

class Sure extends Model
{
    protected static string $table = '__sures';

    protected array $guarded = [
        'id',
        'created_at',
    ];

    protected array $casts = [
        'params'        => 'object',
        'created_at'    => 'datetime',
    ];

    public static function getByUserHash(string $userHashCode, int $bookingId): ?Model
    {
        $user = User::getByHashCode($userHashCode);
        $model = self::queryBuilder()
            ->where('user_id', '=', $user->id)
            ->andWhere('booking_id', '=', $bookingId)
            ->getFirst();

        return $model;
    }
}