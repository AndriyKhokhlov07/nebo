<?php

namespace Libs\Console;

class Message
{
    const TYPE_MESSAGE_DEFAULT  = 'default';
    const TYPE_MESSAGE_INFORM   = 'inform';
    const TYPE_MESSAGE_SUCCESS  = 'success';
    const TYPE_MESSAGE_WARNING  = 'warning';
    const TYPE_MESSAGE_ERROR    = 'error';
    const TYPES_STILE = [
        self::TYPE_MESSAGE_INFORM => [
            self::FONT_COLOR_LIGHT_GREY,
            self::BACK_COLOR_BLACK
        ],
        self::TYPE_MESSAGE_SUCCESS => [
            self::FONT_COLOR_LIGHT_GREEN,
            self::BACK_COLOR_BLACK
        ],
        self::TYPE_MESSAGE_WARNING => [
            self::FONT_COLOR_YELLOW,
            self::BACK_COLOR_BLACK
        ],
        self::TYPE_MESSAGE_ERROR => [
            self::FONT_COLOR_RED,
            self::BACK_COLOR_CYAN
        ],
        self::TYPE_MESSAGE_DEFAULT => [
            self::FONT_COLOR_LIGHT_GREY,
            self::BACK_COLOR_BLACK
        ],
    ];

    const FONT_COLOR_BLACK = '0;30';
    const FONT_COLOR_DARK_GREY = '1;30';
    const FONT_COLOR_RED = '0;31';
    const FONT_COLOR_LIGHT_RED = '1;31';
    const FONT_COLOR_GREEN = '0;32';
    const FONT_COLOR_LIGHT_GREEN = '1;32';
    const FONT_COLOR_BROWN = '0;33';
    const FONT_COLOR_YELLOW = '1;33';
    const FONT_COLOR_BLUE = '0;34';
    const FONT_COLOR_LIGHT_BLUE = '1;34';
    const FONT_COLOR_MAGENTA = '0;35';
    const FONT_COLOR_LIGHT_MAGENTA = '1;35';
    const FONT_COLOR_CYAN = '0;36';
    const FONT_COLOR_LIGHT_CYAN = '1;36';
    const FONT_COLOR_LIGHT_GREY = '0;37';
    const FONT_COLOR_WHITE = '1;37';

    const BACK_COLOR_BLACK = '40';
    const BACK_COLOR_RED = '41';
    const BACK_COLOR_GREEN = '42';
    const BACK_COLOR_YELLOW = '43';
    const BACK_COLOR_BLUE = '44';
    const BACK_COLOR_MAGENTA = '45';
    const BACK_COLOR_CYAN = '46';
    const BACK_COLOR_LIGHT_GREY = '47';

    public static function message(string $message, ?string $typeMessage = null)
    {
        $default = implode(';', self::TYPES_STILE[self::TYPE_MESSAGE_DEFAULT]);

        $preffix = !empty(self::TYPES_STILE[$typeMessage])
            ? implode(';', self::TYPES_STILE[$typeMessage])
            : implode(';', self::TYPES_STILE[self::TYPE_MESSAGE_DEFAULT]);

        echo "\033[{$preffix}m{$message}\033[{$default}m" . PHP_EOL;
    }

    public static function messages(array $messages, ?string $typeMessage = null)
    {
        foreach ($messages as $message){
            if(is_string($message)){
                self::message($message, $typeMessage);
            }
        }
    }
}