<?php

$path = __DIR__ . DIRECTORY_SEPARATOR;
$prefix = '';
while(!file_exists($path . $prefix . 'autoloader.php')){
    $prefix .= '..' . DIRECTORY_SEPARATOR;
}
define('ROOT_PATH', realpath($path . $prefix));
require_once (ROOT_PATH . DIRECTORY_SEPARATOR . 'autoloader.php');

use Libs\Console\Message;
use Libs\Console\Migrations\Migrations;
use Config;

$config = new Config();

/**
 * @param array|string $messages
 * @param string $typeMessage
 */
function exitConsole($messages = [], string $typeMessage = Message::TYPE_MESSAGE_DEFAULT): void
{
    if(is_string($messages)){
        $messages = [$messages];
    }
    foreach ($messages as $message){
        if(!empty($message)){
            if(is_array($message)){
                exitConsole($message, $typeMessage);
            }else{
                Message::message($message, $typeMessage);
            }
        }
    }
    Message::message('===== CONSOLE DONE =====');
    exit();
}
function exitConsoleWithInform($messages = []): void { exitConsole($messages, Message::TYPE_MESSAGE_INFORM); }
function exitConsoleWithWarning($messages = []): void { exitConsole($messages, Message::TYPE_MESSAGE_WARNING); }
function exitConsoleWithError($messages = []): void { exitConsole($messages, Message::TYPE_MESSAGE_ERROR); }



Message::message('===== CONSOLE RUNNING =====');

/**
 * For create new migration file call
 *      php bin/console.php migrations:create [--description|-d=eny_description]
 * For migrate new files into DB call
 *      php bin/console.php migrations:migrate
 */
const MODULE_MIGRATIONS = 'migrations';

if(empty($GLOBALS['argv'][1])){
    exitConsole(['UNDEFINED COMMAND, LET`S TRY AGAIN'], Message::TYPE_MESSAGE_WARNING);
}

$params = $argv;
array_shift($params);

[$module, $action] = explode(':', array_shift($params));

switch ($module){
    case MODULE_MIGRATIONS:
        Message::message('===== MODULE MIGRATIONS =====');
        new Migrations($action, $params);
        break;
    default:
        exitConsole(['UNDEFINED SUPPORTED COMMAND, LET`S TRY AGAIN'], Message::TYPE_MESSAGE_WARNING);
}

