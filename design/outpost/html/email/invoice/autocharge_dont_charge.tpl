{* Payment Update: Action Required *}

{$subject = "Payment Update: Action Required" scope=parent}

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
						<p style="color:#333; font: 500 29px/1 Helvetica; margin:0 0 15px;">Dear {$user->first_name|escape},</p>
						<p style="color:#333; font: 100 14px/1.2 Helvetica; margin:0 0 7px;">
							We hope this email finds you well.  Unfortunately, we encountered an issue while processing the payment, and we were unable to charge the amount from your designated payment account. We kindly request your attention to ensure that sufficient funds are available in your bank account.
						</p>
						<p style="color:#333; font: 100 14px/1.2 Helvetica; margin:0 0 7px;">
							<span style="font-weight: 400">To rectify this matter, please take the following steps:</span>
							<ol style="color:#333; font: 100 14px/1.2 Helvetica; padding: 0 0 0 20px; margin:0 0 7px;">
								<li style="margin-bottom: 7px"><span style="font-weight: 400">Verify Sufficient Funds:</span> Please double-check your bank account balance to ensure that there are enough funds to cover the payment. In case of any discrepancies, please contact your bank to address the issue.
								</li>
								<li><span style="font-weight: 400">Payment via Invoice:</span> If you prefer an alternative payment method, we have generated an invoice for the outstanding amount. You can access the invoice by clicking on the following link: <a href="{$config->root_url}/order/{$order->url}?u={$user->id}&w=1&pm=a" target="_blank">{$config->root_url}/order/{$order->url}?u={$user->id}&w=1&pm=a</a></li>
							</ol>
						</p>
						<p style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">
							We kindly request that you take prompt action to either resolve any banking issues or proceed with payment using the provided invoice.
						</p>
						<p style="color:#333; font: 100 14px/1.2 Helvetica; margin:0 0 60px;">
							Thank you for your cooperation and understanding.
						</p>
						<p style="color:#333; font: 100 14px/1.2 Helvetica; margin:0 0 20px;">
							Sincerely,<br>
							The Outpost Club
						</p>
						<p style="color:#333; font: 100 13px/1.2 Helvetica; margin:0 0 7px;">
							If you have any questions, please contact us at <a style="color:#444; font-weight:400; white-space:nowrap;" href="mailto:customer.service@outpost-club.com" target="_blank">customer.service@outpost-club.com</a>.
						</p>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td style="padding: 15px 30px 20px;">
			{include file="file:{$smarty.current_dir}/../bx/footer.tpl"}
		</td>
	</tr>
</table>
</div>
