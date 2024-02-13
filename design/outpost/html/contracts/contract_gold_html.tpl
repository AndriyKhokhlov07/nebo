{* Contract html *}


<h1>Membership Agreement</h1>

<p>This Membership Agreement (hereinafter referred to as "the Agreement" or &ldquo;this Agreement&rdquo;) is made by and between Outpost Club Inc (hereinafter referred to as "Outpost Club" or &ldquo;the Club&rdquo;) and <strong>{$contract_user->name|escape}</strong> (hereinafter referred to as "the Member") as of the date last set forth on the signature page of this Agreement.</p>

<h2>Why We Have this Agreement</h2>
<p>The reason for this agreement is to solidify the relationship between the Member and Outpost Club in legal terms. This Agreement protects the rights of both parties to this Agreement. Please read this agreement in its entirety; not knowing a part of this agreement is not a reason to not follow its terms, as all parties to this agreement have signed it with the assumption that all other parties have reviewed its contents thoroughly.</p>



<p>For good and valuable consideration, the sufficiency of which is acknowledged, the parties to this Agreement who have signed at the bottom of this document hereby agree as follows:</p>

<ol>
<li>By applying for the Outpost Club Membership, the Member agrees to become a part of
the Outpost Club community of startups, entrepreneurs, professionals, students,
engineers, designers, creatives, people simply working in New York and more.</li>
<li>By signing this Agreement, the Member agrees to pay the Monthly Membership Fee.</li>
<li>Upon payment by the Member of the agreed Monthly Membership Fee, the Member
gains access to temporary stay at <strong>{$contract_info->rental_address|escape}</strong> in <strong>{$contract_info->rental_name|escape}</strong>
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
{/if}
from <strong>{$contract_info->date_from|date}</strong>, at 1 pm EST until <strong>{$contract_info->date_to|date}</strong>, at 11 am EST, and unrestricted access to all the
Privileges of the Members listed in Appendix 1.</li>
</ol>

<h2>Monthly Membership Fee Payment Schedule</h2>
<p>For good and valuable consideration, the sufficiency of which is acknowledged, the parties to this Agreement who have signed at the bottom of this document hereby agree as follows:</p>
<ol>
<li>The total amount for the whole period is {$contract_info->invoices_total|convert} USD.</li>
<li>The agreed Monthly Membership Fee is {$contract_info->price_month|convert} USD.</li>
<li>Payment for the first Monthly Membership Fee should be paid no later than {(strtotime($contract_info->date|date)+ (2*24*60*60))|date_format:'%b %e, %Y'}.</li>
<li>The payment of the Monthly Membership Fee for each of the following month’s must be paid by the Member according to the following schedule:
<ol>
	{foreach $contract_info->invoices as $i}
		{if $i@iteration>1}
			<li>Payment for {$i->date_from|date:'M j'} - {$i->date_to|date:'M j'}: {$i->price|convert} USD, to be paid on or before {$i->date_for_payment|date:'M j'}</li>
		{/if}
	{/foreach}
</ol>
</li>

</ol>

<h2>Security Deposit, Security Deposit PaymentSchedule, and HelloRented</h2>
<p>For good and valuable consideration, the sufficiency of which is acknowledged, the parties to this Agreement who have signed at the bottom of this document hereby agree as follows:</p>
<ol>
<li>In addition to the Monthly Membership Fee, a Security Deposit (hereinafter referred to as &ldquo;the Deposit&rdquo;) of {$contract_info->price_deposit|convert} USD is collected to cover any damage which may be caused by the Member to Outpost Club’s property, or to cover the loss caused due to untimely vacating of Outpost Club’s property subject to the discontinuation of Membership. This can take effect due to an ill-timed payment or nonpayment of the Monthly Membership Fee. If the Member successfully meets the conditions outlined in this clause, the Deposit will be returned to the Member within 30 days of the Member’s departure from the Outpost Club.</li>
<li>If the Member elects to use HelloRented Inc. (hereinafter referred to as “HelloRented” to pay their Deposit, the amount will be the same as stated in Clause 8 and is collected to cover any damage which may be caused by the Member to Outpost Club’s property, or to cover the loss caused due to untimely vacating of Outpost Club’s property subject to the discontinuation of Membership. This can take effect due to an ill-timed payment or  nonpayment of the Monthly Membership Fee. If Outpost Club has reason to withhold the security deposit, Outpost Club will notify Hellorented of this, and the Member will be responsible for repaying the withheld Deposit amount to HelloRented if the Member successfully meets the conditions outlined in this clause and has used HelloRented to pay their Deposit, the Deposit will be returned to the HelloRented within 30 days of the Member’s departure from the Outpost Club.</li>
</ol>

{* Membership: 1 - Gold, 2 -Silver *}
{if $contract_info->membership==1 || $contract_info->membership==2}
<h2>Annual Membership Payment</h2>
<p>For good and valuable consideration, the sufficiency of which is acknowledged, the parties to this Agreement who have signed at the bottom of this document hereby agree as follows:</p>
<ol>
<li>The Member agrees to pay an Annual Membership Payment of {if $contract_info->membership==1}690 USD for Gold{elseif $contract_info->membership==2}29 USD for Silver{/if} Membership, giving them access to all benefits and agreeing to all the conditions outlined in Appendix 1 for one year, starting from the Arrival Date (Clause 3).</li>
</ol>
{/if}


<h2>Late Payment, Cancellation During-Stay, and Extensions</h2>
<p>For good and valuable consideration, the sufficiency of which is acknowledged, the parties to this Agreement who have signed at the bottom of this document hereby agree as follows:</p>
<ol>
<li>In case the Payment is not received timely, before the date indicated in Clause 7, a Late
Payment Fine of 50 USD per day would be applied. If the member’s payment is late by
more than 3 days, Outpost Club reserves the right to cancel the Membership Agreement
and Outpost Club will not guarantee the availability of the room or other rooms.</li>
<li>In the case Member cancels their stay at the Club earlier than Member committed in
Clause 7 of this Agreement, for $250, the Member may cancel their Membership
agreement with the Club with 30 days’ notice at any time during the length of the
contract. The member will still be obligated to pay for the 30 days after the notice is
given.</li>
<li>After the period indicated in Clause 3 of this Agreement, Member is free to choose to
continue their Membership under the agreed Monthly Membership Fee indicated in
Clause 5. The Member should inform the Club with 30 days notice of their intent to
vacate the Club Property. If the Member has not informed Outpost Club of their intent to
vacate the Club Property, Outpost Club will still assume that the Member intends to
leave, and the member is still obligated to vacate the Club Property on the last day of the
Membership Agreement indicated in Clause 3.</li>
<li>All extensions are always considered as a new reservation, and have to be pre-approved
with Customer Service (<a href="mailto:bookings@outpost-club.com">bookings@outpost-club.com</a>).</li>
<li>If the extended period is less than a month, the Monthly Membership Fee indicated in
Clause 5 would be prorated according to a 30-day month regardless of the current
month’s duration.</li>
<li>Outpost Club reserves the right to deny the Member the ability to extend of if the
Member has violated the conditions of this agreement at any point during their stay.</li>
<li>The Member understands that they have only reserved until their departure date in this
agreement (Clause 3) and that their bed is not reserved for them past this date. The
member understands that they may extend their stay at anytime as-per Clauses 13 and
14, but that Outpost Club is actively seeking to sell all available vacancies, and their bed can be reserved anytime past the Member’s departure date (Clause 3).</li>
</ol>

<h2>Cancellation Policy Before Move-In</h2>
<p>For good and valuable consideration, the sufficiency of which is acknowledged, the parties to this Agreement who have signed at the bottom of this document hereby agree as follows:</p>
<ol>
<li>If you need to cancel your booking please contact us as soon as possible on the
<a href="mailto:bookings@outpost-club.com">bookings@outpost-club.com</a> e-mail.
<ol>
	<li>The reservation is officially canceled at the moment the Member notifies Outpost Club via email <a href="mailto:bookings@outpost-club.com">bookings@outpost-club.com</a>.</li>
</ol>
</li>
<li>If, before the move-in date indicated in Clause 3 the Member elects to cancel the agreement, but has already made payment of the First Monthly Membership Fee (Clause 5) and Security Deposit (Clause 8), the Member is entitled to the following:
<ol>
<li>In the case that cancellation is more than 30 days in advance of the Member’s
move-in date, the Member will receive a 100% full refund from Outpost Club.
This includes both the Member’s First Monthly Membership Fee (Clause 5) and
the Security Deposit (Clause 8).</li>
<li>In the case that cancellation is less than 30 days in advance of the Member’s
move-in date, but more than 14 days in advance of the Members move-in date,
the Member will receive a refund on their First Monthly Membership Fee (Clause
5) from Outpost Club, but the deposit (Clause 8) will be non-refundable. The
Member will be entitled to exchange the security deposit for an equivalent
amount of days on future stays at any properties of Outpost Club.</li>
<li>In the case that cancellation is less than 14 days in advance of the Member’s
move-in date, the Member will receive a refund on their First Monthly
Membership Fee (Clause 5) from Outpost Club, but the deposit (Clause 8) will be
non-refundable.</li>
</ol>
</li>
<li>If, before the move-in date indicated in Clause 3 the Member elects to cancel the
agreement, but has already made payment of the First Monthly Membership Fee
(Clause 5), and has elected to use HelloRented to pay the Security Deposit (Clause 9),
the Member is entitled to the following:</li>
<ol>
<li>In the case that cancellation is more than 30 days in advance of the Member’s
move-in date, the Member will receive a 100% full refund from Outpost Club.
This includes both the Member’s First Monthly Membership Fee (Clause 5) and
the HelloRented Security Deposit (Clause 9). The HelloRented Security Deposit
will be refunded to HelloRented, not the Member. Outpost Club is not responsible
to pay any fees the Member paid to HelloRented for their service.</li>
<li>In the case that cancellation is less than 30 days in advance of the Member’s
move-in date, but more than 14 days in advance of the Members move-in date,
the Member’s Security Deposit (Clause 9) will be refunded to HelloRented within
30 days of the cancelation notice but the Member’s First Monthly Membership
Fee (Clause 5) will be non-refundable. The Member will be entitled to exchange
the First Monthly Membership Fee (Clause 5) for an equivalent amount of days
on future stays at any properties of Outpost Club. Outpost Club is not
responsible to pay any fees the Member paid to HelloRented for their service.</li>
<li>In the case that cancellation is less than 14 days in advance of the Member’s
move-in date, the Member’s Security Deposit (Clause 9) will be refunded to
HelloRented within 30 days of the cancelation notice and the Member’s First
Monthly Membership Fee (Clause 5) will be non-refundable. Outpost Club is not
responsible to pay any fees the Member paid to HelloRented for their service.</li>
</ol>
<li>The Member will receive a full refund of their Annual Membership Payment if Outpost
Club has already received the entirety of the Member’s first Monthly Membership fee
and the Member’s Security Deposit.</li>
<li>If the Member arrives and decides to leave earlier than scheduled, in a case of a noshow or cancel the booking after the arrival date, full payment will be required.
<ol>
<li>Applicable taxes will be retained and remitted.</li>
</ol>
</li>
<li>REFUNDS AND RETURNS ARE NOT AVAILABLE ON FREE PROMOTIONAL ITEMS OR OFFERS. REFUNDS ARE NOT AVAILABLE FOR DISCOUNTED MONTHS OR OFFERS.</li>
</ol>

<h2>Additional Stipulations</h2>
<p>For good and valuable consideration, the sufficiency of which is acknowledged, the parties to this Agreement who have signed at the bottom of this document hereby agree as follows:</p>
<ol>
<li>The Member agrees to abide by the Club Rules attached as Appendix 2 at all times
while at the Outpost Club property. If the Member permits anyone else on the Outpost
Club property, the Member’s Guests agree to abide by the Club Rules, while Member
becomes responsible for their Guests behavior while at the Club property. If the Guest of
a Member violates the terms of this agreement, Outpost Club reserves the right to treat
the violation as a violation by the Member.</li>
<li>Member agrees to and signs the Release and Waiver of Liability attached as Appendix 4</li>
<li>A Member shall allow the Club access to the Club property or rooms at all times for
inspection, cleaning, repair or maintenance. The Club shall exercise this right of access
in a reasonable manner.</li>
<li>The Member agrees to and signs the Consent to photograph and film a Member for
usage on the social media and internet attached as Appendix 5.</li>
<li>The Member and Outpost Club both agree previously signed Membership Agreements
are superseded by this Membership Agreement, and that any subsequent Membership
Agreements signed after this Membership Agreement supersede this agreement.</li>
</ol>


<h2>Appendix 1: Privileges and Terms of a Gold Membership</h2>
<p>For good and valuable consideration, the sufficiency of which is acknowledged, the parties to this Agreement who have signed at the bottom of this document hereby agree as follows:</p>

<p>The Member must make the Gold-Membership Payment of $690 USD in advance of their
Arrival Date. This payment will be made to Outpost Club through an Invoice.</p>

<p>Outpost Club Members who have signed a Gold Membership Agreement and paid the Gold
Annual Membership Payment are granted access to the following:</p>
<ol>
<li>Outpost Club will pay for utilities and WiFi for Outpost Club houses.</li>
<li>The Member will have access to all silver- and gold-level events at no additional cost to the Member.</li>
<li>The Member will be provided a bed in a fully-furnished apartment.</li>
<li>Outpost Club will provide security in the form of Nest camera systems in the common
areas of Club houses.</li>
<li>Outpost Club will provide maintenance and cleaning services at all Club properties.</li>
<li>Outpost Club will provide household essentials of the Club’s choice at no additional cost to the Member.</li>
</ol>

<p>In addition to the above, Outpost Club Members who have signed a Gold Membership
Agreement and paid the Gold Annual Membership Payment agree to the following:</p>
<ol>
<li>The Member has access to all Club houses that have common spaces for use by the
entire house. Members may only access the common areas of other houses that they do
not have at their own house: Theaters, Workout Spaces, Coworking space, etc. They
may not use kitchens, private living rooms, bedrooms, private bathrooms, or other areas
that they may have at their own home.</li>
<li>The Member can move between Club houses with 30 days’ notice, provided there is an
available bed.</li>
<li>The Member may have an overnight guest on Club property during quiet hours (10 p.m.
- 9 a.m.) for up to four nights per calendar month. After the member uses there four free
nights for guests, the Member may only be have overnight guests by paying a $30 per
night fee. The Member is limited to one overnight guest at a time for no longer than two
consecutive days. Outpost Club can only provide the option of accommodating a paid
guest if Outpost Club has a room or bed for the guest.</li>
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
obligated to pay for the 30 days after the notice is given.</li>
<li>The Member may pause their Membership with the Club for 30-90 days during the
length of the contract by giving 30 days’ notice. The length of the Membership pause will
be added to the end of the original contract length, which the Member agrees to fulfill.
The Member may only pause their membership once during the duration of this
Membership Agreement.</li>
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

<br /><br />

<h2>Appendix 2 - Club Rules, Applicable on Security Deposit terms.</h2>
<p>For good and valuable consideration, the sufficiency of which is acknowledged, the parties to this Agreement who have signed at the bottom of this document hereby agree as follows:</p>
<h4>Move-in</h4>
<ol>
<li>During the Move-in to the Outpost Club property, a photo ID will be required. Only the persons identified during the move-in will be authorized to stay in the Outpost Club Property.</li>
</ol>
<h4>During the Stay</h4>
<ol>
<li>The Monthly Membership Fee paid to Outpost Club is a per-person rate unless stated otherwise in this agreement - stay overnight is only for the person who has reserved. No overnight Guest stays are allowed, unless otherwise permitted by Outpost Club Management.</li>
<li>The Member is responsible for the appropriate behavior of anyone allowed to enter the
Outpost Club Property as a Guest. Should this person or persons being with them not
behave responsibly and appropriately, they will be asked to leave immediately. Should
the Member fail to comply with the obligations mentioned above, Outpost Club may, at
their own discretion, ask the Member and/or Guest to abandon the Club Properties,
without the Member being entitled to any compensation. If a guest violates the rules
outlined in this agreement, it will be treated as if the Member has violated the agreement.</li>
<li>The Member will not sublet the space to others during the duration of their reservation without the written consent of Outpost Club Management.</li>
<li>The Member will not sell any products or services to other Members or Guests on the Outpost Club premises without the written consent of Outpost Club Management.</li>
</ol>

<h5>Cleanliness and Organization During the Stay</h5>
<ol>
<li>The Member will take their shoes off and keep their shoes on the shoe rack once the Member is inside the Outpost Club Property.</li>
<li>The Member will wash all kitchen appliances the Member uses every time after using
them, and the Member will clean the sink of all food remains. The Member will leave no
dishes or kitchen equipment in the sink, repeated violations of this rule can lead to the
cancelation of your Membership. Outpost Club reserves the right to check the cameras
to identify who is violating this rule. Outpost Club only checks cameras once our
Members or House Leaders notify us of a violation.</li>
<li>On the agreed schedule, the Member will have the responsibility of taking out the trash, wiping down the countertops, and emptying/running the dishwasher.</li>
<li>The Member will separate all waste by placing all garbage in its designated container for:
<ol type="a">
<li>Plastic Product</li>
<li>Glass and Metal Products</li>
<li>Paper Products</li>
</ol>
</li>
<li>Fridge and Food shelves are divided among the Members - the Member will use their designated area and mark their food, otherwise, if the Member leaves the food outside their area or did not mark it, it can be removed during cleaning.</li>
<li>The Member will not leave their belongings in the common areas - the Member&rsquo;s belonging can be removed to the Lost and Found boxes if so.</li>
<li>The Member will clean the bathroom after the Member uses the bathroom. This includes
cleaning the shower, sink, toilet, mirrors, or anything else in the bathroom after use. The
Member will make sure to leave the bathroom in the condition it was found after Outpost
Club’s Cleaners have cleaned it.</li>
<li>The Member will remove hair from the drains to avoid clogging. This includes the sink and shower drains.</li>
<li>If for some reason the Member clogs the toilet, the Member will unclog it. There are multiple plungers provided in every house.</li>
<li>If the Member is staying in a shared bedrooms - the Member will keep their room to the highest level of cleanliness. This includes keeping personal belongings organized, clean, laundered, sanitary.</li>
<li>The Member will let the cleaners enter bedroom for a weekly cleaning of the floor. For
the cleaning days, you must organize your personal belongings in a way that allows the
cleaners to mop and sweep the floor.</li>
</ol>

<h5>Safety During the Stay</h5>
<ol>
<li>The Member will turn off all electronic devices in the common areas when not in use.</li>
<li>The Member will check and turn off oven and gas when not in use.</li>
<li>Alcohol - being a health-oriented Club, Outpost Club recommends minimizing alcohol consumption.</li>
<li>Smoking/illicit drugs are not allowed anywhere inside the Outpost Club premises. Smoking of legal product is permitted in legally accessible rooftops, backyards, courtyards, front porches, front steps, or any other outdoor common areas on the Outpost Club premises.</li>
<li>Dogs and Pets are not allowed in the Outpost Club premises.</li>
<li>Tampering with cameras and smoke detectors, locks, or keypads is forbidden on Outpost Club Properties.</li>
<li>Security cameras are installed in common areas of the Outpost Club Properties and at
the Entrance to the Outpost Club Properties. All the records of cameras owned by
Outpost Club are automatically erased after 1 week and used for security purposes only.
The access to the records is granted via approval of the top management of the
company. No cameras will be monitored, only checked in instances of potential
agreement violations and to ensure the safety of Members.</li>
<li>The Member will not insert any metal object in the microwave.</li>
<li>The USA electrical system is 110 V. The Member will not plug in electronics that can not handle this voltage. Please check your electronics for any risk.</li>
<li>The Member will not affix anything to windows, walls, or any other part of the Outpost Club premises without the consent of Outpost Club Management.</li>
<li>The Member is forbidden from entering any bedrooms that are not their own, unless the
member is given verbal consent by the Member or Members inhabiting other bedrooms.
The Member is not allowed to enter vacant rooms, unless given consent by Outpost Club.</li>
<li>The Member will be given access to the house be key or code. The Member may not
share their key or code with anyone other than Outpost Club Management. This includes
friends, guests, and other Members.</li>
</ol>
<h5>Comfort During Stay</h5>
<ol>
<li>Weekday quiet hours are from 10 PM to 9 AM on Sunday nights through Thursday mornings. Weekend quiet hours are from 11:30 AM to 10 AM Friday night through Sunday mornings. During these times, the Member will not play no loud music, watch TV loudly, talk loudly, sing loudly or engage in any other actions producing loud noises, unless otherwise permitted by Outpost Club.</li>
<li>If, for any reason, Members of Outpost Club are affected by the smoking habits taking place on the Outpost Club premises, Outpost Club reserves the right to require the Member smoking to move to an area that will not affect its other Members. This may require the Member to smoke off Outpost Club premises.</li>
<li>All cigarette butts must be disposed of properly, and may not be tossed on the ground on Outpost Club premises. It is not Outpost Club&rsquo;s responsibility to provide proper disposal of cigarettes, however it is the Member&rsquo;s responsibility to dispose of it properly.</li>
<li>Any unauthorized parties are forbidden in the Club Properties. Outpost Club reserves the right to ask the Member or the Guests to abandon the Club Property in case of violation. The Noise Tracking devices are installed in the cameras of the Outpost Club Properties.</li>
<li>Any gatherings outside the Outpost Club Properties in the corridors or common areas of the building or outside the building are not allowed unless otherwise permitted by Outpost Club.</li>
<li>IT and copyright laws prohibit Torrents use through house WiFi for copywriter video/music - the whole House WiFi can be blocked by an Internet Service Provider for 24 hours. The Member agrees to abide by all copyright laws when using Outpost Club&rsquo;s WiFi.</li>
<li>The Member may only use the bed they were assigned, and will not use any other beds in the room or house. Violation of this can result in a fine of $60 USD for each bed that was used in violation, to be paid by invoice.</li>
</ol>
<h5>Other Stipulations During Stay</h5>
<ol>
<li>Photos and/or videos of the Members may be recorded during the Events and used on the official Outpost Club social networks and Website. They will be removed upon request.</li>
<li>Zero tolerance harassment policy - being part of the large community, there is absolutely no tolerance towards physical, sexual or psychological harassment. This Agreement would be immediately discontinued if any cases are reported. The Member will not
engage in unwanted touching, unwanted sexual advances, sexual or harassing jokes,
comments, or gestures towards your roommate(s) on the Outpost Club Property. All
reports will be investigated and Outpost Club will make the final decision regarding all
reported cases. Outpost Club reserves the right to cancel Membership agreements of all
Members involved in the violation of this Club Rule.</li>
<li>Outpost Club is a space for everyone to feel welcome and at home. The Member will not
not engage in Racism, sexism, ableism, ageism, homophobia, transphobia, xenophobia
or religious intolerance will not be tolerated on Outpost Club premises. All reported
cases will be investigated and Outpost Club reserves the right to cancel Membership
agreements of all Members involved in the violation of this Club Rule.</li>
</ol>
<h4>Move-Out</h4>
<ol>
<li>The Club Property must be left clean and in good state. Any damage would be subject to withdrawal of the Deposit.</li>
<li>Check-out time is 11 AM as-per Clause 3 of this contract. Outpost Club cleaners will need access to enter your room to clean and prepare your bed after this time.</li>
<li>The Member must also follow these steps to receive their Security Deposit back in-full:
<ol type="a">
<li>The Member will let us know about their exact move-out time by emailing Outpost Club at <a href="mailto:bookings@outpost-club.com">bookings@outpost-club.com</a></li>
<li>The Member will remove all their belongings out of their room on the move out date before 11 AM. The Member can always store their belongings in the common area for the day, but can not leave them in their bedroom.</li>
<li>The Member will THROW OUT THEIR GARBAGE FROM THEIR ROOM.</li>
<li>The Member will strip their bed and leave the bed linens and towels on the bed.</li>
<li>The Member will take everything out of their kitchen cabinet(s) and fridge that belongs to them.</li>
<li>The Member will take everything that is their out of the bathrooms.</li>
</ol>
</li>
</ol>
<h4>Responsibility</h4>
<ol>
<li>Outpost Club will not be held responsible for any physical or financial damage, direct or indirect, that may be caused to the Members as a result of misuse by the Members.</li>
<li>Outpost Club is not responsible for any physical or financial damage, direct or indirect, relating to the Member&rsquo;s incoming mail and packages.</li>
</ol>
<p>The Member expressly agrees that the Club Rules are intended to be as broad and inclusive as permitted by the laws of the State of New York and the United States of America, and that the Club Rules shall be governed by and interpreted in accordance with the laws of the State of New York. The Member agrees that in the event that any clause or provision of these Club Rules shall be held to be invalid by any court of competent jurisdiction, the invalidity of such clause or provision shall not otherwise affect the remaining provisions of these Club Rules, which shall continue to be enforceable.</p>

<h2>Appendix 3 - Enforcement of Rules and Consequences of Violations</h2>
<p>For good and valuable consideration, the sufficiency of which is acknowledged, the parties to this Agreement who have signed at the bottom of this document hereby agree as follows:</p>

<p>Outpost Club does not monitor its Members and would never want Members to feel monitored. Outpost Club&rsquo;s goal is to make Members feel at home from the moment arrive to the moment they leave. In order to preserve this feeling of home, Outpost Club has the rules outlined in this Membership agreement to communicate our vision of what home should be: respectful, clean, comfortable space to connect with others.</p>

<p>In order to achieve this Members must not only follow the rules, but report to Outpost Club management when and if rules are being broken. Outpost Club can not enforce violations of rules by its Members that it is not aware of, therefore it is your responsibility as a Member to notify us when something is bothering you.</p>

<p>Please report all violations of the rules to <a href="mailto:customer.service@outpost-club.com" target="_blank">customer.service@outpost-club.com</a>, or contact your House Leader or Community Manager directly. When reporting please include the time, place, and description of the violation. If the person reporting knows who is involved, we&rsquo;d appreciate if the person reporting provides that information as well but understand if they do not want to. Please understand that we made not be able to resolve the issue if we do not know who commits the violation.</p>

<p>If Outpost Club has reason to believe that a Member has broken the rules, Outpost Club
reserves the right to issue warnings, and in circumstances where the violation is heinous and/or is a threat to the community, Outpost Club reserves the right to discontinue Membership after warnings or immediately.</p>
<p>If the Member has this agreement up as a couple, the Member signing this agreement is
responsible for the actions of the other Member in the couple’s relationship. All violations of this agreement by either Member of the couple are violations by the entire couple</p>

<h2>Appendix 4 - RELEASE and WAIVER OF LIABILITY</h2>
<p>For good and valuable consideration, the sufficiency of which is acknowledged, the parties to this Agreement who have signed at the bottom of this document hereby agree as follows:</p>

<p>This Release and Waiver of Liability (hereinafter referred to as "Release") is in favor of Outpost Club Inc. and each of its directors, officers, employees, and agents (collectively, the "Released Parties"). The undersigned was using the residential rental services in New York City with Outpost Club Inc.</p>
<p>The undersigned hereby freely and voluntarily, without duress, executes this Release under the following terms:</p>
<ol>
<li>Waiver and Release. I, the undersigned, hereby release and forever discharge and hold
harmless the Released Parties and their successors and assigns from any and all
liability, claims, and demands of whatever kind or nature, either in law or in equity, which arise or may hereafter arise from any and all actions I engage in for Outpost Club Inc. during my stay in New York City. I understand and acknowledge that this Release
discharges the Released Parties from any liability or claim that I and any minor for whom
I have responsibility may have against the Released Parties with respect to bodily injury,
personal injury, illness, death, or property damage that may arise out of, or result from,
my or their participation in Coliving community in New York City.</li>
<li>Insurance. I, the undersigned, hereby acknowledge that the Released Parties do not
assume any responsibility for, or obligation to provide, financial assistance or other
assistance, including but not limited to medical, health, or disability insurance, in the
event of injury, illness, death, or property damage. I, the undersigned, hereby expressly
waive any such claim for compensation or liability on the part of the Released Parties in
the event of such injury, illness, death, or property damage to myself or any minor for
whom the undersigned has responsibility.</li>
<li>Medical Treatment. I, the undersigned, hereby release and forever discharge the
Released Parties from any claim whatsoever which arises or may hereafter arise on
account of any first-aid treatment or other medical services rendered by any of such
Parties or their representatives, agents or assigns as the result of an injury or illness to
the undersigned or any minor for whom the undersigned has responsibility arising out of,
or resulting from, the undersigned s or such minor s participation in Coliving Community
with Outpost Club Inc.</li>
<li>Other. I, the undersigned, expressly agree that this Release is intended to be as broad
and inclusive as permitted by the laws of the State of New York and the United States of
America, and that this Release shall be governed by and interpreted in accordance with
the laws of the State of New York. The undersigned agrees that in the event that any
clause or provision of this Release shall be held to be invalid by any court of competent
jurisdiction, the invalidity of such clause or provision shall not otherwise affect the
remaining provisions of this Release, which shall continue to be enforceable.</li>
</ol>

<h2>Appendix 5 - Consent to Photograph and Film a
Member for Usage Online and in Marketing
Materials</h2>
<p>For good and valuable consideration, the sufficiency of which is acknowledged, the parties to this Agreement who have signed at the bottom of this document hereby agree as follows:</p>

<p>I (the Member) hereby consent to the participation in interviews, the use of quotes, and the taking of photographs, movies or videotapes of the Member named above by Outpost Club.</p>

<p>I also grant to Outpost Club the right to edit, use, and reuse said products for commercial and non-commercial purposes including use on social media, on the Internet, and in all other forms of media. I also hereby release Outpost Club Inc and its agents and employees from all claims, demands, and liabilities whatsoever in connection with the above. I understand that I am not entitled to compensation of any kind if Outpost Club uses my likeness for commercial or noncommercial purposes.</p>
<p>I also understand that I If I am at an Outpost Club Event where pictures are being taken, I can
ask Outpost Club’s photographer to not take pictures of me. If they do happen to take a picture
of me, I can ask Outpost Club Staff to delete it on-site. If photos of me are posted online by an
Outpost Club representative, I can ask Outpost Club Staff to delete them.</p>

<p>I understand that if a Member of Outpost Club takes a picture of me, that is between me and the Member, regardless of where the media is published. Outpost Club cannot intervene on my behalf; Outpost Club will only intervene if a member of Outpost Club Staff takes a picture and publishes it.</p>

<p>I understand that if a picture of me is posted in a House’s private Facebook Messenger chat (to which only current Outpost Club members belong), it is not possible to remove. I understand that it is my responsibility to request that photos not be posted in the Facebook Messenger group before they are posted, and I understand that requesting so does not guarantee they will not be posted.</p>

<p><br/><br/><br/></p>
<p>For good and valuable consideration, the sufficiency of which is acknowledged, the parties to this Agreement who have signed below hereby agree as follows:</p>




<h5>Outpost Club:</h5>
<p>
Name (print): Sergii Starostin<br/>
Date: {$contract_info->date_created|date:'m/d/Y'}<br/>
Toll free phone # (during stay): +1 (833) 707-6611 - press 2
</p>
<img src="design/{$settings->theme|escape}/images/c_signature.png" alt="Signature Sergii Starostin" width="240" />
<p><br/></p>

<h5>Member:</h5>
<p>
Name (print): {$contract_user->name|escape}<br/>
{if $contract_info->signing}
	Date: {$contract_info->date_signing|date:'m/d/Y'}<br/>
{/if}	
{if $contract_user->phone}
	Phone # (during stay): {$contract_user->phone|escape}
{/if}
</p>


{if $contract_info->signature}
	<img src="{$config->contracts_dir}{$contract_info->url}/signature.png" alt="Signature {$contract_user->name|escape}" width="240" />
{/if}




