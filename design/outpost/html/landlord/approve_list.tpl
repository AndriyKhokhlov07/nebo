{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}
{$apply_button_hide=1 scope=parent}

{$members_menu=1 scope=parent}


<link href="design/{$settings->theme|escape}/css/landlord/landlord.css?v1.0.22" rel="stylesheet">



<div class="page_wrapper w1000">


    <div class="notifications_block">
        <div class="title_bx">
            <h1 class="title">Waiting list</h1>
        </div><!-- title_bx -->

        {if $salesflows}
        <div class="notifications">
            <div class="list1_header fx sb">
                <div class="left_bx fx">
                    <div class="h_name">House / Unit / Bed</div>
                    <div class="u_name">Tenant</div>
                </div>
                <div class="right_bx fx">
                    <div class="b_period">Arrive / Depart</div>
                    <div class="b_prices fx w">
                        <div class="b_price_item">Month</div>
                        <div class="b_price_item">Total</div>
                    </div>
                </div>
            </div>
            <div class="list1 ll_bookings_list ll_approve_list">
                {foreach $salesflows as $s}
                    <a class="item fx sb" href="/landlord/approve/{$s->id}">
                        <div class="left_bx fx">
                            <div class="h_name">
                                {$houses[$s->house_id]->name}
                                <div class="sm">
                                    <i class="fa fa-map-marker"></i>
                                    {$houses[$s->house_id]->blocks2['address']}
                                </div>
                                <div class="apt_bed">
                                    {if $apartments[$s->booking->apartment_id]}
                                        <span class="nm">{$apartments[$s->booking->apartment_id]->name|escape}</span>
                                    {/if}
                                    {if $s->booking->type==1}
                                        {if $beds[$s->booking->object_id]}
                                            <span class="nm">{$beds[$s->booking->object_id]->name|escape}</span>
                                        {/if}
                                    {/if}
                                </div>
                            </div>
                            <div class="u_name">
                                <div class="badge">
                                    {if $s->booking->type==1}
                                        Bed booking
                                    {elseif $s->booking->type==2}
                                        Full apartment booking
                                    {/if}
                                </div>
                                <div class="tenants_name bl">
                                    <i class="fa fa-user"></i>
                                    {$s->user_name|escape}
                                </div>
                            </div>
                        </div>
                        <div class="right_bx fx">
                            <div class="b_period">
                                {$s->booking->arrive|date:'M j'}{if $s->booking->arrive|date:'Y' != $s->booking->depart|date:'Y'}, {$s->booking->arrive|date:'Y'}{/if}
                                <i class="fa fa-long-arrow-right"></i> 
                                {$s->booking->depart|date:'M j, Y'}
                                <span class="count">{$s->booking->days_count}</span>
                            </div>
                            <div class="b_prices fx w">
                                <div class="b_price_item ll_month_price">
                                    {if $s->contract->price_month > 0}
                                        $ {$s->contract->price_month|convert}
                                    {elseif $s->booking->price_month > 0}
                                        $ {$s->booking->price_month|convert}
                                    {/if}
                                </div>
                                <div class="b_price_item ll_total_price">
                                    {if $s->contract->total_price > 0}
                                        $ {$s->contract->total_price|convert}
                                    {elseif $s->booking->total_price > 0}
                                        $ {$s->booking->total_price|convert}
                                    {/if}
                                </div>
                            </div><!-- b_prices -->
                        </div><!-- right_bx -->
                    </a><!-- item -->
                {/foreach}
            </div><!-- list_1 -->
        </div><!-- notifications -->
        {else}
            No data
        {/if}
    </div><!-- notifications_block -->

</div><!-- page_wrapper -->

