<?php

namespace Libs\DBHelper\QueryBuilder;

trait FromTrait
{
    use HelperTrait;

    private ?string $table = null;
    private ?string $tableAlias = null;

    public function setTable(string $table)
    {
        [$table, $tableAlias] = preg_split('/ as /i', $table);
        $this->table = $this->clearString(strtolower($table));
        $this->tableAlias = $this->clearString(strtolower($tableAlias));

        return $this;
    }

    public function getTable(): ?string
    {
        return $this->table;
    }

    public function getTableAlias(): string
    {
        return $this->tableAlias ?? $this->table;
    }

    private function getSqlFrom(): string
    {
        return $this->_queryBuilderTable();
    }

    private function _queryBuilderTable(): string
    {
        $table = $this->model::getTable();
        $query = "FROM " . $this->_prepareTableName($table);

        return $query . "\n";
    }
}