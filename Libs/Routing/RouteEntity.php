<?php

namespace Libs\Routing;

class RouteEntity
{
    private array $methods = [];
    private array $uri = [];
    private array $uriParams = [];
    private $callable;

    private ?RouteEntity $group;
    public ?string $name = null;

    public function __construct($methods, string $uri, $callable, array $params = [])
    {
        if($methods === null){
            $methods = [];
        }
        $methods = is_array($methods) ? $methods : explode(',', $methods);
        foreach ($methods as $method){
            $method = trim(strtoupper($method));
            if(in_array($method, Route::SUPPORTED_METHODS) && !in_array($method, $this->methods)){
                $this->methods[] = $method;
            }
        }
        $partsUri = explode('/', $uri);
        foreach ($partsUri as $partUri){
            $partUri = trim($partUri);
            if($partUri){
                $this->uri[] = $partUri;
            }
            if(preg_match("/^\{.*\}$/", $partUri)){
                $paramName = preg_replace('/^\{(.*)\}$/', '$1', $partUri);
                $param = [
                    'name'          => $paramName,
                    'type'          => null,
                    'constraint'    => $params[$paramName]->constraint ?? null,
                ];

                $this->uriParams[$param['name']] = $param;
            }
        }
        $this->callable = $callable;
    }

    public static function getInstanceFromConfig(object $route): RouteEntity
    {
        $instance = new static($route->methods, implode('/', $route->uri), $route->callable, (array)$route->uriParams);
        $instance->setName($route->name ?? '');

        return $instance;
    }

    public function getMethods(): array
    {
        return $this->methods;
    }

    public function getUri(): array
    {
        return $this->uri;
    }

    public function getUriParams(): array
    {
        return $this->uriParams;
    }

    private function setCallable($callable)
    {
        if (is_array($callable)) {
            $a=1;
        } elseif (is_string($callable)) {
            $a=1;
        } elseif (gettype($callable) === 'object'){
            $a=1;
        }
    }

    public function getCallable()
    {
        return $this->callable;
    }

    public function setName(?string $name): RouteEntity
    {
        $this->name = $name;
        return $this;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function addConstraints(array $constraints): RouteEntity
    {
        foreach ($constraints as $key => $patten){
            if(isset($this->uriParams[$key])){
                $this->uriParams[$key]['constraint'] = $patten;
            }
        }

        return $this;
    }

    public function getUriParam(string $key): ?array
    {
        return $this->getUriParams()[$key] ?? null;
    }

    public function toArray()
    {
        return [
            'methods'       => $this->getMethods(),
            'uri'           => $this->getUri(),
            'uriParams'     => $this->getUriParams(),
            'callable'      => $this->getCallable(),
            'name'          => $this->getName(),
        ];
    }
}