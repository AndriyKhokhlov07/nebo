{* Password remind *}
{$canonical="/user/password_remind" scope=parent}
{$apply_button_hide=1 scope=parent}


<div class="page_wrap">
    <div class="main_width">
        
        <div class="login_form_block">

            <i class="icon fa fa-user-circle-o"></i>

            <h1 class="h1 center">Password reset</h1>

            {if $email_sent}
				<p>An email for password recovery was sent to <br><strong>{$email|escape}</strong></p>
				<p>Please remember to check your spam folder if you can not find the email</p>
            {else}

	            {if $error}
				<div class="message_error">
					{if $error == 'user_not_found'}
						User not found
					{else}
						{$error}
					{/if}
				</div>
				{/if}

	            <form class="form login_form" method="post">
	                <div class="inp_bx">
	                    <input class="inp" type="text" name="email" placeholder="Email" data-format="email" data-notice="Enter email" value="{$email|escape}" maxlength="255" />
	                    <i class="fa fa-user"></i>
	                </div><!-- inp_bx -->

	                <input type="submit" class="button1 black" value="Send">
	            </form>
			{/if}
        </div><!-- login_form_block -->
        

    </div>
</div>
