<?php

namespace Libs\Collection;

interface CollectionInterface
{
    const TYPE_BOOLEAN      = 'boolean';
    const TYPE_INTEGER      = 'integer';
    const TYPE_DOUBLE       = 'double';
    const TYPE_STRING       = 'string';
    const TYPE_ARRAY        = 'array';
    const TYPE_OBJECT       = 'object';
    const TYPE_RESOURCE     = 'resource';
    const TYPE_NULL         = 'NULL';
    const TYPE_UNKNOWN_TYPE = 'unknown type';

    public function toArray(): array;

    public function push($item): CollectionInterface;
    public function merge($items): CollectionInterface;

    public function count(): int;
    public function get($index);
    public function first();
    public function last();
    public function findFirst(string $field, $value, string $operator = '=');

    public function column($column, $index = null);

    public function remove($index): CollectionInterface;
}