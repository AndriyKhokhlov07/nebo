

<div class="tab_nav_bx">
    <div class="tab_nav">
        <div class="wrapper w1300">
            <ul>
                {foreach $houses as $h}
                <li{if $h->selected} class="selected"{/if}>
                    <a href="{$nav_url}{$h->id}{if $smarty.get.month}?month={$smarty.get.month}{/if}{if $smarty.get.view}{if $smarty.get.month}&{else}?{/if}view={$smarty.get.view}{/if}">{$h->name}</a>
                    {if $h->selected}<div class="l"></div>{/if}
                </li>
                {/foreach}
            </ul>
        </div>
    </div><!-- tab_nav -->
</div><!-- tab_nav_bx -->