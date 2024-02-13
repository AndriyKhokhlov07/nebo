{* Шаблон текстовой страницы *}

{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}

{$this_page='page' scope=parent}
{$members_menu=1 scope=parent}

{*
<div class="path">
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
</div>

<!-- Заголовок страницы -->
<h1 data-page="{$page->id}" itemprop="name">{$page->header|escape}</h1>

*}

<div class="main_width {if $page->image == ''}page_wrap{/if}">
	<h1 class="text_center">{$page->header|escape}</h1>

	<div class="press_form">
	{literal}
	<script charset="utf-8" type="text/javascript" src="//js.hsforms.net/forms/v2.js"></script>
    <script>
    hbspt.forms.create({
        portalId: "4068949",
        formId: "c8f22647-ce0f-4f7b-84a2-09a9174dac3d"
    });
    </script>
    {/literal}
    </div>


	{$page->body}
</div>



