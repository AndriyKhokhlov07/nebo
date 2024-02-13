
<div class="page v_signed">
	<div class="signed_block">
		<div style="width: 80px; margin: 0 auto 30px">
			<img src="design/{$settings->theme|escape}/images/Qira.svg" alt="Qira" class="w100">
		</div>
		<h1 class="bold_h1 center">Security deposit</h1>

		<p class="center">Outpost is happy to partner with Qira to give our members the opportunity to skip their security deposit. By signing up for Qira, Outpost members can pay a monthly fee and have their security deposit covered by Qira.</p>
		<p class="center">If you would like to pay your security deposit on your own, that’s fine too! In order to quickly return your security deposit to you at the end of your stay, Qira also accepts Outpost Club's security deposits from tenants. By choosing this method, there are no additional fees, and you can choose it by skipping the first option. <strong>Regardless of which option you choose, you must choose one of these two options.</strong></p>
		<p class="center">You will receive an email from Qira with instructions.</p>

		<br>
		<br>


		<div class="txt">
			{if $salesflow->type == 3 && $booking->days_count >= 30}
				{$active_step=3}
				{$steps_type = 'hotel'}
				{if $invoice}
					{* {$timer=15} *}
					{$next_step_link = "order/{$invoice->url}?u={$user->id}"}
				{/if}
				{include file='bx/steps_apps.tpl'}
				<br>
			{/if}
			<p class="center">Questions? Contact Outpost Club Inc at <a href="mailto:info@outpost-club.com">info@outpost-club.com</a> or call at <a href="tel:+18337076611">+1 (833) 707-6611</a>.</p>
		</div>
	</div>
</div>


{literal}
<script>
$(function() {

function tm(el, t) {
	setTimeout(()=> {
		if (t > 0) {
			el.find('.tcount').text(t);
			t = t-1;
			tm(el, t);
		} else {
			window.location.replace(el.attr('href'));
		}
	}, 1000);
}

$('a[data-timer]').each(function(){
	let t = parseInt($(this).data('timer'))
	$(this).append($('<span class="tcount">'+t+'</span>'));
	tm($(this), t);
});

});
</script>
{/literal}

