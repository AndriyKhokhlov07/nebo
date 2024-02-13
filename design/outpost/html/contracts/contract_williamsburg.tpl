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
table{
	margin-bottom: 15px;
	width: 100%;
}
td, th {
    border: 1px solid black;
    padding: 10px 3px 8px;
}
tr *:first-child {
	width: 85%;
}
tr *:last-child {
	width: 15%;
	text-align: center;
}
li > h2{
	text-align: left;
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
</style>
{/literal}
{/if}

<h2 class="center">186N6 OWNER LLC <br>THIS APARTMENT IS NOT SUBJECT TO RENT REGULATION, INCLUDING, BUT NOT LIMITED TO, RENT CONTROL AND/OR RENT STABILIZATION <br>APARTMENT LEASE</h2>

<h2>INTRODUCTORY STATEMENT</h4>
<p>This Lease, together with the accompanying riders, documents, schedules, and exhibits, which is collectively defined below as the "Lease", contain the agreements between each Individual Tenant, as defined herein, and Lessor, as defined herein, concerning each Individual Tenant's rights and obligations and the rights and obligations of the Lessor. Each Individual Tenant and Lessor have other rights and obligations which are set forth in government laws and regulations.</p>
<p>Each Individual Tenant should carefully read this Lease and all of its attached parts. If you, as an Individual Tenant, have any questions, or if you do not understand any words or statements, you should seek and obtain clarification. Upon each Individual Tenant's signing of this Lease, each such Individual Tenant will be presumed to have read it and understood it. Each Individual Tenant and Lessor acknowledge and agree that all agreements between each Individual Tenant and Lessor have been written into this Lease and the House Rules, as defined herein. Each Individual Tenant understands that any agreements made before or after this Lease was signed and not written into this Lease, will not be enforceable.</p>
<p><strong>Lessor does not discriminate in leasing or any services offered as part of leasing on the basis of race, color, sex, gender, gender identity, sexual orientation, national origin, citizenship, religion, familial status, age or any other protected characteristic under applicable federal, state or local laws. Each Individual Tenant agrees, by entering into this Lease, not to discriminate with respect to any other Individual Tenant, Authorized Occupant, or their guests and invitees on the basis of race, color, sex, gender, gender identity, sexual orientation, national origin, citizenship, religion, familial status, age or any other protected characteristic under applicable federal, state or local laws.</strong></p>

<p>THIS LEASE (this "Lease") is made on <strong>{if $contract_info->signing}{$contract_info->date_signing|date_format:'%b %e, %Y'}{else}{$smarty.now|date_format:'%b %e, %Y'}{/if}</strong> between 186N6 Owner LLC, a New York limited liability company ("Lessor") whose address is c/o Flatiron, 119 W. 23rd St., #903, New York, NY 10011, and each person signing this Lease as a tenant (each an "Individual Tenant") whose addresses are set forth on their respective signature page to this Lease.</p>

<ol>

<li>
	<h2>APARTMENT UNIT AND USE</h2>
	<ol>
		<li>Lessor agrees to Lease to each Individual Tenant the apartment unit numbered <strong>{$apartment->name} / {$bed->name}</strong> (the "Apartment Unit") in the building  located at {$contract_info->rental_address} ("Apartment Building").</li>
		<li>The Apartment Unit is comprised of 4 individual bedrooms (each a "Bedroom"), a living room (the "Living Room"), a kitchen (the "Kitchen") and one or more bathrooms (the "Bathroom"). The Living Room and Kitchen may not have dividing walls and be open space. Each Individual Tenant will have the non-exclusive shared use of the Living Room, the Kitchen and the Bathroom, and the exclusive use of a Bedroom as designated on the signature page to this Lease of each Individual Tenant. The Apartment Unit will generally contain the furnishings, fixtures and other property identified in the Inventory List (the "Inventory List"). Each Individual Tenant agrees that only the Individual Tenant, and his or her immediate family designated on the signature page to this Lease of such Individual Tenant, and as defined in and only in accordance with Real Property Law §235-f ("Authorized Occupant") are permitted residents in the Apartment Unit. If family Residents wish to lease an Apartment Unit together, each adult must sign this Lease as a separate Individual Tenant. A child or children may reside with an Individual Tenant who is his or her parent, a person who has legal custody, or with the written permission of the parent or the person with legal custody, subject to local code occupancy requirements. Each Individual Tenant and Authorized Occupant shall use the Apartment Unit only for residential purposes and shall not permit any other person claiming by or through them the Apartment Unit for any other purpose, other than an occasional daytime visiting guest of such Individual Tenant or Authorized Occupant. Each Individual Tenant and Authorized Occupant shall have access to the Apartment Building, the Apartment Unit and the exclusive use of the Bedroom through physical key tags, as further provided for in this Lease and the House Rules and Regulations.</li>
		<li>Each Individual Tenant's rights to occupy the Apartment Unit and receive the benefits and services of this Lease is also subject to the terms and conditions of the House Rules.</li>
	</ol>

	<p>In order to be allowed to lease and enter into occupancy of the Apartment Unit, each Individual Tenant will be required to execute this Lease, or if in the case of a Lease renewal or change in the designated exclusive use Bedroom, a Lease Amendment. Each Individual Tenant will be parties to this Lease by executing their own signature page with designation of their (i) Lease Execution Date, (ii) Lease Commencement Date, (iii) Lease Termination Date, (iv) Minimum Lease Term, (v) Monthly Rent, (vi) Exclusive Use Bedroom, and (vii) Authorized Occupants.</p>
</li>


<li>
	<h2>LENGTH OF LEASE</h2>

<ol>
	<li>The term (that means the length) of this Lease (the "Term") for each Individual Tenant is designated on their respective signature pages to this Lease. If you do not do everything you, as an Individual Tenant, agree to do in this Lease, Lessor may have the right to end it before the expiration of the Term. If Lessor does not do everything that Lessor agrees to do in this Lease, you may have the right to end your tenancy under the Lease before the expiration of the Term. The Term of tenancy under this Lease is specified on the separate signature page for each Individual Tenant.</li>
	<li>The tenancy of each Individual Tenant under the Term of this Lease will end at the Lease Termination Date specified on the signature page for each respective Individual Tenant.</li>
	<li>For any initial lease term of an Individual Tenant which is less than one hundred eighty (180) days, the Individual Tenant may be subject to and responsible for paying applicable New York City Hotel Room and Occupancy Tax. If the Term of this Lease is less than one hundred eighty (180) days or if this Lease is terminated for any reason resulting in a term of less than one hundred eighty (180) days Tenant may be responsible for the payment of the Hotel Room and Occupancy Tax assessed on the tenancy, subject to applicable law, and shall pay such amount to Landlord prior to the termination of this Lease.</li>
</ol>
</li>

<li>
	<h2>RENT</h2>

<ol>
	<li>Each Individual Tenant's monthly rent for the Apartment Unit is set forth on the signature page for each respective Individual Tenant. Each Individual Tenant must pay Lessor his or her respective rent, in advance, on the first day of each month to 186N6 Owner LLC, at c/o Flatiron, 119 W. 23rd St, #903, NY, NY, or at such other place that Lessor may inform you of by written notice, or through an online payment platform Lessor may make available to Individual Tenant. Each Individual Tenant must pay to Lessor (i) the Security Deposit when such Individual Tenant signs this Lease and books an Apartment Unit, and (ii) the first month's rent not later than the Commencement Date of the Individual Tenant's tenancy under this Lease if the Lease begins on the first day of the month. If the Lease begins not on the first day of the month, such Individual Tenant must pay no later than the Commencement Date full month rent for the first month, while during next consecutive month tenant will pay the pro rata portion of the monthly rent for the period from the Commencement Date of this Lease until the last day of that first partial month. After that, Individual Tenant will pay full month rent every first day of the month. For example if Individual Tenant moves in on the 12th of the month, Individual Tenant pays full first month rent before move in; on the first day of the second month Individual Tenant will pay pro-rata between 12th of the month and last day of the move-in month; on the third month tenant will pay full month rent on the first of the month.</li>
	<li>In terms of all agreed payments under this Lease the deadline will be determined as the date that Lessor receives such payment and not the date of mailing or transmission by the Individual Tenant.</li>
	<li>Each Individual Tenant may pay all rent and additional rent and any other fees and charges under this Lease by check, cash, money order, direct debit withdrawal or credit card. If Individual Tenant elects to pay by check or direct debit withdrawal, Individual Tenant is required to maintain sufficient money in his or her bank account to pay the fees and charges described in this Lease and to inform Lessor promptly of any changes to the account. If Individual Tenant elects to pay by credit card, Individual Tenant is required to inform Lessor promptly of any changes to Individual Tenant's credit card information and must ensure that he or she replaces such credit card and update the relevant information prior to its expiration date. Only a single checking, savings or credit card account may be used at any given time to make payments under this Lease. If payment by check, direct debt withdrawal or credit card fails on two occasions during the term of this Lease, Lessor will have the right to require Individual Tenant to make payments by money order or other certified funds. Changes to Individual Tenant's payment method will not be accepted in the last fifteen (15) calendar days of the calendar month. Each Individual Tenant under this Lease shall make payment separate from each other Individual Tenant under this Lease. Credit card payments shall be subject to the fees imposed by the credit card processor utilized by Lessor, at Tenant’s expense.</li>
	<li>Each Individual Tenant acknowledges and agrees that Lessor and its managing agent have the right to perform credit checks on you and tenant histories on you and your Authorized Occupants before providing occupancy to the Apartment Unit or Services, as defined herein, and occasionally from time-to-time during the Individual Tenant's tenancy under this Lease in Lessor's reasonable discretion, and by entering into this Lease, each Individual Tenant hereby consents to such credit checks and tenant histories and agrees to execute any further and additional consent forms, as required.</li>
</ol>
</li>

<li>
	<h2>SECURITY DEPOSIT</h2>

<ol>
	<li>Each Individual Tenant is required to deposit with Lessor the sum specified in the signature page of such Individual Tenant when such Individual Tenant signs this Lease as a security deposit (the "Security Deposit"), which is called in law a trust. Lessor will deposit this Security Deposit in Bank of America, which is located within the State of New York. If the Apartment Building contains six or more Apartments Units, the bank account holding the Security Deposit will earn interest, as prescribed by the law of the State of New York. Alternatively, Tenant may utilize Hello Rented, who will either hold the security deposit, or provide the alternate form of security as outlined in a separate agreement between Tennant and Hello Rented.</li>
	<li>In the event that your rent increases at the time of Lease renewal, the Lessor may also require an increase in the Security Deposit and you will be required to place additional funds in the Security Deposit. The Security Deposit will be held as security for performance of all your obligations under this Lease and is not intended to be a reserve from which fees, charges, rent and additional rent may be paid. In the event you owe Lessor other fees or charges, in addition to the rent, you may not rely on deducting them from the Security Deposit, but must pay them separately.</li>
	<li>The Security Deposit, and any interest accrued thereon (to the extent applicable), or any balance remaining after deducting outstanding rent, fees and other costs due to Lessor, will be returned to you as an Individual Tenant no later than fourteen (14) calendar days after you as an Individual Tenant have vacated the Apartment Unit following the termination or expiration of this Lease with respect to you as an Individual Tenant, subject to the complete satisfaction of all of your Individual Tenant's obligations under this Lease. In the event that you, as an Individual Tenant, relocate to another Apartment Unit, you will need to post a new Security Deposit and execute a new lease. The Security Deposit is refundable except as otherwise expressly stated in this Lease.</li>
	<li>If you as an Individual Tenant carry out all of your agreements in this Lease and you move out of the Apartment Unit and return it to Lessor along with the furnishings and items provided by Lessor in the same condition it was in when you first occupied it, except for ordinary wear and tear or damage caused by fire or other casualty not the fault of you, Lessor will return to you as an Individual Tenant your Security Deposit and any interest to which you are entitled once Lessor or its managing agent has inspected the Apartment Unit and within fourteen (14) days after the vacancy of the Apartment Unit by you as an Individual Tenant. However, if you do not carry out all your agreements in this Lease, Lessor may keep all or part of your Security Deposit and any interest which has not yet been paid to you necessary to pay Lessor for any losses incurred, including for unpaid rent and damage to the Apartment Unit beyond normal wear and tear and any item in the Inventory List. Notwithstanding the foregoing, if another Individual Tenant is moving out of the Apartment Unit and through Lessor's inspection determines that there is damage to the Apartment Unit or furnishings or items listed in the Inventory List caused by you, Lessor may charge your Security Deposit for the cost of such damage and require you to replenish the Security Deposit to the full Security Deposit amount.</li>
	<li>If Lessor sells and/or assigns this Lease, Lessor will turn over your Security Deposit, with interest, to purchaser or assignee of this Lease. Lessor will then have no further responsibility to you for your Security Deposit. The new lessor will become responsible to you for the Security Deposit.</li>
</ol>
</li>

<li>
<h2>CAPTIONS</h2>

<ol>
	<li>In any dispute arising out of this Lease, in the event of a conflict between the text and a caption, the text controls.</li>
</ol>
</li>

<li>
	<h2>WARRANTY OF HABITABILITY</h2>

<ol>
	<li>All of the sections of this Lease are subject to the provisions of the then applicable Warranty of Habitability Law during this Lease. Nothing in this Lease can be interpreted to mean that you have given up any of your rights under that law which may not be waived or altered by contract. Under that law, Lessor agrees that the Apartment Unit and the Apartment Building are fit for human habitation. Each Individual Tenant, their Authorized Occupants, guests and invitees shall be responsible for the proper and safe use of the Apartment Unit and Apartment Building, including kitchen appliances, bathroom fixtures, and rooftop terrace, and Lessor shall have no liability for injury or damage caused by improper or unsafe use.</li>
	<li>You will cooperate with and do nothing to interfere or make more difficult Lessor's performance of maintenance and repair of the Apartment Building and Apartment Unit or the Lessor's efforts to provide you and all other Individual Tenants and Authorized Occupants of the Apartment Unit and the Apartment Building with facilities and services. Any condition or circumstance caused by your misconduct or the misconduct of anyone under your direction or control shall not be a deemed a breach by Lessor.</li>
</ol>
</li>

<li>
	<h2>CARE OF YOUR APARTMENT UNIT-END OF LEASE-MOVING OUT</h2>

<ol>
	<li>The rental of the Apartment Unit is only for the purpose of residential living. Any other use of the Apartment Unit or Apartment Building, in particular commercial usage, is prohibited.</li>
	<li>During months requiring heating, be sure to lower the Apartment Unit's thermostat to approximately 66 degrees Fahrenheit and in months requiring cooling, be sure to lower the Apartment Unit's thermostat to approximately 78 degrees when you and all other Individual Tenants leave the Apartment Unit for an extended period of time (during vacation, the weekend, or during simple extended absence).</li>
	<li>You will take good care of the Apartment Unit and will not permit or do any damage to it, except for damage which occurs through ordinary wear and tear. You will move out on or before the ending date of this Lease, subject to automatic renewal on a month-to-month basis until terminated in writing as provided for in this Lease, and leave the Apartment Unit in good order and in the same condition as it was when you first occupied it, except for ordinary wear and tear and damaged cause by other Individual Tenants and their Authorized Occupants.</li>
	<li>When this Lease ends, you must remove all of your movable property. You must also remove at your own expense, any wall covering, bookcases, cabinets, mirrors, painted murals or any other installation or attachment you may have installed in the Apartment Unit even if it was done with Lessor's consent. You must restore and repair to its original condition any and all furnishing and items listed in the Inventory List as well as those portions of the Apartment Unit affected by the installations and removals referenced above. You have not moved out until you, as the Individual Tenant, and your Authorized Occupants, if any, your and their furniture and other property is also out of the Apartment Unit. If your property remains in the Apartment Unit after the Lease ends, Lessor may either treat you as still in occupancy and charge you for use, or may consider that you have given up the Apartment Unit and any property remaining in the Apartment Unit. In this event, Lessor may either discard the property or store it are your expense as further provided in subparagraph 7.9 below. You agree to pay Lessor for all costs and expenses incurred in removing such property. The provisions of this article will continue to be in effect after the end of this Lease.</li>
	<li>You shall take good care of the Apartment Unit and the fixtures and appurtenances therein and preserve the Apartment Unit in good working order and condition, reasonable wear and tear, obsolescence and damage from the elements, fire or other casualty, excepted. All damage or injury to the Apartment Unit or to any other part of the Apartment Building, or to its fixtures, equipment and appurtenances caused by or resulting from the negligent acts or omissions of you, your Authorized Occupants, guests or invitees, shall be promptly repaired by you in a first class and workmanlike manner, failing which such repairs may be made by Lessor at your sole cost and expense. You shall repair all damage to the Apartment Unit and the Apartment Building caused by the moving of your fixtures, furniture or equipment. All the aforesaid repairs shall be of the quality and class equal to the original work or construction.</li>
	<li>Individual Tenants are individually responsible for any damage caused to the Apartment Unit, the Apartment Building and/or its furnishings or facilities and shall be charged for any such damage unless specific liability is determined to lie with another Individual Tenant or is assumed by the person(s) responsible. Furthermore, each Individual Tenant shall reimburse Lessor for all damages and expenses that Lessor may suffer or incur for repair to any Apartment Building common area or public space, or any other furnishings or facilities of the Apartment Building, caused by any Individual Tenant's misconduct or neglect, or by the misconduct or neglect of the guests or visitors of any Individual Tenants, unless specific liability is determined to lie with another Individual Tenant or is assumed by the person(s) responsible.</li>
	<li>You must vacate and surrender the Apartment Unit, remove all of your belongings and return all key tags or cards, and complete any other steps required by Lessor (collectively, the "Vacate Procedures") on or before 11:00 a.m. in the Apartment Building's time zone on the last day of the Term (and immediately upon effectiveness of the cancellation or termination of this Lease) ("Exit Date"). If you do not complete the Vacate Procedures by the Exit Date, Lessor and its managing agent reserve all rights to take any legal action to remove you from the Apartment Unit and the Apartment Building. Any Individual Tenant who fails to timely vacate, will be responsible for all costs and direct or indirect damages suffered by Lessor in connection with such Individual Tenant's failure to vacate the Apartment Unit and the Apartment Building by the Exit Date, including the cost of accommodations for each person who would otherwise have occupied the Apartment Unit and all legal and other expenses incurred by Lessor and its managing agent in connection with removing such Individual Tenant or his or her guests, visitors or invitees from the Apartment Unit and Apartment Building.</li>
	<li>If you enter into this Lease but never occupy the Apartment Unit, or you vacate the Apartment Unit without returning the key tags or cards to the Lessor or its managing agent, your obligations under this Lease, this Lease will remain effective, and you will continue to be responsible for all rents, fees and other charges due under or as a consequence of this Lease until this Lease is effectively terminated or otherwise in accordance with the terms and conditions herein.</li>
	<li>Upon the termination or expiration of this Lease, you will remove all of your and your guests' or visitors' property from the Apartment Unit and the Apartment Building, and leave the apartment clean, including any linens provided. After providing you with reasonable notice if Lessor has received from you your forwarding address and/or contact information, we will be entitled to dispose of any property remaining in the Apartment Unit or Apartment Building after the termination or expiration of this Lease, without any obligation to store such property, and you waive any claims or demands regarding such property or our handling of such property. Following the termination or expiration of this Lease, we will not forward or hold mail or other packages delivered to us.</li>
</ol>
<p><strong>In the event that we are required to commence legal proceedings to remove any Individual Tenant from the Apartment Unit, legal proceedings will be commenced only against the defaulting Individual Tenant without terminating this Lease with respect to other non-defaulting Individual Tenants.</strong></p>

</li>

<li>
	<h2>CHANGES AND ALTERATIONS TO APARTMENT</h2>

<ol>
	<li>You cannot build in, add to, change or alter, the Apartment Unit in any way without getting Lessor's written consent before you do anything. Without Lessor's prior written consent, you cannot install or use in the Apartment Unit any of the following which has not been installed and provided by the Lessor: dishwasher machines, clothes washing or drying machines, electric stoves, microwaves, garbage disposal units, heating, ventilating or air conditioning units or any other electrical equipment which, in Lessor's reasonable opinion, will overload the existing wiring installation in the Apartment Building or interfere with the use of such electrical wiring facilities by other tenants of the Apartment Building. Also, you cannot place in the Apartment Unit water-filled furniture. If permitted, all alterations shall be required to conform with all New York City codes, regulations and ordinances.</li>
	<li>Decoration and design must be limited to only minor cosmetic changes, which can readily be removed without causing any damage or lasting residue to the Apartment Unit. Any modifications which require the use of tools, including marking, painting, drilling, defacing, and/or will cause any damage to the Apartment Unit are expressly prohibited.</li>
	<li>You are strictly prohibited from attaching pictures, shelves etc. in the Apartment Unit with nails, screws or screw anchors. Posting signs or inscriptions of any sort within the Apartment Unit or the Apartment Building or on the Apartment Unit's windows is prohibited. Attaching personalized signs, warnings, etc. is only allowed by the prior express written consent of the Lessor, which consent may be withheld in Lessor's sole discretion.</li>
	<li>You may not remove or alter any of the furnishings, fixtures, appliances and locks provided by Lessor or add any furnishing, fixtures, appliances or locks that are not provided by Lessor, without Lessor's express prior written consent.</li>
	<li>You may not install an individual telephone system. Lessor will make a readily accessible W-LAN system available to you.</li>
</ol>
</li>


<li>
	<h2>YOUR DUTY TO OBEY AND COMPLY WITH LAWS, REGULATIONS AND LEASE RULES</h2>

<ol>
	<li>Government Laws and Orders. You will obey and comply (1) with all present and future city, state and federal laws and regulations which affect the Apartment Unit and the Apartment Building, and (2) with all orders and regulations of Insurance Rating Organizations which affect the Apartment Unit and the Apartment Building. You will not clean or allow to be cleaned any windows in the Apartment Unit from the outside, unless such windows are safely accessible from an adjoining balcony or terrace or unless the equipment and safety devices required by law are used. Each Individual Tenant must act in accordance with the laws concerning the use of the internet and carries all responsibility for his or her actions. The use of illegal websites and/or illegal downloads is prohibited and can lead to prosecution. In the event of such actions, the Lessor will give the authorities all necessary data concerning applicable Individual Tenant or Authorized Occupant as the law requires.</li>
	<li>Lessor's Rules Affecting You. You will obey all Lessor's rules listed in this Lease, including the House Rules and Regulations, and all future reasonable rules of Lessor and Lessor's managing agent. Notice of all additional rules shall be delivered to each Individual Tenant in writing or posted in the lobby or other public place in the Apartment Building. Lessor shall not be responsible to any Individual Tenant for not enforcing any rules, regulations or provisions of another Individual Tenant's Lease except to the extent required by law.</li>
	<li>Your Responsibility. You are responsible for the behavior of yourself, and your Authorized Occupants, immediate family, your guests and invitees. You will reimburse Lessor as additional rent upon demand for the cost of all losses, damages, fines and reasonable legal expenses incurred by Lessor because you, your Authorized Occupants, Residents of your immediate family, your guests and invitees have not obeyed government laws and orders or rules and regulations of this Lease. Each Individual Tenant shall be held for any such damages, but not for the damages cause by unrelated Individual Tenants. Each Individual Tenant may refer to the Fee Catalogue (the "Fee Catalogue") which contains the fees that will be charged to Individual Tenants for damage or theft.</li>
</ol>
</li>

<li>
	<h2>OBJECTIONABLE CONDUCT</h2>

<ol>
	<li>As an Individual Tenant in the Apartment Building, you will not engage in or permit your Authorized Occupants, guests and invitees to engage in objectionable conduct. Objectionable conduct means behavior which makes or will make the Apartment Unit or the Apartment Building less fit to live in for you or other Individual Tenants and Authorized Occupants. It also means anything which interferes with the right of others to properly, safely and peacefully enjoy their Apartment Units or common areas of the Apartment Building, or causes conditions that are dangerous, hazardous, unsanitary and detrimental to other Individual Tenants and Authorized Occupants in the Apartment Building. Objectionable conduct by you gives Lessor the right to end your tenancy under this Lease. Each Individual Tenant will be liable for any harm he or she may cause to the person or property of another Individual Tenant, their Authorized Occupants, guests and invitees.</li>
	<li>Individual Tenants who engage in conduct designed or intended to dissuade or intimidate other Individual Tenants or their Authorized Occupants from moving into an Apartment Unit or who otherwise attempt to manipulate the housing assignment process may be subject to judicial action and termination of their tenancy under this Lease, plus the consequential damages to Owner of same.</li>
</ol>
</li>


<li>
	<h2>SERVICES AND FACILITIES</h2>

<ol>
	<li>Required Services. Lessor will provide heat and air conditioning as required by law, and shall make and/or have repairs made to the Apartment Unit. You are not entitled to any rent reduction because of a stoppage or reduction of any of the services or facilities provided for herein unless such reduction is required by law or court order.</li>
	<li>Other Utilities. Lessor will provide electric, gas (if applicable), water and WiFi for the Apartment Unit as part of the monthly Rent, which shall be reimbursed at the rate of $149 per month. Tenant does not need to arrange for utility service directly with the appropriate utility company or pay a separate charge for these utilities. Lessor does not provide any land-based telephone service, equipment or system.</li>
	<li>Appliances. Appliances (including but not limited to refrigerator, stove, oven, microwave, and toaster) located in the Apartment Unit as of the date hereof which have been supplied by Lessor in the Apartment, if any, are for your use, and the use by other Individual Tenants and Authorized Occupants of the Apartment Unit.</li>
	<li>Other Items. Additional items provided by Lessor for the Apartment Unit are listed in the Inventory List and shall be of the quality and in the quantity typically provided to other Individual Tenants in the same Apartment Building in a similar Apartment Unit. Lessor does not provide towels for the Apartment Unit, and each Individual Tenant shall provide for their own towels and those of his or her Authorized Occupants. The Inventory List may have certain items listed that may be absent from certain units, and Tenant acknowledges that some units may not have sofas or televisions in the common area of the Unit.</li>
	<li>Amenities and Service Fees. Additional fees which are charged for certain services or use of certain facilities and/or amenities are subject to increase from time-to-time effective on no less than fifteen (15) calendar days prior to the date on which such increase will take effect.</li>
</ol>
</li>

<li>
	<h2>INABILITY TO PROVIDE SERVICES</h2>
<p>Because of a strike, labor, national or local emergency, repairs, or any other cause beyond Lessor's reasonable control, Lessor may not be able to provide or may be delayed in providing any services or in making any repairs to the Apartment Unit or the Apartment Building. In any of these events, any rights you may have against Lessor are only those rights which are allowed by laws in effect when the reduction in service occurs.</p>
</li>

<li>
	<h2>ENTRY TO APARTMENT</h2>
<p>During reasonable hours and with reasonable notice, except in emergencies, Lessor, its managing agent and/or the Apartment Building's owner, if different from Lessor, may enter the Apartment Unit for the following reasons:</p>
<ol>
	<li>To erect, use and maintain pipes and conduits in and through the walls and ceilings of the Apartment Unit; to inspect the Apartment Unit and to make any necessary repairs or changes Lessor, its managing agent and/or the Apartment Building's owner, if different from Lessor, decides are necessary. Your rent will not be reduced because of any of this work, unless required by law;</li>
	<li>To show the Apartment Unit to persons who may wish to become lessors of the unit or owners or lessees of the entire Apartment Building or may be interested in lending money to Lessor or the Apartment Building's owner, if different from Lessor;</li>
	<li>Reasonable hours shall include, but are not limited to, weekdays 9:00 a.m. - 8:00 p.m., and weekends and holidays 10:00 a.m. - 7:00 p.m. Except in the case of an emergency in which no advance notice shall be required, notice of not less than 24 hours should constitute reasonable notice. Tenant shall be liable for any and all damages arising from a breach hereof, including loss of rentals profit, damages and attorneys' fees;</li>
	<li>If during the last month of the Lease you have moved out and removed all or almost all of your property from the Apartment Unit, Lessor may enter to make changes, repairs, or redecorations. Your rent will not be reduced for that month and this Lease will not be ended by Lessor's entry;</li>
	<li>If at any time you are not personally present to permit Lessor or Lessor's representative to enter the Apartment Unit and entry is necessary or allowed by law or under this Lease, Lessor or Lessor's representatives may nevertheless enter the Apartment Unit. Lessor may enter by force in an emergency. Lessor will not be responsible to you, unless during this entry, Lessor or Lessor's representative is negligent or misuses your property.</li>
</ol>
</li>


<li>
	<h2>ASSIGNING; SUBLETTING; ABANDONMENT</h2>

<p><strong>Assigning and Subletting.</strong> Without Lessor's advance written consent, which may be given or withheld for any reason, you will not mortgage or pledge this Lease or let anyone use or live in the Apartment Unit other than the Individual Tenant and your Authorized Occupants, if any. If Lessor unreasonably refuses to consent to an assignment or subletting requested in writing by you in the manner required by law (Real Property Law section 226-b), then you may continue as an Individual Tenant, sublet, or assign this Lease, but only to another person that has signed a Lease, or at your request in writing, Lessor will end this Lease and release you from further liability. The first and every other time you wish to assign your Lease, sublet the Apartment Unit or permit anyone else to use it, you must get the written consent of Lessor. Lessor may impose a service charge on you in connection with any approved assignment or subletting. Lessor may collect rent from the assignee, subtenant or occupant if you fail to pay your rent. Lessor will credit the amount collected against the rent due from you. However, Lessor's acceptance of such rent does not change the status of the assignee, subtenant or occupant if you fail to pay your rent. Lessor will credit the amount collected against the rent due from you. However, Lessor's acceptance of such rent does not change the status of the assignee, subtenant or occupant to that of direct tenant of Lessor and does not release you from this Lease.</p>

<ol>
	<li>
		<p>These steps must be followed by Individual Tenants wishing to sublet:</p>
		<ol>
			<li>The Individual Tenant must send a written request to the Lessor by certified mail, return receipt requested. The request must contain the following information: (a) the length of the sublease; (b) the name, home and business address of the proposed subtenant; (c) the reason for subletting; (d) the tenant's address during the sublet; (e) the written consent of any co-tenant or guarantor; (f) a copy of the proposed sublease together with a copy of the tenant's own lease, if available, (g) evidence reasonably satisfactory to Lessor that subtenant has passed a criminal background check and financial credit review equivalent to Lessor's requirements for Individual Tenants.</li>
			<li>Within ten (10) days after the mailing of this request, the Lessor may ask the Individual Tenant for additional information to help make a decision. Any request for additional information may not be unduly burdensome.</li>
			<li>Within thirty (30) days after the mailing of the Individual Tenant's request to sublet or the additional information requested by the Lessor, whichever is later, the Lessor must send the Individual Tenant a notice of consent, or if consent is denied, the reasons for denial. Lessor's failure to send this written notice is considered a consent to sublet.</li>
		</ol>
	</li>
	<li><strong>Abandonment.</strong> If you move out of the Apartment Unit (abandonment) before the end of this Lease without the consent of Lessor, this Lease will not be ended (except as provided by law following Lessor's unreasonable refusal to consent to an assignment or subletting requested by you). You will remain responsible for each monthly payment of rent as it becomes due until the end of this Lease. In case of abandonment, your responsibility for rent will end only if Lessor chooses to end this Lease for default as provided in Article 15. In the case of abandonment, Lessor may reenter and retake possession of the Apartment Unit without any court proceedings and re-rent the Apartment Unit without freeing Individual Tenant from Individual Tenant's debts and duties assumed in signing this Lease. Lessor, at Lessor's election, may bring an action or proceeding to collect all of the rent due and owing.</li>
</ol>
</li>

<li>
	<h2>DEFAULT</h2>

<ol>
	<li>
		<p><strong>Tenant Default.</strong> Upon the occurrence of any one or more of the following events, You will be in default under this Lease and Lessor shall be entitled to exercise any of the remedies provided in this Lease or otherwise available at law or equity as a result of such default:</p>
		<ol>
			<li>You fail to carry out any agreement or provision of this Lease;</li>
			<li>if the Apartment shall be used or occupied by any person other than permitted under Article 1 and Article 10</li>
			<li>You or one of your Authorized Occupants of the Apartment Unit behaves in an objectionable manner;</li>
			<li>You do not take possession or move into the Apartment Unit within fifteen (15) days after the beginning of the Lease;</li>
			<li>You and your Authorized Occupants of the Apartment Unit move out permanently before the Lease ends;</li>
			<li>You fail to follow the House Rules.</li>
		</ol>
	</li>
	<li>If you do default in any one of these ways, other than a default in the agreement to pay rent and/or maintain the Apartment Unit as your primary or secondary residence, Lessor may serve you with a written notice to stop or correct the specified default within ten (10) days. You must then either stop or correct the default within ten (10) days, or, if you need more than ten (10) days, you must begin to correct the default within ten (10) days, and continue to do all that is necessary to correct the default as soon as possible.</li>
	<li>If you do not stop or correct the default within ten (10) days, Lessor may give you a second written notice that this Lease will end six (6) days after the date of the second written notice is sent to you. At the end of this six (6) day period, this Lease will end. You must then move out of the Apartment Unit. Even though this Lease ends, you will remain liable to Lessor for unpaid rent up to the end of this Lease, the value for your occupancy, if any, after the Lease ends, and damages caused to the Lessor, including the fees for damage and theft described in the Fee Catalogue</li>
	<li>If you do not pay your rent when this Lease requires after a personal demand for the rent has been made, or within five (5) days after a statutory written demand for the rent has been made, or if the Lease ends, the Lessor may do the following: (a) enter the Apartment Unit, including your exclusive use Bedroom, and re-take possession of it if you have moved out; or (b) go to court and ask that you and all other occupants in the Apartment Unit claiming by or through you be compelled to move out.</li>
	<li>Once your tenancy under this Lease has been ended, whether because of default or otherwise, you give up any right you might have to reinstate or renew your tenancy under this Lease.</li>
</ol>
</li>

<li>
	<h2>REMEDIES OF LESSOR AND YOUR LIABILITY</h2>

<ol>
	<li>
		<p>If this Lease is ended by Lessor because of your default, the following are the rights and obligations of you, as an Individual Tenant, and the Lessor:</p>
		<ol>
			<li>You must pay your rent until this Lease is ended. Thereafter, you must pay an equal amount for what the law calls "use and occupancy" until you actually move out of the Apartment Unit and the Apartment Building.</li>
			<li>Once you are out, Lessor may re-rent the Apartment Unit, including your exclusive use Bedroom, which may end before or after the ending of this Lease. Lessor may re-rent to a new tenant at a lesser rent or may charge a higher rent than the rent in this Lease.</li>
		</ol>
	</li>
	<li>
		<p>Whether the Apartment Unit is re-rented or not, you must pay to Lessor as damages:</p>
		<ol>
			<li>the difference between the rent in this Lease and the amount, if any, of the rents collected in any later Lease or Leases of the Apartment Unit which, includes your exclusive use Bedroom, for what would have been the remaining period of this Lease; and</li>
			<li>Lessor's expenses for attorney's fees, advertisements, broker's fees and the cost of putting the Apartment Unit in good condition for re-rental.</li>
		</ol>
	</li>
	<li>You shall pay all damages due in monthly installments on the rent day established in this Lease. Any legal action brought to collect one or more monthly installments of damages shall not prejudice in any way Lessor's right to collect the damages for a later month by a similar action. Each Individual Tenant shall be held liable for any such damages it has caused or permitted to be caused. If the rent collected by Lessor from a subsequent tenant of the Apartment Unit is more than the unpaid rent and damages which you owe Lessor, you cannot receive the difference. Lessor's failure to re-rent to another tenant will not release or change your liability for damages, unless the failure is due to Lessor's deliberate inaction.</li>
	<li>Individual Tenant agrees that any violation of the provisions of this Lease shall be deemed a material violation of a substantial obligation of this Lease and shall entitle the Lessor to terminate this Lease.</li>
	<li>To the extent that this Lease provides Lessor the right to seek to recover attorney's fees if a lawsuit arises under this Lease, Individual Tenant has a reciprocal right to seek to recover attorney's fees as provided for in New York Real Property Law §234.</li>
</ol>
</li>

<li>
	<h2>ADDITIONAL LESSOR REMEDIES</h2>

<p>If you do not do everything you have agreed to do, or if you do anything which shows that you intend not to do what you have agreed to do, Lessor has the right to ask a Court to make you carry our your obligations under this Lease or to give the Lessor such other relief as the Court can provide. This is in addition to the remedies in Article 16 and 18 of this Lease.</p>
</li>

<li>
	<h2>FEES AND EXPENSES</h2>

<ol>
	<li>
		<p><strong>Lessor's Right.</strong> You must reimburse Lessor for any of the following fees and expenses incurred by Lessor:</p>
		<ol>
			<li>Making any repairs to the Apartment Unit or the Apartment Building which result from misuse or negligence by you, your Authorized Occupants or your guests or invitees;</li>
			<li>Repairing or replacing any appliance and/or any items identified on the Inventory List which are damaged by your misuse or negligence, including damage through misuse or negligence of the rooftop and common areas and facilities of the Apartment Building;</li>
			<li>Correcting any violations of city, state, or federal laws or orders and regulations of insurance rating organizations concerning the Apartment Unit or the Apartment Building which you, your Authorized Occupants or guests or invitees have caused;</li>
			<li>Any legal fees and disbursements for legal actions or proceedings brought by Lessor against you because of a Lease default by you, your Authorized Occupants or guests or invitees or for defending lawsuits brought against Lessor because of your or their actions;</li>
			<li>Removing all of your property after this Lease is ended;</li>
			<li>All other fees and expenses incurred by Lessor because of your failure, and the failure of your Authorized Occupants, guests and invitees, to obey any other provisions and agreements of this Lease and the Agreement, including but not limited to violations of the House Rules and Regulations attached to this Lease;</li>
			<li>These fees and expenses shall be paid by you to Lessor as additional rent within thirty (30) days after you receive Lessor's bill or statement. If this Lease has ended when these fees and expenses are incurred, you will still be liable to Lessor for the same amount as damages.</li>
		</ol>
	</li>
	<li><strong>Tenant's Right.</strong> Lessor agrees that you have the right to collect reasonable legal fees and expenses incurred in a successful defense by you of a lawsuit brought by Lessor against you or brought by you against Lessor to the extent provided by Real Property Law, §234.</li>
</ol>
</li>

<li>
	<h2>PROPERTY LOSS, DAMAGES, OR INCONVENIENCE</h2>

<ol>
	<li>Unless caused by the negligence or misconduct of Lessor or Lessor's agents or employees, Lessor or Lessor's agents and employees are not responsible to you for any of the following: (1) any loss or damage to you or your property in the Apartment Unit or the Apartment Building due to any accidental or intentional cause, even a theft or another crime committed in the Apartment Unit or elsewhere in the Apartment Building; (2) any loss of or damage to your property delivered to any employee of the Apartment Building (i.e., doorman, superintendent, etc.); or (3) any damage or inconvenience caused to you by actions, negligence or violations of a Lease by any other tenant or person in the Apartment Building except to the extent required by law.</li>
	<li>Lessor will not be liable for any temporary interference with light, ventilation, or view caused by construction by or in behalf of Lessor. Lessor will not be liable for any such interference on a permanent basis caused by construction on any parcel of land not owned by Lessor. Also, Lessor will not be liable to you for such interference on a permanent basis caused by construction on any parcel of land not owned by Lessor. Also, Lessor will not be liable to you for such interference caused by the permanent closing, darkening or blocking up of windows, if such action is required by law. None of the foregoing events will cause a suspension or reduction of the rent or allow you to cancel the Lease.</li>
	<li>Lessor assumes no responsibility for any of your personal property while you use the Apartment Unit and the Apartment Building. You are responsible for maintaining personal property and liability insurance covering you, your Authorized Occupants, guests and invitees and you will provide proof of insurance to Lessor upon our request.</li>
</ol>
</li>

<li>
	<h2>FIRE OR CASUALTY</h2>

<ol>
	<li><strong>YOU MUST IMMEDIATELY NOTIFY THE LESSOR IN WRITING IN THE EVENT THERE IS ANY DAMAGE TO THE APARTMENT UNIT OR THE APARTMENT BUILDING BECAUSE OF FIRE, ACCIDENT OR OTHER CASUALTY.</strong></li>
	<li>If the Apartment Unit becomes unusable, in part or totally, because of fire, accident or other casualty, this Lease will continue unless ended by Lessor under subsection 20.4 below or by you under subsection 20.5 below. But the rent will be reduced immediately. This reduction will be based upon the part of the Apartment Unit which is unusable.</li>
	<li>Lessor will repair and restore the Apartment Unit, unless Lessor decides to take actions described in subsection 20.4 below.</li>
	<li>After a fire, accident or other casualty in the Apartment Building, the owner may decide to tear down the Apartment Building or to substantially rebuild it. In such case, Lessor and/or owner need not restore the Apartment Building but may end this Lease. Lessor may do this even if the Apartment Unit has not been damaged, by giving you written notice of this decision within thirty (30) days after the date when the damage occurred. If the Apartment Unit is usable when Lessor gives you such notice, this Lease will end sixty (60) days from the last day of the calendar month in which you were given the notice.</li>
	<li>If the Apartment Unit is completely unusable because of fire, accident or other casualty and it is not repaired within thirty (30) days, You may give Lessor written notice that you end the Lease. If you give that notice, this Lease is considered ended on the day that the fire, accident or casualty occurred. Lessor will refund your Security Deposit and the pro-rate portion of rents paid for the month in which the casualty happened.</li>
	<li>Unless prohibited by the applicable insurance policies, to the extent that such insurance is collected, you and Lessor release and waive all right of recovery against the other or anyone claiming through or under each by way subrogation.</li>
</ol>
</li>

<li>
	<h2>PUBLIC TAKING</h2>

<p>The entire Apartment Building or a part of it can be acquired (condemned) by any government or government agency for a public or quasi-public use or purpose. If this happens, this Lease shall end on the date the government or agency take title. You shall have no claim against Lessor for any damage resulting. You also agree that by signing this Lease, you assign to Lessor any claim against the government or government agency for the value of the unexpired portion of this Lease.</p>
</li>


<li>
	<h2>SUBORDINATION CERTIFICATE AND ACKNOWLEDGEMENTS</h2>

<ol>
	<li>All leases and mortgages of the Apartment Building or of the land on which the Apartment Building is located, now in effect or made after this Lease is signed, come ahead of this Lease. In other words, this Lease is "subject and subordinate to" any existing or future lease or mortgage on the Apartment Building or land, including any renewals, consolidations, modifications and the replacements of these leases or mortgages. If certain provisions of any of these leases or mortgages come into effect, the holder of such lease or mortgage can end this Lease. If this happens, you agree that you have no claim against Lessor or such lease or mortgage holder. If Lessor requests, you will sign promptly an acknowledgement of the "'subordination" in the form that Lessor requires.</li>
	<li>You also agree to sign (if accurate) a written acknowledgement to any third party designated by Lessor that this Lease is in effect, that Lessor is performing Lessor's obligations under this Lease and that you have no present claim against Lessor.</li>
</ol>
</li>

<li>
	<h2>TENANT'S RIGHT TO LIVE IN AND USE THE APARTMENT UNIT</h2>

<ol>
	<li>If you pay the rent and any required additional rent on time and you do everything you have agreed to do in this Lease, your tenancy cannot be cut off before the ending date, except as provided for herein. You will no longer be allowed to occupy the Apartment Unit and/or receive the services under this Lease upon the earlier of (i) the termination or expiration of this Lease, subject to automatic extension of the tenancy under this Lease on a month-to-month basis until terminated in writing by either Lessor or Individual Tenant by no less than a thirty (30) day prior writing notice to the other with termination occurring on the last day of the next full calendar month following issuance and receipt of the written termination notice, or (iii) our notification to you that you will be removed from the Apartment Unit under the terms and conditions of this Lease.</li>
	<li>The rights given to you under this Lease to access and share with us the use of the Apartment Unit for the Term is so that you may be provided with the Services as referenced in this Lease. The parties to this Lease shall each be independent contractors in the performance of their obligations under this Lease, and this Lease shall not be deemed to create a fiduciary or agency relationship, or partnership or joint venture, for any purpose, other than is required by law. Neither party will in any way misrepresent our relationship.</li>
	<li>Only individuals who are parties to a Lease may be allowed to occupy an Apartment Unit. Individual Tenants may be added to or removed from the Apartment Unit under and in accordance with the procedures set forth in this Lease. </li>
</ol>
</li>

<li>
	<h2>BILLS AND NOTICE</h2>

<ol>
	<li><strong>Notices to You.</strong> Any notice from Lessor or Lessor's managing agent or attorney will be considered properly given to you if it (1) is in writing; (2) is signed by or in name of Lessor or Lessor's managing agent or attorney; and (3) is addressed to you at the Apartment Unit and delivered to you personally or sent by registered or certified mail to you at the Apartment Unit. In the event that we receive multiple notices from different Individual Tenants containing inconsistent instructions, we will decide in our reasonable discretion which notice will control. Any and all notices due or to be provided under the Lease are subject to the notice requirements contained therein.</li>
	<li><strong>Notices to Lessor.</strong> If you wish to give a notice to Lessor, you must write it and deliver it or send it by registered or certified mail to Lessor at the address noted on page 1 of this Lease or at another address of which Lessor or its managing agent has given you written notice. We will send notices to you which impact or relate to your tenancy under this Lease, and we may send notices to other Individual Tenants, without providing you notice, if such notice does not impact or relate to your tenancy under this Lease, as we determine in our reasonable discretion.</li>
</ol>
</li>

<li>
	<h2>GIVING UP RIGHT TO TRIAL BY JURY AND COUNTERCLAIM</h2>

<ol>
	<li>Both you and Lessor agree to give up the right to a trial by jury in a court action, proceeding or counterclaim on any matters concerning this Lease, the relationship of you and Lessor as an Individual Tenant and Landlord or your use or occupancy of the Apartment Unit. This agreement to give up the right to a jury trial does not include claims for personal injury or property damage.</li>
	<li>If Lessor begins any court action or proceeding against you which asks that you be compelled to move out, you cannot make a counterclaim unless you are claiming that Lessor has not done what Lessor is supposed to do about the condition of the Apartment Unit or the Apartment Building.</li>
</ol>
</li>

<li>
	<h2>NO WAIVER OF LEASE PROVISIONS</h2>

<p><strong>Even if Lessor accepts your rent or fails once or more often to take action against you when you have not done what you have agreed to do in this Lease, the failure of Lessor to take action or Lessor's acceptance of rent does not prevent Lessor from taking action at a later date if you again do not do what you have agreed to do.</strong></p>

<ol>
	<li>Only a written agreement between you and Lessor can waive any violation of this Lease.</li>
	<li>If you pay and Lessor accepts an amount less than all the rent due, the amount received shall be considered to be in payment of all or part of the earliest rent due. It will not be considered an agreement by Lessor to accept this lesser amount in full satisfaction of all of the rent due.</li>
	<li>Any agreement to end this Lease and also to end the rights and obligations or you and Lessor must be in writing, signed by you and Lessor or Lessor's managing agent. Even if you return your keys to the Apartment Unit and they are accepted by Lessor or any employee or managing agent of Lessor, this Lease is not ended.</li>
</ol>
</li>

<li>
<h2>CONDITION OF THE APARTMENT</h2>

<ol>
	<li>When you signed this Lease, you did not rely on anything said by Lessor, Lessor's managing agent or superintendent about the physical condition of the Apartment Unit, the Apartment Building or the land on which it is built. You did not rely on any promises as to what would be done, unless what was said or promised is written in this Lease and signed by both you and Lessor.</li>
	<li>You shall maintain the Apartment Unit in a clean, safe, and undamaged condition at all times. You shall be jointly responsible for cleaning and maintaining any kitchens, bathrooms, or other common areas of the Apartment Unit with the other Individual Tenants of the Apartment Unit. You shall not alter the Apartment Unit or any of its facilities or any furnishings in the Apartment Unit or any facilities in other portions of the Apartment Building in any way without our prior written consent, which consent may be withheld in our sole discretion, with or without cause or explanation.</li>
</ol>
</li>

<li>
	<h2>DEFINITIONS</h2>
<ol>
	<li><strong>Lessor.</strong> The term "Lessor" means the person or organization receiving or entitled to receive rent from you for the Apartment Unit at any particular time other than a rent collector or managing agent of Lessor. "Lessor" includes the Lessor of the land or Apartment Building, a lessor, or sublessor of the land or Apartment Building and a mortgagee in possession. It does not include a former owner or Lessor, even if the former Lessor signed this Lease.</li>
	<li><strong>Individual Tenant.</strong> The term "Individual Tenant" and the term "you" means the person or persons signing this Lease as an Individual Tenant and the successors and assigns of the signer. This Lease has established a Tenant-Lessor relationship between you and Lessor.</li>
</ol>
</li>

<li>
	<h2>SUCCESOR INTERESTS</h2>
<p>The agreements in this Lease shall be binding on Lessor and each Individual Tenant and on those who succeed to the interest of Lessor or each such Individual Tenant by law, by approved assignment or by transfer.</p>
</li>

<li>
	<h2>INABILITY AND INDEMNITY</h2>

<p>This Lease is made upon the express condition that, except to the extent caused by the negligence of Lessor or Lessor's employees or agents, the Lessor shall be free from all liabilities and claims for damages and/or suits for or by reason of any injury or injuries to any person or persons or property of any kind whatsoever, whether the person or property of Individual Tenant, his or her Authorized Occupants, guests or invitees, from any cause whatsoever while in or upon the subject premises or any part thereof during the Terms or occasioned by any occupancy or use of said premises or any activity carried on by Individual Tenant, his or her Authorized Occupants, guest or invitees, in connection therewith and Individual Tenant hereby agrees to indemnify and hold the Lessor harmless from any liabilities, damages, loss, causes of action, charges, expenses (including counsel fees) and costs on account of or by reason of any such injuries, liabilities, claims, suits or losses however occurring or damages growing out of same.</p>
</li>


<li>
	<h2>INSURANCE</h2>

<p>Lessor shall not be liable for damage or loss of Individual Tenant's personal property (i.e., furniture, jewelry, clothing, etc.) or those of Individual Tenant's Authorized Occupants, guests and invitees, from the occurrences set forth in this Lease or other causes whatsoever unless due to the Lessor, its managing agent or employee's negligence. Individual Tenant agrees to obtain and retain, at Individual Tenant's sole cost and expense, for the term of this Lease and any extensions or renewal's thereof, "Renter's" liability insurance with a minimum coverage of USD 100,000.00 per occurrence for bodily or personal injury and list Lessor as an additional insured under such policy. Individual Tenant's failure to obtain and maintain such insurance shall constitute an event of default under the Lease availing the Lessor of its rights and remedies provided in this Lease. It is recommended that Individual Tenant, at Individual Tenant's sole cost and expense, obtain and retain minimum contents insurance of USD 50,000.00 per occurrence for property damage and loss. Individual Tenant shall pay for damages suffered by and reasonable expenses of Lessor relating to any claim arising from any act or negligence committed by Tenant. As a condition of this Lease, Individual Tenant must supply proof of insurance required hereunder prior to the Commencement Date and prior to any renewal hereof; additionally Tenant shall supply proof of such insurance to the Lessor at any time during the Term of this Lease within thirty (30) days following request by Lessor.</p>
</li>

<li>
	<h2>LIABILITY</h2>

<ol>
	<li>Except to the extent caused by the negligence of Lessor or Lessor's employees or agents, Lessor shall not be liable for damage occasioned by or from plumbing, gas, water, sprinklers, steam or other pipes or sewage or the bursting, leaking or running of any pipes, tanks or plumbing fixtures, in, above, upon or about the Apartment Unit or Apartment</li>
	<li>Building, nor for any damage occasioned by water, snow or ice being upon or coming through the roof, windows or otherwise, nor for and damage arising from the acts, or neglect of other Individual Tenants, their Authorized Occupants, guest and invitees or other occupants of the Apartment Unit or the Apartment Building or of any owners, or occupants of adjacent or contiguous apartments.</li>
	<li>Except to the extent caused by the negligence of Lessor or Lessor's employees or agents, Lessor shall not be liable for damage or loss of Individual Tenant's or his or her Authorized Occupants', guests' or invitees' personal property (furniture, jewelry, clothing, etc.) from theft, water, fire, vandalism, rains, storms, smoke, exposures, sonic booms or other causes whatsoever.</li>
	<li>Except to the extent caused by the negligence of Lessor or Lessor's employees or agents, each Individual Tenant, and their Authorized Occupants, guests and invitees assumes all risk of personal injury to themselves and to others, in their use and occupancy of the Apartment Unit and any other portions of the Apartment Building.</li>
	<li>You must pay for damages suffered by and reasonable expenses of Lessor relating to any claim or arising from any act or neglect committed by you, your Authorized Occupants, guests and invitees. In such event all Individual Tenants shall be held individually liable for any damages. If an action is brought against Lessor arising from your act or neglect, or the act or neglect of your Authorized Occupant, guest or invitee, you shall defend Lessor at your expense with an attorney of Lessor's choice.</li>
</ol>
</li>

<li>
	<h2>CORRECTING YOUR DEFAULT</h2>

<p>If Lessor is compelled to pay any expense, including reasonable attorney's fees in instituting, prosecuting or defending any action or proceeding instituted by reason of you, or your Authorized Occupant, guest or invitee, breaching or defaulting under the terms of this Lease, the money paid by Lessor with all interest, costs and damages shall be deemed to be additional rent hereunder and shall be due from you to Lessor on the first day of the month following the payment of such expenses.</p>
</li>

<li>
	<h2>NOTATION ON CHECKS</h2>

<ol>
	<li>Lessor and you expressly agree that any endorsements or statements on a check given in payment as rent shall not be deemed to constitute an "accord and satisfaction," and you further agree that the Lessor may accept such checks without prejudice to Lessor's legal rights. You further agree that Lessor has the right in Lessor's sole discretion and judgment, to apply any payments of rents to outstanding balances that Lessor may elect.</li>
</ol>
<p>Damage to the equipment or appliances supplied by Lessor, caused by your act or neglect, may be repaired by Lessor at your expense. The repair cost will be added to your rent as additional rent.</p>
</li>

<li>
	<h2>PETS</h2>

<ol>
	<li>You shall not keep or maintain in or about the said premises or permit any other person to keep or maintain therein, any dog, cat or other domestic or wild animals without the written consent of the Lessor, except to the extent such animal constitutes a service or comfort animal under applicable law.</li>
	<li>If the Apartment Unit is designated by Lessor to be one in which pets are permitted, no pet may be brought into the Apartment Unit and the Apartment Building without Lessor's prior written permission and provided that Individual Tenant enters into a Pet Rider to this Lease and all of the terms and conditions of such Pet Rider are fully complied with. In addition, except for service or comfort animals required to be permitted under applicable law, if any Individual Tenant, his or her Authorized Occupant, guest or invitee intends to bring a pet into the Apartment Unit or otherwise into the Apartment Building, we may require such individual to produce proof of vaccination for such pet in a form satisfactory to us and such party must provide written evidence of the consent of every other Individual Tenant and their Authorized Occupants of the Apartment Unit to the presence of such pet in the Apartment Unit. All pets should remain inside the Apartment Unit unless accompanied by an Individual Tenant. If any Individual Tenant's Authorized Occupants, guests or invitees brings a pet into the Apartment Building, such Individual Tenant will be responsible for any injury or damage caused by this pet to other tenants, employees, or guests in the Apartment Building. Lessor shall not be responsible for any injury to such pets or injuries or damage caused by pets to any other tenants or third parties. We reserve the right, in our sole discretion, to restrict any Individual Tenant and/or such Individual Tenant's Authorized Occupants, guests or invitees right to bring a pet into the Apartment Building, except to the extent such pet constitutes a service or comfort animal under applicable law.</li>
	<li>Lessor's permission to other Individual Tenants in the Apartment Building to harbor dogs, cats, birds or any other animals does not constitute a waiver of this provision. If permission is given by the Lessor to harbor a particular dog, cat, bird or other animal, such permission may not be construed as permission to harbor an additional dog, cat, bird or other animal or a different dog, cat, bird or other animal. The consent or permission or waiver of the right to object to the presence of a pet by reason of the New York City Pet Law shall not bar Lessor's right to revoke the consent, permission or waiver based upon the conduct or behavior of the dog or other animal, including without limitation, any aggressive behavior, conduct or attacks by the pet against other tenants, guests, occupants or the employees of Lessor (even if only one instance). This clause shall be applicable whether or not the permission is explicitly given or by reason of the New York City Pet Law.</li>
</ol>
</li>

<li>
	<h2>NO MAJOR ELECTRICAL APPLIANCE</h2>

<p>You shall not use any major electrical appliance or equipment in the Apartment Unit other than those appliances provided by the Lessor with the Apartment Unit, or any electrical appliance or equipment you provide which will overburden the electrical input.</p>
</li>

<li>
	<h2>FAILURE TO PAY FULL RENT</h2>

	<p>The receipt by the Lessor of an amount which is less than that amount of rent or additional rent owned by you shall not be deemed a waiver of the right to collect the balance. Any payment of rent or additional rent which is less than the full amount owed, shall be deemed to be on account of and shall be applied to the earliest item.</p>
</li>

<li>
	<h2>LATE FEE AND INSUFFICIENT FUNDS</h2>

<ol>
	<li>It is agreed that the rental under this Lease is due and payable in equal monthly installments in advance on the first day of each month during the entire Lease term. In the event that any monthly installment of rent, or any other payment required to be made by an Individual Tenant under this lease shall be overdue by more than five (5) days, a late charge of the lesser of either (i) 5% of the monthly rent or (ii) the highest amount permitted by applicable law, may be charged by the Lessor for each month, or fraction of each month, from its due date until paid for the purpose of defraying the administrative and other costs incurred by Lessor in handling delinquent payments.</li>
	<li>If any check remitted by Individual Tenant for payment of rent or other sums due under this lease is returned unpaid for insufficient funds or otherwise, the Lessor may require and Individual Tenant agrees to pay, as additional rent, a fee equal to the greater of (i) $75.00 or (ii) the fee charged to Lessor by the Lessor's bank for a returned check. Further, Individual Tenant understands and agrees, in the event rent is not timely received by the Lessor on the day of the month for which rent is due, Lessor may commence legal proceedings seeking both a monetary and possessory judgment against Individual Tenant, with Individual Tenant being responsible and liable for all costs and expenses incurred by Lessor pursuant to this Lease. By this subparagraph Lessor neither waives nor modifies Individual Tenant's obligation to pay to Lessor the rent, in advance on the first day of each month, nor does Lessor waive or modify any legal or equitable rights or remedies available to it.</li>
	<li>Tenant understands and agrees to the following: (a) if Lessor accepts Individual Tenant's rent or if Lessor fails once or more often to take action against Individual Tenant when Individual Tenant has not done what Individual Tenant has agreed to do in this Lease, the failure of Lessor to take action or Lessor's acceptance of rent does not prevent Lessor from taking action at a later date if Individual Tenant again does not do what Individual Tenant has agreed to do pursuant to this Lease; (b) Lessor's acceptance of rent from any person other than Individual Tenant shall be deemed to constitute a tender of rent on Individual Tenant's behalf only, such that neither the tender nor the acceptance thereof shall neither waive any of Lessor rights or remedies nor shall the tender nor the acceptance thereof be deemed to create any rights or tenancy status in any person other than Individual Tenant, however, Lessor shall be under no obligation to accept the tender of rent from any person other than the Individual Tenant named on the Lease; (c) only a written agreement between Individual Tenant and Lessor can waive any provision or violation of this lease; (d) if Individual Tenant pays and Lessor accepts an amount less than all the rent due, the amount received shall be considered to be in payment of all or a part of the earliest rent due and such tender shall not be considered an agreement by Lessor to accept any lesser amount in full satisfaction of all of the rent due; (d) Lessor and Individual Tenant expressly agree that any endorsements or statements or notations made by Individual Tenant or by anyone else on the front or back of a check given in payment as rent, whether handwritten or printed, if deposited by Lessor, shall neither be deemed to constitute an "accord and satisfaction," nor shall the terms of this Lease nor the parties rights and/or obligations thereunder be deemed modified thereby; and (e) Lessor may accept, endorse, deposit or negotiate any check, money order or other monetary instrument without connoting Lessor's acceptance of the endorsements or statements or notations made thereon and, Lessor may accept same as if said endorsements or statements or notations did not exist, and any such endorsements or statements or notations are without prejudice to Lessor's legal rights and shall not connote Lessor's acceptance of the endorsements or statements or notations made thereon.</li>
</ol>
</li>

<li>
	<h2>INTENTIONALLY DELETED</h2>
</li>

<li>
	<h2>NO APPLICABLE RENT REGULATION</h2>

<p>Lessor and Individual Tenant agree and acknowledge that this Lease and the Apartment Unit are not registered under nor subject to, nor intended to be subject to any rent regulatory law, including but not limited to the Rent Stabilization Law, the Rent Stabilization Code of the City of New York, the Emergency Tenant Protection act of 1974, or any federal, state, or city law regulating rents. In addition, Individual Tenant specifically acknowledges and agrees that the Apartment Unit and this Lease shall not be subject to the jurisdiction or any rulings or orders of DH1 the New York State Division of Housing and Community Renewal, the New York City Conciliation and Appeals Board or any of the New York City Rent Guidelines Board. Individual Tenant specifically acknowledges and agrees that he or she shall have no right to renew this Lease pursuant to this law or any other law, rule or regulation.</p>
</li>

<li>
	<h2>CONSTRUCTION OF NEIGHBORING BUILDINGS AND LOT LINE WINDOWS</h2>

<p>In the event any windows, light, or view in the Apartment Unit or elsewhere in the Apartment Building shall become obstructed, in whole or in part, as a result of the erection of a building or structure or otherwise, such occurrences shall not be deemed a breach of this Lease or any of Lessor's obligations hereunder and the Lease shall remain in full force and effect without any right by Individual Tenant or Authorized Occupant to make a claim for damages, nuisance, abatement of rent or otherwise. If Individual Tenant's Apartment Unit, including but not limited to Individual Tenant's exclusive use Bedroom, contains one or more "lot line" window(s), Individual Tenant is advised that a building or structure may be erected on adjacent property, which may completely block the said lot line window(s).</p>
</li>

<li>
	<h2>NO ORAL AGREEMENTS</h2>

<p>It is agreed that this instrument cannot be changed orally and is subject to the review and approval of the Lessor. The applicant hereby waives any claims against the Lessor in the event this Lease is rejected for any reason. The Lessor will in no event be bound, nor will possession be given unless and until this Lease is executed by the Lessor and delivered to the Individual Tenant. No representations other than those contained within this lease agreement have been made by Lessor. All understandings and agreements heretofore made between the parties hereto are merged in this contract, which alone, fully and completely expresses the agreement between Lessor and Individual Tenant.</p>
</li>

<li>
	<h2>WATERBEDS</h2>

<p>Individual Tenant agrees not to keep furniture which contains water or other liquid, including but not limited to "water beds" in the Apartment Unit.</p>
</li>

<li>
	<h2>PATIOS, TERRACES AND BALCONIES</h2>

<p>Individual Tenant shall keep his or her terrace or balcony, if any, and the drains located therein, free from all rubbish, dirt, debris or windblown materials, and Individual Tenant shall be responsible for any water damage caused to Individual Tenant's Apartment Unit or any other apartment or to the Apartment Building, resulting from clogged drains or from any other use of such patio, terrace, or balcony. The Individual Tenant may not install a fence or any addition to the terrace or balcony. No plantings, bicycles, furniture or any other objects shall be placed on any terrace or balcony without the written permission of the Lessor. No clothing, towels, bedding or any other objects shall be placed on any terrace or balcony for drying or airing.</p>
</li>

<li>
	<h2>EMPLOYEES MISCONDUCT</h2>

<p>In the event any employee of the Lessor or its managing agent renders assistance in parking or delivery of an automobile or in the handling or delivery of any furniture, household goods, or other articles at the request of the Individual Tenant or any Authorized Occupant, or at the request of any guest or invitee of the Individual Tenant, then said Lessor's or managing agent's employee shall be deemed an agent of the person making such request and the Lessor and the managing agent shall be expressly relieved from any and all loss or liability in connection therewith.</p>
</li>

<li>
	<h2>GARBAGE RECYCLING</h2>

<ol>
	<li>Individual Tenant agrees at Individual Tenant's sole cost and expense, to comply with all present and future laws, orders and regulations, commissions and boards regarding the collection, sorting, separation, and recycling of waste products, in accordance with the rules and regulations adopted by the Lessor and/or the City of New York for the sorting and separation of such designated recyclable materials. The household rubbish should only be disposed of in the intended garbage and recycling containers. Care must be taken in the consequent separation of garbage. Special waste and bulky materials do not belong in these containers. They are to be disposed of separately according to the rules and regulations of the City of New York.</li>
	<li>Lessor reserves the right, if permitted by law, to refuse to collect or accept from Individual Tenant any waste products, garbage, refuse, or trash, which is not separated and sorted as required by law. Individual Tenant shall pay all costs, expenses, fines, penalties, or damages, which may be imposed on Lessor or Individual Tenant by reason of Individual Tenant's failure to comply with the provisions of this Article. Individual Tenant's failure to comply with this Article shall constitute a violation of a substantial obligation of the tenancy, local statute and of Lessor's rules listed in this Lease, and the House Rules. Individual Tenant shall be liable to the Lessor for any costs, expenses, or disbursements, including attorney's fees, incurred by Lessor in the commencement and/or prosecution of any action or proceedings by Lessor against Individual Tenant, predicated upon Individual Tenant's breach of this Article.</li>
</ol>
</li>

<li>
	<h2>AIR CONDITIONER</h2>

<p>Individual Tenant shall not install or have installed or use or permit the installation of air conditioners or air conditioning machinery in the Apartment Unit which have not been provided by Lessor without the Lessor's prior written consent.</p>
</li>

<li>
	<h2>ABANDONED PROPERTY</h2>

	<p>Lessor shall not be obligated to repair, replace or maintain any personal property left in the Apartment Unit by a prior tenant or occupant of the Apartment Unit. Whatever remains in the Apartment Unit after Individual Tenant vacates is considered abandoned by Individual Tenant and at the election of the Lessor, shall either be left in the Apartment Unit or removed and discarded. Individual Tenant shall be responsible for Lessor's expenses and/or damages resulting from removal of abandoned property or restoration of the Apartment Unit necessary to correct any damage caused by removal of Individual Tenant's and his or her Authorized Occupants' property and/or installations.</p>
</li>

<li>
	<h2>MOVING</h2>

<p>Individual Tenant is permitted to use the service elevator, if any, only if required to move furniture and possessions on designated days and hours that have been scheduled in advance and with prior approval from the Lessor or its managing agent. Lessor shall not be liable for any costs, expenses, or damages incurred by Individual Tenant in moving because of delays caused by the unavailability of the elevator.</p>
</li>

<li>
	<h2>INVALIDITY OF ANY PROVISION</h2>
<p>If any term, covenant, condition, or provision of this Lease or a Rider shall be invalid or unenforceable to any extent, the remaining terms, covenants, conditions, and provisions of this Lease or such Rider other than those as to which any term, covenant, condition, or provision is held invalid or unenforceable, shall not be affected thereby and each remaining term, covenant, condition, and provision of this Lease and such Rider shall be valid and shall be enforceable to the fullest extent permitted by law.</p>
</li>

<li>
	<h2>RELOCATION</h2>

<p>In the event that an Individual Tenant desires to relocate to another unit in either the same Apartment Building or another building owned and/or operated by 186N6 Owner LLC, 1262 Broadway (Suite 405), New York 10001, US during the term of the existing Lease, they may not do so until after being in occupancy under the Lease for a period of no less than ninety (90) consecutive days. Any Individual Tenant selecting a Lease Term less than 180 days will be subject to a New York City tax for tenancies shorter than one hundred eighty (180) days. In the event an Individual Tenant desires to relocate to another available exclusive use Bedroom in the same Apartment Unit, they may do so only with the permission of Lessor and upon executing an amendment to this Lease evidencing the substitution of the alternative exclusive use Bedroom.</p>
</li>

<li>
	<h2>INDIVIDUAL TENANT MISREPRESENTATION</h2>

<p>Individual Tenant has made various representations in its application to this Lease, and has further represented that Individual Tenant shall abide by the terms of this Lease. Lessor has specifically relied upon such representations by Individual Tenant as a material inducement for Lessor's decision to offer to lease the Apartment Unit to Individual Tenant, absent which reliance Lessor would neither have offered nor executed this Lease with Individual Tenant. It is agreed that in the event the Individual Tenant shall in its application for an apartment which application is incorporated herein by reference, and made a part hereof, make any misrepresentation or untruthful statement, Lessor may treat same as a violation of the covenant of this Lease, and the remedies provided under the terms of this Lease in the event of violation of the terms hereof shall become applicable thereto in addition to which Lessor may seek rescission of this Lease by reason of such misrepresentation. In the event the Lessor shall discover or ascertain such misrepresentation or untruthful statement before the commencement of the term hereunder, the Lessor shall have the right to terminate this Lease and refuse occupancy to the Individual Tenant.</p>
</li>

<li>
	<h2>DELIVERIES</h2>

<p>Notwithstanding anything contained in this Lease, in the event that the Apartment Building has a doorman or superintendent that is willing to accept deliveries of packages for the Individual Tenant, the Individual Tenant agrees not to deliver or cause to be delivered to Lessor or Lessor's authorized agent for delivery to the Individual Tenant or to any other person any item of property (packaged or otherwise), which shall have a value in excess of $250.00. Individual Tenant further agrees that in no event shall Lessor be liable in excess of the sum of USD 250.00 for loss or damage to any property (packaged or otherwise) which shall be delivered to Lessor's authorized agent for delivery to the Individual Tenant or to any other person and the Individual Tenant hereby indemnifies and agrees to hold Lessor harmless from any liability or claim in excess of USD 250.00 for loss or damage to any such property which may be asserted by the Individual Tenant or any consignor, deliverer, shipper, lessor of such property or other person.</p>
</li>

<li>
	<h2>REPORTING REQUIREMENTS</h2>

	<p>Individual Tenant is to immediately inform the Lessor or its managing agent, in writing, of all defects of the Apartment Unit and common areas of the Apartment Building. The reporting obligation also applies to all furnishings, equipment, appliances and other property provided by Lessor stated in the schedule attached to the Lease. Individual Tenant cannot demand substitutes for objects not listed in the schedule attached to the Lease. Individual Tenant is obligated to notify the Lessor or its managing agent of all such damages to the Apartment Unit or Apartment Building immediately as they are discoverable, noticeable or perceptible, in particular the drainage pipes, moisture in the Apartment Unit or common areas of the Apartment Building, damage to the elevators, or damage to the heating or air conditioning systems.</p>
</li>

<li>
	<h2>ILLEGAL ACTIVITY/EVICTION</h2>
	<p>The possession, use, cultivation, manufacture or sale of any illegal substance, including marijuana, is strictly prohibited. It is expressly agreed and understood that any Individual Tenant, his or her Authorized Occupants, and their guests and invitees who conduct any illegal trade, or manufacture, or other illegal business or activity in the Apartment Unit or other areas of the Apartment Building, including grounds surrounding the Apartment Building shall be subject to immediate eviction from the premises.</p>
</li>

<li>
	<h2>VEHICLES</h2>
	<p>If the Apartment Building offers off-street parking and the Individual Tenant leases one or more parking spaces, no vehicle belonging to the Individual Tenant or his or her Authorized Occupant, guest or invitee shall be parked in such manner to prevent ready access to any entrance or driveway of the Apartment Building.</p>
</li>

<li>
	<h2>SERVICES</h2>

<ol>
	<li>The cost of providing electricity, cable and/or satellite television, natural gas, if applicable, and Internet service to the Apartment Unit and the Apartment Building is included in the rent of each Individual Tenant; provided, however, that any measurable utility cost of an Apartment Unit that exceeds the average of the same type of utility in similar apartment units with similar number of occupants in the Apartment Building by more than 25%, Lessor reserves the right to charge a proportionate share of the costs in excess of such 25% to each Individual Tenant in the Apartment Unit.</li>
	<li>Certain services for additional fees may be offered by Lessor. Lessor is not required  to provide any services or level of staffing other than those which are specifically set forth in this Lease, or are offered and accepted through the Lease and/or booking through the Manager’s portal. Any discontinuance or failure to perform such optional service shall not constitute a decrease in services under this Lease. It is further understood that if Lessor elects to provide any additional service which were not in effect as of the date of this Lease, such additional service shall not be deemed a service for which the Individual Tenant is paying rent and if Lessor shall, during the term of this Lease, elect to withdraw such additional service from the Apartment Building, Lessor shall not be subject to any liability nor shall Individual Tenant be entitled to any compensation or diminution or abatement of rent nor such revocation or diminution be deemed a constructive or actual eviction.</li>
	<li>Individual Tenant acknowledges that Lessor makes no representation and assumes no responsibility whatsoever with respect to the functioning or operation of any of the human or mechanical security systems, if any, which Lessor does or may provide. Individual Tenant agrees that Lessor shall not be responsible or liable for any bodily harm or property loss or damage of any kind or nature which Individual Tenant or any Authorized Occupant and their guests and invitees may suffer or incur by reason of any claim that Lessor, its agents or employees has been negligent or any mechanical or electronic system in the Apartment Building has not functioned properly or that some other or additional security measure or system could have prevented the bodily harm or property loss or damage.</li>
</ol>
</li>

<li>
	<h2>EXTERMINATOR</h2>

<p>Lessor's agents, representatives, contractors and workmen, shall have the right to enter the Apartment Unit at any reasonable hour of the day for the purpose of inspecting the Apartment Unit to ascertain whether measures are necessary or desirable to control or exterminate any vermin, insects or other pests and for the purpose of taking such measures as may be necessary to control or exterminate any such vermin, insects, or other pests. If Lessor takes any measures to control or exterminate bed bugs, carpet beetles, cereal pests or fabric moths in the Apartment Unit, the cost thereof may be charged in whole or in part to the Individual Tenant or Individual Tenants as additional rent. Individual Tenant must follow all of Lessor's procedures associated with the extermination for bed bugs, carpet beetles, cereal pests or fabric moths that are recommended by Lessor or Lessor's extermination contractor.</p>
</li>

<li>
	<h2>SMOKE DETECTOR AND CARBON MONOXIDE DETECTOR</h2>

<p>The Apartment Unit shall be equipped with a smoke detector(s) and carbon monoxide detector(s) as required by applicable law. Individual Tenant shall not disable, cover, remove, repair or otherwise tamper with any smoke detector(s) and carbon monoxide detector(s). Individual Tenant shall give prompt written notice to Lessor of any damage to the smoke detector(s) and carbon monoxide detector(s), and as to any defect or malfunction in the operation thereof. Individual Tenant understands that it is his or her obligation to immediately replace batteries as necessary.</p>
</li>

<li>
	<h2>NOISES, ODORS, SCENTS AND HAZARDOUS OR TOXIC MATERIALS</h2>

<ol>
	<li>Individual Tenant acknowledges that the Lessor has not made any representations or promises with respect to noises or odors however arising and whether occurring inside or outside the Apartment Building, and Individual Tenant waives and releases any claim, cause of action or set off by reason of or arising out of any noise, inconvenience, aromas, scents, or odors, however arising, and whether occurring inside or outside the Apartment Building.</li>
	<li>Individual Tenant shall not rescind this Lease or be entitled to any compensation or diminution or abatement of rent, nor shall Individual Tenant fail to honor any other obligations under this Lease by virtue of any of the above mentioned items. Individual Tenant and his or her Authorized Occupants, guests and invitees shall not permit any noxious odors or objectionable odors to emanate from Individual Tenant's Apartment Unit or any area of the Apartment Building. Further Individual Tenant and his or her Authorized Occupants, guests and invitees shall not use, generate, store or dispose of any type of hazardous or toxic materials or substances at, from, or in the Apartment Unit or any area of the Apartment Building.</li>
</ol>
</li>

<li>
	<h2>BROKER</h2>

<p>Individual Tenant represents that no broker brought about this Lease or if a broker did, in fact bring about this Lease, Individual Tenant has agreed with the broker to pay the broker's fee and Individual Tenant agrees to hold Lessor harmless from any claim for commission made by any broker in connection with this Lease including without limitation the costs of defense plus reasonable attorney's fees by an attorney selected by Lessor to defend it. Lessor shall not be subject to any liability nor shall Individual Tenant be entitled to any compensation or diminution or abatement of rent, nor such revocation or diminution be deemed a constructive or actual eviction.</p>
</li>

<li>
	<h2>PUBLIC AREAS</h2>

<p>Individual Tenant acknowledges and agrees that (i) the public halls or stairways of the Apartment Building shall not be obstructed or used for any purpose other than ingress to or egress from the Apartment Units in the Apartment Building, (ii) no common areas shall be decorated or furnished by any person in any manner, (iii) children shall not play in the common areas of the Apartment Building, (iv) children shall not be fed or diapered in the lobby or in any other public areas of the Apartment Building, (v) housekeepers and caregivers shall not congregate in the lobby or in other public areas of the Apartments Building, and (vi) children shall at all times be supervised by an adult while in the public areas of the Apartment Building.</p>
</li>

<li>
	<h2>ADVERTISEMENT</h2>

<p>Individual Tenant acknowledges and agrees that (i) no sign, notice, advertisement or illumination shall be inscribed, placed or displayed on or at any window, balcony or terrace of the Apartment Unit, (ii) no sign, notice, or advertisement may be placed in any common area of the Apartment Building, and (iii) Individual Tenant shall not peddle, distribute or solicit any merchandise, book, periodical, circular, handbills, pamphlets, advertising material or otherwise, or solicit donations or contributions for or membership in any public or private  organization in any common area of the Apartment Building.</p>
</li>

<li>
	<h2>BARBEQUING PROHIBITED WITHOUT LESSOR CONSENT</h2>
<p>Individual Tenant agrees that he or she shall not cook or barbecue on any balconies or terraces adjoining the Apartment Unit. To the extent that the Apartment Building has a roof terrace designed and equipment for barbequing or other cooking, Individual Tenant shall only utilize such roof terrace and facilities for barbequing and/or other cooking following Individual Tenant obtaining the consent of Lessor. Failure of Lessor to respond to a request for consent shall not imply consent.</p>
</li>

<li>
	<h2>FACILITY USAGE</h2>

<ol>
	<li>To the extent any additional facilities are provided by Lessor to all tenants in the Building during the term of this Lease, provided Individual Tenant is not in default under the terms of the Lease, Individual Tenants shall be able to access such facilities. Individual Tenant and his or her Authorized Occupants, guests and invitees agree that any such use is at their own risk and agree to sign any requisite liability waivers, agreements, if any, which may be required for the use of the facilities. Individual Tenant and his or her Authorized Occupants, guests and invitees shall be required to comply with all House Rules and other rules established from time-to-time in connection with the use of the facilities. If Individual Tenant or his or her Authorized Occupants, guests and invitees default in connection with any of their obligations with respect to the facilities, then Individual Tenant and his or her Authorized Occupants, guests and invitees shall be prohibited from using the facilities. In addition, if Individual Tenant or his or her Authorized Occupant, guests or invitees default in connection with any obligation of them with respect to the facilities, said default shall be deemed to be a default under this Lease and said default shall give Lessor the right to terminate the tenancy of the Individual Tenant under this Lease and exercise any and all remedies available to Lessor under this Lease, at law, or in equity, in connection with any default under the Lease. Lessor makes no representation as to what facilities are available other than those disclosed on the Customer Portal, and Lessor reserves the right to modify the facilities, including the times of access, place limitations on use, at a future time and close or eliminate the facilities completely and that any such modification, limitation or closure will have no effect on Individual Tenant's obligations hereunder.</li>
	<li>Notwithstanding anything to the contrary contained in this Lease, Individual Tenant and Lessor acknowledge that the COVID – 19 Crisis has or may result in the issuance of orders, directives or advice by a governmental authority restricting access to or use of the Building or portions thereof, including the facilities provided by Lessor (any such measures, a "Major Health Order"). Individual Tenant hereby waives, and releases Lessor from, any and all claims that any Major Health Order, whether now or hereafter existing, or any changes to the operation of the Building reasonably implemented by Lessor as a result of any Major Health Order, constitutes an eviction, a constructive eviction, an interruption of any right of quiet enjoyment, an interruption of services to be provided pursuant to the Lease, or otherwise entitles Individual Tenant to an abatement or offset of Rent or any other sum which is due or is to become due under this Lease.</li>
	<li>Notwithstanding anything to the contrary contained in this Lease, Individual Tenant, his or her Authorized Occupants, guests and invitees shall not have any right to use the facilities following the termination of this Lease and/or Individual Tenant vacating the Apartment Unit.</li>
</ol>
</li>

<li>
	<h2>ALTERATIONS AND INSTALATIONS</h2>

<ol>
	<li>The installation of a satellite dish is prohibited except upon the express written permission of the Lessor and may only be professionally installed by an installer of Lessor's choosing. Individual Tenant shall pay all the costs of the installation. Individual Tenant is required to cover the costs of removal of the system prior to moving out of the Apartment Unit. Individual Tenant shall pay all reasonable expenses for the restoration of the property.</li>
	<li>Individual Tenant is required, upon reasonable written notice, to allow Lessor to perform all repairs, alterations and modifications as Lessor deems necessary. Lessor and/or its contractor may inspect the Apartment Unit on twenty-four (24) hours written notice.</li>
</ol>
</li>

<li>
	<h2>Intentionally Deleted</h2>
</li>

<li>
	<h2>PREVENTING MOISTURE AND MILDEW</h2>

<ol>
	<li>
		<p>Individual Tenant acknowledges that it is necessary for Individual Tenant to provide appropriate climate control in the Apartment Unit and take other measures to retard and prevent mold and mildew from accumulating in the Apartment Unit. Individual Tenant shall:</p>
		<ol>
			<li>maintain the Apartment Unit in clean condition, dust the Apartment Unit on a regular basis and remove any visible moisture accumulation in or on the leased premises, including on windows, walls, floors, ceilings, bathroom fixtures, and other surfaces; mop up spills and thoroughly dry affected area as soon as possible after occurrence and (ii) not block or cover any of the heating, ventilation or air-conditioning ducts in the Apartment Unit and keep climate and moisture in the Apartment Unit at reasonable levels.</li>
		</ol>
	</li>
	<li>Individual Tenant shall promptly notify management in writing of the presence of the following conditions: (i) any evidence of a water leak or excessive moisture or standing water inside the Apartment Unit or in any common area of the Apartment Building; (ii) any evidence of mold or mildew-like growth in the Apartment Unit that persists after Individual Tenant has tried several times to remove it with a common household cleaner containing disinfectants and/or bleach, (iii) any failure or malfunction in the heating, ventilation and air conditioning systems or the laundry equipment, if any, in the Apartment Unit; and (iv) any inoperable doors or windows.</li>
	<li>If Individual Tenant fails to comply with the provisions of this section, then, in addition to Individual Tenant's obligation to indemnify Lessor in accordance with the terms of this Lease for all damage, loss, cost and expense, including attorney's fees and disbursements, suffered or incurred by Lessor in connection with said failure to comply, Individual Tenant shall also be responsible for all damage or loss to and all costs and/or expenses suffered or incurred by Individual Tenant, his or her personal property and other Authorized Occupants, guests and invitees of the Apartment Building and their respective personal property.</li>
</ol>
</li>

<li>
	<h2>WINDOWS</h2>

	<p>Under no circumstances is Individual Tenant permitted to install/affix any window treatment of any kind, including but not limited to blinds, curtains, valances, etc. into the window frames, mullions and/or sills in the Apartment Unit. Additional window treatments may only be installed with Lessor's express written consent. In the event that Individual Tenant is granted permission to have additional window treatments installed, such installation may only be done by a contractor chosen by Lessor, in its sole discretion. Individual Tenant shall pay the contractor and all costs associated with the installation and removal of such window treatments, including for the repair any damage caused as a result thereof. Any and all additional window treatments installed pursuant to this section must be removed upon the expiration and/or termination of the Lease and any renewals thereof. Individual Tenant shall deposit the sum of USD 250.00 with Lessor at the time permission to install the window treatment is granted and prior to the performance of any work associated with such installation to ensure that Individual Tenant abides by its obligations under this section.</p>
</li>

<li>
	<h2>WINDOW GUARDS</h2>
<p>Individual Tenant must disclose to Lessor if he or she has children under the age of 10 years who will be residing in the Apartment Unit so that Lessor can install window guards in accordance with legal requirements. Individual Tenant acknowledges that Individual Tenant has received notice that under Section 131.15 of the New York City Health Code Lessor is required to install window guards in the Apartment Unit if a child 10 years of age or under lives in the Apartment Unit. Individual Tenant shall cooperate with Lessor with the installation of such window guards. As part of signing this Lease, Individual Tenant shall have completed and signed the Window Guard Notification and Disclosure attached as Rider No. 3 to this Lease.</p>
</li>

<li>
	<h2>END OF TERM</h2>

<p>At the end of the Term, Individual Tenant must: (i) leave the Apartment Unit, including his or her exclusive use Bedroom, clean and in good condition; remove, at Individual Tenant's sole expense, all of the Individual Tenant's and his or her Authorized Occupant's property and all their installations and decorations (unless Lessor requests otherwise); (ii) repair all damage to the Apartment Unit and Apartment Building caused by moving or other acts; and (iii) restore the Apartment Unit to its condition at the beginning of the term.</p>
</li>

<li>
	<h2>HOLDING OVER</h2>

<p>In the event that Individual Tenant or his or her Authorized Occupants fail to move out of the Apartment Unit in accordance with the terms of this Lease and/or any extension or renewal thereof, Individual Tenant understands that Individual Tenant will be charged and agrees to pay an additional USD 3,000.00 per month over and above the rent reflected in this Lease as use and occupancy for any month and/or any portion thereof that Individual Tenant holds over after such expiration, until such time as Individual Tenant vacates or is evicted from the Apartment Unit. The acceptance of such sum does not act as a Lease renewal or implied rental agreement.</p>
</li>

<li>
	<h2>PLUMBING</h2>

	<p>Individual Tenant at Individual Tenant's sole cost and expense, to keep the drain, waste pipes and connections with the Apartment Building's main pipes and connections free from obstruction to the satisfaction of the Lessor, and all authorities having jurisdiction.</p>
</li>

<li>
	<h2>LEAD PAINT DISCLOSURE</h2>

<p>If the Apartment Building was built before 1980, Lessor would have provided and Individual Tenant would have acknowledged prior to entering into this Lease that it has read and understands the "Disclosure of Information on Lead-Based Paint and Lead-Based Paint Hazards" form attached to this Lease. This Apartment Building was constructed after 1980.</p>
</li>

<li>
	<h2>TEMPORARY UNIT</h2>
<p>In the event the Apartment Unit is not yet ready for occupancy on the date hereof, the Individual Tenant hereby agrees to occupy a similar available unit in the same Apartment Building ("Temporary Unit") until the Apartment Unit is ready for occupancy. Individual Tenant shall maintain all of his or her obligations under the terms of this Lease, including payment of rent, during his or her occupancy of the Temporary Unit. Upon readiness of the Apartment Unit, Lessor will notify Individual that the Apartment Unit is ready for occupancy, and Individual Tenant shall be responsible for moving into the Apartment Unit immediately thereafter. The terms of this Lease shall otherwise remain binding and in full force and effect during the Individual Tenant's occupancy of the Temporary Unit.</p>
</li>

<li>
	<h2>PERSONAL DATA AND INFORMATION</h2>
	<p>The personal data of Individual Tenants and Authorized Occupants are processed within the limits of applicable data privacy laws, including Outpost Club Privacy Policy which is available on the Outpost Club website. For the purposes of rental and property management, the protection against possible loss of rent and for debt collection and creditworthiness purposes, the Lessor is entitled to transfer personal data of the Individual Tenant and Authorized Occupants to a third party.</p>
</li>

<li>
	<h2>MILITARY SERVICE</h2>
	<p>If Individual Tenant joins any branch of the military service of the United States or experiences a change in military status, and such Individual Tenant desires to terminate his or her tenancy under this Lease, such Individual Tenant shall notify Lessor in writing identifying the branch of the military service, the date such new/active military status commences, and where such Individual Tenant will be located or stationed, if such information is not confidential, and Lessor will confirm such Individual Tenant's eligibility for any protections afforded to Residents of the armed services, including the right to early termination of his or her tenancy under this Lease.</p>
</li>

<li>
	<h2>COUNTERPARTS AND ELECTRONIC SIGNATURES</h2>
	<p>This Lease may be (i) executed manually and transmitted electronically by facsimile or e-mail (PDF) signature, or (ii) executed through a digital signing system, in any number of counterparts, each of which shall be deemed an original, but all of which together shall constitute one and the same instrument.</p>
</li>

<li>
	<h2>TO CONFIRM OUR AGREEMENTS, INCLUDING THOSE SET FORTH BELOW, LESSOR AND THE UNDERSIGNED INDIVIDUAL TENANT, RESPECTIVELY SIGN THIS LEASE AS OF THE DAY AND YEAR WRITTEN BELOW.</h2>
</li>

<li>
	<h2>KEY TERMS:</h2>

	<ul>
		<li><strong>Lease Execution Date:</strong> {if $contract_info->signing}{$contract_info->date_signing|date_format:'%b %e, %Y'}{else}{$smarty.now|date_format:'%b %e, %Y'}{/if}</li>
		<li><strong>Lease Commencement Date:</strong> {$contract_info->date_from|date}</li>
		<li><strong>Lease Termination Date:</strong> {$contract_info->date_to|date}</li>
		<li><strong>Minimum Lease Term:</strong> Any Individual Tenant selecting a Lease Term less than 180 days may be subject to a New York City tax for tenancies shorter than one hundred eighty (180) days.</li>
		<li>
			<strong>Monthly Rent During Term of Lease:</strong> 
			{if $booking->client_type_id==2}
				{$booking->airbnb_reservation_id}
			{else}
				{$contract_info->price_without_utilities|convert} (US Dollars)
			{/if}
		</li>
		{if $booking->client_type_id != 2}
		<li><strong>Security Deposit:</strong> {$contract_info->price_deposit|convert} (US Dollars)</li>
		<li><strong>Utilities:</strong> $149/month</li>
		{/if}
		<li><strong>Designation	of	Exclusive	Use	Bedroom	No.</strong> {if $apartment}{$apartment->name}{/if} / {$bed->name}</li>
		<li><strong>LESSOR:</strong> 186N6 Owner LLC, a New York limited liability company</li>
		<li><strong>INDIVIDUAL TENANT(S):</strong> {foreach $contract_users as $user}{if $contract_user->id != $user->id}{$user->name|escape}, {/if}{/foreach}{$contract_user->name|escape}</li>
	</ul>
</li>

</ol>


{foreach $contract_users as $user}
{if $user->id != $contract_user->id}
<p>TENANT NAME: {$user->name|escape}<br/>
	{if $user->log && $booking->client_type_id != 2}
	DATE: {$user->log->date|date}<br/>
	SIGNATURE:<br/>
	<img src="{$config->contracts_dir}{$contract_info->url}/signature-{$user->id}.png" alt="Signature {$user->name|escape}" width="180" />
	{/if}
</p>
{/if}
{/foreach}

<p>TENANT NAME: {$contract_user->name|escape}<br/>
{if $contract_info->signing == 1 && $booking->client_type_id != 2}
	DATE: {$contract_info->date_signing|date}<br/>
{/if}
</p>

{if $booking->client_type_id == 2 && $booking->airbnb_reservation_id}
<p>Digital Signature ID: {$booking->airbnb_reservation_id}</p>
{/if}

{if !$contract_info->signature2 && $booking->client_type_id != 2}
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

{if $contract_info->signature2 && $booking->client_type_id != 2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{/if} 

<br><br>

<p><strong>This document was issued electronically and is therefore valid without signature.</strong></p>
<p>Riders to lease</p>
<ol>
	<li>Rider No. 1 - Notes</li>
	<li>Rider No. 2 – House Rules and Regulations</li>
	<li>Rider No. 3 – Window Guard Notification and Disclosure</li>
	<li>Rider No. 4 – Bedbug Infestation History</li>
	<li>Rider No. 5 – Lead paint</li>
	<li>Rider No. 6 – Smoke Detector Acknowledgment</li>
	<li>Rider No. 7 – Human Rights</li>
	<li>Rider No. 8 – Fee Catalog</li>
	{* <li>Rider No. 9 – Inventory List</li> *}
	{if $contract_info->free_rental_amount != 0}
		<li>Rider No. 9 – Free Rent</li>
	{/if}
</ol>

<br>
<br>
<br>

<hr>

<br>
<br>
<br>

<p><strong>Rider No. 1 - Notes</strong></p>

{if $contract_info->note1}
	<p>{$contract_info->note1}</p>
{else}
	<p>Intentionally left blank.</p>	
{/if}

<br>

{foreach $contract_users as $user}
{if $user->id != $contract_user->id}
<p>TENANT NAME: {$user->name|escape}<br/>
	{if $user->log && $booking->client_type_id != 2}
	DATE: {$user->log->date|date}<br/>
	SIGNATURE:<br/>
	<img src="{$config->contracts_dir}{$contract_info->url}/signature-{$user->id}.png" alt="Signature {$user->name|escape}" width="180" />
	{/if}
</p>
{/if}
{/foreach}

<p>TENANT NAME: {$contract_user->name|escape}<br/>
{if $booking->client_type_id != 2}	
	{if $contract_info->signing == 1}
		DATE: {$contract_info->date_signing|date}<br/>
	{/if}
		SIGNATURE:<br>
{/if}
</p>

{if $booking->client_type_id == 2 && $booking->airbnb_reservation_id}
<p>Digital Signature ID: {$booking->airbnb_reservation_id}</p>
{elseif $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree1" for="agree1">I agree and sign</label><input type="checkbox" id="agree1" name="agree1" class="agree" value="1"></p>
{/if} 

<br>
<br>
<br>

<hr>

<br>
<br>
<br>

<p><strong>Rider No. 2 – House Rules and Regulations</strong></p>

<div class="center">
	<h1>RIDER NO. 2 TO LEASE</h1>

	<h1>ATTACHED RULES WHICH ARE A PART OF THE LEASE HOUSE RULES AND REGULATIONS</h1>
	<h4>Terms and Conditions</h4>
</div>

<p><strong>Individual Tenant's signature on the Lease indicates that Individual Tenant agrees to and accepts the terms, conditions, rules and regulations set forth below ("House Rules"):</strong></p>

<p>This is a legally binding contract rider to the Lease. Individual Tenant understands that any violation of the Lease or these House Rules may result in penalties ranging from a warning to Individual Tenant being permanently discharged from the Apartment Unit and the Apartment Building. Where appropriate for the personal safety of Individual Tenant or other Individual Tenants of the Apartment Building, Lessor reserves the right to remove an Individual Tenant from his/her Apartment Unit and the Apartment Building. Individual Tenants removed from the Apartment Building for violations of the Lease and/or these House Rules will still be held to his/her financial obligations for the remainder of the Term of the Lease.</p>

<p>Lessor reserves the right to rescind or amend any of the Lessor's House Rules, and to institute such other rules from time-to-time as may be deemed necessary for the safety, care, or cleanliness of the Apartment Building and for securing the comfort and convenience of all Individual Tenants and their Authorized Occupants. The Lessor shall not be liable to Individual Tenants or their Authorized Occupants for the violation of any of the Lessor's rules or the breach of any of the items in any Lease by any other Individual Tenant, Authorized Occupant or occupant of the Apartment Building.</p>

<p><strong>Initial Apartment Unit Condition, Occupancy, Keys and Lockout Fees</strong></p>

<p>At the commencement of occupancy, Individual Tenant will have seven (7) days to note the condition of, and any damage to, the Apartment Unit and the Lessor provided furniture, fixtures, equipment, appliances and other property in the Apartment Unit identified on the Inventory List. Individual Tenants must take care in keeping their Apartment Units clean to prevent insect infestation.</p>

<p>Individual Tenant may not change or add locks (including chain locks, deadbolts, etc.). Duplication of keys is prohibited. Individual Tenant must return his/her key tags any other access items to Lessor at the end of the Individual Tenant's tenancy under the Lease. Unauthorized copies of keys will not be accepted. At or following Individual Tenant's vacating of the Apartment Unit, the exclusive use Bedroom and non-exclusive use Living Room, Kitchen and Bathroom, they will be inspected and any damage not previously noted by Individual Tenant in the initial seven (7) day period of occupancy shall be charged to Individual Tenant.</p>

<p>In the event that Individual Tenant or his or her Authorized Occupant, guests or invitees damage any locks, Individual Tenant shall pay for changes to the locks.</p>

<p>In the event Individual Tenant loses or breaks any physical access tag or the digital access code needs to be changed because Individual Tenant has not keep the code secure from unauthorized person, Individual Tenant shall pay Lessor a replacement and/or access code resetting fee of One Hundred Dollars ($100). Individual Tenant shall advise Lessor of the loss of any physical access tag and compromise of the security of the digital access code as soon as possible but no later than twenty-four hours of such loss.</p>

<p>Lessor shall charge Individual Tenant a fee of $100 to unlock the Apartment Unit or exclusive use Bedroom entrance doors. Lessor makes no representation that staff will be available at all times to provide access.</p>

<p>Individual Tenant may not relocate to another Apartment Unit or another exclusive use Bedroom within the Apartment Unit without the consent of Lessor which may be withheld in Lessor's sole discretion. Individual Tenant will relocate to another unit in the Apartment Building at Lessor's request.</p>

<p><strong>Damage/Loss Charges</strong></p>

<p>Individual Tenant is responsible for damages to his/her Apartment Unit, as well as damage and/or loss to the furnishings, fixtures, equipment, appliances and other property Lessor has provided, which are caused by the acts or omissions of such Individual Tenant, and his or her Authorized Occupants, guests and invitees. Individual Tenant agrees to pay for the restoration of the property to its condition at the time of initial occupancy or for repairs or replacement (except normal wear and tear), unless the identity of others responsible, including other Individual Tenants and their Authorized Occupants, guests and invitees, for the damage or loss is established and proven by Individual Tenant. This responsibility extends until the Apartment Unit is officially returned to Lessor as provided above. If the responsible party for the damages cannot be determined, charges for damages, cleaning, replacement of furniture, etc. shall be divided by the number of Individual Tenants leasing the Apartment Unit. If one or more Individual Tenants or their Authorized Occupants assume responsibility for damages, cleaning, replacement of furniture, etc., a written statement signed by the responsible party must be noted in writing and delivered to Lessor at the time of surrendering occupancy. Charges will not be assessed to one Individual Tenant based solely on another Individual Tenant's claim of wrongdoing. Individual Tenant should assure that all windows and doors to the Apartment Unit are locked and secured at all times and when vacating the Apartment Unit. It is understood that Individual Tenants are responsible for any damage or loss caused or non-routine cleaning or trash removal required to the common areas of the Apartment Building and their furnishings, including vending machines and other equipment placed in the Apartment Building as a convenience to Individual Tenants and Authorized Occupants. Common areas outside of Apartment Units may include corridors, recreation rooms, kitchens, study rooms, living rooms, laundry rooms, public bathrooms, lounges, terraces, roof top terraces, entry corridors and pavement in front of the Apartment Building, as specified for the Apartment Building on the Outpost Club website. When damage occurs, Individual Tenant(s) will be billed directly for the repairs. Lessor shall have the authority to assess and assign charges for these damages as set forth in the Fee Catalogue.</p>

<p><strong>Furnishings/Fixtures</strong></p>

<p>Furniture, fixtures, equipment, appliances and other property provided by Lessor may not be removed from an Apartment Unit or the Apartment Building and may not be switched between rooms. In addition, window screens, if any, shall not be removed.</p>

<p><strong>Guests/Visitation</strong></p>

<p>Guests and invitees are expected to abide by these House Rules and all other rules and regulations. Individual Tenant is responsible for the behavior of his/her guests and invitees, including restitution for damages caused by such Individual Tenant's guests and invitees. In order to have a guest(s) or invitee(s), Individual Tenant must have the consent of the other Individual Tenants of the Apartment Unit on each occasion. Extended visits (i.e., more than 3 consecutive days, or more than 5 days in any 2 week period) are not permitted, nor is cohabitation (residency with someone other than an Authorized Occupant provided for in the Lease).</p>

<p><strong>Housekeeping/Trash Removal</strong></p>

<p>Individual Tenants are responsible for routine cleaning of their Apartment Units, and maintaining order in all common areas, such as hallways, stairwells. Hallways and stairwells must be kept free of personal belongings. Lessor may offer optional housekeeping services for the Apartment Unit for a fee. Periodic cleaning of common areas of the Apartment Building outside of each Apartment Unit will be provided by Lessor. Individual Tenants shall maintain their exclusive use Bedrooms and non-exclusive use shared Living Room, Kitchen and Bathroom in an orderly and sanitary condition. This includes removal of personal trash (such as trash bags, pizza boxes, etc.) to a trash bin or dumpster and recycling as provided. Individual Tenants may be charged a fee for the removal of their personal trash from common areas in the Apartment Building.</p>

<p><strong>Inspections/Unit Entry</strong></p>

<p>Authorized representatives of Lessor may enter an Individual Tenant's Apartment Unit:</p>

<ul>
	<li>For the purpose of assuring fire protection, life safety, sanitation or scheduled maintenance and proper use of Lessor's furnishings, fixtures, equipment, appliances, property and facilities. Any such inspections or entry, except in the case of emergencies, shall be announced twenty-four (24) hours in advance by providing notice to the Individual Tenants of the Apartment Unit or the posting of a notice in common areas of the Apartment Building. Individual Tenant's absence will not prevent the carrying out of such maintenance or safety inspections.</li>
	<li>When Individual Tenant has requested repairs or extermination by delivering a written request for work to Lessor's representative, workers may enter Individual Tenant's Apartment Unit in his/her absence.</li>
	<li>If an Individual Tenant moves out of an Apartment Unit, the Lessor or its representative may enter the Apartment Unit following the completion of the move to inspect for damages and insure space is available for a new occupant.</li>
	<li>To verify that all vacancies are prepared for new occupants. Cleaning and other charges may be imposed on an Individual Tenant if his/her Apartment Unit is not ready for a new occupant.</li>
	<li>If noise (unattended loud music, alarm clock, etc.) coming from an Apartment Unit where the occupants are not present is causing a disruption to the community.</li>
	<li>To unlock a Bathroom door if it is reasonable to assume that other Individual Tenants and Authorized Occupants will be gone overnight and/or being locked out of the Bathroom creates a major inconvenience or presents a safety hazard to locked-out Individual Tenant(s) or Authorized Occupants.</li>
	<li>In any circumstance where Lessor's representative reasonably believes in good faith that a health or safety issue or threat exists, including for example illegal drug use or illegal presence of weapons.</li>
</ul>
<p>Lessor's policy prohibits staff Residents from unlocking Apartment Unit doors and exclusive use Bedroom doors for anyone other than the Individual Tenant or other Authorized Occupant of the Apartment Unit and exclusive use Bedroom.</p>


<p><strong>Maintenance</strong></p>

<p>While Lessor will be responsible for routine maintenance, Individual Tenant is responsible for reporting maintenance concerns. Lessor will provide electrical power, heat, air-conditioning and water and maintain these utilities under controllable conditions. Individual Tenants must understand that, as a condition of their tenancy under the Lease, Lessor shall not be responsible or liable for any damage or loss to Individual Tenant's personal property while in the Apartment Unit or the Apartment Building caused by the cessation or failure of such utilities. Moreover, Lessor will not be in breach of the Lease if such utility service is suspended for any reason.</p>

<p><strong>Repairs</strong></p>
<p>Requests for repairs should be made in writing to Lessor's on site representative. If the repair is not made within a reasonable amount of time, a second request should be submitted by Individual Tenant.</p>

<p><strong>Prohibited Items in the Building</strong></p>

<p>Some examples of items not permitted in the Apartment Building or any Apartment Unit are listed here; however, this list is not necessarily all-inclusive: animals (except service and comfort animals as permitted under applicable law), non-fused extension cords, outside antennas, bread machines, candles, incense, ceiling fans, chain locks, dead-bolt locks, explosives, firearms, fireworks, gasoline and other combustible liquids, hot pots, immersion coils, oil lamps, open flames, space heaters, torchiere-style (pole) halogen lamps, waterbeds and weapons. Live cut Christmas trees are not permitted in the Apartment Building or any Apartment Unit except with the prior written consent of Lessor.</p>

<p><strong>Unit Changes</strong></p>

<p>Individual Tenants may not move from one Apartment Unit to another or from one exclusive use Bedroom to another within the same Apartment Unit without prior written consent from Lessor which consent may be withheld in Lessor's sole discretion. Violation of this requirement is a violation of the Lease which may result in termination or in a charge to Individual Tenant in an amount equal to one-month's rent under the Lease, and the failure of Individual Tenant to pay such charge by the deadline indicated by Lessor will result in the termination of the Lease. Individual Tenants interested in changing his or her Apartment Unit or exclusive use Bedroom may make application to Lessor. Once a change has been granted, Such Individual Tenant should complete his or her move within 48 hours or as otherwise agreed to by Lessor.</p>

<p><strong>Safety and Security</strong></p>

<ol>
	<li>Lessor cannot guarantee the safety and security of Individual Tenants, and their Authorized Occupants, guests and invitees. Individual Tenants are responsible for their personal security and that of their belongings within the Apartment Unit and the Apartment Building.</li>
	<li>Individual Tenants and their Authorized Occupants, guests and invitees may not engage in any activity which creates a safety risk or which jeopardizes the security of the Apartment Building or other Individual Tenants and their Authorized Occupants, guests and invitees. For safety reasons the roofs (except for recreational roof terraces), porches, fire escapes (except in the case of an emergency requiring emergency egress), window ledges, unfinished attics and mechanical equipment rooms of the Apartment Building are restricted areas and may not be accessed.</li>
	<li>Individuals observed in the hall who are not Individual Tenants or their Authorized Occupants, guests or invitees that are no properly registered at the front desk should be reported immediately to Lessor's representative or the police. All individuals who are not Individual Tenants or their Authorized Occupants, guests or invitees staying in the Apartment Building beyond a reasonable time for visitation constitute trespassers and may be removed by Lessor with or without police assistance. No Individual Tenant shall allow any guest or invitee to stay overnight in any common area of the Apartment Building.</li>
	<li>Permanent electrical circuits cannot be altered by occupants or anyone not authorized by Lessor.</li>
	<li>Appliances, lamps and other electrical equipment with damaged, worn, cracked, or frayed cords and plugs must be replaced.</li>
	<li>All lighting fixtures must use only light bulbs of type and wattage as recommended by the manufacturer. Lamp shades must also meet manufacturer specifications for the specific fixture.</li>
	<li>Electrical cords or other communication cables may not be installed under carpets, hung over nails or run through doorways and windows.</li>
	<li>The following are prohibited in Apartment Units: multi-plug adapters (the type that are affixed directly to the wall outlet), cube adapters, unfused power strips or items such as air fresheners that include an outlet on them.</li>
	<li>Grounded relocatable power taps or "surge protector strips" with heavy duty cords and a "reset" switch will be the only allowable receptacle extensions from wall outlets. Each power tap will be connected directly into a wall receptacle and they shall not be plugged into one another.</li>
	<li>Non-fused extension cords and flexible cords are prohibited in the Apartment Unit and Apartment Building.</li>
	<li>OPEN FLAMES (from any source) and burning materials of any kind are absolutely prohibited in the Apartment Unit and the Apartment Building.</li>
	<li>The integrity of all ceilings, floors and walls must remain intact and not be disturbed. Also, light fixtures must have proper globe or deflector in place. Any open bulb fixtures are a fire hazard and should be reported.</li>
	<li>Additional wall coverings (e.g., paneling, wallpaper, etc.) must not be installed by Individual Tenants or their Authorized Occupants.</li>
	<li>Candles and incense are prohibited in the Apartment Unit and the Apartment Building, even if such items are unlit or being used for decorative purpose only.</li>
	<li>No more than 10% of an Apartment Unit's wall surface area may be covered by potentially flammable objects. This includes but is not limited to posters, framed pictures, photos, flags, tapestries or any other decorative objects that are mounted on the wall. Individual Tenants in Apartment Units that surpass this 10% level may be required to remove items as necessary. In addition, wall hangings cannot contact electrical outlets or come closer than 12 inches to any heating unit. All ceiling decorations are prohibited.</li>
	<li>Only authorized window coverings may be used by Individual Tenants and their Authorized Occupants and must carry a recognized fire rating and be constructed of fire retardant material. No sheets, towels, flags or other materials may be used as window coverings.</li>
	<li>Living areas must be kept uncluttered and access to the doors clear. Hallways and stairways must remain clear and unobstructed.</li>
	<li>At no time may the maximum capacity restrictions of an Apartment Unit or the Apartment Building be exceeded.</li>
</ol>

<p>Any violation of the foregoing safety and security rules shall be corrected by Individual Tenant immediately upon notice. Any continuing violation after notice shall constitute an Individual Tenant default of the Lease.</p>

<p><strong>Smoke-Free</strong></p>

<p>The Apartment Unit and the Apartment Building are smoke-free, unless expressly authorized by Landlord. Tenants and their guests must refrain from smoking at any time they are physically present in the Apartment Unit and other parts of the Apartment Building.</p>

<p><strong>Storage</strong></p>

<p>Lessor does not provide storage for use by Individual Tenants. Nothing may be stored in any area outside of Individual Tenant's Apartment Unit.</p>

<p><strong>Capacity Numbers</strong></p>

<p>Based on fire safety no Individual Tenant shall exceed the maximum legal capacity of any Apartment Unit or his or her exclusive use Bedroom. Individual Tenants and their Authorized Occupants may not have assemblages or parties within their Apartment Units, or elsewhere in the Apartment Building except with the prior written consent of Lessor.</p>

<p><strong>Decorations Policy</strong></p>

<p>Individual Tenants are permitted to decorate their Apartment Units as long as they adhere to the following policies:</p>
<ol>
	<li>Smoke detectors, sprinklers, fire alarms and light fixtures must remain uncovered. Tenants must not drape or attach decorations to these items.</li>
	<li>Decorations must not obstruct hallways, fire exits, exit signs and access  to fire safety equipment.</li>
	<li>All light bulbs and light strings generate enough heat to ignite paper and cloth. Individual Tenants must ensure that light bulbs and light strings do not come into contact with anything flammable.</li>
	<li>String lights or light ropes can be used to decorate Individual Tenant's exclusive use Bedrooms. Decorative lights must either be plugged directly into an outlet or into a surge protector. Individual Tenants may run decorative light strings in series up to 3 strings per outlet. The use of string lights in public areas is prohibited.</li>
	<li>No crimping of cords may occur, or no cords shall be placed under doorways or windows.</li>
	<li>For everyone's safety, lights must be turned off when the area is unattended.</li>
	<li>Use of live garland, greenery, wreaths, leaves, twigs, bamboo, branches, hay or sand as decoration is prohibited. Floors must not be covered with any material other than carpet or rugs.</li>
	<li>Decorations placed in the Apartment Unit but outside of an Individual Tenant's exclusive use Bedroom shall be consented to by each Individual Tenant of the Apartment Unit.</li>
</ol>

<p><strong>Painting Rooms</strong></p>

<p>Individual Tenants and their Authorized Occupants may not paint their rooms in any other color, or add murals or border designs to their Apartment Unit walls or ceilings, including their exclusive use Bedrooms.</p>

<p><strong>Quiet Hours, Noise, Vibration and Odors</strong></p>

<p>No Individual Tenant shall make or permit any disturbing noises, vibration, odors or conduct activities in the Apartment Unit or the Apartment Building, nor do or permit anything by such persons that will constitute a nuisance to or interfere with the rights, comforts, or convenience of other Individual Tenants, Authorized Occupants, and their guess and invitees. No musical instruments, television, radio, CD player, videogames, loud speakers or similar devices shall be used in Individual Tenant's Apartment Unit between the hours of 10:00 PM and 8:00 AM. if the same shall disturb or annoy any other occupant of the Apartment Unit or the Apartment Building. No construction, repair work or other installation by Individual Tenant that involves noise or vibrations shall be conducted except on weekdays, excluding legal holidays, and only between the hours of 9:00 a.m. to 5:00 p.m.</p>

<p><strong>Substance-Free</strong></p>

<p>Smoking is not permitted anywhere in the Apartment Unit, the Apartment Building or immediately in front of the Apartment Building, unless expressly authorized by Landlord.</p>

<p>Moderate and lawful consumption of alcohol is permitted within the Apartment Unit and in common areas of the Apartment Building designated for social activities and gathering of Individual Tenants and their Authorized Occupants.</p>

<p><strong>Bicycles</strong></p>

<p>Individual Tenants and their Authorized Occupants, guests and invitees must store their bicycles in the Individual Tenant's Apartment Unit or in areas of the Apartment Building designated for bicycle storage, if any. Bicycles may not be left in the lobby, hallways, laundry room, maintenance rooms or any other common area of the Apartment Building.</p>

<p><strong>No AIRBNB or Other Short Term Rentals.</strong></p>

<p>Marketing any Apartment Unit or exclusive use Bedroom on Airbnb, Craigslist, Couchsurfer (and/or any similar marketing websites, media and/or services) or permitting the Apartment Unit or exclusive use Bedroom to be used for a short term rental, is strictly prohibited.</p>

<p><strong>Costs of Enforcement</strong></p>

<p>In the event legal action is required to enforce the provisions of these House Rules or the Lease, Lessor shall have the right to seek damages and/or equitable remedies (including eviction of the Individual Tenant and his or her Authorized Occupants) through the New York Superior Court, and in such event the prevailing party shall be entitled to recover reasonably incurred attorneys' fees and other related costs.</p>

<p><strong>Move-in and Move-out Times</strong></p>

<p>Move-in times are between 4pm - 8pm. Move-out must occur until 12pm on the last day of the Lease Agreement.</p>


<h2>CODE OF CONDUCT FOR ALL RESIDENTS</h2>

<ol>
	<li>In order for you to have a pleasant experience in your apartment share with, you must abide  by and accept the principles of cohabitation. This includes consideration, tolerance, and a willingness to compromise amongst each other as well as the neighbors. All Residents must organize amongst each other how to maintain their cohabitation fairly and with consideration of the interests of all Residents.</li>
	<li>Residents may enjoy general community spaces and community facilities at {$contract_info->rental_address} buildings, which are not located in Individual Apartments. Amongst others and depending on availability, such may include bars, dining rooms, movie theatres, laundry rooms, outside areas, or reading corners. Enjoyment of such facilities is only permitted to Residents of the building. Without consent of the Owner or Manager, family Residents, friends, or visitors do not have the right to enjoy community spaces or facilities.</li>
	<li>Guests and invitees are expected to abide by this Code and all other rules and regulations. Residents are responsible for the behavior of his/her guests and invitees, including restitution for damages caused by such Resident’s guests and invitees. Extended  visits (i.e., more than 3 consecutive days, or more than 5 days in any 2-week period) are not permitted.</li>
	<li>Individuals observed in the hall who are not Residents or their Authorized Occupants, guests or invitees that are not properly registered should be reported immediately to OWNERS’ representative or the police. All individuals who are not Residents or their Authorized Occupants, guests or invitees staying in the Apartment Building beyond a reasonable time for visitation constitute trespassers and may be removed with or without police assistance. No Resident shall allow any guest or invitee to stay overnight in any Common Area of the Apartment Building.</li>
	<li>In order to avoid disturbing neighbors and other Residents, large private gatherings in the Apartment or the Building are generally prohibited. Everyone should be able to study, work or sleep undisturbed in their rooms if they wish. Therefore, you should not make or  permit any disturbing noises, vibration, odors or conduct activities in the Apartment Unit or the Apartment Building, nor do or permit anything by such persons that will constitute a nuisance to or interfere with the rights, comforts, or convenience of the neighbors, other Residents and their guests and invitees. Noisy parties in the Apartment Building are generally prohibited. All loud activities should be decreased to room level volume by 10:00pm. Special care must be taken to avoid any noise disturbance between between 10:00pm and 8:00am. Loud noise is strictly forbidden on Sundays and the holidays. Stereos, televisions, etc. are to be operated at room level volume. Playing instruments during daytime hours, between 7:00pm and 8:00am is generally forbidden. Instruments should not be played for longer than two hours during the rest of the day.</li>
	<li>To preserve the Residents and their Authorized Occupants' health and safety, no pets or other animals are permitted in any area inside the Apartment Building, except for service or comfort animals permitted by applicable laws. The harboring of a dog, cat, bird or any other animal constitutes a material violation of a substantial obligation of the Lease.</li>
	<li>Keep your Apartment and the Common Areas clean and uncluttered. Residents are  responsible for routine cleaning and maintaining order in all Common Areas, such as hallways and stairwells. This includes removal of personal trash (ex: trash bags, pizza boxes, etc.) to a trash bin or dumpster and recycling as provided, according to the Statute Law of the city. You should break down cardboard boxes that you dispose of in the recycling areas. Any kind of rubbish, food rests, oils or other objects that could clog the drainage system should not be rinsed down the drainpipes - especially in the bath, kitchen and toilet. These objects are to be disposed of in the intended garbage containers. In case of non- compliance with these rules, you may be charged a fee for the removal of your personal trash from Common Areas in the Apartment Building.</li>
	<li>Residents and their Authorized Occupants must store their bicycles in the areas designated for bicycle storage, if any. Bicycles may not be left in the lobby, hallways, laundry room, maintenance rooms or any other Common Areas of the Apartment Building.</li>
	<li>The storage of hazardous, flammable or strong smelling substances on the property is not allowed. Some examples of items not permitted in the Apartment Building or any Apartment Unit are listed here; however, this list is not necessarily all-inclusive: animals (except service and comfort animals as permitted under applicable law), non-fused extension cords, outside antennas, bread machines, candles, incense, ceiling fans, chain locks, dead-bolt locks, explosives, firearms, fireworks, gasoline and other combustible liquids, hot pots, immersion coils, oil lamps, open flames, multi-plug adapters, cube adapters, unfused power strips or items such as air fresheners that include an outlet on them, space heaters, torchiere-style (pole) halogen lamps, waterbeds and weapons. Live cut Christmas trees are not permitted in the Apartment Building or any Apartment Unit.</li>
	<li>We have absolutely no lenience towards illegal drugs. The possession or consumption of any illegal substance are strictly forbidden at the property. Smoking is also prohibited anywhere in the Apartment Unit, the Apartment Building or immediately in front of the Apartment Building. Moderate and lawful consumption of alcohol is permitted within the Apartment Unit and in common areas of the Apartment Building designated for social activities and gathering of Residents and their Authorized Occupants.</li>
	<li>No Resident is allowed to remove, change or bring any furniture, fixtures, equipment, appliances and other property into the Common Areas of the Apartment Building. Attaching pictures, shelves, etc. with nails, screws or screw anchors, as weil as posting signs or inscriptions of any sort within the Apartments and the Common Rooms is strictly forbidden,</li>
	<li>We have the doorbell nameplates standardly lettered with the building address, to insure the postal deliveries. The lettering on the mailboxes is not to be altered. lt's sufficient if you simply use the property’s address and your unit number to receive mail. Attaching personalized signs, warnings, etc. is only allowed if previously authorized by Management.</li>
	<li>Pay your Rent and other charges on time and by the first working day of every month.  This saves us and you a lot of stress. You will find the accepted forms and conditions of payment in your Lease.</li>
	<li>Inform us of damages to the property as soon as possible. This will ensure your liability exclusion if you did not cause the damage. Requests for repairs should be made via the portal that Management provides. lf the repair is not made within a reasonable amount of time, a second request should be submitted. Residents are responsible for any damage or loss caused or non-routine cleaning or trash removal required to the common areas of the Apartment Building and their furnishings, including vending machines and other equipment placed in the Apartment Building as a convenience to Residents and Authorized  Occupants. Common areas outside of Apartment Units include corridors, recreation rooms, kitchens, study rooms, living rooms, laundry rooms, public bathrooms and lounges. When damage occurs, Residents will be billed directly for the repairs. We shall have the authority to assess and assign charges for these damages. lf the responsible party for the damages cannot be determined, charges for damages, cleaning, replacement of furniture, etc. may be charged to all of the Residents of an apartment unit. lf one or more Residents or their Authorized Occupants assume responsibility for damages, cleaning, replacement of furniture, etc., a written statement signed by the responsible party must be noted in writing and delivered to us at the time of surrendering occupancy. Charges will not be assessed to one Resident based solely on another Resident’s claim of wrongdoing.</li>
	<li>We will be responsible for routine maintenance, Residents are responsible for reporting maintenance concerns. We will provide electrical power, heat and water and maintain these utilities under controllable conditions. Management, as well as the gas or water supply service companies,  must  be informed immediately in case of leakage or other defects. lf a gas smell is noticed do not enter the room with open light and do not operate any electronic switches or devices. Open the windows and seal the man stopcock immediately. Residents must understand that, as a condition of their tenancy, we shall not be responsible or liable for any damage or loss to Resident’s personal property while in the Apartment Building caused by the cessation or failure of such utilities, no matter the reason. Moreover, we will not be in breach of the Lease if such utility service is suspended for any reason.</li>
	<li>We cannot guarantee the safety and security of Residents and their Authorized Occupants, guests and invitees. Residents are responsible for their personal security and that of their belongings within the Apartment Building. For your and the other Residents safety, the entrance doors to the Apartment Building are to be closed between 10:00pm and 06:00am. Stairs, halls and entrances must remain accessible between 10:00pm and 06:00am to be used as escape routes in case of emergency.</li>
	<li>Residents and their Authorized Occupants may not engage in any activity which creates a safety risk or which jeopardizes the security of the Apartment Building or other Residents and their Authorized Occupants. For safety reasons the roofs, porches, fire escapes, window ledges, unfinished attics and mechanical equipment rooms of the Apartment Building are restricted areas and may not be accessed. Grilling and barbeques are only allowed in the facilities available in the Apartment Building for that purpose, if applicable.</li>
</ol>

{foreach $contract_users as $user}
{if $user->id != $contract_user->id}
<p>TENANT NAME: {$user->name|escape}<br/>
	{if $user->log && $booking->client_type_id != 2}
	DATE: {$user->log->date|date}<br/>
	SIGNATURE:<br/>
	<img src="{$config->contracts_dir}{$contract_info->url}/signature-{$user->id}.png" alt="Signature {$user->name|escape}" width="180" />
	{/if}
</p>
{/if}
{/foreach}

<p>TENANT NAME: {$contract_user->name|escape}<br/>
{if $booking->client_type_id != 2}
	{if $contract_info->signing == 1}
		DATE: {$contract_info->date_signing|date}<br/>
	{/if}
		SIGNATURE:<br>
{/if}
</p>

{if $booking->client_type_id == 2 && $booking->airbnb_reservation_id}
<p>Digital Signature ID: {$booking->airbnb_reservation_id}</p>
{elseif $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree2" for="agree2">I agree and sign</label><input type="checkbox" id="agree2" name="agree2" class="agree" value="1"></p>
{/if} 

<br>
<br>
<br>

<hr>

<br>
<br>
<br>

<p><strong>Rider No. 3 – Window Guard Notification and Disclosure </strong></p>

<h2>Window Guard Notification and Disclosure</h2>

<p>Name of tenant(s): <strong>{foreach $contract_users as $user}{if $contract_user->id != $user->id}{$user->name|escape}, {/if}{/foreach}{$contract_user->name|escape}</strong></p>
<p>Subject Premises: <strong>{$contract_info->rental_address}</strong></p>

<p>Apt. #: <strong>{$apartment->name}</strong></p>
<p>Date of vacancy lease: <strong>{$contract_info->date_from|date}</strong></p>

<p><strong>Individual Tenant is required by law</strong> to have window guards installed if a child 10 years or younger lives in your Apartment Unit.</p>
<p><strong>Lessor is required</strong> by law to install window guards in your Apartment Unit:</p>

<ul>
	<li>if you ask Lessor to put window guards at any time (you need not give a reason)</li>
</ul>
<p>OR</p>
<ul>
	<li>if a child 10 years of age or younger lives in your apartment</li>
</ul>

<p><strong>It is a violation of law</strong> to refuse, interfere with installation, or remove window guards where required.</p>

<p><strong>CHECK ONE</strong></p>
{if $contract_info->signature || $booking->client_type_id == 2}
<ul>
	<li>[{if $contract_info->options['children']==1 || $booking->client_type_id == 2}x{else} {/if}] CHILDREN 10 YEARS OF AGE OR YOUNGER LIVE IN MY APARTMENT UNIT</li>
	<li>[{if $contract_info->options['children']==2}x{else} {/if}] NO CHILDREN 10 YEARS OF AGE OR YOUNGER LIVE IN MY APARTMENT UNIT</li>
	<li>[{if $contract_info->options['children']==3}x{else} {/if}] I WANT WINDOW GUARDS EVEN THOUGH I HAVE NO CHILDREN 10 YEARS OF AGE OR YOUNGER</li>
</ul>
{else}
<ul>
	<li><input type="radio" id="children1" name="children" class="agree" value="1" required><label id="block_children1" for="children1">CHILDREN 10 YEARS OF AGE OR YOUNGER LIVE IN MY APARTMENT UNIT</label> </li>
	<li><input type="radio" id="children2" name="children" checked class="agree" value="2" required><label id="block_children2" for="children2">NO CHILDREN 10 YEARS OF AGE OR YOUNGER LIVE IN MY APARTMENT UNIT</label></li>
	<li><input type="radio" id="children3" name="children" class="agree" value="3" required><label id="block_children3" for="children3">I WANT WINDOW GUARDS EVEN THOUGH I HAVE NO CHILDREN 10 YEARS OF AGE OR YOUNGER</label></li>
</ul>
{/if}

<p>Acknowledged, understood, and agreed:</p>

<p>This document was issued electronically and is therefore valid without signature.</p>

<p>FOR FURTHER INFORMATION CONTACT:</p>
<p>Window Falls Prevention Program New York City Department of Health </p>
<p>125 Worth Street, Room 222A</p>
<p>New York, New York 10013</p> 
<p>Tel: (212) 566-8082</p>

{foreach $contract_users as $user}
{if $user->id != $contract_user->id}
<p>TENANT NAME: {$user->name|escape}<br/>
	{if $user->log && $booking->client_type_id != 2}
	DATE: {$user->log->date|date}<br/>
	SIGNATURE:<br/>
	<img src="{$config->contracts_dir}{$contract_info->url}/signature-{$user->id}.png" alt="Signature {$user->name|escape}" width="180" />
	{/if}
</p>
{/if}
{/foreach}

<p>TENANT NAME: {$contract_user->name|escape}<br/>
{if $booking->client_type_id != 2}
{if $contract_info->signing == 1}
	DATE: {$contract_info->date_signing|date}<br/>
{/if}
	SIGNATURE:<br>
{/if}
</p>

{if $booking->client_type_id == 2 && $booking->airbnb_reservation_id}
<p>Digital Signature ID: {$booking->airbnb_reservation_id}</p>
{elseif $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree3" for="agree3">I agree and sign</label><input type="checkbox" id="agree3" name="agree3" class="agree" value="1"></p>
{/if} 


<br>

<br>

<hr>

<br>
<br>
<br>

<p><strong>Rider No. 4 – Bedbug Infestation History</strong></p>
<div class="center">
	<p><strong>NOTICE TO TENANT</strong></p>
	<h2>DISCLOSURE OF BEDBUG INFESTATION HISTORY</h2>
</div>

<p>Pursuant to the NYC Housing Maintenance Code, an owner/managing agent of residential rental property shall furnish to each tenant signing a vacancy lease a notice that sets forth the property's bedbug infestation history.</p>

<p>Name of tenant(s): <strong>{foreach $contract_users as $user}{if $contract_user->id != $user->id}{$user->name|escape}, {/if}{/foreach}{$contract_user->name|escape}</strong></p>
<p>Subject Premises: <strong>{$contract_info->rental_address}</strong></p>

<p>Apt. #: <strong>{$apartment->name}</strong></p>
<p>Date of vacancy lease: <strong>{$contract_info->date_from|date}</strong></p>

<p>BEDBUG INFESTATION HISTORY (Only boxes checked apply)</p>
<ul>
	<li>[X] There is no history of any bedbug infestation within the past year in the building or in any apartment.</li>
	<li>[ ] During the past year the building had a bedbug infestation history that has been the subject of eradication measures. The location of the infestation was on the floor(s).</li>
	<li>[ ] During the past year the building had a bedbug infestation history on the floor(s) and it has not been the subject of eradication measures.</li>
	<li>[ ] During the past year the apartment had a bedbug infestation history and eradication measures were employed.</li>
	<li>[ ] During the past year the apartment had a bedbug infestation history and eradication measures were not employed.</li>
</ul>

{foreach $contract_users as $user}
{if $user->id != $contract_user->id}
<p>TENANT NAME: {$user->name|escape}<br/>
	{if $user->log && $booking->client_type_id != 2}
	DATE: {$user->log->date|date}<br/>
	SIGNATURE:<br/>
	<img src="{$config->contracts_dir}{$contract_info->url}/signature-{$user->id}.png" alt="Signature {$user->name|escape}" width="180" />
	{/if}
</p>
{/if}
{/foreach}

<p>TENANT NAME: {$contract_user->name|escape}<br/>
{if $booking->client_type_id != 2}
{if $contract_info->signing == 1}
	DATE: {$contract_info->date_signing|date}<br/>
{/if}
	SIGNATURE:<br>
{/if}
</p>

{if $booking->client_type_id == 2 && $booking->airbnb_reservation_id}
<p>Digital Signature ID: {$booking->airbnb_reservation_id}</p>
{elseif $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree4" for="agree4">I agree and sign</label><input type="checkbox" id="agree4" name="agree4" class="agree" value="1"></p>
{/if} 

<br>
<br>

<hr>

<br>
<br>
<br>

<p><strong>Rider No. 5 – Lead paint</strong></p>

<h1>Disclosure of Information on Lead-Based Paint and/or Lead-Based Paint Hazards</h1>
<p><strong>Lead Warning Statement</strong></p>
<p>Housing built before 1978 may contain lead-based paint. Lead from paint, paint chips, and dust can pose health hazards if not managed properly. Lead exposure is especially harmful to young children and pregnant women. Before renting pre-1978 housing, lessors must disclose the presence of know lead-based paint and/or lead-based paint hazards in the dwelling. Lessees must also receive a federally approved pamphlet on lead poisoning prevention.</p>
<p><strong>Lessor’s Disclosure</strong></p>
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
<p><strong>Lessee’s Acknowledgment (initial)</strong></p>
<ul>
	<li>(c) Lessee has received the pamphlet Protect Your Family from Lead in (d) Your Home.</li>
	<li>(d) Lessee has received copies of all information listed above.</li>
</ul>
<p><strong>Agent’s Acknowledgment (initial)</strong></p>
<ul>
	<li>(e) Agent has informed the lessor of the lessor’s obligations under 42 U.S.C. 4852d and is aware of his/her responsibility to ensure compliance.</li>
</ul>
<p><strong>Certification of Accuracy</strong></p>
<p>The following parties have reviewed the information above and certify, to the best of their knowledge, that the information they have provided is true and accurate.</p>

{foreach $contract_users as $user}
{if $user->id != $contract_user->id}
<p>TENANT NAME: {$user->name|escape}<br/>
	{if $user->log && $booking->client_type_id != 2}
	DATE: {$user->log->date|date}<br/>
	SIGNATURE:<br/>
	<img src="{$config->contracts_dir}{$contract_info->url}/signature-{$user->id}.png" alt="Signature {$user->name|escape}" width="180" />
	{/if}
</p>
{/if}
{/foreach}

<p>TENANT NAME: {$contract_user->name|escape}<br/>
{if $booking->client_type_id != 2}
{if $contract_info->signing == 1}
	DATE: {$contract_info->date_signing|date}<br/>
{/if}
	SIGNATURE:<br>
{/if}
</p>

{if $booking->client_type_id == 2 && $booking->airbnb_reservation_id}
<p>Digital Signature ID: {$booking->airbnb_reservation_id}</p>
{elseif $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree5" for="agree5">I agree and sign</label><input type="checkbox" id="agree5" name="agree5" class="agree" value="1"></p>
{/if} 

<br>

<hr>

<br>
<br>
<br>

<p><strong>Rider No. 6 Smoke Detector Acknowledgement</strong></p>

<p>Lessee(s) hereby acknowledge receipt from Lessor, as manager of the building for the owner, its beneficiaries, agents and partners (collectively, "Lessor"), approved smoke detector(s) which are in good working order on the date hereof for installation by Lessor. Lessee fully understands that a tenant, at their sole costs, shall be responsible for maintaining or replacing such detectors in accordance with the written information and instructions hereby furnished and promptly notifying Lessor in writing of any deficiencies therein. Lessee hereby authorizes Lessor to charge all costs and expenses for repairing and/or replacing such detectors if such is deemed necessary by Lessor due to Lessee failing to satisfy its responsibilities. Lessee hereby knowingly and voluntarily forever waives and releases Lessor, its successors and assigns, from any and all responsibility, claims, damages and demands whatsoever resulting directly or indirectly from the failure of such detectors to function properly.</p>

<p><strong>Ventilation Acknowledgement</strong></p>

<p>Lessee has inspected the aforementioned premises and certifies that he/she has not observed mold, mildew or moisture within the premises. Lessee agrees to immediately notify Lessor if he/she observes mold/mildew and or moisture conditions (from any source, including leaks) and allow Lessor to evaluate and make recommendations and/or take appropriate corrective action. Lessee relieves Lessor from any liability for any personal injury or damages to property cause by or associated with the growth of or occurrence of mold, mildew, or moisture on the premises.</p>
<p>Please be advised that when Lessee exercise proper ventilation and moisture control precautions, it will enhance comfort and safety. Please adopt the following guidelines, if applicable, to avoid developing excessive moisture in your home.</p>
<p>Ventilate your home daily. Constant fresh airflow is imperative to help prevent moisture from becoming trapped within your home.</p>
<p>Use of your ceiling fan on the low setting will help maintain air flow through your residence while you are away for a long period of time.</p>
<p>Always operate your bathroom fan when showering.</p>

<p>Use of dehumidifying crystals is suggested for closet areas where ventilation and airflow is difficult to achieve.</p>
<p>Report excessive moisture to Management.</p> 

<p>ACCEPTED: Lessee</p>

<p>By: {$contract_user->name|escape}<br/>
{if $booking->client_type_id != 2}	
{if $contract_info->signing == 1}
	DATE: {$contract_info->date_signing|date}<br/>
{/if}
	SIGNATURE:<br>
{/if}
</p>

{if $booking->client_type_id == 2 && $booking->airbnb_reservation_id}
<p>Digital Signature ID: {$booking->airbnb_reservation_id}</p>
{elseif $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree6" for="agree6">I agree and sign</label><input type="checkbox" id="agree6" name="agree6" class="agree" value="1"></p>
{/if} 

<br>
<br>

<hr>

<br>
<br>
<br>

<p><strong>Rider No. 7 – Human Rights</strong></p>
{include file='contracts/bx/rider_accommodations.tpl'}


<p><strong>Rider No. 8 – Fee Catalog</strong></p>

<h1>FEE CATALOG – 186N6 <br>Owner LLC</h1>

<table>
	<tr>
		<th>Service Fees</th>
		<th>Cost In USD</th>
	</tr>
	<tr>
		<td>Disturbing quiet hours (10pm - 9am)</td>
		<td>$100.00</td>
	</tr>
	<tr>
		<td>Late Payment Fee</td>
		<td>As per lease</td>
	</tr>
	<tr>
		<td>Lockout Fee</td>
		<td>$150.00</td>
	</tr>
	<tr>
		<td>Cleaning Fee - Building Shared Spaces</td>
		<td>$250.00</td>
	</tr>
	<tr>
		<td>Cleaning Fee - Barbecue</td>
		<td>$250.00</td>
	</tr>
	<tr>
		<td>Pest Attraction fee</td>
		<td>$300.00</td>
	</tr>
	<tr>
		<td>Unplugging camera Fee</td>
		<td>$250.00</td>
	</tr>
</table>
<table>
	<tr>
		<th>Keys/Fobs/Locks</th>
		<th>Cost In USD</th>
	</tr>
	<tr>
		<td>Lost Fob</td>
		<td>$180.00</td>
	</tr>
	<tr>
		<td>Lost Mailbox Key</td>
		<td>$45.00</td>
	</tr>
	<tr>
		<td>Lost Building Key</td>
		<td>$45.00</td>
	</tr>
	<tr>
		<td>Damaged or Broken Electronic Lock</td>
		<td>$700.00</td>
	</tr>
	<tr>
		<td>Damaged or Broken Door/Mailbox Lock</td>
		<td>$200.00</td>
	</tr>
	<tr>
		<td>Delayed Return of Keys (Per Day)</td>
		<td>$50.00</td>
	</tr>
</table>
<table>
	<tr>
		<th>Room Return - Damage or Loss</th>
		<th>Cost In USD</th>
	</tr>
	<tr>
		<td>Extra Cleaning For Dirty or Messy Room</td>
		<td>$150.00</td>
	</tr>
	<tr>
		<td>Extra Cleaning For Dirty or Messy Shared Spaces (Kitchen, Bathroom, Hallways and Living Room) in Noncompliance with Outpost Club Standards or Any Reclamation of New Tenants (cost will be divided and applied to all tenants)</td>
		<td>$300.00</td>
	</tr>
	<tr>
		<td>Smoking (room/shared spaces) – each incident</td>
		<td>$300.00</td>
	</tr>
	<tr>
		<td>Electric Socket</td>
		<td>$75.00</td>
	</tr>
	<tr>
		<td>Bed Frame (Queen)</td>
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
		<td>$100.00</td>
	</tr>
	<tr>
		<td>Wardrobe</td>
		<td>$500.00</td>
	</tr>
	<tr>
		<td>Closet (Quarters Design)</td>
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
</table>

<table>
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
		<td>$600.00</td>
	</tr>
	<tr>
		<td>TV Console</td>
		<td>$300.00</td>
	</tr>
	<tr>
		<td>Sofa (Loveseat)</td>
		<td>$800.00</td>
	</tr>
	<tr>
		<td>Kitchen Table + 4 Chairs</td>
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
		<td>Major Kitchen Appliances (Such as Refrigerator, Oven, Stovetop, Vents, Dishwasher, Washer, Dryer) - Depends on the actual cost of replacement + Labor</td>
		<td>$600.00 - $2,000.00</td>
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
		<td>$100.00</td>
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
		<td>Kitchen Accessories such as Lemon Squeezer, Glass Tupperware Set, Oven Mitts, Pot Placement, Ice Cube Tray, Paper Towel Dispenser, Can Opener, Wine Opener, Hand Towels, Measuring cups, Cutting Board, etc. (Per Item)</td>
		<td>$25.00</td>
	</tr>
	<tr>
		<td>Cookware such as Pot, Pans, Lids, Oven Pyrex, etc (Per item)</td>
		<td>$50.00</td>
	</tr>
	<tr>
		<td>Utensils & Glassware such as Pasta Ladle, Spatula, Thongs, Wisk, Ladle, Peeler, Grater, Scissors, Salt and Pepper Shakers (set), Cooking knives, Mugs, Glasses, Small and Large plates, Bowls, Wine Glasses, Salad Bowls, Cutlery (Forks, Knives, Spoons), Cake Slicer, Pizza Cutter, etc. (Per Item)</td>
		<td>$25.00</td>
	</tr>
</table>
<table>
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
		<td>$600.00</td>
	</tr>
	<tr>
		<td>Cabinets</td>
		<td>$750.00</td>
	</tr>
	<tr>
		<td>Toilet</td>
		<td>$500.00</td>
	</tr>
	<tr>
		<td>Toilet Seat</td>
		<td>$75.00</td>
	</tr>
	<tr>
		<td>Bathroom Accessories such as Plunger, Toilet Brush, Trash Can, ToothBrush Cup, Hand Soap Dispenser, Toilet Paper Holder, Towel Bar, etc. (Per Item)</td>
		<td>$45.00</td>
	</tr>
</table>

{foreach $contract_users as $user}
{if $user->id != $contract_user->id}
<p>TENANT NAME: {$user->name|escape}<br/>
	{if $user->log && $booking->client_type_id != 2}
	DATE: {$user->log->date|date}<br/>
	SIGNATURE:<br/>
	<img src="{$config->contracts_dir}{$contract_info->url}/signature-{$user->id}.png" alt="Signature {$user->name|escape}" width="180" />
	{/if}
</p>
{/if}
{/foreach}

<p>TENANT NAME: {$contract_user->name|escape}<br/>
{if $booking->client_type_id != 2}
{if $contract_info->signing == 1}
	DATE: {$contract_info->date_signing|date}<br/>
{/if}
	SIGNATURE:<br>
{/if}
</p>

{if $booking->client_type_id == 2 && $booking->airbnb_reservation_id}
<p>Digital Signature ID: {$booking->airbnb_reservation_id}</p>
{elseif $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree7" for="agree7">I agree and sign</label><input type="checkbox" id="agree7" name="agree7" class="agree" value="1"></p>
{/if} 

<br>
<br>

<hr>

<br>
<br>
<br>

{*
<p><strong>Rider No. 9 – Inventory List</strong></p>
<p>All common space furniture varies - depending on the unit size, we provide: dining table set and/or couch, coat rack, shoe rack, TV console, and coffee table. Some units have TVs while others do not.</p>
*}

{if $contract_info->rider_type == 1}
	{include file='free_rent_doc/free_rent_month.tpl'}
{elseif $contract_info->rider_type == 3}
	{include file='free_rent_doc/rider_earlymovein.tpl'}
{elseif $contract_info->rider_type == 2 && $contract_info->free_rental_amount != 0}
	{foreach $contract_users as $user}
	{if $user->id != $contract_user->id}
	<p>TENANT NAME: {$user->name|escape}<br/>
		{if $user->log && $booking->client_type_id != 2}
		DATE: {$user->log->date|date}<br/>
		SIGNATURE:<br/>
		<img src="{$config->contracts_dir}{$contract_info->url}/signature-{$user->id}.png" alt="Signature {$user->name|escape}" width="180" />
		{/if}
	</p>
	{/if}
	{/foreach}

	<p>TENANT NAME: {$contract_user->name|escape}<br/>
	{if $booking->client_type_id != 2}
	{if $contract_info->signing == 1}
		DATE: {$contract_info->date_signing|date}<br/>
	{/if}
		SIGNATURE:<br>
	{/if}
	</p>

	{if $booking->client_type_id == 2 && $booking->airbnb_reservation_id}
	<p>Digital Signature ID: {$booking->airbnb_reservation_id}</p>
	{elseif $contract_info->signature2}
		<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
	{else}
	<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree8" for="agree8">I agree and sign</label><input type="checkbox" id="agree8" name="agree8" class="agree" value="1"></p>
	{/if} 

<br>
<br>

<hr>

<br>
<br>
<br>

	<p><strong>Rider No. 9 – Free Rent</strong></p>
 	{include file='free_rent_doc/free_rent.tpl'}
	<p>By initialing below, you acknowledge and agree to the terms in Rider No. 9.</p>
{/if}


{foreach $contract_users as $user}
{if $user->id != $contract_user->id}
<p>TENANT NAME: {$user->name|escape}<br/>
	{if $user->log && $booking->client_type_id != 2}
	DATE: {$user->log->date|date}<br/>
	SIGNATURE:<br/>
	<img src="{$config->contracts_dir}{$contract_info->url}/signature-{$user->id}.png" alt="Signature {$user->name|escape}" width="180" />
	{/if}
</p>
{/if}
{/foreach}

{if $booking->client_type_id == 2 && $booking->airbnb_reservation_id}
<p>TENANT NAME: {$contract_user->name|escape}</p>
<p>Digital Signature ID: {$booking->airbnb_reservation_id}</p>
{elseif $contract_info->signature}
<p>TENANT NAME: {$contract_user->name|escape}<br/>
{if $contract_info->signing == 1}
	DATE: {$contract_info->date_signing|date}<br/>
{/if}
	SIGNATURE:<br>
</p>
<img src="{$contract_info->signature}" alt="Signature {$contract_user->name|escape}" width="180" />
{/if}
