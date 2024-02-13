{$subject="{$settings->company_name|escape} | Your account" scope=parent}

<h1 style="font-weight:normal;font-family:arial;">An account has been created for you</h1>
<p>
Link for login: <a href="{$config->root_url}/user/login" target="_blank">{$config->root_url}/user/login</a><br>
Login: <strong>{$email}</strong><br>
Password: <strong>{$pass}</strong>
</p>