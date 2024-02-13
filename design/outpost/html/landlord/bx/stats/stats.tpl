
<div class="house_statistics fx v">
    <div class="icons_block md fx w">
        <div class="icon_block">
            <div class="icon_bx">
                <i class="i-apartments"></i>
                <div class="cont">
                    <div class="title">
                            <span>
                                Apartments
                                {if $params->apartments_types|count==1}
                                    {$apartments_type=current($params->apartments_types)}
                                    ({$apartments_type->name})
                                {/if}
                            </span>
                    </div>
                    <span>{$params->apartments|count}</span>
                </div>
                {if $params->apartments_types|count>1}
                    <div class="cont apartment_types">
                        <table>
                            {foreach $params->apartments_types as $at}
                                <tr>
                                    <td>{$at->name}:</td>
                                    <td class="count">{$at->count}</td>
                                </tr>
                            {/foreach}
                        </table>
                    </div>
                {/if}
            </div>
        </div>
        <div class="icon_block">
            <div class="icon_bx">
                <i class="i-room"></i>
                <div class="cont">
                    <div class="title">
                        <span>Rooms</span>
                    </div>
                    <span>{$params->rooms|count}</span>
                </div>
                {if $params->rooms_types}
                    <div class="cont apartment_types">
                        <table>
                            {foreach $params->rooms_types as $rt}
                                <tr>
                                    <td>{if $rt->name}{$rt->name}{else}[not selected]{/if}:</td>
                                    <td class="count">{$rt->count}</td>
                                </tr>
                            {/foreach}
                        </table>
                    </div>
                {/if}
            </div>
        </div>
        {if $params->beds|count!=$params->rooms|count}
            <div class="icon_block">
                <div class="icon_bx">
                    <i class="i-beds"></i>
                    <div class="cont">
                        <div class="title">
                            <span>Beds</span>
                        </div>
                        <span>{$params->beds|count}</span>
                    </div>
                </div>
            </div>
        {/if}
        {*
        <div class="icon_block">
            <div class="icon_bx">
                <i class="i-beds"></i>
                <div class="cont">
                    <div class="title">
                        <span>Total / Filled</span>
                    </div>
                    <span>
                        {$params->selected_occupancy->days_beds_count} /
                        {if $params->selected_occupancy->occupancy_bdays>$params->selected_occupancy->days_beds_count}
                            {$params->selected_occupancy->days_beds_count}
                        {else}
                            {$params->selected_occupancy->occupancy_bdays}
                        {/if}
                    </span>
                </div>
            </div>
        </div>
        *}
        <div class="icon_block">
            {$occupancy_val=$params->selected_occupancy->occupancy}
            {if $occupancy_val>100}
                {$occupancy_val=100}
            {/if}
            <div class="icon_bx">
                <div class="oh_icon">
                    <div class="occupancy_icon graph_bx">
                        <div class="graph">
                            <svg viewBox="0 0 42 42" class="donut">
                                <circle class="donut-ring" cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke-width="6"></circle>
                                <circle class="donut-segment" cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke-width="6" stroke-dasharray="{$occupancy_val} {100-$occupancy_val}" stroke-dashoffset="25"></circle>
                            </svg>
                        </div><!-- graph -->
                    </div><!-- graph_bx -->
                </div>
                <div class="cont">
                    <div class="title">
                        <span>Occupancy</span>
                    </div>
                    <span>{$occupancy_val}%</span>
                </div>
                {if $occupancy_val}
                    <div class="cont apartment_types">
                        <table>
                            <tr>
                                <td>Total:</td>
                                <td class="count"><strong>{$params->selected_occupancy->days_beds_count}</strong></td>
                            </tr>
                            <tr>
                                <td>Filled:</td>
                                <td class="count">
                                    <strong>
                                        {if $params->selected_occupancy->occupancy_bdays>$params->selected_occupancy->days_beds_count}
                                            {$params->selected_occupancy->days_beds_count}
                                        {else}
                                            {$params->selected_occupancy->occupancy_bdays}
                                        {/if}
                                    </strong>
                                </td>
                            </tr>
                        </table>
                    </div>
                {/if}
            </div>
        </div>


        <div class="icon_block">
            <div class="icon_bx">
                <i class="i-beds"></i>

                <div class="cont">
                    <div class="title">
                        <span>Vacant</span>
                    </div>
                    {if $params->selected_month=='now'}

                        <table>
                            <tr>
                                <td>Now:</td>
                                <td class="count"><strong>{$stats->beds_available_now}</strong></td>
                            </tr>
                            {*
                            <tr>
                                <td>Last day:</td>
                                <td class="count"><strong>{$stats->beds_available}</strong></td>
                            </tr>
                            *}
                        </table>
                    {else}
                        <span>{$stats->beds_available}</span>
                    {/if}
                </div>
                <div class="cont apartment_types">
                    <div class="title">
                        <span>Ready to sell</span>
                    </div>
                    {if $params->selected_month=='now'}
                        <table>
                            <tr>
                                <td>Now:</td>
                                <td class="count"><strong>{$stats->beds_ready_to_sell_now}</strong></td>
                            </tr>
                            {*
                            <tr>
                                <td>Last day:</td>
                                <td class="count"><strong>{$stats->beds_ready_to_sell}</strong></td>
                            </tr>
                            *}
                        </table>
                    {else}
                        <span>{$stats->beds_ready_to_sell}</span>
                    {/if}
                </div>
            </div>
        </div>

    </div>
    <div>
        <a class="more_link wt" href="{if $params->view=='landlord'}landlord/tenants/{$selected_house->main_id}{else}{url module="TenantsAdmin"}{/if}" data-tooltip="Tenants">Show details <i class="fa fa-external-link"></i></a>
    </div>

</div>


<div class="house_block fx sb">
    <div class="house_bx">
        <h3 class="title_style">Occupancy</h3>
        <div class="house_cont_block occupancy_house">

            {if $occupancy_house}
                <input class="more_ch" id="occupancy_info" type="checkbox">
                <div class="occupancy_days_graph occupancy_months_graph anim fx sb" style="height:175px">
                    {foreach $occupancy_house|array_reverse as $n=>$month}
                        {$d=$month->data}
                        <a class="item{if $month->selected} selected{elseif $month->now} now{elseif $month->future} future{/if}" href="{url month=$month->month|date_format:'%m-%Y'}">
                            <div class="wrapper">
                                {if $d->occupancy>0}
                                    <div class="top_val">{$d->occupancy}%</div>
                                    <div class="val" style="height:{$d->occupancy}%">
                                        {*<div class="occupancy_val">{$d->occupancy}%</div>*}
                                    </div>
                                {/if}
                                <div class="day">
                                    <span>{$month->month|date_format:'%b'}</span>
                                    {$month->month|date_format:'%Y'}
                                </div>
                            </div>
                        </a><!-- item -->
                    {/foreach}
                </div><!-- occupancy_graph -->
                <label class="more_link hide_checked" for="occupancy_info"><i class="left_icon fa fa-table"></i> Show details</label>
                <div class="more_bx">
                    <div class="occupancy_table table_r">
                        <table>
                            <tr class="tr_h">
                                <td rowspan="2">Month</td>
                                <td colspan="2">Beds</td>
                                <td rowspan="2">Occupancy</td>
                            </tr>
                            <tr class="tr_h">
                                <td>Total</td>
                                <td>Filled</td>
                            </tr>
                            <tr><td class="bl" colspan="5"></td></tr>
                            {*
                            <tr class="tr_gtotal br">
                                <td class="text-left">Beds</td>
                                <td>{$params->days_beds_count}</td>
                                <td>{$params->occupancy_bdays}</td>
                                <td>{$params->occupancy}%</td>
                            </tr>
                            <tr><td class="bl" colspan="4"></td></tr>
                            *}

                            {if $occupancy_house}
                                {foreach $occupancy_house as $month}
                                    <tr>
                                        <td class="text-left">
                                            <a href="{url month=$month->month|date_format:'%m-%Y'}">
                                                {$month->month|date_format:'%B'}
                                                {if $params->now_month|date_format:'%Y' != $month->month|date_format:'%Y'}
                                                    {$month->month|date_format:'%Y'}
                                                {/if}
                                            </a>
                                        </td>
                                        <td>
                                            {$month->data->days_beds_count}
                                            {if $month->data->beds_tcount}
                                                ({$month->data->beds_tcount})
                                            {/if}
                                        </td>
                                        <td>
                                            {$month->data->occupancy_bdays}
                                            {if !$month->data->occupancy_bdays && $month->data->occupancy_bdays2}
                                                ({$month->data->occupancy_bdays2*1})
                                            {/if}
                                        </td>

                                        <td class="occupancy_td">
                                            <div class="wrapper fx v c">
                                                {if $month->data->days_beds_count}
                                                    <div class="gr{if $month->data->occupancy<90} red{/if}" style="width:{$month->data->occupancy*1}%"></div>
                                                    <div class="val">{$month->data->occupancy*1}%</div>
                                                {elseif $month->data->beds_tcount}
                                                    <div class="gr" style="width:{$month->data->occupancy2*1}%"></div>
                                                    <div class="val">({$month->data->occupancy2*1}%)</div>
                                                {else}–{/if}
                                            </div>
                                        </td>
                                    </tr>
                                {/foreach}

                                {* {$occupancy->occupancy_average}% *}
                            {/if}
                        </table>
                    </div><!-- table_r -->
                    <label class="more_link mt20" for="occupancy_info"><i class="left_icon fa fa-table"></i> Hide details</label>
                </div>
            {/if}

        </div><!-- house_cont_block -->
    </div><!-- house_bx -->


    <div class="house_bx">
        <h3 class="title_style">Leads</h3>
        <div class="house_cont_block">
            <div class="table_r">
                <table>
                    <tr class="tr_h">
                        <td></td>
                        <td>Leads</td>
                        <td>Applications</td>
                        <td>Contracts</td>
                    </tr>
                    <tr>
                        <td class="bl" colspan="4"></td>
                    </tr>
                    <tr>
                        <td class="strong">Website</td>
                        <td>
                            {if $stats->leads_outpost}
                                {$stats->leads_outpost}
                                {* ({round($stats->leads_outpost/$stats->leads_total*100, 1)}%) *}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->created_bookings_outpost}
                                {$stats->created_bookings_outpost}
                                {* ({round($stats->created_bookings_outpost/$stats->leads_outpost*100, 1)}%) *}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->contracted_outpost}
                                {$stats->contracted_outpost}
                                {* ({round($stats->contracted_outpost/$stats->leads_outpost*100, 1)}%) *}
                            {else}
                                –
                            {/if}
                        </td>
                    </tr>
                    <tr>
                        <td class="strong">3rd Party</td>
                        <td>
                            {if $stats->leads_3_services}
                                {$stats->leads_3_services}
                                {* ({round($stats->leads_3_services/$stats->leads_total*100, 1)}%) *}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->created_bookings_3_services}
                                {$stats->created_bookings_3_services}
                                {* ({round($stats->created_bookings_3_services/$stats->leads_3_services*100, 1)}%) *}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->contracted_3_services}
                                {$stats->contracted_3_services}
                                {* ({round($stats->contracted_3_services/$stats->leads_3_services*100, 1)}%) *}
                            {else}
                                –
                            {/if}
                        </td>
                    </tr>
                    <tr>
                        <td class="strong">Corporate</td>
                        <td>
                            {if $stats->leads_corporate}
                                {$stats->leads_corporate}
                                {* ({round($stats->leads_corporate/$stats->leads_total*100, 1)}%) *}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->created_bookings_corporate}
                                {$stats->created_bookings_corporate}
                                {* ({round($stats->created_bookings_corporate/$stats->leads_corporate*100, 1)}%) *}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->contracted_corporate}
                                {$stats->contracted_corporate}
                                {* ({round($stats->contracted_corporate/$stats->leads_corporate*100, 1)}%) *}
                            {else}
                                –
                            {/if}
                        </td>
                    </tr>
                    <tr>
                        <td class="strong">Offline</td>
                        <td>
                            {if $stats->leads_offline}
                                {$stats->leads_offline}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->created_bookings_offline}
                                {$stats->created_bookings_offline}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->contracted_offline}
                                {$stats->contracted_offline}
                            {else}
                                –
                            {/if}
                        </td>
                    </tr>
                    <tr class="tr_total br">
                        <td class="strong">Total</td>
                        <td>
                            {if $stats->leads_total}
                                {$stats->leads_total}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->created_bookings_total}
                                {$stats->created_bookings_total}
                                {* ({round($stats->created_bookings_total/$stats->leads_total*100, 1)}%) *}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->contracted_total}
                                {$stats->contracted_total}
                                {* ({round($stats->contracted_total/$stats->leads_total*100, 1)}%) *}
                            {else}
                                –
                            {/if}
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div><!-- house_bx -->
</div><!-- house_block -->



<div class="house_block fx sb">
    <div class="house_bx">
        <h3 class="title_style">Contracts</h3>
        <div class="house_cont_block contracts_table_house">
            <div class="table_r">
                <table>
                    <tr class="tr_h">
                        <td></td>
                        <td class="ll"></td>
                        <td>1-3 m</td>
                        <td>4-6 m</td>
                        <td>7+ m</td>
                        <td class="ll"></td>
                        <td>Days</td>
                        <td>Av price</td>
                        <td>Sum</td>
                        <td>ADR</td>
                    </tr>
                    <tr><td class="bl" colspan="8"></td></tr>
                    <tr>
                        <td class="strong">New</td>
                        <td class="ll"></td>
                        <td>
                            {if $stats->contracts->short->new}
                                {$stats->contracts->short->new}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->contracts->middle->new}
                                {$stats->contracts->middle->new}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->contracts->long->new}
                                {$stats->contracts->long->new}
                            {else}
                                –
                            {/if}
                        </td>
                        <td class="ll"></td>
                        <td>
                            {if $stats->contracts->days->new}
                                {$stats->contracts->days->new}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->contracts->av_price->new}
                                $ {$stats->contracts->av_price->new|number_format:2:'.':''}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->contracts->sum->new}
                                $ {$stats->contracts->sum->new|number_format:2:'.':''}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->contracts->adr->new}
                                $ {$stats->contracts->adr->new|number_format:2:'.':''}
                            {else}
                                –
                            {/if}
                        </td>
                    </tr>
                    <tr>
                        <td class="strong">Extension</td>
                        <td class="ll"></td>
                        <td>
                            {if $stats->contracts->short->ext}
                                {$stats->contracts->short->ext}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->contracts->middle->ext}
                                {$stats->contracts->middle->ext}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->contracts->long->ext}
                                {$stats->contracts->long->ext}
                            {else}
                                –
                            {/if}
                        </td>
                        <td class="ll"></td>
                        <td>
                            {if $stats->contracts->days->ext}
                                {$stats->contracts->days->ext}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->contracts->av_price->ext}
                                $ {$stats->contracts->av_price->ext|number_format:2:'.':''}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->contracts->sum->ext}
                                $ {$stats->contracts->sum->ext|number_format:2:'.':''}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->contracts->adr->ext}
                                $ {$stats->contracts->adr->ext|number_format:2:'.':''}
                            {else}
                                –
                            {/if}
                        </td>
                    </tr>
                    <tr class="tr_total br">
                        <td>Total</td>
                        <td class="ll"></td>
                        <td>
                            {if $stats->contracts->short->total}
                                {$stats->contracts->short->total}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->contracts->middle->total}
                                {$stats->contracts->middle->total}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->contracts->long->total}
                                {$stats->contracts->long->total}
                            {else}
                                –
                            {/if}
                        </td>
                        <td class="ll"></td>
                        <td>
                            {if $stats->contracts->days->total}
                                {$stats->contracts->days->total}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->contracts->av_price->total}
                                $ {$stats->contracts->av_price->total|number_format:2:'.':''}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->contracts->sum->total}
                                $ {$stats->contracts->sum->total|number_format:2:'.':''}
                            {else}
                                –
                            {/if}
                        </td>
                        <td>
                            {if $stats->contracts->adr->total}
                                $ {$stats->contracts->adr->total|number_format:2:'.':''}
                            {else}
                                –
                            {/if}
                        </td>
                    </tr>
                </table>
            </div>
            {if $leads_bookings}
                <input class="more_ch" id="leads_bookings_list" type="checkbox">
                <label class="more_link hide_checked mt20" for="leads_bookings_list"><i class="left_icon fa fa-list-ul"></i> Show details</label>
                {* {if $leads_bookings|count > 20}
                    <label class="more_link show_checked inline_block mt20" for="leads_bookings_list"><i class="left_icon fa fa-list-ul"></i> Hide details</label>
                {/if} *}
            {/if}


            {if $leads_bookings}
                <div class="more_bx mt40">
                    <div class="tabs_filter">
                        <input class="t_inp t_inp1" id="cb1" type="radio" name="contracted_bookings" checked>
                        <input class="t_inp t_inp2" id="cb2" type="radio" name="contracted_bookings">
                        <input class="t_inp t_inp3" id="cb3" type="radio" name="contracted_bookings">
                        <div class="tabs_filter_nav fx">
                            <label for="cb1">
                                All
                                {if $stats->leases_count}
                                    <span class="count b">{$stats->leases_count}</span>
                                {/if}
                            </label>
                            <label for="cb2">
                                New
                                {if $stats->new}
                                    <span class="count b">{$stats->new}</span>
                                {/if}
                            </label>
                            <label for="cb3">
                                Extension
                                {if $stats->ext}
                                    <span class="count b">{$stats->ext}</span>
                                {/if}
                            </label>
                        </div>
                        <div class="journal_content">
                            <div class="list_1 s_counter">
                                {foreach $leads_bookings as $b}
                                    {if $params->view=='landlord'}
                                    <div class="item cont_t cont_t1 {if $b->sp_type==3 && $b->parent_id}{elseif $b->sp_type==1 && $b->parent_id}cont_t3{else}cont_t2{/if} fx sb{if $b->status==3} bg3{elseif $b->status==0} canceled{/if}">
                                    {else}
                                    <a class="item cont_t cont_t1 {if $b->sp_type==3 && $b->parent_id}{elseif $b->sp_type==1 && $b->parent_id}cont_t3{else}cont_t2{/if} fx sb{if $b->status==3} bg3{elseif $b->status==0} canceled{/if}" href="?module=BedAdmin&item={$b->id}" target="_blank">
                                    {/if}
                                        <div class="name">
                                            <span class="n"></span>

                                            <div class="value1 invoice_number">#{$b->id}</div>
                                            <div class="value1" data-tooltip="Created">
                                                {$b->created|date}
                                            </div>
                                            <span class="badges">
												{if $b->sp_type!=3}
                                                    <span class="badge ct_{$b->client_type_id}" title="{$b->client_type}">
													{$b->client_type}
												</span>
                                                {/if}
                                                {if $b->sp_type==3 && $b->parent_id}
                                                    <span class="badge">Rider: Early Move-in</span>
												{elseif $b->sp_type==1 && $b->parent_id}
													<span class="badge">Ext</span>
												{else}
													<span class="badge ct_1">New</span>
                                                {/if}

                                                {if $b->type==2}
                                                    <span class="badge">Apt</span>
                                                {/if}
											</span>
                                            <div class="value1 dates" data-tooltip="Arrive / Depart">
                                                {$b->lease_date_from|date:'M j'}{if $b->lease_date_from|date:'Y' != $b->lease_date_to|date:'Y'}, {$b->lease_date_from|date:'Y'}{/if}
                                                <i class="fa fa-long-arrow-right"></i>
                                                {$b->lease_date_to|date}
                                            </div>
                                            <span class="value1 sm">{$b->lease_days_count} {$b->lease_days_count|plural:'day':'days'}</span>
                                        </div>
                                        <div class="right_bx">
                                            {if $b->contract}
                                                <i class="fa fa-file-o"></i>
                                            {/if}
                                        </div>
                                    {if $params->view!='landlord'}
                                    </a>
                                    {else}
                                    </div>
                                    {/if}
                                {/foreach}
                            </div><!-- list_1 -->
                        </div><!-- journal_content -->
                    </div><!-- tabs_filter -->
                    <label class="more_link mt20" for="leads_bookings_list"><i class="left_icon fa fa-list-ul"></i> Hide details</label>
                </div>
            {/if}



        </div>
    </div><!-- house_bx -->


    <div class="house_bx">
        <h3 class="title_style">Move in/out</h3>
        <div class="house_cont_block moveinout_table_house">

            {*<div class="table_r house_stats_table">
                <table>
                    <tr>
                        <td class="strong">Move-In</td>
                        <td class="strong">{$params->movein_count|number_format:0:'.':' '}</td>
                    </tr>
                    <tr>
                        <td class="strong">Move-Out</td>
                        <td class="strong">{$params->moveout_count|number_format:0:'.':' '}</td>
                    </tr>
                </table>
            </div>*}


            {if $leasings}
                <div class="tabs_filter">
                    <input class="t_inp t_inp1" id="mio1" type="radio" name="moveinout">
                    <input class="t_inp t_inp2" id="mio2" type="radio" name="moveinout">
                    <div class="tabs_filter_nav fx">
                        <label for="mio1">
                            Move-In
                            {if $params->movein_count}
                                <span class="count b">{$params->movein_count}</span>
                            {/if}
                        </label>
                        <label for="mio2">
                            Move-Out
                            {if $params->moveout_count}
                                <span class="count b">{$params->moveout_count}</span>
                            {/if}
                        </label>
                    </div>

                    <div class="list_1 s_counter">
                        {foreach $leasings as $lease}
                            {if $lease->movein || $lease->moveout}
                                <div class="lease_item has_tenants cont_t{if $lease->movein} cont_t1{/if}{if $lease->moveout} cont_t2{/if}">
                                    <div class="lease_info fx sb">
                                        <div class="fx">
                                            <div class="n lease_number"></div>
                                            <div class="lease_type">
                                                {if $lease->movein}
                                                    Move-In
                                                {/if}
                                                {if $lease->moveout}
                                                    Move-Out
                                                {/if}
                                            </div>
                                        </div>
                                        <div class="lease_dates">
                                            {if $lease->movein}<strong>{/if}
                                                {$lease->arrive|date:'M j'}{if $lease->arrive|date:'Y' != $lease->depart|date:'Y'}, {$lease->arrive|date:'Y'}{/if}
                                                {if $lease->movein}</strong>{/if}
                                            <i class="fa fa-long-arrow-right"></i>
                                            {if $lease->moveout}<strong>{/if}
                                                {$lease->depart|date}
                                                {if $lease->moveout}</strong>{/if}

                                            <div class="days_count">
                                                {if $lease->days_units=='nights'}
                                                    {$lease->days_count-1} {($lease->days_count-1)|plural:'night':'nights'}
                                                {else}
                                                    {$lease->days_count} {$lease->days_count|plural:'day':'days'}
                                                {/if}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="lease_tenants">
                                        {$n=0}
                                        {foreach $lease->bookings as $b}
                                            {if $params->view=='landlord'}
                                            <div class="lease_tenant fx sb">
                                            {else}
                                            <a class="lease_tenant fx sb" href="?module=BedAdmin&item={$b->id}" target="_blank">
                                            {/if}
                                                <div class="fx">
                                                    <div class="lease_number">{$n=$n+1}{$n}</div>
                                                    <div class="value1 invoice_number">#{$b->id}</div>
                                                </div>

                                                {if $b->type==2}
                                                    <div class="lease_tenant_client_type sm w_auto">Apartment</div>
                                                {/if}
                                                <div class="lease_tenant_client_type sm w_auto">{$b->client_type}</div>
                                                <div class="lease_dates">
                                                    {$b->arrive|date:'M j'}{if $b->arrive|date:'Y' != $b->depart|date:'Y'}, {$b->arrive|date:'Y'}{/if}
                                                    <i class="fa fa-long-arrow-right"></i>
                                                    {$b->depart|date}

                                                    <span class="days_count sm">
													{if $b->days_units=='nights'}
                                                        {$b->days_count-1} {($b->days_count-1)|plural:'night':'nights'}
                                                    {else}
                                                        {$b->days_count|round} {$b->days_count|plural:'day':'days'}
                                                    {/if}
												</span>
                                                </div>
                                                {if $params->view=='landlord'}
                                                </div>
                                                {else}
                                                </a>
                                                {/if}
                                        {/foreach}
                                    </div>
                                </div>
                            {/if}
                        {/foreach}
                    </div>
                </div>
            {/if}



        </div>
    </div><!-- house_bx -->

</div><!-- house_block -->


<div class="house_block fx sb">
    <div class="house_bx">
        <h3 class="title_style">Property Key Data</h3>
        <div class="house_cont_block">
            <div class="table_r house_stats_table_">
                <table>
                    <tr class="tr_h">
                        <td>Unit</td>
                        <td>Amount</td>
                        <td class="ll"></td>
                        <td>Leasable</td>
                        <td>Occupied</td>
                        <td>Vacant</td>
                    </tr>
                    <tr><td class="bl" colspan="4"></td></tr>
                    {foreach $params->apartments_types as $at}
                        <tr>
                            <td class="strong">{$at->name}</td>
                            <td>{$at->count}</td>
                            <td class="ll"></td>
                            <td>{$at->leasable}</td>
                            <td>{$at->occupied}</td>
                            <td>{$at->vacant}</td>
                        </tr>
                    {/foreach}
                    <tr class="tr_total br">
                        <td>Total</td>
                        <td>{$params->apartments|count}</td>
                        <td class="ll"></td>
                        <td>{$params->apartments_property_key_data->leasable}</td>
                        <td>{$params->apartments_property_key_data->occupied}</td>
                        <td>{$params->apartments_property_key_data->vacant}</td>
                    </tr>
                </table>
            </div>
        </div>
    </div><!-- house_bx -->

    <div class="house_bx">
        <h3 class="title_style">Extension Rate</h3>
        <div class="house_cont_block">
            <span data-tooltip="Extension">{$stats->ext*1}</span>/<span data-tooltip="Move-Out">{$params->moveout_count*1}</span>
            {$moveout_count=$params->moveout_count}
            {if $moveout_count==0}
                {$moveout_count=1}
            {/if}
            <div style="font-size: 20px; font-weight: 600; color: #4A4E66">{round($stats->ext/$moveout_count * 100)}%</div>
        </div>
    </div><!-- house_bx -->

</div><!-- house_block -->