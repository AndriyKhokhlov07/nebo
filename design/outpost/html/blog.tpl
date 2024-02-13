{* Список записей блога *}

{* Канонический адрес страницы *}

{if !$tag && !$author}
{$canonical="/blog" scope=parent}
{elseif $tag}
{$canonical="/blog_category/"|cat:$tag->url scope=parent}
{elseif $author}
{$canonical="/author/"|cat:$author->url scope=parent}
{/if}

{$this_page='page' scope=parent}

<div class="w1200 blog_page {if $author || $tag || $current_page_num!=1}page_wrap{/if}">
<div class="txt">
{$page->body}	
</div>


	
<div class="path">
	<div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
	   <a href="{$config->root_url}/" itemprop="url"><span itemprop="title">{$settings->site_name|escape}</span></a> 
    </div>
    {if $page->parent}
    <div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
	   <a href="{$page->parent->url}" itemprop="url"><span itemprop="title">{$page->parent->name}</span></a>
    </div>
    {/if}
    {if $author || $tag}
	<div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
	   <a href="/blog" itemprop="url"><span itemprop="title">Blog</span></a>
    </div>
    {/if}
    {if $author}
    <div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
		<a href="{$config->root_url}/author/{$author->url}" itemprop="url">
			<span itemprop="title">{$author->name}</span>
		</a>
	</div>
	{elseif $tag}
	<div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
		<a href="{$config->root_url}/blog_category/{$tag->url}" itemprop="url">
			<span itemprop="title">{$tag->name}</span>
		</a>
	</div>
	{else}
	<div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
		<a href="{$config->root_url}/{$page->url}" itemprop="url">
			<span itemprop="title">{$page->name}</span>
		</a>
	</div> 
    {/if}                  
</div>

<div class="fx">
	<div class="blog_ch2">
	    <ul class="blog fx ch2">
	        {foreach $posts as $post}
	        <li>
	        	
	        	<div class="preview">
	                <h4><a data-post="{$post->id}" href="blog/{$post->url}">{$post->name|escape}</a></h4>
	                
	                <div class="post_authors">
	                {foreach $post->authors_ids as $author_id}
						{if $posts_authors[$author_id]}
							{$p_author = $posts_authors[$author_id]}
							<a class="author" href="author/{$p_author->url}">
								{if $p_author->image}
									<img src="{$p_author->image|resize:author:35:35}" alt="{$p_author->name|escape}">
								{else}
								{/if}
								<span>by {$p_author->name|escape}</span>
							</a>
						{/if}
					{/foreach}
					</div>
	                <p class="date">{$post->date|date_format:"%b %e, %Y"}</p>
	                
				</div>
				
	            {if $post->image}
	                    <a class="img" href="blog/{$post->url}">
	                        <img src="{$post->image|resize:blog:700:700}" alt="{$post->name|escape}">
	                    </a>
	            {/if}
	            <div class="preview">
	            	{if $post->tags_ids}
				    		{foreach $post->tags_ids as $tag_id}
				    			{if $posts_tags[$tag_id]->featured == 1}
				    			<p class="post_tags">
					    			{if $tag->id == $tag_id}
					    				<span>{$tag->name|escape}</span>
					    			{else}
					    				<a href="blog_category/{$posts_tags[$tag_id]->url}">{$posts_tags[$tag_id]->name|escape}</a>
					    			{/if}
				    			</p>
				    			{/if}
				    		{/foreach}
				    {/if}
	                <div>{$post->annotation}</div>
	                <a class="more" href="blog/{$post->url}">Read More →</a>
	            </div>
	        </li>
	        {/foreach}
	    </ul>
	    {include file='pagination.tpl'} 
	</div>
	<div class="blog_sb">
		{get_posts featured=1 var=f_posts limit=5}
		{if $f_posts}
		<p class="h5">Featured</p>
		<ul class="featured_blog">
			{foreach $f_posts as $post}
			<li class="fx">
				<div>
					<a class="img" href="blog/{$post->url}">
	                    <img src="{$post->image|resize:blog:100:100}" alt="{$post->name|escape}">
	                </a>
				</div>
				<div>
					<h5 class="h5"><a data-post="{$post->id}" href="blog/{$post->url}">{$post->name|escape}</a></h5>
	                <p class="date">{$post->date|date_format:"%b %e, %Y"}</p>
				</div>
				
			</li>
			{/foreach}
		</ul>

		<hr class="hr">
		{/if}
		<a href="hot-deals/?utm_source=referral&utm_medium=banner&utm_campaign=blog" target="_blank" class="promo_block">
			<h6 class="h2">Hot Deals</h6>
			<h6 class="h5">Be Sure To Grab The Best Price!</h6>
		</a>
		<hr class="hr">

		<div class="follow">
			<p class="h5">Follow us</p>
			<div class="socials fx">
                <a href="http://instagram.com/outpost_club" data-tooltip="Instagram" target="_blank" rel="nofollow">
                    <img src="/design/{$settings->theme|escape}/images/icons/instagram.svg" alt="Outpost instagram">
                </a>
                {*
                <a href="https://twitter.com/outpost_club" data-tooltip="Twitter" target="_blank" rel="nofollow">
                    <img src="/design/{$settings->theme|escape}/images/icons/twitter.svg" alt="Outpost twitter">
                </a>
                <a href="https://www.linkedin.com/company-beta/17932725/" data-tooltip="Linkedin" target="_blank" rel="nofollow">
                    <img src="/design/{$settings->theme|escape}/images/icons/linkedin.svg" alt="Outpost linkedin">
                </a>
                *}
                <a href="http://www.facebook.com/outpostclubNY/" data-tooltip="Facebook" target="_blank" rel="nofollow">
                    <img src="/design/{$settings->theme|escape}/images/icons/facebook.svg" alt="Outpost facebook">
                </a>
            </div>

		</div>
		
	</div>
</div>
</div>
