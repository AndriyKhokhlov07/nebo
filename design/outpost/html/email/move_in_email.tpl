{$subject="{$settings->company_name|escape} | New Tenant / {$guest->house->name}" scope=parent}
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
						<p style="color:#333; font: 500 29px/1 Helvetica; margin:0 0 15px;">Hey {$user->name},</p>
						<p style="color:#333; font: 300 17px/1 Helvetica; margin:0 0 15px;">Outpost Club would like to let you know that you will have a new housemate soon! On {$guest->booking->arrive|date}, your new housemate {$guest->first_name} will arrive and move into {$guest->apt->name} / bed {$guest->bed->name}.
						</p>
						<p style="color:#333; font: 300 17px/1 Helvetica; margin:0 0 15px;">Please be prepared for their arrival and work with your other housemates to make sure there’s enough room in the fridge and cabinets for the new housemate. Also, if you have any personal items in the common areas, be sure to bring them back to your room.</p>
						<p style="color:#333; font: 300 17px/1 Helvetica; margin:0 0 15px;">We hope you’re excited for your new housemate!</p>
						<p style="color:#333; font: 300 17px/1 Helvetica; margin:0 0 15px;">The Outpost Club Team</p>
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
