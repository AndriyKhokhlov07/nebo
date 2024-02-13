{* Qira email template for customer *}
{$subject = "{$settings->company_name|escape} | Skip Your Security Deposit With Qira" scope=parent}

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
						<p style="color:#333; font: 500 26px/1 Helvetica; margin:0 0 15px;">Hello, {$user->first_name}</p>
						<p style="color:#333; font: 100 16px/1.3 Helvetica; margin:0 0 15px;">Outpost Club's partners at Qira have a great product that can save all our members a lot of money. For a small monthly fee, Qira will fund your security deposit for you.</p>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="padding: 20px 30px 20px;">
						
						<a style="display:block; border-radius: 7px; background:#008f35; color:#fff; font:500 20px/1 Helvetica; text-align:center; text-transform:uppercase; text-decoration: none; padding: 17px 10px 15px; margin: 0 0 15px;" href="{$config->root_url}/hellorented/{$notification->url}">Skip Your Security Deposit</a>
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
