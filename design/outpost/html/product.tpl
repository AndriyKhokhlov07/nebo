{* Страница товара *}

{* Канонический адрес страницы *}
{$canonical="/products/{$product->url}" scope=parent}

{$this_page='product' scope=parent}
{$product=$product scope=parent}
{$apply_button_hide=1 scope=parent}
{if $user}
	{$members_menu=1 scope=parent}
{/if}


<div class="product_block main_width">
	
	<div class="path">
		{* <div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
		   <a href="{$config->root_url}/" itemprop="url"><span itemprop="title">Main</span></a> 
	    </div> *}
	    <div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
		   <a href="current-members" itemprop="url"><span itemprop="title">Current Members</span></a> 
	    </div>
	    {foreach $category->path as $cat}
			<div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
			   <a href="catalog/{$cat->url}" itemprop="url"><span itemprop="title">{$cat->name|escape}</span></a>
		    </div>
	    {/foreach}
	    {if $brand}
	    	<div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
			   <a href="catalog/{$cat->url}/{$brand->url}" itemprop="url"><span itemprop="title">{$brand->name|escape}</span></a>
		    </div>
		{/if}
		<div>
			<span>{$product->name|escape}</span>
		</div> 
	</div><!-- path -->

	<div class="product_view">
		<div class="main_info fx w w100">
			<div class="images_block fx v">
				{if $product->image}
					{*<a class="image{if $product->images|count>1} v2_{/if}" href="{$product->image->filename|resize:'product':1200:1000}" data-fancybox="product">
						<img src="{$product->image->filename|resize:'product':700:900}" alt="{$product->product->name|escape}">
					</a>*}
					<div class="image{if $product->images|count>1} v2_{/if}">
						<img src="{$product->image->filename|resize:'product':900:900}" alt="{$product->product->name|escape}">
					</div>
				{/if}
				{*
				{if $product->images|count>1}
					<div class="images fx w w100">
						{foreach $product->images|cut as $i=>$image}
							<div class="img">
								<a href="{$image->filename|resize:'product':1200:1000}" data-fancybox="product">
									<img src="{$image->filename|resize:'product':125:125}" alt="{$product->name|escape}">
								</a>
							</div>
						{/foreach}
					</div>
				{/if}
				*}
			</div><!-- images_block -->
			<div class="cont">
				<h1 class="title" data-product="{$product->id}">{$product->name|escape}</h1>

				{if $product->variants|count > 0}
					<form class="variants" action="/{if $user}cart{else}user/login{/if}" method="{if $user}get{else}post{/if}">
						{* {if $product->variants|count > 1} *}
							<div class="select_variant fx w100 ch_{$product->variants|count}">
								{foreach $product->variants as $v}
									<input id="product_{$v->id}" name="variant" value="{$v->id}" type="radio"{if $product->variant->id==$v->id} checked{/if}>
									<div class="variant_info">
										<label for="product_{$v->id}">
											<span class="v_name">{$v->name}</span>
											{if $v->compare_price > 0}
												<span class="compare_price">{$currency->sign|escape} {$v->compare_price|convert}</span>
											{/if}
											<span class="price">
												{if $v->price==0}
													Free
												{else}
													{$currency->sign|escape} {$v->price|convert}
												{/if}
											</span>
										</label>
										<input type="submit" class="button" value="{if $v->price==0}RSVP{else}Pay{/if}">
									</div>
								{/foreach}
							</div>
						{* {/if} *}
					</form>
				{/if}

				{if $product->image}
					{$ogimage="{$product->image->filename|resize:'product':700:900}"}
				{else}
					{$ogimage="{$config->root_url}/design/{$settings->theme|escape}/images/logo.png"}
				{/if}

				{if $ogimage}
					{$share_img = $ogimage|urlencode}
				{/if}

				{$share_url = "`$config->root_url|urlencode`/products/`$product->url|urlencode`"}
			    {$share_title = $product->name|urlencode}
			    {if $product->annotation}
		            {$share_description = $product->annotation|strip_tags|urlencode}
		        {elseif $meta_description}
		            {$share_description = $meta_description|urlencode}
		        {/if}
				
				<div class="share fx">
					<div class="title">Share</div>
					<div class="sh fb" onClick='window.open("http://www.facebook.com/sharer.php?u={$share_url}","displayWindow","width=600,height=400,status=no,toolbar=no,menubar=no");return false;'>
		                <span>Facebook</span>
		            </div>
					<div class="sh copy_link" data-tooltip="Copied">
						<span>Copy link</span>
						<div id="link_to_copy">{$config->root_url}/products/{$product->url}</div>
					</div>
				</div>
				
				<div class="clear"></div>


				{if $product->features}
					<table class="features">
						{foreach $product->features as $f}
							<tr>
								<td>{$f->name}</td>
								<td>{$f->value}</td>
							</tr>
						{/foreach}
					</table>
				{/if}
			</div><!-- cont -->
		</div><!-- main_info -->
		
		<div class="product_info_block">
			{$product->body}
		</div>

		{if $category->url == 'events'}
			<div id="back_forward">
				<div class="next_prev_block prev"></div>
				<div class="next_prev_block back">
					<div class="wrapper t_block">
		            	<div class="i">
		                	<a href="catalog/events"><i class="fa fa-angle-left"></i></a>
		                </div>
		                <div>
		                	<h6><a class="prev_page_link" href="catalog/events">To all events</a></h6>
		                </div>
		            </div>
				</div>
			</div>
		{else}
		<div id="back_forward">
			<div class="next_prev_block prev">
				{if $prev_product}
		        	<div class="wrapper t_block">
		            	<div class="i">
		                	<a href="products/{$prev_product->url}"><i class="fa fa-angle-left"></i></a>
		                </div>
		                <div>
		                	<div class="info">Prev</div>
		                	<h6><a class="prev_page_link" href="products/{$prev_product->url}">{$prev_product->name|escape}</a></h6>
		                </div>
		            </div>
				{/if}
			</div>
		    <div class="next_prev_block next">
				{if $next_product}
		        	<div class="wrapper t_block">
		                <div>
		                	<div class="info">Next</div>
		                	<h6><a class="next_page_link" href="products/{$next_product->url}">{$next_product->name}</a></h6>
		                </div>
		                <div class="i">
		                	<a href="products/{$next_product->url}"><i class="fa fa-angle-right"></i></a>
		                </div>
		            </div>
				{/if}
			</div>
		</div>
		{/if}

	</div><!-- product -->

</div><!-- product_block -->




