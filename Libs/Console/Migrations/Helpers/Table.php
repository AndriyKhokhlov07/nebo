<?php

namespace Libs\Console\Migrations\Helpers;

use Libs\Console\Migrations\Schema;
use Libs\Console\Migrations\Helpers\SqlBuilder as SB;

class Table
{
    /**
     * @var string
     */
    private string $name;

    /**
     * @var string
     */
    private string $comment;

    public function name(): string
    {
        return $this->name;
    }

    public function comment(): string
    {
        return $this->comment;
    }

    public static function create(string $name, string $comment = '', array $columns = [], array $indexes = [], array $foreign_keys = []): Table
    {

        $table = new static();
        $table->name = $name;
        $table->comment = $comment;

        $sql = SB::createTable($table, $columns);

        Schema::addFinallyQuery($sql);

        return $table;
    }

    public static function rename(string $oldName, string $newName)
    {
        $table = new static();
        $table->name = $newName;

        $sql = "RENAME TABLE {$oldName} to {$newName};" . PHP_EOL;

        return [$sql, $table];
    }


//    public function addColumn(
//        string $name,
//        string $type = 'string',
//        bool $nullable = true,
//        $default = null,
//        string $description = null
//    ): Column
//    {
//        $newColumn = new Column($name, $type, $nullable, $default, $description);
//        $this->columns[] = $newColumn;
//
//        return $newColumn;
//    }
//
//    public function updateColumn(
//        string $name,
//        string $type = 'string',
//        bool $nullable = true,
//               $default = null,
//        string $description = null
//    ): Column
//    {
//        $newColumn = new Column($name, $type, $nullable, $default, $description);
//        $this->columns[] = $newColumn;
//
//        return $newColumn;
//    }
//
//    public function renameColumn(string $name, string $newName): Table
//    {
//        return $this;
//    }
//
//    public function deleteColumn(string $name): Table
//    {
//        return $this;
//    }
//
//    /**
//     * @param string[] $columns
//     * @param string $type
//     * @return $this
//     */
//    public function addIndex(array $columns, string $type): Table
//    {
//        $newIndex = new Index($columns, $type);
//
//        return $this;
//    }
}