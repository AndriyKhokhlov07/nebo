{* Письмо восстановления пароля *}
	
{$subject = "{$settings->company_name|escape} | New password" scope=parent}

<p>Hey there,</p>
<p>Thank you for requesting to reset your password. This link is valid for 5 minutes. You can change your password by clicking the following link: <a href='{$config->root_url}/user/password_remind/{$code}/{$user->email|urlencode}'>Change password</a></p>
<p>If you did not request a password reset for your account, please respond to this email letting us know. If you received this email in error, feel free to ignore it.</p>


