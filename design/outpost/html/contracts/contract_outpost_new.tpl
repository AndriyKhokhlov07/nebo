{* Full apt contract *}
{literal}
<style>
*,
div,
p,
ul,
ol,
li,
span{
	font-size: 13px !important;
}
h1{
	font-size: 17px !important;
	text-align: center;
}
h2{
	font-size: 15px !important;
	text-align: center;
}
p,
h1,
h2,
h3,
h4{
	margin-bottom: 10px;
}
img{
	display: block;
	margin-top: 10px;
}
li > h2{
	text-align: left;
}
.contract_table{	
	margin-bottom: 15px;
	width: 100%;	
}
.contract_table td, 
.contract_table th{
    border: #ccc 1px solid;
	font-size: 13px !important;
    padding: 10px 5px 8px;
}
.contract_table tr *:first-child {
	width: 85%;
}
.contract_table tr *:last-child {
	width: 15%;
	text-align: center;
}
.page-break-before{
	page-break-before: always;
}
.page-break-after{
	page-break-after: always;
}
</style>
{/literal}
{if $contract_info->signing == 1}
{literal}
<style>
*,
div,
p,
ul,
ol,
li,
span{
	font-size: 12px !important;
}
h1{
	font-size: 16px !important;
	text-align: center;
}
h2{
	font-size: 14px !important;
	text-align: center;
}
.contract_table td, 
.contract_table th {
	font-size: 12px !important;
	padding: 7px 5px 5px;
}
</style>
{/literal}
{/if}

<div>
	
<h1>PREAMBLE</h1>

<p>This document is a Sub Lease and a roommate agreement between the parties as defined on the Signature Pages attached to this Sub Lease (“the Sub Lease”), their assignees, if any, and Ne-Bo Services Corp (“Overtenant”). This document is a Sub Lease, in that, in consideration of the mutual covenants and agreements contained herein, Overtenant Sub Leases to Tenants (as defined on the Sub Lease Signature Pages) in the Apartment, in exchange for Tenants complying with all the terms and conditions in this agreement, which they promise to Overtenant, until the end of the term. </p>

<p>This document is also a roommate agreement, in that the Tenants acknowledge that one or more Tenants have signed this Sub Lease with Overtenant for the Apartment and that this agreement establishes the rights and responsibilities of each Tenant with respect to the others. Except as provided in this Sub Lease, the Tenants are jointly and severally liable for all duties of a Tenant under the Sub Lease.</p>

<p>Overtenant and Tenants agree that the Apartment will be used for co-living. Co-living means an arrangement by which a Overtenant rents a furnished Apartment to a group of Tenants, where the Tenants occupy and share the Apartment as roommates, an arrangement which the Overtenant consents to and facilitates as an active participant. A mutual goal of Overtenant and Tenants is to create a community within the Apartment. </p>

<h1>AGREEMENT</h1>
<p>Tenants and Overtenant make the Sub Lease as follows:</p>

<h2>ARTICLE 1 <br> IMPORTANT TERMS</h2>

<ul>
	<li>Date of Lease: {if $master_lease->date_from}{$master_lease->date_from|date_format:'%b %e, %Y'}{elseif $contract_info->id == 2807}{$contract_info->date_from|date}{elseif $new_lease_contract->signing == 1}{$new_lease_contract->date_signing|date}{else}{$smarty.now|date_format:'%b %e, %Y'}{/if}</li>
	<li>Tenant’s Names and Contact Information: See Signature Page</li>
	<li>Tenants includes any assignee of Tenants under a Sub Lease assignment approved by Overtenant.</li>
	<li>Overtenant: Ne-Bo Services Corp</li>
	<li>Overtenant includes Overtenant’s Agents</li>
	<li>Overtenant Address: P.O. 780316 MASPETH, NY, 11378</li>
	<li>Building: {$contract_info->rental_address}</li>
	<li>Apartment: {$apartment->name}, in the Building</li>
	<li>Term: {if !$master_lease}1 year,{/if} beginning on 
		{if $master_lease->date_from}
			{$master_lease->date_from|date_format:'%b %e, %Y'}
		{elseif $contract_info->id == 2807}{$contract_info->date_from|date}{else}{$new_lease_contract->date_signing|date}{/if} 
			and ending on 
		{if $master_lease->date_to}
			{$master_lease->date_to|date_format:'%b %e, %Y'}
		{elseif $contract_info->id == 2807}{(strtotime($contract_info->date_from) + (364*24*60*60))|date_format:'%b %e, %Y'}{elseif $new_lease_contract->signing == 1}{(strtotime($new_lease_contract->date_signing) + (365*24*60*60))|date_format:'%b %e, %Y'}{else}{(strtotime($smarty.now|date_format) + (365*24*60*60))|date_format:'%b %e, %Y'}{/if}</li>

	{*
	{if $booking->client_type_id==2}
		<li>Monthly Rent: {$booking->airbnb_reservation_id}</li>
		<li>Security Deposit: {$contract_info->price_deposit|convert} (US Dollars)</li>
	{else}
		<li>Monthly Rent: {if $apartment->property_price != '' && $apartment->property_price != 0}{$apartment->property_price|convert}{else}8,000{/if} (US Dollars)</li>
		<li>Security Deposit: {if $apartment->property_price != '' && $apartment->property_price != 0}{$apartment->property_price|convert}{else}8,000{/if} (US Dollars)</li>
	{/if}
	*}
	<li>Monthly Rent: {if $apartment->property_price != '' && $apartment->property_price != 0}{$apartment->property_price|convert}{else}8,000{/if} (US Dollars)</li>
	<li>Security Deposit: {if $apartment->property_price != '' && $apartment->property_price != 0}{$apartment->property_price|convert}{else}8,000{/if} (US Dollars)</li>
</ul>

<h2>ARTICLE 2 <br> THE NATURE OF THIS AGREEMENT</h2>

<p>THIS Sub LEASE AND ROOMMATE AGREEMENT IS FORMED BY ALL PARTIES. ALL TENANTS FORM A COMMON HOUSEHOLD WITHIN THE APARTMENT. TENANTS DO NOT RESIDE SEPARATELY AND INDEPENDENTLY OF EACH OTHER. TENANTS HAVE ACCESS TO ALL PARTS OF THE APARTMENT.</p>
 
<p>TENANTS ARE JOINTLY AND SEVERALLY LIABLE FOR THE MONTHLY RENT. THE ALLOCABLE PORTION OF THE MONTHLY RENT SET FORTH ON AGREEMENT SIGNATURE PAGE REPRESENTS AN AGREEMENT BETWEEN TENANTS REGARDING DIVIDING THE MONTHLY RENT BETWEEN THEM. ALLOCABLE PORTION OF THE MONTHLY RENT PROVISIONS OF THIS Sub Lease SHALL IN NO WAY LIMIT TENANTS’ JOINT AND SEVERAL LIABILITY FOR THE FULL MONTHLY RENT.</p>
 
<p>EACH TENANT AGREES TO ACT REASONABLY IN THEIR DEALINGS WITH OTHER TENANTS AND TO REFRAIN FROM ANY BEHAVIOR, ACTION OR INACTION THAT THE TENANT KNOWS, OR REASONABLY OUGHT TO KNOW, WILL INTERFERE WITH OTHER TENANTS’ QUIET ENJOYMENT.</p>

<h2>ARTICLE 3 <br> USE OF THE APARTMENT</h2>
<p>In consideration of the mutual covenants and agreements herein contained, Overtenant hereby Sub Leases to Tenants the Apartment, in exchange for Tenants complying with all the terms and conditions of this Sub Lease until the end of term.</p>
<ul>
	<li>Tenants shall use the Apartment for their own living purposes only.</li>
	<li>Tenants shall not violate Real Property Law § 235(f) or similar statute, commonly known as “the Roommate Law”, which, among other things, prohibits the combined number of Tenants and occupants to be more than the number of Tenants on a Sub Lease.</li>
	<li>Tenants shall not violate New York City’s Administrative Code Section 27-2075 or similar statute, which, among other things, limits the number of people who may legally occupy an Apartment of this size. </li>
	<li>Tenants shall not violate Multiple Dwelling Law § 4(8)(a) of similar statute, which, among other things, prohibits short-term leasing of an Apartment. The Apartment may not at any time be used for occupancy by any person on a transient basis, including, without limitation, the use of the Apartment as a party space, hotel, motel, dormitory, fraternity house, sorority house, or rooming house. Neither Tenants nor anyone on Tenants’ behalf may advertise for any such use of the Apartment on Airbnb.com or any other website, platform, newspaper, periodical, or other medium.</li>
	<li>Tenants shall not violate Zoning Resolution of the City of New York § 12-10, which, among other things, proscribes the ability to carry on a business inside an Apartment. </li>
	<li>Tenants shall not assign this Sub Lease or sublet the Apartment or Sub Lease or subSub Lease or permit anyone else to occupy the Apartment without Overtenant’s advance written consent, which consent may be withheld by Overtenant in its sole discretion, and in each instance in the manner required by Real Property Law § 226-b or similar statute. Any action contrary to this provision shall be void.</li>
	<li>Tenants agree to abide by, and cause its agents, invitees, and guests to abide by, all rules and regulations relating to the Apartment now in effect and such as may be promulgated from time to time hereafter by Overtenant or Overtenant’s Agent as set forth in this Sub Lease. </li>
	<li>Tenants shall not cause or permit the installation of any lock, deadbolt or other locking device or mechanism that controls the entrance door to any individual bedroom (“Bedroom Door”) within the Apartment. Tenants may use previously installed locking doorknob to lock an individual Bedroom Door from the inside, while such person(s) is/are in the bedroom. Tenants shall not change or replace any such locking doorknob. </li>
	<li>If the Apartment has multiple Bedrooms, Overtenant has and will have no involvement in the assigning of bedrooms within the Apartment to the Tenants except that the Allocable Portion of the Monthly Rent may change in the event Tenants select different bedrooms. Tenants are a Tenants of the entire Apartment.</li>
</ul>

<h2>ARTICLE 4 <br> RENT</h2>
<ul>
	<li>Tenants shall pay Overtenant the Monthly Rent, in advance, on the first day of each month that this Sub Lease is in effect; provided that with respect to any partial calendar month at the beginning or end of a Term, such fee shall be prorated for the number of days during such period. Tenants must pay the first full month’s rent due to Overtenant when Tenants sign this Sub Lease and must pay for any prorated amount of Monthly Rent for any partial calendar month when demanded by Overtenant. In the event that Monthly Rent is not received by the tenth (10th) day of the month when due, Tenants shall pay to Overtenant as Additional Rent a Late Charge in the amount of $100 for each delinquent payment for the purpose of defraying the expenses incurred in handling delinquent payments. </li>
 
	<li>Tenants agrees and affirms that Overtenant or Overtenant Agent is authorized to automatically charge a designated credit card or debit a designated bank account, or to process payment with any other applicable third-party payment processor, for Monthly Rent (“Recurring Payment”). Tenants further agrees to notify Overtenant promptly of any changes to Tenants’ credit card or debit card account, including but not limited to changes to Tenants’ credit card or debit card account number, expiration date, and/or billing address. Tenants further agrees to promptly notify Overtenant if Tenants’ credit card or debit card expires or is canceled for any other reason. Tenants represents and warrants that he or she is an authorized user of the credit card, debit card, or third-party payment processor platform account used to pay Monthly Rent. Tenants acknowledge and agree to provide Overtenant with a name, billing address and other information necessary to allow Overtenant to complete Recurring Payments made using a credit card, a debit card, or a third-party payment platform, or as required by other applicable law. In the event of declined payment, Overtenant reserves the right to demand that replacement payment and/or future payments be made by certified check, bank check or money order. In the event that Monthly Rent is returned for “insufficient funds” or for any other reason, Tenants shall pay, as Additional Rent, the greater of $50.00 and/or the actual fees, penalties and/or expenses incurred by Overtenant directly or indirectly caused by each such dishonored payment, as well as any applicable late fees or interest.</li>
	 
	<li>With respect to any Tenants, Overtenant or Overtenant’s Agent shall not be entitled to increase the Monthly Rent during the Term of the Sub Lease.</li>
	 
	<li>All amounts payable by Tenants pursuant to this Sub Lease in excess of the amount of the Monthly Rent shall be deeded “Additional Rent”. Overtenant shall have the same rights and remedies with respect to defaults in the payment of Additional Rent as Overtenant has with respect to payment of the Monthly Rent. Additional Rent shall be due within ten days of notice of such by Overtenant to Tenants in accordance with the notice provisions of this Sub Lease.</li>
	 
	<li>Tenants agree that the payment of the Monthly Rent and any Additional Rent or any other charges under this Sub Lease must be made timely and is an important consideration in Overtenant renting the Apartment to the Tenants. In addition to all other remedies available to Overtenant, all sums of Monthly Rent or Additional Rent or any other charges, which are not paid within ten (10) business days of the date when due under this Sub Lease, will bear interest from the original due date to the date of payment at a rate per annum which will be two (2) percentage points higher than the interest rate required to be paid on judgments for sums of money recovered in actions in the Supreme Court of the State of New York (by way of illustration only, presently 2% plus 9% equals 11%) but not more than the highest rate of interest which will at such time be permitted under the laws of the State of New York. This interest rate will be payable so long as the amount due is unpaid, even if the amount has been included in a court judgment.</li>
</ul>

<h2>ARTICLE 5 <br> ASSIGNMENT</h2>

<ul>
	<li>No Tenant can assign this Sub Lease without Owner’s advance written consent in each instance. If the Building contains four or more residential units, a Tenant must make a request to assign or sublet in the manner required by Real Property Law §226.b. If the Building contains four or more residential units, Owner may refuse to consent to a Sub Lease assignment for any reason or no reason, but if Owner unreasonably refuses to consent to request for a Sub Lease assignment or sublet properly made, at Tenant’s request in writing, Owner will end this Sub Lease effective as of thirty days after your request.</li>
	<li>
		<strong>TENANTS CONSENT TO THE ASSIGNMENT OF THIS SUB LEASE BY ANY OTHER TENANT IN THE APARTMENT TO AN ASSIGNEE OF Overtenant’S CHOOSING. TENANTS KNOWINGLY WAIVE ANY RIGHT TO KNOW THE IDENTITY OF SUCH ASSIGNEE IN ADVANCE OF THE ASSIGNMENT. TENANTS AGREE TO BE JOINTLY AND SEVERALLY LIABLE FOR ALL OBLIGATIONS OF THE SUB LEASE WITH SUCH ASSIGNEE.</strong> Overtenant and Tenants agree that: 
		<ul>
			<li>Overtenant covenants to find Tenants for this Sub Lease and introduce them to each other;</li>
			<li>Tenants are not responsible for finding Tenants.</li>
		</ul>
	</li>
	<li>If Tenants or any Tenant moves out of the Apartment before the end of this Sub Lease without the consent of Overtenant, this Sub Lease will not be ended. Tenants or Tenant will remain responsible for Monthly Rent as it becomes due until the end of this Sub Lease. </li>
</ul>
        
<h2>ARTICLE 6 <br> SECURITY DEPOSIT</h2>

<ul>
	<li>Tenants shall deposit with Overtenant an amount equal to one (1) month’s Monthly Rent as a security deposit (the “Security”) in accordance with the provisions of this Section 6 for Tenants’ faithful performance of his or her obligations under this Sub Lease. </li>
	<li>Tenants agrees and affirms that Overtenant is authorized to automatically debit a designated bank account, or to process payment with any other applicable third-party payment processor, for Security. Overtenant will notify Tenants of the name and address of the Bank in which the security is deposited.</li> 
	<li>If any Tenants or any Tenant does not pay Monthly Rent on time, Overtenant may, but is NOT required to, apply the Security to pay the Monthly Rent then due. If Tenants or a Tenant fails to timely perform any other term contained in this Sub Lease or causes any damage to the Apartment or the Building or to any of Overtenant or Overtenant’s Agent’s property contained therein, Overtenant may apply the Security for reimbursement of any sums Overtenant may spend, or damages Overtenant suffers because of Tenants’ failure.</li>
	 
	<li>If Overtenant applies any Security or any portion thereof, then Tenants shall, immediately upon notice from Overtenant, send to Overtenant an amount equal to the sum so applied by Overtenant, and that amount shall be due, when billed, as an Additional Rent hereunder. At all times the amount of Security stated above shall be maintained by Overtenant.</li>
	 
	<li>If a Tenants fully performs all terms of this Sub Lease, pay Monthly Rent on time, and timely vacates the Apartment and leaves same in good condition as required hereunder, then Overtenant will return any Security being held to such Tenants as per this section.</li>
	<li>If Overtenant sells or assigns the Sub Lease (as defined in this Sub Lease), Overtenant may give the security to the buyer or assignee. In that event, Tenants will look only to the buyer or assignee for the return of the Security and Overtenant will be deemed reSub Leased. </li>
	 
	<li>Overtenant may put the Security in any place permitted by law. The Security will bear interest only if required by law. Overtenant will give Tenants the interest when Overtenant is required to return the Allocable Security to a Tenants. Any interest returned to Tenants will be less the sum Overtenant is allowed to keep for expenses. Overtenant need not give a Tenant’s interest on the Allocable Security if such Tenants is in default. </li>

	<li>No Tenant shall use the Security to pay any portion of the Monthly Rent.</li>
</ul>

<h2>ARTICLE 7 <br> FURNITURE AND CONTENTS OF APARTMENT PROVIDED BY OVERTENANT</h2>
<p>The Apartment is Sub Leased furnished containing the items of household furniture, kitchen utensils, and other household items. Tenants agree to return all items provided at the start of Term in as good condition as when received, reasonable wear and tear excepted. Tenants will be responsible for all breakage or other damage to items provided and such damages are deductible from the Security. Chipped, cracked, or burned dishes will be counted as breakage.</p>

<h2>ARTICLE 8 <br> FAILURE OF OVERTENANT TO GIVE POSSESSION</h2>
<p>A situation could arise which might prevent Overtenant from letting a Tenant move into the Apartment on the beginning date set in this Sub Lease or on a subsequent date agreed to for occupancy. If this happens, Overtenant will not be responsible for Tenant’s damages or expenses, and this Sub Lease will remain in full force and effect; provided, however, in such case, the Tenant’s commitments under this Sub Lease shall begin when Overtenant gives Tenant three (3) calendar days’ notice by Contact Email (as set forth above in this Sub Lease) that Tenant is allowed to move in, and the ending date of the Initial Term will be changed, if necessary, to a new date. If Overtenant does not give Tenant notice that the move-in date is within thirty (30) calendar days after the Tenant’s expected move in, Tenant may inform Overtenant in writing that Tenant is canceling the Sub Lease as to that Tenant and any money paid by Tenant on account of this Sub Lease will then be refunded promptly by Overtenant. This Sub Lease will remain in full force and effect for any other Tenants of the Apartment. </p>

<h2>ARTICLE 9 <br>WARRANTY OF HABITABILITY AND ACCESS TO ALL PARTS OF THE APARTMENT</h2>
<ul>
	<li>All the sections of this Sub Lease are subject to the provisions of the Warranty of Habitability Law in the form it may have from time to time during this Sub Lease. </li>
 
	<li>Overtenant or Overtenant’s Agent reserves the right to decorate or to make repairs, alterations, additions, or improvements, whether structural or otherwise, in and about the Building and the Apartment, or any part thereof, and for such purposes to temporarily close doors, entryways, public space and corridors in the Building and to interrupt or temporarily suspend Building services and facilities, all without abatement of Monthly Rent or affecting any of Tenants’ obligations hereunder.</li>
	 
	<li>Tenants will do nothing to interfere or make more difficult Overtenant’s efforts to provide Tenants and all other occupants of the Building with the required facilities and services. Any condition caused by a Tenants’ misconduct or the misconduct of anyone under a Tenants’ direction and/or control shall not be a breach by Overtenant. </li>
	 
	<li>During reasonable hours and with reasonable notice, except in emergencies, and as required by law, Overtenant or Overtenant’s agent, Outpost Club, Inc. (“Overtenant’s Agent”) may enter the Apartment to erect, use and maintain pipes and conduits in and through the walls and ceilings of the Apartment; to inspect all parts of the Apartment, to make any repairs or changes that Overtenant or Overtenant desires or decides are necessary and to show all parts of the Apartment to investors, partners, and prospective tenants. The Monthly Rent will not be reduced because of any of this work, unless required by law. In the event that Overtenant performs any obligations required of Tenants to be performed hereunder, the amount paid by Overtenant to perform such obligations shall be due and payable by Tenants to Overtenant upon demand or charged as Additional Rent. </li>
	 
	<li>In the event of an emergency which affects the safety of the occupants of the Building or which may cause damage to the Building, Overtenant or Overtenant may enter the Apartment without prior notice to Tenants. If at any time Tenants are not personally present to permit Overtenant or Overtenant’s representatives to enter the Apartment and entry is necessary or allowed by law, Overtenant or Overtenant’s representatives may nevertheless enter the Apartment. Overtenant will not be responsible to Tenants in such case.  </li>
	 
	<li>Failure to provide access as per this section is a breach of a substantial obligation of this Sub Lease. </li> 
	 
	<li>Overtenant may retain a passkey to the Apartment. </li>
	 
	<li>Nothing contained in this Sub Lease shall be construed to impose any liability or obligations on Overtenant or require Overtenant to take any action or make any repairs to or maintain the Apartment or the Building.</li>
</ul>

<h2>ARTICLE 10 <br> KEY MANAGEMENT</h2>
<ul>
	<li>At the end of this Sub Lease, Tenants must return to Overtenant all keys, codes and entry devices either furnished or otherwise obtained. </li> 
 
	<li>If Tenants loses or fails to return any keys which were furnished to them, Tenants shall pay to Overtenant the cost of replacing such lost keys as Additional Rent. </li>
	 
	<li>Overtenant will only issue one key per Tenants. Overtenant is not required to issue extra keys to a Tenants’ family members or guests. </li>
	 
	<li>Codes provided by Overtenant for use by the Tenants to access the Apartment or Apartment are for Tenants’ use only and may not be shared or otherwise distributed. </li>
</ul>
<h2>ARTICLE 11 <br> CONDITION OF APARTMENT AND SERVICES AND FACILITIES</h2>
<ul>
	<li>Tenants have inspected the Apartment and accepts the Apartment in the condition it is in as of such inspection. Tenants acknowledges that the Apartment is free of defects. When Tenants entered into this Sub Lease they did not rely on anything said by Overtenant, its employees or agents about the physical condition of the Apartment, the Building or the land on which it is built. Tenants agree that Overtenant has not promised to do any work in the Apartment, unless what was said or promised is written in this Sub Lease and signed by both Tenants and Overtenant. </li>

	<li>Overtenant will provide cold and hot water and heat as required by law, elevator service if the Building has elevator equipment. </li>

	<li>Other Utilities. Lessor will provide electric, gas (if applicable), water and WiFi for the Apartment Unit as part of the monthly Rent, which shall be reimbursed by the Tenant at the rate of $149 per month, provided, however, that any measurable utility cost of an Apartment Unit that exceeds the average of the same type of utility in similar apartment units with similar number of occupants in the Apartment Building by more than 25%, Lessor reserves the right to charge a proportionate share of the costs in excess of such 25% to each Individual Tenant in the Apartment.</li>
	<li>Tenant does not need to arrange for utility service directly with the appropriate utility company or pay a separate charge for these utilities. Overtenant does not provide any land-based telephone service, equipment or system.</li>
	<li>To the extent the Apartment is separately metered for utilities, including, but not limited to, water, gas, electricity, telephone, internet, and cable, Tenants shall be responsible for paying the applicable utility provider for all usage incurred during the Term or during any period that Tenants have possession of the Apartment. Overtenant may, at its sole and absolute discretion, set up a utility account for the Apartment and pay for such usage or may include utilities charges as Additional Rent. Tenants are not entitled to any reduction in the Monthly Rent because of a stoppage or reduction of any of the above services unless such reduction is required by law. No other utilities or services are to be furnished by Overtenant or Overtenant’s Agent or used by Tenants in the Apartment without the prior written consent of Overtenant or Overtenant’s Agent and on the terms and conditions specified in such written consent. Tenants shall make no alterations or additions to the Apartment. </li>
	 
	<li>Appliances supplied by Overtenant in the Apartment are for Tenants’ use. Such appliances will be maintained and repaired or replaced by Overtenant, but if repairs or replacement are made necessary because of Tenants’ or any Tenant’s negligence or misuse, Tenants or Tenant will pay Overtenant for the cost of such repair or replacement as Additional Rent. Tenants must not use a dishwasher, washing machine, dryer, freezer, heater, ventilator, air-cooling equipment, or other appliance unless installed by Overtenant. </li>
	 
	<li>Tenants will not use more electric than the wiring or feeders to the Building can safely carry. </li>
	 
	<li>If Overtenant permits Tenants to use any storeroom, laundry room, bike rack, or any other facility (a “Facility”) located in or directly outside of the Building, the use of a Facility will be at Tenants’ own risk, except for loss suffered by a Tenants due to Overtenant’s gross negligence. </li>
	 
	<li>Because of a strike, labor trouble, national emergency, repairs, or any other cause beyond Overtenant’s reasonable control, Overtenant may not be able to provide or may be delayed in providing any services or in making any repairs to the Apartment. In any of these events, any rights Tenants may have against Overtenant are only those rights that are allowed by laws in effect when the reduction in service occurs. </li>

	<li>Certain services for additional fees may be offered by Overtenant. Overtenant is not required to provide any services or level of staffing other than those which are specifically set forth in this Sub Lease, or are offered and accepted through the Sub Lease and/or booking through the Manager’s portal. Any discontinuance or failure to perform such optional service shall not constitute a decrease in services under this Sub Lease. It is further understood that if Overtenant elects to provide any additional service which were not in effect as of the date of this Sub Lease, such additional service shall not be deemed a service for which the Individual Tenant is paying rent and if Overtenant shall, during the term of this Sub Lease, elect to withdraw such additional service from the Apartment Building, Overtenant shall not be subject to any liability nor shall Individual Tenant be entitled to any compensation or diminution or abatement of rent nor such revocation or diminution be deemed a constructive or actual eviction.</li>

	<li>Individual Tenant acknowledges that Overtenant makes no representation and assumes no responsibility whatsoever with respect to the functioning or operation of any of the human or mechanical security systems, if any, which Overtenant does or may provide. Individual Tenant agrees that Overtenant shall not be responsible or liable for any bodily harm or property loss or damage of any kind or nature which Individual Tenant or any Authorized Occupant and their guests and invitees may suffer or incur by reason of any claim that Lessor, its agents or employees has been negligent or any mechanical or electronic system in the Apartment Building has not functioned properly or that some other or additional security measure or system could have prevented the bodily harm or property loss or damage.</li>
</ul>

<h2>ARTICLE 12 <br> CARE OF THE APARTMENT AND THE BUILDING BY TENANTS</h2>         
  
<ul>
	<li>Tenants will take good care of the Apartment and will not permit or do any damage to it, ordinary wear and tear excepted. </li>
 
	<li>When a Tenant moves out on or before the ending date of this Sub Lease, such Tenant will leave the Apartment in good order and in the same condition as it was when the Tenant first occupied it, except for ordinary wear and tear and damage caused by fire or other casualty. At such time, the Tenant must remove all of its (as opposed to Overtenant’s) movable property. If the Tenant’s property remains in the Apartment after the Sub Lease ends, Overtenant may either treat the Tenant as still in occupancy and charge Tenant for such use, or may consider that Tenant has given up the Apartment and any property remaining in the Apartment. In this event, Overtenant may either discard the property or store it at the Tenant’s expense. Such Tenant agrees to pay Overtenant for all costs and expenses incurred in removing such property. The provisions of this article will continue to be in effect after the end of this Sub Lease. </li> 
	 
	<li>Tenants cannot build in, add to, change, or alter the Apartment in any way, including, but not limited to: wallpapering, painting, boring or drilling into walls or installing any paneling, flooring, “built in” decorations, partitions, or railings. Tenants may not change the plumbing, ventilating, air conditioning, electric or heating systems in the Apartment or the Building.</li> 
	 
	<li>If a lien is filed on the Apartment or Building for any reason relating to any Tenant’s fault, Tenant must immediately pay or bond the amount stated in the Lien. Overtenant may pay or bond the lien if the Tenant fails to do so within ten (10) days after Tenant has notice about the Lien. Overtenant’s costs in this regard shall be Additional Rent.</li>
	 
	<li>Tenants cannot place in the Apartment water-filled furniture. </li>
	 
	<li>Tenants shall not block or leave anything in or on fire escapes, the sidewalks, entrances, driveways, elevators, stairways, or halls of the Building. Public access ways shall be used only for entering and leaving the Apartment and the Building. Only those elevators and passageways designated by Overtenant can be used for deliveries. Baby carriages, bicycles or other property of Tenants shall not be allowed to stand in the halls, passageways, public areas or courts of the Building.  </li>
	 
	<li>The bathrooms, toilets and wash closets and plumbing fixtures shall only be used for the purposes for which they were designed or built; Tenants shall not place in them any sweepings, rubbish bags, acids, or other substances. </li>
	 
	<li>Tenants shall not hang or shake carpets, rugs, or other articles out of any window of the Building. Tenants shall not sweep or throw or permit to be swept or thrown any dirt, garbage, or other substances out of the windows or into any of the halls, elevators, or elevator shafts. </li>
	 
	<li>Tenants shall not place any articles outside of the Apartment or outside of the Building except in safe containers and only at places chosen by Overtenant. </li>
	 
	<li>Tenants shall use laundry and drying apparatus, if any, in the manner and at the times that the property manager or other representative of Overtenant may direct. Tenants shall not dry or air clothes on the roof. </li>
	 
	<li>Tenants shall comply with all applicable recycling laws. </li>
	 
	<li>An aerial may not be erected on the roof or outside wall of the Building without the written consent of Overtenant. Awnings or other projections shall not be attached to the outside walls of the Building or to any balcony or terrace. </li>
	 
	<li>Tenants are not allowed on the roof of the Building, except to the extent expressly permitted by Overtenant. </li>
	 
	<li>Tenants can use the elevator, if there is one, to move furniture and possessions only on days and hours designated by Overtenant. Overtenant shall not be liable for any costs, expenses or damages incurred by Tenants in moving because of delays caused by the unavailability of the elevator.</li> 
	 
	<li>The Apartment may have a terrace or balcony. The terms of this Sub Lease apply to the terrace or balcony as if part of the Apartment. Overtenant may make special rules for the terrace and balcony. Overtenant will notify Tenants of such rules. Tenants must keep the terrace or balcony clean and free and in good repair. No cooking is allowed on the terrace or balcony. </li>
	 
	<li>Tenants acknowledge that Tenants must take measures to prevent mold and mildew from growing in the Apartment. Tenants agree to remove visible moisture accumulating on the windows, walls, and other surfaces. Tenants agree not to cover or block any heating, ventilation, or air conditioning (HVAC) ducts in the Apartment. Tenants agree to immediately notify Overtenant of (i) any water leaks or excessive moisture in the unit, (ii) any evidence of mold or mildew, (iii) any failure of any HVAC systems in the unit, and (iv) any inoperable doors or windows. Tenants agree that Tenants shall be responsible for any damage to the unit and Tenants’ property as well as personal injury to any Tenants and occupants resulting from Tenants’ failure to comply with this Sub Lease provision. Any breach of this provision shall be considered a breach of a substantial obligation of this Sub Lease. </li>
</ul>

<h2>ARTICLE 13 <br>DUTY TO OBEY AND COMPLY WITH LAWS AND TO REFRAIN FROM OBJECTIONABLE CONDUCT</h2>

<ul>
	<li>Tenants will obey and comply with all present and future city, state and federal laws and regulations, which affect the Building or the Apartment; with all orders and regulations of Insurance Rating Organizations which affect the Apartment and the Building; and with the Rules and Regulations promulgated by Overtenant and attached to this Sub Lease. </li> 
	<li>Tenants will not allow any windows in the Apartment to be cleaned from the outside.</li> 
	 
	<li>Each Tenant is responsible for the behavior of Tenant and their family, guests, employees, visitors, and/or invitees. Tenant will reimburse Overtenant as Additional Rent upon demand for the cost of all losses, damages, fines, and reasonable legal expenses incurred by Overtenant because violation of this section.</li> 
	 
	<li><p>Tenant will not engage in Objectionable Conduct. Objectionable Conduct means behavior that:</p>
	    <ul>
	    	<li>causes conditions that are dangerous, hazardous, unsanitary, and/or detrimental to other occupants of the Building or Tenants; </li>
	    	<li>causes noises, sights, or odors in the Apartment or Building that are disturbing to other occupants of the Building or Tenants; </li>
	    	<li>will interfere with the rights, comforts, or convenience of other occupants of the Building; </li>
	    	<li>makes or will make the Apartment or the Building less fit to live in for other occupants of the Building or Tenants;</li>
	    	<li>interferes with the right of other occupants of the Building or Tenants to properly and peacefully enjoy their Apartments.</li>
	    </ul>
	</li>
	<li>Tenants shall not play a musical instrument or operate or allow to be operated speakers, radios, or television sets so as to disturb or annoy any other occupant of the Building. </li>
	<li>Any breach of the provisions of this Section 13 shall be considered a breach of a substantial obligation of this Sub Lease. Overtenant reserves the right, upon breach of this section of the Sub Lease by any Tenant, to proceed legally against all Tenants or against any individual Tenant. Tenants will reimburse Overtenant as Additional Rent for the cost of all losses, damages, fines, and reasonable legal expenses incurred by Overtenant because of a violation of this section.</li>
	<li>Tenant acknowledges that the Overtenant has not made any representations or promises with respect to noises or odors however arising and whether occurring inside or outside the Apartment Building, and Tenant waives and reSub Leases any claim, cause of action or set off by reason of or arising out of any noise, inconvenience, aromas, scents, or odors, however arising, and whether occurring inside or outside the Apartment Building.</li>
	<li>Individual Tenant shall not rescind this Sub Lease or be entitled to any compensation or diminution or abatement of rent nor shall Tenant fail to honor any other obligations under this Sub Lease by virtue of any of the above mentioned items. Individual Tenant and his or her Authorized Occupants, guests and invitees shall not permit any noxious odors or objectionable odors to emanate from Individual Tenant's Apartment Unit or any area of the Apartment Building. Further Tenant and his or her Authorized Occupants, guests and invitees shall not use, generate, store or dispose of any type of hazardous or toxic materials or substances at, from, or in the Apartment Unit or any area of the Apartment Building.</li>

</ul>

<h2>ARTICLE 14 <br> NO PETS</h2>
<p>Animals of any kind shall not be kept or harbored in the Apartment, unless in each instance it is expressly permitted in writing by Overtenant. Unless carried or on a leash, a dog shall not be permitted on any passenger elevator or in any public portion of the Building. </p>
 
<p>Unless there is a Pet Rider to the Sub Lease, You are representing to Overtenant that You do not have any pets and You have no intention of acquiring a pet. If You do acquire or intend to acquire a pet, You must obtain the prior written approval from Overtenant (which, except as may be required by a non-waivable provision of law, may be withheld for any or no reason). You must request such approval in writing. Your notice to Overtenant must include the name, type, breed, color, weight (which may not exceed 30 pounds, fully grown), size and age of Your pet, two photographs (one front and one side) of Your pet and a statement that You have no other pets, or if You do have other pet(s) describing those other pets. Except as may be required by a non-waivable provision of law, Overtenant WILL NOT CONSENT TO MORE THAN ONE DOG OR ONE CAT PER APARTMENT, ANY (EVEN ONE) PIT BULL, ROTHWEILLER, OR OTHER BREED OR ANIMAL THAT IS PRONE TO HAVING A VICIOUS NATURE, OR ANY OTHER ANIMAL (EXCEPT FOR SMALL BIRDS, SMALL FISH, SMALL RODENTS AND SMALL REPTILES). ANIMAL COMBINATIONS, SUCH AS ONE DOG AND ONE HAMSTER, ARE SUBJECT TO APPROVAL BY Overtenant. If Overtenant shall consent to Your having a pet, such consent will be SUBJECT TO YOUR COMPLIANCE WITH ALL BUILDING RULES AND ALL LAWS, RULES AND REGULATIONS. Any violation of this Article will give Overtenant the right to end the Sub Lease.</p>

<h2>ARTICLE 15 <br>END OF TERM</h2>

<p>At the expiration of the Term, Tenants shall yield up the Apartment, broom clean and in good repair, order, and condition, and remove all its property therein. Tenants acknowledges that possession of the Apartment must be surrendered to Overtenant or Overtenant’s Agent upon the expiration or earlier termination of the Term. If Tenants fail to deliver vacant possession of the Apartment in the manner required hereunder on or prior to the expiration or earlier termination of the Term, such failure will not be deemed to extend the Term and Tenants will pay to Overtenant or Overtenant’s Agent promptly upon demand therefor as and for liquidated damages, for each day or portion thereof during which Tenants retain possession of the Apartment after such expiration or earlier termination, an amount equal to 150% of the pro rata Allocable Portion of the Monthly Rent payable by Tenants during the Term (in addition to all other amounts set forth herein). The provisions of this Section 15 will not be deemed to limit or constitute a waiver of any other rights or remedies provided herein or at law or in equity, and Overtenant or Overtenant’s Agent may without notice, reenter the Apartment either by force or otherwise, and dispossess Tenants by summary proceedings or otherwise. Tenants will additionally indemnify and hold Overtenant or Overtenant’s Agent harmless from and against all loss, liability, costs and expenses of any kind or nature (including, without limitation, attorneys’ fees, and disbursements) resulting from or arising out of Tenants’ failure to comply with the provisions of this Section 15. Nothing herein contained will be deemed to permit Tenants to retain possession of the Apartment after the expiration or earlier termination the Term. The provisions of this Section 15 will survive the expiration or earlier termination of the Term.</p>
<p>If Tenants shall fail or refuse to remove any stored property upon termination of the Sub Lease, Overtenant or Overtenant’s Agent may treat such failure, as conclusive evidence that Tenants has abandoned the property and Overtenant or Overtenant’s Agent (or Owner if in possession of the Building) may enter the Apartment and dispose of all or any part of such property in any manner that Overtenant or Overtenant’s Agent (or Owner if in possession of the Building) shall choose. If Overtenant or Overtenant’s Agent’s employees are required to remove or handle the property or perform any services for Tenants, a charge for the same at Overtenant or Overtenant’s Agent’s customary rates on a time and material basis will be payable by Tenants. Tenants shall pay all costs Overtenant incurs in connection with removal of any Tenants’ property under this paragraph. </p>

<h2>ARTICLE 16 <br> TENANT DEFAULT </h2>
<ul>
	<li>As to a non-rent default by Tenants or any Tenant: </li>
 
	<li><p>Any Tenant defaults under the Sub Lease if he or she fails to carry out any agreement or provision of this Sub Lease. </p>
		<ul>
			<li>If a Tenant defaults, other than a default in the agreement to pay rent, Overtenant may serve the Tenant with a written notice to stop or correct the specified default within five (5) days. In such event, the Tenant must then stop or correct the default within five days. </li>
	 
			<li>If Tenant does not stop or correct a default for which Tenant has been noticed within five days, Overtenant may give Tenant a second written notice that this Sub Lease, with respect to that Tenants, will end Five (5) days after the date of such notice. At the end of the 5-day period, this Sub Lease, with respect to that Tenant, will end and Tenant then must move out of the Apartment. </li> 
			 
			<li>In the event of a non-rent default by a Tenant and a subsequent termination of Sub Lease pursuant to this section, then this Sub Lease will nevertheless remain in full force and effect for Overtenant and the remaining Tenants.</li>
		</ul>
	</li>
	<li><p>If (i) Tenants or any Tenant does not pay the Monthly Rent or any Additional Rent due pursuant to this Sub Lease when this Sub Lease requires such, within three days after a statutory written demand for rent has been made or (ii) the Sub Lease is terminated as described in the Non-Rent default section, then Overtenant may do the following: </p>
		<ul>
			<li>enter the Apartment and retake possession of it if the Tenants have moved out; or</li>
			<li>go to court and ask that the defaulting Tenants or Tenant be compelled to move out. </li>
		</ul>
	</li>
	<li>For the avoidance of doubt, the parties specifically agree that Overtenant may proceed to do a summary nonpayment proceeding or holdover proceeding against only one Tenant or against all Tenants, in Overtenant’s discretion. The Tenants hereby acknowledge that all Tenants are not necessary parties to any legal proceeding by Overtenant against any single Tenant. If Overtenant proceeds to do a summary proceeding or holdover proceeding against only one Tenant, this Sub Lease will nevertheless remain in full force and effect for Overtenant and the remaining Tenants.  </li>
	<li>Tenants or any individual Tenant shall pay and discharge all reasonable costs, attorney’s fees and expenses that may be incurred by Overtenant or Overtenant’s Agent in enforcing or attempting to enforce the covenants and provisions of this Sub Lease. All rights and remedies under this Sub Lease shall be cumulative and none shall exclude any other rights and remedies allowed by law. </li>
</ul>

<h2>ARTICLE 17 <br> REMEDIES OF LANDLORD AND TENANTS LIABILITY</h2>
<p>If this Sub Lease is ended by Overtenant with respect to Tenants or any individual Tenant because of the Tenants’ or any Tenant’s default, the following are the rights and obligations of Tenants and Overtenant. </p>
<ul>
<li>Tenant must pay the Monthly Rent until the end of the Term. Thereafter, Tenant must pay an equal amount for "use and occupancy" until Tenant actually moves out. </li>
 
<li>Once Tenant is out, Overtenant may re-Sub Lease the Apartment or assign the Sub Lease or any portion of it for a period of time, which may end before or after the ending date of this Sub Lease. Overtenant may re-Sub Lease or assign this Sub Lease to a new tenant at a lesser rate or may charge a higher rate than the Monthly Rent in this Sub Lease. </li>
 
<li>Whether Overtenant re-Sub Leases the Apartment or assigns the Sub Lease or any portion of it, Tenant must pay Overtenant as damages the difference between fees (whether Monthly Rent or otherwise) collected and what would have been the remaining term of this Sub Lease. </li>
 
<li>Any legal action brought to collect one or more monthly installments of damages shall not prejudice in any way Overtenant’s right to collect the damages for a later month by a similar action. </li>
 
<li>If a Tenant does not do everything they have agreed to do, or if a Tenant does anything which shows that Tenant intends not to do what he or she has agreed to do, Overtenant has the right to ask a Court to make such Tenants or Tenant carry out his or her agreements in this Sub Lease or to give the Overtenant such other relief as the Court can provide. </li>
 
<li>If Tenants or Tenant fail to timely correct a default after notice from Overtenant, Overtenant may correct it at Tenants’ or Tenant’s expense. Overtenant’s costs to correct the default shall be added to Monthly Rent. </li>
</ul>

<h2>ARTICLE 18 <br>FEES AND EXPENSES</h2>

<ul>
	<li><p>A Tenant must reimburse Overtenant for any of the following fees and expenses incurred by Overtenant:</p>
		<ul>
			<li>Making any repairs to the Apartment or the Building or furniture, appliances or personalty which result from misuse or negligence by any Tenant and/or his or her family, guests, employees, visitors, and/or invitees;</li> 
 
			<li>Repairing or replacing property damaged by or caused by the misuse or negligence of Tenant and/or his or her family, guests, employees, visitors, and/or invitees; </li>
			 
			<li>Correcting any violations of city, state or federal laws or orders and regulations of insurance rating organizations concerning the Apartment or the Building caused by Tenant and/or his or her family, guests, employees, visitors, and/or invitees; </li>
			 
			<li>Tenant to pay a $250 fee for cleaning the Apartment to prepare the Apartment for new tenant either at the expiration of the Term or assignment of the Sub Lease, which shall be paid during the final payment for Monthly Rent by Tenant or, upon consent of Tenant, by deducting $250 from the Security Deposit. </li>
			 
			<li>Any legal fees and disbursements for legal actions or proceedings brought by Overtenant against any Tenant because of a default by any Tenant and/or for defending lawsuits brought against Overtenant because of the actions of any Tenant and/or his or her family, guests, employees, visitors, and/or invitees; </li>
			 
			<li>Removing any Tenant’s property after Tenants moves out; and </li>
			 
			<li>All other fees and expenses incurred by Overtenant because of a Tenant’s failure to obey any other provisions and agreements of this Sub Lease. </li>
		</ul>
	</li>
	 
	<li>Tenants shall pay these fees and expenses to Overtenant as Additional Rent within ten (10) days after Tenant receives Overtenant’s bill or statement. If this Sub Lease has ended when these fees and expenses are incurred, Tenants will still be liable to Overtenant for the same amount as damages. </li>
</ul>

<h2>ARTICLE 19 <br>MODIFICATION</h2>
<p>THIS SUB LEASE MAY BE MODIFIED BY OVERTENANT TO ADD TENANTS WITHOUT NOTICE. ALL OTHER MODIFICATIONS SHALL REQUIRE NOTICE AND CONSENT OF TENANTS. TENANTS SHALL NOT MODIFY THIS SUB LEASE. </p>

<h2>ARTICLE 20 <br>BILLS AND NOTICES</h2>

<ul>
<li>Tenants agrees to notice by Overtenant via email to the email address provided by Tenants or by Overtenant or Overtenant’s Agent posting a notice on the Site. Tenants agrees that all agreements, notices, disclosures and other communications that Overtenant or Overtenant’s Agent provides electronically shall satisfy any legal requirement that such communications be in writing. </li>
<li>Any notice by Tenants to Overtenant or Overtenant’s Agent shall be given by email to Overtenant or Overtenant’s Agent at <a href="mailto:customer.service@outpost-club.com">customer.service@outpost-club.com</a> or such other or additional email or other address provided by Overtenant or Overtenant’s Agent from time to time or otherwise posted on the Site. </li>
</ul>

<h2>ARTICLE 21 <br>PROPERTY LOSS, DAMAGES, OR INCONVENIENCE</h2>
<ul>
	<li><p>Unless caused by the negligence or misconduct of Overtenant or Overtenant’s agents or employees, Overtenant or Overtenant’s agents and employees are not responsible to Tenants for any of the following: </p>
		<ul>
			<li>any loss of or damage to Tenants or their property in the Apartment or the Building due to any accidental or intentional cause, even a theft or another crime committed in the Apartment or elsewhere in the Building; </li>
			<li>any loss of or damage to Tenants’ property delivered to any employee of the Building (doorman, superintendent, property manager, etc.); or </li>
			<li>any damage or inconvenience caused to Tenants by actions, negligence or violations of a Sub Lease by any other Tenants or person in the Building except to the extent required by law.</li>
		</ul>
	</li>
 
<li>Overtenant will not be liable for any temporary interference with light, ventilation, or view caused by construction by or on behalf of Overtenant. Overtenant will not be liable for any such interference on a permanent basis caused by construction on any parcel of land not owned by Overtenant. Also, Overtenant will not be liable to Tenants for such interference caused by the permanent closing, darkening or blocking up of windows, if such action is required by law. None of the foregoing events will cause a suspension or reduction of the Monthly Rents or allow Tenants to cancel this Sub Lease.  </li>
 
<li>Overtenant is not liable to Tenants for permitting or refusing entry of anyone in the Building. </li> 
 
<li>Except for the willful acts or negligence of Overtenant or Overtenant’s Agent, and except to the extent otherwise specifically provided in this Sub Lease, Tenants hereby assumes all risk of loss and waives any claims it may have against Overtenant or Overtenant’s Agent, owner’s of the Building, and their respective directors, officers, members, shareholders, partners, trustees, managers, principals, agents, beneficiaries, employees and insurers (collectively, the “Protected Parties”) for any injury to or illness of person or loss or damage to property or business, of any person or entity by whomever or howsoever caused. Tenants shall protect, defend, indemnify and hold the Protected Parties harmless from and against any and all liabilities, claims, demands, costs and actions of whatever nature (including reasonable attorney’s fees) for any injury to or illness of person, or damage to or loss of property or business, in or about the Building caused or occasioned by Tenants, its invitees, servants, agents or employees, or arising out of Tenants’ use of the Apartment, or arising out of Tenants’ breach of this Sub Lease. The provisions of this paragraph shall survive any expiration or termination of this Sub Lease. </li>
 
<li>ALL PROPERTY STORED WITHIN THE APARTMENT OR THE BUILDING BY TENANTS SHALL BE AT TENANTS’ SOLE RISK. IT IS THE TENANTS’ DUTY TO PROVIDE INSURANCE COVERAGE ON TENANTS’ PROPERTY FOR LOSS CAUSED BY FIRE OR OTHER CASUALTY, INCLUDING, WITHOUT LIMITATION, VANDALISM AND MALICIOUS MISCHIEF, PERILS COVERED BY EXTENDED COVERAGE, THEFT, WATER DAMAGE (HOWEVER CAUSED), EXPLOSION, SPRINKLER LEAKAGE AND OTHER SIMILAR RISKS. THE APARTMENT IS PROVIDED FOR TENANTS’ SELF-SERVICE AND IN NO EVENT SHALL Overtenant OR Overtenant’S AGENT BECOME A BAILEE (EITHER VOLUNTARY OR OTHERWISE) OR ACCEPT OR BE CHARGED WITH THE DUTIES THEREOF, OF TENANTS’ PROPERTY.</li>

</ul>

<h2>ARTICLE 22 <br> FIRE, CASUALTY AND CONDEMNATION</h2>

<ul>
	<li>If the Apartment becomes unusable, in part or totally, because of fire, accident or other casualty, this Sub Lease will continue unless terminated by Overtenant or any Tenants pursuant to this Sub Lease. However, the Monthly Rents will be reduced immediately. This reduction will be based upon the part of the Apartment that is unusable. </li> 
 
	<li>Overtenant will repair and restore the Apartment, unless Overtenant decides to take actions described in paragraph C below.</li>
	 
	<li>If the Apartment is completely unusable because of fire, accident or other casualty and it is not repaired in thirty (30) days, any Tenants may give Overtenant written notice that he or she terminates this Sub Lease. If a Tenants gives such notice, this Sub Lease shall terminate with respect to that Tenants on the day that the fire, accident or casualty occurred. Overtenant will refund that Tenants’ security deposit and the pro-rata portion of Monthly Rent paid for the month in which the casualty happened. </li>
	 
	<li>If Overtenant elects to terminate the Sub Lease pursuant to any of the provisions thereof on account of a fire or other casualty or on account of a condemnation, then this Sub Lease shall automatically terminate and expire upon the termination of the Sub Lease. If Overtenant or Overtenant’s Agent has the right to terminate the Sub Lease pursuant to any of the provisions thereof on account of a fire or other casualty or on account of a condemnation, then (i) Overtenant or Overtenant’s Agent may exercise such right or not in Overtenant or Overtenant’s Agent’s sole discretion and (ii) if Overtenant or Overtenant’s Agent so elects to terminate the Sub Lease, this Sub Lease and the Sub Lease granted herein shall automatically terminate and expire upon the termination of the Sub Lease.  </li>
</ul>

<h2>ARTICLE 23 <br>SUBORDINATION CERTIFICATE AND ACKNOWLEDGMENTS</h2>
<ul>
	<li>Tenants acknowledge that the Apartment and the Building may be Sub Leased by Overtenant or Overtenant’s Agent, as Tenants, from an owner, pursuant to a Sub Lease or may be managed by Outpost Club, Inc. under a Management Sub Lease (collectively the “Over Sub Lease”). This Sub Lease is subject and subordinate to the Over Sub Lease and to all underlying Sub Leases and mortgages now or hereafter affecting the real property of which the Building is a part and to all renewals, modifications, consolidations, replacements and extensions of the Sub Lease and such underlying Sub Leases and mortgages. The provisions of this Section 23 shall be self- operative. Tenants covenants and agrees (1) to comply with all applicable terms and conditions of the Over Sub Lease to be performed by Overtenant or Overtenant’s Agent thereunder, (2) to not pay any Monthly Rent or other sums due under this Sub Lease for more than one (1) month in advance without Overtenant’s written permission, (3) that Tenants does not have any rights or interest in any other portion of the Building or Apartment except as specified under this Sub Lease, (4) that Tenants has no tenancy rights under the Over Sub Lease, (5) to look solely to Overtenant or Overtenant’s Agent for performance of any repair or other service request, concern, complaint, or the like in connection with the condition or occupancy of the Apartment, the Building or the area adjacent outside areas of the Building, (6) that no one other than Overtenant or Overtenant’s Agent shall have a liability or obligation: (a) to communicate with, deal with, or respond to requests of any kind from Tenants; (b) for Overtenant or Overtenant’s Agent’s failure to make any repair or provide any service in the Apartment, the Building; or (c) for any injury, loss or damage to Tenants or their property in the Apartment, or the Building; (7) that if the Over Sub Lease shall terminate for any reason, this Sub Lease shall terminate and Tenants shall promptly vacate the Apartment as if it were the expiration of the Term; and (8) in the event any Tenants fails to vacate the Apartment as required under this Sub Lease, Overtenant or Owner shall have a right to bring an action to evict such Tenants and such Tenants shall be liable for Overtenant’s or Owner’s expenses including reasonable attorney’s fees incurred in connection therewith. The provisions of this paragraph shall survive any expiration or termination of this Sub Lease.</li>
 
	<li>All Sub Leases and mortgages of the Building or of the land on which the Building is located, now in effect or made after this Sub Lease is signed, come ahead of this Sub Lease. In other words, this Sub Lease is "subject and subordinate to" any existing or future Sub Lease or mortgage on the Building or land, including any renewals, consolidations, modifications and replacements of these Sub Leases or mortgages. If certain provisions of any of these Sub Leases or mortgages come into effect, the holder of such Sub Lease or mortgage can end this Sub Lease. If this happens, Tenants agree that Tenants have no claim against Overtenant or such Sub Lease or mortgage holder. If Overtenant requests, Tenants will sign promptly an acknowledgment of the "subordination" in the form that Overtenant requires. </li>
	 
	<li>Tenants also agree to sign (if accurate) a written acknowledgment to any third party designated by Overtenant that this Sub Lease is in effect, that Overtenant is performing Overtenant's obligations under this Sub Lease, and that Tenants has no present claim against Overtenant. </li>
</ul>

<h2>ARTICLE 24 <br>WAIVER OF RIGHT TO TRIAL BY JURY AND COUNTERCLAIM</h2>

<ul>
	<li>Both Tenants and Overtenant agree to waive the right to a trial by jury in a court action, proceeding or counterclaim on any matters concerning this Sub Lease, the relationship of Tenants and Overtenant or Tenants’ use or occupancy of the Apartment.</li>
	<li>If Overtenant begins any court action or proceeding against a Tenants that asks that the Tenants be compelled to move out, Tenants cannot make a counterclaim unless the Tenants is claiming that Overtenant has not done what Overtenant is required to do with regard to the condition of the Apartment or the Building. </li>
</ul>

<h2>ARTICLE 25 <br>NO WAIVER OF LEASE PROVISIONS</h2>

<ul>
	<li>Even if Overtenant accepts a Tenants’ Monthly Rent or fails once or more often to take action against a Tenants when a Tenants have not done what that Tenants have agreed to do in this Sub Lease, the failure of Overtenant to take action or Overtenant’s acceptance of Monthly Rents does not prevent Overtenant from taking action at a later date. </li>
	<li>Only a written agreement between a Tenants and Overtenant can waive any violation of this Sub Lease. No exchange of electronic correspondence between the parties shall operate to amend, modify, or waive any term or provision of this Sub Lease or constitute a waiver of or estoppel against Overtenant’s right to insist upon Tenants’ full and timely performance of all the terms and/or conditions of this Sub Lease. An email exchange between the parties or their counsel will NOT be deemed “a writing” for purposes of this Sub Lease. </li>
	<li>If a Tenants pay and Overtenant accepts an amount less than all the Monthly Rent, the amount received shall be considered to be in payment of all or a part of the earliest Monthly Rent due. It will not be considered an agreement by Overtenant to accept this lesser amount in full satisfaction of all of the Monthly Rent due. </li>
	<li>No waiver of any condition in this Sub Lease shall be implied by any neglect of Overtenant or Overtenant’s Agent to enforce any remedy on account of the violation of any such condition and no receipt of money by Overtenant or Overtenant’s Agent after the termination in any way of the Term hereunder or after the giving of any notice shall reinstate, continue or extend the Term hereof or affect any notice given to Tenants. </li>
</ul>

<h2>ARTICLE 26 <br>SUCCESSOR INTERESTS</h2> 
  
<p>The agreements in this Sub Lease shall be binding on Overtenant and Tenants and on those who succeed to the interest of Overtenant and/or the Tenants by law, by approved assignment or by transfer. None of the provisions of this Sub Lease, however, are intended to be nor shall any of such provisions be construed to be for the benefit of any third party except for an Assignor who assumes the Sub Lease with Overtenant’s consent.</p>

<h2>ARTICLE 27 <br> CAPTIONS</h2>

<p>In any dispute arising under this Sub Lease, in the event of a conflict between the text and a caption, the text controls. </p>

<h2>ARTICLE 28 <br> INABILITY AND INDEMNITY</h2>

<p>This Sub Lease is made upon the express condition that, except to the extent caused by the negligence of Sub Lessor employees or agents, the Sub Lessor shall be free from all liabilities and claims for damages and/or suits for or by reason of any injury or injuries to any person or persons or property of any kind whatsoever, whether the person or property of Individual Tenant, his or her Authorized Occupants, guests or invitees, from any cause whatsoever while in or upon the subject premises or any part thereof during the Terms or occasioned by any occupancy or use of said premises or any activity carried on by Individual Tenant, his or her Authorized Occupants, guest or invitees, in connection therewith and Individual Tenant hereby agrees to indemnify and hold the Sub Lessor harmless from any liabilities, damages, loss, causes of action, charges, expenses (including counsel fees) and costs on account of or by reason of any such injuries, liabilities, claims, suits or losses however occurring or damages growing out of same.</p>

<h2>ARTICLE 29 <br> INSURANCE</h2>

<p>Sub Lessor shall not be liable for damage or loss of Individual Tenant's personal property (i.e., furniture, jewelry, clothing, etc.) or those of Individual Tenant's Authorized Occupants, guests and invitees, from the occurrences set forth in this Sub Lease or other causes whatsoever unless due to the Sub Lessor, its managing agent or employee's negligence. Individual Tenant agrees to obtain and retain, at Individual Tenant's sole cost and expense, for the term of this Sub Lease and any extensions or renewal's thereof, "Renter's" liability insurance with a minimum coverage of USD 100,000.00 per occurrence for bodily or personal injury and list Lessor as an additional insured under such policy. Individual Tenant's failure to obtain and maintain such insurance shall constitute an event of default under the Sub Lease availing the Lessor of its rights and remedies provided in this Sub Lease. It is recommended that Individual Tenant, at Individual Tenant's sole cost and expense, obtain and retain minimum contents insurance of USD 50,000.00 per occurrence for property damage and loss. Individual Tenant shall pay for damages suffered by and reasonable expenses of Sub Lessor relating to any claim arising from any act or negligence committed by Tenant. As a condition of this Sub Lease, Individual Tenant must supply proof of insurance required hereunder prior to the Commencement Date and prior to any renewal hereof; additionally Tenant shall supply proof of such insurance to the Sub Lessor at any time during the Term of this Sub Lease within thirty (30) days following request by Lessor.</p>

<h2>ARTICLE 30 <br> LIABILITY</h2>

<p>Except to the extent caused by the negligence of Sub Lessor's employees or agents, Sub Lessor shall not be liable for damage occasioned by or from plumbing, gas, water, sprinklers, steam or other pipes or sewage or the bursting, leaking or running of any pipes, tanks or plumbing fixtures, in, above, upon or about the Apartment Unit or Apartment Building, nor for any damage occasioned by water, snow or ice being upon or coming through the roof, windows or otherwise, nor for and damage arising from the acts, or neglect of other Individual Tenants, their Authorized Occupants, guest and invitees or other occupants of the Apartment Unit or the Apartment Building or of any owners, or occupants of adjacent or contiguous apartments.</p>
<p>Except to the extent caused by the negligence of Sub Lessor's employees or agents, Sub Lessor shall not be liable for damage or loss of Individual Tenant's or his or her Authorized Occupants', guests' or invitees' personal property (furniture, jewelry, clothing, etc.) from theft, water, fire, vandalism, rains, storms, smoke, exposures, sonic booms or other causes whatsoever.</p>
<p>Except to the extent caused by the negligence of Sub Lessor's employees or agents, each Individual Tenant, and their Authorized Occupants, guests and invitees assumes all risk of personal injury to themselves and to others, in their use and occupancy of the Apartment Unit and any other portions of the Apartment Building.</p>
<p>You must pay for damages suffered by and reasonable expenses of Sub Lessor relating to any claim or arising from any act or neglect committed by you, your Authorized Occupants, guests and invitees. In such event all Individual Tenants shall be held individually liable for any damages. If an action is brought against Sub Lessor arising from your act or neglect, or the act or neglect of your Authorized Occupant, guest or invitee, you shall defend Lessor at your expense with an attorney of Sub Lessor's choice.</p>

<h2>ARTICLE 31 <br> CORRECTING YOUR DEFAULT</h2>

<p>If Sub Lessor is compelled to pay any expense, including reasonable attorney's fees in instituting, prosecuting or defending any action or proceeding instituted by reason of you, or your Authorized Occupant, guest or invitee, breaching or defaulting under the terms of this Sub Lease, the money paid by Sub Lessor with all interest, costs and damages shall be deemed to be additional rent hereunder and shall be due from you to Sub Lessor on the first day of the month following the payment of such expenses.</p>

<h2>ARTICLE 32 <br>SECOND HAND SMOKE</h2>

<ul>
	<li>Tenants acknowledges that scientific studies have shown that second hand smoke, smoke created by the burning of tobacco or other substance by one individual which is present in the environment and which may be inhaled by other individuals, poses a significant health risk. Smoking or using electronic cigarettes is not allowed inside of residential units, outside of areas that are part of residential units (such as balconies, patios, porches), outdoor common areas, or outdoors within 15 feet of entrances, exits, windows, and air intake units on property grounds. The failure to comply with any condition described in this paragraph shall constitute a violation of a substantial obligation of tenancy. Nothing in this provision shall make Overtenant or its agents and employees the guarantor of Tenants’ health or of the smoke-free condition of any Apartment or common area of the Building. Overtenant is not required to take any steps in response to smoking unless Overtenant has been given written notice of said smoking. </li>
</ul>

<h2>ARTICLE 33 <br> ENTIRE AGREEMENT AND CROSS DEFAULT</h2>
<p>Tenants have read this Sub Lease. All promises made by Overtenant regarding occupancy (but not membership if required) are in this Sub Lease. A default under this Sub Lease by a Tenants shall be a default under the corresponding Membership Sub Lease between Overtenant and Tenants. </p>
   
<h2>ARTICLE 34 <br>RULES AND REGULATIONS</h2>   
<p>Tenant agrees, for itself, its agents, invitees and guests, to observe and comply at all times with the rules and regulations set forth herein and with such modifications thereof and additions thereto as Overtenant or Overtenant’s Agent may from time to time make for the Building, and that failure to observe and comply with such rules, regulations, modifications and additions shall constitute a default under the Sub Lease. Any failure by Overtenant or Overtenant’s Agent to enforce any rules and regulations now or hereafter in effect, either against Tenant or any other occupant or Tenant in the Building, shall not constitute a waiver of Overtenant or Overtenant’s Agent’s right to enforce any such rules and regulations at a future time. Rules are as follows: </p>
<ul>
	<li>Tenant is permitted an overnight guest up to 8 nights per month (2 nights/week). Guests must be at least 18 years of age; exceptions will be granted on a case-by-case basis. </li>
 
<li>Overnight guests are only permitted to sleep in Tenant’ bedrooms. Sleeping is not permitted in other parts of the Apartment or Building. </li>
 
<li>Tenant will not use, permit or store in the Apartment anything that will invalidate any policy of insurance now or hereafter carried on the Building or that will increase the rate of insurance on the Building. </li>
 
<li>Tenant will not: (a) store, use or permit anything in the Apartment that may be dangerous to life or limb; (b) in any manner deface or injure the Building or any part thereof; (c) overload the floors of the Apartment; (d) conduct any business in or from the Apartment; or (e) do anything or permit anything to be done in or upon the Apartment tending in any way to create a nuisance or tending to disturb any Tenant in the Building, or the occupants thereof. Tenant, at its sole cost, will fully and promptly comply with all government, health and police requirements, codes and regulations respecting the Apartment and the goods stored therein. </li>
 
<li>Tenant shall not bring upon, use or keep in the Apartment any hazardous or toxic materials, narcotics, explosives or flammable items, pets, animals, items that may leak, spill or freeze, or any illegal or stolen substance or property except as otherwise set forth herein. </li>
 
<li>Tenant shall not paint, display, affix, or inscribe any sign, color, advertisement or picture on the outside of the Building. </li>
 
<li>Tenant, and its agents and employees, shall not encumber or obstruct sidewalks, halls, passageways, exits, entrances, elevators, stairways or other Overtenant areas in or about the Building. Any discarded items, litter and debris must be deposited in rubbish areas and in the manner designated by Overtenant or Overtenant’s Agent. Tenant shall not cause any unnecessary janitorial labor or services by reason of Tenant’ litter, carelessness or indifference in the preservation of good order and cleanliness. </li>
 
<li>Smoking, candles, incense, refrigerators, space heaters and air conditioning units are prohibited throughout the Building. Smoking is permitted outside the Building provided it is at least fifteen (15) feet from any entryway. </li>
 
<li>Hotplates, rice cookers, or other electrical kitchen appliances are prohibited in bedrooms. </li>
 
<li>Tenant shall not do anything that would jeopardize the security of other members/Tenant or the community. Tenant shall keep the building locked at all times, and make sure its belongings are secure. </li>
 
<li>Bicycles must be kept in bike storage area and kept out of hallways, stairwells and Overtenant areas of the Apartments and Building. Bikes found in these areas will be removed. </li>
 
<li>Tenant shall let other Tenant get a full night’s rest. Tenant shall limit music that can be 
heard outside of his or her bedroom to before 10PM and after 8AM, and take the party 
elsewhere between those hours if someone is trying to sleep. </li>
 
<li>Damages caused by a Tenant (or her/his guest) will be Tenant’ responsibility. Any costs 
resulting from damages will be billed to Tenant involved. All Tenant in an Apartment share the  responsibility for damage of as kitchens, bathrooms, and living rooms.</li>
 
<li>Tenant and their guests may possess or consume alcoholic beverages as long as each person possessing/consuming alcohol is twenty-one (21) years of age or older and the 
consumption/service of alcohol is in compliance with New York State Law. </li>
 
<li>Tenant shall not engage in disorderly, disruptive, or aggressive behavior that impairs or interferes with the general comfort, safety, security, health, or welfare of the Apartment, 
Building, or community. </li>
 
<li>Upon the termination of the Term, Tenant shall deliver to Overtenant or Overtenant’s Agent all keys for the Apartment. Tenant shall not install any locks or make, or cause to be made, any  additional keys for the Apartment. </li>
 
<li>Tenant shall transport large personal items within the Building only upon or by vehicles 
equipped with rubber tires and shall cause such items to be carried in a freight elevator at such time that the Overtenant or Overtenant’s Agent shall fix. Movements of Tenant’ property into or out of the Building and within the Building are entirely at the risk and responsibility of Tenant, and Overtenant or Overtenant’s Agent reserves the right to require permits before allowing any such property to be moved into or out of the Building. Tenant shall fully cooperate with Overtenant or Overtenant’s Agent’s security measures.</li>
 
<li>Notwithstanding anything contained therein, the Overtenant or Overtenant’s Agent shall provide Tenant reasonable access to the Apartment.</li>
 
<li>Overtenant or Overtenant’s Agent reserves the right to make such other and further rules and regulations as in Overtenant or Overtenant’s Agent’s judgment may from time to time be needful for the safety, care and cleanliness of the Apartment and the prudent operation of the Building.</li>
 
<li>Each Tenant will respect the privacy of other Tenant. </li>
 
<li>Neither a Tenant nor its guests may use the Building or Apartment to conduct or pursue any activities prohibited by law or for which a Tenant or its guests are not authorized. Tenant shall be strictly liable for the activities of their guests. </li>
 
<li>Each Tenant hereby agrees not to conduct any activity that is generally regarded as offensive to other people, whether written, oral or in any form or medium known or to be created. No harassment, sexual or otherwise, will be permitted in the Building and Apartments. Any such harassment will be immediately reported to Overtenant. If Overtenant determines in its sole discretion that a complaint is justified, the offending party’s Sub Lease may be terminated.</li>
 
<li>Each Tenant hereby agrees not to conduct any activity that may be hazardous to other persons in the Building or Apartment. </li>
 
<li>Each Tenant hereby agrees to refrain from any activities that may be unreasonably disruptive, including, but not limited to, acts of disorderly nature or excessive noise.</li>

<li>No weapons of any kind are permitted in any Overtenant Building or Apartment unless Tenant is an active duty police or other law enforcement officer and has identified him or herself as such to Overtenant. Possession of weapons in the Building or Apartment other than by an active duty police or other law enforcement officer is grounds for immediate termination of this Sub Lease. </li>
 
<li>No additional furniture, appliances, furnishings or decorations shall be brought into the Building or Apartment, nor shall the installation of any satellite or microwave antennas, dishes, cabling, technology or telecommunications lines be permitted therein, without the prior written consent of Overtenant, which such consent may be given or withheld in Overtenant’s sole and absolute discretion. </li>

</ul>

<h2>SIGNATURE PAGE TO FOLLOW</h2>
<br>
<hr>
<br>

{foreach $users as $user}
{if $user->id != $contract_user->id && ($user->booking->client_type_id != 2 || in_array($contract->house_id, $airbnb_contracts_houses_ids))}
<h1>SUB LEASE SIGNATURE PAGE</h1>
<p>In the event of any inconsistency between the provisions of this Sub Lease Signature Page and the provisions of the Sub Lease to which this Sub Lease Signature Page is attached, the provisions of this Sub Lease Signature Page shall control.  Any defined terms contained herein not otherwise defined herein shall have the meaning so ascribed in the Sub Lease.</p>
<div>
	<p><strong>“Tenant”:</strong></p>
	<p>{$user->name|escape}</p>
</div>
<div>
	<p><strong>Tenant Email Address for Notice and Correspondence:</strong> </p>
	<p>{$user->email}</p>
</div>
<div>
	<p><strong>“Occupancy Term”</strong></p>
	<p>
		{if $user->booking->client_type_id == 2} {* Airbnb *}
			{$user->booking->arrive|date_format:'%b %e, %Y'} to {$user->booking->depart|date_format:'%b %e, %Y'}.
		{else}
			{$user->contract->date_from|date_format:'%b %e, %Y'} to {$user->contract->date_to|date_format:'%b %e, %Y'}.
		{/if}
	</p>
	<p>TENANT AGREES THAT THIS SUB LEASE IS VALID FOR THE TERM SET FORTH ON THE FIRST PAGE OF THIS SUB LEASE.  Tenant’s occupancy commences at noon on the first date of the Occupancy Term, and ends at 12 p.m. on the final day of the Occupancy Term.</p>
</div>
<div>
	<p><strong>
		{if $user->booking->client_type_id == 2} {* Airbnb *}
			“Total Amount”
		{else}
			“Allocable Portion of Monthly Rent”
		{/if}
	</strong></p>
	<p>
		{if $user->booking->client_type_id == 2} {* Airbnb *}
			{$user->booking->airbnb_reservation_id}.
		{else}
			{$user->contract->price_month|convert} (US Dollars).
		{/if}
	</p>
	<p>TENANT IS JOINTLY AND SEVERALLY LIABLE FOR THE MONTHLY RENT set forth on the first page of this Sub Lease. Overtenant will not seek to hold Tenant for more than the Allocable Portion of the Monthly Rent for any month or portion of a month in which that Tenant has legal occupancy of the Apartment, except if (1) Tenant causes any other occupant to vacate the Apartment; (2) Tenant causes any other occupant to be unable to move into the Apartment. Unless held jointly and severally liable for the Monthly Rent or any portion thereof, Tenant must pay the Allocable Portion of Monthly Rent for the entire Occupancy Term.</p>
</div>
<div>
	<p><strong>“Allocable Portion of Security Deposit”</strong></p>
	<p>{$user->contract->price_deposit|convert} (US Dollars).</p>
	<p>Allocable Portion of Security Deposit shall be assigned to an assignee in the event of Assignment of the Sub Lease. Tenant agrees to accept a cash payment from Overtenant equal to the Allocable Portion of Security Deposit (“Cash Payment”), less any costs deducted in accordance with the Sub Lease and less the Early Termination Fee, as consideration for the assignment of the Allocable Portion of Security Deposit.</p>
</div>
<div>
	<p><strong>“Bedroom Selection”</strong></p>
	<p>Room {$user->bed->name}.</p>
	<p>Tenant is free to change Bedroom Selection to another bedroom within the Apartment by consent of the tenant occupying the desired bedroom. Nothing herein contained shall require notification to Overtenant of such changes. Tenant agrees that the Allocable Portion of the Monthly Rent may be adjusted to reflect the portion of the Monthly Rent allocable to Tenant’s bedroom.</p>
</div>
<div>
	<p><strong>Consent to Assignment</strong></p>
	<p>At the end of the Occupancy Term or any termination of occupancy prior to the end of the Occupancy Term, Tenant consents to Assign this Sub Lease to an individual of Overtenant’s choosing. Tenant understands that the identity of the assignee shall not be provided to Tenant.</p>
</div>
<div>
	<p><strong>Additional Terms and Conditions of Sub Lease:</strong></p>
	<p>Tenant agrees to pay the Allocable Portion of Monthly Rent in the manner set forth for payment of Monthly Rent in the Sub Lease for the Occupancy Term and shall pay the Allocable Portion of the Monthly Rent for any additional period Tenant is in occupancy of the Suite. Occupancy after the end of the Occupancy Term is subject to the Overstay Fee.</p>
	<p>In the event Tenant remains in occupancy or has failed to remove all personal items beyond the  Occupancy Term, the Occupancy Term shall be automatically extended to the end of the Sub Lease Term and Tenant shall pay an overstay fee of $1500 (“<strong>Overstay Fee</strong>”) for each month or portion of a month from the end of the Occupancy Term to the end of the Sub Lease Term. Overstay Fee shall be Additional Rent. Tenants who remain in occupancy beyond the Sub Lease Term are subject to the liquidated damages set forth in the End of Term provision of this Sub Lease.  Tenant shall not occupy the Apartment or store or otherwise keep personal items in the Apartment or Building prior to the start of the Occupancy Term.</p>
	<p>In the event that Tenant terminates this Sub Lease to transfer to another Apartment or Building controlled by Overtenant or Overtenant’s Agent, which shall be in Overtenant’s or Overtenant’s Agent’s sole discretion, Tenant must assign this Sub Lease. In the event Tenant does not transfer after the request has been granted, Tenant shall pay the Overstay Fee for each month or portion of a month from the termination of the Occupancy Term to the end of the Sub Lease Term.</p>
	<p>If the end of the Occupancy Term precedes the end of the Sub Lease Term then Tenant shall pay an early termination fee in the amount of $890 (the “Early Termination Fee”).</p> 
</div>  

<div>
	<p><strong>Signatures and Commencement Date:</strong></p>
	<p>Overtenant and Tenant have signed this Sub Lease as of the Date of Sub Lease. It commences upon (1) Tenant’s acceptance by Overtenant’s Agent, Outpost Club, Inc, (2) the receipt of Tenant’s Allocable Portion of the Security Deposit and Allocable Portion of Monthly Rent due for the first month of the Occupancy Term (collectively “Commencement Requirements”). This Sub Lease shall have no effect and shall be mutually rescinded if Commencement Requirements are not met, and Tenant shall have no occupancy rights in the Apartment.</p>
</div>

{*
<div>
	<p><strong>Note:</strong></p>
	{if $contract_info->note1}
		<p>{$user->contract->note1}</p>
	{else}
		<p>None.</p>	
	{/if}
</div>
*}

<p><strong>TO CONFIRM OUR AGREEMENTS, OVERTENANT AND TENANT RESPECTIVELY SIGN THIS SUB LEASE AS OF THE DAY AND YEAR FIRST WRITTEN ON PAGE 1 OF THE SUB LEASE.</strong></p>
<p>Overtenant: Ne-Bo Services Corp<br/>
	SIGNATURE:<br/>
	<img src="design/{$settings->theme|escape}/images/c_signature.png" alt="Signature Sergii Starostin" width="180" />
<br/>By :<br/>
Title: Leasing Agent
</p>

{if $user->contract->signature}
<p>TENANT: {$user->name|escape}<br/>
	DATE: {$user->contract->date_signing}<br/>
	SIGNATURE:<br/>
	<img src="{$user->contract->signature}" alt="Signature {$user->name|escape}" width="180" />
</p>
{elseif $user->booking->client_type_id==2}
<p>TENANT: {$user->name|escape}<br/>
	DATE: {$user->booking->created|date_format:'%b %e, %Y'}<br/>
	DIGITAL SIGNATURE ID: {$user->booking->airbnb_reservation_id}<br>
</p>
{/if}
<br>
<hr>
<br>
{/if}
{/foreach}

<h1>SUB LEASE SIGNATURE PAGE</h1>
<p>In the event of any inconsistency between the provisions of this Sub Lease Signature Page and the provisions of the Sub Lease to which this Sub Lease Signature Page is attached, the provisions of this Sub Lease Signature Page shall control.  Any defined terms contained herein not otherwise defined herein shall have the meaning so ascribed in the Sub Lease.</p>
<div>
	<p><strong>“Tenant”:</strong></p>
	<p>{foreach $contract_users as $user}{if $contract_user->id != $user->id}{$user->name|escape}, {/if}{/foreach}{$contract_user->name|escape}</p>
</div>
<div>
	<p><strong>Tenant Email Address for Notice and Correspondence:</strong> </p>
	<p>{foreach $contract_users as $user}{if $contract_user->id != $user->id}{$user->email}, {/if}{/foreach}{$contract_user->email}</p>
</div>
<div>
	<p><strong>“Occupancy Term”</strong></p>
	<p>{$contract_info->date_from|date} to {$contract_info->date_to|date}.</p>
	<p>TENANT AGREES THAT THIS SUB LEASE IS VALID FOR THE TERM SET FORTH ON THE FIRST PAGE OF THIS SUB LEASE.  Tenant’s occupancy commences at noon on the first date of the Occupancy Term, and ends at 12 p.m. on the final day of the Occupancy Term.</p>
</div>
<div>
	{if $booking->client_type_id == 2}
		<p><strong>“Total Amount”</strong></p>
		<p>{$booking->airbnb_reservation_id}</p>
	{else}
		<p><strong>“Allocable Portion of Monthly Rent”</strong></p>
		<p>{$contract_info->price_month|convert} (US Dollars).</p>
	{/if}
	<p>TENANT IS JOINTLY AND SEVERALLY LIABLE FOR THE MONTHLY RENT set forth on the first page of this Sub Lease. Overtenant will not seek to hold Tenant for more than the Allocable Portion of the Monthly Rent for any month or portion of a month in which that Tenant has legal occupancy of the Apartment, except if (1) Tenant causes any other occupant to vacate the Apartment; (2) Tenant causes any other occupant to be unable to move into the Apartment. Unless held jointly and severally liable for the Monthly Rent or any portion thereof, Tenant must pay the Allocable Portion of Monthly Rent for the entire Occupancy Term.</p>
</div>
<div>
	<p><strong>“Allocable Portion of Security Deposit”</strong></p>
	<p>{$contract_info->price_deposit|convert} (US Dollars).</p>
	<p>Allocable Portion of Security Deposit shall be assigned to an assignee in the event of Assignment of the Sub Lease. Tenant agrees to accept a cash payment from Overtenant equal to the Allocable Portion of Security Deposit (“Cash Payment”), less any costs deducted in accordance with the Sub Lease and less the Early Termination Fee, as consideration for the assignment of the Allocable Portion of Security Deposit.</p>
</div>
<div>
	<p><strong>“Bedroom Selection”</strong></p>
	<p>Room {$bed->name}.</p>
	<p>Tenant is free to change Bedroom Selection to another bedroom within the Apartment by consent of the tenant occupying the desired bedroom. Nothing herein contained shall require notification to Overtenant of such changes. Tenant agrees that the Allocable Portion of the Monthly Rent may be adjusted to reflect the portion of the Monthly Rent allocable to Tenant’s bedroom.</p>
</div>
<div>
	<p><strong>Consent to Assignment</strong></p>
	<p>At the end of the Occupancy Term or any termination of occupancy prior to the end of the Occupancy Term, Tenant consents to Assign this Sub Lease to an individual of Overtenant’s choosing. Tenant understands that the identity of the assignee shall not be provided to Tenant.</p>
</div>
<div>
	<p><strong>Additional Terms and Conditions of Sub Lease:</strong></p>
	<p>Tenant agrees to pay the Allocable Portion of Monthly Rent in the manner set forth for payment of Monthly Rent in the Sub Lease for the Occupancy Term and shall pay the Allocable Portion of the Monthly Rent for any additional period Tenant is in occupancy of the Suite. Occupancy after the end of the Occupancy Term is subject to the Overstay Fee.</p>
	<p>In the event Tenant remains in occupancy or has failed to remove all personal items beyond the  Occupancy Term, the Occupancy Term shall be automatically extended to the end of the Sub Lease Term and Tenant shall pay an overstay fee of $1500 (“<strong>Overstay Fee</strong>”) for each month or portion of a month from the end of the Occupancy Term to the end of the Sub Lease Term. Overstay Fee shall be Additional Rent. Tenants who remain in occupancy beyond the Sub Lease Term are subject to the liquidated damages set forth in the End of Term provision of this Sub Lease.  Tenant shall not occupy the Apartment or store or otherwise keep personal items in the Apartment or Building prior to the start of the Occupancy Term.</p>
	<p>In the event that Tenant terminates this Sub Lease to transfer to another Apartment or Building controlled by Overtenant or Overtenant’s Agent, which shall be in Overtenant’s or Overtenant’s Agent’s sole discretion, Tenant must assign this Sub Lease. In the event Tenant does not transfer after the request has been granted, Tenant shall pay the Overstay Fee for each month or portion of a month from the termination of the Occupancy Term to the end of the Sub Lease Term.</p>
	<p>If the end of the Occupancy Term precedes the end of the Sub Lease Term then Tenant shall pay an early termination fee in the amount of $890 (the “Early Termination Fee”).</p> 
</div>  

<div>
	<p><strong>Signatures and Commencement Date:</strong></p>
	<p>Overtenant and Tenant have signed this Sub Lease as of the Date of Sub Lease. It commences upon (1) Tenant’s acceptance by Overtenant’s Agent, Outpost Club, Inc, (2) the receipt of Tenant’s Allocable Portion of the Security Deposit and Allocable Portion of Monthly Rent due for the first month of the Occupancy Term (collectively “Commencement Requirements”). This Sub Lease shall have no effect and shall be mutually rescinded if Commencement Requirements are not met, and Tenant shall have no occupancy rights in the Apartment.</p>
</div>

<div>
	<p><strong>Note:</strong></p>
	{if $contract_info->note1}
		<p>{$contract_info->note1}</p>
	{else}
		<p>None.</p>	
	{/if}
</div>

<p><strong>TO CONFIRM OUR AGREEMENTS, OVERTENANT AND TENANT RESPECTIVELY SIGN THIS SUB LEASE AS OF THE DAY AND YEAR FIRST WRITTEN ON PAGE 1 OF THE SUB LEASE.</strong></p>

<p>Overtenant: Ne-Bo Services Corp<br/>
	SIGNATURE:<br/>
	{if $contract_info->signature}
	<img src="design/{$settings->theme|escape}/images/c_signature.png" alt="Signature Sergii Starostin" width="180" />
	{/if}
</p>
<p>By :<br/>
Title: Leasing Agent
</p>

{foreach $contract_users as $user}
{if $user->id != $contract_user->id}
<p>TENANT NAME: {$user->name|escape}<br/>
	{if $user->log}
	DATE: {$user->log->date|date}<br/>
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
{if $contract_info->signature2}
	SIGNATURE:<br>
</p>
{/if}
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

{foreach $users as $user}
{if $user->id != $contract_user->id && ($user->booking->client_type_id != 2 || in_array($contract->house_id, $airbnb_contracts_houses_ids))}
	{if $user->contract->signature}
		<p>TENANT: {$user->name|escape}<br/>
			DATE: {$user->contract->date_signing}<br/>
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

{foreach $contract_users as $user}
{if $user->id != $contract_user->id}
<p>TENANT NAME: {$user->name|escape}<br/>
	{if $user->log}
	DATE: {$user->log->date|date}<br/>
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
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree1" for="agree1">I agree and sign</label><input type="checkbox" id="agree1" name="agree1" class="agree" value="1"></p>
{/if} 

<br>

<hr>

<br>
<br>
<br>

<h1>SPRINKLER DISCLOSURE</h1>
<p>Pursuant to the New York State Real Property Law, Article 7, Section 231-a, all residential leases must contain a conspicuous notice as to the existence or non-existence of a Sprinkler System in the Leased Premises. A “Sprinkler System” is a system of piping and appurtenances designed and installed in accordance with generally accepted standards so that heat from a fire will automatically cause water to be discharged over the fire area to extinguish it or prevent its further spread (Executive Law of New York, Article 6-C, Section 155-a(5)).</p>
<p>Name of tenant(s): <strong>{foreach $contract_users as $user}{if $contract_user->id != $user->id}{$user->name|escape}, {/if}{/foreach}{$contract_user->name|escape}</strong></p>
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

{foreach $contract_users as $user}
{if $user->id != $contract_user->id}
<p>TENANT NAME: {$user->name|escape}<br/>
	{if $user->log}
	DATE: {$user->log->date|date}<br/>
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
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree2" for="agree2">I agree and sign</label><input type="checkbox" id="agree2" name="agree2" class="agree" value="1"></p>
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
<p>Name of tenant(s): <strong>{foreach $contract_users as $user}{if $contract_user->id != $user->id}{$user->name|escape}, {/if}{/foreach}{$contract_user->name|escape}</strong></p>
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
	DATE: {$user->log->date|date}<br/>
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
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree3" for="agree3">I agree and sign</label><input type="checkbox" id="agree3" name="agree3" class="agree" value="1"></p>
{/if} 
<br>

<hr>

<br>
<br>
<br>

{include file='contracts/bx/rider_accommodations.tpl'}

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
{else}
<ul>
	<li><input type="radio" id="children1" name="children" class="agree" value="1" required><label id="block_children1" for="children1">CHILDREN 10 YEARS OF AGE OR YOUNGER LIVE IN MY APARTMENT</label> </li>
	<li><input type="radio" id="children2" name="children" checked class="agree" value="2" required><label id="block_children2" for="children2">NO CHILDREN 10 YEARS OF AGE OR YOUNGER LIVE IN MY APARTMENT</label></li>
	<li><input type="radio" id="children3" name="children" class="agree" value="3" required><label id="block_children3" for="children3">I WANT WINDOW GUARDS EVEN THOUGH I HAVE NO CHILDREN 10 YEARS OF AGE OR YOUNGER</label></li>
</ul>
{/if}
{foreach $users as $user}
{if $user->id != $contract_user->id && ($user->booking->client_type_id != 2 || in_array($contract->house_id, $airbnb_contracts_houses_ids))}
	{if $user->contract->signature}
	<p>TENANT: {$user->name|escape}<br/>
		DATE: {$user->contract->date_signing}<br/>
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

{foreach $contract_users as $user}
{if $user->id != $contract_user->id}
<p>TENANT NAME: {$user->name|escape}<br/>
	{if $user->log}
	DATE: {$user->log->date|date}<br/>
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
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree4" for="agree4">I agree and sign</label><input type="checkbox" id="agree4" name="agree4" class="agree" value="1"></p>
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
<p>This Addendum made on <strong>{$contract_info->date_created|date}</strong> by and between <strong>{foreach $contract_users as $user}{if $contract_user->id != $user->id}{$user->name|escape}, {/if}{/foreach}{$contract_user->name|escape}</strong> (“Tenant”) and Outpost Club Inc (“Overtenant”) shall become a part of and be incorporated into the attached Sub Lease Agreement (“Sub Lease”) dated <strong>{$contract_info->date_from|date}</strong> for <strong>{$apartment->name} at {$contract_info->rental_address}</strong> (“Apartment”).</p>
<ul>
	<li><strong>Basement.</strong> Tenant shall have limited access to the basement in the Apartment (“Basement”).</li>
	<li><strong>Use.</strong> The Tenant understands and agrees that the Basement shall only be used for the purpose of storage and not for living space.</li>
	<li><strong>No Storage of Dangerous Items.</strong> The Tenant understands and agrees that storage of any dangerous items in the Basement is strictly prohibited. Dangerous items include, but are not limited to, living animals, reptiles, insects, any hazardous, flammable, noxious, combustible materials or otherwise dangerous or illegal items that pose a risk or hazard to the safety of the Tenant and any other resident.</li>
	<li><strong>Tenant Responsibility for Storage.</strong> The Tenant understands and agrees that the Overtenant has no liability whatsoever for any damage or loss to any items stored by the Tenant in the Basement, whether caused by theft, fire, flooding, or otherwise.</li>
	<li><strong>Indemnification of Overtenant.</strong> The Tenant agrees to indemnify and hold the Overtenant harmless from and against any and all claims, actions, suits, judgments and demands brought by any other party on account of or in connection with any activity associated with the Basement. This includes but is not limited to, any damages caused by fire, insects, liquid or hazardous materials, water, or theft.</li>
	<li><strong>Access by Overtenant.</strong> Tenant understands and agrees that Overtenant has the right, to visit basement without notice, to enter the Basement to make routine inspections or necessary repairs.</li>
	<li><strong>Abandoned Items.</strong> Any items remaining in the Basement after the term of the Lease, or any extension thereof, will be deemed abandoned and will be removed, sold or otherwise disposed of by the Landlord.</li>
	<li><strong>Revocation of Addendum.</strong> Overtenant has, at its sole option, the right to revoke Tenant’s use of the Basement at any time. Tenant shall not be entitled to any damages incurred as a result of Landlord’s decision to revoke Tenant’s use of the Basement under this provision.</li>
	<li><strong>Control over Sub Lease.</strong> The terms of this Addendum shall control over the terms of the Sub Lease.</li>
	<li><strong>Binding effect.</strong> This Addendum shall bind all parties to the Lease and shall also bind all those succeeding to the rights of any party of the Sub Lease.</li>
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
	DATE: {$user->log->date|date}<br/>
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
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree5" for="agree5">I agree and sign</label><input type="checkbox" id="agree5" name="agree5" class="agree" value="1"></p>
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

{foreach $contract_users as $user}
{if $user->id != $contract_user->id}
<p>TENANT NAME: {$user->name|escape}<br/>
	{if $user->log}
	DATE: {$user->log->date|date}<br/>
	SIGNATURE:<br/>
	<img src="{$config->contracts_dir}{$contract_info->url}/signature-{$user->id}.png" alt="Signature {$user->name|escape}" width="180" />
	{/if}
</p>
{/if}
{/foreach}

{if $contract_info->signature}
<p>TENANT NAME: {$contract_user->name|escape}<br/>
{if $contract_info->signing == 1}
	DATE: {$contract_info->date_signing|date}<br/>
{/if}
	SIGNATURE:<br>
</p>
<img src="{$contract_info->signature}" alt="Signature {$contract_user->name|escape}" width="180" />
{/if}


</div>

{include file='contracts/bx/inventory_list.tpl'}
{include file='contracts/bx/fee_catalog.tpl'}

{if $contract_info->rider_type == 1}
	{include file='free_rent_doc/free_rent_month.tpl'}
{elseif $contract_info->rider_type == 3}
	{include file='free_rent_doc/rider_earlymovein.tpl'}
{/if}
