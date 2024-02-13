{if $notification->type == 9 || $notification->type == 11}
	{$subject="{$settings->company_name|escape} | Visit of Outpost Team" scope=parent}
{else}
	{$subject="{$settings->company_name|escape} | Alert!" scope=parent}
{/if}

<div style="background:#f2f2f2;width:100%;min-width:100%;padding: 40px 0">
<table cellpadding="0" cellspacing="0" border="0" align="center" width="600" style="max-width:96%; margin:0 auto !important;">
	<tr>
		<td style="padding: 0 30px 20px;">
			<a href="{$config->root_url}" target="_blank" style="display:block; margin:0 0 20px;">
				<img src="{$config->root_url}/design/{$settings->theme|escape}/images/logo_b.png" alt="{$settings->company_name}" width="190" height="28">
			</a>
		</td>
	</tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" align="center" style="background:#fff; border-radius: 5px; width:100%; box-shadow: 0 3px 15px rgba(0,0,0,.15);">
				<tr>
					<td colspan="4" style="padding: 40px 30px 20px;">
						<p style="color:#333; font: 500 26px/1 Helvetica; margin:0 0 15px;">Hello, {$user->first_name}</p>
						<p style="color:#333; font: 100 16px/1.3 Helvetica; margin:0 0 15px;">{$notification->text}</p>
						<p style="color:#333; font: 900 16px/1.3 Helvetica; margin:0 0 15px;">Date: {$notification->date|date}</p>
						{if $notification->time_from != 0 || $notification->time_to != 0}
						<p style="color:#333; font: 900 16px/1.3 Helvetica; margin:0 0 15px;">Time: {if $notification->time_from != 0} from {$notification->time_from|date_format:"%I:00 %p"}{/if}{if $notification->time_to != 0} to {$notification->time_to|date_format:"%I:00 %p"}{/if}</p>
						{/if}
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td style="padding: 15px 30px 20px; text-align: center;">
			{include file="file:{$smarty.current_dir}/bx/footer.tpl"}
		</td>
	</tr>
</table>
</div>
