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

{if !$apartment->furnished}
	<h1>FREE MARKET UNFURNISHED AGREEMENT</h1>
{else}
	<h1>FREE MARKET LEASE AGREEMENT</h1>
{/if}

<p>THIS LEASE is made as of {$contract_info->date_created|date}, between <strong>{$landlord->name|escape}</strong> (“Owner” or “Landlord”), acting by and through its agent, <strong>Outpost Club, Inc.</strong>, which have an address at P.O. 780316 Maspeth, NY, 11378 and <strong>{foreach $contract_users as $u}{$u->name}{if !$u@last}, {/if}{/foreach}</strong> (“You” or “Tenant”).</p>

<p>This Lease and the riders annexed hereto, contain the agreements between You and Owner concerning Your right sand  obligations  and  the  rights  and  obligations  of  Owner. You and Owner have other rights and obligations which are set forth in government laws and regulations:</p> 
<p>You  should  read  this  Lease  and  all  of  its  attached  parts  and  the  other  documents  carefully.  If  You  have  any questions, or if You do not understand any words or statements, get clarification. Once You and Owner sign this Lease, Youand Owner will be presumed to have read it and understood it. You and Owner admit that all agreements between You andOwner have been written into this Lease and the documents indicated above. You understand that any other agreements,whether made before or after this Lease was signed, will not be enforceable.</p>

<h2>ARTICLE 1 <br> APARTMENT; TENANCY AND USE</h2>

<ul>
	<li><strong>Apartment.</strong> Owner  agrees  to  lease  to  You  and  You  agree  to  rent  from  Owner, <strong>{$apartment->name}</strong>  (“Apartment”)  in  the building known as <strong>{$contract_info->rental_name|escape}</strong> and located at <strong>{$contract_info->rental_address}</strong> (“Building”).</li>
	<li><strong>Use  of  Apartment.</strong>  You  shall  use  the  Apartment  for  living  purposes  only  and  shall  not  operate  any  business within  the  Apartment,  except  that  if  any  space in the Apartment is legally designated for "home occupations" such space may  also  be  used for "home occupations" but only as permitted under applicable law. Unless You obtain the prior written consent of Owner (which Owner may withhold for any or no reason), the Apartment may only be occupied by (a) You, (b)members  of  Your  immediate  family  and  (c)  if  and  to  the  extent  that  New  York Real Property Law § 235-f applies and is non-waivable, occupants and dependent children of occupants as defined in and to the limited extent required by § 235-f.You represent to Owner that the only occupants of the Apartment (other than Tenant) are listed above. You shall promptly notify  Owner  of  any  change  in  occupancy  of  the  Apartment,  which  notice  shall  include  the  name,  date  of  birth,  social security number and relationship to Tenant of any additional occupant.</li>
</ul>

<h2>ARTICLE 2 <br> LENGTH OF LEASE</h2>

<ul>
	<li>The term (that means the length) of this Lease is for <strong>{$contract_info->lease_term} Months</strong> and commences on <strong>{$contract_info->date_from|date}</strong> and ends on <strong>{$contract_info->date_to|date}</strong>, except that, if You do not do everything You agree to do in this Lease, Owner may have the rightto end this Lease before the above date. </li>
</ul>

<h2>ARTICLE 3 <br> RENT; LATE CHARGE</h2>

<ul>
	<li>The Tenant agrees to pay <strong>{if $booking->client_type_id==2}{$booking->airbnb_reservation_id}{else}{$contract_info->price_month|convert} (US Dollars){/if}</strong> as rent, to be paid as follows: <strong>{if $booking->client_type_id==2}{$booking->airbnb_reservation_id}{else}{$contract_info->price_month|convert} (US Dollars) per month due on the 1st day of each month{/if}</strong>. The first payment of rent and any security deposit is due upon the signing of this lease by the Tenant. If You fail to make a payment of all or any part of the monthly rent for the Apartment within 5 days of its due date You shall pay to Owner,as additional rent, a late charge of $100. The Tenant must also pay a fee of $60 as additional rent for any dishonored check. The Tenant must also pay attorney fees & court costs related to any eviction as additional rent.</li>
	<li>You must pay Owner the rent, in advance, on the first day of each month either at the address specified in a rentbill  or,  if  you  do  not  receive  a  bill, at the address stated above, or through Owner's online payment service or at another place  that  Owner  may  inform  You  of  by  written  notice.  If  you  pay  by  check or money order, You must pay with a single check or money order for the entire month's rent, even if there is more than one person signing this Lease as Tenant. </li>
	<li><strong>Leasing  Incentive.</strong>  If  Tenant  is  entitled  to  any  rent-free  month(s)  during  the  term  of  the  Lease  (“Leasing Incentive”),  said  Leasing  Incentive  is  conditional  upon  Tenant  fulfilling  all  Tenant’s  obligations  and  complying  with  all provisions of the Lease, including but not limited to, the terms relating to abandonment of the Apartment under Article 13. 2and all provisions relating to eviction of Tenant. If Tenant fails to comply with any obligation under the Lease, the Leasing Incentive  will  be  automatically  revoked and Tenant will be immediately required to pay to Owner the full amount that was waived  pursuant  to  the  Leasing  Incentive,  as  additional  rent. <strong>Tenants  are  paying  the  1st  month  rent  and  1  month security at the lease signing. <!-- Tenants will receive 2nd month’s rent, September 2020, free. The next payment is due on October 1, 2020 and the proportional amount is $1934.00 for October 2020 --></strong>.</li>
	<li>You  must  pay the security deposit in the amount of <strong>{$contract_info->price_deposit|convert} (US Dollars)</strong> in addition to the first month's rent to Owner when You  sign  this  Lease.  If  required  by  Owner,  you  will  make  such payment by certified or bank check. If any concession or special amenity is for any reason given to You, such concession or special amenity is to induce Your initial occupancy of the Apartment and is not intended to be, and shall not be a term or condition of, any renewal of this Lease. </li>
	<li><strong>Rent Payments.</strong> The rent under this Lease shall commence on the first day of its term, provided the Apartment is vacant asof that date (even if any painting and cleaning of the Apartment is not finished). Thereafter, you must pay rent on the first day of each and every month regardless of whether or not You receive a rent bill. Rent will only be accepted from the tenant of record. If a rent payment is accepted from someone other than the tenant of record, such acceptance shall not confer any right, title or interest under this Lease or to the Apartment to the individual or entity who made such payment. </li>
	<li><strong>Partial Calendar Months.</strong> If this Lease does not start on the first day of a calendar month, You still must pay the full  month's  rent  for  that  month;  any  overpayment will be applied towards the second month's rent. You must pay the full month's rent for the last month of the term of this Lease; You will not be entitled to any refund if You move out before the end of that month.</li>
</ul>

<h2>ARTICLE 4 <br> SECURITY DEPOSIT</h2>
<p>You are required to give Owner the sum specified above as a security deposit, which shall be due and payable when you sign this Lease. Owner will deposit this security with the bank or savings institution named above or another one as Owner may select. The bank account will earn interest at the rate set by the bank from time to time, for similar residential rent security deposit accounts. The interest rate will not be less than the prevailing rate earned by other such deposits made with banking organizations in the area; but this may be less than the rate earned by other types of accounts and may be less than the maximum available interest rate. Owner will be entitled to 1% per annum interest on the security deposit for administrative costs; the balance of the interest, if any, will be applied as provided below.</p>
<ul>
	<li><strong>Interest on Security.</strong> If You carry out all of Your agreements in this Lease, at the end of each calendar year, Owner or the bank will pay to You Your share of the interest earned on the security deposit, if any.</li>
	<li><p><strong>Refund of Security.</strong> If You carry out all of Your agreements in this Lease and move out of the Apartment and return it to Owner in the same condition it was in when You first occupied it (except for ordinary wear and tear, or damage caused by fire or other casualty not caused by You or anyone else in the Apartment), Owner will return to You the full amount of the security deposit and Your share of the interest within 60 days after this Lease ends. However, if You do not carry out all Your agreements in this Lease, Owner may keep all or part of the security deposit and Your share of the interest which has not yet been paid to You as is necessary to pay Owner for any losses incurred, including missed payments, notwithstanding the above.</p>
	<p>The Landlord will retain $400 of the security deposit contingent upon the execution of the final meter reading and receipt of the final Utilities Costs. Owner will return to you the full amount of this portion of the deposit within 60 days of receipt of the final Utilities Costs payment. However, Owner may keep all or part of the security deposit which has not yet been paid to You as is necessary to pay Owner for any losses incurred, including missed utility payments.</p></li>
	<li><strong>Transfer of Security to New Owners.</strong> If Owner sells or leases the Building, Owner will turn over the security, with interest, either to You or to the person buying or leasing (a lessee) the Building within 5 days after the sale or lease. In such case, Owner will have no further responsibility to You for the security or Your share of the interest. The new owner or lessee will become responsible to You for the security and Your share of the interest.</li>
	<li><strong>Security Deposit and Last Month's Rent.</strong> If You violate this Lease by using the security as the last month's rent, You will be required to pay Owner a special handling charge equal to 25% of one month's rent in addition to damages, if any. This handling charge is deemed additional rent and is due and payable on the last day of the last month of the term of this Lease.</li>
</ul>

<h2>ARTICLE 5 <br> IF YOU ARE UNABLE TO MOVE IN</h2>

<p>A situation could arise which might prevent Owner from letting You move into the Apartment on the beginning date set in this Lease. In this situation, Owner will not be responsible for Your damages or expenses, and this Lease will remain in full force and effect. However, in such case, this Lease will start, and Your obligation to pay rent will begin, on the date when You can move in. Owner will give You notice (which for this purpose includes oral or electronic notice) of the date that You can move in.</p>
        
<h2>ARTICLE 6 <br> PETS</h2>

<p>Unless there is a Pet Rider to this Lease, You are representing to Owner that You do not have any pets and You have no intention of acquiring a pet. If You do acquire or intend to acquire a pet, You must obtain the prior written approval from Owner (which, except as may be required by a non-waivable provision of law, may be withheld for any or no reason). You must request such approval in writing. Your notice to Owner must include the name, type, breed, color, weight (which may not exceed 30 pounds, fully grown), size and age of Your pet, two photographs (one front and one side) of Your pet and a statement that You have no other pets, or if You do have other pet(s) describing those other pets. Except as may be required by a non-waivable provision of law, OWNER WILL NOT CONSENT TO MORE THAN ONE DOG OR ONE CAT PER APARTMENT, ANY (EVEN ONE) PIT BULL, ROTHWEILLER, OR OTHER BREED OR ANIMAL THAT IS PRONE TO HAVING A VICIOUS NATURE, OR ANY OTHER ANIMAL (EXCEPT FOR SMALL BIRDS, SMALL FISH, SMALL RODENTS AND SMALL REPTILES). ANIMAL COMBINATIONS, SUCH AS ONE DOG AND ONE HAMSTER, ARE SUBJECT TO APPROVAL BY OWNER. If Owner shall consent to Your having a pet, such consent will be SUBJECT TO YOUR COMPLIANCE WITH ALL BUILDING RULES AND ALL LAWS, RULES AND REGULATIONS. Any violation of this Article will give Owner the right to end this Lease.</p>

<h2>ARTICLE 7 <br> CARE OF THE APARTMENT; END OF LEASE; MOVING OUT</h2>
<ul>
	<li><strong>Care of the Apartment.</strong> You must take good care of the Apartment and not permit or do any damage to the Apartment except Excusable Damage (The term "Excusable Damage" as used in this Article means any damage caused by ordinary wear and tear and damage due to fire or other casualty not caused by You or anyone else in the Apartment).</li>
	<li><strong>Moving Out.</strong>
		<ol type="a">
			<li>Rent for the last month of this Lease must be paid on or before the first day of the month. The security deposit may not be used for this purpose. Even if You vacate early, rent is due until the last day of this Lease and will not be pro-rated.</li>
			<li>
				On or before the ending date of this Lease:
				<ul>
				 	<li>(i) You and all other persons must move out of the Apartment;</li>
				 	<li>(ii) You must repair and restore the Apartment, at Your own cost and expense, so that it will be in good order and in the same condition it was in when You first occupied it, except for Excusable Damage (as defined in Section 7.1 of this Lease);</li>
				 	<li>(iii) You must remove, from the Apartment and from all storage and other areas of the Building, at Your own cost and expense, all of Your moveable property, as well as all furnishings, installations, attachments, wires, cables, conduits, wallpaper, paneling, mirrors, murals and other wall coverings, bookcases, cabinets, and all vinyl tile, linoleum, carpeting and other floor coverings (including all nails, tacks or stripping by or to which the same may have been attached) that You or any previous tenant may have installed, whether or not these items were installed with Owner's consent, at Your own cost and expense;</li>
				 	<li>(iv) You must schedule Your move (including Your use of the elevator) with the Building's superintendent, give all apartment and mailbox keys to Owner, and notify Owner in writing of Your forwarding address. You must also give Owner all keys and access cards, if any, used to gain entry to the Building or any of the Common Facilities. If You lose or fail to ret urn any keys or access cards which were furnished to You by Owner, You shall pay Owner the cost of replacing them and Owner may deduct such costs from the security deposit held by Owner;</li>
				 	<li>(v) You must restore and repair to its original condition those portions of the Apartment affected by the items described in (iii) above, at Your own cost and expense. This means, for example that (a) You must restore all walls and floors to the same condition in which they were received, except for Excusable Damage; (b) You must leave the walls in good order and prime painted; and (c) You must have the floor and adjacent areas scraped, refinished and repaired so that the affected areas and contiguous areas are uniform in color and finish.</li>
				</ul> 
			</li>
		</ul>
	</li>
	<li><strong>Remaining Property.</strong> If anyone or if any of Your property remains in the Apartment after this Lease ends, Owner may either (a) treat You as still in occupancy and charge You "use and occupancy" for the Apartment (which, shall be an amount that is not less than 125% of the rent You were paying on the last day of this Lease; or (b) Owner may consider that You have given up the property remaining in the Apartment, in which case, Owner may discard the property or store it at Your expense, and You will have to pay Owner for all costs and expenses incurred in removing and/or storing such property. In either case You will also owe Owner for all losses, costs and expenses incurred by Owner as well as any losses, costs and expenses incurred by a new tenant if the new tenant's moving into the Apartment is delayed by You.</li>
	<li><strong>Failure To Repair or Restore Property.</strong> If You fail to duly and punctually perform any of Your obligations under this Article, Owner may do so, at Your expense. Owner, in addition to any of its other rights and remedies, may deduct the costs of performing any of Your obligations, from any security deposit held by Owner.</li>
	<li><strong>Obligations Survive the Expiration of Lease.</strong> Your obligations under this Article 7 will continue even after this Lease ends. Without limiting the generality of the foregoing, if any of You do not sign a renewal lease for the Apartment that person's obligations under this Lease will continue.</li>
	<li><strong>Renewals and Change in Lease.</strong> The Landlord may offer the Tenant a new Lease to take effect at the end of this current Lease. The new Lease may include reasonable changes to the Lease terms and/or an increase in the monthly rent amount. The Tenant will be notified of any proposed new Lease at least sixty (60) days before the end of the current Lease. The Tenant must notify the Landlord of the Tenant’s decision of whether or not to accept the new Lease at least thirty (30) days before the end of the current Lease term. If Tenant does not respond to the new Lease offer at least thirty (30) days before the end of the current Lease term, the Tenant will have been deemed to have accepted the new Lease with an additional 10% increase applied to the newly offered rental amount, including any reasonable lease term changes. For example, if a Tenant whose current rent is $1,000.00 per month is offered a renewal with a $50.00 increase per month (for a total offered rent of $1,050.00) does not sign and return the new Lease on the date specified, and remains in the Apartment, said Tenant will be charged a new rental amount of $1,155.00 per month. Said charging and/or accepting of said increased rental amount shall not prejudice any of Landlord’s rights, including the right to evict Tenant for failing to accept reasonable lease changes.</li>
</ul>

<h2>ARTICLE 8 <br>CHANGES AND ALTERATIONS TO APARTMENT</h2>
<ul>
	<li><strong>Consent of Owner Required.</strong> You may not, without Owner's prior written consent in each instance: (a) build in, add to, change or alter the Apartment in any way including, without limitation, flooring, wallpapering, cabling, painting, repainting or other decorating; (b) install in the Apartment any of the following: clothes washing or drying machines, electric stoves., garbage disposal units, heating, ventilating or air conditioning units or any other equipment which, in Owner's opinion, will overload the existing wiring installation or plumbing in the Building, create a hazardous condition or interfere with the use of any Building facilities by other tenants of the Building; (c) place in the Apartment water or other fluid-filled furniture such as waterbeds; or (d) install, change, attach, remove or disconnect any couplings, offshoots, cable, pipe or conduit wherever located.</li>
	<li><strong>Painting; Flooring; Drawers.</strong> You shall not cover, paint or chemically treat or in any other way alter or decorate the kitchen cabinets, bathroom tile or exposed brick walls, if any, in the Apartment. You shall not line any drawers or cabinets with heavy stick or strong hold contact paper or the like. You shall not scrape, stain or refinish any floors in the Apartment except as required by Owner as provided elsewhere in this Lease. You must get the prior written consent of Owner for any painting the Apartment. You shall not use peel-and-stick picture hangers or stick-on-hooks of any kind on any surface of the Apartment.</li>
	<li><strong>No Structural Alterations.</strong> You shall not, without first obtaining the written consent of Owner, make in the Apartment, or on any terrace, balcony, roof deck or patio that is accessible from the Apartment, any structural alteration of any kind or install any electrical or other equipment which may impose an excess load on existing electric, gas or water supplies. You shall not permit or suffer anything to be done or kept in the Apartment which will increase the rate of fire insurance on the Building or the contents thereof.</li>
	<li><strong>Mechanics Liens.</strong> In case there shall be filed a notice of mechanics lien against the Building for or purporting to be for labor or materials alleged to have been furnished or delivered for the Apartment to or for You, You shall immediately cause such lien to be discharged by payment, bonding or otherwise and, if You shall fail to cause such lien to be discharged within ten (10) days after notice from Owner, then Owner may cause such lien to be discharged by payment, bonding or otherwise, without investigation as to the validity of or any offsets or defenses to such lien, and Owner may collect such amounts and all costs and expenses paid or incurred in connection with such lien from You, including reasonable attorneys’ fees and disbursements, together with interest thereon from the time of payment of such lien.</li>
</ul>

<h2>ARTICLE 9 <br>YOUR DUTY TO COMPLY WITH LAWS, RULES AND REGULATIONS</h2>
<ul>
	<li><strong>Government Laws and Orders.</strong> You will obey and comply with all (a) present and future city, state and federal laws, rules and regulations, including, without limitation, the Rent Stabilization Code and Law, which affect the Building or the Apartment or the occupancy or use thereof, and (b) orders and regulations of Insurance Rating Organizations which affect the Apartment or the Building or the occupancy or use thereof. You will not allow any windows in the Apartment to be cleaned from the outside, unless the equipment and safety devices required by law are used.</li>
	<li><strong>Building Rules.</strong> You will obey all of the Building Rules listed in or attached to this Lease, and changes in those Building Rules and all future reasonable rules and regulations of Owner or Owner's agent. Owner shall not be responsible to You for not enforcing any rules, regulations or provisions of another tenant's Lease except to the extent required by law.</li>
	<li><strong>Your Responsibility.</strong> You are responsible for the behavior of Yourself, Your immediate family, Your servants and other occupants of the Apartment and people visiting You. You will pay to Owner as additional rent, upon demand, all losses, damages, fines and reasonable legal expenses paid or incurred by or on behalf of Owner because You, members of Your immediate family, servants and other occupants of the Apartment or people visiting You have not obeyed government laws and orders or the agreements or rules of this Lease.</li>
	<li><strong>Fire Safety Plan and Notice.</strong> You acknowledge having received a copy of, read and understand the fire safety plan for the Building; You will keep at all times Your copy of the fire safety plan in an easily accessible place in the Apartment. You also acknowledge that there is a fire safety notice attached to the inside of the door to the Apartment. You must not tamper with or remove this notice.</li>
</ul>

<h2>ARTICLE 10 <br> OBJECTIONABLE CONDUCT</h2>
<ul>
	<li>As a tenant in the Building, You will not engage in objectionable conduct nor will You allow any occupant, visitor or pet to engage in objectionable conduct. Objectionable conduct means behavior which makes or will make the Apartment or the Building less fit to live in for You or other tenants or occupants, including, without limitation, smoking which is strictly prohibited in the Apartment and Building. It also means anything that interferes with the right of others to properly and peacefully enjoy their apartments or causes conditions which are dangerous, hazardous, unsanitary or detrimental to other tenants and occupants in the Building. Objectionable conduct by You, or any occupant, visitor or pet will give Owner the right to end this Lease. Notwithstanding anything contained herein to the contrary, Owner is not required to serve a notice of default in the event of objectionable conduct on the part of the Tenant. The Owner need only serve a seven (7) day termination notice based upon the allegations of objectionable conduct.</li>
</ul>
<h2>ARTICLE 11 <br> SERVICES; UTILITIES; APPLIANCES; AND TELECOMMUNICATIONS</h2>
<ul>
	<li><strong>Required Services.</strong> Owner will make repairs to the Apartment and provide cold water and heat (unless the Apartment has its own heating system) as required by law.</li>
	<li><strong>Electricity and Other Services.</strong> Electricity (including, but not limited to, electric charges for the operation of the heating and air-conditioning systems and the cost of operating the fan and compressor), television, internet and telephone service are not included in the rent and are the responsibility of the Tenant. You acknowledge that Owner and its agent have made no promise or representation of any kind or nature with respect to the cost and operation of electric, television, telephone, internet and other utilities nor as to the heating and air-conditioning system, including without limitation the electricity cost or the manner of the functioning of the systems or the portion of the cost of operating the systems which will be borne by You.</li>
	<li><strong>Water and Gas Charges.</strong> If Owner furnishes You with water and/or gas, the water is to be used for drinking, lavatory and toilet purposes only and the gas for cooking purposes only, through the fixtures installed by Owner. You shall not waste or permit the waste of water or gas or use the water or gas for any purposes other than those stated.</li>
	<li><strong>Appliances.</strong> Appliances supplied by Owner in the Apartment are for Your use. They will be maintained and repaired or replaced by Owner; but if repairs or replacement are made necessary because of Your negligence or misuse, You must pay Owner for the cost of such repair or replacement as additional rent. You are prohibited from replacing or installing any dishwasher, washer or dryer without the Owner’s prior written consent which can be withheld for any or no reason.</li>
	<li><strong>Telecommunications, Cable, Internet and Other Services.</strong> Telecommunications, cable or satellite television, internet and other services and equipment ("Communications Services") are the sole responsibility of the service provider. Owner does not warrant, guarantee or make any promises concerning the availability, type of service, quality, cost or any other matter relating to any Communications Services. No action or failure to act on the part of Owner in connection with the installation, availability, operation, approval, rejection or commencement of any Communications Services shall be deemed a default or breach of Owner's obligations under this Lease. You are responsible for arranging for Communications Services directly with the provider; however, You may not make arrangements with any provider that has not made, in advance of Your request, written arrangements with Owner to provide services in the Building. Without limiting the generality of the foregoing, You acknowledge that Your choice of service providers for Communications Services may be limited because of the arrangements made by Owner for the Building, that You have had the opportunity to inquire of Owner as to the range of Communications Services and service providers for the Building prior to signing this Lease and that You are renting the Apartment with a full awareness of the available options and limitations.</li>
	<li><strong>Storeroom Use.</strong> If Owner permits You to use any storeroom, laundry or any other facility located in the Building but outside of the Apartment free of charge, the use of this storeroom or facility will be at Your own risk, except for loss suffered by You due to Owner's negligence. You will operate at Your expense any coin operated or card operated appliances located in such storerooms or laundries.</li>
</ul>

<h2>ARTICLE 12 <br> ENTRY TO APARTMENT</h2>         
  
<ul>
	<li><strong>Entry Permitted.</strong> Upon 24 hours’ notice, Owner and Owner's agents, contractors, workmen and representatives may enter the Apartment for any of the following reasons: (a) to erect, use, maintain, repair, replace or improve any mechanical, electronic, plumbing or other system or component or part of the Building, including, without limitation, meters, pipes, wires, cables and conduits (a "Building Improvement"), whether in or through the walls or ceilings of the Apartment or otherwise; (b) to inspect the Apartment and to make any repairs or changes Owner decides are necessary or appropriate; (c) to show the Apartment to persons who may wish to become owners or lessees of the Building or the Apartment or who may be interested in lending money to Owner; (d) to show the Apartment to persons who may wish to rent or otherwise occupy it; and (e) if there is an offering plan to convert the Building to cooperative or condominium ownership, or if the Building is already owned as a cooperative or condominium, to show the Apartment to persons who may wish to purchase the Apartment (or the shares of stock and proprietary lease for the Apartment). Your rent will not be reduced because of any of the foregoing.</li>
	<li><strong>Entry Near End of Lease.</strong> If during the last month of this Lease, You have moved out and removed all or almost all of Your property from the Apartment, Owner may enter the Apartment to make changes, repairs, or decorations without prior notice to You. Your rent will not be reduced for that month and the Lease will not be ended by Owner's entry.</li>
	<li><strong>Entry When You Are Not Home.</strong> If at any time You are not present to permit Owner or Owner's representative to enter the Apartment and entry is necessary or allowed by law or under this Lease, Owner or Owner's representatives may nevertheless enter the Apartment. Entry by force (including, without limitation, breaking the lock) is permitted in an emergency or where prompt action is required to reduce the risk of damage, loss or injury to persons or property. Owner will not be responsible to You, unless during this entry, Owner or Owner's representative is negligent or misuses Your property.</li>
	<li><strong>Entry by Emergency Contact.</strong> You hereby grant Owner and Owner's representatives, the right, without liability, to allow any of Your "emergency contacts" (which you may change by notice to Owner) to enter the Apartment and inspect Your personal property, without any court order or other authorization, if Owner at any time has reason to believe that You are missing, deceased, unconscious, incompetent or otherwise unable to communicate with Owner. Your emergency contact(s) are also authorized to remove any documents (such as medical or other insurance information) that he or she deems necessary or desirable in order to attend to Your affairs.</li>
	<li><strong>Keys.</strong> You shall supply Owner with all keys necessary to gain access to the Apartment (including, without limitation, keys and/or code numbers to de-activate any security system). You may not change the lock and/or add any lock to the entrance door of (or any other door in) the Apartment without the prior written consent of Owner. You will immediately give Owner a duplicate key or keys (and/or code numbers Co de-activate' any security system) if changes or additions are made to any lock (or security system).</li>
	<li><strong>Remedies.</strong> The right to enter the Apartment as allowed by law or under this Lease, as well as Owner's and its representatives other rights under this Article, are material obligations of Your part; Your failure or refusal to permit Owner to enter the Apartment or exercise any of such other rights shall be considered a default by You under this Lease and, without limiting Owner's other rights and remedies, may result in Your being responsible to Owner for any monetary or other damages.</li>
	<li><strong>Fee for Failing to Provide Access for Previously Scheduled Requested Repairs.</strong> Where You and Owner have agreed upon a specific date and time for repair(s) requested by You, You will be assessed a fee, charged as additional rent, should You fail to be in the Apartment at said scheduled date and time to allow access to the Apartment for said repairs. If You are unable to be in the Apartment at the scheduled date and time, You must inform Owner of same, at which point Owner or Owner’s representative will enter the Apartment without You being present. This fee will be accessed as follows: $[AMOUNT] for each failure to be in the Apartment at the scheduled date and time. On the second such failure to be in the Apartment at the scheduled date and time, and for each failure after that, Owner reserves the right to enter the Apartment without You being present.</li>
</ul>

<h2>ARTICLE 13 <br>ASSIGNING; SUBLETTING; ABANDONMENT</h2>

<ul>
	<li><strong>Assigning and Subletting.</strong> You may not assign this Lease or sublet the Apartment without Owner's prior written consent in each instance, which consent, except as may be required by New York Real Property Law § 226-b (if applicable) or the Rent Stabilization Law and Code, Owner may withhold for any or no reason. Any request to assign or sublet must include all information required by, and otherwise must be made in accordance with, said Real Property Law § 226-b and the Rent Stabilization Law and Code. If Owner provides written consent to Your request to sublet or assign this Lease, the rent for the Apartment will automatically increase for the period of the subletting (or for the balance of the term in the case Of an assignment) by the amount, if any, of any increase permitted by the Rent Stabilization Law and Code, and You will remain liable. for the performance of the tenant's obligations under this Lease. Owner may collect rent from any subtenant, assignee Or occupant without releasing You from this Lease. Owner will credit the amount collected against the rent due under this Lease; however, Owner's acceptance of rent does not change the status of any subtenant or occupant to that of a direct tenant of Owner and does not release You from this Lease.</li>
	<li><strong>Abandonment.</strong> If You move out of the Apartment (abandonment) before the end of this Lease without the prior written consent of Owner (which may be withheld for any or no reason or may be subject to such conditions as Owner may impose, including, without limitation, the payment of a fee): (i) This Lease will not be ended; (ii) You will remain responsible for each monthly payment of rent as it becomes due until the end of this Lease; (iii) Owner may commence immediate proceedings to collect as damages, the full amount of rent for the unexpired term of this Lease. If the Apartment or any part of the Apartment is re-rented, Owner shall give credit for the amount received from the re-renting up to the balance of the term of this Lease after deducting Owner's expenses, but such credit for each month that Owner receives rent from the new tenant shall be limited to the amount of the monthly rental provided in this Lease; and (iv) Whether or not rent payments by You are then current, Owner may re-enter and resume possession and control of the Apartment. Owner's consent to Your moving out of the Apartment before the end of this Lease is at Owner's sole discretion and may be subject to such conditions as Owner may impose, including, without limitation, the payment of a fee.</li>
</ul>

<h2>ARTICLE 14 <br> DEFAULTS; LEASE TERMINATION</h2>

<ul>
	<li><strong>Defaults</strong>
		<ol type='a'>
			<li>(a) You will be in default under this Lease if: i) You fail to carry out any agreement or provision of this Lease; ii) You do not take possession or move into the Apartment 15 days after the beginning of this Lease; iii) You and other legal occupants of the Apartment move out permanently before this Lease ends; or iv) You or another occupant of the Apartment fails to carry out any agreement or provision of any lease or other agreement, whether now existing or entered into after the date of this Lease, between You (or such occupant) and Owner pertaining to the Building (including, without limitation, any other apartment in the Building), any of the Common Facilities or otherwise;</li>
			<li>(b) If You default under this Lease, other than a default in the agreement to pay rent or a default under Paragraph 10 of this Lease, Owner shall serve You with a written notice of default to stop or correct the specified default. You must then either stop or correct the default within ten (10) days, or, if You need more than ten (10) days, You must so notify Owner and begin to correct the default within ten (10) days and continue to do all that is necessary to correct the default as soon as possible.</li>
		</ul>
	 </li>
	<li><strong>Notice of Lease Termination.</strong> If You do not cease any activity which is a default under this Lease or begin to correct a default within ten (10) days as set forth in a notice of default served in accordance with Section 14.1(b) hereof or if a default under Article 10 of this Lease occurs, Owner shall give You a notice of termination that this Lease will end seven (7) days after the date the notice of termination is sent to You. At the end of the 7-day period, this Lease will end. You then must move out of the Apartment. Even though this Lease ends, You will remain liable to Owner for unpaid rent up to the end of this Lease, an amount equal to what the law calls "use and occupancy" until You actually move out of the Apartment after this Lease ends, and damages caused to Owner after that time as stated below.</li>
	<li><strong>No Rights to Reinstate Lease.</strong> Once this Lease has been ended, whether because of default or otherwise, You give up any right You might otherwise have to reinstate or renew this Lease.</li>
</ul>

<h2>ARTICLE 15 <br>REMEDIES OF OWNER AND YOUR LIABILITY</h2>

<ul>
	<li>If Owner ends this Lease because of Your default, the following are the rights and obligations of You and Owner:
		<ol type="a">
			<li>You must pay rent until this Lease has ended through the date set forth in Article 2. Thereafter, You must pay an equal amount for "use and occupancy" until You actually move out. "Use and occupancy" shall not be less than the rent you were paying on the last day of this Lease, plus any increases permitted by the Rent Stabilization Law.</li>
			<li>Once You are out, Owner may re-rent the Apartment or any portion of it for a period of time which may end before or after the ending date of this Lease. Owner may re-rent to a new tenant at a lesser rent or may charge a higher rent than the rent in this Lease.</li>
			<li>Whether the Apartment is re-rented, or not, You must pay to Owner as damages: (i) The difference between the rent in this Lease and the amount, if any, of the rents collected in any later lease or leases of the Apartment for what would have been the remaining period of this Lease; and (ii) All expenses paid or incurred by or on behalf of Owner related thereto including, without limitation, attorney's fees, advertising costs, brokerage fees and the cost of putting the Apartment in good condition for re-rental.</li>
			<li>You shall pay all damages due in monthly installments on the rent day established in this Lease. Any legal action brought to collect one or more monthly installments of damages shall not prejudice in any way Owner's right to collect the damages for a later/ month by a similar action. If the rent collected by Owner from a subsequent tenant of the Apartment is more than the unpaid rent and damages which You owe Owner, You will not receive the difference. Owner's failure to re-rent to another tenant will not release or change Your liability for rent and damages, unless and to the limited extent that the failure is due to Owner's deliberate inaction.</li>
		</ul>
	</li>
</ul>

<h2>ARTICLE 16 <br> ADDITIONAL OWNER REMEDIES</h2>
<p>If You do not do everything You have agreed to do, or if You do anything which shows that You intend not to do what You have agreed to do, Owner has the right to ask a court to make You carry out Your agreement or to give Owner such other relief as the court may provide. This is in addition to the other remedies described in this Lease.</p>

<h2>ARTICLE 17 <br> FEES AND EXPENSES</h2>
<ul>
	<li><strong>Owner's Rights.</strong> You must pay to Owner all fees and expenses paid or incurred by or on behalf of Owner: a) In making any repairs to the Apartment or the Building (including, without limitation, any of the Common Facilities) resulting from misuse or negligence by You or persons who live with You, visit You, or work for You; b) In repairing or replacing any appliance damaged by misuse or negligence by You or persons who live with You, visit You, or work for You; c) In correcting any violations of city, state or federal laws, rules, orders or regulations or the requirements of insurance policies or rating organizations concerning the Apartment or the Building which You or persons who live with You, visit You, or work for You, have caused; d) In preparing the Apartment for the next tenant (including but not limited to, attorney's fees, advertisements, broker's fees and the cost of putting the Apartment in good condition for re-rental) if You move out of the Apartment before this Lease's ending date; e) To obtain legal or collection services relating to Your actions or inaction or those of persons who live with You, visit You or work for You, including, without limitation, any action or inaction that would constitute a default by You under this Lease, and whether or not Owner brings or defends a lawsuit, arbitration, mediation or other proceeding against or by You or anyone else; f) In removing all of Your property from the Apartment after this Lease has ended; and g) Arising from Your failure to obey any other provisions or agreements of this Lease or any other agreement between You and Owner (including, without limitation, any agreement for the use of a storage room or for the use of any of the Common Facilities).</li>
	<li>You shall pay these fees and expenses to Owner as additional rent within 30 days after You receive Owner's bill or statement. If this Lease has ended when these fees and expenses are incurred, You will still be liable to Owner for the same amount as damages.</li>
	<li>In any provision of this Lease which provides for Your payment of attorneys' fees paid or incurred by or on behalf of Owner, said fees shall include all costs of collection (including, without limitation contingency and other fees paid or incurred to collection agents whether or not any legal services are involved or attorneys collection efforts rendered by employees of Owner or any agent or affiliate of Owner.</li>
</ul>

<h2>ARTICLE 18 <br>PROPERTY LOSS AND DAMAGE; PERSONAL INJURY</h2>

<ul>
	<li><strong>Owner Not Liable for Damage.</strong> Owner and Owner's agents and employees will not be responsible to You for: (a) any loss of or damage to You or Your property in the Apartment (even when Owner and Owner's agents or employees are permitted to enter the Apartment) or the Building (including, without limitation, any of the Common Facilities). due to any accidental or intentional cause, even a theft or another crime committed in the Apartment or elsewhere in the Building; (b) any loss of or damage to Your property delivered to any of Owner's agents or employees (such as the superintendent, doorman, concierge, etc.); (c) any damage or inconvenience caused to You by any other tenant, occupant or person in the Building; (d) any loss or damage (including, without limitation, any consequential losses) caused by or due to the installation, removal, operation, maintenance, malfunction, interference with or discontinuance of any Communications Services; (e) any loss or damage caused by or due to any leaks in any air-conditioning unit or window; and (f) any loss, damage, inconvenience, expense (including without limitation consequential losses, such as medical expenses and/or clothing, furniture or other cleaning expenses) to You or Your property in the Apartment (even when Owner and Owner's agents or employees are permitted to enter into the Apartment) due to an infestation of vermin, insects or other pests (including without limitation bedbugs).</li>
	<li><strong>Deliveries.</strong> Notwithstanding anything to the contrary contained in this Lease or otherwise: You acknowledge that Owner's agents and employees are prohibited from receiving any mail or packages of any kind and from receiving any keys for or from family members, friends, guests, employees or servants. You must personally receive deliveries of property directly from the shipper Any Building employee to whom any of Your property shall be entrusted shall be considered to be acting on Your behalf, as Your agent, with respect- to such property. If entry to the Building or any of the Common Areas requires the use of a key or access card, in no event shall You give any such key or access card to anyone who is not a Tenant or legal occupant of the Apartment, unless You first obtain Owner's prior written consent and You sign a separate agreement pertaining to such key or access card (if required by Owner).</li>
	<li><strong>Loss by Building Employees.</strong> Owner shall not be responsible for any fault or misconduct of its agents and employees unless they were negligent or engaged in willful misconduct while performing work that is part of their duties for Owner. If any agent or employee of Owner renders assistance in the parking or delivery of an automobile, handling or delivery of any furniture, household goods, keys or other articles or in providing any other service that is beyond the scope of their employment, at Your request or at the request of any lawful occupant, or at the request of any of Your employees or guests, then said Owner's employee shall be deemed an agent of the person making such request and Owner is expressly relieved from any and all loss or liability in connection therewith.</li>
	<li><strong>Prohibited Areas.</strong> You are strictly prohibited from opening, entering, accessing, or tampering with, or attempting to open, enter or access, any areas of the Building or the Apartment that are locked, limited to Building employees or service personnel, or otherwise off-limits to tenants. This includes, without limiting, locked or closed access doors, panels, shafts, ducts, mechanical and telecommunications rooms and closets. THESE AREAS MAY CONTAIN HIGH VOLTAGE OR OTHER DANGEROUS EQUIPMENT or conditions. To the maximum extent permitted by law, You (and not Owner or Owner's agents or employees) will be held responsible for any loss or injury to Yourself or anyone else caused by Your violation of the foregoing prohibitions.</li>
	<li><strong>Negligence in Operation of Building.</strong> Notwithstanding any provision to the contrary, nothing in this Lease or any other agreement shall exempt Owner from liability for damages for injuries to person or property caused by or resulting from the negligence of Owner, Owner's agents, servants or employees in the operation or maintenance of the Apartment or the real property containing the Apartment; but, except as may be provided by a non-waivable provision of applicable law, such liability shall be limited to actual losses that are in excess of the greater of the amount of insurance You actually have and the amount of insurance You are required to have pursuant to the terms of this Lease.</li>
</ul>

<h2>ARTICLE 19 <br>FIRE, CASUALTY, EMERGENCY OR ORDER</h2>
<ul>
	<li><strong>Lease Remains in Effect.</strong> If the Apartment becomes unusable, in part or totally, or the Building becomes inaccessible, because of fire, accident, weather, labor or materials shortage, war, terrorism, bio-terrorism or other casualty affecting the Apartment, the Building or the area in which the Building is located (a "Casualty"), or by virtue of an order of any governmental or civil authority having jurisdiction, this Lease will continue unless ended by Owner under Section 19.2 below or by You under Section 19.3 below. But the rent may be reduced immediately for the period of time that the Apartment is unusable or inaccessible; if the Apartment is partially usable, the reduction will be based on the pro rata area of the Apartment that is unusable by You.</li>
	<li><strong>Cancellation of Lease by Owner.</strong> Except as may be otherwise provided by a non-waivable provision of law, if a Casualty in the Building or area in which the Building is located, or order of any governmental or civil authority having jurisdiction, prevents the use of all or substantially all of the Building for 30 days or longer, (i) Owner may decide to tear down the Building, vacate all or substantially all of the Building, or substantially rebuild the Building, (ii) if Owner exercises any of its options under Subsection 19.2(i) hereof, (a) Owner may end this Lease, even if the Apartment is usable, by giving You notice of this decision, which notice must be given within 120 days after the date of such Casualty or order; and (b) the Lease will end (A) if the Apartment is usable, on the date set forth in such notice, which date must be no sooner than 30 days from the date You are given this notice, or (B) if the Apartment is unusable, on the day that the Apartment became unusable.</li>
	<li><strong>Renter's Insurance Required.</strong> It is the Tenant’s responsibility to obtain and keep in full force and effect during the term of this Lease, a comprehensive renter's insurance policy with a replacement cost endorsement and waiver of subrogation clause in favor of Owner, its agents and employees.
	<ol type="a">
		<li>Such policy shall cover, among other things, loss of or damage to all property in the Apartment, loss of any property left in the care, custody or control of Landlord or any of its agents or employees, loss of use of the Apartment and all other perils commonly insured against by prudent residential tenants.</li>
		<li>During the term of this Lease and each renewal thereof, the Tenant’s insurance policy must have personal liability protection with a minimum combined single limit of $300,000.00 per occurrence for property damage and bodily or personal injury (including death) to any number of persons in any one occurrence.</li>
		<li><strong>Outpost Club Inc.</strong> must be listed as an "Additional Interest" on the Tenant’s policy. By doing this, <strong>Outpost Club Inc.</strong> will be notified should the Tenant’s policy cancel or non-renew. The "Additional Interest" must read as follows: “Alerts
– <strong>Outpost Club Inc.</strong>, P.O. 780316 Maspeth, NY, 11378.”</li>
		<li>At the signing of the lease you must provide the Landlord with proof of your insurance policy. Failure to obtain Renter’s Insurance under this Lease will be a violation of the Lease terms and will be a valid cause for eviction.</li>
		<li><strong>Contractor's Insurance Required.</strong> If You have anyone perform any work in the Apartment or the Building, You must provide to Owner, prior to the start of any work, evidence satisfactory to Owner, of Your contractor's having policies of general liability insurance with builders risk coverage and workers' compensation insurance. Such policies must name Owner and its agents as additional insureds.</li>
	</ul>
	</li>
</ul>

<h2>ARTICLE 20 <br>PUBLIC TAKING; INTERFERENCE WITH LIGHT AND AIR</h2>

<ul>
	<li><strong>Interference with Light and Air.</strong> Owner will not be liable for (and You hereby consent to) any of the following occurrences or conditions ("Permitted Obstruction"):
	<ol type="a">
	 	<li>any temporary interference with or impairment of light, ventilation, air quality or view caused by construction by or on behalf of Owner;</li>
	 	<li>any interference with or impairment of light, ventilation, air quality or view (whether temporary or permanent) caused by construction on, or changes to, property not owned by Owner;</li>
	 	<li>the closing, darkening or blocking up of windows if such action is required by law; and (d) any temporary dirt, noise, od or or other condition stemming from the creation of, or other work pertaining to, any of the items described in 1 (a) through (c) hereof. No Permitted Obstruction will be considered a breach of this Lease or any of Owner's obligations under this Lease; nor will any Permitted Obstruction entitle You to a suspension or reduction of rent or allow You to cancel this Lease or make a claim for damages, nuisance, abatement of rent or otherwise. You will cooperate fully with, and not object to nor interfere with, Owner and Owner's representatives (and, if required by Owner, the owner of neighboring buildings and its representatives) in their creation of, or performance of other work pertaining to, a Permitted Obstruction. This includes, Without limitation, Your giving Owner and Owner's representatives (and such owner of neighboring buildings and its representatives)access to the Apartment to plan, perform and in spect such work. If the - Apartment contains a "lot line" window(s), You acknowledge that You were advised that a building or structure may be erected on adjacent property which may completely block said lot line window(s).</li>
	</ul> 
	</li>
</ul>

<h2>ARTICLE 21 <br>SUBORDINATION; CERTIFICATION; LENDER'S CONSENT</h2>
<ul>
	<li><strong>Subordination.</strong> All leases and mortgages of the Building or of the land on which the Building is located, now in effect or made after this Lease is signed, come ahead of this Lease. In other words, this Lease is "subject and subordinate to" any existing and future leases and mortgages on the Building or land, including any renewals, consolidations, modifications and replacements of any such lease or mortgage (a "Mortgage"). If certain provisions of any Mortgage come into effect, the holder of such Mortgage or its successor in interest (a "Lender") can end this Lease. If this happens, You will have no claim against Owner or such Lender. If requested by Owner or any Lender, You will sign promptly an acknowledgment of the "subordination" in the form that Owner or such Lender requires.</li>
	<li><strong>Attornment.</strong> In the event of the enforcement by any Lender of any remedy under a Mortgage, You shall, subject to applicable legal requirements, if requested by such Lender as a result of such enforcement "attorn to" such Lender and recognize such Lender as the landlord under this Lease without change in the provisions of this Lease; provided however, that such Lender shall not be: (a) bound by any payment of rent or additional rent which may have been made more than 30 days before its due date; (b) liable for any previous act or omission of Owner (or its predecessors in interest); (c) responsible for any monies owing by Owner to You or subject to any credits, offsets, claims, counterclaims, demands or defenses which You may have against Owner (or its predecessors in interest); (d) bound by any agreement to undertake or complete any construction of the Building or any part of the Building; or (e) obligated to make any payment to You other than any security deposit actually delivered to such Lender.</li>
	<li><strong>Estoppel Certificate.</strong> You agree to sign and deliver to Owner
(a) within 5-days after requested, a written acknowledgment (if accurate) to Owner or any third party designated by Owner that this Lease is in effect, that Owner is performing Owner's obligations under this Lease and that You have no present claim against Owner; and (b) upon request by any Lender, an instrument or instruments confirming the "attornment" provisions of Paragraph 21.2 hereof.
</li>
	<li><strong>Lender's Consent Required.</strong>
	<ul>
		<li>If any Mortgage requires Owner to obtain the consent of a Lender to this form of Lease;</li>
		<li>If this Lease is signed before any Lender has given its consent, and</li>
		<li>After this Lease is signed, a Lender requires that Owner change the form of this Lease, then Owner will notify You of the required changes and this Lease will be automatically amended to incorporate such changes, except that You will have the option to terminate this Lease early, if the required changes increase Your monthly rent or materially increase Your other obligations. To terminate this Lease early, You must so notify Owner, within 15 days after Owner gives you notice of the required changes, of the date that You want this Lease to end; If You properly give such notice, the Lease will end on the date You specified.</li>
	</ul>
	</li>
</ul>

<h2>ARTICLE 22 <br> BILLS AND NOTICES</h2>

<ul>
	<li><strong>Notices to You.</strong> Any notice from Owner or Owner's, agent or attorney will be considered properly given to You:
	<ol type="a">
		<li><strong>Written Notice.</strong> If it is (a) in writing; (b) signed by or in the name of Owner, Owner's agent or attorney; (c) addressed to You at the Apartment or such other address as Owner believes is reasonably likely to reach You and (d) delivered by messenger, regular mail or overnight delivery service (such as Federal Express). Such notice will be deemed effective as of the date of delivery (if sent by messenger), one day after it is sent by overnight delivery service or on the next day after mailing that the Postal Service makes regular residential deliveries.</li>
		<li><strong>Posted Notice.</strong> Such notice is intended for more than one tenant in the Building (as opposed to a notice that is specifically for You) and such notice is given (i) by inclusion on or with Your rent bill, (ii) by posting it in or near the lobby of the Building, mail box, elevator and/or other public area in the Building, or (iii) by leaving same under or at Your Apartment door. Such notice need not be signed and will be deemed given one day after it is sent to you, posted in the Building, or left under or at Your Apartment door.</li>
		<li><strong>Oral Notice.</strong> Such notice is given to You orally, in person, by telephone or otherwise, in the case of an emergency, in which case, such notice will be deemed given immediately. If there is more than one person signing this Lease as Tenant, each Tenant designates the other persons as his or her agent for the purpose of receiving notices, so that Owner need only give notice to one such person for a notice to be effective as to all persons who constitute Tenant.</li>
	</ul>
	</li>
	<li><strong>Notices to Owner.</strong> Unless and until Owner notifies You that Owner, in its discretion, will accept notices given by You electronically, any notice that You may wish to give to Owner, will not be effective unless it is in writing, signed by all of the persons named as Tenant under the Lease, and sent, postage prepaid, by certified mail, return receipt requested, to Owner at the address noted at the beginning of this Lease, marked Attention: Property Manager, with a copy to Owner at said address, at such other address as Owner may designate from time to time. Such notice will be deemed given on the next day after mailing that the Postal Service makes regular deliveries to businesses.</li>
</ul>

<h2>ARTICLE 23 <br>GIVING UP TRIAL BY JURY AND COUNTERCLAIMS; NEW YORK LAW</h2>
<ul>
	<li><strong>No Jury Trials.</strong> Both You and Owner agree to give up the right to a trial by jury in a court action, proceeding or counterclaim on any matters concerning this Lease, the relationship of You and Owner as tenant and landlord or Your use or occupancy of the Apartment or any of the Common Facilities. This agreement to give up the right to a jury trial does not include claims for personal injury or property damage.</li>
	<li><strong>Counterclaims.</strong> If Owner begins any court action or proceeding against You, You may not make a counterclaim in that action or proceeding.</li>
	<li><strong>New York Law.</strong> This Lease shall be deemed to have been made in the City and State of New York. Your and Owner's rights and obligations shall be determined in accordance with the internal laws of the State of New York. You will submit to the personal jurisdiction of the courts of the State of New York, whose jurisdiction shall be exclusive in any action or proceeding arising out of this Lease or any other agreement or relationship between You and Owner.</li>
</ul>

<h2>ARTICLE 24 <br>NO WAIVER OF LEASE PROVISIONS AND NOTATION ON CHECKS</h2>

<ul>
	<li><strong>Acceptance of Rent Is No Waiver.</strong> Even if Owner accepts Your rent or fails once or more often to take action against You when You have not done what You have agreed to do in this Lease, the failure of Owner to take action or Owner's acceptance of rent does not prevent Owner from taking action at a later date if You again do not do what You have agreed to do. If You pay and Owner accepts an amount less than the total amount of rent due, the amount received shall be considered to be in payment of all or a part of the earliest rent due. It will not be considered an agreement by Owner to accept this lesser amount in full satisfaction of all of the rent due and it will be accepted without regard to any notation on the check directing how payment should be applied, which notation shall not be binding upon Owner.</li>
	<li><strong>Waiver of Lease Violations Must Be In Writing.</strong> Only a written agreement between You and Owner can waive any violation of this Lease. Any agreement to end this Lease or to end or modify the rights and obligations of You and Owner must be in writing, signed by You and Owner or Owner's agent, except as otherwise provided in the Rent Stabilization Law or Code. Even if You give keys to the Apartment and any employee or agent of Owner or by Owner accepts them, this Lease is not ended.</li>
	<li><strong>Electronic Communications Are Not Binding On Owner.</strong> Any agreement, notice or other communication sent to or from Owner, by e-mail, fax, or other electronic means ("electronic notice"), is not legally binding, valid or enforceable against Owner, absent Owner's specific written authorization unless otherwise, provided for in this Lease.</li>
	<li>The deposit by Owner of any check or other monetary instrument for the payment of rent or additional rent, that contains any endorsements, statements or notations made by Tenant or any other party shall not: (i) be binding upon Owner; (ii) prejudice Owner’s legal rights; (iii) create any right in favor of or for the benefit of any other party; or (iv) constitute an accord and satisfaction, waiver, or a modification of the terms of this Lease or of the rights and/or obligations of Owner and/or Tenant under this Lease. Owner’s acceptance, endorsement, deposit, or negotiation of the check or monetary instrument shall not be deemed to be an acceptance of the endorsements, statements or notations made on the check or monetary instrument by or on behalf of Tenant and the Owner may accept the check or monetary instrument as if said endorsements, statements or notations did not exist. Owner’s acceptance of a check or other monetary instrument from a party not named in this Lease, shall not be deemed to be an acceptance by Owner of that party as an occupant of the Apartment or an acknowledgment or agreement by Owner that said party has any rights in connection with the occupancy or possession of the Apartment or this Lease.</li>
</ul>

<h2>ARTICLE 25 <br>CONDITION OF THE APARTMENT AND NEIGHBORHOOD</h2>

<ul>
	<li><strong>Apartment Is Rented "As Is".</strong> When You signed this Lease, You did not rely on anything said by Owner or Owner's agent about the physical condition or permitted uses of the Apartment, the Building or the land on which it is built. You did not rely on any promises as to what would be done, unless what was said or promised is written in this Lease and signed by both You and Owner. Before signing this Lease, You have inspected the Apartment and You accept it in its present condition "as is" (except for any condition which You could not reasonably have seen during Your inspection and which Owner is required to rectify by a non-waivable provision of law, provided that promptly after You move in You shall have notified Owner in writing of such condition). You agree that Owner has not promised to do any work in the Apartment except as may be specified in a rider signed by Owner.</li>
	<li><strong>No Promises By Owner Except As Stated In Lease.</strong> You acknowledge that no representation or promise of any kind has been made by Owner, or any agent or employee of Owner or any broker or broker's agent, and You are not relying on any representation or promise, except as expressly set forth in this Lease or in the separate documents indicated on the first page of this Lease. Without limiting the foregoing, You acknowledge that You are not relying upon and You were not induced to enter into this Lease or to take possession of the Apartment by anything contained in any floor plans, brochure or other literature. This Lease (together with the documents indicated on the first page of this Lease) contains the entire agreement between You and Owner with respect to the topics covered by this Lease and supersedes all other statements, communications, brochures and agreements, whether oral or written.</li>
	<li><strong>Noise; Odors and Other Annoyances.</strong> You acknowledge that Owner has not made any representations or promises with respect to noise, odors or other annoyances however arising and whether occurring inside or outside the Building or in the general vicinity of the Building. You hereby waive and release any claim, cause of action or set-off by reason of or arising out of any noise, inconvenience, aroma, scent, odor or other annoyance, however arising, and whether occurring inside or outside the Building (including, without limitation, annoyances caused by others in the Building, others in the general vicinity of the Building, traffic, cars, buses and other vehicles, deliveries, business activities, dust, fumes, debris, vibration and air pollution, public improvements and other construction activities). You shall not rescind this Lease or claim any abatement or reduction of rent, nor shall You fail to honor any of Your other obligations under this Lease by virtue of any of the above- mentioned items.</li>
	<li><strong>Maintain Condition of the Apartment.</strong> You acknowledge that Owner has the right to maintain the proper condition of the Apartment. In the event of an infestation of vermin, insects or other pests such as bedbugs, You must notify Owner immediately and You may be required to comply with a set of instructions, including but not limited to cleaning your clothes, furniture and other personal property, at Your expense. Owner may obtain an order to compel You to comply with necessary prerequisites and requirements to restore the condition of the Apartment. Any expense associated with restoring the condition of the Apartment including without limitation extermination expenses and/or legal fees shall be charged to You as additional rent. You shall not rescind this Lease or claim any abatement or reduction of rent for the restoration of the condition of the Apartment.</li>
</ul>

<h2>ARTICLE 26 <br>DEFINITIONS</h2> 
  
<p>Whenever the words "Owner" “Tenant” or "You" are used in this Lease, it shall mean: The term "Owner" means the person or organization receiving or entitled to receive rent from You for the Apartment at any particular time other than a rent collector or managing agent of Owner. "Owner" includes the owner of the land or Building and a mortgagee in possession. It does not include a former owner, even if the former owner signed this Lease, except to the extent a former owner may be entitled to receive rent from You for the period that the former owner was the owner of the land or Building. The term "You" or “Tenant” means the person or persons signing this Lease as tenant and the successors and assigns of the signer. This Lease has established a tenant-landlord relationship between You and Owner.</p>

<h2>ARTICLE 27 <br> INFORMATION; NO CONFIDENTIALITY</h2>

<p>By signing this Lease You are telling Owner that all information and documents provided by You or on Your behalf to Owner or Owner's agents (including, without limitation, anything in Your application to rent the Apartment) or otherwise obtained by Owner or Owner's agents in connection with this Lease and Your rental of the Apartment is true, correct and complete and does not leave out any information that would be important to Owner's decision to rent the Apartment to, You. If Owner discovers any such misrepresentation or omission before the start of or during the term of this Lease, Owner may cancel this Lease by notice to You (which for this purpose may be written or electronic notice). All such information and documents (including, without limitation, information obtained by Owner during the term of this Lease, such as information about Your timeliness in making rent payments and fulfilling Your obligations under this Lease) may be disclosed by Owner or its agents to third parties.</p>

<h2>ARTICLE 28 <br>CHARGES FOR LATE PAYMENT AND INSUFFICIENT FUNDS</h2>

<p>If in any six (6) month period during this Lease, more than <strong>two (2)</strong> checks remitted by Tenant for payment of rent or other amounts due under this Lease are returned to Owner unpaid or uncollected as a result of insufficient funds or otherwise, then Owner shall have the right to require that Tenant pay all amounts due under this Lease by either Tenant's certified check, money order or official bank check, drawn on a bank with a banking office in the City of New York and made payable directly to Owner. Owner shall exercise this right by giving written notice thereof to Tenant.</p>

<h2>ARTICLE 29 <br>WINDOW GUARDS AND LEAD-BASED PAINT</h2>

<ul>
	<li>You acknowledge that You have received notice that under Section 131.15 of the New York City Health Code, Owner is required to install window guards in an Apartment if a child ten years old or under lives or visits in the Apartment. Except as specified in a separate Rider to this Lease, You represent that there is no child or children who are members of Your immediate family under ten (10) years of age who shall be residing in the Apartment. If such a child does become a resident, You must notify Owner. Unless and until Owner receives such notice, Owner will rely on Your representation and shall not be required to install any such window guards. If any law or regulation requires window guards, You shall pay for the cost.</li>
	<li>You acknowledge and represent that You received the Prevention of Lead-Based Paint Hazards Inquiry Regarding Child (the "NYC Lead Paint Notice") and a New York City Department of Health and Mental Hygiene pamphlet on lead-based paint hazards and You fully and accurately completed and signed the NYC Lead Paint Notice, a copy of which is attached to this Lease,
		<ol type="a">
			<li>The NYC Lead-Based Paint Notice is a Rider to and part of this Lease and You shall fully and punctually comply with its terms. This includes, among other things, the obligation to notify Owner immediately, in writing, if a child under seven years of age comes to reside in the Apartment.</li>
			<li>You shall give Owner access to the Apartment to find out if a child under seven years of age resides in the Apartment. You also shall give Owner access for the purpose of investigating and repairing lead-based paint hazards.</li>
			<li>Except as may be specified by You in the NYC Lead Paint Notice, You represent that no child or children under seven (7) years of age will be residing in the Apartment.</li>
		</ul>
	</li>
</ul>

<h2>ARTICLE 30 <br> SECURITY SYSTEMS</h2>
<p><strong>No Liability Of Owner.</strong> Owner makes no representation and assumes no responsibility whatsoever with respect to the functioning or operation of any human or automated security systems which Owner does or may provide, including without limitation, desk-persons, lobby attendants, intercom system, hand recognition system or TV monitoring. Owner shall not be responsible or liable for any bodily harm or property loss or damage of any kind or nature which You or any members of Your family, employees or guest may suffer or incur by reason of any claim that Owner, its agents or employees or any such system in the Building has been negligent or has not functioned properly or that some other or additional security measure or system could have prevented the bodily harm or property loss or damage. If You install a security system, Owner shall not be responsible for its maintenance. Neither the superintendent nor Owner nor any of its employees shall be obligated to respond to any alarm or security alert.</p>
   
<h2>ARTICLE 31 <br>HOME OCCUPATION SPACE AND RECREATION ROOMS; TERRACES</h2>   

<ul>
	<li><strong>Terrace.</strong> If the Apartment includes a terrace, balcony, patio or roof deck ("Your Terrace"), the following provisions shall apply to the use of Your Terrace:
	<ol type="a">
		<li><strong>Equipment On Your Terrace; Access Gate.</strong> Owner may in its discretion, at any time, on a permanent or temporary basis, install, maintain, repair and replace on, and remove from, Your Terrace (i) mechanical or other types of equipment, including, without limitation, any equipment used in the operation, maintenance, repair or improvement of the Building ("Equipment") and/or (ii) an unlocked gate to provide access between Your Terrace and one or more adjacent terraces or areas of the Building(an "Access Gate"). You acknowledge that the presence of any Equipment and/or Access Gate is acceptable to You and will not constitute a reduction in services to You or partial eviction of the Apartment and without Your being entitled to any rent reduction, abatement, off-set or credit. You shall not (nor shall you allow anyone else to) tamper with, damage, destroy or remove any Equipment or Access Gate, or block or lock any Access Gate. You shall be responsible to Owner for any damages due to a violation of any of these provisions.</li>
		<li><strong>Entry To Your Terrace.</strong>
		<ul>
			<li><strong>(i) Via Access Gate.</strong> Owner and Owner's agents contractors, workmen and representatives may enter Your Terrace through an Access Gate, at any time, without prior notice to You, whether or not You are present, to reach Your Terrace or any other area of the Building. Owner may enter by force if an Access Gate is locked or otherwise blocked (and you shall be responsible to Owner for any damages caused thereby).</li>
			<li><strong>(ii) Through Your Apartment.</strong> With reasonable notice (which for this purpose includes oral notice), Owner and Owner's agents contractors, workmen and representatives may enter the Apartment (including, without limitation, Your Terrace) to repair, replace and/or maintain any Access Gate or Equipment located on Your Terrace. Notwithstanding the foregoing, no notice shall be required to enter the Apartment in an emergency nor shall any notice be required after three unsuccessful attempts to notify You by telephone or otherwise, that Owner wants to enter the Apartment and Your Terrace.</li>
			<li><strong>(iii) Entry If You Are Not Home.</strong> If at any time You are not present to permit Owner or Owner's representative to enter the Apartment or Your Terrace and entry is necessary or allowed by law or under this Lease, Owner or Owner's representatives may nevertheless enter the Apartment (including, without limitation, Your Terrace). Owner may enter by force in an emergency. Owner and Owner's representatives will not be responsible to You, unless during this entry, Owner or Owner's representative is negligent or misuses Your property.</li>
			<li><strong>(iv) Lease Default.</strong> Owner's right to enter the Apartment (including, without limitation, Your Terrace) as allowed by law or under this Lease is a material obligation on Your part; Your failure or refusal to permit Owner to enter the Apartment (including, without limitation, Your Terrace) shall be considered a material default under this Lease and, without limiting Owner's other rights and remedies, may result in Your being responsible to Owner for any monetary or other damages.</li>
		</ul>
		</li>
		<li><strong>No Valuables Permitted On Your Terrace.</strong> You acknowledge that because Your Terrace may be accessible via an Access Gate to others (including, for example, other tenants and occupants of the Building and their guests, employees and contractors), Your storage of any personal property on Your Terrace is at your sole risk. You further acknowledge having been advised by Owner to take appropriate precautions to secure the Apartment against the entry by unauthorized third parties from Your Terrace. Such precautions include, without limitation, keeping all doors and windows to Your Terrace locked, keeping blinds on such doors and windows closed, and installing such alarm or other security precautions as You may think appropriate. Owner shall not be responsible for any loss or damage to any of your personal property by reason of any act or omission of other tenants and occupants or any other third party, for any reason whatsoever.</li>
		<li><strong>Water Conditions.</strong> You acknowledge that you have been advised that water may accumulate on or leak into Your Terrace due to heavy rainfall, clogged drains, the discharge of water from the domestic water tank or other reasons. Owner shall not be responsible for loss of or damage to any of Your property nor shall You be entitled to any rent abatement if access to Your Terrace is impaired or Your Terrace becomes temporarily unusable (in whole or part) due to any water accumulation or leakage on Your Terrace.</li>
		<li><strong>Satellite Dishes, Antennae and Other Equipment Prohibited.</strong> Except to the extent provided otherwise by a non-waivable provision of law, You may not install, attach, hang, keep, operate or maintain any satellite dish, antenna or other machinery or equipment on Your Terrace or Building without Owner's prior written consent in each instance, which Owner may withhold for any or no reason. If any such equipment shall be permitted on Your Terrace, You must, (i) install, operate and maintain the same in accordance with all of the terms and provisions of the Lease and applicable law, and in such a way as will not interfere with anyone else in the Building or with the operation, maintenance and repair of the Building, (ii) comply with all rules and regulations as Owner may implement from time to time and at any time and (iii) remove the same and restore Your Terrace to the condition that existed at the commencement of the Lease prior to the expiration or sooner termination of the Lease.</li>
	</ul>
</li>
</ul>

<h2>ARTICLE 32 <br>SMOKE AND OTHER DETECTORS</h2>

<p>You acknowledge that (a) the Apartment is equipped with one or more smoke detecting devices and carbon monoxide detecting devices (or combined smoke and carbon monoxide detecting devices), (b) a carbon monoxide detective device (or combined device) is located within fifteen feet of the primary entrance to each bedroom or other room lawfully used for sleeping purposes, (c) You have inspected each such device and it is operational and in good working order and (d) You received written instructions on how to test and maintain each such device. You shall maintain each such device, test it regularly (at least monthly), promptly replace any batteries and repair the device, if needed, and promptly replace any device which is stolen, removed, missing or rendered inoperable. You shall not allow anyone to tamper with or render any device inoperable, except for replacing the batteries or for other maintenance purposes. You (and not Owner) shall be liable for any loss or damage resulting from Your failure to abide by this Section 34.2, including, without limitation, any loss or damage caused by the resultant failure of any such device to operate properly. Owner will, within 30 days after receipt of notice from You, replace any device which becomes inoperable due to a manufacturing defect within one year after installation and without fault of any occupant of the Apartment.</p>

<h2>ARTICLE 33 <br>MILITARY SERVICE</h2>

<p>You represent that You are not in the military service or being supported by anyone in the military service at this time. If during the tenancy You shall be supported by anyone in the military service or You enter the military service, You must immediately notify Owner of this change.</p>

<h2>ARTICLE 34 <br>FIREPLACE</h2>
<p>No representation of any kind is made by Owner with respect to any fireplace(s) in the Apartment, including but without limitation whether the fireplace(s) is in working order or will function, and no part of the rent for the Apartment is based upon a working fireplace(s). You will be responsible for the-maintenance, repair and use of any fireplace(s) and for any damage or injury that may be caused by such fireplace(s).</p>

<h2>ARTICLE 35 <br>SUCCESSORS; SHARED RESPONSIBILITIES; CONFLICTS; PROHIBITED PERSONS</h2>
<ul>
	<li><strong>Shared Responsibilities.</strong> The agreements in this Lease shall be binding on Owner and You and on those who succeed to the interest of Owner or You by law, by approved assignment or by transfer. If more than one person is signing this Lease as Tenant, Your obligations are joint and several. This means that each of You is fully responsible for the obligations of Tenant under this Lease, including, without limitation, the obligation to pay all of the rent. Each of You will remain responsible for the obligations of Tenant under this Lease, even if this Lease is changed, renewed or extended, whether or not You sign the extension, renewal or modification agreement.</li>
	<li><strong>Conflicts.</strong> In the event of a conflict between the text and a caption, the text controls. In the event of a conflict between this Lease form and any rider to this Lease or Lease modification agreement, the terms of such rider of modification agreement control. Notwithstanding any provision of this tease or any other document to the contrary, any provision of this Lease or other document that conflicts with a non-waivable provision of law, shall be deemed to be modified automatically, so that this Lease and other documents shall at all times be in compliance with such non-waivable provision of law.</li>
	<li><strong>Prohibited Persons.</strong> You represent that You are not (1] listed on the list of "Specially Designated Nationals and Blocked Persons" ("SDN") promulgated by the Office of Foreign Assets Control of the U.S. Department of the Treasury pursuant to 31 C.F.R. Part 500 or (2] someone that Owner is prohibited or restricted from doing business with pursuant to the United States Patriot Act or any other law, rule, regulation, order or governmental action (an "Anti-Terrorism Law"). You shall, on request of Owner, provide such information (including, without limitation, any certification) as may be required to enable Owner to comply with any Anti-Terrorism Law. Notwithstanding any provision of this Lease to the contrary, in no event are You permitted to assign this Lease, sublet the Apartment (in whole or part) or engage in any other transaction relating to this Lease or the Apartment with a SDN and any such transaction shall be void.</li>
</ul>

<h2>ARTICLE 36 <br>SIGNING AND BINDING</h2>
<p>You represent that the signing of this Lease and its delivery to Owner shall constitute an offer to enter into the Lease with Owner. You may not revoke the offer. This Lease shall not be binding upon Owner until it is signed by Owner.</p>

<h2>ARTICLE 37 <br>REPLACEMENT AND ABANDONMENT OF PERSONAL PROPERTY</h2>

<p>Owner shall not be obligated to repair, replace or maintain any personal property left in the Apartment by a prior tenant or occupant of the Apartment. If any personal property remains in the Apartment after Tenant vacates the Apartment, said personal property shall be deemed abandoned by Tenant and at the election of the Owner, shall either be left in the Apartment or discarded. Tenant shall be responsible for all expenses and/or damages incurred by Owner in connection with discarding abandoned property and/or the restoration of the Apartment as may be required to correct any damage caused by removal of Tenant's abandoned property and/or installations.</p>

<h2>ARTICLE 38 <br>WAIVER OF IMMUNITY</h2>
<ul>
	<li>If Tenant is a foreign state, an agent or instrumentality of a foreign state, a foreign government, sovereign mission or embassy or a diplomat, consulate, ambassador, consul, consular official or other official or representative of any of the foregoing, then the following provision shall apply:
	<ul>
		<li>Tenant agrees that: (i) this Lease, including any modification, amendment, or renewal or supplement to this Lease, and any consent, license, or other agreement in connection with this Lease or the Building, including any modification, amendment, renewal or supplement thereto (such consent, license or other agreement and any modification, amendment, renewal or supplement thereto is hereinafter collectively referred to as the "Other Agreement") that may be hereafter entered into by Tenant, shall constitute a commercial act by Tenant; (ii) Tenant shall be subject to jurisdiction, suit, including summary proceedings to recover possession of the Apartment, setoff, judgment, and execution with respect to said judgment, in connection with this Lease, the Other Agreement and the transactions contemplated by this Lease and the Other Agreement; (iii) Tenant does not have, is not entitled to and hereby expressly, knowingly and irrevocably waives, to the fullest extent permitted by applicable law, including, without limitation, the United States Foreign Sovereign Immunities Act of 1976, the Vienna Convention on Diplomatic Relations and the Vienna Convention on Consular Relations, any existing or future claim to any Immunity, (whether characterized as sovereign Immunity, diplomatic or consular immunity or otherwise), from any legal proceedings, including summary proceedings to recover possession of the Apartment, whether commenced or prosecuted in the United States of America or elsewhere, to enforce Tenant's obligations under this Lease and/or the Other Agreement or to collect any amounts owed by Tenant to Owner in connection with this Lease and/or the Other Agreement. The foregoing waiver of immunity shall include, without limitation, a waiver of immunity from service of process, jurisdiction of any court or tribunal, attachment prior to entry of judgment, attachment in aid of execution, and execution upon a judgment in respect of Tenant or Tenant's property in any action or proceeding in respect of Tenant's obligations under this Lease and/or any Other Agreement.</li>
		<li>Tenant hereby agrees that any legal action or proceeding with respect to this Lease and/or any Other Agreement may be brought, at Owner's option, in the Civil Court of the City of New York, the Supreme Court of the State of New York or in the United States District Court for the Southern District or Eastern District of New York. By execution and delivery of this Lease, Tenant hereby accepts with regard to any such action or proceeding, for itself and in respect of Tenants property, generally and unconditionally, the jurisdiction of the aforesaid courts and agrees that for the purposes of 28 USC 1608, the mailing by regular mail to Tenant of a summons and complaint or other legal process or the service thereof by any means permitted by the laws of the State of New York shall be deemed to be a "special arrangement for service of process.</li>
		<li>Nothing herein shall affect the right of Owner to commence legal proceedings or otherwise proceed against the Tenant in the Tenant's country or in any other jurisdiction in which assets of the Tenant are located or to serve process in any other manner permitted by applicable law.</li>
		<li>Tenant further agrees that final judgment against Tenant in any action, counterclaim or proceeding instituted by Owner against Tenant pursuant to this Article, shall be conclusive and, to the extent permitted by applicable law, may be enforced in any other jurisdiction within or outside the United States of America by suit on the judgment, a certified or exemplified copy of which shall be conclusive evidence of the fact and the amount of Tenant's indebtedness or other liability to Owner.</li>
	</ul>
</li>
</ul>

<h2>ARTICLE 39 <br>ELECTRICITY</h2>

<p>All Electricity used in the Apartment during the term of this Lease shall be measured by a direct meter within the Apartment (the "Direct Meter) that shall be installed by Owner at its cost and expense. Owner will arrange for this electrical service directly with the respective service provider of these services, and charge Tenant monthly for the cost of these services. These charges shall be considered additional rent. Tenant covenants and agrees that at all times its use of Electricity shall never exceed the capacity of existing feeders to the Building or the risers, wiring or electrical installations serving the Apartment. Tenant shall not make any alterations, modifications or additions to the electrical installations serving the Apartment. Owner shall have the right to suspend electric service to the Apartment when necessary by reason of accident or for repairs, alterations, replacements or improvements necessary or desirable in Owner's judgment for as long as may be reasonably required by reason thereof and Owner shall not incur any liability for any damage or loss sustained by the Tenant as a result of such suspension. Owner shall not in any way be liable or responsible to Tenant for any loss, damage, cost or expense that Tenant or any occupant of the Apartment may incur if either the quantity or character of electric service is changed or is no longer available or suitable for Tenant's requirements or if the supply or availability of Electricity is limited, reduced, interrupted or suspended by the public utility company serving the Building or for any reason or circumstances beyond the control of Owner. Except as may be provided by applicable law, Tenant shall not be entitled to any rent reduction because of a stoppage, modification, interruption, suspension, limitation or reduction of electric service to the Apartment.</p>

<h2>ARTICLE 40 <br>LOCKOUT FEES</h2>

<p>Tenant agrees to pay to Owner a fee in the amount of <strong>$300</strong> to unlock Apartment entrance doors ("Lockout Fee"), per occurrence. Owner makes no representation that any Building Employee will be available at all times to unlock Apartment entrance doors and to provide Tenant with access to the Apartment. The term "Building Employee" shall mean any employee of either Owner or Owner's managing agent working at the Building.</p>

<h2>ARTICLE 41 <br>ILLEGAL ACTIVITY/EVICTION</h2>

<p>Tenant acknowledges, agrees and understands that if Tenant, any member of Tenant's family, any employee, guest, or invitee of Tenant, or any other party in occupancy of the Apartment, harbors, conducts or participates in any illegal activity  in  the  Building  or  upon  the  sidewalks  or  grounds  surrounding  or  adjoining  the Building, then Tenant and/or such other parties shall be subject to eviction from the Apartment.</p>

<h2>ARTICLE 42 <br>STORAGE</h2>
<ul>
	<li>To the extent that storage facilities are provided at the Building by Owner during the term of this Lease, Tenant may be permitted to utilize the storage space to be designated by Owner during the term of this Lease. Notwithstanding anything to the contrary contained in this Lease, Owner makes no representation or warranty that any storage space will be made available to Tenant, or as to the size, amount or location of any storage space that may be made available to Tenant. If any storage space is made available to Tenant, Owner shall have the right to require Tenant to sign and deliver to Owner, a separate agreement relative to Tenant's use of the storage space and the execution and delivery thereof shall be a condition of Tenant's right to use the storage space. If Tenant does not sign and deliver said separate agreement to Owner within 10 days following Owner's submission thereof to Tenant or if Tenant defaults in complying with any provision of said agreement, then Owner shall have the right to terminate Tenant's use of or the right to use the storage space. Tenant shall be required to pay any fee established by Owner from time to time, for use of the storage space and the payment thereof shall be deemed to be additional rent. Tenant shall be responsible for providing a lock for Tenant's storage space and shall use the storage space at Tenant's own risk except for any loss to Tenant's personal property caused by Owner's negligence. Tenant shall be required to comply with all Rules established by Owner from time to time in connection with the use of the storage space.</li>
	<li>Any personal property not removed by Tenant from the storage space, including, but not limited to the lock, by the date that Tenant vacates the Apartment, shall be deemed abandoned by Tenant and may be removed and disposed of by Owner, at Tenant's sole cost and expense, and Owner shall not have any liability to Tenant or any other party in connection with the removal and disposal of Tenant's personal property.</li>
	<li>Owner shall have the right to eliminate the storage space assigned to Tenant, reduce the size of the storage space, relocate the storage space and to limit and/or prohibit access to the storage space in connection with repairs and/or maintenance to Tenant's storage space, any other storage space or to the adjoining area(s) of the Building. If Tenant defaults in connection with any obligation of Tenant with respect to the storage space, including, but not limited to, a default under any separate agreement signed by Tenant in connection with the storage space, then said default shall be deemed to be a default under this Lease and said default shall give Owner the right to terminate this Lease and the right to exercise any and all remedies available to Owner, under this Lease, at law, or in equity, in connection with any default under this Lease. If Owner eliminates the storage space, then Owner shall have the right to terminate Tenant's right to use the storage space by giving written notice thereof to Tenant. If Tenant's right to use the storage space is terminated or if the amount of storage space is diminished, relocated or eliminated or if Tenant's access to the storage space is limited and/or prohibited to facilitate any repairs and/or maintenance, then Owner shall not have any liability to Tenant and Tenant shall not be entitled to any compensation or diminution or abatement of rent, and said termination, diminution, relocation, limitation, prohibition or elimination shall not be deemed to constitute a constructive, actual, or partial eviction. Notwithstanding anything to the contrary contained in this Lease, Tenant shall not have any right to use any storage space following the termination of this Lease.</li>
</ul>

<h2>ARTICLE 43 <br>MOLD AND MILDEW.</h2>
<ul>
	<li>Tenant acknowledges and agrees that if Tenant fails to take steps necessary to prevent or reduce moisture from building up in the Apartment or fails to maintain the Apartment in a clean condition, Tenant will be creating an environment that could result in mold growth. Tenant agrees to notify Owner immediately of any sign of a water leak, excessive or persistent moisture or any condensation issues in the Apartment or in any storage room or garage leased to Tenant, any stains, discoloration, mold growth or musty odor in any of such areas, any malfunction of the heating or air-conditioning system, or any cracked or broken windows. Tenant acknowledges and agrees that Owner will not be responsible for damages or losses due to mold growth to the extent such conditions have resulted from the acts or omissions of Tenant, or if Tenant has failed to immediately notify Owner of any of the conditions noted in the preceding sentence, and Tenant will reimburse Owner for any damage to the Apartment resulting from Tenant’s acts or omissions or failure to notify Owner of such conditions. Tenant agrees to cooperate fully with Owner in Owner’s efforts to investigate and correct any conditions that could result in, or have resulted in, mold growth, including, without limitation, upon Owner’s request, vacating the Apartment for such time as necessary to allow for any investigation and corrective action deemed necessary by Owner.</li>
	<li>Tenant shall immediately report to the Owner (I) any evidence of a water leak or excessive moisture in the Apartment or in any Common Area or the garage at the Building; (ii) any evidence of mold or mildew like growth in the Apartment that cannot be removed by simply applying a common household cleaner and wiping the area; (ill) any failure or malfunction in the heating, ventilation and air conditioning systems or the laundry equipment, if any, in the Apartment and, (Iv) any inoperable doors or windows.</li>
	<li>If Tenant fails to comply with the provisions of this Article, then, in addition to Tenant's obligation to indemnify Owner in accordance with the terms of this Lease for all damage, loss, cost and expense, including attorneys' fees and disbursements, suffered or incurred by Owner in connection with said failure to comply, Tenant shall also be responsible for all damage or loss to and all costs and/or expenses suffered or incurred by Tenant, Tenant's personal property and other occupants of the Building and their respective personal property.</li>
</ul>

<h2>ARTICLE 44 <br>ADDITIONAL LEASE RULES</h2>

<p>In addition, Tenant shall comply with the following rules:</p>
<ul>
	<li><strong>Use of Common Areas</strong>
		<ul>
			<li><strong>Obstruction of Common Areas.</strong> The halls, lobby and stairways of the Building shall not be obstructed or used for any purpose other than ingress to and egress from apartments in the Building. No personal property of any kind (including, without limitation, shoes, water bottles, umbrellas, coats and other articles of clothing, coat· racks, laundry, dry cleaning, brooms, mops, buckets and other cleaning items and packages of any kind) shall be left in the halls, lobby, stairways or other common areas of the Building. Fire towers shall not be obstructed in any way.</li>
			<li><strong>Courtyard.</strong> If the Building contains a courtyard, its use is strictly prohibited except for the purpose of entry to Tenants' apartments. Tenants may not use the courtyard for any other purpose, including, but not limited to, storage, drying of clothes, plantings, and access to other apartments or any recreational use whatsoever.</li>
			<li><strong>Halls, etc.</strong> No public hall or other common areas of the Building (including, without limitation, any doors to Tenants' apartments) shall· be decorated or furnished by any Tenant in any manner. No article shall be placed in the halls or on the staircase landings or fire towers, nor shall anything be hung from or attached to any doors (including, without limitation, any apartment doors), terraces, balconies; patios or roof decks ("Terraces") or windows nor shall anything be placed upon windowsills or the facade of the Building. Coat racks are not permitted in the public hallways, passageways or other common areas of the Building.</li>
			<li><strong>Furniture.</strong> Furniture and equipment may not be removed from any of the Common Areas.</li>
			<li><strong>Specific Uses.</strong> Messengers and trades people shall use such means of ingress and egress as shall be designated by Owner. Children shall not play in the public halls, courtyards, stairways, fire towers or lobby.</li>
		</ul>
	</li>
	<li><strong>Smoking. Smoking is strictly prohibited in all parts of the Building and Apartment.</strong></li>
	<li><strong>Backyard/Garden</strong>. The Tenant shall be permitted to utilize the backyard area (“Backyard”) solely for recreational purposes, and no other purpose whatsoever. Tenant shall comply with all applicable laws, ordinances, codes, rules, regulations and requirements of all federal, state and municipal governments, agencies, departments, boards and officials in connection with its use of the Backyard. Tenant shall be required to reasonably maintain the appearance and condition of the Backyard. The Tenant shall not perform any landscaping or digging, nor install any fencing, trees, shrubs or bushes or any irrigating systems or install any sheds, or permanent fixtures in the Backyard and shall not place any personal property in the Backyard other than outdoor furniture. Tenant shall also not be permitted to dry clothes or hang any items in the Backyard. Tenant shall not install pools of any kind in the Backyard, including above ground pools. Tenant may permit its licensees, invitees and/or guests to utilize the Backyard; however, Tenant and such persons shall not leave rubbish, debris, cigarette butts or personal items in the Backyard. The Tenant, at its own cost and expense, shall arrange for the removal of refuse, rubbish and garbage, subject to all applicable municipal laws and such reasonable rules and regulations as the Landlord shall reasonably deem necessary and proper. The Landlord shall not be required to furnish any services or equipment for the removal of said refuse, rubbish or garbage. Tenant shall also provide, at its sole cost and expense, all extermination services required in the Backyard. In addition, Tenant and any licensees, invitees and/or guests shall not disturb the peace and quiet enjoyment of other tenants in the Building or neighbors and shall not engage in loud conversations or permit any loud noises or odors to emanate from the Backyard. Smoking of any kind is strictly prohibited in the Backyard.</li>
	<li><strong>Noise.</strong> No Tenant shall make or permit any disturbing noises in the Building or do or permit anything to be done therein which will interfere with the rights, comfort or convenience of other Tenants. No Tenant shall play upon or suffer to be played upon any musical instrument or permit to be operated a phonograph, stereo, radio, television or other loud speaker in such Tenant's apartment between the hours of eleven o'clock p.m. and the following eight o'clock a.m. if the same shall disturb or annoy other occupants of the Building.</li>
	<li><strong>Work Hours.</strong> No construction or repair work or other installation involving noise shall be conducted in any apartment except on weekdays (not including legal holidays) and only between the hours of 8:30 a.m. and 5:00 p.m.</li>
	<li><strong>Window Air Conditioners, etc.</strong> No awnings, window air-conditioning units or ventilators shall be used in or about the Building except such as shall have been expressly approved in writing by Owner or the managing agent, nor shall anything be projected out of any window of the Building without similar approval. You agree that if Owner agrees in writing to permit the installation of an air-conditioning unit(s), it shall be installed only by Owner or its agent.</li>
	<li><strong>Signs.</strong> No sign, notice, advertisement or illumination shall be inscribed or exposed on or at any window or other part of the Building or Apartment door unless approved in writing by Owner or the managing agent.</li>
	<li><strong>Deliveries.</strong> Groceries, dry-cleaning and packages of every kind are to be delivered only at the service or other entrance designated by Owner. Unless Owner provides lobby attendant services, Tenant must have someone available to receive packages when a delivery arrives.</li>
	<li><strong>Moving.</strong> The moving of trunks, furniture, heavy baggage and large packages ("Moving Articles") in or out of the Building (and the use of an elevator, if applicable) shall be (a) through the service entrance or other entrance designated by the Building's superintendent and (b) scheduled in advance with the Building's superintendent. If a Tenant is employing a mover, such Tenant must provide the Building's superintendent with evidence that such mover has liability insurance satisfactory to the Owner and that the Owner, the Managing Agent and the tenant hiring such mover are named as additional insureds under such policy. If a Building employee is needed to operate an elevator or if the Owner or the Managing Agent determines that it is necessary or desirable to have a Building employee observe any move, the Tenant shall reimburse the Owner for all costs and expenses for the same.</li>
	<li><strong>Toilets.</strong> Toilets and other water apparatus in the Building shall not be used for any purposes other than those for which they were constructed, nor shall any sweepings, rubbish, rags or any other article be thrown into the toilets. The Tenant in whose apartment it shall have been caused shall pay for the cost of repairing any damage resulting from misuse of any toilets or the apparatus.</li>
	<li><strong>Laundry.</strong> Tenants may use the available laundry facilities (if any) only upon such days and during such hours as may be designated by Owner or the managing agent. Owner is not responsible for the maintenance of the laundry equipment or any damage to Tenants' personal property caused by such equipment.</li>
	<li><strong>Relocation of Storage and Laundry Facilities.</strong> Owner shall have the right from time to time to curtail or relocate any space devoted to storage or laundry purposes.</li>
	<li><strong>Window Cleaning.</strong> Each Tenant shall keep the windows of the Apartment clean. In case of refusal or neglect of a tenant for 10 days after notice in writing from Owner or the managing agent to clean the windows, such cleaning may be done by Owner, which shall have the right, by its officers or authorized agents, to enter the Apartment for the purpose and to charge the cost of such cleaning to the Tenant.</li>
	<li><strong>Consents May Be Revoked and are at Owner's Discretion.</strong> The granting of any consent or approval by Owner or its agent is at their sole discretion and may be withheld for any or no reason (except as may be required by a non-waivable provision of law). Any consent or approval given by Owner or its agent must be in writing and shall be revocable at any time.</li>
	<li><strong>Garbage; Recycling; Compactors.</strong> Garbage and refuse from the Apartment shall be sorted by Tenant and disposed of only at such times and in such manner as the superintendent or the managing agent of the Building may direct. Notwithstanding any other provision of this paragraph to the contrary, Tenants shall comply with any and all laws, rules and regulations as may be applicable for the collection, sorting, separation and recycling of bottles, cans, newspapers and other materials. Tenants will be required to pay all costs, expenses, fines, penalties and damages imposed on Owner or anyone else resulting from a· tenant's (or from a member of the family or guest, subtenant or employee of a tenant) failure to comply with the preceding sentence.</li>
	<li><strong>Exterminator.</strong> Owner's agents, contractors and workmen, may enter any Apartment any reasonable hour for the purpose of inspecting such apartment to ascertain whether measures are necessary or desirable to control or exterminate any vermin, insects or other pests and for the purpose of taking such measures as may be necessary to control or exterminate any such vermin, insects or other pests. If Owner takes measures to control or exterminate carpet beetles or bedbugs, the cost thereof shall be payable by the Tenant, as additional rent. Tenant shall immediately notify Owner upon discovery of any vermin, insects or other pests in Tenant's apartment. Tenant shall comply with extermination treatment instructions provided to tenant by Owner, Owner's agents, contractor or workmen to facilitate the extermination treatment(s) of the apartment, including but not limited to the removal and cleaning of clothing, furniture and other personal property items, at the Tenant's expense. Tenant shall pay for all extermination treatments and all cleaning and other fees incurred by Tenant because of contamination, except as may be otherwise required by a non- waivable provision of law. If Tenant fails or refuses to pay for any such costs, Owner may pay such costs and charge such costs to Tenant as additional rent. Tenant shall take every precaution to avoid any infestation and to ensure infestation does not spread. Tenant shall not use any Building equipment, such as washing machines or dryers to launder clothes or use any Building space, such as the trash compactor rooms to dispose of any items, including mattresses, clothes or other personal effects, which may be contaminated.</li>
	<li><strong>Soliciting Prohibited.</strong> No person, including any Tenant, shall enter or go through the Building for the purpose of vending, peddling or soliciting orders for any merchandise, book, periodical or circular of any kind or nature whatsoever or for the purpose of soliciting donations or contributions for any organization or for the purpose of distributing handbills, pamphlets, circulars, books, advertising material or otherwise, remember except with the written consent or invitation of solicited Tenants after same shall previously have been furnished or exhibited to Owner.</li>
	<li><strong>Bicycle Storage.</strong> If Owner shall designate a room for the storage of bicycles, the following rules shall apply to such bicycle storage room: Spaces are not guaranteed; they are allocated on a "first come first serve" basis, Space may not be available for every bicycle. All bicycles must be placed on the bicycle racks provided and must be locked and chained. Owner may remove bicycles that are not locked on a bicycle rack without notice, at the tenant's expense. All bicycles must be properly tagged in accordance with the Building's bicycle tagging system. Only bicycles may be stored in the bicycle room, i.e., no baby strollers or other furnishings and equipment are permitted. Tenants must respect bicycles that belong to other tenants when placing and removing bicycles. Tenants will be responsible for any damage they cause to others' bicycles. Bicycle storage is at the tenant's own risk. Neither Owner, nor the managing agent, nor any of their employees or agents will be responsible for any loss or damage due to theft, accidents, mishandling or other cause, except to the extent such loss or damage is due to gross negligence or willful misconduct. Tenants shall duly and punctually pay to Owner any bicycle storage fees as may be imposed by Owner in its discretion.</li>
	<li><strong>No Film or Recording Sessions; Auctions; Paid Events.</strong> Tenants may not use, or permit others to use, the Apartment (including, without limitation, any terrace, balcony or roof), public hallway or any other part of the Building, for film shoots, video or sound recordings, photography shoots, screenings, auctions, classes, fund raisers, social or other gatherings or events which require the payment of any tuition, admission charge, fee or other compensation to Tenant of any kind, or any similar activities without the prior consent of Owner or its managing agent in each instance.</li>
	<li><strong>Unsafe Conditions.</strong> If any violation of the Building Rules constitutes an unsafe or unlawful condition, Owner may, in addition to all of its other rights and remedies, remove any item and attempt to rectify such condition, at Tenant's sole cost and expense, without notice to Tenant.</li>
	<li><strong>Building Access.</strong> Tenants shall comply with all building access requirements that Owner my impose from time to time or at any time, including, without limitation, any requirement that Tenants and guests use an automated security and/or intercom system, be photographed and present identification and/or an electronic key as a condition to entry. Owner may, at its option, disallow entry to anyone that fails to comply with such requirements. If Owner distributes electronic or manual keys or other access device, entry codes and/or forms of identification for Building access by Tenants, Tenants shall not give or loan such items to anyone who is not a permitted Tenant of the Building and shall immediately notify Owner if any such item is lost, stolen or damaged or falls into unauthorized hands.</li>
	<li><strong>Amendments.</strong> These Building Rules may be added to, amended or repealed at any time by Owner, on notice to Tenant.</li>
</ul>

<div>
	<h2>ARTICLE 45 <br>NOTE</h2>
	{if $contract_info->note1}
		<p>{$contract_info->note1}</p>
	{else}
		<p>None.</p>	
	{/if}
</div>

<p>If more than one person is a tenant under the Lease, each of us signing below, acknowledges, represents and agrees with, and to abide by, the foregoing rules.</p>

<p>OWNER: Outpost Club, Inc.<br/>
	DATE: {$contract_info->date_signing|date} <br/>
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
		{elseif $user->contract->date_signing}
			DATE: {$user->contract->date_signing|date}<br/>
			{if $user->contract->signature}
				SIGNATURE:<br/>
				<img src="{$user->contract->signature}" alt="Signature {$user->name|escape}" width="180" />
			{/if}
		{elseif $user->booking->airbnb_reservation_id}
			<p>Digital Signature ID: {$user->booking->airbnb_reservation_id}</p>
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

{if $booking->client_type_id == 2 && $booking->airbnb_reservation_id}
	<p>Digital Signature ID: {$booking->airbnb_reservation_id}</p>
{elseif $contract_info->signature2}

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
	DATE: {$contract_info->date_signing|date} <br/>
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
		{elseif $user->contract->date_signing}
			DATE: {$user->contract->date_signing|date}<br/>
			{if $user->contract->signature}
				SIGNATURE:<br/>
				<img src="{$user->contract->signature}" alt="Signature {$user->name|escape}" width="180" />
			{/if}
		{elseif $user->booking->airbnb_reservation_id}
			<p>Digital Signature ID: {$user->booking->airbnb_reservation_id}</p>
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

{if $booking->client_type_id == 2 && $booking->airbnb_reservation_id}
	<p>Digital Signature ID: {$booking->airbnb_reservation_id}</p>
{elseif $contract_info->signature2}
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
	DATE: {$contract_info->date_signing|date} <br/>
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
		{elseif $user->contract->date_signing}
			DATE: {$user->contract->date_signing|date}<br/>
			{if $user->contract->signature}
				SIGNATURE:<br/>
				<img src="{$user->contract->signature}" alt="Signature {$user->name|escape}" width="180" />
			{/if}
		{elseif $user->booking->airbnb_reservation_id}
			<p>Digital Signature ID: {$user->booking->airbnb_reservation_id}</p>
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

{if $booking->client_type_id == 2 && $booking->airbnb_reservation_id}
	<p>Digital Signature ID: {$booking->airbnb_reservation_id}</p>
{elseif $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{/if}
<br>

<hr>

<br>
<br>
<br>
{if $apartment->furnished}
<h1>Utility Addendum</h1>

<p>This Addendum made on <strong>{$contract_info->date_created|date}</strong> by and between <strong>{foreach $contract_users as $u}{$u->name}{if !$u@last}, {/if}{/foreach}</strong> (“Tenant”) and <strong>Outpost Club Inc</strong>, located at P.O. 780316 Maspeth, NY, 11378 (“Landlord”) shall become a part of and be incorporated into the attached Lease Agreement (“Lease”) dated {$contract_info->date_from|date} for {$contract_info->rental_address}, {$apartment->name} (“Apartment”).</p>
<p><strong>Tenant Responsibility to Pay Utilities.</strong> The Tenant understands that payment for Gas and Electric (‘Utilities’) as listed in Article 11 & Article 40 of the attached Lease are entirely the responsibility of the Tenant (“Utility Costs”).</p>
<p><strong>Cause for Eviction.</strong> The Tenant understands and agrees that the Utilities Costs are considered additional rent and failure to pay the Utilities Costs will be cause for eviction.</p>
<p><strong>Control over Lease.</strong> The terms of this Rider shall control over the terms of the Lease.</p>
<p><strong>Binding effect.</strong> This Rider shall bind all parties to the Lease and shall also bind all those succeeding to the rights of any party of the Lease.</p>

<p>OWNER: Outpost Club, Inc.<br/>
	DATE: {$contract_info->date_signing|date} <br/>
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
			{elseif $user->contract->date_signing}
				DATE: {$user->contract->date_signing|date}<br/>
				{if $user->contract->signature}
					SIGNATURE:<br/>
					<img src="{$user->contract->signature}" alt="Signature {$user->name|escape}" width="180" />
				{/if}
			{elseif $user->booking->airbnb_reservation_id}
				<p>Digital Signature ID: {$user->booking->airbnb_reservation_id}</p>
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

{if $booking->client_type_id == 2 && $booking->airbnb_reservation_id}
	<p>Digital Signature ID: {$booking->airbnb_reservation_id}</p>
{elseif $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{/if}
<br>

<br>

<hr>

<br>
<br>
<br>
{/if}

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
	DATE: {$contract_info->date_signing|date} <br/>
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
		{elseif $user->contract->date_signing}
			DATE: {$user->contract->date_signing|date}<br/>
			{if $user->contract->signature}
				SIGNATURE:<br/>
				<img src="{$user->contract->signature}" alt="Signature {$user->name|escape}" width="180" />
			{/if}
		{elseif $user->booking->airbnb_reservation_id}
			<p>Digital Signature ID: {$user->booking->airbnb_reservation_id}</p>
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

{if $booking->client_type_id == 2 && $booking->airbnb_reservation_id}
	<p>Digital Signature ID: {$booking->airbnb_reservation_id}</p>
{elseif $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{/if}
<br>

<hr>

<br>
<br>
<br>

{$contract_users_hide=true}
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
<ul>
	<li>[{if $contract_info->options['children']==1}x{else} {/if}] CHILDREN 10 YEARS OF AGE OR YOUNGER LIVE IN MY APARTMENT</li>
	<li>[{if $contract_info->options['children']==2}x{else} {/if}] NO CHILDREN 10 YEARS OF AGE OR YOUNGER LIVE IN MY APARTMENT</li>
	<li>[{if $contract_info->options['children']==3}x{else} {/if}] I WANT WINDOW GUARDS EVEN THOUGH I HAVE NO CHILDREN 10 YEARS OF AGE OR YOUNGER</li>
</ul>

{foreach $contract_users as $user}
	{if $user->id != $contract_user->id}
		<p>TENANT NAME: {$user->name|escape}<br/>
		{if $user->log}
			DATE: {$user->log->date|date}<br/>
			SIGNATURE:<br/>
			<img src="{$config->contracts_dir}{$contract_info->url}/signature-{$user->id}.png" alt="Signature {$user->name|escape}" width="180" />
		{elseif $user->contract->date_signing}
			DATE: {$user->contract->date_signing|date}<br/>
			{if $user->contract->signature}
				SIGNATURE:<br/>
				<img src="{$user->contract->signature}" alt="Signature {$user->name|escape}" width="180" />
			{/if}
		{elseif $user->booking->airbnb_reservation_id}
			<p>Digital Signature ID: {$user->booking->airbnb_reservation_id}</p>
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

{if $booking->client_type_id == 2 && $booking->airbnb_reservation_id}
	<p>Digital Signature ID: {$booking->airbnb_reservation_id}</p>
{elseif $contract_info->signature2}
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
	DATE: {$contract_info->date_signing|date} <br/>
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
		{elseif $user->contract->date_signing}
			DATE: {$user->contract->date_signing|date}<br/>
			{if $user->contract->signature}
				SIGNATURE:<br/>
				<img src="{$user->contract->signature}" alt="Signature {$user->name|escape}" width="180" />
			{/if}
		{elseif $user->booking->airbnb_reservation_id}
			<p>Digital Signature ID: {$user->booking->airbnb_reservation_id}</p>
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

{if $booking->client_type_id == 2 && $booking->airbnb_reservation_id}
	<p>Digital Signature ID: {$booking->airbnb_reservation_id}</p>
{elseif $contract_info->signature2}
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
<div>
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

<p>OWNER: Outpost Club, Inc.<br/>
	DATE: {$contract_info->date_signing|date}<br/>
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
		{elseif $user->contract->date_signing}
			DATE: {$user->contract->date_signing|date}<br/>
			{if $user->contract->signature}
				SIGNATURE:<br/>
				<img src="{$user->contract->signature}" alt="Signature {$user->name|escape}" width="180" />
			{/if}
		{elseif $user->booking->airbnb_reservation_id}
			<p>Digital Signature ID: {$user->booking->airbnb_reservation_id}</p>
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
	<img src="{$contract_info->signature}" alt="Signature {$contract_user->name|escape}" width="180" />
{/if} 

{if $apartment->furnished}
	{include file='contracts/bx/inventory_list.tpl'}
{/if}
{include file='contracts/bx/fee_catalog.tpl'}

{if $contract_info->rider_type == 1}
	{include file='free_rent_doc/free_rent_month.tpl'}
{elseif $contract_info->rider_type == 3}
	{include file='free_rent_doc/rider_earlymovein.tpl'}
{elseif $contract_info->rider_type == 2 && $contract_info->free_rental_amount != 0}
<br>
<br>
<br>
<hr>
<br>
<br>

 	{include file='free_rent_doc/free_rent.tpl'}
	

	{foreach $contract_users as $user}
		{if $user->id != $contract_user->id}
			<p>TENANT NAME: {$user->name|escape}<br/>
			{if $user->log}
				DATE: {$user->log->date|date}<br/>
				SIGNATURE:<br/>
				<img src="{$config->contracts_dir}{$contract_info->url}/signature-{$user->id}.png" alt="Signature {$user->name|escape}" width="180" />
			{elseif $user->contract->date_signing}
				DATE: {$user->contract->date_signing|date}<br/>
				{if $user->contract->signature}
					SIGNATURE:<br/>
					<img src="{$user->contract->signature}" alt="Signature {$user->name|escape}" width="180" />
				{/if}
			{elseif $user->booking->airbnb_reservation_id}
				<p>Digital Signature ID: {$user->booking->airbnb_reservation_id}</p>
			{/if}
			</p>
		{/if}
	{/foreach}




	

<br>
<br>
{/if}


<p>OWNER: Outpost Club, Inc.<br/>
	{if $contract_info->signature}
		DATE: {$contract_info->date_signing|date} <br/>
		SIGNATURE:<br/>
		<img src="design/{$settings->theme|escape}/images/c_signature.png" alt="Signature Sergii Starostin" width="180" />
	{else}
		DATE: _______________<br/>
		SIGNATURE: _______________<br/>
	{/if}
</p>


{foreach $contract_users as $user}
	{if $user->id != $contract_user->id}
		<p>TENANT NAME: {$user->name|escape}<br/>
			{if $user->log}
				DATE: {$user->log->date|date}<br/>
				SIGNATURE:<br/>
				<img src="{$config->contracts_dir}{$contract_info->url}/signature-{$user->id}.png" alt="Signature {$user->name|escape}" width="180" />
			{elseif $user->contract->date_signing}
				DATE: {$user->contract->date_signing|date}<br/>
				{if $user->contract->signature}
					SIGNATURE:<br/>
					<img src="{$user->contract->signature}" alt="Signature {$user->name|escape}" width="180" />
				{/if}
			{elseif $user->booking->airbnb_reservation_id}
				<p>Digital Signature ID: {$user->booking->airbnb_reservation_id}</p>
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
{/if} 
