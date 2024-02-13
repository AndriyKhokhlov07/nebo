{* Order email template for customer *}

{$subject = "{$settings->company_name|escape} | Order #`$order->id`" scope=parent}
<h1 style="font-weight:normal;font-family:arial;">
	<a href="{$config->root_url}/order/{$order->url}?u={$user->id}">Order #{$order->id}</a>
	for {$order->total_price|convert:$currency->id}&nbsp;{$currency->sign}
	{if $order->paid == 1}payment received{else}waiting for payment{/if},
	{if $order->status == 0}waiting for acceptance{elseif $order->status == 1}accepted{elseif $order->status == 2}executed{elseif $order->status == 3}отменен{/if}
</h1>
<table cellpadding="6" cellspacing="0" style="border-collapse: collapse;">
	<tr>
		<td style="padding:6px; width:170; background-color:#f0f0f0; border:1px solid #e0e0e0;font-family:arial;">
			Status
		</td>
		<td style="padding:6px; width:330; background-color:#ffffff; border:1px solid #e0e0e0;font-family:arial;">
			{if $order->status == 0}
				waiting for acceptance      
			{elseif $order->status == 1}
				accepted
			{elseif $order->status == 2}
				executed
			{elseif $order->status == 3}
				отменен
			{/if}
		</td>
	</tr>
	<tr>
		<td style="padding:6px; width:170; background-color:#f0f0f0; border:1px solid #e0e0e0;font-family:arial;">
			Payment
		</td>
		<td style="padding:6px; width:330; background-color:#ffffff; border:1px solid #e0e0e0;font-family:arial;">
			{if $order->paid == 1}
			<font color="green">payment received</font>
			{else}
			waiting for payment
			{/if}
		</td>
	</tr>
	{if $user->name}
	<tr>
		<td style="padding:6px; width:170; background-color:#f0f0f0; border:1px solid #e0e0e0;font-family:arial;">
			Customer name
		</td>
		<td style="padding:6px; width:330; background-color:#ffffff; border:1px solid #e0e0e0;font-family:arial;">
			{$user->name|escape}
		</td>
	</tr>
	{/if}
	{if $user->email}
	<tr>
		<td style="padding:6px; background-color:#f0f0f0; border:1px solid #e0e0e0;font-family:arial;">
			Email
		</td>
		<td style="padding:6px; background-color:#ffffff; border:1px solid #e0e0e0;font-family:arial;">
			{$user->email|escape}
		</td>
	</tr>
	{/if}
	{if $user->phone}
	<tr>
		<td style="padding:6px; background-color:#f0f0f0; border:1px solid #e0e0e0;font-family:arial;">
			Phone
		</td>
		<td style="padding:6px; background-color:#ffffff; border:1px solid #e0e0e0;font-family:arial;">
			{$user->phone|escape}
		</td>
	</tr>
	{/if}
	{if $order->address}
	<tr>
		<td style="padding:6px; background-color:#f0f0f0; border:1px solid #e0e0e0;font-family:arial;">
			Shipping address
		</td>
		<td style="padding:6px; background-color:#ffffff; border:1px solid #e0e0e0;font-family:arial;">
			{$order->address|escape}
		</td>
	</tr>
	{/if}
	{if $order->comment}
	<tr>
		<td style="padding:6px; background-color:#f0f0f0; border:1px solid #e0e0e0;font-family:arial;">
			Customer comment
		</td>
		<td style="padding:6px; background-color:#ffffff; border:1px solid #e0e0e0;font-family:arial;">
			{$order->comment|escape|nl2br}
		</td>
	</tr>
	{/if}
	<tr>
		<td style="padding:6px; background-color:#f0f0f0; border:1px solid #e0e0e0;font-family:arial;">
			Order date
		</td>
		<td style="padding:6px; width:170; background-color:#ffffff; border:1px solid #e0e0e0;font-family:arial;">
			{$order->date|date} {$order->date|time}
		</td>
	</tr>
</table>

<h1 style="font-weight:normal;font-family:arial;">You have ordered:</h1>

<table cellpadding="6" cellspacing="0" style="border-collapse: collapse;">

	{foreach $purchases as $purchase}
	<tr>
		<td align="center" style="padding:6px; width:100; padding:6px; background-color:#ffffff; border:1px solid #e0e0e0;font-family:arial;">
			{$image = $purchase->product->images[0]}
			<a href="{$config->root_url}/products/{$purchase->product->url}"><img border="0" src="{$image->filename|resize:50:50}"></a>
		</td>
		<td style="padding:6px; width:250; padding:6px; background-color:#f0f0f0; border:1px solid #e0e0e0;font-family:arial;">
			<a href="{$config->root_url}/products/{$purchase->product->url}">{$purchase->product_name}</a>
			{$purchase->variant_name}
			{if $order->paid && $purchase->variant->attachment}
			<br>
			<a href="{$config->root_url}/order/{$order->url}/{$purchase->variant->attachment}"><font color="green">Скачать {$purchase->variant->attachment}</font></a>
			{/if}
		</td>
		<td align=right style="padding:6px; text-align:right; width:150; background-color:#ffffff; border:1px solid #e0e0e0;font-family:arial;">
			{$purchase->amount} {$settings->units} &times; {$purchase->price|convert:$currency->id}&nbsp;{$currency->sign}
		</td>
	</tr>
	{/foreach}
	
	{if $order->discount}
	<tr>
		<td style="padding:6px; width:100; padding:6px; background-color:#ffffff; border:1px solid #e0e0e0;font-family:arial;"></td>
		<td style="padding:6px; background-color:#f0f0f0; border:1px solid #e0e0e0;font-family:arial;">
			Discount
		</td>
		<td align=right style="padding:6px; text-align:right; width:170; background-color:#ffffff; border:1px solid #e0e0e0;font-family:arial;">
			{$order->discount}&nbsp;%
		</td>
	</tr>
	{/if}

	{if $order->coupon_discount>0}
	<tr>
		<td style="padding:6px; width:100; padding:6px; background-color:#ffffff; border:1px solid #e0e0e0;font-family:arial;"></td>
		<td style="padding:6px; background-color:#f0f0f0; border:1px solid #e0e0e0;font-family:arial;">
			Coupon {$order->coupon_code}
		</td>
		<td align=right style="padding:6px; text-align:right; width:170; background-color:#ffffff; border:1px solid #e0e0e0;font-family:arial;">
			&minus;{$order->coupon_discount}&nbsp;{$currency->sign}
		</td>
	</tr>
	{/if}

	{if $delivery && !$order->separate_delivery}
	<tr>
		<td style="padding:6px; width:100; padding:6px; background-color:#ffffff; border:1px solid #e0e0e0;font-family:arial;"></td>
		<td style="padding:6px; background-color:#f0f0f0; border:1px solid #e0e0e0;font-family:arial;">
			{$delivery->name}
		</td>
		<td align="right" style="padding:6px; text-align:right; width:170; background-color:#ffffff; border:1px solid #e0e0e0;font-family:arial;">
			{$order->delivery_price|convert:$currency->id}&nbsp;{$currency->sign}
		</td>
	</tr>
	{/if}
	
	<tr>
		<td style="padding:6px; width:100; padding:6px; background-color:#ffffff; border:1px solid #e0e0e0;font-family:arial;"></td>
		<td style="padding:6px; background-color:#f0f0f0; border:1px solid #e0e0e0;font-family:arial;font-weight:bold;">
			Total
		</td>
		<td align="right" style="padding:6px; text-align:right; width:170; background-color:#ffffff; border:1px solid #e0e0e0;font-family:arial;font-weight:bold;">
			{$order->total_price|convert:$currency->id}&nbsp;{$currency->sign}
		</td>
	</tr>
</table>

<br>
You can view order status by following this link:<br>
<a href="{$config->root_url}/order/{$order->url}">{$config->root_url}/order/{$order->url}</a>
<br>