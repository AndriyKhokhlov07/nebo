<?php

namespace Libs\DBHelper;

use Exception;
use Libs\Collection\Collection;
use Libs\DBHelper\QueryBuilder\QueryBuilder;

abstract class Model implements ModelInterface
{
    use Schema;

    /**
     * Database Connection
     */
    protected $connection = null;

    /**
     * Table name
     */
    protected static string $table = '';

    /**
     * Table Fields
     * @var array
     */
    private array $fields = [];

    private array $original = [];
    private array $attributes = [];

    private array $cachedValues = [];

    protected array $fillable = ['*'];
    protected array $guarded = [];

    protected array $visible = ['*'];
    protected array $hidden = [];

    protected array $joined = [];
    protected array $related = [];

    protected array $casts = [];
    protected string $dateFormat = 'Y-m-d';
    protected string $dateTimeFormat = 'Y-m-d H:i:s';

    private bool $existing = false;

    public static array $orders = [];
    public static int $offset = 0;
    public static int $limit = 15;

    /**
     * @param array $attributes
     */
    public function __construct(array $attributes = [])
    {
        $this->connection = self::getConnection();
        $tables = self::getSchema()['tables'];
        if(empty($tables[$this->getTable()])){
            self::refreshSchema();
        }
        $this->fields = $tables[$this->getTable()] ?? [];

        if(!empty($attributes)){
            $this->fill($attributes);
        }
    }

    public static function create(array $attributes = []): ?Model
    {
        $model = new static($attributes);

        return $model->save();
    }

    public static function update(array $conditions = [], array $attributes = []): array
    {
        $list = self::getList(['*'], $conditions, [], 0);

        if(empty($list)){
            return [];
        }

        $updatedList = [];
        foreach ($list as $model){
            $model->save($attributes);
            $updatedList[] = $model;
        }

        return $updatedList;
    }

    public function delete(): bool
    {
        $query = (new static())->queryBuilderDelete(["`id` = " . $this->getAttribute('id')]);

        $db = self::getConnection();
        if(!$db->query($query)){
            return false;
        }

        return true;
    }

    public static function deleteList(array $conditions = []): array
    {
        $fieldName = (new static())->getPrimaryKeyFieldName();
        $list = self::getList([$fieldName], $conditions, [], 0);

        if(empty($list)){
            return [];
        }

        $deletedList = [];
        foreach ($list as $model){
            $deletedList[$model->getAttribute($fieldName)] = $model->delete();
        }
        return $deletedList;
    }

    public function isExisting(): bool
    {
        return $this->existing;
    }

    public static function find($pk): ?self
    {
        $fieldName = (new static())->getPrimaryKeyFieldName();
        $type = (new static())->getPrimaryKeyType();

        if(preg_match('/^varchar/', $type)){
            $pk = (string)$pk;
        }else{
            switch ($type){
                case 'int':
                    $pk = (int)$pk;
                    break;
            }
        }

        return static::queryBuilder()->where($fieldName, '=', $pk)->getFirst();
    }

    public static function queryBuilder(): QueryBuilder
    {
        return new QueryBuilder(static::class);
    }

    public static function get(?QueryBuilder $queryBuilder = null): Collection
    {
        if(empty($queryBuilder)){
            return self::queryBuilder()->get();
        }

        $result = self::getCollection($queryBuilder);

        return $result;
    }

    /**
     * @deprecated
     */
    public static function getList(?array $select = ['*'], ?array $conditions = [], ?array $orders = [], ?int $limit = null, int $offset = null): array
    {
        $select = (empty($select)) ? ['*'] : $select;
        $conditions = (empty($conditions)) ? [] : $conditions;

        $offset = ($offset === null) ? self::$offset : $offset;
        $limit = ($limit === null) ? self::$limit : $limit;
        $orders = (empty($orders)) ? self::$orders : $orders;

        $query = (new static())->queryBuilderGetList($select, $conditions, $orders, $limit, $offset);
        $list = self::getQueryAssocs($query);

        $result = [];
        if(!empty($list)){
            foreach ($list as $item){
                $model = new static();
                $model->existing = true;
                $model::$orders = $orders;
                $model::$limit = $limit;
                $attributes = [];
                foreach ($item as $key => $value){
                    $attributes[$key] = $model->_getCastValue($key, $value);
                }
                $model->original = $attributes;
                $model->attributes = $attributes;
                $result[] = $model;
            }
        }

        return $result;
    }

    public static function getFirst(?array $select = ['*'], array $conditions = []): ?self
    {
        $list = self::getList($select, $conditions, [], 1, 0);

        return !empty($list) ? $list[0] : null;
    }

    public static function setTable(string $table)
    {
        static::$table = $table;
    }

    public static function getTable(): string
    {
        $config = self::getConfig();

        if(static::$table) {
            if(preg_match('/^__/', static::$table)){
                return preg_replace('/^__/', $config->db_prefix, static::$table);
            }
            return static::$table;
        }else{
            $parts = explode('\\', static::class);
            return $config->db_prefix . strtolower($parts[count($parts) - 1] . 's');
        }
    }

    public function getOriginal(?string $key = null, $default = null)
    {
        return $this->original[$key] ?? $default;
    }

    public function getAttribute(?string $key = null, $default = null)
    {
        return $this->attributes[$key] ?? $default;
    }

    public function __set($name, $value)
    {
        if($this->hasField($name)){
            $this->attributes[$name] = $value;
        }else{
            $this->{$name} = $value;
        }
    }

    public function __get($name)
    {
        if(isset($this->attributes[$name])) {
            return $this->attributes[$name];
        }elseif (isset($this->cachedValues[$name])){
            return $this->cachedValues[$name];
        }elseif (method_exists($this, $name)){
            $this->cachedValues[$name] = $this->{$name}();
            return $this->cachedValues[$name];
        }else{
            return null;
        }
    }

    public function toArray(): array
    {
        $result = $this->attributes;
//        if(count($this->joined)){
//
//        }
//        if(count($this->related)){
//
//        }
        return $result;
    }

    public function toObject(): object
    {
        return (object)$this->toArray();
    }

    public function getChanges(): array
    {
        return [];
    }

    public function save(array $attributes = []): ?Model
    {
        if(!empty($attributes)){
            $this->fill($attributes);
        }

        if(!$this->existing){
            $query = $this->queryBuilderCreate();
        }else{
            $pk = $this->getPrimaryKeyValue();
            $query = $this->queryBuilderUpdate([$this->getPrimaryKeyFieldName() . ' = ' . $pk]);
        }

        $db = self::getConnection();
        try{
            if(!$db->query($query)){
                return null;
            }
        }catch (Exception $exception){
            $a=$exception;
        }

        if(!$this->existing) {
            $pk = $db->insert_id;
        }

        if($model = self::find($pk)){
            $model->existing = true;
        }

        return $model;
    }

    public function fill(array $attributes = [])
    {
        foreach ($attributes as $key => $value) {
            if($this->isGuarded($key)){
                continue;
            }
            if ($this->isFillable($key)) {
                $this->setAttribute($key, $value);
            }
        }

        return $this;
    }

    public function isGuarded(string $key): bool
    {
        return in_array($key, $this->guarded);
    }

    public function isFillable(string $key): bool
    {
        if(
            $this->hasField($key)
            && !$this->isGuarded($key)
            && (
                in_array($key, $this->fillable)
                || $this->fillable = ['*']
            )
        ){
            return true;
        }

        return false;
    }

    public function hasAttribute(string $key):bool
    {
        return $this->hasField($key) and isset($this->attributes[$key]);
    }

    public function hasField(string $key):bool
    {
        return isset($this->fields[$key]);
    }

    public function getPrimaryKeyFieldName()
    {
        foreach ($this->fields as $field){
            if($field['key'] === 'pri'){
                return $field['field'];
            }
        }

        return null;
    }

    public function getPrimaryKeyType()
    {
        return $this->fields[$this->getPrimaryKeyFieldName()]['type'];
    }

    public function getPrimaryKeyValue()
    {
        $PrimaryKeyFieldName = $this->getPrimaryKeyFieldName();

        return $this->getAttribute($PrimaryKeyFieldName);
    }

    public function setAttribute(string $key, $value): self
    {
        $this->attributes[$key] = $value;

        return $this;
    }

    private static function getCollection(QueryBuilder $queryBuilder): Collection
    {
        $list = self::getQueryAssocs($queryBuilder);

        $result = [];
        foreach ($list as $item){
            $model = new static();
            $model->existing = true;
            $model::$orders = $queryBuilder ? $queryBuilder->getOrders() : static::$orders;
            $model::$limit = $queryBuilder ? $queryBuilder->getLimit() : static::$limit;
            $attributes = [];
            foreach ($item as $key => $value){
                $attributes[$key] = $model->_getCastValue($key, $value);
            }
            $model->original = $attributes;
            $model->attributes = $attributes;

            $result[] =  $model;
        }

        $resultCollection =  new Collection($result);

        /**
         * @var QueryBuilder $join
         */
        foreach ($queryBuilder->getJoined() as $join){
            $relationValues = $resultCollection->column($join->getLocalField())->unique()->toArray();
            $join->setRelationValues($relationValues);
            $joinCollection = $join->get()->setColumnAsKey($join->getRelationField());

            foreach ($resultCollection->getItems() as $item){
//                $item->joined[]
                $a=1;
            }

            $a=1;
        }


        return $resultCollection;
    }
    private function queryBuilderGetList(array $select = ['*'], array $conditions = [], array $orders = [], int $limit = 15, int $offset = 0): string
    {
        $query = $this->_queryBuilderSelect($select)
            . "FROM `{$this->getTable()}`\n"
            . (!empty($conditions) ? $this->_queryBuilderConditions($conditions) . "\n" : "")
            . (!empty($orders) ? $this->_queryBuilderOrders($orders) . "\n" : "")
            . ($limit > 0 ? "LIMIT $limit OFFSET $offset" : "")
            . ";\n";

        return $query;
    }
    private function queryBuilderCreate(): string
    {
        $query = "INSERT INTO `{$this->getTable()}`\n"
            . "    " . $this->_queryBuilderInsertFields($this->attributes) . "\n"
            . "VALUES\n"
            . "    " . $this->_queryBuilderInsertValues($this->attributes)
            . ";\n";

        return $query;
    }

    private function queryBuilderUpdate(array $conditions = []): string
    {
        $query = "UPDATE `{$this->getTable()}`\n"
            . $this->_queryBuilderSetsForUpdate($this->attributes) . "\n"
            . $this->_queryBuilderConditions($conditions)
            . ";\n";

        return $query;
    }
    private function queryBuilderDelete(array $conditions = []): string
    {
        $query = "DELETE FROM `{$this->getTable()}`"
            . $this->_queryBuilderConditions($conditions)
            . ";\n";

        return $query;
    }
    private function _queryBuilderSelect(array $select = ['*']): string
    {
        $query = '';
        if(!empty($select)){
            $query .= "SELECT\n";
            $fields = [];
            foreach ($select as $field){
                if($field === '*'){
                    return "SELECT *\n";
                    break;
                }else{
                    $fields[] = "    `$field`";
                }
            }
            $query .= implode(",\n", $fields) . "\n";
        }
        return $query;
    }

    private function _queryBuilderInsertFields(array $attributes = []): string
    {
        $query = '';
        if(!empty($attributes)){
            $fields = [];
            foreach ($attributes as $key => $value){
                $fields[] = "`$key`";
            }
            $query .= "(" . implode(', ', $fields) . ")";
        }
        return $query;
    }
    private function _queryBuilderInsertValues(array $attributes = []): string
    {
        $query = '';
        if(!empty($attributes)){
            $parts = [];
            foreach ($attributes as $key => $value){
                $parts[] = $this->_prepareParam($this->fields[$key], $value);
            }
            $query .= "(" . implode(', ', $parts) . ")";
        }
        return $query;
    }
    private function _queryBuilderSetsForUpdate(array $attributes = []): string
    {
        $query = '';
        if(!empty($attributes)){
            $parts = [];
            foreach ($attributes as $key => $value){
                $parts[] = "    $key = " . $this->_prepareParam($this->fields[$key], $value);
            }
            $query = "SET\n" . implode(",\n", $parts);
        }
        return $query;
    }
    /**
     * Formats of $conditions
     * ["string with prepared condition", ...]
     * ['field'=>'value']
     * [['field'=>'value'], ...]
     * [['field', '=', 'value'], ...]
     * [['field', 'is null'], ...]
     * [['field', 'is not null'], ...]
     * [['field', 'in', [value, ...]], ...]
     * [['field', 'in', 'values_string_with_comma_as_separator'], ...]
     * [['field', 'not in', [value, ...]], ...]
     * [['field', 'not in', 'values_string_with_comma_as_separator'], ...]
     * [['field', 'like', '%value%'], ...]
     */
    private function _queryBuilderConditions($conditions): string
    {
        $query = '';
        if(!empty($conditions)){
            $parts = [];
            foreach ($conditions as $key => $condition){
                if(in_array(strtoupper(trim($key)), [self::CONDITION_LOGIC_AND, self::CONDITION_LOGIC_OR])){
                    $logic = strtoupper(trim($key));
                    $key = null;
                }else{
                    $logic = self::CONDITION_LOGIC_AND;
                }
                $parts[] = "    $logic " . $this->_getCondition($condition, $key);
            }
            $query .= "WHERE 1\n" . implode("\n", $parts);
        }
        return $query;
    }
    private function _getCondition($condition, $key = null)
    {
        if(!empty($key) && !is_int($key) && !is_array($condition)){
            $condition = is_string($condition) ? '"' . $condition . '"' : $condition;
            return '`' . trim($key) . '`=' . $condition;
        }elseif(is_string($condition)){
            return trim($condition);
        }elseif(is_array($condition) && !empty($condition)){
            if(count($condition) === 1){
                $key = array_key_first($condition);
                $cond2 = is_string($condition[$key]) ? '"' . $condition[$key] . '"' : $condition[$key];
                return '`' . $key . '`=' . $cond2;
            }
            $field = '`' . trim($condition[0]) . '`';
            if(count($condition) === 2 && !empty($condition[1])){
                return $field . '=' . trim($condition[1]);
            }
            if(!empty($condition[1]) && is_string($condition[1])){
                $cond1 = trim(strtoupper($condition[1]));

                $cond2 = trim($condition[2]) ?? '';
                $cond2 = is_string($cond2) ? '"' . $cond2 . '"' : $cond2;
                switch ($cond1){
                    case '<':
                    case '<=':
                    case '=':
                    case '>=':
                    case '>':
                        $result = $field . $cond1 . $cond2;
                        break;
                    case 'IN':
                    case 'NOT IN':
                        if(is_array($cond2)){
                            $cond2 = implode(',', $cond2);
                        }else{
                            $cond2 = trim($cond2, "\"()");
                        }
                        $result = $field . ' ' . $cond1 . ' (' . $cond2 . ')';
                        break;
                    case 'IS NULL':
                    case 'IS NOT NULL':
                        $result = $field . ' ' . $cond1;
                        break;
                    case 'LIKE':
                        $result = $field . ' ' . $cond1 . ' ' . $cond2;
                        break;
                    default:
                        break;
                }
                return $result;
            }

        }
    }
    private function _queryBuilderOrders(array $orders = []): string
    {
        $query = '';
        if(!empty($orders)){
            $parts = [];
            foreach ($orders as $order){
                $parts[] = "    `$order`";
            }
            $query .= "ORDER BY\n" . implode("\n", $parts);
        }
        return $query;
    }
    private function _prepareParam(array $field, $value)
    {
        $type = $field['type'];
        $isNullable = $field['null'] === 'yes';

        if($value !== 0 && empty($value) && $isNullable){
            return 'NULL';
        }else{
            switch (strtolower($type)){
                case 'int':
                case 'bigint':
                    return (int)$value;
                case 'json':
                    if(is_array($value) || is_object($value)){
                        return "'" . mysqli_real_escape_string(self::getConnection(), json_encode($value)) . "'";
                    }else{
                        return "'" . mysqli_real_escape_string(self::getConnection(), $value) . "'";
                    }
                case 'text':
                    if(is_array($value) || is_object($value)){
                        return "'" . mysqli_real_escape_string(self::getConnection(), serialize($value)) . "'";
                    }else{
                        return "'" . mysqli_real_escape_string(self::getConnection(), $value) . "'";
                    }
                case 'date':
                case 'datetime':
                case 'timestamp':
                    return "'$value'";
                default:
                    if(preg_match('/^varchar/', $type)){
                        return "'" . mysqli_real_escape_string(self::getConnection(), $value) . "'";
                    }
            }
        }

        return $value;
    }

    private function _getCastValue(string $key, $value)
    {
        $type = strtolower($this->fields[$key]['type']);

        if($value === null){
            return null;
        }

        if(empty($this->casts[$key])){
            if(preg_match('/^varchar/', $type)){
                return (string)$value;
            }
            switch ($type){
                case 'int':
                    return (int)$value;
            }
        }

        switch (strtolower($this->casts[$key])){
            case 'bool':
            case 'boolean':
                if(is_string($value)){
                    return trim($value) === 'true';
                }else{
                    return (bool)$value;
                }
            case 'int':
            case 'integer':
                return (int)$value;
            case 'money':
                return number_format($value, 2, '.', ' ');
            case 'date':
                return date_create_from_format('Y-m-d', $value)->format(trim($this->dateFormat));
            case 'datetime':
                return date_create_from_format('Y-m-d H:i:s', $value)->format(trim($this->dateTimeFormat));
            case 'array':
                if($type === 'json'){
                    return json_decode($value, true);
                }
                return unserialize($value);
            case 'object':
                if($type === 'json'){
                    return json_decode($value, false);
                }
                return (object)unserialize($value);
            default:
                return $value;
        }
    }
}