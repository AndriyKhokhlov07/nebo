{* Contract email template for customer *}

{if $contract->type==3}
	{$membership_name=''}
{/if}

{$subject = "Membership Agreement - Signature requested by Outpost Club Team" scope=parent}
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
						<p style="color:#333; font: 500 29px/1 Helvetica; margin:0 0 15px;">Dear {$user->name},</p>
						<p style="color:#333; font: 500 20px/1 Helvetica; margin:0 0 15px;">Thank you for accepting our offer to stay at Outpost Club. We're excited for your arrival!</p>
						<p style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">Please complete these steps to finalize your booking. If these steps are not completed within 24 hours, Outpost Club reserves the right to cancel your booking and nullify all completed steps. Here is how to complete your booking:</p>
						
						<p style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 20px;">Start your booking by clicking on this link:</p>
						<a style="display:block; border-radius: 7px; background:#008f35; color:#fff; font:500 20px/1 Helvetica; text-align:center; text-transform:uppercase; text-decoration: none; padding: 17px 10px 15px; margin: 0 0 20px;" href="{$config->root_url}/user/covid_form/{$user->auth_code}{if $contract != ''}?c={$contract->id}{/if}" target="_blank">Start</a>
						<ol>
							<li style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">Sign the COVID waiver</li>
							<li style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">Complete the background check</li>
							<li style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">Sign your contract</li>
							<li style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">Pay your first month's rent</li>
							<li style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;"><p>Pay your security deposit: Outpost Club has partnered with Qira to quickly and securely process security deposits. You have two ways of paying your security deposit through Qira:</p>
							<ol>
								<li>Skip your security deposit: Qira will pay your security deposit to Outpost Club for a setup fee of $45 and a monthly fee of around 1% of your total security deposit, depending on your risk level. Read more about it <a style="color:#444; font-weight:400; white-space:nowrap;" href="https://outpost-club.com/skip-your-security-deposit" target="_blank">here</a>.</li>
								<li>Pay your security deposit in-full to Qira: In order to quickly return your security deposit to you at the end of your stay, Qira also accepts Outpost Club's security deposits from tenants. By choosing this method, there are no additional fees, and you can choose it by skipping the first option.</li>
							</ol>
							</li>
							<li style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">Sign up for renters insurance: Outpost Club requires its new members to have renters insurance. Outpost partners with Sure, a renters insurance provider to make the process quick and easy. Once you sign up, this inexpensive service will follow you to all your future apartments.</li>
						</ol>
						<p style="color:#666;font:100 13px/1 Helvetica;">Once these five steps are completed, your booking is complete and you will receive a booking confirmation email. If you have any questions, feel free to reply to this email, or call us at <a style="color:#444; font-weight:400; white-space:nowrap;" href="tel:+18337076611" target="_blank">+1 (833) 707-6611</a>.</p>
						<p style="color:#666;font:100 13px/1 Helvetica;">Please note that your due date is included in your invoice. If we don’t receive payment on or before your due date, your booking will be canceled. Should you need more time to study the agreement or make a payment, please let us know the new date you will be comfortable with, and we will try our best to hold the room for you. You will receive an email with detailed instructions for your move-in once the above steps have been completed.</a>
						</p>
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
