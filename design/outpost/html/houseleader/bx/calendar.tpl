

{function name=booking}
    <div class="c_booking st{$booking->status} fx{if $booking->movein} movein{/if}{if $booking->moveout} moveout{/if}{if $booking->parent_id && ($booking->sp_type==1 || $params->parent_booking->sp_type==1) && $booking->start>0} ext{/if}" style="width:calc({$booking->width}% + 2px);left:{$booking->start}%" data-id="{$booking->id}">
        
        <div class="wrapper">
            <div class="s_info">
                {if $booking->client_type_id>1}
                    <i class="client_type ct_{$booking->client_type_id}"></i>
                {/if}
                {$booking->arrive|date:'M j'}{if $booking->arrive|date:'Y' != $booking->depart|date:'Y'}, {$booking->arrive|date:'Y'}{/if}
                <i class="fa fa-long-arrow-right"></i> 
                {$booking->depart|date:'M j, Y'}
            </div><!-- s_info -->
        </div>
        <div class="z"></div>

        <div class="m_info">
            <div class="wrapper">

                <div class="bx fx">
                    <div class="icon">
                        <i class="fa fa-calendar"></i>
                    </div>
                    <div class="cont">
                        <div class="b_title">
                            {if $booking->status==5}
                                Interval
                            {else}
                                Arrive / Depart
                            {/if}
                            <div class="badge">{$booking->days_count} {($booking->days_count)|plural:'day':'days'}</div>
                        </div>
                        <div class="b_val">
                            {$booking->arrive|date:'M j'}{if $booking->arrive|date:'Y' != $booking->depart|date:'Y'}, {$booking->arrive|date:'Y'}{/if}
                            <i class="fa fa-long-arrow-right"></i> 
                            {$booking->depart|date:'M j, Y'}
                        </div>
                    </div><!-- cont -->
                </div><!-- bx -->
                {if $booking->users}
                <div class="bx fx">
                    <div class="icon">
                        <i class="fa fa-user{if $booking->users|count>1}s{/if}"></i>
                    </div>
                    <div class="cont">
                        <div class="b_title">
                            {$booking->users|count|plural:'Tenant':'Tenants'}
                            {if $booking->client_type_id>1}
                                <div class="badge ct_{$booking->client_type_id}">
                                    {$booking->client_type}
                                </div>
                            {/if}
                        </div>
                        <div class="b_val">
                            {foreach $booking->users as $u}
                                {if $u@iteration>1}<br>{/if}
                                {$u->name|escape}<br>Phone: <a href="tel:{$u->phone}">{$u->phone}</a><br>Email: <a href="mailto:{$u->email}">{$u->email}</a><br>
                            {/foreach}
                        </div>
                    </div><!-- cont -->
                </div><!-- bx -->
                <div class="bx fx">
                    <div class="icon">
                        <i class="fa fa-usd"></i>
                    </div>
                    <div class="cont fx">
                        {if $selected_house->type == 1}
                            <div class="column">
                                <div class="b_title">
                                    Night
                                </div>
                                <div class="b_val">
                                    {if $booking->price_night > 0}
                                        $ {$booking->price_night|convert}
                                    {elseif $booking->contract && $booking->contract->total_price > 0}
                                        $ {round($booking->contract->total_price / ($booking->days_count-1), 2)}
                                    {elseif $booking->total_price > 0}
                                        $ {round($booking->total_price / ($booking->days_count-1), 2)}
                                    {/if}
                                </div>
                            </div>
                            
                        {elseif $booking->price_30_days}
                            <div class="column">
                                <div class="b_title">
                                    30 days
                                </div>
                                <div class="b_val">
                                    $ {$booking->price_30_days|convert}
                                </div>
                                {if $booking->house_id!=337}
                                    <div class="b_title">
                                        (Utilities included)
                                    </div>
                                {/if}
                            </div>
                        {else}
                            <div class="column">
                                <div class="b_title">
                                    Month
                                </div>
                                <div class="b_val">
                                    {if $booking->client_type_id==5}
                                        –
                                    {elseif $booking->price_month > 0}
                                        $ {$booking->price_month|convert}
                                    {elseif $booking->contract && $booking->contract->price_month > 0}
                                        $ {$booking->contract->price_month|convert}
                                    {/if}
                                </div>
                            </div>
                        {/if}

                        {if $booking->client_type_id==5 || $booking->total_price > 0 || $booking->contract->total_price > 0}
                        <div class="column">
                            <div class="b_title">
                                Total
                            </div>
                            <div class="b_val">
                                {if $booking->client_type_id==5}
                                    –
                                {elseif $booking->total_price > 0}
                                    $ {$booking->total_price|convert}
                                {elseif $booking->contract && $booking->contract->total_price > 0}
                                    $ {$booking->contract->total_price|convert}
                                {/if}
                            </div>
                        </div>
                        {/if}
                    </div><!-- cont -->
                </div><!-- bx -->
				{/if}
                
                {if $booking->status==5}
                    <div class="bx fx">
                        <div class="icon">
                            <i class="fa fa-exclamation-triangle"></i>
                        </div>
                        <div class="cont">
                            <div class="b_title">Status</div>
                            <div class="b_val">Temporary Closed</div>
                        </div><!-- cont -->
                    </div><!-- bx -->
                {/if}

                {if $booking->note_logs}
                    <div class="bx fx">
                        <div class="icon">
                            <i class="fa fa-bookmark"></i>
                        </div>
                        <div class="cont">
                            <div class="b_title">Note</div>
                            {foreach $booking->note_logs as $l}
                                <div class="b_val">{$l->value}</div>
                            {/foreach}
                        </div><!-- cont -->
                    </div><!-- bx -->
                {/if}
            </div><!-- wrapper -->
        </div><!-- m_info -->
                        
    </div><!-- c_booking -->
{/function}


{if $apartments}

<div class="tenents_calendar">

    <div class="days_lines days_bx days_{$params->days_to_show} fx">
        {foreach $params->calendar_days as $day}
            <div class="d {if $day == $smarty.now|date_format:"%b %d"}today{/if}">
                <span>{$day} </span>
            </div>
        {/foreach}
    </div>
    {$apartments_count=0}
    {foreach $apartments as $apartment}
        {if ($apartment->rooms_visible || $apartment->bed_bookings || $apartment->apartment_bookings) && $apartment->visible}
            {$apartments_count=$apartments_count+1}
        {/if}
    {/foreach}
    {foreach $apartments as $apartment}
        {if ($apartment->rooms_visible || $apartment->bed_bookings || $apartment->apartment_bookings) && $apartment->visible}
        <div class="apartment_bx {if $apartments_count==1}count_apt_1{/if}">
            <div class="title_bx">
                <div>
                    {$apartment->name}
                    {if !$apartment->visible}
                        [off]
                    {/if}
                </div>
            </div><!-- title_bx -->

            <div class="lines_bx"{if $apartment->max_booking_users} style="min-height: {($apartment->max_booking_users*24)+(($apartment->max_booking_users-1)*7)}px"{/if}>
                {if $apartment->apartment_bookings}
                    <div class="f_apartment_bx">
                        {foreach $apartment->bookings as $booking}
                            {booking booking=$booking}
                        {/foreach}
                    </div><!-- f_apartment_bx -->
                {/if}
                {foreach $apartment->rooms as $room}
                    {foreach $room->beds as $bed}
                        {* if ($room->visible && $bed->visible && $bed->width) || ($bed->bookings || $apartment->bookings) *}
                        {if ($room->visible && $bed->visible && $bed->width) || ($bed->bookings)}

                        <div class="line_bx fx">
                            <div class="l_head fx v c">
                                <div>
                                    {if !$room->visible}
                                        [room {$room->name} off] –
                                    {/if}
                                    {$bed->name}
                                </div>
                            </div><!-- l_head -->
                            <div class="l_cont">
                                {if $bed->width}
                                    <div class="l_bg" style="width:{$bed->width}%;left:{$bed->start}%;"></div>  
                                {/if}
                                {if $bed->bookings}
                                    {foreach $bed->bookings as $booking}
                                        {booking booking=$booking}
                                    {/foreach}
                                {/if}
                            </div><!-- l_cont -->
                        </div><!-- line_bx -->
                        {/if}
                    {/foreach}
                {/foreach}
            </div><!-- lines_bx -->
        </div><!-- apartment_bx -->
        {/if}
    {/foreach}
</div><!-- tenents_calendar -->

{/if}