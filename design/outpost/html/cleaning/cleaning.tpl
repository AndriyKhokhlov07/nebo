{* User (Guest) page *}
{$canonical="/cleaning" scope=parent}
{$apply_button_hide=1 scope=parent}
{$members_menu=1 scope=parent}
{$meta_title = "Cleaning" scope=parent}

{$js_include="design/`$settings->theme`/js/cleaning.js?v.1.1" scope=parent}

<div class="page_wrap">
    <div class="guest_home w100">
        <div class="technical_issues cleaning fx w w100">
            
            <div class="item user_bookings booking_invoices">
            	<div class="txt">
                    <div class="header_bx fx w w100">
                        <div class="title_bx fx v c">
                            <div class="title">Cleaning and maintenance</div>
                        </div><!-- title_bx -->
                    </div><!-- header_bx -->
                    {*<p>We’re here to help you make your home the best it can be!</p>
                    <p>Our cleaning team visits regularly to clean your house’s common areas, and it’s up to our members to follow house rules and make sure the house stays tidy between cleaning days. Gold members can also request a bedroom cleaning once a month, although for a limited time we’re opening this offer to all members.</p>
                    <p>Any member can submit a maintenance request, which will be addressed as soon as possible depending on the urgency of the request. While you’re provided with a brand new towel and bed set upon your arrival, you can purchase a new set at any time on this page if you need replacements.</p>*}
                    <p>Our cleaning team visits regularly to clean your house’s common areas, and it’s up to our members to follow house rules and make sure the house stays tidy between cleaning days. Gold members can also request a bedroom cleaning once a month for $29. Silver and Bronze members can request a cleaning for $39.</p>
                    <p>Any member can submit a maintenance request, which will be addressed as soon as possible depending on the urgency of the request. You can also purchase a new set of sheets and a towel for $29.99, or a full bedding set, including a mattress protector, sheets, a towel, pillows and a comforter for $59,99.</p>
            	</div>
        		<div class="box team center">
                    <div class="header_bx fx w w100">
                        <div class="title_bx fx v c">
                            <div class="title">Meet our Cleaners</div>
                        </div><!-- title_bx -->
                    </div><!-- header_bx -->
                    {if $cleaners}
                    <div class="fx ch4 w">
                        {foreach $cleaners as $cl}
                        <div>
                            <div class="img">
                                <img src="{$cl->image|resize:'user':300:300}" alt="{$cl->name}">
                            </div>
                            <p class="name"><strong>{$cl->name}</strong></p>
                        </div>
                        {/foreach}
                    </div>
                    {else}
            		<div class="fx ch4 w">
                        {*
    					<div>
                            <div class="img">
                                <img src="/design/{$settings->theme|escape}/images/Lakhicharan.jpg" alt="Dwayne">
                            </div>
                            <p class="name"><strong>Dwayne</strong></p>
                        </div>
                        *}
                        <div>
                            <div class="img">
                                <img src="/design/{$settings->theme|escape}/images/andrei.jpg" alt="Andrei">
                            </div>
                            <p class="name"><strong>Andrei</strong></p>
                        </div>
                        {*
                        <div>
                            <div class="img">
                                <img src="/design/{$settings->theme|escape}/images/Grimes.jpg" alt="John">
                            </div>
                            <p class="name"><strong>John</strong></p>
                        </div>
                        *}
					</div>
                    {/if}
				</div>	
                <div class="header_bx fx w w100">
                    <div class="icon">
                        <i class="fa fa-wrench"></i>
                    </div>
                    <div class="title_bx fx v c">
                        <div class="title">
                            Cleaning tracker
                            {if $user->house_id && $rooms[$user->house_id]}
                            | {$rooms[$user->house_id]->header|escape}
                            {/if}
                        </div>
                    </div><!-- title_bx -->
                </div><!-- header_bx -->
                <div class="box">

                    <table class="table_s">
                        <tr class="table_header">
							<th class="title">Date</th>
                            <th class="title">Type</th>
                            <th class="title">Price</th>
                            <th class="title">Photos (before/after)</th>
							<th class="title">Status</th>
						</tr>
                        {if $cleanings}
							{foreach $cleanings as $cl}
							<tr>
								<td><span>Desired date: </span>{$cl->desired_date}</td>
                                <td><span>Type: </span>{foreach $purchases[$cl->order_id] as $pur}{if $pur@iteration != 1}, <br>{/if}{$pur->product_name}{/foreach}</td>
                                <td><span>Price: </span>{$cl->total_price}</td>
                                <td><span>Photos: </span>
                                    {if $cl->images}
                                    <div class="images">
                                        {foreach $cl->images as $i}
                                            <a href="{$config->root_url}/{$config->cleaning_images_dir}{$i}" data-fancybox="f{$cl->id}">
                                                <img src="{$config->root_url}/{$config->cleaning_images_dir}{$i}" alt="">
                                            </a>
                                        {/foreach}
                                    </div>
                                    {/if}
                                </td>
								<td><span>Status: </span>
									{if $cl->status == 0}
									Waiting
									{else}
									Done
									{/if}
								</td>
							</tr>
							{/foreach}
                        {/if}
                    </table>
                </div><!-- box -->

            </div><!-- item  -->
            


            <div class="item">
                <div class="id" id="request_form"></div>
                <div class="header_bx fx w w100">
                    <div class="icon">
                        <i class="fa fa-bullhorn"></i>
                    </div>
                    <div class="title_bx fx v c">
                        <div class="title">New Cleaning Request</div>
                    </div><!-- title_bx -->
                </div><!-- header_bx -->
                <div class="box cleaning_form  hl_checklist">
                    <form method="post" enctype="multipart/form-data">

						<div class="input_block">
							<label class="req" for="first_name">Choose the date</label>
							<input type="text" name="desired_date" class="datepicker" required data-able="{foreach $cleaning_days as $cd name=cd}{if $smarty.foreach.cd.iteration != 1}, {/if}{if $cd->day > 0}+{/if}{$cd->day}{/foreach}">

						</div><!-- input_block -->
						<div class="input_block">
							<textarea name="comment" placeholder="Comment"></textarea>
						</div>
                        <div class="ch_item type_ch">
                            <input type="checkbox" name="price_cleaning" id="cleaning" value="{if $contract->membership==1}29.00{else}39.00{/if}" checked>
                            <div class="ch_bx">
                                <label for="cleaning" class="req" data-price="{if $contract->membership==1}29.00{else}39.00{/if}">
                                    Cleaning <span>{if $contract->membership==1}29.00{else}39.00{/if}</span>
                                </label>
                            </div>
                        </div>
                        <div class="ch_item type_ch radio sheet_towel">
                            <input type="checkbox" name="sheet_towel" id="sheet_towel" value="29.99">
                            <div class="ch_bx">
                                <label for="sheet_towel" class="req" data-price="29.99">
                                    Bed Sheet Set and Bath Towel <span>29.99</span>
                                </label>
                            </div>
                        </div>
                        <div class="ch_item type_ch radio sheet_towel_plus">
                            <input type="checkbox" name="sheet_towel_plus" id="sheet_towel_plus" value="59.99">
                            <div class="ch_bx">
                                <label for="sheet_towel_plus" class="req" data-price="59.99">
                                    Bed Sheet Set, Bath Towel, Comforter, Pillows, Mattress Protector <span>59.99</span>
                                </label>
                            </div>
                        </div>
						<div class="ch_item">
							<input type="checkbox" name="to_check" id="to_check" value="1" required>
							<div class="ch_bx">
								<label for="to_check" class="req red">
									<i>With this checkbox I allow to enter my bedroom/space to perform the needed services requested with this form.</i>
								</label>
							</div>
						</div>
                        <div class="price">
                            Total price: <span>{if $contract->membership==1}29.00{else}39.00{/if}</span><br>
                            <i>*Fee not refunded</i>
                        </div>
						<button class="button red" type="submit">Submit</button>
					</form>
                </div><!-- box -->
            </div><!-- item / user_files -->
            

        </div><!-- fx -->
    </div><!-- guest_home -->
</div><!-- page_wrap -->





