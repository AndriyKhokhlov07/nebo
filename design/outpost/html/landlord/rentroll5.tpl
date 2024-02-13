{$apply_button_hide=1 scope=parent}
{$members_menu=1 scope=parent}


<link href="design/{$settings->theme|escape}/css/landlord/landlord.css?v1.0.8.4" rel="stylesheet">
<link id="to_ptint_css" href="design/{$settings->theme|escape}/css/landlord/print_rentroll.css?v1.0.2" rel="stylesheet">

{$javascripts[]="design/`$settings->theme`/js/rentroll_w.js?v.1.3" scope=parent}

{if $houses|count > 1}
    {$nav_url = 'landlord/lender/'}
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
        <div class="fx tenants_cont1 sb">
            {*<div class="fx">
                <div class="filter_item">
                    <div class="filter_head">
                        <div class="title">
                            Rent Roll 5
                        </div>
                    </div><!-- filter_head -->
                </div><!-- filter_item -->

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
            </div>*}
            <div class="fx">
                <div class="tag_filter_block">
                    <div class="date_info" style="margin-right:50px">
                        <i class="fa fa-calendar"></i>
                        {$smarty.now|date_format:"%B %e, %Y"}
                    </div>
                </div><!-- tag_filter_block -->
            </div>
            <div class="fx w" style="padding:5px 0 0;">
                    
                    <a class="download_zip_button fx" href="{url f=xls}" download>
                        <span>Excel file</span>
                        <i class="icon"></i>
                    </a>
                    <a style="margin-left:10px;" class="download_zip_button fx" href="{url f=pdf}" download>
                        <span>PDF file</span>
                        <i class="icon"></i>
                    </a>
                    {if $data->is_cache}
                        {*<div class="date_info" style="margin-right:50px">
                            <i class="fa fa-calendar"></i>
                            {if $log_save}
                                {$log_save->date|date_format:"%B %e, %Y"}
                            {else}
                                {$data->cache_date|date_format:"%B %e, %Y"}
                            {/if}

                        </div>*}
                    {/if}
                    {*
                    <div class="download_zip_button fx" style="margin-left:10px;" id="to_print" data-title1="Rent Roll" data-title2="Property: {$selected_house->llc_name} {$smarty.now|date_format:'%m/%d/%Y'}" data-title3="{$selected_house->blocks2['address']}" data-desc1="Prepared On: {$smarty.now|date_format:'%m/%d/%Y'}" data-desc2="Properties: {$selected_house->blocks2['address']}" data-desc3="Units: Active" data-desc4="As of: {$params->selected_date|date_format:'%m/%d/%Y'}" data-desc5="Include Non-Revenue Units: No">
                        <span>PDF file</span>
                        <i class="icon"></i>
                    </div>
                    *}

            </div>
        </div><!-- tenants_cont1 -->
    </div><!-- w1300 -->
	
	{if $data->is_cache || 1}
    <div id="print_bx">
        {include file='landlord/bx/rentroll/rr5_html.tpl'}
    </div><!-- print_bx -->
    {else}
    <div class="w1300">
        <div style="padding: 30px 20px 50px">
            No data are available
        </div>
    </div>
    {/if}

</div><!-- >page_wrapper -->
