{$canonical="/roommates" scope=parent}
{$apply_button_hide=1 scope=parent}
{$members_menu=1 scope=parent}

<div class="page_wrap">
	{if $guest->type != 2}
    <div class="guest_home w1200">
    	<h1 class="bold_h1">Roommates</h1>
		<div class="fx w w100">
			{if $guest->house}
				<div class="item house_info fx v">
					<div>
						<div class="icon">
						<i class="fa fa-home"></i>
					</div>
					<div class="cont">
						{if $guest->house}
			    		<div class="box">
							<div class="title">House</div>
								<p>
									{$guest->house->header}
								</p>
						</div><!-- box -->
						{/if}
						
						{if $guest->house->blocks2['address']}
			    		<div class="box">
							<div class="title">Address</div>
								<p>
									{$guest->house->blocks2['address']}
								</p>
						</div><!-- box -->
						{/if}
						{if $guest->apt}
			    		<div class="box">
			    			<div class="title">Apartment</div>
								<p>
									{$guest->apt->name}
								</p>
						</div><!-- box -->
						{/if}
					</div><!-- cont -->
					</div>
				</div><!-- item -->
			{/if}
    	</div><!-- fx -->
		{if $roommates}
			<div class="roommates_blocks ch4 fx w ">
				{foreach $roommates as $booking}
				{if $booking->users}
				{foreach $booking->users as $user}
				<div>
					<p class="title">
						{$user->name}
					</p>
					<p>
						{if $booking->bed}Bed {$booking->bed->name}{else}Full Apartment{/if}
					</p>
				</div><!-- box -->
				{/foreach}
				{/if}
				{/foreach}
			</div><!-- item / bookings -->
		{/if}

	</div>
   	{/if}
	{if $houses_rooms}
	<div class="w1200">
    	<h1 class="bold_h1">Roommates</h1>

		<div class="rooms_block">
			
				{foreach $houses_rooms as $house_id=>$apartments_ids}

					{if $houses_arr[$house_id]}
						<div class="house_title " data-house_id="{$house_id}"><i class="fa fa-home"></i> {$houses_arr[$house_id]->name|escape}</div>
						
						{foreach $apartments_ids as $apartment_id=>$rooms_ids}
						<div class="apartment_bx{if $apartment_id} apartment{/if}{if $rent_type == 2 && $apartments[$apartment_id]->rent_apartment} apartment_rent{/if}">
							{if $apartments[$apartment_id]}
								<div class="apartment_title red">
									{$apartments[$apartment_id]->name}
								</div>
							{/if}
							<div class="rooms_  fx w w100" data-house_id="{$house_id}">
								{foreach $rooms_ids as $room_id}
									{if $rooms[$room_id]}
										{$room = $rooms[$room_id]}

										{$bed_n=0}
										{if $room->beds}
											{$bed_n=$room->beds|first}
										{/if}

										<div class="room{if $room->beds|count>1 || is_array($bed_n)} multi{/if}">
											<div class="fx v sb">
											<div class="beds_bx fx w">
												{foreach $room->beds as $bed}
													{if is_array($bed)}
														<div class="bed_bx bed_group fx w">
															{foreach $bed as $b}
															<div class="bed floor_{$b->floor}{if !$beds_bookings[$b->id]} free{/if}">

																<div class="title">Bed: {$bed->name|escape}</div>
																{if $beds_bookings[$bed->id]}
																	<div class="journal_info">
																		{foreach $beds_bookings[$bed->id] as $j}
																			{if in_array($j->contract->type, [3, 7])}<div class="badge fm_lease">Non Coliving</div>{/if}
																			<div class="item red">
																				{foreach $j->users as $u}
																				{$u->name}{if !$u@last}, {/if}
																				{/foreach}
																			</div>
																		{/foreach}

																	</div>
																{/if}

															</div>
															{/foreach}
														</div><!-- bed_bx / bed_broup -->
													{else}
														<div class="bed_item bed_bx {if !$beds_bookings[$bed->id]} free{/if}">
															<div class="bed">
																<div class="title">Bed: {$bed->name|escape}</div>
																{if $beds_bookings[$bed->id]}
																	<div class="journal_info">
																		{foreach $beds_bookings[$bed->id] as $j}
																			{if in_array($j->contract->type, [3, 7])}<div class="badge fm_lease">Non Coliving</div>{/if}
																			<div class="item red">
																				{foreach $j->users as $u}
																				{$u->name}{if !$u@last}, {/if}
																				{/foreach}
																			</div>
																		{/foreach}

																	</div>
																{/if}
															</div>
														</div><!-- bed_bx -->
													{/if}
												{/foreach}
											</div><!-- beds -->
											</div>
										</div><!-- room -->
									{/if}
								{/foreach}
							</div><!-- rooms -->
							{if $apartments[$apartment_id]->rent_apartment}
							{if $apartments_bookings[$apartment_id]}
								<div class="room" style="width:100%;">
									<div class="bed_bx">
										<div class="bed">
											<div class="journal_info">
												{foreach $apartments_bookings[$apartment_id] as $j}
												<div class="title">Apartment booking{if in_array($j->contract->type, [3, 7])}<div class="badge fm_lease">Non Coliving</div>{/if}</div>
													<div class="item red">
														{foreach $j->users as $u}
														{$u->name}{if !$u@last}, {/if}
														{/foreach}
													</div>
												{/foreach}
											</div><!-- journal_info -->
										</div>
									</div>
								</div><!-- apartment_header -->
							{/if}
							{/if}
						</div><!-- apartment -->
						{/foreach}
					{/if}
				{/foreach}
		</div><!-- rooms_block -->

	</div><!-- guest_home -->
	{/if}

</div><!-- page_wrap -->
