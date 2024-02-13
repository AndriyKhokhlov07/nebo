
{$apply_button_hide=1 scope=parent}
{$members_menu=1 scope=parent}


<link href="design/{$settings->theme|escape}/css/landlord.css?v1.0.25" rel="stylesheet">


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


    <!-- Days in month -->
    <td>{if $i->booking}
            {$i->booking->days_in_month}
        {/if}</td>

    <!-- New -->
    <td>{if $i->booking && $i->booking->new}
        <div class="badge">Yes</div>  
        {/if}</td>

    <!-- Commitment Income -->
    <td class="td_price">{if $i->booking && $i->booking->total_price>0}
            $ {$i->booking->total_price|convert}
        {/if}</td>

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
    <td class="td_price">{if $i->total_price>0}
            $ {$i->total_price|convert}
        {/if}</td>

    <!-- Invoice paid -->
    <td class="td_price">{if $i->paid && ($i->total_price>0 || $i->total_paid_price>0)}
            {if $i->total_paid_price>0}
                $ {$i->total_paid_price|convert}
            {else}
                $ {$i->total_price|convert}
            {/if}
        {elseif !$i->paid && $i->total_price>0 && $t->type!='total'}
            <div class="badge red">Not paid</div>
        {/if}</td>

{/function}



        <div class="table_r">
            <table>
                <tr class="tr_h">
                    <td colspan="4">Basic information</td>
                    <td class="ll"></td>
                    <td colspan="10">Contract</td>
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
                    <td>Days in month</td>
                    <td>New</td>
                    <td>Commitment Income</td>
                    <td>Commitment this month income</td>
                    <td>Av. rent per month</td>
                    <td>Av. price per night</td>

                    <td class="ll"></td>

                    <td>Invoice ID</td>
                    <td>Date from</td>
                    <td>Date till</td>
                    <td>Invoiced amount</td>
                    <td>Invoice paid</td>

                </tr>

                <tr><td class="bl" colspan="21"></td></tr>

                {foreach $table as $t}
                    {if $t->apartment->invoices}
                        
                        
                        {foreach $t->apartment->invoices as $i}
                            <tr>
                            {if $t->apartment && $i@iteration==1}
                                <td class="strong" {if $t->apartment->rows>1} rowspan="{$t->apartment->rows}"{/if}>
                                    {$t->apartment->name}
                                </td>
                            {/if}
                            <td colspan="2">Full apartment</td>
                            {tr i=$i}
                            </tr>
                        {/foreach}
                        
                    {/if}
                    {foreach $t->invoices as $i}
                        <tr{if $t->class} class="{$t->class}"{/if}>
                            {if $t->apartment->name && $i@iteration==1 && !$t->apartment->invoices}
                                <td class="strong"{if $t->apartment->rows>1} rowspan="{$t->apartment->rows}"{/if}>
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
                        <tr><td class="bl" colspan="21"></td></tr>
                    {/if}
                {/foreach}

                <tr class="tr_gtotal">
                    <td colspan="4">Grand total</td>


                    <td colspan="8"></td>
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
        </div><!-- table -->
            
    </div><!-- w_max -->

</div><!-- page_wrapper -->