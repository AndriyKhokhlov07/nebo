<?php

namespace Libs\Console\Migrations\Helpers;

class Column
{

    /**
     * Numeric Data Types
     */
    const TYPE_BIT = 'bit';
    // exact values
    const TYPE_TINYINT = 'tinyint';
    const TYPE_INT = 'int';
    const TYPE_INTEGER = 'integer';
    const TYPE_MEDIUMINT = 'mediumint';
    const TYPE_BIGINT = 'bigint';
    const TYPE_DEC = 'dec';
    const TYPE_DECIMAL = 'decimal';
    const TYPE_NUMERIC = 'numeric';
    const TYPE_FIXED = 'fixed';
    // approximate values
    const TYPE_FLOAT = 'float';
    const TYPE_DOUBLE = 'double';

    /**
     * Boolean Data Types
     */
    const TYPE_BOOL = 'bool';
    const TYPE_BOOLEAN = 'boolean';

    /**
     * DateTime Data Types
     */
    const TYPE_DATE = 'date';
    const TYPE_TIME = 'time';
    const TYPE_DATETIME = 'datetime';
    const TYPE_TIMESTAMP = 'timestamp';
    const TYPE_YEAR = 'year';

    /**
     * String Data Types
     */
    const TYPE_CHAR = 'char';
    const TYPE_VARCHAR = 'varchar';
    const TYPE_BINARY = 'binary';
    const TYPE_VARBINARY = 'varbinary';
    const TYPE_TEXT = 'text';
    const TYPE_BLOB = 'blob';

    private string $name;

    private string $type;

    private $attributes = [
        'nullable'          => true,
        'default'           => null,
        'first'             => false,
        'after'             => null,
        'comment'           => null,
        'primary_key'       => false,
        'auto_increment'    => false,
        'index'             => null,
        'unique'            => false,
    ];

    public function __get($name)
    {
        return $this->{$name};
    }

//    public function name(): string
//    {
//        return $this->name;
//    }
//
//    public function type(): string
//    {
//        return $this->type;
//    }
//
//    public function attributes(): array
//    {
//        return $this->attributes;
//    }

    public static function create(
        string $name,
        string $type = self::TYPE_INT,
        array $attributes = []
    ): Column
    {
        $column = new static();
        $column->name = $name;
        $column->type = $type;
        $column->attributes = array_merge($column->attributes, $attributes);

        return $column;
    }

    public static function rename(string $oldName, string $newName)
    {
        $schema = Schema::getSchema();
        return "change `{$oldName}` `{$newName}`";
    }

    public static function update(
        string $name,
        string $type = self::TYPE_INT,
        array $attributes = []
    )
    {
        $column = new static();
        $column->name = $name;
        $column->type = $type;
        $column->attributes = array_merge($column->attributes, $attributes);
    }
}