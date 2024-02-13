
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
            {*
            <div style="padding:5px 0 0;">
                <a class="download_zip_button fx" href="{url f=xls}" download>
                    <span>Excel file</span>
                    <i class="icon"></i>
                </a>
            </div>
            *}
            
        </div><!-- tenants_cont1 -->


    </div><!-- w1300 -->
    

    <div class="w1300">


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
                <td>{$b->arrive|date_format:"%m/%d/%Y"} {*{$m->from|date_format:"%m/%d/%Y"}*}</td>
                <td>{$b->depart|date_format:"%m/%d/%Y"} {*{$m->to|date_format:"%m/%d/%Y"}*}</td>
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
                        </tr>
                        <tr class="tr_total">
                            <td colspan="3"></td>
                            <td>$ {$a->price}</td>
                            <td class="ll"></td>
                            <td colspan="7"></td>
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
                            </tr>
                            <tr class="tr_total">
                                <td colspan="3"></td>
                                <td>$ {$a->price}</td>
                                <td class="ll"></td>
                                <td></td>
                                <td>
                                    {if $a->month1_total_rent_gross}
                                        $ {$a->month1_total_rent_gross}
                                    {/if}
                                </td>
                                <td>
                                    {if $a->month1_total_utility_price}
                                        $ {$a->month1_total_utility_price}
                                    {/if}
                                </td>
                                <td></td><td></td><td></td><td></td>
                            </tr>
                            {/foreach}


                            {*
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
                                                
                                                <!-- {if $a->rooms[$a->beds[$bed_id]->room_id]->price1}
                                                    {$a->rooms[$a->beds[$bed_id]->room_id]->price1}
                                                {elseif $a->price}
                                                    ({round($a->price/$a->beds_count)})
                                                {/if} -->
                                                
                                                {$a->rooms[$a->beds[$bed_id]->room_id]->price1}
                                            </td>
                                            <td class="ll"></td>
                                            {month_ln m=$b->month1 b=$b}
                                        </tr>
                                    {/foreach}
                                {/foreach}
                                <tr class="tr_total">
                                    <td></td>
                                    <td>{$a->beds_count}</td>
                                    <td></td>
                                    <td>
                                        {if $a->b_current_count==$a->beds_count}
                                            $ {$a->b_current_sum}
                                        {/if}
                                    </td>
                                    <td class="ll"></td>
                                    <td></td>
                                    <td>
                                        {if $a->month1_total_rent_gross}
                                            $ {$a->month1_total_rent_gross}
                                        {/if}
                                    </td>
                                    <td>
                                        {if $a->month1_total_utility_price}
                                            $ {$a->month1_total_utility_price}
                                        {/if}
                                    </td>
                                    <td></td><td></td><td></td><td></td>
                                </tr>
                            {/if}

                            *}


                            {if $a->b_bookings && $a->b_current_count>0}
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
                                        </tr>
                                    {/if}
                                {/foreach}
                                <tr class="tr_total">
                                    <td></td>
                                    <td>{$a->beds_count}</td>
                                    <td></td>
                                    <td>
                                        {* {if $a->b_current_count==$a->beds_count}
                                            $ {$a->b_current_sum}
                                        {/if} *}
                                        {if $a->b_total_price}
                                            $ {$a->b_total_price}
                                        {/if}
                                    </td>
                                    <td class="ll"></td>
                                    <td></td>
                                    <td>
                                        {if $a->month1_total_rent_gross}
                                            $ {$a->month1_total_rent_gross}
                                        {/if}
                                    </td>
                                    <td>
                                        {if $a->month1_total_utility_price}
                                            $ {$a->month1_total_utility_price}
                                        {/if}
                                    </td>
                                    <td></td><td></td><td></td><td></td>
                                </tr>
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
                                    </tr>
                                {/if}
                            {/foreach}
                            <tr class="tr_total">
                                <td></td>
                                <td>{$a->beds_count}</td>

                                <td></td>
                                <td>
                                    {* {if $a->b_current_count==$a->beds_count}
                                        $ {$a->b_current_sum}
                                    {/if} *}
                                    {if $a->b_total_price}
                                        $ {$a->b_total_price}
                                    {/if}
                                </td>
                                <td class="ll"></td>
                                <td></td>
                                <td>
                                    {if $a->month1_total_rent_gross}
                                        $ {$a->month1_total_rent_gross}
                                    {/if}
                                </td>
                                <td>
                                    {if $a->month1_total_utility_price}
                                        $ {$a->month1_total_utility_price}
                                    {/if}
                                </td>
                                <td></td><td></td><td></td><td></td>
                            </tr>
                        {/if}
                        
                    {/if}

                {/foreach}
                <tr>
                    <td colspan="4" style="height:5px;"></td>
                    <td class="ll" style="height:5px;"></td>
                    <td colspan="7" style="height:5px;"></td>
                </tr>
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


    {if $notifications_bookings}
    <div class="w1300" style="margin-top: 70px;">
    <div class="notifications_block">
        <div class="title_bx">
            <h1 class="title">Future Period</h1>
        </div><!-- title_bx -->
        
        <div class="notifications">
            <div class="list1_header fx sb">
                <div class="left_bx fx">
                    <div class="h_name">House</div>
                    <div class="u_name">Tenant</div>
                </div>
                <div class="right_bx fx">
                    <div class="b_period">Arrive / Depart</div>
                    <div class="b_price">Total</div>
                </div>
            </div>
            <div class="list1 ll_bookings_list">
                {foreach $notifications_bookings as $b}
                    <div class="item fx sb">
                        <div class="left_bx fx">
                            {*<div class="b_id">{$b->id}</div>*}
                            <div class="h_name">
                                {$houses[$b->house_id]->name}
                                <div class="sm">
                                    <i class="fa fa-map-marker"></i>
                                    {$houses[$b->house_id]->blocks2['address']}
                                </div>
                            </div>
                            <div class="u_name">
                                <div class="tenants_name">
                                    {if $b->users|count>1}
                                        <i class="fa fa-users"></i>
                                    {else}
                                        <i class="fa fa-user"></i>
                                    {/if}
                                    {foreach $b->users as $u}{if $u@iteration>1}, {/if}{$u->name|escape}{/foreach}
                                </div>
                            </div>
                        </div>
                        <div class="right_bx fx">
                            <div class="b_period">
                                {$b->arrive|date:'M j'}{if $b->arrive|date:'Y' != $b->depart|date:'Y'}, {$b->arrive|date:'Y'}{/if}
                                <i class="fa fa-long-arrow-right"></i> 
                                {$b->depart|date:'M j, Y'}
                                <span class="count">{$b->days_count}{* {$b->days_count|plural:'day':'days'}*}</span>
                            </div>
                            <div class="b_price">
                                {if $b->total_price > 0}
                                    $ {$b->total_price|convert}
                                {/if}
                            </div><!-- b_price -->
                        </div><!-- right_bx -->
                    </div><!-- item -->
                {/foreach}
            </div><!-- list_1 -->
        </div><!-- notifications -->
        
        
    </div><!-- notifications_block -->
    </div><!-- w1300 -->
    {/if}


</div><!-- >page_wrapper -->
