{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}
{$apply_button_hide=1 scope=parent}

{$members_menu=1 scope=parent}


<link href="design/{$settings->theme|escape}/css/landlord.css?v1.0.0" rel="stylesheet">


{if $houses|count > 1}
<div class="tab_nav">
    <div class="wrapper w1300">
        <ul>
            {foreach $houses as $h}
            <li{if $h->selected} class="selected"{/if}>
                <a href="landlord/tenants/{$h->id}">{$h->name}</a>
                {if $h->selected}<div class="l"></div>{/if}
            </li>
            {/foreach}
        </ul>
    </div>
</div><!-- tab_nav -->
{/if}

<div class="page_wrapper w1300">
    <div class="title_bx">
        <h1 class="title">Tenants of {$selected_house->name|escape}</h1>
    </div>


    <div class="tag_filter_block">
        <a href="{url tenant_status=1}" {if !$tenant_status || $tenant_status==1}class="selected"{/if}>
            Current
            {if $counts->current}
                <span class="count">{$counts->current}</span>
            {/if}
        </a>
        <a href="{url tenant_status=2}" {if $tenant_status==2}class="selected"{/if}>
            Future
            {if $counts->future}
                <span class="count">{$counts->future}</span>
            {/if}
        </a>
        <a href="{url tenant_status=3}" {if $tenant_status==3}class="selected"{/if}>Archive</a>
    </div><!-- tag_filter_block -->





{function name=tenant}
    <div class="tenant fx sb">
        <div class="left_info fx">
            <div class="n fx v c"><div>{$n}</div></div>
            <div class="icon">
                <i class="fa fa-user"></i>
            </div>
            <div class="name">
                {$u->name|escape}
            </div>
            <div class="booking_period s">
                {$u->inquiry_arrive|date} -  {$u->inquiry_depart|date}
            </div>
        </div>
        <div class="right_info fx">
            <div class="download_doc"></div>
        </div>
    </div><!-- tenant -->
{/function}

    <div class="units_tenants_block">
        {foreach $apartments as $apartment}
            {$n=0}
            <div class="unit_tenants fx">
                <div class="unit_bx">
                    <div class="title">{$apartment->name|escape}</div>
                </div><!-- unit_bx -->
                <div class="tenants_bx">
                    {if $apartments_users[$apartment->id]}
                        {foreach $apartments_users[$apartment->id] as $u}
                            {$n=$n+1}
                            {tenant u=$u n=$n}
                        {/foreach}
                    {else}
                        <div class="no_tenants">No tenants</div>
                    {/if}
                </div><!-- tenants_bx -->
            </div><!-- unit_tenants -->
        {/foreach}
    </div><!-- units_tenants_block -->

    {*
    <div class="units_tenants_block">
        {foreach $apartments as $apartment}
            {$n=0}
            <div class="unit_tenants fx">
                <div class="unit_bx">
                    <div class="title">{$apartment->name|escape}</div>
                </div><!-- unit_bx -->
                <div class="tenants_bx">
                    {if $apartments_users[$apartment->id]}
                        {foreach $apartments_users[$apartment->id] as $u}
                            {$n=$n+1}
                            {tenant u=$u n=$n}
                        {/foreach}
                    {else}
                        <div class="no_tenants">No tenants</div>
                    {/if}
                </div><!-- tenants_bx -->
            </div><!-- unit_tenants -->
        {/foreach}
        {if $apartments_users['no_apartment']}
            <div class="unit_tenants fx">
                <div class="unit_bx"></div>
                <div class="tenants_bx">
                    {foreach $apartments_users['no_apartment'] as $u}
                        {$n=$n+1}
                        {tenant u=$u n=$n}
                    {/foreach}
                </div><!-- tenants_bx -->
            </div><!-- unit_tenants -->
        {/if}
    </div><!-- units_tenants_block -->

    *}
    
    
 
</div><!-- page_wrapper -->





{*

<label for="guests_{$h->id}">Current tenants</label>
                        <label for="future_{$h->id}">Future tenants</label>
                        <label for="archive_{$h->id}">Archive tenants</label>


<div class="page_wrap">
    <div class="guest_home landlord_home w1200">
        <div class="fx w w100">
        {if $houses}
            {foreach $houses as $h}
            <input type="radio" name="houses" id="h_{$h->id}" {if $h@iteration == 1}checked{/if} class="hide">
            {/foreach}
            <div class="tabs houses">
                {foreach $houses as $h}
                <label for="h_{$h->id}" data-class="h_{$h->id}">{$h->name}</label>
                {/foreach}
            </div>
            
            {foreach $houses as $h}
            <div class="item user_bookings booking_invoices h_{$h->id} {if $h@iteration == 1}first{/if}">
                <div class="header_bx fx w w100">
                    <div class="icon">
                        <i class="fa fa-user"></i>
                    </div>
                    <div class="title_bx fx v c">
                        <div class="title">Tenants of {$h->name}</div>
                            <p></p>
                            <p>{$h->guests|@count} people live now.</p>
                    </div><!-- title_bx -->
                </div><!-- header_bx -->
                <div class="box">
                    <input type="radio" name="tabs_{$h->id}" id="guests_{$h->id}" class="hide" checked="">
                    <input type="radio" name="tabs_{$h->id}" id="future_{$h->id}" class="hide">
                    <input type="radio" name="tabs_{$h->id}" id="archive_{$h->id}" class="hide">
                    {if $h->guests || $h->future || $h->archive}
                    <div class="tabs">
                        <label for="guests_{$h->id}">Current tenants</label>
                        <label for="future_{$h->id}">Future tenants</label>
                        <label for="archive_{$h->id}">Archive tenants</label>
                    </div>
                    {/if}
                    {if $h->guests}
                    <table class="table_s guests">
                        <!-- <tr>
                            <th>Type</th>
                            <th>Description</th>
                            <th></th>
                            <th></th>
                        </tr> -->

                        {foreach $h->guests as $u}
                        {$contract = $u->contracts[0]}
                        <tr>
                            <td>
                                <div>{$u->name}</div>
                                <div class="c green">
                                    Tenant
                                </div>
                            </td>
                            <td>
                                {if $contract->price_month > 0}
                                {$contract->price_month}/month
                                {else}
                                CC / 3PS
                                {/if}
                            </td>
                            <td>
                                {$u->bed_journal->arrive|date} -  {$u->bed_journal->depart|date}
                            </td>
                            {$paid_invoices = null}
                            {if $u->invoices}
                                {foreach $u->invoices as $inv}
                                {if $inv->paid}
                                {$paid_invoices[] = $inv->paid}
                                {/if}
                                {/foreach}
                            {/if}
                            <td class="inv_td">
                                <div class="nowrap">Invoices:&nbsp;paid {$paid_invoices|@count} of {$u->invoices|@count}</div>
                                <input type="checkbox" id="invoices_{$u->id}" class="hide invoices_label">
                                {if $u->invoices}
                                <label for="invoices_{$u->id}" class="show_invs">Show invoices</label>
                                <label for="invoices_{$u->id}" class="hide_invs">Hide invoices</label>

                                <div class="hide">
                                    {foreach $u->invoices as $inv}
                                    {if $inv->status == 2}
                                    <a href="{$root_url}/order/{$inv->url}?u={$u->id}">{(strtotime($inv->date_from|date)-(5*24*60*60))|date_format:'%b %e, %Y'} / ${$inv->total_price}</a>
                                    {else}
                                    <span>{(strtotime($inv->date_from|date)-(5*24*60*60))|date_format:'%b %e, %Y'} / ${$inv->total_price}</span>
                                    {/if}
                                    {/foreach}
                                </div>
                                {/if}
                            </td>
                            <td>
                                {if $u->contracts && $contract->type != 1 && $contract->type != 2}
                                    <a class="more_inv nowrap" href="{$root_url}/contract/{$contract->url}?download=1">Download contract</a>
                                {elseif $u->contracts && $contract->type == 1}
                                    <a class="more_inv nowrap" href="{$root_url}/files/contracts/{$contract->url}/contract.pdf">Download contract</a>
                                {else}
                                    CC / 3PS
                                {/if}
                            </td>
                        </tr>
                        {/foreach}

                    </table>
                    {/if}
                    {if $h->future}
                    <table class="table_s future">
                        <!-- <tr>
                            <th>Type</th>
                            <th>Description</th>
                            <th></th>
                            <th></th>
                        </tr> -->

                        {foreach $h->future as $k=>$day}
                        {foreach $day as $u}
                        {if $month != (strtotime($k))|date_format:'%b'}
                        <tr class="background_fff w100">
                            <td>
                                <div class="title red_color">{(strtotime($k))|date_format:'%b'}</div>
                            </td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        {/if}
                        {$month = (strtotime($k))|date_format:'%b'}

                        {$contract = $u->contracts[0]}
                        <tr>
                            <td>
                                <div>{$u->name}</div>
                                <div class="c orange">
                                    Future
                                </div>
                            </td>
                            <td>
                                {if $contract->price_month}
                                Price: {$contract->price_month}/month
                                {else}
                                   CC / 3PS
                                {/if}
                            </td>
                            <td>
                                {$u->bed_journal->arrive|date} -  {$u->bed_journal->depart|date}
                            </td>
                            {$paid_invoices = null}
                            {if $u->invoices}
                                {foreach $u->invoices as $inv}
                                {if $inv->paid}
                                {$paid_invoices[] = $inv->paid}
                                {/if}
                                {/foreach}
                            {/if}
                            <td class="inv_td">
                                <div class="nowrap">Invoices:&nbsp;paid {$paid_invoices|@count} of {$u->invoices|@count}</div>
                                <input type="checkbox" id="invoices_{$u->id}" class="hide invoices_label">
                                {if $u->invoices}
                                <label for="invoices_{$u->id}" class="show_invs">Show invoices</label>
                                <label for="invoices_{$u->id}" class="hide_invs">Hide invoices</label>

                                <div class="hide">
                                    {foreach $u->invoices as $inv}
                                    {if $inv->status == 2}
                                    <a href="{$root_url}/order/{$inv->url}">{(strtotime($inv->date_from|date)-(5*24*60*60))|date_format:'%b %e, %Y'} / ${$inv->total_price}</a>
                                    {else}
                                    <span>{(strtotime($inv->date_from|date)-(5*24*60*60))|date_format:'%b %e, %Y'} / ${$inv->total_price}</span>
                                    {/if}
                                    {/foreach}
                                </div>
                                {/if}
                            </td>
                            <td>
                                {if $u->contracts && $contract->type != 1 && $contract->type != 2}
                                    <a class="more_inv nowrap" href="{$root_url}/contract/{$contract->url}?download=1">Download contract</a>
                                {else}
                                   CC / 3PS
                                {/if}
                            </td>
                        </tr>
                        {/foreach}
                        {/foreach}

                    </table>
                    {/if}
                    {if $h->archive}
                    <table class="table_s archive">
                        <!-- <tr>
                            <th>Type</th>
                            <th>Description</th>
                            <th></th>
                            <th></th>
                        </tr> -->

                        {foreach $h->archive as $u}
                        {$contract = $u->contracts[0]}
                        <tr>
                            <td>
                                <div>{$u->name}</div>
                                <div class="c red">
                                    Archive
                                </div>
                            </td>
                            <td>
                                {if $contract->price_month}
                                Price: {$contract->price_month}/month
                                {else}
                               CC / 3PS
                                {/if}
                            </td>
                            <td>
                                {$u->bed_journal->arrive|date} -  {$u->bed_journal->depart|date}
                            </td>
                            {$paid_invoices = null}
                            {if $u->invoices}
                                {foreach $u->invoices as $inv}
                                {if $inv->paid}
                                {$paid_invoices[] = $inv->paid}
                                {/if}
                                {/foreach}
                            {/if}
                            <td class="inv_td">
                                <div class="nowrap">Invoices:&nbsp;paid {$paid_invoices|@count} of {$u->invoices|@count}</div>
                                <input type="checkbox" id="invoices_{$u->id}" class="hide invoices_label">
                                {if $u->invoices}
                                <label for="invoices_{$u->id}" class="show_invs">Show invoices</label>
                                <label for="invoices_{$u->id}" class="hide_invs">Hide invoices</label>

                                <div class="hide">
                                    {foreach $u->invoices as $inv}
                                    {if $inv->status == 2}
                                    <a href="{$root_url}/order/{$inv->url}">{(strtotime($inv->date_from|date)-(5*24*60*60))|date_format:'%b %e, %Y'} / ${$inv->total_price}</a>
                                    {else}
                                    <span>{(strtotime($inv->date_from|date)-(5*24*60*60))|date_format:'%b %e, %Y'} / ${$inv->total_price}</span>
                                    {/if}
                                    {/foreach}
                                </div>
                                {/if}
                            </td>
                            <td>
                                {if $u->contracts && $contract && $contract->type != 1 && $contract->type != 2}
                                    <a class="more_inv nowrap" href="{$root_url}/contract/{$contract->url}?download=1">Download contract</a>
                                {else}
                                   CC / 3PS
                                {/if}
                            </td>
                        </tr>
                        {/foreach}

                    </table>
                    {/if}
                </div><!-- box -->
            </div><!-- item / bookings -->
            {/foreach}
        {/if}
        </div>
    </div>
</div>

*}
            
