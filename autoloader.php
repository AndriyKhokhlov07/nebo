<?php

include_once(ROOT_PATH . '/Libs/ViewHelper/view_helper.php');

$classesPaths = [
    'api',
    'payment/Paypal',
    'payment/Qira',
    'payment/Stripe',
    'payment/StripeACH',
    'payment/StripeACHv2',
];

function prepareFilePath(string $path): string
{
    $path = str_replace('\\', '/', $path);
    return preg_replace('/\/+/', '/', $path);
}

spl_autoload_register(function($className) use($classesPaths) {
    $fileName = $className . '.php';
    $fullPath = prepareFilePath(ROOT_PATH . DIRECTORY_SEPARATOR . $fileName);
    if (file_exists($fullPath)) {
        include_once($fullPath);
    }else{
        foreach ($classesPaths as $classesPath){
            $fullPath = prepareFilePath(ROOT_PATH . DIRECTORY_SEPARATOR . $classesPath . DIRECTORY_SEPARATOR . $fileName);
            if (realpath($fullPath)) {
                include_once($fullPath);
                break;
            }
        }
    }
});


