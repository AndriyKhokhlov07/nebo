{* Contract email template for customer *}

{if $contract->type==3}
	{$membership_name=''}
{/if}

{$subject = "Request from Outpost Club: Start the process to secure your spot" scope=parent}
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
						<p style="color:#333; font: 500 29px/1 Helvetica; margin:0 0 15px;">Hey {$user->first_name},</p>
						{if $interval_days < 30}
							<p style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">The well-being of our guests is our top priority, and we're committed to providing a safe environment for members at all Outpost properties. To ensure this, we require each guest to complete a few steps prior to arrival. Your booking will not be complete until all steps below are completed:</p>
							<ol>
								<li style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">We will request your phone and email address to add you to the remote lock system and our maintenance portal.</li>
								<li style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 30px;">We will request a photo of the ID of each person that moves into the apartment/room</li>
							</ol>
						{else}
							<p style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">Please complete these steps to secure your spot at Outpost Club. If these steps are not completed within 24 hours, <strong>Outpost Club reserves the right to cancel your reserved spot until you’ve completed the steps.</strong></p>
							<p style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">Here is how to reserve your spot:</p>
							<ol>
								<li style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;"><strong>Fill out Rental Application:</strong> we will use the information that you provide for a background check.</li>
								<li style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;"><strong>Sign the House Rules:</strong> all tenants must sign this before entering the apartment.</li>
								{*<li style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;"><strong>Sign the COVID waiver:</strong> all tenants must sign this before entering the apartment.</li>*}
								<li style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;"><strong>Pay your security deposit:</strong> we will use the information that you provide for a background check.</li>
								<li style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;"><strong>Pay your first rent invoice:</strong> complete the payment using the payment options listed at your convenience.</li>
							</ol>
						{/if}
						<a href="{$config->root_url}/user/check/{$bg_check->url}{if $user->active_salesflow_id}?s={$user->active_salesflow_id}{/if}" target="_blank" style="display:block; border-radius: 7px; background:#008f35; color:#fff; font:500 20px/1 Helvetica; text-align:center; text-transform:uppercase; text-decoration: none; padding: 17px 10px 15px; margin: 0 0 20px;">Start the process</a>
						<p style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">If you have any questions, feel free to reply to this email, or call us at <a style="color:#444; font-weight:400; white-space:nowrap;" href="tel:+18337076611" target="_blank">+1 (833) 707-6611</a>.</p>
						<p style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">
							Best,<br>The Outpost Club Team</p>
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
