{* Order email template for customer *}

{$subject = "Outpost Club event booking confirmation" scope=parent}


<table style="border-collapse: collapse; background-color:#f0f0f0;border:#ccc 1px solid; width: 90%;max-width: 600px; margin: 10px auto;">
	<tr>
		<td colspan="2" style="background-color:#ccc; padding: 20px;">
			<a style="text-decoration: none;" href="{$config->root_url}">
				<img src="{$config->root_url}/design/{$settings->theme|escape}/images/logo_s.png" alt="Outpost">
			</a>
		</td>
	</tr>
	<tr>
		<td colspan="2" style="padding: 20px;">
			<h2 style="font-family:arial; font-size: 20px;">Outpost Club event booking confirmation</h2>
		</td>
	</tr>
	{foreach $purchases as $purchase}
	<tr>
		<td style="padding:0 10px 20px 20px;">
			{$image = $purchase->product->images[0]}
			<a style="text-decoration: none;" href="{$config->root_url}/products/{$purchase->product->url}"><img border="0" src="{$image->filename|resize:'product':130:130}"></a>
		</td>
		<td style="padding:0 20px 20px 0;">
			<a style="text-decoration: none; color:#111; font-family:arial; font-size: 16px; font-weight: bold" href="{$config->root_url}/products/{$purchase->product->url}">{$purchase->product_name}</a>
			<div style="font-family:arial; font-size: 12px; color: #555;">{$purchase->product->annotation}</div>
		</td>
	</tr>
	{/foreach}
</table>
<table style="border-collapse: collapse; background-color:transparent;width: 90%;max-width: 600px; margin: 10px auto;">
	<tr>
		<td style="padding: 0 20px;">
			{foreach $menu as $m}
				{if $m->url!='join-us' && $m->url!=''}
				<a style="display: inline-block; font-family:arial; font-size: 12px; color: #444; text-decoration: none; margin-right: 10px;" href="{$config->root_url}/{$m->url}">{$m->name|escape}</a>
				{/if}
			{/foreach}
			<p style="font-family:arial; font-size: 12px; color: #999; float: right; margin: 0">{$smarty.now|date_format:'%Y'} &copy; Outpost Club</p>
		</td>
	</tr>
</table>
