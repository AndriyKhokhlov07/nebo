
{if $notifications_bookings}
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
                </div>
            </div>
        </div>
    {/foreach}
{/if}
        

