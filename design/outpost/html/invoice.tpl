{* Invoice Page *}

{$this_page='order' scope=parent}
{$members_menu=1 scope=parent}
{$apply_button_hide=1 scope=parent}
{$meta_title = "Your invoice `$order->sku`" scope=parent}
{$preloader=true scope=parent}


{if $user->type==6} {* Guarantor *}
	{$members_menu=0 scope=parent}
{/if}

{googleSearchAddress()}


<div class="invoice_width main_width">
	<div class="invoice_block w100" id="invoice_block">

		<div class="invoice_header fx w">

			<div class="company_info">
				<img class="logo_b" src="/design/{$settings->theme|escape}/images/logo_b.svg" alt="{$settings->company_name}">
				<p>P.O. 780316 Maspeth, NY, 11378</p>
				{*<p>970 Park place <br>Brooklyn, NY 11213, United States</p>*}
				<p><a href="tel:+18337076611" target="_blank">+1 (833) 707-6611</a></p>
				<p><a href="mailto:info@outpost-club.com" target="_blank">info@outpost-club.com</a></p>
			</div><!-- company_info -->

			<div class="invoice_info text_right">

				{if $order->paid == 1}
					<div class="status paid">Paid</div>
				{else}
					{if $order->status == 0 || $order->status == 4}
						<div class="status new">New</div>
					{elseif $order->status == 1}
						<div class="status pending">Pending</div>
					{elseif $order->status == 3}
						<div class="status canceled">Canceled</div>
					{/if}
				{/if}

				<h3 class="title">Invoice</h3>
				<p>Invoice number: <span>{$order->sku}</span></p>
				{if $order->contract_id}
					<p>Contract number: <span>{$order->contract_id}</span></p>
				{/if}
				<p>Date of issue: <span>{$order->date|date}</span></p>
				{if $order->paid != 1 && $order->status != 3}
					<p>
						Due date:
						<span>
						{if $order->date_due && $order->date_due|date:'Y'!='1969'}
							{$order->date_due|date}
						{elseif $order->date_from}
							{(strtotime($order->date_from)+ (2*24*60*60))|date_format:'%b %e, %Y'}
						{else}
							{(strtotime($order->date)+ (2*24*60*60))|date_format:'%b %e, %Y'}
						{/if}
						</span>
					</p>
				{/if}

			</div><!-- invoice_info -->

			<div class="bill_to">
				<h3 class="title">Billed to</h3>
				<p><strong>{$user->name|escape}</strong>{foreach $users as $u}{if $u->id != $user->id}, {$u->name}{/if}{/foreach}</p>
				<p>{$user->email|escape}</p>
			</div><!-- bill_to -->

		</div><!-- invoice_header -->


		<div class="inv_purchases">
			<table>
				<tr>
					<th class="pd"></th>
					<th colspan="2">Items</th>
					<th class="pd"></th>
				</tr>
				{foreach $purchases as $purchase}
					<tr>
						<td class="pd"></td>
						<td class="name">
							{$purchase->product_name|escape} {$purchase->variant_name|escape}
						</td>
						<td class="price">
							{$currency->sign}&nbsp;{($purchase->price*$purchase->amount)|convert}
						</td>
						<td class="pd"></td>
					</tr>
				{/foreach}
				{if $order->discount > 0}
					<tr class="total">
						<td class="pd"></td>
						<td class="name">Discount</td>
						<td class="price">
							{if $order->discount_type==2}
								{$currency->sign}&nbsp;{$order->discount|convert}
							{else}
								{$order->discount}&nbsp;%
							{/if}
						</td>
						<td class="pd"></td>
					</tr>
				{/if}
				{if $order->coupon_discount > 0}
					<tr class="total">
						<td class="pd"></td>
						<td class="name">Coupon discont</td>
						<td class="price">
							{$currency->sign}&nbsp;{$order->coupon_discount|convert}
						</td>
						<td class="pd"></td>
					</tr>
				{/if}
				<tr class="total">
					<td class="pd"></td>
					<td class="name">
						Total
					</td>
					<td class="price">
						{$currency->sign}&nbsp;{$order->total_price|convert}
					</td>
					<td class="pd"></td>
				</tr>
				{if $payment_method}
					{if $payment_method->fee}
						{$payment_commission = $payment_method->fee}
			    	{else}
						{$payment_commission = (($all_currencies[$payment_method->currency_id]->rate_from / $all_currencies[$payment_method->currency_id]->rate_to) - 1) * $order->total_price}
					{/if}
					<tr class="total">
						<td class="pd"></td>
						<td class="name">
							Fee ({$payment_method->name})
						</td>
						<td class="price">
							{$currency->sign}&nbsp;{$payment_commission|convert}
						</td>
						<td class="pd"></td>
					</tr>
					{if $order->coupon_discount > 0}
					<tr class="total">
						<td class="pd"></td>
						<td class="name">Coupon discont</td>
						<td class="price">
							{$currency->sign}&nbsp;{$order->coupon_discount|convert}
						</td>
						<td class="pd"></td>
					</tr>
					{/if}
					<tr class="total">
						<td class="pd"></td>
						<td class="name">
							Total to pay
						</td>
						<td class="price">
							{$currency->sign}&nbsp;{($order->total_price+$payment_commission)|convert}
						</td>
						<td class="pd"></td>
					</tr>
				{/if}
			</table>
			{if $order->date_from}
			<p class="inv_questions">*Overuse may be subject to additional charge.</p>
			{/if}
		</div><!-- inv_purchases -->

		
		{if (!$order->paid && $order->status!=3) || !$order->payment_method_id}
			{if $payment_methods && !$payment_method && $order->total_price>0}
				<div class="id" id="pm"></div>
				<div class="payment_methods_block">
				<form method="post">
					<h3 class="title">Select payment method</h2>
					<div class="payment_methods fx w w100{if $user->hide_ach} ch2{/if}">
					    {foreach $payment_methods as $payment_method}
					    {if (($user->hide_ach == 1 && ($payment_method->name!='ACH' && !($payment_method->module=='Qira' && $payment_method->settings['payment_method_type']==3))) || $user->hide_ach == 0)}
					    {if ($order->type == 3 && ($payment_method->name!='ACH' && !($payment_method->module=='Qira' && $payment_method->settings['payment_method_type']==3))) || $order->type != 3}
							{if $payment_method->fee}
								{$payment_commission = $payment_method->fee}
					    	{elseif $order->user_id == 1300 && $payment_method->name!='ACH'}
					    		{$payment_commission = 0.0395 * $order->total_price}
					    	{else}
					    		{$payment_commission = (($all_currencies[$payment_method->currency_id]->rate_from / $all_currencies[$payment_method->currency_id]->rate_to) - 1) * $order->total_price}
					    	{/if}
					    	<div class="item fx v">		
								<div class="cont">
									<h4 class="title">
										{$payment_method->name}
										{if $payment_method->name=='ACH'}
											<span>Bank transfer</span>
										{/if}
									</h4>
									<div class="amounts fx w100">
										<p>
											Fee
											<span class="price">
												{$all_currencies[$payment_method->currency_id]->sign}
												{$payment_commission|convert}
											</span>
										</p>
										<p>
											Total to pay
											<span class="price">
												{$all_currencies[$payment_method->currency_id]->sign} {($order->total_price+$payment_commission)|convert}
											</span>
										</p>
									</div>
									{*
									<div class="description">
										{$payment_method->description}
									</div>
									*}
								</div><!-- cont -->
								<!-- <input class="button" type='submit' value='Select {$payment_method->name}'> -->
								<button class="button" type="submit" name="payment_method_id" value="{$payment_method->id}">
									Pay by
									{if $payment_method->module=='Stripe'}
										{$payment_method->module}
									{else}
										{$payment_method->name}
									{/if}
								</button>
					    	</div><!-- item -->
					    {/if}
					    {/if}
					    {/foreach}
					</div><!-- payment_methods -->
					<!-- <input type='submit' class="button" value='Proceed to checkout'> -->
					</form>
				</div><!-- payment_methods -->
			{elseif $payment_method && $order->status != 3}
				<div class="payment_method">
					<div class="title_block fx sb w100">
						<h3 class="title">Payment method: <span>{$payment_method->name}</span></h3>
						
						{if $order->status==0 || $order->status==4}
							<form method=post>
								<button class="button" type="submit" name="reset_payment_method" value="1">
									<i class="fa fa-arrow-left"></i> change payment method
								</button>
							</form>
						{else if $order->status==1}
							{*
							<form method=post>
								<button class="button" type="submit" name="reset_payment_method" value="1">
									Retry payment <i class="fa fa-arrow-right"></i>
								</button>
							</form>
							*}
						{/if}
					</div><!-- title_block -->
					
					<div class="checkout_block w100">
						{if $order->status==0 || $order->status==4}
							{checkout_form order_id=$order->id module=$payment_method->module}
						{else if $order->status==1}
							{if $payment_method->module=='StripeACH'}
								Thanks! ACH payments take up to 5 business days to receive acknowledgment of their success.
							{else}
								Pending
							{/if}
						{/if}
					</div><!-- checkout_block -->
					
				</div><!-- payment_method -->
			{/if}
		{/if}


		{if !$hide_salesflow_steps}
			{if $user->type==6} {* Guarantor *}
				{if $order->status==1 || $order->status==2 || $order->paid}
					{$active_step=2}
					{$next_step_link="{$config->root_url}/guarantor/agreement"}
				{/if}
				{include file='guarantor/bx/steps_apps.tpl'}
			{else}
				{if $salesflow->type == 1 && $order->type == 11 && ($order->status==1 || $order->status==2 || $order->paid)}
					{$active_step=2}
					{* {$next_step_link = "user/covid_form/{$user->auth_code}"} *}
					{$steps_type='hotel_airbnb'}
					{include file='bx/steps_apps.tpl'}
				{elseif $first_month_invoice || ($salesflow->type == 3 && ($order->status==1 || $order->status==2 || $order->paid))}
					{if !$first_month_invoice && ($order->status==1 || $order->status==2 || $order->paid)}
						<h1 class="bold_h1_new center">Thank You!</h1>
						{$active_step=5}
					{else}
						{$active_step=4}
						{$next_step_link = "order/{$first_month_invoice->url}?u={$user->id}"}
					{/if}
					{$steps_type='hotel'}
					{include file='bx/steps_apps.tpl'}
				{elseif $tp || (!$order->application_fee && ($order->status==1 || $order->status==2 || $order->paid))}
					{if $order->deposit == 1}
						{if $contract_interval >= 180}
						{$steps_count = 3}
						{/if}
						{$active_step=3}
						{$next_step_link = 'thank-you'}
					{else}
						{$active_step=6}
						{$next_step_link = "/user/sure/plans/{$user->hash_code}/{$order->booking_id}"}
					{/if}
					{$steps_type='bg_check'}
					{include file='bx/steps_apps.tpl'}
				{elseif $order->application_fee  && ($order->status==1 || $order->status==2 || $order->paid)}
					{$steps_type='bg_check'}
					{$steps_count = 3}
					{$active_step=2}
					{if $deposit_invoice}
						{$next_step_link = "order/{$deposit_invoice->url}?u={$user->id}"}
					{else}
						{$next_step_link = "/hellorented/{$user->auth_code}?c={$order->contract_id}"}
					{/if}
					{include file='bx/steps_apps.tpl'}
				{elseif $order->prepayment_invpice}
					{include file='bx/steps_apps.tpl'}
				{/if}
			{/if}
		{/if}

		<p class="inv_questions">Delay in payment may trigger automatic late fees. All payments (other than deposits) are final and non-refundable. Attempted cancellations through credit card processor, or chargebacks for non-fraudulent transactions through payment processors (Stripe/Paypal/via Credit/Debit Card/ACH) will be subject to fines and criminal investigation. We reserve the right to prosecuted fraud/theft-of-services to the fullest extent of the law.<br><br>
		If you moved in on any day other than the first day of the month, your first invoice will be for one month starting from your move-in date. Your second invoice will be for a pro-rated amount until the last day of that month. After that, all future months will be billed from the first day of the month to the last day of the month. If your last move out day is in the middle of the month, your last month will be prorated as well.<br><br>
		If you need to discuss a payment plan please email us at <a class="red_color" href="mailto:collections@outpost-club.com" target="_blank">collections@outpost-club.com</a><br>
		If you have questions related to this invoice - please check your agreement or email <a class="red_color" href="mailto:customer.service@outpost-club.com" target="_blank">customer.service@outpost-club.com</a></p>

	</div><!-- invoice_block -->
</div><!-- main_width -->
 