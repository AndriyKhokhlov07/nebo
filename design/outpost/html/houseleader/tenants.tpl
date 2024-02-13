{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}
{$apply_button_hide=1 scope=parent}

{$members_menu=1 scope=parent}


<link href="design/{$settings->theme|escape}/css/landlord/landlord.css?v1.0.37" rel="stylesheet">




{if $houses|count > 1}
    {$nav_url = 'houseleader/calendar/'}
    {include file='landlord/bx/houses_nav.tpl'}
{/if}

<div class="page_wrapper w1300">

 
    <div class="title_bx">
        <h1 class="title">{$selected_house->name|escape}</h1>
        {if $selected_house->blocks2['address']}
            <p class="tn_address">
                <i class="fa fa-map-marker"></i>
                {$selected_house->blocks2['address']}
            </p>
        {/if}
    </div>

    {include file='houseleader/bx/calendar.tpl'}
    

 
</div><!-- page_wrapper -->



{if $type_view=='calendar'}
{literal}
<script>


$(function() {

$('.c_booking').on('click', function(e){
    $('.c_booking.hover').removeClass('hover');
    $(this).toggleClass('hover');
    c_booking = $(this).closest('.c_booking');
    m_info = $(this).closest('.c_booking').find('.m_info');  

    $(m_info).css({bottom:'100%',left:e.offsetX+'px', transform:'translateX(-50%)'});
});
$('.c_booking > .z').hover(function(){
    item_el = $(this);
    m_info = $(this).closest('.c_booking').find('.m_info');     
    $(document).mousemove(mouse);
}, function(){
    $(document).off("mousemove", mouse);
});
function mouse(e){
    m_info.css({'left': e.pageX - item_el.offset().left + 'px'});
}

// window.onscroll = function () {
//     el = document.querySelector('.days_lines');
//     if(window.scrollY > 200)
//     {
//         line_top = window.scrollY - 205;
//         el.style.top = line_top+'px';
//     }
// };
el = document.querySelector('.days_lines');
page_wrap = document.querySelector('.page_wrapper');

window.onscroll = function () {
    if(window.scrollY > 200)
    {
        line_top = window.scrollY - document.querySelector('.page_wrapper').offsetTop - 85;
        el.style.top = line_top+'px';
    }
    else{
        el.style.top = '-40px';
    }
};
if($(window).width() < 650){
    el.style.top = '-40px';
    page_wrap.scrollLeft = 400;

}

});

</script>
{/literal}
{/if}

