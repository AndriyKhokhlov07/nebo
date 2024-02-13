<?php

namespace Libs\Routing;

class RouteAdditional
{
    /**
     * @var RouteEntity $route
     */
    private RouteEntity $route;

    public function __construct(RouteEntity $route)
    {
        $this->route = $route;
    }

    public function name(string $name): RouteAdditional
    {
        $this->route->setName($name);

        return $this;
    }

    public function where(array $constraints = []): RouteAdditional
    {
        $this->route->addConstraints($constraints);

        return $this;
    }
}