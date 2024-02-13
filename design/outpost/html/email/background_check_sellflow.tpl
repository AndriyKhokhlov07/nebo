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
						<p style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">Please complete these steps to secure your spot at Outpost Club. If these steps are not completed within 24 hours, <strong>Outpost Club reserves the right to cancel your reserved spot until you’ve completed the steps.</strong></p>
						<p style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">Here is how to reserve your spot:</p>
						<ol>
							<li style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;"><strong>Fill out Rental Application:</strong> we will use the information that you provide for a background check</li>
							{if $interval_days >= 28 && !$is_airbnb_contract}

								<li style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;"><strong>Submit additional documents for verification:</strong> Outpost Club requires that you submit these documents depending on your status: employed (a), needing a guarantor (b), or an international student (c).
									
									<ol type="a" style="margin: 10px 0;">
										<li style="margin-bottom:5px">
											If you are employed, please provide copies of your:
											<ol>
												<li style="margin-top:5px">two most recent bank statements</li>
												<li style="margin-top:5px">three most recent pay stubs</li>
												<li style="margin-top:5px">tax return and/or W2</li>
											</ol>
										</li>
										<li style="margin-bottom:5px">
											If you need a guarantor, please let us know and we will send you a link for your guarantor to complete. They will need to provide copies of their:
											<ol>
												<li style="margin-top:5px">two most recent bank statements</li>
												<li style="margin-top:5px">three most recent pay stubs</li>
												<li style="margin-top:5px">tax return and/or W2</li>
											</ol>
										</li>
										<li style="margin-bottom:5px">
											If you are an international student, please provide copies of your:
											<ol>
												<li style="margin-top:5px">I-20 form from your university</li>
												<li style="margin-top:5px">student visa (J1, M1, F1)</li>
												<li style="margin-top:5px">passport page - needs to be your internationally recognized passport</li>
											</ol>
										</li>
									</ol>
								</li>

								{* house_id = 349 - Philadelphia The Mason on Chestnut *}
								{if !$is_airbnb_contract}
									<li style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;"><strong>Pay your {if $contract->house_id == 349}$99{else}$20{/if} application fee:</strong> In order to ensure that you have great roommates we have costs associated with your application.</li>
								{/if}
							{/if}
							{if !$is_airbnb_contract}
								<li style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;"><p><strong>Pay your security deposit:</strong> Outpost Club has partnered with Qira to quickly and securely process security deposits. You have two ways of paying your security deposit through Qira:</p>
									{if $contract->house_id != 349}
									<ol>
										<li style="margin-bottom:5px">Skip your security deposit: Qira will pay your security deposit to Outpost Club for a setup fee of $45 and a monthly fee of around 1% of your total security deposit, depending on your risk level. Read more about it <a style="color:#444; font-weight:400; white-space:nowrap;" href="https://outpost-club.com/skip-your-security-deposit" target="_blank">here</a>.</li>
										<li>Pay your security deposit in-full to Qira: in order to quickly return your security deposit to you at the end of your stay, Qira also accepts Outpost Club's security deposits from tenants. By choosing this method, there are no additional fees, and you can choose it by skipping the first option. <strong>Regardless of which option you choose, you must choose one of the two options above.</strong></li>
									</ol>
									{/if}
								</li>
							{/if}
						</ol>
						{if $is_airbnb_contract}
							<p style="color:#333;font:100 13px/1 Helvetica;">You will receive another email with instructions to sign a lease agreement{* and sign a COVID waiver*}.
							</p>
						{else}
							<p style="color:#333;font:100 13px/1 Helvetica;">Once we review your application and receive your security deposit, you will then receive another email with instructions to sign a lease agreement,{* sign a COVID waiver*}, pay your first month’s rent, and sign up for renters insurance.
							</p>
						{/if}
						<a href="{$config->root_url}/user/check/{$bg_check->url}{if $contract != ''}?c={$contract->id}{/if}" target="_blank" style="display:block; border-radius: 7px; background:#008f35; color:#fff; font:500 20px/1 Helvetica; text-align:center; text-transform:uppercase; text-decoration: none; padding: 17px 10px 15px; margin: 0 0 20px;">Start the process</a>
						<p style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">If you have any questions, feel free to reply to this email, or call us at <a style="color:#444; font-weight:400; white-space:nowrap;" href="tel:+18337076611" target="_blank">+1 (833) 707-6611</a>. If you need extra time to collect the funds to pay your security deposit, please let us know, but please keep in mind that your spot is not secured until you’ve completed this process.</p>
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
