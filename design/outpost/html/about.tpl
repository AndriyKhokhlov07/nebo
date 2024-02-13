{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}

<div class="main_width txt about">
	<h6 class="h1 center">Founded in 2016 by a team who knows what it’s like to move. We spent our careers travelling around the world, working remotely and building start-ups.</h6>
	<p>Outpost Club was launched by three entrepreneurs who understands the challenges of moving to new places, working remotely and building a start-up from scratch in a new country.</p>
	<p>Our mission is to build a tight-knit community with shared passions and visions, thereby making the world we live in a better place.</p>
	<p>We build connections between people by offering members access to a network of successful creatives, entrepreneurs, investors, executives and experts to help them grow their businesses and professional careers. Membership with Outpost Club includes access to professionals like web designers, legal advisors, financial strategists, marketing developers and more, while dinners, seminars and activities widen the scope of community and connections.</p>
</div>
{*
<div class="full_width img_block">
    <img class="bg" src="/design/{$settings->theme|escape}/images/team.jpg" alt="Our Team">
    <div class="main_width">
        <p class="white_h1">Our Team</p>
        <p class="h4">The best and brightest</p>
    </div>
</div>
*}
<div class="main_width partners center">
	<p class="h1">Our Team</p>
    <p class="h3">The best and brightest</p>
	<div class="fx ch4 c w">
		<div>
			<div class="img">
				<img src="/design/{$settings->theme|escape}/images/team/starostin1.jpg" alt="Sergii Starostin">
			</div>
			<p class="name"><strong>Sergii Starostin</strong></p>
			<p class="info">Chief Executive Ofiicer</p>
		</div>
		<div>
			<div class="img">
				<img src="/design/{$settings->theme|escape}/images/team/prykhodko.jpg" alt="Alex Prykhodko">
			</div>
			<p class="name"><strong>Alex Prykhodko</strong></p>
			<p class="info">Chief Operations Officer</p>
		</div>
		{*
		<div>
			<div class="img">
				<img src="/design/{$settings->theme|escape}/images/team/cherven.jpg" alt="Karen Cherven">
			</div>
			<p class="name"><strong>Karen Cherven</strong></p>
			<p class="info">Outpost Academy Leader</p>
		</div>
		
		<div>
			<div class="img">
				<img src="/design/{$settings->theme|escape}/images/team/morgunskyi2.jpg" alt="Valentyn Morgunskyi">
			</div>
			<p class="name"><strong>Valentyn Morgunskyi</strong></p>
			<p class="info">Chief Marketing Officer</p>
		</div>
		*}
		<div>
			<div class="img">
				<img src="/design/{$settings->theme|escape}/images/team/shapiro.jpg" alt="Jacob Shapiro">
			</div>
			<p class="name"><strong>Jacob Shapiro</strong></p>
			<p class="info">Account Manager, New York</p>
		</div>
		<div>
			<div class="img">
				<img src="/design/{$settings->theme|escape}/images/team/vega.jpg" alt="Lauren Vega">
			</div>
			<p class="name"><strong>Lauren Vega</strong></p>
			<p class="info">Communications Manager</p>
		</div>

		{*
		
		
		<div>
			<div class="img">
				<img src="/design/{$settings->theme|escape}/images/team/smith.jpg" alt="Kijuan Smith">
			</div>
			<p class="name"><strong>Kijuan Smith</strong></p>
			<p class="info">Community Manager, New York</p>
		</div>
		*}
		
		<div>
			<div class="img">
				<img src="/design/{$settings->theme|escape}/images/team/kostromin.jpg" alt="Alexander Kostromin">
			</div>
			<p class="name"><strong>Alexander Kostromin</strong></p>
			<p class="info">Director of Real Estate Partnerships</p>
		</div>
	</div>
	<div class="hr"></div>
</div>
{*
<div class="full_width img_block">
    <img class="bg" src="/design/{$settings->theme|escape}/images/career.jpg" alt="Careers">
    <div class="main_width">
        <p class="white_h1">Careers</p>
    </div>
</div>

<div class="main_width">
	<p class="h1 center">Careers</p>
	<p class="h5 center">Open Positions</p>
	<hr class="hr">
	<p class="h3">Sorry, there are currently no open positions</p>
	<hr class="hr">
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

*}
<div class="main_width">
	<h6 class="h5">If you want to know more about us check out our blog:</h6>
	<a href="blog" class="button1 black">Blog</a>
	<hr class="hr m0">
</div>
<div class="main_width center find_us">
	<h6 class="h1">Find us on</h6>
    <div class="fx c w vc ch3 partners_slider">
    	<div class="item">
            <a href="https://www.forbes.com/sites/ranagood/2020/01/28/outpost-making-long-term-city-travel-reality/#a34a44991a0e" target="_blank" rel="nofollow">
                <img src="design/{$settings->theme|escape}/images/forbes.svg" alt="Forbes">
            </a>
        </div>
        <div class="item">
            <a href="https://www.nytimes.com/2019/12/23/realestate/sharing-a-room-in-bedford-stuyvesant-and-making-new-friends.html" target="_blank" rel="nofollow">
                <img src="design/{$settings->theme|escape}/images/new-york-city-logo.png" alt="The New York Times">
            </a>
        </div>
        <div class="item">
            <a href="https://www.foxbusiness.com/real-estate/co-living-real-estate-trend-has-renters-saving-thousands?fbclid=IwAR3G8nt2xCNOJr01TjFhmHq0LT5ZjrxLZtyYyT-wBGvNsfyDt6tsDfFngsg" target="_blank" rel="nofollow">
                <img src="design/{$settings->theme|escape}/images/fox.png" alt="Fox">
            </a>
        </div>
    	<div class="item">
    		<a href="https://medium.com/qwerkycoliving/the-worlds-first-coliving-conference-co-liv-review-85e8d1a7ac09" target="_blank" rel="nofollow">
    			<img src="design/{$settings->theme|escape}/images/icons/medium.svg" alt="Medium">
    		</a>
        </div>
        <div class="item">
        	<a href="https://coliving.com/blog/breaking-the-preconceived-notions-of-coliving" target="_blank" rel="nofollow">
        		<img src="design/{$settings->theme|escape}/images/icons/coliving_logo.svg" alt="Coloving">
        	</a>
        </div>
        <div class="item">
        	<div>
        		<img src="design/{$settings->theme|escape}/images/dislocation.jpg" alt="Dislocation">
        	</div>
        </div>
    	<div class="item">
    		<a href="http://au.blurb.com/" target="_blank" rel="nofollow">
        		<img src="design/{$settings->theme|escape}/images/blurb-logo.png" alt="Blurb">
        	</a>
    	</div>
    </div>
</div>