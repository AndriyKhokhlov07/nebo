{* HouseLeader Page *}

{* Канонический адрес страницы *}
{$canonical={$page->url} scope=parent}

{$this_page='page' scope=parent}
{$js_include="design/`$settings->theme`/js/houseleader.js?v3" scope=parent}

{$members_menu=1 scope=parent}



<div class="main_width">
	<div class="path">
		<div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
		   <a href="{$config->root_url}/" itemprop="url"><span itemprop="title">Main</span></a> 
	    </div>
	    <div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
		   <a href="current-members" itemprop="url"><span itemprop="title">Current Members</span></a> 
	    </div>
	    <div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
		   <a href="houseleader" itemprop="url"><span itemprop="title">House Leader</span></a> 
	    </div>
		<div>
			<span>{$page->name}</span>
		</div>
	</div><!-- path -->
	<div class="houseleader_block guest_home">
		{if $message_success == 'added'}
		<h1 class="bold_h1">
			Thank you!
		</h1>
		{elseif $error == 'no_notify'}
		<h1 class="bold_h1">
			Use button in <a href="/notifications">Notifications</a> or link in email.
		</h1>
		{elseif $page->blocks}
		<h1 class="bold_h1">{$page->header}</h1>

		<div class="text_block hl_text">
			{$page->body}
		</div>
			<div class="hl_checklist form2">
				<form class="" method="post" enctype="multipart/form-data">
					<input name="type" type="hidden" value="hl_checklist">
					
	                <input type="hidden" name="name[1]" value="Checklist">
	                <input type="hidden" name="value[1]" value="{$page->name|escape}">

	                <input type="hidden" name="name[2]" value="HouseLeader">
	                <input type="hidden" name="value[2]" value="{$smarty.session.user_name}">

	                {*
	                <input type="hidden" name="name[0]" value="">
	                <input type="hidden" name="value[0]" value="HouseLeader Checklist">

	                <input type="hidden" name="name[3]" value="House">
	                <input type="hidden" name="value[3]" value="{$user_house->name|escape}">
	            	*}

					

	            	<input type="hidden" name="name[clear1]" value="clear">
	                <input type="hidden" name="value[clear1]" value="1">
					
					{function name=page_blocks_tree k='' hide_child=0}
						{foreach $page_blocks as $i=>$pb}
							<div class="ch_item t{$pb['type']} {if $hide_child}hide_child{/if}">

								{if $pb['type']==1 || $pb['type']==7} <!-- text / note -->
									{if $pb['title']}
										<p class="title">{$pb['title']}</p>
									{/if}
									{if $pb['description']}
										<div class="description">{$pb['description']|replace:'{user_code}':{$guest->auth_code}}</div>
									{/if}


								{elseif $pb['type']==2} <!-- checkbox -->
									{*
									<input type="checkbox" name="name[c{$k}_{$i}]" id="c{$k}_{$i}" value="{$pb['title']}">
									<input type="hidden" name="value[c{$k}_{$i}]" value="Checked">
									*}

									<input type="hidden" name="name[c{$k}_{$i}]" value="{$pb['title']}">
									<input class="mmr" type="checkbox" name="value[c{$k}_{$i}]" id="c{$k}_{$i}" value="Checked" {if $mmr["c`$k`_`$i`"]} checked{/if}>
									<div class="ch_bx">
										{if $pb['title']}
											<label class="title" for="c{$k}_{$i}">{$pb['title']}</label>
										{/if}
										{if $pb['description']}
											<div class="description">{$pb['description']}</div>
										{/if}
									</div>


								{elseif $pb['type']==3} <!-- radio -->
									{*
									<input type="radio" name="name[c{$k}]" id="c{$k}_{$i}" value="{$$pb['title']}">
									<input type="hidden" name="value[c{$k}_{$i}]" value="Checked">
									*}
									<input type="hidden" name="name[c{$k}]" value="{$parent['title']}">
									<input class="mmr" type="radio" name="value[c{$k}]" id="c{$k}_{$i}" value="{$pb['title']}" {if $mmr["c`$k`_`$i`"]} checked{/if}>
									<div class="ch_bx">
										{if $pb['title']}
											<label class="title" for="c{$k}_{$i}">{$pb['title']}</label>
										{/if}
										{if $pb['description']}
											<div class="description">{$pb['description']}</div>
										{/if}
									</div>


								{elseif $pb['type']==5} <!-- input -->
									<div class="input_block">
										<input type="hidden" name="name[c{$k}_{$i}]" value="{$pb['title']}">
										<input class="mmr {if $pb['name']}inp_{$pb['name']}{/if}" type="text" name="value[c{$k}_{$i}]" id="c{$k}_{$i}" value="{if $pb['name'] == 'apt' || $pb['name'] == 'bed'}{$guest->$pb['name']->name}{elseif $pb['name']}{$guest->{$pb['name']}}{elseif $mmr["c`$k`_`$i`"]}{$mmr["c`$k`_`$i`"]}{/if}" {if $pb['title']}placeholder="{$pb['title']}"{/if} {if !$hide_child}required{/if}>
										{if $pb['description']}
											<div class="description">{$pb['description']}</div>
										{/if}
									</div>

								
								{elseif $pb['type']==6} <!-- textarea -->
									<div class="input_block">
										<input type="hidden" name="name[c{$k}_{$i}]" value="{$pb['title']}">
										<textarea class="mmr" name="value[c{$k}_{$i}]" id="c{$k}_{$i}" {if $pb['title']}placeholder="{$pb['title']}"{/if}>{if $mmr["c`$k`_`$i`"]}{$mmr["c`$k`_`$i`"]}{/if}</textarea>
										{if $pb['description']}
											<div class="description">{$pb['description']}</div>
										{/if}
									</div>

								{elseif $pb['type']==8} <!-- select house -->
									<div class="input_block">
										<input type="hidden" name="name[c{$k}_{$i}]" value="{$pb['title']}">
										<div class="select_wrapper">
										<div class="select_block">
											<select class="mmr" name="value[c{$k}_{$i}]">
												<option value="Non selected">--- {$pb['title']} ---</option>
												{foreach $pages as $pp}
	            									{if $pp->menu_id==5}
	            										{if $pp->subcategories}
	            											<optgroup label="{$pp->name|escape}">
	            											{foreach $pp->subcategories as $p}
			            										<option class="h_{$p->id}" data-id='{$p->id}' id="c{$k}_{$i}_{$p->id}" {if $mmr["c`$k`_`$i`_`$p->id`"]==$p->name|escape || $guest->house_id==$p->id}selected{/if}>{$p->name|escape}</option>
		            										{/foreach}
		            										</optgroup>
	            										{/if}
	            									{/if}
	            								{/foreach}
											</select>
										</div>
										</div>
										{if $pb['description']}
											<div class="description">{$pb['description']}</div>
										{/if}
									</div>
									{if ($page->id == 235 || $page->id == 241) && !$guest}
									<div class="search">
										<input class="hide" type="text" name="user_id" id="user_id">
										<input type="text" name=user id="user" placeholder="Select Guest">
									</div>
									{/if}


								{elseif $pb['type']==9} <!-- Restocking items -->
									<div class="select_restocking_item_block">
										<div class="input_block">
											<input type="hidden" name="name[c{$k}_{$i}]" value="House (order)">
											<div class="select_wrapper">
											<div class="select_block">
												<select class="house" name="value[c{$k}_{$i}]">
													<option value="0">--- Select house ---</option>
		            								{foreach $pages as $pp}
		            									{if $pp->menu_id==5}
		            										{if $pp->subcategories}
		            											<optgroup label="{$pp->name|escape}">
		            											{foreach $pp->subcategories as $p}
				            										<option data-value="{$p->id}">{$p->name|escape}</option>
			            										{/foreach}
			            										</optgroup>
		            										{/if}
		            									{/if}
		            								{/foreach}
												</select>
											</div>
											</div>
											{if $pb['description']}
												<div class="description">{$pb['description']}</div>
											{/if}
										</div>
										<div class="input_block select_restocking_item">
											<div class="wrapper fx" data-n="1">
												<div class="restocking_item">
													<div class="select_wrapper">
														<div class="select_block">
															<select class="select_item" name="name[v1]"></select>
														</div>
													</div><!-- select_wrapper -->
												</div><!-- restocking_item -->
												<input class="amount" type="number" step="1" name="value[v1]" value="" placeholder="Amount" required>
												<div class="del_bx fx v c">
													<i class="del fa fa-times-circle" aria-hidden="true"></i>
												</div>
											</div>
										</div><!-- input_block -->
										<a class="add" href="#">choose more</a>
									</div><!-- select_restocking_item_block -->

								{elseif $pb['type']==10} <!-- Notification email -->
									<input type="hidden" name="mail_to" value="{$pb['title']}">

								{elseif $pb['type']==11} <!-- Notification email -->
									<div class="input_block">
										{if $pb['title']}
											<p class="title">{$pb['title']}</p>
										{/if}
										{if $pb['description']}
											<div class="description">{$pb['description']}</div>
										{/if}
										<input type="hidden" name="name[c{$k}_{$i}]" value="{$pb['title']}">
										<input type="file" name="files[c{$k}_{$i}][]" multiple="">
									</div>

								{/if}

								{$hidechild=0}
								{if $pb['sub']}
									{if $pb['hide_child']==1}
										{$hidechild=$pb['hide_child']}
									{/if}
									{page_blocks_tree page_blocks=$pb['sub'] k="{$k}_{$i}" hide_child=$hidechild parent=$pb}
								{/if}
							</div><!-- item -->
						{/foreach}
					{/function}
					{page_blocks_tree page_blocks=$page->blocks k=''}
					<button class="button red" type="submit">Submit</button>
					<div class="clear_form{if !$mmr} hide{/if}">Reset</div>
				</form>
				<div class="info"><span></span></div>
			</div><!-- houseleader_checklist -->
		{/if}
		
	</div><!-- houseleader_block -->
</div>

