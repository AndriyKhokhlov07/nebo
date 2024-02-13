
{$apply_button_hide=1 scope=parent}
{$members_menu=1 scope=parent}


<link href="design/{$settings->theme|escape}/css/landlord/landlord.css?v1.0.8.1" rel="stylesheet">
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

                <div class="filter_item">
                    <div class="filter_head">
                        <div class="title">
                            Rent Roll v.1
                        </div>
                        <div class="select_block">
                            <div class="wrapper">
                                <div class="option_group">
                                    <div class="option">
                                        <a href="/landlord/rentroll1/">
                                            RentRoll v.1
                                        </a>
                                    </div>
                                    <div class="option">
                                        <a href="/landlord/rentroll/">
                                            RentRoll v.3
                                        </a>
                                    </div>
                                </div><!-- option_group -->
                            </div><!-- wrapper -->
                        </div><!-- select_block -->
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
                
                {*
                <div class="toggle_empty_rows_bx">
                    {if $params->show_empty_rows}
                        <a class="toggle_link" href="{url sr=null}">Hide empty rows</a>
                    {else}
                        <a class="toggle_link" href="{url sr=1}">Show empty rows</a>
                    {/if}
                </div>
                *}

            </div>


            

            

            <div class="fx">

                <div class="date_info" style="margin-right:50px">
                    <i class="fa fa-calendar"></i>
                    {$smarty.now|date_format:"%B %e, %Y"}
                </div>

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
            {if $i->contract->sku}{$i->contract->sku}{else}{$i->contract_id}{/if}
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
    <td>
        {if $i->booking && $i->new}
            <div class="badge">New</div>  
        {/if}

        {if $i->booking->sp_bookings|count>1}
            {foreach $i->booking->sp_bookings as $sp_booking}
                {if $sp_booking->arrive|date:'m-Y' == $params->now_month|date_format:'%m-%Y'}
                    <div class="badge">
                        Room: {$apartments[$sp_booking->apartment_id]->rooms[$sp_booking->room_id]->beds[$sp_booking->object_id]->name}
                        {if $sp_booking->apartment_id != $i->booking->apartment_id}
                            ({$apartments[$sp_booking->apartment_id]->name})
                        {/if}
                        <br>
                        {$sp_booking->arrive|date_format:"%m/%d/%Y"}
                        
                    </div>
                {/if}
            {/foreach}
        {/if}
    </td>

    <!-- Commitment Income -->
    <td class="td_price">
        {if $i->contract}
            $ {$i->contract->total_price|number_format:2:'.':''}
        {elseif $i->booking && $i->booking->total_price>0}
            $ {$i->booking->total_price|number_format:2:'.':''}
        {/if}
    </td>

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
    <td>{if $i->sku}{$i->sku}{elseif $i->id}{$i->id}{/if}</td>

    <!-- Date from -->
    <td>{if $i->date_from}
            {$i->date_from|date_format:"%m/%d/%Y"}
        {/if}</td>

    <!-- Date toll -->
    <td>{if $i->date_to}
            {$i->date_to|date_format:"%m/%d/%Y"}
        {/if}</td>

    <!-- Invoiced amount -->
    <td class="td_price">{if ($i->month=='this' || $show_price) && $i->total_price>0}
            $ {$i->total_price|convert}
        {/if}</td>

    <!-- Invoice paid -->
    <td class="td_price" d="{$show_paid}">{if $i->paid && ((!$i->paid_m || $i->paid_m=='this_month') && ($i->total_price>0 || $i->total_paid_price>0) || $show_paid)}
            {if $i->total_paid_price>0}
                $ {$i->total_paid_price|convert}
            {elseif $t->type!='total' || $show_paid}
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
        {elseif !$i->paid && $i->total_price>0 && $t->type!='total' || $show_unpaid}
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
                    <td>Move-in</td>
                    <td>Move-out</td>
                    <td>Days</td>
                    {*<td>Days in month</td>*}
                    <td>Status</td>
                    <td>Commitment Income</td>
                    {*<td>Commitment this month income</td>
                    <td>Av. rent per month</td>*}
                    <td>ADR</td>

                    <td class="ll"></td>

                    <td>Invoice ID</td>
                    <td>Date from</td>
                    <td>Date till</td>
                    <td>Accrual Based</td>
                    <td>Cash Based</td>

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
                                {$rowspan=$t->room->rows}
                                {if $apartments[$t->apartment->id]->rooms[$t->room->id]->beds_invoices_count && $apartments[$t->apartment->id]->rooms[$t->room->id]->beds_invoices_count < $rowspan}
                                    {$rowspan=$apartments[$t->apartment->id]->rooms[$t->room->id]->beds_invoices_count}
                                {/if}
                                <td{if $rowspan>1} rowspan="{$rowspan}"{/if}  data-rr="{$apartments[$t->apartment->id]->rooms[$t->room->id]->beds_invoices_count}">
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
                    <td colspan="7"></td>
                    <td class="td_price">
                        {if $params->grand_total->adr_adv}
                            $ {$params->grand_total->adr_adv}
                        {/if}
                    </td>
                    <td colspan="4"></td>

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
                        {if $params->grand_total->price_invoices}
                            <tr>
                                <td>Invoiced Amount Current Month</td>
                                <td class="val">$ {$params->grand_total->price_invoices|round|convert}</td>
                            </tr>
                        {/if}

                        {if $params->grand_total->price_paid_invoices || $params->other_period_total->price_paid}
                            <tr class="ll">
                                <td colspan="2"></td>
                            </tr>
                            <tr class="rs_invoice_total_paid hd">
                                <td>Total Paid Current Month</td>
                                <td class="val">$ <span class="sum">{($params->grand_total->price_paid_invoices|round+$params->other_period_total->price_paid|round)|convert}</span></td>
                            </tr>
                        {/if}

                        {if $params->grand_total->price_paid_invoices}
                            <tr class="rs_invoice_paid">
                                <td>Invoice Paid Current Month</td>
                                <td class="val">$ <span class="sum">{$params->grand_total->price_paid_invoices|round|convert}</span></td>
                            </tr>
                        {/if}
                        {if $params->other_period_total->price_paid}
                            <tr class="rs_other_period">
                                <td>Invoice Paid Other Period</td>
                                <td class="val">$ <span class="sum">{$params->other_period_total->price_paid|round|convert}</span></td>
                            </tr>
                        {/if}

                        {if $params->grand_total->price_paid_invoices || $params->other_period_total->price_paid}
                            <tr class="ll">
                                <td colspan="2"></td>
                            </tr>
                        {/if}


                        {$occupancy_val=$occupancy->occupancy}
                        {if $occupancy_val>100}
                            {$occupancy_val=100}
                        {/if}

                        <tr>
                            <td>Occupancy</td>
                            <td class="val">{$occupancy_val}%</td>
                        </tr>
                        {if $params->grand_total->adr_adv}
                            <tr>
                                <td>ADR</td>
                                <td class="val">$ {$params->grand_total->adr_adv}</td>
                            </tr>
                        {/if}

                        {if $params->debt_invoices->price}
                            <tr>
                                <td>Debt</td>
                                <td class="val">$ {$params->debt_invoices->price|convert}</td>
                            </tr>
                        {/if}

                        {if $params->cost->price > 0}
                            <tr>
                                <td>Expenses</td>
                                <td class="val">
                                    $ {$params->cost->price|convert}
                                </td>
                            </tr>

                            <tr class="net_operating_income_block">
                                <td>Net Operating Income</td>
                                <td class="val">$ <span class="sum">{$params->net_operating_income|round|convert}</span></td>
                            </tr>
                        {/if}


                    </table>
                </div><!-- table_r -->
            </div><!-- rentroll_cont_bx2 -->
            
        </div><!-- w1300 -->


        {if $other_period_invoices}

            <div class="w1300">
                <div class="rentroll_cont_bx2">
                    <h2 class="title2">Other period</h2>
                </div>
            </div><!-- w1300 -->


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
                        <td>Move-in</td>
                        <td>Move-out</td>
                        <td>Days</td>
                        <td>Status</td>
                        <td>Commitment Income</td>
                        <td>ADR</td>

                        <td class="ll"></td>

                        <td>Invoice ID</td>
                        <td>Date from</td>
                        <td>Date till</td>
                        <td>Invoiced amount</td>
                        <td>Invoice paid</td>

                    </tr>

                    <tr><td class="bl" colspan="19"></td></tr>

                    {foreach $other_period_invoices as $i}
                        <tr>
                            <td>
                                {$apartments[$i->booking->apartment_id]->name}
                            </td>
                            {if $i->booking->type==1}
                                <td>{$apartments[$i->booking->apartment_id]->rooms[$i->booking->room_id]->name}</td>
                                <td>{$apartments[$i->booking->apartment_id]->rooms[$i->booking->room_id]->beds[$i->booking->object_id]->name}</td>
                            {elseif $i->booking->type==2}
                                <td colspan="2">Full apartment</td>
                            {/if}
                            {tr i=$i show_price=$i->show_price show_paid=1}
                        </tr>
                    {/foreach}

                    <tr><td class="bl" colspan="19"></td></tr>

                    <tr class="tr_gtotal">
                    <td colspan="4"></td>
                    <td colspan="9"></td>
                    <td colspan="3"></td>

                    <td class="td_price">
                        {if $params->other_period_total->price}
                            $ {$params->other_period_total->price|convert}
                        {/if}
                    </td>
                    <td class="td_price">
                        {if $params->other_period_total->price_paid}
                            $ {$params->other_period_total->price_paid|convert}
                        {/if}
                    </td>
                </tr>
                </table>
            </div><!-- table_r -->


        {/if}





        {if $debt_invoices}

            <div class="w1300">
                <div class="rentroll_cont_bx2">
                    <h2 class="title2">Debt</h2>
                </div>
            </div><!-- w1300 -->


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
                        <td>Move-in</td>
                        <td>Move-out</td>
                        <td>Days</td>
                        <td>Status</td>
                        <td>Commitment Income</td>
                        <td>ADR</td>

                        <td class="ll"></td>

                        <td>Invoice ID</td>
                        <td>Date from</td>
                        <td>Date till</td>
                        <td>Invoiced amount</td>
                        <td>Invoice paid</td>

                    </tr>

                    <tr><td class="bl" colspan="19"></td></tr>

                    {foreach $debt_invoices as $i}
                        <tr>
                            <td>
                                {$apartments[$i->booking->apartment_id]->name}
                            </td>
                            {if $i->booking->type==1}
                                <td>{$apartments[$i->booking->apartment_id]->rooms[$i->booking->room_id]->name}</td>
                                <td>{$apartments[$i->booking->apartment_id]->rooms[$i->booking->room_id]->beds[$i->booking->object_id]->name}</td>
                            {elseif $i->booking->type==2}
                                <td colspan="2">Full apartment</td>
                            {/if}
                            {tr i=$i show_price=1 show_unpaid=1}
                        </tr>
                    {/foreach}

                    <tr><td class="bl" colspan="19"></td></tr>

                    <tr class="tr_gtotal">
                    <td colspan="4"></td>
                    <td colspan="9"></td>
                    <td colspan="3"></td>

                    <td class="td_price">
                        {if $params->debt_invoices->price}
                            $ {$params->debt_invoices->price|convert}
                        {/if}
                    </td>
                    <td class="td_price">
                        
                    </td>
                </tr>
                </table>
            </div><!-- table_r -->


        {/if}

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
