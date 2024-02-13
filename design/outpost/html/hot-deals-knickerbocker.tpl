{* Шаблон текстовой страницы *}

{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}

{$this_page='page' scope=parent}




<div class="main_width {if $page->image == ''}page_wrap{/if}">
	{*<h1 class="text_center">{$page->header|escape}</h1>*}

	<div class="press_form">
	{literal}
	<!--[if lte IE 8]>
	<script charset="utf-8" type="text/javascript" src="//js.hsforms.net/forms/v2-legacy.js"></script>
	<![endif]-->
	<script charset="utf-8" type="text/javascript" src="//js.hsforms.net/forms/v2.js"></script>
	<script>
	  hbspt.forms.create({
		portalId: "4068949",
		formId: "750f54c4-e1f2-4a1b-bb64-572e56787ef1"
	});
	</script>
    {/literal}
    </div>



	{$page->body}
</div>



