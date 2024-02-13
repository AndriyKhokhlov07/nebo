
{$apply_button_hide=1 scope=parent}
{$members_menu=1 scope=parent}


<link href="design/{$settings->theme|escape}/css/landlord/landlord.css?v1.0.2" rel="stylesheet">
<link id="to_ptint_css" href="design/{$settings->theme|escape}/css/landlord/print_rentroll.css?v1.0.2" rel="stylesheet">

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
                    <a class="item" href="{url month=$params->next_month|date_format:'%m-%Y'}">
                        <span>{$params->next_month|date_format:'%B'}</span>
                        <i class="fa fa-angle-right"></i>
                    </a>
                </div><!-- tag_filter_block -->
                
                <div class="toggle_empty_rows_bx">
                    {if $params->show_empty_rows}
                        <a class="toggle_link" href="{url sr=null}">Hide empty rows</a>
                    {else}
                        <a class="toggle_link" href="{url sr=1}">Show empty rows</a>
                    {/if}
                </div>

            </div>

            

            <div>
                <div class="download_zip_button fx" id="to_print" data-title1="Rent Roll Analysis - {$params->now_month|date_format:'%B %Y'}" data-title2="Property: {$selected_house->llc_name} {$smarty.now|date_format:'%m/%d/%Y'}" data-title3="{$selected_house->blocks2['address']}">
                    <span>Print / Download</span>
                    <i class="icon"></i>
                </div>
            </div>
            
        </div><!-- fx -->


    </div><!-- w1300 -->
    

    <div class="w_max">


{function name=tr}
    <!-- Tenant -->
    <td class="tenants_name_td">
        {if $i->booking->users}
            <div class="tenants_name"{if $i->booking->users|count>1} title="{foreach $i->booking->users as $u}{$u->name|escape}{if $u@iteration>1 && !$u@last}, {/if}{/foreach}"{/if}>
                {foreach $i->booking->users as $u}{$u->name|escape}{if $u@iteration>1 && !$u@last}, {/if}{/foreach}
            </div>
        {/if}
    </td>

    <td class="ll"></td>

    <!-- Contract ID -->
    <td>{if $i->contract_id}
            {$i->contract_id}
        {elseif $i->booking}
            {if $i->booking->airbnb_reservation_id}
                {$i->booking->airbnb_reservation_id}
            {elseif $i->booking->client_type_id==2}
                Airbnb
            {/if}
        {/if}</td>

    <!-- Move in -->
    <td>{if $i->booking->arrive}
            {$i->booking->arrive|date_format:"%m/%d/%Y"}
        {/if}</td>

    <!-- Move out -->
    <td>{if $i->booking->depart}
            {$i->booking->depart|date_format:"%m/%d/%Y"}
        {/if}</td>

    <!-- Days count -->
    <td>{if $i->booking}
            {$i->booking->days_count}
        {/if}</td>

    {*
    <!-- Days in month -->
    <td>{if $i->booking}
            {$i->booking->days_in_month}
        {/if}</td>
    *}

    <!-- New -->
    <td>{if $i->booking && $i->booking->new}
        <div class="badge">Yes</div>  
        {/if}</td>

    <!-- Commitment Income -->
    <td class="td_price">{if $i->booking && $i->booking->total_price>0}
            $ {$i->booking->total_price|convert}
        {/if}</td>

    {*
    <!-- Commitment this month income -->
    <td class="td_price">{if $i->booking}
            {if $i->booking->price_month_income>0}
                $ {$i->booking->price_month_income|convert}
            {elseif $t->type!='total'}
                –
            {/if}
        {/if}</td>

    <!-- Av. rent per month -->
    <td class="td_price">{if $i->booking && $i->booking->price_month>0}
            $ {$i->booking->price_month|convert}
        {/if}</td>
    *}

    <!-- Av. rent per night -->
    <td class="td_price">{if $i->booking && $i->booking->price_day>0}
            $ {$i->booking->price_day}
        {/if}</td>

    <td class="ll"></td>

    <!-- Invoice ID -->
    <td>{if $i->id}{$i->id}{/if}</td>

    <!-- Date from -->
    <td>{if $i->date_from}
            {$i->date_from|date_format:"%m/%d/%Y"}
        {/if}</td>

    <!-- Date toll -->
    <td>{if $i->date_to}
            {$i->date_to|date_format:"%m/%d/%Y"}
        {/if}</td>

    <!-- Invoiced amount -->
    <td class="td_price">{if $i->month=='this' && $i->total_price>0}
            $ {$i->total_price|convert}
        {/if}</td>

    <!-- Invoice paid -->
    <td class="td_price">{if $i->paid && (!$i->paid_m || $i->paid_m=='this_month') && ($i->total_price>0 || $i->total_paid_price>0)}
            {if $i->total_paid_price>0}
                $ {$i->total_paid_price|convert}
            {elseif $t->type!='total'}
                $ {$i->total_price|convert}
            {/if}
        {elseif $i->paid && $i->paid_m=='past'}
            <div class="badge">Paid in <a href="{url month=$i->payment_date|date_format:'%m-%Y'}">{$i->payment_date|date_format:'%B'}</a></div>
        {elseif $i->paid && $i->paid_m=='future'}
            {*
            <div class="badge orange">Unpaid</div>
            <a href="{url month=$i->payment_date|date_format:'%m-%Y'}" class="dot_info tooltip-left" data-tooltip="Paid in {$i->payment_date|date_format:'%B'}"></a>
            *}
            <div class="badge red">Unpaid</div>
        {elseif $i->paid && !$i->paid_m}
            {*
            <div class="badge">Paid</div><br>
            Not isset payment date
            *}
            $ {$i->total_price|convert}
        {elseif !$i->paid && $i->total_price>0 && $t->type!='total'}
            <div class="badge red">Unpaid</div>
        {/if}</td>

{/function}


        <div id="print_bx">
        <div class="table_r">
            <table>
                <tr class="tr_h">
                    <td colspan="4">Basic information</td>
                    <td class="ll"></td>
                    <td colspan="7">Contract</td>
                    <td class="ll"></td>
                    <td colspan="5">Monthly invoice</td>
                </tr>
                <tr class="tr_h st">
                    <td>Apartment</td>
                    <td>Room</td>
                    <td>Bed</td>
                    <td>Tenant</td>

                    <td class="ll"></td>

                    <td>Contract ID</td>
                    <td>Move in</td>
                    <td>Move out</td>
                    <td>Days</td>
                    {*<td>Days in month</td>*}
                    <td>New</td>
                    <td>Commitment Income</td>
                    {*<td>Commitment this month income</td>
                    <td>Av. rent per month</td>*}
                    <td>ADR</td>

                    <td class="ll"></td>

                    <td>Invoice ID</td>
                    <td>Date from</td>
                    <td>Date till</td>
                    <td>Invoiced amount</td>
                    <td>Invoice paid</td>

                </tr>

                <tr><td class="bl" colspan="19"></td></tr>

                {foreach $table as $k=>$t}
                    {if $t->apartment->invoices}
                        {foreach $t->apartment->invoices as $i}
                            <tr data-k="t{$k}">
                            {if $t->apartment && $i@iteration==1}
                                <td class="strong r{$t->apartment->r}" {if $t->apartment->rows>1} rowspan="{$t->apartment->rows}"{/if}>
                                    {$t->apartment->name}
                                </td>
                            {/if}
                            <td colspan="2">Full apartment</td>
                            {tr i=$i}
                            </tr>
                        {/foreach}
                        
                    {/if}
                    {foreach $t->invoices as $i}
                        <tr{if $t->class} class="{$t->class}"{/if} data-k="t{$k}">
                            {if $t->apartment->name && $i@iteration==1 && !$t->apartment->invoices}
                                <td class="strong r{$t->apartment->r}"{if $t->apartment->rows>1} rowspan="{$t->apartment->rows}"{/if}>
                                    {$t->apartment->name}
                                </td>
                            {/if}
                            {if $t->room->name && $i@iteration==1}
                                <td{if $t->room->rows>1} rowspan="{$t->room->rows}"{/if}>
                                    {$t->room->name}
                                </td>
                            {/if}
                            {if $t->bed->name && $i@iteration==1}
                                <td{if $t->bed->rows>1} rowspan="{$t->bed->rows}"{/if}>
                                    {$t->bed->name}
                                </td>
                            {/if}
                            {tr i=$i}
                        </tr>
                    {/foreach}

                    {if $t->type == 'total'}
                        <tr><td class="bl" colspan="18"></td></tr>
                    {/if}
                {/foreach}

                <tr class="tr_gtotal">
                    <td colspan="4">Grand total</td>
                    <td colspan="9"></td>
                    <td colspan="3"></td>

                    {*
                    <td colspan="7"></td>
                    <td class="td_price">
                        {if $params->grand_total->price_month_income}
                            $ {$params->grand_total->price_month_income|convert}
                        {/if}
                    </td>
                    <td class="td_price">
                        {if $params->grand_total->price_rent_month}
                            $ {$params->grand_total->price_rent_month|convert}
                        {/if}
                    </td>
                    <td class="td_price">
                        {if $params->grand_total->price_rent_day}
                            $ {$params->grand_total->price_rent_day}
                        {/if}
                    </td>
                    <td colspan="4"></td>
                    *}
                    <td class="td_price">
                        {if $params->grand_total->price_invoices}
                            $ {$params->grand_total->price_invoices|convert}
                        {/if}
                    </td>
                    <td class="td_price">
                        {if $params->grand_total->price_paid_invoices}
                            $ {$params->grand_total->price_paid_invoices|convert}
                        {/if}
                    </td>
                </tr>
            </table>
        </div><!-- table_r -->

        <div class="w1300">

            <div class="rentroll_cont_bx2">
                <h2 class="title2">Report Summary</h2>
                <div class="table_r ts1">
                    <table>
                        {if $params->grand_total->price_paid_invoices}
                            <tr>
                                <td>Invoiced amount</td>
                                <td class="val">$ {$params->grand_total->price_invoices|convert}</td>
                            </tr>
                            <tr>
                                <td>Invoice paid</td>
                                <td class="val">$ {$params->grand_total->price_paid_invoices|convert}</td>
                            </tr>
                            
                        {/if}
                        <tr>
                            <td>Occupancy</td>
                            <td class="val">{$params->occupancy}%</td>
                        </tr>
                    </table>
                </div><!-- table_r -->
            </div><!-- rentroll_cont_bx2 -->
            
        </div><!-- w1300 -->

        </div><!-- print_bx -->
            
    </div><!-- w_max -->



</div><!-- page_wrapper -->

{literal}
<script>
let to_print = document.getElementById('to_print');
let print_bx = document.getElementById('print_bx').innerHTML;
let to_ptint_css = document.getElementById('to_ptint_css');

function css_text(x) { return x.cssText; }

to_print.addEventListener('click', createPDF);

function createPDF() {
    let css_content = Array.prototype.map.call(to_ptint_css.sheet.cssRules, css_text).join('\n');
    var win = window.open('', '', 'height=auto,width=1400');
    win.document.write('<html><head>');
    win.document.write('<title>'+to_print.dataset.title1+'</title>');
    win.document.write('<style>'+css_content+'</style>'); 
    win.document.write('</head>');
    win.document.write('<body class="print_body">');
    win.document.write('<h1>'+to_print.dataset.title1+'</h1>');
    win.document.write('<h2>'+to_print.dataset.title3+'</h2>');
    win.document.write('<h2>'+to_print.dataset.title2+'</h2>');
    win.document.write(print_bx); 
    win.document.write('</body></html>');
    win.document.close();
    win.print();
}

</script>
{/literal}
