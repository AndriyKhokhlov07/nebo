
{$apply_button_hide=1 scope=parent}
{$members_menu=1 scope=parent}

<link href="design/{$settings->theme|escape}/css/landlord/landlord.css?v1.0.18" rel="stylesheet">
<link href="design/{$settings->theme|escape}/css/landlord/stats.css?v1.0.1" rel="stylesheet">

{if $houses|count > 1}
    {$nav_url = 'landlord/stats/'}
    {include file='landlord/bx/houses_nav.tpl'}
{/if}


<div class="page_wrapper">

    <div class="w1300">
        <div class="title_bx">
            <h1 class="title">{$selected_house->name|escape}</h1>
            {if $selected_house->blocks2['address']}
                <p class="tn_address">
                    <i class="fa fa-map-marker"></i>
                    {$selected_house->blocks2['address']}
                </p>
            {/if}
        </div><!-- title_bx -->


        <div class="tag_filter_block">
            {if $params->prev_month}
                <a class="item" href="{url month=$params->prev_month|date_format:'%m-%Y'}">
                    <i class="fa fa-angle-left"></i>
                    <span>{$params->prev_month|date_format:'%B'}</span>
                </a>
            {/if}
            <div class="item selected">
                {$params->now_month|date_format:'%B %Y'}
            </div>
            {if $params->next_month}
                <a class="item" href="{url month=$params->next_month|date_format:'%m-%Y'}">
                    <span>{$params->next_month|date_format:'%B'}</span>
                    <i class="fa fa-angle-right"></i>
                </a>
            {/if}
        </div><!-- tag_filter_block -->



    </div><!-- w1300 -->

    <div class="house_stats_block view_landlord w1500">
        {include file='landlord/bx/stats/stats.tpl'}
    </div>



</div><!-- page_wrapper -->


