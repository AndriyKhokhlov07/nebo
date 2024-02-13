<?PHP

 
require_once('View.php');


class MainView extends View
{

	function fetch()
	{
		// header('Location: '.$this->config->root_url.'/user/');
		// exit;


		if($this->page)
		{
			$this->design->assign('meta_title', $this->page->meta_title);
			$this->design->assign('meta_keywords', $this->page->meta_keywords);
			$this->design->assign('meta_description', $this->page->meta_description);
		}

		// $this->design->assign('loans', $this->loans->get_loans(array('visible'=>1)));

		return $this->design->fetch('main.tpl');
	}
}
