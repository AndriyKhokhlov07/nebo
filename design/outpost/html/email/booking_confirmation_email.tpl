{* Contract email template for customer *}

{if $contract->type==3}
	{$membership_name=''}
{/if}

{$subject = "{$settings->company_name|escape} | Booking confirmation" scope=parent}
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
						<p style="color:#333; font: 500 29px/1 Helvetica; margin:0 0 15px;">Dear {$user->first_name},</p>
						<p style="color:#333; font: 400 14px/1.1 Helvetica; margin:0 0 25px;">Thank you for completing the steps to secure your spot at {$house->header} powered by Outpost Club. We confirm your payments as summarized below:</strong></p>
						<p style="color:#333; font: 600 14px/1.1 Helvetica; margin:0 0 7px;"><strong>MEMBER: {$user->first_name} {$user->last_name}</strong></p>
						<p style="color:#333; font: 400 14px/1.1 Helvetica; margin:0 0 7px;">Move-in date: <strong>{$booking->arrive|date} from 3 p.m. to 9 p.m.</strong></p>
						<p style="color:#333; font: 400 14px/1.1 Helvetica; margin:0 0 7px;">Move-out date: <strong>{$booking->depart|date} from 8 a.m. to 11 a.m.</strong></p>
						{*<p style="color:#333; font: 400 14px/1.1 Helvetica; margin:0 0 7px;">Number of Tenants: 1</p>*}

						<p style="color:#333; font: 400 14px/1.1 Helvetica; margin:20px 0 7px;">
							
							{if $house->type == 1} {* Hotel *}
								{* Accommodation: <strong>Private Room</strong> *}
							{else}
								Accommodation type: <strong>1-2-3-4 person stay room</strong>
							{/if}
						</p>
						{if $house->type!=1}
							<p style="color:#333; font: 400 14px/1.1 Helvetica; margin:0 0 7px;">Property: <strong>{$bed->name}</strong></p>
						{/if}
						<p style="color:#333; font: 400 14px/1.1 Helvetica; margin:0 0 7px;">Address: <strong>{$house->blocks2['address']}</strong></p>

						{if $invoices}
						<p style="color:#333; font: 600 14px/1.1 Helvetica; margin:20px 0 7px;"><strong>BOOKINGS SCHEDULE:</strong></p>
						{foreach $invoices as $inv}
						<p style="color:#333; font: 400 14px/1.1 Helvetica; margin:0 0 7px;">Booking #{$inv->sku}: <strong>{$inv->date_from|date} - {$inv->date_to|date}</strong> ({$inv->nights} {$inv->nights|plural:'night':'nights'})</p>
						{/foreach}
						{/if}

						<p style="color:#333; font: 600 14px/1.1 Helvetica; margin:20px 0 7px;"><strong>SUMMARY of PAYMENTS:</strong></p>
						<p style="color:#333; font: 400 14px/1.1 Helvetica; margin:0 0 7px;">Booking {$first_month_invoice->sku}{if $house->type == 1}: <strong>{$first_month_invoice->total_price|convert} USD</strong>{/if}</p>

						<p style="color:#333; font: 400 14px/1.1 Helvetica; margin:0 0 7px;">The remaining balance of Taxes (Occupancy Tax $2.00/day) will be charged upon arrival.</p>

						
						{if $salesflow->type == 3}
							<p style="color:#333; font: 400 14px/1.1 Helvetica; margin:0 0 7px;">Refundable Deposit Paid: <strong>{if $house->type == 1}1000{else}400{/if} USD</strong></p>
						{/if}
						{if $house->type!=1}
							<p style="color:#333; font: 400 14px/1.1 Helvetica; margin:0 0 7px;">$79 Linens Fee: PAID / NOT APPLICABLE</p>
						{/if}

						<p style="color:#333; font: 600 14px/1.1 Helvetica; margin:20px 0 20px; text-align: center;"><strong>******** IMPORTANT. TAKE THE FOLLOWING ACTIONS ************</strong></p>

						<p style="color:#333; font: 400 14px/1.1 Helvetica; margin:7px 0 7px;">We have no full-time reception, so you’ll need to set up a move-in time in advance to make sure your move-in goes seamlessly:</p>
						<p style="color:#333; font: 400 14px/1.1 Helvetica; margin:0 0 7px;">Please provide your <strong>expected arrival time and travel details</strong> (flight number, port of arrival, bus/train/route information) to <a style="color:#444; font-weight:400" href="mailto:customer.service@outpost-club.com" target="_blank">customer.service@outpost-club.com</a>. If your expected arrival to the property changes by more than 1 hour, please inform us in advance via email, text or call. <strong>Our regular move-in time is from 3 p.m. to 9 p.m.</strong></p>
						<p style="color:#333; font: 400 14px/1.1 Helvetica; margin:0 0 7px;">Evening move-in (after 9 p.m.) may be also accommodated for an extra fee of $30 USD. <strong>We can't guarantee move-in between 12 a.m. and 9 a.m.;</strong> however, if we are able to do it, there will be a $70 late move-in fee. Early move-in (10 a.m. to 3 p.m.) may also be possible, subject to availability. <strong>We’ll reach out 2–3 days before your arrival with all the info you’ll need to get settled in, including the name and number of the person you’ll need to call to get in.</strong></p>

						<p style="color:#333; font: 600 14px/1.1 Helvetica; margin:20px 0 20px; text-align: center;"><strong>ARRIVAL TERMS:</strong></p>

						<ol>
							<li style="color:#333; font: 400 14px/1.1 Helvetica; margin:0 0 7px;">You’ll meet our House Leader at the address listed above.</li>
							<li style="color:#333; font: 400 14px/1.1 Helvetica; margin:0 0 7px;">Be aware that if you have a non-US phone number, you may not have service to reach us when you arrive.</li>
							<li style="color:#333; font: 400 14px/1.1 Helvetica; margin:0 0 7px;">We’ll give you keys or electronic access upon move-in.</li>
							<li style="color:#333; font: 400 14px/1.1 Helvetica; margin:0 0 7px;">Please provide your expected arrival time as soon as you know it, but no later 48 hours before your arrival, to <a style="color:#444; font-weight:400" href="mailto:customer.service@outpost-club.com" target="_blank">customer.service@outpost-club.com</a></li>
							<li style="color:#333; font: 400 14px/1.1 Helvetica; margin:0 0 7px;">We require a photo ID during move-in. <strong>The name on this confirmation email must match the ID.</strong></li>
							{*<li style="color:#333; font: 400 14px/1.1 Helvetica; margin:0 0 7px;">Depending on where you are coming from, you may be subject to state or local laws regarding COVID-19. It is your responsibility to know and abide by local laws when you arrive at Cassa Studios.</li>*}
						</ol>

						<p style="color:#333; font: 600 14px/1.1 Helvetica; margin:20px 0 20px; text-align: center;"><strong>Transportation and Timing:</strong></p>

						<p style="color:#333; font: 400 14px/1.1 Helvetica; margin:7px 0 7px;">From JFK, LGA, EWR:</p>
						<ol>
							<li style="color:#333; font: 400 14px/1.1 Helvetica; margin:0 0 7px;">By PUBLIC transportation (bus/train, subway) to Brooklyn locations: 60-80 minutes.</li>
							<li style="color:#333; font: 400 14px/1.1 Helvetica; margin:0 0 7px;">By TAXI: 30-45 min</li>
						</ol>
						<p style="color:#333; font: 400 14px/1.1 Helvetica; margin:0 0 7px;"><a style="color:#444; font-weight:400; white-space:nowrap;" href="http://tripplanner.mta.info/" target="_blank">Visit the MTA’s site to plan your route.</a></p>


						<p style="color:#333; font: 400 14px/1.1 Helvetica; margin:20px 0 20px;">We look forward to welcoming you to New York City!</p>


						<div style="text-align: center;">
							<a style="color:#444; font: 400 14px/1.1 Helvetica; display: inline-block; padding: 0 15px; border-right: 1px solid #ccc;" href="https://ne-bo.com/move-in-faq#move_in" target="_blank">Moving In</a>
							<a style="color:#444; font: 400 14px/1.1 Helvetica; display: inline-block; padding: 0 15px; border-right: 1px solid #ccc;" href="https://ne-bo.com/move-in-faq#faq" target="_blank">Check in FAQ</a>
							<a style="color:#444; font: 400 14px/1.1 Helvetica; display: inline-block; padding: 0 15px;" href="https://ne-bo.com/move-in-faq#cancelation_policy" target="_blank">Cancelation Policy</a>
						</div>
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
