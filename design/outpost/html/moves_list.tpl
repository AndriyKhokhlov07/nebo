{* HouseLeader Page *}

{* Канонический адрес страницы *}
{$canonical={$page->url} scope=parent}

{$this_page='page' scope=parent}
{$js_include="design/`$settings->theme`/js/houseleader.js?v3" scope=parent}
<link href="design/{$settings->theme|escape}/css/landlord/landlord.css?v1.0.16" rel="stylesheet">

{$members_menu=1 scope=parent}



<div class="main_width">
	<div class="path">
		<div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
		   <a href="{$config->root_url}/" itemprop="url"><span itemprop="title">Main</span></a> 
	    </div>
	    <div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
		   <a href="moves-schedule" itemprop="url"><span itemprop="title">Moves List</span></a> 
	    </div>
		<div>
			<span>{$page->name}</span>
		</div>
	</div><!-- path -->
	<div class="houseleader_block guest_home">

	{if $apartments}
	<div class="tenents_calendar moves_version">
	    <div class="days_lines days_bx days_3 fx">
	        {foreach $moves_days as $day}
	            <div class="d">
	                <span>
	                	{$day} 
	                	<div class="fx ch2">
		                	<div>Move-In</div>
		                	<div>Move-Out</div>
		                </div>
	                </span>
	            </div>
	        {/foreach}
	    </div>
	    {foreach $apartments as $apartment}
	        <div class="apartment_bx">
	            <div class="title_bx">
	                <div>
	                </div>
	            </div><!-- title_bx -->
				<p class="title">{$apartment->name}
                {if !$apartment->visible}
                    [off]
                {/if}</p>
	            <div class="lines_bx">

	                {foreach $apartment->rooms as $room}
	                    {foreach $room->beds as $bed}
	                        <div class="line_bx fx ">
	                            <div class="l_head fx v c">
	                                <div>
	                                    {if !$room->visible}
	                                        [room {$room->name} off] –
	                                    {/if}
	                                    {$bed->name}
	                                    <span class="badge">{$rooms_types[$room->type_id]->name}</span>
	                                </div>
	                            </div><!-- l_head -->
	                            <div class="l_cont">
	                            	<div class="fx ch3">
	                            		{foreach $moves_days as $day}
								            <div class="fx ch2">
			                            		<div>
			                            			{if $bed->moves_in[$day]}
			                            			<form method="post" id='product'>
														<input type=hidden name="session_id" value="{$smarty.session.id}">
														<input type="hidden" name="bed_id" value="{$bed->id}">
														<input type="hidden" name="clean_status" value="1">
														<button class="button" type="submit">Set clean</button>
													</form>
			                            			{/if}
			                            		</div>
			                            		<div>
			                            			{if $bed->moves_out[$day]}
			                            			<form method="post" id='product'>
														<input type=hidden name="session_id" value="{$smarty.session.id}">
														<input type="hidden" name="bed_id" value="{$bed->id}">
														<input type="hidden" name="clean_status" value="1">
														<button class="button" type="submit">Set clean</button>
													</form>
			                            			{/if}
			                            		</div>
			                            	</div>
								        {/foreach}
	                            	</div>
	                            </div><!-- l_cont -->
	                        </div><!-- line_bx -->
	                    {/foreach}
	                {/foreach}
	            </div><!-- lines_bx -->
	        </div><!-- apartment_bx -->
	    {/foreach}
	</div><!-- tenents_calendar -->
	{/if}
		
	</div><!-- houseleader_block -->
</div>

