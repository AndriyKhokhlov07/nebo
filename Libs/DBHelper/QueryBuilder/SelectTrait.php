<?php

namespace Libs\DBHelper\QueryBuilder;

trait SelectTrait
{
    use HelperTrait;

    private $select = ['*'];

    public function select($fields)
    {
        $this->select = [];

        $this->addSelect($fields);

        return $this;
    }

    public function addSelect($fields)
    {
        if(is_string($fields)){
            $fields = explode(',', $fields);
        }
        foreach ($fields as $field){
            $this->_addField($field);
        }

        return $this;
    }

    private function _addField(string $field)
    {
        $field = $this->_prepareFieldName($field);
        $this->select = array_diff($this->select, [$field]);
        $this->select[] = $field;
    }

    private function getSqlSelect(): string
    {
        return $this->_queryBuilderSelect();
    }

    private function _queryBuilderSelect(): string
    {
        $query = "SELECT *";
        if(count($this->select) > 1){
            $this->select = array_diff($this->select, ['*']);
        }
        if(!empty($this->select)){
            $query = "SELECT\n";
            $fields = [];
            foreach ($this->select as $field){
                if(trim($field) === '*'){
                    return "SELECT *\n";
                }else{
                    $fields[] = '    ' . trim($field);
                }
            }
            $query .= implode(",\n", $fields);
        }
        return $query . "\n";
    }
}