{* Contract email template for customer *}

{if $contract->type==3}
	{$membership_name=''}
{/if}

{$subject = "Request from Outpost Club: Complete the process of securing your spot" scope=parent}
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
						<p style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">
							Thank you for submitting your rental application
							{if !$is_airbnb_contract} and paying your security deposit{/if}. 
							Please follow these steps to complete the process of reserving your spot.
						</p>
						<p style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">Here is how to reserve your spot:</p>
						<ol>
							<li style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;"><strong>Sign your lease agreement:</strong> please review your lease agreement and sign where indicated.
							{if $contract->house_id == 349} {* Philadelphia | The Mason on Chestnut  *}
								<br>
								To comply with City of Philadelphia regulations, your signed lease will include these documents, which you can find here: <a href="https://bit.ly/3mL9EYx">https://bit.ly/3mL9EYx</a>
							{/if}
							</li>
							{*<li style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;"><strong>Sign the COVID waiver:</strong> all tenants must sign this before entering the apartment.</li>*}
							{if !$is_airbnb_contract}
								<li style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;"><strong>Pay your first month's rent:</strong> complete the payment using the payment options listed at your convenience.</li>
								<li style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;"><strong>Sign up for renters insurance:</strong> Outpost Club requires its new members to have renters insurance. Outpost partners with Sure, a renters insurance provider to make the process quick and easy. Once you sign up, this inexpensive service will follow you to all your future apartments. It costs around $15/month.</li>
							{/if}
						</ol>
						<a href="{$config->root_url}/contract/{$contract->url}/{$user->id}?w=1" target="_blank" style="display:block; border-radius: 7px; background:#008f35; color:#fff; font:500 20px/1 Helvetica; text-align:center; text-transform:uppercase; text-decoration: none; padding: 17px 10px 15px; margin: 0 0 20px;">Continue the process</a>
						<p style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">If you have any questions, feel free to reply to this email, or call us at <a style="color:#444; font-weight:400; white-space:nowrap;" href="tel:+18337076611" target="_blank">+1 (833) 707-6611</a>. If you need extra time to collect the funds to pay your security deposit, please let us know, <strong>but please keep in mind that your spot is not secured until you’ve completed this process.</strong> Once these steps are completed, your spot is secure and you will receive a payment confirmation email.</p>
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
