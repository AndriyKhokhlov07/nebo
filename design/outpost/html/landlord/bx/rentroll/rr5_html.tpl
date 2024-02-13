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
    padding: 3px;
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
.lender_tenants_name_td{
    width: 400px;
}
.lender_tenants{
    text-align: left;
    width: 400px;
}
</style>
{/if}


<div class="w_max_">
    {if $smarty.get.f=='pdf'}
        <h3>Lender</h3>
        {* <p>Prepared On: {$smarty.now|date_format:'%m/%d/%Y'}</p> *}
        <p>Properties: {$selected_house->blocks2['address']}</p>
        <p>Units: Active</p>
        <p>Include Non-Revenue Units: No</p>
        <p>As of: {$params->now_month|date_format:'%B %Y'}</p>
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
                <td>Unit</td>
                <td>BRs</td>
                <td>Unit Type</td>
                <td>Status</td>
                <td>Market Rent</td>
                <td>Lease Amount</td>
                <td>Tenant</td>
                <td>Lease From</td>
                <td>Lease Till</td>
            </tr>
            {foreach $data->apartments as $a}
                <tr>
                    <td>{$a->name}</td>
                    <td>{$a->bed}</td>
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
                        {if $a->lease->active_status == 'Active'}
                            Current
                        {elseif $a->lease->active_status == 'Future'}
                            Vacant Rented
                        {else}
                            Vacant
                        {/if}
                    </td>
                    <td>
                        {if $a->lease}
                            {$a->property_price|number_format:2:'.':','}
                        {/if}
                    </td>
                    <td>
                        {if $a->lease}
                            {$a->lease->price|number_format:2:'.':','}
                        {/if}
                    </td>
                    <td class="lender_tenants_name_td">
                        <div class="lender_tenants">{$firstIteration = true}{foreach $a->lease->data as $d}{$user=$data->tenants[$d->user_id]}{if $user}{if not $firstIteration}, {/if}{$user->name}{if $firstIteration}{$firstIteration = false}{/if}{else}Tenant{/if}{/foreach}</div>
                    </td>
                    <td>
                        {if $a->lease}
                            {$a->lease->date_from|date_format:"%m/%d/%Y"}
                        {/if}
                    </td>
                    <td>
                        {if $a->lease}
                            {$a->lease->date_to|date_format:"%m/%d/%Y"}
                        {/if}
                    </td>
                </tr>
            {/foreach}
            <tr class="tr_total">
                <td>Total:</td>
                <td>{$data->total_beds}</td>
                <td></td>
                <td></td>
                <td>${$data->total_market_rent|number_format:2:'.':','}</td>
                <td>${$data->total_lease_amount|number_format:2:'.':','}</td>
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
                    {foreach $data->apartments_types as $at}
                        {if $at['count']}
                            <tr class="tr_h">
                                <td class="td_name">{$at['name']}</td>
                                <td class="val">${$at['market_rent']|number_format:2:'.':','}</td>
                                <td class="val">${$at['lease_amount']|number_format:2:'.':','}</td>
                            </tr>
                        {/if}
                    {/foreach}
                </table>
            </div><!-- table_r -->
        </div><!-- rentroll_cont_bx2 -->
        {*
        <div class="rentroll_cont_bx3">
            <div class="table_r ts1">
                <table>
                    <tr class="tr_h">
                        <td class="td_name">ANNUALIZED</td>
                        <td class="val">$ {$data->months_summ_total|number_format:2:'.':','}</td>
                        <td class="val">$ {$data->months_summ_total|number_format:2:'.':','}</td>
                    </tr>
                </table>
            </div>
        </div>
        *}
    </div><!-- fx -->
</div><!-- w1300 -->
