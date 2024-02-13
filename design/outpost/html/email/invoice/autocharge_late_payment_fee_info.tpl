{* Urgent Payment Required: Late Payment Fee Applicable *}

{$subject = "Urgent Payment Required: Late Payment Fee Applicable" scope=parent}

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
							We hope this email finds you well.
						</p>
						<p style="color:#333; font: 100 14px/1.2 Helvetica; margin:0 0 7px;">
							Regrettably, we encountered an issue while processing the payment, and we were unable to charge the amount from your designated payment account. It is crucial that you take immediate action to resolve this matter to avoid any further complications.
						</p>
						<p style="color:#333; font: 100 14px/1.2 Helvetica; margin:0 0 7px;">
							<span style="font-weight: 400">We kindly request your immediate attention to the following steps:</span>
						<ol style="color:#333; font: 100 14px/1.2 Helvetica; padding: 0 0 0 20px; margin:0 0 7px;">
							<li style="margin-bottom: 7px">
								<span style="font-weight: 400">Verify Bank Account:</span> Please ensure that there are sufficient funds available in your bank account to cover the payment. We recommend contacting your bank to address any potential issues or discrepancies.
							</li>
							<li>
								<span style="font-weight: 400">Payment via Invoice:</span> As an alternative payment method, we have prepared an invoice for the outstanding amount. To access the invoice and proceed with the payment, please click on the following link:
								<a href="{$config->root_url}/order/{$order->url}?u={$user->id}&w=1&pm=a" target="_blank">{$config->root_url}/order/{$order->url}?u={$user->id}&w=1&pm=a</a>
							</li>
						</ol>
						</p>
						<p style="color:#333; font: 100 14px/1.2 Helvetica; margin:0 0 7px;">
							Please note that due to the delayed payment, a late payment fee will be added to the outstanding amount. To avoid incurring any further charges, we urge you to resolve this matter promptly.
						</p>
						<p style="color:#333; font: 100 14px/1.2 Helvetica; margin:0 0 7px;">
							If you require any assistance or have questions regarding this issue, please do not hesitate to reach out to us.
						</p>
						<p style="color:#333; font: 100 14px/1.2 Helvetica; margin:0 0 60px;">
							Thank you for your immediate action. We value your tenancy and look forward to resolving this situation as soon as possible.
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
