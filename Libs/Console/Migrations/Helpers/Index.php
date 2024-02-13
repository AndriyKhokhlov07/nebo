<?php

namespace Libs\Console\Migrations\Helpers;

class Index
{
    const TYPE_PRIMARY = 'primary';
    const TYPE_INDEX = 'index';
    const TYPE_UNIQUE = 'unique';

    private string $type = self::TYPE_INDEX;
    private array $columns = [];

    public function __construct(array $columns = [], string $type)
    {
        $this->type = $type;
    }
}