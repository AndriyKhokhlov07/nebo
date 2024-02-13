<?php

namespace Models;

use Libs\DBHelper\Model;

class Page extends Model
{
    protected static string $table = '__pages';

    public static array $orders = ['position'];

    protected array $casts = [
        'blocks' => 'object',
        'blocks2' => 'object',
        'blocks3' => 'object',
        'visible' => 'boolean',
    ];

    public function children(): array
    {
        return Page::getList(null, ["parent_id = {$this->id}"], ['name']);
    }

    public function city(): ?Model
    {
        return ((int)$this->parent_id > 0) ? Page::find($this->parent_id) : null;
    }

    public function neighborhood(): ?Model
    {
        return ((int)$this->parent2_id > 0) ? Neighborhood::find($this->parent2_id) : null;
    }
}