<?php

namespace Libs\ViewHelper;

use Libs\Routing\Route;

class ViewPlugins
{
    public function route_plugin($params = []): string
    {
        $a=func_get_args();
        Route::route($params['name']??'', $params['params']??[]);
        return 'aaaaaaaaaaaaaaa';
    }
}