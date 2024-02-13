<?php

namespace Libs\Routing;

trait ConstraintsTrait
{
    public function where(array $conditions): RouteInterface
    {
        return $this;
    }
}