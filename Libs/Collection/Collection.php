<?php

namespace Libs\Collection;

class Collection extends CollectionAbstract
{
    public function getAsArray($value): array
    {
        if(is_array($value)){
            return $value;
        }elseif (is_string($value)){
            return preg_split('/\s*,\s*/', $value);
        }elseif (is_object($value)){
            return (array)$value;
        }

        return [];
    }

    public function isExpressionTrue($value1, $value2, string $operator = '=')
    {
        switch ($operator){
            case '!=':
                return $value1 != $value2;
            case '<':
                return $value1 < $value2;
            case '<=':
                return $value1 <= $value2;
            case '=':
            case '==':
                return $value1 == $value2;
            case '===':
                return $value1 === $value2;
            case '>=':
                return $value1 >= $value2;
            case '>':
                return $value1 > $value2;
            case 'in':
                return in_array($value1, $this->getAsArray($value2));
            case 'not in':
                return !in_array($value1, $this->getAsArray($value2));
        }
    }

    public function findFirst(string $column, $value = null, string $operator = '=')
    {
        foreach ($this->items as $item){
            $itemValue = (is_object($item) ? ($item->$column ?? null) : is_array($item)) ? ($item[$column] ?? null) : null;
            if($this->isExpressionTrue($itemValue, $value, $operator))
            {
                return $item;
            }
        }

        return null;
    }

    public function map(callable $callback): Collection
    {
        $result = new Collection();

        foreach ($this->items as $item){
            $result->push($callback($item));
        }

        return $result;
    }

    public function column($column, $index = null): ?Collection
    {
        return new Collection(array_column($this->toArray(), $column, $index));
    }

    final public function groupByColumn(string $column): Collection
    {
        $arr = [];
        foreach ($this->items as $item){
            $itemObj = (object)$item->toArray();

            if(!is_array($values = $itemObj->{$column})){
                $values = [$values];
            }
            foreach ($values as $value){
                $arr[$value][] = $item;
            }
        }

        $collection = new Collection();
        foreach ($arr as $key => $value){
            $collection->push(new Collection($value), $key);
        }
        return $collection;
    }


    public function setColumnAsKey($column): ?Collection
    {
        $result = [];
        foreach ($this->getItems() as $item){
            $result[$item->{$column}] = $item;
        }
        return new Collection($result);
    }

    public function unique($column = null): ?Collection
    {
        $indexes = [];
        $unique = [];

        if($column){
            foreach ($this->items as $item) {
                if (!in_array($item[$column], $indexes)) {
                    $indexes[] = $item[$column];
                    $unique[] = $item;
                }
            }
        }else{
            foreach ($this->items as $item) {
                if (!in_array($item, $unique)) {
                    $unique[] = $item;
                }
            }
        }

        return new Collection($unique);
    }
}