{* Lafayette *}
{if $booking->house_id == 307}
	{$subject = "{$booking->house->loan_number|escape} / Common Clifton" scope=parent}
{else}
	{$subject = "{$settings->company_name|escape} | For Approval" scope=parent}
{/if}

<div style="background:#f2f2f2;width:100%;min-width:100%;padding: 40px 0">
<table cellpadding="0" cellspacing="0" border="0" align="center" width="600" style="max-width:96%; margin:0 auto !important;">
	<tr>
		<td style="padding: 0 30px 20px;">
			<a href="{$config->root_url}" target="_blank" style="display:block; margin:0 0 20px;">
				<img src="{$config->root_url}/design/{$settings->theme|escape}/images/logo_b.png" alt="{$settings->company_name}" width="190" height="28">
			</a>
			<p style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">P.O. 780316 Maspeth, NY, 11378</p>
			<p style="font: 100 14px/1.1 Helvetica; margin:0 0 7px;"><a style="color:#333; text-decoration:none;" href="tel:+18337076611" target="_blank">+1 (833) 707-6611</a></p>
			<p style="font: 100 14px/1.1 Helvetica; margin:0;"><a style="color:#333; text-decoration:none;" href="mailto:info@outpost-club.com" target="_blank">info@outpost-club.com</a></p>
		</td>
	</tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" align="center" style="background:#fff; border-radius: 5px; width:100%; box-shadow: 0 3px 15px rgba(0,0,0,.15);">
				<tr>
					<td colspan="4" style="padding: 40px 30px 20px;">
						<p style="color:#333; font: 500 26px/1 Helvetica; margin:0 0 15px;">Hey {$landlord->name|escape},</p>
						<p style="color:#333; font: 100 16px/1.3 Helvetica; margin:0 0 15px;">Our team has received an application for your property. Please review this applicant and the information they have provided to us.</p>
						

						{* Lafayette *}
						{if $booking->house_id == 307}

							<table style="color:#333; font: 500 16px/1.3 Helvetica; margin:20px 0 25px; width: 100%;" cellspacing=0 cellpadding=10>

								{if $booking->users}
								<tr>
									<td style="border-bottom: #ccc 2px solid; border-top: #ccc 2px solid;">{($booking->users|count)|plural:'Tenant':'Tenants'}:</td>
									<td style="border-bottom: #ccc 2px solid; border-top: #ccc 2px solid; font-weight: 800;">
										{foreach $booking->users as $u}
											{$u->name}
											{if !$u@last}<br>{/if}
										{/foreach}
									</td>
								</tr>
								<tr>
									<td colspan="2"></td>
								</tr>
								{/if}


								{if $booking->house->loan_number} 
								<tr>
									<td style="border-bottom: #ccc 1px solid; border-top: #ccc 2px solid;">Loan Number:</td>
									<td style="border-bottom: #ccc 1px solid; border-top: #ccc 2px solid; font-weight: 800;">{$booking->house->loan_number|escape}</td>
								</tr>
								{/if}
								<tr>
									<td style="border-bottom: #ccc 2px solid;">Property Name:</td>
									<td style="border-bottom: #ccc 2px solid; font-weight: 800;">{$booking->house->blocks2['address']|escape}</td>
								</tr>
								<tr>
									<td style="border-bottom: #ccc 2px solid;" colspan="2"></td>
								</tr>
								<tr>
									<td style="border-bottom: #ccc 1px solid;">Suite / Apartment Number:</td>
									<td style="border-bottom: #ccc 1px solid; font-weight: 800;">{$booking->apt->number|escape}</td>
								</tr>
								<tr>
									<td style="border-bottom: #ccc 1px solid;">Unit Type (Bed/Bathroom Count):</td>
									<td style="border-bottom: #ccc 1px solid; font-weight: 800;">{$booking->apt->note|escape}</td>
								</tr>

								{if $booking->bed}
								<tr>
									<td style="border-bottom: #ccc 1px solid;">Room Number:</td>
									<td style="border-bottom: #ccc 1px solid; font-weight: 800;">{$booking->bed->name|escape}</td>
								</tr>
								<tr>
									<td style="border-bottom: #ccc 1px solid;">Bathroom:</td>
									<td style="border-bottom: #ccc 1px solid; font-weight: 800;">
										{if $booking->room->labels[4]} {* Private bathroom *}
											Ensuite
										{else}
											Shared
										{/if}
									</td>
								</tr>
								
								{/if}

								{if $booking->room->square}
								<tr>
									<td style="border-bottom: #ccc 1px solid;">SF:</td>
									<td style="border-bottom: #ccc 1px solid; font-weight: 800;">{$booking->room->square*1}</td>
								</tr>
								{/if}
								<tr>
									<td style="border-bottom: #ccc 2px solid;">Renovated:</td>
									<td style="border-bottom: #ccc 2px solid; font-weight: 800;">Yes</td>
								</tr>
								<tr>
									<td style="border-bottom: #ccc 2px solid;" colspan="2"></td>
								</tr>
								<tr>
									<td style="border-bottom: #ccc 1px solid; font-weight: 800;" colspan="2">Terms:</td>
								</tr>
								<tr>
									<td style="border-bottom: #ccc 1px solid;">Rent (monthly):</td>
									<td style="border-bottom: #ccc 1px solid; font-weight: 800;">$ {$booking->price_month}</td>
								</tr>
								<tr>
									<td style="border-bottom: #ccc 1px solid;">Term:</td>
									<td style="border-bottom: #ccc 1px solid; font-weight: 800;">
										{if $booking->period->y}
											{$booking->period->y} {($booking->period->y)|plural:'year':'years'}
										{/if}
										{if $booking->period->m}
											{$booking->period->m} {($booking->period->m)|plural:'month':'months'}
										{/if}
										{if $booking->period->d}
											{$booking->period->d} {($booking->period->d)|plural:'day':'days'}
										{/if}
									</td>
								</tr>
								<tr>
									<td style="border-bottom: #ccc 1px solid;">Arrive / Depart:</td>
									<td style="border-bottom: #ccc 1px solid; font-weight: 800;">
										{$booking->arrive|date:'M j'}{if $booking->arrive|date:'Y' != $booking->depart|date:'Y'}, {$booking->arrive|date:'Y'}{/if}
										-
                            			{$booking->depart|date:'M j, Y'}
									</td>
								</tr>
								<tr>
									<td style="border-bottom: #ccc 2px solid;">Free Rent or Concessions:</td>
									<td style="border-bottom: #ccc 2px solid; font-weight: 800;">0 month</td>
								</tr>
							</table>
						{else}
						
						{if $booking->users}
						<p style="color:#333; font: 800 16px/1.3 Helvetica; margin:0 0 15px;">Tenant(s): {foreach $booking->users as $u}{$u->name}{if !$u@last}, {/if}{/foreach}</p>
						{/if}
						<p style="color:#333; font: 800 16px/1.3 Helvetica; margin:0 0 15px;">Arrive: {$booking->arrive|date}</p>
						<p style="color:#333; font: 800 16px/1.3 Helvetica; margin:0 0 15px;">Depart: {$booking->depart|date}</p>
						<p style="color:#333; font: 800 16px/1.3 Helvetica; margin:0 0 15px;">Price per month: {$booking->price_month}</p>
						<p style="color:#333; font: 800 16px/1.3 Helvetica; margin:0 0 15px;">Total price: {$booking->total_price}</p>
						<p style="color:#333; font: 800 16px/1.3 Helvetica; margin:0 0 15px;">Apartment: {$booking->apt->name}</p>
						<p style="color:#333; font: 800 16px/1.3 Helvetica; margin:0 0 15px;">{if $room_type}Room type: {$room_type->name}{else}Full apartment booking{/if}</p>
						{if $booking->bed}
							<p style="color:#333; font: 800 16px/1.3 Helvetica; margin:0 0 15px;">Room: {$booking->bed->name}</p>
						{/if}


						{/if}
						



						<p style="color:#333; font: 100 16px/1.3 Helvetica; margin:0 0 15px;">Once you have reviewed the applicants credentials, please “Accept” “Reject” or “Request more info” so that we can proceed with the applicant. If you choose to “Request more info” please let us know exactly what info is missing so that our team can retrieve it from the applicant.</p>
						<p style="color:#333; font: 100 16px/1.3 Helvetica; margin:0 0 15px;">Your speedy response is appreciated; the quicker we know what to do, the quicker we can increase the performance of your property!</p>
						<p style="color:#333; font: 100 16px/1.3 Helvetica; margin:0;">Thank you in advance,<br> The Outpost Club Team</p>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="padding: 20px 30px 20px;">
						<a style="display:block; border-radius: 7px; background:#008f35; color:#fff; font:500 20px/1 Helvetica; text-align:center; text-transform:uppercase; text-decoration: none; padding: 17px 10px 15px; margin: 0 0 15px;" href="{$config->root_url}/landlord/approve/{$salesflow_id}" target="_blank">Review</a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td style="padding: 15px 30px 20px;">
			{include file="file:{$smarty.current_dir}/bx/footer.tpl"}
		</td>
	</tr>
</table>
</div>
