{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}
{$apply_button_hide=1 scope=parent}

{$members_menu=1 scope=parent}


<link href="design/{$settings->theme|escape}/css/landlord/landlord.css?v1.0.13" rel="stylesheet">



<div class="page_wrapper w900">


    <div class="notifications_block">
        <div class="title_bx">
            <h1 class="title">Bookings</h1>
        </div><!-- title_bx -->
        {if $notifications_bookings}
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
                                <span class="count">
                                    {if $houses[$b->house_id]->type == 1}
                                        {$b->days_count-1} {($b->days_count-1)|plural:'night':'nights'}
                                    {else}
                                        {$b->days_count} {$b->days_count|plural:'day':'days'}
                                    {/if}
                                </span>
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
            <div class="load_more" data-page="1">Show more</div>
        </div><!-- notifications -->
        {else}
            No bookings
        {/if}
        
    </div><!-- notifications_block -->


</div><!-- page_wrapper -->



{literal}
<script>

let load_n_bookings = 0;
let notifications_list = $('.notifications .list1');

$('.load_more').live('click', function(){
    let load_more_btn = $(this);
    let page_num = load_more_btn.attr('data-page');
    page_num ++;
    load_more_btn.addClass('dwld');
    if(load_n_bookings == 0){
        load_n_bookings = 1;

        $.get(
            'ajax/get_notifications_bookings.php',
            {
                page: page_num
            },
            function(data){
                if(data.items > 0){
                    load_n_bookings = 0;
                    load_more_btn.removeClass('dwld');
                    notifications_list.append(data.tpl);
                    load_more_btn.attr('data-page', page_num);
                }
                else{
                    load_more_btn.addClass('hide');
                }

            }, "json"
        );
    }
});
   
</script>
{/literal}

