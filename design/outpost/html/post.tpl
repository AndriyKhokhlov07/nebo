{* Страница отдельной записи блога *}

{* Канонический адрес страницы *}
{$canonical="/blog/{$post->url}" scope=parent}

{$this_page='page' scope=parent}
{$page_type='post' scope=parent}


<div class="main_width post">
	<div class="path">
		<div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
		   <a href="{$config->root_url}/" itemprop="url"><span itemprop="title">{$settings->site_name|escape}</span></a> 
	    </div>
	    <div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
		   <a href="/blog" itemprop="url"><span itemprop="title">Blog</span></a>
	    </div>
		<div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
			<a href="{$config->root_url}/blog/{$post->url}" itemprop="url">
				<span itemprop="title">{$post->name}</span>
			</a>
		</div> 
	</div>
	<div class="post" itemscope itemtype="http://schema.org/Article">
		<!-- Заголовок /-->
		<h1 class="hide" data-post="{$post->id}" itemprop="headline">{$post->name|escape}</h1>
		<span itemscope itemprop="mainEntityOfPage" itemtype="https://schema.org/WebPage" itemid="{$config->root_url}/blog/{$post->url}"></span>

		<meta itemprop="datePublished" content="{$post->date|date_format:"%Y-%m-%d"}">
		<meta itemprop="dateModified" content="{$post->date|date_format:"%Y-%m-%d"}">
	<div itemprop="articleBody">
		<div class="text_block">
		
		<div class="hide" itemprop="image" itemscope itemtype="https://schema.org/ImageObject">
			<img src="{$post->image|resize:blog:1000:600}" alt="Image: {$post->name|escape}" itemprop="url contentUrl" content="{$post->image|resize:blog:1000:600}"/>
		</div>
		{*
		<div class="center">
			{if $post->authors}
	            <div class="post_authors">
	                {foreach $post->authors as $post_author}
	                    <a class="author" href="author/{$post_author->url}" itemprop="author" itemscope itemtype="https://schema.org/Person">
	                    	{if $post_author->image}
								<img src="{$post_author->image|resize:author:35:35}" alt="{$post_author->name|escape}">
							{else}
								<i class="icon-user"></i>
							{/if}
	                        <span itemprop="name">{$post_author->name|escape}</span>
	                    </a>
	                {/foreach}
	            </div>
	        {else}
	            <div itemprop="author" itemscope itemtype="https://schema.org/Person">
	                <meta itemprop="name" content="{$settings->site_name|escape}">
	            </div>
	        {/if}
	        <p class="date">{$post->date|date}</p>
		</div>
		*}
		
		{$post->text}
		{if $post->tags}
		<p class="center tags">
			Tagged:
    		{foreach $post->tags as $tag}
		    	<a href="blog_category/{$tag->url}">{$tag->name|escape}</a>
    		{/foreach}
    	</p>
    	{/if}
		</div>

	</div>

	<hr class="hr">

	<div class="main_width">
	    <div class="fx c w ch3 areas_list">
	        <a class="item" target="_blank" href="blog/refer-your-friends-to-outpost-and-youll-both-get-250/?utm_source=blog">
	            <div><p class="title">Outpost Referral Program</p>
	            <p class="p">Refer Your Friends to Outpost and You'll Both Get $250</p></div>
	        </a>
	        <a class="item" target="_blank" href="hot-deals/?utm_source=referral&utm_medium=button&utm_campaign=blog">
	        	<div>
	        		<p class="title">Hot Deals</p>
	            	<p class="p">Hot Deals be Sure to Grab the Best Price!</p>
	        	</div>
	        </a>
	    </div>
	</div>



	<div itemprop="author" itemscope itemtype="https://schema.org/Person">
        <meta itemprop="name" content="{$settings->site_name|escape}">
    </div>


	<div class="hide" itemprop="publisher" itemscope itemtype="https://schema.org/Organization">
	    <meta itemprop="telephone" content="+18337076611">
	    <meta itemprop="address" content="10 Hanover Square, New York, NY, 10005, USA">
	    <meta itemprop="name" content="{$settings->site_name|escape}">
	    <span itemprop="logo" itemscope itemtype="https://schema.org/ImageObject">
	        <img itemprop="url contentUrl" content="{$config->root_url}/design/{$settings->theme|escape}/images/logo" src="design/{$settings->theme|escape}/images/logo.png" alt="{$settings->site_name|escape}">
	        <meta itemprop="width" content="900px">
	        <meta itemprop="height" content="132px">        
	    </span>                               
	</div>
		
		{$share_url = "`$config->root_url|urlencode`/`$category->url|urlencode`"}
		{if $post->image}
		    {$share_img = $post->image|resize:blog:150:150|urlencode}
		{/if}
		{$share_title = $post->name|urlencode}
		{$share_description = $meta_description|urlencode}


	</div>



	<!-- Соседние записи /-->
	<div id="back_forward">
		<div class="next_prev_block prev">
			{if $prev_post}
	        	<div class="wrapper t_block">
	            	<div class="i">
	                	<a href="blog/{$prev_post->url}"><i class="fa fa-angle-left"></i></a>
	                </div>
	                <div>
	                	<div class="info">Prev post</div>
	                	<h6><a class="prev_page_link" href="blog/{$prev_post->url}">{$prev_post->name}</a></h6>
	            		<p>
	                    {if $prev_post->annotation|strip_tags|trim|mb_strlen > 120}
							{$prev_post->annotation|strip_tags|trim|mb_substr:0:120}...
						{else}
							{$prev_post->annotation|strip_tags|trim}
						{/if}
	                    </p>
	                </div>
	            </div>
			{/if}
		</div>
	    <div class="next_prev_block next">
			{if $next_post}
	        	<div class="wrapper t_block">
	                <div>
	                	<div class="info">Next post</div>
	                	<h6><a class="next_page_link" href="blog/{$next_post->url}">{$next_post->name}</a></h6>
	            		<p>
	                    {if $next_post->annotation|strip_tags|trim|mb_strlen > 120}
							{$next_post->annotation|strip_tags|trim|mb_substr:0:120}...
						{else}
							{$next_post->annotation|strip_tags|trim}
						{/if}
	                    
	                    </p>
	                </div>
	                <div class="i">
	                	<a href="blog/{$next_post->url}"><i class="fa fa-angle-right"></i></a>
	                </div>
	            </div>
			{/if}
		</div>
	</div>
</div>
