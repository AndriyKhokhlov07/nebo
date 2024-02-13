{* Restocking | Select House *}

{$this_page='restocking' scope=parent}

{$members_menu=1 scope=parent}



<div class="main_width">
	{*
	<div class="path">
		<div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
		   <a href="{$config->root_url}/" itemprop="url"><span itemprop="title">Main</span></a> 
	    </div>
	    {if $user->type==2}
		    <div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
			   <a href="current-members" itemprop="url"><span itemprop="title">Current Members</span></a> 
		    </div>
		    <div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
			   <a href="houseleader" itemprop="url"><span itemprop="title">House Leader</span></a> 
		    </div>
	    {/if}
		<div>
			<span>{$title}</span>
		</div>
	</div><!-- path -->
	*}


	<div class="restocking_block">
		<h1 class="bold_h1">{$title}</h1>
		<div class="title2">Select House</div>

		{if $houses}
			{foreach $houses as $city}
				{if $city->subcategories}
				<div class="houses_group">
					<div class="title h3">{$city->name|escape}</div>
					<div class="r_houses fx w w100">
						{foreach $city->subcategories as $house}
							<a class="item" href="restocking/{$house->id}">
								<span class="title">{$house->name|escape}</span>
								{if $house->location}
									<span class="location">{$house->location|escape}</span>
								{/if}

								<i class="fa fa-angle-right"></i>
							</a>
						{/foreach}
					</div><!-- r_houses -->
				</div><!-- houses_group -->
				{/if}
			{/foreach}
		{/if}
		
		{*		
		{if $houses}
		<div class="r_houses fx w w100">
			{foreach $houses as $house}
				<a class="item" href="restocking/{$house->id}">
					<span class="title">{$house->name|escape}</span>
					{if $house->location}
						<span class="location">{$house->location|escape}</span>
					{/if}

					<i class="fa fa-angle-right"></i>
				</a>
			{/foreach}
		</div><!-- r_houses -->
		{/if}

		*}

	</div><!-- restocking_houses_block -->
</div>



