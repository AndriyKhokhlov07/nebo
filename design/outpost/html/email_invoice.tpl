{* Invoice email template for customer *}

{$subject = "{$settings->company_name|escape} | Invoice `$order->sku`" scope=parent}

<div style="background:#f2f2f2;width:100%;min-width:100%;padding: 40px 0">
<table cellpadding="0" cellspacing="0" border="0" align="center" width="600" style="max-width:96%; margin:0 auto !important;">
	<tr>
		<td style="padding: 0 30px 20px;">
			<a href="https://ne-bo.com" target="_blank" style="display:block; margin:0 0 20px;">
				<img src="https://ne-bo.com/design/{$settings->theme|escape}/images/logo_b.png" alt="{$settings->company_name}" width="190" height="28">
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
						<p style="background:{if $order->paid == 1}#008f35{elseif $order->status == 1}#2881ee{elseif $order->status == 3}#cacaca{else}#333{/if}; display:inline-block; color:#fff; font: 600 16px/1 Helvetica; text-transform: uppercase; padding:6px 12px 3px; margin: 0 0 3px;">
							{if ($order->paid == 1 && $order->type != 3) || ($order->paid == 1 && $order->type == 3 && $order->total_price|convert != 0)}
								Paid
							{elseif $order->paid == 1 && $order->type == 3}
								Pending
							{else if $order->status == 0 || $order->status==4}
								New
							{elseif $order->status == 1}
								Pending
							{elseif $order->status == 2}
								Closed
							{elseif $order->status == 3}
								Canceled
							{/if}
						</p>
						<p style="color:#333; font: 500 36px/1 Helvetica; text-transform:uppercase; margin:0 0 15px;">Invoice</p>
						<p style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">Invoice number: <span style="font-weight:700">{$order->sku}</span></p>
						<p style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">Date of issue: <span style="font-weight:700">{$order->date|date}</span></p>
						{if $order->paid != 1 && $order->status != 3}
							<p style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">Due date: <span style="font-weight:700">
							{if $order->date_due && $order->date_due|date:'Y'!='1969'}
								{$order->date_due|date}
							{else}
								{(strtotime($order->date)+ (2*24*60*60))|date_format:'%b %e, %Y'}
							{/if}
							</span></p>
						{/if}

						<p style="color:#333; font: 500 22px/1 Helvetica; text-transform:uppercase; margin:40px 0 10px;">Billed to</p>
						<p style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;"><strong>{$user->name|escape}</strong>{foreach $users as $u}{if $u->id != $user->id}, {$u->name}{/if}{/foreach}</p>
						<p style="color:#333; font: 100 14px/1.1 Helvetica; margin:0 0 7px;">{$user->email|escape}</p>
					</td>
				</tr>
				<tr>
					<td width="15"></td>
					<td style="color:#999; font: 100 12px/1 Helvetica; text-transform:uppercase; padding: 5px 15px;">Items</td>
					<td></td>
					<td width="15"></td>
				</tr>
				{foreach $purchases as $purchase}
					<tr>
						<td style="background:#f2f2f2" width="15"></td>
						<td style="background:#f2f2f2; border-bottom:#d9d9d9 1px solid; color:#555; font: 500 15px/1 Helvetica; padding:12px 15px 10px;">{$purchase->product_name|escape} {$purchase->variant_name|escape}</td>
						<td style="background:#f2f2f2; border-bottom:#d9d9d9 1px solid; color:#222; font: 500 15px/1 Helvetica; text-align:right; width:70px; padding:12px 15px 10px;"><span class="white-space:nowrap">{$currency->sign}{($purchase->price*$purchase->amount)|number_format:2:'.':''}<span></td><td style="background:#f2f2f2" width="15"></td>
					</tr>
				{/foreach}

				{if $order->discount > 0}
					<tr>
						<td style="background:#dee0e1" width="15"></td>
						<td style="background:#dee0e1; border-bottom:#c7c9ca 1px solid; color:#555; font: 500 15px/1 Helvetica; text-align:right; padding:12px 15px">Discount</td>
						<td style="background:#dee0e1; border-bottom:#c7c9ca 1px solid; color:#222; font: 500 15px/1 Helvetica; text-align:right; width:70px;padding:12px 15px">
							<span class="white-space:nowrap">
								{if $order->discount_type==2}
									{$currency->sign}{$order->discount|number_format:2:'.':''}
								{else}
									{$order->discount}&nbsp;%
								{/if}
							</span>
						</td>
						<td style="background:#dee0e1" width="15"></td>
					</tr>
				{/if}
				<tr>
					<td style="background:#dee0e1" width="15"></td>
					<td style="background:#dee0e1; {if $payment_method}border-bottom:#c7c9ca 1px solid;{/if} color:#555; font: 500 15px/1 Helvetica; text-align:right; padding:12px 15px">Total</td>
					<td style="background:#dee0e1; {if $payment_method}border-bottom:#c7c9ca 1px solid;{/if} color:#222; font: 500 15px/1 Helvetica; text-align:right; width:70px; padding:12px 15px"><span class="white-space:nowrap">{$currency->sign}{$order->total_price|number_format:2:'.':''}</span></td>
					<td style="background:#dee0e1" width="15"></td>
				</tr>
				{if $payment_method}
					{$payment_commission = (($all_currencies[$payment_method->currency_id]->rate_from / $all_currencies[$payment_method->currency_id]->rate_to) - 1) * $order->total_price}
					<tr>
						<td style="background:#dee0e1" width="15"></td>
						<td style="background:#dee0e1; border-bottom:#c7c9ca 1px solid;color:#555; font: 500 15px/1 Helvetica; text-align:right; padding:12px 15px">Fee ({$payment_method->name})</td>
						<td style="background:#dee0e1; border-bottom:#c7c9ca 1px solid; color:#222; font: 500 15px/1 Helvetica; text-align:right; width:70px; padding:12px 15px"><span class="white-space:nowrap">{$currency->sign}{$payment_commission|number_format:2:'.':''}</span></td>
						<td style="background:#dee0e1" width="15"></td>
					</tr>
					<tr>
						<td style="background:#dee0e1" width="15"></td>
						<td style="background:#dee0e1; color:#555; font: 500 15px/1 Helvetica; text-align:right; padding:12px 15px">Total to pay</td>
						<td style="background:#dee0e1; color:#222; font: 500 15px/1 Helvetica; text-align:right; width:70px; padding:12px 15px"><span class="white-space:nowrap">{$currency->sign}{($order->total_price+$payment_commission)|number_format:2:'.':''}</span></td>
						<td style="background:#dee0e1" width="15"></td>
					</tr>
				{/if}
				<tr>
					<td colspan="4" style="padding: 20px 30px 20px;">
						{if $order->status == 0 || $order->status==4}
							<a style="display:block; border-radius: 7px; background:#008f35; color:#fff; font:500 20px/1 Helvetica; text-align:center; text-transform:uppercase; text-decoration: none; padding: 17px 10px 15px; margin: 0 0 45px;" href="https://ne-bo.com/order/{$order->url}?u={$user->id}&w=1#pm" target="_blank">Pay</a>
						{/if}
						
						<p style="color:#666;font:100 13px/1 Helvetica;">You can view invoice status by following this link:<br><a style="color:#000" href="https://ne-bo.com/order/{$order->url}?u={$user->id}&w=1" target="_blank">https://ne-bo.com/order/{$order->url}?u={$user->id}&w=1</a>
						</p>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td style="padding: 15px 30px 20px;">
			{include file="file:{$smarty.current_dir}/email/bx/footer.tpl"}
		</td>
	</tr>
</table>
</div>
