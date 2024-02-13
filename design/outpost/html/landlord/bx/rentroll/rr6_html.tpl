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
.table_r .tr_gtotal td,
.table_r .tr_broker_fee_total td{
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
.broker_fee_tenants_name_td{
    width: 350px;
}
.broker_fee_tenants{
    text-align: left;
    width: 350px;
}
</style>
{/if}


<div class="w_max_">
    {if $smarty.get.f=='pdf'}
        <h3>Lender</h3>
        {* <p>Prepared On: {$smarty.now|date_format:'%m/%d/%Y'}</p> *}
        <p>Properties: {$selected_house->blocks2['address']}</p>
        <p>Units: Active</p>
        {* <p>Include Non-Revenue Units: No</p> *}
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
                <td>Bedroom</td>
                <td>Tenant</td>
                <td>Lease Date Start</td>
                <td>Lease Date End</td>
                <td>Days</td>
                <td>Contracted amount</td>
                <td>Monthly rent</td>
                <td>Broker fee</td>
                <td>Days count</td>
                <td>Days (previus period)</td>
                <td>Broker fee (previus period)</td>
            </tr>
            {foreach $data->invoices as $i}
                {if !empty($i)}
                    <tr>
                        <td>
                            {$i->apartment->name}
                        </td>
                        <td>
                            {if $i->booking->type == 1}
                                {$i->bed->name}
                            {/if}
                            {if $i->booking->type == 2}
                                Full Apartmnet
                            {/if}
                        </td>
                        <td class="broker_fee_tenants_name_td">
                            {if $i->booking->users}
                                <div class="broker_fee_tenants"
                                    {if $i->booking->users|count>1}
                                    {foreach $i->booking->users as $u}
                                        {$u->name|escape}{if !$u@last}, {/if}
                                    {/foreach}
                                    {/if}>
                                    {if $namePage != 'backendRR6' || $smarty.get.f=='pdf'}
                                        {foreach $i->booking->users as $u}
                                            {$u->name|escape}{if !$u@last}, {/if}
                                        {/foreach}
                                    {else}
                                        {foreach $i->booking->users as $u}
                                            <a title="{$u->name}" href="?module=UserAdmin&id={$u->id}" target="_blank">{$u->name|escape}</a>{if !$u@last},&nbsp;{/if}
                                        {/foreach}
                                    {/if}
                                </div>
                            {/if}
                        </td>
                        <td>
                            {$i->booking->arrive|date_format:"%m/%d/%Y"}
                        </td>
                        <td>
                            {$i->booking->depart|date_format:"%m/%d/%Y"}
                        </td>
                        <td>
                            {$i->booking->days_count}
                        </td>
                        <td>
                            {$i->total_amount|number_format:2:'.':','}
                        </td>
                        <td>
                            {$i->monthly_amount|number_format:2:'.':','}
                        </td>
                        <td>
                            <span class="tooltip_left tt_r20" data-tooltip="{$i->broker_fee_formula}">{$i->broker_fee|number_format:2:'.':','}</span>
                        </td>

                        <td>
                            {$i->feeDaysCount}
                        </td>
                        <td>
                            {$i->booking->feePrevDays}
                        </td>
                        <td>
                            {$i->booking->feePrevSumm|number_format:2:'.':','}
                        </td>
                    </tr>
                {/if}
            {/foreach}
            <tr class="tr_broker_fee_total">
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td>Total:</td>
                <td>${$data->total_broker_fee|number_format:2:'.':','}</td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
        </table>
    </div><!-- table_r -->
</div><!-- w_max -->
