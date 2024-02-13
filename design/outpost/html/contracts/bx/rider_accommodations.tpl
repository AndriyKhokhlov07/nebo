{* 253 - NYC *}
{if $house->parent_id == 253} 
<h1>NOTICE DISCLOSING TENANTS' RIGHTS TO REASONABLE ACCOMMODATIONS FOR PERSONS WITH DISABILITIES</h1>
<h2>Reasonable Accommodations</h2>
<p>The New York State Human Rights Law requires housing providers to make reasonable accommodations or modifications to a building or living space to meet the needs of people with disabilities. For example, if you have a physical, mental, or medical impairment, you can ask your housing provider to make the common areas of your building accessible, or to change certain policies to meet your needs.</p>
<p>To request a reasonable accommodation, you should contact your property manager by calling <a href="tel:+18337076611">+1 (833) 707-6611</a>, or by e-mailing <a href="mailto:customer.service@outpost-club.com">customer.service@outpost-club.com</a>*. You will need to inform your housing provider that you have a disability or health problem that interferes with your use of housing, and that your request for accommodation may be necessary to provide you equal access and opportunity to use and enjoy your housing or the amenities and services normally offered by your housing provider. A housing provider may request medical information, when necessary to support that there is a covered disability and that the need for the accommodation is disability related.</p>
<p>If you believe that you have been denied a reasonable accommodation for your disability, or that you were denied housing or retaliated against because you requested a reasonable accommodation, you can file a complaint with the New York State Division of Human Rights as described at the end of this notice.</p>
<p>Specifically, if you have a physical, mental, or medical impairment, you can request:**</p>
<p>Permission to change the interior of your housing unit to make it accessible (however, you are required to pay for these modifications, and in the case of a rental your housing provider may require that you restore the unit to its original condition when you move out); Changes to your housing provider’s rules, policies, practices, or services; Changes to common areas of the building so you have an equal opportunity to use the building. The New York State Human Rights Law requires housing providers to pay for reasonable modifications to common use areas.</p>
---------------
<p>* The Notice must include contact information when being provided under 466.15(d)(1), above. However, when being provided under (d)(2) and when this information is not known, the sentence may read “To request a reasonable accommodation, you should contact your property manager.”</p>
<p>** This Notice provides information about your rights under the New York State Human Rights Law, which applies to persons residing anywhere in New York State. Local laws may provide protections in addition to those described in this Notice, but local laws cannot decrease your protections.</p>
<br>
<p>Examples of reasonable modifications and accommodations that may be requested under the New York State Human Rights Law include:</p>
<p>If you have a mobility impairment, your housing provider may be required to provide you with a ramp or other reasonable means to permit you to enter and exit the building.</p>
<p>If your healthcare provider provides documentation that having an animal will assist with your disability, you should be permitted to have the animal in your home despite a “no pet” rule.</p>
<p>If you need grab bars in your bathroom, you can request permission to install them at your own expense. If your housing was built for first occupancy after March 13, 1991 and the walls need to be reinforced for grab bars, your housing provider must pay for that to be done.</p>
<p>If you have an impairment that requires a parking space close to your unit, you can request your housing provider to provide you with that parking space, or place you at the top of a waiting list if no adjacent spot is available.</p>
<p>If you have a visual impairment and require printed notices in an alternative format such as large print font, or need notices to be made available to you electronically, you can request that accommodation from your landlord.</p>

<h2>Required Accessibility Standards</h2>
<p>All buildings constructed for use after March 13, 1991, are required to meet the following standards: Public and common areas must be readily accessible to and usable by persons with disabilities;</p>
<p>All doors must be sufficiently wide to allow passage by persons in wheelchairs; and</p>
<p>All multi-family buildings must contain accessible passageways, fixtures, outlets, thermostats, bathrooms, and kitchens.</p>
<p>If you believe that your building does not meet the required accessibility standards, you can file a complain with the New York State Division of Human Rights.</p>

<h2>How to File a Complaint</h2>
<p>A complaint must be filed with the Division within one year of the alleged discriminatory act or in court within three years of the alleged discriminatory act. You can find more information on your rights, and on the procedures for filing a complaint, by going to <a href="www.dhr.ny.gov" target="_blank">www.dhr.ny.gov</a>, or by calling <a href="tel:+18883923644">1-888-392-3644</a>. You can obtain a complaint form on the website, or one can be e-mailed or mailed to you. You can also call or e-mail a Division regional office. The regional offices are listed on the website.</p>

<br>
<br>


<p>OWNER: Outpost Club, Inc.<br/>
	DATE: <br/>
	{if $contract_info->signature}
		SIGNATURE:<br/>
		<img src="design/{$settings->theme|escape}/images/c_signature.png" alt="Signature Sergii Starostin" width="180" />
	{else}
		SIGNATURE:<br/>
	{/if}
</p>

{*
{foreach $contract_users as $user}
{if $user->id != $contract_user->id}
<p>TENANT NAME: {$user->name|escape}<br/>
	{if $user->log}
	DATE: {$user->log->date|date_format:'%b %e, %Y'}<br/>
	SIGNATURE:<br/>
	<img src="{$config->contracts_dir}{$contract_info->url}/signature-{$user->id}.png" alt="Signature {$user->name|escape}" width="180" />
	{/if}
</p>
{/if}
{/foreach}
*}

{foreach $users as $user}
{if $user->id != $contract_user->id}
	{if $user->contract->signature}
	<p>TENANT NAME: {$user->name|escape}<br/>
		DATE: {$user->contract->date_signing|date_format:'%b %e, %Y'}<br/>
		SIGNATURE:<br/>
		<img src="{$user->contract->signature}" alt="Signature {$user->name|escape}" width="180" />
	</p>
	{elseif $user->booking->client_type_id==2}
	<p>TENANT NAME: {$user->name|escape}<br/>
		DATE: {$user->booking->created|date_format:'%b %e, %Y'}<br/>
		DIGITAL SIGNATURE ID: {$user->booking->airbnb_reservation_id}
	</p>
	{/if}
{/if}
{/foreach}

{if $airbnb_bookings}
{foreach $airbnb_bookings as $airbnb_booking}
{if $airbnb_booking->users}
{foreach $airbnb_booking->users as $user}
<p>TENANT NAME: {$user->name|escape}<br/>
	DATE: {$airbnb_booking->created|date_format:'%b %e, %Y'}<br/>
	DIGITAL SIGNATURE ID: {$airbnb_booking->airbnb_reservation_id}
</p>
{/foreach}
{/if}
{/foreach}
{/if}

{if $booking->type==2 && !$contract_users_hide}
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
{/if}

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
    <br>
    <br>
    SIGNATURE:<br>
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree10" for="agree10">I agree and sign</label><input type="checkbox" id="agree10" name="agree10" class="agree" value="1"></p>
{/if} 


<br>
<br>
<br>
<hr>
<br>
{/if}