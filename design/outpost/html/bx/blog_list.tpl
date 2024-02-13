
{get_posts type=1 var=posts limit=8}
{if $posts}
<div class="main_width blog_list">
	<h4 class="h3 center">Outpost Coliving Blog</h4>
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