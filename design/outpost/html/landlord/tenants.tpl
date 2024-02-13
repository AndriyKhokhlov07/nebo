{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}
{$apply_button_hide=1 scope=parent}

{$members_menu=1 scope=parent}


<link href="design/{$settings->theme|escape}/css/landlord/landlord.css?v1.0.17" rel="stylesheet">




{if $houses|count > 1}
    {$nav_url = 'landlord/tenants/'}
    {include file='landlord/bx/houses_nav.tpl'}
{/if}

<div class="page_wrapper w1300">

 
    <div class="title_bx">
        <h1 class="title">{$selected_house->name|escape}</h1>
        {if $selected_house->blocks2['address']}
            <p class="tn_address">
                <i class="fa fa-map-marker"></i>
                {$selected_house->blocks2['address']}
            </p>
        {/if}
    </div>


    <div class="fx sb">

        <div class="fx tenants_cont1">
            
            <div class="tag_filter_block">

                {*
                <a class="item{if !$tenant_status || $tenant_status==1} selected{/if}" href="{url tenant_status=1}">
                    Current
                    {if $counts->current}
                        <span class="count">{$counts->current}</span>
                    {/if}
                </a>
                <a class="item{if $tenant_status==2} selected{/if}" href="{url tenant_status=2}">
                    Future
                    {if $counts->future}
                        <span class="count">{$counts->future}</span>
                    {/if}
                </a>
                <a class="item{if $tenant_status==3} selected{/if}"href="{url tenant_status=3}">
                    Archive
                </a>
                *}



                {if $params->prev_month}
                <a class="item" href="{url month=$params->prev_month|date_format:'%m-%Y'}">
                    <i class="fa fa-angle-left"></i>
                    <span>{$params->prev_month|date_format:'%B'}</span>
                </a>
                {/if}

                <div class="item selected">
                    {$params->now_month|date_format:'%B %Y'}
                </div>

                <a class="item" href="{url month=$params->next_month|date_format:'%m-%Y'}">
                    <span>{$params->next_month|date_format:'%B'}</span>
                    <i class="fa fa-angle-right"></i>
                </a>

                
            </div><!-- tag_filter_block -->

            {if $occupancy}
            <div class="grids_info fx">

                

                <div class="item fx">
                    {$occupancy_val=$occupancy->occupancy}
                    {if $occupancy_val>100}
                        {$occupancy_val=100}
                    {/if}
                    <div class="icon">
                        <div class="occupancy2_graph graph_bx">
                            <div class="graph">
                                <svg viewBox="0 0 42 42" class="donut">
                                  <circle class="donut-ring" cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke-width="6"></circle>
                                  <circle class="donut-segment" cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke-width="6" stroke-dasharray="{$occupancy_val} {100-$occupancy_val}" stroke-dashoffset="25"></circle>
                                </svg>
                            </div><!-- graph -->
                        </div><!-- graph_bx -->
                    </div>
                    <div class="cont">
                        <div class="value">{$occupancy_val}%</div>
                        <div class="name">Occupancy</div>
                    </div>
                    
                </div><!-- item -->

                <div class="item fx">
                    <div class="icon">
                        <i class="fa fa-bed"></i>
                    </div>
                    <div class="cont">
                        <div class="value">
                            {if $occupancy->occupancy_bdays>$params->days_beds_count}
                                {$occupancy->days_beds_count}
                            {else}
                                {$occupancy->occupancy_bdays}
                            {/if}
                            / {$occupancy->days_beds_count}
                        </div>
                        <div class="name">Beds: Filled/Total</div>
                    </div>
                </div><!-- item -->


                {*
                <div class="item fx">
                    <div class="icon">
                        <i class="fa fa-usd"></i>
                    </div>
                    <div class="cont">
                        <div class="value">$ {$params->total_price_this_month|convert}</div>
                        <div class="name">Invoices sent</div>
                    </div>
                </div><!-- item -->
                *}


            </div><!-- grids_info -->
            {/if}

        </div><!-- fx -->
        
        {*
        <div class="select_view">
            <a{if $type_view=='calendar'} class="selected"{/if} href="{url w=null}">
                <i class="fa fa-calendar"></i>
                Calendar
                <span class="bdg">beta</span>
            </a>
            <a{if $type_view=='list'} class="selected"{/if} href="{url w=list}">
                <i class="fa fa-list"></i>
                List
            </a>
        </div>
        *}


        {if $selected_house->has_contracts}
        <div>
            <form action="" method="post">
                <input type="hidden" name="download_contracts" value="1">
                <button class="download_zip_button fx">
                    <span>Download contracts</span>
                    <i class="icon"></i>
                </button>
            </form>
        </div>
        {/if}
    </div><!-- fx sb -->



    {if $type_view=='calendar'}
        {include file='landlord/bx/tenants/calendar.tpl'}
    {elseif $type_view=='list'}
        {include file='landlord/bx/tenants/list.tpl'}
    {/if}
    

 
</div><!-- page_wrapper -->



{if $type_view=='calendar'}
{literal}
<script>

$(function() {
 
$('.c_booking > .z').hover(function(){
    item_el = $(this);
    m_info = $(this).closest('.c_booking').find('.m_info');     
    $(document).mousemove(mouse);
}, function(){
    $(document).off("mousemove", mouse);
});
function mouse(e){
    m_info.css({'left': e.pageX - item_el.offset().left + 'px'});
}

});

</script>
{/literal}
{/if}

