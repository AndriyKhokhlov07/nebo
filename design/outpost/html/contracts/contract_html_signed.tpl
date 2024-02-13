{* Contract html *}
<!-- <style>
	p, li, div, a, i {
		font-size: 12px;
	}
	h1{
		font-size: 18px;
	}
	h2{
		font-size: 16px;
	}
</style> -->
<style>
div,
p,
ul,
li,
span{
	font-size: 9px;
}
h1{
	font-size: 13px;
}
h2{
	font-size: 11px;
}
p,
h1,
h2{
	margin-bottom: 3px;
}
.hide_child .ch_item.pd{
	padding-left: 15px;
}
img{
	display: block;
	margin-top: 10px;
}
</style>

<h1>Outpost Roommate Agreement</h1>

<p>This document represents a legal contract that details the terms and liabilities of individuals residing in residential property, hereinafter referred to as the "Agreement".</p>

<h2>Section 1. The Parties & Property</h2>
<p>This agreement is supplemental to the Subtenant Addition Addendum and Sublease Agreement for you to join the current subtenancy among the existing subtenants.</p>

<p>For purposes of this Agreement, <strong>{$contract_user->first_name}{if $contract_user->middle_name} {$contract_user->middle_name}{/if} {$contract_user->last_name}</strong> shall be known as the "New Roommate".</p>

<p>The street address of the Property is <strong>{$contract_info->rental_address}</strong> in <strong>{$contract_info->rental_name|escape}</strong> and New Roommate will occupy {if $apartment}<strong>{$apartment->name} / {$bed->name}</strong>{/if}
{if $contract_info->room_type!=0}
	{if $contract_info->room_type==1}
		2-people room
	{elseif $contract_info->room_type==2}
		3-people room
	{elseif $contract_info->room_type==3}
		4-people room
	{elseif $contract_info->room_type==4}
		3-people shared room
	{elseif $contract_info->room_type==5}
		4-people shared room
	{elseif $contract_info->room_type==6}
		Private room
	{elseif $contract_info->room_type==7}
		Private room with bathroom
	{/if}
{/if} hereinafter known as the "Property".</p>


<h2>Section 2. The Term</h2>
<p>The duration of this Agreement is to start with the move-in and possession of the Property on <strong>{$contract_info->date_from|date}</strong>, at 1 pm EST and end on <strong>{$contract_info->date_to|date}</strong>, at 11 am EST hereinafter referred to as the "Term".</p>


<h2>Section 3. Security Deposit</h2>
<p>The Security Deposit for the New Roommate shall be {$contract_info->price_deposit|convert} (US Dollars) that will be refunded, minus any deductions as set forth in the Sublease Agreement, at the end of the Roommate Agreement Term.</p>

<p>The New Roommate agrees to accept responsibility for damages in the Common Areas that are caused from themselves personally or guests on the Property and agrees to reimburse the other Roommates for the part of their Security Deposit withheld for these damages.</p>
<p>If there are any damages caused in the Common Areas of the Property, <strong>that is not linked to any specific Roommate</strong>, all the Roommates will be equally liable. However, the New Roommate shall not be liable if there is any damage that is present prior to the start date of this Agreement.</p>
<p>The New Roommate have the right to complete a Move-in Checklist at the time of possession and indicate the pre-existing damages. The photos with damages should be sent to <a href="mailto:customer.service@outpost-club.com">customer.service@outpost-club.com</a> during 3 (three) days after move in. </p>

<h2>Section 4. Rent</h2>

{$invoice_first=$contract_info->invoices|first}
  
<p>The New Roommate agrees to pay in rent the amount of {$contract_info->price_month|convert} (US Dollars) due on the <strong>{(strtotime($invoice_first->date_from|date)-(10*24*60*60))|date_format:'%e'} of every month</strong>.</p> 

<p>The total amount of Rent payment for the whole period is {$contract_info->invoices_total|convert} (US Dollars).</p>


{* Monthly Membership *}
{*
<p>Full Payment (first month rent and deposit) for the first Month should be paid no later than {(strtotime($contract_info->date|date)+ (2*24*60*60))|date_format:'%b %e, %Y'}.</p>
<p>The payment of the Monthly Membership Fee for each of the following month’s must be paid by the Member according to the following schedule:
<ul>
	{foreach $contract_info->invoices as $i}
		{if $i@iteration>1}
			<li>Payment for {$i->date_from|date:'M j'} - {$i->date_to|date:'M j'}: {$i->price|convert} USD, to be paid on or before {$i->date_for_payment|date:'M j'}</li>
		{/if}
	{/foreach}
</ul>
</p>
*}
{* Monthly Membership (end) *}
  
<p>Rental Payment Instructions: Each month Outpost Club Inc. sends an invoice to the New Roommate e-mail address. Outpost Club Inc. sends the invoice ten (10) days in advance of the next pay period, and the invoice is due on the same day. However, Outpost Club allows for a ten (10) day grace-period allowing the member to pay anytime before 11:00 AM on the day of the upcoming pay period.</p>

<p>The New Roommate needs to register at the <a href="/" target="_blank">ne-bo.com</a> to receive access to all documents, invoices and maintenance tickets system. New Roommate will receive a temporary password to access <a href="/" target="_blank">ne-bo.com</a>. In case support is needed please reach out to <a href="mailto:customer.service@outpost-club.com">customer.service@outpost-club.com</a> or <a href="tel:+18337076611">+1 (833) 707-6611</a></p>
  
<p>The Roommates understand that the Landlord or Overtenant of the property can evict all of the Roommates if the landlord does not receive the rental payments in full and on time.</p>

<p>Any rent payments are final and non refundable. Attempted cancellations through credit card processor, chargebacks for non-fraudulent transactions through the Payment System (Stripe/Paypal/via Credit/Debit Card/ACH) will be subject to investigation and these individuals will be prosecuted to the fullest extent of the law.</p>
  
<h2>Section 5. Mutual Respect</h2>
<p>All Roommates agree to be respectful of each other and each other’s property, personal belongings and space.</p>

<h2>Section 6. Additional Agreements </h2>
<p>In Addition to this Agreement, the Roommates have each signed the Sublease Agreement via any applicable Sublease Addendums. </p>
<p>Landlord  will provide cold and hot water and heat as required by law, elevator service if the Building has elevator equipment., Subtenant will open accounts and cover charges for electricity, and gas utilities as well as internet services in the combined amount of $50/month for each Roommate on the Sub-Lease. In the case of overuse, when electricity, gas and internet monthly bill will be more than aggregate amount covered, Subtenant reserves the right to bill all roommates on the Sub-Lease for the additional amount for utilities as Additional Rent.</p>

<p>New Roommate agrees that Subtenant or Overtenant may share personal data including but not limited to Name/Surname, email, telephone number, current address and zipcode with Hellorented (security deposit provider), EKATA (background check company), Transunion (background check company).</p>

  
<h2>Section 7. Lead Paint Disclosure </h2>
<p>If the Property was built before 1978 a Lead Paint Disclosure Addendum is attached to the original Lease or can be requested through <a href="mailto:customer.service@outpost-club.com">customer.service@outpost-club.com</a>.</p> 
  
<h2>Section 8. Governing Law</h2> 
<p>This Agreement shall be governed by and construed in accordance with the laws of the State of New York.</p>

<h2>Section 9. Note</h2> 
{if $contract_info->note1}
	<p>{$contract_info->note1}</p>
{else}
	<p>None.</p>	
{/if}
  
<h2>Section 10. Authorization</h2> 

{if $contract_info->signing}
	<p>This agreement has been signed on {if $contract_info->signing}{$contract_info->date_signing|date:'m/d/Y'}<br/>{/if}</p>
{/if}
  
 
<p>New Roommate Signature</p>


{if $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{/if} 

<br>

<hr>

<br>
<br>
<br>

<h1>Subtenant Addition Addendum</h1>

<p>This Subtenant Addition Addendum is hereby a part for all purposes of the Sublease Agreement between: Ne-Bo Services Corporation, as	OVERTENANT and Outpost Club, Inc., as CURRENT SUBTENANT(s) for the property known as: {*{$contract_info->rental_name|escape}*}<strong>{$contract_info->rental_address}, {$apartment->name} / {$bed->name}</strong> OVERTENANT and CURRENT SUBTENANT(S) hereby acknowledge and agree	that  <strong>{$contract_user->name|escape}</strong> will be moving into the Property and shall become a SUBTENANT under the terms and conditions set forth in the Sublease Agreement referenced above.  SUBTENANT acknowledges receipt of the Sublease Agreement. All parties to this Subtenant Addition Addendum agree to be jointly and severally liable under the Lease Agreement for all amounts due and owing, whether past due, currently due or to be owed in the future, and all parties agree to abide by all terms of the Sublease Agreement.</p>

<p>All parties below hereby acknowledge and agree that upon vacating the Property any and all refunds of monies paid in advance under the terms of the Sublease Agreement, to include, but not limited to, security deposits and advance rent, shall be paid to all of the SUBTENANTS, as applicable, which shall include all NEW TENANTS added to the Lease Agreement.</p>
<p>Any extensions of the Sublease Agreement, this Subtenant Addition Addendum and Roommate Agreement must be expressly approved by Overtenant.</p>

<p>SUBTENANT may terminate this sublease and receive a FULL REFUND of any security deposit it has paid as well as the first month’s rent deposited if such termination is more than sixty (60) days prior to the Sublease start date.  If the security deposit was paid through Qira, the security deposit will be refunded to Qira, not SUBTENANT; provided, however, that Overtenant is not responsible to pay any fees SUBTENANT may owe separately to Qira for their service. The notice of cancellation should be sent to <a href="mailto:customer.service@outpost-club.com">customer.service@outpost-club.com</a> Oral or text requests will not be considered.</p>
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i></p>


<p>If SUBTENANT terminates this sublease less than sixty (60) days but more than thirty (30) days prior to the Sublease start date, SUBTENANT shall receive a refund on their first month’s rent but not any security deposit it has paid; provided, however, that SUBTENANT may elect to apply the security deposit amount as a credit toward another sublease at a different property for any lease of which Overtenant is also an Overtenant and is offering a sublease.  Such credit will expire one (1) year after the notice of cancellation.  Overtenant is not responsible to pay any fees SUBTENANT may owe separately to Qira for their service. The notice of cancellation should be sent to <a href="mailto:customer.service@outpost-club.com">customer.service@outpost-club.com</a>. Oral or text requests will not be considered.</p>
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i></p>


<p>If SUBTENANT terminates this sublease less than thirty (30)  days prior to the Sublease start date, SUBTENANT shall not receive a refund on their first month’s rent or any security deposit it has paid. Overtenant is not responsible to pay any fees SUBTENANT may owe separately to Qira for their service.</p>
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i></p>

<p>Any applicable taxes will be retained and remitted.</p>

<p>If SUBTENANT is more than five (5) days late in making any required rent payments, OVERTENANT reserves to terminate the Sublease Agreement and to charge a $50 late fee.</p>

<p>In the event that the bank for the account used above returns the transaction for Insufficient Funds, SUBTENANT will be assessed a $35.00 NSF Fee.</p>

<p>Attempted chargebacks for non-fraudulent transactions through the Ne-Bo payments processing system via Stripe, Credit / Debit Card, Paypal or ACH will be subject to investigation and these individuals will be prosecuted to the fullest extent of the law.</p>
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i></p>

<p>SUBTENANTS shall be permitted to extend the Sublease Agreement only with the prior written approval of OVERTENANT. Any extension requests to the Sublease should be submitted to <a href="mailto:customer.service@outpost-club.com">customer.service@outpost-club.com</a> not later than 30 days before end of individual term. Oral or text requests will not be considered.</p> 
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i></p>

<p>Abandonment of premises and unclaimed property</p>
<p>In the event the Subtenant abandons the premises, i.e. is not current with rent payments and is not living full time at the premises, the Overtenant may dispose of the Subtenants remaining personal property and fixtures as provided by state law. The Subtenant agrees that the Overtenant will determine if abandoned property is of value or to be treated as trash. Property of value will be inventoried and stored at the Subtenants expense. There will be a daily storage charge assess by the Overtenant depending on the size of valuables and the difficulty of storing the valuables. All charges must be paid before the stored items will be released by the Overtenant to the Subtenant. After sixty days, the Subtenant agrees that Overtenant may sell or dispose of the Subtenants items.</p>

<p>SUBTENANT may not further sublet the Apartment.</p>

<p>
OVERTENANT NAME:  Ne-Bo Services Corporation<br/>
DATE: {$contract_info->date_created|date:'m/d/Y'}<br/>
OVERTENANT SIGNATURE:<br>
<img src="design/{$settings->theme|escape}/images/c_signature2.png" alt="Signature Ne-Bo" width="180" />
</p>


 


<p><br/></p>

{foreach $contract_users as $user}
{if $user->id != $contract_user->id}
<p>NEW SUBTENANT NAME: {$user->name|escape}<br/>
	{if $user->log}
	DATE: {$user->log->date|date:'m/d/Y'}<br/>
	<img src="{$config->contracts_dir}{$contract_info->url}/signature-{$user->id}.png" alt="Signature {$user->name|escape}" width="180" />
	{/if}
</p>
{/if}
{/foreach}

<p>
NEW SUBTENANT NAME: {$contract_user->name|escape}<br/>
{if $contract_info->signing}
	DATE: {$contract_info->date_signing|date:'m/d/Y'}<br/>
{/if}	
<!-- NEW SUBTENANT SIGNATURE: -->
{if $contract_info->signature3}
	<img src="{$contract_info->signature3}" alt="Signature {$contract_user->name|escape}" width="180" />
{/if}

<br>
<br>


{if $contract_info->link1_type!=0}
<br>
<p>
	<strong>Link to Sublease Agreement:</strong>
	{if $contract_info->link1_type==1}
		{$link_1_part='1iYxxZB3Jb8hiW1XF7C1ayRWX-BbYNLRm'}
	{elseif $contract_info->link1_type==2}
		{$link_1_part='1DtkSFvqdMeDxO6WnQQ9bR1FJpoHYkNF6'}
	{elseif $contract_info->link1_type==3}
		{$link_1_part='1rOlORljTie5rvnA4SXkjK6zhKfsWicYY'}
	{elseif $contract_info->link1_type==4}
		{$link_1_part='1x7SC7QnuJlwbUwhyh83Fy9FnDUuQ_dF8'}
	{elseif $contract_info->link1_type==5}
		{$link_1_part='1Q0p-eq_RnfItKGMA_RXacfkVI2p7MPCQ'}
	{elseif $contract_info->link1_type==6}
		{$link_1_part='1JRE36BCCSMIjLssIcNdNuBMss6yMuznJ'}
	{elseif $contract_info->link1_type==7}
		{$link_1_part='1wHK8V9y0nZe15XBvE7W3sT2t65NXWcT9'}
	{elseif $contract_info->link1_type==8}
		{$link_1_part='1VdReZLV7cR6X2-5x5xANWe4wOdgvIhqr'}
	{elseif $contract_info->link1_type==9}
		{$link_1_part='1-VBqV2hOIrM4xHpCPMNfZ9LPzAkZ0XEc'}
	{elseif $contract_info->link1_type==10}
		{$link_1_part='1pVZL3tHprETWAV9AUk7AiZjaivr27whz'}
	{elseif $contract_info->link1_type==11}
		{$link_1_part='1bTNKjldF8fdowuzhV-lSO9kKQ8wJf24S'}
	{elseif $contract_info->link1_type==12}
		{$link_1_part='1gjtOgIkuAhoILw69F32vhKpR3dRY4V_R'}
	
	{elseif $contract_info->link1_type==13}
		{$link_1_part='14SCVrG7W40iD1Uf2blDX69oE4pPVT5Ye'}
	{elseif $contract_info->link1_type==14}
		{$link_1_part='10yxSHixqoKQ0dDSlLgGSEjPdRH4cvIG-'}
	{elseif $contract_info->link1_type==15}
		{$link_1_part='17d1qH6YuK_3ZdLR-GPo5IBluY3zW74VN'}
	{elseif $contract_info->link1_type==16}
		{$link_1_part='1Gq5mBtRxkAymR7uWP9WXLW8Txtsi01da'}
	{elseif $contract_info->link1_type==17}
		{$link_1_part='16sclZ-WbUvr10sEqgPmbFTOvLXLz3uAb'}
	{elseif $contract_info->link1_type==18}
		{$link_1_part='1p_2jPhsrfymvs3i57AjCvdRGfdM1EGiP'}
	{elseif $contract_info->link1_type==19}
		{$link_1_part='1uknXPOiahLo7qVilnxtpcYsUK-Ej-3Vz'}
	{elseif $contract_info->link1_type==20}
		{$link_1_part='10jxYyg4q5tKlrFnU2x8cr3VclVy6uluO'}
	{elseif $contract_info->link1_type==21}
		{$link_1_part='1UMbLb524WmHi3PS_xzkccs2MFy3kt8MQ'}
	{elseif $contract_info->link1_type==22}
		{$link_1_part='1FkUyEwsQf8_U5UGDDNYb3KtQvTJYxSX3'}
	{elseif $contract_info->link1_type==23}
		{$link_1_part='1BqMeS9qaWUbiNto0282d5z3cyc16Zlu0'}
	{elseif $contract_info->link1_type==24}
		{$link_1_part='17fg0bZOIwtwXzpysGZKZP0dRnqDJnnD6'}
	{/if}

	{if $link_1_part}
		<a href="https://drive.google.com/file/d/{$link_1_part}" target="_blank">https://drive.google.com/file/d/{$link_1_part}</a>
	{/if}

</p>
{/if}



<br>

<hr>

<br>
<br>
<br>
<h1>House Rules</h1>

<p>Outpost provides House Rules to assure a safe and productive environment. If a subtenant breaks any of the House Rules, Outpost reserves the right not to renew or extend the sublease.</p>
<p>These House Rules are incorporated into the sublease.  By adopting these House Rules, subtenant understands that subtenant is obligated to follow the rules and any violations thereof are subject to the penalties and remedies set forth herein or in any of the incorporated agreements.</p>
<h4>Move-in</h4>
<ul>
<li>When subtenant moves into the premises, subtenant  will be required to furnish a valid government photo ID card and update all contact information for the Property Manager.</li>
<li>Property Manager is authorized to perform a background check of all subtenants, and deny tenancy based on false information provided in connection therewith.</li>
</ul>

<h4>Guests</h4>
<ul>
<li>Unless otherwise permitted in writing pursuant to this Agreement, subtenants are not permitted overnight guests on the premises; on a common couches, common areas, in hallways or other common areas.</li>
<li>Subtenants are responsible for the appropriate behavior of their guests. Should subtenants’s guest(s) not behave responsibly and appropriately in accordance with the same rules and policy which subtenants is obligated to abide by, they will be asked to leave immediately.</li>
<li>Should subtenant fail to comply with the aforementioned obligations, Owner/Landlord and/or Property Manager may, at its sole discretion, terminate the sublease and require that subtenant and their guest(s) vacate the premises.</li>
<li>Outpost reserves the right to curtail or even revoke the guest policy at Outpost’s sole discretion, if the revocation is for the safety of its members.</li>
</ul>

<h4>Residential Purposes Only</h4>
<ul>
	<li>Subtenant sublease and rights as a subtenant are for residential purposes only. subtenants may not sell or market any products or services to any other subtenants, subtenants or guests on the Premises.</li>
</ul>

<h4>Cleanliness</h4>
<ul>
	<li>In common areas and common kitchens subtenant will wash all kitchen appliances it uses each time after using them and will clean the sink of any food remnants it caused to be there.</li>
	<li>Subtenant will leave no dishes or kitchen equipment in the sink of the common kitchens or common areas.  Repeated violations of this rule can lead to the termination of subtenant’s Lease. Owner/Landlord and/or Property Manager reserves the right to check the cameras to identify who is violating this rule. Owner/Landlord and/or Property Manager only checks cameras once other subtenants or House Leaders notify us of a violation.</li>
	<li>Subtenants with other roommates will have the responsibility of taking out the trash, wiping down the countertops, and emptying/running the dishwasher.</li>
	<li>Subtenants are responsible for separating all waste by placing all garbage in its designated container for:
		<ol type="a">
		<li>Plastic Product</li>
		<li>Glass and Metal Products</li>
		<li>Paper Products</li>
		</ul>
	</li>
	<li>Subtenants may share fridge and freezer with their roommates.</li>
	<li>Subtenant will not leave their belongings in the common areas of the property. Any such mislaid belongings may be removed and placed in a Lost and Found box.</li>
	<li>Subtenant will clean the bathrooms in common areas of the premises after they use the bathroom. subtenant will make sure to leave the bathrooms in the condition it was found after Property Manager’s housekeeper has cleaned it.</li>
	<li>Subtenant will remove hair from the drains to avoid clogging. This include the sink and shower drains.</li>
	<li>If Subtenant clogs the toilet, Subtenant is responsible for unclogging it with the provided bathroom plunger.</li>
	<li>Subtenants are required to keep their bedrooms and common areas clean, sanitary, and organized.</li>
	<li>Property Manager shall provide cleaning services on a bi-weekly basis for all common areas and bathrooms. During those cleaning days, subtenants should organize their personal belongings in a way that allows the cleaners to mop and sweep the floor. The service schedule/frequency may be amended according to governmental restrictions or to provide safety for subtenants and/or employees of the company.</li>
	<li>Occasionally Owner/Landlord and/or Property Manager is dependent on third party services, including but not limited to, service companies for extermination, service of the equipment and appliances, plumbing, electrical, structural, internet, gas, furniture service, and air-conditioning. Neither Property Manager nor Current subtenant(s) make any representations as to its obligations which are otherwise considered Owner/Landlord’s obligations.</li>
</ul>

<h4>Safety and Security</h4>
<ul>
	<li>Subtenants will turn off all electronic devices in the common areas when not in use.</li>
	<li>Subtenant will check and turn off oven and gas when not in use.</li>
	<li>Smoking/illicit drugs are not allowed anywhere inside or in front of the Building. Smoking of legal product is permitted in legally accessible rooftops, backyards, courtyards, front porches, front steps, or any other outdoor common areas on the premises.</li>
	<li>Dogs and Pets are not allowed in the Building. Service dogs should be indicated in the sublease prior to move-in during Agreement signing.</li>
	<li>Tampering with security cameras and smoke detectors, locks, or keypads is forbidden. Cost associated with fixing or sending Landlord Personnel to turn ON security cameras will be reimbursed from subtenant Security Deposit on the $50/case basis.</li>
	<li>Security cameras are installed in common areas and entrances of the Building. All the records of cameras are owned by Owner/Landlord and/or Property Manager, are automatically erased after one (1) week and used for security purposes only.  Access to the recordings is granted only with Outpost’s approval, unless otherwise required by law.  No cameras will be monitored, only checked in instances of potential agreement violations and to ensure the safety of all subtenants and subsubtenants.</li>
	<li>Subtenants consent to being photographed and/or videotaped in public areas and during Property Manager-sponsored events. These photographs and videos can be used in Outpost or its affiliates social media accounts, websites and blogs, newsletters, media content.</li>
	<li>Subtenants shall not insert any metal object in the microwave.</li>
	<li>The USA electrical system is 110 V. subtenants will not plug in electronics that cannot handle this voltage. Please check your electronics for any risk.</li>
	<li>Subtenants will not affix anything to windows, walls, or any other part of the Premises without the consent of Owner/Landlord and/or Property Manager.</li>
	<li>Subtenant will be given access to the house key or code. subtenant may not share their key or code with anyone other than Property Manager. This includes friends, guests, and/or other Members.</li>
	<li>Owner/Landlord and/or Property Manager Personnel including but not limited to Cleaners, House Leaders, Community Manager, Service Personnel may enter common spaces of the Premises during the regular business hours without notice.</li>
	<li>Owner/Landlord and/or Property Manager Personnel may enter Premises in the event of an emergency, or with 12 hours / reasonable notice.</li>
</ul>

<h4>Noise and Nuissance</h4>
<ul>
	<li>During Quiet Hours, subtenants shall not play loud music, watch television loudly, talk loudly, sing loudly or engage in any other actions producing loud noises, unless otherwise permitted by Property Manager.</li>
	<li>Weekday Quiet Hours (Sunday through Thursday): 10 PM to  9 AM.</li> 
	<li>Weekend Quiet Hours (Friday and Saturday): 11:30 PM to 10 AM.</li> 
	<li>Property Manager may reduce Quiet Hours at its sole discretion.</li>
	<li>If, for any reason, other subtenants or subsubtenants are affected by the smoking habits taking place on the premises, Property Manager reserves the right to require any subtenant smoking to move to an area that will not affect the other subtenants/subsubtenants. This may require that subtenants smoke off the premises.</li>
	<li>All cigarette butts must be disposed of properly and may not be tossed on the ground. It is not Owner/Landord and/or Property Manager’s responsibility to provide proper disposal of cigarettes, however it is the subtenant’s responsibility to dispose of it properly.</li> 
	<li>Any unauthorized parties are forbidden in on the premises. Violation of this rule can lead to the termination of the sublease.</li> 
	<li>Noise Tracking devices are installed in the cameras of the premises.</li>
	<li>No group loitering is permitted outside the premises, in the corridors or common areas of the building or outside the building unless otherwise permitted by Property Manager.</li>
	<li>No unauthorized use of Torrents or other violations of any intellectual property rights is permitted using Property Manager-provided WiFi.  Property Manager reserves the right to block any Property Manager-provided WiFi or other Internet Service Provider for up to 24 hours.</li>
</ul>  

<h4>Anti-Harassment and Anti-Discrimination Policy</h4>
<ul>
	<li>This policy applies to and prohibits all forms of illegal harassment and discrimination, not only sexual harassment. Accordingly, Owner/Landlord and/or Property Manager absolutely prohibits harassment or discrimination based on sex, age, disability, perceived disability, marital status, personal appearance, sexual orientation, race, color, religion, national origin, veteran status or any other legally protected characteristic.</li>
	<li>Sexual Harassment:
	<ul>
		<li>Because confusion often arises concerning the meaning of sexual harassment in particular, it deserves special mention. Sexual harassment may take many forms, including the following:
			<ol type="a">
				<li>Offensive and unwelcome sexual invitations, whether or not the person submits to the invitation;</li>
				<li>Offensive and unwelcome conduct of a sexual nature, including sexually graphic spoken comments;</li> 
				<li>Offensive or suggestive images or graphics whether physically present in the premises or accessed or the possession of or use of sexually suggestive objects;</li>
				<li>Offensive and unwelcome physical contact of a sexual nature, including the touching of another’s body; the touching or display of one’s own body, or any similar contact.</li>
			</ul>
		</li>
	</ul>
	</li>
</ul>

<h4>Enforcement of Rules and Consequences of Violations</h4>
<p>Neither Owner/Landlord nor Property Manager monitors subtenants and neither would never want subtenants to feel monitored. Owner/Landlord and/or Property Manager’s goal is to make subtenants feel at home from the moment they arrive up to the moment they leave. In order to preserve this feeling of home, Property Manager has outlined these House Rules to communicate a vision of what home should be: a respectful, clean, comfortable space to connect with others. </p>

<p>In order to achieve this, subtenants must not only follow the rules, but report to Property Manager if and when rules are being broken. Property Manager cannot enforce violations of rules by subtenants that it is not aware of, therefore it is each subtenant’s responsibility to notify Property Manager when something is bothering them.</p>

<p>Please report all violations of the rules to <a href="mailto:customer.service@outpost-club.com" target="_blank">customer.service@outpost-club.com</a>. When reporting please include the time, place, and description of the violation. If the person reporting knows who is involved, Property Manager would appreciate if the person reporting provides that information as well but understand if they do not want to. Please understand that Property Manager may not be able to resolve the issue if it does not know who commits the violation.</p>

<p>If Property Manager has reason to believe that a subtenant has broken the rules, Property Manager reserves the right to issue warnings, and in circumstances where the violation is heinous and/or is a threat to the other subtenants/subsubtenants, Owner/Landlord and/or Property Manager reserves the right to terminate that violating subtenant’s sublease after warnings or immediately.</p> 


<div class="fx ch2">
	<div>
		<p>
			Ne-Bo Services Corporation, Overtenant<br>
			By: Alexander Kostromin<br>
			Position: CEO
		</p>
		<img src="design/{$settings->theme|escape}/images/c_signature2.png" alt="Signature Ne-Bo" width="180" />
		<br>
		<br>
	</div>
	<div>
		<p>
			Outpost Club, Inc., Subtenant<br>
			By: Sergii Starostin<br>
			Position: CEO<br>
			e-mail: <a href="mailto:customer.service@outpost-club.com" target="_blank">customer.service@outpost-club.com</a><br>
			phone: <a href="tel:+18337076611" target="_blank">+1-833-707-6611</a>
		</p>
		<img src="design/{$settings->theme|escape}/images/c_signature.png" alt="Signature Sergii Starostin" width="180" />
		<br>
		<br>
	</div>
</div>

<p>New Subtenant Acknowledgement</p>

{if $contract_info->signature4}
	<img src="{$contract_info->signature4}" alt="Signature {$contract_user->name|escape}" width="180" />
{/if}


<br>

<hr>

<br>
<br>
<br>


<h1>Disclosure of Information on Lead-Based Paint and/or Lead-Based Paint Hazards</h1>
<strong>Lead Warning Statement</strong>
<p>Housing built before 1978 may contain lead-based paint. Lead from paint, paint chips, and dust can pose health hazards if not managed properly. Lead exposure is especially harmful to young children and pregnant women. Before renting pre-1978 housing, lessors must disclose the presence of know lead-based paint and/or lead-based paint hazards in the dwelling. Lessees must also receive a federally approved pamphlet on lead poisoning prevention.</p>
<strong>Lessor’s Disclosure</strong>
<ul>
	<li>(a) Presence of lead-based paint and/or lead-based paint hazards (check (i) or (ii) below):
		<ul>
			<li>(i) [ ] Known lead-based paint and/or lead-based paint hazards are present in the housing (explain).</li>
			<li>(ii) [ X ] Lessor has no knowledge of lead-based paint and/or lead-based paint hazards in the housing.</li>
		</ul>
	</li>
	<li>(b) Records and reports available to the lessor (check (i) or (ii) below): 
	<ul>
		<li>(i) [ ] Lessor has provided the lessee with all available records and reports pertaining to lead-based paint and/or lead-based paint hazards in the housing (list documents below).</li>
		<li>(ii) [ X ] Lessor has no reports or records pertaining to lead-based paint and/or lead-based paint hazards in the housing.</li>
	</ul>
	</li>
</ul>
<strong>Lessee’s Acknowledgment (initial)</strong>
<ul>
	<li>(c) Lessee has received the pamphlet Protect Your Family from Lead in (d) Your Home.</li>
	<li>(d) Lessee has received copies of all information listed above.</li>
</ul>
<strong>Agent’s Acknowledgment (initial)</strong>
<ul>
	<li>(e) Agent has informed the lessor of the lessor’s obligations under 42 U.S.C. 4852d and is aware of his/her responsibility to ensure compliance.</li>
</ul>
<strong>Certification of Accuracy</strong>
<p>The following parties have reviewed the information above and certify, to the best of their knowledge, that the information they have provided is true and accurate.</p>

<p>OWNER: Outpost Club, Inc.<br/>
	DATE: <br/>
	SIGNATURE:<br/>
	{if $contract_info->signature}
	<img src="design/{$settings->theme|escape}/images/c_signature.png" alt="Signature Sergii Starostin" width="180" />
	{/if}
</p>

{foreach $contract_users as $user}
{if $user->id != $contract_user->id}
<p>TENANT NAME: {$user->name|escape}<br/>
	{if $user->log}
	DATE: {$user->log->date|date:'m/d/Y'}<br/>
	SIGNATURE:<br/>
	<img src="{$config->contracts_dir}{$contract_info->url}/signature-{$user->id}.png" alt="Signature {$user->name|escape}" width="180" />
	{/if}
</p>
{/if}
{/foreach}

<p>TENANT NAME: {$contract_user->name|escape}<br/>
{if $contract_info->signing == 1}
	DATE: {$contract_info->date_signing|date}<br/>
{/if}
	SIGNATURE:<br>
</p>

{if $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{/if} 

<br>

<hr>

<br>
<br>
<br>

<h1>SPRINKLER DISCLOSURE</h1>
<p>Pursuant to the New York State Real Property Law, Article 7, Section 231-a, all residential leases must contain a conspicuous notice as to the existence or non-existence of a Sprinkler System in the Leased Premises. A “Sprinkler System” is a system of piping and appurtenances designed and installed in accordance with generally accepted standards so that heat from a fire will automatically cause water to be discharged over the fire area to extinguish it or prevent its further spread (Executive Law of New York, Article 6-C, Section 155-a(5)).</p>
<p>Name of tenant(s): <strong>{foreach $contract_users as $u}{$u->name}{if !$u@last}, {/if}{/foreach}</strong></p>
<p>Leased Premises Address: <strong>{$contract_info->rental_address}</strong></p>
<p><strong>Check One:</strong></p>
<ul>
	<li>[ X ] There is <strong>NO</strong> Maintained and Operative Sprinkler System in the Leased Premises.</li>
	<li>[ ] There is a Maintained and Operative Sprinkler System in the Leased Premises.
		<ul>
			<li>-The Sprinkler System was maintained and inspected.</li>
		</ul>
	</li>
</ul>
 
<strong>Acknowledgment & Signatures:</strong>
<p>I, the Tenant(s), have read the disclosure set forth above. I understand that this notice, as to the existence or non-existence of a Sprinkler System, is being provided to me to help me make an informed decision about the Leased Premises in accordance with New York State Real Property Law Article 7, Section 231-a.</p>

<p>OWNER: Outpost Club, Inc.<br/>
	DATE: <br/>
	SIGNATURE:<br/>
	{if $contract_info->signature}
	<img src="design/{$settings->theme|escape}/images/c_signature.png" alt="Signature Sergii Starostin" width="180" />
	{/if}
</p>

<p>TENANT NAME: {$contract_user->name|escape}<br/>
{if $contract_info->signing == 1}
	DATE: {$contract_info->date_signing|date}<br/>
{/if}
	SIGNATURE:<br>
</p>

{if $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{/if} 
<br>

<hr>

<br>
<br>
<br>

<h1>Disclosure of Bedbug Infestation Rider</h1>
<div class="center">
	<p>State of New York</p>
	<p><strong>Division of Housing and Community Renewal</strong></p>
	<p>Office of Rent Administration</p>
	<p>WebSite: www.nysdhcr.gov</p>
	<br>
	<p><strong>NOTICE TO TENANT</strong></p>
	<p><strong>DISCLOSURE OF BEDBUG INFESTATION HISTORY</strong></p>
</div>

<p>Pursuant to the NYC Housing Maintenance Code, an owner/managing agent of residential rental property shall furnish to each tenant signing a vacancy lease a notice that sets forth the property's bedbug infestation history.</p>
<p>Name of tenant(s): <strong>{foreach $contract_users as $u}{$u->name}{if !$u@last}, {/if}{/foreach}</strong></p>
<p>Subject Premises: <strong>{$contract_info->rental_address}, {$apartment->name}</strong></p>
<p>Apt.#: {$apartment->name}</p>
<p>Date of vacancy lease: {$contract_info->date_from|date}</p>

<p>BEDBUG INFESTATION HISTORY (Only boxes checked apply)</p>
<ul>
	<li>[X] There is no history of any bedbug infestation within the past year in the building or in any apartment.</li>
	<li>[ ] During the past year the building had a bedbug infestation history that has been the subject of eradication measures. The location of the infestation was on the floor(s).</li>
	<li>[ ] During the past year the building had a bedbug infestation history on the floor(s) and it has not been the subject of eradication measures.</li>
	<li>[ ] During the past year the apartment had a bedbug infestation history and eradication measures were employed. [ ] During the past year the apartment had a bedbug infestation history and eradication measures were not employed.</li>
	<li>[ ] Other: -</li>
</ul>

<p>OWNER: Outpost Club, Inc.<br/>
	DATE: <br/>
	SIGNATURE:<br/>
	{if $contract_info->signature}
	<img src="design/{$settings->theme|escape}/images/c_signature.png" alt="Signature Sergii Starostin" width="180" />
	{/if}
</p>

{foreach $contract_users as $user}
{if $user->id != $contract_user->id}
<p>TENANT NAME: {$user->name|escape}<br/>
	{if $user->log}
	DATE: {$user->log->date|date:'m/d/Y'}<br/>
	SIGNATURE:<br/>
	<img src="{$config->contracts_dir}{$contract_info->url}/signature-{$user->id}.png" alt="Signature {$user->name|escape}" width="180" />
	{/if}
</p>
{/if}
{/foreach}

<p>TENANT NAME: {$contract_user->name|escape}<br/>
{if $contract_info->signing == 1}
	DATE: {$contract_info->date_signing|date}<br/>
{/if}
	SIGNATURE:<br>
</p>

{if $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{/if} 
<br>

<hr>

<br>
<br>
<br>

<h1>Appendix A. WINDOW GUARDS REQUIRED</h1>
<h2>Lease Notice to Tenant</h2>

<p>You are required by law to have window guards installed in all windows if a child 10 years of age or younger lives in your apartment.</p>
<p>Your landlord is required by law to install window guards in your apartment:</p>
<p>if a child 10 years of age or younger lives in your apartment,</p>
<p>OR</p>
<p>if you ask him to install window guards at any time (you need not give a reason).</p>
<p>It is a violation of law to refuse, interfere with installation, or remove window guards where required.</p> 
<p><strong>CHECK ONE</strong></p>
{if $contract_info->signature}
<ul>
	<li>[{if $contract_info->options['children']==1}x{else} {/if}] CHILDREN 10 YEARS OF AGE OR YOUNGER LIVE IN MY APARTMENT</li>
	<li>[{if $contract_info->options['children']==2}x{else} {/if}] NO CHILDREN 10 YEARS OF AGE OR YOUNGER LIVE IN MY APARTMENT</li>
	<li>[{if $contract_info->options['children']==3}x{else} {/if}] I WANT WINDOW GUARDS EVEN THOUGH I HAVE NO CHILDREN 10 YEARS OF AGE OR YOUNGER</li>
</ul>
{/if}

{foreach $contract_users as $user}
{if $user->id != $contract_user->id}
<p>TENANT NAME: {$user->name|escape}<br/>
	{if $user->log}
	DATE: {$user->log->date|date:'m/d/Y'}<br/>
	SIGNATURE:<br/>
	<img src="{$config->contracts_dir}{$contract_info->url}/signature-{$user->id}.png" alt="Signature {$user->name|escape}" width="180" />
	{/if}
</p>
{/if}
{/foreach}


<p>TENANT NAME: {$contract_user->name|escape}<br/>
{if $contract_info->signing == 1}
	DATE: {$contract_info->date_signing|date}<br/>
{/if}
	SIGNATURE:<br>
</p>

{if $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{/if} 


<p>RETURN THIS FORM TO:</p>
<p>Owner/Manager: Outpost Club, Inc.<br/>
	By: Sergii Starostin<br/>
	Address: P.O. 780316 Maspeth, NY, 11378<br/>
	DATE: <br/>
	SIGNATURE: <br/>
	{if $contract_info->signature}
	<img src="design/{$settings->theme|escape}/images/c_signature.png" alt="Signature Sergii Starostin" width="180" />
	{/if}
</p>

<p>For Further Information Call: Window Falls Prevention (212) 676-2162 WF-013 (Rev. 11/02)</p>

<br>

<hr>

<br>
<br>
<br>

<h1>Basement Use Lease Addendum</h1>
<p>This Addendum made on <strong>{$contract_info->date_created|date}</strong> by and between <strong>{foreach $contract_users as $u}{$u->name}{if !$u@last}, {/if}{/foreach}</strong> (“Tenant”) and Outpost Club Inc (“Landlord”) shall become a part of and be incorporated into the attached Lease Agreement (“Lease”) dated <strong>{$contract_info->date_from|date}</strong> for <strong>{$apartment->name} at {$contract_info->rental_address}</strong> (“Apartment”).</p>
<ul>
	<li><strong>Basement.</strong> Tenant shall have limited access to the basement in the Apartment (“Basement”).</li>
	<li><strong>Use.</strong> The Tenant understands and agrees that the Basement shall only be used for the purpose of storage and not for living space.</li>
	<li><strong>No Storage of Dangerous Items.</strong> The Tenant understands and agrees that storage of any dangerous items in the Basement is strictly prohibited. Dangerous items include, but are not limited to, living animals, reptiles, insects, any hazardous, flammable, noxious, combustible materials or otherwise dangerous or illegal items that pose a risk or hazard to the safety of the Tenant and any other resident.</li>
	<li><strong>Tenant Responsibility for Storage.</strong> The Tenant understands and agrees that the Landlord has no liability whatsoever for any damage or loss to any items stored by the Tenant in the Basement, whether caused by theft, fire, flooding, or otherwise.</li>
	<li><strong>Indemnification of Landlord.</strong> The Tenant agrees to indemnify and hold the Landlord harmless from and against any and all claims, actions, suits, judgments and demands brought by any other party on account of or in connection with any activity associated with the Basement. This includes but is not limited to, any damages caused by fire, insects, liquid or hazardous materials, water, or theft.</li>
	<li><strong>Access by Landlord.</strong> Tenant understands and agrees that Landlord has the right, to visit basement without notice, to enter the Basement to make routine inspections or necessary repairs.</li>
	<li><strong>Abandoned Items.</strong> Any items remaining in the Basement after the term of the Lease, or any extension thereof, will be deemed abandoned and will be removed, sold or otherwise disposed of by the Landlord.</li>
	<li><strong>Revocation of Addendum.</strong> Landlord has, at its sole option, the right to revoke Tenant’s use of the Basement at any time. Tenant shall not be entitled to any damages incurred as a result of Landlord’s decision to revoke Tenant’s use of the Basement under this provision.</li>
	<li><strong>Control over Lease.</strong> The terms of this Addendum shall control over the terms of the Lease.</li>
	<li><strong>Binding effect.</strong> This Addendum shall bind all parties to the Lease and shall also bind all those succeeding to the rights of any party of the Lease.</li>
</ul>

<p>OWNER: Outpost Club, Inc.<br/>
	DATE: <br/>
	SIGNATURE:<br/>
	{if $contract_info->signature}
	<img src="design/{$settings->theme|escape}/images/c_signature.png" alt="Signature Sergii Starostin" width="180" />
	{/if}
</p>

{foreach $contract_users as $user}
{if $user->id != $contract_user->id}
<p>TENANT NAME: {$user->name|escape}<br/>
	{if $user->log}
	DATE: {$user->log->date|date:'m/d/Y'}<br/>
	SIGNATURE:<br/>
	<img src="{$config->contracts_dir}{$contract_info->url}/signature-{$user->id}.png" alt="Signature {$user->name|escape}" width="180" />
	{/if}
</p>
{/if}
{/foreach}

<p>TENANT NAME: {$contract_user->name|escape}<br/>
{if $contract_info->signing == 1}
	DATE: {$contract_info->date_signing|date}<br/>
{/if}
	SIGNATURE:<br>
</p>

{if $contract_info->signature}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{/if} 

<br>

<hr>

<br>
<br>
<br>


<h1>PROCEDURE FOR TENANTS REGARDING SUSPECTED GAS LEAKS</h1>
<p>The law requires the owner of the premises to advise tenants that when they suspect that a gas leak has occurred, they should take the following actions:</p>
<ul>
	<li>Quickly open nearby doors and windows and then leave the building immediately; do not attempt to locate the leak. Do not turn on or off any electrical appliances, do not smoke or light matches or lighters, and do not use a house-phone or cell-phone within the building;</li>
	<li>After leaving the building, from a safe distance away from the building, call 911 immediately to report the suspected gas leak;</li>
	<li>After calling 911, call the gas service provider for this building as follows:</li>
</ul>
<div class="fx ch2 sb">
	<div>
		Consolidated Edison <br>Provider
	</div>
	<div><a href="tel:+18007526633">1(800) 752-6633</a> <br>Number</div>
</div>
<br>
<div class="fx ch2 sb">
	<div>
		National Grid <br>Provider
	</div>
	<div><a href="tel:+17186434050">1(718) 643-4050</a> <br>Number</div>
</div>
<br>	
<h1>PROCEDIMIENTO PARA LOS INQUILINOS CUANDO HAY SOSPECHA DE GAS</h1>
<p>La ley requiere que el propietario de la casa o edificio informe a los inquilinos que cuando sospechan que se ha producido un escape de gas, deben tomar las siguientes medidas:</p>
<ul>
	<li>Abra rápidamente las puertas y ventanas cercanas y salga del edificio inmediatamente; No intente localizar el escape de gas. No encienda o apague ningún electrodoméstico, no fume ni encienda fósforos ni encendedores, y no utilice un teléfono de la casa o un teléfono celular dentro del edificio;</li>
	<li>Después de salir del edificio, a una distancia segura del edificio, llame al 911 inmediatamente para reportar sus sospechas;</li>
	<li>Después de llamar al 911, llame al proveedor de servicio de gas para este edificio, de la siguiente manera:</li>
</ul>
<div class="fx ch2 sb">
	<div>
		Consolidated Edison <br>Proveedor
	</div>
	<div><a href="tel:+18007526633">(800) 752-6633</a> <br>Telefono</div>
</div>
<br>
<div class="fx ch2 sb">
	<div>
		National Grid <br>Proveedor
	</div>
	<div><a href="tel:+17186434050">(718) 643-4050</a> <br>Telefono</div>
</div>
 <br><br>
<div class="fx ch2 sb">
	<div>Department of Housing Preservation and Development Interim Sample Notice</div>
	<div>June 2017</div>
</div>

<p>TENANT NAME: {$contract_user->name|escape}<br/>
{if $contract_info->signing == 1}
	DATE: {$contract_info->date_signing|date}<br/>
{/if}
	SIGNATURE:<br>
</p>

{if $contract_info->signature}
	<img src="{$contract_info->signature}" alt="Signature {$contract_user->name|escape}" width="180" />
{/if}
