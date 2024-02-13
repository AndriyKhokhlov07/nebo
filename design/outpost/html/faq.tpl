{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}


<div class="main_width faq">
    <div class="search">
        <input type=text name=search_related id='faq_search' class="input_autocomplete" placeholder='Quick answer search'>
    </div>
    {foreach $pages as $p}
        {if $p->menu_id == 6}
        <div class="item">
            {if $p->subcategories}
                <h5 class="bold_h1">{$p->name}</h5>
                <ul>
                    {foreach $p->subcategories as $pc}
                        <li>
                            <input class="hide" type="checkbox" id="{$pc->id}">
                            <label class="h5 pc_{$pc->id}" for="{$pc->id}">{$pc->name}</label>
                            <div class="text">{$pc->body}</div>
                        </li>
                    {/foreach}
                </ul>
            {/if}
        </div>
        {/if}
    {/foreach}
</div>
