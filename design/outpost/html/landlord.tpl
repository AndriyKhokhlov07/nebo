{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}
{$apply_button_hide=1 scope=parent}

{$members_menu=1 scope=parent}


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
                        {* <tr>
                            <th>Type</th>
                            <th>Description</th>
                            <th></th>
                            <th></th>
                        </tr> *}

                        {foreach $h->guests as $u}
                        {$contract = $u->contracts|first}
                        <tr>
                            <td>
                                <div>{$u->name}</div>
                                <div class="c green">
                                    Tenant
                                </div>
                            </td>
                            <td>
                                {if $contract->price_month > 0}
                                {$contract->price_month*1} $/month
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
                                {*
                                {if $u->contracts && $contract->type != 1 && $contract->type != 2}
                                    <a class="more_inv nowrap" href="{$root_url}/contract/{$contract->url}?download=1">Download contract</a>
                                {elseif $u->contracts && $contract->type == 1}
                                *}

                                {if $contract}
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
                        {* <tr>
                            <th>Type</th>
                            <th>Description</th>
                            <th></th>
                            <th></th>
                        </tr> *}

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

                        {$contract = $u->contracts|first}
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
                                {* {if $u->contracts && $contract->type != 1 && $contract->type != 2}
                                    <a class="more_inv nowrap" href="{$root_url}/contract/{$contract->url}?download=1">Download contract</a>
                                 *}
                                {if $contract}
                                     <a class="more_inv nowrap" href="{$root_url}/files/contracts/{$contract->url}/contract.pdf">Download contract</a>
                                    
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
                        {* <tr>
                            <th>Type</th>
                            <th>Description</th>
                            <th></th>
                            <th></th>
                        </tr> *}

                        {foreach $h->archive as $u}
                        {$contract = $u->contracts|first}
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
                                {* {if $u->contracts && $contract && $contract->type != 1 && $contract->type != 2}
                                    <a class="more_inv nowrap" href="{$root_url}/contract/{$contract->url}?download=1">Download contract</a>
                                 *}
                                {if $contract}
                                    <a class="more_inv nowrap" href="{$root_url}/files/contracts/{$contract->url}/contract.pdf">Download contract</a>
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
            
