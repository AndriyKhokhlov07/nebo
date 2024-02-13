{* User Login *}
{$canonical="/user/login}" scope=parent}
{$apply_button_hide=1 scope=parent}

<div class="page_wrap">
    <div class="main_width">
        
        <div class="login_form_block">

            <i class="icon fa fa-user-circle-o"></i>

            <h1 class="h1 center">Login</h1>

            {if $error}
            <div class="message_error">
                {if $error == 'login_incorrect'}Incorrect login or password
                {elseif $error == 'user_disabled'}Your account has not been activated yet
                {else}{$error}{/if}
            </div>
            {/if}

            <form class="form login_form" method="post">
                <div class="inp_bx">
                    <input class="inp" type="text" name="email" placeholder="Email" data-format="email" data-notice="Enter email" value="{$email|escape}" maxlength="255" />
                    <i class="fa fa-user"></i>
                </div><!-- inp_bx -->
                
                <div class="inp_bx">
                    <input class="inp" type="password" name="password" placeholder="Password" data-format=".+" data-notice="Enter password" value="" />
                    <a class="password_remind" href="user/password_remind">password reset</a>
                    <i class="fa fa-unlock-alt"></i>
                </div><!-- inp_bx -->

                <input type="submit" class="button1 black" name="login" value="Login">
            </form>

        </div><!-- login_form_block -->
        

    </div>
</div>
