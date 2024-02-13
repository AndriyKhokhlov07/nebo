<?php


require_once('Backend.php');

class Cache extends Backend
{

	private $cache_dir = 'backend/files/cache/';
	private $cache_url;

    private function arrayObject($e) {
        if (is_object($e)) {
            foreach ($e as $k=>$v) {
                if (is_object($v)) {
                    $e->$k = $this->arrayObject($v);
                }
            }
            if (is_numeric(array_key_first((array)$e))) {
                $e = (array)$e;
            }
        }
        return $e;
    }

    public function get_data($type, $params = [])
	{
        $params = (array)$params;
		if (empty($type) && empty($params['path'])) {
			return false;
        }

		$result = false;
        
        if (!empty($params['path'])) {
            $this->cache_url = $this->cache_dir.$params['path'];
        }
		elseif ($type == 'occupancy') {
			if (isset($params['month']) && isset($params['year'])) {
				$this->cache_url = $this->cache_dir.$type.'/'.$params['year'].'-'.$params['month'].'.json';
			}
		}
        elseif (in_array($type, ['rr2', 'rr4', 'rr6'])) {
            if (isset($params['month']) && isset($params['year']) && isset($params['house_id'])) {
                $this->cache_url = $this->cache_dir.$type.'/'.$params['year'].'-'.$params['month'].'/'.$params['house_id'].'.json';
            }
        }
        if (file_exists($this->cache_url)) {
            $result = json_decode(file_get_contents($this->cache_url));
            $result = $this->arrayObject($result);
            $result->cache_date = filectime($this->cache_url);
            $result->is_cache = true;
        }
		return $result;
	}

	public function set_data($type, $params = [], $data)
	{
		if(empty($type) || !isset($data)) {
			return false;
		}

		if ($type == 'occupancy') {
			if (isset($params['month']) && isset($params['year'])) {
				$this->cache_url = $this->cache_dir.$type.'/'.$params['year'].'-'.$params['month'].'.json';		
			}
		}
        elseif (in_array($type, ['rr2', 'rr4', 'rr6'])) {
            if (isset($params['month']) && isset($params['year']) && isset($params['house_id'])) {
                if (!file_exists($this->cache_dir.$type.'/'.$params['year'].'-'.$params['month'])) {
                    mkdir($this->cache_dir.$type.'/'.$params['year'].'-'.$params['month'], 0777, true);
                }
                $this->cache_url = $this->cache_dir.$type.'/'.$params['year'].'-'.$params['month'].'/'.$params['house_id'].'.json';
                
            }
        }
        $data->manager = $this->managers->get_manager()->login;
        $data = json_encode($data, JSON_NUMERIC_CHECK | JSON_PARTIAL_OUTPUT_ON_ERROR);

		if (!empty($this->cache_url) && isset($data) && $data != false) {
			$f = fopen($this->cache_url, 'w');
			fwrite($f, $data);
			fclose($f);
		}
	}
}
