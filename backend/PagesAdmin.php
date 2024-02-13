<?PHP 

require_once('api/Backend.php');

########################################
class PagesAdmin extends Backend
{

  public function fetch()
  {

  	// Администратор
  	$manager = $this->managers->get_manager();
  	if(!empty($manager->permissions))
	{
		$menu_permissions = array();
		foreach($manager->permissions as $permission)
		{
			$p_arr = explode('_', $permission);
			if(count($p_arr) == 2 && $p_arr[0] == 'menu')
			{
				$menu_permissions[] = (int)$p_arr[1];
			}
		}
	}
    // Меню
    $menus = $this->pages->get_menus();
 	$this->design->assign('menus', $menus);
 	
    // Текущее меню
  	$menu_id = $this->request->get('menu_id', 'integer');
  	
  	if(!empty($menu_id) && !in_array($menu_id, $menu_permissions))
	{
		return 'Permission denied';
	}
  	if(!$menu_id || !$menu = $this->pages->get_menu($menu_id))
  	{
  		$menu = reset($menus);

  		if(!in_array($menu->id, $menu_permissions))
  		{
  			$menu_id = reset($menu_permissions);
  			$menu = $this->pages->get_menu($menu_id);
  		}
  		//if($backend->managers->access('products'))
  	}
 	$this->design->assign('menu', $menu);


   	// Обработка действий
  	if($this->request->method('post'))
  	{
		// Сортировка
		$positions = $this->request->post('positions'); 		
 		$ids = array_keys($positions);
		sort($positions);
		foreach($positions as $i=>$position)
			$this->pages->update_page($ids[$i], array('position'=>$position)); 

		
		// Действия с выбранными
		$ids = $this->request->post('check');
		if(is_array($ids))
		switch($this->request->post('action'))
		{
		    case 'disable':
		    {
				$this->pages->update_page($ids, array('visible'=>0));	      
				break;
		    }
		    case 'enable':
		    {
				$this->pages->update_page($ids, array('visible'=>1));	      
		        break;
		    }
		    case 'delete':
		    {
			    foreach($ids as $id)
					$this->pages->delete_page($id);    
		        break;
		    }
		}		
		
 	}

  

	// Отображение
	if(!empty($menu->id))
	{
		$pages_ = $this->pages->get_pages(array('menu_id'=>$menu->id));
		$pages = array();
		if(!empty($pages_))
		{
			foreach($pages_ as $k=>$p)
			{
				$pages[$k] = $p;
				if(!empty($p->blocks2))
					$pages[$k]->blocks2 = unserialize($p->blocks2);
			}
		}
		$pages = $this->pages->get_pages_tree();


		if($menu->id == 5) // Houses
		{
			// Neighborhoods
			$neighborhoods = array();
			$neighborhoods_ = $this->beds->get_neighborhoods();
			if(!empty($neighborhoods_))
			{
				foreach($neighborhoods_ as $neighborhood)
					$neighborhoods[$neighborhood->id] = $neighborhood;
			}
			$this->design->assign('neighborhoods', $neighborhoods);
		}
	}
  	


	if(!empty($pages))
 		$this->design->assign('pages', $pages);
	return $this->design->fetch('pages.tpl');
  }
}


