{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}

<div class="main_width">
    <div class="advantages">
        
        <h5 class="h5">What's included with your bedroom in our all-inclusive prices:</h5>
        <div class="fx c w">
            <div class="item">
                <img src="/design/{$settings->theme|escape}/images/landing/living-room.svg" alt="Fully furnished">
                <p class="title">Fully furnished</p>
                <p class="text">Recently remodeled houses</p>
            </div>
            <div class="item">
                <img src="/design/{$settings->theme|escape}/images/landing/shield_.svg" alt="Security">
                <p class="title">Security</p>
                <p class="text">Our Nest systems will allow you to always feel safe at home</p>
            </div>
            <div class="item">
                <img src="/design/{$settings->theme|escape}/images/landing/invoice.svg" alt="Utilities">
                <p class="title">Utilities</p>
                <p class="text">You`ll never have to "pay the bills" again. This includes gas, water, electric and WiFi</p>
            </div>
            <div class="item">
                <img src="/design/{$settings->theme|escape}/images/landing/brush.svg" alt="Cleaning and maintenance">
                <p class="title">Cleaning and maintenance</p>
                <p class="text">Our team takes care of your home so you don`t have to</p>
            </div>
            
        </div>
    </div>
</div>
<div class="main_width rooms">
    <div class="fx w ch2">
        {get_pages parent_id={$city_id} var=c_pages limit=16}
        {foreach $c_pages as $p}
                <div class="room">
                    <a class="img" href="{$p->url}">
                        <img src="{$p->image|resize:'pages':700:700}" alt="{$p->name|escape}">
                    </a>
                    <a class="h2" href="{$p->url}">{$p->name|escape}</a>
                    <div class="annotation">
                        {$p->annotation}
                    </div>
                    <a href="{$p->url}" class="button2">Explore this home</a>
                </div>
        {/foreach}
    </div>
    <p class="center">*Pricing is subject to location, room type, length of stay, season, and availability*</p>
    <a class="button1 black" href="../join-us">Get your exclusive offer now</a>
    <hr class="hr m0">
</div>
{if $page->id == 253}
<div class="main_width">
	<h4 class="h3 center">Our Coliving Locations</h4>
	<iframe src="https://www.google.com/maps/d/embed?mid=1auTDUCQMxu4x5uNSz2_xs-aIb8m5zCB1&hl=en_US" style="width: 100%; height: 480px;"></iframe>
</div>
{/if}
{get_posts type=2 var=posts limit=16}
{if $posts}
<div class="w800 reviews_list">
    <h4 class="h3 center">Members Reviews</h4>
    <div class="reviews reviews_slider">
        {foreach $posts as $post}
        <div class="item">
            {if $post->image}
                <div class="img">
                    <img src="{$post->image|resize:blog:380:380}" alt="{$post->name|escape}">
                </div>
            {/if}
            <div class="preview">
                <h4><a data-post="{$post->id}" href="blog/{$post->url}">{$post->name|escape}</a></h4>
                <div>{$post->text}</div>
            </div>
        </div>
        {/foreach}
    </div>
</div>
{/if}