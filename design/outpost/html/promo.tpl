{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}

<div class="promo main_width txt room_blocks">
{foreach $hot_deals as $p}
    <div class="room_block">
        {foreach $p->blocks as $pb}
        <div class="fx ch2">
            <div>
                {if $pb->images != ""}
                <div class="img_slider">
                   {foreach $pb->images as $img}
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="../{$config->galleries_images_dir}{$img}" alt="{$p->name}" />   
                        </div>  
                    </div>
                    {/foreach}
                </div>   
                {/if}             
            </div>
            <div>
                <p class="h5">{$p->header} <br><span>{$p->name}</span></p>
                <p class="green">Promotional price {$pb->price} per month</p>
                <div class="info">
                    <ul>
                        <li>Move-in: {$pb->move_in}</li>
                        <li>Minimal stay {$pb->min_stay}</li>
                        <li>Maximum stay {$pb->max_stay}</li>
                    </ul>
                    {$pb->body}
                </div>
            </div>
        </div>
        <div class="center">
            <a href="{$pb->url}" target="_blank" class="button2 red">Book Now</a>
        </div>
        {/foreach}
    </div>
{/foreach}
</div>


{*
 <div class="promo main_width txt room_blocks">
    <div class="room_block">
        <div class="fx ch2">
            <div>
                <div class="img_slider">
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List1/01-promo-manhattan-6.jpg" alt="The Private room at Central Park Manhattan House" />   
                        </div>  
                    </div>
                   
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List1/promo-manhattan-2.jpg" alt="The Private room at Central Park Manhattan House" />   
                        </div>  
                    </div>
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List1/promo-manhattan-3.jpg" alt="The Private room at Central Park Manhattan House" />   
                        </div>  
                    </div>
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List1/promo-manhattan-4.jpg" alt="The Private room at Central Park Manhattan House" />   
                        </div>  
                    </div>
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List1/promo-manhattan-5.jpg" alt="The Private room at Central Park Manhattan House" />   
                        </div>  
                    </div>
                     <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List1/promo-manhattan-1.jpg" alt="The Private room at Central Park Manhattan House" />   
                        </div>  
                    </div>
                </div>                
            </div>
            <div>
                <p class="h5">The Private room at Central Park Manhattan House <br><span>(near 115st East and Manhattan Ave)</span></p>
                <p class="green">Promotional price $1190 per month</p>
                <div class="info">
                    <ul>
                        <li>Move-in: by Feb 15, 2019</li>
                        <li>Minimal stay is 1 month</li>
                        <li>Maximum stay is 2 months</li>
                    </ul>
                    <p>Price per 1 person per room. Second person in the same room + $300 per month.</p>
                    <p>Security deposit in the equivalent of the one-month fee is required and fully refundable after move-out.</p>
                </div>
            </div>
        </div>
        <div class="center">
            <a href="hot-deals-manhattan/?utm_source=landing+page&utm_medium=hot+deal&utm_campaign=manhattan+house" class="button2 red">Book Now</a>
        </div>
        
    </div>
    <div class="room_block">
        <div class="fx ch2">
            <div>
                <div class="img_slider">
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List2/01-promo-bed-stuy-7.jpg" alt="The Private room with ensuite full bathroom at Bed Stuy House" />   
                        </div>  
                    </div>
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List2/promo-bed-stuy-1.jpg" alt="The Private room with ensuite full bathroom at Bed Stuy House" />   
                        </div>  
                    </div>
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List2/promo-bed-stuy-2.jpg" alt="The Private room with ensuite full bathroom at Bed Stuy House" />   
                        </div>  
                    </div>
                     <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List2/promo-bed-stuy-3.jpg" alt="The Private room with ensuite full bathroom at Bed Stuy House" />   
                        </div>  
                    </div>
                     <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List2/promo-bed-stuy-4.jpg" alt="The Private room with ensuite full bathroom at Bed Stuy House" />   
                        </div>  
                    </div>
                     <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List2/promo-bed-stuy-5.jpg" alt="The Private room with ensuite full bathroom at Bed Stuy House" />   
                        </div>  
                    </div>
                     <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List2/promo-bed-stuy-6.jpg" alt="The Private room with ensuite full bathroom at Bed Stuy House" />   
                        </div>  
                    </div>
                </div>                
            </div>
            <div>
                <p class="h5">The Private room with ensuite full bathroom at Bed Stuy House <br><span>(near Marcus Garvey Blvd and Hart street)</span></p>
                <p class="green">Promotional price $1390 per month</p>
                <div class="info">
                    <ul>
                        <li>Move-in: by Feb 15, 2019</li>
                        <li>Minimal stay is 1 month</li>
                        <li>Maximum stay is 3 months</li>
                    </ul>
                    <p>Price per 1 person per room. Second person in the same room + $300 per month.</p>
                    <p>Security deposit in the equivalent of the one-month fee is required and fully refundable after move-out.</p>
                </div>
            </div>
        </div>
        <div class="center">
            <a href="hot-deals-bed-stuy/?utm_source=landing+page&utm_medium=hot+deal&utm_campaign=bed+stuy" class="button2 red">Book Now</a>
        </div>
    </div>
    <div class="room_block">
        <div class="fx ch2">
            <div>
                <div class="img_slider">
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List3/01-promo-flatbushhouse-7.jpg" alt="Shared room for male at Flatbush House" />   
                        </div>  
                    </div>
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List3/promo-flatbushhouse-1.jpg" alt="Shared room for male at Flatbush House" />   
                        </div>  
                    </div>
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List3/promo-flatbushhouse-2.jpg" alt="Shared room for male at Flatbush House" />   
                        </div>  
                    </div>
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List3/promo-flatbushhouse-3.jpg" alt="Shared room for male at Flatbush House" />   
                        </div>  
                    </div>
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List3/promo-flatbushhouse-4.jpg" alt="Shared room for male at Flatbush House" />   
                        </div>  
                    </div>
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List3/promo-flatbushhouse-5.jpg" alt="Shared room for male at Flatbush House" />   
                        </div>  
                    </div>
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List3/promo-flatbushhouse-6.jpg" alt="Shared room for male at Flatbush House" />   
                        </div>  
                    </div>
                </div>                
            </div>
            <div>
                <p class="h5">The bed in 4-people shared room for male at Flatbush House <br><span>(near Nostrand Ave and Beverly Rd)</span></p>
                <p class="green">Promotional price $690 per month</p>
                <div class="info">
                    <ul>
                        <li>Move-in: Jan 30, 2019 - Feb 13, 2019</li>
                        <li>Minimal stay is 1 month</li>
                        <li>Maximum stay by May 1, 2019</li>
                    </ul>
                    <p>Price per 1 person in shared 4-people room.</p>
                    <p>Security deposit in the equivalent of the one-month fee is required and fully refundable after move-out.</p>
                </div>
            </div>
        </div>
        <div class="center">
            <a href="hot-deals-flatbush-house/?utm_source=landing+page&utm_medium=hot+deal&utm_campaign=flatbush" class="button2 red">Book Now</a>
        </div>
    </div>
    <div class="room_block">
        <div class="fx ch2">
            <div>
                <div class="img_slider">
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List4/01-promo-ridgewood-4.jpg" alt="Shared room for male OR female at Ridgewood House" />   
                        </div>  
                    </div>
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List4/promo-ridgewood-1.jpg" alt="Shared room for male OR female at Ridgewood House" />   
                        </div>  
                    </div>
                     <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List4/promo-ridgewood-2.jpg" alt="Shared room for male OR female at Ridgewood House" />   
                        </div>  
                    </div>
                     <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List4/promo-ridgewood-3.jpg" alt="Shared room for male OR female at Ridgewood House" />   
                        </div>  
                    </div>
                     <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List4/promo-ridgewood-5.jpg" alt="Shared room for male OR female at Ridgewood House" />   
                        </div>  
                    </div>
                </div>                
            </div>
            <div>
                <p class="h5">The bed in 2-people shared room for male OR female at Ridgewood House <br><span>(near Forest Ave and Putnam Ave)</span></p>
                <p class="green">Promotional price $890 per month</p>
                <div class="info">
                    <ul>
                        <li>Move-in: anytime by Mar 01, 2019</li>
                        <li>Minimal stay is 1 month</li>
                        <li>Maximum stay is 3 months</li>
                    </ul>
                    <p>Price per 1 person in shared 2-people room.</p>
                    <p>Security deposit in the equivalent of the one-month fee is required and fully refundable after move-out.</p>
                </div>
            </div>
        </div>
        <div class="center">
            <a href="hot-deals-ridgewood/?utm_source=landing+page&utm_medium=hot+deal&utm_campaign=ridgewood" class="button2 red">Book Now</a>
        </div>
    </div>
    <div class="room_block ">
        <div class="fx ch2">        
            <div>
                <div class="img_slider">
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List5/01-promo-bushwick-2.jpg" alt="Shared room for male at Bushwick House" />   
                        </div>  
                    </div>
                     <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List5/promo-bushwick-1.jpg" alt="Shared room for male at Bushwick House" />   
                        </div>  
                    </div>
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List5/promo-bushwick-3.jpg" alt="Shared room for male at Bushwick House" />   
                        </div>  
                    </div>
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List5/promo-bushwick-4.jpg" alt="Shared room for male at Bushwick House" />   
                        </div>  
                    </div>
                    <div>
                        <div class="img">
                            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-lazy="/design/{$settings->theme|escape}/images/landing/promo/List5/promo-bushwick-5.jpg" alt="Shared room for male at Bushwick House" />   
                        </div>  
                    </div>
                </div>                
            </div>
            <div>
                <p class="h5">The bed in 3-people shared room for male at Bushwick House <br><span>(near Wilson Ave and Jefferson Ave)</span></p>
                <p class="green">Promotional price $750 per month</p>
                <div class="info">
                    <ul>
                        <li>Move-in: Jan 30, 2019 - Feb 10, 2019</li>
                        <li>Minimal stay is 1 month</li>
                        <li>Maximum stay is 3 months</li>
                    </ul>
                    <p>Price per 1 person in shared 3-people room</p>
                    <p>Security deposit in the equivalent of the one-month fee is required and fully refundable after move-out.</p>
                </div>
            </div>
        </div>
        <div class="center">
            <a href="hot-deals-bushwick/?utm_source=landing+page&utm_medium=hot+deal&utm_campaign=bushwick" class="button2 red">Book Now</a>
        </div>
    </div>
</div>
*}

{*
<div class="main_width  txt">
    <h4 class="h1 center">Coliving Spaces</h4>
    <p class="big_p center">Each of our houses includes one or more kitchens, common areas and co-working spaces, allowing you plenty of room to cook, work and relax, all while getting to know people from all around the world. All of our houses were exclusively designed to be comfortable to all members in any room of the house.</p>
    <p class="big_p center">Your room will be move-in ready, just like the rest of the house; there’s no need to even bring a pillow. Our kitchens are fully stocked with appliances, cookware and everything else you’ll need to make a home-cooked meal. We also have 24/7 security in all common areas</p>
    <hr class="hr">
</div>

*}

<div class="promo main_width advantages txt">
        <h3 class="h3 center">Your membership is like your rent, but is all-inclusive</h3>
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
        <hr class="hr m0">
</div>



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

