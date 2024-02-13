<?php

namespace Libs\DBHelper\QueryBuilder;

class Expression implements QueryBuilderInterface
{
    use HelperTrait;

    private $logic = null;
    private $field = null;
    private $operator = null;
    private $value = null;

    private $subExpressions = [];

    public function __construct(string $logic)
    {
        $this->logic = $this->_prepareLogic($logic);
    }

    private function _instance(...$conditions): Expression
    {
        $conditions = func_get_args()[0];

        if(is_string($conditions[0])) {
            $this->_instanceWithCondition($conditions[0], $conditions[1] ?? null, $conditions[2] ?? null);
        }else{
            foreach ($conditions as $condition){
                if ($condition instanceof QueryBuilder) {
                    $this->_instanceWithSubExpressions($condition->getConditions());
                }
            }
        }

        return $this;
    }

    private function _instanceWithCondition(string $field = '', string $operator = null, $value = null): Expression
    {
        $this->field = $this->_prepareFieldName($field);
        $this->operator = $operator ? $this->_prepareOperator($operator) : $operator;
        $this->value = $value;

        return $this;
    }

    private function _instanceWithSubExpressions(array $expressions = []): Expression
    {
        foreach ($expressions as $expression){
            $this->subExpressions[] = $expression;
        }

        return $this;
    }

    public function getValue()
    {
        return $this->value;
    }

    public function setValue($value)
    {
        $this->value = $value;
        return $this;
    }

    public static function andWhere(...$conditions): Expression
    {
        return (new static(QueryBuilder::CONDITION_LOGIC_AND))->_instance($conditions);
    }

    public static function andWhereRaw(...$conditions): Expression
    {
        return (new static(QueryBuilder::CONDITION_LOGIC_AND))->_instance($conditions);
    }

    public static function orWhere(...$conditions): Expression
    {
        return (new static(QueryBuilder::CONDITION_LOGIC_OR))->_instance($conditions);
    }

    public static function orWhereRaw(...$conditions): Expression
    {
        return (new static(QueryBuilder::CONDITION_LOGIC_OR))->_instance($conditions);
    }

    public function getSqlExpression(int $subIndex = 1): string
    {
        return $this->_buildSqlExpression($subIndex);
    }

    private function _buildSqlExpression(int $subIndex = 1): string
    {
        $sql = $this->getTab($subIndex) . $this->logic;
        if(!empty($this->field)){
            $sql .= ' ' . $this->field;
            switch ($this->operator){
                case '<':
                case '<=':
                case '!=':
                case '=':
                case '>=':
                case '>':
                    $sql .=  ' ' . $this->operator . ' ' . (is_string($this->value) ? '"' . $this->value . '"' : $this->value) . "\n";
                    break;
                case self::CONDITION_OPERATOR_LIKE:
                case self::CONDITION_OPERATOR_ILIKE:
                    $sql .= ' ' . $this->operator . ' "' . $this->value . '"' . "\n";
                    break;
                case self::CONDITION_OPERATOR_IN:
                case self::CONDITION_OPERATOR_NOT_IN:
                    $preparedValue = $this->_prepareValueAsArray($this->value);
                    $sql .= ' ' . $this->operator . ' (' . implode(', ', $preparedValue) . ')' . "\n";
                break;
                case self::CONDITION_OPERATOR_IS_NULL:
                case self::CONDITION_OPERATOR_IS_NOT_NULL:
                    $sql .= ' ' . $this->operator . "\n";
                    break;
                case null:
                    $sql .= "\n";
                    break;
            }
        }elseif(!empty($this->subExpressions)){
            $sql .= " ( 1\n";
            foreach($this->subExpressions as $subExpression){
                /**
                 * @var Expression $subExpression
                 */
                $sql .= $subExpression->getSqlExpression($subIndex + 1);
            }
            $sql .= $this->getTab($subIndex) . ")\n";
        }

        return $sql;
    }
}