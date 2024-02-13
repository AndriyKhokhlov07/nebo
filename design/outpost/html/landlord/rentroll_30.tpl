
{$apply_button_hide=1 scope=parent}
{$members_menu=1 scope=parent}


<link href="design/{$settings->theme|escape}/css/landlord/landlord.css?v1.0.7" rel="stylesheet">
{* <link id="to_ptint_css" href="design/{$settings->theme|escape}/css/landlord/print_rentroll.css?v1.0.2" rel="stylesheet"> *}

{$javascripts[]="design/`$settings->theme`/js/rentroll_w.js?v.1.0" scope=parent}


{if $houses|count > 1}
    {$nav_url = 'landlord/rentroll_w/'}
    {include file='landlord/bx/houses_nav.tpl'}
{/if}


<div class="page_wrapper">

    <div class="w1300">
        <div class="title_bx">
            <h1 class="title">{$selected_house->name|escape}</h1>
            {*
            {if $selected_house->blocks2['address']}
                <p class="tn_address">
                    <i class="fa fa-map-marker"></i>
                    {$selected_house->blocks2['address']}
                </p>
            {/if}
            *}
        </div><!-- title_bx -->

        <div class="fx tenants_cont1 sb">
            <div class="fx">
                <form class="rr_form" method="get">
                    <div class="ll_input_block">
                        <i class="fa fa-calendar"></i>
                        <input class="s_date" type="text" name="date" value="{$params->selected_date|date_format:'%Y-%m-%d'}" placeholder="Select date">
                    </div>                    
                </form>
            </div>
            <div style="padding:5px 0 0;">
                <a class="download_zip_button fx" href="{url f=xls}" download>
                    <span>Excel file</span>
                    <i class="icon"></i>
                </a>
            </div>
            
        </div><!-- tenants_cont1 -->


    </div><!-- w1300 -->
    

    <div class="w_max">


        {function name=month_ln}
            {if $m}
                <td>{$m->days}</td>
                <td>{$m->price}</td>
                <td>{$m->utility_price}</td>
                <td></td>
                <td>
                    <div class="tenants_name"{if $b->users|count>1} title="{foreach $b->users as $u}{$u->name|escape}{if $u@iteration>1 && !$u@last}, {/if}{/foreach}"{/if}>
                        {$b->users_names}
                    </div>
                </td>
                <td>{$b->arrive|date_format:"%m/%d/%Y"}</td>
                <td>{$b->depart|date_format:"%m/%d/%Y"}</td>
            {else}
                <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
            {/if}
        {/function}


        <div class="table_r">
            <table>
                <tr class="tr_h">
                    <td colspan="4"></td>
                    <td class="ll"></td>
                    <td colspan="7">{$params->now_month|date_format:'%B'}</td>
                    <td class="ll"></td>
                    <td colspan="7">{$params->next_month|date_format:'%B'}</td>
                    <td class="ll"></td>
                    <td colspan="7">{$params->next_2month|date_format:'%B'}</td>
                </tr>
                <tr class="tr_h st">

                    <td>Unit</td>
                    <td>BRs</td>
                    <td>Status</td>
                    <td>Market Rent</td>
                    <td class="ll"></td>

                    <td>Days</td>
                    <td>Rent Gross</td>
                    <td>Thereof utilites</td>
                    <td>Thereof fees</td>
                    <td>Tenant</td>
                    <td>Lease<br> from</td>
                    <td>Lease<br> till</td>
                    <td class="ll"></td>

                    <td>Days</td>
                    <td>Rent Gross</td>
                    <td>Thereof utilites</td>
                    <td>Thereof fees</td>
                    <td>Tenant</td>
                    <td>Lease<br> from</td>
                    <td>Lease<br> till</td>
                    <td class="ll"></td>

                    <td>Days</td>
                    <td>Rent Gross</td>
                    <td>Thereof utilites</td>
                    <td>Thereof fees</td>
                    <td>Tenant</td>
                    <td>Lease<br> from</td>
                    <td>Lease<br> till</td>

                </tr>



                {foreach $apartments as $a}


                    {if !$a->a_bookings && !$a->b_bookings}
                        <tr>
                            <td>{$a->name}</td>
                            <td>{$a->beds_count}</td>
                            <td>Vacant-Unrented</td>
                            <td>{$a->price}</td>
                            <td class="ll"></td>
                            <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                            <td class="ll"></td>
                            <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                            <td class="ll"></td>
                            <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                        </tr>
                    {else}
                        {if $a->a_bookings}
                            {foreach $a->a_bookings as $b}
                            <tr>
                                <td>{$a->name}</td>
                                <td>{$a->beds_count}</td>
                                <td>{$b->rr_status}</td>
                                <td>{$a->price}</td>
                                <td class="ll"></td>
                                {month_ln m=$b->month1 b=$b}
                                <td class="ll"></td>
                                {month_ln m=$b->month2 b=$b}
                                <td class="ll"></td>
                                {month_ln m=$b->month3 b=$b}
                            </tr>
                            {/foreach}
                            {if $a->b_bookings}
                                {$bed_n=0}
                                {foreach $a->b_bookings as $bed_id=>$bed_bookings}
                                    {$bed_n=$bed_n+1}
                                    {foreach $bed_bookings->bookings as $b}
                                        <tr>
                                            <td>{$a->name}-{$bed_n}</td>
                                            <td>1</td>
                                            <td>{$b->rr_status}</td>
                                            <td>
                                                {*
                                                {if $a->rooms[$a->beds[$bed_id]->room_id]->price1}
                                                    {$a->rooms[$a->beds[$bed_id]->room_id]->price1}
                                                {elseif $a->price}
                                                    ({round($a->price/$a->beds_count)})
                                                {/if}
                                                *}
                                                {$a->rooms[$a->beds[$bed_id]->room_id]->price1}
                                            </td>
                                            <td class="ll"></td>
                                            {month_ln m=$b->month1 b=$b}
                                            <td class="ll"></td>
                                            {month_ln m=$b->month2 b=$b}
                                            <td class="ll"></td>
                                            {month_ln m=$b->month3 b=$b}
                                        </tr>
                                    {/foreach}
                                {/foreach}
                            {/if}
                        {elseif $a->b_bookings}
                            {$bed_n=0}
                            {foreach $a->beds as $bed}
                                {$bed_n=$bed_n+1}
                                {if $a->b_bookings[$bed->id]}
                                    {foreach $a->b_bookings[$bed->id]->bookings as $b}
                                        <tr>
                                            <td>{$a->name}-{$bed_n}</td>
                                            <td>1</td>
                                            <td>{$b->rr_status}</td>
                                            <td>
                                                {$a->rooms[$a->beds[$bed->id]->room_id]->price1}
                                            </td>
                                            <td class="ll"></td>
                                            {month_ln m=$b->month1 b=$b}
                                            <td class="ll"></td>
                                            {month_ln m=$b->month2 b=$b}
                                            <td class="ll"></td>
                                            {month_ln m=$b->month3 b=$b}
                                        </tr>
                                    {/foreach}
                                {else}
                                    <tr>
                                        <td>{$a->name}-{$bed_n}</td>
                                        <td>1</td>
                                        <td>Vacant-Unrented</td>
                                        <td>
                                            {$a->rooms[$a->beds[$bed->id]->room_id]->price1}
                                        </td>
                                        <td class="ll"></td>
                                        <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                                        <td class="ll"></td>
                                        <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                                        <td class="ll"></td>
                                        <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                                    </tr>
                                {/if}
                            {/foreach}
                        {/if}
                        
                    {/if}

                {/foreach}

                <tr class="tr_total">
                    <td>Total</td>
                    <td>{$params->total_beds}</td>
                    <td></td>
                    <td>{$params->total_market_rent}</td>
                    <td class="ll"></td>
                    <td></td>
                    <td>{$params->total_rent_gross[1]}</td>
                    <td>{$params->total_utility_price[1]}</td>
                    <td></td><td></td><td></td><td></td>
                    <td class="ll"></td>
                    <td></td>
                    <td>{$params->total_rent_gross[2]}</td>
                    <td>{$params->total_utility_price[2]}</td>
                    <td></td><td></td><td></td><td></td>
                    <td class="ll"></td>
                    <td></td>
                    <td>{$params->total_rent_gross[3]}</td>
                    <td>{$params->total_utility_price[3]}</td>
                    <td></td><td></td><td></td><td></td>
                </tr>

            </table>
        </div><!-- table_r -->

    </div><!-- w_max -->

    <div class="w1300">

        <div class="rentroll_cont_bx2">
            <div class="table_r ts1">
                <table>
                    <tr>
                        <td>Total Bedrooms Leased</td>
                        <td class="val">{$params->beds_leased}</td>
                    </tr>
                    <tr>
                        <td>Current % Leased</td>
                        <td class="val">{$params->current_leased}%</td>
                    </tr>
                    <tr>
                        <td>Current Occupied Bedrooms</td>
                        <td class="val">{$params->current_beds}</td>
                    </tr>
                    <tr>
                        <td>Current Occupancy</td>
                        <td class="val">{$params->current_occupancy}%</td>
                    </tr>
                    <tr>
                        <td>Vacant-Rented Bedrooms</td>
                        <td class="val">{$params->rented_beds}</td>
                    </tr>
                    <tr>
                        <td>Vacant-Rented Occupancy</td>
                        <td class="val">{$params->rented_occupancy}%</td>
                    </tr>
                </table>
            </div><!-- table_r -->
        </div><!-- rentroll_cont_bx2 -->

    </div><!-- w1300 -->


</div><!-- >page_wrapper -->
