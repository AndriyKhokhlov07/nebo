{* Text page *}
{$canonical="/{$page->url}" scope=parent}

{$this_page='page' scope=parent}

{$members_menu=1 scope=parent}
{* $maintenance_request_button_hide=1 scope=parent *}

<div class="main_width {if $page->image == ''}page_wrap{/if}">
    <h1 data-page="{$page->id}" itemprop="name">{$page->header|escape}</h1>
    {literal}
        <!--[if lte IE 8]>
        <script charset="utf-8" type="text/javascript" src="//js.hsforms.net/forms/v2-legacy.js"></script>
        <![endif]-->
        <script charset="utf-8" type="text/javascript" src="//js.hsforms.net/forms/embed/v2.js"></script>
        <script>
            hbspt.forms.create({
                region: "na1",
                portalId: "4068949",
                formId: "9245162c-7879-4a57-8500-13090dd1e275"
            });
        </script>
    {/literal}
    {$page->body}
</div>