<?php

namespace Libs\DBHelper\QueryBuilder;

trait ConditionsTrait
{
    public function where(string $field = '', string $operator = null, $value = null): QueryBuilder
    {
        return $this->andWhere($field, $operator, $value);
    }

    public function whereRaw(string $expression): QueryBuilder
    {
        return $this->andWhereRaw($expression);
    }

    public function whereGroup($callback): QueryBuilder
    {
        return $this->andWhereGroup($callback);
    }

    public function andWhere(string $field = '', string $operator = null, $value = null): QueryBuilder
    {
        $this->conditions[] = Expression::andWhere($field, $operator, $value);
        return $this;
    }

    public function andWhereRaw(string $expression): QueryBuilder
    {
        $this->conditions[] = Expression::andWhereRaw($expression);
        return $this;
    }

    public function andWhereGroup($callback): QueryBuilder
    {
        $query = new QueryBuilder();
        $callback($query);
        $this->conditions[] = Expression::andWhere($query);
        return $this;
    }

    public function orWhere(string $field = '', string $operator = null, $value = null): QueryBuilder
    {
        $this->conditions[] = Expression::orWhere($field, $operator, $value);
        return $this;
    }

    public function orWhereRaw(string $expression): QueryBuilder
    {
        $this->conditions[] = Expression::orWhereRaw($expression);
        return $this;
    }

    public function orWhereGroup($callback): QueryBuilder
    {
        $query = new QueryBuilder();
        $callback($query);
        $this->conditions[] = Expression::orWhere($query);
        return $this;
    }

    private function getSqlConditions(): string
    {
        return $this->_queryBuilderConditions();
    }

    private function _queryBuilderConditions(int $subIndex = 1): string
    {
        $sql = '';
        if(!empty($this->conditions)){
            $sql .= 'WHERE 1' . "\n";
//            if($this->getJoined() instanceof Expression){
//                $sql .= $this->getJoined()->getSqlExpression($subIndex);
//            }
            foreach ($this->conditions as $expression){
                if($expression instanceof Expression){
                    $sql .= $expression->getSqlExpression($subIndex);
                }
            }
        }
        return $sql;
    }
}