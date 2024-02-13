<?php

use Libs\Routing\Route;
use Controllers\Api\QiraController;
use Controllers\Api\TestController;


//Route::get('user', [\Models\User::class, 'getUser'])->name('get_user');
//Route::get('user/{id}', function(int $id){
//        return \Models\User::find($id);
//});
Route::get('user/qira/autocharge-remove/{userHash}/{paymentMethodId}', [QiraController::class, 'deletePaymentMethod'])
    ->where([
        'userHash' => '/^[a-f\d]{32}$/i',
        'paymentMethodId' => '/^[a-f\d]{8}(-[a-f\d]{4}){4}[a-f\d]{8}$/i',
    ])
    ->name('qira.autocharge.remove_payment_method');
Route::get('test/{userHash}/{orderId}', [TestController::class, 'hasPaymentMethod'])
    ->where([
        'userHash' => '/^[a-f\d]{32}$/i',
        'orderId' => '/^[\d]+$/',
    ]);



