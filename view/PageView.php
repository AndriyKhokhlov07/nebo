<?PHP

require_once('View.php');

class PageView extends View
{
	function fetch()
	{
		$url = $this->request->get('page_url', 'string');

		$page = $this->pages->get_page($url);
		
		// Отображать скрытые страницы только админу
		if(empty($page) || (!$page->visible && empty($_SESSION['admin'])))
			return false;
			
		$page->children = $this->pages->get_pages(array('parent_id'=>$page->id, 'visible'=>1));
		if($page->parent_id != 0)
			$page->parent = $this->pages->get_page((int)$page->parent_id);

		$salesflow_id = $this->request->get('s');
		if(!empty($salesflow_id))
		{
			$this->salesflows->check_salesflow_status(intval($salesflow_id));

			$salesflow = $this->salesflows->get_salesflows(['id'=>intval($salesflow_id), 'limit'=>1]);
			$this->design->assign('salesflow', $salesflow);
		}

		
		// House Leader
		if($page->menu_id == 12)
		{
			if(empty($this->user))
			{
				header('Location: '.$this->config->root_url.'/user/login');
				exit();
			}
			if($this->user->type!=2)
			{
				header('Location: '.$this->config->root_url.'/current-members');
				exit();
			}

			if(!empty($this->user->house_id))
			{
				$user_house = $this->pages->get_page((int)$this->user->house_id);
				if(!empty($user_house))
					$this->design->assign('user_house', $user_house);
			}

			if(!empty($_COOKIE['mmr']))
			{
				$mmr = array();
				foreach(explode('__', $_COOKIE['mmr']) as $vv_)
				{
					$vv = explode('--', $vv_);
					$mmr[$vv[0]] = $vv[1];
				}
				$this->design->assign('mmr', $mmr);
			}



		}
		
		if($page->menu_id == 3 || $page->menu_id == 4)
		{
			
		// Фотогалереи
		$images_gallery_ids = array();
		foreach($this->galleries->get_related(array('type'=>'services', 'related_id'=>$page->id)) as $g)
			$images_gallery_ids[$g->image_id] = $g->image_id;
		
		if(!empty($images_gallery_ids))
		{
			$gallery = array();
			foreach($this->galleries->get_images(array('id'=>$images_gallery_ids)) as $i)
			{
				$gallery[$i->id] = $i;
			}
		}
		if(!empty($gallery))
		{
			$gallery_related = $this->galleries->get_related(array('image_id'=>array_keys($gallery)));
			$gallery_related_products = array();
			$gallery_related_services = array();
			foreach($gallery_related as $r)
			{
				if($r->type == 1)
					$gallery_related_products[$r->related_id] = $r->related_id;
				elseif($r->type == 2)
					$gallery_related_services[$r->related_id] = $r->related_id;
			}
			if(!empty($gallery_related_products))
			{
				$temp_gallery_products = $this->products->get_products(array('id'=>$gallery_related_products));
				foreach($temp_gallery_products as $temp_product)
					$gallery_related_products[$temp_product->id] = $temp_product;
				$gallery_related_products_images = $this->products->get_images(array('product_id'=>array_keys($gallery_related_products)));
				foreach($gallery_related_products_images as $i)
					$gallery_related_products[$i->product_id]->images[] = $i;
				foreach($gallery_related_products as $rp)
					$gallery_related_products[$rp->id]->image = $rp->images[0];
			}
			// Связанные услуги
			if(!empty($gallery_related_services))
			{
				foreach($this->pages->get_pages(array('id'=>$gallery_related_services, 'visible'=>1)) as $rs)
					$gallery_related_services[$rs->id] = $rs;
			}
			// Распределяем связанные по картинкам
			foreach($gallery_related as $r)
			{
				if($r->type == 1 && !empty($gallery_related_products[$r->related_id]))
					$gallery[$r->image_id]->related_products[] = $gallery_related_products[$r->related_id];
				elseif($r->type == 2  && !empty($gallery_related_services[$r->related_id]))
					$gallery[$r->image_id]->related_services[] = $gallery_related_services[$r->related_id];
			}
			$this->design->assign('gallery', $gallery);
		}	
		}

		if($page->url == "hot-deals")
		{
			$hot_deals = $this->pages->get_pages(array('menu_id'=>11, 'visible'=>1));
			foreach ($hot_deals as $hd) 
			{
				$hd->blocks = unserialize($hd->blocks);
			}
			if(!empty($hot_deals))
				$this->design->assign('hot_deals', $hot_deals);
		}


		
		if(!empty($page->blocks))
		{
			$page->blocks = unserialize($page->blocks);
		}



		if(!empty($page->related))
		{
			$comments = array();
		 	$page->related = unserialize($page->related);
		 	foreach ($page->related as $p) 
		 	{
		 		$rel_page = $this->blog->get_post((int)$p);
				$comments[] = $rel_page;
		 	}
		}

		/*
		if($page->url == "hellorented")
		{
			if($this->request->method('post') && $this->request->post('hellorented'))
			{
				if(!empty($this->user->id))
				{

					$r = $this->hellorented->invite_tenant($this->user->id);

					if(is_null($this->user->security_deposit_type))
		    		{
		    			$this->users->update_user($this->user->id, array(
							'security_deposit_type' => 2,  // HelloRented
							'security_deposit_status' => 2 // Sending
						));
		    		}
				}
				
			}
		}
		*/


		if($page->url == "hellorented")
		{
			$auth_code = $this->request->get('auth_code');
			if(!empty($auth_code))
			{
				$user = $this->users->get_user_code($auth_code);
			}
			if(empty($this->user))
				$this->user = $user;

			if(!empty($this->user))
			{
				$contract_id = $this->request->get('c');

				if(!empty($contract_id))
				{
					$contract = $this->contracts->get_contracts(array(
						'id' => intval($contract_id),
						'limit' => 1
					));
					if(!empty($contract))
					{
						$contract = current($contract);
						$this->design->assign('contract', $contract);

						// Month count
						$d1 = date_create($contract->date_from);
						$d2 = date_create($contract->date_to);
						
						$interval = date_diff($d1, $d2);

						$this->design->assign('contract_interval', $interval->days);
					}
				}
			}
			
			if(empty($this->user->hellorented_tenant_id))
			{
				if(!empty($auth_code))
				{
					if(!empty($user))
					{
						$this->design->assign('hellorented_id', $user->id);

						// $r = $this->hellorented->invite_tenant($user->id);
						// if(!empty($_SESSION['admin']))
						// {
						// 	print_r($r); exit;
						// }
						// if($r == 'succeeded')
						// {
						// 	//header('Location: '.$this->config->root_url.'/thank-you');
						// 	// $this->design->assign('hellorented_succeeded', 1);
						// 	$user = $this->users->get_user((int)$user->id);

						// 	if(is_null($user->security_deposit_type))
				  //   		{
				  //   			$this->users->update_user($this->user->id, array(
						// 			'security_deposit_type' => 2,  // HelloRented
						// 			'security_deposit_status' => 2 // Sending
						// 		));
				  //   		}

						// 	$this->design->assign('user', $user);
						// }
						// else
						// {
						// 	$this->design->assign('error', 'contact_manager');
						// }
					}
				}
			}
		}

		if($page->id == 235) // Houseleader Move In
		{
			if($this->request->method('post'))
			{
				$move_in->user_id = $this->request->post('user_id');
				$move_in->hl_id  = $this->user->id;
				$move_in->type 	 = 1;

				$allowed_image_extentions = array('png', 'gif', 'jpg', 'jpeg', 'ico');

				$data = array();
				if($this->request->post('name')){

					foreach($this->request->post('name') as $n=>$v)
					{
						if(!isset($data[$n]))
						{
							$data[$n] = new stdClass;
						}
						$data[$n]->name = $v;
					}
				}
				if($this->request->post('value')){
					foreach($this->request->post('value') as $n=>$v)
					{
						if(!isset($data[$n]))
						{
							$data[$n] = new stdClass;
						}
						$data[$n]->value = $v;
					}
				}


				$type = $this->request->post('type');
				$mail_to = $this->request->post('mail_to');

				if(!empty($data))
				{
					$files_arr = $this->request->files('files');
					if(!empty($files_arr))
					{	

						foreach ($files_arr['name'] as $k=>$files)
						{
							for($i=0; $i<count($files); $i++)
							{
								if($image_name = $this->image->upload_image($files_arr['tmp_name'][$k][$i], $files_arr['name'][$k][$i], 'tmp'))
								{
									// Resize image
							 		$imagesize = getimagesize($this->config->root_dir.$this->config->tmp_dir.$image_name);
							 		if($imagesize[0] > 1000)
							 		{
							 			$this->simpleimage->load($this->config->root_dir.$this->config->tmp_dir.$image_name);
										$this->simpleimage->resizeToWidth(1000);
										$this->simpleimage->save($this->config->root_dir.$this->config->tmp_dir.$image_name);
							 		}

									$data[$k]->images[] = $this->config->root_url.'/'.$this->config->tmp_dir.$image_name;
								}
							}
						}
					}


					foreach($data as $k=>$d)
					{
						if(empty($d->value) && empty($d->images))
							unset($data[$k]);
					}
					$this->design->assign('data', $data);

					$move_in->inputs = serialize($data);

					$move_in->id = $this->houseleader->add_movein($move_in);
					$this->design->assign('message_success', 'added');

					// TO
					$mailto = $this->settings->comment_email;
					// FROM
					$mailfrom = $this->settings->notify_from_email;
					// HouseLeader Checklist
					if($type == 'hl_checklist')
					{
						$this->design->assign('subject_', $data[1]->value);
						$mailto = $this->settings->checklists_email;
						$data_arr['content'] = 'Thank You!';
					}

					if(!empty($mail_to))
						$mailto = $mail_to;

					$email_template = $this->design->fetch($this->config->root_dir.'backend/design/html/email_forms_admin.tpl');
					$subject = $this->design->get_var('subject');
					// $this->notify->email($mailto, $subject, $email_template, $mailfrom);
				}
			}


		}


		
		$this->design->assign('page', $page);
		$this->design->assign('meta_title', $page->meta_title);
		$this->design->assign('meta_keywords', $page->meta_keywords);
		$this->design->assign('meta_description', $page->meta_description);

		if(!empty($comments))
			$this->design->assign('comments', $comments);

		$this->design->assign('loans', $this->loans->get_loans(array('visible'=>1)));

		$tpl = 'page.tpl';

		if($page->id == 98)
			$tpl = 'houses.tpl';

		elseif($page->id == 253 || $page->id == 254) // Houses NY and SF
		{
			$this->design->assign('city_id', $page->id);
			$tpl = 'houses.tpl';
		}

		elseif($page->menu_id == 5)
			$tpl = 'house.tpl';

		elseif($page->menu_id == 12)
			$tpl = 'houseleader_page.tpl';

		elseif($page->id == 275)
			$tpl = 'page_checklist.tpl';

		elseif($page->id == 100)
			$tpl = 'join_us.tpl';

		elseif($page->id == 105)
			$tpl = 'membership.tpl';

		elseif($page->id == 106)
			$tpl = 'corporate.tpl';

		elseif($page->id == 107)
			$tpl = 'partner.tpl';
		
		elseif($page->id == 108)
			$tpl = 'press.tpl';

		elseif($page->id == 110)
			$tpl = 'about.tpl';

		elseif($page->id == 113)
			$tpl = 'faq.tpl';

		elseif($page->id == 165)
			$tpl = 'new_event_request.tpl';

		elseif($page->id == 166)
			$tpl = 'event_report.tpl';

		elseif($page->id == 168)
			$tpl = 'joinus_thankyou.tpl';

		elseif($page->id == 169)
			$tpl = 'questionnaire.tpl';

		elseif($page->id == 184)
			$tpl = 'rent_brooklyn.tpl';

		elseif($page->id == 186)
			$tpl = 'shared_apartments.tpl';

		elseif($page->id == 191)
			$tpl = 'communal-living.tpl';

		elseif($page->id == 199)
			$tpl = 'promo.tpl';
		
		elseif($page->id == 109)
			$tpl = 'reviews.tpl';

		elseif($page->id == 202)
			$tpl = 'student_housing.tpl';

		elseif($page->id == 220)
			$tpl = 'furnished_rooms.tpl';

		elseif($page->id == 221)
			$tpl = 'membership_table.tpl';

		elseif($page->id == 259)
			$tpl = 'rent_sanfranscisco.tpl';

		elseif($page->id == 267)
			$tpl = 'nob_hill.tpl';
		elseif($page->id == 268)
			$tpl = 'lakeview.tpl';
		elseif($page->id == 269)
			$tpl = 'soma.tpl';

		elseif($page->id == 203)
			$tpl = 'hot-deals-manhattan.tpl';
		elseif($page->id == 204)
			$tpl = 'hot-deals-bed-stuy.tpl';
		elseif($page->id == 205)
			$tpl = 'hot-deals-flatbush-house.tpl';
		elseif($page->id == 206)
			$tpl = 'hot-deals-ridgewood.tpl';
		elseif($page->id == 207)
			$tpl = 'hot-deals-bushwick.tpl';
		elseif($page->id == 215)
			$tpl = 'hot-deals-east-bushwick.tpl';
		elseif($page->id == 217)
			$tpl = 'hot-deals-east-williamsburg.tpl';
		elseif($page->id == 219)
			$tpl = 'hot-deals-downtown-brooklyn.tpl';
		elseif($page->id == 236)
			$tpl = 'hot-deals-south-williamsburg.tpl';
		elseif($page->id == 271)
			$tpl = 'hot-deals-knickerbocker.tpl';
		elseif($page->id == 351) // Maintenence request
			$tpl = 'pages/maintenence_request.tpl';
        elseif($page->id == 457) // Complaints at Mason on Chestnut
            $tpl = 'pages/complaints_masononchestnut.tpl';


		elseif($page->url == 'hellorented')
			$tpl = 'hellorented.tpl';

		elseif($page->url == 'brochure')
		{
			echo $this->design->fetch('brochure.tpl');
			exit;
		}


		return $this->design->fetch($tpl);
	}
}