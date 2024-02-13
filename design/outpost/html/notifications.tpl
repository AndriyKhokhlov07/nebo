{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}
{$apply_button_hide=1 scope=parent}

{if $notifications_journal && $user->type == 5} 
{$handyman_menu=1 scope=parent}
{else}
{$members_menu=1 scope=parent}
{/if}

<div class="page_wrap">
    <div class="guest_home w1200">
        <div class="fx w w100">

            
            <div class="item user_bookings booking_invoices">
                <div class="header_bx fx w w100">
                    
                    <div class="title_bx fx v c">
                        <div class="title">Notifications</div>
                        {if !$invoices && !$issues && !$new_event && !$new_product && !$cleanings && !$notify && !$notifications_journal}
                            <p></p>
                            <p>No updates</p>
                        {/if}
                        {if $notifications_journal}
                        <span>
                        <br>
                            <a href="create-notification" class="button_red">Add notification</a></span>
                        {/if}
                    </div><!-- title_bx -->
                </div><!-- header_bx -->
                <div class="box">
                    <table class="table_s">
                        {*
                        <tr class="info">
                            <td class="fx vc">
                                <div class="icon blue">
                                    <i class="fa fa-bell"></i>
                                </div>
                                <div>Alert</div>
                            </td>
                            <td>
                                <div>Jul 12, 2022</div>
                            </td>
                            <td style="max-width: 450px;">
                                <div class="txt_bx">
                                    <p>Dear Tenants,</p>
                                    <p>As you may have heard, the price of utilities have been soaring throughout the US, and Outpost Club locations are not immune to this increase. You can read more about this increase here from ConEdison, a major New York City utility provider: <a href="https://bit.ly/3bAqtTb" target="_blank">https://bit.ly/3bAqtTb</a></p>
                                    <p>In some cases, we have switched utility providers, in other cases, we have even bought energy in bulk to mitigate the costs. <strong>Despite this, Outpost Club has seen a 50%-100% increase in utility costs across all properties. As a result, the current cost paid by our tenants does not cover the actual utility bills</strong>. You can see some of our anonymized internal data here: <a href="https://bit.ly/3bNx8ts" target="_blank">bit.ly/3bNx8ts</a></p>
                                    <p><strong>We have no choice but to increase the utility allowance fee to $149/month starting from August 1st, 2022.</strong> This will only affect you if Outpost Club pays your utilities. We have waited as long as financially possible to do this, and hope you understand you have been saving on utility payment for the last couple months because of this delay. Our increase is only in line with the increases we have experienced, and we apologize for the inconvenience.</p>
                                    <p>Sincerely,<br> The Outpost Club Team</p>
                                </div>
                            </td>
                            <td>
                            </td>
                        </tr>
                        *}
                        {if $all_notifications}
                            {foreach $all_notifications as $day}
                            {foreach $day as $n}
                            {if $n->notify_type == 'alert'}
                            <tr class="alert {if $n->active==0}non_active{/if}">
                                <td class="fx vc">
                                    <div class="icon red">
                                        <i class="fa fa-bell"></i>
                                    </div>
                                    <div>Alert
                                    {if $notifications_journal && $n->creator}
                                    <br>{$n->creator}
                                    {/if}
                                    </div>
                                </td>
                                {if $notifications_journal}
                                <td>
                                    <div>
                                    {if $n->subtype == 1 || ($n->type == 9 && $n->subtype == 0)}
                                    {if $apts[$n->object_id]}{$houses[{$apts[$n->object_id]->house_id}]->name} - {$apts[$n->object_id]->name}{/if}
                                    {elseif $n->subtype == 2 || ($n->type == 10 && $n->subtype == 0)}
                                    {if $houses[$n->object_id]}{$houses[$n->object_id]->name}{/if}
                                    {/if}
                                    </div>
                                </td>
                                {/if}
                                <td>
                                    <div>
                                    {$n->date|date}
                                    {if $n->time_from != 0}
                                        from {$n->time_from|date_format:"%I:00 %p"}
                                    {/if}
                                    {if $n->time_to != 0}
                                        to {$n->time_to|date_format:"%I:00 %p"}
                                    {/if}
                                    </div>
                                </td>
                                <td style="max-width: 450px;">
                                    <div>{$n->text}</div>
                                </td>
                                <td>
                                </td>
                            </tr>
                            {elseif $n->notify_type == 'visit'}
                            <tr class="visit {if $n->active==0}non_active{/if}">
                                <td class="fx vc">
                                    <div class="icon orange">
                                        <i class="fa fa-bell"></i>
                                    </div>
                                    <div>Visit
                                    {if $notifications_journal && $n->creator}
                                    <br>{$n->creator}
                                    {/if}
                                    </div>
                                </td>
                                {if $notifications_journal}
                                <td>
                                    <div>
                                        {if $n->subtype == 1 || ($n->type == 9 && $n->subtype == 0)}
                                        {if $apts[$n->object_id]}{$houses[{$apts[$n->object_id]->house_id}]->name} - {$apts[$n->object_id]->name}{/if}
                                        {elseif $n->subtype == 2 || ($n->type == 10 && $n->subtype == 0)}
                                        {if $houses[$n->object_id]}{$houses[$n->object_id]->name}{/if}
                                        {/if}
                                    </div>
                                </td>
                                {/if}
                                <td>
                                    <div>
                                    {$n->date|date}
                                    {if $n->time_from != 0}
                                        from {$n->time_from|date_format:"%I:00 %p"}
                                    {/if}
                                    {if $n->time_to != 0}
                                        to {$n->time_to|date_format:"%I:00 %p"}
                                    {/if}
                                    </div>
                                </td>
                                <td style="max-width: 550px;">
                                    <div>{$n->text}</div>
                                </td>
                                <td>
                                </td>
                            </tr>
                            {elseif $n->notify_type == 'move'}
                            <tr {if $n->active==0}class="non_active"{/if}>
                                <td class="fx vc">
                                    {if $n->type==5}
                                    <div class="icon green">
                                        <i class="fa fa-bell"></i>
                                    </div>
                                    <div>New tenant</div>
                                    {elseif $n->type==6}
                                    <div class="icon orange">
                                        <i class="fa fa-bell"></i>
                                    </div>
                                    <div>Tenant leaving us</div>
                                    {/if}
                                </td>
                                <td>
                                    {if $n->type==5}
                                    Arrive: {$users[$n->object_id]->inquiry_arrive|date}
                                    {elseif $n->type==6}
                                    Depart: {$users[$n->object_id]->inquiry_depart|date}
                                    {/if}
                                </td>
                                <td>
                                    <div class="nowrap">{$users[$n->object_id]->name}</div>
                                    {if $guest->type == 2}
                                    <div class="invoice_desc">{$users[$n->object_id]->house->name}</div>
                                    {/if}
                                </td>
                                <td>
                                    {if $guest->type == 2}
                                    {if $n->type==5}
                                    {if $n->status != 1}
                                    {* <a class="button_red" href="{$root_url}/move-in-checklist/{$users[$n->object_id]->auth_code}" target="_blank">Move-in</a> *}
                                    <a class="button_red" href="{$root_url}/move-in-checklist/{$n->url}" target="_blank">Move-in</a>
                                    {else}
                                    <div class="nowrap">Moved-in</div>
                                    {/if}
                                    {elseif $n->type==6}
                                    {if $n->status != 1}
                                    <a class="button_red" href="{$root_url}/move-out-checklist/{$n->url}" target="_blank">Move-out</a>
                                    {else}
                                    <div class="nowrap">Moved-out</div>
                                    {/if}
                                    {/if}
                                    {/if}
                                </td>
                            </tr>
                            {elseif $n->notify_type == 'invoice'}
                                {$invoice = $n}
                                {if $invoice->status==0 && $first_not_paid != 1}
                                {if $invoice->date|date_format:"%Y-%m-%d"|strtotime <= $smarty.now|date_format:"%Y-%m-%d"|strtotime}
                                {*{$first_not_paid = 1}*}
                                <tr>
                                    <td class="fx vc">
                                        {if $invoice->status==0}
                                            <div class="icon red">
                                                <i class="fa fa-bell"></i>
                                            </div>
                                            <div>
                                            New invoice
                                        {elseif $invoice->status==1}
                                            <div class="icon orange">
                                                <i class="fa fa-bell"></i>
                                            </div>
                                            <div>
                                                Pending invoice
                                        {elseif $invoice->status==4}
                                            <div class="icon red">
                                                <i class="fa fa-bell"></i>
                                            </div>
                                            <div>
                                                Failed invoice
                                        {/if}
                                                <div class="invoice_desc bl">Invoice number: {$invoice->id}</div>
                                            </div>
                                    </td>
                                    <td>
                                        {$invoice->date|date}
                                        {if $invoice->purchases}
                                            {foreach $invoice->purchases as $purchase}
                                                <div class="invoice_desc bl">{$purchase->product_name|escape}</div>
                                            {/foreach}
                                        {/if}
                                    </td>
                                    <td>
                                        <div class="nowrap">{$currency->sign}&nbsp;{$invoice->total_price|convert}</div>
                                        <a class="more_inv nowrap" href="{$root_url}/order/{$invoice->url}" target="_blank">Show detail</a>
                                    </td>
                                    <td>
                                        {if $invoice->status==0 || $invoice->status==4}
                                            <a class="button_red" href="{$root_url}/order/{$invoice->url}" target="_blank">Pay</a>
                                        {/if}
                                    </td>
                                </tr>
                                {/if}
                                {elseif $invoice->status!=0}
                                <tr>
                                    <td class="fx vc">
                                        {if $invoice->status==0}
                                             <div class="icon red">
                                                <i class="fa fa-bell"></i>
                                            </div>
                                            <div>
                                                New invoice
                                            
                                        {elseif $invoice->status==1}
                                             <div class="icon orange">
                                                <i class="fa fa-bell"></i>
                                            </div>
                                            <div>
                                                Pending invoice
                                        {elseif $invoice->status==4}
                                            <div class="icon red">
                                                <i class="fa fa-bell"></i>
                                            </div>
                                            <div>
                                                Failed invoice
                                            
                                        {/if}
                                                <div class="invoice_desc bl">Invoice number: {$invoice->id}</div>
                                            </div>
                                    </td>
                                    <td>
                                        {$invoice->date|date}
                                        {if $invoice->purchases}
                                            {foreach $invoice->purchases as $purchase}
                                                <div class="invoice_desc bl">{$purchase->product_name|escape}</div>
                                            {/foreach}
                                        {/if}
                                    </td>
                                    <td>
                                        <div class="nowrap">{$currency->sign}&nbsp;{$invoice->total_price|convert}</div>
                                        <a class="more_inv nowrap" href="{$root_url}/order/{$invoice->url}" target="_blank">Show detail</a>
                                    </td>
                                    <td>
                                        {if $invoice->status==0 || $invoice->status==4}
                                            <a class="button_red" href="{$root_url}/order/{$invoice->url}" target="_blank">Pay</a>
                                        {/if}
                                    </td>
                                </tr>
                                {/if}
                            {elseif $n->notify_type == 'cleaning'}
                            {$cleaning = $n}
                            <tr>
                                <td class="fx vc">
                                    {if $cleaning->status==0}
                                        <div class="icon red">
                                            <i class="fa fa-bell"></i>
                                        </div>
                                        <div>
                                            New cleaning request
                                    {elseif $cleaning->status==1}
                                        <div class="icon orange">
                                            <i class="fa fa-bell"></i>
                                        </div>
                                        <div>
                                            Pending cleaning
                                    {elseif $cleaning->status==4}
                                        <div class="icon red">
                                            <i class="fa fa-bell"></i>
                                        </div>
                                        <div>
                                            Failed cleaning
                                    {/if}
                                            <div class="invoice_desc bl">cleaning number: {$cleaning->id}</div>
                                        </div>
                                </td>
                                <td>
                                    Order date: {$cleaning->date|date}
                                    {if $cleaning->purchases}
                                        {foreach $cleaning->purchases as $purchase}
                                            <div class="invoice_desc bl">{$purchase->product_name|escape}</div>
                                        {/foreach}
                                    {/if}
                                </td>
                                <td>
                                    <div class="nowrap">{$currency->sign}&nbsp;{$cleaning->total_price|convert}</div>
                                    <a class="more_inv nowrap" href="{$root_url}/order/{$cleaning->url}" target="_blank">Show detail</a>
                                </td>
                                <td>
                                    {if $cleaning->status==0 || $cleaning->status==4}
                                        <a class="button_red" href="{$root_url}/order/{$cleaning->url}" target="_blank">Pay</a>
                                    {/if}
                                </td>
                            </tr>
                            {elseif $n->notify_type == 'cleaning_com_area'}
                            {$cl = $n}
                            <tr {if $cl->active==0}class="non_active"{/if}>
                                <td class="fx vc">
                                    <div class="icon blue">
                                        <i class="fa fa-bell"></i>
                                    </div>
                                    <div>Common area cleaning</div>
                                </td>
                                <td>
                                    {$cl->desired_date|date}
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            {/if}

                            {/foreach}
                            {/foreach}

                        {/if}
                        
                    </table>
                </div><!-- box -->
               
            </div><!-- item / bookings -->
        </div>
    </div>
</div>