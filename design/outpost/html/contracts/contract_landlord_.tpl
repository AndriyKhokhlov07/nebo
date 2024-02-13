{* Contract html *}


<h1>LEASE AMENDMENT NUMBER {$contract_info->id}</h1>
{if $guests}
{$first_contract = $guests|@current}
{/if}
<p>For good and valuable consideration, the receipt of which is hereby acknowledged, this Lease Amendment Number {$contract_info->id}, dated this <span class="border_b">{$contract_info->date_created|date}</span> by and between Landlord and Tenants to be incorporated into a certain Lease Agreement for {$apartment->name} at <span class="border_b">{*{$contract_info->rental_name|escape}*} {$house->blocks2['address']}</span> dated <span class="border_b">{if $first_contract}{$first_contract->date_signing|date}{else}{$contract_info->date_created|date} {/if}</span> between Landlord and Tenants, is hereby incorporated into said document. All terms and conditions of the original lease, except revisions listed below, shall remain in full force.</p>

<p>The Landlord and Tenants hereby agree that the Schedule of Pro Rata Share of Rent has been amended to add the below:</p>


<p><strong>New Tenant</strong> {$contract_user->first_name}{if $contract_user->middle_name} {$contract_user->middle_name}{/if} {$contract_user->last_name}</p>

<p><strong>Individual Term Starting From</strong> {$contract_info->date_from|date} <strong>Finish on</strong> {$contract_info->date_to|date}</p>

<p><strong>Pro Rata Share of Monthly Rent</strong> {$contract_info->price_month|convert} (US Dollars). <strong>Total amount for the whole period</strong> {$contract_info->invoices_total|convert} (US Dollars)</p>

<p><strong>Pro Rata Share of Security Deposit</strong> {$contract_info->price_deposit|convert} (US Dollars)</p>

<p><strong>Full Payment</strong> (first month pro-rated rent and pro-rated deposit) for the first Month should be paid no later than {(strtotime($contract_info->date|date)+ (2*24*60*60))|date_format:'%b %e, %Y'}</p>

{$invoice_first=$contract_info->invoices|first}

<p><strong>Payment each month on</strong> {(strtotime($invoice_first->date_from|date)-(10*24*60*60))|date_format:'jS'}</p>

<p><strong>Schedule of rent payments:</strong></p>
<ol>
	{foreach $contract_info->invoices as $i}
		{if $i@iteration>1}
			<li>Payment for {$i->date_from|date:'M j'} - {$i->date_to|date:'M j'}: {$i->price|convert} USD, to be paid on or before {$i->date_for_payment|date:'M j'}</li>
		{/if}
	{/foreach}
</ol>

<p>Rental Payment Instructions: Each month Landlord or Property Manager sends an invoice to the New Tenant e-mail address. New Tenant need to register at the <a href="https://ne-bo.com">ne-bo.com</a> to receive access to all documents, invoices and maintenance tickets system.</p>

<p>New Tenant must receive temporary password to access <a href="https://ne-bo.com">ne-bo.com</a>. In case support is needed please reach out to <a href="mailto:customer.service@outpost-club.com">customer.service@outpost-club.com</a> or <a href="tel:+18337076611">+1 (833) 707-6611</a>.</p>


{if $contract_info->note1}
<br>
	<p><strong>Note:</strong></p>
	<p>{$contract_info->note1}</p>
{/if}


{if !$contract_info->signing}
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
	<p>
		Tenant {$contract_user->name|escape}<br/>
	{if $contract_info->signing}
		Date {$contract_info->date_signing|date}<br/>
	{/if}
	Signature
	</p>
	<img src="{$config->contracts_dir}{$contract_info->url}/signature2.png" alt="Signature {$contract_user->name|escape}" width="180" />
{/if} 

<br>
<br>

<p>This Agreement may be signed by the parties in counterparts which together shall constitute one and the same agreement among the parties. An email signature shall constitute an original signature for all purposes.</p>

<p>IN WITNESS WHEREOF, the Landlord and Tenant(s) have executed this instrument as of the day and year first above written.</p>

<p>
Date: {$contract_info->date_created|date}<br/>
Inventory Manager Signature (in care of Landlord):<br>
<img src="design/{$settings->theme|escape}/images/c_signature2.png" alt="Signature Ne-Bo" width="180" />
</p>

<br>

<hr>

<br>
<br>
<br>

<h1>LEASE</h1>

<p><strong>Date of Lease:</strong> {$first_contract->date_signing|date}</p>
<p><strong>Landlord:</strong> {$landlord->middle_name}</p>
<p><strong>Term:</strong> 1 year commencing on {$first_contract->date_signing|date}</p>
<p><strong>Rent Payment Day:</strong> The 1st day of each month</p>
<p><strong>Building:</strong> {$house->blocks2['street_address']}, {$apartment->name}, {$house->blocks2['city']}, {$house->blocks2['region']}, {$house->blocks2['postal']}</p>

<br>

<p>Landlord and Tenants make this apartment lease agreement as follows.</p>

<h2>1. IMPORTANT TERMS</h2>

<p><strong>PRO RATA SHARE OF RENT (defined herein)* - *</strong>All Tenants are jointly and severally liable for the Monthly Rent, which in the aggregate, is {if $house->id == 305}$7500{elseif $house->id == 304}$5000{elseif $house->id == 306}$4800{elseif $house->id == 155}$5800{elseif $apartment->id == 10}$11,000{else}$8,000{/if}. The Pro Rata Share of the Rent represents an agreement between the Tenants regarding dividing the Monthly Rent between them. The Pro Rata Share of Rent provisions of this contract shall in no way limit each Tenant’s joint and several liability for the full Monthly Rent, except as otherwise provided below in the Tenant Replacement section.</p>

<p>(Collectively all Tenants will hereinafter be referred to as “Tenants”)</p>

<p><strong>Replacement Tenant:</strong> A Tenant that joins this Lease after a Tenant executes the Early Termination clause.</p>

<p><strong>Early Termination Date:</strong> Agreed upon Date in which Landlord terminates Tenant’s Lease obligations.</p>

<h2>2. LEASE</h2>

<p>In consideration of the mutual covenants and agreements herein contained, Landlord hereby leases to the Tenants the Apartment, in exchange for the Tenants complying with all of the terms and conditions contained within this Lease, until the end of the Term of this Lease. The Term is defined in the Important Terms section of this Lease.</p>

<h2>3. USE OF THE APARTMENT</h2>
<ol type="a">
	<li>Tenants shall use the Apartment for living purposes only.</li>
	<li>Tenants shall not violate Real Property Law § 235(f) or similar statute, commonly known as “the Roommate Law”, which, among other things, prohibits the combined number of tenants and occupants from being more than the number of tenants on a lease.</li>
	<li>Tenants shall not violate New York City's Administrative Code Section 27-2075 or similar statute, which, among other things, limits the number of people who may legally occupy an apartment of this size.</li>
	<li>Tenants shall not violate Multiple Dwelling Law § 4(8)(a) of similar statute, which, among other things, prohibits short-term leasing of an apartment. The Apartment may not at any time be used for occupancy by any person on a transient basis, including, without limitation, the use of the Apartment as a party space, hotel, motel, dormitory, fraternity house, sorority house, or rooming house. Neither Tenants nor anyone on Tenants’ behalf may advertise for any such use of the Apartment on Airbnb.com or any other website, platform, newspaper, periodical, or other medium.</li>
	<li>Tenants shall not violate Zoning Resolution of the City of New York § 12-10, which, among other things, proscribes the ability to carry on a business inside an apartment.</li>
	<li>Tenants agree to abide by, and cause its agents, invitees, and guests to abide by, all rules and regulations relating to the Apartment now in effect and such as may be promulgate from time to time hereafter by Landlord or Landlord’s Agent as set forth in this Lease.</li>
	<li>Tenants shall not cause or permit the installation of any lock, deadbolt or other locking device or mechanism that controls the entrance door to any individual bedroom (“Bedroom Door”) within the Apartment. Tenants may use previously installed locking doorknob to lock an individual Bedroom Door from the inside, while such person(s) is/are in the bedroom. Tenants shall not change or replace any such locking doorknob.</li>
	<li>If the Apartment has multiple Bedrooms, Landlord has, and we will have, no involvement in the assigning of bedrooms within the Apartment to the Tenants except that the Pro Rata share of the Monthly Rent may change in the event Tenants select different bedrooms. Tenants have access to the entire Apartment.</li>
</ol>

<h2>4. ASSIGNMENT</h2>

<ol type="a">
	<li>No Tenant can assign this Lease or sublet the Apartment without Landlord's advance written consent in each instance. If the Building contains four or more residential units, a Tenant must make a request made by Tenant in the manner required by Real Property Law § 226-b or similar statute. If the Building contains four or more residential units, Owner may refuse to consent to a lease assignment for any reason or no reason, but if Owner unreasonably refuses to consent to request for a Lease assignment or sublet properly made, at Tenant’s request in writing, Owner will end this Lease effective as of thirty (30) days after Tenant’s request.</li>
	<li><strong>Tenants consent to the assignment of this Lease by any other tenant in the Apartment to an assignee of Landlord’s choosing. Tenants knowingly waives any right to know the identity of such assignee in advance of the assignment. Tenants agree to be jointly and severally liable for all obligations of the Lease with such assignee.</strong> Landlord and Tenants agree that: (1) Landlord covenants to find Tenants for this Lease and introduce them to each other; (2) Tenants are not responsible for finding Tenants.</li>
	<li>If Tenants or any Tenant moves out of the Apartment before the end of this Lease without consent of Landlord, this Lease will not be ended. Tenants or Tenant will remain responsible for Monthly Rent as it becomes due until the end of this Lease.</li>
</ol>

<h2>5. RENT</h2>
<ol type="a">
	<li>Tenants must pay Landlord the Monthly Rent, in advance, or, on the Rent Payment Day each month.</li>
	<li>All Tenants are jointly and severally liable for the Monthly Rent.</li>
	<li>In the Important Terms section of this Lease, each Tenant agreed to be assigned a <strong>“Pro Rata Share of the Rent”</strong>. The Pro Rata Share of the Rent represents an agreement between the Tenants regarding dividing the Monthly Rent between them. The Pro Rata Share of Rent provisions of this contract shall in no way limit each Tenant’s several liability for the full Monthly Rent, except as otherwise provided below in the Tenant Replacement section.</li>
	<li>All amounts payable by Tenants pursuant to this Lease in excess of the amount of the Monthly Rent shall be deeded <strong>“Additional Rent”</strong>. Landlord shall have the same rights and remedies with respect to defaults in the payment of Additional Rent as Landlord has with respect to payment of the Monthly Rent.</li>
	<li>In the event that Rent is not received by within five (5) days from the Rent Payment Day, Landlord reserves the right to terminate the Lease and to charge a $50 per day late fee.</li>
	<li>In the event of declined payment, Landlord reserves the right to demand that replacement payment and/or future payments be made by certified check, bank check or money order. In the event that Monthly Rent is returned for “insufficient funds” or for any other reason, Tenants shall pay, as Additional Rent, the greater of $50.00 and/or the actual fees, penalties and/or expenses incurred by Landlord directly or indirectly caused by each such dishonored payment, as well as any applicable late fees or interest.</li>
	<li>Attempted chargebacks for non-fraudulent transactions through the Payment System (Stripe/Paypal/via Credit/Debit Card/ACH) will be subject to investigation and these individuals will be prosecuted to the fullest extent of the law.</li>
</ol>

<h2>6. EARLY TERMINATION OPTION</h2>

<ol type="a">
	<li>A Tenant may terminate that Tenant’s obligations under this Lease before the end of the Term indicated in the Important Terms section, if and only if:
		<ol>
			<li>Tenant provides ninety (90) days’ written notice to customer.service@outpost-club.com of intent to terminate this lease to Landlord, unless otherwise specified in Tenant’s Services Agreement with Outpost.</li>
			<li>Tenant must execute a Surrender Affidavit in order to terminate their obligations under this Lease.</li>
			<li>Tenant must vacate the Premises and return all keys to Landlord on or before seven (7) days prior to Early Termination Date.</li>
			<li>Tenant is not in default of any portion of the Monthly Rent owed to Landlord.</li>
		</ol>
	</li>
	<li>If a Tenant properly exercises his or her right to invoke an Early Termination Option, such Tenant will hereinafter be referred to as an <strong>“Early Termination Tenant”</strong> and the event will hereinafter be referred to as a <strong>“Tenant Loss”</strong>. In the event of a Tenant Loss, the remaining Tenants or Tenant will hereinafter be referred to as the <strong>“Remaining Tenants”</strong>.</li>
	<li>In the event of early termination as defined herein, Tenant shall be responsible for any Landlord expenses associated with said termination, including but not limited to rent concession, and preparation of the apartment for new Tenant. This includes, but is not limited to, a $250 cleaning fee.</li>
	<li>In the event of a Tenant Loss, then this Lease will nevertheless remain in full force and effect for Landlord and the remaining Tenants or Tenant.</li>
	<li>If Landlord is unable to locate a new tenant willing to pay an equal or higher rent than the Rent, then Landlord shall notify Tenant. In such event Tenant shall either (1) stay in the Premises until the end of the term; or (2) compensate Landlord for the entire difference between the Rent and the new tenant’s rent in one lump sum payment and upon receipt by the Landlord of said payment, the Lease shall terminate.</li>
	<li>The location of a new tenant shall be in Landlord’s sole discretion but Landlord shall use its best efforts to locate a new tenant willing to pay a rent equal to or higher than the Rent.</li>
</ol>

<h2>7. TENANT REPLACEMENT</h2>
<ol type="a">
	<li>In the event of a Tenant Loss, Landlord will not seek to hold the Remaining Tenants liable for the Early Termination Tenant’s Pro Rata Share of Rent after the Early Termination Tenant’s Early Termination Date, subject to the exceptions below.</li>
	<li>In the event of a Tenant Loss, Landlord may select another tenant to replace the Early Termination Tenant, and such new tenant will hereinafter be referred to as a <strong>“Replacement Tenant”</strong>.</li>
</ol>

<h2>8. SECURITY DEPOSITS</h2>

<ol type="a">
	<li>Each Tenant is expected to post security for that Tenant’s faithful performance of his or her obligations pursuant to this Lease.</li>
	<li>Each Tenant will deposit with Landlord an amount that is equal to one month rent as a security deposit <strong>(“a Security Deposit”)</strong> for that Tenant’s faithful performance of his or her obligations under this Lease.</li>
	<li>Landlord will inform each Tenant of the name and address of the Bank in which the Security Deposit is held. To receive such information Tenant must send a request to <a href="mailto:customer.service@outpost-club.com">customer.service@outpost-club.com</a>.</li>
	<li>If the Tenants do not pay the Monthly Rent on time, Landlord may, but is NOT required to, use any Security Deposit to pay for rent then due. If Tenants fail to timely perform any other term in this Lease, Landlord may use any Security Deposit for payment of money Landlord spends or payment of damages Landlord suffers because of any Tenants’ failure.</li>
	<li>If Landlord uses any Security Deposit, then each Tenant whose Security Deposit has been used shall, upon notice from Landlord, send to Landlord an amount equal to the amount remaining portion of the Security Deposit used by Landlord.</li>
	<li>If a Tenant fully performs all terms of this Lease, pays rent on time, and leaves the Apartment in good condition on the day such Tenant leaves, then Landlord will return the Security Deposit tendered by such Tenant to such Tenant within 14 days of the end of the Term. Deposit return request should be submitted to <a href="mailto:customer.service@outpost-club.com">customer.service@outpost-club.com</a></li>
	<li>Tenant agrees and affirms that Landlord is authorized to automatically debit a designated bank account or to process payment with any other applicable third-party payment processor, for Security.</li>
	<li>If Landlord sells or assigns this Lease (as defined in this Lease), Landlord may give the Security to the buyer or assignee. In that event, Tenants will look only to the buyer or assignee for the return of the Security and Landlord will be deemed released.</li>
	<li>Tenant may not use any portion of the Security Deposit to pay the Monthly Rent.</li>
	<li>HelloRented.  Tenant and any future tenant may elect to use the services of third-party company HelloRented Inc. (“HelloRented”) to pay their Security Deposit.  If any tenant elects to use HelloRented, and if Landlord has reason to withhold the Security Deposit, Landlord will notify HelloRented of its decision to do so, including the amount withheld, and that tenant will be responsible for repaying the withheld Security Deposit amount to HelloRented.</li>
</ol>

<h2>9. FURNITURE AND CONTENTS OF APARTMENT PROVIDED BY LANDLORD</h2>

<p>The Apartment may be leased furnished containing the items of household furniture, kitchen utensils, and other household items. Tenants agree to return all items provided at the start of Term in as good condition as when received, reasonable wear and tear excepted. Tenants will be responsible for all breakage or other damage to items provided and such damages are deductible from the Security Deposit. Chipped, cracked, or burned dishes will be counted as breakage.</p>

<h2>10. WARRANTY OF HABITABILITY AND ACCESS TO ALL PARTS OF THE APARTMENT FOR EMERGENCIES AND REPAIRS</h2>

<ol type="a">
	<li>All of the sections of this Lease are subject to the provisions of the Warranty of Habitability during this Lease. Under that law, Landlord agrees that the Apartment is fit for human habitation and that there will be no conditions which will be detrimental to life, health, or safety.</li>
	<li>Landlord or Landlord’s Agent reserves the right to decorate or to make repairs, alterations, additions, or improvements, whether structural or otherwise, in and about the Building and the Apartment, or any part thereof, and for such purposes to temporarily close doors, entryways, public space and corridors in the Building and to interrupt or temporarily suspend Building services and facilities, all without abatement of Monthly Rent or affecting any of Tenants’ obligations hereunder.</li>
	<li>Tenants will do nothing to interfere or make more difficult Landlord's efforts to provide Tenants and all other occupants of the Building with the required facilities and services. Any condition caused by a Tenant’s misconduct or the misconduct of anyone under a Tenant’s direction and/or control shall not be a breach of the Warranty of Habitability by Landlord.</li>
	<li>During reasonable hours and with reasonable notice, except in emergencies, and as required by Law, Landlord or the Landlord of the Building (“Landlord”) may enter the Apartment to erect, use and maintain pipes and conduits in and through the walls and ceilings of the Apartment; to inspect all parts of the Apartment, to make any repairs or changes that Landlord desires or decides are necessary and to show all parts of the Apartment to investors, partners, and prospective Tenants. The Monthly Rent will not be reduced because of any of this work, unless required by law. In the event that Landlord performs any obligations required of Tenants to be performed hereunder, the amount paid by Landlord to perform such obligations shall be due and payable by Tenants to Landlord upon demand or charges as Additional Rent.</li>
	<li>Landlord may retain a key to the Apartment.</li>
	<li>Nothing in this Lease shall be construed to impose any liability or obligations on Landlord or require Landlord to take any action or make any repairs to or maintain the Apartment or the Building.</li>
</ol>

<h2>11. CONDITION OF SUITE AND SERVICES AND FACILITIES</h2>

<ol type="a">
	<li>Tenants have inspected the Apartment and accepts the Apartment in the condition it is in as of such inspection. Tenant acknowledges that the Apartment is free of defects. When Tenant entered into this Lease they did not rely on anything said by Landlord, its employees or agents about the physical condition of the Apartment, the Building or the land on which it is built. Tenants agree that Landlord has not promised to do any work in the Apartment, unless what was said or promised is written in this Lease and signed by both Tenants and Landlord.</li>
	<li>Landlord will provide cold and hot water and heat as required by law, elevator service if the Building has elevator equipment, electricity, and gas utilities as well as internet services. Tenants are not entitled to any reduction in the Monthly Rent because of a stoppage or reduction of any of the above services unless such reduction is required by law. No other utilities or services are to be furnished by Landlord or Landlord’s agent or used by Tenants in the Apartment without prior written consent of Landlord or Landlord’s Agent and on the terms and conditions specified in such written consent. Tenants shall make no alterations to the Apartment.</li>
	<li>Appliances supplied by Landlord in the Apartment are for the Tenant’s use, Such appliances will be maintained and repaired or replaced by Landlord, but if repairs or replacement are made necessary because of Tenant’s or any Tenant’s negligence or misuse, Tenants will pay Landlord for the cost of such repair or replacement as Additional Rent. Tenants must not use a dishwasher, washing machine, dryer, freezer, heater, ventilator, air-cooling equipment, or other appliance unless installed by Landlord. Tenants will not use more electric than the wiring or feeders to the Building can safely carry.</li>
	<li>In the event of an emergency which affects the safety of the occupants of the Building or that may cause damage to the Building, Landlord may enter the Apartment without prior notice to Tenants. If, at any time, Tenants are not personally present to permit Landlord or Landlord's representatives to enter the Apartment and entry is necessary or allowed by law, Landlord or Landlord’s representatives may nevertheless enter the Apartment.</li>
	<li>Failure to provide access as per this section is a breach of a substantial obligation of this Lease.</li>
	<li>If Landlord permits Tenants to use any storeroom, laundry room, bike rack, yard, or any other facility (“a Facility”) located in or directly outside of the Building, the use of a Facility will be at Tenants’ own risk, except for loss suffered by a Tenant due to Landlord's negligence.</li>
	<li>Because of a strike, labor trouble, national emergency, repairs done by the owner of the Building, or any other cause beyond Landlord's reasonable control, Landlord may not be able to provide or may be delayed in providing any services or in making any repairs to the Apartment. In any of these events, any rights Tenants may have against Landlord are only those rights which are allowed by laws in effect when the reduction in service occurs.</li>
</ol>

<h2>12. CARE OF THE APARTMENT AND THE BUILDING BY TENANTS</h2>

<ol type="a">
	<li>Tenants will take good care of the Apartment and will not permit or do any damage to it, except for damage that occurs through ordinary wear and tear.</li>
	<li>Tenants cannot build in, add to, change or alter the Apartment in any way, including, but not limited to: wallpapering, painting, installing any paneling, flooring, built-in decorations, partitions, or railings. Tenants cannot install or use in the Apartment any of the following: dishwashers, clothes washing or drying machines, electric stoves, garbage disposal units, heating, ventilating or air conditioning units or any other appliance or electrical equipment. Tenants may not change the plumbing, ventilating, air conditioning, electric or heating systems in the Apartment or the Building.</li>
	<li>If a lien is filed on the Apartment or Building for any reason relating to any Tenant’s fault, Tenants must immediately pay or bond the amount stated in the lien. Landlord may pay or bond the lien if the Tenants fail to do so within Ten (10) days after Tenants have notice about the lien. Landlord’s costs in this regard shall be Additional Rent.</li>
	<li>Tenants cannot place in the Apartment water-filled or excessively heavy furniture. What is “excessively heavy” shall be determined in Landlord’s sole discretion.</li>
	<li>Tenants shall not block or leave anything in or on fire escapes, the sidewalks, entrances, driveways, elevators, stairways, or halls of the Building. Public access ways shall be used only for entering and leaving the Apartment and the Building. Only those elevators and passageways designated by Landlord can be used for deliveries. Baby carriages, bicycles or other property of Tenants shall not be allowed to stand in the halls, passageways, the roofs, public areas, or courts of the Building.</li>
	<li>The bathrooms, toilets, sinks, and plumbing fixtures shall only be used for the purposes for which they were designed or built; Tenants shall not place in them any sweepings, rubbish bags, acids, or other substances.</li>
	<li>Tenants shall not hang or shake carpets, rugs, or other articles out of any window of the Building. Tenants shall not sweep or throw or permit to be swept or thrown any dirt, garbage or other substances out of the windows or into any of the halls, elevators, or elevator shafts.</li>
	<li>Tenants shall not place any articles outside of the Apartments or outside of the Building except in safe containers and only at places chosen by Landlord and/or dictated by applicable law for the disposal of garbage.</li>
	<li>Tenants shall comply with all applicable recycling laws.</li>
	<li>An aerial may not be erected on the roof, outside wall, or fire escape of the Building without the written consent of Landlord.</li>
	<li>Awnings, flower boxes, or other projections shall not be attached to the outside walls of the Building or to any balcony or terrace.</li>
	<li>Tenants are not allowed on the roof of the Building.</li>
	<li>Tenants can use the elevator, if there is one, to move furniture and possessions only on days and hours designated by Landlord. Landlord shall not be liable for any costs, expenses, or damages incurred by Tenants in moving because of delays caused by the unavailability of the elevator.</li>
	<li>The Apartment may have a terrace or balcony. The terms of this Lease apply to the terrace or balcony as if part of the Apartment. Landlord may make special rules for the terrace and balcony. Landlord will notify Tenants of such rules. Tenants must keep the terrace or balcony clean and in good repair. No cooking is allowed on the terrace or balcony.</li>
	<li>Tenants will not allow any windows in the Apartment to be cleaned from the outside.</li>
	<li>Tenants acknowledges that Tenants must take measures to prevent mold and mildew from growing in the Apartment. Tenants agree to remove visible moisture accumulating on the windows, walls, and other surfaces. Tenants agree not to cover or block any heating, ventilation, or air conditioning (HVAC) ducts in the Apartment. Tenants agree to immediately notify Landlord of (a) any water leaks or excessive moisture in the unit, (b) any evidence of mold or mildew, (c) any failure of any HVAC systems in the unit, and (d) any inoperable doors or windows. Tenants agree that Tenants shall be responsible for any damage to the unit and Tenants’ property as well as personal injury to any Tenant and occupants resulting from Tenants’ failure to comply with this Lease provision. Any breach of this Lease provision shall be considered a breach of a substantial obligation of this Lease.</li>
	<li>Tenants shall use laundry and drying apparatus, if any, in the manner and at the times that the property manager or other representative of the Landlord may direct. Tenants shall not dry or air clothes on the roof.</li>
	<li>Tenants are not allowed on the roof of the Building, except to the extent expressly permitted by Landlord.</li>
	<li>When a Tenant moves out on or before the ending date of this Lease, such Tenant will leave the Apartment in good order and in the same condition as it was when the Tenant first occupied it, except for ordinary wear and tear and damage caused by fire or other casualty. At such time, the Tenant must remove all of his or her movable property. If the Tenant’s property remains in the Apartment after the Lease ends, Landlord may either treat the Tenant as still in occupancy and charge Tenant for such use, or may consider that Tenant has given up the Apartment and any property remaining in the Apartment. In this event, Landlord may either discard the property or store it at the Tenant’s expense. Such Tenant agrees to pay Landlord for all costs and expenses incurred in removing such property. The provisions of this article will continue to be in effect after the end of this Lease.</li>
</ol>

<h2>13. ENTRY TO APARTMENT</h2>

<ol type="a">
	<li>During reasonable hours and with reasonable notice, except in emergencies, Landlord may enter the Apartment for the following reasons:
		<ol>
			<li>To show the Apartment to persons who may wish to become Landlords or lessees of the entire Building or may be interested in lending money to the Building’s owner.</li>
			<li>To show the Apartment to persons who wish to become future Tenants of the Apartment.</li>
			<li>To provide additional and/or maintenance services, Landlord Personnel including but not limited to Cleaners, House Leaders, Community Manager, Service Personnel may enter common spaces of Apartment during the regular business hours without notice.</li>
			<li>Landlord Personnel may enter individual Bedrooms in the event of an emergency, or with 12 hours /reasonable notice.</li>
		</ol>
	</li>
</ol>

<h2>14. KEY MANAGEMENT</h2>

<ol type="a">
	<li>At the end of this Lease, Tenants must return to Landlord all keys, codes and entry devices either furnished or otherwise obtained.</li>
	<li>Landlord will only issue one key per Tenant. Landlord is not required to issue extra keys to Tenants.</li>
	<li>Codes provided by Landlord for use by the Tenants to access the Apartment are for Tenant’s use only and may not be shared or otherwise distributed.</li>
</ol>

<h2>15. TENANTS’ DUTY TO OBEY AND COMPLY WITH LAWS AND TO REFRAIN FROM OBJECTIONABLE CONDUCT</h2>

<ol type="a">
	<li>Tenants will obey and comply with all present and future city, state, and federal laws and regulations, which affect the Building or the Apartment, and with all orders and regulations of Insurance Rating Organizations which affect the Apartment and the Building.</li>
	<li>Tenants are responsible for the behavior of Tenants and their family, guests, employees, visitors, and/or invitees.</li>
	<li>Tenants will not have parties in the Apartment.</li>
	<li>No Tenant will engage in Objectionable Conduct. Objectionable Conduct means and Behavior that:
		<ol>
			<li>causes conditions that are dangerous, hazardous, unsanitary, and/or detrimental to other occupants of the Building or other Tenants in the Apartment;</li>
			<li>causes noises, sights, or odors in the Apartment or Building that are disturbing to other occupants of the Building or other Tenants in the Apartment;</li>
			<li>will interfere with the rights, comforts, or convenience of other occupants of the Building;</li>
			<li>makes or will make the Apartment or the Building less fit to live in for other occupants of the Building or other Tenants of the Apartment;</li>
			<li>interferes with the right of other occupants of the Building or other Tenants of the Apartment to properly and peacefully enjoy their Apartments.</li>
		</ol>
	</li>
	<li>No Tenant shall play musical instruments or operate or allow to be operated speakers, radios, or television sets in the Apartment or Building, so as to disturb or annoy any other occupant of the Building or Tenant of the Apartment.</li>
	<li>Any breach of this Lease provision shall be considered a breach of a substantial obligation of this Lease. Tenants will reimburse Landlord as Additional Rent for the cost of all losses, damages, fines, and reasonable legal expenses incurred by Landlord because of a violation of this section.</li>
	<li>For the avoidance of doubt, Landlord reserves the right, upon breach of this section of the Lease by any Tenant, to proceed legally against all Tenants or against individual Tenants.</li>
</ol>

<h2>16. NO PETS</h2>

<p>Animals of any kind shall not be kept or harbored in the Apartment, unless in each instance it be expressly permitted in writing by Landlord. Unless carried or on a leash, a dog shall not be permitted on any passenger elevator or in any public portion of the Building.</p>

<h2>17. WINDOW GUARDS</h2>

<p>IT IS A VIOLATION OF LAW TO REFUSE, INTERFERE WITH THE INSTALLATION OF, OR REMOVE WINDOW GUARDS WHERE REQUIRED. (SEE ATTACHED WINDOW GUARD RIDER).</p>

<h2>18. TENANT DEFAULT</h2>

<ol type="a">
	<li>
		As to a non-rent default by a Tenant:
		<ol>
			<li>A Tenant defaults under the Lease if he or she fails to carry out any agreement or provision of this Lease.</li>
			<li>If a Tenant defaults, other than a default in the agreement to pay rent, Landlord may serve the Tenant with a written notice to stop or correct the specified default within Ten (10) days. In such event, the Tenant must then stop or correct the default within 10 days.</li>
			<li>If Tenant does not stop or correct a default for which Tenant has been noticed within 10 days, Landlord may give Tenant a second written notice that this Lease, with respect to that Tenant, will end Five (5) days after the date of such notice. At the end of the 5-day period, this Lease, with respect to that Tenant, will end and Tenant then must move out of the Apartment.</li>
			<li>In the event of a non-rent default by a Tenant and a subsequent termination of Lease pursuant to this section, then this Lease will nevertheless remain in full force and effect for Landlord and the remaining Tenants or Tenant.</li>
		</ol>
	</li>
	<li>If Tenants do not pay the Monthly Rent or any Additional Rent due pursuant to this Lease when this Lease requires such, within three (3) days after a statutory written demand for rent has been made or (ii) the Lease is terminated as described in the Non-Rent default section, then Landlord may do the following:
		<ol>
			<li>enter the Apartment and retake possession of it if the Tenants have moved out; or</li>
			<li>go to court and ask that the defaulting Tenant or Tenants be compelled to move out.</li>
		</ol>
	</li>
	<li>For the avoidance of doubt, the parties specifically agree that Landlord may proceed to do a summary nonpayment proceeding or holdover proceeding against only one Tenant or against all Tenants, in Landlord’s discretion. The Tenants hereby acknowledge that all Tenants are not necessary parties to any legal proceeding by Landlord against any single Tenant.</li>
	<li>Tenants or any individual Tenant shall pay and discharge all reasonable costs, attorney’s fees and expenses that may be incurred by Landlord or Landlord’s Agent in enforcing or attempting to enforce the covenants and provisions of this Lease. All rights and remedies under this Lease shall be cumulative and none shall exclude any other rights and remedies allowed by law.</li>
</ol>


<h2>19. REMEDIES OF LANDLORD AND TENANT LIABILITY</h2>

<p>If this Lease is ended by Landlord because of the Tenants’ default, the following are the rights and obligations of Tenants and Landlord.</p>

<ol type="a">
	<li>Tenants must pay the Monthly Rent until the end of the Term. Thereafter, Tenants must pay an equal amount for what the law calls "use and occupancy" until Tenants actually move out.</li>
	<li>Once Tenants move out completely, Landlord may re-rent the Apartment or any portion of it for a period of time, which may end before or after the end of the Term. Landlord may re-rent to a new Tenant at a lesser rent or may charge a higher rent than the rent in this Lease.</li>
	<li>Any legal action brought to collect one or more monthly installments of damages shall not prejudice in any way Landlord's right to collect the damages for a later month by a similar action.</li>
	<li>If Tenants do not do everything they agreed to do pursuant to this Lease or if the Tenants do anything that shows that Tenants intend not to do what they have agreed to do pursuant to this Lease, then Landlord has the right to ask a Court to order Tenants to carry out their agreements in this Lease or to give the Landlord such other relief as the Court can provide.</li>
	<li>If Tenants fail to timely correct a default after notice from Landlord, Landlord may correct it at Tenants’ expense. Landlord’s costs to correct the default shall be Additional Rent.</li>
	<li>Whether Landlord releases the Apartment or assigns the Lease or any portion of it, Tenant must pay Landlord as damages the difference between fees (whether Monthly Rent or otherwise) collected and what would have been the remaining term of this Lease.</li>
</ol>

<h2>20. FEES AND EXPENSES</h2>

<ol type="a">
	<li>
		Tenants must reimburse Landlord for any of the following fees and expenses incurred by Landlord:
		<ol>
			<li>Making any repairs to the Apartment or the Building which result from misuse or negligence by any Tenant and/or his or her family, guests, employees, visitors, and/or invitees;</li>
			<li>Correcting any violations of city, state or federal laws or orders and regulations of insurance rating organizations concerning the Apartment or the Building caused by any Tenant and/or his or her family, guests, employees, visitors, and/or invitees;</li>
			<li>Preparing the Apartment for the next tenants if all Tenants moves out of the Apartment before the end of the Term;</li>
			<li>Any legal fees and disbursements for legal actions or proceedings brought by Landlord against any Tenant because of a default by any Tenant and/or for defending lawsuits brought against Landlord by any Tenant or because of the actions of any Tenant and/or her or her family, guests, employees, visitors, and/or invitees;</li>
			<li>Removing any Tenant’s property after Tenant moves out.</li>
			<li>Repairing or replacing property damaged by or caused by the misuse or negligence of Tenant and/or his or her family, guests, employees, visitors, and/or invitees.</li>
			<li>All other fees and expenses incurred by Landlord because of a Tenant’s failure to obey any other provisions and agreements of this Lease.</li>
		</ol>
	</li>
	<li>These fees and expenses shall be paid by Tenant to Landlord as Additional Rent within Ten (10) days after Tenants receive Landlord's bill or statement. If this Lease has ended when such Additional Rent is incurred, Tenants will still be liable to Landlord for the same amount as damages.</li>
</ol>

<h2>21. MODIFICATION</h2>

<p>THIS LEASE MAY BE MODIFIED BY LANDLORD TO ADD TENANTS. ALL MODIFICATIONS SHALL REQUIRE NOTICE AND CONSENT OF TENANTS. TENANTS SHALL NOT MODIFY THIS LEASE.</p>

<h2>22. BILLS AND NOTICES</h2>

<ol type="a">
	<li>Any notice from Landlord or Landlord's agent or attorney will be considered properly given to a Tenant or Tenants if such notice: (1) is in writing; (2) is signed by or in the name of Landlord or Landlord's agent; (3) is addressed to Tenant or Tenants at the Apartment; and (4) is hand delivered to Tenant or Tenants personally, sent by regular and certified mail, or sent by reputable overnight courier.</li>
	<li>The date of service of any written notice by Landlord to a Tenant under this Lease is the date of delivery or mailing of such notice.</li>
	<li>If a Tenant wishes to give a notice to Landlord, the Tenant must write it and hand deliver it or send it by regular and certified mail or by reputable overnight courier to Landlord at the addresses of which Landlord or Agent has given Tenant written notice.</li>
</ol>

<h2>23. PROPERTY LOSS, DAMAGES, OR INCONVENIENCE</h2>

<ol type="a">
	<li>Unless caused by the negligence or misconduct of Landlord or Landlord's agents or employees, Landlord or Landlord's agents and employees are not responsible to Tenants for any of the following:
		<ol>
			<li>Any loss of or damage to Tenants or their property in the Apartment or the Building due to any accidental or intentional cause, including but not limited to a theft or another crime committed in the Apartment or elsewhere in the Building;</li>
			<li>Any loss of or damage to Tenants’ property delivered to any employee of the Building (i.e., doorman, superintendent, etc.,); or</li>
			<li>Any damage or inconvenience caused to Tenants by actions, negligence, or violations of a lease by any other occupant of the Building, except to the extent required by law.</li>
		</ol>
	</li>
	<li>All property stored within the Apartment or the Building by Tenants shall be at Tenants’ sole risk. It is Tenants’ duty to provide insurance coverage on stored property for loss caused by fire or other casualty, including, without limitation, vandalism and malicious mischief, perils covered by extended coverage, theft, water damage (however caused), explosion, sprinkler leakage, and other similar risks.</li>
	<li>Landlord will not be liable for any temporary interference with light, ventilation, or view caused by construction by or on behalf of Landlord or owner of the Building. Landlord will not be liable for any such interference on a permanent basis caused by construction on any parcel of land not owned by Landlord. Also, Landlord will not be liable to Tenants for such interference caused by the permanent closing, darkening or blocking up of windows, if such action is required by law. None of the foregoing events will cause a suspension or reduction of the rent or allow Tenant to cancel the Lease.</li>
	<li>Landlord is not liable to Tenants for permitting or refusing entry to the Building to anyone in Landlord’s sole discretion.</li>
	<li>Except for the willful acts or negligence of Landlord or Landlord’s Agent, and except to the extent otherwise specifically provided in this Lease, Tenants hereby assumes all risk of loss and waives any claims it may have against Landlord or Landlord’s Agent, owner’s of the Building; and their respective director, officers, members, shareholders, partners, trustees managers, principals, agents, beneficiaries, employees and insurers (collectively, the “Protected Parties”) for any injury to or illness of person or loss or damage to property or business, or any person or entity by whomever or howsoever caused. Tenants shall protect, defend, indemnify and hold the Protected Parties harmless from and against any and all liabilities, claims, demands, costs and actions of whatever nature (including reasonable attorney’s fees) for any injury to or illness of person, or damage to or loss of property or business, in or about the Building caused or occasioned by Tenants, its invitees, servants, agents or employees, or arising out of Tenants’ use of the Apartment, or arising out of Tenants’ breach of this Lease. The provisions of this paragraph shall survive any expiration or termination of this Lease.</li>
	<li>ALL PROPERTY STORED WITHIN THE SUITE OR THE BUILDING BY TENANTS SHALL BE AT TENANTS’ SOLE RISK. IT IS THE TENANTS’ DUTY TO PROVIDE INSURANCE COVERAGE ON TENANTS’ PROPERTY FOR LOSS CAUSED BY FIRE OR OTHER CASUALTY, INCLUDING, WITHOUT LIMITATION, VANDALISM AND MALICIOUS MISCHIEF, PERILS COVERED BY EXTENDED COVERAGE, THEFT, WATER DAMAGE (HOWEVER CAUSED), EXPLOSION, SPRINKLER LEAKAGE AND OTHER SIMILAR RISKS. THE SUITE IS PROVIDED FOR TENANTS’ SELF-SERVICE AND IN NO EVENT SHALL LANDLORD OR LANDLORD’S AGENT BECOME A BAILEE (EITHER VOLUNTARILY OR OTHERWISE) OR ACCEPT OR BE CHARGED WITH THE DUTIES THEREOF, OF TENANTS’ PROPERTY.</li>
</ol>

<h2>24. FIRE OR CASUALTY</h2>

<ol type="a">
	<li>If the Apartment becomes unusable, in part or totally, because of fire, accident, or other casualty, this Lease will continue unless ended by Landlord or Tenants pursuant to this Lease. But the rent will be reduced immediately. This reduction will be based upon the part of the Apartment which is unusable.</li>
	<li>Landlord will repair and restore the Apartment, unless Landlord decides to take actions described in paragraph C below.</li>
	<li>After a fire, accident, or other casualty in the Building, Landlord or the Building’s owner may decide to tear down the area of the Building the Apartment is located in or the whole Building or to substantially rebuild either. In such case, Landlord need not restore the Apartment but may end this Lease. Landlord may do this even if the Apartment has not been damaged, by giving Tenants written notice of this decision within Thirty (30) days after the date when the damage occurred.</li>
	<li>If Landlord elects to terminate the Lease pursuant to any of the provisions thereof on account of a fire or other casualty or on account of a condemnation, then this Lease shall automatically terminate and expire upon the termination of the Lease. If Landlord or Landlord’s Agent has the right to terminate the Lease pursuant to any of the provisions thereof on account of a fire or other casualty or on account of a condemnation, then (i) Landlord or Landlord’s Agent may exercise such right or not in Landlord or Landlord’s Agent’s sole discretion and (ii) if Landlord or Landlord’s Agent so elects to terminate the Lease, this Lease and the Lease granted herein shall automatically terminate and expire upon the termination of the Lease.</li>
</ol>

<h2>25. PROPERTY MANAGEMENT ACKNOWLEDGMENTS</h2>

<ol>
	<li>Tenants acknowledge that the Apartment is managed by Outpost Club, Inc. (“Outpost” or “Property Manager”), as a property manager, under a Property Management Agreement (collectively the “PMA”).  As such, Outpost has the authority to act as a leasing agent for Landlord, including, without limitation, to execute this Lease on Landlord’s behalf and any modifications thereto.</li>
	<li>All leases and mortgages of the Building or of the land on which the Building is located, now in effect or made after this Lease is signed, come ahead of this Lease. In other words, this Lease is "subject and subordinate to" any existing or future lease or mortgage on the Building or land, including any renewals, consolidations, modifications and replacements of these leases or mortgages. If certain provisions of any of these leases or mortgages come into effect, the holder of such lease or mortgage can end this Lease. If this happens, Tenants agree that Tenants have no claim against Landlord or such lease or mortgage holder. If Landlord requests, Tenants will sign promptly an acknowledgment of the "subordination" in the form that Landlord requires.</li>
	<li>Tenants also agree to sign (if accurate) a written acknowledgment to any third party designated by Landlord that this Lease is in effect, that Landlord is performing Landlord's obligations under this Lease, and that Tenant has no present claim against Landlord.</li>
</ol>

<h2>26. GIVING UP RIGHT TO TRIAL BY JURY AND COUNTERCLAIM</h2>

<ol type="a">
	<li>Both Tenants and Landlord agree to give up the right to a trial by jury in a court action, proceeding, or counterclaim on any matters concerning this Lease, the relationship of Tenants and Landlord, or Tenants’ use or occupancy of the Apartment. This agreement to give up the right to a jury trial does not include claims for personal injury or property damage.</li>
	<li>If Landlord begins any court action or proceeding against a Tenant which asks that Tenant be compelled to move out, Tenant cannot make a counterclaim unless the Tenants is claiming that Landlord has not done what Landlord is required to do with regard to the condition of the Apartment or the Building.</li>
</ol>

<h2>27. ABANDONMENT OF PREMISES AND UNCLAIMED PROPERTY</h2>

<ol type="a">
	<li>In the event the Tenant abandons the premises, i.e. is not current with rent payments and is not living full time at the premises, the Landlord may dispose of the Tenant remaining personal property and fixtures as provided by state law. The Tenant agrees that the Landlord will determine if abandoned property is of value or to be treated as trash. Property of value will be inventoried and stored at the Tenant expense. There will be a daily storage charge assess by the Landlord depending on the size of valuables and the difficulty of storing the valuables. All charges must be paid before the stored items will be released by the Landlord to the Tenant. After sixty days, the Tenant agrees that Landlord may sell or dispose of the Tenants’ items.</li>
</ol>



<h2>28. GENERAL LEASE PROVISIONS</h2>

<ol type="a">
	<li>No Waiver of Lease Provisions
		<ol>
			<li>Even if Landlord accepts the Monthly Rent or fails once or more often to take action against a Tenant or Tenants when a Tenant has or Tenants have not done what they have agreed to do in this Lease, the failure of Landlord to take action or Landlord's acceptance of the Monthly Rent does not prevent Landlord from taking action at a later date.</li>
			<li>Only a written agreement between a Tenant and Landlord can waive any violation of this Lease. No exchange of electronic correspondence between the parties shall operate to amend, modify, or waive any term or provision of this Lease. An email exchange between the parties or their counsel will NOT be deemed “a writing” for purposes of this Lease.</li>
			<li>If Tenants pay and Landlord accepts an amount less than all the Monthly Rent due, the amount received shall be considered to be in payment of all or a part of the earliest Monthly Rent due. It will not be considered an agreement by Landlord to accept this lesser amount in full satisfaction of all of the Monthly Rent due.</li>
			<li>No waiver of any condition in this Lease shall be implied by any neglect of Landlord or Landlord’s Agent to enforce any remedy on account of the violation of any such condition and no receipt of money by Landlord or Landlord’s Agent after the termination in any way of the Term hereunder or after the giving of any notice shall reinstate, continue or extend the Term hereof or affect any notice given to Tenants.</li>
		</ol>
	</li>
	<li>
		Successor Interests and No Third Parties
		<ul>
			<li>The agreements in this Lease shall be binding on Landlord and Tenants and on those who succeed to the interest of Landlord and/or the Tenants by law, by approved assignment, or by transfer. None of the provisions of this Lease, however, are intended to be nor shall any of such provisions be construed to be for the benefit of any third party.</li>
		</ul>
	</li>
	<li>
		Captions
		<ul>
			<li>The captions are here only for the convenience of the parties. The text of the captions are not the terms of this Lease.</li>
		</ul>
	</li>
	<li>
		No Broker
		<ul>
			<li>Tenants represent that no broker or agent showed Tenants the Apartment or were otherwise involved in this transaction.</li>
		</ul>
	</li>
	<li>
		Entire Agreement
		<ul>
			<li>Tenants have read this Lease. All promises made by Landlord are in this Lease. All promises made by Landlord regarding occupancy (but not membership if required) are on this Lease. A default under this Lease by Tenant shall be a default under the corresponding Membership Lease between Landlord and Tenants.</li>
		</ul>
	</li>
	<li>
		Invalidity
		<ul>
			<li>If any provision of this Lease shall be held to be contrary to law or invalid under the law of any jurisdiction, such illegality or invalidity shall not affect any other provisions of this Lease in any way, and the other provisions of this Lease shall nevertheless continue in full force and effect.</li>
		</ul>
	</li>
	<li>
		Non-Military
		<ul>
			<li>Tenants represent and warrant that none of them are not in any branch of the armed services or the military services of the United States and that no Tenant is dependent on anyone in any branch of the armed services or the military services of the United States.</li>
		</ul>
	</li>
	<li>
		Counterparts
		<ul>
			<li>This Lease may be signed in separate counterparts, each of which shall be deemed an original, but all of which together shall constitute one instrument.</li>
		</ul>
	</li>
	<li>
		Authority to Sign
		<ul>
			<li>By signing this Agreement, Outpost Club, Inc., acting as Property Manager to the Landlord for the aforementioned apartment, directly and expressly warrants that it has been given and has received and accepted authority to sign and execute this Lease on behalf of the Landlord. Such authorization has been given by the Landlord to the Property Manager in a separate Property Management Agreement signed by both parties. Facsimile or PDF signatures shall be deemed to be original signatures for purposes of this Lease and any notice required to be served pursuant to this Lease.</li>
		</ul>
	</li>
</ol>

<p>Riders</p>
<ul>
	<li>Lead Paint</li>
	<li>Window Guards</li>
</ul>

<br>
{foreach  $guests as $g}
{if $contract_user->id != $g->user_id && $g->signing==1}
<p>Tenant {$users[$g->user_id]->name}</p>

<p>Signature</p>
<img src="{$config->contracts_dir}{$g->url}/signature.png" alt="{$g->name}" width="120">
<br>
<p>Date {$g->date_signing|date}</p>
<br>
<br>
{/if}
{/foreach}

{if !$contract_info->signing}
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
	<p>
		Tenant {$contract_user->name|escape}<br/>
		{if $contract_info->signing}
			Date {$contract_info->date_signing|date}<br/>
		{/if}
		Signature
	</p>
	<img src="{$config->contracts_dir}{$contract_info->url}/signature3.png" alt="Signature {$contract_user->name|escape}" width="180" />
{/if}

<br>
<br>

<p>
Date: {$contract_info->date_created|date}<br/>
Inventory Manager Signature (in care of Landlord):<br>
<img src="design/{$settings->theme|escape}/images/c_signature2.png" alt="Signature Ne-Bo" width="180" />
</p>

<br>

<hr>

<br>
<br>
<br>

<h1>SIGNATURE PAGE</h1>

{foreach  $guests as $g}
{if $g->signing==1}
<div class="fx ch2">
	<div>
		<p>Tenant {$users[$g->user_id]->name}</p>

		<p>Individual Term {$g->date_from|date} - {$g->date_to|date}</p>

		<p>Pro Rata Share of Monthly Rent {$g->price_month}</p>

		<p>Date {$g->date_signing|date}</p>
		<br>
	</div>
	<div>
		<img src="{$config->contracts_dir}{$g->url}/signature.png" alt="{$g->name}" width="120">
	</div>
</div>

{/if}
{/foreach}


<p><strong>Free Rent:</strong> All months prior to Individual Term stated above are free of rent.</p>

<p><strong>Exit Clause:</strong> Tenant is solely responsible for the individual term stated above. This Lease is not in effect for Tenant between the end date of the Individual Term until the end date of the Lease Term on the first page of this Lease.</p>

<p><strong>Outpost Membership Fee:</strong> Tenant agrees to enter into a separate Services Agreement between it and Outpost Club, Inc., pursuant to the Terms thereof.</p>

<p><strong>Pro Rata Share of Monthly Rent:</strong> Tenants are all jointly and severally liable for the Monthly Rent. Landlord will not seek to hold Tenant for more than the Pro Rata Share amount for any month or portion of a month in which the tenant has legal occupancy of the Apartment, except if, (1) Tenant causes any other occupant to vacate the Apartment; (2) Tenant causes any other occupant to be unable to move into the Apartment.</p>

<p><strong>Individual Term:</strong> TENANT AGREES THAT THIS LEASE IS VALID FOR THE TERM SET FORTH ON THE FIRST PAGE OF THIS LEASE. Tenant’s occupancy commences at noon on the first day of Individual Term, and ends at 5pm on the final day of the Individual Term.</p>

<p><strong>Consent to Additional/Replacement Tenants:</strong> Tenant agrees and consents to the addition of new tenants, provided, that any additional/new tenants execute this Lease and Lease Amendment.</p>

<br>

<hr>

<br>
<br>
<br>

<h1>HOUSE RULES</h1>

<p>Outpost provides House Rules to assure a safe and productive environment. If a member breaks any of the House Rules, Outpost will not renew or extend the member's lease.</p>

<p>These House Rules are incorporated into the Lease.  By adopting these House Rules, you understand that you are obligated to follow the rules and any violations thereof are subject to the penalties and remedies set forth herein or in any of the incorporated agreements.</p>

<h4>Move-in</h4>
<ul>
	<li>When Tenant moves into the premises, they will be required to furnish a valid government photo ID card and update all contact information.</li>
	<li>Property Manager is authorized to perform a background check of all Tenants, and deny tenancy based on false information provided in connection therewith.</li>
	<li>Standard moving hours are between 3 p.m. and 9 p.m.</li>
	<li>If Tenant moves in between the hours of 9 p.m. and 12 a.m. an additional $30 convenience fee shall be due upon arrival.</li>
	<li>If Tenant moves in between the hours of 12 a.m. and 8 a.m. an additional $70 convenience fee shall be due upon arrival. </li>
</ul>

<h4>Guests</h4>
<ul>
	<li>Unless otherwise permitted in writing pursuant to this Agreement, Tenants are not permitted overnight guests on the premises.</li>
	<li>Tenants is responsible for the appropriate behavior of your guests. Should Tenants’s guest(s) not behave responsibly and appropriately in accordance with the same rules and policy which Tenants is obligated to abide by, they will be asked to leave immediately.</li> 
	<li>Should Tenant fail to comply with the aforementioned obligations, Owner/Landlord and/or Property Manager may, at its sole discretion, terminate the Lease and require that Tenant and their guest(s) vacate the premises.</li>
	<li>Outpost Club reserves the right to curtail or even revoke the guest policy at Outpost Club’s sole discretion, if the revocation is for the safety of its members.</li>
</ul>


<h4>Residential Purposes Only</h4>
<ul>
	<li>Tenant Lease and rights as a Tenant are for residential purposes only. Tenants may not sell or market any products or services to any other tenants, subtenants or guests on the Premises.</li>
</ul>

<h4>Cleanliness</h4>
<ul>
	<li>It is recommended that Tenant will remove their shoes and keep their shoes on the shoe rack once the Tenant is inside the Apartment.</li>
	<li>Tenant will wash all kitchen appliances it uses each time after using them and will clean the sink of any food remnants it caused to be there. </li>
	<li>Tenant will leave no dishes or kitchen equipment in the sink.  Repeated violations of this rule can lead to the termination of Tenant’s Lease. Owner/Landlord and/or Property Manager reserves the right to check the cameras to identify who is violating this rule. Owner/Landlord and/or Property Manager only checks cameras once other tenants or House Leaders notify us of a violation.</li>
	<li>On the agreed schedule set forth in the Roommate Agreement, Tenants will have the responsibility of taking out the trash, wiping down the countertops, and emptying/running the dishwasher.</li>
	<li>Tenants are responsible for separating all waste by placing all garbage in its designated container for:
		<ol type="a">
		<li>Plastic Product</li>
		<li>Glass and Metal Products</li>
		<li>Paper Products</li>
		</ol>
	</li>
	<li>Tenants share fridge and freezer with their roommates.  Please be respectful of each other’s space and food.</li>
	<li>Tenant will not leave their belongings in the common areas.  Any such mislaid belongings may be removed and placed in a Lost and Found box.</li>
	<li>Tenants will clean the bathroom after they use the bathroom. This includes cleaning the shower, sink, toilet, mirrors, or anything else in the bathroom after use. Tenant will make sure to leave the bathroom in the condition it was found after Property Manager’s housekeeper has cleaned it.</li>
	<li>Tenant will remove hair from the drains to avoid clogging. This include the sink and shower drains.</li>
	<li>If Tenant clogs the toilet, Tenant is responsible for unclogging it with the provided bathroom plunger.</li>
	<li>Tenants are required to keep their bedrooms and common areas clean, sanitary, and organized.</li>
	<li>Property Manager shall provide cleaning services on a bi-weekly basis for all common areas and bathrooms. During those cleaning days, Tenants should organize their personal belongings in a way that allows the cleaners to mop and sweep the floor. Cleaning in Tenants bedrooms is not provided; however, Tenants can request that their bedrooms or common rooms be cleaned by raising a maintenance ticket in the customer portal at ne-bo.com. The service schedule/frequency may be amended according to governmental restrictions or to provide safety for tenants and/or employees of the company.</li>
	<li>Occasionally Owner/Landlord and/or Property Manager is dependent on third party services, including but not limited to, service companies for extermination, service of the equipment and appliances, plumbing, electrical, structural, internet, gas, furniture service, and air-conditioning.  Neither Property Manager nor Current Tenant(s) make any representations as to its obligations which are otherwise considered Owner/Landlord’s obligations.</li>
</ul>

<h4>Safety and Security</h4>
<ul>
	<li>Tenants will turn off all electronic devices in the common areas when not in use.</li>
	<li>Tenant will check and turn off oven and gas when not in use.</li>
	<li>Tenant recommends minimizing excessive alcohol consumption in the Apartment and on the Premises.</li>
	<li>Smoking/illicit drugs are not allowed anywhere inside or in front of the Building. Smoking of legal product is permitted in legally accessible rooftops, backyards, courtyards, front porches, front steps, or any other outdoor common areas on the premises.</li>
	<li>Dogs and Pets are not allowed in the Building. Service dogs should be indicated in the Lease prior to move-in during Agreement signing.</li>
	<li>Tampering with security cameras and smoke detectors, locks, or keypads is forbidden. Cost associated with fixing or sending Landlord Personnel to turn ON security cameras will be reimbursed from Tenant Security Deposit on the $50/case basis.</li>
	<li>Security cameras are installed in common areas and entrances of the Building. All the records of cameras are owned by Owner/Landlord and/or Property Manager, are automatically erased after one (1) week and used for security purposes only.  Access to the recordings is granted only with Outpost’s approval, unless otherwise required by law.  No cameras will be monitored, only checked in instances of potential agreement violations and to ensure the safety of all tenants and subtenants.</li>
	<li>Tenants consent to being photographed and/or videotaped in public areas and during Property Manager-sponsored events. These photographs and videos can be used in Outpost Club or its affiliates social media accounts, websites and blogs, newsletters, media content.</li>
	<li>Tenants shall not insert any metal object in the microwave.</li>
	<li>The USA electrical system is 110 V. Subtenants will not plug in electronics that cannot handle this voltage. Please check your electronics for any risk.</li>
	<li>Tenants will not affix anything to windows, walls, or any other part of the Premises without the consent of Owner/Landlord and/or Property Manager.</li>
	<li>Tenant will be given access to the house key or code. Tenant may not share their key or code with anyone other than Property Manager. This includes friends, guests, and/or other Members.</li>
	<li>Due to the nature of coliving operations, which include additional services, Owner/Landlord and/or Property Manager Personnel including but not limited to Cleaners, House Leaders, Community Manager, Service Personnel may enter common spaces of the Premises during the regular business hours without notice.</li>
	<li>Owner/Landlord and/or Property Manager Personnel may enter Premises in the event of an emergency, or with 12 hours / reasonable notice. </li>
</ul>

<h4>Noise and Nuissance</h4>
<ul>
	<li>During Quiet Hours, Tenants shall not play loud music, watch television loudly, talk loudly, sing loudly or engage in any other actions producing loud noises, unless otherwise permitted by Property Manager.</li>
	<li>Weekday Quiet Hours (Sunday through Thursday): 10 PM to  9 AM.</li> 
	<li>Weekend Quiet Hours (Friday and Saturday): 11:30 PM to 10 AM.</li> 
	<li>Property Manager may reduce Quiet Hours at its sole discretion.</li>
	<li>If, for any reason, other tenants or subtenants are affected by the smoking habits taking place on the premises, Property Manager reserves the right to require any tenant smoking to move to an area that will not affect the other tenants/subtenants. This may require that tenants smoke off the premises.</li>
	<li>All cigarette butts must be disposed of properly and may not be tossed on the ground. It is not Owner/Landord and/or Property Manager’s responsibility to provide proper disposal of cigarettes, however it is the Tenant’s responsibility to dispose of it properly.</li> 
	<li>Any unauthorized parties are forbidden in on the premises. Violation of this rule can lead to the termination of the Lease.</li> 
	<li>Noise Tracking devices are installed in the cameras of the premises.</li>
	<li>No group loitering is permitted outside the premises, in the corridors or common areas of the building or outside the building unless otherwise permitted by Property Manager.</li>
	<li>No unauthorized use of Torrents or other violations of any intellectual property rights is permitted using Property Manager-provided WiFi.  Property Manager reserves the right to block any Property Manager-provided WiFi or other Internet Service Provider for up to 24 hours. </li>
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
			</ol>
		</li>
	</ul>
	</li>
</ul>

<h4>Enforcement of Rules and Consequences of Violations</h4>
<p>Neither Owner/Landlord nor Property Manager monitors Tenants and neither would never want Tenants to feel monitored. Owner/Landlord and/or Property Manager’s goal is to make Tenants feel at home from the moment they arrive up to the moment they leave. In order to preserve this feeling of home, Property Manager has outlined these House Rules to communicate a vision of what home should be: a respectful, clean, comfortable space to connect with others.</p>

<p>In order to achieve this, Tenants must not only follow the rules, but report to Property Manager if and when rules are being broken. Property Manager cannot enforce violations of rules by Tenants that it is not aware of, therefore it is each Tenant’s responsibility to notify Property Manager when something is bothering them.</p>

<p>Please report all violations of the rules to <a href="mailto:customer.service@outpost-club.com" target="_blank">customer.service@outpost-club.com</a>.  When reporting please include the time, place, and description of the violation. If the person reporting knows who is involved, Property Manager would appreciate if the person reporting provides that information as well but understand if they do not want to. Please understand that Property Manager may not be able to resolve the issue if it does not know who commits the violation.</p>

<p>If Property Manager has reason to believe that a Tenant has broken the rules, Property Manager reserves the right to issue warnings, and in circumstances where the violation is heinous and/or is a threat to the other tenants/subtenants, Owner/Landlord and/or Property Manager reserves the right to terminate that violating Tenant’s Lease after warnings or immediately.</p> 


{foreach  $guests as $g}
{if $contract_user->id != $g->user_id && $g->signing==1}
<p>Tenant {$users[$g->user_id]->name}</p>

<p>Signature</p>
<img src="{$config->contracts_dir}{$g->url}/signature.png" alt="{$g->name}" width="120">
<br>
<p>Date {$g->date_signing|date}</p>
<br>
<br>
{/if}
{/foreach}

{if !$contract_info->signing}
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
	<p>
		Tenant: {$contract_user->name|escape}<br/>
	{if $contract_info->signing}
		Date: {$contract_info->date_signing|date}<br/>
	{/if}
	Signature
	</p>
	<img src="{$config->contracts_dir}{$contract_info->url}/signature4.png" alt="Signature {$contract_user->name|escape}" width="180" />
{/if}


<br>

<hr>

<br>
<br>
<br>



<h1>Outpost Service Agreement Memberships</h1>

<p>This Services Agreement (“Agreement”) is between <strong>Outpost Club Inc</strong> (“Company”), and <strong>{$contract_user->name|escape}</strong> (“Member”). There shall be no force or effect to any different terms of any related purchase order or similar form even if signed by the parties after the date hereof.  Company may change non-material terms herein by providing notice to Member and any material changes must be mutually approved by both parties.</p>

<p>Subject to the terms of this Agreement, Company will use commercially reasonable efforts to provide Member the Services in accordance with the Service Level Terms attached hereto as Appendix 1 and Appendix 2.</p>

{if $contract_info->membership==1 || $contract_info->membership==2 || $contract_info->membership==4}
<h2>Payment of Membership</h2>
<p>Customer will pay Company the then applicable one-time yearly fees according to service level chosen: {if $contract_info->membership==1}690 USD{elseif $contract_info->membership==2}79 USD{elseif $contract_info->membership==4}29 USD{/if}.</p>
{/if}

<p>Company reserves the right to change the Fees or applicable charges and to institute new charges and Fees at the end of the Initial Service Term after 1 year. If Customer believes that Company has billed Customer incorrectly, Customer must contact Company no later than 30 days after signing date on the first billing statement in which the error or problem appeared, in order to receive an adjustment or credit.  Inquiries should be directed to Company’s customer support department at <a href="mailto:customer.service@outpost-club.com" target="_blank">customer.service@outpost-club.com</a>.</p>

<strong><i>For the avoidance of doubt, the Membership Fee is not a commission on any rent amounts you are otherwise obligated to pay to Landlord/Owner of the property in which you are a tenant of.</i></strong>

<h2>Term and termination</h2>
<p>This Agreement is for the Initial Service Term of 1 year, and may be renewed only upon both parties’ consent.  For the avoidance of doubt, the Initial Service Term shall not be automatically renewed.</p>

<h2>Warranty and disclaimer</h2>
<p>Company shall use reasonable efforts consistent with prevailing industry standards to maintain the Services in a manner which minimizes errors and interruptions in the Services and shall perform in a professional and workmanlike manner.</p>
<p>Services may be temporarily unavailable for scheduled maintenance or for unscheduled emergency maintenance, either by Company or by third-party providers, or because of other causes beyond Company’s reasonable control, but Company shall use reasonable efforts to provide advance notice in writing or by e-mail of any scheduled service disruption.</p>  
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
	<li>The Member has access to all Club houses that have common spaces for use by the entire house. Members may only access the common areas of other houses that they do not have at their own house: Theaters, Workout Spaces, Coworking space, etc. They may not enter anyone else’s apartment without that respective tenant/subtenant’s consent.</li>
	<li>Subject to availability, the Member can move between Club houses with 30 days’ notice, by terminating their existing lease and entering into a new lease for that new unit.</li>
	<li>The Member must notify the Landlord (<a href="mailto:customer.service@outpost-club.com">customer.service@outpost-club.com</a>) inquiring about the availability for their guests. The member may request to reserve a bed or room for a guest as far in advance as the member duration of their lease, however, guest approval from the Landlord may remain tentative up until one week before the requested arrival date. The Landlord will provide confirmation of the guests stay from customer.service@outpost-club.com</li>
	<li>The Member may have an overnight guest on Club property during quiet hours (10 p.m. - 9 a.m.) for up to four nights per calendar month. After the member uses there four free nights for guests, the Member may only be have overnight guests by paying a $30 per night fee. The Member is limited to one overnight guest at a time for no longer than two consecutive days. Outpost Club can only provide the option of accommodating a paid guest if Outpost Club has a room or bed for the guest. If the Member is leasing a private room, the Member may add an additional person to their lease for $200 per month. This is upon the condition that the new tenant has applied to Outpost Club and has been approved, and has made payment in advance. Outpost Club reserves the right to reject all requests to add an additional person to the lease at their discretion.</li>
	<li>If the Member would like to have their guest stay in a room other than their own, the guest must stay in a room in the same apartment, and the Member must pay the over tenant $59 for new bed linens and $29 for post-stay cleaning. The Member may provide their own sheets, avoiding the $59 cost, but must either provide their own sheet or purchase them from Outpost Club; the guest can not sleep directly on the bed without bed linens.</li>
	<li>The Member, along with other Gold Members, will be provided the opportunity to enter into a lease at Club houses before such leases in the houses are made available to Silver Members and the general public.</li>
	<li>The Member will be afforded one additional week’s stay at a Club property within six months of the termination of their Membership agreement, provided the terms of the original contract were met in full and the Club is given at least one week’s notice of the intended stay.  Outpost Club can only provide the option of accommodating a free week’s stay if Outpost Club has a room or bed for the Member and only if local laws permit short term rentals. Outpost Club can only confirm the availability of a bed or room one week in advance of the Member’s one-week stay.</li>
	<li>For $250, the Member may terminate their lease with 30 days’ notice at any time during the length of the contract. The member will still be obligated to pay rent for the 30 days after the notice is given.</li>
	<li>The Member may temporarily terminate their Lease as well as the Services provided for herein for 30-90 days during the length of the Lease by giving 30 days’ notice. The length of the temporary Lease termination will be added to the end of the original lease Term, which the Member agrees to fulfill. The Member may only pause their membership once during the duration of this Membership Agreement and the Lease.</li>
	<li>The Club will provide the Member with accommodation for up to two additional nights at the end of the fulfilled contract by extending the term of the Lease should the Member’s travel plans fall through due to unforeseen circumstances. The Club cannot guarantee the Member will be able to stay in their previously leased unit.</li>
	<li>Standard move-in takes place between 3 p.m. and 9 p.m. daily. Gold Members may move in outside of standard move-in hours at no additional cost. </li>
	<li>The Member is afforded the opportunity to postpone payment of their Security Deposit up to two months after their arrival date. The deposit must be paid in full by the due date of the Member’s third month’s rent payment. If the member elects to postpone Security Deposit payment, they will pay the Security Deposit according to the following schedule below:
	<ol type="a">
	<li>The Member made the full security Deposit payment in advance of the arrival date.</li>

	{if $contract_info->invoices|count > 1 && $contract_info->split_deposit==1}
	{foreach $contract_info->invoices as $i}
		{if $i@iteration<3}
		<li>Security Deposit Payment for {$i->date_from|date:'M j'} - {$i->date_to|date:'M j'}: {($contract_info->price_deposit/2)|convert} USD, to be paid on or before {$i->date_for_payment|date:'M j'}</li>
		{/if}
	{/foreach}
	{/if}

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
	<li>The Member has access to only the Outpost Club House for which they are a tenant, except to attend Outpost Club events or visit other Club Members</li><li>Unless otherwise permitted in writing pursuant to this Agreement, Members are not permitted overnight guests on the premises, however, if the Member has leased a private room, they may  add an additional person to their lease for $200 per month. This is upon the condition that the new tenant has applied to Outpost Club and has been approved, and has made payment in advance. Outpost Club reserves the right to reject all requests to add an additional person to the sublease at their discretion.</li>
	<li>The Member may not cancel or pause their Lease before the end of the contract term.</li> 
	<li>Standard move-in takes place between 3 p.m. and 9 p.m. daily. Members who move in between 9 p.m. and 12 a.m. must pay a $30 fee upon arrival. Members who move in between 12 a.m. and 8 a.m. must pay a $70 fee upon arrival.</li> 
</ol>

{/if}

<p>
Outpost Club Inc<br/>
Sergii Starostin, CEO<br/>
<a href="mailto:customer.service@outpost-club.com" target="_blank">customer.service@outpost-club.com</a><br/>
DATE: {$contract_info->date_created|date}<br/>
SIGNATURE:
</p>
<img src="design/{$settings->theme|escape}/images/c_signature.png" alt="Signature Sergii Starostin" width="180" />
<p><br/></p>

<p>
Tenant: {$contract_user->name|escape}<br/>
{if $contract_info->signing}
	DATE: {$contract_info->date_signing|date}<br/>
{/if}
{if $contract_info->signature}
	MEMBER SIGNATURE:<br>
	<img src="{$config->contracts_dir}{$contract_info->url}/signature.png" alt="Signature {$contract_user->name|escape}" width="180" />
{/if}

</p>

