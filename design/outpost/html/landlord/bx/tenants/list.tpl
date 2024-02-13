
    
    
{function name=tenant}
<div class="tenant fx sb">
    <div class="left_info fx">
        {* <div class="n fx v c"><div>{$n}</div></div> *}
        
        <div class="tenant_name"{if $b->users|count>1} title="{$b->users|count} tenants"{/if}>
            <div class="icon{if $b->movein} green{elseif $b->moveout} red{/if}">
                {if $b->users|count>1}
                    <i class="fa fa-users"></i>
                {else}
                    <i class="fa fa-user"></i>
                {/if}
            </div>
            {foreach $b->users as $u}
                {$u->name|escape}{if $u@iteration>1 && !$u@last}, {/if}
            {/foreach}
        </div>
        <div class="booking_period s">
            {$b->arrive|date:'M j'}{if $b->arrive|date:'Y' != $b->depart|date:'Y'}, {$b->arrive|date:'Y'}{/if}
            <i class="fa fa-long-arrow-right"></i> 
            {$b->depart|date:'M j, Y'}
            <div class="b_info">
                <div class="days_count">
                    {if $days_units == 'nights'}
                        {$b->days_count-1} {($b->days_count-1)|plural:'night':'nights'}
                    {else}
                        {$b->days_count} {($b->days_count)|plural:'day':'days'}
                    {/if}
                </div>
                <div class="b_line">
                    <div class="b_active" style="width:{$b->live_width}%"></div>
                </div>
            </div>
        </div>
        <div class="price">
            {if $b->client_type_id==5}
                –
            {elseif in_array($b->client_type_id, [2]) && $b->price_30_days>0}
                $ {$b->price_30_days|convert}
            {elseif $b->contract && $b->contract->price_month > 0}
                $ {$b->contract->price_month|convert}
            {elseif $b->price_month > 0}
                $ {$b->price_month|convert}
            {/if}
        </div>
        <div class="price">
            {if $b->client_type_id==5}
                –
            {elseif $b->contract && $b->contract->total_price > 0}
                $ {$b->contract->total_price|convert}
            {elseif $b->total_price > 0}
                $ {$b->total_price|convert}
            {/if}
        </div>
    </div>
    

    <div class="right_info fx">
        {if $b->client_type_id==5}
            <div class="cont">House Leader</div>
        {elseif $b->contract}
            <a class="download_doc fx" href="{$root_url}/files/contracts/{$b->contract->url}/contract.pdf" target="_blank">
                <span>#{if $b->contract->sku}{$b->contract->sku}{else}{$b->contract->id}{/if}</span>
                <i class="icon"></i>
            </a>
        {elseif $b->airbnb_reservation_id}
            <div class="cont">{$b->airbnb_reservation_id}</div>
        {else}
            <div class="cont">Airbnb</div>
        {/if}
    </div>
    
</div><!-- tenant -->
{/function}


{if !$tenant_status || $tenant_status==1 || $tenant_status==4}
<div class="units_tenants_block">
    {if $apartments && $params->days_beds_count}
    <div class="units_tenants_header fx sb">
        <div class="left_info fx">
            <div class="th room_th">Room</div>
            <div class="th room_th">Bed</div>
            <div class="th tenant_th">Tenant</div>
            <div class="th period_th">Arrive / Depart</div>
            <div class="th price_th">Month</div>
            <div class="th price_th total_th_">Total</div>
        </div><!-- left_info -->
        <div class="right_info fx">
            <div class="th contract_th">Contract</div>
        </div>
    </div><!-- units_tenants_header -->
    {elseif !$days_beds_count}
        Empty house
    {elseif $apartments}
        Empty tenants
    {/if}
    {foreach $apartments as $apartment}
        {if ($apartment->rooms_visible || $apartment->bed_bookings || $apartment->apartment_bookings) && $apartment->visible}
        {$n=0}
        <div class="unit_tenants fx">
            <div class="unit_bx">
                <div class="title">
                    {$apartment->name|escape}
                    {if !$apartment->visible}
                        [off]
                    {/if}
                </div>
            </div><!-- unit_bx -->
            <div class="room_tenants_bx{if $apartment->apartment_bookings} isset_apartment_bookings{/if}">
                {if $apartment->apartment_bookings}
                {foreach $apartment->bookings as $b}
                    <div class="apartment_bookings_wrapper fx">
                        <div class="left_w">
                            {foreach $apartment->rooms as $room}
                            <div class="room_tenants fx">
                                <div class="room_bx">
                                    <div class="title">
                                        &nbsp; {* {$room->name|escape} *}
                                        {if !$room->visible}
                                            [off]
                                        {/if}
                                    </div>
                                </div>
                                <div class="tenants_bx">
                                    {foreach $room->beds as $bed}
                                        <div class="room_tenants fx">
                                            <div class="room_bx">
                                                <div class="title">{$bed->name|escape}</div>
                                            </div>
                                        </div>
                                    {/foreach}
                                </div>
                            </div><!-- room_tenants -->
                            {/foreach}
                        </div><!-- left_w -->
                        <div class="right_w">
                            
                            <div class="apartment_booking fx">
                                <div class="tenants_w">
                                    <div class="wrapper">
                                    {foreach $b->users as $u}
                                        <div class="tenant_name">
                                            <div class="icon{if $b->movein} green{elseif $b->moveout} red{/if}">
                                                <i class="fa fa-user"></i>
                                            </div>
                                            {$u->name|escape}
                                        </div>
                                    {/foreach}
                                    </div>
                                </div><!-- tenants_w -->
                                <div class="apartment_booking_info">
                                    <div class="tenant fx sb">
                                        <div class="left_info fx">
                                            <div class="booking_period s">
                                                {$b->arrive|date:'M j'}{if $b->arrive|date:'Y' != $b->depart|date:'Y'}, {$b->arrive|date:'Y'}{/if}
                                                <i class="fa fa-long-arrow-right"></i> 
                                                {$b->depart|date:'M j, Y'}
                                                <div class="b_info">
                                                    <div class="days_count">
                                                        {if $days_units == 'nights'}
                                                            {$b->days_count-1} {($b->days_count-1)|plural:'night':'nights'}
                                                        {else}
                                                            {$b->days_count} {($b->days_count)|plural:'day':'days'}
                                                        {/if}
                                                    </div>
                                                    <div class="b_line">
                                                        <div class="b_active" style="width:{$b->live_width}%"></div>
                                                    </div>
                                                </div>
                                            </div><!-- booking_period -->
                                            <div class="price">
                                                {if $b->client_type_id==5}
                                                    –
                                                {elseif $b->contract && $b->contract->price_month > 0}
                                                    $ {$b->contract->price_month|convert}
                                                {elseif $b->price_month > 0}
                                                    $ {$b->price_month|convert}
                                                {/if}
                                            </div>
                                            <div class="price">
                                                {if $b->client_type_id==5}
                                                    –
                                                {elseif $b->contract && $b->contract->total_price > 0}
                                                    $ {$b->contract->total_price|convert}
                                                {elseif $b->total_price > 0}
                                                    $ {$b->total_price|convert}
                                                {/if}
                                            </div>
                                        </div><!-- left_info -->
                                        <div class="right_info fx">
                                            {if $b->client_type_id==5}
                                                <div class="cont">House Leader</div>
                                            {elseif $b->contract}
                                                <a class="download_doc fx" href="{$root_url}/files/contracts/{$b->contract->url}/contract.pdf" target="_blank">
                                                    <span>#{if $b->contract->sku}{$b->contract->sku}{else}{$b->contract->id}{/if}</span>
                                                    <i class="icon"></i>
                                                </a>
                                            {elseif $b->airbnb_reservation_id}
                                                <div class="cont">{$b->airbnb_reservation_id}</div>
                                            {else}
                                                <div class="cont">Airbnb</div>
                                            {/if}
                                        </div>
                                    </div><!-- tenant -->
                                </div><!-- apartment_booking_info -->
                                
                            </div><!-- apartment_booking -->
                            
                            
                        </div><!-- right_w -->
                    </div><!-- apartment_bookings_wrapper -->
                {/foreach}
                {/if}
                {if $apartment->bed_bookings || (!$apartment->apartment_bookings && !$apartment->bed_bookings)}
                    {foreach $apartment->rooms as $room}

                        <div class="room_tenants fx{if !$room->isset_bookings} empty{/if}">
                            <div class="room_bx{if !$room->isset_bookings} empty{/if}">
                                <div class="title">
                                    &nbsp; {* {$room->name|escape} *}
                                    {if !$room->visible}
                                        [off]
                                    {/if}
                                </div>
                            </div>

                            <div class="tenants_bx">
                            {foreach $room->beds as $bed}
                                <div class="room_tenants fx">
                                    <div class="room_bx{if !$bed->bookings} empty{/if}">
                                        <div class="title">{$bed->name|escape}</div>
                                    </div>

                                    <div class="tenants_bx">

                                        {if $bed->bookings}
                                            {foreach $bed->bookings as $booking}
                                                {$n=$n+1}
                                                {tenant b=$booking n=$n}
                                            {/foreach}
                                        {else}
                                            <div class="no_tenants">Empty</div>
                                        {/if}
                                    </div><!-- tenants_bx -->
                                </div><!-- room_tenants -->
                            {/foreach}
                            </div><!-- tenants_bx -->
                        </div><!-- room_tenants -->
                    {/foreach}
                {/if}
            </div><!-- room_tenants_bx -->
        </div><!-- unit_tenants -->    
        {/if}
    {/foreach}
</div><!-- units_tenants_block -->

{elseif $tenant_status==2 || $tenant_status==3}
<div class="units_tenants_block">
    {if $bookings}
    <div class="units_tenants_header fx sb">
        <div class="left_info fx">
            <div class="th unit_room_th">Unit / Room / Bed</div>
            <div class="th tenant_th">Tenant</div>
            <div class="th period_th">Arrive / Depart</div>
            <div class="th price_th">Month</div>
            <div class="th price_th total_th_">Total</div>
        </div><!-- left_info -->
        <div class="right_info fx">
            <div class="th contract_th">Contract</div>
        </div>
    </div><!-- units_tenants_header -->
    {else}
        Empty tenants
    {/if}
    {foreach $bookings as $k=>$bb}
        {$n=0}
        <div class="unit_tenants fx">
            <div class="unit_bx">
                <div class="title m">{$k|date:'F Y'}</div>
            </div><!-- unit_bx -->
            <div class="room_tenants_bx">
                {foreach $bb as $b}
                    <div class="room_tenants fx">
                        <div class="unit_rooms_bx">
                            {if $b->type==1}
                                <div class="nm">{$apartments[$b->apartment_id]->name}</div>
                                {if $apartments[$b->apartment_id]->rooms[$b->room_id]}
                                    <div class="nm">{$apartments[$b->apartment_id]->rooms[$b->room_id]->name}</div>
                                    {if $apartments[$b->apartment_id]->rooms[$b->room_id]->beds[$b->object_id]}
                                        <div class="nm">{$apartments[$b->apartment_id]->rooms[$b->room_id]->beds[$b->object_id]->name}</div>
                                    {/if}
                                {/if}
                            {elseif $b->type==2}
                                <div class="nm">{$apartments[$b->object_id]->name}</div>
                                <div class="badge">Full apartment</div>
                            {/if}
                        </div>
                        <div class="tenants_2_bx">
                            {tenant b=$b n=$n}
                        </div><!-- tenants_bx -->
                    </div><!-- room_tenants -->
                {/foreach}
            </div><!-- room_tenants_bx -->
        </div><!-- unit_tenants --> 
    {/foreach}
</div><!-- units_tenants_block -->
{/if}





