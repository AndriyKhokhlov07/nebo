{* Шаблон текстовой страницы *}

{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}

{$this_page='page' scope=parent}
{$members_menu=1 scope=parent}

<div class="main_width {if $page->image == ''}page_wrap{/if}">
	<h1 class="text_center">{$page->header|escape}</h1>

	<div class="press_form">
	{literal}
	<script charset="utf-8" type="text/javascript" src="//js.hsforms.net/forms/v2.js"></script>
    <script>
    hbspt.forms.create({
        portalId: "4068949",
        formId: "76244bdc-7e5d-431f-a5bf-eedf5ab70a05"
    });
    </script>
    {/literal}
    </div>


	{$page->body}
</div>



