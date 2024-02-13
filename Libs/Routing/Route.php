<?php

namespace Libs\Routing;

use Libs\Collection\Collection;
use Models\Log;
use IndexView;

class Route
{
    const ROUTES_CONFIG_PATH = ROOT_PATH . '/config/routes.php';
    const COMPILED_ROUTES_PATH = ROOT_PATH . '/compiled/routes.json';
    /** Request Methods */
    const METHOD_GET    = 'GET';
    const METHOD_POST   = 'POST';
    const METHOD_PUT    = 'PUT';
    const METHOD_PATCH  = 'PATCH';
    const METHOD_DELETE = 'DELETE';
    const SUPPORTED_METHODS = [
        self::METHOD_GET,
        self::METHOD_POST,
        self::METHOD_PUT,
        self::METHOD_PATCH,
        self::METHOD_DELETE
    ];

    private static Collection $routesCollection;

    public string $requestMethod;
    public string $requestUri;
    public array $requestParams = [];
    public ?RouteEntity $requestRoute;

    final private function __construct()
    {
        $this->initRoutes();

//        $this->additional = new RouteAdditional($this);
//        $this->action = Arr::except($this->parseAction($action), ['prefix']);

//        if (in_array('GET', $this->methods) && ! in_array('HEAD', $this->methods)) {
//            $this->methods[] = 'HEAD';
//        }
//
//        $this->prefix(is_array($action) ? Arr::get($action, 'prefix') : '');
    }

    public static function run()
    {
        $instance = new static();

        $instance->requestMethod = strtoupper($_SERVER['REQUEST_METHOD']);
        $instance->requestUri = ltrim($_SERVER['REQUEST_URI'], '/');
        $instance->requestParams = [
            'params'    => array_merge($_GET, $_REQUEST),
            'get'       => $_GET,
            'request'   => $_REQUEST,
        ];

        $routes = self::$routesCollection->groupByColumn('methods')->get($instance->requestMethod);

        if($routes instanceof Collection){
            foreach ($routes->getItems() as $route){
                if($instance->compareUri($route)){
                    $instance->requestRoute = $route;
                    break;
                }
            }
        }

        Log::create([
            'patent_id' => 0,
            'type' => 100,
            'subtype' => 100,
            'user_id' => 0,
            'sender' => 'route-test',
            'sender_type' => 5,
            'value' => 'Route::run',
            'data' => $instance->requestRoute ?? null,
        ]);
        if(!empty($instance->requestRoute)){
            return $instance->runRouteAction($instance->requestRoute);
        }else{
            header("http/1.0 404 not found");
            $_GET['page_url'] = '404';
            $_GET['module'] = 'PageView';
            print (new IndexView())->fetch();
        }
    }

    private function initRoutes()
    {
        self::$routesCollection = new Collection();
        $compiledRoutePath = realpath(self::COMPILED_ROUTES_PATH);
        $configRoutePath = realpath(self::ROUTES_CONFIG_PATH);

        if(
            !$compiledRoutePath
            || filemtime($configRoutePath) > filemtime($compiledRoutePath)
        ){
            require_once($configRoutePath);
            $json = json_encode(self::$routesCollection->toArray());
            $fp = fopen(self::COMPILED_ROUTES_PATH, 'w');
            fwrite($fp, $json);
            fclose($fp);
        }
        $routes = json_decode(file_get_contents($compiledRoutePath), false);
        foreach ($routes as $route){
            self::$routesCollection->push(RouteEntity::getInstanceFromConfig($route));
        }
    }

    private function runRouteAction(RouteEntity $route)
    {
        Log::create([
            'patent_id' => 0,
            'type' => 100,
            'subtype' => 100,
            'user_id' => 0,
            'sender' => 'route-test',
            'sender_type' => 5,
            'value' => 'Route::runRouteAction',
            'data' => $route,
        ]);

        $action = $route->getCallable();
        $result = null;

        if(is_array($action)){
            $className = $action[0];
            $methodName = $action[1];
            $instanceClass = new $className();
            $result = call_user_func_array([$instanceClass, $methodName], $this->requestParams['uri']);
        }elseif (
            is_object($action)
            && get_class($action) === 'Callable'
        ){
            $a=1;
        }

        return $result;
    }

    public static function get(string $uri, $callable): RouteAdditional
    {
        $route = new RouteEntity(self::METHOD_GET, $uri, $callable);
        self::$routesCollection->push($route);

        return new RouteAdditional($route);
    }

    public static function post(string $uri, $callable): RouteAdditional
    {
        $route = new RouteEntity(self::METHOD_POST, $uri, $callable);
        self::$routesCollection->push($route);

        return new RouteAdditional($route);
    }

    public static function put(string $uri, $callable): RouteAdditional
    {
        $route = new RouteEntity(self::METHOD_PUT, $uri, $callable);
        self::$routesCollection->push($route);

        return new RouteAdditional($route);
    }

    public static function patch(string $uri, $callable): RouteAdditional
    {
        $route = new RouteEntity(self::METHOD_PATCH, $uri, $callable);
        self::$routesCollection->push($route);

        return new RouteAdditional($route);
    }

    public static function delete(string $uri, $callable): RouteAdditional
    {
        $route = new RouteEntity(self::METHOD_DELETE, $uri, $callable);
        self::$routesCollection->push($route);

        return new RouteAdditional($route);
    }

//    public static function match(array $methods, string $uri, $callable): RouteAdditional
//    {
//        $route = new RouteEntity($methods, $uri, $callable);
//        self::$routesCollection->push($route);
//
//        return new RouteAdditional($route);
//    }

//    public static function any(string $uri, $callable): RouteAdditional
//    {
//        $route = new RouteEntity(null, $uri, $callable);
//        self::$routesCollection->push($route);
//
//        return new RouteAdditional($route);
//    }

//    public static function redirect(string $uri, string $destination, int $status = 302)
//    {
//        $a=1;
//    }

    public static function route(string $name, array $params = []): ?string
    {
        $instance = new static();

        /**
         * @var RouteEntity $route
         */
        if(!($route = $instance::$routesCollection->setColumnAsKey('name')->get($name))){
            return null;
        }
        $uriParts = $route->getUri();
        foreach ($uriParts as &$uriPart){
            if(preg_match('/^\{.*\}$/', $uriPart)){
                $paramName = preg_replace('/^\{(.*)\}$/', '$1', $uriPart);
                if(isset($params[$paramName])){
                    if($pattern = $route->getUriParam($paramName)['constraint'] ?? null){
                        $uriPart = preg_match($pattern, $params[$paramName]) ? (string)$params[$paramName] : $uriPart;
                    }else{
                        $uriPart = (string)$params[$paramName];
                    }
                }
            }
        }

        $protocol = empty($_SERVER['HTTPS']) ? 'http' : 'https';
        $domain = $_SERVER['SERVER_NAME'];
        return $protocol . '://' . $domain . '/' . implode('/', $uriParts);
    }

    private function compareUri(RouteEntity $route): bool
    {
        if(!in_array($this->requestMethod, $route->getMethods())){
            return false;
        }

        $partsRequestUri = explode('/', $this->requestUri);
        $partsRouteUri = $route->getUri();
        if(count($partsRequestUri) !== count($partsRouteUri)){
            return false;
        }

        $uriParams = [];
        for ($i=0; $i < count($partsRouteUri); $i++){
            /** Is URI parameter */
            if(preg_match('/^\{.*\}$/', $partsRouteUri[$i])){
                $paramName = preg_replace('/^\{(.*)\}$/', '$1', $partsRouteUri[$i]);
                if(
                    $routeParam = $route->getUriParam($paramName)
                ){
                    if(
                        empty($routeParam['constraint'])
                        || preg_match($routeParam['constraint'], $partsRequestUri[$i])
                    ){
                        $uriParams[$paramName] = $partsRequestUri[$i];
                    }else{
                        return false;
                    }
                }
            }elseif (strtolower($partsRouteUri[$i]) !== strtolower($partsRequestUri[$i])){
                return false;
            }
        }

        $this->requestParams['uri'] = $uriParams;

        return true;
    }
}