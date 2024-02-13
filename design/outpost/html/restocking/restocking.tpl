{* Restocking *}

{$this_page='restocking' scope=parent}


{$members_menu=1 scope=parent}


{$js_include="design/`$settings->theme`/js/restocking.js?v1.0.0" scope=parent}

<div class="restocking_wrapper main_width">

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
			<a href="restocking"><span>{$title}</span></a> 
		</div>
		<div>
			<span>{$house->name}</span>
		</div>
	</div><!-- path -->
	*}


	<div class="restocking_block">

		<a class="back" href="restocking"><i class="fa fa-angle-left"></i> Back</a>



		<div class="title2">{$title}</div>
		<h1 class="bold_h1">{$house->name}</h1>
		{if $inventory}
			<div class="date">{$inventory->date|date_format:"%b %e, %Y"} at {$inventory->date|time}</div>
		{/if}

		{if $message_success}
			<div class="message_success fx sb w100">
				<div class="fx v c">
					<span>{$title} data {if $message_success=='updated'}updated{elseif $message_success=='added'}added{/if}</span>
				</div>
				<div>
					<a class="back" href="restocking"><i class="fa fa-angle-left"></i> Back</a>
				</div>
				
			</div>
		{else}
			<div class="info_line">Listed amount which available NOW</div>
		{/if}
		
		{if $groups_tree}
		<form method="post" enctype="multipart/form-data">
			<input type=hidden name="session_id" value="{$smarty.session.id}">
			<input name=id type="hidden" value="{$inventory->id}">

			<input name="type" type="hidden" value="{if $user->type==2}kitchen_restocking{else if $user->type==3}restocking{/if}">

			{function name=groups_tree level=0}

			{if $groups_t}
			{foreach $groups_t as $group}
				{$subcategories_items=0}
				{if $group->subcategories}
					{foreach $group->subcategories as $sc}
						{if $sc->items}
							{$subcategories_items=1}
						{/if}
					{/foreach}
				{/if}
				{if $subcategories_items || $group->items}
				<div class="restocking_group{if !$group->items} no_items{/if}">
					{if $group->subcategories}
						<input class="show_subcat hide" id="ssc_{$group->id}" type="checkbox" name="ssc_{$group->id}" value="1"{if $groups_t|count==1} checked="checked"{/if}>
						<label class="title" for="ssc_{$group->id}">{$group->name|escape}</label>
					{else if $group->items}
						<input class="show_items hide" id="si_{$group->id}" type="checkbox" name="si_{$group->id}" value="1" {if $groups_t|count==1} checked="checked"{/if}>
						<label class="title" for="si_{$group->id}">{$group->name|escape}</label>
					{/if}
					{if $group->items && !$group->subcategories}
					<div class="items fx w">
						{foreach $group->items as $item}
							<div class="item fx">
								<div class="name fx v c">
									<div class="fx">
										<span class="num">{$item@iteration}</span>
										<label for="r_{$group->id}_{$item->id}">{$item->name|escape}</label>
									</div>
									
								</div><!-- name -->
								<div class="i_inp_block fx">
									<div class="i_inp fx v c">
										{if $inventory}
											<input id="r_{$group->id}_{$item->id}" name="inv[{$group->id}][{$item->id}][{$inventory->values[{$group->id}][{$item->id}]->id}]" type="number" step="1" value="{if $inventory->values[{$group->id}][{$item->id}]}{$inventory->values[{$group->id}][{$item->id}]->value}{/if}" placeholder="0">
										{else}
											<input id="r_{$group->id}_{$item->id}" name="inv[{$group->id}][{$item->id}][0]" type="number" step="1" value="" placeholder="0">
										{/if}
										<div class="unit">
											{if $item->unit}
												{$item->unit|escape}
											{else}
												pcs
											{/if}
										</div><!-- unit -->
									</div>
									<div class="i_nav fx v c">
										<div class="plus">+</div>
										<div class="minus">-</div>
									</div><!-- i_nav -->
								</div><!-- i_inp -->
								
							</div><!-- item -->
						{/foreach}
					</div>
					{/if}
					{groups_tree groups_t=$group->subcategories level=$level+1}
				</div><!-- restocking_group -->
				{/if}
			{/foreach}
			{/if}
			{/function}
			{groups_tree groups_t=$groups_tree}

			<textarea class="note{if !$inventory->note} hide{/if}" name="note" placeholder="Note">{$inventory->note|escape}</textarea>

			<div class="r_images_block images">
				<ul class="r_images fx w">
					{foreach $inventory->images as $image}
					{if $image}
					<li class="r_image">
						<div>
							<img src="{$config->inventories_images_dir}{$image}" alt="" />
							<i class='delete fa fa-times-circle'></i>
							<input type=hidden name='images[]' value='{$image}'>
						</div>
					</li>
					{/if}
					{/foreach}
				</ul><!-- r_images -->
			</div><!-- r_images_block -->

			<div class="button_block">
				<div class="note_photo_btn fx c">
					<div class="to_add_note{if $inventory->note} hide{/if}">
						<i class="fa fa-pencil"></i>
						Add note
					</div>
					<div id="dropZone" class="to_add_photo">
						<div id="dropMessage"><i class="fa fa-picture-o"></i> Add photo</div>
						<input type="file" name="dropped_images[]" multiple class="dropInput">
					</div>
				</div>
				<button class="button green" type="submit">Apply</button>
			</div><!-- button_block -->
		</form>
		{/if}
	</div><!-- restocking_houses_block -->
</div>



