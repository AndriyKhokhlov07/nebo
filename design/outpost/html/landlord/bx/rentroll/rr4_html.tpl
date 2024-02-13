{if $smarty.get.f=='pdf'}
<style>

@page{ 
    margin: 10px;
}
body{
    margin: 0px;
}
p{
    padding: 0;
    margin: 0 0 2px;
}
.table_r.ts1 table,
tbody
{
    page-break-inside: avoid;
}

div,
table{
    font-size: 6px;
}

.table_r .tr_h td,
.table_r .tr_total td,
.table_r .tr_gtotal td{
    background: #dbdbe6;
    font-weight: 800;
}
table{
    border-collapse: collapse;
    border-spacing: 0;
    margin: 10px 0;
}
.table_r td{
    border: #000 0.3px solid;
    font-size: 6px;
    text-align: center;
    padding: 1px;
}
.table_r table td.ll{
    background: #fff;
    border: none;
    padding: 0.7px;
}
.table_r.ll_n table{
    width: 100%;
}
.table_r.ts1 table{
    background: #f3f1ef;
    width: auto;
    min-width: 200px;
}
.table_r.ts1 .td_name{
    text-align: left;
}
.table_r.ts1 .val{
    font-weight: 600;
}
.tenants_name{
    white-space: nowrap;
}
</style>
{/if}


<div class="w_max_">
    {if $smarty.get.f=='pdf'}
        <h3>Rent Roll</h3>
        {* <p>Prepared On: {$smarty.now|date_format:'%m/%d/%Y'}</p> *}
        <p>Properties: {$selected_house->blocks2['address']}</p>
        {*<p>Units: Active</p>*}
        <p>As of: {$params->now_month|date_format:'%B %Y'}</p>
        {*<p>Include Non-Revenue Units: No</p>*}
    {/if}
    
    <div class="table_r ll_n">
        <table>
            {*
                <tr class="tr_h">
                    <td colspan="4"></td>
                    <td class="ll"></td>
                    <td colspan="{if $smarty.get.f}11{else}12{/if}">{$params->now_month|date_format:'%B'}</td>
                </tr>
            *}
            <tr class="tr_h st">
                <td>Unit / Bed</td>
                <td>Room Type</td>
                <td>Unit Type</td>
                <td>BRs</td>
                {*<td>Unit Gross Rent</td>*}

                <td class="ll"></td>

                <td>Monthly Rate*</td>
                <td>Status</td>
                <td>
                    {if $days_units=='nights'}
                        Nights
                    {else}
                        Days
                    {/if}
                </td>
                <td>Monthly Rent (Accrued)*</td>

                {if !$smarty.get.f}
                    <td>Invoice number</td>
                {/if}

                <td>Monthly Rent (Accrued) - Paid Amount</td>
                <td>Date Paid (Month)</td>
                <td>Utilities Included in Monthly Rent</td>
                <td>Concessions Included in Monthly Rent</td>
                <td>Tenant</td>
                <td>Lease - Start Date</td>
                <td>Lease - End Date</td>
            </tr>
            {foreach $data->apartments as $a}
                {$bed_n=0}
                {foreach $a->beds as $bed}
                    {$bed_n=$bed_n+1}
                    {if $bed->bookings}
                        {foreach $bed->bookings as $booking}
                            {if $booking->invoices}
                                {foreach $booking->invoices as $invoice}
                                <tr>
                                    <td>
                                        {$a->name}-{$bed_n}({$bed->name})
                                    </td>
                                    <td>
                                        {$bed->room_type->name}
                                    </td>
                                    <td>
                                        {if $a->type == 1}
                                            C
                                        {elseif $a->type == 2}
                                            S
                                        {elseif $a->type == 3}
                                            T
                                        {/if}
                                    </td>
                                    <td>
                                        {if $bed->current_invoice->id == $invoice->id}
                                            1
                                        {/if}
                                    </td>
                                    <td class="ll"></td>
                                    <td>
                                        {if $bed->current_invoice->id == $invoice->id}
                                            {$booking->leased_rent|number_format:2:'.':','}
                                        {/if}
                                    </td>
                                    <td>
                                        {$booking->rr_status}
                                    </td>
                                    <td>
                                        {if $days_units=='nights'}
                                            {$invoice->month_nights_count}
                                        {else}
                                            {$invoice->month_days_count}
                                        {/if}
                                    </td>
                                    <td>
                                        {if $days_units=='nights'}
                                            {$invoice->nights_total_price|number_format:2:'.':','}
                                        {else}
                                            {$invoice->days_total_price|number_format:2:'.':','}
                                        {/if}
                                    </td>
                                    {if !$smarty.get.f}
                                    <td>
                                        {if $namePage == 'landlordRR4'}
                                            <span class="nowrap">
                                                {if $invoice->sku}
                                                    {$invoice->sku}
                                                {else}
                                                    {$invoice->id}
                                                {/if}
                                            </span>
                                        {else}
                                            <a class="nowrap" href="?module=OrderAdmin&id={$invoice->id}" target="_blank">
                                            {if $invoice->sku}
                                                {$invoice->sku}
                                            {else}
                                                {$invoice->id}
                                            {/if}
                                            </a>
                                        {/if}
                                    </td>
                                    {/if}
                                    <td>
                                        {if $invoice->paid}
                                            {if $days_units=='nights'}
                                                {$invoice->nights_paid_price|number_format:2:'.':','}
                                            {else}
                                                {$invoice->days_paid_price|number_format:2:'.':','}
                                            {/if}
                                        {/if}
                                    </td>
                                    <td>
                                        {if $invoice->paid}
                                            {$invoice->payment_date|date_format:'%B'}
                                            {if !$invoice->payment_date|date_format:'%B'}
                                                [Paid] 
                                            {/if}
                                        {/if}
                                    </td>
                                    <td>
                                        {if $invoice->paid && $invoice->purchases_utilites_days_price}
                                            {if $days_units=='nights'}
                                                {$invoice->purchases_utilites_nights_price|number_format:2:'.':','}
                                            {else}
                                                {$invoice->purchases_utilites_days_price|number_format:2:'.':','}
                                            {/if}
                                        {/if}
                                    </td>
                                    <td>
                                        {if $invoice->days_discount_sum}
                                            {if $days_units=='nights'}
                                                -{$invoice->nights_discount_sum|number_format:2:'.':','}
                                            {else}
                                                -{$invoice->days_discount_sum|number_format:2:'.':','}
                                            {/if}
                                        {/if}
                                    </td>
                                    <td>
                                        {$users_names=$invoice->users_names}
                                        <div title="{$users_names}" class="tenants_name"{if $invoice->users|count>1} title="{$users_names}"{/if}>
                                            {if $booking->client_type_id==5}
                                                {$users_names="[House Leader] `$users_names`"}
                                            {/if}
                                            {if $smarty.get.f=='pdf'}
                                                {$users_names|truncate:24:'…':true}
                                            {else}
                                                {$users_names}
                                            {/if}
                                        </div>
                                    </td>
                                    <td>
                                        {$booking->arrive|date_format:"%m/%d/%Y"}
                                    </td>
                                    <td>
                                        {$booking->depart|date_format:"%m/%d/%Y"}
                                    </td>
                                </tr>
                                {/foreach}
                            {/if}
                        {/foreach}
                    {else}
                        <tr>
                            <td>{$a->name}-{$bed_n}({$bed->name})</td>
                            <td>
                                {$bed->room_type->name}
                            </td>
                            <td>
                                {if $a->type == 1}
                                    C
                                {elseif $a->type == 2}
                                    S
                                {elseif $a->type == 3}
                                    T
                                {/if}
                            </td>
                            <td>1</td>
                            {* <td></td> *}
                            <td class="ll"></td>
                            <td></td>
                            <td>Vacant</td>
                            <td></td><td></td>
                            {if !$smarty.get.f}<td></td>{/if}
                            <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                        </tr>
                    {/if}
                {/foreach}
                <tr class="tr_total">
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>{$a->beds_count}</td>
                    {* <td>${$a->price|number_format:2:'.':','}</td> *}
                    <td class="ll"></td>
                    <td>
                        {if $a->leased_rent}
                            ${$a->leased_rent|number_format:2:'.':','}
                        {/if}
                    </td>
                    <td></td>
                    <td></td>
                    <td>
                        {if $a->rent_prorated}
                            ${$a->rent_prorated|number_format:2:'.':','}
                        {/if}
                    </td>
                    {if !$smarty.get.f}<td></td>{/if}
                    <td>
                        {if $a->paid_prorated}
                            ${$a->paid_prorated|number_format:2:'.':','}
                        {/if}
                    </td>
                    <td></td>
                    <td>
                        {if $a->paid_utilites}
                            ${$a->paid_utilites|number_format:2:'.':','}
                        {/if}
                    </td>
                    <td>
                        {if $a->discount_sum}
                            -${$a->discount_sum|number_format:2:'.':','}
                        {/if}
                    </td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            {/foreach}
            <tr>
                <td colspan="4" style="height:5px;"></td>
                <td class="ll" style="height:5px;"></td>
                <td colspan="{if !$smarty.get.f}12{else}11{/if}" style="height:5px;"></td>
            </tr>
            <tr class="tr_total">
                <td>Total</td>
                <td></td>
                <td></td>
                <td>
                    {$data->total_beds}
                </td>
                {* <td>${$data->total_market_rent|number_format:2:'.':','}</td> *}
                <td class="ll"></td>
                <td>${$data->total_leased_rent|number_format:2:'.':','}</td>
                <td></td>
                <td></td>
                <td>${$data->total_rent_prorated|number_format:2:'.':','}</td>
                {if !$smarty.get.f}<td></td>{/if}
                <td>
                    {if $data->total_paid_prorated}
                        ${$data->total_paid_prorated|number_format:2:'.':','}
                    {/if}
                </td>
                <td></td>
                <td>
                    {if $data->total_paid_utilites}
                        ${$data->total_paid_utilites|number_format:2:'.':','}
                    {/if}
                </td>
                <td>
                    {if $data->total_discount_sum}
                        -${$data->total_discount_sum|number_format:2:'.':','}
                    {/if}
                </td>
                <td></td>
                <td></td>
                <td></td>
                
            </tr>
        </table>
    </div><!-- table_r -->

</div><!-- w_max -->

<div class="w1300_">
    <div class="fx">
        <div class="rentroll_cont_bx3">
            <div class="table_r ts1">
                <table>
                    <tr class="tr_h">
                        <td colspan="2">Summary Totals</td>
                    </tr>
                    <tr>
                        <td class="td_name">Monthly Rate*</td>
                        <td class="val">${$data->total_leased_rent|number_format:2:'.':','}</td>
                    </tr>
                    <tr>
                        <td class="td_name">Monthly Rent (Accrued)</td>
                        <td class="val">${$data->total_rent_prorated|number_format:2:'.':','}</td>
                    </tr>
                    <tr>
                        <td class="td_name">Monthly Rent (Accrued) - Paid Amount</td>
                        <td class="val">${$data->total_paid_prorated|number_format:2:'.':','}</td>
                    </tr>
                    <tr>
                        <td class="td_name">Occupancy</td>
                        <td class="val">{$data->occupied_beds_pr}%</td>
                    </tr>
                </table>
            </div><!-- table_r -->
        </div><!-- rentroll_cont_bx2 -->
        {if $data->months_summ}
        <div class="rentroll_cont_bx3">
            <div class="table_r ts1">
                <table>
                    <tr class="tr_h">
                        <td colspan="2">Payments (Paid in month)</td>
                    </tr>
                    {foreach $data->months_summ as $month=>$month_data}
                        <tr>
                            <td class="td_name">{$month|date_format:'%B'}</td>
                            <td class="val">$ {$month_data->sum|number_format:2:'.':','}</td>
                        </tr>
                    {/foreach}
                    <tr class="tr_h">
                        <td class="td_name">Total</td>
                        <td class="val">$ {$data->months_summ_total|number_format:2:'.':','}</td>
                    </tr>
                </table>
            </div>
        </div>
        {/if}
    </div><!-- fx -->
</div><!-- w1300 -->
{*
<div class="w1300_">
    <div class="fx">
        <div class="table_r ts1">
            <table>
                <tr class="tr_h">
                    <td colspan="2">Apendix</td>
                </tr>
                <tr {if $data->apartments_types|count > 1}{/if}>
                    <td class="td_name">Unit/Bed</td>
                    <td class="val">{$data->apartnents_count}</td>
                </tr>
                {if $data->apartments_types|count > 1}
                    {foreach $data->apartments_types as $at_id=>$at}
                        <tr>
                            <td class="td_name">
                                {if $at_id==1}
                                    Coliving
                                {elseif $at_id==2}
                                    Stabilized
                                {elseif $at_id==3}
                                    Traditional
                                {/if}
                                units
                            </td>
                            <td class="val">{$at}</td>
                        </tr>
                    {/foreach}
                {/if}
                <tr>
                    <td class="td_name">Room Type</td>
                    <td class="val">{$data->beds_count}</td>
                </tr>
                <tr>
                    <td class="td_name">Unit Type</td>
                    <td class="val">{$data->occupied_beds}</td>
                </tr>
                <tr>
                    <td class="td_name">BRs</td>
                    <td class="val">{$data->occupied_beds_pr}%</td>
                </tr>
                <tr>
                    <td class="td_name">Monthly Rate*</td>
                    <td class="val">${$data->total_leased_rent|number_format:2:'.':','}</td>
                </tr>
                <tr>
                    <td class="td_name">Status</td>
                    <td class="val">${$data->total_market_rent|number_format:2:'.':','}</td>
                </tr>
                <tr>
                    <td class="td_name">Days</td>
                    <td class="val">${$data->total_leased_rent|number_format:2:'.':','}</td>
                </tr>
                <tr>
                    <td class="td_name">Monthly Rent (Accrued)*</td>
                    <td class="val">${$data->total_rent_prorated|number_format:2:'.':','}</td>
                </tr>
                <tr>
                    <td class="td_name">Invoice number</td>
                    <td class="val">${$data->total_paid_utilites|number_format:2:'.':','}</td>
                </tr>
                <tr>
                    <td class="td_name">Monthly Rent (Accrued) - Paid Amount</td>
                    <td class="val">${$data->total_paid_prorated|number_format:2:'.':','}</td>
                </tr>
                <tr>
                    <td class="td_name">Date Paid (Month)</td>
                    <td class="val">${$data->total_paid_utilites|number_format:2:'.':','}</td>
                </tr>
                <tr>
                    <td class="td_name">Utilities Included in Monthly Rent</td>
                    <td class="val"></td>
                </tr>
                <tr>
                    <td class="td_name">Concessions Included in Monthly Rent</td>
                    <td class="val"></td>
                </tr>
                <tr>
                    <td class="td_name">Lease - Start Date</td>
                    <td class="val"></td>
                </tr>
                <tr>
                    <td class="td_name">Lease - End Date</td>
                    <td class="val"></td>
                </tr>
                <tr>
                    <td class="td_name">Ocupance</td>
                    <td class="val">{$data->occupied_beds_pr}%</td>
                </tr>
            </table>
        </div><!-- table_r ts1r -->
    </div><!-- fx -->
</div><!-- w1300 -->

{*
<div class="w1300_">
    <div class="rentroll_cont_bx2">
        <div class="table_r ts1">
            <table>
                <tr>
                    <td class="td_name">Total Bedrooms Leased</td>
                    <td class="val">{$data->beds_leased}</td>
                </tr>
                <tr>
                    <td class="td_name">Current % Leased</td>
                    <td class="val">{$data->current_leased}%</td>
                </tr>
                <tr>
                    <td class="td_name">Current Occupied Bedrooms</td>
                    <td class="val">{$data->current_beds}</td>
                </tr>
                <tr>
                    <td class="td_name">Current Occupancy</td>
                    <td class="val">{$data->current_occupancy}%</td>
                </tr>
                <tr>
                    <td class="td_name">Vacant-Rented Bedrooms</td>
                    <td class="val">{$data->rented_beds}</td>
                </tr>
                <tr>
                    <td class="td_name">Vacant-Rented Occupancy</td>
                    <td class="val">{$data->rented_occupancy}%</td>
                </tr>
            </table>
        </div><!-- table_r -->
    </div><!-- rentroll_cont_bx2 -->
</div><!-- w1300 -->
*}
