{* Contract html *}


<h1>Outpost Roommate Agreement</h1>

<p>This document represents a legal contract that details the terms and liabilities of individuals residing in residential property, hereinafter referred to as the "Agreement".</p>

<h2>Section 1. The Parties & Property</h2>
<p>This agreement is supplemental to the Subtenant Addition Addendum and Sublease Agreement for you to join the current subtenancy among the existing subtenants.</p>

<p>For purposes of this Agreement, <strong>{$contract_user->first_name}{if $contract_user->middle_name} {$contract_user->middle_name}{/if} {$contract_user->last_name}</strong> shall be known as the "New Roommate".</p>

<p>The street address of the Property is <strong>{$contract_info->rental_address}</strong> in <strong>{$contract_info->rental_name|escape}</strong> and New Roomate will occupy {if $apartment}<strong>{$apartment->name}{if $bed} / {$bed->name}{/if}</strong>{/if}
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
  
<p>Rental Payment Instructions: Each month Outpost Club Inc. sends invoice to the New Roommate e-mail address. New Roommate need to register at the <a href="/" target="_blank">ne-bo.com</a> to receive access to all documents, invoices and maintenance tickets system. </p>

<p>New Roommate must receive temporary password to access <a href="/" target="_blank">ne-bo.com</a>. In case support is needed please reach out to <a href="mailto:customer.service@outpost-club.com">customer.service@outpost-club.com</a> or <a href="tel:+18337076611">+1 (833) 707-6611</a></p>
  
<p>The Roommates understand that the Landlord or Overtenant of the property can evict all of the Roommates if the landlord does not receive the rental payments in full and on time.</p>
  
<h2>Section 5. Mutual Respect</h2>
<p>All Roommates agree to be respectful of each other and each other’s property, personal belongings and space.</p>

<h2>Section 6. Additional Agreements </h2>
<p>In Addition to this Agreement, the Roommates have each signed the Sublease Agreement via any applicable Sublease Addendums.</p> 
  
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

{if !$contract_info->signature2}
	<div id="signature2_block">
	    <p class="signature_title">Signature:</p>
		<div class="wrapper">
			<canvas id="signature2-pad" class="signature-pad" width=460 height=240></canvas>
		</div>
	    <input id="signature2" type="hidden" name="signature2" value="">
	    <div class="button_block">
	        <div id="clear2" class="clear">Clear</div>
	        <div id="save2" class="save">Sign</div>
	    </div>
	  
	</div><!-- signature_block -->
	<div id="signature2_img"></div>


	{literal}
	<script>
	var signature2 = 0;
	var canvas2 = document.getElementById('signature2-pad');

	// function resizeCanvas2() {
	//     var ratio =  Math.max(window.devicePixelRatio || 1, 1);
	//     canvas2.width = canvas2.offsetWidth * ratio;
	//     canvas2.height = canvas2.offsetHeight * ratio;
	//     canvas2.getContext("2d").scale(ratio, ratio);
	// }
	function resizeCanvas2() {
	    canvas2.width = canvas2.offsetWidth;
	    canvas2.height = canvas2.offsetHeight;
	}
	//window.onresize = resizeCanvas2;
	resizeCanvas2();

	var signaturePad2 = new SignaturePad(canvas2, {
		backgroundColor: 'rgb(255, 255, 255)', // necessary for saving image as JPEG; can be removed is only saving as PNG or SVG
		penColor: 'rgb(1, 31, 117)'
	});

	function saveSignature2(){
		var signature2_input = document.getElementById('signature2');
		if(signature2_input.value == '')
		{
			if(signature2===0 && signaturePad2.isEmpty())
		        return alert("Please provide a signature first");
		    var data2 = signaturePad2.toDataURL('image/png');
		    var img_data2 = canvas2.toDataURL('image/png');
		    document.getElementById('signature2_img').innerHTML += '<img src="'+img_data2+'" width="180" />';
		    document.getElementById('signature2_block').hidden = true;
		    signature2_input.value = img_data2;

		    signaturePad2.clear();
		    delete data2;
		    delete img_data2;
		    delete signaturePad2;
		    signature2 = 1;
		    delete canvas2;
		}	
	}
	document.getElementById('save2').addEventListener('click', function () {
	    saveSignature2();
	});

	document.getElementById('clear2').addEventListener('click', function () {
		signaturePad2.clear();
	});


	</script>
	{/literal}

{/if}

{if $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{/if} 

<br>

<hr>

<br>
<br>
<br>

<h1>Subtenant Addition Addendum</h1>

<p>This Subtenant Addition Addendum is hereby a part for all purposes of the Sublease Agreement between: Ne-Bo Services Corporation, as	OVERTENANT 	and Outpost Club, Inc., as CURRENT SUBTENANT(s) for the property known as: {*{$contract_info->rental_name|escape}*}<strong>{$contract_info->rental_address}, {$apartment->name}{if $bed} / {$bed->name}{/if}</strong> OVERTENANT and CURRENT SUBTENANT(S) hereby	acknowledge	and agree	that  <strong>{$contract_user->name|escape}</strong> will be moving into the Property and shall become a SUBTENANT under the terms and conditions set forth in the Sublease Agreement referenced above.  SUBTENANT acknowledges receipt of the Sublease Agreement. All parties to this Subtenant Addition Addendum agree to be jointly and severally liable under the Lease Agreement for all amounts due and owing, whether past due, currently due or to be owed in the future, and all parties agree to abide by all terms of the Sublease Agreement.</p>

<p>All parties below hereby acknowledge and agree that upon vacating the Property any and all refunds of monies paid in advance under the terms of the Sublease Agreement, to include, but not limited to, security deposits and advance rent, shall be paid to all of the SUBTENANTS, as applicable, which shall include all NEW TENANTS added to the Lease Agreement.</p>
<p>Any extensions of the Sublease Agreement, this Subtenant Addition Addendum and Roommate Agreement must be expressly approved by Overtenant.</p>

<p>SUBTENANT may terminate this sublease and receive a FULL REFUND of any security deposit it has paid as well as the first month’s rent deposited if such termination is more than sixty (60) days prior to the Sublease start date.  If the security deposit was paid through HelloRented, the security deposit will be refunded to HelloRented, not SUBTENANT; provided, however, that Overtenant is not responsible to pay any fees SUBTENANT may owe separately to HelloRented for their service. The notice of cancellation should be sent to <a href="mailto:customer.service@outpost-club.com">customer.service@outpost-club.com</a> Oral or text requests will not be considered.</p>
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree1" for="agree1">I agree</label><input type="checkbox" id="agree1" name="agree1" class="agree" value="1"></p>


<p>If SUBTENANT terminates this sublease less than sixty (60) days but more than thirty (30) days prior to the Sublease start date, SUBTENANT shall receive a refund on their first month’s rent but not any security deposit it has paid; provided, however, that SUBTENANT may elect to apply the security deposit amount as a credit toward another sublease at a different property for any lease of which Overtenant is also an Overtenant and is offering a sublease.  Such credit will expire one (1) year after the notice of cancellation.  Overtenant is not responsible to pay any fees SUBTENANT may owe separately to HelloRented for their service. The notice of cancellation should be sent to <a href="mailto:customer.service@outpost-club.com">customer.service@outpost-club.com</a>. Oral or text requests will not be considered.</p>
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree2" for="agree2">I agree</label><input type="checkbox" id="agree2" name="agree2" class="agree" value="1"></p>


<p>If SUBTENANT terminates this sublease less than thirty (30)  days prior to the Sublease start date, SUBTENANT shall not receive a refund on their first month’s rent or any security deposit it has paid. Overtenant is not responsible to pay any fees SUBTENANT may owe separately to HelloRented for their service.</p>
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree3" for="agree3">I agree</label><input type="checkbox" id="agree3" name="agree3" class="agree" value="1"></p>

<p>Any applicable taxes will be retained and remitted.</p>

<p>If SUBTENANT is more than five (5) days late in making any required rent payments, OVERTENANT reserves to terminate the Sublease Agreement and to charge a $50 late fee.</p>

<p>In the event that the bank for the account used above returns the transaction for Insufficient Funds, SUBTENANT will be assessed a $35.00 NSF Fee.</p>

<p>Attempted chargebacks for non-fraudulent transactions through the Ne-Bo payments processing system via Stripe, Credit / Debit Card, Paypal or ACH will be subject to investigation and these individuals will be prosecuted to the fullest extent of the law.</p>
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree4" for="agree4">I agree</label><input type="checkbox" id="agree4" name="agree4" class="agree" value="1"></p>

<p>SUBTENANTS shall be permitted to extend the Sublease Agreement only with the prior written approval of OVERTENANT. Any extension requests to the Sublease should be submitted to <a href="mailto:customer.service@outpost-club.com">customer.service@outpost-club.com</a> not later than 30 days before end of individual term. Oral or text requests will not be considered.</p> 
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree5" for="agree5">I agree</label><input type="checkbox" id="agree5" name="agree5" class="agree" value="1"></p>

<p>Abandonment of premises and unclaimed property</p>
<p>In the event the Subtenant abandons the premises, i.e. is not current with rent payments and is not living full time at the premises, the Overtenant may dispose of the Subtenants remaining personal property and fixtures as provided by state law. The Subtenant agrees that the Overtenant will determine if abandoned property is of value or to be treated as trash. Property of value will be inventoried and stored at the Subtenants expense. There will be a daily storage charge assess by the Overtenant depending on the size of valuables and the difficulty of storing the valuables. All charges must be paid before the stored items will be released by the Overtenant to the Subtenant. After sixty days, the Subtenant agrees that Overtenant may sell or dispose of the Subtenants items.</p>

<p>SUBTENANT may not further sublet the Apartment.</p>

<p>
OVERTENANT NAME:  Ne-Bo Services Corporation<br/>
DATE: {$contract_info->date_created|date:'m/d/Y'}<br/>
{*
	<img src="design/{$settings->theme|escape}/images/c_signature2.png" alt="Signature Ne-Bo" width="180" />
*}
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
</p>

{if !$contract_info->signature3}
	<div id="signature3_block">
	    <p class="signature_title">Signature:</p>
		<div class="wrapper">
			<canvas id="signature3-pad" class="signature-pad" width=460 height=240></canvas>
		</div>
	    <input id="signature3" type="hidden" name="signature3" value="">
	    <div class="button_block">
	        <div id="clear3" class="clear">Clear</div>
	        <div id="save3" class="save">Sign</div>
	    </div>
	  
	</div><!-- signature_block -->
	<div id="signature3_img"></div>


	{literal}
	<script>
	var signature3 = 0;
	var canvas3 = document.getElementById('signature3-pad');

	// function resizeCanvas3() {
	//     var ratio =  Math.max(window.devicePixelRatio || 1, 1);
	//     canvas3.width = canvas3.offsetWidth * ratio;
	//     canvas3.height = canvas3.offsetHeight * ratio;
	//     canvas3.getContext("2d").scale(ratio, ratio);
	// }
	function resizeCanvas3() {
	    canvas3.width = canvas3.offsetWidth;
	    canvas3.height = canvas3.offsetHeight;
	}
	//window.onresize = resizeCanvas;
	resizeCanvas3();

	var signaturePad3 = new SignaturePad(canvas3, {
		backgroundColor: 'rgb(255, 255, 255)', // necessary for saving image as JPEG; can be removed is only saving as PNG or SVG
		penColor: 'rgb(1, 31, 117)'
	});

	function saveSignature3(){
		var signature3_input = document.getElementById('signature3');
		if(signature3_input.value == '')
		{
			if(signature3===0 && signaturePad3.isEmpty())
		        return alert("Please provide a signature first");
		    var data3 = signaturePad3.toDataURL('image/png');
		    var img_data3 = canvas3.toDataURL('image/png');
		    document.getElementById('signature3_img').innerHTML += '<img src="'+img_data3+'" width="180" />';
		    document.getElementById('signature3_block').hidden = true;
		    signature3_input.value = img_data3;


		    signaturePad3.clear();
		    delete data3;
		    delete img_data3;
		    delete signaturePad3;
		    signature3 = 1;
		    delete canvas3;
		}	
	}
	document.getElementById('save3').addEventListener('click', function () {
	    saveSignature3();
	});

	document.getElementById('clear3').addEventListener('click', function () {
		signaturePad3.clear();
	});


	</script>
	{/literal}

{/if}

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

<p>These House Rules are incorporated into the Sublease Agreement (Appendix _B_), the Subtenant Addition Addendum (Appendix _C_), and the Roommate Agreement (Appendix _D_).  By adopting these House Rules, you understand that you are obligated to follow the rules and any violations thereof are subject to the penalties and remedies set forth herein or in any of the incorporated agreements.</p>
<h4>Move-in</h4>
<ol>
<li>When Subtenant moves into the premises, they will be required to furnish a valid government photo ID card and update all contact information.</li>
<li>Tenant is authorized to perform a background check of all Subtenants, and deny tenancy based on false information provided in connection therewith.</li>
<li>Standard moving hours are between 3 p.m. and 9 p.m.</li>
<li>If Subtenant moves in between the hours of 9 p.m. and 12 a.m. an additional $30 convenience fee shall be due upon arrival.</li>
<li>If Subtenant moves in between the hours of 12 a.m. and 8 a.m. an additional $70 convenience fee shall be due upon arrival.</li>
</ol>

<h4>Guests</h4>
<ol>
<li>Unless otherwise permitted in writing pursuant to this Agreement, Subtenants are not permitted overnight guests on the premises.</li>
<li>Subtenant is responsible for the appropriate behavior of your guests. Should Subtenant’s guest(s) not behave responsibly and appropriately in accordance with the same rules and policy which Subtenant is obligated to abide by, they will be asked to leave immediately.</li>
<li>Should Subtenant fail to comply with the aforementioned obligations, Overtenant may, at its sole discretion, terminate Subtenant’s Sublease Agreement and require that Subtenant and their guest(s) vacate the premises.</li>
<li>Outpost Club reserves the right to curtail or even revoke the guest policy at Outpost Club’s sole discretion, if the revocation is for the safety of its members.</li>
</ol>

<h4>Residential Purposes Only</h4>
<ol>
	<li>Subtenant’s Sublease and rights as a subtenant are for residential purposes only.  Subtenants may not sell or market any products or services to any other tenants, subtenants or guests on the Premises.</li>
</ol>

<h4>Cleanliness</h4>
<ol>
	<li>It is recommended that Subtenant will remove their shoes and keep their shoes on the shoe rack once the Subtenant is inside the Apartment.</li>
	<li>Subtenant will wash all kitchen appliances it uses each time after using them and will clean the sink of any food remnants it caused to be there.</li>
	<li>Subtenants will leave no dishes or kitchen equipment in the sink.  Repeated violations of this rule can lead to the termination of Subtenant’s Sublease Agreement. Tenant reserves the right to check the cameras to identify who is violating this rule. Ne-Bo only checks cameras once our Members or House Leaders notify us of a violation.</li>
	<li>On the agreed schedule set forth in the Roommate Agreement, Subtenants will have the responsibility of taking out the trash, wiping down the countertops, and emptying/running the dishwasher.</li>
	<li>Subtenants are responsible for separating all waste by placing all garbage in its designated container for:
		<ol type="a">
		<li>Plastic Product</li>
		<li>Glass and Metal Products</li>
		<li>Paper Products</li>
		</ol>
	</li>
	<li>Subtenants share fridge and freezer with their roommates.  Please be respectful of each other’s space and food.</li>
	<li>Subtenant will not leave their belongings in the common areas.  Any such mislaid belongings may be removed and placed in a Lost and Found box.</li>
	<li>Subtenants will clean the bathroom after they use the bathroom. This includes cleaning the shower, sink, toilet, mirrors, or anything else in the bathroom after use. Subtenant will make sure to leave the bathroom in the condition it was found after Tenant’s housekeeper has cleaned it.</li>
	<li>Subtenant will remove hair from the drains to avoid clogging. This include the sink and shower drains.</li>
	<li>If Subtenant clogs the toilet, Subtenant is responsible for unclogging it with the provided bathroom plunger.</li>
	<li>Subtenants are required to keep their bedrooms and common areas clean, sanitary, and organized.</li>
	<li>Tenant shall provide cleaning services on a bi-weekly basis for all common areas and bathrooms. During those cleaning days, Subtenants should organize their personal belongings in a way that allows the cleaners to mop and sweep the floor. Cleaning in Subtenant bedrooms is not provided; however, Subtenants can request that their bedrooms or common rooms be cleaned by raising a maintenance ticket in the customer portal at ne-bo.com. The service schedule/frequency may be amended according to governmental restrictions or to provide safety for tenants and/or employees of the company.</li>
	<li>Occasionally Tenant is dependent on third party services, including but not limited to, service companies for extermination, service of the equipment and appliances, plumbing, electrical, structural, internet, gas, furniture service, and air-conditioning.  Neither Overtenant nor Current Subtenant make any representations as to its obligations which are otherwise considered Landlord’s obligations.</li>
</ol>

<h4>Safety and Security</h4>
<ol>
	<li>Subtenants will turn off all electronic devices in the common areas when not in use.</li>
	<li>Subtenants will check and turn off oven and gas when not in use.</li>
	<li>Tenant recommends minimizing excessive alcohol consumption in the Apartment and on the Premises.</li>
	<li>Smoking/illicit drugs are not allowed anywhere inside or in front of the Building. Smoking of legal product is permitted in legally accessible rooftops, backyards, courtyards, front porches, front steps, or any other outdoor common areas on the premises.</li>
	<li>Dogs and Pets are not allowed in the Ne-Bo premises. Service dogs should be indicated in the Lease prior to move-in during Agreement signing.</li>
	<li>Tampering with cameras and smoke detectors, locks, or keypads is fordbidden. Cost associated with fixing or sending Tenant Personnel to turn ON security cameras will be reimbursed from Subtenant Security Deposit on the $50/case basis.</li>
	<li>Security cameras are installed in common areas and entrances of the Building. All the records of cameras are owned by Tenant, are automatically erased after 1 week and used for security purposes only.  Access to the recordings is granted only with Tenant’s approval, unless otherwise required by law.  No cameras will be monitored, only checked in instances of potential agreement violations and to ensure the safety of all tenants and subtenants.</li>
	<li>Subtenants consent to being photographed and/or videotaped in public areas and during Tenant-sponsored events. These footage can be used in Outpost club or its affiliates social media accounts, websites and blogs, newsletters, media content.</li>
	<li>Subtenants shall not insert any metal object in the microwave.</li>
	<li>The USA electrical system is 110 V. Subtenants will not plug in electronics that cannot handle this voltage. Please check your electronics for any risk.</li>
	<li>Subtenants will not affix anything to windows, walls, or any other part of the Premises without the consent of Tenant.</li>
	<li>The Member will be given access to the house be key or code. The Member may not share their key or code with anyone other than Ne-Bo Management. This includes friends, guests, and other Members.</li>
	<li>Due to the nation of coliving operations, which include additional services, Tenant Personnel including but not limited to Cleaners, House Leaders, Community Manager, Service Personnel may enter common spaces of Subtenant Units during the regular business hours without notice.</li>
	<li>Tenant Personnel may enter Subtenant Bedrooms in the event of an emergency, or with 12 hours / reasonable notice. </li>
</ol>

<h4>Noise and Nuissance</h4>
<ol>
	<li>During Quiet Hours, Subtenants shall not play loud music, watch television loudly, talk loudly, sing loudly or engage in any other actions producing loud noises, unless otherwise permitted by Tenant.</li>
	<li>Weekday Quiet Hours (Sunday through Thursday): 10 PM to  9 AM.</li> 
	<li>Weekend Quiet Hours (Friday and Saturday): 11:30 PM to 10 AM.</li> 
	<li>Tenant may reduce Quiet Hours at its sole discretion.</li>
	<li>If, for any reason, other tenants or subtenants are affected by the smoking habits taking place on the premises, Tenant reserves the right to require any subtenant smoking to move to an area that will not affect the other tenants/subtenants. This may require that subtenants smoke off the premises.</li>
	<li>All cigarette butts must be disposed of properly and may not be tossed on the ground. It is not Tenant’s responsibility to provide proper disposal of cigarettes, however it is the Subtenant’s responsibility to dispose of it properly.</li> 
	<li>Any unauthorized parties are forbidden in on the premises. Violation of this rule can lead to the termination of Subtenant’s Sublease Agreement.</li> 
	<li>Noise Tracking devices are installed in the cameras of the premises.</li>
	<li>No group loitering is permitted outside the premises, in the corridors or common areas of the building or outside the building unless otherwise permitted by Tenant.</li>
	<li>No unauthorized use of Torrents or other violations of any intellectual property rights is permitted using Tenant-provided WiFi.  Tenant reserves the right to block any Tenant-provided WiFi or other Internet Service Provider for up to 24 hours.</li>
</ol>  

<h4>Anti-Harassment and Anti-Discrimination Policy</h4>
<ol>
	<li>This policy applies to and prohibits all forms of illegal harassment and discrimination, not only sexual harassment. Accordingly, Tenant absolutely prohibits harassment or discrimination based on sex, age, disability, perceived disability, marital status, personal appearance, sexual orientation, race, color, religion, national origin, veteran status or any other legally protected characteristic.</li>
	<li>Sexual Harassment:
	<ul>
		<li>Because confusion often arises concerning the meaning of sexual harassment in particular, it deserves special mention. Sexual harassment may take many forms, including the following:
			<ol type="a">
				<li>Offensive and unwelcome sexual invitations, whether or not the person submits to the invitation;</li>
				<li>Offensive and unwelcome conduct of a sexual nature, including sexually graphic spoken comments;</li> 
				<li>Offensive or suggestive images or graphics whether physically present in the premises or accessed or the possession of or use of sexually suggestive objects;</li>
				<li>Offensive and unwelcome physical contact of a sexual nature, including the touching of another’s body; the touching or display of one’s own body, or any similar contact.</li>
			</ol>
		</li>
	</ul>
	</li>
</ol>

<h4>Enforcement of Rules and Consequences of Violations</h4>
<p>Tenant does not monitor Subtenants and would never want Subtenants to feel monitored. Tenant’s goal is to make Subtenants feel at home from the moment they arrive up to the moment they leave. In order to preserve this feeling of home, Tenant has outlined these House Rules to communicate a vision of what home should be: a respectful, clean, comfortable space to connect with others.</p>

<p>In order to achieve this, Subtenants must not only follow the rules, but report to Tenant if and when rules are being broken. Tenant cannot enforce violations of rules by Subtenants that it is not aware of, therefore it is each Subtenant’s responsibility to notify Tenant when something is bothering them.</p>

<p>Please report all violations of the rules to <a href="mailto:customer.service@outpost-club.com" target="_blank">customer.service@outpost-club.com</a>.  When reporting please include the time, place, and description of the violation. If the person reporting knows who is involved, Tenant would appreciate if the person reporting provides that information as well but understand if they do not want to. Please understand that Tenant may not be able to resolve the issue if it does not know who commits the violation.</p>

<p>If Tenant has reason to believe that a Subtenant has broken the rules, Tenant reserves the right to issue warnings, and in circumstances where the violation is heinous and/or is a threat to the other tenants/subtenants, Tenant reserves the right to terminate that violating Subtenant’s Sublease Agreement after warnings or immediately.</p> 




<div class="fx ch2">
	<div>
		<p>
			Ne-Bo Services Corporation, Overtenant<br>
			By: Alexander Kostromin<br>
			Position: CEO
		</p>
		{*
		<img src="design/{$settings->theme|escape}/images/c_signature2.png" alt="Signature Ne-Bo" width="180" />
		*}
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
		{*
		<img src="design/{$settings->theme|escape}/images/c_signature.png" alt="Signature Sergii Starostin" width="180" />
		*}
		<br>
		<br>
	</div>
</div>

<p>New Subtenant Acknowledgement</p>


{if !$contract_info->signature4}
	<div id="signature4_block">
	    <p class="signature_title">Signature:</p>
		<div class="wrapper">
			<canvas id="signature4-pad" class="signature-pad" width=460 height=240></canvas>
		</div>
	    <input id="signature4" type="hidden" name="signature4" value="">
	    <div class="button_block">
	        <div id="clear4" class="clear">Clear</div>
	        <div id="save4" class="save">Sign</div>
	    </div>
	  
	</div><!-- signature_block -->
	<div id="signature4_img"></div>


	{literal}
	<script>
	var signature4 = 0;
	var canvas4 = document.getElementById('signature4-pad');

	// function resizeCanvas4() {
	//     var ratio =  Math.max(window.devicePixelRatio || 1, 1);
	//     canvas4.width = canvas4.offsetWidth * ratio;
	//     canvas4.height = canvas4.offsetHeight * ratio;
	//     canvas4.getContext("2d").scale(ratio, ratio);
	// }
	function resizeCanvas4() {
	    canvas4.width = canvas4.offsetWidth;
	    canvas4.height = canvas4.offsetHeight;
	}
	//window.onresize = resizeCanvas;
	resizeCanvas4();

	var signaturePad4 = new SignaturePad(canvas4, {
		backgroundColor: 'rgb(255, 255, 255)', // necessary for saving image as JPEG; can be removed is only saving as PNG or SVG
		penColor: 'rgb(1, 31, 117)'
	});

	function saveSignature4(){
		var signature4_input = document.getElementById('signature4');
		if(signature4_input.value == '')
		{
			if(signature4===0 && signaturePad4.isEmpty())
		        return alert("Please provide a signature first");
		    var data4 = signaturePad4.toDataURL('image/png');
		    var img_data4 = canvas4.toDataURL('image/png');
		    document.getElementById('signature4_img').innerHTML += '<img src="'+img_data4+'" width="180" />';
		    document.getElementById('signature4_block').hidden = true;
		    signature4_input.value = img_data4;

		    signaturePad4.clear();
		    delete data4;
		    delete img_data4;
		    delete signaturePad4;
		   	signature4 = 1;
		    delete canvas4;
		}	
	}
	document.getElementById('save4').addEventListener('click', function () {
	    saveSignature4();
	});

	document.getElementById('clear4').addEventListener('click', function () {
		signaturePad4.clear();
	});


	</script>
	{/literal}

{/if}

{if $contract_info->signature4}
	<img src="{$contract_info->signature4}" alt="Signature {$contract_user->name|escape}" width="180" />
{/if}


<br>

<hr>

<br>
<br>
<br>



<h1>Service Agreement Memberships</h1>

<p>This Services Agreement (“Agreement”) is between <strong>Outpost Club Inc</strong> (“Company”), and the Customer: <strong>{$contract_user->name|escape}</strong>.  There shall be no force or effect to any different terms of any related purchase order or similar form even if signed by the parties after the date hereof.  Company may change non-material terms herein by providing notice to Member and any material changes must be mutually approved by both parties.</p>

<p>Subject to the terms of this Agreement, Company will use commercially reasonable efforts to provide Member the Services in accordance with the Service Level Terms attached hereto as Appendix 1 and Appendix 2.</p>

{if $contract_info->membership==1 || $contract_info->membership==2 || $contract_info->membership==4}
<h2>Payment of Membership</h2>
<p>Customer will pay Company the then applicable one-time yearly fees according to service level chosen: {if $contract_info->membership==1}690 USD{elseif $contract_info->membership==2}79 USD{elseif $contract_info->membership==4}29 USD{/if}.</p>
{/if}

<p>Company reserves the right to change the Fees or applicable charges and to institute new charges and Fees at the end of the Initial Service Term after 1 year. If Customer believes that Company has billed Customer incorrectly, Customer must contact Company no later than 30 days after signing date on the first billing statement in which the error or problem appeared, in order to receive an adjustment or credit.  Inquiries should be directed to Company’s customer support department at <a href="mailto:customer.service@outpost-club.com" target="_blank">customer.service@outpost-club.com</a>.</p>

<h2>Term and termination</h2>
<p>This Agreement is for the Initial Service Term of 1 year, and may be renewed only upon both parties’ consent.  For the avoidance of doubt, the Initial Service Term shall not be automatically renewed.</p>

<h2>Warranty and disclaimer</h2>
<p>Company shall use reasonable efforts consistent with prevailing industry standards to maintain the Services in a manner which minimizes errors and interruptions in the Services and shall perform in a professional and workmanlike manner.</p>
<p>Services may be temporarily unavailable for scheduled maintenance or for unscheduled emergency maintenance, either by Company or by third-party providers, or because of other causes beyond Company’s reasonable control, but Company shall use reasonable efforts to provide advance notice in writing or by e-mail of any scheduled service disruption.  
<p>However, Company does not warrant that the Services will be uninterrupted or error free; nor does it make any warranty as to the results that may be obtained from use of the Services.</p>

{if $contract_info->membership==1}

<h2>Appendix 1: Privileges and Terms of a Gold Membership</h2>
<p>For good and valuable consideration, the sufficiency of which is acknowledged, the parties to this Agreement who have signed at the bottom of this document hereby agree as follows:</p>

<p>Standard 1-year Gold-Membership Payment is $690 in advance of Member Arrival Date. This payment will be made to Outpost Club through an Invoice.</p>

<p>Outpost Club Members who have signed a Gold Membership Agreement and paid the Gold Annual Membership Payment are granted access to the following:</p> 
<ol>
	<li>Outpost Club will pay for utilities and WiFi for Outpost Club houses.</li>
	<li>The Member will have access to all gold-level events at no additional cost to the Member.</li> 
	<li>Outpost Club will provide security in the form of Nest camera systems in the common areas of Club houses.</li> 
	<li>Outpost Club will provide maintenance and cleaning services at all Club properties.</li> 
	<li>Outpost Club will provide household essentials of the Club’s choice at no additional cost to the Member.</li>
	<li>Outpost Club will provide comforter and pillows, new set of linens at no additional cost to the Member during move-in.</li>
</ol>

<p>In addition to the above, Outpost Club Members who have signed a Gold Membership Agreement and paid the Gold Annual Membership Payment agree to the following:</p> 
<ol>
<li>The Member has access to all Club houses that have common spaces for use by the
entire house. Members may only access the common areas of other houses that they do
not have at their own house: Theaters, Workout Spaces, Coworking space, etc. They
may not use kitchens, private living rooms, bedrooms, private bathrooms, or other areas
that they may have at their own home.</li>
<li>The Member can move between Club houses with 30 days’ notice, provided there is an
available bed.</li>
<li>The Subtenant must notify the Overtentant (<a href="mailto:customer.service@outpost-club.com">customer.service@outpost-club.com</a>) inquiring about the availability for their guests. The subtenant may request to reserve a bed or room for a guest as far in advance as the subtenant's duration of their lease, however, guest approval from the Overtenant may remain tentative up until one week before the requested arrival date. The Overtenant will provide confirmation of the guests stay from <a href="mailto:customer.service@outpost-club.com">customer.service@outpost-club.com</a></li>
<li>The Member may have an overnight guest on Club property during quiet hours (10 p.m.
- 9 a.m.) for up to four nights per calendar month. After the member uses there four free
nights for guests, the Member may only be have overnight guests by paying a $30 per
night fee. The Member is limited to one overnight guest at a time for no longer than two
consecutive days. Outpost Club can only provide the option of accommodating a paid
guest if Outpost Club has a room or bed for the guest. If the subtenant is subleasing a private room, the subtenant may add an additional person to their sublease for $200 per month. This is upon the condition that the new subtenant has applied to Outpost Club and has been approved, and has made payment in advance. Outpost Club reserves the right to reject all requests to add an additional person to the sublease at their discretion.</li>
<li>If the subtenant would like to have their guest stay in a room other than their own, the guest must stay in a room in the same apartment, and the subtenant must pay the over tenant $59 for new bed linens and $29 for post-stay cleaning. The Subtenant may provide their own sheets, avoiding the $59 cost, but must either provide their own sheet or purchase them from Outpost Club; the guest can not sleep directly on the bed without bed linens.</li>
<li>The Member, along with other Gold Members, will be provided the opportunity to move
to new Club houses before rooms in the houses are made available to Silver Members
and the general public.</li>
<li>The Member will be afforded one additional week’s stay at a Club property within six
months of the termination of their Membership agreement, provided the terms of the
original contract were met in full and the Club is given at least one week’s notice of the
intended stay. Outpost Club can only provide the option of accommodating a free
690 week’s stay if Outpost Club has a room or bed for the Member. Outpost Club can only
confirm the availability of a bed or room one week in advance of the Member’s one-week
stay.</li>
<li>For $250, the Member may cancel their Membership agreement with the Club with 30
days’ notice at any time during the length of the contract. The member will still be
obligated to pay for the 30 days after the notice is given. Any termination requests should be sent to <a href="mailto:customer.service@outpost-club.com">customer.service@outpost-club.com</a>. Oral or text requests will not be considered.</li>
{*<li>The Member may pause their Membership with the Club for 30-90 days during the
length of the contract by giving 30 days’ notice. The length of the Membership pause will
be added to the end of the original contract length, which the Member agrees to fulfill.
The Member may only pause their membership once during the duration of this
Membership Agreement.</li>*}
<li>The Club will provide the Member with accommodation for up to two additional nights at
the end of the fulfilled contract should the Member’s travel plans fall through due to
unforeseen circumstances. The Club cannot guarantee the Member will be able to stay
in their previously occupied room or house.</li>
<li>The Member may move into an available room at a Club house on the same day as
signing the Membership agreement and paying the first Monthly Membership Fee,
security deposit and the Gold Annual Membership Payment.</li>
<li>Standard move-in takes place between 3 p.m. and 9 p.m. daily. Gold Members may
move in outside of standard move-in hours at no additional cost.</li>
<li>The Member is afforded the opportunity to postpone payment of their Security Deposit
up to two months after their arrival date. The deposit must be paid in full by the due date
of the Member’s third month’s rent payment. If the member elects to postpone Security
Deposit payment, they will pay the Security Deposit according to the following schedule
below:
<ol type="a">
<li>The Member made the full security Deposit payment in advance of the arrival date.</li>

{if $contract_info->invoices|count > 1 && $contract_info->split_deposit==1}
{foreach $contract_info->invoices as $i}
	{if $i@iteration<3}
	<li>Security Deposit Payment for {$i->date_from|date:'M j'} - {$i->date_to|date:'M j'}: {($contract_info->price_deposit/2)|convert} USD, to be paid on or before {$i->date_for_payment|date:'M j'}</li>
	{/if}
{/foreach}
{/if}


{*<li>Security Deposit Payment for June 15 - July 15: XXX USD, to be paid on or before June 1</li>
<li>Security Deposit Payment for July 15 - August 15: XXX USD, to be paid on or before July<br /><br /></li>*}
</ol>
</li>
</ol>

{elseif $contract_info->membership==2 || $contract_info->membership==3}

<h2>Appendix 1: Privileges and Terms of a {if $contract_info->membership==2}Silver{else if $contract_info->membership==3}Bronze{/if} Membership</h2>
<p>For good and valuable consideration, the sufficiency of which is acknowledged, the parties to this Agreement who have signed at the bottom of this document hereby to agree as follows:</p>

<p>Outpost Club Members who have signed a {if $contract_info->membership==2}Silver{else if $contract_info->membership==3}Bronze{/if} Membership Agreement are granted access to the following:</p>
<ol>
	<li>Outpost Club will pay for utilities and WiFi for Outpost Club houses.</li>
	{if $contract_info->membership==2}
		<li>The Member will have access to all silver-level Outpost Club events at no additional cost, and to gold-level events for a small fee.</li>
	{/if} 
	<li>Outpost Club will provide maintenance and cleaning services at all Club properties.</li> 
	<li>Outpost Club will provide household essentials of the Club’s choice at no additional cost to the Member.</li>
	<li>Outpost Club will provide comforter and pillows, new set of linens at no additional cost to the Member during move-in.</li>
</ol> 

<p>In addition to the above, Outpost Club Members who have signed a {if $contract_info->membership==2}Silver{else if $contract_info->membership==3}Bronze{/if} Membership Agreement agree to the following:</p> 
<ol>
	<li>The Member has access to only the Outpost Club House for which they are a subtenant, except to attend Outpost Club events or visit other Club Members.</li> 
	<li>Unless otherwise permitted in writing pursuant to this Agreement, Subtenants are not permitted overnight guests on the premises, however, if the subtenant has leased a private room, they may  add an additional person to their sublease for $200 per month. This is upon the condition that the new subtenant has applied to Outpost Club and has been approved, and has made payment in advance. Outpost Club reserves the right to reject all requests to add an additional person to the sublease at their discretion.</li>
	<li>The Member may have an overnight guest on Club property during quiet hours (10 p.m. - 9 a.m.) only by paying a $30 per night fee. The Member is limited to one overnight guest at a time for no longer than two consecutive days. Outpost Club can only provide the option of accommodating a paid guest if Outpost Club has a room or bed for the guest.</li> 
	<li>The Member with Bronze/Silver Membership may not cancel or pause their Sublease before the end of the contract term.</li> 
	<li>The Member with Bronze/Silver Membership may not have overnight guests during their stay.</li>
	<li>Standard move-in takes place between 3 p.m. and 9 p.m. daily. Members who move in between 9 p.m. and 12 a.m. must pay a $30 fee upon arrival. Members who move in between 12 a.m. and 8 a.m. must pay a $70 fee upon arrival.</li> 
</ol>

{/if}

<p>
Outpost Club Inc<br/>
Sergii Starostin, CEO<br/>
<a href="mailto:customer.service@outpost-club.com" target="_blank">customer.service@outpost-club.com</a><br/>
DATE: {$contract_info->date_created|date:'m/d/Y'}<br/>
</p>
{*
SIGNATURE:
<img src="design/{$settings->theme|escape}/images/c_signature.png" alt="Signature Sergii Starostin" width="180" />
*}
<p><br/></p>

{foreach $contract_users as $user}
{if $user->id != $contract_user->id}
<p>MEMBER NAME: {$user->name|escape}<br/>
	{if $user->log}
	DATE: {$user->log->date|date:'m/d/Y'}<br/>
	MEMBER SIGNATURE:<br>
	<img src="{$config->contracts_dir}{$contract_info->url}/signature-{$user->id}.png" alt="Signature {$user->name|escape}" width="180" />
	{/if}
</p>
{/if}
{/foreach}

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

