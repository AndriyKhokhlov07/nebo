{* Add Guarantor Form *}
{$apply_button_hide=1 scope=parent}
{$members_menu=0 scope=parent}

{$meta_title='Indicate the Guarantor' scope=parent}

{$head_javascripts[]="js/heic2any.min.js" scope=parent}
{$javascripts[]="js/jquery.image-upload-resizer.js?v1.1.0" scope=parent}
{$javascripts[]="design/`$settings->theme`/js/user_check.js?v1.0.27" scope=parent}

<div class="guarantor_form_page {if $smarty.get.success=='sended'}page v_signed{else}w600{/if}">

	{if $smarty.get.success!='sended'}
		<div class="company_header">
			<img class="logo_b" src="/design/{$settings->theme|escape}/images/logo_b.svg" alt="{$settings->company_name}">
			<div class="cont">
				<p>Outpost Club Inc and Outpost Brokerage Inc are part of Outpost Group, which provides property management services in the states of New York, New Jersey and California. Should you have any questions, please feel free to call <a href="tel:+18337076611" target="_blank">+1 (833) 707-6611</a> or email <a href="mailto:info@outpost-club.com" target="_blank">info@outpost-club.com</a></p>
				<p>The registered address of Outpost Club Inc is P.O. 780316, 5502 69th St, Maspeth NY, 11378<br>
				The registered address of Outpost Brokerage Inc is P.O. 780316, 5502 69th St, Maspeth NY, 11378</p>
			</div><!-- cont -->
		</div><!-- company_header -->
	{/if}
		
	<h1 class="bold_h1_new">Indicate the Guarantor</h1>
	{if $smarty.get.success=='sended'}
		<div class="form2">
			<div class="info">
				<span>Thank you for indicating who will be your guarantor! That person will receive an email with instructions on how to become your guarantor. Please make sure to contact them and make sure they complete their part in order to move the process of securing your spot forward.</span>
			</div>
		</div>
		{*
		<hr class="hr">
		<div class="txt"></div>
		*}
	{else}
		<div class="user_check guarantor_form hl_checklist">
			<form method="post" name="guarantor_form">

				<div class="content_block1 visible">
					<div class="padd_bx">

						<div class="input_block mt0">
							<div class="input_wrapper">
								<label class="req" for="first_name">First name</label>
								<input class="inp_i required{if $message_errors['first_name']} not_req{/if}" id="first_name" type="text" name="first_name" value="{$u->first_name}" data-pattern="{literal}[\w\s]{2,}{/literal}">
								{if $message_errors['first_name']}<div class="req_info">Enter First name</div>{/if}
							</div>
						</div><!-- input_block -->

						<div class="input_block clear">
							<div class="input_wrapper">
								<label class="req" for="last_name">Last name</label>
								<input class="inp_i required{if $message_errors['last_name']} not_req{/if}" id="last_name" type="text" name="last_name" value="{$u->last_name}" data-pattern="{literal}[\w\s]{2,}{/literal}">
								{if $message_errors['last_name']}<div class="req_info">Enter Last name</div>{/if}
							</div>
						</div><!-- input_block -->

						<div class="input_block clear">
							<div class="input_wrapper">
								<label for="email" class="req">Email</label>
								<input class="inp_i required{if $message_errors['email']} not_req{/if}" id="email" type="text" name="email" value="{$u->email}" data-pattern="{literal}[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+{/literal}">
								{if $message_errors['email']}
									<div class="req_info">Enter Email</div>
								{elseif $message_errors['isset_user']}
									<div class="req_info">This user already in our system</div>
								{/if}
							</div>
						</div><!-- input_block -->
						
						<div class="input_block clear">
							<button class="button red green v2" type="submit">Submit</button> 
						</div><!-- input_block -->

					</div><!-- padd_bx -->
				</div><!-- content_block1 -->
			</form>
		</div><!-- user_check -->
	{/if}
</div><!-- guarantor_form_page -->





