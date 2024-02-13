<?php

namespace Libs\DBHelper\QueryBuilder;

trait OrderTrait
{
    use HelperTrait;

    private array $orders = [];

    /**
     * Supported formats of $field
     * "field1 asc, field2 desc, ..."
     * ['field1 asc', 'field2 desc', ...]
     *
     * @param $fields
     * @return QueryBuilder
     */
    public function order($fields): QueryBuilder
    {
        if(is_string($fields)){
            $fields = explode(',', $fields);
        }
        $this->orders = [];
        foreach ($fields as $field){
            if($preparedOrder = $this->_prepareOrder($field)){
                $this->orders[] = $preparedOrder;
            }
        }
        return $this;
    }

    public function getOrders(): array
    {
        return $this->orders;
    }

    private function getSqlOrders(): string
    {
        return $this->_queryBuilderOrders();
    }

    private function _queryBuilderOrders(): string
    {
        $sql = '';
        if(!empty($this->orders)){
            $sql .= "ORDER BY\n";
            foreach ($this->orders as $order){
                $sql .= $this->getTab(1) . $order . (next( $this->orders ) ? ',' : '') . "\n";
            }
        }
        return $sql;
    }
}