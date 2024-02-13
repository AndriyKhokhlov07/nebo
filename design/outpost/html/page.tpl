{* Шаблон текстовой страницы *}

{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}

{$this_page='page' scope=parent}

{if $page->menu_id==7}
	{$members_menu=1 scope=parent}
{elseif $page->menu_id==13}
	{$css[]="design/`$settings->theme`/css/room_type.css?v1.0.0" scope=parent}
{/if}

<!-- <div class="path">
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

<!-- Заголовок страницы -->
<!-- <h1 data-page="{$page->id}" itemprop="name">{$page->header|escape}</h1> -->

{if $page->id==193}
	{$grey_body='1' scope=parent}
	<div class="page v_signed">
{else}
	<div class="main_width {if $page->image == '' && $page->id != 343}page_wrap{/if}">
{/if}
{if in_array($page->id, [335, 456])}
	{$page->body|replace:'{maintenance_form}':'<div class="press_form"><script charset="utf-8" type="text/javascript" src="//js.hsforms.net/forms/v2.js"></script>
                    <script>
                    hbspt.forms.create({
                    portalId: "4068949",
                    formId: "4bfb8920-65c7-4de6-b9be-7ecaceaa8ab6"
                    });
                    </script></div>'}
{else}
	{$page->body}
{/if}
</div>



