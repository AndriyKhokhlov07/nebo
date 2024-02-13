
{$apply_button_hide=1 scope=parent}
{$members_menu=1 scope=parent}


<link href="design/{$settings->theme|escape}/css/landlord/landlord.css?v1.0.18" rel="stylesheet">
<link id="to_ptint_css" href="design/{$settings->theme|escape}/css/landlord/print_rentroll.css?v1.0.2" rel="stylesheet">

{if $houses|count > 1}
    {$nav_url = 'landlord/rentroll2/'}
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
                {* not The Mason on Chestnut - Philadelphia *}
                {if $selected_house->id != 349}
                <div class="filter_item">
                    <div class="filter_head">
                        <div class="title">
                            {if $smarty.get.view=='rent_arrears'}
                                Rent Arrears
                            {else}
                                Invoice Based Rent Roll
                            {/if}
                        </div>
                        <div class="select_block">
                            <div class="wrapper">
                                <div class="option_group">
                                    <div class="option">
                                        <a href="/landlord/rentroll2/{$selected_house->main_id}{if $smarty.get.month}?month={$smarty.get.month}{/if}">
                                            Invoice Based Rent Roll
                                        </a>
                                    </div>
                                    <div class="option">
                                        <a href="/landlord/rentroll/{$selected_house->main_id}{if $smarty.get.month}?month={$smarty.get.month}{/if}">
                                            Prorated Monthly Rent Roll
                                        </a>
                                    </div>
                                    <div class="option">
                                        <a href="/landlord/rentroll2/{$selected_house->main_id}?view=rent_arrears{if $smarty.get.month}&month={$smarty.get.month}{/if}">
                                            Rent Arrears
                                        </a>
                                    </div>
                                </div><!-- option_group -->
                            </div><!-- wrapper -->
                        </div><!-- select_block -->
                    </div><!-- filter_head -->
                </div><!-- filter_item -->
                {/if}

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


            

            
            {if $data->is_cache}
            <div class="fx">

                {* {if $data->is_cache}
                    <div class="date_info" style="margin-right:50px">
                        <i class="fa fa-calendar"></i>
                        {if $log_save}
                            {$log_save->date|date_format:"%B %e, %Y"}
                        {else}
                            {$data->cache_date|date_format:"%B %e, %Y"}
                        {/if}
                    </div>
                {/if} *}

                <div class="download_zip_button fx" id="to_print" data-title1="Rent Roll Analysis - {$params->now_month|date_format:'%B %Y'}" data-title2="Property: {$selected_house->llc_name} {$smarty.now|date_format:'%m/%d/%Y'}" data-title3="{$selected_house->blocks2['address']}">
                    <span>Print / Download</span>
                    <i class="icon"></i>
                </div>
            </div>
            {/if}
            
        </div><!-- fx -->


    </div><!-- w1300 -->
    
{if $data->is_cache || 1}
    <div class="w_max">


{function name=tr}
    <!-- Tenant -->
    <td class="tenants_name_td">
        {if $i->booking->users}
            <div class="tenants_name"{if $i->booking->users|count>1} title="{foreach $i->booking->users as $u}{$u->name|escape}{if !$u@last}, {/if}{/foreach}"{/if}>
                {foreach $i->booking->users as $u}{$u->name|escape}{if !$u@last}, {/if}{/foreach}
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
            {elseif $i->type=='houseleader'}
                <div class="badge">Houseleader</div>
            {/if}
        {/if}</td>

    <!-- Move in -->
    <td>{if $i->contract}
            {$i->contract->date_from|date_format:"%m/%d/%Y"}
        {elseif $i->booking->arrive}
            {$i->booking->arrive|date_format:"%m/%d/%Y"}
        {/if}</td>

    <!-- Move out -->
    <td>{if $i->contract}
            {$i->contract->date_to|date_format:"%m/%d/%Y"}
        {elseif $i->booking->depart}
            {$i->booking->depart|date_format:"%m/%d/%Y"}
        {/if}</td>

    <!-- Days count -->
    <td>{if $i->contract}
            {$i->contract->days_count}
        {elseif $i->booking}
            {$i->booking->days_count}
        {/if}</td>

    {*
    <!-- Days in month -->
    <td>{if $i->booking}
            {$i->booking->days_in_month}
        {/if}</td>
    *}

    {*
    <!-- Status -->
    <td>{if $i->booking}{if $i->child_refund_id}
        <div class="badge red">Refunded</div>{elseif $i->new}
        <div class="badge">New</div>
        {elseif $i->extension}  
        <div class="badge">Ext</div>
        {/if}{/if}
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
    *}

    <!-- Commitment Income -->
    <td class="td_price">
        {if $i->contract}
            $ {$i->contract->total_price|number_format:2:'.':''}
        {elseif $i->booking && $i->booking->total_price>0}
            $ {$i->booking->total_price|number_format:2:'.':''}
        {/if}
    </td>

    <!-- Utility -->
    <td class="td_price">
        {if $i->contract}
            $ {$i->contract->price_utility_total|number_format:2:'.':''}
        {/if}
    </td>

    {*
    <!-- Commitment this month income -->
    <td class="td_price">{if $i->booking}
            {if $i->booking->price_month_income>0}
                $ {$i->booking->price_month_income|round}
            {elseif $t->type!='total'}
                –
            {/if}
        {/if}</td>

    <!-- Av. rent per month -->
    <td class="td_price">{if $i->booking && $i->booking->price_month>0}
            $ {$i->booking->price_month|round}
        {/if}</td>
    *}

    <!-- Av. rent per night -->
    <td class="td_price">{if $i->booking && $i->booking->price_day>0}
            $ {$i->booking->price_day|number_format:2:'.':''}
        {/if}</td>

    <td class="ll"></td>

    <!-- Invoice ID -->
    <td>{if $i->id}<span class="invoice_name" title="{if $i->sku}{$i->sku}{elseif $i->id}{$i->id}{/if}">{if $i->sku}{$i->sku}{elseif $i->id}{$i->id}{/if}</span>{/if}</td>

    <!-- Date from -->
    <td>{if $i->date_from}
            {$i->date_from|date_format:"%m/%d/%Y"}
        {/if}</td>

    <!-- Date toll -->
    <td>{if $i->date_to}
            {$i->date_to|date_format:"%m/%d/%Y"}
        {/if}</td>

    <!-- Days count -->
    <td>{if $i->days_count}
        {$i->days_count}
    {/if}</td>

    <!-- Invoices Sent (Accrual) -->
    <td class="td_price">{if ($i->month=='this' || $show_price) && $i->total_price>0}
            $ {$i->total_price|number_format:2:'.':''}
        {/if}</td>

    <!-- Invoices Paid (Cash) -->
    <td class="td_price" d="{$show_paid}">{if $i->paid && ((!$i->paid_m || $i->paid_m=='this_month') && ($i->total_price>0 || $i->total_paid_price>0) || $show_paid)}
            {if $i->total_paid_price>0}
                $ {$i->total_paid_price|number_format:2:'.':''}
            {elseif $t->type!='total' || $show_paid}
                $ {$i->total_price|number_format:2:'.':''}
            {/if}
        {elseif $i->paid && $i->paid_m=='past'}
            <div class="badge">in <a href="{url month=$i->payment_date|date_format:'%m-%Y'}#other_period">{$i->payment_date|date_format:'%B'}</a></div>
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
            $ {$i->total_price}
        {elseif !$i->paid && $i->total_price>0 && $t->type!='total' || $show_unpaid}
            <div class="badge red">Unpaid</div>
        {/if}</td>



    {*
    {if !$is_debt}
    <!-- Paid date -->
    <td>{if $i->payment_date && !$i->payment_date_generated}
            {$i->payment_date|date_format:"%m/%d/%Y"}
        {/if}</td>
    {/if}
    *}

    {*
    {if !$hide_purchases_price}
        <td class="td_price">{if $i->purchases_price && ($i->paid && $i->paid_m=='this_month')}$ {$i->purchases_price|round}{/if}</td>
    {/if}
    {if !$hide_utilites}
        <td class="td_price">{if $i->purchases_utilites_price && ($i->paid && $i->paid_m=='this_month')}$ {$i->purchases_utilites_price|round}{/if}</td>
    {/if}
    *}


    {if !$hide_bf_to}
        <td class="ll"></td>

        <!-- Broker Fee -->
        <td class="td_price brokerfee_price">{if $i->isset_broker_fee}
            $ <span>{$i->booking->broker_fee}</span>
        {/if}</td>

        
        <td>{if $i->isset_broker_fee && $t->type!='total'}
            <div class="brokerfee_discount_bx">
                <div class="wrapper">
                    <input class="brokerfee_discount" type="text" name="brokerfee_discount" value="{$i->booking->brokerfee_discount|round}">
                </div>
            </div>
        {/if}</td>

        <!-- Broker Fee Paid -->
        <td class="td_price broker_fee_result_bx">{if $i->isset_broker_fee}
            $ <span>{$i->booking->broker_fee_paid|round}</span>
        {/if}</td>

    
        <td class="ll"></td>

        <!-- To owner | Sended -->
        <td>{if $t->type!='total' && $i->id && $i->paid && $i->paid_m!='future' && $i->booking->client_type_id!=2}            
            {if $i->sended_owner}
                <div class="badge">Sent</div>
            {elseif $i->paid_m=='this_month' && !$i->child_refund_id}
                <input type="checkbox" name="owner[{$i->id}][sended]" value="{$i->price|round}">
            {/if}
        {elseif $t->type!='total' && $i->booking->client_type_id==2}
            <span class="sm">Airbnb</span>
        {/if}</td>

        <!-- To owner | Date -->
        <td class="so_date {if $i->sended_owner}sended_owner{/if}" data-invoice_id="{$i->id}">{if $t->type!='total' && $i->id && $i->paid && $i->paid_m!='future' && $i->booking->client_type_id!=2 && !$i->child_refund_id}
            {if $i->sended_owner || ($i->paid_m=='this_month' && !$i->child_refund_id)}
            <div class="wrapper">
                <input class="date_input" type="text" name="owner[{$i->id}][date]" value="{$i->sended_owner_date|date_format:"%m/%d/%Y"}">
            </div>
            {/if}
        {/if}</td>

    {/if}

{/function}


    <div id="print_bx">
    {if $smarty.get.view!='rent_arrears'}
        <div class="table_r">
            <table>
                <tr class="tr_h">
                    <td colspan="3">Basic information</td>
                    <td class="ll"></td>
                    <td colspan="7">Contract</td>
                    <td class="ll"></td>
                    <td colspan="6">Monthly invoice</td>
                    {*
                    <td class="ll"></td>
                    <td colspan="3">Broker Fee</td>
                    <td class="ll"></td>
                    <td colspan="2">To owner</td>
                    *}
                </tr>
                <tr class="tr_h st">
                    <td>Apartment</td>
                    {* <td>Room</td> *}
                    <td>Bed</td>
                    <td>Tenant</td>

                    <td class="ll"></td>

                    <td>Contract ID</td>
                    <td>Move-in</td>
                    <td>Move-out</td>
                    <td>Days</td>
                    {*<td>Days in month</td>*}
                    {*<td>Status</td>*}
                    <td>Commitment Income</td>
                    <td>Utility</td>
                    {*<td>Commitment this month income</td>
                    <td>Av. rent per month</td>*}
                    <td>ADR</td>

                    <td class="ll"></td>

                    <td>Invoice ID</td>
                    <td>Date from</td>
                    <td>Date till</td>
                    <td>Days</td>
                    <td>Invoices Sent (Accrual)</td>
                    <td>Invoices Paid (Cash)</td>
                    {*
                    <td>Thereof rent</td>
                    <td>Thereof utilities</td>
                    *}

                    {*
                    <td class="ll"></td>
                    <td>Scheduled</td>
                    <td>Discount</td>
                    <td>BF paid</td>
                    <td class="ll"></td>
                    <td>Sent</td>
                    <td>Date</td>
                    *}
                </tr>

                <tr><td class="bl" colspan="18"></td></tr>

                {foreach $table as $k=>$t}
                    {if $t->apartment->invoices}
                        {foreach $t->apartment->invoices as $i}
                            <tr class="{if $i->month=='past'}past{/if}{if $i->type=='houseleader'} houseleader{/if}" data-k="t{$k}" data-apt_id="{$t->apartment->id}" {if $i->booking_id}data-booking_id="{$i->booking_id}"{/if}>
                            {if $t->apartment && $i@iteration==1}
                                <td class="apt_name strong r{$t->apartment->r}" {if $t->apartment->rows>1} rowspan="{$t->apartment->rows}"{/if}>
                                    {$t->apartment->name}
                                </td>
                            {/if}
                            <td class="td_price">Full apt</td>
                            {tr i=$i hide_bf_to=1}
                            </tr>
                        {/foreach}
                        
                    {/if}
                    {foreach $t->invoices as $i}
                        <tr class="{if $i->month=='past'}past{/if} {if $t->class}{$t->class}{/if}{if $i->type=='houseleader'} houseleader{/if}" data-k="t{$k}" {if $t->type=='total'}data-total_apt="{$t->apartment->id}"{else}data-apt_id="{$t->apartment->id}"{/if} {if $i->booking_id}data-booking_id="{$i->booking_id}"{/if}>
                            {if $t->apartment->name && $i@iteration==1 && !$t->apartment->invoices}
                                <td class="apt_name strong r{$t->apartment->r}"{if $t->apartment->rows>1} rowspan="{$t->apartment->rows}"{/if}>
                                    {$t->apartment->name}
                                </td>
                            {/if}
                            {*
                            {if $t->room->name && $i@iteration==1}
                                {$rowspan=$t->room->rows}
                                {if $apartments[$t->apartment->id]->rooms[$t->room->id]->beds_invoices_count && $apartments[$t->apartment->id]->rooms[$t->room->id]->beds_invoices_count < $rowspan && !$params->show_empty_rows}
                                    {$rowspan=$apartments[$t->apartment->id]->rooms[$t->room->id]->beds_invoices_count}
                                {/if}
                                <td{if $rowspan>1} rowspan="{$rowspan}"{/if}  data-rr="{$apartments[$t->apartment->id]->rooms[$t->room->id]->beds_invoices_count}">
                                    {$t->room->name}
                                </td>
                            {/if}
                            *}
                            {if $t->bed->name && $i@iteration==1}
                                <td{if $t->bed->rows>1} rowspan="{$t->bed->rows}"{/if}>
                                    {$t->bed->name}
                                </td>
                            {/if}
                            {tr i=$i hide_bf_to=1}
                        </tr>
                    {/foreach}

                    {if $t->type == 'total'}
                        <tr><td class="bl" colspan="18"></td></tr>
                    {/if}
                {/foreach}

                <tr class="tr_gtotal">
                    <td colspan="3">Grand total</td>
                    <td colspan="7"></td>
                    <td class="td_price">
                        {if $data->grand_total->adr_adv}
                            $ {$data->grand_total->adr_adv|number_format:2:'.':''}
                        {/if}
                    </td>
                    <td colspan="5"></td>

                    {*
                    <td colspan="7"></td>
                    <td class="td_price">
                        {if $data->grand_total->price_month_income}
                            $ {$data->grand_total->price_month_income|number_format:2:'.':''}
                        {/if}
                    </td>
                    <td class="td_price">
                        {if $data->grand_total->price_rent_month}
                            $ {$data->grand_total->price_rent_month|number_format:2:'.':''}
                        {/if}
                    </td>
                    <td class="td_price">
                        {if $data->grand_total->price_rent_day}
                            $ {$data->grand_total->price_rent_day|number_format:2:'.':''}
                        {/if}
                    </td>
                    <td colspan="4"></td>
                    *}
                    <td class="td_price">
                        {if $data->grand_total->price_invoices}
                            $ {$data->grand_total->price_invoices|number_format:2:'.':''}
                        {/if}
                    </td>
                    <td class="td_price">
                        {if $data->grand_total->price_paid_invoices}
                            $ {$data->grand_total->price_paid_invoices|number_format:2:'.':''}
                        {/if}
                    </td>
                    {*
                    <td class="td_price">
                        {if $data->grand_total->purchases_price}
                            $ {$data->grand_total->purchases_price|number_format:2:'.':''}
                        {/if}
                    </td>
                    <td class="td_price">
                        {if $data->grand_total->utilites_price}
                            $ {$data->grand_total->utilites_price|number_format:2:'.':''}
                        {/if}
                    </td>
                    *}
                    

                    {*
                    <td class="td_price">
                        {if $data->grand_total->broker_fee}
                            $ {$data->grand_total->broker_fee|number_format:2:'.':''}
                        {/if}
                    </td>
                    <td></td>
                    <td class="td_price broker_fee_result_bx">
                        {if $data->grand_total->broker_fee_paid}
                            $ <span>{$data->grand_total->broker_fee_paid|number_format:2:'.':''}</span>
                        {/if}
                    </td>
                    <td colspan="3"></td>
                    *}
                </tr>
            </table>
        </div><!-- table_r -->

        <div class="w1300 fx w">

            <div class="rentroll_cont_bx2">
                <h2 class="title2">Report Summary</h2>
                <div class="table_r ts1">
                    <table>
                        {if $data->grand_total->price_invoices}
                            <tr>
                                <td>Invoices Sent (Accrual) Current Month</td>
                                <td class="val">$ {$data->grand_total->price_invoices|round:2|convert}</td>
                            </tr>
                        {/if}

                        {if $data->grand_total->price_paid_invoices || $data->other_period_total->price_paid}
                            <tr class="ll">
                                <td colspan="2"></td>
                            </tr>
                            <tr class="rs_invoice_total_paid hd">
                                <td>Rent (cash basis)</td>
                                <td class="val">$ <span class="sum">{($data->grand_total->price_paid_invoices|round:2+$data->other_period_total->price_paid|round:2)|convert}</span></td>
                            </tr>
                        {/if}

                        {if $data->grand_total->price_paid_invoices}
                            <tr class="rs_invoice_paid">
                                <td>Invoices Paid (Cash) Current Month</td>
                                <td class="val">$ <span class="sum">{$data->grand_total->price_paid_invoices|round:2|convert}</span></td>
                            </tr>
                        {/if}
                        {if $data->other_period_total->price_paid}
                            <tr class="rs_other_period">
                                <td>Invoices Paid (Cash) Rent Prepaid</td>
                                <td class="val">$ <span class="sum">{$data->other_period_total->price_paid|round:2|convert}</span></td>
                            </tr>
                        {/if}

                        {if $data->grand_total->price_paid_invoices || $data->other_period_total->price_paid}
                            <tr class="ll">
                                <td colspan="2"></td>
                            </tr>
                        {/if}


                        {if $data->grand_total->purchases_price || $data->other_period->purchases_price}
                            <tr class="ll">
                                <td colspan="2"></td>
                            </tr>
                            {if $data->grand_total->purchases_price && $data->other_period->purchases_price}
                                <tr class="rs_invoice_total_paid hd">
                                    <td>Total Thereof rent</td>
                                    <td class="val">$ <span class="sum">{($data->grand_total->purchases_price|round:2+$data->other_period->purchases_price|round:2)|convert}</span></td>
                                </tr>
                            {/if}
                            {if $data->grand_total->purchases_price}
                                <tr>
                                    <td>Thereof rent Current Month</td>
                                    <td class="val">$ <span class="sum">{($data->grand_total->purchases_price|round)|convert}</span></td>
                                </tr>
                            {/if}
                            {if $data->other_period->purchases_price}
                                <tr>
                                    <td>Thereof rent Rent Prepaid</td>
                                    <td class="val">$ <span class="sum">{($data->other_period->purchases_price|round)|convert}</span></td>
                                </tr>
                            {/if}
                            <tr class="ll">
                                <td colspan="2"></td>
                            </tr>
                        {/if}


                        {if $data->grand_total->utilites_price || $data->other_period->utilites_price}
                            <tr class="ll">
                                <td colspan="2"></td>
                            </tr>
                            {if $data->grand_total->utilites_price && $data->other_period->utilites_price}
                                <tr class="rs_invoice_total_paid hd">
                                    <td>Total Thereof utilities</td>
                                    <td class="val">$ <span class="sum">{($data->grand_total->utilites_price|round:2+$data->other_period->utilites_price|round:2)|convert}</span></td>
                                </tr>
                            {/if}
                            {if $data->grand_total->utilites_price}
                                <tr>
                                    <td>Thereof utilities Current Month</td>
                                    <td class="val">$ <span class="sum">{($data->grand_total->utilites_price|round:2)|convert}</span></td>
                                </tr>
                            {/if}
                            {if $data->other_period->utilites_price}
                                <tr>
                                    <td>Thereof utilities Rent Prepaid</td>
                                    <td class="val">$ <span class="sum">{($data->other_period->utilites_price|round:2)|convert}</span></td>
                                </tr>
                            {/if}
                            <tr class="ll">
                                <td colspan="2"></td>
                            </tr>
                        {/if}




                        {$occupancy_val=$data->occupancy}
                        {if $occupancy_val>100}
                            {$occupancy_val=100}
                        {/if}

                        <tr>
                            <td>Occupancy</td>
                            <td class="val">{$occupancy_val}%</td>
                        </tr>
                        {if $data->grand_total->adr_adv}
                            <tr>
                                <td>ADR</td>
                                <td class="val">$ {$data->grand_total->adr_adv|number_format:2:'.':''}</td>
                            </tr>
                        {/if}

                        {if $data->debt_invoices->price}
                            <tr>
                                <td>Rent Arrears</td>
                                <td class="val">$ {$data->debt_invoices->price|convert}</td>
                            </tr>
                        {/if}

                        {if $data->cost->price > 0}
                            {*
                            <tr>
                                <td>Expenses</td>
                                <td class="val">
                                    $ {$data->cost->price|convert}
                                </td>
                            </tr>
                            *}

                            <tr class="net_operating_income_block">
                                <td>Net Operating Income</td>
                                <td class="val">$ <span class="sum">{$data->net_operating_income|round:2|convert}</span></td>
                            </tr>
                        {/if}


                    </table>
                </div><!-- table_r -->
            </div><!-- rentroll_cont_bx2 -->
            
            
            
            <div class="rentroll_cont_bx2" style="margin-left: 40px;">
				<h2 class="title2">Invoices</h2>
				<div class="table_r ts1">
                    <table>
						<tr class="hd">
							<td>Status</td>
							<td class="val">Amount</td>
							<td class="val">Sum</td>
						</tr>
						<tr>
							<td>Sent</td>
							<td class="val">
								{if $data->grand_total->sent_invoices_amount}
									{$data->grand_total->sent_invoices_amount}
								{else}
									–
								{/if}
							</td>
							<td class="val">
								{if $data->grand_total->price_invoices}
									$ {$data->grand_total->price_invoices|number_format:2:'.':''}
								{else}
									–
								{/if}
							</td>
						</tr>
						<tr>
							<td>Paid</td>
							<td class="val">
								{if $data->grand_total->paid_invoices_amount}
									{$data->grand_total->paid_invoices_amount}
								{else}
									–
								{/if}
							</td>
							<td class="val">
								{if $data->grand_total->price_paid_invoices}
									$ {$data->grand_total->price_paid_invoices|number_format:2:'.':''}
								{else}
									–
								{/if}
							</td>
						</tr>
						<tr>
							<td>Unpaid</td>
							<td class="val">
								{if $data->grand_total->unpaid_invoices_amount}
									{$data->grand_total->unpaid_invoices_amount}
								{else}
									–
								{/if}
							</td>
							<td class="val">
								{if $data->grand_total->price_unpaid_invoices}
									$ {$data->grand_total->price_unpaid_invoices|number_format:2:'.':''}
								{else}
									–
								{/if}
							</td>
						</tr>
					</table>
				</div>
			</div>


            {if $data->past_paid || $data->grand_total->price_paid_invoices}
                <div class="rentroll_cont_bx2" style="margin-left: 40px;">
                    <h2 class="title2">Paid invoices for current period</h2>
                    <div class="table_r ts1">
                        <table>
                            <tr class="hd">
                                <td>Month</td>
                                {*<td>Amount</td>*}
                                <td class="val">Sum</td>
                            </tr>
                            {if $data->grand_total->price_paid_invoices}
                            <tr>
                                <td>{$params->now_month|date_format:'%B'}</td>
                                <td class="val">$ {$data->grand_total->price_paid_invoices|convert}</td>
                            </tr>
                            {/if}
                            {if $data->past_paid}
                                {foreach $data->past_paid as $d=>$v}
                                    <tr>
                                        <td>{$d|date_format:'%B'}</td>
                                        {*<td>{$v->amount}</td>*}
                                        <td class="val">$ {$v->total_price|convert}</td>
                                    </tr>
                                {/foreach}
                                <tr class="tr_total hd">
                                    <td></td>
                                    <td class="val">$ {$data->grand_total->total_price_paid_invoices|convert}</td>
                                </tr>
                            {/if}
                        </table>
                    </div>
                </div>
            {/if}
            
        </div><!-- w1300 -->


        {if $other_period_invoices}

            <div class="w1300">
                <div class="rentroll_cont_bx2">
                    <h2 class="title2">Rent Prepaid</h2>
                </div>
            </div><!-- w1300 -->


            <div class="table_r">
                <table class="other_period_table">
                    
                    <tr class="tr_h">
                        <td colspan="3">Basic information</td>
                        <td class="ll"></td>
                        <td colspan="7">Contract</td>
                        <td class="ll"></td>
                        <td colspan="6">Monthly invoice</td>
                        {*
                        <td class="ll"></td>
                        <td colspan="3">Broker Fee</td>
                        <td class="ll"></td>
                        <td colspan="2">To owner</td>
                        *}
                    </tr>
                    <tr class="tr_h st">
                        <td>Apartment</td>
                        <td>Bed</td>
                        <td>Tenant</td>

                        <td class="ll"></td>

                        <td>Contract ID</td>
                        <td>Move-in</td>
                        <td>Move-out</td>
                        <td>Days</td>
                        {*<td>Status</td>*}
                        <td>Commitment Income</td>
                        <td>Utility</td>
                        <td>ADR</td>

                        <td class="ll"></td>

                        <td>Invoice ID</td>
                        <td>Date from</td>
                        <td>Date till</td>
                        <td>Days</td>
                        <td>Invoices Sent (Accrual)</td>
                        <td>Invoices Paid (Cash)</td>
                        {*
                        <td>Thereof rent</td>
                        <td>Thereof utilities</td>
                        *}

                        {*
                        <td class="ll"></td>
                        <td>Scheduled</td>
                        <td>Discount</td>
                        <td>BF paid</td>

                        <td class="ll"></td>
                        <td>Sent</td>
                        <td>Date</td>
                        *}
                    </tr>

                    <tr><td class="bl" colspan="18"></td></tr>

                    {foreach $other_period_invoices as $i}
                        <tr data-apartment_id="{$i->booking->apartment_id}" data-booking_id="{$i->booking->id}">
                            <td>
                                {$apartments[$i->booking->apartment_id]->name}
                            </td>
                            {if $i->booking->type==1}
                                <td>{$apartments[$i->booking->apartment_id]->rooms[$i->booking->room_id]->beds[$i->booking->object_id]->name}</td>
                            {elseif $i->booking->type==2}
                                <td class="td_price">Full apt</td>
                            {/if}
                            {$t='data'}
                            {tr i=$i show_price=$i->show_price show_paid=1 hide_bf_to=1}
                        </tr>
                    {/foreach}

                    <tr><td class="bl" colspan="18"></td></tr>

                    <tr class="tr_gtotal">
                    <td colspan="3"></td>
                    <td colspan="9"></td>
                    <td colspan="4"></td>

                    <td class="td_price">
                        {if $data->other_period_total->price}
                            $ {$data->other_period_total->price|number_format:2:'.':''}
                        {/if}
                    </td>
                    <td class="td_price">
                        {if $data->other_period_total->price_paid}
                            $ {$data->other_period_total->price_paid|number_format:2:'.':''}
                        {/if}
                    </td>
                    {*
                    <td class="td_price">
                        {if $data->other_period->purchases_price}
                            $ <span>{$data->other_period->purchases_price|number_format:2:'.':''}</span>
                        {/if}
                    </td>
                    <td class="td_price">
                        {if $data->other_period->utilites_price}
                            $ <span>{$data->other_period->utilites_price|number_format:2:'.':''}</span>
                        {/if}
                    </td>

                    <td></td>
                    <td class="td_price">
                        {if $data->other_period_total->broker_fee}
                            $ <span>{$data->other_period_total->broker_fee|number_format:2:'.':''}</span>
                        {/if}
                    </td>

                    <td></td>

                    <td class="td_price broker_fee_result_bx">
                        {if $data->other_period_total->broker_fee_paid}
                            $ <span>{$data->other_period_total->broker_fee_paid|number_format:2:'.':''}</span>
                        {/if}
                    </td>

                    <td colspan="3"></td>
                    *}
                </tr>
                </table>
            </div><!-- table_r -->


        {/if}
    {/if}



    {if $smarty.get.view=='rent_arrears'}

        <div class="w1300">
            <div class="rentroll_cont_bx2">
                <h2 class="title2">Rent Arrears</h2>
            </div>
        </div><!-- w1300 -->

        {if $debt_invoices}
            <div class="table_r">
               <table>
                    <tr class="tr_h">
                        <td colspan="3">Basic information</td>
                        <td class="ll"></td>
                        <td colspan="7">Contract</td>
                        <td class="ll"></td>
                        <td colspan="6">Monthly invoice</td>
                    </tr>
                    <tr class="tr_h st">
                        <td>Apartment</td>
                        <td>Bed</td>
                        <td>Tenant</td>

                        <td class="ll"></td>

                        <td>Contract ID</td>
                        <td>Move-in</td>
                        <td>Move-out</td>
                        <td>Days</td>
                        {*<td>Status</td>*}
                        <td>Commitment Income</td>
                        <td>Utility</td>
                        <td>ADR</td>

                        <td class="ll"></td>

                        <td>Invoice ID</td>
                        <td>Date from</td>
                        <td>Date till</td>
                        <td>Days</td>
                        <td>Invoices Sent (Accrual)</td>
                        <td>Invoices Paid (Cash)</td>
                    </tr>

                    <tr><td class="bl" colspan="18"></td></tr>

                    {foreach $debt_invoices as $i}
                        <tr>
                            <td>
                                {$apartments[$i->booking->apartment_id]->name}
                            </td>
                            {if $i->booking->type==1}
                                <td>{$apartments[$i->booking->apartment_id]->rooms[$i->booking->room_id]->beds[$i->booking->object_id]->name}</td>
                            {elseif $i->booking->type==2}
                                <td class="td_price">Full apt</td>
                            {/if}
                            {tr i=$i show_price=1 show_unpaid=1 hide_bf_to=1 is_debt=1 hide_utilites=1 hide_purchases_price=1}
                        </tr>
                    {/foreach}

                    <tr><td class="bl" colspan="18"></td></tr>

                    <tr class="tr_gtotal">
                    <td colspan="3"></td>
                    <td colspan="9"></td>
                    <td colspan="4"></td>

                    <td class="td_price">
                        {if $data->debt_invoices->price}
                            $ {$data->debt_invoices->price|number_format:2:'.':''}
                        {/if}
                    </td>
                    <td class="td_price">
                        
                    </td>

                </tr>
                </table>
            </div><!-- table_r -->


            {else}
                <div class="w1300">
                    <p>No data to show</p>
                </div>
            {/if}
        {/if}

        </div><!-- print_bx -->
            
    </div><!-- w_max -->
    {else}
    <div class="w1300">
        <div style="padding: 30px 20px 50px">
            No data are available
        </div>
    </div>
    {/if}



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
