{* User (Guest) page *}
{$canonical="/user" scope=parent}
{$apply_button_hide=1 scope=parent}


<div class="page_wrap">
    <div class="guest_home w1200">
		<div class="fx w w100">

			{if $guest->main_info}
	    	<div class="item user_info">
	    	<form method="post">
				<input type="checkbox" name="change_password" id="change_password">
	    		<div class="header_bx fx w w100">
	    			<div class="icon">
	    				<i class="fa fa-user-circle-o"></i>
	    			</div>
	    			<div class="title_bx fx v c">
	    				<div class="title">{$guest->main_info['name']}</div>
	    				<div class="options_line">
	    					<a class="logout" href="user/logout/">Logout <i class="fa fa-sign-out"></i></a>
							<label for="change_password">Change password</label>
	    				</div>
	    			</div>
	    		</div>
	    		<div class="inp_bx new_password">
                    <input class="inp" type="password" name="password" placeholder="New password" value="">
                    <i class="fa fa-unlock-alt"></i>
                    <button type="submit"><i class="fa fa-arrow-right"></i></button>
                </div><!-- inp_bx -->
				
				{*
				{if $guest->main_info['address']}
					<div class="box">
						<div class="title">Address</div>
						{if $guest->main_info['address']['country'] || $guest->main_info['address']['city']}
							<p>
								{if $guest->main_info['address']['country']}
									{$guest->main_info['address']['country']}<br>
								{/if}
								{$guest->main_info['address']['city']}
							</p>
						{/if}
					</div><!-- box -->
				{/if}
				*}

				<div class="box">
					<div class="title">Email</div>
					<p>{$user->email}</p>
				</div><!-- box -->
				
				{if $guest->main_info['phones']}
					<div class="box">
						<div class="title">Phones</div>
						<p>
							{foreach $guest->main_info['phones'] as $phone}
								{if $rp@iteration > 1}<br>{/if}
								{$phone}
							{/foreach}
						</p>
					</div><!-- box -->
				{elseif $guest->main_info['phone']}
					<div class="box">
						<div class="title">Phone</div>
						<p>{$guest->main_info['phone']}</p>
					</div><!-- box -->
				{/if}

			</form>
	    	</div><!-- item / user_info -->
	    	{elseif $user}
	    		<div class="item user_info">
			    	<form method="post">
						<input type="checkbox" name="change_password" id="change_password">
			    		<div class="header_bx fx w w100">
			    			<div class="icon">
			    				<i class="fa fa-user-circle-o"></i>
			    			</div>
			    			<div class="title_bx fx v c">
			    				<div class="title">{$user->name}</div>
			    				<div class="options_line">
			    					<a class="logout" href="user/logout/">Logout <i class="fa fa-sign-out"></i></a>
									<label for="change_password">Change password</label>
			    				</div>
			    			</div>
			    		</div>
			    		<div class="inp_bx new_password">
		                    <input class="inp" type="password" name="password" placeholder="New password" value="">
		                    <i class="fa fa-unlock-alt"></i>
		                    <button type="submit"><i class="fa fa-arrow-right"></i></button>
		                </div><!-- inp_bx -->
		                <div class="box">
							<div class="title">Email</div>
							<p>{$user->email}</p>
						</div><!-- box -->
					</form>
	    		</div><!-- item / user_info -->
	    	{/if}

	    	{if $guest->booking_invoices}
			<div class="item user_bookings booking_invoices">
				<div class="header_bx fx w w100">
					<div class="icon">
						<i class="fa fa-tags"></i>
					</div>
					<div class="title_bx fx v c">
	    				<div class="title">Billing & Payments</div>
	    			</div><!-- title_bx -->
				</div><!-- header_bx -->
				<div class="box">
					<table class="table_s">
						<tr>
							<th>Created</th>
							<th>ID</th>
							<th>Description</th>
							<th>Total</th>
							<th>Status</th>
							<th></th>
						</tr>
						{foreach $guest->booking_invoices as $bi}
							<tr>
								<td>
									{$bi['created']|date_format:'%d-%b-%y'}<br>
									{$bi['created']|date_format:'%I:%M %p'}
								</td>
								
								<td>
									{$bi['invoice_num']}
								</td>
								<td>
									{foreach $bi['invoice_items'] as $i}
										{if $i['description']}
											<span class="invoice_desc">{$i['description']}</span>
										{/if}
									{/foreach}
								</td>
								<td>
									{$sum = 0}
									{foreach $bi['invoice_items'] as $i}
										{$sum = $sum + ( (($i['unitCost'] * $i['qty']) + $i['discount']) * $i['percent'])}
									{/foreach}
									{money_format('%(#10n', $sum)}
									<br>
									<a class="more_inv" href="https://invoices.tokeet.com/invoice/guest/{$bi['created']}/{$bi['invoice_num']}/{$bi['pkey']}/{$bi['public_key']}/{$guest->tokeet_account}" target="_blank">Show detail</a>
								</td>
								<td>
									{if $bi['status'] == 0}
										New
									{elseif $bi['status'] == 1}
										Unpaid
									{elseif $bi['status'] == 2}
										Paid
									{elseif $bi['status'] == -1}
										Canceled
									{/if}
								</td>
								<td>

									{if $bi['status'] == 0 || $bi['status'] == 1}
										<a class="button_red" href="https://invoices.tokeet.com/invoice/guest/{$bi['created']}/{$bi['invoice_num']}/{$bi['pkey']}/{$bi['public_key']}/{$guest->tokeet_account}" target="_blank">Pay</a>
									{/if}
								</td>
							</tr>
						{/foreach}
					</table>
				</div><!-- box -->
			</div><!-- item / bookings -->
			{/if}

	    	{if $guest->bookings}
			<div class="item user_bookings">
				<div class="header_bx fx w w100">
					<div class="icon">
						<i class="fa fa-bookmark"></i>
					</div>
					<div class="title_bx fx v c">
	    				<div class="title">Bookings</div>
	    			</div><!-- title_bx -->
				</div><!-- header_bx -->
				<div class="box">
					<table class="table_s">
						<tr>
							<th>Rental</th>
							<th>Arrive</th>
							<th>Depart</th>
							<th>Nights</th>
							<th>Guests</th>
							<th>Booking Charges</th>
						</tr>
						{foreach $guest->bookings as $booking}
							{$date_from = $booking['guest_arrive']}
							{$date_to = $booking['guest_depart']}
							{$datediff = ($date_to - $date_from) / (60 * 60 * 24)}
							<tr>
								<td>
									<div class="rental_title">{$booking['rental']['name']}</div>
									{if $booking['rental']['address']}
										<div class="rental_address">
											{$booking['rental']['address']['address']}, 
											{$booking['rental']['address']['city']},
											{$booking['rental']['address']['state']}
										</div>
									{/if}
								</td>
								<td>{$date_from|date_format:'%a %b %d, %Y'}</td>
								<td>{$date_to|date_format:'%a %b %d, %Y'}</td>
								<td>{$datediff}</td>
								<td>
									{$booking['num_adults'] + $booking['num_child']}
									{if $booking['num_child']}
										<br>
										<span class="adults_info">
										{$booking['num_adults']} {$booking['num_adults']|plural:'adult':'adults'}, {$booking['num_child']} {$booking['num_child']|plural:'children':'childrens'}
										</span>
									{/if}
								</td>
								<td class="booking_charges">
									<input type="checkbox" id="b_{$booking@iteration}">
									{if $booking['cost']->charge == 0 && $booking['cost']->userCharge > 0}
										<table>
											<tr><td>Base Charge:</td><td>{money_format('%(#10n', $booking['cost']->userCharge)}</td></tr>
											<tr><td>Discounts & Fees:</td><td>{money_format('%(#10n', $booking['cost']->feeSum)}</td></tr>
											<tr><td>Taxes:</td><td>{money_format('%(#10n', $booking['cost']->taxes)}</td></tr>
											<tr><td>Total:</td><td>{money_format('%(#10n', $booking['cost']->userCharge)}</td></tr>
										</table>
									{else}
									<table>
										<tr><td>Base Charge:</td><td>{money_format('%(#10n', $booking['cost']->charge)}</td></tr>
										<tr><td>Discounts & Fees:</td><td>{money_format('%(#10n', $booking['cost']->feeSum)}</td></tr>
										<tr><td>Taxes:</td><td>{money_format('%(#10n', $booking['cost']->taxes)}</td></tr>
										<tr><td>Total:</td><td>{money_format('%(#10n', $booking['cost']->sum)}</td></tr>
									</table>
									{/if}
									<label for="b_{$booking@iteration}"><span>Show detail</span><span>Hide detail</span></label>
								</td>
							</tr>
						{/foreach}
					</table>
				</div><!-- box -->
			</div><!-- item / bookings -->
			{/if}


			


			{if $guest->main_info['files']}
			<div class="item user_bookings user_files">
				<div class="header_bx fx w w100">
					<div class="icon">
						<i class="fa fa-file"></i>
					</div>
					<div class="title_bx fx v c">
	    				<div class="title">Files</div>
	    			</div><!-- title_bx -->
				</div><!-- header_bx -->
				<div class="box">
					<div class="files fx w">
					{foreach $guest->main_info['files'] as $f}
						<a class="file fx v" href="{$f['url']}" data-fancybox>
							{if $f['type'] == 'application/pdf'}
								<i class="fa fa-file-pdf-o"></i>
							{elseif $f['type'] == 'image/jpeg' || $f['type'] == 'image/png'}
								<i class="fa fa-file-image-o"></i>
							{else}
								<i class="fa fa-file-o"></i>
							{/if}
							<span class="name" data-tooltip="{$f['name']}"><i>{$f['name']}</i></span>
							<span class="size">{round($f['size']/1024 /1024, 2)} MB</span>
						</a>
					{/foreach}
					</div><!-- files -->
				</div><!-- box -->
			</div><!-- item / user_files -->
			{/if}

			<div class="item">
				<div class="header_bx fx w w100">
					<div class="icon">
						<i class="fa fa-bookmark"></i>
					</div>
					<div class="title_bx fx v c">
	    				<div class="title">New Technical Request</div>
	    			</div><!-- title_bx -->
				</div><!-- header_bx -->
				<div class="box">
					{literal}
					<!--[if lte IE 8]>
					<script charset="utf-8" type="text/javascript" src="//js.hsforms.net/forms/v2-legacy.js"></script>
					<![endif]-->
					<script charset="utf-8" type="text/javascript" src="//js.hsforms.net/forms/v2.js"></script>
					<script>
					hbspt.forms.create({
					portalId: "4068949",
					formId: "4bfb8920-65c7-4de6-b9be-7ecaceaa8ab6"
					});
					</script>
					{/literal}
				</div><!-- box -->
			</div><!-- item / user_files -->



    	</div><!-- fx -->


	</div><!-- guest_home -->
</div><!-- page_wrap -->
