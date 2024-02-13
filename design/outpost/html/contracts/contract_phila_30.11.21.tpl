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



<h1 class="center">STUDENT HOUSING LEASE CONTRACT</h1>
<p class="center"><span style="font-style: italic">This is a binding document. Read carefully before signing.</span></p>
<h2>General Lease Provisions</h2>
 
<p>1. PARTIES. This Lease Contract is between you, the resident: {$contract_user->name} and us, the owner: CSC 3701 Chestnut, LLC</p>
 
<p>2. APARTMENT. You are renting:</p>

<p>[ ]  Apartment Number ________,</p>
<p>[ ]  Bedroom Number TBD, or</p>
<p>[ X ]  Floor Plan <strong>{$contract_info->roomtype->name}</strong> at 3701 Chestnut Street (street address) in Philadelphia (city), Pennsylvania, 19104 (zip code) for use as a private residence only.</p>

<p>When this lease is signed, all fees are paid and any guarantor paperwork is received, we will set aside a bedroom from our inventory for you. We will notify you of your bedroom assignment prior to move-in if not noted above.</p>

<p><strong>2.1. Use and Occupancy.</strong> Your access may include exclusive areas, shared common space in the unit, and common areas in the property.</p>
<p>We may assign another person to share a bedroom with you. If the apartment has a separate bathroom for each bedroom, you and any other person assigned to your bedroom will have exclusive use of that bathroom.</p>
<p>We do not make any representations about the identity, background or suitability of any other resident, and we are under no obligation to perform any resident screening of any kind, including credit, prior resident history or criminal background. Any disputes that arise are your responsibility to resolve directly in a reasonable manner that complies with this Lease. Disputes are not grounds to terminate this Lease.</p>
<p>You have a non-exclusive right to use other areas in the unit, including the kitchen, living area, patios/balconies and other shared spaces. Both you and other residents have equal rights to use the space and amenities in the unit common area. It is a violation of this Lease to use any spaces not assigned to you, and we have the right to assign a roommate to any vacancy at any time with or without notice.</p>

<p><strong>2.2.Access Devices.</strong> In accordance with our policies, you’ll receive access devices for your apartment and mailbox, and other access devices including:</p>
<p style="text-decoration: underline;">FOB for BLDG and card for unit/amenity access</p>
  
<p><strong>3. EMPLOYMENT INFORMATION: You are requested to provide us with the following current Employment Information (Name of Employer, Address, Telephone Number):</strong></p>
<p>_____________________________________________________________________________________________</p>
<p>You must immediately inform us, in writing, of any change in employment throughout your residency. Failure to notify us of any change in employment will be considered a breach of the Lease, subjecting you to all remedies in accordance with the Lease Contract.</p>

<p><strong>4. TERM.</strong> The term of the Lease Contract begins on the {$contract_info->date_from|date}, and ends at noon the {$contract_info->date_to|date}. You must give at least <strong>60</strong> days written notice of termination or intent to move-out if it is prior to the Lease Contract ending date.</p>
<p>4.1. Philadelphia Only - If the number of days isn’t filled in, at least sixty (60) days notice is required on all leases for one (1) year or more and at least thirty (30) days notice is required for all leases of less than one (1) year.</p>
<p><strong>This Lease does not automatically renew.</strong></p>
<p>4.2.Holdover. You or any occupant, invitee, or guest must not hold over beyond the date contained in your move- out notice or our notice to vacate (or beyond a different move-out date agreed to by the parties in writing). If a holdover occurs, then:</p>
<ul>
	<li>(A) holdover rent is due in advance on a daily basis and may become delinquent without notice or demand; </li>
	<li>(B) rent for the holdover period will be in creased by 25% over the then-existing rent, without notice;</li>
	<li>(C) you’ll be liable to us for all rent for the full term of the previously signed Lease Contract of a new resident who can’t occupy because of the holdover;
	<strong>and</strong>
	</li>
	<li>(D) at our option, we may extend the Lease Contract term—for up to one (1) month from the date of notice of Lease Contract extension—by delivering written notice to you or your apartment while you continue to hold over.</li>
</ul>

<p><strong>5. RENT AND CHARGES.</strong> Your rent for the term is <strong>${$contract_info->price_month|convert}</strong>. Under this Lease and in accordance with our policies, your total amount due is payable in advance and without demand in 1 installments of <strong>${$contract_info->price_month|convert}</strong> each. This amount may include or exclude other fees and charges as outlined in your lease package.</p>
<p>The first installment is due on or before the first (1st) of the month in which this Lease begins. All other payments must be made by the first (1st) of the month in which they are due, with no grace period. This amount is owed by you and is not the total rent owed by all residents.</p>
<p>If you don’t pay the first installment by the date above, the total rent for the Lease term may be automatically accelerated without notice and become immediately due. We also may end your right of occupancy and recover damages, future rent, reletting charges, attorney’s fees, court costs, and other lawful charges. Our rights, remedies and duties herein apply under this paragraph. <strong><span style="font-style: italic">You must pay your installments on or before the first (1st) day of the month in which they are due. There is no grace period, and you agree that not paying by the first (1st) of the month is a material breach of this Lease. Cash is not acceptable without our prior written permission. You cannot withhold or offset rent unless authorized by law. Your obligation to pay rent does not change if there is a reduction of amenity access or other services performed by us.</span></strong> If you don’t pay rent on time, you’ll be in default and subject to all remedies under state law and this Lease.</p>


<p><strong>5.1. Payments.</strong> You will pay your rent: </p>
<p>[ X ] at the onsite manager’s office</p>
<p>[ X ] through our online payment site </p>
<p>[ ] at ___________________________________________________________________</p>
<p>We may, at our option, require at any time that you pay all rent and other sums in cash, certified or cashier’s check, money order, or one (1) monthly check rather than multiple checks. At our discretion, we may convert any and all checks via the Automated Clearing House (ACH) system for the purposes of collecting payment. Rent is not considered accepted, if the payment/ACH is rejected, does not clear, or is stopped for any reason. Rent and late fees are due without demand, and all other sums are due upon our demand.</p>
<p><strong>5.2.Application of Money Received.</strong> When we receive money, other than utility payments subject to government regulation, we may apply it at our option, and without notice, first to any of your unpaid obligations, then to current rent. We may do so regardless of notations on checks or money orders and regardless of when the obligations arose.</p>
<p><strong>5.3.Utilities and Services.</strong> We’ll pay for the following if checked:</p>
<p>[ X ] gas</p>
<p>[ X ] water</p>
<p>[ X ] wastewater </p>
<p>[ X ]  electricity</p>
<p>[ X ] trash/recycling</p>
<p>[ ] cable/satellite</p>
<p>[ ] Internet</p>
<p>[ ] stormwater/drainage</p>
<p>[ ] government fees</p>
<p>[ ] other</p>

<p>Your per-person share of any submetered or allocated utilities or services for the apartment will be included as an itemized charge on a billing statement to you. “Per person” is determined by the number of residents authorized to be living in the apartment at the time of the utility billing to you by us or our agent. You’ll pay for all other utilities and services, related deposits, and any charges or fees on such utilities and services during your Lease term.</p>
<p><strong>5.4. Late Charges.</strong> If you don’t pay rent in full by 11:59 p.m. on the <strong>4th</strong> day of the month, you must pay us the following late charge immediately and without demand in addition to the unpaid rent: <strong>10%</strong> of your installment amount as stated in this Lease.</p>
<p>You’ll also pay a charge of <strong>$25.00</strong> for each returned check or rejected electronic payment plus a late charge.</p>
<p><strong>5.5. Lease Changes.</strong> No rent increases or Lease changes are allowed during the Lease term, except for those allowed by special provisions, by a written addendum or amendment signed by you and us, or by reasonable changes of apartment rules allowed under the provisions herein.</p>
<p><strong>6. SECURITY DEPOSIT.</strong> Your deposit is <strong>${$contract_info->price_deposit|convert}</strong> , due on or before the date this Lease Contract is signed. This amount does not include an animal deposit. Any animal deposit will be stated in an animal addendum.</p>
<p><strong>6.1. Refunds and Security Deposit Deductions.</strong></p>
<p><strong><span style="font-style: italic">In accordance with our policies and as allowed by law, we may deduct from your security deposit the amount of damages beyond normal wear and tear.</span></strong> We’ll mail you, to the forwarding address you provide, your security deposit refund (less lawful deductions) and an itemized accounting of any deductions no later than thirty (30) days after surrender or abandonment, unless statutes provide otherwise. You’ll be liable for the following charges, if applicable: unpaid rent; unpaid utilities; unreimbursed service charges; repairs or damages caused by negligence, carelessness, accident, or abuse, including stickers, scratches, tears, burns, stains, or unapproved holes; replacement cost of our property that was in or attached to the apartment and is missing; replacing dead or missing smoke and Carbon Monoxide detector batteries; utilities for repairs or cleaning; trips to let in company representatives to remove your telephone or TV cable services or rental items (if you so request or have moved out); trips to open the apartment when you or any guest or occupant is missing a key.</p>
<p>You’ll also be liable for the following charges, if applicable: unreturned keys; missing or burned-out light bulbs; removing or rekeying unauthorized access control devices or alarm systems; agreed re-renting charges; packing, removing, or storing property removed or stored as described in this Lease Contract; removing illegally parked vehicles; special trips for trash removal caused by parked vehicles blocking dumpsters; false security- alarm charges unless due to our negligence.</p>
<p>You must thoroughly clean the apartment, including doors, windows, furniture, bathrooms, kitchen appliances, patios, balconies, garages, carports, and storage rooms. You must follow move-out cleaning instructions if they have been provided. If you don’t clean adequately, you’ll be liable for reasonable cleaning charges.</p>
<p>You should meet with our representative for a move-out inspection.</p>
<p>Any statements or estimates by us or our representative are subject to our correction, modification, or disapproval before final refunding or accounting.</p>
<p>You’ll be liable for the following charges, if applicable: unpaid rent; unpaid utilities; unreimbursed service charges; repairs or damages caused by negligence, carelessness, accident, or abuse, including You have the apartment when:</p>
<ul>
	<li>(A) the move-out date has passed and no one is living in the apartment in our reasonable judgment; or</li>
	<li>(B) all apartment keys and access devices have been turned in where rent is paid—whichever date occurs first.</li>
</ul>
<p>You’ll also be liable for the following charges, if applicable: animal-related charges as provided in this Lease Contract; government fees or fines against us for violation (by you, your occupants, or guests) of local ordinances relating to smoke and Carbon Monoxide detectors, false alarms, recycling, or other matters; late-payment and returned- check charges; a charge (not to exceed $100) for our time and inconvenience in our lawful removal of an animal or in any valid eviction proceeding against you, plus attorney’s fees, court costs, and filing fees actually paid; and other sums due under this Lease Contract.</p>
<p>You’ll be liable to us for:</p>
<p>(A) charges for replacing all keys and access devices if you fail to return them on or before your actual move-out date; and</p>
<p>(B) are - renting fee as provided for in this Lease Contract.</p>
<p><strong>7. GUESTS.</strong> “Guests” include anyone entering the apartment for any reason related to your occupancy. You are responsible for the conduct of your guests, invitees, family members, and any other person whom you allow to enter the property or apartment, as if such conduct were your own. Unless otherwise stated in this Lease or in our policies, no more than 10 people may be present in the apartment at one time.</p>
<p>Other than residents and authorized occupants, no one else may occupy the apartment. Guests are not permitted to stay in the apartment for more than 3 consecutive days without our prior written consent. If the previous blank isn’t filled in, two (2) consecutive days will be the limit.</p>
<p>7.1. Exclusion of Persons. We may exclude from the apartment community, to the extent permitted by Pennsylvania statutes, guests or others who, in our judgment, have been violating the law, violating this Lease Contract or any apartment rules, or disturbing other residents, neighbors, visitors, or owner representatives. We may also exclude from any outside area or common area to the extent permitted by Pennsylvania statutes, a person who refuses to show photo identification or refuses to identify himself or herself as a resident, occupant, or guest of a specific resident in the community.</p>


<p><strong> 8. CARE OF UNIT/COMMON AREAS AND DAMAGES.</strong> You must promptly reimburse us for loss, damage, government fines, or cost of repairs or service in the apartment community due to a violation of the Lease Contract or rules, improper use, negligence, or intentional conduct by you or your invitees, guests or occupants.</p>
<div style="text-decoration: underline;">
	<p>Unless the damage or wastewater stoppage is due to our negligence, we’re not liable for—and you must pay for— repairs, replacement costs, and damage to the following that result from your or your invitees, guests, or occupants’ negligence or intentional acts:</p>
	<p>(A) damage to doors, windows, or screens;</p>
	<p>(B) damage from windows or doors left open; <strong>and</strong></p>
	<p>(C) damagefromwastewaterstoppagescausedbyimproper objects in lines exclusively serving your apartment.</p>
</div>
<p>We may require payment at any time, including advance payment of repairs for which you’re liable. We have not waived our right to collect these payments from you if there is a delay in our demanding payment from you. These damages and charges are considered additional rent and payment is considered a condition of this Lease Contract.</p>
<p>Each resident is jointly and severally liable for all Lease Obligations relating to any shared areas and utilities (if applicable). All residents will be jointly responsible for damage to the Apartment that we do not determine (in our sole discretion) was caused by a specific Resident, and other amounts due under the Lease. In addition to other obligations outlined in this Lease, you are liable for your per-person share of animal violation charges, missing batteries from smoke or other detectors, government fines, or damages to the apartment if we cannot, in our reasonable judgment, ascertain the identity of the person who caused the damages or the charge or fee to be incurred. “Per person” is determined by the number of persons, including you and other residents, authorized to live in the apartment at the time of the damage, charge, fine or violation.</p>
<p><strong>9. INSURANCE.</strong> We do not maintain insurance to cover your personal property or personal injury.</p>
<p><strong>9.1. Renter’s Insurance Requirement</strong></p>
<p>You are:</p>
<p>[ ] required to buy and maintain renter’s insurance; or</p>
<p>[ X ] not required to buy renter’s insurance.</p>
<p><strong>9.2. Personal Liability Insurance Requirement</strong></p>
<p>You are:</p>
<p>[ X ] required to purchase and maintain personal liability</p>
<p>insurance; or</p>
<p>[ ] not required to buy liability insurance.</p>
<p><strong><span style="font-style: italic">If neither option is checked, insurance is not required but is still strongly recommended. Even if not required, we urge you to get your own insurance for losses due to theft, fire, water, pipe leaks, and similar occurrences.</span></strong> Renter’s insurance doesn’t cover losses due to a flood. We urge all residents, and particularly those residents in coastal areas, areas near rivers, and areas prone to flooding, to obtain flood insurance. A flood insurance resource which may be available includes the National Flood Insurance Program managed by the Federal Emergency Management Agency (FEMA).</p>
<p><strong>10. EARLY MOVE-OUT; RE-LETTING CHARGE.</strong> You’ll be liable to us for a reletting charge of <strong>${$contract_info->price_month|convert}</strong> (not to exceed 100% of your installment amount during the Lease Contract term) if you:</p>
<p>(A) fail to give written move-out notice as required; or</p>
<p>(B) move out without paying rent in full for the entire Lease Contract term or renewal period; or</p>
<p>(C) move out at our demand because of your default; or </p>
<p>(D) are judicially evicted.</p>
<p><strong>The reletting charge is not a cancellation fee nor a buyout fee and does not release you from your obligations under this Lease.</strong> It is a liquidated amount covering only part of our damages; that is, our time, effort, and expense in finding and processing a replacement. These damages are uncertain and difficult to ascertain—particularly those relating to</p>
<p>inconvenience, paperwork, advertising, showing apartments, utilities for showing, checking prospects, office overhead, marketing costs, and locator-service fees. You agree that the reletting charge is a reasonable estimate of such damages and that the charge is due whether or not our reletting attempts succeed. If no amount is stipulated, you must pay our actual reletting costs so far as they can be determined. The reletting charge does not release you from continued liability for: future or past-due rent; charges for cleaning, repairing, repainting, or unreturned keys; or other sums due.</p>
<p><strong>11. SECURITY AND SAFETY DEVICES.</strong></p>
<p><strong>11.1. Smoke and Carbon Monoxide Detectors.</strong></p>
<p>We’ll furnish smoke detectors and carbon monoxide detectors only if required by statute. We may install additional detectors not so required. <strong>We’ll test them and provide working batteries when you first take possession. Upon request, we’ll provide, as required by law, a smoke alarm or carbon monoxide detector capable of alerting a person with a hearing-impairment disability.</strong></p>
<p>You must test the smoke detectors and the carbon monoxide detectors on a regular basis, and you must pay for and replace batteries as needed, unless the law provides otherwise. We may replace dead or missing batteries at your expense, without prior notice to you. <strong>If you damage or disable the smoke detector or carbon monoxide detector or remove a battery without replacing it with a working battery, you may be liable to us for the cost of replacing or repairing the tampered device, actual damages, and attorney’s fees.</strong></p>
<p><strong>11.2. Duty to Report.</strong> You must immediately report smoke detector and carbon monoxide detector malfunctions to us. Neither you nor others may disable neither the smoke detectors nor the carbon monoxide detectors. If you fail to report malfunctions to us, or disable the smoke detectors or carbon monoxide detectors, you will be liable to us and others for any loss, damage, or fines from fire, smoke, or water.</p>
<p><strong>12. DELAY OF OCCUPANCY.</strong> We are not responsible for any delay of your occupancy caused by construction, repairs, cleaning, or a previous resident’s holding over.</p>
<p>The Lease Contract will remain in force subject to:</p>
<p>(1) abatement of rent on a daily basis during delay; and </p>
<p>(2) your right to terminate as set forth below.</p>
<p>Termination notice must be in writing. After termination, you are entitled only to refund of deposit(s) and any rent paid. Rent abatement or Lease Contract termination does not apply if delay is for cleaning or repairs that don’t prevent you from occupying the apartment.</p>
<p>If there is a delay and we haven’t given notice of delay as set forth immediately below, you may terminate up to the date when the apartment is ready for occupancy, but not later. <strong>Termination notice must be in writing.</strong></p>
<p>(a) If we give written notice to any of you when or after the Lease begins—and the notice states that occupancy has been delayed because of construction or a previous resident’s holding over, and that the apartment will be ready on a specific date—you may terminate the Lease Contract within three (3) days of your receiving the notice, but not later.</p>
<p>(b) If we give written notice before the date the Lease begins and the notice states that construction delay is expected and that the apartment will be ready for you to occupy on a specific date, you may terminate the Lease Contract within seven (7) days after you receive written notice, but not later.</p>
<p>The readiness date is considered the new initial term as set forth herein for all purposes. This new date may not be moved to an earlier date unless we and you agree in writing.</p>
<h2>Resident Life</h2>
<p> <strong>13. COMMUNITY POLICIES OR RULES.</strong> You and all guests and occupants must comply with any written apartment rules and community policies, including instructions for care of our property. Our rules are considered part of this Lease Contract. We may make reasonable changes to written rules, effective immediately, if they are distributed and applicable to all units in the apartment community and do not materially change the terms of the Lease Contract.</p>
<p>13.1. Photo/VideoRelease. WhensigningthisLease,you grant us permission to use any photograph or video taken of you while you are using property common areas or participating in any event sponsored by us.</p>
<p>13.2. Limitations on Conduct. Your apartment and other areas reserved for your private use must be kept clean and free of trash, garbage, and other debris. Trash must be disposed of at least weekly in appropriate receptacles in accordance with local ordinances. Passageways may be used only for entry or exit. You agree to keep all passageways and common areas free of obstructions such as trash, storage items, and all forms of personal property. No person shall ride or allow bikes, skateboards, or other similar objects in the passageways. Any swimming pools, saunas, spas, tanning beds, exercise rooms, storerooms, laundry rooms, and similar areas must be used with care in accordance with apartment rules and posted signs.</p>
<p>Glass containers are prohibited in or near pools and all common areas. You, your occupants, or guests may not anywhere in the apartment community: use candles or use kerosene lamps without our prior written approval; cook on balconies or outside; or solicit business or contributions. Conducting any kind of business (including child care services) in your apartment or in the apartment community is prohibited—except that any lawful business conducted “at home” by computer, mail, or telephone is permissible if customers, clients, patients, or other business associates do not come to your apartment for business purposes.</p>
<p>We may regulate:</p>
<p>(1) the use of patios, balconies, and porches;</p>
<p>(2) the conduct of furniture movers and delivery persons; and</p>
<p>(3) recreational activities in common areas.</p>
<p>13.3. Attendance and Enrollment. We may, at our option, require information about your attendance and enrollment. If required by us, you must notify us prior to any extended absence from your unit that is for more than fourteen (14) days and not during a regular school break. If you are suspended or expelled by an educational institution, we have the right, but not the obligation, to terminate your Lease. Within ten (10) days of your suspension or expulsion, you must give us written notice if our policies require this information. At our request, the educational institution may give us information about your enrollment status.</p>
<p>14. PROHIBITED CONDUCT. You, your occupants or guests, or the guests of any occupants, may not engage in the following activities:</p>
<p>(a) criminalconduct;manufacturing,delivering,possessing with intent to deliver, or otherwise possessing a controlled substance or drug paraphernalia; engaging in or threatening violence; possessing a weapon prohibited by state law; discharging a firearm in the apartment community; displaying or possessing a gun, knife, or other weapon in the common area in a way that may alarm others;</p>
<p>(b) behaving in a loud or obnoxious manner;</p>
<p>(c) disturbing or threatening the rights, comfort, health, safety, or convenience of others (including our agents</p>
<p>and employees) in or near the apartment community; (d) disrupting our business operations;</p>
<p>(e) storing anything in closets having gas appliances;</p>
<p>(f) tampering with utilities or telecommunications;</p>
<p>(g) bringing hazardous materials into the apartment community;</p>
<p>(h) using windows for entry or exit; or</p>
<p>(i) heating the apartment with a gas-operated cooking stove or oven.</p>
<p><strong>15. SMOKING POLICY DISCLOSURE.</strong> Smoking of any illegal substance is prohibited anywhere on the property. For purposes of this paragraph “smoking” includes but is not limited to pipe smoking, cigarette smoking, and cigar smoking. Our smoking policy is checked below.</p>
<p>[ X ]  Smoking of tobacco or any other legal substance is not allowed anywhere in the common areas, in any building, or in apartment or balcony. See the No Smoking Addendum for further details.</p>
<p>[ ] Smokingoftobaccooranyotherlegalsubstanceisallowed in the following checked areas only:</p>
<p>[ ] All apartments [ ] Apartments</p>
<p>[ ]Balconies. See No Smoking Addendum for further details.</p>
<p>[ ]Common areas. See No Smoking Addendum for further details.</p>
<p>1strong	6. PARKING. We may regulate the time, manner, and place of parking all cars, trucks, motorcycles, bicycles, boats, trailers, and recreational vehicles. Motorcycles, motorized bikes, or scooters may not be parked inside an apartment unit or on sidewalks, under stairwells, or in handicapped parking areas. We may have unauthorized or illegally parked vehicles towed by following applicable state law procedures. A vehicle is unauthorized or illegally parked in the apartment community if it:</p>
<p>(1) has a flat tire or other condition rendering it inoperable;</p>
<p>(2) is on jacks, blocks or has wheel(s) missing;</p>
<p>(3) has no current license plate or no current registration</p>
<p>and/or inspection sticker;</p>
<p>(4) takes up more than one parking space;</p>
<p>(5) belongs to a resident or occupant who has surrendered</p>
<p>or abandoned the apartment;</p>
<p>(6) isparkedinamarkedhandicapspacewithoutthelegally</p>
<p>required handicap insignia;</p>
<p>(7) is parked in space marked for manager, staff, or guest</p>
<p>at the office;</p>
<p>(8) blocks another vehicle from exiting;</p>
<p>(9) isparkedinafirelaneordesignated“noparking”area;</p>
<p>(10) is parked in a space marked for other resident(s) or unit(s);</p>
<p>(11) is parked on the grass, sidewalk, or patio;</p>
<p>(12) blocks garbage trucks from access to a dumpster; or</p>
<p>(13) belongs to a resident and is parked in a visitor or retail parking space.</p>
<p><strong>17. RELEASE OF RESIDENT.</strong> Unless allowed by this Lease Contract, federal or state law, you won’t be released from this Lease Contract for any reason.</p>

<p><strong>18. MILITARY PERSONNEL CLAUSE</strong></p>
<p>All parties to this Lease Contract agree to comply with any federal law, including, but not limited to the Service Member’s Civil Relief Act, or any applicable state law(s), if you are seeking to terminate this Lease Contract and/or subsequent renewals and/or Lease Contract extensions under the rights granted by such laws.</p>


<p><strong>19. RESIDENT SAFETY AND LOSS. <span style="font-style: italic">We are not liable to you, other residents in your unit or your guests for any damage, injury or loss to person or property caused by persons, including but not limited to theft, burglary, assault, vandalism or other crimes.</span></strong> We’re not liable to you, other residents, guests, or occupants for personal injury or damage or loss of personal property from any cause, including but not limited to: fire, smoke, rain, flood, water and pipe leaks, hail, ice, snow, lightning, wind, explosions, earthquake, interruption of utilities or other occurrences unless such damage injury or loss is caused exclusively by our negligence, unless otherwise required by law. Unless required by law, we have no duty to remove any ice, sleet, or snow but may remove any amount with or without notice.</p>
<p>During freezing weather, you must ensure that the temperature in the apartment is sufficient to make sure that the pipes do not freeze (the appropriate temperature will depend upon weather conditions and the size and layout of your unit). If the pipes freeze or any other damage is caused by your failure to properly maintain the heat in your apartment, you’ll be liable for damage to our and other’s property. If you ask our representatives to perform services not contemplated in this Lease Contract, you will indemnify us and hold us harmless from all liability for these services.</p>
<p>You acknowledge that we are not equipped or trained to provide personal security services to you, other residents or your guests. You recognize that we are not required to provide any private security services and that no security devices or measures on the property are fail-safe. You further acknowledge that even if an alarm is provided it is a mechanical device that requires proper operation by you regarding coding and maintaining the alarm. Any charges resulting from the use of an intrusion alarm will be charged to you, including but not limited to any false alarms with police/fire/ambulance response or other required city charges.</p>
<p><strong>We do not warrant security of any kind.</strong> You agree that you will not rely upon any security measures taken by us for personal security, and that you will call local law enforcement authorities if any security needs arise, along with 911 or any other applicable emergency number if an emergency occurs.</p>
<p><strong>20. CONDITION OF THE PREMISES AND ALTERATIONS.</strong></p>
<p><strong>20.1. As-Is. We disclaim all implied warranties.</strong> You accept the apartment, fixtures, and furniture as is, except for conditions materially affecting the health or safety of ordinary persons. We disclaim all implied warranties except those required by Pennsylvania statutes. You’ll be given an Inventory and Condition form on or before move-in. You must note on the form all defects or damage and return it to our representative. Otherwise, everything will be considered to be in a clean, safe, and good working condition.</p>
<p><strong>20.2. Standards and Improvements.</strong> You must use customary diligence in maintaining the apartment and not damaging or littering the common areas. Unless authorized by statute or by us in writing, you must not perform any repairs, painting, wallpapering, carpeting, electrical changes, or otherwise alter our property. No holes or stickers are allowed inside or outside the apartment. But we’ll permit a reasonable number of small nail holes for hanging pictures on sheetrock walls and in grooves of wood-paneled walls, unless our rules state otherwise.</p>
<p>No water furniture, washing machines, additional phone or TV-cable outlets, alarm systems, or lock changes, additions, or rekeying is permitted unless statutorily allowed or we’ve consented in writing. You may install a satellite dish or antenna provided you sign our satellite dish or antenna lease addendum which complies with reasonable restrictions allowed by federal law. You agree not to alter, damage, or remove our property, including alarm systems, smoke and Carbon Monoxide detectors, furniture, telephone and cable TV wiring, screens, locks, and access control devices.</p>
<p>When you move in, we’ll supply light bulbs for fixtures we furnish, including exterior fixtures operated from inside the apartment; after that, you’ll replace them at your expense with bulbs of the same type and wattage. Your improvements to the apartment (whether or not we consent) become ours unless we agree otherwise in writing.</p>
<p><strong></strong></p>
<p><strong>21.1. Written Requests Required.</strong> <span style="text-decoration:underline;">IF YOU NEED TO SEND A NOTICE OR REQUEST—FOR EXAMPLE, FOR REPAIRS, INSTALLATIONS, SERVICES, OR SECURITY- RELATED MATTERS—IT MUST BE SUBMITTED THROUGH EITHER THE ONLINE RESIDENT PORTAL, OR SIGNED AND IN WRITING AND DELIVERED TO OUR DESIGNATED REPRESENTATIVE</span> (except for fair- housing accommodation or modification requests or situations involving imminent danger or threats to health or safety such as fire, smoke, gas, explosion, overflowing sewage, uncontrollable running water, electrical shorts, or crime in progress). Our written notes on your oral request do not constitute a written request from you. A request for maintenance or repair by anyone residing in your bedroom or apartment constitutes a request from all residents.</p>
<p><strong>21.2. Notifications and Requirements.</strong> You must promptly notify us in writing of: water leaks; electrical problems; malfunctioning lights; broken or missing locks or latches; and other conditions that pose a hazard to property, health, or safety. Unless we instruct otherwise, you are required to keep the apartment cooled or heated according to our policies.</p>
<p><strong>21.3. Utilities.</strong> We may change or install utility lines or equipment serving the apartment if the work is done reasonably without substantially increasing your utility costs. We may turn off equipment and interrupt utilities as needed to avoid property damage or to perform work. If utilities malfunction or are damaged by fire, water, or similar cause, you must notify our representative immediately.</p>
<p><strong>21.4. Casualty Loss and Equipment Repair.</strong> We’ll act with customary diligence to make repairs and reconnections, taking into consideration when casualty insurance proceeds are received. Rent will not abate in whole or in part. Air conditioning problems are not emergencies. If air conditioning or other equipment malfunctions, you must notify our representative as soon as possible on a business day.</p>
<p><strong>21.5. Our Right to Terminate for Casualty Loss/Property Closure.</strong> If we believe that fire or catastrophic damage is substantial, or that performance of needed repairs poses a danger to you, we may terminate your tenancy within a reasonable time by giving you written notice. We also have the right to terminate this Lease during the Lease term by giving you at least thirty (30) days’ written notice of termination if we are demolishing your apartment or closing it and it will no longer be used for residential purposes for at least six (6) months, or if the property is subject to eminent domain. If your tenancy is so terminated, we’ll refund prorated rent and all deposits, less lawful deductions. We may also remove personal property if it causes a health or safety hazard.</p>
<p><strong>22. ANIMALS.</strong></p>
<p><strong>22.1. No Animals Without Consent. Unless otherwise provided under federal, state, or local law, no animals (including mammals, reptiles, birds, fish, rodents, and insects) are allowed, even temporarily, anywhere in the apartment or apartment community unless we’ve so authorized in writing.</strong> If we allow an animal as a pet, you must execute a separate animal addendum which may require additional deposits, rents, fees or other charges. The animal addendum includes information governing animals, including assistance or service animals. When allowed by applicable laws, before we authorize an assistance animal, if the disability is not readily apparent, we may require a written statement from a qualified professional verifying the disability-related need for the assistance animal. If we authorize an assistance animal, we may require you to execute a separate animal and/or assistance animal addendum. Animal deposits, additional rents, fees or other charges will not be required for an assistance animal needed due to disability, including an emotional support or service animal, as authorized under federal, state, or local law. You represent that any requests you made are true, accurate and made in good faith. You must not feed stray or wild animals.</p>
<p><strong>22.2. Removal of Unauthorized Animal.</strong> We may remove an illegal or unauthorized animal by (1) leaving, in a conspicuous place in the apartment, a written notice of our intent to remove the animal within 24 hours; and (2) following the procedures for entering the unit. We won’t be liable for loss, harm, sickness, or death of the animal unless due to our negligence. We’ll return the animal to you upon request if it has not already been turned over to a humane society or local authority. You must pay for the animal’s reasonable care and kenneling charges. We have no lien on the animal for any purpose.</p>
<p><strong>22.3. Violations of Animal Policies and Charges.</strong> If you or any guest or occupant violates animal restrictions (with or without your knowledge), you’ll be subject to charges, damages, eviction, and other remedies provided in this Lease Contract, including an initial charge of <strong>$ 100.00</strong> per animal (not to exceed $100 per animal) and a daily charge of <strong>$ 10.00</strong> per animal (not to exceed $10 per day per animal) from the date the animal was brought into your apartment until it is removed. If an animal has been in the apartment at any time during your term of occupancy (with or without our consent), we’ll charge you for defleaing, deodorizing, and shampooing.</p>
<p>Initial and daily animal-violation charges and animal- removal charges are liquidated damages for our time, inconvenience, and overhead (except for attorney’s fees and litigation costs) in enforcing animal restrictions and rules.</p>
<p><strong>23. WHEN WE MAY ENTER</strong>. If you or any guest or occupant is present, then repairers, servicers, contractors, our representatives, or other persons listed below may peacefully enter the apartment at reasonable times for the purposes listed below. If nobody is in the apartment, then such persons may enter peacefully and at reasonable times by duplicate or master key (or by breaking a window or other means when necessary) if:</p>
<p>(1) written notice of the entry is left in a conspicuous place in the apartment immediately after the entry; and</p>
<p>(2) entry is for: responding to your request; making repairs or replacements; estimating repair or refurbishing costs; performing pest control; doing preventive maintenance; changing filters; testing or replacing smoke and Carbon Monoxide detectors batteries; retrieving unreturned tools, equipment, or appliances; preventing waste of utilities; leaving notices; delivering, installing, reconnecting, or replacing appliances, furniture, equipment, or access control devices; removing or rekeying unauthorized access control devices; removing unauthorized window coverings; or for stopping excessive noise; removing health or safety hazards (including hazardous materials), or items prohibited under our rules; removing perishable foodstuffs if your electricity is disconnected; retrieving property owned or leased by former residents; inspecting when immediate danger to person or property is reasonably suspected; allowing entry by a law officer with a search or arrest warrant, or in hot pursuit; showing apartment to prospective residents (after move-out or vacate notice has been given); or showing apartment to government inspectors, fire marshals, lenders, appraisers, contractors, prospective buyers, or insurance agents.</p>
<p><strong>24. NOTICES.</strong> Notices and requests from you or any other resident or occupant of the apartment, or granting a right or license to occupy constitute notice from all residents. Unless this Lease or the law requires otherwise, any notice required to be provided, sent or delivered in writing by us may be given electronically, subject to our rules. Your notice of tenancy termination or intent to move out must be signed by you. A notice from us to you to pay sums owed only by you, or regarding sale of property that belongs only to you or that was in your possession and care, will be addressed to you only. You represent that you have provided your current electronic mail address to us, and that you will notify us in the event your electronic mail address changes.</p>
<p><strong>25. SUBLETTING, TRANSFERS, RELOCATION AND REPLACEMENTS. Replacing a resident, subletting, assignment, or granting a right or license to occupy is allowed only when we expressly consent in writing.</strong></p>
<p><strong>25.1. Transfers.</strong> You must get our prior written approval for any transfer. If transfer is approved, you must:</p>
<p>(a) be in compliance with all terms of this Lease;</p>
<p>(b) execute a new Lease or other agreement for the space to which you are transferring;</p>
<p>(c) complete all required forms;</p>
<p>(d) pay a new security deposit in advance if required; and</p>
<p>(e) pay transfer fee of $ 250.00 in advance if you are moving from one unit to another or $ 250.00 in advance if you are moving from one exclusive space to another in the same unit.</p>
<p>Under no circumstances will we be responsible for paying for moving costs.</p>
<p><strong>25.2.Relocation.</strong> We reserve the right at any time, upon five (5) days prior written notice to you and without your having to pay any transfer fee, to relocate you to another bedroom in the Apartment or to another Apartment within the Apartment community. We will assist you in moving your personal property and pay for rekeying if we require you to relocate.</p>
<p><strong>25.3.Replacement.</strong> If departing or remaining residents find a replacement resident acceptable to us before moving out and we expressly consent, in writing, to the replacement, subletting, assignment, or granting a right or any license to occupy then:</p>
<p>(a) a reletting charge will not be due;</p>
<p>(b) a reasonable administrative (paperwork) and/or transfer fee will be due, and a rekeying fee will be due if rekeying is requested or required; and</p>
<p>(c) the departing and remaining residents will remain liable for all Lease Contract obligations for the rest of the original Lease Contract term.</p>
<p>If we approve a replacement resident, then, at our option, that resident must sign a new Lease. Deposits will not transfer, unless we agree otherwise in writing. The departing resident will no longer have a right to occupancy or a security deposit refund, but will remain liable for the remainder of the original Lease Contract term unless we agree otherwise in writing—even if a new Lease Contract is signed.</p>
<p><strong>25.4. Rental Prohibited.</strong> You agree that you won‘t rent or offer to rent your bedroom or all or any part of your apartment to anyone else. You agree that you won‘t accept anything of value from anyone else for the use of any part of your apartment. You agree not to list any part of your apartment on any lodging rental website or with any service that advertises dwellings for rent.</p>

<h2>Owner’s Rights and Remedies</h2>

<p><strong>26. OUR RESPONSIBILITIES.</strong> We’ll act with customary diligence to:</p>

<p>(1) keep common areas reasonably clean,</p>
<p>(2) maintain fixtures, furniture, hot water, heating and A/C</p>
<p>equipment;</p>
<p>(3) comply with applicable federal, state, and local laws</p>
<p>regarding safety, sanitation, and fair housing; and</p>
<p>(4) make all reasonable repairs, subject to your obligation</p>
<p>to pay for damages for which you are liable.</p>

<p><strong>26.1. Your Remedies.</strong> If we violate any of the above, you may terminate your tenancy and exercise other remedies under state statute by following this procedure:</p>
<p>(a) you must make a written request for repair or remedy of the condition, and all rent must be current at the time;</p>
<p>(b) after receiving the request, we have a reasonable time to repair, considering the nature of the problem and the reasonable availability of materials, labor and utilities;</p>
<p>(c) if we haven’t diligently tried to repair within a reasonable time, you must then give us written notice of intent to terminate your tenancy unless the repair is made within seven (7) days; and</p>
<p>(d) if repair hasn’t been made within seven (7) days, you may terminate your tenancy and exercise other statutory remedies. Security deposits and prorated rent will be refunded as required by law.</p>
<p><strong>27, DEFAULT BY RESIDENT.</strong></p>
<p><strong>27.1. Acts of Default.</strong> You’ll be in default if you or any guest or occupant violates any terms of this Lease Contract including but not limited to the following violations: (A) you don’t pay rent or other amounts that you owe when due;</p>
<p>(B) you or any guest or occupant violates the</p>
<p>apartment rules, or fire, safety, health, or criminal laws, regardless of whether or where arrest or conviction occurs;</p>
<p>(C) you abandon the apartment;</p>
<p>(D) you give incorrect or false answers in a rental</p>
<p>application;</p>
<p>(E) you or any occupant is arrested, convicted, or</p>
<p>given deferred adjudication for (1) a felony offense involving actual or potential physical harm to a person, or involving possession, manufacture, or delivery of a controlled substance, marijuana, or drug paraphernalia under state statute, or (2) any sex-related crime, including a misdemeanor;</p>
<p>(F) any illegal drugs or paraphernalia are found in your apartment;</p>
<p>(G) you or any occupant, in bad faith, makes an invalid complaint to an official or employee of a utility company or the government; or</p>
<p>(H) you allow a co-resident who has been evicted to stay in your bedroom or the apartment.</p>
<p>The resident defaults contained in the Lease will be limited to conduct by you or any of your invitees, guests or occupants, or to conduct in which you and any invitee, guest, occupant or resident participated. The remedies for a default committed solely by a resident in the apartment will be limited to those that affect that resident only.</p>
<p>Compliance with the terms of this paragraph is a condition of this Lease Contract.</p>
<p><strong>27.2. Lease Renewal When A Breach or Default Has Occurred.</strong> Intheeventthatyouenterintoasubsequent Lease prior to the expiration of this Lease and you breach or otherwise commit a default under this Lease, We may, at our sole and absolute discretion, terminate the subsequent Lease, even if the subsequent Lease term has yet to commence. We may terminate said subsequent Lease by sending you written notice of our desire to terminate said subsequent Lease.</p>

<p><strong>27.3. Eviction.</strong> Termination of your possession rights or subsequent re-renting doesn’t release you from liability for future rent or other Lease Contract obligations. After filing an eviction suit, we may still accept rent or other sums due; the filing or acceptance doesn’t waive or diminish our right of eviction, or any other contractual or statutory right. Accepting money at any time doesn’t waive our right to damages; past or future rent or other sums; or to continue with eviction proceedings. If you are evicted, you must leave the apartment and cannot live in another bedroom or anywhere else in the apartment. In an eviction, rent is owed for the full rental period and will not be prorated.</p>
<p>However, we will accept past-due rent and costs at any time prior to eviction being completed as required by Pennsylvania statutes.</p>
<p><strong>27.4. WAIVER OF NOTICE:</strong> If the Landlord desires to start a Court action to recover possession for nonpayment of rent or for any other reason, the Resident specifically waives any notice period contained in Section 501 of the Landlord and Resident Act of 1951, as amended, 68 P.S. 250.101 et seq., or any other notice period established by law. THEREFORE, THE LANDLORD MAY FILE SUIT AGAINST THE RESIDENT WITHOUT NOTICE IF THE RESIDENT BREACHES THIS LEASE AGREEMENT, AND RESIDENT AGREES THAT NO NOTICE IS REQUIRED.</p>
<p>Disclaimer: If there is a breach of this Lease Contract and the law does not allow us to evict only the breaching resident, all co-residents may be evicted if only one resident breaches this Lease Contract.</p>
<p><strong>27.5. Other Remedies</strong>. If your rent is delinquent and we give you prior written notice, we may terminate electricity that we’ve furnished at our expense, by following applicable Pennsylvania law, unless governmental regulations on submetering or utility proration provide otherwise. We may report unpaid amounts to credit agencies. If you default and move out early, you will pay us any amounts stated to be rental discounts in this Lease Contract, in addition to other sums due.</p>
<p>Upon your default, we have all other legal remedies, including termination of your tenancy. In a lawsuit under this contract, we may recover from you attorney’s fees and all other litigation costs. Late charges are liquidated damages for our time, inconvenience, and overhead in collecting late rent (but are not for attorney’s fees and litigation costs). All unpaid amounts bear 18% interest per year from due date, compounded annually. You must pay all collection-agency fees if you fail to pay all sums due within ten (10) days after we mail you a letter demanding payment and stating that collection agency fees will be added if you don’t pay all sums by that deadline.</p>
<p><strong>27.6. Mitigation of Damages.</strong> If you move out early, you’ll be subject to any reletting charge described in this Lease Contract and all other remedies. We’ll exercise customary diligence to re-rent and minimize the amount you owe to us. We’ll credit all subsequent rent that we actually receive from subsequent residents against your liability for past-due and future rent and other sums due.</p>
<p><strong>27.7. Default by Other Residents.</strong> If there is a default by another resident, it may not be possible to prevent their occupancy of the apartment during legal proceedings.</p>

<p><strong>28. NO AUTHORITY TO AMEND UNLESS IN WRITING.</strong></p>
<p><strong>28.1. Representatives’ Authority; Waivers; Notice.</strong></p>
<p><strong>Our representatives (including management personnel, employees, and agents) have no authority to waive, amend, or terminate this Lease Contract or any part of it, unless in writing, and no authority to make promises, representations, or agreements that impose security duties or other obligations on us or our representatives unless in writing.</strong></p>
<p>Any dimensions and sizes provided to you relating to the apartment are only approximations or estimates; actual dimensions and sizes may vary. No action or omission of our representative will be considered a waiver of any subsequent violation, default, or time or place of performance. Our not enforcing or belatedly enforcing written-notice requirements, rental due dates, liens, or other rights, isn’t a waiver under any circumstances.</p>
<p>Except when notice or demand is required by statute, you waive any notice and demand for performance from us if you default. Written notice to or from our managers constitutes notice to or from us. Any person giving a notice under this Lease Contract should retain a copy of the memo, letter or fax that was given. Fax signatures are binding. All notices must be signed.</p>
<p><strong>28.2. Entire Agreement.</strong> Neither we nor any of our representatives have made any oral promises, representations, or agreements. This Lease Contract is the entire agreement between you and us.</p>
<p><strong>28.3. Waiver of Jury Trial.</strong> To minimize legal expenses and, to the extent allowed by law, you and we agree that a trial of any lawsuit based on statute common law, and/or related to this Lease Contract shall be to a judge and not a jury.</p>
<p><strong>28.4. Miscellaneous.</strong></p>
<p>(A) Ifweexerciseonelegalrightagainstyou,westill have all other legal rights available in any legal proceeding against you.</p>
<p>(B) Insurance subrogation is waived by all parties.</p>
<p>(C) No employee, agent, or management company is personally liable for any of our contractual, statutory, or other obligations merely by virtue</p>
<p>of acting on our behalf.</p>
<p>(D) This Lease Contract binds subsequent owners.</p>
<p>(E) This Lease remains in effect if any provision or</p>
<p>clause is invalid or if initials are omitted on any</p>
<p>page.</p>
<p>(F) All provisions regarding our non-liability and</p>
<p>non-duty apply to our employees, agents, and</p>
<p>management companies.</p>
<p>(G) This Lease Contract is subordinate or superior</p>
<p>to existing and future recorded mortgages, at</p>
<p>lender’s option.</p>
<p>(H) AllLeaseContractobligationsmustbeperformed</p>
<p>in the county where the apartment is located.</p>
<p>(I) Cablechannelsthatareprovidedmaybechanged during the Lease Contract term if the change</p>
<p>applies to all residents.</p>
<p>(J) Utilities may be used only for normal household purposes and must not be wasted.</p>
<p>(K) If your electricity is ever interrupted, you must use only battery-operated lighting.</p>
<p>(L) All discretionary rights reserved for us within this Lease Contract or any accompanying addenda are at our sole and absolute discretion.</p>
<p>(M) The term “including” in this Lease should be interpreted to mean “including but not limited to.”</p>
<p>(N) Nothing in this Lease constitutes a waiver of our remedies for a breach under your prior lease that occurred before the lease term begins.</p>
<p><strong>28.5. Rooming House.</strong> In no event shall the Apartment be deemed a rooming or lodging house and, in the event any state or local agency makes any determination to the contrary, we reserve the right to terminate the Lease upon seven (7) days’ notice.</p>
<p><strong>28.6.Force Majeure.</strong> If we are prevented from completing performances of any obligations hereunder by an act of God, strikes, epidemics, war, acts of terrorism, riots, flood, fire, hurricane, tornado, sabotage, or other occurrence which is beyond our control, then we shall be excused from any further performance of obligations and undertakings hereunder, to the fullest extent allowed under applicable law. Your exposure to or contracting of a Virus does not excuse you from fulfilling your Lease obligations.</p>
<p>Furthermore, if such an event damages the property to materially affect its habitability or prevents the occupancy of the property by some or all residents, we reserve the right to vacate any and all leases and you agree to excuse us from any further performance of obligations and undertakings hereunder, to the full extent allowed under applicable law.</p>
<p><strong>28.7. Obligationto Vacate.</strong> If we provide you with a notice to vacate, you shall vacate the Apartment and remove all your personal property therefrom at the expiration of the lease term, or by the date set forth in the notice to vacate, whichever date is earlier, without further notice or demand from us.</p>
<p>The Pennsylvania General Assembly has passed legislation (often referred to as “Megan’s Law,” 42 Pa.C.S. Section 9791 et seq.) providing for community notification of the presence of certain convicted sex offenders. Residents with concerns on this issue are encouraged to contact the municipal police department or the Pennsylvania State Police for information relating to the presence of sex offenders near a particular property, or to check the information on the Pennsylvania State Police Web site at www.pameganslaw.state.pa.us.</p>
<h2> End of the Lease</h2>
<p> <strong>29. MOVE-OUT PROCEDURES.</strong> The move-out date can’t be changed unless we and you both agree in writing. You won’t move out before the Lease Contract term or renewal period ends unless all rent for the entire Lease Contract term or renewal period is paid in full. Early move-out may result in re-renting charges. You’re prohibited from applying any security deposit to rent. You won’t stay beyond the date you are supposed to move out.</p>
<p>All residents, guests, and occupants must abandon the apartment before the thirty (30)-day period for deposit refund begins. You must give us and the U.S. Postal Service, in writing, each resident’s forwarding address.</p> 
<p><strong>29.1.Cleaning.</strong> You must thoroughly clean the apartment, including doors, windows, furniture, bathrooms, kitchen appliances, patios, balconies, garages, carports, and storage rooms. You must follow move-out cleaning instructions if they have been provided. If you don’t clean adequately, you’ll be liable for reasonable cleaning charges—including charges for cleaning carpets, draperies, furniture, walls, etc. that are soiled beyond normal wear (that is, wear or soiling that occurs without negligence, carelessness, accident, or abuse).</p>
<p><strong>29.2. Move-Out Inspection.</strong> You should meet with our representative for a move-out inspection. Our representative has no authority to bind or limit us regarding deductions for repairs, damages, or charges. Any statements or estimates by us or our representative are subject to our correction, modification, or disapproval before final refunding or accounting.</p>
<p><strong>30. SURRENDER AND ABANDONMENT.</strong></p>
<p>You have <strong>surrendered</strong> the bedroom and the apartment when:</p>
<p>(A) the move-out date has passed and no one is living in the</p>
<p>apartment in our reasonable judgment; or</p>
<p>(B) all apartment keys and access devices have been turned</p>
<p>in where rent is paid—whichever date occurs first.</p>
<p>You have <strong>abandoned</strong> the bedroom and the apartment when all of the following have occurred:</p>
<p>(A) everyone appears to have moved out in our reasonable</p>
<p>judgment;</p>
<p>(B) clothes, furniture, and personal belongings have been</p>
<p>substantially removed from the bedroom in our</p>
<p>reasonable judgment;</p>
<p>(C) you’vebeenindefaultfornon-paymentofrentforfifteen</p>
<p>(15) consecutive days, or water, gas, or electric service for the apartment not connected in our name has been terminated; and</p>
<p>(D) you’ve not responded for two (2) days to our notice left on the inside of the main entry door, stating that we consider the apartment abandoned.</p>
<p>An apartment is also “abandoned” ten (10) days after the death of a sole resident.</p>
<p><strong>30.1. The Ending of Your Rights.</strong> Surrender, abandonment, and judicial eviction ends your right of possession for all purposes and gives us the immediate right to: clean up, make repairs in, and relet the apartment; determine any security deposit deductions; and remove property left in the apartment. Your surrender or abandonment of the premises does not terminate your responsibility to pay rent or any other balances you may owe.</p>
<p><strong>30.2. Property Left In Apartment.</strong> “Apartment” excludes common areas but includes interior living areas and exterior patios, balconies, attached garages, and storerooms for your exclusive use. In accordance with Section 505.1(b) of the Pennsylvania Landlord and Resident Act, upon your relinquishment of possession of real property, a resident shall remove all personal property from the leased or formerly leased premises.</p>

<h2>General Provisions and Signatures</h2>

<p><strong>31. DISCLOSURE RIGHTS.</strong> If someone requests information on you or your rental history for law-enforcement, governmental, or business purposes, we may provide it.</p>
<p><strong>32. ASSOCIATION MEMBERSHIP.</strong> We represent that either: (1) we or; (2) the management company that represents us, is at the time of signing this Lease Contract or a renewal of this Lease Contract, a member of both the National Apartment Association and any affiliated state and local apartment (multi-housing) associations for the area where the apartment is located.</p>
<p><strong>3. CANCELLATION.</strong> Ifwrittencancellationisreceivedwithin 72 hours of the date you sign this Lease, the Lease will be voided with no penalties to you, unless we have received the first installment or you have been issued keys.</p>
<p><strong>34. SEVERABILITY.</strong> If any provision of this Lease Contract is invalid or unenforceable under applicable law, such provision shall be ineffective to the extent of such invalidity or unenforceability only without invalidating or otherwise affecting the remainder of this Lease Contract. The court shall interpret the lease and provisions herein in a manner such as to uphold the valid portions of this Lease Contract while preserving the intent of the parties.</p>
<p><strong>35. ORIGINALS AND ATTACHMENTS.</strong> This Lease Contract has been executed in multiple originals, with original signatures (for purposes of this section, an electronic signature shall be deemed an original signature). We will provide you with a copy of the Lease Contract. Your copy of the Lease Contract may be in paper format, in an electronic format at your request, or sent via e-mail if we have communicated by e-mail about this Lease. Our rules and community policies, if any, will be attached to the Lease Contract and provided to you at signing. When an Inventory and Condition form is completed, you should retain a copy, and we should retain a copy. Any addenda or amendments you sign as a part of executing this Lease Contract are binding and hereby incorporated into and made part of the Lease Contract between you and us. This lease is the entire agreement between you and us. You acknowledge that you are NOT relying on any oral representations. A copy or scan of this Lease Contract and related addenda, amendments, and agreements may be used for any purpose and shall be treated as an original.</p>
<p><strong>36. SPECIAL PROVISIONS.</strong> The following or attached special provisions and any addenda or written rules furnished to you at or before signing will become a part of this Lease and will supersede any conflicting provisions of this printed Lease form.</p>
<p style="text-decoration: underline;"> See special provisions on the last page</p>
<p>Before submitting a rental application or signing a Lease, you should review the documents and consult an attorney. You are legally bound by this Lease when you sign it. A facsimile or an electronic signature on this Lease is as binding as an original signature.</p>
<p>The leasing process will be completed after we review, approve and return a countersigned Lease to you. You understand a contract has been formed even if the specific apartment or bedroom is to be assigned at a later date.</p>
<p>Additional provisions or changes may be made in the Lease if agreed to in writing by the parties. This Lease is the entire agreement between you and us. You are NOT relying on any oral representations.</p>
<p>You are entitled to receive a copy of this Lease after it is fully signed.</p>
<p>Keep it in a safe place.</p>
<p>NOTICE: YOU ARE GIVING UP CERTAIN IMPORTANT RIGHTS. YOU ARE WAIVING YOUR RIGHT TO HAVE A NOTICE SENT TO YOU BEFORE WE START A COURT ACTION TO RECOVER POSSESSION OF THE APARTMENT FOR NONPAYMENT OR FOR ANY OTHER REASON. YOU ARE ALSO WAIVING YOUR RIGHT TO A JURY TRIAL.</p>

<p>Resident (sign below): {$contract_user->name|escape}</p>
 
{if $contract_info->signing == 1}
<p>Date Signed: {$contract_info->date_signing|date}</p>
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
<p>Owner or Owner’s Representative (signing on behalf of owner):</p>
<p>Date Signed:</p>

<p>Name and address of locator service (if applicable)<br>
_______________________________________________________________________________</p>
<p>Address and phone number of owner’s representative for notice purposes</p>
<p><strong>2970 CLAIRMONT RD STE 310 <br>
Atlanta, Georgia 30329 (404)920-5300</strong></p>

<p><strong>After-hour phone number (267) 317-4110 </strong><br>(Always call 911 for police, fire, or medical emergencies.)</p>

<p style="text-decoration: underline;">SPECIAL PROVISIONS (CONTINUED FROM PAGE 9). SEE PEAK CAMPUS COMMUNITY ADDENDUM AND ALL OTHER ADDENDA ATTACHED HERETO. The Non-Refundable Application Fee shall be $50 and the Administration Fee shall be $100. Reletting charge shall be the lesser of $500 or 100% of one month's rent.</p>
<p style="border: 1px; padding: 10px;">The National Apartment Association’s legal staff is happy to report that the Pennsylvania Lease and accompanying addenda have received Plain Language Preapproval from Pennsylvania’s Office of Attorney General. Though preapproval is not required by law, it provides a safe harbor for owners using our lease that the forms pass muster under the requirements of Pennsylvania’s plain language statute. In the opinion of the Office of Attorney General, a preapproved consumer contract meets the Test of Readability under 73 P. S. § 2205 of the Plain Language Consumer Contract Act. Preapproval of a consumer contract by the Office of Attorney General only means that simple, understandable and easily readable language is used. It is not an approval of the contents or legality of the contract.</p>

<br><br>



<h1 class="center">COMMUNITY POLICIES, RULES AND REGULATIONS ADDENDUM</h1>
<p><span style="font-style: italic">This Addendum is incorporated into the Lease Contract (the “Lease”) identified below and is in addition to all the terms and conditions contained in the Lease. If any terms of this Addendum conflict with the Lease, the terms of this Addendum shall be controlling:</span></p>
<p>Property Owner: <strong>CSC 3701 Chestnut, LLC</strong></p>
<p>Resident(s): <strong>{$contract_user->name}</strong></p>
<p>Unit No:/Address: <strong>3701 Chestnut Street, Philadelphia, PA 19104</strong></p>
<p>Lease Date: <strong>{if $contract_info->signed == 1}{$contract_info->date_signing|date}{else}{$smarty.now|date_format:'%b %e, %Y'}{/if}</strong></p>
<p><strong>I. GENERAL CONDITIONS FOR USE OF APARTMENT PROPERTY AND RECREATIONAL FACILITIES.</strong></p>
<p>Resident(s) permission for use of all common areas, Resident amenities, and recreational facilities (together, “Amenities”) located at the Apartment Community is a privilege and license granted by Owner, and not a contractual right except as otherwise provided for in the Lease. Such permission is expressly conditioned upon Resident’s adherence to the terms of the Lease, this Addendum, and the Community rules and regulations (“Rules”) in effect at any given time, and such permission may be revoked by Owner at any time for any lawful reason. In all cases, the most strict terms of either the Lease, this Addendum, or the Community Rules shall control. Owner reserves the right to set the days and hours of use for all Amenities and to change the character of or close any Amenity based upon the needs of Owner and in Owner’s sole and absolute discretion, without notice, obligation or recompense of any nature to Resident. Owner and management may make changes to the Rules for use of any Amenity at any time.</p>
<p><strong>Additionally, Resident(s) expressly agrees to assume all risks of every type, including but not limited to risks of personal injury or property damage, of whatever nature or severity, related to Resident’s use of the amenities at the Community. Resident(s) agrees to hold Owner harmless and release and waive any and all claims, allegations, actions, damages, losses, or liabilities of every type, whether or not foreseeable, that Resident(s) may have against Owner and that are in any way related to or arise from such use. This provision shall be enforceable to the fullest extent of the law.</strong></p>
<p><strong>THE TERMS OF THIS ADDENDUM SHALL ALSO APPLY TO RESIDENT(S)’ OCCUPANTS, AGENTS AND INVITEES, TOGETHER WITH THE HEIRS, ASSIGNS, ESTATES AND LEGAL REPRESENTATIVES OF THEM ALL, AND RESIDENT(S) SHALL BE SOLELY RESPONSIBLE FOR THE COMPLIANCE OF SUCH PERSONS WITH THE LEASE, THIS ADDENDUM, AND COMMUNITY RULES AND REGULATIONS, AND RESIDENT(S) INTEND TO AND SHALL INDEMNIFY AND HOLD OWNER HARMLESS FROM ALL CLAIMS OF SUCH PERSONS AS DESCRIBED IN THE PRECEDING PARAGRAPH. The term “Owner” shall include the Management, officers, partners, employees, agents, assigns, Owners, subsidiaries and affiliates of Owner.</strong></p>
<p><strong>II. POOL.</strong> This Community <strong>[ ] DOES; [ X ] DOES NOT</strong> have a pool. When using the pool, Resident(s) agrees to the following:</p>
<ul>
<li>Residents and guests will adhere to the rules and regulations posted in the pool area and Management policies.</li>
<li>All Swimmers swim at their own risk. Owner is not responsible for accidents or injuries.</li>
<li>For their safety, Residents should not swim alone.</li>
<li>Pool hours are posted at the pool.</li>
<li>No glass, pets, or alcoholic beverages are permitted in the pool area. Use paper or plastic containers only.</li>
<li>Proper swimming attire is required at all times and a swimsuit “cover up” should be worn to and from the pool.</li>
<li>No running or rough activities are allowed in the pool area. Respect others by minimizing noise, covering pool furniture with a towel when using suntan oils, leaving pool furniture in pool areas, disposing of trash, and keeping pool gates closed.</li>
<li>Resident(s) must accompany their guests.</li>
<li>Resident(s) must notify Owner any time there is a problem or safety hazard at the pool.</li>
</ul>
<h2 class="center">IN CASE OF EMERGENCY DIAL 911</h2>
<p><strong>III. FITNESS CENTER.</strong> This Community <strong>[ X ] DOES; [ ] DOES NOT</strong> have a fitness center. When using the fitness center, Resident agrees to the following:</p>
<ul>
<li>Residents and guests will adhere to the rules and regulations posted in the fitness center and Management policies.</li>
<li>The Fitness Center is not supervised. Resident(s) are solely responsible for their own appropriate use of equipment.</li>
<li>Resident(s) shall carefully inspect each piece of equipment prior to Resident’s use and shall refrain from using any equipment that may be functioning improperly or that may be damaged or dangerous.</li>
<li>Resident(s) shall immediately report to Management any equipment that is not functioning properly, is damaged or appears dangerous, as well any other person’s use that appears to be dangerous or in violation of Management Rules and Policies.</li>
<li>Resident(s) shall consult a physician before using any equipment in the Fitness Center and before participating in any aerobics or exercise class, and will refrain from such use or participation unless approved by Resident’s physician.</li>
<li>Resident(s) will keep Fitness Center locked at all times during Resident’s visit to the Fitness Center.</li>
<li>Resident(s) will not admit any person to the Fitness Center who has not registered with the Management Office.</li>
<li>Resident(s) must accompany guests, and no glass, smoking, eating, alcoholic beverages, pets, or black sole shoes are permitted in the Fitness Center.</li>
</li>
<p><strong>IV. PACKAGE RELEASE.</strong></p>
<p>This Community <strong>[ X ] DOES; [ ] DOES NOT</strong> accept packages on behalf of Residents.</p>
<p><strong><span style="font-style: italic">For communities that do accept packages on behalf of its Residents:</span></strong></p>
<p>Resident(s) gives Owner permission to sign and accept any parcels or letters sent to Resident(s) through UPS, Federal Express, Airborne, United States Postal Service or the like. Resident agrees that Owner does not accept responsibility or liability for any lost, damaged, or unordered deliveries, and agrees to hold Owner harmless for the same.</p>
<p><strong>V. BUSINESS CENTER.</strong> This Community <strong>[ X ] DOES; [ ] DOES NOT</strong> have a business center.</p>
<p>Resident(s) agrees to use the business center at Resident(s) sole risk and according to the Rules and Regulations posted in the business center and Management policies. Owner is not responsible for data, files, programs or any other information lost or damaged on Business Center computers or in the Business Center for any reason. No software may be loaded on Business Center computers without the written approval of Community Management. No inappropriate, offensive, or pornographic images or files (in the sole judgment of Owner) will be viewed or loaded onto the Business Center computers at any time. Residents will limit time on computers to 15 minutes if others are waiting to use them. Smoking, eating, alcoholic beverages, pets, and any disturbing behavior are prohibited in the business center.</p>
<p><strong>VI. AUTOMOBILES/BOATS/RECREATIONAL VEHICLES.</strong> The following policies are in addition to those in the Lease, and may be modified by the additional rules in effect at the Community at any given time:</p>
<ul>
<li>Only <strong>0</strong> vehicle per licensed Resident is allowed.</li>
<li>All vehicles must be registered at the Management office.</li>
<li>Any vehicle(s) not registered, considered abandoned, or violating the Lease, this Addendum, or the Community Rules, in</li>
<li>the sole judgment of Management, will be towed at the vehicle owner’s expense after a   hour notice is placed on the vehicle.</li>
<li>Notwithstanding this, any vehicle illegally parked in a fire lane, designated no parking space or handicapped space, or blocking an entrance, exit, driveway, dumpster, or parked illegally in a designated parking space, will immediately be towed, without notice, at the vehicle owner’s expense.</li>
<li>The washing of vehicles is not permitted on the property unless specifically allowed in designated area.</li>
<li>Any on property repairs and/or maintenance of any vehicle must be with the prior written permission of the Management.</li>
<li>Recreational vehicles, boats or trailers may only be parked on the property with Management’s permission (in Management’s sole discretion), and must be registered with the Management Office and parked in the area(s) designated by Management.</li>
</ul>
<p><strong>VII. FIRE HAZARDS.</strong> In order to minimize fire hazards and comply with city ordinances, Resident shall comply with the following:</p>
<ul>
<li>Residents and guests will adhere to the Community rules and regulations other Management policies concerning fire hazards, which may be revised from time to time.</li>
<li>No person shall knowingly maintain a fire hazard.</li>
<li><strong>Grills, Barbeques, and any other outdoor cooking or open flame devices will be used only on the ground level and will be placed a minimum of feet from any building.</strong> Such devices will not be used close to combustible materials, tall grass or weeds, on exterior walls or on roofs, indoors, on balconies or patios, or in other locations which may cause fires.</li>
<li><strong>Fireplaces</strong>: Only firewood is permitted in the fireplace. No artificial substances, such as Duraflame® logs are permitted. Ashes must be disposed of in metal containers, after ensuring the ashes are cold.</li>
<li>Flammable or combustible liquids and fuels shall not be used or stored (including stock for sale) in apartments, near exits, stairways breezeways, or areas normally used for the ingress and egress of people. This includes motorcycles and any apparatus or engine using flammable or combustible liquid as fuel.</li>
<li>No person shall block or obstruct any exit, aisle, passageway, hallway or stairway leading to or from any structure.</li>
<li>Resident(s) are solely responsible for fines or penalties caused by their actions in violation of local fire protection codes.</li>
<li>The Philadelphia Fire Code, Section 806.1.1 states that no naturally cut trees shall be allowed in multi-family buildings.</li>
</ul>
<p>VIII. EXTERMINATING. Unless prohibited by statute or otherwise stated in the Lease, Owner may conduct extermination operations in Residents’ apartment several times a year and as needed to prevent insect infestation. Owner will notify Residents in advance of extermination in Residents’ apartment, and give Resident instructions for the preparation of the apartment and safe contact with insecticides. Residents will be responsible to prepare the apartment for extermination in accordance with Owner’s instructions. If Residents are unprepared for a scheduled treatment date Owner will prepare Residents’ apartment and charge Residents accordingly. Residents must request extermination treatments in addition to those regularly provided by Owner in writing. <strong>Residents agree to perform the tasks required by Owner on the day of interior extermination to ensure the safety and effectiveness of the extermination. These tasks will include, but are not limited to, the following:</strong></p>
<ul>
<li>Clean in all cabinets, drawers and closets in kitchen and pantry.</li>
<li>Remove pets or place them in bedrooms, and notify Owner of such placement.</li>
<li>If roaches have been seen in closets, remove contents from shelves and floor.</li>
<li>Remove infants and young children from the apartment.</li>
<li>Remove chain locks or other types of obstruction on day of service.</li>
<li>Cover fish tanks and turn off their air pumps.</li>
<li>Do not wipe out cabinets after treatment.</li>
</ul>
<p>In the case of suspected or confirmed bed bug infestation, resident will agree to the following:</p>
<ul>
<li>Resident will wash all clothing, bed sheets, draperies, towels, etc. in extremely hot water.</li>
<li>Resident will thoroughly clean, off premises, all luggage, handbags, shoes and clothes hanging containers.</li>
<li>Resident will cooperate with Owner’s cleaning efforts for all mattresses and seat cushions or other upholstered furniture, and will dispose of same if requested.</li>
</ul>
<p class="center"><strong>RESIDENTS ARE SOLELY RESPONSIBLE TO NOTIFY OWNER IN WRITING PRIOR TO EXTERMINATION OF ANY ANTICIPATED HEALTH OR SAFETY CONCERNS RELATED TO EXTERMINATION AND THE USE OF INSECTICIDES</strong></p>
<p><strong>IX. DRAPES AND SHADES.</strong> Drapes or shades installed by Resident, when allowed, must be lined in white and present a uniform exterior appearance.</p>
<p><strong>X. WATER BEDS.</strong> Resident shall not have water beds or other water furniture in the apartment without prior written permission of Owner.</p>
<p><strong>XI. BALCONY or PATIO.</strong> Balconies and patios shall be kept neat and clean at all times. No rugs, towels, laundry, clothing, appliances or other items shall be stored, hung or draped on railings or other portions of balconies or patios. No misuse of the space is permitted, including but not limited to, throwing, spilling or pouring liquids or other items, whether intentionally or negligently, over the balconies or patios.</p>
<p><strong>XII. SIGNS.</strong> Resident shall not display any signs, exterior lights or markings on apartment. No awnings or other projections shall be attached to the outside of the building of which apartment is a part.</p>
<p><strong>XIII. SATELLITE DISHES/ANTENNAS.</strong> You must complete a satellite addendum and abide by its terms prior to installation or use.</p>
<p><strong>XIV. WAIVER/SEVERABILITY CLAUSE.</strong> No waiver of any provision herein, or in any Community rules and regulations, shall be effective unless granted by the Owner in a signed and dated writing. If any court of competent jurisdiction finds that any clause, phrase, or provision of this Part is invalid for any reason whatsoever, this finding shall not effect the validity of the remaining portions of this Addendum, the Lease Contract or any other addenda to the Lease Contract.</p>
<p><strong>XV. SPECIAL PROVISIONS.</strong> The following special provisions control over conflicting provisions of this printed form:</p>
<p><strong>Grills or any other outdoor cooking or open flame devices are prohibited unless provided by the community in common areas. The fine for a grill on a patio/balcony is a minimum of $100.00. If Resident activates the fire sprinkler system without the danger of fire present, Resident will be responsible for all damages caused by the activation. Anyone found to falsely pull a fire alarm will be subject to criminal charges, a minimum fine of $300.00, and/or a default of the Contract.</strong></p>
<p>I have read, understand and agree to comply with the preceding provisions.</p>


<p>Resident: {$contract_user->name}</p>
<p>Date:
{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}
{/if}
	<br/>SIGNATURE:<br>
</p>

{if $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree1" for="agree1">I agree and sign</label><input type="checkbox" id="agree1" name="agree1" class="agree" value="1"></p>
{/if} 

<p>Owner Representative</p>
<p>Date:{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}
{/if}</p>


<br><br>


<h1 class="center">UTILITY AND SERVICES ADDENDUM</h1>
<p>This Utility Addendum is incorporated into the Lease Contract (referred to in this addendum as “Lease Contract” or “Lease”) dated <strong>{if $contract_info->signed == 1}{$contract_info->date_signing|date}{else}{$smarty.now|date_format:'%b %e, %Y'}{/if}</strong> between CSC 3701 Chestnut, LLC (“We” and/or “we” and/or “us”) and {$contract_user->name} (“You” and/or “you”) of Unit No. ______ located at 3701 Chestnut Street (street address) in Philadelphia, PA 19104</p>
<p>and is in addition to all terms and conditions in the Lease. This Addendum constitutes an Addendum to the above described Lease Contract for the above described premises, and is hereby incorporated into and made a part of such Lease Contract. Where the terms or conditions found in this Addendum vary or contradict any terms or conditions found in the Lease Contract, this Addendum shall control.</p>
<p>1. Responsibility for payment of utilities, and the method of metering or otherwise measuring the cost of the utility, will be as indicated below.</p>
<p>a) <strong>Water</strong> service to your apartment will be paid by you either:</p>
<p>[ ] directly to the utility service provider; or</p>
<p>[ ] water bills will be billed by the service provider to
us and then allocated to you based on the following formula:</p>
<p> - [ ] If flat rate is selected, the current flat rate is $______  per month.</p>
<p> - [ ] 3rd party billing company if applicable __________________________________</p>
<p>b) <strong>Sewer</strong> service to your apartment will be paid by you either:</p>
<p>[ ] directly to the utility service provider; or</p>
<p>[ ] sewer bills will be billed by the service provider to us and then allocated to you based on the following formula:</p>
<p> - [ ] If flat rate is selected, the current flat rate is $______  per month.</p>
<p> - [ ] 3rd party billing company if applicable __________________________________</p>
<p>c) <strong>Gas</strong> service to your apartment will be paid by you either:</p>
<p>[ ] directly to the utility service provider; or</p>
<p>[ ] gas bills will be billed by the service provider to us and then allocated to you based on the following formula:</p>
<p> - [ ] If flat rate is selected, the current flat rate is $______  per month.</p>
<p> - [ ] 3rd party billing company if applicable __________________________________</p>
<p>d) <strong>Trash</strong> service to your apartment will be paid by you either:</p>
<p>[ ] directly to the utility service provider; or</p>
<p>[ ] trashbillswillbebilledbytheserviceprovidertousandthenchargedtoyoubasedonthefollowingformula:</p>
<p> - [ ] If flat rate is selected, the current flat rate is $______  per month.</p>
<p> - [ ] 3rd party billing company if applicable __________________________________</p>
<p>e) <strong>Electric</strong> service to your apartment will be paid by you either:</p>
<p>[ ] directly to the utility service provider; or</p>
<p>[ ] electric bills will be billed by the service provider to us and then allocated to you based on the following formula:</p>
<p> - [ ] If flat rate is selected, the current flat rate is $______  per month.</p>
<p> - [ ] 3rd party billing company if applicable __________________________________</p>
<p>f) <strong>Stormwater</strong> service to your apartment will be paid by you either:</p>
<p>[ ] directly to the utility service provider; or</p>
<p>[ ] stormwater bills will be billed by the service provider to us and then allocated to you based on the following formula:</p>
<p> - [ ] If flat rate is selected, the current flat rate is $______  per month.</p>
<p> - [ ] 3rd party billing company if applicable __________________________________</p>
<p>g) <strong>Cable TV</strong> service to your apartment will be paid by you either:</p>
<p>[ ] directly to the utility service provider; or</p>
<p>[ ] cableTV bills will be billed by the service provider to us and then allocated to you based on the following formula:</p>
<p> - [ ] If flat rate is selected, the current flat rate is $______  per month.</p>
<p> - [ ] 3rd party billing company if applicable __________________________________</p>
<p>h) <strong>Master Antenna</strong> service to your apartment will be paid by you either:</p>
<p>[ ] directly to the utility service provider; or</p>
<p>[ ] masterantenna bills will be billed by the service provider to us and then allocated to you based on the following formula:</p>
<p> - [ ] If flat rate is selected, the current flat rate is $______  per month.</p>
<p> - [ ] 3rd party billing company if applicable __________________________________</p>
<p>i) <strong>Internet</strong> service to your apartment will be paid by you either:</p>
<p>[ ] directly to the utility service provider; or</p>
<p>[ ] internet bills will be billed by the service provider to us and then allocated to you based on the following formula:</p>
<p> - [ ] If flat rate is selected, the current flat rate is $______  per month.</p>
<p> - [ ] 3rd party billing company if applicable __________________________________</p>
<p>j) <strong>Pest Control</strong> service to your apartment will be paid by you either:</p>
<p>[ ] directly to the utility service provider; or</p>
<p>[ ] pestcontrolbillswillbebilledbytheserviceprovidertousandthenchargedtoyoubasedonthefollowingformula:</p>
<p> - [ ] If flat rate is selected, the current flat rate is $______  per month.</p>
<p> - [ ] 3rd party billing company if applicable __________________________________</p>

<p>k) <strong>(Other)</strong> service to your apartment will be paid by you either:</p>
<p>[ ] directly to the utility service provider; or</p>
<p>[ ] bills will be billed by the service provider to us and then allocated to you based on the following formula:</p>
<p> - [ ] If flat rate is selected, the current flat rate is $______  per month.</p>
<p> - [ ] 3rd party billing company if applicable __________________________________</p>
<p>l) <strong>(Other)</strong> service to your apartment will be paid by you either:</p>
<p>[ ] directly to the utility service provider; or</p>
<p>[ ] bills will be billed by the service provider to us and then allocated to you based on the following formula:</p>
<p> - [ ] If flat rate is selected, the current flat rate is $______ per month.</p>
<p> - [ ] 3rd party billing company if applicable</p>
<br>
<p>METERING/ALLOCATION METHOD KEY</p>
<p>“1” - Sub-metering of all of your water/gas/electric use</p>
<p>“2” - Calculation of your total water use based on sub-metering of hot water</p>
<p>“3” - Calculation of your total water use based on sub-metering of cold water</p>
<p>“4” - Flat rate per month</p>
<p>“5” - Allocation based on the number of persons residing in your apartment</p>
<p>“6” - Allocation based on the number of persons residing in your apartment using a ratio occupancy formula</p>
<p>“7” - Allocation based on square footage of your apartment</p>
<p>“8” - Allocation based on a combination of square footage of your apartment and the number of persons residing in your apartment “9” - Allocation based on the number of bedrooms in your apartment</p>
<p>“10”- Allocation based on a lawful formula not listed here</p>
<p>(Note: if method “10” is selected, a separate sheet will be attached describing the formula used)</p>
<p>2. Allocation formulas are used when the apartment has no sub-meter. The formula may be based on factors such as, the interior square footage of the apartment, number of bedrooms, number of occupants, number of bathrooms, presence of washing machine, and average water usage for that floor plan. The allocation is an estimate of usage by the resident. If an allocation method is used, we or our billing company will calculate your allocated share of the utilities and services provided and all costs in accordance with state and local statutes. Under any allocation method, Resident may be paying for part of the utility usage in common areas or in other residential units as well as administrative fees. Both Resident and Owner agree that using a calculation or allocation formula as a basis for estimating total utility consumption is fair and reasonable, while recognizing that the allocation method may or may not accurately reflect actual total utility consumption for Resident. Where lawful, we may change the above methods of determining your allocated share of utilities and services and all other billing methods, in our sole discretion, and after providing written notice to you. More detailed descriptions of billing methods, calculations and allocation formulas will be provided upon request.</p>
<p>If a flat fee method for trash or other utility service is used, Resident and Owner agree that the charges indicated in this Agreement (as may be amended with written notice as specified above) represent a fair and reasonable amount for the service(s) provided and that the amount billed is not based on a monthly per unit cost.</p>
<p>3. When billed by us directly or through our billing company, you must pay utility bills within 30 days of the date when the utility bill is issued at the place indicated on your bill, or the payment will be late. If a payment is late, you will be responsible for a late fee as indicated below. The late payment of a bill or failure to pay any utility bill is a material and substantial breach of the Lease and we will exercise all remedies available under the Lease, up to and including eviction for nonpayment. To the extent there are any new account, monthly administrative, late or final bill fees, you shall pay such fees as indicated below.</p>
<p>New Account Fee: <span style="text-decoration: underline;">$ (not to exceed $)</span></p>
<p>Monthly Administrative Billing Fee: <span style="text-decoration: underline;">$ (not to exceed $)</span></p>
<p>Late Fee: <span style="text-decoration: underline;">$ (not to exceed $)</span></p>
<p>Final Bill Fee: <span style="text-decoration: underline;">$ (not to exceed $)</span></p>
<p>If allowed by state law, we at our sole discretion may amend these fees, with written notice to you.</p>
<p>4. You will be charged for the full period of time that you were living in, occupying, or responsible for payment of rent or utility charges on the apartment. If you breach the Lease, you will be responsible for utility charges for the time period you were obliged to pay the charges under the Lease, subject to our mitigation of damages. In the event you fail to timely establish utility services, we may charge you for any utility service billed to us for your apartment and may charge a reasonable administration fee for billing for the utility service in the amount of <strong>$ 50.00</strong>.</p>
<p>5. When you move out, you will receive a final bill which may be estimated based on your prior utility usage. This bill must be paid at the time you move out or it will be deducted from the security deposit.</p>
<p>6. We are not liable for any losses or damages you incur as a result of outages, interruptions, or fluctuations in utility services provided to the apartment unless such loss or damage was the direct result of negligence by us or our employees. You release us from any and all such claims and waive any claims for offset or reduction of rent or diminished rental value of the apartment due to such outages, interruptions, or fluctuations.</p>
<p>7. You agree not to tamper with, adjust, or disconnect any utility sub-metering system or device. Violation of this provision is a material breach of your Lease and may subject you to eviction or other remedies available to us under your Lease, this Utility Addendum and at law.</p>
<p>8. Wherelawful,allutilities,chargesandfeesofanykindunderthisleaseshallbeconsideredadditionalrent,andifpartialpayments are accepted by the Owner, they will be allocated first to non-rent charges and to rent last.</p>
<p>9. You represent that all occupants that will be residing in the Unit are accurately identified in the Lease. You agree to promptly notify Owner of any change in such number of occupants.</p>
<p>10. You agree that you may, upon thirty (30) days prior written notice from Owner to you, begin receiving a bill for additional utilities and services, at which time such additional utilities and services shall for all purposes be included in the term Utilities.</p>
<p>11. This Addendum is designed for use in multiple jurisdictions, and no billing method, charge, or fee mentioned herein will be used in any jurisdiction where such use would be unlawful. If any provision of this addendum or the Lease is invalid or unenforceable under applicable law, such provision shall be ineffective to the extent of such invalidity or unenforceability only without invalidating or otherwise affecting the remainder of this addendum or the Lease. Except as specifically stated herein, all other terms and conditions of the Lease shall remain unchanged. In the event of any conflict between the terms of this Addendum and the terms of the Lease, the terms of this Addendum shall control.</p>
<p>12. The following special provisions and any addenda or written rules furnished to you at or before signing will become a part of this Utility Addendum and will supersede any conflicting provisions of this printed Utility Addendum and/or the Lease Contract.</p>
<p>Resident agrees to pay an account set-up fee (Telecom Fee) of $99 for new leases and $55 for renewal leases at the time of new move-in or renewal. Such Telecom Fee is required by Owner and includes the cost of set up and management of Internet service. If Owner uses an outside vendor to provide billing services, Owner has the right to charge Resident for such services, and such amount will be payable by Resident as additional rent. Owner has the right to change the third-party billing provider at any time upon written notice to Resident.</p>

<p>Resident: {$contract_user->name}</p>
<p>Date:
{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}
{/if}
	<br/>SIGNATURE:<br>
</p>

{if $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree2" for="agree2">I agree and sign</label><input type="checkbox" id="agree2" name="agree2" class="agree" value="1"></p>
{/if} 

<p>Owner Representative</p>
<p>Date:{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}
{/if}</p>


<br><br>


<h1 class="center">CRIME/DRUG FREE HOUSING ADDENDUM</h1>
<p><strong>1. APARTMENT DESCRIPTION.</strong></p>
<p>Unit No. ______ , 3701 Chestnut Street (street address) in Philadelphia(city), Pennsylvania, 19104 (zip code).</p>
<p><strong>2. LEASE CONTRACT DESCRIPTION.</strong></p>
<p>Lease Contract Date: <strong>{if $contract_info->signed == 1}{$contract_info->date_signing|date}{else}{$smarty.now|date_format:'%b %e, %Y'}{/if}</strong></p>
<p>Owner’s name: CSC 3701 Chestnut, LLC</p>
<p>Residents (list all residents): <strong>{$contract_user->name}</strong></p>
<p>This Addendum constitutes an Addendum to the above described Lease Contract for the above described premises, and is hereby incorporated into and made a part of such Lease Contract. Where the terms or conditions found in this Addendum vary or contradict any terms or conditions found in the Lease Contract, this Addendum shall control.</p>
<p><strong>3. ADDENDUM APPLICABILITY.</strong> In the event any provision in this Addendum is inconsistent with any provision(s) contained in other portions of, or attachments to, the above- mentioned Lease Contract, then the provisions of this Addendum shall control. For purposes of this Addendum, the term “Premises” shall include the apartment, all common areas, all other apartments on the property or any common areas or other apartments on or about other property owned by or managed by the Owner. The parties hereby amend and supplement the Lease Contract as follows:</p>
<p><strong>4. CRIME/DRUG FREE HOUSING.</strong> Resident, members of the Resident’s household, Resident’s guests, and all other persons affiliated with the Resident:</p>
<p>A. Shall not engage in any illegal or criminal activity on or about the premises. The phrase, “illegal or criminal activity” shall include, but is not limited to, the following:</p>
<p>1. Engaging in any act intended to facilitate any type of criminal activity.</p>
<p>2. Permitting the Premises to be used for, or facilitating any type of criminal activity or drug related activity, drug related criminal activity has occurred on or within your apartment; your apartment was used to promote or further drug-related criminal activity; or you or any of your guests has engaged in drug-related criminal activity or or in the immediate vicinity of your apartment.</p>
<p>3. The first conviction for an illegal sale, manufacture or distribution of any drug in violation of the Controlled Substance, Drug, Device and Cosmetic Act in your apartment or on any portion of the community complex;</p>
<p>the second violation of any of the provisions of the Controlled Substance, Drug, Device and Cosmetic Act in your apartment or on any portion of the community complex; the seizure by law enforcement officials of any illegal drugs in your apartment or on any portion of the community complex.</p>
<p>4. Violation of any federal drug laws governing the use, possession, sale, manufacturing and distribution of marijuana, regardless of state or local laws. (So long as the use, possession, sale, manufacturing and distribution of marijuana remains a violation of federal law, violation of any such federal law shall constitute a material violation of this rental agreement.)</p>
<p>5. Any breach of the Lease Contract that otherwise jeopardizes the health, safety, and welfare of the Owner, Owner’s agents, or other Residents, or involving imminent, actual or substantial property damage.</p>
<p>6. Engaging in or committing any act that would be a violation of the Owner’s screening criteria for criminal conduct or which would have provided Owner with a basis for denying Resident’s application due to criminal conduct.</p>
<p>7. Engaging in any activity that constitutes waste, nuisance, or unlawful use.</p>
<p>B. AGREE THAT ANY VIOLATION OF THE ABOVE PROVISIONS CONSTITUTES A MATERIAL VIOLATION OF THE PARTIES’ LEASE CONTRACT AND GOOD CAUSE FOR TERMINATION OF TENANCY. A single violation of any of the provisions of this Addendum shall be deemed a serious violation, and a material default, of the parties’ Lease Contract. It is understood that a single violation shall be good cause for termination of the Lease Contract. Notwithstanding the foregoing comments, Owner may terminate Resident’s tenancy for any lawful reason, and by any lawful method, with or without good cause.</p>
<p>5. CRIMINAL CONVICTION NOT REQUIRED. Unless other wise provided by law, proof of violation of any criminal law shall not require a criminal conviction.</p>
<p>6. SPECIAL PROVISIONS. The following special provisions control over conflicting provisions of this printed form: ___________________________________________________________________________________________________</p>

<p>Resident(s): {$contract_user->name}</p>
<p>Date of Signing Addendum:
{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}
{/if}
	<br/>SIGNATURE:<br>
</p>

{if $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree3" for="agree3">I agree and sign</label><input type="checkbox" id="agree3" name="agree3" class="agree" value="1"></p>
{/if} 

<p>Owner or Owner’s Representative (signs here)</p>
<p>Date of Signing Addendum:{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}<br/>
{/if}</p>

<br><br>


<h1 class="center">NO-SMOKING ADDENDUM</h1>
<p class="center">Date: <strong>{if $contract_info->signed == 1}{$contract_info->date_signing|date}{else}{$smarty.now|date_format:'%b %e, %Y'}{/if}</strong></p>
<p class="center">(when this Addendum is filled out)</p>
<p><span style="font-style: italic">All use of any tobacco product involving smoking, burning, or combustion of tobacco is prohibited in any portion of the apartment community. You are entitled to receive an original of this No-Smoking Addendum after it is fully signed. Keep it in a safe place.</span></p>
<p><strong>1. APARTMENT DESCRIPTION.</strong></p>
<p>Unit No. ______ , 3701 Chestnut Street (street address) in Philadelphia(city), Pennsylvania, 19104 (zip code).</p>
<p><strong>2. LEASE CONTRACT DESCRIPTION.</strong></p>
<p>Lease Contract Date: <strong>{if $contract_info->signed == 1}{$contract_info->date_signing|date}{else}{$smarty.now|date_format:'%b %e, %Y'}{/if}</strong></p>
<p>Owner’s name: CSC 3701 Chestnut, LLC</p>
<p>Residents (list all residents): {$contract_user->name}</p>
<p>This Addendum constitutes an Addendum to the above described Lease Contract for the above described premises, and is hereby incorporated into and made a part of such Lease Contract. Where the terms or conditions found in this Addendum vary or contradict any terms or conditions found in the Lease Contract, this Addendum shall control.</p>
<p><strong>3. DEFINITION OF SMOKING.</strong> Smoking refers to any use or possession of a cigar, cigarette, e-cigarette, hookah, vaporizer, or pipe containing tobacco or a tobacco product while that tobacco or tobacco product is burning, lighted, vaporized, or ignited, regardless of whether the person using or possessing the product is inhaling or exhaling the smoke from such product. The term tobacco includes, but is not limited to any form, compound, or synthesis of the plant of the genus Nicotiana or the species N. tabacum which is cultivated for its leaves to be used in cigarettes, cigars, e-cigarettes, hookahs, vaporizers, or pipes. Smoking also refers to use or possession of burning, lighted, vaporized, or ignited non-tobacco products if they are noxious, offensive, unsafe, unhealthy, or irritating to other persons.</p>
<p><strong>4. SMOKING ANYWHERE INSIDE BUILDINGS OF THE APARTMENT COMMUNITY IS STRICTLY PROHIBITED.</strong> All forms and use of burning, lighted, vaporized, or ignited tobacco products and smoking of tobacco products inside any apartment, building, or interior of any portion of the apartment community is strictly prohibited. Any violation of the no- smoking policy is a material and substantial violation of this Addendum and the Lease Contract.</p>
<p>The prohibition on use of any burning, lighted, vaporized, or ignited tobacco products or smoking of any tobacco products extends to all residents, their occupants, guests, invitees and all others who are present on or in any portion of the apartment community. The no-smoking policy and rules extend to, but are not limited to, the management and leasing offices, building interiors and hallways, building common areas, apartments, club house, exercise or spa facility, tennis courts, all interior areas of the apartment community, commercial shops, businesses, and spaces, work areas, and all other spaces whether in the interior of the apartment community or in the enclosed spaces on the surrounding community grounds.</p>
<p>Smoking of non-tobacco products which are harmful to the health, safety, and welfare of other residents inside any apartment or building is also prohibited by this Addendum and other provisions of the Lease Contract.</p>
<p><strong>5. SMOKING OUTSIDE BUILDINGS OF THE APARTMENT COMMUNITY.</strong> Smoking is permitted only in specially designated areas outside the buildings of the apartment community. Smoking must be at least 50 feet from the buildings in the apartment community, including administrative office buildings. If the previous field is not completed, smoking is only permitted at least 25 feet from the buildings in the apartment community, including administrative office buildings. The smoking-permissible areas are marked by signage.</p>
<p>Smoking on balconies, patios, and limited common areas attached to or outside of your apartment [ ] is [ X ] is not permitted.</p>
<p>The following outside areas of the community may be used for smoking: none-smoke free community</p>
<p>Even though smoking may be permitted in certain limited outside areas, we reserve the right to direct that you and your occupants, family, guests, and invitees cease and desist from smoking in those areas if smoke is entering the apartments or buildings or if it is interfering with the health, safety, or welfare or disturbing the quiet enjoyment, or business operations of us, other residents, or guests.</p>
<p><strong>6. YOUR RESPONSIBILITY FOR DAMAGES AND CLEANING.</strong></p>
<p>You are responsible for payment of all costs and damages to your apartment, other residents’ apartments, or any other portion of the apartment community for repair, replacement, or cleaning due to smoking or smoke related damage caused by you or your occupants, family, guests, or invitees, regardless of whether such use was a violation of this Addendum. Any costs or damages we incur related to repairs, replacement, and cleaning due to your smoking or due to your violation of the no-smoking provisions of the Lease Contract are in excess of normal wear and tear. Smoke related damage, including but not limited to, the smell of tobacco smoke which permeates sheetrock, carpeting, wood, insulation, or other components of the apartment or building is in excess of normal wear and tear in our smoke free apartment community.</p>
<p><strong>7. YOUR RESPONSIBILITY FOR LOSS OF RENTAL INCOME AND ECONOMIC DAMAGES REGARDING OTHER RESIDENTS.</strong> You are responsible for payment of all lost rental income or other economic and financial damages or loss to us due to smoking or smoke related damage caused by you or your occupants, family, guests, or invitees which results in or causes other residents to vacate their apartments, results in disruption of other residents’ quiet enjoyment, or adversely affects other residents’ or occupants’ health, safety, or welfare.</p>
<p><strong>8. LEASE CONTRACT TERMINATION FOR VIOLATION OF THIS ADDENDUM.</strong> We have the right to terminate your Lease Contract or right of occupancy of the apartment for any violation of this No-Smoking Addendum. Violation of the no- smoking provisions is a material and substantial default or violation of the Lease Contract. Despite the termination of the Lease Contract or your occupancy, you will remain liable for rent through the end of the Lease Contract term or the date on which the apartment is re-rented to a new occupant, whichever comes first. Therefore, you may be responsible for payment of rent after you vacate the leased premises even though you are no longer living in the apartment.</p>
<p><strong>9. EXTENT OF YOUR LIABILITY FOR LOSSES DUE TO SMOKING.</strong></p>
<p>Your responsibility for damages, cleaning, loss of rental income, and loss of other economic damages under this No- Smoking Addendum are in addition to, and not in lieu of, your responsibility for any other damages or loss under the Lease Contract or any other addendum.</p>
<p><strong>10. YOUR RESPONSIBILITY FOR CONDUCT OF OCCUPANTS, FAMILY MEMBERS, AND GUESTS.</strong> You are responsible for communicating this community’s no-smoking policy and for ensuring compliance with this Addendum by your occupants, family, guests, and invitees.</p>
<p><strong>11. THERE IS NO WARRANTY OF A SMOKE FREE ENVIRONMENT.</strong> Although we prohibit smoking in all interior parts of the apartment community, there is no warranty or guaranty of any kind that your apartment or the apartment community is smoke free. Smoking in certain limited outside areas is allowed as provided above. Enforcement of our no-smoking policy is a joint responsibility which requires your cooperation in reporting incidents or suspected violations of smoking. You must report violations of our no-smoking policy before we are obligated to investigate and act, and you must thereafter cooperate with us in prosecution of such violations.</p>
<p>This is an important and binding legal document. By signing this Addendum you are agreeing to follow our no-smoking policy and you are acknowledging that a violation could lead to termination of your Lease Contract or right to continue living in the apartment. If you or someone in your household is a smoker, you should carefully consider whether you will be able to abide by the terms of this Addendum.</p>
<p><strong>12. SPECIAL PROVISIONS.</strong> The following special provisions control over conflicting provisions of this printed form:</p>
<p style="text-decoration: underline;">Initial smoking violation charge is $50. Owner reserves the right to escalate per occurrence.</p>
<p>Resident(s): {$contract_user->name}</p>
<p>Date of Signing Addendum:
{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}
{/if}
	<br/>SIGNATURE:<br>
</p>

{if $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree4" for="agree4">I agree and sign</label><input type="checkbox" id="agree4" name="agree4" class="agree" value="1"></p>
{/if} 

<p>Owner or Owner’s Representative (signs here)</p>
<p>Date of Signing Addendum:{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}<br/>
{/if}</p>

<br><br>

<h1 class="center">ADDENDUM REGARDING MEDICAL MARIJUANA USE AND LANDLORD’S COMMITMENT TO ENFORCEMENT OF CRIME/DRUG FREE ADDENDUM</h1>
<p><strong>1. APARTMENT DESCRIPTION.</strong></p>
<p>Unit No. ______ , 3701 Chestnut Street (street address) in Philadelphia(city), Pennsylvania, 19104 (zip code).</p>
<p><strong>2. LEASE CONTRACT DESCRIPTION.</strong></p>
<p>Lease Contract Date: <strong>{if $contract_info->signed == 1}{$contract_info->date_signing|date}{else}{$smarty.now|date_format:'%b %e, %Y'}{/if}</strong></p>
<p>Owner’s name: CSC 3701 Chestnut, LLC</p>
<p>Residents (list all residents): {$contract_user->name}</p>
<p>This Addendum constitutes an Addendum to the above described Lease Contract for the above described premises, and is hereby incorporated into and made a part of such Lease Contract. Where the terms or conditions found in this Addendum vary or contradict any terms or conditions found in the Lease Contract, this Addendum shall control.</p>
<p>3. The Medical Marijuana Actpermits the limited use of medical marijuana in specific and limited circumstances. However, this is not the case under federal law. Under federal law, specifically the Controlled Substances Act (CSA), marijuana is still categorized as a Schedule I substance. This means that under federal law, the manufacture, distribution, or possession of marijuana is strictly prohibited. Because the U.S. Department of Housing and Urban Development is controlled by the federal government, it agrees that the use of marijuana, whether prescribed for medical reasons or not, is a criminal offense and will not be protected under the fair housing laws. Therefore, apartment complexes are not required to accommodate the use of marijuana by a tenant who is a current medical marijuana user. Disabled tenants who are registered medical marijuana users, however, should not feel discouraged to request reasonable accommodations if the need arises.</p>
<p>4. The Premises listed above follows and complies with federal law regarding marijuana use and is, and will continue to be, a drug free community. Possession, use, manufacture or sale of any illegal substance, including marijuana, or any use of marijuana by the tenant and/or guests will result in immediate termination. If you have any questions or concerns about this policy, please speak to management.</p>
<p>5. By signing below, the resident acknowledges his or her understanding of the terms and conditions as stated above, and his or her agreement to comply with those terms and conditions.</p>
<p><strong>6. SPECIAL PROVISIONS.</strong> The following special provisions control over conflicting provisions of this printed form:</p>

<p>Resident(s): {$contract_user->name}</p>
<p>Date of Signing Addendum:
{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}
{/if}
	<br/>SIGNATURE:<br>
</p>

{if $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree5" for="agree5">I agree and sign</label><input type="checkbox" id="agree5" name="agree5" class="agree" value="1"></p>
{/if} 

<p>Owner or Owner’s Representative (signs here)</p>
<p>Date of Signing Addendum:{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}<br/>
{/if}</p>

<br><br>

<h1 class="center">ADDENDUM PROHIBITING SHORT-TERM SUBLETTING OR RENTAL</h1>
<p><strong>1. APARTMENT DESCRIPTION.</strong></p>
<p>Unit No. ______ , 3701 Chestnut Street (street address) in Philadelphia(city), Pennsylvania, 19104 (zip code).</p>
<p><strong>2. LEASE CONTRACT DESCRIPTION.</strong></p>
<p>Lease Contract Date: <strong>{if $contract_info->signed == 1}{$contract_info->date_signing|date}{else}{$smarty.now|date_format:'%b %e, %Y'}{/if}</strong></p>
<p>Owner’s name: CSC 3701 Chestnut, LLC</p>
<p>Residents (list all residents): {$contract_user->name}</p>
<p>This Addendum constitutes an Addendum to the above described Lease Contract for the above described premises, and is hereby incorporated into and made a part of such Lease Contract. Where the terms or conditions found in this Addendum vary or contradict any terms or conditions found in the Lease Contract, this Addendum shall control.</p>
<p><strong>3. SHORT TERM SUBLEASE OR RENTING PROHIBITED.</strong> Without limiting the prohibition in the Lease on subletting, assignment, and licensing, and without limiting any of our rights or remedies, this Addendum to the Lease further supplements and defines the requirements and prohibitions contained in the Lease Contract between you and us. You are hereby strictly prohibited from subletting, licensing, or renting to any third party, or allowing occupancy by any third party, of all or any portion of the apartment, whether for an overnight use or duration of any length, without our prior written consent in each instance. This prohibition applies to overnight stays or any other stays arranged on Airbnb.com or other similar internet sites.</p>
<p><strong>4. PROHIBITION ON LISTING OR ADVERTISING APARTMENT ON OVERNIGHT SUBLETTING OR RENTING WEBSITES.</strong> You agree not to list or advertise the apartment as being available for short term subletting or rental or occupancy by others on Airbnb.com or similar internet websites. You agree that listing or advertising the apartment on Airbnb.com or similar internet websites shall be a violation of this Addendum and a breach of your Lease Contract.</p>
<p><strong>5. VIOLATION OF LEASE AGREEMENT.</strong> Your Lease Contract allows for use of your apartment as a private residence only and strictly prohibits conducting any kind of business in, from, or involving your apartment unless expressly permitted by law. Separately, your Lease Contract prohibits subletting or occupancy by others of the apartment for any period of time without our prior written consent. Permitting your apartment to be used for any subletting or rental or occupancy by others (including, without limitation, for a short term), regardless of the value of consideration received or if no consideration is received, is a violation and breach of this Addendum and your Lease Contract.</p>

<p><strong>6. REMEDY FOR VIOLATION.</strong> Any violation of this Addendum constitutes a material violation of the Lease Contract, and as such we may exercise any default remedies permitted in the Lease Contract, including termination of your tenancy, in accordance with local law. This clause shall not be interpreted to restrict our rights to terminate your tenancy for any lawful reason, or by any lawful method.</p>
<p><strong>7. RESIDENT LIABILITY.</strong> You are responsible for and shall be held liable for any and all losses, damages, and/or fines that we incur as a result of your violations of the terms of this Addendum or the Lease Contract. Further, you agree you are responsible for and shall be held liable for any and all actions of any person(s) who occupy your apartment in violation of the terms of this Addendum or the Lease Contract, including, but not limited to, property damage, disturbance of other residents, and violence or attempted violence to another person. In accordance with applicable law, without limiting your liability you agree we shall have the right to collect against any renter’s or liability insurance policy maintained by you for any losses or damages that we incur as the result of any violation of the terms of this Addendum.</p>
<p><strong>8. SEVERABILITY.</strong> If any provision of this Addendum or the Lease Contract is invalid or unenforceable under applicable law, such provision shall be ineffective to the extent of such invalidity or unenforceability only without invalidating or otherwise affecting the remainder of this Addendum or the Lease Contract. The court shall interpret the lease and provisions herein in a manner such as to uphold the valid portions of this Addendum while preserving the intent of the parties.</p>
<p><strong>9. SPECIAL PROVISIONS.</strong> The following special provisions control over conflicting provisions of this printed form:</p>

<p>Resident(s): {$contract_user->name}</p>
<p>Date of Signing Addendum:
{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}
{/if}
	<br/>SIGNATURE:<br>
</p>

{if $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree6" for="agree6">I agree and sign</label><input type="checkbox" id="agree6" name="agree6" class="agree" value="1"></p>
{/if} 

<p>Owner or Owner’s Representative (signs here)</p>
<p>Date of Signing Addendum:{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}<br/>
{/if}</p>

<br><br>

<h1 class="center">MOLD INFORMATION AND PREVENTION ADDENDUM</h1>

<p style="background: #efefef; padding: 5px 10px;"><span style="font-style: italic">Please note: It is our goal to maintain a quality living environment for our residents. To help achieve this goal, it is important to work together to minimize any mold growth in your apartment. That is why this addendum contains important information for you, and responsibilities for both you and us.</span></p>

<p><strong>1. APARTMENT DESCRIPTION.</strong></p>
<p>Unit No. ______ , 3701 Chestnut Street (street address) in Philadelphia(city), Pennsylvania, 19104 (zip code).</p>
<p><strong>2. LEASE CONTRACT DESCRIPTION.</strong></p>
<p>Lease Contract Date: <strong>{if $contract_info->signed == 1}{$contract_info->date_signing|date}{else}{$smarty.now|date_format:'%b %e, %Y'}{/if}</strong></p>
<p>Owner’s name: CSC 3701 Chestnut, LLC</p>
<p>Residents (list all residents): {$contract_user->name}</p>
<p>This Addendum constitutes an Addendum to the above described Lease Contract for the above described premises, and is hereby incorporated into and made a part of such Lease Contract. Where the terms or conditions found in this Addendum vary or contradict any terms or conditions found in the Lease Contract, this Addendum shall control.</p>
<p><strong>3. ABOUT MOLD.</strong> Mold is found virtually everywhere in our environment--both indoors and outdoors and in both new and old structures. Molds are naturally occurring microscopic organisms which reproduce by spores and have existed practically from the beginning of time. All of us have lived with mold spores all our lives. Without molds we would all be struggling with large amounts of dead organic matter.</p>
<p>Mold breaks down organic matter in the environment and uses the end product for its food. Mold spores (like plant pollen) spread through the air and are commonly transported by shoes, clothing and other materials. When excess moisture is present inside an apartment, mold can grow. A 2004 Federal Centers for Disease Control and Prevention study found that there is currently no scientific evidence that the accumulation of mold causes any significant health risks for person with normally functioning immune systems. Nonetheless, appropriate precautions need to be taken.</p>
<p><strong>4. PREVENTING MOLD BEGINS WITH YOU.</strong> In order to minimize the potential for mold growth in your apartment, you must do the following:</p>
<ul>
	<li>Keep your apartment clean--particularly the kitchen, the bathroom(s), carpets and floors. Regular vacuuming, mopping and using a household cleaner to clean hard surfaces is important to remove the household dirt and debris that harbor mold or food for mold. Immediately throw away moldy food.</li>
	<li>Removevisiblemoistureaccumulationonwindows,walls, ceilings, floors and other surfaces as soon as reasonably possible. Look for leaks in washing machine hoses and discharge lines-especially if the leak is large enough for water to infiltrate nearby walls. Turn on any exhaust fans in the bathroom and kitchen before you start showering or cooking with open pots. When showering, be sure to keep the shower curtain inside the tub or fully close the shower doors. Also, the experts recommend that after taking a shower or bath, you: (1) wipe moisture off of shower walls, shower doors, the bathtub and the bathroom floor; (2) leave the bathroom door open until all moisture on the mirrors and bathroom walls and tile surfaces has dissipated; and (3) hang up your towels and bath mats so they will completely dry out.</li>
	<li>Promptlynotifyusinwritingaboutanyairconditioningor heating system problems you discover. Follow our rules, if any, regarding replacement of air filters. Also, it is recommended that you periodically open windows and doors on days when the outdoor weather is dry (i.e., humidity is below 50 percent) to help humid areas of your apartment dry out.</li>
	<li>Promptlynotifyusinwritingaboutanysignsofwaterleaks, water infiltration or mold. We will respond in accordance with state law and the Lease Contract to repair or remedy the situation, as necessary.</li>
	<li>Keep the thermostat set to automatically circulate air in the event temperatures rise to or above 80 degrees Fahrenheit.</li>
</ul>

<p><strong>5. IN ORDER TO AVOID MOLD GROWTH,</strong> it is important to prevent excessive moisture buildup in your apartment. Failure to promptly pay attention to leaks and moisture that might accumulate on apartment surfaces or that might get inside walls or ceilings can encourage mold growth. Prolonged moisture can result from a wide variety of sources, such as:</p>
<ul>
	<li>rainwater leaking from roofs, windows, doors and outside walls, as well as flood waters rising above floor level;</li>
	<li>overflows from showers, bathtubs, toilets, lavatories, sinks, washing machines, dehumidifiers, refrigerator or A/C drip pans or clogged up A/C condensation lines;</li>
	<li>leaksfromplumbinglinesorfixtures,andleaksintowalls from bad or missing grouting/caulking around showers, tubs or sinks;</li>
	<li>washing machine hose leaks, plant watering overflows, pet urine, cooking spills, beverage spills and steam from excessive open-pot cooking;</li>
	<li>leaks from clothes dryer discharge vents (which can put lots of moisture into the air); and</li>
	<li>insufficient drying of carpets, carpet pads, shower walls and bathroom floors.</li>
</ul>
<p><strong>6. IF SMALL AREAS OF MOLD HAVE ALREADY OCCURRED ON NON-POROUS SURFACES</strong> (such as ceramic tile, formica, vinyl flooring, metal, wood or plastic), the federal Environmental Protection Agency (EPA) recommends that you first clean the areas with soap (or detergent) and water, let the surface dry, and then within 24 hours apply a pre-mixed, spray-on-type household biocide, such as Lysol Disinfectant®, Pine-Sol Disinfectant® (original pine-scented), Tilex Mildew Remover® or Clorox Cleanup®. (Note: Only a few of the common household cleaners will actually kill mold.) Tilex® and Clorox® contain bleach which can discolor or stain. <strong>Be sure to follow the instructions on the container.</strong> Applying biocides without first cleaning away the dirt and oils from the surface is like painting over old paint without first cleaning and preparing the surface.</p>
<p>Always clean and apply a biocide to an area 5 or 6 times larger than any visible mold because mold may be adjacent in quantities not yet visible to the naked eye. A vacuum cleaner with a high-efficiency particulate air (HEPA) filter can beused to help remove non-visible mold products from porous items, such as fibers in sofas, chairs, drapes and carpets-- provided the fibers are completely dry. Machine washing or dry cleaning will remove mold from clothes.</p>
<p><strong>7. DO NOT CLEAN OR APPLY BIOCIDES TO</strong>: (1) visible mold on porous surfaces, such as sheetrock walls or ceilings, or (2) large areas of visible mold on non-porous surfaces. Instead, notify us in writing, and we will take appropriate action.</p>
<p><strong>8. COMPLIANCE</strong>. Complying with this addendum will help prevent mold growth in your apartment, and both you and we will be able to respond correctly if problems develop that could lead to mold growth. If you have questions regarding this addendum, please contact us at the management office or at the phone number shown in your Lease Contract.</p>
<p><strong>If you fail to comply with this Addendum, you can be held responsible for property damage to the apartment and any health problems that may result. We can’t fix problems in your apartment unless we know about them.</strong></p>

<p><strong>9. SPECIAL PROVISIONS.</strong> The following special provisions control over conflicting provisions of this printed form:</p>
<p style="text-decoration:underline;">Do not block or cover heating, ventilation or air conditioning ("HVAC") ducts in the premises. Resident must operate the HVAC system in a reasonable manner so as to maintain temperatures in the premises within a range of 62 to 78 degrees Fahrenheit. Resident must use bathroom fans while bathing or showering, kitchen fans while cooking, and utility area fans while water is being used. Continue use of fans for at least 30 minutes after the activity. Resident must notify Owner of any signs of water leaks, water infiltration, or mold within 24 hours of discovery.</p>


<p>Resident(s): {$contract_user->name}</p>
<p>Date of Signing Addendum:
{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}
{/if}
	<br/>SIGNATURE:<br>
</p>

{if $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree7" for="agree7">I agree and sign</label><input type="checkbox" id="agree7" name="agree7" class="agree" value="1"></p>
{/if} 

<p>Owner or Owner’s Representative (signs here)</p>
{if $contract_info->signing == 1}
<p>Date of Lease Contract: {$contract_info->date_signing|date}
{/if}

<br><br>

<div class="center">
<h1>BED BUG ADDENDUM</h1>
<p>Date: <strong>{if $contract_info->signed == 1}{$contract_info->date_signing|date}{else}{$smarty.now|date_format:'%b %e, %Y'}{/if}</strong></p>
<p><span style="font-style: italic">(when this Addendum is filled out)</span></p>
</div>

<p style="background: #efefef; padding: 5px 10px;"><span style="font-style: italic">Please note: It is our goal to maintain a quality living environment for our residents. To help achieve this goal, it is important to work together to minimize the potential for any bed bugs in your apartment or surrounding apartments. This addendum contains important information that outlines your responsibility and potential liability with regard to bed bugs.</span></p>
<p><strong>1. APARTMENT DESCRIPTION.</strong></p>
<p>Unit No. ______ , 3701 Chestnut Street (street address) in Philadelphia(city), Pennsylvania, 19104 (zip code).</p>
<p><strong>2. LEASE CONTRACT DESCRIPTION.</strong></p>
<p>Lease Contract Date: <strong>{if $contract_info->signed == 1}{$contract_info->date_signing|date}{else}{$smarty.now|date_format:'%b %e, %Y'}{/if}</strong></p>
<p>Owner’s name: CSC 3701 Chestnut, LLC</p>
<p>Residents (list all residents): {$contract_user->name}</p>
<p>This Addendum constitutes an Addendum to the above described Lease Contract for the above described premises, and is hereby incorporated into and made a part of such Lease Contract. Where the terms or conditions found in this Addendum vary or contradict any terms or conditions found in the Lease Contract, this Addendum shall control.</p>

<p><strong>3. PURPOSE.</strong> This Addendum modifies the Lease Contract and addresses situations related to bed bugs (cimex lectularius) which may be discovered infesting the apartment or personal property in the apartment. You understand that we relied on your representations to us in this Addendum.</p>

<p><strong>4. INSPECTION AND INFESTATIONS. BY SIGNING THIS ADDENDUM, YOU REPRESENT THAT:</strong></p>

<p>• YOU HAVE INSPECTED THE DWELLING PRIOR TO MOVING IN, OR PRIOR TO SIGNING THIS ADDENDUM, AND YOU DID NOT FIND ANY EVIDENCE OF BED BUGS OR A BED BUG INFESTATION;</p>
<p>OR</p>
<p>• YOU WILL INSPECT THE DWELLING WITHIN 48 HOURS AFTER MOVING IN, OR WITHIN 48 HOURS AFTER SIGNING THIS ADDENDUM AND WILL NOTIFY US OF ANY BED BUGS OR BED BUG INFESTATIONS.</p>
<p>You agree that you have read the information provided in this Addendum and that you are not aware of any infestation or presence of bed bugs in your current or previous dwellings, furniture, clothing, personal property, or possessions. You also acknowledge that you have fully disclosed to us any previous bed bug infestations or bed bug issues that you have experienced.</p>
<p>If you disclose to us a previous experience with bed bug infestations or other bed bug related issues, we can review documentation of the previous treatment(s) and inspect your personal property and possession to confirm the absence of bed bugs.</p>
<p><strong>5. ACCESS FOR INSPECTION AND PEST TREATMENT.</strong> You must allow us and our pest control agents access to the apartment at reasonable times to inspect for or treat bed bugs as allowed by law. You and your family members, occupants, guests, and invitees must cooperate and will not interfere with inspections or treatments. We have the right to select any licensed pest control professional to treat the apartment and building. We can select the method of treating the apartment, building and common areas for bed bugs. We can also inspect and treat adjacent or neighboring apartments to the infestation even if those apartments are not the source or cause of the known infestation. Unless otherwise prohibited by law, you are responsible for and must, at your own expense, have your own personal property, furniture, clothing and possessions treated according to accepted treatment methods established by a licensed pest control firm that we approve. You must do so as close as possible to the time we treated the apartment. If you fail to do so, you will be in default, and we will have the right to terminate your right of occupancy and exercise all rights and remedies under the Lease Contract. You agree not to treat the apartment for a bed bug infestation on your own.</p>
<p><strong>6. NOTIFICATION.</strong> You must promptly notify us:</p>
<ul>
	<li>of any known or suspected bed bug infestation or presence in the apartment, or in any of your clothing, furniture or personal property.</li>
	<li>of any recurring or unexplained bites, stings, irritations, or sores of the skin or body which you believe is caused by bed bugs, or by any condition or pest you believe is in the apartment.</li>
	<li>if you discover any condition or evidence that might indicate the presence or infestation of bed bugs, or of any confirmation of bed bug presence by a licensed pest control professional or other authoritative source.</li>
</ul>
<p><strong>7. COOPERATION.</strong> If we confirm the presence or infestation of bed bugs, you must cooperate and coordinate with us and our pest control agents to treat and eliminate the bed bugs. You must follow all directions from us or our agents to clean and treat the apartment and building that are infested. You must remove or destroy personal property that cannot be treated or cleaned as close as possible to the time we treated the apartment. Any items you remove from the apartment must be disposed of off-site and not in the property’s trash receptacles. If we confirm the presence or infestation of bed bugs in your apartment, we have the right to require you to temporarily vacate the apartment and remove all furniture, clothing and personal belongings in order for us to perform pest control services. If you fail to cooperate with us, you will be in default, and we will have the right to terminate your right of occupancy and exercise all rights and remedies under the Lease Contract.</p>
<p><strong>8. RESPONSIBILITIES.</strong> You may be required to pay all reasonable costs of cleaning and pest control treatments incurred by us to treat your apartment for bed bugs. If we confirm the presence or infestation of bed bugs after you vacate your apartment, you may be responsible for the cost of cleaning and pest control treatments. If we must move other residents in order to treat adjoining or neighboring apartments to your apartment, you may be liable for payment of any lost rental income and other expenses incurred by us to relocate the neighboring residents and to clean and perform pest control treatments to eradicate infestations in other apartments. If you fail to pay us for any costs you are liable for, you will be in default, and we will have the right to terminate your right of occupancy and exercise all rights and remedies under the Lease Contract, and obtain immediate possession of the apartment. If you fail to move out after your right of occupancy has been terminated, you will be liable for holdover rent under the Lease Contract.</p>
<p><strong>9. TRANSFERS.</strong> If we allow you to transfer to another apartment in the community because of the presence of bed bugs, you must have your personal property and possessions treated according to accepted treatment methods or procedures established by a licensed pest control professional. You must provide proof of such cleaning and treatment to our satisfaction.</p>
<p><strong>10. SPECIAL PROVISIONS.</strong> The following special provisions control over conflicting provisions of this printed form: ___________________________________________________</p>
<p class="center"><strong>You are legally bound by this document. Please read it carefully.</strong></p>

<p>Resident: {$contract_user->name}</p>
<p>Date:
{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}
{/if}
	<br/>SIGNATURE:<br>
</p>

{if $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree14" for="agree14">I agree and sign</label><input type="checkbox" id="agree14" name="agree14" class="agree" value="1"></p>
{/if} 

<p>Owner Representative</p>
<p>Date:{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}
{/if}</p>

<p><span style="font-style: italic">You are entitled to receive an original of this Addendum after it is fully signed. Keep it in a safe place.</span></p>

<hr>

<h1 class="center">BED BUGS - A Guide for Rental Housing Residents</h1>

<p>Bed bugs, with a typical lifespan of 6 to 12 months, are wingless, flat, broadly oval-shaped insects. Capable of reaching the size of an apple seed at full growth, bed bugs are distinguishable by their reddish-brown color, although after feeding on the blood of humans and warm-blooded animals--their sole food source-- the bugs assume a distinctly blood-red hue until digestion is complete.</p>
<p>
	<strong>Bed bugs don’t discriminate</strong>
</p>
<p>Bed bugs increased presence across the United States in recent decades can be attributed largely to a surge in international travel and trade. It’s no surprise then that bed bugs have been found time and time again to have taken up residence in some of the fanciest hotels and apartment buildings in some of the nation’s most expensive neighborhoods.</p>
<p>Nonetheless, false claims that associate bed bugs presence with poor hygiene and uncleanliness have caused rental housing residents, out of shame, to avoid notifying owners of their presence. This serves only to enable the spread of bed bugs.</p>
<p>While bed bugs are, by their very nature, more attracted to clutter, they’re certainly not discouraged by cleanliness.</p>
<p>Bottom line: bed bugs know no social and economic bounds; claims to the contrary are false.</p>
<p><strong>Bed bugs don’t transmit disease</strong></p>
<p>There exists no scientific evidence that bed bugs transmit disease. In fact, federal agencies tasked with addressing pest of public health concern, namely the U.S. Environmental Protection Agency and the Centers for Disease Control and Prevention, have refused to elevate bed bugs to the threat level posed by disease transmitting pests. Again, claims associating bed bugs with disease are false.</p>
<p><strong>Identifying bed bugs</strong></p>
<p><span style="font-style: italic">Bed bugs can often be found in, around and between:</span></p>
<ul>
	<li>Bedding</li>
	<li>Bed frames</li>
	<li>Mattress seams</li>
	<li>Upholstered furniture, especially under cushions and along seams</li>
	<li>Around, behind and under wood furniture, especially along areas where drawers slide</li>
	<li>Curtains and draperies</li>
	<li>Along window and door frames</li>
	<li>Ceiling and wall junctions</li>
	<li>Crown moldings</li>
	<li>Behind and around wall hangings and loose wallpaper</li>
	<li>Between carpeting and walls (carpet can be pulled away from the wall and tack strip)</li>
	<li>Cracks and crevices in walls and floors</li>
	<li>Inside electronic devices, such as smoke and carbon monoxide detectors</li>
	<li>Because bed bugs leave some persons with itchy welts strikingly similar to those caused by fleas and mosquitoes, the origination of such markings often go misdiagnosed. However, welts caused by bed bugs often times appear in succession and on exposed areas of skin, such as the face, neck and arms. In some cases, an individual may not experience any visible reaction resulting from direct contact with bed bugs.</li>
	<li>While bed bugs typically prefer to act at night, they often do not succeed in returning to their hiding spots without leaving traces of their presence through fecal markings of a red to dark brown color, visible on or near beds. Blood stains tend also to appear when the bugs have been squashed, usually by an unsuspecting host in their sleep. And, because they shed, it’s not uncommon for skin casts to be left behind in areas typically frequented by bed bugs.</li>
</ul>
<p><strong>Preventing bed bug encounters when traveling</strong></p>
<p>Because humans serve as bed bugs’ main mode of transportation, it is extremely important to be mindful of bed bugs when away from home. Experts agree that the spread of bed bugs across all regions of the United States is largely attributed to an increase in international travel and trade. Travelers are therefore encouraged to take a few minutes upon arriving to their temporary destination to thoroughly inspect their accommodations, so as to ensure that any uninvited guests are detected before the decision is made to unpack.</p>
<p>Because bed bugs can easily travel from one room to another, it is also recommended that travelers thoroughly inspect their luggage and belongings for bed bugs before departing for home.</p>
<p><strong>Bed bug do’s and don’ts</strong></p>
<ul>
	<Li>Do not bring used furniture from unknown sources into your apartment. Countless bed bug infestations have stemmed directly from the introduction into a resident’s unit of second- hand and abandoned furniture. Unless the determination can be made with absolute certainty that a piece of second-hand furniture is bed bug-free, residents should assume that the reason a seemingly nice looking leather couch, for example, is sitting curbside, waiting to be hauled off to the landfill, may very well be due to the fact that it’s teeming with bed bugs.</Li>
	<Li>Do address bed bug sightings immediately. Rental housing residents who suspect the presence of bed bugs in their unit must immediately notify the owner.</Li>
	<Li>Do not attempt to treat bed bug infestations. Under no circumstance should you attempt to eradicate bed bugs. Health hazards associated with the misapplication of traditional and non-traditional, chemicalbased insecticides and pesticides poses too great a risk to you and your neighbors.</Li>
	<Li>Do comply with eradication protocol. If the determination is made that your unit is indeed playing host to bed bugs, you must comply with the bed bug eradication protocol set forth by both your owner and their designated pest management company.</Li>
</ul>

<br><br>

<h1 class="center">PHILADELPHIA BED BUG ADDENDUM</h1>

<p><strong>Resident: {$contract_user->name}</strong></p>

<p><strong>Property Address: 3701 Chestnut Street Philadelphia, PA 19104</strong></p>

<p>1. The history of bed bugs in your unit during the previous 120 days is as follows: (check one)</p>
<p>a. [ X ] There has been no history of bed bug infestation</p>
<p>b. [ ] There was a bed bug infestation as follows (describe the history of the bed bug infestation and the remediation that was done for the dwelling unit): ________________________________________</p>
<p>2. Resident acknowledges having received the informational notice regarding bed bugs prepared by the City of Philadelphia, a copy of which is attached hereto.</p>
<p>3. Owner has developed, maintained and is following a bed bug control plan as required by City of Philadelphia ordinance Section 9-4500 et seq.</p>

<p>Resident(s): {$contract_user->name}</p>
<p>Date of Signing Addendum:
{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}
{/if}
	<br/>SIGNATURE:<br>
</p>

{if $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree8" for="agree8">I agree and sign</label><input type="checkbox" id="agree8" name="agree8" class="agree" value="1"></p>
{/if} 

<p>Owner or Owner’s Representative (signs here)</p>
{if $contract_info->signing == 1}
<p>Date of Lease Contract: {$contract_info->date_signing|date}
{/if}

<br><br>

<h1 class="center">PACKAGE ACCEPTANCE ADDENDUM</h1>

<p><strong>1. APARTMENT DESCRIPTION.</strong></p>
<p>Unit No. ______ , 3701 Chestnut Street (street address) in Philadelphia(city), Pennsylvania, 19104 (zip code).</p>
<p><strong>2. LEASE CONTRACT DESCRIPTION.</strong></p>
<p>Lease Contract Date: <strong>{if $contract_info->signed == 1}{$contract_info->date_signing|date}{else}{$smarty.now|date_format:'%b %e, %Y'}{/if}</strong></p>
<p>Owner’s name: CSC 3701 Chestnut, LLC</p>
<p>Residents (list all residents): {$contract_user->name}</p>
<p>This Addendum constitutes an Addendum to the above described Lease Contract for the above described premises, and is hereby incorporated into and made a part of such Lease Contract. Where the terms or conditions found in this Addendum vary or contradict any terms or conditions found in the Lease Contract, this Addendum shall control.</p>
<p><strong>3. PURPOSE OF ADDENDUM.</strong> By signing this Addendum, you wish for us to sign for, and to accept, U.S. mail and privately- delivered packages or other items on your behalf, subject to the terms and conditions set forth herein.</p>
<p><strong>4. PACKAGE ACCEPTANCE.</strong></p>
<p>A. Generally. You hereby authorize us and our agent to accept, on your behalf, any package or item delivered to our on-site management office during disclosed business hours, including but not limited to any package delivered by the U.S. Postal Service or by any private courier service or individual. You also specifically authorize us to sign on your behalf if the person or entity delivering said package or item requires an adult signature prior to delivery, including but not limited to the delivery of certified or registered mail. A photo I.D. is required before any packages will be released. Packages will only be released to verified Residents or approved representatives.</p>
<p>B. Limitations. You understand and agree that we may refuse to accept any package for any reason or no reason at all.</p>
<p><strong>5. TIME LIMITATION.</strong> Due to limited storage space, we must ask that you pick up your package as soon as possible. You also agree that we shall have no duty whatsoever to hold or store any package for more than 30 days after receipt (accordingly, you should notify the management office if you are going to be away from the apartment home and expect to be receiving a package(s)). After said time, you agree that any such package is deemed abandoned and you authorize us to return the package to its original sender.</p>

<p><strong>6. DUTY OF CARE, INDEMNIFICATION, ASSUMPTION OF RISKS AND WAIVER.</strong> As to any package for which we sign and/or receive on your behalf, you understand and agree that we have no duty to notify you of our receipt of such package, nor do we have any duty to maintain, protect, or deliver said package to you, nor do we have any duty to make said package available to you outside disclosed business hours. Any packages or personal property delivered to us or stored by us shall be at your sole risk, and you assume all risks whatsoever associated with any loss or damage to your packages and personal property. You, your guests, family, invitees, and agents hereby waive any and all claims against us or our agents of any nature regarding or relating to any package or item received by us, including but not limited to, claims for theft, misplacing or damaging any such package, except in the event of our or our agent’s gross negligence or willful misconduct. You also agree to defend and indemnify us and our agents and hold us both harmless from any and all claims that may be brought by any third party relating to any injury sustained relating to or arising from any package that we received on your behalf. You also agree to indemnify us and our agents and hold us harmless from any damage caused to us or our agents by any package received by us for you. You also authorize us to throw away or otherwise dispose of any package that we, in our sole discretion, deem to be dangerous, noxious, or in the case of packaged food, spoiled, and waive any claim whatsoever resulting from such disposal.</p>
<p><strong>7. SEVERABILITY.</strong> If any provision of this Addendum or the Lease Contract is illegal, invalid or unenforceable under any applicable law, then it is the intention of the parties that (a) such provision shall be ineffective to the extent of such invalidity or unenforceability only without invalidating or otherwise affecting the remainder of this Addendum or the Lease, (b) the remainder of this Addendum shall not be affected thereby, and (c) it is also the intention of the parties to this Addendum that in lieu of each clause or provision that is illegal, invalid or unenforceable, there be added as a part of this Addendum a clause or provision similar in terms to such illegal, invalid or unenforceable clause or provision as may be possible and be legal, valid and enforceable.</p>
<p><strong>8. SPECIAL PROVISIONS.</strong> The following special provisions control over conflicting provisions of this printed form:</p>
<p style="text-decoration: underline;">If Owner uses a third-party package delivery, storage, or locker system to receive or store resident packages, then resident may be required to register for such service directly with the provider before resident's packages can be delivered to the community. If resident fails to complete any such registration, packages may be refused.</p>

<p>Resident(s): {$contract_user->name}</p>
<p>Date of Signing Addendum:
{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}
{/if}
	<br/>SIGNATURE:<br>
</p>

{if $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree9" for="agree9">I agree and sign</label><input type="checkbox" id="agree9" name="agree9" class="agree" value="1"></p>
{/if} 

<p>Owner or Owner’s Representative (signs here)</p>
<p>Date of Signing Addendum:{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}<br/>
{/if}</p>

<br><br>

<hr>

<h1 class="center">LEASE CONTRACT ADDENDUM FOR SATELLITE DISH OR ANTENNA</h1>
<p>Under a Federal Communications Commission (FCC) order, you as our resident have a right to install a transmitting or receiving satellite dish or antenna on the leased premises, subject to FCC limitations. We as a rental housing owner are allowed to impose reasonable restrictions relating to such installation. You are required to comply with these restrictions as a condition of installing such equipment. This addendum contains the restrictions that you and we agree to follow.</p>
<p><strong>1. APARTMENT DESCRIPTION.</strong></p>
<p>Unit No. ______ , 3701 Chestnut Street (street address) in Philadelphia(city), Pennsylvania, 19104 (zip code).</p>
<p><strong>2. LEASE CONTRACT DESCRIPTION.</strong></p>
<p>Lease Contract Date: <strong>{if $contract_info->signed == 1}{$contract_info->date_signing|date}{else}{$smarty.now|date_format:'%b %e, %Y'}{/if}</strong></p>
<p>Owner’s name: CSC 3701 Chestnut, LLC</p>
<p>Residents (list all residents): {$contract_user->name}</p>
<p>This Addendum constitutes an Addendum to the above described Lease Contract for the above described premises, and is hereby incorporated into and made a part of such Lease Contract. Where the terms or conditions found in this Addendum vary or contradict any terms or conditions found in the Lease Contract, this Addendum shall control.</p>
<p><strong>3. NUMBER AND SIZE.</strong> You may install <strong>1</strong> satellite dish(es) or antenna(s) on the leased premises. A satellite dish may not exceed one meter (3.3 feet) in diameter. Antennas that only transmit signals or that are not covered by 47 CFR § 1.4000 are prohibited.</p>
<p><strong>4. LOCATION.</strong> Your satellite dish or antenna must be located: (1) inside your apartment; or (2) in an area outside your apartment such as a balcony, patio, yard, etc. of which you have exclusive use under your lease. Installation is not permitted on any parking area, roof, exterior wall, window, window sill, fence or common area, or in an area that other residents are allowed to use. A satellite dish or antenna may not protrude beyond the vertical and horizontal space that is leased to you for your exclusive use.</p>
<p><strong>5. SAFETY AND NON-INTERFERENCE.</strong> Your installation: (1) must comply with all applicable ordinances and laws and all reasonable safety standards; (2) may not interfere with our cable, telephone or electrical systems or those of neighboring properties; (3) may not be connected to our telecommunication systems; and (4) may not be connected to our electrical system except by plugging into a 110-volt duplex receptacle. If the satellite dish or antenna is placed in a permitted outside area, it must be safely secured by one of three methods: (1) securely attaching it to a portable, heavy object such as a small slab of concrete (cinder block); (2) clamping it to a part of the building’s exterior that lies within your leased premises (such as a balcony or patio railing); or (3) any other method approved by us in writing. No other methods are allowed. We may require reasonable screening of the satellite dish or antenna by plants, etc., so long as it does not impair reception.</p>
<p><strong>6. SIGNAL TRANSMISSION FROM EXTERIOR DISH OR ANTENNA TO INTERIOR OF APARTMENT.</strong> You may not damage or alter the leased premises and may not drill holes through outside walls, door jams, window sills, etc. If your satellite dish or antenna is installed outside your apartment (on a balcony, patio, etc.), the signals received by it may be transmitted to the interior of your apartment only by the following methods: (1) running a “flat” cable under a door jam or window sill in a manner that does not physically alter the premises and does not interfere with proper operation of the door or window; (2) running a traditional or flat cable through a pre-existing hole in the wall (that will not need to be enlarged to accommodate the cable); (3) connecting cables “through a window pane,” similar to how an external car antenna for a cellular phone can be connected to inside wiring by a device glued to either side of the window--without drilling a hole through the window; (4) wireless transmission of the signal from the satellite dish or antenna to a device inside the apartment; or (5) any other method approved by us in writing.</p>
<p><strong>7. SAFETY IN INSTALLATION.</strong> In order to assure safety, the strength and type of materials used for installation must be approved by us. Installation must be done by a qualified person or company approved by us. Our approval will not be unreasonably withheld. An installer provided by the seller of the satellite dish or antenna is presumed to be qualified.</p>
<p><strong>8. MAINTENANCE.</strong> You will have the sole responsibility for maintaining your satellite dish, antenna and all related equipment.</p>
<p><strong>9. REMOVAL AND DAMAGES.</strong> You must remove the satellite dish or antenna and all related equipment when you move out of the apartment. In accordance with NAA Lease Contract, you must pay for any damages and for the cost of repairs or repainting caused by negligence, carelessness, accident or abuse which may be reasonably necessary to restore the leased premises to its condition prior to the installation of your satellite dish, antenna or related equipment. You will not be responsible for normal wear.</p>
<p><strong>10. LIABILITY INSURANCE AND INDEMNITY.</strong> You must take full responsibility for the satellite dish, antenna and related equipment. If the dish or antenna is installed at a height that could result in injury to others if it becomes unattached and falls, you must provide us with evidence of liability insurance (if available) to protect us against claims of personal injury and property damage to others, related to your satellite dish, antenna and related equipment. The insurance coverage must be $ 100000.00 ,whichisanamountreasonablydetermined by us to accomplish that purpose. Factors affecting the amount of insurance include height of installation above ground level, potential wind velocities, risk of the dish/ antenna becoming unattached and falling on someone, etc. You agree to hold us harmless and indemnify us against any of the above claims by others.</p>
<p><strong>11. SECURITY DEPOSIT.</strong> Your security deposit is increased by an additional reasonable sum of <strong>$0.00</strong> to help protect us against possible repair costs damages, or failure to remove the satellite dish, antenna and related equipment at time of move-out. Factors affecting any security deposit may vary, depending on: (1) how the dish or antenna is attached (nails, screws, lag bolts drilled into walls); (2) whether holes were permitted to be drilled through walls for the cable between the satellite dish and the TV; and (3) the difficulty and cost of repair or restoration after removal, etc.</p>
<p><strong>12. WHEN YOU MAY BEGIN INSTALLATION.</strong> You may start installation of your satellite dish, antenna or related equipment only after you have: (1) signed this addendum; (2) provided us with written evidence of the liability insurance referred to in this addendum; (3) paid us the additional security deposit, if applicable; and (4) received our written approval of the installation materials and the person or company that will do the installation, which approval may not be unreasonably withheld.</p>
<p><strong>13. MISCELLANEOUS.</strong> If additional satellite dishes or antennas are desired, an additional lease addendum must be executed.</p>
<p><strong>14. SPECIAL PROVISIONS.</strong> The following special provisions control over conflicting provisions of this printed form: ___________________________________________________________________________</p>

<p>Resident(s): {$contract_user->name}</p>
<p>Date of Signing Addendum:
{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}
{/if}
	<br/>SIGNATURE:<br>
</p>

{if $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree10" for="agree10">I agree and sign</label><input type="checkbox" id="agree10" name="agree10" class="agree" value="1"></p>
{/if} 

<p>Owner or Owner’s Representative (signs here)</p>
<p>Date of Signing Addendum:{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}<br/>
{/if}</p>

<br><br>

<h1 class="center">CLASS ACTION WAIVER ADDENDUM</h1>
<p><strong>1. APARTMENT DESCRIPTION.</strong></p>
<p>Unit No. ______ , 3701 Chestnut Street (street address) in Philadelphia(city), Pennsylvania, 19104 (zip code).</p>
<p><strong>2. LEASE CONTRACT DESCRIPTION.</strong></p>
<p>Lease Contract Date: <strong>{if $contract_info->signed == 1}{$contract_info->date_signing|date}{else}{$smarty.now|date_format:'%b %e, %Y'}{/if}</strong></p>
<p>Owner’s name: CSC 3701 Chestnut, LLC</p>
<p>Residents (list all residents): {$contract_user->name}</p>
<p>This Addendum constitutes an Addendum to the above described Lease Contract for the above described premises, and is hereby incorporated into and made a part of such Lease Contract. Where the terms or conditions found in this Addendum vary or contradict any terms or conditions found in the Lease Contract, this Addendum shall control.</p>
<p><strong>3. CLASS ACTION WAIVER.</strong> You agree that you hereby waive your ability to participate either as a class representative or member of any class action claim(s) against us or our agents. While you are not waiving any right(s) to pursue claims against us related to your tenancy, you hereby agree to file any claim(s) against us in your individual capacity, and you may not be a class action plaintiff, class representative, or member in any purported class action lawsuit (“Class Action”). Accordingly, you expressly waive any right and/or ability to bring, represent, join, or otherwise maintain a Class Action or similar proceeding against us or our agents in any forum.</p>
<p><strong>Any claim that all or any part of this Class Action waiver provision is unenforceable, unconscionable, void, or voidable shall be determined solely by a court of competent jurisdiction.</strong></p>
<p><strong>YOU UNDERSTAND THAT, WITHOUT THIS WAIVER, YOU MAY HAVE POSSESSED THE ABILITY TO BE A PARTY TO A CLASS ACTION LAWSUIT. BY SIGNING THIS AGREEMENT, YOU UNDERSTAND AND CHOOSE TO WAIVE SUCH ABILITY AND CHOOSE TO HAVE ANY CLAIMS DECIDED INDIVIDUALLY. THIS CLASS ACTION WAIVER SHALL SURVIVE THE TERMINATION OR EXPIRATION OF THIS LEASE CONTRACT.</strong></p>
<p><strong>4. SEVERABILITY.</strong> If any clause or provision of this Addendum is illegal, invalid or unenforceable under any present or future laws, then it is the intention of the parties hereto that the remainder of this Addendum shall not be affected thereby.</p>
<p><strong>5. SPECIAL PROVISIONS.</strong> The following special provisions control over conflicting provisions of this printed form: ___________________________________________________________________________</p>

<p>Resident’s Acknowledgment: {$contract_user->name}</p>
<p>Date of Signing Addendum:
{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}
{/if}
	<br/>SIGNATURE:<br>
</p>

{if $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree11" for="agree11">I agree and sign</label><input type="checkbox" id="agree11" name="agree11" class="agree" value="1"></p>
{/if} 

<p>Landlord (or Landlord Agent) Acknowledgment</p>
<p>Date of Signing Addendum:{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}<br/>
{/if}</p>

<br><br>

<hr>

<h1 class="center">REASONABLE MODIFICATIONS AND ACCOMMODATIONS POLICY</h1>
<p><strong>1. APARTMENT DESCRIPTION.</strong></p>
<p>Unit No. ______ , 3701 Chestnut Street (street address) in Philadelphia(city), Pennsylvania, 19104 (zip code).</p>
<p><strong>2. LEASE CONTRACT DESCRIPTION.</strong></p>
<p>Lease Contract Date: <strong>{if $contract_info->signed == 1}{$contract_info->date_signing|date}{else}{$smarty.now|date_format:'%b %e, %Y'}{/if}</strong></p>
<p>Owner’s name: CSC 3701 Chestnut, LLC</p>
<p>Residents (list all residents): {$contract_user->name}</p>
<p>This Addendum constitutes an Addendum to the above described Lease Contract for the above described premises, and is hereby incorporated into and made a part of such Lease Contract. Where the terms or conditions found in this Addendum vary or contradict any terms or conditions found in the Lease Contract, this Addendum shall control.</p>


<p><strong>3. EQUAL HOUSING OPPORTUNITY POLICY.</strong> We provide rental housing on an equal opportunity basis. Consistent with this policy, we welcome persons with disabilities to our community and will not discriminate against any person because of his or her disability, or his or her association with anyone with a disability. In addition, we know that it may sometimes be necessary for persons with disabilities to be able to make modifications to their surroundings or to have accommodations made in our practices or procedures to enable them to fully enjoy and use their housing, and we have created the policy described herein to meet that need.</p>
<p><strong>4. PURPOSE OF POLICY.</strong> A resident or applicant may be entitled under state and federal fair housing laws to a reasonable accommodation and/or reasonable modification when needed because of a disability of the resident, the applicant, and/or a person associated with a resident or applicant, such as a member of the household or frequent guest. The reasonable accommodation and/or reasonable modification must be necessary for the individual with the disability to have an equal opportunity to fully use and/or enjoy housing services offered to other residents and/or the individual apartment. We will grant requests for accommodations or modifications that are reasonable and necessary because of a disability, would not impose an undue financial or administrative burden on our operations, and do not fundamentally alter the nature of services or resources we provide as part of our housing program.</p>
<p><strong>5. DEFINITIONS.</strong></p>
<p>A. Disability. The Federal Fair Housing Act defines a person
with a disability to include: (1) individuals with a physical or mental impairment that substantially limits one or more major life activities; (2) individuals who are regarded as having such an impairment; or (3) individuals with a record of such an impairment.</p>
<p>B. Reasonable Modifications. A reasonable modification is a structural change made to existing premises, occupied or to be occupied, by a person with a disability, in order to afford such person full enjoyment of the premises. These are typically structural changes to interiors and exteriors of apartments and to common and public use areas, which are necessary to accommodate a person with a disability. Depending on the nature of the request, reasonable modifications are typically granted at the expense of the person requesting them.</p>
<p>C. Reasonable Accommodation. A reasonable accommodation is a change, exception, or adjustment to a rule, policy, practice, or service that may be necessary for a person with a disability to have an equal opportunity to use and enjoy an apartment, including public and common areas.</p>
<p><strong>6. REQUESTS FOR REASONABLE MODIFICATIONS.</strong></p>
<p>A. Generally. If you are a resident or an applicant (i) with a disability, or (ii) with someone associated with you who has a disability, you have the right to request a reasonable modification to your apartment or the common areas, in accordance with fair housing laws, if such modifications may be necessary to allow you to have an equal opportunity to fully use and/or enjoy your apartment.</p>
<p>B. Reasonable Modification Expenses. Expenses for reasonable modifications, and restoration expenses, if applicable, of such modifications, shall be allocated in accordance with state and federal fair housing laws.</p>
<p>C. Permission Required, Evaluation of Disability. If you would like to request a reasonable modification to your apartment or the common areas of the community that is necessary because of a disability, you must first obtain permission from us. We prefer that you use the attached “Reasonable Accommodation and/or Modification to Rental Unit” form, but you are not required to use this form. If you would like or need assistance in completing this form, please let us know, and we will be glad to provide assistance. Whether you use our form or your own form of request, we will need to know what specific modification is being sought. In addition, if the disability or the disability-related need for the modification is not obvious, we may ask for information that is reasonably necessary to evaluate the disability-related need for the modification; however, we will only request information necessary to evaluate your request, and all information will be kept confidential.</p>
<p>D. Reasonable Assurances. Depending on the modification requested, we may require you to provide reasonable assurances that the modification will be done in a workmanlike manner and that any required building permits will be obtained. In some cases, any third-party retained to perform the modification may also have to be approved in writing by us, and be properly licensed and insured. During and upon completion of the modification, we may inspect the work in connection with our overall property management responsibilities. We will not increase your security deposit as a result of a modification request. However, when applicable, if you fail to restore the interior of the apartment to its original condition, excluding normal wear and tear, at the end of the tenancy, we may assess the cost of restoration against your security deposit and/or final account upon move-out.</p>
<p>E. Restoration Reimbursement. At the end of your tenancy, you may be responsible to restore the interior of your apartment to its pre-modification condition at your expense, depending on the nature of the modification. Again, depending on the modification, we may request that you deposit sufficient funds for that restoration in an interest bearing escrow account to ensure any required restoration can be completed. Regardless of modification, you will remain responsible to pay for damage to your apartment in excess of ordinary wear and tear.</p>
<p>F. Alternative Modification. Depending on the circumstances, we may not be able to grant the exact modification you have requested and we may ask to discuss other alternatives with you.</p>
<p><strong>7. REQUESTS FOR REASONABLE ACCOMMODATIONS.</strong></p>
<p>A. Generally. We will make reasonable accommodations in our rules, policies, practices, and/or services, to the extent that such accommodations may be reasonably necessary to give you, as a disabled person, an equal opportunity to fully use and enjoy your apartment, and the public and common areas of the premises, and as otherwise required by law.</p>
<p>B. Request for Accommodation, Evaluation of Disability. If you would like a reasonable accommodation that is necessary because of a disability, please submit a request to us, preferably using the attached “Reasonable Accommodation and/or Modification to Rental Unit” form, but you are not required to use this form. If you would like or need assistance completing this form please let us know and we will be glad to provide assistance. Whether you use our form or your own form of request, we will need to know what accommodation is being sought. In addition, if the disability is not obvious, we may ask for information that is reasonably necessary to evaluate the disability-related need for the accommodation. We will only request information that is reasonably necessary for us to evaluate your request, and we will keep all information you provide confidential.</p>
<p>C. Alternative Accommodation. Depending on the circumstances, we may not be able to grant the exact accommodation you have requested and we may ask to discuss other alternatives with you.</p>
<p><strong>8. OWNER RESPONSIBILITY.</strong> We will respond to all requests for a reasonable accommodation and/or modification in a timely manner. If we deny your request for a reasonable modification and/or accommodation, we will explain the reason for our denial and we will discuss with you whether there are alternative accommodations and/or modifications that we could provide that would meet your needs. We also are committed to entering into an interactive dialogue with you in relation to any request, and therefore agree to speak with you in relation to any request so that you have sufficient opportunity to provide us with any information you believe is relevant to our evaluation of your request for the modification(s) and/or accommodation(s).</p>
<p><strong>9. AMENDMENT TO POLICY.</strong> This policy may be amended and updated at any time upon written notice to you. In addition, in the event of any conflict between this policy and/or state, local or federal law, the provisions of such law shall control.</p>
<p>If you have any questions about this policy, you should contact:</p>
<p><strong>Property Manager</strong></p>
<p>by writing or calling:</p>
<p><strong>Leasing Office</strong></p>
<br>
<p>Resident(s): {$contract_user->name}</p>
<p>Date of Signing Addendum:
{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}
{/if}
	<br/>SIGNATURE:<br>
</p>

{if $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree12" for="agree12">I agree and sign</label><input type="checkbox" id="agree12" name="agree12" class="agree" value="1"></p>
{/if} 

<p>Owner or Owner’s Representative (signs here)</p>
<p>Date of Signing Addendum:{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}<br/>
{/if}</p>

<br><br>

<h1 class="center">LEAD DISCLOSURE AND CERTIFICATION ADDENDUM TO LEASE</h1>
<p><strong>Resident(s): {$contract_user->name}</strong></p>
<p><strong>Property Address: 3701 Chestnut Street, Philadelphia, PA 19104</strong></p>

<o><strong>I. CHECK WHICH ZIP CODE PROPERTY IS LOCATED IN TO DETERMINE DATE THE NEW LAW APPLIES TO YOUR PROPERTY.</strong></p>
<p>(Check one of the following.)</p>
<p>A. [ ] Check if property is located within the following zip codes:</p>
<p>19121, 19131, 19132, 19133, 19138, 19139, 19140, 19141, 19143, 19144, 19151</p>
<p>If your property is located within one of the zip codes above,the new law appliesas of: October 1, 2020.</p>
<p>B. [ X ] Check if property is located within one of the following zip codes:</p>
<p>19102, 19104, 19119, 19120, 19122, 19124, 19126, 19127, 19134, 19137, 19142</p>
<p>If your property is located within one of the zip codes above, the new law applies as of: April 1, 2021.</p>
<p>C. [ ] Check if property is located within one of the following zip codes:</p>
<p>19107, 19118, 19125, 19128, 19129, 19130, 19135, 19145, 19146, 19148, 19153</p>
<p>If your property is located within one of the zip codes above, the new law applies as of: October 1, 2021.</p>
<p>D. [ ] Check if property is located within one of the following zip codes:</p>
<p>19103, 19106, 19111, 19114, 19115, 19116, 19123, 19136, 19147, 19149, 19150, 19152, 19154</p>
<p>If your property is located within one of the zip codes above, the new law applies as of: April 1, 2022.</p>
<p>*** Note the date that the new law applies to your property. If that date has passed, go to Section III below. If that date has not yet passed, proceed to Section II below. ***</p>
<p><strong>II. WILL A CHILD THAT IS SIX (6) OR UNDER RESIDE IN THE RESIDENTIAL DWELLING?</strong> (Check one of the following.)</p>
<p>A.[ ] No child six (6) or under will reside in the residential dwelling during the lease term. In addition, Resident is not pregnant to their knowledge. Under this circumstance, no lead dust wipe test, Lead-Free or Lead-Safe certifications are required.</p>
<p>B.[ ] A child six (6) or under will reside in the residential dwelling or Resident is pregnant, to their knowledge. Under this circumstance, a lead dust wipe test and Lead-Safe Certification or Lead-Free Certification is required unless one of the following applies: (Check if any of the following apply.)</p>
<p>1. [ ] The property was developed by and for educational institutions for exclusive use and occupancy of the institutions’ students;</p>
<p>2. [ ] The building’s units are leased only to students enrolled at a college or university; or</p>
<p>3. [ ] The property is Philadelphia Housing Authority (PHA) housing or residential property leased under HUD programs including housing vouchers (Section 8).</p>
<p>*** Resident acknowledges and agrees that it is Resident’s responsibility to update Owner of any change in the foregoing. Resident is responsible for notifying Owner if Resident is pregnant or if Resident has a child six (6) or under residing in the residential dwelling during the original lease term and during any and all renewals.</p>
<p><strong>III. LEAD SERVICE LINE AND PLUMBING COMPONENT DISCLOSURE</strong></p>
<p>Owner hereby sets forth Owner’s knowledge or lack thereof regarding lead service lines and lead plumbing components:</p>
<p><span style="font-style: italic">(Check one of the following.)</span></p>
<p>A. [ X ] Owner has no knowledge of any lead service line or lead plumbing components. Accordingly, there may be a lead service line or lead plumbing components, but Owner is not aware of them.</p>
<p>B. [ ] Owner knows and acknowledges that there are lead service lines, lead plumbing components, or both.</p>
<p><strong>IV. LEAD WARNING STATEMENT</strong></p>
<p>EVERY RESIDENT OF ANY INTEREST IN RESIDENTIAL PROPERTY ON WHICH A RESIDENTIAL DWELLING WAS BUILT PRIOR TO 1978 IS NOTIFIED THAT SUCH RESIDENTIAL DWELLING MAY PRESENT EXPOSURE TO LEAD FROM LEAD-BASED PAINT AND/OR LEAD DUST THAT MAY PLACE YOUNG CHILDREN AT RISK OF DEVELOPING LEAD POISONING. LEAD POISONING IN YOUNG CHILDREN MAY PRODUCE PERMANENT NEUROLOGICAL DAMAGE, INCLUDING LEARNING DISABILITIES, REDUCED INTELLIGENCE QUOTIENT, BEHAVIOR PROBLEMS AND IMPAIRED MEMORY. LEAD POISONING ALSO POSES A PARTICULAR RISK TO PREGNANT WOMEN. THE OWNER OF ANY INTEREST IN RESIDENTIAL REAL PROPERTY IS REQUIRED TO DISCLOSE TO THE RESIDENT THE PRESENCE OR ABSENCE OF ANY LEAD-BASED PAINT AND/OR LEAD-BASED PAINT HAZARDS.</p>
<p>IN RESIDENTIAL HOUSING CONSTRUCTED PRIOR TO 1978, A COMPREHENSIVE LEAD INSPECTION OR A RISK ASSESSMENT FOR POSSIBLE LEAD-BASED PAINT AND/OR LEAD-BASED PAINT HAZARDS IS RECOMMENDED PRIOR TO LEASE. EVERY RESIDENT OF ANY INTEREST IN RESIDENTIAL PROPERTY IS NOTIFIED THAT ANY RESIDENTIAL DWELLING, REGARDLESS OF CONSTRUCTION DATE, MAY HAVE A LEAD WATER SERVICE LINE OR LEAD PLUMBING COMPONENTS. REGARDLESS OF THE CONSTRUCTION DATE, THE OWNER OF ANY INTEREST IN RESIDENTIAL REAL PROPERTY IS REQUIRED TO DISCLOSE TO THE RESIDENT THE KNOWN EXISTENCE OF A LEAD WATER SERVICE LINE. YOU ARE ADVISED TO READ THE PAMPHLET CONTAINING INFORMATION ON LEAD WATER SERVICE LINES AND LEAD PLUMBING COMPONENTS PROVIDED AT THE TIME OF ENTERING INTO THE LEASE.</p>
<p>NOTE: RESIDENT IS ADVISED TO PERFORM A VISUAL INSPECTION OF ALL PAINTED SURFACES PERIODICALLY DURING THE TERM OF THE LEASE AND MAY INFORM THE OWNER OF ANY CRACKED, FLAKING, CHIPPING, PEELING OR OTHERWISE DETERIORATING PAINT SURFACES.</p>

<p><strong>V. DATE PROPERTY BUILT</strong></p>
<p>(Check one of the following.)</p>
<p>A. [ ] Residential Property was built March 1978 or thereafter. Under this circumstance, the provisions of this addendum relating to lead from lead-based paint or dust DO NOT apply. The Resident still retains the option to test for lead. The Owner still must disclose the existence of any known lead service line.</p>
<p>B. [ X ] Residential Property was built prior to March 1978.</p>
<p>(Check one of the options below.)</p>
<ul>
	<li>
		<p>1. [ ] The new law DOES NOT apply to your property as determined in Section I above (your property does not fall within one of the zip codes where the date that the new law applies has passed), and the owner of any “Targeted Housing,” as defined below, built prior to March 1978, is required to perform a comprehensive lead inspection conducted by a certified lead inspector or other qualified professional and provide either a certificate of lead-safe or lead-free status.</p>
		<p>“Targeted housing” is defined as residential property built before March 1978, but excluding:</p>
		<ul type="a">
			<li>a. Residential property developed by and for educational institutions for exclusive use and occupancy of the institutions’ students;</li>
			<li>b. Building’s whose units are leased only to students enrolled at a college or university;</li>
			<li>c. Philadelphia Housing Authority (PHA) housing and residential property leased under the HUD programs including housing vouchers (section 8); or</li>
			<li>d. Residential dwellings in which children aged six or under do not and will not reside during the lease term.</li>
		</ul>
	</li>
	<li>
		<p>2.[ X ] The new law applies to your property as determined in Section I above (your property falls within one of the zip codes where the date that the new law applies has passed), and the owner of any “Targeted Housing,” as defined below, built prior to March 1978, is required to perform a comprehensive lead inspection conducted by a certified lead inspector or other qualified professional and provide either a certificate of lead-safe or lead-free status.</p>
		<p>“Targeted housing” is defined as residential property built before March 1978, but excluding:</p>
		<p>College and university housing and other educational housing that is exclusively for students where non-family members are not permitted to reside.</p>
		<p> If the residential property was built before March 1978 and none of the above exclusions apply, the Owner has given the Resident the following, upon entering into the lease agreement:</p>
		<ul>
			<li>Lead Information Pamphlet – Protect Your Family from Lead in Your Home • Partners for Good Housing Pamphlet</li>
			<li>The Notices contained within this Addendum</li>
			<li>Certification of Lead-Safe or Lead-Free status from a qualified professional</li>
		</ul>
	</li>
</ul>

<p><strong>VI. ALL RESIDENTS HAVE THE OPTION TO TEST FOR LEAD</strong></p>
<p>Resident has the option to have a comprehensive lead inspection and risk assessment from a certified lead inspector performed at their cost. If the Resident chooses to have a lead inspection or risk assessment, it must be done within 10 days of the date the Resident signs this form. The Resident and the Owner can agree in writing to a different period of time. In the case of residential housing constructed prior to 1978, should the inspection reveal lead-based paint or lead-based paint hazards on the premises; or in the case of any residential housing, should the inspection reveal a lead service line or lead plumbing components, the Resident may terminate the lease within two business days of the receipt of the inspection report, with all moneys paid on account to be refunded to the Resident. Failure of the Resident to obtain such inspection within the permitted ten days and/or failure to terminate the lease upon a finding of lead-based paint or lead-based paint hazards or a lead service line or lead plumbing components within the two-day period will constitute a waiver of the right to conduct an independent inspection and the lease will remain in full force and effect.</p>
<p>Upon renewal of an existing lease, any Resident shall have the right to proceed with an inspection or risk assessment as provided above except that such renewing Resident shall not be required to terminate the lease within two (2) days of performance of a comprehensive lead inspection or a risk assessment, but shall be afforded a ten (10) day period to notify Owner in writing of Resident’s intention to terminate the lease, with actual termination and vacation of the premises to occur at a time not to exceed ninety (90) days after receipt of the comprehensive lead inspection or risk assessment, during which period all lease obligations shall remain in full force and effect.</p>
<p><strong>VII. OWNER ACKNOWLEDGMENT</strong></p>
<p>Owner has provided the Resident the required information they have about lead-based paint or lead-based paint hazards as well as the existence of any known lead service line and lead plumbing components in the residential dwelling.</p>
<p><strong>VIII. RESIDENT ACKNOWLEDGMENT</strong></p>
<ul>
	<li>Resident has read and received a copy of this Addendum and all relevant documents.</li>
	<li>Resident has read the above LEAD WARNING STATEMENT.</li>
	<li>Resident understands they have the option to conduct their own lead inspection or risk assessment.</li>
	<li>If the property was built after March 1978, Resident acknowledges that this addendum relating to lead-based paint or dust does not apply.</li>
</ul>
<p><strong>IX. AGENT’S ACKNOWLEDGMENT</strong></p>
<p>Agent, if any, has informed the Owner and Resident of the Owner’s obligations under 42 U.S.C. § 4852d and Philadelphia Ordinance 6-800 et seq. and is aware of their responsibility to ensure compliance with those laws.
<p><strong>X. TRANSFERABILITY</strong></p>
<p>In the event the property is sold during the lease term, the Lead-Safe or Lead-Free Certificates transfer to the new owners of the property.</p>
<p><strong>XI. RESOURCES</strong></p>
<p>The Philadelphia Department of Health has posted a list of “Certified/Licensed Lead Professionals” at www.phila.gov/ health/leadlaw. This list is not an endorsement or recommendation and the Philadelphia Department of Health makes no claims as to the individual’s credentials or abilities.</p>
<p><strong>XII. CERTIFICATION OF ACCURACY</strong></p>
<p>In accordance with 42 U.S.C. § 4852d and § 6-806 of the Philadelphia Health Code, the following parties have reviewed the information above and acknowledge, to the best of their knowledge, that the information contained is true and accurate and they have received all required disclosures, pamphlets and documents as set forth herein.</p>

<p>Resident(s): {$contract_user->name}</p>
<p>Date:
{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}
{/if}
	<br/>SIGNATURE:<br>
</p>

{if $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{else}
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree13" for="agree13">I agree and sign</label><input type="checkbox" id="agree13" name="agree13" class="agree" value="1"></p>
{/if} 

<p>OWNER or AGENT FOR OWNER<br>
SIGNATURE:<br/>
{if $contract_info->signature}
<img src="design/{$settings->theme|escape}/images/c_signature.png" alt="Signature Sergii Starostin" width="180" />
{/if}</p>
<p>Date:{if $contract_info->signing == 1}
	{$contract_info->date_signing|date}
{/if}</p>

<br><br>

<h1 class="center">CITY OF PHILADELPHIA <br> ACKNOWLEDGMENT OF RECEIPT OF REQUIRED DOCUMENTS</h1>

<p>I hereby acknowledge that I have received a copy of the following documents:</p>
<ul>
	<li>City of Philadelphia Certificate of Rental Suitability</li>
	<li>Partners for Good Housing Brochure</li>
	<li>Philadelphia Lead Paint Addendum</li>
	<li>Federally Required Lead Hazard Information and Disclosure Addendum</li>
	<li>Philadelphia Bed Bug Brochure: A Guide to Bed Bug Safety</li>
	<li>Philadelphia Bed Bug Addendum</li>
</ul>

<p>Address of Premises: 3701 Chestnut Street Philadelphia, PA 19104</p>
<p>Resident Name: {$contract_user->name}</p>
<p>Resident Signature:</p>





