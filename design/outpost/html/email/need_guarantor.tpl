{$subject = "Request of guarantor" scope=parent}

<div style="background:#f2f2f2;width:100%;min-width:100%;padding: 40px 0">
<table cellpadding="0" cellspacing="0" border="0" align="center" width="600" style="max-width:96%; margin:0 auto !important;">
	<tr>
		<td style="padding: 0 30px 20px;">
			<a href="{$config->root_url}" target="_blank" style="display:block; margin:0 0 20px;">
				<img src="{$config->root_url}/design/{$settings->theme|escape}/images/logo_b.png" alt="{$settings->company_name}" width="190" height="28">
			</a>
			<p style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">P.O. 780316, 5502 69th St, <br>Maspeth NY, 11378</p>
			<p style="font: 100 14px/1.1 Helvetica; margin:0 0 7px;"><a style="color:#333; text-decoration:none;" href="tel:+18337076611" target="_blank">+1 (833) 707-6611</a></p>
			<p style="font: 100 14px/1.1 Helvetica; margin:0;"><a style="color:#333; text-decoration:none;" href="mailto:info@outpost-club.com" target="_blank">info@outpost-club.com</a></p>
		</td>
	</tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" align="center" style="background:#fff; border-radius: 5px; width:100%; box-shadow: 0 3px 15px rgba(0,0,0,.15);">
				<tr>
					<td colspan="4" style="padding: 40px 30px 20px;">
						<p style="color:#333; font: 500 26px/1 Helvetica; margin:0 0 15px;">Dear {$user->first_name},</p>
						<p style="color:#333; font: 100 16px/1.3 Helvetica; margin:0 0 15px;">Thank you for applying to Outpost Club and submitting your tenant application. After reviewing your application, we have concluded that we will only be able to accept you as a tenant with a guarantor application.</p>
						<p style="color:#333; font: 100 16px/1.3 Helvetica; margin:0 0 15px;">Please complete use the apply button below to specify who will be your guarantor, and their information.</p>
						<p style="color:#333; font: 100 16px/1.3 Helvetica; margin:0 0 15px;">If you would no longer like to continue the process of securing your spot at Outpost Club, please let us know by contacting the sales agent you have been speaking with.</p>
						<p style="color:#333; font: 100 16px/1.3 Helvetica; margin:0 0 15px;">Best,<br> The Outpost Club Team</p>
						<p style="color:#333; font: 100 16px/1.3 Helvetica; margin:0 0 15px;"></p>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="padding: 20px 30px 20px;">
						<a style="display:block; border-radius: 7px; background:#008f35; color:#fff; font:500 20px/1 Helvetica; text-align:center; text-transform:uppercase; text-decoration: none; padding: 17px 10px 15px; margin: 0 0 15px;" href="{$config->root_url}/user/add_guarantor/{$user->auth_code}/{$salesflow->id}">Apply</a>
					</td>
				</tr>
				<tr>
					<td style="padding: 0 30px 20px;">
						<p style="color:#333; font:500 12px/1 Helvetica;">
						If the button does not work for you, please use this link:<br> <a style="color:#333; font:500 15px/1 Helvetica;" href="{$config->root_url}/user/add_guarantor/{$user->auth_code}/{$salesflow->id}">{$config->root_url}/user/add_guarantor/{$user->auth_code}/{$salesflow->id}</a>
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

