{$apply_button_hide=1 scope=parent}
{$members_menu=0 scope=parent}

{literal}
<script type="text/javascript">
$(document).ready(function() {
	let user_id = $('.hellorented_id_block').attr('data-hlid');
	let c_id = $('.hellorented_id_block').attr('data-cid');
	if(user_id != '')
	{
		$.ajax({
		    dataType: 'json',
		    url: 'ajax/hr_invite.php?id='+user_id+'&c_id='+c_id,
		    type: 'POST'
		});
	}
});
</script>
{/literal}

{$meta_title='Qira' scope=parent}

<div class="main_width hellorented_id_block" data-hlid="{$hellorented_id}" data-cid="{$contract->id}">
	<h1 class="bold_h1_new">Pay or skip your deposit using Qira</h1>
	{*	
	<h1 class="bold_h1_new">Deposit by Qira {$user->hellorented_tenant_id}</h1>

	{if $user->hellorented_tenant_id}
		<div class="form2">
			<div class="info">
				<span>Thank You!</span>
				<span>You will receive an email with instructions from Qira</span>
			</div>
		</div>
	{elseif $error=='contact_manager'}
		<div class="form2">
			<div class="info">
				<span>
					Contact the manager<br>
					customer.service@outpost-club.com<br>
					<a href="tel:+18337076611">+1 (833) 707-6611</a><br>
					<br>
					Please inform Customer Service team about the problem with the deposit.
				</span>
			</div>
		</div>

	{else}
	{/if}
	*}
		<div class="txt">
			<div class="fx hellorented_txt">
				<span>
	          		{*<p>Outpost is happy to partner with Qira to give our members the opportunity to skip their security deposit. By signing up with Qira, Outpost members can pay a low monthly fee and have their security deposit covered by Qira.</p>
	          		<p><strong>You will receive an email with instructions from Qira</strong></p>*}
	          		<p>Outpost is happy to partner with Qira to give our members the opportunity to skip their security deposit. By signing up for Qira, Outpost members can pay a monthly fee and have their security deposit covered by Qira.</p>
	          		<p>If you would like to pay your security deposit on your own, that’s fine too! In order to quickly return your security deposit to you at the end of your stay, Qira also accepts Outpost Club's security deposits from tenants. By choosing this method, there are no additional fees, and you can choose it by skipping the first option. <strong>Regardless of which option you choose, you must choose one of these two options.</strong></p>
	          		<p>You will receive an email from Qira with instructions.</p>
	          		{if $contract->type == 4}<p>If you are applying as a group, only one of you needs to pay the security deposit, and therefore only one of you needs to sign up for Qira. Everyone in the group will receive an email from Qira including next steps, but only one of you needs to complete these steps. Please choose among your group who will be completing this.</p>{/if}
				</span>
				<div style="width: 40%;">
					<img src="design/{$settings->theme|escape}/images/Qira.svg" alt="Qira" class="w100">
				</div>
				
			</div>
			
			{if $contract_interval >= 28}
			{$steps_count = 3}
			{/if}
            {$active_step=3}
            {$steps_type='bg_check'}
            {include file='bx/steps_apps.tpl'}
			</div>
			<p class="center">Once we review your application and receive your security deposit, you will then receive another email with instructions to sign a lease agreement,{* sign a COVID waiver,*} pay your first month’s rent, and sign up for renters insurance.</p>
			<div class="signed_block">
       		<div class="txt_from_contracts">
			<p class="center">Questions? Contact Outpost Club Inc at <a href="mailto:info@outpost-club.com">info@outpost-club.com</a> or call at <a href="tel:+18337076611">+1 (833) 707-6611</a>.</p>
			</div>
		</div>
</div>