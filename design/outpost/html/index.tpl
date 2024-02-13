<!DOCTYPE html>
{*
    Общий вид страницы
    Этот шаблон отвечает за общий вид страниц без центрального блока.
*}
<html lang="en">
<head>
{literal}
<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-TSNWF2P');</script>
<!-- End Google Tag Manager -->
{/literal}


    <base href="{$config->root_url}/"/>
    <title>{$meta_title|escape}</title>
    
    {* Метатеги *}
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="description" content="{$meta_description|escape}" />
    {*<meta name="keywords"    content="{$meta_keywords|escape}" />*}
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    {*<meta name="yandex-verification" content="a4fca232c041bec1" />
    <meta name="theme-color" content="#2BBA61">
    <meta name="robots" content="noindex, nofollow">*}

    <meta name="robots" content="noindex, nofollow">

    {* Канонический адрес страницы *}
    {if isset($canonical)}<link rel="canonical" href="{$config->root_url}{$canonical}"/>{/if}

{if $current_page_num==2}
    <link rel="prev" href="{$config->root_url}{url page=null}">
{elseif $current_page_num>2}
    <link rel="prev" href="{$config->root_url}{url page=$current_page_num-1}">
{/if}
{if $current_page_num<$total_pages_num}
    <link rel="next" href="{$config->root_url}{url page=$current_page_num+1}">
{/if}
    <link href="design/{$settings->theme|escape}/images/favicon.ico" rel="icon"          type="image/x-icon"/>
    <link href="design/{$settings->theme|escape}/images/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
    
    {* Стили *}
    <link href="design/{$settings->theme|escape}/fonts/fa/font-awesome.min.css?v4.7.0" rel="stylesheet">
        <link href="design/{$settings->theme|escape}/js/slick/slick.css" rel="stylesheet">
    <link href="design/{$settings->theme|escape}/js/slick/slick-theme.css" rel="stylesheet">
    <link href="js/fancybox/jquery.fancybox.min.css" rel="stylesheet">
    <link href="design/{$settings->theme}/js/datepicker/css/datepicker.css" rel="stylesheet">

    <link href="design/{$settings->theme|escape}/css/style.css?v1.0.239" rel="stylesheet">
    <link href="design/{$settings->theme|escape}/css/style2.css?v1.0.102" rel="stylesheet">

    {if $css}
        {foreach $css as $css_href}
            <link href="{$css_href}" rel="stylesheet">
        {/foreach}
    {/if}


    <script src="js/jquery/jquery.js?v1.0.0"></script>
    
    
    {* Всплывающие подсказки для администратора *}

    <meta property="og:locale" content="en_US"/>
    <meta property="og:site_name" content="Ne-Bo Services"/>

    {if $page_type == "post"}

        <meta property="og:type" content="article"/>
        <meta property="og:title" content="{$post->name|escape}"/>
        {if $meta_description}<meta property="og:description" content='{$meta_description}'/>{/if}

        {if $post->image}
            <meta property="og:image" content="{$config->root_url}/files/blog_originals/{$post->image}"/>
        {else}
            <meta property="og:image" content="{$config->root_url}/design/{$settings->theme|escape}/images/logo.png"/>
        {/if}
        <meta property="og:url" content="{$config->root_url}/blog/{$post->url}"/>
    {elseif $this_page=='product'}
        {if $product->images|count>1}
            {$product_image = $product->images[1]}
            <meta property="og:image" content="{$product_image->filename|resize:'product':1000:700}"/>
        {elseif $product->image}
            <meta property="og:image" content="{$product->image->filename|resize:'product':900:700}"/>
        {else}
            <meta property="og:image" content="{$config->root_url}/design/{$settings->theme|escape}/images/logo.png"/>
        {/if}
        <meta property="og:title" content="{$product->name|escape}"/>
        <meta property="og:url" content="{$config->root_url}/products/{$product->url}"/>
        {if $product->annotation}
            <meta property="og:description" content='{$product->annotation|strip_tags}'/>
        {elseif $meta_description}
            <meta property="og:description" content='{$meta_description}'/>
        {/if}
    {else}
        <meta property="og:title" content="{$page->name|strip_tags}"/>
        {if $meta_description}<meta property="og:description" content='{$meta_description}'/>{/if}

        {if $page->image}
            <meta property="og:image" content="{$page->image|resize:'pages':500:500}"/>
        {else}
            <meta property="og:image" content="{$config->root_url}/design/{$settings->theme|escape}/images/logo1.1.png"/>
        {/if}
        <meta property="og:url" content="{$config->root_url}/{$page->url}"/>
    {/if}


    {if $head_javascripts}
        {foreach $head_javascripts as $j}
            <script src="{$j}"></script>
        {/foreach}
    {/if}


</head>
<body{if $this_page} class="c_{$this_page} su {if $grey_body}grey_body{/if}"{/if} {if $page_type=='product'} itemscope itemtype="http://schema.org/Product"{/if}>
{if $preloader}
    {preloader(true)}
{/if}
{literal}
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-TSNWF2P"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
{/literal}
    {if $members_menu}
        
        <div class="fix header members_header{if $page->image || $post->image} v2{/if}">

            {*
            <a href="/" class="logo">
                <img src="/design/{$settings->theme|escape}/images/logo.svg" alt="Ne-Bo Services logo">
            </a>
            *}

             <ul class="menu u_menu">
                <li class="user_n">
                    <div class="u_info fx">
                        <div class="icon">
                            <i class="fa fa-user-circle-o"></i>
                        </div>
                        <div class="title_bx fx">
                            <div class="title">{$user->name}</div>
                            <div class="options_line">
                                <a href="user/profile/">Profile</a>
                                <a class="logout" href="user/logout/">Logout</a>
                            </div>
                        </div>
                    </div><!-- user_info -->
                </li>
                {if $user->type==2}
                <li>
                    <a href="houseleader">Info</a>
                </li>
                <li>
                    <a href="houseleader/calendar">Calendar</a>
                </li>
                <li>
                    <a href="cleaner_cleaning">Cleaning</a>
                </li>
                <li>
                    <a href="notifications-journal">Visits/Alerts</a>
                </li>
                {else if $user->type==3}
                <!-- (($user->house_id == 238 || $user->house_id == 238) && $user->membership == 1) -->
                <li>
                    <a href="cleaner_cleaning">Cleaning</a>
                </li>
                {else if $user->type==4}
                <li>
                    <a href="landlord/stats/{if $smarty.get.house_id}{$smarty.get.house_id}{/if}{if $smarty.get.month}?month={$smarty.get.month}{/if}">Stats</a>
                </li>
                <li>
                    <a href="landlord/tenants/{if $smarty.get.house_id}{$smarty.get.house_id}{/if}{if $smarty.get.month}?month={$smarty.get.month}{/if}">Tenants</a>
                </li>
                <li>
                    <a href="landlord/rentroll/{if $smarty.get.house_id}{$smarty.get.house_id}{/if}{if $smarty.get.month}?month={$smarty.get.month}{/if}">Rent Roll</a>
                </li>
                <li>
                    <a href="landlord/bookings/">Bookings</a>
                </li>
                {if $user->tenant_approve}
                    <li>
                        <a href="/landlord/approve/">Waiting list</a>
                    </li>
                {/if}
                <li>
                    <a href="landlord/tenant-directory/">Tenant Directory</a>
                </li>
                <li>
                    <a href="landlord/lender/{if $smarty.get.house_id}{$smarty.get.house_id}{/if}{if $smarty.get.month}?month={$smarty.get.month}{/if}">Lender</a>
                </li>
                {*
                    <li>
                        <a href="landlord/broker-fee/{if $smarty.get.house_id}{$smarty.get.house_id}{/if}{if $smarty.get.month}?month={$smarty.get.month}{/if}">Broker Fee</a>
                    </li>
                *}
                {/if}
                {if $user->type==2 || $user->type==3}
                {*<li>
                    <a href="restocking">Restocking</a>
                </li>
                <li>
                    <a href="kitchen-restocking">Kitchen restocking</a>
                </li>*}
                {/if}
                {if $user->type!=4}
                <li>
                    <a href="notifications">Full list of Notifications</a>
                </li>
                {/if}
            </ul>

            <ul class="menu">

                

                {if $user->type!=3 && $user->type!=4}
                <li>
                    <a href="/current-members">Main</a>
                </li>
                <li>
                    {if $user->type == 5}
                    <a href="user/roommates">Roommates</a>
                    {elseif $user->type == 2}
                    <a href="houseleader/calendar">Calendar</a>
                    {/if}
                </li>
                {if $categories}
                    {foreach $categories as $c}
                        {if $c->visible}
                        <li>
                            <a href="catalog/{$c->url}">{$c->name|escape}</a>
                        </li>
                        {/if}
                    {/foreach}
                {/if}
                {if $user->type!=2 && $user->house_id != 349}
                <li>
                    <a href="current-members#essential_documents">Essential Documents</a>
                </li>
                <li>
                    <a href="current-members#contacts">Contacts</a>
                </li>
                {/if}
                {if !in_array($user->house_id, array('252','279', '278', '349')) && $user->booking->type != 2}
                <li>
                    <a href="cleaning">Cleaning</a>
                </li>
                {/if}
                <!-- 
                <li>
                    <a href="technical-issues">Technical issues</a>
                </li> 
                -->
                {if !$maintenance_request_button_hide}
                <li>
                    <a class="button" href="technical-issues#request_form">Maintenance Request</a>
                </li>
                {/if}
                {/if}
            </ul>

            <div class="open_sidebar">
                <i></i>
            </div>
        </div>
    {elseif $handyman_menu}
        <div class="fix header members_header{if $page->image || $post->image} v2{/if}">

            {*
            <a href="/" class="logo">
                <img src="/design/{$settings->theme|escape}/images/logo.svg" alt="Ne-Bo Services logo">
            </a>
            *}

             <ul class="menu u_menu">
                <li class="user_n">
                    <div class="u_info fx">
                        <div class="icon">
                            <i class="fa fa-user-circle-o"></i>
                        </div>
                        <div class="title_bx fx">
                            <div class="title">{$user->name}</div>
                            <div class="options_line">
                                 <a class="logout" href="user/logout/">Logout</a>
                            </div>
                        </div>
                    </div><!-- user_info -->
                </li>
                <li>
                    <a href="notifications-journal">Visits/Alerts</a>
                </li>
            </ul>

            <div class="open_sidebar">
                <i></i>
            </div>
        </div>
    {else}
        {*
        <div class="fix header{if $page->image || $post->image} v2{/if}">
            {if $this_page == "home"}
            <div class="logo">
                <img src="/design/{$settings->theme|escape}/images/logo.svg" alt="Ne-Bo Services logo">
            </div>
            {else}
            <a href="/" class="logo">
                <img src="/design/{$settings->theme|escape}/images/logo.svg" alt="Ne-Bo Services logo">
            </a>
            {/if}
            <ul class="menu">
                <li>
                    <a href="/hot-deals"><div class="green">Hot deals</div></a>
                </li>
                
                {foreach $pages as $p}
                    {if $p->menu_id==1}
                        {if $p->url == 'join-us'}
                        <li{if $page && $page->id == $p->id && !$author && !$tag} class="selected"{/if}>
                            <a href="{if $apply_form}#apply{else}/join-us{/if}" class="button {if $apply_form}anchor{/if}">{$p->name|escape}</a>
                        </li>
                        {elseif $p->url != "" && $p->url != 'faq' && $p->url != 'our-houses'}
                        <li{if $page && $page->id == $p->id && !$author && !$tag} class="selected"{/if}>
                            {if $p->id == 100}
                                <a href="{$p->url}" class="button">{$p->name|escape}</a>
                            {elseif !$user && $p->url=='current-members'}
                                <a href="user/login">{$p->name|escape}</a>
                            {else}
                                <a href="{$p->url}">{$p->name|escape}</a>
                            {/if}
                        </li>
                        {elseif $p->url == 'our-houses'}
                        <li class="menu_about">
                            <span>Our houses</span>
                            <ul class="hide">
                                {foreach $pages as $p}
                                {if $p->menu_id==5}
                                    <li>
                                        <a href="{$p->url}">{$p->name|escape}</a>
                                    </li>
                                {/if}
                                {/foreach}
                            </ul>
                        </li>
                        <li>
                            <a href="/coliving">Coliving</a>
                        </li>
                        {elseif $p->url == 'faq'}
                        <li>
                            <a href="{$p->url}">{$p->name|escape}</a>
                        </li>
                        <li class="menu_about">
                            <span>Ne-Bo Services</span>
                            <ul class="hide">
                                <!-- <li>
                                    <a href="/about">About</a>
                                </li> -->
                                <li>
                                    <a href="/our-houses">Our houses</a>
                                </li>
                                <li>
                                    <a href="/partner-with-us">Partner with us</a>
                                </li>
                                <li>
                                    <a href="/press">Press</a>
                                </li>
                                
                            </ul>
                        </li>
                        {/if}
                    {/if}
                {/foreach}
            </ul>
            <div class="open_sidebar">
                <i></i>
            </div>
        </div>
        *}
    {/if}
    {*
    {if $user}
        <div class="user_nav_block{if $page->image} v2{/if}">
            <div class="user_info fx">
                <div class="icon">
                    <i class="fa fa-user-circle-o"></i>
                </div>
                <div class="title_bx fx">
                    <div class="title">{$user->name}</div>
                    <div class="options_line">
                        <a href="user/profile/">Profile</a>
                        <a class="logout" href="user/logout/">Logout</a>
                    </div>
                </div>
            </div><!-- user_info -->
            <ul class="r_nav">
                {if $categories}
                    {foreach $categories as $c}
                        {if $c->visible}
                        <li>
                            <a href="catalog/{$c->url}">{$c->name|escape}</a>
                        </li>
                        {/if}
                    {/foreach}
                {/if}
                <li>
                    <a href="current-members#essential_documents">Essential Documents</a>
                </li>
                <li>
                    <a href="technical-issues">Technical issues</a>
                </li>
                {if !$maintenance_request_button_hide}
                <li>
                    <a class="button" href="technical-issues#request_form">Maintenance Request</a>
                </li>
                {/if}
            </ul>  
        </div><!-- user_nav_block -->
    {/if}
    *}
    {if $this_page=='home'}

    {else if $page->image && $page->parent_id==0 && !$author && !$tag  && $current_page_num<2}
    <div class="full_width top_block">
        <img class="top_bg" src="{$page->image|resize:'pages':1600:1600}" alt="{$page->header}">
        <div class="header">
            <a href="/" class="logo">
                <img src="/design/{$settings->theme|escape}/images/logo.svg" alt="logo">
            </a>
            <ul class="menu">
                <li>
                    <a href="/hot-deals"><div class="green">Hot deals</div></a>
                </li>
                
                {foreach $pages as $p}
                    {if $p->menu_id==1}
                         {if $p->url == 'join-us'}
                        <li class="{if $page && $page->id == $p->id && !$author && !$tag}selected{/if}">
                            <a href="{if $apply_form}#apply{else}/join-us{/if}" class="button {if $apply_form}anchor{/if}">{$p->name|escape}</a>
                        </li>
                        {elseif $p->url != "" && $p->url != 'faq' && $p->url != 'our-houses'}
                        <li{if $page && $page->id == $p->id && !$author && !$tag} class="selected"{/if}>
                            {if $p->id == 100}
                                <a href="{$p->url}" class="button">{$p->name|escape}</a>
                            {elseif !$user && $p->url=='current-members'}
                                <a href="user/login">{$p->name|escape}</a>
                            {else}
                                <a href="{$p->url}">{$p->name|escape}</a>
                            {/if}
                        </li>
                        {elseif $p->url == 'our-houses'}
                        <li class="menu_about">
                            <span>Our houses</span>
                            <ul class="hide">
                                {foreach $pages as $p}
                                {if $p->menu_id==5}
                                    <li>
                                        <a href="{$p->url}">{$p->name|escape}</a>
                                    </li>
                                {/if}
                                {/foreach}
                            </ul>
                        </li>
                        <li>
                            <a href="/coliving">Coliving</a>
                        </li>
                        {elseif $p->url == 'faq'}
                        <li>
                            <a href="{$p->url}">{$p->name|escape}</a>
                        </li>
                        <li class="menu_about">
                            {* <span>Ne-Bo Services</span> *}
                            <ul class="hide">
                                {*<li>
                                    <a href="/about">About</a>
                                </li>
                                <li>
                                    <a href="/our-houses">Our houses</a>
                                </li>
                                *}
                                <li>
                                    <a href="/partner-with-us">Partner with us</a>
                                </li>
                                <li>
                                    <a href="/press">Press</a>
                                </li>
                                
                            </ul>
                        </li>
                        {/if}
                    {/if}
                {/foreach}
            </ul>
            <div class="open_sidebar">
                <i></i>
            </div>
        </div>
        <div class="main">
            {if $page->annotation}
                {$page->annotation}
            {else}
                <h1 class="h1">{$page->header}</h1>
            {/if}
        </div>
    </div>
    {/if}
    


    {*
    {if $page->bg_image}
    <div class="full_width top_block">
        <img class="top_bg" src="{$config->pages_bg_images_dir}{$page->bg_image}" alt="{$page->header}">
        <div class="header">
            <a href="/" class="logo">
                <img src="/design/{$settings->theme|escape}/images/logo.svg" alt="Logo">
            </a>
            <ul class="menu">
                <li>
                    <a href="/hot-deals"><div class="green">Hot deals</div></a>
                </li>
                
                {foreach $pages as $p}
                    {if $p->menu_id==1}
                         {if $p->url == 'join-us'}
                        <li class="{if $page && $page->id == $p->id && !$author && !$tag}selected{/if}">
                            <a href="{if $apply_form}#apply{else}/join-us{/if}" class="button {if $apply_form}anchor{/if}">{$p->name|escape}</a>
                        </li>
                        {elseif $p->url != "" && $p->url != 'faq' && $p->url != 'our-houses'}
                        <li{if $page && $page->id == $p->id && !$author && !$tag} class="selected"{/if}>
                            {if $p->id == 100}
                                <a href="{$p->url}" class="button">{$p->name|escape}</a>
                            {elseif !$user && $p->url=='current-members'}
                                <a href="user/login">{$p->name|escape}</a>
                            {else}
                                <a href="{$p->url}">{$p->name|escape}</a>
                            {/if}
                        </li>
                        {elseif $p->url == 'our-houses'}
                        <li class="menu_about">
                            <span>Our houses</span>
                            <ul class="hide">
                                {foreach $pages as $p}
                                {if $p->menu_id==5}
                                    <li>
                                        <a href="{$p->url}">{$p->name|escape}</a>
                                    </li>
                                {/if}
                                {/foreach}
                            </ul>
                        </li>
                        <li>
                            <a href="/coliving">Coliving</a>
                        </li>
                        {elseif $p->url == 'faq'}
                        <li>
                            <a href="{$p->url}">{$p->name|escape}</a>
                        </li>
                        <li class="menu_about">
                            <span>Ne-Bo Services</span>
                            <ul class="hide">
                                <!-- <li>
                                    <a href="/about">About</a>
                                </li> -->
                                <li>
                                    <a href="/partner-with-us">Partner with us</a>
                                </li>
                                <li>
                                    <a href="/press">Press</a>
                                </li>
                                
                            </ul>
                        </li>
                        {/if}
                    {/if}
                {/foreach}
            </ul>
            <div class="open_sidebar">
                <i></i>
            </div>
        </div>
        <div class="main">
            {if $page->bg_text}
                {$page->bg_text}
            {else}
                <h1 class="h1">{$page->header}</h1>
            {/if}
        </div>
    </div>
    {/if}

    *}

    {if $post->image}
    <div class="full_width top_block">
        <img class="top_bg" src="{$config->blog_images_dir}{$post->image}" alt="{$post->name}">
        {if !$members_menu}
        <div class="header">
            <a href="/" class="logo">
                <img src="/design/{$settings->theme|escape}/images/logo.svg" alt="Logo">
            </a>
            <ul class="menu">
                <li>
                    <a href="/hot-deals"><div class="green">Hot deals</div></a>
                </li>
                
                {foreach $pages as $p}
                    {if $p->menu_id==1}
                        
                        {if $p->url != "" && $p->url != 'faq' && $p->url != 'our-houses'}
                        <li class="{if $page && $page->id == $p->id}selected{/if}">
                            <a href="{$p->url}"{if $p->id == 100} class="button"{/if}>{$p->name|escape}</a>
                        </li>
                        {elseif $p->url == 'our-houses'}
                        <li class="menu_about">
                            <span>Our houses</span>
                            <ul class="hide">
                                {foreach $pages as $p}
                                {if $p->menu_id==5}
                                    <li>
                                        <a href="{$p->url}">{$p->name|escape}</a>
                                    </li>
                                {/if}
                                {/foreach}
                            </ul>
                        </li>
                        <li>
                            <a href="/coliving">Coliving</a>
                        </li>
                        {elseif $p->url == 'faq'}
                        <li>
                            <a href="{$p->url}">{$p->name|escape}</a>
                        </li>
                        <li class="menu_about">
                            {* <span>Ne-Bo Services</span> *}
                            <ul class="hide">
                                {*<li>
                                    <a href="/about">About</a>
                                </li>*}
                                <li>
                                    <a href="/our-houses">Our houses</a>
                                </li>
                                <li>
                                    <a href="/partner-with-us">Partner with us</a>
                                </li>
                                <li>
                                    <a href="/press">Press</a>
                                </li>
                                
                            </ul>
                        </li>
                        {/if}
                    {/if}
                {/foreach}
            </ul>
            {if $members_menu}
            <div class="open_sidebar">
                <i></i>
            </div>
            {/if}
        </div>
        {/if}
        <div class="main">
            <h1 class="h1">{$post->name}</h1>
        </div>

    </div>
    {/if}

    {if $members_menu || $handyman_menu}
    <div class="sidebar_bg"></div>

    <div class="sidebar">   
        <div class="wrapper">

            {if $members_menu}

                <ul class="menu">
                    <li class="user_n">
                        <div class="u_info fx">
                            <div class="icon">
                                <i class="fa fa-user-circle-o"></i>
                            </div>
                            <div class="title_bx fx">
                                <div class="title">{$user->name}</div>
                            </div>
                        </div><!-- user_info -->
                        <div class="options_line">
                            <a href="user/profile/">Profile</a>
                            <a class="logout" href="user/logout/">Logout</a>
                        </div>
                    </li>
                    
                    {if $user->type==2}
                        <li>
                            <a href="houseleader">Info</a>
                        </li>
                        <li>
                            <a href="houseleader/calendar">Calendar</a>
                        </li>
                        <li>
                            <a href="cleaner_cleaning">Cleaning</a>
                        </li>
                        <li>
                            <a href="notifications-journal">Visits/Alerts</a>
                        </li>
                    {else if $user->type==3}
                        <li>
                            <a href="cleaner_cleaning">Cleaning</a>
                        </li>
                    {elseif $user->type==4}
                        <li>
                            <a href="landlord/stats/{if $smarty.get.house_id}{$smarty.get.house_id}{/if}{if $smarty.get.month}?month={$smarty.get.month}{/if}">Stats</a>
                        </li>
                        <li>
                            <a href="landlord/tenants/{if $smarty.get.house_id}{$smarty.get.house_id}{/if}{if $smarty.get.month}?month={$smarty.get.month}{/if}">Tenants</a>
                        </li>
                        <li>
                            <a href="landlord/rentroll/{if $smarty.get.house_id}{$smarty.get.house_id}{/if}{if $smarty.get.month}?month={$smarty.get.month}{/if}">Rent Roll</a>
                        </li>
                        <li>
                            <a href="landlord/bookings/">Bookings</a>
                        </li>
                        {if $user->tenant_approve}
                            <li>
                                <a href="/landlord/approve/">Waiting list</a>
                            </li>
                        {/if}
                        <li>
                            <a href="landlord/tenant-directory/">Tenant Directory</a>
                        </li>
                        <li>
                            <a href="landlord/lender/{if $smarty.get.house_id}{$smarty.get.house_id}{/if}{if $smarty.get.month}?month={$smarty.get.month}{/if}">Lender</a>
                        </li>
                        {*
                            <li>
                                <a href="landlord/broker-fee/{if $smarty.get.house_id}{$smarty.get.house_id}{/if}{if $smarty.get.month}?month={$smarty.get.month}{/if}">Broker Fee</a>
                            </li>
                        *}
                    {/if}
                    {if $user->type==2 || $user->type==3}
                    {*
                    <li>
                        <a href="restocking">Restocking</a>
                    </li>
                    <li>
                        <a href="kitchen-restocking">Kitchen restocking</a>
                    </li>
                    *}


                    {/if}
                    {if $user->type!=3 && $user->type!=4}
                     <li>
                        <a href="/current-members">Main</a>
                    </li>
                    <li>
                        {if $user->type == 5}
                        <a href="user/roommates">Roommates</a>
                        {elseif $user->type == 2}
                        <a href="houseleader/calendar">Calendar</a>
                        {/if}
                    </li>
                    {if $categories}
                        {foreach $categories as $c}
                            {if $c->visible}
                            <li>
                                <a href="catalog/{$c->url}">{$c->name|escape}</a>
                            </li>
                            {/if}
                        {/foreach}
                    {/if}
                    {if $user->type!=2 && $user->house_id != 349}
                    <li>
                        <a href="current-members#essential_documents">Essential Documents</a>
                    </li>
                    {/if}
                    {if !$maintenance_request_button_hide}
                    <li>
                        <a class="button" href="technical-issues#request_form">Maintenance Request</a>
                    </li>
                    {/if}
                    {/if}
                    {if $user->type!=4}
                    <li>
                        <a href="notifications">Full list of Notifications</a>
                    </li>
                    {/if}
                </ul>
            {elseif $handyman_menu}
            <ul class="menu">
                    <li class="user_n">
                        <div class="u_info fx">
                            <div class="icon">
                                <i class="fa fa-user-circle-o"></i>
                            </div>
                            <div class="title_bx fx">
                                <div class="title">{$user->name}</div>
                            </div>
                        </div><!-- user_info -->
                        <div class="options_line">
                            <a class="logout" href="user/logout/">Logout</a>
                        </div>
                    </li>
                    <li>
                        <a href="notifications-journal">Visits/Alerts</a>
                    </li>
                </ul>
            {else}

             <ul class="menu">
                <li>
                    <a href="/hot-deals"><div class="green">Hot deals</div></a>
                </li>
                <li>
                    <a href="/coliving">Coliving</a>
                </li>
                {foreach $pages as $p}
                    {if $p->menu_id==1}
                         {if $p->url == 'join-us'}
                        <li{if $page && $page->id == $p->id && !$author && !$tag} class="selected"{/if}>
                            {*<a href="{if $apply_form}#apply{else}/join-us{/if}" class="button {if $apply_form}anchor{/if}">{$p->name|escape}</a>*}
                            <a href="/join-us" class="button">{$p->name|escape}</a>
                        </li>
                        {elseif $p->url != "" && $p->url != 'faq' && $p->url != 'our-houses'}
                        <li{if $page && $page->id == $p->id && !$author && !$tag} class="selected"{/if}>
                            {if $p->id == 100}
                                <a href="{$p->url}" class="button">{$p->name|escape}</a>
                            {elseif !$user && $p->url=='current-members'}
                                <a href="user/login">{$p->name|escape}</a>
                            {else}
                                <a href="{$p->url}">{$p->name|escape}</a>
                            {/if}
                        </li>
                        {elseif $p->url == 'our-houses'}
                        <li class="menu_about">
                            <span>Our houses</span>
                            <ul>
                                {foreach $pages as $p}
                                {if $p->menu_id==5}
                                    <li>
                                        <a href="{$p->url}">{$p->name|escape}</a>
                                    </li>
                                {/if}
                                {/foreach}
                            </ul>
                        </li>
                        {elseif $p->url == 'faq'}
                        <li>
                            <a href="{$p->url}">{$p->name|escape}</a>
                        </li>
                        <li class="menu_about">
                            {* <span>Ne-Bo Services</span> *}
                            <ul>
                                {*<li>
                                    <a href="/about">About</a>
                                </li>*}
                                <li>
                                    <a href="/our-houses">Our houses</a>
                                </li>
                                <li>
                                    <a href="/partner-with-us">Partner with us</a>
                                </li>
                                <li>
                                    <a href="/press">Press</a>
                                </li>
                                
                            </ul>
                        </li>
                        {/if}
                    {/if}
                {/foreach}
            </ul>
            {/if}
            
            {*
            <div class="info">
                <a href="tel:+18337076611">+1 (833) 707-6611</a>
                <a href="mailto:info@outpost-club.com">info@outpost-club.com</a>
            </div>
            *}

        </div><!-- wrapper -->  
        <div class="close">
            <i></i>
        </div>
    </div><!-- sidebar -->
    {/if}
       
   {$content}

    {if $this_page!='home'}
    <div class="footer">

        {*
        {if !$apply_button_hide}
        
        <div class="fx c v vc grey hide">
            <a href="/join-us" class="button1 black">Apply Now</a>
            
            <div class="socials fx">
                <a href="mailto:info@outpost-club.com" target="_blank">
                    <img src="/design/{$settings->theme|escape}/images/icons/email.svg" alt="Outpost email">
                </a>
                <a href="http://instagram.com/outpost_club" target="_blank" rel="nofollow">
                    <img src="/design/{$settings->theme|escape}/images/icons/instagram.svg" alt="Outpost instagram">
                </a>
                <a href="https://twitter.com/outpost_club" target="_blank" rel="nofollow">
                    <img src="/design/{$settings->theme|escape}/images/icons/twitter.svg" alt="Outpost twitter">
                </a>
                <a href="https://www.linkedin.com/company-beta/17932725/" target="_blank" rel="nofollow">
                    <img src="/design/{$settings->theme|escape}/images/icons/linkedin.svg" alt="Outpost linkedin">
                </a>
                <a href="http://www.facebook.com/outpostclubNY/" target="_blank" rel="nofollow">
                    <img src="/design/{$settings->theme|escape}/images/icons/facebook.svg" alt="Outpost facebook">
                </a>
            </div>
            
        </div>
        
        {/if}
        *}
        

        
        <div class="low_footer">
            
            
            <div class="partners main_width fx w">

                <a href="http://bit.ly/3aTrPUn" target="_blank">
                    <img src="/design/{$settings->theme|escape}/images/logos/outpost.svg" alt="Outpost">
                </a>
                <a href="http://bit.ly/2te6ZhA" target="_blank">
                    <img src="/design/{$settings->theme|escape}/images/logos/business_travelers.svg" alt="Business Travelers">
                </a>
                <a href="http://bit.ly/2ObNyNu" target="_blank">
                    <img src="/design/{$settings->theme|escape}/images/logos/internhousingnyc.svg" alt="Intern Housing NYC">
                </a>
                <a href="http://bit.ly/2u4CMSl" target="_blank">
                    <img src="/design/{$settings->theme|escape}/images/logos/bedly.svg" alt="Bedly">
                </a>

            </div><!-- partners -->
            

            <div class="info main_width">
                {* <p>Ne-Bo Services Corporation</p> *}
                <p>
                    PO Box 780556 Maspeth NY 11378
                </p>
                <a href="mailto:admin@ne-bo.com">admin@ne-bo.com</a>
            </div>
       </div>

       
   </div><!-- footer -->
   {/if}



   <div class="scroll_top"></div>


    
    <script src="design/{$settings->theme}/js/slick/slick.min.js?v1.0.0"></script>
    <script src="js/fancybox/jquery.fancybox.min.js"></script>
    <script src="design/{$settings->theme}/js/jquery.form.min.js"></script>
    <script src="design/{$settings->theme}/js/jquery.maskedinput.js"></script>
    <script src="design/{$settings->theme}/js/datepicker/js/datepicker.min.js"></script>
    <script src="design/{$settings->theme}/js/main.js?v1.35"></script>
    <script src="design/{$settings->theme}/js/autocomplete/jquery.autocomplete-min.js"></script>
    
    {if $js_include}
        <script src="{$js_include}"></script>
    {/if}
    {if $javascripts}
        {foreach $javascripts as $j}
            <script src="{$j}"></script>
        {/foreach}
    {/if}
    {if $smarty.session.admin == 'admin' && $on}
        <script src ="js/admintooltip/admintooltip.js"></script>
    {/if}

</body>
</html>