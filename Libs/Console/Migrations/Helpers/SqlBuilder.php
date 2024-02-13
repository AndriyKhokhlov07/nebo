<?php

namespace Libs\Console\Migrations\Helpers;

class SqlBuilder
{
    /**
     * @param Table $table
     * @param Column[] $columns
     */
    public static function createTable(Table $table, array $columns): string
    {
        global $config;

        if(empty($columns)){
            exitConsoleWithError("The creating table `{$table->name()}` must have at least one field");
        }

        $sql = "CREATE TABLE `{$table->name()}` (" . PHP_EOL;
        $columnsSql = self::createColumns($columns);
        $sql .= implode(',' . PHP_EOL, $columnsSql['columns']);
        $tableComment = !empty($table->comment()) ? " COMMENT '{$table->comment()}'" : "";
        $sql .= "){$tableComment} ENGINE=InnoDB DEFAULT CHARSET={$config->db_charset};" . PHP_EOL;


//        $sql .= $firstColumnSql['create_index'] . PHP_EOL;
//        $sql .= $firstColumnSql['update_column'] . PHP_EOL;
    }

    /**
     * @param Table $table
     * @param Column[] $columns
     * @return string[]
     */
    private static function createColumns(Table $table, array $columns): array
    {
        $columnsSql = [];
        $indexesSql = [];

        foreach ($columns as $column){
            $sql = "`{$column->name}` {$column->type}";
            $sql .= $column->attributes['nullable'] ? " NULL" : " NOT NULL";
            $sql .= !empty($column->attributes['default']) ? " DEFAULT '{$column->attributes['default']}'" : "";
            $sql .= ($column->attributes['auto_increment'] && $column->attributes['primary_key']) ? " AUTO_INCREMENT" : "";
            if($column->attributes['first']){
                $sql .= " FIRST";
            }elseif (!empty($column->attributes['after'])){
                $sql .= " AFTER '{$column->attributes['after']}'";
            }
            $sql .= !empty($column->attributes['comment']) ? " COMMENT '{$column->attributes['comment']}'" : "";

            if(
                $column->attributes['primary_key']
                || $column->attributes['auto_increment']
            ){
                if($column->attributes['primary_key']){
                    $sql .= "," . PHP_EOL . "CONSTRAINT {$table->name()}_pk" . PHP_EOL . "PRIMARY KEY (`{$column->name}`)";
                }
            }

            if($column->attributes['index']){

            }
            if($column->attributes['unique']){

            }
        }

        return [
            'columns' => $columnsSql,
            'indexes' => $indexesSql
        ];
    }

    /**
     * @param Table $table
     * @param Column $column
     */
    public static function addColumnIntoExistTable(Table $table, Column $column)
    {

    }

}