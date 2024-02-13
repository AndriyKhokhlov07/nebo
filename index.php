<?PHP

//ini_set('error_reporting', E_ERROR);

$path = __DIR__ . DIRECTORY_SEPARATOR;
$prefix = '';
while(!file_exists($path . $prefix . 'autoloader.php')){
    $prefix .= '..' . DIRECTORY_SEPARATOR;
}
define('ROOT_PATH', realpath($path . $prefix));
require_once (ROOT_PATH . DIRECTORY_SEPARATOR . 'autoloader.php');

use Libs\Routing\Route;

// Засекаем время
$time_start = microtime(true);

session_start();

setlocale(LC_MONETARY, 'en_US');

//require_once('cerber.php');

require_once('view/IndexView.php');

$view = new IndexView();

if(isset($_GET['logout']))
{
    header('WWW-Authenticate: Basic realm="Backend CMS"');
    header('HTTP/1.0 401 Unauthorized');
	unset($_SESSION['admin']);
}

// Если все хорошо
if(($res = $view->fetch()) !== false)
{
    // Выводим результат
    header("Content-type: text/html; charset=UTF-8");
    print $res;

    // Сохраняем последнюю просмотренную страницу в переменной $_SESSION['last_visited_page']
    if(empty($_SESSION['last_visited_page']) || empty($_SESSION['current_page']) || $_SERVER['REQUEST_URI'] !== $_SESSION['current_page'])
    {
        if(!empty($_SESSION['current_page']) && !empty($_SESSION['last_visited_page']) && $_SESSION['last_visited_page'] !== $_SESSION['current_page'])
            $_SESSION['last_visited_page'] = $_SESSION['current_page'];
        $_SESSION['current_page'] = $_SERVER['REQUEST_URI'];
    }
}
else
{

//    if(
//        $_SERVER['REDIRECT_STATUS'] == 404
//        || $_SERVER['REDIRECT_URL'] == '/404'
//    ){
//        // Подменим переменную GET, чтобы вывести страницу 404
//        $_GET['page_url'] = '404';
//        $_GET['module'] = 'Route';
//        $list = headers_list();
////    header_remove();
//        print Route::run();
//    }

    // Иначе страница об ошибке
    header("http/1.0 404 not found");

    // Подменим переменную GET, чтобы вывести страницу 404
    $_GET['page_url'] = '404';
    $_GET['module'] = 'PageView';
    print $view->fetch();
}



// $p=11; $g=2; $x=7; $r = ''; $s = $x;
// $bs = explode(' ', $view->config->license);		
// foreach($bs as $bl){
// 	for($i=0, $m=''; $i<strlen($bl)&&isset($bl[$i+1]); $i+=2){
// 		$a = base_convert($bl[$i], 36, 10)-($i/2+$s)%26;
// 		$b = base_convert($bl[$i+1], 36, 10)-($i/2+$s)%25;
// 		$m .= ($b * (pow($a,$p-$x-1) )) % $p;}
// 	$m = base_convert($m, 10, 16); $s+=$x;
// 	for ($a=0; $a<strlen($m); $a+=2) $r .= @chr(hexdec($m{$a}.$m{($a+1)}));}

// @list($l->domains, $l->expiration, $l->comment) = explode('#', $r, 3);

// $l->domains = explode(',', $l->domains);

// $h = getenv("HTTP_HOST");
// if(substr($h, 0, 4) == 'www.') $h = substr($h, 4);
/*if((!in_array($h, $l->domains) || (strtotime($l->expiration)<time() && $l->expiration!='*')))
{
	print "<div style='text-align:center; font-size:22px; height:100px;'>Лицензия недействительна<br><a href='http://backendcms.ru'>Скрипт интернет-магазина Backend</a></div>";
}*/

// Отладочная информация
if(1)
{
	print "<!--\r\n";
	$time_end = microtime(true);
	$exec_time = $time_end-$time_start;
  
  	if(function_exists('memory_get_peak_usage'))
		print "memory peak usage: ".memory_get_peak_usage()." bytes\r\n";  
	print "page generation time: ".$exec_time." seconds\r\n";
	//print "[".dirname(__FILE__)."]\r\n";
	print " -->";
}
