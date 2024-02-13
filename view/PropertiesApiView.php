<?PHP
ini_set('error_reporting', E_ALL);

require_once('View.php');

class PropertiesApiView extends View
{
	private $secretKeys = [
		'Philadelphia' => 's4PLqXdGaTR0jhBDctniKxUCblF3u9Wg8ZYm2fF176JIeAwMN',
		'Alpaca' => 'e3da59312a0870c24e55d9a18db26c53590701518e5f57b64c8a972c799149e5',
	];

	public $house;

	function fetch()
	{
		$house = new stdclass;

		if($this->request->get('house_id'))
			$houseId = $this->request->get('house_id', 'integer');
		$secretKey = '';
		if(!empty($_SERVER['HTTP_AUTHORIZATION']))
		{
			$authHeader = explode(" ", $_SERVER['HTTP_AUTHORIZATION']);
			$secretKey = $authHeader[1];
		}  

		header("Content-type: application/json; charset=UTF-8");
		header("Access-Control-Allow-Origin: *");
		header("Cache-Control: must-revalidate");
		header("Pragma: no-cache");
		header("Expires: -1");
		if(in_array($secretKey, $this->secretKeys))
		{
			if(!empty($houseId))
			{

				$properties = $this->properties->get_properties($houseId, array_search($secretKey, $this->secretKeys));

	            header('HTTP/1.0 200 OK');
	            echo $properties;
	            exit;
			}
			else
			{
				$houses = $this->properties->get_houses();

				header('HTTP/1.0 200 OK');
	            echo $houses;
	            exit;
			}
		}
		
        header('HTTP/1.0 400 Bad Request');
        echo json_encode([
            'error' => 'Bad Request'
        ]);
        exit;
	}
}