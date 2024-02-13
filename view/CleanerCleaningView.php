<?php


require_once('View.php');

class CleanerCleaningView extends View
{
	public function fetch()
	{
		if(empty($this->user))
		{
			header('Location: '.$this->config->root_url.'/user/login');
			exit();
		}

		$cl_note = new stdClass;
		$cleaning_record = new stdClass;
		if($this->request->method('post'))
		{
			$cl_note_id = $this->request->post('cl_note_id', 'integer');
			$cleaning_record->desired_date = $this->request->post('date');
			$cleaning_record->house_id = $this->request->post('house_id', 'integer');
			$cleaning_record->completion_date = date('Y-m-d H:i:s');
			$cleaning_record->cleaner_id = $this->user->id;
			$cleaning_record->status = 1;
			$cleaning_record->note = $this->request->post('note');

			// Загрузка drag-n-drop файлов
			$i_images = array();
  		    if($images = $this->request->post('images_urls_dropZone'))
  		    {
				foreach($images as $url)
				{
			 		if($dropped_images = $this->request->files('dropped_images'))
			  		{

			 			$key = array_search($url, $dropped_images['name']);
					 	if ($key!==false && $image_name = $this->image->upload_image($dropped_images['tmp_name'][$key], $dropped_images['name'][$key], 'cleanings'))
					 	{
					 		// Resize image
					 		$imagesize = getimagesize($this->config->root_dir.$this->config->cleaning_images_dir.$image_name);
					 		if($imagesize[0] > 1000)
					 		{
					 			$this->simpleimage->load($this->config->root_dir.$this->config->cleaning_images_dir.$image_name);
								$this->simpleimage->resizeToWidth(1000);
								$this->simpleimage->save($this->config->root_dir.$this->config->cleaning_images_dir.$image_name);
					 		}
					 		$i_images[] = $image_name;
					 	}
				  	   	
					}
				}
			}
			$old_cleaning = $this->cleaning->get_cleanings(array('id'=>$cl_note_id));

			if(!empty($i_images))
			{
				$images_arr = array();

				if(!empty($old_cleaning))
    			{
    				if(!empty($old_cleaning->images))
    				{
    					$old_images = unserialize($old_cleaning->images);
    					if(!empty($old_images))
    					{
	    					foreach($old_images as $i)
	    						$images_arr[] = $i;
    					}

    				}
    				unset($old_images);
    			}
    			foreach($i_images as $i)
    				$images_arr[] = $i;


				$cleaning_record->images = serialize($images_arr);
			}

			//
			$i_images1 = array();
  		    if($images1 = $this->request->post('images_urls_dropZone1'))
  		    {
				foreach($images1 as $url)
				{
			 		if($dropped_images = $this->request->files('dropped_images1'))
			  		{

			 			$key = array_search($url, $dropped_images['name']);
					 	if ($key!==false && $image_name = $this->image->upload_image($dropped_images['tmp_name'][$key], $dropped_images['name'][$key], 'cleanings'))
					 	{
					 		// Resize image
					 		$imagesize = getimagesize($this->config->root_dir.$this->config->cleaning_images_dir.$image_name);
					 		if($imagesize[0] > 1000)
					 		{
					 			$this->simpleimage->load($this->config->root_dir.$this->config->cleaning_images_dir.$image_name);
								$this->simpleimage->resizeToWidth(1000);
								$this->simpleimage->save($this->config->root_dir.$this->config->cleaning_images_dir.$image_name);
					 		}
					 		$i_images1[] = $image_name;
					 	}
					}
				}
			}

			if(!empty($i_images1))
			{
				$images_arr =  array();

				if(!empty($old_cleaning))
    			{
    				if(!empty($old_cleaning->images1))
    				{
    					$old_images = unserialize($old_cleaning->images1);
    					if(!empty($old_images))
    					{
	    					foreach($old_images as $i)
	    						$images_arr[] = $i;
    					}
    					unset($old_images);
    				}
    			}
    			foreach($i_images1 as $i)
    				$images_arr[] = $i;


				$cleaning_record->images1 = serialize($images_arr);
			}

			//
			$i_images2 = array();
  		    if($images2 = $this->request->post('images_urls_dropZone2'))
  		    {
				foreach($images2 as $url)
				{
			 		if($dropped_images = $this->request->files('dropped_images2'))
			  		{

			 			$key = array_search($url, $dropped_images['name']);
					 	if ($key!==false && $image_name = $this->image->upload_image($dropped_images['tmp_name'][$key], $dropped_images['name'][$key], 'cleanings'))
					 	{
					 		// Resize image
					 		$imagesize = getimagesize($this->config->root_dir.$this->config->cleaning_images_dir.$image_name);
					 		if($imagesize[0] > 1000)
					 		{
					 			$this->simpleimage->load($this->config->root_dir.$this->config->cleaning_images_dir.$image_name);
								$this->simpleimage->resizeToWidth(1000);
								$this->simpleimage->save($this->config->root_dir.$this->config->cleaning_images_dir.$image_name);
					 		}
					 		$i_images2[] = $image_name;
					 	}
				  	   	
					}
				}
			}

			if(!empty($i_images2))
			{
				$images_arr =  array();

				if(!empty($old_cleaning))
    			{
    				if(!empty($old_cleaning->images2))
    				{
    					$old_images = unserialize($old_cleaning->images2);
    					if(!empty($old_images))
    					{
	    					foreach($old_images as $i)
	    						$images_arr[] = $i;
    					}

    				}
    				unset($old_images);
    			}
    			foreach($i_images2 as $i)
    				$images_arr[] = $i;


				$cleaning_record->images2 = serialize($images_arr);
			}

			//
			$i_images3 = array();
  		    if($images3 = $this->request->post('images_urls_dropZone3'))
  		    {
				foreach($images as $url)
				{
			 		if($dropped_images = $this->request->files('dropped_images3'))
			  		{

			 			$key = array_search($url, $dropped_images['name']);
					 	if ($key!==false && $image_name = $this->image->upload_image($dropped_images['tmp_name'][$key], $dropped_images['name'][$key], 'cleanings'))
					 	{
					 		// Resize image
					 		$imagesize = getimagesize($this->config->root_dir.$this->config->cleaning_images_dir.$image_name);
					 		if($imagesize[0] > 1000)
					 		{
					 			$this->simpleimage->load($this->config->root_dir.$this->config->cleaning_images_dir.$image_name);
								$this->simpleimage->resizeToWidth(1000);
								$this->simpleimage->save($this->config->root_dir.$this->config->cleaning_images_dir.$image_name);
					 		}
					 		$i_images3[] = $image_name;
					 	}
				  	   	
					}
				}
			}

			if(!empty($i_images3))
			{
				$images_arr =  array();

				if(!empty($old_cleaning))
    			{
    				if(!empty($old_cleaning->images3))
    				{
    					$old_images = unserialize($old_cleaning->images3);
    					if(!empty($old_images))
    					{
	    					foreach($old_images as $i)
	    						$images_arr[] = $i;
    					}

    				}
    				unset($old_images);
    			}
    			foreach($i_images3 as $i)
    				$images_arr[] = $i;


				$cleaning_record->images3 = serialize($images_arr);
			}

			// Добавить Кост с нужной ценой по уборке
			

			if(!empty($cl_note_id))
			{
				$this->cleaning->update_cleaning($cl_note_id, $cleaning_record);
			}
			else
			{
				$cl_note_id = $this->cleaning->add_cleaning($cleaning_record);
			}

			$cleaning = $this->cleaning->get_cleaning($cl_note_id);

            if(!empty($cleaning->bed) && !empty($cleaning->order_id))
            	$subtype = 4; // Cleaning request
            elseif($cleaning->bed == 'Common Area')
            	$subtype = 2; // Common area cleaning
            elseif($cleaning->bed != '' && $cleaning->order_id == '0' && $cleaning->type != 3)
            	$subtype = 5; // Flip
			elseif($cleaning->type == 3)
				$subtype = 3; // Room cleaning
			else
				$subtype = 1; // Regular cleaning

			$this->costs->add_cost(array(
                'parent_id' => $cl_note_id,
                'house_id' => $cleaning_record->house_id,
                'type' => 2, // Cleanings 
                'subtype' => $subtype, // Вариант уборки
                'price' => $this->costs->cost_types[2]['subtypes'][$subtype]['price'],
                'sender_type' => 3,
                'sender' => $this->user->name,
                'name' => $this->user->name
            ));

		}

		// $cleanings = array();
		// $orders_ = $this->orders->get_orders(array('user_id'=>$this->user->id, 'status'=>array(0,1,4), 'type'=>3));
		// $purchases = array();

		// if(!empty($orders_))
		// {
		// 	foreach($orders_ as $o)
		// 	{
		// 		$cleanings[$o->id] = $o;
		// 	}
		// 	unset($orders_);

		// 	if(!empty($cleanings))
		// 	{
		// 		$purchases_ = $this->orders->get_purchases(array('order_id'=>array_keys($cleanings)));
		// 		if(!empty($purchases_))
		// 		{
		// 			foreach($purchases_ as $p)
		// 			{
		// 				$purchases[$p->order_id][] = $p;

						// if(isset($cleanings[$p->order_id]))
						// {
						// 	$cleanings[$p->order_id]->purchases[$p->id] = $p;
						// }
		// 			}
		// 		}
		// 	}

		// }

		$houseleaders_houses = $this->users->get_houseleaders_houses(array('user_id'=>$this->user->id));
		$housecleaners_houses = $this->users->get_housecleaners_houses(array('user_id'=>$this->user->id));

		$cleanings_by_house = array();
		$house_ids = array();
		$houses = array();
		$cleaning_days = array();

		if(!empty($houseleaders_houses))
		foreach ($houseleaders_houses as $house) 
		{
			$house_ids[] = $house->house_id;
		}
		if(!empty($housecleaners_houses))
		foreach ($housecleaners_houses as $house) 
		{
			$house_ids[] = $house->house_id;
		}


		if(!empty($house_ids))
		{
			$houses_ = $this->pages->get_pages(array('id'=>$house_ids));
			foreach ($houses_ as $h) {
				$houses[$h->id] = $h;
			}
		}
		

		$today = date('Y-m-d');

		$cleanings = $this->cleaning->get_cleanings(array('house_ids'=>$house_ids, 'date_from'=>$today));
		$cleaning_days = $this->cleaning->get_cleaning_days($house_ids);


		// $date = time();
		// $day = 60 * 60 * 24;
		// $week_one = array(1, 5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53);
		// $week_two = array(2, 6, 10, 14, 18, 22, 26, 30, 34, 38, 42, 46, 50, 54);
		// $week_three = array(3, 7, 11, 15, 19, 23, 27, 31, 35, 39, 43, 47, 51, 55);
		// $week_four = array(4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56);



		
		// foreach($cleaning_days as $cd)
		// {
		// 	$date = time();
		// 	if($cd->day > 0 && $cd->type==0)
		// 	{
		// 		$cd_day = $cd->day;
		// 		if($cd->day > 7 && $cd->day < 15)
		// 			$cd_day = $cd->day - 7;
		// 		if($cd->day > 14 && $cd->day < 22)
		// 			$cd_day = $cd->day - 14;
		// 		if($cd->day > 21)
		// 			$cd_day = $cd->day - 21;


		// 		// if(in_array(date('W', $date), $week_two))
		// 		// {
		// 		// 	$date -= 10 * $day;
		// 		// }
		// 		// echo $date;
		// 		$i=1;
		// 		while (date('N', $date) != $cd_day)
		// 		{
		// 			$date += $day;
		// 			// echo date('Y-m-d', $date); 
		// 			// echo '/';
		// 			// echo date('N', $date);
		// 			// echo '-'.$cd_day.'______';
		// 		}
		// 		// exit;

		// 		// echo date('Y-m-d', $date);
		// 		// echo '/';
		// 		// echo $cd->day;
				
		// 		// echo date('Y-m-d', $date+14*$day); 
		// 		// exit;

		// 		if(in_array(date('W', $date), $week_two))
		// 		{
		// 			$date -= 7 * $day;
		// 		}
		// 		elseif(in_array(date('W', $date), $week_three))
		// 		{
		// 			$date -= 14 * $day;
		// 		}
		// 		elseif(in_array(date('W', $date), $week_four))
		// 		{
		// 			$date -= 21 * $day;
		// 		}
		// 		else{
		// 			$date = $date;
		// 		}

		// 		if(in_array(date('W', $date), $week_one)==1 && $cd->day < 8)
		// 		{
		// 			$cd_desired_date = date('Y-m-d', $date);
		// 			$cleanings_by_house[$cd_desired_date][$cd->house_id][] = $cd_desired_date;
		// 		}
		// 		if(in_array(date('W', $date+7*$day), $week_two)==1 && $cd->day > 7 && $cd->day < 15){
		// 			$date += 7 * $day;
		// 			$cd_desired_date = date('Y-m-d', $date);
		// 			$cleanings_by_house[$cd_desired_date][$cd->house_id][] = $cd_desired_date;
		// 		}
		// 		if(in_array(date('W', $date+14*$day), $week_three)==1 && $cd->day > 14 && $cd->day < 22){
		// 			$date += 14 * $day;
		// 			// echo $date;
		// 			$cd_desired_date = date('Y-m-d', $date);
		// 			$cleanings_by_house[$cd_desired_date][$cd->house_id][] = $cd_desired_date;
		// 		}
		// 		if(in_array(date('W', $date+21*$day), $week_four)==1 && $cd->day > 21)
		// 		{
		// 			$date += 21 * $day;
		// 			$cd_desired_date = date('Y-m-d', $date);
		// 			$cleanings_by_house[$cd_desired_date][$cd->house_id][] = $cd_desired_date;
		// 		}
		// 	}
		// }
		// exit;
		
		// print_r($cleaning_days); exit;

		$date = time();
		$day = 60 * 60 * 24;

		// print_r($cleaning_days);
		// echo date('w', time());
		// exit;


		foreach ($cleaning_days as $cd) 
		{
			$date = time();
			
			if($cd->day > 0)
			{
				$while_n = 0;
				while ((date('w', $date) !== $cd->day) and ($while_n < 10))
				{
					$date += $day;
					$while_n ++;
				}
				for ($i=0; $i < 4; $i++) { 
					if(date('W', $date) && 1)
					{
						$cd_desired_date = date('Y-m-d', $date);
						$cleanings_by_house[$cd_desired_date][$cd->house_id][] = $cd_desired_date;
					}
					$date += 7 * $day;
				}
			}
			else
			{
				$cd->day = abs($cd->day);
				$while_n = 0;
				while ((date('w', $date) != $cd->day) and ($while_n < 10))
				{
					$date += $day;
					$while_n ++;
				}
				for ($i=0; $i < 4; $i++) {
					if(date('W', $date) && 1)
					{
						
					}
					else
					{
						$cd_desired_date = date('Y-m-d', $date);
						$cleanings_by_house[$cd_desired_date][$cd->house_id][] = $cd_desired_date;
					}
					$date += 7 * $day;
				}
			}
		}

		$purchases = array();
		$order_ids = array();
		$cleaners = array();
		$cleaners_ids = array();
		foreach ($cleanings as $cl) {
			if($cl->order_id == 0 && $cl->bed == '')
			{
				foreach ($cleanings_by_house[$cl->desired_date][$cl->house_id] as &$com_area) {
					if($com_area == $cl->desired_date)
						$com_area = $cl;
				}
			}
			else{
				$cleaners_ids[] = $cl->cleaner_id;
				$order_ids[] = $cl->order_id;
				$cleanings_by_house[$cl->desired_date][$cl->house_id][] = $cl;
			}

		}

		$purchases_ = $this->orders->get_purchases(array('id'=>$order_ids));
		if($purchases_)
		foreach ($purchases_ as $pur) {
			$purchases[$pur->order_id][] = $pur;
		}

		$cleaners_ = $this->users->get_users(array('id'=>$cleaners_ids));
		if($cleaners_)
		foreach ($cleaners_ as $c) {
			$cleaners[$c->id] = $c;
		}

		ksort($cleanings_by_house);

		$this->design->assign('houses', $houses);
		$this->design->assign('purchases', $purchases);
		$this->design->assign('cleaners', $cleaners);
		$this->design->assign('cleanings', $cleanings_by_house);



		return $this->design->fetch('cleaning/cleaner_cleaning.tpl');
	}
}
