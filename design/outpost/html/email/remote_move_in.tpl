{$subject="{$settings->company_name|escape} | Move in" scope=parent}
{if $subject_}
	{$subject = $subject_ scope=parent}
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
						<p style="color:#333; font: 500 29px/1 Helvetica; margin:0 0 15px;">Hey {$user->first_name},</p>
						<p style="color:#333; font: 300 15px/1 Helvetica; margin:0 0 15px;">This is <strong style="font-weight: 500">{if $houseleader}{$houseleader->name}{else}[HOUSELEADER NAME]{/if}</strong> with Outpost Club I'll be helping you during your move-in. Unfortunately, I won’t be home at the time of your arrival, but I’ll be sure to get you inside! We’ll meet up later to complete the move in process, but for now I’ll give you some information here.</p>
						<p style="color:#333; font: 300 15px/1 Helvetica; margin:0 0 15px;">First, please let me know the right time of your arrival if it has changed. We’re expecting you to arrive at <strong style="font-weight: 500">{$user->current_booking->arrive|date}</strong>.</p>
						<p style="color:#333; font: 500 18px/1 Helvetica; margin:0 0 15px;">Here is the info to get in</p>
						<p style="color:#333; font: 300 15px/1 Helvetica; margin:0 0 15px;">Front door code: <strong style="font-weight: 500">{$user->house->blocks2['door_code']}</strong></p>
						<p style="color:#333; font: 300 15px/1 Helvetica; margin:0 0 15px;">Indoor Code: <strong style="font-weight: 500">{$user->house->blocks2["a_{$user->current_booking->apartment_id}_code"]}</strong></p>
						<p style="color:#333; font: 300 15px/1 Helvetica; margin:0 0 15px;">How can you find your room: <strong style="font-weight: 500">{$user->current_apt->name}{if $user->current_bed}, {$user->current_bed->name}{/if}</strong></p>
						<p style="color:#333; font: 300 15px/1 Helvetica; margin:0 0 15px;">The access to apartment is through August lock you will receive an invitation to download it.</p>
						<p style="color:#333; font: 500 18px/1 Helvetica; margin:0 0 15px;">Internet</p>
						<p style="color:#333; font: 300 15px/1 Helvetica; margin:0 0 15px;">Network Name: <strong style="font-weight: 500">Outpost Club</strong></p>
						<p style="color:#333; font: 300 15px/1 Helvetica; margin:0 0 15px;">Password: <strong style="font-weight: 500">{$user->house->blocks2['wifi_password']}</strong></p>
						<p style="color:#333; font: 500 18px/1 Helvetica; margin:0 0 15px;">Documents</p>
						<p style="color:#333; font: 300 15px/1 Helvetica; margin:0 0 15px;">Use this link <a href="https://ne-bo.com/doc-upload/{$user->auth_code}" target="_blank">https://ne-bo.com/doc-upload/{$user->auth_code}</a> to fill the information and upload your document</p>
						<p style="color:#333; font: 300 15px/1 Helvetica; margin:0 0 15px;">That’s for now, we’ll do the rest of the move in together later!</p>
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
