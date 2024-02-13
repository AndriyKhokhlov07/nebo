<?PHP

//ini_set('error_reporting', E_ALL);
 ini_set('error_reporting', 0);
chdir('..');

// Засекаем время
$time_start = microtime(true);
session_start();

$path = __DIR__ . DIRECTORY_SEPARATOR;
$prefix = '';
while(!file_exists($path . $prefix . 'autoloader.php')){
    $prefix .= '..' . DIRECTORY_SEPARATOR;
}
define('ROOT_PATH', realpath($path . $prefix));
require_once (ROOT_PATH . DIRECTORY_SEPARATOR . 'autoloader.php');

if(isset($_GET['logout']))
{
	unset($_SESSION['admin']);
	unset($_SESSION['logout']);
	
    header('WWW-Authenticate: Basic realm="NeBo"');
    header('HTTP/1.0 401 Unauthorized');
	// unset($_SESSION['admin']);
	// header('Location: '.$backend->config->root_url.'/backend/');


	// if(isset($_SESSION['admin'])) 
	// 	unset($_SESSION['admin']);
	// // if(isset($_SESSION['logout'])) 
	
	// 	unset($_SESSION['id']);
	// $_SESSION['admin'] = null;
	
	//exit;
	header('Location: '.$backend->config->root_url.'/backend/');
	die;
}

$_SESSION['admin'] = 'admin';
$_SESSION['id'] = session_id();

@ini_set('session.gc_maxlifetime', 86400); // 86400 = 24 часа
@ini_set('session.cookie_lifetime', 0); // 0 - пока браузер не закрыт

require_once('backend/IndexAdmin.php');

// Кеширование в админке нам не нужно
Header("Cache-Control: no-cache, must-revalidate");
header("Expires: -1");
Header("Pragma: no-cache");

$backend = IndexAdmin::backendApp();





// Установим переменную сессии, чтоб фронтенд нас узнал как админа
// $_SESSION['admin'] = 'admin';





// Проверка сессии для защиты от xss
if(!$backend->request->check_session())
{
	unset($_POST);
	trigger_error('Session expired', E_USER_WARNING);
}


print $backend->fetch();

// Отладочная информация
if($backend->config->debug)
{
	print "<!--\r\n";
	$i = 0;
	$sql_time = 0;
	foreach($page->db->queries as $q)
	{
		$i++;
		print "$i.\t$q->exec_time sec\r\n$q->sql\r\n\r\n";
		$sql_time += $q->exec_time;
	}
  
	$time_end = microtime(true);
	$exec_time = $time_end-$time_start;
  
  	if(function_exists('memory_get_peak_usage'))
		print "memory peak usage: ".memory_get_peak_usage()." bytes\r\n";  
	print "page generation time: ".$exec_time." seconds\r\n";  
	print "sql queries time: ".$sql_time." seconds\r\n";  
	print "php run time: ".($exec_time-$sql_time)." seconds\r\n";
	print date('Y-m-d H:i:s')."\r\n";  
	print "-->";
}
