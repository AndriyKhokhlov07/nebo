<?php

require_once('Backend.php');

class Guesty extends Backend
{

	// private $api_key = '62643b1ebfb1530dc01741d927f54c93';
    private $api_key = '62643b1ebfb1530dc01741d927f54c93';
	private $secret_key = 'c85a0aa51a0f70ed585d88a04b728e16';



    // Client ID
    // 0oa9apsubiaYtykPQ5d7

    // Client Secret
    // rq0-9qf5NGyDAgS0QqLoE5ChUCS20rozvggZkxRT


	private $account_id = '5849641db774fd10000c2d32';

	private $request_url = 'https://api.guesty.com/api/v2/';
	private $response_url;
	private $auth_token;
	private $auth_token_file = 'api/tokens/guesty_auth.token';


	// webhook id
	// 611d2c432292bb002e5862f5

	
	public function __construct()
	{
		$this->response_url = $this->config->root_url.'/request/guesty/';		
	}



	public function get_webhooks()
	{
		$curl = curl_init();
		curl_setopt($curl, CURLOPT_URL, $this->request_url.'/webhooks');
		curl_setopt($curl, CURLOPT_USERPWD, $this->api_key . ":" . $this->secret_key);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);

		$json = curl_exec($curl);
		$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);

		if($http_status == 200)
		{
			// $response = json_decode($json);
			$response = $json;
			return $response;
			// if(!empty($response->access_token))
			// 	return $response->access_token;
		}
	}

	public function add_webhook($params)
	{
		$params = (array)$params;

		if(empty($params['events']))
			return false;

		if(empty($params['url']))
			$params['url'] = $this->response_url;
		if(empty($params['accountId']))
			$params['accountId'] = $this->account_id;

		$curl = curl_init();
		curl_setopt($curl, CURLOPT_URL, $this->request_url.'/webhooks');
		curl_setopt($curl, CURLOPT_USERPWD, $this->api_key . ":" . $this->secret_key);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_POST, true);
		curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);
		//curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($params));
		curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($params));

		$json = curl_exec($curl);
		$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);

		if($http_status == 200)
		{
			// $response = json_decode($json);
			$response = $json;
			return $response;
			// if(!empty($response->access_token))
			// 	return $response->access_token;
		}

	}


	public function delete_webhook($id)
	{
		if(empty($id))
			return false;

		$curl = curl_init();
		curl_setopt($curl, CURLOPT_URL, $this->request_url.'/webhooks/'.$id);
		curl_setopt($curl, CURLOPT_USERPWD, $this->api_key . ":" . $this->secret_key);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);
		curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "DELETE");

		$json = curl_exec($curl);
		$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);

		if($http_status == 204)
		{
			$response = $json;
			return $response;
		}
	}


	public function get_guest($id)
	{

		$curl = curl_init();
		curl_setopt($curl, CURLOPT_URL, $this->request_url.'/guests/'.$id);
		curl_setopt($curl, CURLOPT_USERPWD, $this->api_key . ":" . $this->secret_key);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);

		$json = curl_exec($curl);
		$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);

		if($http_status == 200)
		{
			// $response = json_decode($json);
			$response = $json;
			return $response;
			// if(!empty($response->access_token))
			// 	return $response->access_token;
		}

	}










	public function test()
	{
		// echo $this->api_key; exit;
		// $auth_params = array(
		// 	'client_id' 	=> $this->client_id,
		// 	'client_secret' => $this->client_secret,
		// 	'grant_type'    => 'client_credentials'
		// );

		$curl = curl_init();
		curl_setopt($curl, CURLOPT_URL, $this->request_url.'/users');
		curl_setopt($curl, CURLOPT_USERPWD, $this->api_key . ":" . $this->secret_key);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		//curl_setopt($curl, CURLOPT_POST, true);
		curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);
		// curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($auth_params));

		$json = curl_exec($curl);
		$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);

		if($http_status == 200)
		{
			// $response = json_decode($json);
			$response = $json;
			return $response;
			// if(!empty($response->access_token))
			// 	return $response->access_token;
		}
		//echo "status:" . $http_status . "\n" . $json . "\n\n";
		//print_r($response); exit;
	}

}