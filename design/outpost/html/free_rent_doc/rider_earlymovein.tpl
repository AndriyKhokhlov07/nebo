
{if $booking_earlymovein} 
<br>
<br>
<br>
<br>
<h1>RESIDENTS RIDER - EARLY MOVE-IN RIDER</h1>


<p>On <strong>{$contract_info->date_from|date_format:'%b %e, %Y'}</strong> by and between {$landlord->name} (hereinafter “Owner”), owner of the premises known as and located at {$contract_info->rental_address} (“subject premises”) and</p>

{foreach $contract_users as $user}
<strong>{$user->name|escape}</strong><br/>
{/foreach}

<p>(hereinafter “Tenants”), tenants of <strong>{$apartment->name}</strong> in the subject premises (hereinafter “subject apartment”) as follows:</p>
<ol>
	<li>
		<p>The parties agree that Tenants will get early move into subject apartment on {$booking_earlymovein->arrive|date_format:'%b %e, %Y'}</p>
		<p>The Tenant {$contract_user->name|escape} will not owe rent for the above mentioned Early Move In period between {$booking_earlymovein->arrive|date_format:'%b %e, %Y'} and {$contract_info->date_from|date}.</p>
		<p>In other months over the course of the Lease from the beginning {$contract_info->date_from|date} till the end on {$contract_info->date_to|date} - all tenants agree to pay the monthly rent amount of {$contract_info->price_month|convert} (US Dollars).</p>
	</li>
</ol>
 


<p>OWNER: Outpost Club, Inc.<br/>
	{if $contract_info->signature || $contract_info->signing}
		SIGNATURE:<br/>
		<img src="design/{$settings->theme|escape}/images/c_signature.png" alt="Signature Sergii Starostin" width="180" />
	{else}
		SIGNATURE: ____________<br/>
	{/if}
</p>



{foreach $contract_users as $user}
{if $user->id != $contract_user->id}
<p>TENANT NAME: {$user->name|escape}<br/>
	{if $user->log}
		DATE: {$user->log->date|date_format:'%b %e, %Y'}<br/>
		SIGNATURE:<br/>
		<img src="{$config->contracts_dir}{$contract_info->url}/signature-{$user->id}.png" alt="Signature {$user->name|escape}" width="180" />
	{elseif $user->contract->signature}
        DATE: {$user->contract->date_signing|date_format:'%b %e, %Y'}<br/>
		SIGNATURE:<br/>
		<img src="{$user->contract->signature}" alt="Signature {$user->name|escape}" width="180" />
    {elseif $user->booking->client_type_id==2}
		DATE: {$user->booking->created|date_format:'%b %e, %Y'}<br/>
		DIGITAL SIGNATURE ID: {$user->booking->airbnb_reservation_id}
	{/if}
</p>
{/if}
{/foreach}

TENANT NAME: {$contract_user->name|escape}<br/>
{if $contract_info->signing == 1}
	DATE: {$contract_info->date_signing|date_format:'%b %e, %Y'}<br/>
{/if}

{if $contract_info->signature2}
    SIGNATURE:<br>
    <img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
    <br>
    <br>
{elseif $contract_user->booking->client_type_id==2}
	DIGITAL SIGNATURE ID: {$contract_user->booking->airbnb_reservation_id}
	<br>
    <br>
{else}
{*
    <br>
    <br>
    SIGNATURE:<br>
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree10" for="agree10">I agree and sign</label><input type="checkbox" id="agree10" name="agree10" class="agree" value="1"></p>
*}
{/if} 






<br>
<br>
<br>
{/if}