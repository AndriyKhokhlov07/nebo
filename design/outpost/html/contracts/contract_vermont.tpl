{* Contract Vermont *}
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
.contract_table tr > *:first-child {
	width: 85%;
}
.contract_table tr > *:last-child {
	width: 15%;
	text-align: center;
}
.contract_table tr > .w100,
.contract_table tr .w100 *:first-child,
.contract_table tr .w100 *:last-child{
	width: auto;
}
.contract_table .txt_bx,
.contract_table .txt_bx *,
.contract_table .txt_bx *:first-child,
.contract_table .txt_bx *:last-child{
	text-align: left;
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

<p>This document is a lease and a roommate agreement between the parties as defined on the Signature Pages attached to this Lease (“the Lease”), their assignees, if any, and Jacob Shapiro and Taylor Post (“Landlord”). This document is a lease, in that, in consideration of the mutual covenants and agreements contained herein, Landlord leases to Tenants (as defined on the Lease Signature Pages) in the Apartment in exchange for Tenants complying with all the terms and conditions in this agreement, which they promise to Landlord, until the end of the term.</p>
<p>This document is also a roommate agreement in that the Tenants acknowledge that one or more Tenants have signed this lease with the Landlord for the Apartment and that this agreement establishes the rights and responsibilities of each Tenant with respect to the others. Except as provided in this Lease, the Tenants are jointly and severally liable for all duties of a Tenant under the lease.</p>
<p>Landlord and Tenants agree that the Apartment will be used for co-living. Co-living means an arrangement by which a landlord rents a furnished Apartment to a group of Tenants, where the Tenants occupy and share the Apartment as roommates, an arrangement which the landlord consents to and facilitates as an active participant. A mutual goal of the Landlord and Tenants is to create a community within the Apartment.</p>

<h1>AGREEMENT</h1>
<p>Tenants and Landlord make the Lease as follows:</p>

<h2>ARTICLE 1 <br> IMPORTANT TERMS</h2>


<ul>

	{if $booking->type==2}
		<li>Date of Lease: {$contract_info->date_from|date_format:'%b %e, %Y'}</li>
		<li>Tenant’s Names and Contact Information: See Signature Page Tenants include any assignee of Tenants under a lease assignment approved by the Landlord.</li>
		<li>Landlord: Jacob Shapiro and Taylor Post Landlord includes Landlord’s Agents</li>
		<li>Landlord Address: {$landlord->address}</li>
		<li>Building: {$contract_info->rental_address}</li>
		<li>Apartment: {$apartment->name}, in the Building</li>
		<li>Term: beginning on 
			{$contract_info->date_from|date_format:'%b %e, %Y'}
			and ending on
			{$contract_info->date_to|date_format:'%b %e, %Y'}
		</li>
		<li>
			Monthly Rent:
			{if $contract_info->price_month}
				{$contract_info->price_month|convert}
			{elseif $apartment->property_price != '' && $apartment->property_price != 0}
				{$apartment->property_price|convert}
			{else}
				8,000
			{/if}
			(US Dollars)
		</li>
		<li>
			Security Deposit:
			{if $contract_info->price_month}
				{$contract_info->price_month|convert}
			{elseif $apartment->property_price != '' && $apartment->property_price != 0}
				{$apartment->property_price|convert}
			{else}
				8,000
			{/if}
			(US Dollars)
		</li>
	{elseif $booking->type==1}
		<li>Date of Lease:
			{if $master_lease->date_from}
				{$master_lease->date_from|date_format:'%b %e, %Y'}
			{elseif $new_lease_contract->signing == 1}
				{$new_lease_contract->date_signing|date_format:'%b %e, %Y'}
			{else}
				{$smarty.now|date_format:'%b %e, %Y'}
			{/if}
			</li>
		<li>Tenant’s Names and Contact Information: See Signature Page Tenants include any assignee of Tenants under a lease assignment approved by the Landlord.</li>
		<li>Landlord: Jacob Shapiro and Taylor Post Landlord includes Landlord’s Agents</li>
		<li>Landlord Address: {$landlord->address}</li>
		<li>Building: {$contract_info->rental_address}</li>
		<li>Apartment: {$apartment->name}, in the Building</li>
		<li>Term: {if !$master_lease}1 year,{/if} beginning on 
			{if $master_lease->date_from}
				{$master_lease->date_from|date_format:'%b %e, %Y'}
			{elseif $contract_info->id == 5839}
				Dec 4, 2020
			{elseif $contract_info->id == 2807}
				{$contract_info->date_from|date_format:'%b %e, %Y'}
			{else}
				{$new_lease_contract->date_signing|date_format:'%b %e, %Y'}
			{/if}
			and ending on
			{if $master_lease->date_to}
				{$master_lease->date_to|date_format:'%b %e, %Y'}
			{elseif $new_lease_contract->signing == 1}
				{(strtotime($new_lease_contract->date_signing) + (364*24*60*60))|date_format:'%b %e, %Y'}
			{else}
				{(strtotime($smarty.now|date_format) + (364*24*60*60))|date_format:'%b %e, %Y'}
			{/if}
		</li>
		<li>
			Monthly Rent:
			{if $apartment->property_price != '' && $apartment->property_price != 0}
				{$apartment->property_price|convert}
			{else}
				8,000
			{/if}
			(US Dollars)
		</li>
		<li>
			Security Deposit:
			{if $apartment->property_price != '' && $apartment->property_price != 0}
				{$apartment->property_price|convert}
			{else}
				8,000
			{/if}
			(US Dollars)
		</li>
	{/if}
</ul>

<h2>ARTICLE 2 <br> THE NATURE OF THIS AGREEMENT</h2>

<p>THIS LEASE AND ROOMMATE AGREEMENT IS FORMED BY ALL PARTIES. ALL TENANTS FORM A COMMON HOUSEHOLD WITHIN THE APARTMENT. TENANTS DO NOT RESIDE SEPARATELY AND INDEPENDENTLY OF EACH OTHER. TENANTS HAVE ACCESS TO ALL PARTS OF THE APARTMENT.</p>

<p>TENANTS ARE JOINTLY AND SEVERALLY LIABLE FOR THE MONTHLY RENT. THE ALLOCABLE PORTION OF THE MONTHLY RENT SET FORTH ON AGREEMENT SIGNATURE PAGE REPRESENTS AN AGREEMENT BETWEEN TENANTS REGARDING DIVIDING THE MONTHLY RENT BETWEEN THEM. ALLOCABLE PORTION OF THE MONTHLY RENT PROVISIONS OF THIS LEASE SHALL IN NO WAY LIMIT TENANTS’ JOINT AND SEVERAL LIABILITY FOR THE FULL MONTHLY RENT.</p>

<p>EACH TENANT AGREES TO ACT REASONABLY IN THEIR DEALINGS WITH OTHER TENANTS AND TO REFRAIN FROM ANY BEHAVIOR, ACTION OR INACTION THAT THE TENANT KNOWS, OR REASONABLY OUGHT TO KNOW, WILL INTERFERE WITH OTHER TENANTS’ QUIET ENJOYMENT. </p>

<h2>ARTICLE 3 <br> USE OF THE APARTMENT</h2>
<p>In consideration of the mutual covenants and agreements herein contained, Overtenant hereby Sub Leases to Tenants the Apartment, in exchange for Tenants complying with all the terms and conditions of this Sub Lease until the end of term.</p>
	<ul>
		<li>Tenants shall use the Apartment for their own living purposes only.</li>
		<li>Tenants shall not violate “the Roommate Law,” which, among other things, prohibits the combined number of Tenants and occupants to be more than the number of Tenants on a lease.</li>
		<li>Tenants shall not violate occupancy law, which, among other things, limits the number of people who may legally occupy an Apartment of this size.</li>
		<li>Tenants shall not violate Multiple Dwelling Laws, which, among other things, prohibit short-term leasing of an Apartment. The Apartment may not at any time be used for occupancy by any person on a temporary basis, including, without limitation, the use of the Apartment as a party space, hotel, motel, dormitory, fraternity house, sorority house, or rooming house. Neither Tenants nor anyone on Tenants’ behalf may advertise for any such use of the Apartment on Airbnb.com or any other website, platform, newspaper, periodical, or other medium, though the landlord may do so at their discretion.</li>
		<li>Tenants shall not carry on business or commercial activities inside the Apartment. </li>
		<li>Tenants shall not assign this Lease or sublet the Apartment or lease or sublease or permit anyone else to occupy the Apartment without Landlord’s advance written consent, which consent may be withheld by Landlord in its sole discretion and in each instance. Any action contrary to this provision shall be void.</li>
		<li>Tenants agree to abide by, and cause its agents, invitees, and guests to abide by, all rules and regulations relating to the Apartment now in effect and such as may be promulgated from time to time hereafter by Landlord or Landlord’s Agent as set forth in this Lease.</li>
		<li>Tenants shall not cause or permit the installation of any lock, deadbolt, or other locking device or mechanism that controls the entrance door to any individual bedroom (“Bedroom Door”) within the Apartment. Tenants may use previously installed locking doorknob to lock an individual Bedroom Door from the inside while such person(s) is/are in the bedroom. Tenants shall not change or replace any such locking doorknob. </li>
		<li>If the Apartment has multiple Bedrooms, Landlord has and will have no involvement in the assigning of bedrooms within the Apartment to the Tenants except that the Allocable Portion of the Monthly Rent may change in the event Tenants select different bedrooms. Tenants are Tenants of the entire Apartment.</li>
		<li>By agreeing to and signing this lease, you acknowledge that Burlington, Vermont, municipal law governs the occupancy of unrelated individuals inhabiting the same dwelling. As such, you agree to become part of the "related individuals" defined by said law, within the context of this lease agreement. By meeting these requirements, you affirm your status as a related individual as defined by Burlington, Vermont municipal law:
			<ul>
				<li>Acknowledge that this is your primary dwelling and you do not reside at any other address.</li>
				<li>Agree to pay your portion of the utilities as outlined in the lease agreement.</li>
				<li>Acknowledge that you have access to all areas of the apartment, including all bedrooms, regardless of the agreed-upon allocable bedroom.</li>
				<li>Confirm that this is your sole mailing address.</li>
				<li>Understand that you are jointly liable for the entirety of the rent, along with the other tenants named in this lease.</li>
			</ul>
		</li>
	</ul>

	<h2>ARTICLE 4 <br> RENT</h2>
	<ul>
		<li>Tenants shall pay Landlord the Monthly Rent, in advance, on the first day of each month that this Lease is in effect, provided that with respect to any partial calendar month at the beginning or end of a Term, such fee shall be prorated for the number of days during such period. Tenants must pay the first full month’s rent due to Landlord when Tenants sign this Lease and must pay for any prorated amount of Monthly Rent for any partial calendar month when demanded by Landlord. In the event that Monthly Rent is not received by the sixth (6th) day of the month when due, Tenants shall pay to Landlord as Additional Rent a Late Charge in the amount of $50 for each delinquent payment for the purpose of defraying the expenses incurred in handling delinquent payments. </li>

		<li>Tenants agree and affirm that Landlord or Landlord Agent is authorized to automatically charge a designated credit card or debit a designated bank account or to process payment with any other applicable third-party payment processor, for Monthly Rent (“Recurring Payment”). Tenants further agree to notify Landlord promptly of any changes to Tenants’ credit card or debit card account, including but not limited to changes to Tenants’ credit card or debit card account number, expiration date, and/or billing address. Tenants further agree to promptly notify Landlord if Tenants’ credit card or debit card expires or is canceled for any other reason. Tenants represent and warrant that he or she is an authorized user of the credit card, debit card, or third-party payment processor platform account used to pay Monthly Rent. Tenants acknowledge and agree to provide Landlord with a name, billing address, and other information necessary to allow Landlord to complete Recurring Payments made using a credit card, a debit card, or a third-party payment platform, or as required by other applicable law. In the event of a declined payment, Landlord reserves the right to demand that replacement payment and/or future payments be made by certified check, bank check, or money order. In the event that Monthly Rent is returned for “insufficient funds” or for any other reason, Tenants shall pay, as Additional Rent, the greater of $50.00 and/or the actual fees, penalties, and/or expenses incurred by Landlord directly or indirectly caused by each such dishonored payment, as well as any applicable late fees or interest.</li>

		<li>With respect to any Tenants, Landlord or Landlord’s Agent shall not be entitled to increase the Monthly Rent during the Term of the Lease.</li>

		<li>All amounts are payable by Tenants pursuant to this Lease in excess of the amount of the Monthly Rent shall be deeded “Additional Rent”. Landlord shall have the same rights and remedies with respect to defaults in the payment of Additional Rent as Landlord has with respect to payment of the Monthly Rent. Additional Rent shall be due within ten days of notice of such by the Landlord to Tenants in accordance with the notice provisions of this Lease.</li>

		<li>Tenants agree that the payment of the Monthly Rent and any Additional Rent or any other charges under this Lease must be made timely and is an essential consideration in Landlord renting the Apartment to the Tenants. In addition to all other remedies available to Landlord, all sums of Monthly Rent or Additional Rent or any other charges, which are not paid within ten (10) business days of the date when due under this Lease, will bear interest from the original due date to the date of payment at a rate per annum which will be two (2) percentage points higher than the interest rate required to be paid on judgments for sums of money recovered in actions in the Supreme Court of the State of Vermont (by way of illustration only, presently 2% plus 9% equals 11%) but not more than the highest rate of interest which will at such time be permitted under the laws of the State of Vermont. This interest rate will be payable so long as the amount due is unpaid, even if the amount has been included in a court judgment.</li>
	</ul>

	<h2>ARTICLE 5 <br> ASSIGNMENT</h2>
	<ul>
		<li>No Tenant can assign this Lease without the Landlord’s advance written consent in each instance. The Landlord may refuse to consent to a lease assignment for any reason or no reason.</li>
		<li>
			<strong>TENANTS CONSENT TO THE ASSIGNMENT OF THIS LEASE BY ANY OTHER TENANT IN THE APARTMENT TO AN ASSIGNEE OF THE LANDLORD’S CHOOSING. TENANTS KNOWINGLY WAIVE ANY RIGHT TO KNOW THE IDENTITY OF SUCH ASSIGNEE IN ADVANCE OF THE ASSIGNMENT. TENANTS AGREE TO BE JOINTLY AND SEVERALLY LIABLE FOR ALL OBLIGATIONS OF THE LEASE WITH SUCH ASSIGNEE.</strong> Landlord and Tenants agree that:
			<ul>
				<li>Landlord covenants to find Tenants for this Lease and introduce them to each other;</li>
				<li>Tenants are not responsible for finding Tenants.</li>
			</ul>
		</li>
		<li>If Tenants or any Tenant moves out of the Apartment before the end of this Lease without the consent of Landlord, this Lease will not be ended. Tenants or Tenants will remain responsible for Monthly Rent as it becomes due until the end of this Lease. </li>
	</ul>

	<h2>ARTICLE 6 <br> SECURITY DEPOSIT</h2>
	<ul>
		<li>Tenants shall deposit with Landlord an amount equal to one (1) month’s Monthly Rent as a security deposit (the “Security”) in accordance with the provisions of this Section 6 for Tenants’ faithful performance of his or her obligations under this Lease.</li>
		<li>Tenants agree and affirm that Landlord is authorized to automatically debit a designated bank account, or to process payment with any other applicable third-party payment processor, for Security. Landlord will notify the Tenants of the name and address of the Bank in which the security is deposited.</li>
		<li>If any Tenants or any Tenant does not pay Monthly Rent on time, Landlord may, but is NOT required to, apply the Security to pay the Monthly Rent then due. If Tenants or a Tenant fails to timely perform any other term contained in this Lease or causes any damage to the Apartment or the Building or to any of Landlord or Landlord’s Agent’s property contained therein, Landlord may apply the Security for reimbursement of any sums Landlord may spend, or damages Landlord suffers because of Tenants’ failure. Landlord may keep all or part of the Security Deposit and any interest which has not yet been paid to the Tenants to pay the Landlord for any losses incurred, including for unpaid rent and damage to the Apartment beyond normal wear and tear and any item in the Inventory List. Notwithstanding the foregoing, if any Individual Tenant is moving out of the Apartment and, through Landlord's inspection, determines that there is damage to the Apartment or furnishings or items listed in the Inventory List caused by Tenants, Landlord may charge Security Deposit for the cost of such damage and require Tenants to replenish the Security Deposit to the full Security Deposit amount.</li>
		<li>If Landlord applies any Security or any portion thereof, then Tenants shall, immediately upon notice from Landlord, send to Landlord an amount equal to the sum so applied by Landlord, and that amount shall be due, when billed, as an Additional Rent hereunder. At all times, the amount of Security stated above shall be maintained by Landlord.</li>
		<li>If a Tenant fully performs all terms of this Lease, pays Monthly Rent on time, and timely vacates the Apartment and leaves same in good condition as required hereunder, then Landlord will return any Security being held to such Tenants as per this section.</li>
		<li>If Landlord sells or assigns the Lease (as defined in this Lease), Landlord may give the security to the buyer or assignee. In that event, Tenants will look only to the buyer or assignee for the return of the Security, and the Landlord will be deemed released. </li>
		<li>Landlord may put the Security in any place permitted by law. The Security will bear interest only if required by law. Landlord will give Tenants the interest when Landlord is required to return the Allocable Security to a Tenants. Any interest returned to Tenants will be less than the sum Landlord is allowed to keep for expenses. Landlord need not give a Tenant’s interest on the Allocable Security if such Tenants is in default. </li>
		<li>No Tenant shall use the Security to pay any portion of the Monthly Rent. </li>
	</ul>

	<h2>ARTICLE 7 <br> FURNITURE AND CONTENTS OF APARTMENT PROVIDED BY LANDLORD</h2>
	<p>The Apartment’s common areas are leased and furnished, containing items of household furniture, kitchen utensils, and other household items. Tenants agree to return all items provided at the start of the Term in as good condition as when received, with reasonable wear and tear excepted. Tenants will be responsible for all breakage or other damage to items provided, and such damages are deductible from the Security. Chipped, cracked, or burned dishes will be counted as breakage. The Apartment Unit will generally contain the furnishings, fixtures, and other property identified in the Inventory List (the "Inventory List"). The list can be changed at the Landlord’s discretion anytime.</p>

	<h2>ARTICLE 8 <br> FAILURE OF THE LANDLORD TO GIVE POSSESSION</h2>
	<p>A situation could arise which might prevent Landlord from letting a Tenant move into the Apartment on the beginning date set in this Lease or on a subsequent date agreed to for occupancy. If this happens, Landlord will not be responsible for Tenant’s damages or expenses, and this Lease will remain in full force and effect; provided, however, in such case, the Tenant’s commitments under this Lease shall begin when Landlord gives Tenant three (3) calendar days’ notice by Contact Email (as set forth above in this Lease) that Tenant is allowed to move in, and the ending date of the Initial Term will be changed, if necessary, to a new date. If Landlord does not give the Tenant notice that the move-in date is within thirty (30) calendar days after the Tenant’s expected move-in, Tenant may inform Landlord in writing that Tenant is canceling the Lease as to that Tenant and any money paid by the Tenant on account of this Lease will then be refunded promptly by Landlord. This Lease will remain in full force and effect for any other Tenants of the Apartment. </p>

	<h2>ARTICLE 9 <br>WARRANTY OF HABITABILITY AND ACCESS TO ALL PARTS OF THE APARTMENT</h2>
	<ul>
		<li>All the sections of this Lease are subject to the provisions of the Warranty of Habitability Law in the form it may have from time to time during this Lease.</li>

		<li>Landlord or Landlord’s Agent reserves the right to decorate or to make repairs, alterations, additions, or improvements, whether structural or otherwise, in and about the Building and the Apartment, or any part thereof, and for such purposes to temporarily close doors, entryways, public space, and corridors in the Building and to interrupt or temporarily suspend Building services and facilities, all without abatement of Monthly Rent or affecting any of Tenants’ obligations hereunder.</li>

		<li>Tenants will do nothing to interfere or make more difficult the Landlord’s efforts to provide Tenants and all other occupants of the Building with the required facilities and services. Any condition caused by a Tenant’s misconduct or the misconduct of anyone under a Tenant’s direction and/or control shall not be a breach by Landlord.</li>

		<li>During reasonable hours and with reasonable notice, except in emergencies and as required by law, Landlord or a Landlord’s agent may enter the Apartment to erect, use and maintain pipes and conduits in and through the walls and ceilings of the Apartment; to inspect all parts of the Apartment, to make any repairs or changes that Landlord or Landlord desires or decides are necessary and to show all parts of the Apartment to investors, partners, and prospective tenants. The Monthly Rent will not be reduced because of any of this work unless required by law. In the event that the Landlord performs any obligations required of Tenants to be performed hereunder, the amount paid by Landlord to perform such obligations shall be due and payable by Tenants to Landlord upon demand or charged as Additional Rent.</li>

		<li>In the event of an emergency that affects the safety of the occupants of the Building or which may cause damage to the Building, the Landlord or Landlord may enter the Apartment without prior notice to the Tenants. If at any time Tenants are not personally present to permit Landlord or Landlord’s representatives to enter the Apartment and entry is necessary or allowed by law, Landlord or Landlord’s representatives may nevertheless enter the Apartment. Landlord will not be responsible to the Tenants in such cases. </li>

		<li>Failure to provide access as per this section is a breach of a substantial obligation of this Lease. </li>

		<li>Landlord may retain a passkey to the Apartment. </li>

		<li>Nothing contained in this Lease shall be construed to impose any liability or obligations on Landlord or require Landlord to take any action or make any repairs to or maintain the Apartment or the Building.</li>
	</ul>

	<h2>ARTICLE 10 <br> KEY MANAGEMENT</h2>
	<ul>
		<li>At the end of this Lease, Tenants must return to Landlord all keys, codes, and entry devices either furnished or otherwise obtained. </li>

		<li>If Tenants lose or fails to return any keys which were furnished to them, Tenants shall pay to Landlord the cost of replacing such lost keys as Additional Rent in the amount of $50 (fifty dollars) per lost key. </li>

		<li>Landlord will only issue one key per Tenant. Landlord is not required to issue extra keys to a Tenant’s family members or guests.  </li>

		<li>Codes provided by Landlord for use by the Tenants to access the Apartment or Apartment are for the Tenants’ use only and may not be shared or otherwise distributed. </li>
	</ul>
	<h2>ARTICLE 11 <br> CONDITION OF APARTMENT AND SERVICES AND FACILITIES</h2>
	<ul>
		<li>Tenants have inspected the Apartment and accepted the Apartment in the condition it is in as of such inspection. Tenants acknowledge that the Apartment is free of defects. When Tenants entered into this Lease, they did not rely on anything said by the Landlord, its employees, or agents about the physical condition of the Apartment, the Building, or the land on which it is built. Tenants agree that Landlord has not promised to do any work in the Apartment unless what was said or promised is written in this Lease and signed by both Tenants and Landlord. </li>

		<li>Landlord will provide cold and hot water and heat as required by law, and elevator service if the Building has elevator equipment.</li>

		<li>Utilities and Services. The lessor shall assume the comprehensive management of utility accounts, encompassing electricity, gas (if applicable), water, and WiFi services. This includes the diligent oversight of labor dedicated to the maintenance of Wi-Fi systems, as well as the facilitation of electronic system access for tenants.</li>
		<li>Utility Billing Procedure. The lessor shall implement a direct billing system, wherein each tenant shall be invoiced promptly for their respective portion of utility expenses.</li>
		<li>The tenant does not need to arrange for utility service directly with the appropriate utility company or pay a separate charge for these utilities. Landlord does not provide any land-based telephone service, equipment, or system.</li>

		<li>To the extent, the Apartment is separately metered for utilities, including, but not limited to, water, gas, electricity, telephone, internet, and cable, Tenants shall be responsible for paying the applicable utility provider for all usage incurred during the Term or during any period that Tenants have possession of the Apartment. Landlord may, at its sole and absolute discretion, set up a utility account for the Apartment and pay for such usage or may include utility charges as Additional Rent. Tenants are not entitled to any reduction in the Monthly Rent because of a stoppage or reduction of any of the above services unless such reduction is required by law. No other utilities or services are to be furnished by Landlord or Landlord’s Agent or used by Tenants in the Apartment without the prior written consent of the Landlord or Landlord’s Agent and on the terms and conditions specified in such written consent. Tenants shall make no alterations or additions to the Apartment. </li>

		<li>Appliances supplied by Landlord in the Apartment are for the Tenants’ use. Such appliances will be maintained and repaired or replaced by Landlord, but if repairs or replacement are made necessary because of the Tenants’ or any Tenant’s negligence or misuse, the Tenants or Tenant will pay Landlord for the cost of such repair or replacement as Additional Rent. Tenants must not use a dishwasher, washing machine, dryer, freezer, heater, ventilator, air-cooling equipment, or other appliance unless installed by Landlord. The Apartment Unit will generally contain the furnishings, fixtures, and other property identified in the Inventory List (the "Inventory List").</li>

		<li>Tenants will not use more electricity than the wiring or feeders to the Building can safely carry. </li>

		<li>If Landlord permits the Tenants to use any storeroom, laundry room, bike rack, or any other facility (a “Facility”) located in or directly outside of the Building, the use of a Facility will be at the Tenants’ own risk, except for loss suffered by a Tenants due to Landlord’s gross negligence.</li>

		<li>Because of a strike, labor trouble, national emergency, repairs, or any other cause beyond Landlord’s reasonable control, Landlord may not be able to provide or may be delayed in providing any services or in making any repairs to the Apartment. In any of these events, any rights Tenants may have against Landlord are only those rights that are allowed by laws in effect when the reduction in service occurs.</li>

		<li>Certain services for additional fees may be offered by Landlord. Landlord may supply from time to time some paper products - like paper towels and toilet paper, cleaning supplies, like sponges, dish soap, hand soap, and trash bags. Landlord is not required to provide any services or level of staffing other than those which are expressly set forth in this Lease or are offered and accepted through the Lease and/or booking through the Manager’s portal. Any discontinuance or failure to perform such optional service shall not constitute a decrease in services under this Lease. It is further understood that if Landlord elects to provide any additional service which was not in effect as of the date of this Lease, such additional service shall not be deemed a service for which the Individual Tenant is paying rent, and if Landlord shall, during the term of this Lease, elect to withdraw such additional service from the Apartment Building, Landlord shall not be subject to any liability nor shall Individual Tenant be entitled to any compensation or diminution or abatement of rent nor such revocation or diminution be deemed a constructive or actual eviction.</li>

		<li>Individual Tenant acknowledges that Landlord makes no representation and assumes no responsibility whatsoever with respect to the functioning or operation of any of the human or mechanical security systems, if any, which Landlord does or may provide. Individual Tenant agrees that Landlord shall not be responsible or liable for any bodily harm or property loss or damage of any kind or nature which Individual Tenant or any Authorized Occupant and their guests and invitees may suffer or incur by reason of any claim that Lessor, its agents or employees has been negligent or any mechanical or electronic system in the Apartment Building has not functioned properly or that some other or additional security measure or system could have prevented the bodily harm or property loss or damage.</li>
	</ul>

	<h2>ARTICLE 12 <br> CARE OF THE APARTMENT AND THE BUILDING BY TENANTS</h2>
	<ul>
		<li>Tenants will take good care of the Apartment and will not permit or do any damage to it, ordinary wear and tear excepted. When damage occurs, Individual Tenant(s) will be billed directly for the repairs. Landlord shall have the authority to assess and assign charges for these damages as set forth in the Fee Catalogue accessed through the Nebo App, it is also attached to this Lease in the addendum.</li>

		<li>When a Tenant moves out on or before the ending date of this Lease, such Tenant will leave the Apartment in good order and in the same condition as it was when the Tenant first occupied it, except for ordinary wear and tear and damage caused by fire or other casualty. At such time, the Tenant must remove all of its (as opposed to the Landlord’s) movable property. If the Tenant’s property remains in the Apartment after the Lease ends, Landlord may either treat the Tenant as still in occupancy and charge Tenant for such use, or may consider that Tenant has given up the Apartment and any property remaining in the Apartment. In this event, Landlord may either discard the property or store it at the Tenant’s expense. Such Tenant agrees to pay Landlord for all costs and expenses incurred in removing such property. The provisions of this article will continue to be in effect after the end of this Lease. </li>

		<li>Tenants cannot build in, add to, change, or alter the Apartment in any way, including, but not limited to, wallpapering, painting, boring or drilling into walls, or installing any paneling, flooring, “built-in” decorations, partitions, or railings. Tenants may not change the plumbing, ventilating, air conditioning, electric or heating systems in the Apartment or the Building.</li>

		<li>If a lien is filed on the Apartment or Building for any reason relating to any Tenant’s fault, Tenant must immediately pay or bond the amount stated in the Lien. Landlord may pay or bond the lien if the Tenant fails to do so within ten (10) days after Tenant has notice about the Lien. Landlord’s costs in this regard shall be Additional Rent.</li>

		<li>Tenants cannot place in the Apartment water-filled furniture. </li>

		<li>Tenants shall not block or leave anything in or on fire escapes, sidewalks, entrances, driveways, elevators, stairways, or halls of the Building. Public access ways shall be used only for entering and leaving the Apartment and the Building. Only those elevators and passageways designated by Landlord can be used for deliveries. Baby carriages, bicycles, or other property of Tenants shall not be allowed to stand in the halls, passageways, public areas, or courts of the Building.</li>

		<li>The bathrooms, toilets and wash closets, and plumbing fixtures shall only be used for the purposes for which they were designed or built; Tenants shall not place in them any sweepings, rubbish bags, acids, or other substances. </li>

		<li>Tenants shall not hang or shake carpets, rugs, or other articles out of any window of the Building. Tenants shall not sweep or throw or permit to be swept or thrown any dirt, garbage, or other substances out of the windows or into any of the halls, elevators, or elevator shafts. </li>

		<li>Tenants shall not place any articles outside of the Apartment or outside of the Building except in safe containers and only at places chosen by Landlord.</li>

		<li>Tenants shall use laundry and drying apparatus, if any, in the manner and at the times that the property manager or other representative of the Landlord may direct. Tenants shall not dry or air clothes on the roof. </li>

		<li>Tenants shall comply with all applicable recycling laws. </li>

		<li>An aerial may not be erected on the roof or outside wall of the Building without the written consent of the Landlord. Awnings or other projections shall not be attached to the outside walls of the Building or to any balcony or terrace.</li>

		<li>Tenants are not allowed on the roof of the Building except to the extent expressly permitted by Landlord. </li>

		<li>Tenants can use the elevator, if there is one, to move furniture and possessions only on days and hours designated by Landlord. Landlord shall not be liable for any costs, expenses, or damages incurred by the Tenants in moving because of delays caused by the unavailability of the elevator. </li>

		<li>The Apartment may have a terrace or balcony. The terms of this Lease apply to the terrace or balcony as if part of the Apartment. Landlord may make special rules for the terrace and balcony. Landlord will notify the Tenants of such rules. Tenants must keep the terrace or balcony clean and free and in good repair. No cooking is allowed on the terrace or balcony. </li>

		<li>Tenants acknowledge that Tenants must take measures to prevent mold and mildew from growing in the Apartment. Tenants agree to remove visible moisture accumulating on the windows, walls, and other surfaces. Tenants agree not to cover or block any heating, ventilation, or air conditioning (HVAC) ducts in the Apartment. Tenants agree to immediately notify Landlord of (i) any water leaks or excessive moisture in the unit, (ii) any evidence of mold or mildew, (iii) any failure of any HVAC systems in the unit, and (iv) any inoperable doors or windows. Tenants agree that Tenants shall be responsible for any damage to the unit and Tenants’ property as well as personal injury to any Tenants and occupants resulting from Tenants’ failure to comply with this Lease provision. Any breach of this provision shall be considered a breach of a substantial obligation of this Lease.</li>
	</ul>

	<h2>ARTICLE 13 <br>DUTY TO OBEY AND COMPLY WITH LAWS AND TO REFRAIN FROM OBJECTIONABLE CONDUCT</h2>
	<ul>
		<li>Tenants will obey and comply with all present and future city, state, and federal laws and regulations which affect the Building or the Apartment; with all orders and regulations of Insurance Rating Organizations which affect the Apartment and the Building; and with the Rules and Regulations promulgated by Landlord and attached to this Lease.</li>

		<li>Tenants will not allow any windows in the Apartment to be cleaned from the outside.</li>

		<li>Each Tenant is responsible for the behavior of the Tenant and their family, guests, employees, visitors, and/or invitees. Tenant will reimburse Landlord as Additional Rent upon demand for the cost of all losses, damages, fines, and reasonable legal expenses incurred by Landlord because of violation of this section.</li>

		<li><p>The tenant will not engage in Objectionable Conduct. Objectionable Conduct means behavior that:</p>
			<ul>
				<li>Causes conditions that are dangerous, hazardous, unsanitary, and/or detrimental to other occupants of the Building or Tenants;</li>
				<li>causes noises, sights, or odors in the Apartment or Building that are disturbing to other occupants of the Building or Tenants; </li>
				<li>will interfere with the rights, comforts, or convenience of other occupants of the Building; </li>
				<li>makes or will make the Apartment or the Building less fit to live in for other occupants of the Building or Tenants;</li>
				<li>interferes with the right of other occupants of the Building or Tenants to properly and peacefully enjoy their Apartments.</li>
			</ul>
		</li>

		<li>Tenants shall not play a musical instrument or operate or allow to be operated speakers, radios, or television sets so as to disturb or annoy any other occupant of the Building.</li>

		<li>Any breach of the provisions of this Section 13 shall be considered a breach of a substantial obligation of this Lease. Landlord reserves the right, upon breach of this section of the Lease by any Tenant, to proceed legally against all Tenants or against any individual Tenant. Tenants will reimburse Landlord as Additional Rent for the cost of all losses, damages, fines, and reasonable legal expenses incurred by Landlord because of a violation of this section.</li>

		<li>Tenant acknowledges that the Landlord has not made any representations or promises with respect to noises or odors, however arising and whether occurring inside or outside the Apartment Building, and Tenant waives and releases any claim, cause of action or set off by reason of or arising out of any noise, inconvenience, aromas, scents, or odors, however arising, and whether occurring inside or outside the Apartment Building.</li>

		<li>Individual Tenant shall not rescind this Lease or be entitled to any compensation or diminution or abatement of rent, nor shall Tenant fail to honor any other obligations under this Lease by virtue of any of the above-mentioned items. Individual Tenant and his or her Authorized Occupants, guests, and invitees shall not permit any noxious odors or objectionable odors to emanate from Individual Tenant's Apartment Unit or any area of the Apartment Building. Further Tenant and his or her Authorized Occupants, guests, and invitees shall not use, generate, store, or dispose of any type of hazardous or toxic materials or substances at, from, or in the Apartment Unit or any area of the Apartment Building.</li>
	</ul>

	<h2>ARTICLE 14 <br> NO PETS</h2>
	<p>Animals of any kind shall not be kept or harbored in the Apartment unless, in each instance, it is expressly permitted in writing by Landlord. Unless carried or on a leash, a dog shall not be permitted on any passenger elevator or in any public portion of the Building.</p>

	<p>Unless there is a Pet Rider to the Lease, You are representing to Landlord that You do not have any pets and You have no intention of acquiring a pet. If You do acquire or intend to acquire a pet, You must obtain prior written approval from the Landlord (which, except as may be required by a non-waivable provision of law, may be withheld for any or no reason). You must request such approval in writing. Your notice to Landlord must include the name, type, breed, color, weight (which may not exceed 30 pounds, fully grown), size and age of Your pet, two photographs (one front and one side) of Your pet, and a statement that You have no other pets, or if You do have other pet(s) describing those other pets. If Landlord consents to Your having a pet, such consent will be SUBJECT TO YOUR COMPLIANCE WITH ALL BUILDING RULES AND ALL LAWS, RULES, AND REGULATIONS. Any violation of this Article will give Landlord the right to end the Lease.</p>

	<h2>ARTICLE 15 <br>END OF TERM</h2>
	<p>termination of the Term, such failure will not be deemed to extend the Term, and Tenants will pay to Landlord or Landlord’s Agent promptly upon demand therefor as and for liquidated damages, for each day or portion thereof during which Tenants retain possession of the Apartment after such expiration or earlier termination, an amount equal to 150% of the pro rata Allocable Portion of the Monthly Rent payable by Tenants during the Term (in addition to all other amounts set forth herein). The provisions of this Section 15 will not be deemed to limit or constitute a waiver of any other rights or remedies provided herein or at law or in equity, and Landlord or Landlord’s Agent may, without notice, reenter the Apartment either by force or otherwise, and dispossess Tenants by summary proceedings or otherwise. Tenants will additionally indemnify and hold Landlord or Landlord’s Agent harmless from and against all loss, liability, costs, and expenses of any kind or nature (including, without limitation, attorneys’ fees and disbursements) resulting from or arising out of Tenants’ failure to comply with the provisions of this Section 15. Nothing herein contained will be deemed to permit Tenants to retain possession of the Apartment after the expiration or earlier termination of the Term. The provisions of this Section 15 will survive the expiration or earlier termination of the Term.</p>
	<p>If Tenants shall fail or refuse to remove any stored property upon termination of the Lease, Landlord or Landlord’s Agent may treat such failure as conclusive evidence that Tenants has abandoned the property and Landlord or Landlord’s Agent (or Owner if in possession of the Building) may enter the Apartment and dispose of all or any part of such property in any manner that Landlord or Landlord’s Agent (or Owner if in possession of the Building) shall choose. If Landlord or Landlord’s Agent’s employees are required to remove or handle the property or perform any services for the Tenants, a charge for the same at Landlord or Landlord’s Agent’s standard rates on a time and material basis will be payable by the Tenants. Tenants shall pay all costs the Landlord incurs in connection with the removal of any Tenants’ property under this paragraph.</p>

	<h2>ARTICLE 16 <br> TENANT DEFAULT </h2>
	<ul>
		<li>As to a non-rent default by Tenants or any Tenant:</li>

		<li><p>Any Tenant defaults under the Lease if he or she fails to carry out any agreement or provision of this Lease. </p>
			<ul>
				<li>If a Tenant defaults, other than a default in the agreement to pay rent, the Landlord may serve the Tenant with a written notice to stop or correct the specified default within five (5) days. In such an event, the Tenant must then stop or correct the default within five days. </li>

				<li>If Tenant does not stop or correct a default for which Tenant has been noticed within five days, Landlord may give Tenant a second written notice that this Lease, with respect to that Tenant, will end Five (5) days after the date of such notice. At the end of the 5-day period, this Lease, with respect to that Tenant, will end, and Tenant then must move out of the Apartment. </li>

				<li>In the event of a non-rent default by a Tenant and a subsequent termination of the Lease pursuant to this section, then this Lease will nevertheless remain in full force and effect for Landlord and the remaining Tenants.</li>
			</ul>
		</li>
		<li><p>If (i) Tenants or any Tenant does not pay the Monthly Rent or any Additional Rent due pursuant to this Lease when this Lease requires such, within three days after a statutory written demand for rent has been made or (ii) the Lease is terminated as described in the Non-Rent default section, then Landlord may do the following:</p>
			<ul>
				<li>enter the Apartment and retake possession of it if the Tenants have moved out; or </li>
				<li>go to court and ask that the defaulting Tenants or Tenant be compelled to move out.</li>
			</ul>
		</li>
		<li>For the avoidance of doubt, the parties specifically agree that Landlord may proceed to do a summary nonpayment proceeding or holdover proceeding against only one Tenant or against all Tenants in Landlord’s discretion. The Tenants hereby acknowledge that all Tenants are not necessary parties to any legal proceeding by Landlord against any single Tenant. If Landlord proceeds to do a summary proceeding or holdover proceeding against only one Tenant, this Lease will nevertheless remain in full force and effect for Landlord and the remaining Tenants. </li>
		<li>Tenants or any individual Tenant shall pay and discharge all reasonable costs, attorney’s fees, and expenses that may be incurred by Landlord or Landlord’s Agent in enforcing or attempting to enforce the covenants and provisions of this Lease. All rights and remedies under this Lease shall be cumulative, and none shall exclude any other rights and remedies allowed by law.</li>
	</ul>

	<h2>ARTICLE 17 <br> REMEDIES OF LANDLORD AND TENANTS LIABILITY</h2>
	<p>If this Lease is ended by Landlord with respect to the Tenants or any individual Tenant because of the Tenants’ or any Tenant’s default, the following are the rights and obligations of the Tenants and the Landlord.</p>

	<ul>
		<li>Tenant must pay the Monthly Rent until the end of the Term. Thereafter, Tenant must pay an equal amount for "use and occupancy" until Tenant actually moves out. </li>

		<li>Once Tenant is out, Landlord may re-Lease the Apartment or assign the Lease or any portion of it for a period of time, which may end before or after the ending date of this Lease. Landlord may re-Lease or assign this lease to a new tenant at a lesser rate or may charge a higher rate than the Monthly Rent in this Lease.</li>

		<li>Whether Landlord re-leases the Apartment or assigns the Lease or any portion of it, the Tenant must pay Landlord as damages the difference between fees (whether Monthly Rent or otherwise) collected and what would have been the remaining term of this Lease.</li>

		<li>Any legal action brought to collect one or more monthly installments of damages shall not prejudice in any way Landlord’s right to collect the damages for a later month by a similar action.</li>

		<li>If a Tenant does not do everything they have agreed to do, or if a Tenant does anything which shows that Tenant intends not to do what he or she has agreed to do, Landlord has the right to ask a Court to make such Tenants or Tenant carry out his or her agreements in this Lease or to give the Landlord such other relief as the Court can provide.</li>

		<li>If Tenants or Tenant fail to timely correct a default after notice from Landlord, Landlord may correct it at Tenants’ or Tenant’s expense. Landlord’s costs to correct the default shall be added to Monthly Rent.</li>
	</ul>

	<h2>ARTICLE 18 <br>FEES AND EXPENSES</h2>
	<ul>
		<li><p>A Tenant must reimburse Landlord for any of the following fees and expenses incurred by Landlord:</p>
			<ul>
				<li>Making any repairs to the Apartment or the Building or furniture, appliances or personality which result from misuse or negligence by any Tenant and/or his or her family, guests, employees, visitors, and/or invitees; </li>

				<li>Repairing or replacing property damaged by or caused by the misuse or negligence of Tenant and/or his or her family, guests, employees, visitors, and/or invitees; </li>

				<li>Repairing or replacing any appliance and/or any items identified on the Inventory List which are damaged by Tenants’ misuse or negligence, including damage through misuse or negligence of the rooftop and common areas and facilities of the Apartment Building;</li>

				<li>Correcting any violations of city, state, or federal laws or orders and regulations of insurance rating organizations concerning the Apartment or the Building caused by the Tenant and/or his or her family, guests, employees, visitors, and/or invitees;</li>

				<li>In the event Tenant does not clean the apartment to be in move-in ready condition, Tenant shall pay a $250 (two hundred fifty dollar) cleaning fee, which shall be included in the final payment for Monthly Rent by Tenant or, upon the consent of Tenant, by deducting $250 (two hundred fifty dollars) from the Security Deposit.</li>

				<li>Any legal fees and disbursements for legal actions or proceedings brought by the Landlord against any Tenant because of a default by any Tenant and/or for defending lawsuits brought against the Landlord because of the actions of any Tenant and/or his or her family, guests, employees, visitors, and/or invitees;</li>

				<li>Removing any Tenant’s property after Tenants moves out; and</li>

				<li>All other fees and expenses incurred by Landlord because of a Tenant’s failure to obey any other provisions and agreements of this Lease.</li>
			</ul>
		</li>

		<li>Tenants shall pay these fees and expenses to Landlord as Additional Rent within ten (10) days after Tenant receives Landlord’s bill or statement. If this Lease has ended when these fees and expenses are incurred, Tenants will still be liable to Landlord for the same amount as damages. </li>
	</ul>

	<h2>ARTICLE 19 <br>MODIFICATION</h2>
	<p>THIS LEASE MAY BE MODIFIED BY THE LANDLORD TO ADD TENANTS WITHOUT NOTICE. ALL OTHER MODIFICATIONS SHALL REQUIRE NOTICE AND CONSENT OF TENANTS. TENANTS SHALL NOT MODIFY THIS LEASE. </p>

	<h2>ARTICLE 20 <br>BILLS AND NOTICES</h2>
	<ul>
		<li>Tenants agree to notice by Landlord via email to the email address provided by Tenants or by Landlord or Landlord’s Agent posting a notice on the Site. Tenants agree that all agreements, notices, disclosures, and other communications that Landlord or Landlord’s Agent provides electronically shall satisfy any legal requirement that such communications be in writing. </li>

		<li>Any notice by Tenants to Landlord or Landlord’s Agent shall be given by email to Landlord or such other or additional email or other address provided by Landlord or Landlord’s Agent from time to time or otherwise posted on the Site.</li>
	</ul>

	<h2>ARTICLE 21 <br>PROPERTY LOSS, DAMAGES, OR INCONVENIENCE</h2>
	<ul>
		<li><p>Unless caused by the negligence or misconduct of the Landlord or Landlord’s agents or employees, the Landlord or Landlord’s agents and employees are not responsible to Tenants for any of the following:</p>
			<ul>
				<li>any loss of or damage to Tenants or their property in the Apartment or the Building due to any accidental or intentional cause, even theft or another crime committed in the Apartment or elsewhere in the Building;  </li>
				<li>any loss of or damage to Tenants’ property delivered to any employee of the Building (doorman, superintendent, property manager, etc.); or</li>
				<li>Any damage or inconvenience caused to Tenants by actions, negligence, or violations of a Lease by any other Tenants or person in the Building except to the extent required by law. </li>
			</ul>
		</li>

		<li>Landlord will not be liable for any temporary interference with light, ventilation, or view caused by construction by or on behalf of the Landlord. Landlord will not be liable for any such interference on a permanent basis caused by construction on any parcel of land not owned by the Landlord. Also, Landlord will not be liable to the Tenants for such interference caused by the permanent closing, darkening or blocking up of windows if such action is required by law. None of the foregoing events will cause a suspension or reduction of the Monthly Rent or allow Tenants to cancel this Lease. </li>

		<li>Landlord is not liable to the Tenants for permitting or refusing entry of anyone in the Building. </li>

		<li>Except for the willful acts or negligence of Landlord or Landlord’s Agent, and except to the extent otherwise explicitly provided in this Lease, Tenants hereby assumes all risk of loss and waives any claims it may have against Landlord or Landlord’s Agent, owner’s of the Building, and their respective directors, officers, members, shareholders, partners, trustees, managers, principals, agents, beneficiaries, employees and insurers (collectively, the “Protected Parties”) for any injury to or illness of person or loss or damage to property or business, of any person or entity by whomever or howsoever caused. Tenants shall protect, defend, indemnify, and hold the Protected Parties harmless from and against any and all liabilities, claims, demands, costs, and actions of whatever nature (including reasonable attorney’s fees) for any injury to or illness of a person, or damage to or loss of property or business, in or about the Building caused or occasioned by Tenants, its invitees, servants, agents or employees, or arising out of Tenants’ use of the Apartment or arising out of Tenants’ breach of this Lease. The provisions of this paragraph shall survive any expiration or termination of this Lease.</li>

		<li>ALL PROPERTY STORED WITHIN THE APARTMENT OR THE BUILDING BY TENANTS SHALL BE AT THE TENANTS’ SOLE RISK. IT IS THE TENANTS’ DUTY TO PROVIDE INSURANCE COVERAGE ON TENANTS’ PROPERTY FOR LOSS CAUSED BY FIRE OR OTHER CASUALTY, INCLUDING, WITHOUT LIMITATION, VANDALISM AND MALICIOUS MISCHIEF, PERILS COVERED BY EXTENDED COVERAGE, THEFT, WATER DAMAGE (HOWEVER CAUSED), EXPLOSION, SPRINKLER LEAKAGE AND OTHER SIMILAR RISKS. THE APARTMENT IS PROVIDED FOR TENANTS’ SELF-SERVICE, AND IN NO EVENT SHALL THE LANDLORD OR LANDLORD’S AGENT BECOME A BAILEE (EITHER VOLUNTARY OR OTHERWISE) OR ACCEPT OR BE CHARGED WITH THE DUTIES THEREOF, OF TENANTS’ PROPERTY.</li>
	</ul>

	<h2>ARTICLE 22 <br> FIRE, CASUALTY AND CONDEMNATION</h2>
	<ul>
		<li>If the Apartment becomes unusable, in part or totally, because of fire, accident, or other casualty, this Lease will continue unless terminated by Landlord or any Tenants pursuant to this Lease. However, the Monthly Rent will be reduced immediately. This reduction will be based on the part of the Apartment that is unusable.</li>

		<li>Landlord will repair and restore the Apartment unless Landlord decides to take the actions described in paragraph C below.</li>

		<li>If the Apartment is completely unusable because of fire, accident or other casualty and it is not repaired in thirty (30) days, any Tenants may give Landlord written notice that he or she terminates this Lease. If a Tenant gives such notice, this Lease shall terminate with respect to that Tenant on the day that the fire, accident or casualty occurred. Landlord will refund the Tenants’ security deposit, and the pro-rata portion of the Monthly Rent paid for the month in which the casualty happened.</li>

		<li>If Landlord elects to terminate the Lease pursuant to any of the provisions thereof on account of a fire or other casualty or on account of condemnation, then this Lease shall automatically terminate and expire upon the termination of the Lease. If Landlord or Landlord’s Agent has the right to terminate the Lease pursuant to any of the provisions thereof on account of a fire or other casualty or on account of condemnation, then (i) Landlord or Landlord’s Agent may exercise such right or not in Landlord or Landlord’s Agent’s sole discretion and (ii) if Landlord or Landlord’s Agent so elects to terminate the Lease, this Lease and the Lease granted herein shall automatically terminate and expire upon the termination of the Lease. </li>
	</ul>

	<h2>ARTICLE 23 <br>SUBORDINATION CERTIFICATE AND ACKNOWLEDGMENTS</h2>
	<ul>
		<li>All leases and mortgages of the Building or of the land on which the Building is located, now in effect or made after this Lease is signed, come ahead of this Lease. In other words, this Lease is "subject and subordinate to" any existing or future lease or mortgage on the Building or land, including any renewals, consolidations, modifications, and replacements of these leases or mortgages. If certain provisions of any of these leases or mortgages come into effect, the holder of such lease or mortgage can end this Lease. If this happens, Tenants agree that Tenants have no claim against Landlord or such lease or mortgage holder. If Landlord requests, Tenants will promptly sign an acknowledgment of the "subordination" in the form that Landlord requires.</li>

		<li>Tenants also agree to sign (if accurate) a written acknowledgment to any third party designated by Landlord that this Lease is in effect, that Landlord is performing Landlord's obligations under this Lease, and that Tenants has no present claim against Landlord.</li>
	</ul>

	<h2>ARTICLE 24 <br>WAIVER OF RIGHT TO TRIAL BY JURY AND COUNTERCLAIM</h2>
	<ul>
		<li>Both Tenants and Landlord agree to waive the right to a trial by jury in a court action, proceeding or counterclaim on any matters concerning this Lease, the relationship of Tenants and Landlord or Tenants’ use or occupancy of the Apartment.</li>
		<li>If Landlord begins any court action or proceeding against a Tenant that asks that the Tenant be compelled to move out, Tenant cannot make a counterclaim unless the Tenant is claiming that Landlord has not done what Landlord is required to do with regard to the condition of the Apartment or the Building. </li>
	</ul>

	<h2>ARTICLE 25 <br>NO WAIVER OF LEASE PROVISIONS</h2>
	<ul>
		<li>Even if Landlord accepts a Tenant’ Monthly Rent or fails once or more often to take action against a Tenant when the Tenant has not done what the Tenant has agreed to do in this Lease, the failure of the Landlord to take action or the Landlord’s acceptance of Monthly Rents does not prevent Landlord from taking action at a later date.</li>
		<li>Only a written agreement between a Tenants and Landlord can waive any violation of this Lease. No exchange of electronic correspondence between the parties shall operate to amend, modify, or waive any term or provision of this Lease or constitute a waiver of or estoppel against the Landlord’s right to insist upon the Tenants’ full and timely performance of all the terms and/or conditions of this Lease. An email exchange between the parties or their counsel will NOT be deemed “a writing” for purposes of this Lease.  </li>
		<li>If a Tenants pay and Landlord accepts an amount less than all the Monthly Rent, the amount received shall be considered to be in payment of all or a part of the earliest Monthly Rent due. It will not be considered an agreement by Landlord to accept this lesser amount in full satisfaction of all of the Monthly Rent due. </li>
		<li>No waiver of any condition in this Lease shall be implied by any neglect of Landlord or Landlord’s Agent to enforce any remedy on account of the violation of any such condition and no receipt of money by Landlord or Landlord’s Agent after the termination in any way of the Term hereunder or after the giving of any notice shall reinstate, continue or extend the Term hereof or affect any notice given to Tenants.  </li>
	</ul>

	<h2>ARTICLE 26 <br>SUCCESSOR INTERESTS</h2>
	<p>The agreements in this Lease shall be binding on Landlord and Tenants and on those who succeed to the interest of Landlord and/or the Tenants by law, by approved assignment or by transfer. None of the provisions of this Lease, however, are intended to be nor shall any of such provisions be construed to be for the benefit of any third party except for an Assignor who assumes the lease with Landlord’s consent.</p>

	<h2>ARTICLE 27 <br> CAPTIONS</h2>
	<p>In any dispute arising under this Lease, in the event of a conflict between the text and a caption, the text controls.</p>

	<h2>ARTICLE 28 <br> INABILITY AND INDEMNITY</h2>
	<p>This Lease is made upon the express condition that, except to the extent caused by the negligence of Lessor's employees or agents, the Lessor shall be free from all liabilities and claims for damages and/or suits for or by reason of any injury or injuries to any person or persons or property of any kind whatsoever, whether the person or property of Individual Tenant, his or her Authorized Occupants, guests or invitees, from any cause whatsoever while in or upon the subject premises or any part thereof during the Terms or occasioned by any occupancy or use of said premises or any activity carried on by Individual Tenant, his or her Authorized Occupants, guest or invitees, in connection therewith and Individual Tenant hereby agrees to indemnify and hold the Lessor harmless from any liabilities, damages, loss, causes of action, charges, expenses (including counsel fees) and costs on account of or by reason of any such injuries, liabilities, claims, suits or losses however occurring or damages growing out of same.</p>

	<h2>ARTICLE 29 <br> INSURANCE</h2>
	<p>Lessor shall not be liable for damage or loss of Individual Tenant's personal property (i.e., furniture, jewelry, clothing, etc.) or those of Individual Tenant's Authorized Occupants, guests and invitees, from the occurrences set forth in this Lease or other causes whatsoever unless due to the Lessor, its managing agent or employee's negligence. Individual Tenant agrees to obtain and retain, at Individual Tenant's sole cost and expense, for the term of this Lease and any extensions or renewal's thereof, "Renter's" liability insurance with a minimum coverage of USD 100,000.00 per occurrence for bodily or personal injury and list Lessor as an additional insured under such policy. Individual Tenant's failure to obtain and maintain such insurance shall constitute an event of default under the Lease availing the Lessor of its rights and remedies provided in this Lease. It is recommended that Individual Tenant, at Individual Tenant's sole cost and expense, obtain and retain minimum contents insurance of USD 50,000.00 per occurrence for property damage and loss. Individual Tenant shall pay for damages suffered by and reasonable expenses of Sub Lessor relating to any claim arising from any act or negligence committed by Tenant. As a condition of this Lease, Individual Tenant must supply proof of insurance required hereunder prior to the Commencement Date and prior to any renewal hereof; additionally Tenant shall supply proof of such insurance to the Lessor at any time during the Term of this Lease within thirty (30) days following request by Lessor.</p>

	<h2>ARTICLE 30 <br> LIABILITY</h2>
	<p>Except to the extent caused by the negligence of Lessor's employees or agents, Lessor shall not be liable for damage occasioned by or from plumbing, gas, water, sprinklers, steam or other pipes or sewage or the bursting, leaking or running of any pipes, tanks or plumbing fixtures, in, above, upon or about the Apartment Unit or Apartment Building, nor for any damage occasioned by water, snow or ice being upon or coming through the roof, windows or otherwise, nor for and damage arising from the acts, or neglect of other Individual Tenants, their Authorized Occupants, guest and invitees or other occupants of the Apartment Unit or the Apartment Building or of any, owners or occupants of adjacent or contiguous apartments.</p>
	<p>Except to the extent caused by the negligence of Lessor's employees or agents, Lessor shall not be liable for damage or loss of Individual Tenant's or his or her Authorized Occupants', guests' or invitees' personal property (furniture, jewelry, clothing, etc.) from theft, water, fire, vandalism, rains, storms, smoke, exposures, sonic booms or other causes whatsoever.</p>
	<p>Except to the extent caused by the negligence of Lessor's employees or agents, each Individual Tenant, and their Authorized Occupants, guests and invitees assumes all risk of personal injury to themselves and to others, in their use and occupancy of the Apartment Unit and any other portions of the Apartment Building.</p>
	<p>You must pay for damages suffered by and reasonable expenses of Lessor relating to any claim or arising from any act or neglect committed by you, your Authorized Occupants, guests and invitees. In such event all Individual Tenants shall be held individually liable for any damages. If an action is brought against Lessor arising from your act or neglect, or the act or neglect of your Authorized Occupant, guest or invitee, you shall defend Lessor at your expense with an attorney of Lessor's choice.</p>

	<h2>ARTICLE 31 <br> CORRECTING YOUR DEFAULT</h2>
	<p>If Lessor is compelled to pay any expense, including reasonable attorney's fees in instituting, prosecuting or defending any action or proceeding instituted by reason of you, or your Authorized Occupant, guest or invitee, breaching or defaulting under the terms of this Lease, the money paid by Lessor with all interest, costs and damages shall be deemed to be additional rent hereunder and shall be due from you to Lessor on the first day of the month following the payment of such expenses.</p>

	<h2>ARTICLE 32 <br>SECOND HAND SMOKE</h2>
	<p>Tenants acknowledges that scientific studies have shown that second hand smoke, smoke created by the burning of tobacco or other substance by one individual which is present in the environment and which may be inhaled by other individuals, poses a significant health risk. Smoking or using electronic cigarettes is not allowed inside of residential units, outside of areas that are part of residential units (such as balconies, patios, porches), outdoor common areas, or outdoors within 15 feet of entrances, exits, windows, and air intake units on property grounds. The failure to comply with any condition described in this paragraph shall constitute a violation of a substantial obligation of tenancy. Nothing in this provision shall make Landlord or its agents and employees the guarantor of Tenants’ health or of the smoke-free condition of any Apartment or common area of the Building. Landlord is not required to take any steps in response to smoking unless Landlord has been given written notice of said smoking. </p>

	<h2>ARTICLE 33 <br> ENTIRE AGREEMENT AND CROSS DEFAULT</h2>
	<p>Tenants have read this Lease. All promises made by Landlord regarding occupancy (but not membership if required) are in this Lease. A default under this Lease by a Tenants shall be a default under the corresponding Membership Lease between Landlord and Tenants.</p>

	<h2>ARTICLE 34 <br>RULES AND REGULATIONS</h2>
	<p>Tenant agrees, for itself, its agents, invitees and guests, to observe and comply at all times with the rules and regulations set forth herein and with such modifications thereof and additions thereto as Landlord or Landlord’s Agent may from time to time make for the Building, and that failure to observe and comply with such rules, regulations, modifications and additions shall constitute a default under the Lease. Any failure by Landlord or Landlord’s Agent to enforce any rules and regulations now or hereafter in effect, either against Tenant or any other occupant or Tenant in the Building, shall not constitute a waiver of Landlord or Landlord’s Agent’s right to enforce any such rules and regulations at a future time. Rules are as follows:</p>
	<ul>
		<li>Tenant is permitted an overnight guest up to 8 nights per month (2 nights/week). Guests must be at least 18 years of age; exceptions will be granted on a case-by-case basis. </li>

		<li>Overnight guests are only permitted to sleep in Tenant’ bedrooms. Sleeping is not permitted in other parts of the Apartment or Building. </li>

		<li>Tenant will not use, permit or store in the Apartment anything that will invalidate any policy of insurance now or hereafter carried on the Building or that will increase the rate of insurance on the Building. </li>

		<li>Tenant will not: (a) store, use or permit anything in the Apartment that may be dangerous to life or limb; (b) in any manner deface or injure the Building or any part thereof; (c) overload the floors of the Apartment; (d) conduct any business in or from the Apartment; or (e) do anything or permit anything to be done in or upon the Apartment tending in any way to create a nuisance or tending to disturb any Tenant in the Building, or the occupants thereof. Tenant, at its sole cost, will fully and promptly comply with all government, health and police requirements, codes and regulations respecting the Apartment and the goods stored therein. </li>

		<li>Tenant shall not bring upon, use or keep in the Apartment any hazardous or toxic materials, narcotics, explosives or flammable items, pets, animals, items that may leak, spill or freeze, or any illegal or stolen substance or property except as otherwise set forth herein. </li>

		<li>Tenant shall not paint, display, affix, or inscribe any sign, color, advertisement or picture on the outside of the Building. </li>

		<li>Tenant, and its agents and employees, shall not encumber or obstruct sidewalks, halls, passageways, exits, entrances, elevators, stairways or other Landlord areas in or about the Building. Any discarded items, litter and debris must be deposited in rubbish areas and in the manner designated by Landlord or Landlord’s Agent. Tenant shall not cause any unnecessary janitorial labor or services by reason of Tenant’ litter, carelessness or indifference in the preservation of good order and cleanliness. </li>

		<li>Smoking, candles, incense, refrigerators, space heaters and air conditioning units are prohibited throughout the Building. Smoking is permitted outside the Building provided it is at least fifteen (15) feet from any entryway. </li>

		<li>Hotplates, rice cookers, or other electrical kitchen appliances are prohibited in bedrooms. </li>

		<li>Tenant shall not do anything that would jeopardize the security of other members/Tenant or the community. Tenant shall keep the building locked at all times, and make sure its belongings are secure. </li>

		<li>Bicycles must be kept in bike storage area and kept out of hallways, stairwells and Landlord areas of the Apartments and Building. Bikes found in these areas will be removed. </li>

		<li>Tenant shall let other Tenant get a full night’s rest. Tenant shall limit music that can be heard outside of his or her bedroom to before 10PM and after 8AM, and take the party elsewhere between those hours if someone is trying to sleep.</li>

		<li>Damages caused by a Tenant (or her/his guest) will be Tenant’ responsibility. Any costs resulting from damages will be billed to Tenant involved. All Tenant in an Apartment share the  responsibility for damage of as kitchens, bathrooms, and living rooms.</li>

		<li>Tenant and their guests may possess or consume alcoholic beverages as long as each person possessing/consuming alcohol is twenty-one (21) years of age or older and the consumption/service of alcohol is in compliance with Vermont State Law.</li>

		<li>Tenant shall not engage in disorderly, disruptive, or aggressive behavior that impairs or interferes with the general comfort, safety, security, health, or welfare of the Apartment, Building, or community.</li>

		<li>Upon the termination of the Term, Tenant shall deliver to Landlord or Landlord’s Agent all keys for the Apartment. Tenant shall not install any locks or make, or cause to be made, any  additional keys for the Apartment.</li>

		<li>Tenant shall transport large personal items within the Building only upon or by vehicles equipped with rubber tires and shall cause such items to be carried in a freight elevator at such time that the Landlord or Landlord’s Agent shall fix. Movements of Tenant’ property into or out of the Building and within the Building are entirely at the risk and responsibility of Tenant, and Landlord or Landlord’s Agent reserves the right to require permits before allowing any such property to be moved into or out of the Building. Tenant shall fully cooperate with Landlord or Landlord’s Agent’s security measures.</li>

		<li>Notwithstanding anything contained therein, the Landlord or Landlord’s Agent shall provide Tenant reasonable access to the Apartment.</li>

		<li>Landlord or Landlord’s Agent reserves the right to make such other and further rules and regulations as in Landlord or Landlord’s Agent’s judgment may from time to time be needful for the safety, care and cleanliness of the Apartment and the prudent operation of the Building.</li>

		<li>Each Tenant will respect the privacy of other Tenant. </li>

		<li>Neither a Tenant nor its guests may use the Building or Apartment to conduct or pursue any activities prohibited by law or for which a Tenant or its guests are not authorized. Tenant shall be strictly liable for the activities of their guests. </li>

		<li>Each Tenant hereby agrees not to conduct any activity that is generally regarded as  offensive to other people, whether written, oral or in any form or medium known or to be created. No harassment, sexual or otherwise, will be permitted in the Building and Apartments. Any such harassment will be immediately reported to Landlord. If Landlord determines in its sole discretion that a complaint is justified, the offending party’s Lease may be terminated.</li>

		<li>Each Tenant hereby agrees not to conduct any activity that may be hazardous to other persons in the Building or Apartment. </li>

		<li>Each Tenant hereby agrees to refrain from any activities that may be unreasonably disruptive, including, but not limited to, acts of disorderly nature or excessive noise.</li>

		<li>No weapons of any kind are permitted in any Landlord Building or Apartment unless Tenant is an active duty police or other law enforcement officer and has identified him or herself as such to Landlord. Possession of weapons in the Building or Apartment other than by an active duty police or other law enforcement officer is grounds for immediate termination of this Lease. </li>

		<li>No additional furniture, appliances, furnishings or decorations shall be brought into the Building or Apartment, nor shall the installation of any satellite or microwave antennas, dishes, cabling, technology or telecommunications lines be permitted therein, without the prior written consent of Landlord, which such consent may be given or withheld in Landlord’s sole and absolute discretion. </li>
	</ul>

<h2>SIGNATURE PAGE TO FOLLOW</h2>
<br>
<hr>
<br>

{if $users}
<h1>LEASE SIGNATURE PAGE</h1>
<br>
{if $users}
{foreach $users as $user}
{if $user->id != $contract_user->id}
<div>
	<p>
		<strong>
			“Tenant”:<br>
			{$user->name|escape}
		</strong>
	</p>
</div>
<br>
<div>
	<p>
		<strong>
			Tenant Email Address for Notice and Correspondence:<br>
			{$user->email}
		</strong>
	</p>
</div>
<br>
<div>
	<p>
		Landlord:<br>
		<img src="design/{$settings->theme|escape}/images/signatures/jacob_shapiro.png" alt="Signature: Jacob Shapiro" width="110" /><br>
		By:<br> Jacob Shapiro
	</p>
</div>
<br>
<div>
	<p>
		Landlord:<br>
		<img src="design/{$settings->theme|escape}/images/signatures/taylor_post.png" alt="Signature: Taylor Post" width="180" /><br>
		By:<br> Taylor Post
	</p>
</div>
<br>


<div>
	<p>
		Tenant:<br>
		{$user->name|escape}
		{if $user->contract->signature}
			<br>
			<img src="{$user->contract->signature}" alt="Signature {$user->name|escape}" width="180" />
		{elseif $user->booking->client_type_id==2}
			<br>
			Digital Signature ID: {$user->booking->airbnb_reservation_id}
		{/if}
	</p>
</div>
<br>
<br>
{/if}
{/foreach}
{/if}

{if $airbnb_bookings}
{foreach $airbnb_bookings as $airbnb_booking}
	{if $airbnb_booking->users}
		{foreach $airbnb_booking->users as $user}
		<div>
			<p>
				<strong>
					“Tenant” :<br>
					{$user->name|escape}
				</strong>
			</p>
		</div>
		<br>
		{*
		<div>
			<p>
				<strong>
					Tenant Email Address for Notice and Correspondence:<br>
					{$user->email}
				</strong>
			</p>
		</div>
		<br>
		*}
			<div>
				<p>
					Landlord:<br>
					<img src="design/{$settings->theme|escape}/images/signatures/jacob_shapiro.png" alt="Signature: Jacob Shapiro" width="110" /><br>
					By:<br> Jacob Shapiro
				</p>
			</div>
			<br>
			<div>
				<p>
					Landlord:<br>
					<img src="design/{$settings->theme|escape}/images/signatures/taylor_post.png" alt="Signature: Taylor Post" width="180" /><br>
					By:<br> Taylor Post
				</p>
			</div>
		<br>
		<div>
			<p>
				Tenant:<br>
				{$user->name|escape}<br>
				Digital Signature ID: {$airbnb_booking->airbnb_reservation_id}
			</p>
			
		</div>
		<br>
		<br>
		{/foreach}
	{/if}
{/foreach}
{/if}

<div>
	<p>
		<strong>
			“Tenant”:<br>
			{$contract_user->name|escape}
		</strong>
	</p>
</div>
<br>
	<div>
		<p>
			Landlord:<br>
			<img src="design/{$settings->theme|escape}/images/signatures/jacob_shapiro.png" alt="Signature: Jacob Shapiro" width="110" /><br>
			By:<br> Jacob Shapiro
		</p>
	</div>
	<br>
	<div>
		<p>
			Landlord:<br>
			<img src="design/{$settings->theme|escape}/images/signatures/taylor_post.png" alt="Signature: Taylor Post" width="180" /><br>
			By:<br> Taylor Post
		</p>
	</div>
<br>
<div>
	<p>
		Tenant:<br>
		{$contract_user->name|escape}
		{if $contract_info->signature2}
			<br>
			<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
		{elseif $contract_user->booking->client_type_id==2}
			<br>
			Digital Signature ID: {$contract_user->booking->airbnb_reservation_id}
		{/if}
	</p>
</div>


<br>
<hr>
<br>
{/if}



{foreach $users as $user}
{if $user->id != $contract_user->id || $user@iteration < $users|count}
<h1>RIDER TO THE LEASE</h1>
	<p>In the event of any inconsistency between the provisions of this Rider to the Lease and the provisions of the Lease to which this Rider is attached, the provisions of this Rider shall control.  Any defined terms contained herein not otherwise defined herein shall have the meaning so ascribed in the Lease.</p>
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
	<p>TENANT AGREES THAT THIS LEASE IS VALID FOR THE TERM SET FORTH ON THE FIRST PAGE OF THIS LEASE.  Tenant’s occupancy commences at noon on the first date of the Occupancy Term, and ends at 12 p.m. on the final day of the Occupancy Term.</p>
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
			<p>{$user->booking->airbnb_reservation_id}</p>
		{else}
			{$user->contract->price_month|convert} (US Dollars).
		{/if}
	</p>

	<p>TENANT IS JOINTLY AND SEVERALLY LIABLE FOR THE MONTHLY RENT set forth on the first page of this Lease. Landlord will not seek to hold Tenant for more than the Allocable Portion of the Monthly Rent for any month or portion of a month in which that Tenant has legal occupancy of the Apartment, except if (1) Tenant causes any other occupant to vacate the Apartment; (2) Tenant causes any other occupant to be unable to move into the Apartment. Unless held jointly and severally liable for the Monthly Rent or any portion thereof, Tenant must pay the Allocable Portion of Monthly Rent for the entire Occupancy Term.</p>
</div>
<div>
	<p><strong>“Allocable Portion of Security Deposit”</strong></p>
	<p>{$user->contract->price_deposit|convert} (US Dollars).</p>
	<p>Allocable Portion of Security Deposit shall be assigned to an assignee in the event of Assignment of the Sub Lease. Tenant agrees to accept a cash payment from Overtenant equal to the Allocable Portion of Security Deposit (“Cash Payment”), less any costs deducted in accordance with the Sub Lease and less the Early Termination Fee, as consideration for the assignment of the Allocable Portion of Security Deposit.</p>
</div>
<div>
	<p><strong>“Bedroom Selection”</strong></p>
	<p>Room {$user->bed->name}.</p>
	<p>Tenant is free to change Bedroom Selection to another bedroom within the Apartment by consent of the tenant occupying the desired bedroom. Nothing herein contained shall require notification to Landlord of such changes. Tenant agrees that the Allocable Portion of the Monthly Rent may be adjusted to reflect the portion of the Monthly Rent allocable to Tenant’s bedroom.</p>
</div>

<div>
	<p><strong>“Cleaning Fee”</strong></p>
	<p>At the end of the Occupancy Term or a change in Bedroom Selection, whether by transfer or otherwise, Tenant shall pay Landlord a one-time only fee of $250 (two hundred fifty) to cover the costs of cleaning the Tenant’ bedroom, in case the bedroom was not cleaned property by the Tenant. Such Cleaning Fee shall be deducted from the refund of a Tenant’s Allocable Portion of Security Deposit or shall reduce the Cash Payment.</p>
</div>

<div>
	<p><strong>Consent to Assignment</strong></p>
	<p>At the end of the Occupancy Term or any termination of occupancy prior to the end of the Occupancy Term, Tenant consents to Assign this lease to an individual of Landlord’s choosing. Tenant understands that the identity of the assignee shall not be provided to Tenant.</p>
</div>
	<div>
		<p><strong>Additional Terms and Conditions of Lease:</strong></p>
		<p>Tenant agrees to pay the Allocable Portion of Monthly Rent in the manner set forth for payment of Monthly Rent in the Lease for the Occupancy Term and shall pay the Allocable Portion of the Monthly Rent for any additional period Tenant is in occupancy of the Suite. Occupancy after the end of the Occupancy Term is subject to the Overstay Fee.</p>
		<p>In the event Tenant remains in occupancy or has failed to remove all personal items beyond the  Occupancy Term, the Occupancy Term shall be automatically extended to the end of the Lease Term and Tenant shall pay an overstay fee of $500 (“<strong>Overstay Fee</strong>”) for each month or portion of a month from the end of the Occupancy Term to the end of the Lease Term. Overstay Fee shall be Additional Rent. Tenants who remain in occupancy beyond the Lease Term are subject to the liquidated damages set forth in the End of Term provision of this Lease.  Tenant shall not occupy the Apartment or store or otherwise keep personal items in the Apartment or Building prior to the start of the Occupancy Term.</p>
		<p>In the event that Tenant terminates this lease to transfer to another Apartment or Building controlled by Landlord or Landlord’s Agent, which shall be in Landlord’s or Landlord’s Agent’s sole discretion, Tenant must assign this lease. In the event Tenant does not transfer after the request has been granted, Tenant shall pay the Overstay Fee for each month or portion of a month from the termination of the Occupancy Term to the end of the Lease Term.</p>
	</div>

	<div>
		<p><strong>Signatures and Commencement Date:</strong></p>
		<p>Landlord and Tenant have signed this Lease as of the Date of Lease. It commences upon (1) Tenant’s acceptance by Landlord, (2) the receipt of Tenant’s Allocable Portion of the Security Deposit and Allocable Portion of Monthly Rent due for the first month of the Occupancy Term (collectively “Commencement Requirements”). This Lease shall have no effect and shall be mutually rescinded if Commencement Requirements are not met, and Tenant shall have no occupancy rights in the Apartment.</p>
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


	<div>
		<p>
			Landlord:<br>
			<img src="design/{$settings->theme|escape}/images/signatures/jacob_shapiro.png" alt="Signature: Jacob Shapiro" width="110" /><br>
			By:<br> Jacob Shapiro
		</p>
	</div>
	<br>
	<div>
		<p>
			Landlord:<br>
			<img src="design/{$settings->theme|escape}/images/signatures/taylor_post.png" alt="Signature: Taylor Post" width="180" /><br>
			By:<br> Taylor Post
		</p>
	</div>


{if $user->contract->signature}
<p>TENANT: {$user->name|escape}<br/>
	DATE: {$user->contract->date_signing|date_format:'%b %e, %Y'}<br/>
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


{if $airbnb_bookings}
{foreach $airbnb_bookings as $airbnb_booking}
{if $airbnb_booking->users}
{foreach $airbnb_booking->users as $user}


<h1>RIDER TO THE LEASE</h1>
	<p>In the event of any inconsistency between the provisions of this Rider to the Lease and the provisions of the Lease to which this Rider is attached, the provisions of this Rider shall control.  Any defined terms contained herein not otherwise defined herein shall have the meaning so ascribed in the Lease.</p>
<div>
	<p><strong>“Tenant”:</strong></p>
	<p>{$user->name|escape}</p>
</div>
{*<div>
	<p><strong>Tenant Email Address for Notice and Correspondence:</strong> </p>
	<p>{$user->email}</p>
</div>*}
<div>
	<p><strong>“Occupancy Term”</strong></p>
	<p>{$airbnb_booking->arrive|date_format:'%b %e, %Y'} to {$airbnb_booking->depart|date_format:'%b %e, %Y'}.</p>
	<p>TENANT AGREES THAT THIS LEASE IS VALID FOR THE TERM SET FORTH ON THE FIRST PAGE OF THIS LEASE.  Tenant’s occupancy commences at noon on the first date of the Occupancy Term, and ends at 12 p.m. on the final day of the Occupancy Term.</p>
</div>
	<div>
		<p><strong>“Total amount”</strong></p>
		<p>[TENANT RENT AMOUNT].  TENANT IS JOINTLY AND SEVERALLY LIABLE FOR THE MONTHLY RENT set forth on the first page of this Lease. Landlord will not seek to hold Tenant for more than the Allocable Portion of the Monthly Rent for any month or portion of a month in which that Tenant has legal occupancy of the Apartment, except if (1) Tenant causes any other occupant to vacate the Apartment; (2) Tenant causes any other occupant to be unable to move into the Apartment. Unless held jointly and severally liable for the Monthly Rent or any portion thereof, Tenant must pay the Allocable Portion of Monthly Rent for the entire Occupancy Term.</p>
	</div>
	<div>
		<p><strong>“Allocable Portion of Security Deposit”</strong></p>
		<p>0 (US Dollars).</p>
		<p>Allocable Portion of Security Deposit shall be assigned to an assignee in the event of Assignment of the Sub Lease. Tenant agrees to accept a cash payment from Overtenant equal to the Allocable Portion of Security Deposit (“Cash Payment”), less any costs deducted in accordance with the Sub Lease and less the Early Termination Fee, as consideration for the assignment of the Allocable Portion of Security Deposit.</p>
	</div>
	<div>
		<p><strong>“Bedroom Selection”</strong></p>
		<p>Room {$user->bed->name}.  Tenant is free to change Bedroom Selection to another bedroom within the Apartment by consent of the tenant occupying the desired bedroom. Nothing herein contained shall require notification to Landlord of such changes. Tenant agrees that the Allocable Portion of the Monthly Rent may be adjusted to reflect the portion of the Monthly Rent allocable to Tenant’s bedroom.</p>
	</div>
	<div>
		<p><strong>“Cleaning Fee”</strong></p>
		<p>At the end of the Occupancy Term or a change in Bedroom Selection, whether by transfer or otherwise, Tenant shall pay Landlord a one-time only fee of $250 (two hundred fifty) to cover the costs of cleaning the Tenant’ bedroom, in case the bedroom was not cleaned property by the Tenant. Such Cleaning Fee shall be deducted from the refund of a Tenant’s Allocable Portion of Security Deposit or shall reduce the Cash Payment.</p>
	</div>
	<div>
		<p><strong>Consent to Assignment</strong></p>
		<p>At the end of the Occupancy Term or any termination of occupancy prior to the end of the Occupancy Term, Tenant consents to Assign this lease to an individual of Landlord’s choosing. Tenant understands that the identity of the assignee shall not be provided to Tenant.</p>
	</div>
	<div>
		<p><strong>Additional Terms and Conditions of Lease:</strong></p>
		<p>Tenant agrees to pay the Allocable Portion of Monthly Rent in the manner set forth for payment of Monthly Rent in the Lease for the Occupancy Term and shall pay the Allocable Portion of the Monthly Rent for any additional period Tenant is in occupancy of the Suite. Occupancy after the end of the Occupancy Term is subject to the Overstay Fee.</p>
		<p>In the event Tenant remains in occupancy or has failed to remove all personal items beyond the  Occupancy Term, the Occupancy Term shall be automatically extended to the end of the Lease Term and Tenant shall pay an overstay fee of $500 (“<strong>Overstay Fee</strong>”) for each month or portion of a month from the end of the Occupancy Term to the end of the Lease Term. Overstay Fee shall be Additional Rent. Tenants who remain in occupancy beyond the Lease Term are subject to the liquidated damages set forth in the End of Term provision of this Lease.  Tenant shall not occupy the Apartment or store or otherwise keep personal items in the Apartment or Building prior to the start of the Occupancy Term.</p>
		<p>In the event that Tenant terminates this lease to transfer to another Apartment or Building controlled by Landlord or Landlord’s Agent, which shall be in Landlord’s or Landlord’s Agent’s sole discretion, Tenant must assign this lease. In the event Tenant does not transfer after the request has been granted, Tenant shall pay the Overstay Fee for each month or portion of a month from the termination of the Occupancy Term to the end of the Lease Term.</p>
	</div>

<div>
	<p><strong>Signatures and Commencement Date:</strong></p>
	<p>Landlord and Tenant have signed this Lease as of the Date of Lease. It commences upon (1) Tenant’s acceptance by Landlord, (2) the receipt of Tenant’s Allocable Portion of the Security Deposit and Allocable Portion of Monthly Rent due for the first month of the Occupancy Term (collectively “Commencement Requirements”). This Lease shall have no effect and shall be mutually rescinded if Commencement Requirements are not met, and Tenant shall have no occupancy rights in the Apartment.</p>
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

	<div>
		<p>
			Landlord:<br>
			<img src="design/{$settings->theme|escape}/images/signatures/jacob_shapiro.png" alt="Signature: Jacob Shapiro" width="110" /><br>
			By:<br> Jacob Shapiro
		</p>
	</div>
	<br>
	<div>
		<p>
			Landlord:<br>
			<img src="design/{$settings->theme|escape}/images/signatures/taylor_post.png" alt="Signature: Taylor Post" width="180" /><br>
			By:<br> Taylor Post
		</p>
	</div>

<p>TENANT: {$user->name|escape}<br/>
	DATE: {$airbnb_booking->created|date_format:'%b %e, %Y'}<br/>
	DIGITAL SIGNATURE ID: {$airbnb_booking->airbnb_reservation_id}<br>
</p>

<br>
<hr>
<br>


{/foreach}
{/if}
{/foreach}
{/if}



<h1>RIDER TO THE LEASE</h1>
	<p>In the event of any inconsistency between the provisions of this Rider to the Lease and the provisions of the Lease to which this Rider is attached, the provisions of this Rider shall control.  Any defined terms contained herein not otherwise defined herein shall have the meaning so ascribed in the Lease.</p>

{*
<div>
	<p><strong>“Tenant”:</strong></p>
	<p>{foreach $contract_users as $user}{if $contract_user->id != $user->id}{$user->name|escape}, {/if}{/foreach}{$contract_user->name|escape}</p>
</div>
<div>
	<p><strong>Tenant Email Address for Notice and Correspondence:</strong> </p>
	<p>{foreach $contract_users as $user}{if $contract_user->id != $user->id}{$user->email}, {/if}{/foreach}{$contract_user->email}</p>
</div>
*}
<div>
	<p><strong>“Tenant”:</strong></p>
	<p>{$contract_user->name|escape}</p>
</div>
<div>
	<p><strong>Tenant Email Address for Notice and Correspondence:</strong> </p>
	<p>{$contract_user->email}</p>
</div>
<div>
	<p><strong>“Occupancy Term”</strong></p>
	<p>{$contract_info->date_from|date_format:'%b %e, %Y'} to {$contract_info->date_to|date_format:'%b %e, %Y'}.</p>
	<p>TENANT AGREES THAT THIS LEASE IS VALID FOR THE TERM SET FORTH ON THE FIRST PAGE OF THIS LEASE.  Tenant’s occupancy commences at noon on the first date of the Occupancy Term, and ends at 12 p.m. on the final day of the Occupancy Term.</p>
</div>
<div>
	{if $booking->client_type_id == 2}
		<p><strong>“Total Amount”</strong></p>
		<p>{$booking->airbnb_reservation_id}</p>
	{else}
		<p><strong>“Allocable Portion of Monthly Rent”</strong></p>
		<p>{$contract_info->price_month|convert} (US Dollars).</p>
	{/if}

	<p>TENANT IS JOINTLY AND SEVERALLY LIABLE FOR THE MONTHLY RENT set forth on the first page of this Lease. Landlord will not seek to hold Tenant for more than the Allocable Portion of the Monthly Rent for any month or portion of a month in which that Tenant has legal occupancy of the Apartment, except if (1) Tenant causes any other occupant to vacate the Apartment; (2) Tenant causes any other occupant to be unable to move into the Apartment. Unless held jointly and severally liable for the Monthly Rent or any portion thereof, Tenant must pay the Allocable Portion of Monthly Rent for the entire Occupancy Term.</p>
</div>
<div>
	<p><strong>“Allocable Portion of Security Deposit”</strong></p>
	<p>{$contract_info->price_deposit|convert} (US Dollars).</p>
	<p>Allocable Portion of Security Deposit shall be assigned to an assignee in the event of Assignment of the Sub Lease. Tenant agrees to accept a cash payment from Overtenant equal to the Allocable Portion of Security Deposit (“Cash Payment”), less any costs deducted in accordance with the Sub Lease and less the Early Termination Fee, as consideration for the assignment of the Allocable Portion of Security Deposit.</p>
</div>
<div>
	<p><strong>“Bedroom Selection”</strong></p>
	<p>Room {$bed->name}.</p>
	<p>Tenant is free to change Bedroom Selection to another bedroom within the Apartment by consent of the tenant occupying the desired bedroom. Nothing herein contained shall require notification to Landlord of such changes. Tenant agrees that the Allocable Portion of the Monthly Rent may be adjusted to reflect the portion of the Monthly Rent allocable to Tenant’s bedroom.</p>
</div>
	<div>
		<p><strong>“Cleaning Fee”</strong></p>
		<p>At the end of the Occupancy Term or a change in Bedroom Selection, whether by transfer or otherwise, Tenant shall pay Landlord a one-time only fee of $250 (two hundred fifty) to cover the costs of cleaning the Tenant’ bedroom, in case the bedroom was not cleaned property by the Tenant. Such Cleaning Fee shall be deducted from the refund of a Tenant’s Allocable Portion of Security Deposit or shall reduce the Cash Payment.</p>
	</div>
	<div>
		<p><strong>Consent to Assignment</strong></p>
		<p>At the end of the Occupancy Term or any termination of occupancy prior to the end of the Occupancy Term, Tenant consents to Assign this lease to an individual of Landlord’s choosing. Tenant understands that the identity of the assignee shall not be provided to Tenant.</p>
	</div>
	<div>
		<p><strong>Additional Terms and Conditions of Lease:</strong></p>
		<p>Tenant agrees to pay the Allocable Portion of Monthly Rent in the manner set forth for payment of Monthly Rent in the Lease for the Occupancy Term and shall pay the Allocable Portion of the Monthly Rent for any additional period Tenant is in occupancy of the Suite. Occupancy after the end of the Occupancy Term is subject to the Overstay Fee.</p>
		<p>In the event Tenant remains in occupancy or has failed to remove all personal items beyond the  Occupancy Term, the Occupancy Term shall be automatically extended to the end of the Lease Term and Tenant shall pay an overstay fee of $500 (“<strong>Overstay Fee</strong>”) for each month or portion of a month from the end of the Occupancy Term to the end of the Lease Term. Overstay Fee shall be Additional Rent. Tenants who remain in occupancy beyond the Lease Term are subject to the liquidated damages set forth in the End of Term provision of this Lease.  Tenant shall not occupy the Apartment or store or otherwise keep personal items in the Apartment or Building prior to the start of the Occupancy Term.</p>
		<p>In the event that Tenant terminates this lease to transfer to another Apartment or Building controlled by Landlord or Landlord’s Agent, which shall be in Landlord’s or Landlord’s Agent’s sole discretion, Tenant must assign this lease. In the event Tenant does not transfer after the request has been granted, Tenant shall pay the Overstay Fee for each month or portion of a month from the termination of the Occupancy Term to the end of the Lease Term.</p>
	</div>

	<div>
		<p><strong>Signatures and Commencement Date:</strong></p>
		<p>Landlord and Tenant have signed this Lease as of the Date of Lease. It commences upon (1) Tenant’s acceptance by Landlord, (2) the receipt of Tenant’s Allocable Portion of the Security Deposit and Allocable Portion of Monthly Rent due for the first month of the Occupancy Term (collectively “Commencement Requirements”). This Lease shall have no effect and shall be mutually rescinded if Commencement Requirements are not met, and Tenant shall have no occupancy rights in the Apartment.</p>
	</div>

{if $contract_info->note1}
<div>
	<p><strong>Note:</strong></p>
	<p>{$contract_info->note1}</p>
</div>
{/if}


	<div>
		<p>
			Landlord:<br>
			<img src="design/{$settings->theme|escape}/images/signatures/jacob_shapiro.png" alt="Signature: Jacob Shapiro" width="110" /><br>
			By:<br> Jacob Shapiro
		</p>
	</div>
	<br>
	<div>
		<p>
			Landlord:<br>
			<img src="design/{$settings->theme|escape}/images/signatures/taylor_post.png" alt="Signature: Taylor Post" width="180" /><br>
			By:<br> Taylor Post
		</p>
	</div>

{*
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
*}

TENANT NAME: {$contract_user->name|escape}<br/>
{if $contract_info->signing == 1}
	DATE: {$contract_info->date_signing|date_format:'%b %e, %Y'}<br/>
{/if}
{if $contract_info->signature2}
	SIGNATURE:<br>
	<br>
{elseif $contract_user->booking->client_type_id==2 && $contract_info->signing}
	DIGITAL SIGNATURE ID: {$contract_user->booking->airbnb_reservation_id}<br>
	<br>
	<br>
{/if}
{if !$contract_info->signature2 && !$create_pdf}
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

{*
<!-- Bedford house -->
{if $airbnb_bjs && $contract_info->house_id == 315} 
<br>

<hr>

<br>
<br>
<br>

<h1>RESIDENTS RIDER</h1>
<p>This Rider represents the Tenants coming from 3rd party booking sources, residing in the property on the date of Contract signing.</p>

{foreach $airbnb_bjs as $ab}
<div>
	<p><strong>“Tenant”:</strong></p>
	<p>{foreach $ab->users as $user}{$user->name|escape}{if !$user@last}, {/if}{/foreach}</p>
</div>
<div>
	<p><strong>Tenant Email Address for Notice and Correspondence:</strong> </p>
	<p>{foreach $ab->users as $user}{$user->email}{if !$user@last}, {/if}{/foreach}</p>
</div>
<div>
	<p><strong>“Occupancy Term”</strong></p>
	<p>{$ab->arrive|date_format:'%b %e, %Y'} to {$ab->depart|date_format:'%b %e, %Y'}.</p>
</div>
<div>
	<p><strong>“Allocable Portion of Monthly Rent”</strong></p>
	<p>{$ab->price_month|convert} (US Dollars).</p>
</div>
<div>
	<p>DIGITAL TENANT IDENTIFIER: <strong>{$ab->airbnb_reservation_id}</strong></p>
</div>
<br><br>
{/foreach}

{/if}
*}
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
		<li>(c) Lessee has received copies of all information listed above.</li>
		<li>(d) Lessee has received the pamphlet Protect Your Family from Lead in Your Home.</li>
	</ul>
	<strong>Certification of Accuracy</strong>
	<p>The following parties have reviewed the information above and certify, to the best of their knowledge, that the information they have provided is true and accurate.</p>


	<div>
		<p>
			OWNER: Name: Jacob Shapiro<br>
			<img src="design/{$settings->theme|escape}/images/signatures/jacob_shapiro.png" alt="Signature: Jacob Shapiro" width="110" /><br>
			By:<br> Jacob Shapiro
		</p>
	</div>
	<br>
	<div>
		<p>
			OWNER: Name: Taylor Post<br>
			<img src="design/{$settings->theme|escape}/images/signatures/taylor_post.png" alt="Signature: Taylor Post" width="180" /><br>
			By:<br> Taylor Post
		</p>
	</div>

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

{if $booking->type==2}
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
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree1" for="agree1">I agree and sign</label><input type="checkbox" id="agree1" name="agree1" class="agree" value="1"></p>
{/if} 

<br>

<hr>

<br>
<br>
<br>

{*
<h1>SPRINKLER DISCLOSURE</h1>
<p>Pursuant to the New York State Real Property Law, Article 7, Section 231-a, all residential leases must contain a conspicuous notice as to the existence or non-existence of a Sprinkler System in the Leased Premises. A “Sprinkler System” is a system of piping and appurtenances designed and installed in accordance with generally accepted standards so that heat from a fire will automatically cause water to be discharged over the fire area to extinguish it or prevent its further spread (Executive Law of New York, Article 6-C, Section 155-a(5)).</p>
<p>Name of tenant(s): <strong>{if $booking->type==2}{foreach $contract_users as $user}{if $contract_user->id != $user->id}{$user->name|escape}, {/if}{/foreach}{/if}{$contract_user->name|escape}</strong></p>
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
	{if $contract_info->signature || $contract_info->signing}
		<img src="design/{$settings->theme|escape}/images/c_signature.png" alt="Signature Sergii Starostin" width="180" />
	{/if}
</p>

{if $booking->type==2}
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
{/if}

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

{if $booking->type==2}
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
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree2" for="agree2">I agree and sign</label><input type="checkbox" id="agree2" name="agree2" class="agree" value="1"></p>
{/if} 
<br>

<hr>

<br>
<br>
<br>
*}

{*
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
<p>Name of tenant(s): <strong>{if $booking->type==2}{foreach $contract_users as $user}{if $contract_user->id != $user->id}{$user->name|escape}, {/if}{/foreach}{/if}{$contract_user->name|escape}</strong></p>
<p>Subject Premises: <strong>{$contract_info->rental_address}, {$apartment->name}</strong></p>
<p>Apt.#: {$apartment->name}</p>
<p>Date of vacancy lease: {$contract_info->date_from|date_format:'%b %e, %Y'}</p>

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
	{if $contract_info->signature || $contract_info->signing}
		<img src="design/{$settings->theme|escape}/images/c_signature.png" alt="Signature Sergii Starostin" width="180" />
	{/if}
</p>

{if $booking->type==2}
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
{/if}

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

{if $booking->type==2}
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
{if $contract_info->signature || $contract_info->signing}
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

{if $booking->type==2}
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
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree4" for="agree4">I agree and sign</label><input type="checkbox" id="agree4" name="agree4" class="agree" value="1"></p>
{/if} 


<p>RETURN THIS FORM TO:</p>
<p>Owner/Manager: Outpost Club, Inc.<br/>
	By: Sergii Starostin<br/>
	Address: P.O. 780316 Maspeth, NY, 11378<br/>
	DATE: <br/>
	SIGNATURE: <br/>
	{if $contract_info->signature || $contract_info->signing}
		<img src="design/{$settings->theme|escape}/images/c_signature.png" alt="Signature Sergii Starostin" width="180" />
	{/if}
</p>

<p>For Further Information Call: Window Falls Prevention (212) 676-2162 WF-013 (Rev. 11/02)</p>

<br>

<hr>

<br>
<br>
<br>

*}

<h1>Basement Use Lease Addendum</h1>
<p>This Addendum made on <strong>{$contract_info->date_created|date_format:'%b %e, %Y'}</strong> by and between <strong>{if $booking->type==2}{foreach $contract_users as $user}{if $contract_user->id != $user->id}{$user->name|escape}, {/if}{/foreach}{/if}{$contract_user->name|escape}</strong> (“Tenant”) and  Jacob Shapiro and Taylor Post (“Landlord”) shall become a part of and be incorporated into the attached Lease Agreement (“Lease”) dated <strong>{$contract_info->date_from|date_format:'%b %e, %Y'}</strong> for <strong>{$apartment->name} at {$contract_info->rental_address}</strong> (“Apartment”).</p>
<ul>
	<li><strong>Basement.</strong> Tenant shall have limited access to the basement in the Apartment (“Basement”)</li>
	<li><strong>Use.</strong> The Tenant understands and agrees that the Basement shall only be used for the purpose of storage and not for living space.</li>
	<li><strong>No Storage of Dangerous Items.</strong> The Tenant understands and agrees that storage of any dangerous items in the Basement is strictly prohibited. Dangerous items include, but are not limited to, living animals, reptiles, insects, any hazardous, flammable, noxious, combustible materials or otherwise dangerous or illegal items that pose a risk or hazard to the safety of the Tenant and any other resident.</li>
	<li><strong>Tenant Responsibility for Storage.</strong> The Tenant understands and agrees that the Landlord has no liability whatsoever for any damage or loss to any items stored by the Tenant in the Basement, whether caused by theft, fire, flooding, or otherwise.</li>
	<li><strong>Indemnification of Landlord.</strong> The Tenant agrees to indemnify and hold the Landlord harmless from and against any and all claims, actions, suits, judgments and demands brought by any other party on account of or in connection with any activity associated with the Basement. This includes but is not limited to, any damages caused by fire, insects, liquid or hazardous materials, water, or theft.</li>
	<li><strong>Access by Landlord.</strong> Tenant understands and agrees that Landlord has the right, upon giving 24 hours’ notice, to enter the Basement to make routine inspections or necessary repairs</li>
	<li><strong>Abandoned Items.</strong> Any items remaining in the Basement after the term of the Lease, or any extension thereof, will be deemed abandoned and will be removed, sold or otherwise disposed of by the Landlord.</li>
	<li><strong>Revocation of Addendum.</strong> Landlord has, at its sole option, the right to revoke Tenant’s use of the Basement at any time. Tenant shall not be entitled to any damages incurred as a result of Landlord’s decision to revoke Tenant’s use of the Basement under this provision.</li>
	<li><strong>Control over Sub Lease.</strong> The terms of this Addendum shall control over the terms of the Lease.</li>
	<li><strong>Binding effect.</strong> This Addendum shall bind all parties to the Lease and shall also bind all those succeeding to the rights of any party of the Lease.</li>
</ul>

	<div>
		<p>
			OWNER: Name: Jacob Shapiro<br>
			<img src="design/{$settings->theme|escape}/images/signatures/jacob_shapiro.png" alt="Signature: Jacob Shapiro" width="110" /><br>
			By:<br> Jacob Shapiro
		</p>
	</div>
	<br>
	<div>
		<p>
			OWNER: Name: Taylor Post<br>
			<img src="design/{$settings->theme|escape}/images/signatures/taylor_post.png" alt="Signature: Taylor Post" width="180" /><br>
			By:<br> Taylor Post
		</p>
	</div>

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

{if $booking->type==2}
{foreach $contract_users as $user}
{if $user->id != $contract_user->id}
<p>
	TENANT NAME: {$user->name|escape}<br/>
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
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree5" for="agree5">I agree and sign</label><input type="checkbox" id="agree5" name="agree5" class="agree" value="1"></p>
{/if} 

<br>

<hr>

<br>
<br>
<br>



<p><strong>Inventory List</strong></p>
<p>Inventory List - may be changed at the landlord discretion anytime.</p>
<br>
<table class="contract_table">
<tbody>
<tr>
	<th>INDIVIDUAL<br> BEDROOM</th>
</tr>
<tr>
	<td class="w100 txt_bx">
		<p><strong>All bedrooms are unfurnished and will be empty upon arrival, unless agreed otherwise.</strong></p>
		<p><strong>In the event that the room is rented as furnished, the Following List of Furniture & Fixtures Are Included if agreed to. Brand or availability may be subject to change.</strong></p>
		<ul>
			<li>
				<strong>Furniture & Fixtures:</strong> Bed Frame, Mattress, Desk/C-Table (subject of availability), Chair, Shelving, Nightstand, lamp, Coat Hangers, Curtains, Mirror (subject of availability and space). All rooms come “as is” when advertised in photos.
			</li>
			<li>
				<strong>Bedding:</strong> Pillows, Comforter, Bedsheets Set (Pillow Cases, Flat Sheet & Fitted Sheet), Duvet Cover & Mattress Protector - if chosen by the Individual Tenant to be provided by Manager / owner, may be subject to additional one time fee.
			</li>
			<li><strong>Large Appliances:</strong> HVAC Unit or Window A/C provided for hot months of the year.</li>
		</ul>
	</td>
</tr>
</tbody>
</table>

<table class="contract_table">
<tbody>
<tr>
	<th>APARTMENT<br> SHARED SPACES</th>
</tr>
<tr>
<td class="w100 txt_bx">
<p><strong>The Following List of Furniture & Fixtures Are Included. Brand or availability may be subject to change.</strong></p>
<ul>
<li><strong>Living Area:</strong> Vacuum, Iron, Ironing Board, Sofa, TV, TV Console, Coat Racks, Shoe Rack, Coffee Table, Washer, Dryer, Kitchen table & chairs.</li>
<li><strong>Kitchen Appliances:</strong> Coffee Maker, Microwave, Stove, Oven, Refrigerator.</li>
<li><strong>Kitchen Equipment:</strong>  Beverage Glass, Mugs, Pot Holder/ Gloves, Paper Towel Holder, Scissors, Grater, Salad bowl (Large), Salad  Bowl  (Small), Spaghetti Ladle, Frying Pan (Small), Frying Pan (Medium), Pot with Lid (Small), Ladle, Cook Knife, Bread Knife, Steak Knives, Forks, Knives, Spoons, Tea Spoon, Plate Set (Small plates, Large Plates, Bowls), Trash can, Ice Cube Tray, Salt & Pepper, Utensil Tray, Cutting board, Corkscrew & Can Opener.</li>
<li><strong>Bathroom:</strong> Toilet Brush, Shower Curtain, Shower Liner, Shower Rings, Plunger, Toilet Paper, Mirror.</li>
</ul>
</td>
</tr>
</tbody>
</table>





<br>

<hr>

<br>
<br>
<br>


<h1 class="center page-break-before">FEE CATALOG</h1>
<p><strong>Damage/Loss Charges</strong></p>
<p>Individual Tenant is responsible for damages to his/her Apartment Unit, as well as damage and/or loss to the furnishings, fixtures, equipment, appliances and other property Lessor has provided, which are caused by the acts or omissions of such Individual Tenant, and his or her Authorized Occupants, guests and invitees. Individual Tenant agrees to pay for the restoration of the property to its condition at the time of initial occupancy or for repairs or replacement (except normal wear and tear), unless the identity of others responsible, including other Individual Tenants and their Authorized Occupants, guests and invitees, for the damage or loss is established and proven by Individual Tenant. This responsibility extends until the Apartment Unit is officially returned to Lessor as provided above. If the responsible party for the damages cannot be determined, charges for damages, cleaning, replacement of furniture, etc. shall be divided by the number of Individual Tenants leasing the Apartment Unit. If one or more Individual Tenants or their Authorized Occupants assume responsibility for damages, cleaning, replacement of furniture, etc., a written statement signed by the responsible party must be noted in writing and delivered to Lessor at the time of surrendering occupancy. Charges will not be assessed to one Individual Tenant based solely on another Individual Tenant's claim of wrongdoing. Individual Tenant should assure that all windows and doors to the Apartment Unit are locked and secured at all times and when vacating the Apartment Unit. It is understood that Individual Tenants are responsible for any damage or loss caused or non-routine cleaning or trash removal required to the common areas of the Apartment Building and their furnishings, including vending machines and other equipment placed in the Apartment Building as a convenience to Individual Tenants and Authorized Occupants. Common areas outside of Apartment Units may include corridors, recreation rooms, kitchens, study rooms, living rooms, laundry rooms, public bathrooms, lounges, terraces, roof top terraces, entry corridors and pavement in front of the Apartment Building, as specified for the Apartment Building. When damage occurs, Individual Tenant(s) will be billed directly for the repairs. Lessor shall have the authority to assess and assign charges for these damages as set forth in the Fee Catalogue.</p>
<br>


<table class="contract_table">
    <tbody>
    <tr>
        <th>Service Fees</th>
        <th>Cost In USD</th>
    </tr>
    <tr>
        <td>Disturbing quiet hours (12pm - 7am)</td>
        <td>$100.00</td>
    </tr>
    <tr>
        <td>Late Payment Fee</td>
        <td>As per lease</td>
    </tr>
    <tr>
        <td>Lockout Fee</td>
        <td>$10.00</td>
    </tr>
    <tr>
        <td>Cleaning Fee - Building Shared Spaces</td>
        <td>$250.00</td>
    </tr>
    </tbody>
</table>

<table class="contract_table">
    <tbody>
    <tr>
        <th>Keys/Fobs/Locks</th>
        <th>Cost In USD</th>
    </tr>
    <tr>
        <td>Lost Building Key</td>
        <td>$45.00</td>
    </tr>
    <tr>
        <td>Damaged or Broken Electronic Lock</td>
        <td>$500.00</td>
    </tr>
    <tr>
        <td>Damaged or Broken Door</td>
        <td>$200.00</td>
    </tr>
    <tr>
        <td>Delayed Return of Keys (Per Day)</td>
        <td>$50.00</td>
    </tr>
    </tbody>
</table>


<table class="contract_table page-break-before">
    <tbody>
    <tr>
        <th>Room Return - Damage or Loss</th>
        <th>Cost In USD</th>
    </tr>
    <tr>
        <td>Extra Cleaning For Dirty or Messy Room and/or using a room that&rsquo;s not yours</td>
        <td>$150.00</td>
    </tr>
    <tr>
        <td>Extra Cleaning For Dirty or Messy Shared Spaces (Kitchen, Bathroom, Hallways and Living Room) in Noncompliance with The Lanlord Standards or Any Reclamation of New Tenants (cost will be divided and applied w ju to all tenants)</td>
        <td>$300.00</td>
    </tr>
    <tr>
        <td>Smoking (room/shared spaces) &ndash; each incident</td>
        <td>$300.00</td>
    </tr>
    <tr>
        <td>Electric Socket or Light switch</td>
        <td>$150.00</td>
    </tr>
    <tr>
        <td>Bed Frame (Queen/Full)</td>
        <td>$900.00</td>
    </tr>
    <tr>
        <td>Bed Frame (Twin)</td>
        <td>$700.00</td>
    </tr>
    <tr>
        <td>Mattress (Queen/Full)</td>
        <td>$1,000.00</td>
    </tr>
    <tr>
        <td>Mattress (Twin)</td>
        <td>$800.00</td>
    </tr>
    <tr>
        <td>Mattress Protector (Queen/Full)</td>
        <td>$150.00</td>
    </tr>
    <tr>
        <td>Mattress Protector (Twin)</td>
        <td>$100.00</td>
    </tr>
    <tr>
        <td>Pillow</td>
        <td>$50.00</td>
    </tr>
    <tr>
        <td>Blinds</td>
        <td>$50.00</td>
    </tr>
    <tr>
        <td>Sheets Set (Full/Queen)</td>
        <td>$200.00</td>
    </tr>
    <tr>
        <td>Sheets Set (Twin)</td>
        <td>$150.00</td>
    </tr>
    <tr>
        <td>Duvet Cover</td>
        <td>$150.00</td>
    </tr>
    <tr>
        <td>Comforter</td>
        <td>$100.00</td>
    </tr>
    <tr>
        <td>C-Table</td>
        <td>$200.00</td>
    </tr>
    <tr>
        <td>Desk</td>
        <td>$400.00</td>
    </tr>
    <tr>
        <td>Chair</td>
        <td>$150.00</td>
    </tr>
    <tr>
        <td>Metal Stand Lamp</td>
        <td>$150.00</td>
    </tr>
    <tr>
        <td>Wardrobe</td>
        <td>$700.00</td>
    </tr>
    <tr>
        <td>Closet</td>
        <td>$1,250.00</td>
    </tr>
    <tr>
        <td>Door Mirror</td>
        <td>$100.00</td>
    </tr>
    <tr>
        <td>Trash Can</td>
        <td>$25.00</td>
    </tr>
    <tr>
        <td>Curtains (Per Curtain)</td>
        <td>$800.00</td>
    </tr>
    <tr>
        <td>Shelving</td>
        <td>$350.00</td>
    </tr>
    <tr>
        <td>Wall/ceiling damage. Paint</td>
        <td>$500.00</td>
    </tr>
    <tr>
        <td>Wall/ceiling damage. Sheetrock.(depends on the size)</td>
        <td>$300.00/$600.00/$1000.00</td>
    </tr>
    <tr>
        <td>Window damage</td>
        <td>$1000.00</td>
    </tr>
    <tr>
        <td>AC unit damage</td>
        <td>$2000.00</td>
    </tr>
    <tr>
        <td>AC remote missing or damaged</td>
        <td>$250.00</td>
    </tr>
    <tr>
        <td>Floor damage</td>
        <td>$2500.00</td>
    </tr>
    <tr>
        <td>Door damage</td>
        <td>$500.00</td>
    </tr>
    </tbody>
</table>


<table class="contract_table page-break-before">
    <tbody>
    <tr>
        <th>Shared Spaces Return - Damage or Loss</th>
        <th>Cost In USD</th>
    </tr>
    <tr>
        <td>Coffee Table</td>
        <td>$300.00</td>
    </tr>
    <tr>
        <td>Armchair</td>
        <td>$400.00</td>
    </tr>
    <tr>
        <td>TV</td>
        <td>$700.00</td>
    </tr>
    <tr>
        <td>TV Console</td>
        <td>$300.00</td>
    </tr>
    <tr>
        <td>Sofa</td>
        <td>$5,000.00</td>
    </tr>
    <tr>
        <td>Kitchen Table + Chairs</td>
        <td>$650.00</td>
    </tr>
    <tr>
        <td>Side Kitchen Table</td>
        <td>$300.00</td>
    </tr>
    <tr>
        <td>Bar Stool</td>
        <td>$250.00</td>
    </tr>
    <tr>
        <td>Cabinets (Per Cabinet)</td>
        <td>$500.00</td>
    </tr>
    <tr>
        <td>Sink</td>
        <td>$750.00</td>
    </tr>
    <tr>
        <td>Major Kitchen Appliances (Such as Refrigerator, Oven, Stovetop, Vents, Washer, Dryer) - Depends on the actual cost of replacement + Labor</td>
        <td>$600.00-</p>$2,500.00</td>
    </tr>
    <tr>
        <td>Minor Kitchen Appliances (Coffee Maker, Toaster, Electric Kettle, etc.)</td>
        <td>$100.00</td>
    </tr>
    <tr>
        <td>Microwave</td>
        <td>$400.00</td>
    </tr>
    <tr>
        <td>Vacuum</td>
        <td>$500.00</td>
    </tr>
    <tr>
        <td>Garbage Bin</td>
        <td>$150.00</td>
    </tr>
    <tr>
        <td>Shared Spaces Accessories such as Shoe Rack, Ironing Board, Iron, Coat Rack, etc.</td>
        <td>$75.00</td>
    </tr>
    <tr>
        <td>Kitchen Accessories such as Lemon Squeeze jazz r, Glass Tupperware Set, Oven Mitts, Pot Placement, Ice Cube Tray, Paper Towel Dispenser, Can Opener, Wine Opener, Hand Towels, Measuring cups, Cutting Board, etc. (Per Item)</td>
        <td>$25.00</td>
    </tr>
    <tr>
        <td>Cookware such as Pot, Pans, Lids, Oven Pyrex, etc (Per item)</td>
        <td>$50.00</td>
    </tr>
    <tr>
        <td>Utensils &amp; Glassware such as Pasta Ladle, Spatula, Thongs, Wisk, Ladle, Peeler, Grater, Scissors, Salt and Pepper Shakers (set), Cooking knives, Mugs, Glasses, Small and Large plates, Bowls, Wine Glasses, Salad Bowls, Cutlery (Forks, Knives, Spoons), Cake Slicer, Pizza Cutter, etc. (Per Item)</td>
        <td>$25.00</td>
    </tr>
    <tr>
        <td>Unplugging and/or Adjusting Cameras</td>
        <td>$100.00</td>
    </tr>
    <tr>
        <td>Disturbing quiet hours (12pm - 7am)</td>
        <td>$100.00</td>
    </tr>
    <tr>
        <td>Letting unknown guests/strangers into the building</td>
        <td>$100.00 + cost of damages</td>
    </tr>
    </tbody>
</table>

<table class="contract_table page-break-before">
    <tbody>
    <tr>
        <th>Bathroom Return - Damage or Loss</th>
        <th>Cost In USD</th>
    </tr>
    <tr>
        <td>Shower Curtain</td>
        <td>$50.00</td>
    </tr>
    <tr>
        <td>Shower Rod</td>
        <td>$150.00</td>
    </tr>
    <tr>
        <td>Shampoo Holder</td>
        <td>$75.00</td>
    </tr>
    <tr>
        <td>Medicine Cabinet</td>
        <td>$300.00</td>
    </tr>
    <tr>
        <td>Sink</td>
        <td>$750.00</td>
    </tr>
    <tr>
        <td>Cabinets</td>
        <td>$750.00</td>
    </tr>
    <tr>
        <td>Toilet</td>
        <td>$600.00</td>
    </tr>
    <tr>
        <td>Toilet Seat</td>
        <td>$75.00</td>
    </tr>
    <tr>
        <td>Bathroom Accessories such as Plunger, Toilet Brush, Trash Can, ToothBrush Cup, Hand Soap Dispenser, Toilet Paper Holder, Towel Bar, etc. (Per Item)</td>
        <td>$45.00</td>
    </tr>
    </tbody>
</table>

{*
{include file='contracts/bx/inventory_list.tpl'}
{include file='contracts/bx/fee_catalog.tpl'}
*}


{if $contract_info->rider_type == 1}
	{include file='free_rent_doc/free_rent_month.tpl'}
{elseif $contract_info->rider_type == 3}
	{include file='free_rent_doc/rider_earlymovein.tpl'}
{elseif $contract_info->rider_type == 2 && $contract_info->free_rental_amount != 0}
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

	



{* if $contract_info->signature || $contract_info->signing *}
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
		<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree6" for="agree6">I agree and sign</label><input type="checkbox" id="agree6" name="agree6" class="agree" value="1"></p>
	{/if} 

<br>
<br>

<hr>

<br>
<br>
<br>

 	{include file='free_rent_doc/free_rent.tpl'}
	<p>By initialing below, you acknowledge and agree to the terms in Free Rent Rider.</p>
{* /if *}

{/if}