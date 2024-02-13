<?php

namespace Libs\DBHelper\QueryBuilder;

use Libs\DBHelper\Model;
use MongoDB\Driver\Query;

trait JoinTrait
{
    use HelperTrait;
    use ConditionsTrait;

    private $relationAlias;
    private $relationTable;
    private $relationField;
    private $localTable;
    private $localField;

    public function getRelationAlias()
    {
        return $this->relationAlias;
    }

    public function setRelationAlias($relationAlias): QueryBuilder
    {
        $this->relationAlias = $relationAlias;
        return $this;
    }

    public function getRelationTable()
    {
        return $this->relationTable;
    }

    public function setRelationTable($relationTable): QueryBuilder
    {
        $this->relationTable = $relationTable;
        return $this;
    }

    public function getRelationField()
    {
        return $this->relationField;
    }

    public function setRelationField($relationField): QueryBuilder
    {
        $this->relationField = $relationField;
        return $this;
    }

    public function getLocalTable()
    {
        return $this->localTable;
    }

    public function setLocalTable($localTable): QueryBuilder
    {
        $this->localTable = $localTable;
        return $this;
    }

    public function getLocalField()
    {
        return $this->localField;
    }

    public function setLocalField($localField): QueryBuilder
    {
        $this->localField = $localField;
        return $this;
    }

    public function setRelationValues(array $value): QueryBuilder
    {
        $this->conditions[0]->setValue($this->_prepareValueAsArray($value));
        return $this;
    }

    /**
     * @param Model|string $relationTable
     * @param $localField
     * @param $relationField
     * @param $callback
     * @return void
     */
    public function join($relationTable, $relationField, $localField, $callback = null): QueryBuilder
    {
        [$table, $alias] = preg_split('/ as /i', $relationTable);
        $table = (explode('\\', (string)$table)[0] === 'Models') ? $table::getTable() : $this->_prepareTableName($table);
        $alias = $alias ? $this->_prepareTableName($alias) : null;

        /**
         * QueryBuilder $query
         */
        $join = new QueryBuilder();
        $join
            ->setQueryType(self::QUERY_TYPE_JOIN)
            ->setRelationAlias($alias)
            ->setRelationTable($table)
            ->setRelationField($relationField)
            ->setLocalTable($this->table)
            ->setLocalField($localField);
        $join->conditions[] = Expression::andWhere($relationField, 'in', $localField);

        if($callback){
            $callback($join);
        }

        $this->joined[] = $join;
        return $this;
    }
}