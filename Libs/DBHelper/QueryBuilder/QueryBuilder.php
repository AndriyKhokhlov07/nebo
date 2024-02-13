<?php

namespace Libs\DBHelper\QueryBuilder;

use Libs\Collection\Collection;
use Libs\DBHelper\Model;
use Libs\DBHelper\Schema;

class QueryBuilder implements QueryBuilderInterface
{
    use Schema;
    use SelectTrait;
    use FromTrait;
    use ConditionsTrait;
    use JoinTrait;
    use OrderTrait;

    private $model;
    private $queryType = self::QUERY_TYPE_MAIN;

    private int $limit = 0;
    private int $offset = 0;

    /**
     * Array of Expression::class
     * @var array
     */
    private array $conditions = [];

    private array $joined = [];
    private array $related = [];

    public function __construct($model = null)
    {
        $this->model = $model;
        if($model){
            $this->table = $model::getTable();
        }
    }

    public function getQueryType()
    {
        return $this->queryType;
    }

    public function setQueryType(string $queryType)
    {
        $this->queryType = $queryType;
        return $this;
    }

    public function limit(int $limit = 0): QueryBuilder
    {
        $this->limit = $limit;
        return $this;
    }

    public function getLimit(): int
    {
        return $this->limit;
    }

    public function offset(int $offset = 0): QueryBuilder
    {
        $this->offset = $offset;
        return $this;
    }

    public function getOffset(): int
    {
        return $this->offset;
    }

    public function count(): int
    {
        $sql = "SELECT COUNT(*) as `count`\n";
        $sql .= $this->getSqlFrom();
        $sql .= $this->getSqlConditions() . ';';
        return (int)self::getQueryObjects($sql)[0]->count ?? 0;
    }

    public function getSql(): string
    {
        $sql = $this->getSqlSelect();
        $sql .= $this->getSqlFrom();
        $sql .= $this->getSqlConditions();
        $sql .= $this->getSqlOrders();
        if($this->limit > 0){
            $sql .= "LIMIT {$this->limit} OFFSET {$this->offset}\n";
        }

        return $sql;
    }

    public function get(): Collection
    {
        if($this->model){
            $model = $this->model;
        }else{
            Model::setTable($this->getTable());
            $model = new class() extends Model{};
        }
        return $model::get($this);
    }

    public function getFirst(): ?Model
    {
        $model = $this->model;
        $limit = $this->limit;
        $offset = $this->offset;
        $this->limit(1)->offset(0);
        /**
         * @var Collection $collection
         */
        $collection = $model::get($this);
        $this->limit($limit);
        $this->offset($offset);
        return $collection->first();
    }

    public function getConditions(): array
    {
        return $this->conditions;
    }

    public function getJoined(): array
    {
        return $this->joined;
    }

    public function getRelated(): array
    {
        return $this->related;
    }
}