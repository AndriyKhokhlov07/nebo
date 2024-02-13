<?php

namespace Libs\Collection;

abstract class CollectionAbstract implements CollectionInterface
{
    protected string $itemsType;
    protected string $itemsClass;
    protected array $items = [];

    public function __construct($items = [])
    {
        $this->merge($items);
    }

//    public function __get($prop)
//    {
//        return $this->data[$prop];
//    }
//
//    public function __isset($prop) : bool
//    {
//        return isset($this->data[$prop]);
//    }

    public function toArray(): array
    {
        if($this->count() === 0){
            return [];
        }

        if($this->itemsType !== self::TYPE_OBJECT){
            return $this->items;
        }

        $result = [];
        foreach ($this->items as $key => $item){
            $result[$key] = method_exists($item, 'toArray') ? $item->toArray() : (array)$item;
        }
        return $result;
    }

    private function setItemType($item)
    {
        $this->itemsType = gettype($item);
        switch ($this->itemsType){
            case self::TYPE_OBJECT:
                $this->itemsClass = get_class($item);
                break;
            default :
                break;
        }
    }

    private function checkItemType($item): bool
    {
        if(count($this->items)){
            if($this->itemsType !== self::TYPE_OBJECT){
                return $this->itemsType === gettype($item);
            }
            return $item instanceof $this->itemsClass;
        }else{
            $this->setItemType($item);
            return true;
        }
    }

    final public function push($item, $index = null): self
    {
        if($this->checkItemType($item)){
            if($index){
                $this->items[$index] = $item;
            }else{
                $this->items[] = $item;
            }
        }

        return $this;
    }

    final public function merge($items): CollectionInterface
    {
        foreach ($items as $key => $item){
            if($this->checkItemType($item)){
                $this->items[$key] = $item;
            }
        }

        return $this;
    }

    final public function count(): int
    {
        return count($this->items);
    }

    public function each(callable $callback)
    {
        foreach ($this->items as $key => $item) {
            if ($callback($item, $key) === false) {
                break;
            }
        }

        return $this;
    }

    public function getItems(): array
    {
        return $this->items;
    }

    public function get($index)
    {
        return $this->items[$index] ?? null;
    }

    public function first()
    {
        return $this->count() ? $this->get(array_key_first($this->items)) : null;
    }

    public function last()
    {
        return $this->count() ? $this->get(array_key_last($this->items)) : null;
    }

    public function remove($index): CollectionInterface
    {
        unset($this->items[$index]);

        return $this;
    }
}