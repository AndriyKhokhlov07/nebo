<?
chdir('..');
require_once('api/Backend.php');
$backend = new Backend();

$house_id = $backend->request->post('house_id', 'integer');

$results = array();

$apartments = $backend->beds->get_apartments(array('house_id'=>$house_id));

if(!empty($apartments))
{
	foreach($apartments as $apt)
	{
		$i = new stdClass;
		$i->id = $apt->id;
		$i->name = $apt->name;
		$results[] = $i;
	}
}

	
header("Content-type: application/json; charset=UTF-8");
header("Cache-Control: must-revalidate");
header("Pragma: no-cache");
header("Expires: -1");
echo json_encode($results);
