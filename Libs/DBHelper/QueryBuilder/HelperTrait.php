<?php

namespace Libs\DBHelper\QueryBuilder;

trait HelperTrait
{
    private function getTab(int $subIndex = 0): string
    {
        return str_repeat(' ', $subIndex * self::TAB_SIZE);
    }

    private function clearString(string $string): string
    {
        $pattern = ["/^[\s\"'`]+/", "/[\s\"'`]+$/"];
        return preg_replace($pattern, '', $string);
    }

    private function _prepareTableName(string $table): string
    {
        return $this->_prepareFieldName($table);
    }

    private function _prepareFieldName(string $field): string
    {
        $pattern = ["/^[\s\"'`]+/", "/[\s\"'`]+$/"];
        $parts = explode(' as ', strtolower($field));
        $preparedParts = [];
        foreach ($parts as $part){
            $preparedParts[] = preg_replace($pattern, '', $part);
        }
        if(preg_match("/->/", $preparedParts[0])){
            $result = $this->_prepareJsonFieldName($preparedParts[0]);
        }else{
            $result = '`' . $preparedParts[0] . '`';
        }

        if(count($preparedParts) > 1){
            $result .= ' AS `' . $preparedParts[1] . '`';
        }

        return $result;
    }

    /**
     * https://www.sitepoint.com/use-json-data-fields-mysql-databases/
     * Json field name with path
     * field_name=>path.selector
     *
     * @param string $field
     * @return string
     */
    private function _prepareJsonFieldName(string $field): string
    {
        if(preg_match("/->/", $field)){
            $parts = explode('->', $field);
            $field = '' . $parts[0] . '->"$' . $parts[1] . '"';
        }
        return $field;
    }

    private function _prepareLogic(string $logic): string
    {
        return strtoupper(trim($logic));
    }

    private function _prepareOperator(string $operator): string
    {
        return strtoupper(trim($operator));
    }

    private function _prepareValueAsArray($value): array
    {
        if(is_string($value)){
            $value = explode(',', $value);
        }

        $pattern = ["/^[\s\"'`]+/", "/[\s\"'`]+$/"];
        $result = [];
        foreach ($value as $item){
            $preparedItem = preg_replace($pattern, '', $item);
            $result[] = is_string($preparedItem) ? '"' . $preparedItem . '"' : $preparedItem;
        }

        return $result;
    }

    private function _prepareOrder(string $value): string
    {
        $value = preg_replace("/\s+/", ' ', trim($value));
        $parts = explode(' ', $value);

        $pattern = ["/^[\s\"'`]+/", "/[\s\"'`]+$/"];
        $field = preg_replace($pattern, '', strtolower($parts[0]));
        $operator = preg_replace($pattern, '', strtoupper($parts[1] ?? ''));
        $operator = in_array($operator, ['ASC', 'DESC']) ? ' ' . $operator : ' ASC';

        return !empty($field) ? '`' . $field . '`' . $operator : '';
    }
}