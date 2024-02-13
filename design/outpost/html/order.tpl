{* Страница заказа *}

{$members_menu=1 scope=parent}

{$apply_button_hide=1 scope=parent}
{$meta_title = "Your order #`$order->id`" scope=parent}


<div class="main_width">

<h1>Your order #{$order->id} 
{if $order->status == 0}is accepted{/if}
{if $order->status == 1}is approved{elseif $order->status == 2}is executed{/if}
{if $order->paid == 1} and has been paid{else}{/if}
</h1>

{* Список покупок *}
<div class="grey_block">
<table id="purchases" class="table_ts">

{foreach $purchases as $purchase}
<tr>
	{* Изображение товара *}
	{*	
	<td class="image">
		{$image = $purchase->product->images|first}
		{if $image}
		<a href="products/{$purchase->product->url}"><img src="{$image->filename|resize:'product':50:50}" alt="{$product->name|escape}"></a>
		{/if}
	</td>
	*}
	
	{* Название товара *}
	<td class="name">
		<a href="/products/{$purchase->product->url}">{$purchase->product_name|escape}</a>
		{$purchase->variant_name|escape}
		{if $order->paid && $purchase->variant->attachment}
			<a class="download_attachment" href="order/{$order->url}/{$purchase->variant->attachment}">download</a>
		{/if}
	</td>

	{* Цена за единицу *}
	{*
	<td class="price">
		{($purchase->price)|convert}&nbsp;{$currency->sign}
	</td>
	*}

	{* Количество *}
	{*
	<td class="amount">
		&times; {$purchase->amount}&nbsp;{$settings->units}
	</td>
	*}

	{* Цена *}
	<td class="price">
		{($purchase->price*$purchase->amount)|convert}&nbsp;{$currency->sign}
	</td>
</tr>
{/foreach}

{* Скидка, если есть *}
{if $order->discount > 0}
<tr>
	{* <th class="image"></th> *}
	<th class="name">discount</th>
	{*<th class="price"></th>
	<th class="amount"></th>*}
	<th class="price">
		{if $order->discount_type==2}
			{$order->discount} &nbsp;{$currency->sign}
		{else}
			{$order->discount}&nbsp;%
		{/if}
	</th>
</tr>
{/if}

{* Купон, если есть *}
{if $order->coupon_discount > 0}
<tr>
	{*<th class="image"></th>*}
	<th class="name">coupon</th>
	{*<th class="price"></th>
	<th class="amount"></th>*}
	<th class="price">
		&minus;{$order->coupon_discount|convert}&nbsp;{$currency->sign}
	</th>
</tr>
{/if}
{* Если стоимость доставки входит в сумму заказа *}
{if !$order->separate_delivery && $order->delivery_price>0}
<tr>
	{*<th class="image"></th>*}
	<td class="name">{$delivery->name|escape}</td>
	{*<td class="price"></td>
	<td class="amount"></td>*}
	<td class="price">
		{$order->delivery_price|convert}&nbsp;{$currency->sign}
	</td>
</tr>
{/if}
{* Итого *}
<tr>
	{*<th class="image"></th>*}
	<th class="name">Total</th>
	{*<th class="price"></th>
	<th class="amount"></th>*}
	<th class="price">
		{$order->total_price|convert}&nbsp;{$currency->sign}
	</th>
</tr>
{* Если стоимость доставки не входит в сумму заказа *}
{if $order->separate_delivery}
<tr>
	{*<th class="image"></th>*}
	<td class="name">{$delivery->name|escape}</td>
	{*<td class="price"></td>
	<td class="amount"></td>*}
	<td class="price">
		{$order->delivery_price|convert}&nbsp;{$currency->sign}
	</td>
</tr>
{/if}

</table>
</div><!-- grey_block -->


<br>
{if !$order->paid}
{* Select payment method  *}
{if $payment_methods && !$payment_method && $order->total_price>0}
<form method="post">
<h2>Have coupon?</h2>
<div class="inp"><input type="text" name="coupon_code" placeholder="Your coupon"></div>
<h2>Select payment method</h2>
<ul id="deliveries">
    {foreach $payment_methods as $payment_method}
    	<li>
    		<div class="checkbox">
    			<input type=radio name=payment_method_id value='{$payment_method->id}' {if $payment_method@first}checked{/if} id=payment_{$payment_method->id}>
    		</div>			
			<h3>
				<label for=payment_{$payment_method->id}>	{$payment_method->name}, Total to pay: {$order->total_price|convert:$payment_method->currency_id}&nbsp;{$all_currencies[$payment_method->currency_id]->sign}</label></h3>
			<div class="description">
				{$payment_method->description}
			</div>
    	</li>
    {/foreach}
</ul>
<input type='submit' class="button" value='Proceed to checkout'>
</form>

{* Выбраный способ оплаты *}
{elseif $payment_method}
<h2>Payment method &mdash; {$payment_method->name}
{*<form method=post><input type=submit name='reset_payment_method' value='change payment method'></form>*}
</h2>
{$payment_commission = (($all_currencies[$payment_method->currency_id]->rate_from / $all_currencies[$payment_method->currency_id]->rate_to) - 1) * $order->total_price}
{if $payment_commission > 0}
<h6>
	Commission {$payment_method->name}: {$payment_commission|convert} 
	{$all_currencies[$payment_method->currency_id]->sign}
<h6>
{/if}
<p>
{$payment_method->description}
</p>
<h2>
Total to pay: {$order->total_price|convert:$payment_method->currency_id}&nbsp;{$all_currencies[$payment_method->currency_id]->sign}
</h2>

{* Форма оплаты, генерируется модулем оплаты *}
{checkout_form order_id=$order->id module=$payment_method->module}
{/if}

{/if}


<div class="order_info_block">
{* Order details *}
<h2>Order details</h2>
<div class="grey_block">
<table class="order_info table_ts">
	<tr>
		<td>
			Order date
		</td>
		<td>
			{$order->date|date} at
			{$order->date|time}
		</td>
	</tr>
	{if $user->name}
	<tr>
		<td>
			Name
		</td>
		<td>
			{$user->name|escape}
		</td>
	</tr>
	{/if}
	{if $user->email}
	<tr>
		<td>
			Email
		</td>
		<td>
			{$user->email|escape}
		</td>
	</tr>
	{/if}
	{if $user->phone}
	<tr>
		<td>
			Phone
		</td>
		<td>
			{$user->phone|escape}
		</td>
	</tr>
	{/if}
	{if $order->address}
	<tr>
		<td>
			Address
		</td>
		<td>
			{$order->address|escape}
		</td>
	</tr>
	{/if}
	{if $order->comment}
	<tr>
		<td>
			Comment
		</td>
		<td>
			{$order->comment|escape|nl2br}
		</td>
	</tr>
	{/if}
</table>
</div><!-- grey_block -->
</div><!-- order_info_block -->


</div><!-- main_width -->
 