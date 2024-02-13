
{$apply_button_hide=1 scope=parent}
{$members_menu=1 scope=parent}


<link href="design/{$settings->theme|escape}/css/landlord/landlord.css?v1.0.8.1" rel="stylesheet">
<link id="to_ptint_css" href="design/{$settings->theme|escape}/css/landlord/print_rentroll.css?v1.0.2" rel="stylesheet">

{$javascripts[]="design/`$settings->theme`/js/rentroll_w.js?v.1.3" scope=parent}


{if $houses|count > 1}
    {$nav_url = 'landlord/rentroll/'}
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

            <div class="fx">

                <div class="filter_item">
                    <div class="filter_head">
                        <div class="title">
                            Prorated Monthly Rent Roll
                        </div>
                        <div class="select_block">
                            <div class="wrapper">
                                <div class="option_group">
                                    <div class="option">
                                        <a href="/landlord/rentroll2/{$selected_house->id}">
                                            Invoice Based Rent Roll
                                        </a>
                                    </div>
                                    <div class="option">
                                        <a href="/landlord/rentroll/{$selected_house->id}">
                                            Prorated Monthly Rent Roll
                                        </a>
                                    </div>
                                </div><!-- option_group -->
                            </div><!-- wrapper -->
                        </div><!-- select_block -->
                    </div><!-- filter_head -->
                </div><!-- filter_item -->

                <form class="rr_form" method="get">
                    <div class="ll_input_block">
                        <i class="fa fa-calendar"></i>
                        <input class="s_date" type="text" name="date" value="{$params->selected_date|date_format:'%Y-%m-%d'}" {if !in_array($user->id, [3164, 2883])}data-min="2021-07-01"{/if} placeholder="Select date">
                    </div>                    
                </form>
            </div>
            
            <div class="fx w" style="padding:5px 0 0;">
                {if in_array($user->id, [3164, 2883])}
                    <a class="download_zip_button fx" href="{url f=xls}" download>
                        <span>Excel file</span>
                        <i class="icon"></i>
                    </a>

                    <a style="margin-left:10px;" class="download_zip_button fx" href="{url f=pdf}" download>
                        <span>PDF file</span>
                        <i class="icon"></i>
                    </a>
                    {*
                    <div class="download_zip_button fx" style="margin-left:10px;" id="to_print" data-title1="Rent Roll" data-title2="Property: {$selected_house->llc_name} {$smarty.now|date_format:'%m/%d/%Y'}" data-title3="{$selected_house->blocks2['address']}" data-desc1="Prepared On: {$smarty.now|date_format:'%m/%d/%Y'}" data-desc2="Properties: {$selected_house->blocks2['address']}" data-desc3="Units: Active" data-desc4="As of: {$params->selected_date|date_format:'%m/%d/%Y'}" data-desc5="Include Non-Revenue Units: No">
                        <span>PDF file</span>
                        <i class="icon"></i>
                    </div>
                    *}

                {/if}

            </div>
            
            
        </div><!-- tenants_cont1 -->


    </div><!-- w1300 -->
    
    <div id="print_bx">
        {include file='landlord/bx/rentroll/html.tpl'}
    </div><!-- print_bx -->


</div><!-- >page_wrapper -->
