{* Список товаров *}

{* Канонический адрес страницы *}
{if $category && $brand}
{$canonical="/catalog/{$category->url}/{$brand->url}" scope=parent}
{elseif $category}
{$canonical="/catalog/{$category->url}" scope=parent}
{elseif $brand}
{$canonical="/brands/{$brand->url}" scope=parent}
{elseif $keyword}
{$canonical="/products?keyword={$keyword|escape}" scope=parent}
{else}
{$canonical="/products" scope=parent}
{/if}
{$this_page='products' scope=parent}
{$apply_button_hide=1 scope=parent}
{$members_menu=1 scope=parent}


<div class="w1200">



<div class="path">
	{* <div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
	   <a href="{$config->root_url}/" itemprop="url"><span itemprop="title">Main</span></a> 
    </div> *}
    <div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
	   <a href="current-members" itemprop="url"><span itemprop="title">Current Members</span></a> 
    </div>
    {if $category}
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
	{elseif $brand}
		<div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
			<a href="brands/{$brand->url}" itemprop="url"><span itemprop="title">{$brand->name|escape}</span></a>
	    </div>
	{elseif $keyword}
		<div>
			<span>Search for</span>
		</div>	
	{/if}
</div><!-- path -->


{* Заголовок страницы *}
{if $keyword}
<h1 class="bold_h1">Search for {$keyword|escape}</h1>
{elseif $page}
<h1 class="bold_h1">{$page->name|escape}</h1>
{else}
<h1 class="bold_h1">{$category->name|escape} {$brand->name|escape}</h1>
{/if}








{* Описание страницы (если задана) *}
{$page->body}

{if $current_page_num==1}
{* Описание категории *}
{$category->description}
{/if}

{* Фильтр по брендам *}
{if $category->brands}
<div id="brands">
	<a href="catalog/{$category->url}" {if !$brand->id}class="selected"{/if}>All brands</a>
	{foreach $category->brands as $b}
		{if $b->image}
		<a data-brand="{$b->id}" href="catalog/{$category->url}/{$b->url}"><img src="{$config->brands_images_dir}{$b->image}" alt="{$b->name|escape}"></a>
		{else}
		<a data-brand="{$b->id}" href="catalog/{$category->url}/{$b->url}" {if $b->id == $brand->id}class="selected"{/if}>{$b->name|escape}</a>
		{/if}
	{/foreach}
</div>
{/if}


{* Фильтр по свойствам *}
{if $features}
<table class="filter">
	{foreach $features as $key=>$f}
	<tr>
	<td class="feature_name" data-feature="{$f->id}">
		{$f->name}:
	</td>
	<td class="feature_values">
		<a href="{url params=[$f->id=>null, page=>null]}" {if !$smarty.get.$key}class="selected"{/if}>Any</a>
		{foreach $f->options as $o}
		<a href="{url params=[$f->id=>$o->value, page=>null]}" {if $smarty.get.$key == $o->value}class="selected"{/if}>{$o->value|escape}</a>
		{/foreach}
	</td>
	</tr>
	{/foreach}
</table>
{/if}


<!--Каталог товаров-->
{if $products}



<ul class="products fx w">

	{foreach $products as $product}
	<li class="product">
		<div class="image">
		{if $product->image}
			<a href="products/{$product->url}">
				<img src="{$product->image->filename|resize:'product':460:460}" alt="{$product->name|escape}"/>
			</a>
		{/if}
		</div>
		<div class="product_info">
			<h3 class="{if $product->featured}featured{/if}">
				<a data-product="{$product->id}" href="products/{$product->url}">{$product->name|escape}</a>
			</h3>
			<div class="annotation">{$product->annotation}</div>
			{if $product->variant}
				<div class="price_block">
					{if $product->variant->compare_price > 0}
					<div class="compare_price">{$currency->sign|escape} {$product->variant->compare_price|convert}</div>{/if}
					<div class="price">
						{if $product->variant->price == 0}
							Free
						{else}
							{if $product->variants|count > 1}from{/if}
							{$currency->sign|escape} {$product->variant->price|convert}
						{/if}
					</div>
				</div>
			{/if}
			<a class="more" href="products/{$product->url}">More →</a>
		</div>
	</li>
	<!-- Товар (The End)-->
	{/foreach}
			
</ul>

{include file='pagination.tpl'}	
<!-- Список товаров (The End)-->

{else}
	Items not found
{/if}
<!--Каталог товаров (The End)-->

</div><!-- main_width -->