{* Шаблон текстовой страницы *}

{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}

{$this_page='page' scope=parent}

{if $page->menu_id==7}
	{$members_menu=1 scope=parent}
{/if}

{$maintenance_request_button_hide=1 scope=parent}

{* <div class="path">
	<div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
	   <a href="{$config->root_url}/" itemprop="url"><span itemprop="title">Главная</span></a> 
    </div>
    {if $page->parent}
    <div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
	   <a href="{$page->parent->url}" itemprop="url"><span itemprop="title">{$page->parent->name}</span></a>
    </div>
    {/if}
	<div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
		<a href="{$config->root_url}/{$page->url}" itemprop="url">
			<span itemprop="title">{$page->name}</span>
		</a>
	</div>                
</div> -->

*}



<div class="main_width {if $page->image == ''}page_wrap{/if}">

	<h1 data-page="{$page->id}" itemprop="name">{$page->header|escape}</h1>

	{literal}
	<!--[if lte IE 8]>
	<script charset="utf-8" type="text/javascript" src="//js.hsforms.net/forms/v2-legacy.js"></script>
	<![endif]-->
	<script charset="utf-8" type="text/javascript" src="//js.hsforms.net/forms/v2.js"></script>
	<script>
	  hbspt.forms.create({
		region: "na1",
		portalId: "4068949",
		formId: "4bfb8920-65c7-4de6-b9be-7ecaceaa8ab6"
	});
	</script>
	{/literal}

	{$page->body}
</div>



