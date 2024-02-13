{* Contract html *}


<h1>Outpost Roommate Agreement</h1>

<p>This document represents a legal contract that details the terms and liabilities of individuals residing in residential property, hereinafter referred to as the "Agreement".</p>

<h2>Section 1. The Parties & Property</h2>
<p>This agreement is supplemental to the Subtenant Addition Addendum and Sublease Agreement for you to join the current subtenancy among the existing subtenants.</p>

<p>For purposes of this Agreement, <strong>{$contract_user->first_name}{if $contract_user->middle_name} {$contract_user->middle_name}{/if} {$contract_user->last_name}</strong> shall be known as the "New Roommate".</p>

<p>The street address of the Property is <strong>{$contract_info->rental_address}</strong> in <strong>{$contract_info->rental_name|escape}</strong> and New Roomate will occupy 
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
<p>The New Roommate have the right to complete a Move-in Checklist at the time of possession.</p>

<h2>Section 4. Rent</h2>

{$invoice_first=$contract_info->invoices|first}
  
<p>The New Roommate agrees to pay in rent the amount of {$contract_info->price_month|convert} (US Dollars) due on the <strong>{(strtotime($invoice_first->date_from|date)-(10*24*60*60))|date_format:'%e'} of every month</strong>.</p> 

<p>The total amount of Rent payment for the whole period is {$contract_info->invoices_total|convert} (US Dollars).</p>


{* Monthly Membership *}
<p>Full Payment (first month rent and deposit) for the first Month should be paid no later than {(strtotime($contract_info->date|date)+ (2*24*60*60))|date_format:'%b %e, %Y'}.</p>
<p>The payment of the Monthly Membership Fee for each of the following month’s must be paid by the Member according to the following schedule:
<ol>
	{foreach $contract_info->invoices as $i}
		{if $i@iteration>1}
			<li>Payment for {$i->date_from|date:'M j'} - {$i->date_to|date:'M j'}: {$i->price|convert} USD, to be paid on or before {$i->date_for_payment|date:'M j'}</li>
		{/if}
	{/foreach}
</ol>
</p>
{* Monthly Membership (end) *}
  
<p>Rental Payment Instructions: Outpost Club, Inc.</p>
  
<p>The Roommates understand that the Landlord or Overtenant of the property can evict all of the Roommates if the landlord does not receive the rental payments in full and on time.</p>
  
<h2>Section 5. Mutual Respect</h2>
<p>All Roommates agree to be respectful of each other and each other’s property, personal belongings and space.</p>

<h2>Section 6. Additional Agreements </h2>
<p>In Addition to this Agreement, the Roommates have each signed the Sublease Agreement via any applicable Sublease Addendums.</p> 
  
<h2>Section 7. Lead Paint Disclosure </h2>
<p>The Property was built before 1978 and a Lead Paint Disclosure Addendum is attached.</p> 
  
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

<p>
Outpost Club Inc<br/>
Sergii Starostin, CEO<br/>
<a href="mailto:customer.service@outpost-club.com" target="_blank">customer.service@outpost-club.com</a><br/>
DATE: {$contract_info->date_created|date:'m/d/Y'}<br/>
SIGNATURE:
</p>
<img src="design/{$settings->theme|escape}/images/c_signature.png" alt="Signature Sergii Starostin" width="180" />
<p><br/></p>

<p>
MEMBER NAME: {$contract_user->name|escape}<br/>
{if $contract_info->signing}
	DATE: {$contract_info->date_signing|date:'m/d/Y'}<br/>
{/if}
{if $contract_info->signature}
	MEMBER SIGNATURE:<br>
	<img src="{$contract_info->signature}" alt="Signature {$contract_user->name|escape}" width="180" />
{/if}

</p>
