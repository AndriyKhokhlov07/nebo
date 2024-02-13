{* HouseLeader Page *}

{* Канонический адрес страницы *}
{$canonical="/houseleader" scope=parent}

{$this_page='page' scope=parent}

{$members_menu=1 scope=parent}



<div class="main_width">
	<div class="path">
		<div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
		   <a href="{$config->root_url}/" itemprop="url"><span itemprop="title">Main</span></a> 
	    </div>
	    <div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
		   <a href="current-members" itemprop="url"><span itemprop="title">Current Members</span></a> 
	    </div>
		<div>
			<span>House Leader</span>
		</div>
	</div><!-- path -->
	<div class="houseleader_block guest_home">
		<h1 class="bold_h1">House Leader</h1>

		{if $hl_pages}
			{foreach $hl_pages as $hl_page}
				<div class="hl_group item">
					<input class="hide" id="hl_{$hl_page->id}" type="radio" name="hl" value="1">
					<label for="hl_{$hl_page->id}" class="header_bx fx w100">
						<div class="icon">
							<i class="fa fa-bookmark"></i>
						</div>
						<div class="title_bx fx v c">
							<div class="title">{$hl_page->name}</div>
						</div>
					</label><!-- header_bx -->

					{if $hl_page->subcategories}
						<div class="houseleader_box box fx w">
							{foreach $hl_page->subcategories as $p}
							<a class="hl_item fx" href="{$p->url}">
								<span class="icon">
									<i class="fa {if $p->icon}{$p->icon}{else}fa-file{/if}"></i>
								</span>
								<span class="title_bx fx v c">
									<span class="title">{$p->name}</span>
								</span>
							</a>
							{/foreach}
						</div><!-- box -->
					{/if}
				</div><!-- hl_group -->
			{/foreach}
		{/if}

		{*
		<div class="hl_group item">
			<input class="hide" id="hl_1" type="radio" name="hl" value="1">
			<label for="hl_1" class="header_bx fx w100">
				<div class="icon">
					<i class="fa fa-bookmark"></i>
				</div>
				<div class="title_bx fx v c">
					<div class="title">Move-In's, Move-Out's, and House Showings</div>
				</div>
			</label><!-- header_bx -->
			<div class="houseleader_box box fx w">

				<a class="hl_item fx" href="">
					<span class="icon">
						<i class="fa fa-file"></i>
					</span>
					<span class="title_bx fx v c">
						<span class="title">How to Add/Remove someone to/from August</span>
					</span>
				</a>

				<a class="hl_item fx" href="">
					<span class="icon">
						<i class="fa fa-list-ul"></i>
					</span>
					<span class="title_bx fx v c">
						<span class="title">How to Do a Move In Checklist</span>
					</span>
				</a>

				<a class="hl_item fx" href="">
					<span class="icon">
						<i class="fa fa-list-ul"></i>
					</span>
					<span class="title_bx fx v c">
						<span class="title">How to do a move-out Checklist</span>
					</span>
				</a>

				<a class="hl_item fx" href="">
					<span class="icon">
						<i class="fa fa-file"></i>
					</span>
					<span class="title_bx fx v c">
						<span class="title">How to Make contact with International Arrivals</span>
					</span>
				</a>

				<a class="hl_item fx" href="">
					<span class="icon">
						<i class="fa fa-list-ul"></i>
					</span>
					<span class="title_bx fx v c">
						<span class="title">How to show the house to prospective clients Checlist</span>
					</span>
				</a>

			</div><!-- box -->
		</div><!-- hl_group -->

		<div class="hl_group item">
			<input class="hide" id="hl_2" type="radio" name="hl" value="2">
			<label for="hl_2" class="header_bx fx w100">
				<div class="icon">
					<i class="fa fa-bookmark"></i>
				</div>
				<div class="title_bx fx v c">
					<div class="title">Being the Point of Contact For The house</div>
				</div>
			</label><!-- header_bx -->
			<div class="houseleader_box box fx w">

				<a class="hl_item fx" href="">
					<span class="icon">
						<i class="fa fa-file"></i>
					</span>
					<span class="title_bx fx v c">
						<span class="title">Advice on how to communicate with residents</span>
					</span>
				</a>

				<a class="hl_item fx" href="">
					<span class="icon">
						<i class="fa fa-file"></i>
					</span>
					<span class="title_bx fx v c">
						<span class="title">How to be the point of contact at the house</span>
					</span>
				</a>

			</div><!-- box -->
		</div><!-- hl_group -->


		<div class="hl_group item">
			<input class="hide" id="hl_3" type="radio" name="hl" value="3">
			<label for="hl_2" class="header_bx fx w100">
				<div class="icon">
					<i class="fa fa-bookmark"></i>
				</div>
				<div class="title_bx fx v c">
					<div class="title">Cleaning, maintenance, and restocking</div>
				</div>
			</label><!-- header_bx -->
			<div class="houseleader_box box fx w">

				<a class="hl_item fx" href="">
					<span class="icon">
						<i class="fa fa-list-ul"></i>
					</span>
					<span class="title_bx fx v c">
						<span class="title">House Review Check Lists (Each House)</span>
					</span>
				</a>

				<a class="hl_item fx" href="">
					<span class="icon">
						<i class="fa fa-list-ul"></i>
					</span>
					<span class="title_bx fx v c">
						<span class="title">Cleaning Review Checklist</span>
					</span>
				</a>

				<a class="hl_item fx" href="">
					<span class="icon">
						<i class="fa fa-list-ul"></i>
					</span>
					<span class="title_bx fx v c">
						<span class="title">Organization, Maintenance, and Reporting Checklist</span>
					</span>
				</a>

				<a class="hl_item fx" href="">
					<span class="icon">
						<i class="fa fa-file"></i>
					</span>
					<span class="title_bx fx v c">
						<span class="title">How to keep the kitchen clean</span>
					</span>
				</a>

				<a class="hl_item fx" href="">
					<span class="icon">
						<i class="fa fa-file"></i>
					</span>
					<span class="title_bx fx v c">
						<span class="title">How to Restock the house</span>
					</span>
				</a>

				<a class="hl_item fx" href="">
					<span class="icon">
						<i class="fa fa-list-ol"></i>
					</span>
					<span class="title_bx fx v c">
						<span class="title">Restocking List</span>
					</span>
				</a>

			</div><!-- box -->
		</div><!-- hl_group -->




		<div class="hl_group item">
			<input class="hide" id="hl_4" type="radio" name="hl" value="4">
			<label for="hl_4" class="header_bx fx w100">
				<div class="icon">
					<i class="fa fa-bookmark"></i>
				</div>
				<div class="title_bx fx v c">
					<div class="title">Events</div>
				</div>
			</label><!-- header_bx -->
			<div class="houseleader_box box fx w">

				<a class="hl_item fx" href="">
					<span class="icon">
						<i class="fa fa-file"></i>
					</span>
					<span class="title_bx fx v c">
						<span class="title">Event Process</span>
					</span>
				</a>

				<a class="hl_item fx" href="">
					<span class="icon">
						<i class="fa fa-file"></i>
					</span>
					<span class="title_bx fx v c">
						<span class="title">Event Ideas</span>
					</span>
				</a>

				<a class="hl_item fx" href="">
					<span class="icon">
						<i class="fa fa-file"></i>
					</span>
					<span class="title_bx fx v c">
						<span class="title">Event Pricing</span>
					</span>
				</a>

				<a class="hl_item fx" href="">
					<span class="icon">
						<i class="fa fa-list-ul"></i>
					</span>
					<span class="title_bx fx v c">
						<span class="title">Who’s Shit is This? Event Checklist</span>
					</span>
				</a>

			</div><!-- box -->
		</div><!-- hl_group -->

		*}
		

	</div><!-- houseleader_block -->
</div>



