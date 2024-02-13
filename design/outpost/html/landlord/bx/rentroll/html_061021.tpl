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



<div class="w_max">
    {if $smarty.get.f=='pdf'}
        <h3>Rent Roll</h3>
        <p>Prepared On: {$smarty.now|date_format:'%m/%d/%Y'}</p>
        <p>Properties: {$selected_house->blocks2['address']}</p>
        {*<p>Units: Active</p>*}
        <p>As of: {$params->selected_date|date_format:'%m/%d/%Y'}</p>
        {*<p>Include Non-Revenue Units: No</p>*}
    {/if}
    {function name=month_ln}
        {if $m}
            <td>{$m->days}</td>
            <td>
                {if $m->price}
                    ${$m->price|number_format:2:'.':''}
                {/if}
            </td>
            <td>
                {if $m->utility_price}
                    ${$m->utility_price|number_format:2:'.':''}
                {/if}
            </td>
            <td></td>
            <td>
                {$users_names=$b->users_names}
                <div class="tenants_name"{if $b->users|count>1} title="{$users_names}"{/if}>
                    {if $b->client_type_id==5}
                        {$users_names="[House Leader] `$users_names`"}
                    {/if}
                    {if $smarty.get.f=='pdf'}
                        {$users_names|truncate:24:'…':true}
                    {else}
                        {$users_names}
                    {/if}
                </div>
            </td>
            <td>{$b->arrive|date_format:"%m/%d/%Y"} {*{$m->from|date_format:"%m/%d/%Y"}*}</td>
            <td>{$b->depart|date_format:"%m/%d/%Y"} {*{$m->to|date_format:"%m/%d/%Y"}*}</td>
        {else}
            <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
        {/if}
    {/function}
 
    {function name=f_booking}
        {if !$b || $b->id==$pb->id}
            <td></td><td></td><td></td><td></td><td></td><td></td>
        {else}
            
            {* <td>{$b->days_in_month}</td>*}
            <td>{$b->days_count}</td>
            <td>
                ${$b->leased_rent|number_format:2:'.':''}
                {* ${$b->price_month*1} *}

                {* {if $b->client_type_id==2}
                    / 30 days
                {/if} *}
            </td>
            <td>${$b->total_price_result|number_format:2:'.':''}</td>
            <td>
                {$users_names=$b->users_names}
                <div class="tenants_name"{if $b->users|count>1} title="{$users_names}"{/if}>
                    {if $b->client_type_id==5}
                        {$users_names="[House Leader] `$users_names`"}
                    {/if}
                    {if $smarty.get.f=='pdf'}
                        {$users_names|truncate:24:'…':true}
                    {else}
                        {$users_names}
                    {/if}
                </div>
            </td>
            <td>{$b->arrive|date_format:"%m/%d/%Y"}</td>
            <td>{$b->depart|date_format:"%m/%d/%Y"}</td>
        {/if}
    {/function}

    <div class="table_r ll_n">
        <table>
            <tr class="tr_h">
                <td colspan="3"></td>
                <td class="ll"></td>
                <td colspan="2">Monthly Rent</td>
                <td class="ll"></td>
                <td colspan="7">Current Month{* {$params->now_month|date_format:'%B'} *}</td>
                <td class="ll"></td>
                <td colspan="6">Next Lease</td>
            </tr>
            <tr class="tr_h st">

                <td>Unit</td>
                <td>BRs</td>
                <td>Status</td>
                <td class="ll"></td>
                <td>Market Rent</td>
                <td>Leased Rent</td>

                <td class="ll"></td>

                <td>Days</td>
                <td>Rent prorated</td>
                <td>Thereof utilites</td>
                <td>Thereof fees</td>
                <td>Tenant</td>
                <td>Lease<br> from</td>
                <td>Lease<br> till</td>

                <td class="ll"></td>

                <td>Days</td>
                <td>Monthly Rent</td>
                <td>Total contracted</td>
                <td>Tenant</td>
                <td>Lease<br> from</td>
                <td>Lease<br> till</td>

            </tr>
            {foreach $apartments as $a}
                {if !$a->a_bookings && !$a->b_bookings}
                    {if !$a->isset_feature_b_bookings && !$a->feature_a_booking}
                        {$bed_n=0}
                        {foreach $a->beds as $bed}
                            {$bed_n=$bed_n+1}
                            <tr>
                                <td>{$a->name}-{$bed_n}</td>
                                <td>1</td>
                                <td>Vacant-Unrented</td>
                                <td class="ll"></td>
                                <td></td><td></td>
                                <td class="ll"></td>
                                <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                                <td class="ll"></td>
                                <td></td><td></td><td></td><td></td><td></td><td></td>
                            </tr>
                        {/foreach}
                        <tr class="tr_total">
                            <td></td><td>{$a->beds_count}</td><td></td>
                            <td class="ll"></td>
                            <td>${$a->price|number_format:2:'.':''}</td>
                            <td></td>
                            <td class="ll"></td>
                            <td colspan="7"></td>
                            <td class="ll"></td>
                            <td colspan="6"></td>
                        </tr>
                    {else}
                        {$bed_n=0}
                        {foreach $a->beds as $bed}
                            {$bed_n=$bed_n+1}
                            {if $a->feature_a_booking}
                                <tr>
                                    <td>{$a->name}-{$bed_n}</td>
                                    <td>1</td>
                                    <td>Vacant-Unrented</td>
                                    <td class="ll"></td>
                                    <td>
                                        {* {$a->rooms[$a->beds[$bed->id]->room_id]->price1} *}
                                    </td>
                                    <td></td>
                                    <td class="ll"></td>
                                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                                    <td class="ll"></td>
                                    {f_booking b=$a->feature_a_booking pb=0}
                                </tr>
                            {/if}
                            {if $bed->feature_b_booking || !$a->feature_a_booking}
                                <tr>
                                    <td>{$a->name}-{$bed_n}</td>
                                    <td>1</td>
                                    <td>Vacant-Unrented</td>
                                    <td class="ll"></td>
                                    <td>
                                        
                                    </td>
                                    <td></td>
                                    <td class="ll"></td>
                                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                                    <td class="ll"></td>
                                    {f_booking b=$bed->feature_b_booking pb=0}
                                </tr>
                            {/if}
                        {/foreach}
                        <tr class="tr_total">
                            <td></td><td>{$a->beds_count}</td><td></td>
                            <td class="ll"></td>
                            <td>${$a->price|number_format:2:'.':''}</td>
                            <td></td>
                            <td class="ll"></td>
                            <td colspan="7"></td>
                            <td class="ll"></td>
                            <td colspan="6"></td>
                        </tr>
                    {/if}
                {else}

                    {$bed_n=0}
                    {$prev_f_booking=0}
                    {foreach $a->beds as $bed}
                        {$bed_n=$bed_n+1}
                        {$prev_f_booking=0}

                        {if $a->a_bookings}
                            {foreach $a->a_bookings as $b}
                                <tr>
                                    <td>{$a->name}-{$bed_n}</td>
                                    <td>
                                        {if $params->leased_rent[$a->id][$bed->id] && $params->leased_rent[$a->id][$bed->id]->booking_id==$b->id}
                                            1
                                        {/if}
                                    </td>
                                    <td>{$b->rr_status}</td>
                                    <td class="ll"></td>
                                    <td>{* {$a->price} *}</td>
                                    <td>
                                        {if $params->leased_rent[$a->id][$bed->id] && $params->leased_rent[$a->id][$bed->id]->booking_id==$b->id}
                                            ${$params->leased_rent[$a->id][$bed->id]->price|number_format:2:'.':''}
                                            {* {if $b->client_type_id==2}
                                                / 30 days
                                            {/if} *}
                                        {/if}
                                        {* ${$b->leased_rent*1} *}
                                    </td>
                                    <td class="ll"></td>
                                    {month_ln m=$b->month1 b=$b}
                                    <td class="ll"></td>
                                    {if $bed->feature_b_booking && $a->feature_a_booking && $bed->feature_b_booking->u_arrive<$a->feature_a_booking->u_arrive && !$a->b_bookings[$bed->id]->bookings}
                                        {$feature_booking=$bed->feature_b_booking}
                                        {f_booking b=$feature_booking pb=$prev_f_booking}
                                        {$prev_f_booking=$feature_booking}
                                    {else}
                                        {if $params->leased_rent[$a->id][$bed->id] && $params->leased_rent[$a->id][$bed->id]->booking_id==$b->id}
                                            {$feature_booking=$a->feature_a_booking}
                                        {else}
                                            {$feature_booking=0}
                                        {/if}
                                        {f_booking b=$feature_booking pb=$prev_f_booking}
                                    {/if}
                                    
                                </tr>
                            {/foreach}
                            
                        {/if}
                        {if $a->b_bookings && $a->b_bookings[$bed->id]->bookings}
                            
                            {foreach $a->b_bookings[$bed->id]->bookings as $b}
                                {if $b->month1}
                                <tr>
                                    <td>{$a->name}-{$bed_n}</td>
                                    <td>
                                        {if $params->leased_rent[$a->id][$bed->id] && $params->leased_rent[$a->id][$bed->id]->booking_id==$b->id}
                                            1
                                        {/if}
                                    </td>
                                    <td>{$b->rr_status}</td>
                                    <td class="ll"></td>
                                    <td>
                                        {* {$a->rooms[$a->beds[$bed->id]->room_id]->price1} *}
                                    </td>
                                    <td>
                                        {if $params->leased_rent[$a->id][$bed->id] && $params->leased_rent[$a->id][$bed->id]->booking_id==$b->id}
                                            ${$params->leased_rent[$a->id][$bed->id]->price|number_format:2:'.':''}
                                            {* {if $b->client_type_id==2}
                                                / 30 days
                                            {/if} *}
                                        {/if}
                                        {* ${$b->leased_rent*1} *}
                                    </td>
                                    <td class="ll"></td>
                                    {month_ln m=$b->month1 b=$b}
                                    <td class="ll"></td>
                                    {if $a->feature_a_booking && (!$bed->feature_b_booking || ($bed->feature_b_booking && $a->feature_a_booking->u_arrive<$bed->feature_b_booking->u_arrive))}
                                        {if $params->leased_rent[$a->id][$bed->id] && $params->leased_rent[$a->id][$bed->id]->booking_id==$b->id}
                                            {$feature_booking=$a->feature_a_booking}
                                        {else}
                                            {$feature_booking=0}
                                        {/if}
                                    {else}
                                        {$feature_booking=$bed->feature_b_booking}
                                    {/if}
                                    {f_booking b=$feature_booking pb=$prev_f_booking}
                                    {$prev_f_booking=$feature_booking}
                                </tr>
                                {/if}
                            {/foreach}
                        {/if}
                        {if !$a->a_bookings && (!$a->b_bookings[$bed->id]->bookings)}
                            <tr>
                                <td>{$a->name}-{$bed_n}</td>
                                <td>1</td>
                                <td>Vacant-Unrented</td>
                                <td class="ll"></td>
                                <td></td><td></td>
                                <td class="ll"></td>
                                <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                                <td class="ll"></td>
                                {if $bed->feature_b_booking && (!$a->feature_a_booking || ($a->feature_a_booking && $bed->feature_b_booking->u_arrive<$a->feature_a_booking->u_arrive))}
                                    {$feature_booking=$bed->feature_b_booking}
                                {else}
                                    {$feature_booking=$a->feature_a_booking}
                                {/if}
                                {f_booking b=$feature_booking pb=$prev_f_booking}
                                {$prev_f_booking=$feature_booking}
                            </tr>
                        {/if}
                    {/foreach}

                    <tr class="tr_total">
                        <td></td><td>{$a->beds_count}</td><td></td>
                        <td class="ll"></td>
                        <td>${$a->price|number_format:2:'.':''}</td>
                        <td>{if $a->leased_rent}
                            ${$a->leased_rent|number_format:2:'.':''}
                        {/if}</td>
                        <td class="ll"></td>
                        <td></td>
                        <td>
                            {if $a->total_rent_gross}
                                ${$a->total_rent_gross|number_format:2:'.':''}
                            {/if}
                        </td>
                        <td>
                            {if $a->total_utility_price}
                                ${$a->total_utility_price|number_format:2:'.':''}
                            {/if}
                        </td>
                        <td></td><td></td><td></td><td></td>
                        <td class="ll"></td>
                        <td colspan="6"></td>
                    </tr>
                     <!-- coding -->
                {/if}
            {/foreach}
            <tr>
                <td colspan="3" style="height:5px;"></td>
                <td class="ll" style="height:5px;"></td>
                <td colspan="2" style="height:5px;"></td>
                <td class="ll" style="height:5px;"></td>
                <td colspan="7" style="height:5px;"></td>
                <td class="ll" style="height:5px;"></td>
                <td colspan="6" style="height:5px;"></td>
            </tr>
            <tr class="tr_total">
                <td>Total</td>
                <td>
                    Units: {$apartments|count}<br>
                    BRs:{$params->total_beds}
                </td>
                <td></td>
                <td class="ll"></td>
                <td>${$params->total_market_rent|number_format:2:'.':''}</td>
                <td>${$params->total_leased_rent|number_format:2:'.':''}</td>
                <td class="ll"></td>
                <td></td>
                <td>${$params->total_rent_gross[1]|number_format:2:'.':''}</td>
                <td>${$params->total_utility_price[1]|number_format:2:'.':''}</td>
                <td></td><td></td><td></td><td></td>
                <td class="ll"></td>
                <td></td><td></td><td></td><td></td><td></td><td></td>
            </tr>

        </table>
    </div><!-- table_r -->

</div><!-- w_max -->

<div class="w1300">
    <div class="rentroll_cont_bx2">
        <div class="table_r ts1">
            <table>
                <tr>
                    <td class="td_name">Total Bedrooms Leased</td>
                    <td class="val">{$params->beds_leased}</td>
                </tr>
                <tr>
                    <td class="td_name">Current % Leased</td>
                    <td class="val">{$params->current_leased}%</td>
                </tr>
                <tr>
                    <td class="td_name">Current Occupied Bedrooms</td>
                    <td class="val">{$params->current_beds}</td>
                </tr>
                <tr>
                    <td class="td_name">Current Occupancy</td>
                    <td class="val">{$params->current_occupancy}%</td>
                </tr>
                <tr>
                    <td class="td_name">Vacant-Rented Bedrooms</td>
                    <td class="val">{$params->rented_beds}</td>
                </tr>
                <tr>
                    <td class="td_name">Vacant-Rented Occupancy</td>
                    <td class="val">{$params->rented_occupancy}%</td>
                </tr>
            </table>
        </div><!-- table_r -->
    </div><!-- rentroll_cont_bx2 -->

</div><!-- w1300 --> 