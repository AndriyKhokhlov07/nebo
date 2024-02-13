<div class="land furnished_r">
	<div class="w1200 txt">
	<div class="first_block">
		<div class="img">
			<img src="/design/{$settings->theme|escape}/images/landing/furnished/furnished-rooms-for-rent.jpg" alt="furnished rooms for rent in Brooklyn">
		</div>
		<div class="right_bl fx v vc">
			<p>There’s a lot to do once you decide to move to New York City, and the most stressful part can be finding a place to live that fits your budget and consists of more than just a mattress on the floor.</p>
			<p><strong>Outpost Club has solved that problem by offering furnished rooms for rent in Brooklyn, Manhattan and Queens.</strong></p>
			<p>We take care of everything you’ll need to make your new home in the city, so all you have to do is bring your suitcase, whether you’re staying with us for a month or for years.</p>
			<p><strong>Moving in really is as easy as ordering a cup of coffee.</strong></p>
			{*<img src="/design/{$settings->theme|escape}/images/landing/right-arrow.svg" alt="furnished rooms for rent in Brooklyn">*}
		</div>
	</div>
</div>

<div class="w100">
	<div class="main_width txt center">
		<h4 class="h1 center">We have fully furnished apartments throughout New York City</h4>
		<p>We have houses in Bushwick, Williamsburg, Bed-Stuy, Flatbush and Boerum Hill in Brooklyn; Ridgewood in Queens; and just a few blocks from Central Park in Manhattan. No matter where you work or play, you’ll be able to find an apartment that suits your needs.</p> 
		<p>You might be thinking, “I work in Midtown. Do you have an apartment near me?” Thanks to our houses’ convenient locations close to a variety of subway lines, you’ll never have to worry about an insane commute.</p> 
		<p>We take care to choose vibrant neighborhoods with distinct personalities, with access to subways, parks, cafés, restaurants and everything else you’ll need to make New York your home.</p>
		<a href="https://bit.ly/2ItwodM" target="_blank" class="button2">Explore our houses</a>
	</div>
	<div class="fx gall w">
		<a class="img" href="/design/{$settings->theme|escape}/images/landing/rent-in-brook/rent-a-room-in-brooklyn-4.jpg" data-fancybox="gall"><img src="/design/{$settings->theme|escape}/images/landing/rent-in-brook/rent-a-room-in-brooklyn-4.jpg" alt="Rent a room in Brooklyn"></a>
		<a class="img" href="/design/{$settings->theme|escape}/images/landing/rent-in-brook/rent-a-room-in-brooklyn-2.jpg" data-fancybox="gall"><img src="/design/{$settings->theme|escape}/images/landing/rent-in-brook/rent-a-room-in-brooklyn-2.jpg" alt="Rent a room in Brooklyn"></a>
		<a class="img" href="/design/{$settings->theme|escape}/images/landing/rent-in-brook/rent-a-room-in-brooklyn-3.jpg" data-fancybox="gall"><img src="/design/{$settings->theme|escape}/images/landing/rent-in-brook/rent-a-room-in-brooklyn-3.jpg" alt="Rent a room in Brooklyn"></a>
		<a class="img" href="/design/{$settings->theme|escape}/images/landing/rent-in-brook/rent-a-room-in-brooklyn-5.jpg" data-fancybox="gall"><img src="/design/{$settings->theme|escape}/images/landing/rent-in-brook/rent-a-room-in-brooklyn-5.jpg" alt="Rent a room in Brooklyn"></a>
	</div>
</div>
<div class="main_width">
	<div class="advantages txt center">
		<h4 class="h1 ">There’s no need to sacrifice quality for a cheap apartment</h4>
		<p>When we say recently renovated, we mean it: We brought in interior designers to design living spaces that will feel like home no matter your lifestyle, and we take care to make sure our houses are properly maintained and cleaned at all times. We take care of your house so you don’t have to.</p>
		<p>In addition to traditional apartment furnishings, we include kitchen and bathroom essentials like pots, pans, utensils, soap, shampoo, olive oil, coffee and tea, all so you never have to worry about running out of the important things when you need them. Your membership also includes all utilities (plus WiFi!), meaning there’s no more trying to keep track of stacks of bills every month.</p>
		<p class="h5">We offer both shared and private rooms, with memberships starting at $750. The longer you stay, the cheaper your rent! </p>
		<div class="center">
			<a href="https://bit.ly/2GCYYrl" target="_blank" class="button2">I'm interested</a>
		</div>
	</div>
	<hr class="hr m0">
</div>

<div class="main_width steps txt">
    <h4 class="h1 center">Both long-term and short-term rentals are at your fingertips</h4>
    <p class="h3 center">You’re just a couple of clicks away from finding your new home. There are three easy steps to becoming a member of Outpost Club: </p>
    <div class="fx ch3">
        <div>
            <img src="design/{$settings->theme|escape}/images/icons/form.svg" alt="Form">
            <p class="title">Step 1 <br> Fill out the form</p>
            <p class="text">Fill out this form and a member of our team will contact you about pricing and availability.</p>

        </div>
        <div>
            <img src="design/{$settings->theme|escape}/images/icons/phone2.svg" alt="Interview">
            <p class="title">Step 2 <br> Have a Quick Interview</p>
            <p class="text">Schedule a time to talk or fill out our interview form so we can get to know you.</p>
        </div>
        <div>
            <img src="design/{$settings->theme|escape}/images/icons/house.svg" alt="Move-in house">
            <p class="title">Step 3 <br> Move-in!</p>
            <p class="text">You’re all set! We’re excited to welcome you to one of our coliving spaces in New York City.</p>
        </div>
    </div>
    <p class="center">Our furnished rooms for rent offer everything you’ll need to feel at home right away. What are you waiting for?</p>
    <div class="center">
		<a href="https://bit.ly/2XfxwW0" target="_blank" class="button2">Apply now</a>
	</div>
</div>  

<div class="w100 img brook">
	<a href="/about" target="_blank">
	<h4 class="title">More about Outpost Club</h4>
	<img src="/design/{$settings->theme|escape}/images/landing/brook.jpg" alt="Community">
	</a>
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

{get_posts type=1 var=posts limit=6 tag_id=27}
{if $posts}
<div class="main_width blog_list">
    <h4 class="h3 center">#MemberMonday</h4>
    <div class="blog blog_slider">
        {foreach $posts as $post}
        <div class="item">
            {if $post->image}
                    <a class="img" href="blog/{$post->url}">
                        <img src="{$post->image|resize:blog:380:380}" alt="{$post->name|escape}">
                    </a>
            {/if}
            <div class="preview">
                <h4><a data-post="{$post->id}" href="blog/{$post->url}">{$post->name|escape}</a></h4>
                <div>{$post->annotation}</div>
                <a class="more" href="blog/{$post->url}">Read More →</a>
                {*<p class="date">{$post->date|date_format:"%b %e, %Y"}</p>*}
            </div>
        </div>
        {/foreach}
    </div>
</div>
{/if}








</div>
