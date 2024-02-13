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
    background: #dbdbe6;
    border: none;
    padding: 0.7px;
    height:2px !important;
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
.table_r .tenants_unit,
.table_r .tenants_name_td .tenants,
.table_r .tenants_phone,
.table_r .tenants_email{
    text-align: left;
}
.table_r .tenants_move_in,
.table_r .tenants_lease_to,
.table_r .tenants_unit_type {
    text-align: center;
}
.table_r .tenants_deposit {
    text-align: right;
}
</style>
{/if}



<div class="w_max_">
    {if $smarty.get.f=='pdf'}
        <h3>Tenant Directory</h3>
        <p><b>Exported On</b>: {$smarty.now|date_format:'m/d/Y h:i A'}</p>
        <p><b>Properties</b>: {$selected_house->blocks2['address']}</p>
        {*<p><b>As of</b>: {$smarty.now|date_format:'%B %Y'}</p>*}
        <p><b>Tenant</b>: Active</p>
    {/if}


    <div class="table_r ll_n">
        <table>
            <tr class="tr_h st">
                <td>Unit / Room</td>
                <td>Tenant</td>
                <td>Phone Number</td>
                <td>Email</td>
                <td>Lease - Start Date</td>
                <td>Lease - End Date</td>
                <td>Monthly Rent</td>
                <td>Utilities</td>
                <td>Deposit</td>
                <td>Unit Type</td>
            </tr>
            {$firstIteration = true}
            {foreach $bookings->data as $i}
                {if !$a || $a->id!= $i->apartment->id}
                    {if not $firstIteration}
                        <tr>
                            <td class="ll" colspan="10" style="height:10px; background:#dbdbe6"></td>
                        </tr>
                    {/if}
                    {if $firstIteration}
                        {$firstIteration = false}
                    {/if}
                {/if}
                {$a=$i->apartment}
                {$b=$i->bed}
                {$c=$i->contract}
                <tr>
                    <td class="tenants_unit">
                        {$a->name} {if $i->type == 1}/{/if} {$b->name}
                    </td>
                    <td class="tenants_name_td">
                        {if $i->users}
                            <div class="tenants"
                                {if $i->users|count>1}
                                {foreach $i->users as $u}
                                    {$u->name|escape}
                                {/foreach}
                                {/if}>
                                {if $namePage == 'tenant-directory' || $smarty.get.f=='pdf'}
                                    {foreach $i->users as $u}
                                        {$u->name|escape}{if !$u@last},{/if}
                                    {/foreach}
                                {else}
                                    {foreach $i->users as $u}
                                        <a title="{$u->name}" href="?module=UserAdmin&id={$u->id}" target="_blank">{$u->name|escape}</a>{if !$u@last},{/if}
                                    {/foreach}
                                {/if}
                            </div>
                        {/if}
                    </td>
                    <td>
                        {if $i->users}
                            <div class="tenants_phone"
                                {if $i->users|count>1}
                                    {foreach $i->users as $u}
                                        {$u->name|escape}{if !$u@last},{/if}
                                    {/foreach}
                                {/if}>{foreach $i->users as $u}{if $namePage == 'tenant-directory' || $smarty.get.f=='pdf'}{$u->phone|escape}{else}
                                    <span title="{$u->name}" href="?module=UserAdmin&id={$u->id}" target="_blank">{$u->phone|escape}</span>{/if}{if !$u@last && $u->phone != ''},{/if}
                                {/foreach}
                            </div>
                        {/if}
                    </td>
                    <td>
                        {if $i->users}
                            <div class="tenants_email"
                            {if $i->users|count>1}
                                {foreach $i->users as $u}
                                    {$u->name|escape}{if !$u@last},{/if}
                                {/foreach}
                            {/if}>{foreach $i->users as $u}{if $namePage == 'tenant-directory' || $smarty.get.f=='pdf'}{$u->email|escape}{else}
                                    <span title="{$u->name}" href="?module=UserAdmin&id={$u->id}" target="_blank">{$u->email|escape}</span>{/if}{if !$u@last && $u->email != ''},{/if}
                            {/foreach}
                            </div>
                        {/if}
                    </td>
                    <td class="tenants_move_in">{$i->date_from|date_format:"%m/%d/%Y"}</td>
                    <td class="tenants_lease_to">{$i->date_to|date_format:"%m/%d/%Y"}</td>
                    <td class="tenants_deposit">{number_format($i->price_month, 2, '.', ',')}</td>
                    <td class="tenants_deposit">{number_format($c->price_utilites, 2, '.', ',')}</td>
                    <td class="tenants_deposit">{number_format($i->price_month, 2, '.', ',')}</td>
                    <td class="tenants_unit_type">{$a->bed} BD / {$a->bathroom} BA</td>
                </tr>
            {/foreach}
        </table>
    </div><!-- table_r -->
</div><!-- w_max -->