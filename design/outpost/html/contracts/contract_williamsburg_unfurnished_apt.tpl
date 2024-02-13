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
	margin-top: 35px;
	font-size: 17px !important;
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
h4{
	margin-top: 15px;
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
<h3>Flatiron Real Estate Advisors, LLC</h3>
<p>119 West 23rd Street, #903 • New York, NY 10011</p>
<a href="tel:+12126753699">(212) 675-3699</a>

<ol>
	<li>
		<h1>STANDARD FORM OF APARTMENT LEASE (FOR APARTMENTS NOT SUBJECT TO THE RENT STABILIZATION LAW)</h1>
		<ol>
			<li>
				<h4>PREAMBLE:</h4>
				<p>This lease contains the agreements between You and Owner concerning Your rights and obligations and the rights and obligations of Owner. You and Owner have other rights and obligations which are set forth in government laws and regulations.</p>
				<p>You should read this Lease and all of its attached parts carefully. If you have any questions, or if you do not understand any words or statements, get clarification. Once you and Owner sign this Lease You and Owner will be presumed to have read it and understood it. You and Owner admit that all agreements between You and Owner have been written into this Lease. You understand that any agreements made before or after this Lease was signed and not written into it will not be enforceable.</p>
				<p>THIS LEASE is made on <strong>{if $contract_info->signing}{$contract_info->date_signing|date_format:'%b %e, %Y'}{else}{$smarty.now|date_format:'%b %e, %Y'}{/if}</strong>, between Owner, 186N6 Owner LLC, and You, the Tenant(s), <strong> {foreach $contract_users as $user}{if $contract_user->id != $user->id}{$user->name|escape}, {/if}{/foreach}{$contract_user->name|escape} </strong> whose address is {$contract_info->rental_address}.</p>
			</li>
			<li>
				<h4>APARTMENT AND USE</h4>
				<p>Owner agrees to lease to You Apartment <strong>{$apartment->name}</strong>, at {$contract_info->rental_address}, and State of New York.</p>
				<p>You shall use the Apartment for living purposes only. The Apartment may be occupied by the tenant or tenants named above and by the immediate family of the tenant or tenants and by occupants as defined in and only in accordance with Real Property Law §235-f.</p>
			</li>
		</ol>
		<p>By initialing below, you acknowledge and agree to the terms in Section 1.</p>

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
	</li>
	<li>
		<h1>Lease term</h1>
		<ol>
			<li>
				<h4>LENGTH OF LEASE</h4>
				<p>The term (that means the length) of this Lease is beginning on <strong>{$contract_info->date_from|date}</strong> and ending on <strong>{$contract_info->date_to|date}</strong>. If You do not do everything You agree to do in this Lease, Owner may have the right to end it before the above date. If Owner does not do everything that owner agrees to do in this Lease, You may have the right to end the Lease before ending date.</p>
			</li>
		</ol>
		<p>By initialing below, you acknowledge and agree to the terms in Section 2.</p>

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
		{elseif $contract_info->signature2}
			<p>TENANT NAME: {$contract_user->name|escape}<br/>
			{if $contract_info->signing == 1}
				DATE: {$contract_info->date_signing|date}<br/>
			{/if}
				SIGNATURE:<br>
			</p>
			<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
		{else}
			<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree2" for="agree2">I agree and sign</label><input type="checkbox" id="agree2" name="agree2" class="agree" value="1"></p>
		{/if} 
	</li>
	<li>
		<h1>Responsibilities</h1>
		<ol>
			<li>
				<h4>RENT</h4>
				<p>Your monthly rent for the Apartment is <strong>{if $booking->client_type_id==2}{$booking->airbnb_reservation_id}{else}{$contract_info->price_without_utilities|convert} (US Dollars){/if}</strong>. You must pay Owner the rent, online via tenant portal in advance, on the first day of each month. Instructions will be emailed to you on how to use the tenant portal. {if $house->id != 337}The Tenant agrees to a ${$contract_info->utility_month_price|number_format:2} monthly utility charge as per clause 4.8 B of the lease.{/if}</p>
			</li>
			<li>
				<h4>SECURITY DEPOSIT</h4>
				<p>You are required to give Owner the sum of <strong>{$contract_info->price_deposit|convert} (US Dollars)</strong> which is called in law a trust. The Owner will deposit this security in a security bank account. If the Building contains six or more apartments, the bank account will earn interest. If You carry out all of your agreements in this Lease, at the end of each calendar year Owner or the bank will pay to Owner approximately 1% interest on the deposit for administrative costs and to You all other interest earned on the security deposit.</p>
				<p>If You carry out all of your agreements in this Lease and if You move out of the Apartment and return it to Owner in the same condition it was in when You first occupied it, except for ordinary wear and tear or damage caused by fire or other casualty, Owner will return to You the full amount of your security deposit and interest to which You are entitled within 14 days after this Lease ends. However, if You do not carry out all your agreements in this Lease, Owner may keep all or part of your security deposit and any interest which has not yet been paid to You necessary to pay Owner for any losses incurred, including missed payments.</p>
				<p>If Owner sells or leases the building, Owner will turn over your security, with interest, either to You or to the person buying or leasing (lessee) the building within 5 days after the sale or lease. Owner will then notify You, by registered or certified mail, of the name and address of the person or company to whom the deposit has been turned over. In such case, Owner will have no further responsibility to You for the security deposit. The new owner or lessee will become responsible to You for the security deposit.</p>
			</li>
		</ol>
		<p>By initialing below, you acknowledge and agree to the terms in Section 3.</p>

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
		{elseif $contract_info->signature2}
			<p>TENANT NAME: {$contract_user->name|escape}<br/>
			{if $contract_info->signing == 1}
				DATE: {$contract_info->date_signing|date}<br/>
			{/if}
				SIGNATURE:<br>
			</p>
			<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
		{else}
			<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree3" for="agree3">I agree and sign</label><input type="checkbox" id="agree3" name="agree3" class="agree" value="1"></p>
		{/if} 
	</li>

	<li>
		<h1>Policies</h1>
		<ol>
			<li>
				<h4>IF YOU ARE UNABLE TO MOVE IN</h4>
				<p>A situation could arise which might prevent Owner from letting You move into the Apartment on the beginning date set in this Lease. If this happens for reasons beyond Owner’s reasonable control, Owner will not be responsible for Your damages or expenses, and this Lease will remain in effect. However, in such case, this Lease will start on the date when You can move in, and the ending date in Article 2 will be changed to a date reflecting the full term of years set forth in Article 2. You will not have to pay rent until the move-in date Owner gives You by written notice, or the date You move in, whichever is earlier. If Owner does not give You notice that the move-in date is within 30 days after the beginning date of the term of this Lease as stated in Article 2. You may tell Owner in writing, that Owner has 15 additional days to let You move in, or else the Lease will end. If Owner does not allow You to move in within those additional 15 days, then the Lease is ended. Any money paid by You on account of this Lease will then be refunded promptly by Owner.</p>
			</li>
			<li>
				<h4>CAPTIONS</h4>
				<p>In any dispute arising under this Lease, in the event of a conflict between the text and a caption, the text controls.</p>
			</li>
			<li>
				<h4>WARRANTY OF HABITABILITY</h4>
				<ul type="a">
					<li>All of the sections of this Lease are subject to the provisions of the Warranty of Habitability Law in the form it may have from time to time during this Lease. Nothing in this Lease can be interpreted to mean that You have given up any of your rights under that law. Under that law, Owner agrees that the Apartment and the Building are fit for human habitation and that there will be no conditions which will be detrimental to life, health or safety.</li>
					<li>You will do nothing to interfere or make more difficult Owner’s efforts to provide You and all other occupants of the Building with the required facilities and services. Any condition caused by your misconduct or the misconduct of anyone under your direction or control shall not be a breach by Owner.</li>
				</ul>
			</li>
			<li>
				<h4>CARE OF YOUR APARTMENT-END OF LEASE-MOVING OUT</h4>
				<ul type="a">
					<li>You will take good care of the apartment and will not permit or do any damage to it, except for damage which occurs through ordinary wear and tear. You will move out on or before the ending date of this lease and leave the Apartment in good order and in the same condition as it was when You first occupied it, except for ordinary wear and tear and damage caused by fire or other casualty.</li>
					<li>When this Lease ends, You must remove all of your movable property. You must also remove at your own expense, any wall covering, bookcases, cabinets, mirrors, painted murals or any other installation or attachment You may have installed in the Apartment, even if it was done with Owner’s consent. You must restore and repair to its original condition those portions of the Apartment affected by those installations and removals. You have not moved out until all persons, furniture and other property of yours is also out of the Apartment. If your property remains in the Apartment after the Lease ends, Owner may either treat You as still in occupancy and charge You for use, or may consider that You have given up the Apartment and any property remaining in the Apartment. In this event, Owner may either discard the property or store it at your expense. You agree to pay Owner for all costs and expenses incurred in removing such property. The provisions of this article will continue to be in effect after the end of this Lease.</li>
				</ul>
			</li>
			<li>
				<h4>CHANGES AND ALTERATIONS TO APARTMENT</h4>
				<p>You cannot build in, add to, change or alter, the Apartment in any way, including wallpapering, painting, repainting, or other decorating, without getting Owner’s written consent before You do anything. Without Owner’s prior written consent, You cannot install or use in the Apartment any of the following: dishwasher machines, clothes washing or drying machines, electric stoves, garbage disposal units, heating, ventilating or air conditioning units or any other electrical equipment which, in Owner’s reasonable opinion, will overload the existing wiring installation in the Building or interfere with the use of such electrical wiring facilities by other tenants of the Building. Also, You cannot place in the Apartment water-filled furniture.</p>
			</li>
			<li>
				<h4>YOUR DUTY TO OBEY AND COMPLY WITH LAWS, REGULATIONS AND LEASE RULES</h4>
				<ul type="a">
					<li><strong>Government Laws and Orders.</strong> You will obey and comply (1) with all present and future city, state and federal laws and regulations, which affect the Building or the Apartment, and (2) with all orders and regulations of Insurance Rating Organizations which affect the Apartment and the Building. You will not allow any windows in the Apartment to be cleaned from the outside, unless the equipment and safety devices required by law are used.</li>
					<li><strong>Owner’s Rules Affecting You.</strong> You will obey all Owner’s rules listed in this Lease and all future reasonable rules of Owner or Owner’s agent. Notice of all additional rules shall be delivered to You in writing or posted in the lobby or other public place in the building, Owner shall not be responsible to You for not enforcing any rules, regulations or provisions of another tenant’s lease except to the extent required by law.</li>
					<li><strong>Your Responsibility.</strong> You are responsible for the behavior of yourself, of your immediate family, your servants and people who are visiting You. You will reimburse Owner as additional rent upon demand for the cost of all losses, damages, fines and reasonable legal expenses incurred by Owner because You, members of your immediate family, servants or people visiting You have not obeyed government laws and orders or the agreements or rules of this Lease.</li>
				</ul>
			</li>
			<li>
				<h4>OBJECTIONABLE CONDUCT</h4>
				<p>As a tenant in the Building, You will not engage in objectionable conduct. Objectionable conduct means behavior which makes or will make the Apartment or the Building less fit to live in for You or other occupants. It also means anything which interferes with the right of others to properly and peacefully enjoy their Apartments, or causes conditions that are dangerous, hazardous, unsanitary and detrimental to other tenants in the Building. Objectionable conduct by You gives Owner the right to end this Lease.</p>
			</li>

			$contract_info->type!= 3
			<li>
				<h4>SERVICES AND FACILITIES</h4>
				<ul type="a">
					<li><strong>Required Services.</strong> Owner will provide cold and hot water and heat as required by law, repairs to the Apartment as required by law, elevator service if the Building has elevator equipment, and the utilities, if any, included in the rent, as set forth in sub-paragraph B. You are not entitled to any rent reduction because of a stoppage or reduction of any of the above services unless it is provided by law.</li>
					{if $house->id != 337}
					<li><strong>Utilities:</strong> Lessor will provide electric, gas (if applicable), water and WiFi for the Apartment Unit as part of the monthly Rent, which shall be reimbursed at the rate of <strong>${$contract_info->utility_month_price|number_format:2} per month</strong>. Tenant does not need to arrange for utility service directly with the appropriate utility company or pay a separate charge for these utilities. Lessor does not provide any land-based telephone service, equipment or system.</li>
					{/if}
					<li><strong>Appliances.</strong> Appliances supplied by Owner in the Apartment are for your use. They will be maintained and repaired or replaced by Owner, but it repairs or replacement are made necessary because of your negligence or misuse, You will pay Owner for the cost of such repair or replacement as additional rent.</li>
					<li><strong>Elevator Service.</strong> If applicable- If the elevator is the kind that requires an employee of Owner to operate it, Owner may end this service without reducing the rent if: (1) Owner gives You 10 days notice that this service will end; and (2) within a reasonable time after the end of this year 10-day notice, Owner begins to substitute an automatic control type of elevator and proceeds diligently with its installation.</li>
					<li><strong>Storeroom Use. If applicable</strong> - If Owner permits You to use any storeroom, laundry or any other facility located in the building but outside of the Apartment, the use of this storeroom or facility will be furnished to You free of charge and at your own risk, except for loss suffered by You due to Owners negligence. You will operate at your expense any coin operated appliances located in such storeroom or laundries.</li>
				</ul>
			</li>
			<li>
				<h4>INABILITY TO PROVIDE SERVICES</h4>
				<p>Because of a strike, labor, trouble, national emergency, repairs, or any other cause beyond Owner’s reasonable control, Owner may not be able to provide or may be delayed in providing any services or in making any repairs to the Building. In any of these events, any rights You may have against Owner are only those rights which are allowed by laws in effect when the reduction in service occurs.</p>
			</li>
			<li>
				<h4>ENTRY TO APARTMENT</h4>
				<p>During reasonable hours and with reasonable notice, except in emergencies, Owner may enter the Apartment for the following reasons:</p>
				<ul type="a">
					<li>To erect, use and maintain pipes and conduits in and through the walls and ceilings of the Apartment; to inspect the Apartment and to make any necessary repairs or changes Owner decides are necessary. Your rent will not be reduced because of any of this work, unless required by Law.</li>
					<li>To show the Apartment to persons who may wish to become owners or lessees of the entire Building or may be interested in lending money to Owner;</li>
					<li>For 60 days before the end of the Lease, to show the Apartment to persons who wish to rent it;</li>
					<li>If during the last month of the Lease You have moved out and removed all or almost all of your property from the Apartment, Owner may enter to make changes, repairs, or redecorations. Your rent will not be reduced for that month and this Lease will not be ended by Owner’s entry.</li>
					<li>If at any time You are not personally present to permit Owner or Owner’s representative to enter the Apartment and entry is necessary or allowed by law or under this lease, Owner or Owner’s representatives may nevertheless enter the Apartment. Owner may enter by force in an emergency. Owner will not be responsible to You, unless during this entry, Owner or Owner’s representative is negligent or misuses your property.</li>
				</ul>
			</li>
			<li>
				<h4>ASSIGNING; SUBLETTING; ABANDONMENT</h4>
				<ul>
					<li>Assigning and Subletting. You cannot assign this Lease or sublet the Apartment without Owner’s advance written consent in each instance to a request made by You in the manner required by Real Property Law §226-b. Owner may refuse to consent to a lease assignment for any reason or no reason, but if Owner unreasonably refuses to consent to request for a Lease assignment properly made, at your request in writing, Owner will end this Lease effective as of thirty days after your request. The first and every other time you wish to sublet the Apartment, You must get the written consent of Owner unless Owner unreasonably withholds consent following your request to sublet in the manner provided by Real Property Law §226- b. Owner may impose a reasonable credit check fee on You in connection with an application to assign or sublet. If You fail to pay your rent Owner may collect rent from subtenant or occupant without releasing You from the Lease. Owner will credit the amount collected against the rent due from You. However, Owner’s acceptance of such rent does not change the status of the subtenant or occupant to that of direct tenant of Owner and does not release You from this Lease.</li>
					<li>Abandonment. If You move out of the Apartment (abandonment) before the end of this Lease without the consent of Owner, this Lease will not be ended (except as provided by law following Owner’s unreasonable refusal to consent to an assignment or subletting requested by You.) You will remain responsible for each monthly payment of rent as it becomes due until the end of this Lease. In case of abandonment, your responsibility for rent will end only if Owner chooses to end this Lease for default as provided in Article 16.</li>
					<li>Tenant shall not sublet the Premises and or use the Premises as a hotel establishment renting the Premises in violation Article 1, section 4(8)(a) of the New York State Multiple Dwelling Law, which provides, in relevant part, that a Class A multiple dwelling must be occupied for permanent residential purposes by the same natural person or family for a period of 30 consecutive days or more;</li>
				</ul>
				<p><strong>Tenant shall not</strong> profiteer from illegal sublet or use of the Premises as a hotel establishment renting the Premises for periods of less than 30 consecutive days, in violation of Article 1, section 4(8)(a) of the New York State Multiple Dwelling Law, or any form of rent gouging in violation of Sections 180.54, 180.55, 180.56, and 180.57 of the New York State Penal Law.</p>
				<p>If it is found that you are illegally listing and renting the unit, you will be fined $1000 per day and if the city fines the landlord, you will be responsible for the city fine times 3.</p>
			</li>
			<li>
				<h4>DEFAULT</h4>
				<ol>
					<li>
						<p>You default under the Lease if You act in any of the following ways:</p>
						<ul type="a">
							<li>You fail to carry out any agreement or provision of this Lease;</li>
							<li>You or another occupant of the Apartment behaves in an objectionable manner;</li>
							<li>You do not take possession or move into the Apartment 15 days after the beginning of this Lease;</li>
							<li>You and other legal occupants of the Apartment move out permanently before this Lease ends;</li>
						</ul>
						<p>If You do default in any one of these ways, other than a default in the agreement to pay rent, Owner may serve You with a written notice to stop or correct the specified default within 10 days. You must then either stop or correct the default within 10 days, or, if You need more than 10 days, You must begin to correct the default within 10 days and continue to do all that is necessary to correct the default as soon as possible.</p>
					</li>
					<li>If You do not stop or begin to correct a default within 10 days, Owner may give You a second written notice that this Lease will end six days after the date the second written notice is sent to You. At the end of the 6-day period, this Lease will end and You then must move out of the Apartment. Even though this Lease ends, You will remain liable to Owner for unpaid rent up to the end of this Lease, the value of your occupancy, if any, after the Lease ends, and damages caused to Owner after that time as stated in Article 18.</li>
					<li>If You do not pay your rent when this Lease requires after a personal demand for rent has been made, or within three days after a statutory written demand for rent has been made, or if the Lease ends, Owner may do the following: (a) enter the apartment and retake possession of it if You have moved out or (b) go to court and ask that You and all other occupants in the Apartment be compelled to move out.</li>
				</ol>
				<p>Once this Lease has been ended, whether because of default or otherwise, You give up any right You might otherwise have to reinstate or renew the Lease.</p>
			</li>
			<li>
				<h4>REMEDIES OF OWNER AND YOUR LIABILITY</h4>
				<p>If this Lease is ended by Owner because of your default, the following are the rights and obligations of You and Owner.</p>
				<ul type="a">
					<li>You must pay your rent until this Lease has ended. Thereafter, You must pay an equal amount for what the law calls “use and occupancy” until You actually move out.</li>
					<li>Once You are out, Owner may re-rent the Apartment or any portion of it for a period of time which may end before or after the ending date of this Lease. Owner. may re-rent to a new tenant at a lesser rent or may charge a higher rent than the rent in this Lease.</li>
					<li>
						<p>Whether the Apartment is re-rented or not, You must pay to Owner as damages:</p>
						<ul>
							<li>the difference between the rent in this Lease and the amount, if any, of the rents collected in any later lease or leases of the Apartment for what would have been the remaining period of this Lease; and</li>
							<li>Owner’s expenses for advertisements, broker’s fees and the cost of putting the Apartment in good condition for re-rental; and</li>
							<li>Owner’s expenses for attorney’s fees.</li>
						</ul>
					</li>
					<li>You shall pay all damages due in monthly installments on the rent day established in this Lease. Any legal action brought to collect one or more monthly installments of damages shall not prejudice in any way Owner’s right to collect the damages for a later month by a similar action. If the rent collected by Owner from a subsequent tenant of the Apartment is more than the unpaid rent and damages which You owe Owner, You cannot receive the difference. Owner’s failure to re-rent to another tenant will not release or change your liability for damages, unless the failure is due to Owner’s deliberate inaction.</li>
				</ul>
			</li>
			<li>
				<h4>ADDITIONAL OWNER REMEDIES</h4>
				<p>If You do not do everything You have agreed to do, or if You do anything which shows that You intend not to do what You have agreed to do, Owner has the right to ask a Court to make You carry out your agreement or to give the Owner such other relief as the Court can provide. This is in addition to the remedies in Article 16 and 17 of this lease.</p>
			</li>
			<li>
				<h4>FEES AND EXPENSES</h4>
				<ul type="a">
					<li>
						<p><strong>Owner’s Right</strong>. You must reimburse Owner for any of the following fees and expenses incurred by Owner:</p>
						<ol>
							<li>Making any repairs to the Apartment or the Building which result from misuse or negligence by You or persons who live with You, visit You, or work for You;</li>
							<li>Repairing or replacing property damaged by Your misuse or negligence;</li>
							<li>Correcting any violations of city, state or federal laws or orders and regulations of insurance rating organizations concerning the Apartment or the Building which You or persons who live with You, visit You, or work for You have caused;</li>
							<li>Preparing the Apartment for the next tenant if You move out of your Apartment before the Lease ending date;</li>
							<li>Any legal fees and disbursements for legal actions or proceedings brought by Owner against You because of a Lease default by You or for defending lawsuits brought against Owner because of your actions;</li>
							<li> Removing all of your property after this Lease is ended;</li>
							<li>All other fees and expenses incurred by Owner because of your failure to obey any other provisions and agreements of this Lease; These fees and expenses shall be paid by You to Owner as additional rent within 30 days after You receive Owner’s bill or statement. If this Lease has ended when these fees and expenses are incurred, You will still be liable to Owner for the same amount as damages.</li>
						</ol>
					</li>
					<li>
						<p>Tenant’s Right. Owner agrees that unless sub-paragraph 5 of this Article 19 has been stricken out of this Lease</p>
						<p>You have the right to collect reasonable legal fees and expenses incurred in a successful defense by You of a lawsuit brought by Owner against You or brought by You against Owner to the extent provided by Real Property Law, section 234.</p>
					</li>
				</ul>
			</li>
			<li>
				<h4>PROPERTY LOSS, DAMAGES OR INCONVENIENCE</h4>
				<p>Unless caused by the negligence or misconduct of Owner or Owner’s agents or employees, Owner or Owner’s agents and employees are not responsible to You for any of the following (1) any loss of or damage to You or your property in the Apartment or the Building due to any accidental or intentional cause, even a theft or another crime committed in the Apartment or elsewhere in the Building; (2) any loss of or damage to your property delivered to any employee of the Building (i.e., doorman, superintendent, etc.,); or (3) any damage or inconvenience caused to You by actions, negligence or violations of a Lease by any other tenant or person in the Building except to the extent required by law.</p>
				<p>Owner will not be liable for any temporary interference with light, ventilation, or view caused by construction by or in behalf of Owner. Owner will not be liable for any such interference on a permanent basis caused by construction on any parcel of land not owned by Owner. Also, Owner will not be liable to You for such interference caused by the permanent closing, darkening or blocking up of windows, if such action is required by law. None of the foregoing events will cause a suspension or reduction of the rent or allow You to cancel the Lease.</p>
			</li>
			<li>
				<h4>FIRE OR CASUALTY</h4>
				<ul type="a">
					<li>If the Apartment becomes unusable, in part or totally, because of fire, accident or other casualty, this Lease will continue unless ended by Owner under C below or by You under D below. But the rent will be reduced immediately. This reduction will be based upon the part of the Apartment which is unusable.</li>
					<li>Owner will repair and restore the Apartment, unless Owner decides to take actions described in paragraph C below.</li>
					<li>After a fire, accident or other casualty in the Building, Owner may decide to tear down the Building or to substantially rebuild it. In such case, Owner need not restore the Apartment but may end this Lease. Owner may do this even if the Apartment has not been damaged, by giving You written notice of this decision within 30 days after the date when the damage occurred. If the Apartment is usable when Owner gives You such notice, this Lease will end 60 days from the last day of the calendar month in which You were given the notice.</li>
					<li>If the Apartment is completely unusable because of fire, accident or other casualty and it is not repaired in 30 days, You may give Owner written notice that You end the Lease. If You give that notice, this Lease is considered ended on the day that the fire, accident or casualty occurred. Owner will refund your security deposit and the pro-rata portion of rents paid for the month in which the casualty happened.</li>
					<li>Unless prohibited by the applicable insurance policies, to the extent that such insurance is collected, You and Owner release and waive all right of recovery against the other or anyone claiming through or under each applicable policy by way of subrogation.</li>
				</ul>
			</li>
			<li>
				<h4>PUBLIC TAKING</h4>
				<p>The entire building or a part of it can be acquired (condemned) by any government or government agency for a public or quasi-public use or purpose. If this happens, this Lease shall end on the date the government or agency take title and You shall have no claim against Owner for any damage resulting; You also agree that by signing this Lease, You assign to Owner any claim against the Government or Government agency for the value of the unexpired portion of this Lease.</p>
			</li>
			<li>
				<h4>SUBORDINATION CERTIFICATE AND ACKNOWLEDGMENTS</h4>
				<p>All leases and mortgages of the Building or of the land on which the Building is located, now in effect or made after this Lease is signed, come ahead of this Lease. In other words, this Lease is “subject and subordinate to” any existing or future lease or mortgage on the Building or land, including any renewals, consolidations, modifications and replacements of these leases or mortgages. If certain provisions of any of these leases or mortgages come into effect, the holder of such lease or mortgage can end this lease. If this happens, You agree that You have no claim against Owner or such lease or mortgage holder. If Owner requests, You will sign promptly an acknowledgment of the “subordination” in the form that Owner requires.</p>
				<p>You also agree to sign (if accurate) a written acknowledgment to any third party designated by Owner that this Lease is in effect, that Owner is performing Owner’s obligations under this Lease and that you have no present claim against Owner.</p>
			</li>
			<li>
				<h4>TENANT’S RIGHT TO LIVE IN AND USE THE APARTMENT</h4>
				<p>If You pay the rent and any required additional rent on time and You do everything You have agreed to do in this Lease, your tenancy cannot be cut off before the ending date, except as provided for in Article 21, 22, and 23.</p>
			</li>
			<li>
				<h4>BILLS AND NOTICE</h4>
				<ul type="a">
					<li><strong>Notices to You.</strong> Any notice from Owner or Owner’s agent or attorney will be considered properly given to You if it (1) is in writing; (2) is signed by or in the name of Owner or Owner’s agent; and (3) is addressed to You at the Apartment and delivered to You personally or sent by registered or certified mail to You at the Apartment. The date of service of any written notice by owner to you under this agreement is the date of delivery or mailing of such notice.</li>
					<li><strong>Notices to Owner.</strong> If You wish to give a notice to Owner, you must write it and deliver it or send it by registered or certified mail to Owner at the address noted on page 1 of this Lease or at another address of which Owner or Agent has given You written notice.</li>
				</ul>
			</li>
			<li>
				<h4>GIVING UP RIGHT TO TRIAL BY JURY AND COUNTERCLAIM</h4>
				<ul type="a">
					<li>Both You and Owner agree to give up the right to a trial by jury in a court action, proceeding or counterclaim on any matters concerning this Lease, the relationship of You and Owner as Tenant and Landlord or your use or occupancy of the Apartment. This agreement to give up the right to a jury trial does not include claims for personal injury or property damage.</li>
					<li>If Owner begins any court action or proceeding against You which asks that You be compelled to move out, You cannot make a counterclaim unless You are claiming that Owner has not done what Owner is supposed to do about the condition of the Apartment or the Building.</li>
				</ul>
			</li>
			<li>
				<h4>NO WAIVER OF LEASE PROVISIONS</h4>
				<ul type="a">
					<li> Even if Owner accepts your rent or fails once or more often to take action against You when You have not done what You have agreed to do in this Lease, the failure of Owner to take action or Owner’s acceptance of rent does not prevent Owner from taking action at a later date if You again do not do what You have agreed to do.</li>
					<li>Only a written agreement between You and Owner can waive any violation of this Lease.</li>
					<li>If You pay and Owner accepts an amount less than all the rent due, the amount received shall be considered to be in payment of all or a part of the earliest rent due. It will not be considered an agreement by Owner to accept this lesser amount in full satisfaction of all of the rent due.</li>
					<li>Any agreement to end this Lease and also to end the rights and obligations of You and Owner must be in writing, signed by You and Owner or Owner’s agent. Even if You give keys to the Apartment and they are accepted by any employee, or agent, or Owner, this Lease is not ended.</li>
				</ul>
			</li>
			<li>
				<h4>CONDITION OF THE APARTMENT</h4>
				<p>When You signed this Lease, You did not rely on anything said by Owner, Owner’s agent or superintendent about the physical condition of the Apartment, the Building or the land on which it is built. You did not rely on any promises as to what would be done, unless what was said or promised is written in this Lease and signed by both You and Owner or found in Owner’s floor plans or brochure shown to You before You signed the Lease. Before signing this Lease, You have inspected the apartment and You accept it in its present condition “as is,” except for any condition which You could not reasonably have seen during your inspection. You agree that Owner has not promised to do any work in the Apartment except as specified in attached “Work” rider.</p>
			</li>
			<li>
				<h4>DEFINITIONS</h4>
				<ul type="a">
					<li>Owner: The term “Owner” means the person or organization receiving or entitled to receive rent from You for the Apartment at any particular time other than a rent collector or managing agent of Owner. “Owner” includes the owner of the land or Building, a lessor, or sublessor of the land or Building and a mortgagee in possession. It does not include a former owner, even if the former owner signed this Lease.</li>
					<li>You: The Term “You” means the person or persons signing this Lease as Tenant and the successors and assigns of the signer. This Lease has established a tenant-landlord relationship between You and Owner.</li>
				</ul>
			</li>
			<li>
				<h4>SUCCESSOR INTERESTS</h4>
				<p>The agreements in this Lease shall be binding on Owner and You and on those who succeed to the interest of Owner or You by law, by approved assignment or by transfer.</p>
				<p><strong>Owners Rules - a part of this lease article 10.</strong></p>
				<p>By initialing below, you acknowledge and agree to the terms in Section 4.</p>

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
				{if $contract_info->signing == 1}
					DATE: {$contract_info->date_signing|date}<br/>
				{/if}
					SIGNATURE:<br>
				</p>
				{if $booking->client_type_id == 2 && $booking->airbnb_reservation_id}
				<p>Digital Signature ID: {$booking->airbnb_reservation_id}</p>
				{elseif $contract_info->signature2}
					<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
				{else}
				<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree4" for="agree4">I agree and sign</label><input type="checkbox" id="agree4" name="agree4" class="agree" value="1"></p>
				{/if} 
			</li>
		</ol>
	</li>
	<li>
		<h1>Owner's rules</h1>
		<ol>
			<li>
				<h4>RULES</h4>
				<div class="center">
					<h1>STANDARD FORM OF APARTMENT</h1>
					<h3>Lease</h3>
					<h1>ATTACHED RULES WHICH ARE A PART OF THE LEASE AS PROVIDED BY ARTICLE 10</h1>
				</div>
				<ol>
					<li>
						<p><strong>Public Access Ways</strong></p>
						<ul type="a">
							<li>Tenants shall not block or leave anything in or on fire escapes, the sidewalks, entrances, driveways, elevators, stairways, or halls. Public access ways shall be used only for entering and leaving the Apartment and the Building. Only those elevators and passageways designated by Owner can be used for deliveries.</li>
							<li>Baby carriages, bicycles or other property of Tenants shall not be allowed to stand in the halls, passageways, public areas or courts of the Building.</li>
						</ul>
					</li>
					<li>
						<p><strong>Bathroom and Plumbing Fixtures</strong></p>
						<p>The bathrooms, toilets and wash closets and plumbing fixtures shall only be used for the purposes for which they were designed or built; sweepings, rubbish bags, acids or other substances shall not be placed in them.</p>
					</li>
					<li>
						<p><strong>Refuse</strong></p>
						<p>Carpets, rugs or other articles shall not be hung or shaken out of any window of the Building. Tenants shall not sweep or throw or permit to be swept or thrown any dirt, garbage or other substances out of the windows or into any of the halls, elevators or elevator shafts. Tenants shall not place any articles outside of the Apartments or outside of the building except in safe containers and only at places chosen by Owner.</p>
					</li>
					<li>
						<p><strong>Elevators</strong></p>
						<p>All non-automatic passenger and service elevators shall be operated only by employees of Owner and must not in any event be interfered with by Tenants. The service elevators, if any, shall be used by servants, messengers and trades people for entering and leaving, and the passenger elevators, if any, shall not be used by them for any purpose. Nurses with children, however, may use the passenger elevators.</p>
					</li>
					<li>
						<p><strong>Laundry</strong></p>
						<p>Laundry and drying apparatus, if any, shall be used by Tenants in the manner and at the times that the superintendent or other representative of Owner may direct. Tenants agree that the use of the laundry equipment is at your own risk and the landlord and management are not liable for any loss under any circumstance. Tenants shall not dry or air clothes on the roof.</p>
					</li>
					<li>
						<p><strong>Keys and Locks</strong></p>
						<p>Owner may retain a pass key to the apartment. Tenants may install on the entrance of the Apartment an additional lock of not more than three inches in circumference. Tenants may also install a lock on any window but only in the manner provided by law. Immediately upon making any installation of either type, Tenants shall notify Owner or Owner’s agent and shall give Owner or Owner’s agent a duplicate key. If changes are made to the locks or mechanism installed by Tenants, Tenants must deliver keys to Owner. At the end of this Lease, Tenants must return to Owner all keys either furnished or otherwise obtained. If Tenants lose or fail to return any keys which were furnished to them. Tenants shall pay to Owner the cost of replacing them.</p>
					</li>
					<li>
						<p><strong>Noise</strong></p>
						<p>Tenants, their families, guests, employees, or visitors shall not make or permit any disturbing noises in the Apartment or Building or permit anything to be done that will interfere with the rights, comforts or convenience of other tenants. Also, Tenants shall not play a musical instrument or operate or allow to be operated a phonograph, CD player, radio or television set so as to disturb or annoy any other occupant of the Building.</p>
					</li>
					<li>
						<p><strong>No Projections</strong></p>
						<p>An aerial may not be erected on the roof or outside wall of the Building without the written consent of Owner. Also, awnings or other projections shall not be attached to the outside walls of the Building or to any balcony or terrace.</p>
					</li>
					<li>
						<p><strong>Pets</strong></p>
						<p><strong>Tenants may keep a cat without notifying the Landlord or Management. A Dog and may be kept in the Apartment (45lb limit & no pit bulls or other aggressive breeds allowed).</strong> This consent can be taken back by Owner at any time for good cause on reasonably given notice. Unless carried or on a leash, a dog shall not be permitted on any passenger elevator or in any public portion of the building. Also, dogs are not permitted on any grass or garden plot under any condition. BECAUSE OF THE HEALTH HAZARD AND POSSIBLE DISTURBANCE OF OTHER TENANTS WHICH ARISE FROM THE UNCONTROLLED PRESENCE OF ANIMALS, ESPECIALLY DOGS, IN THE BUILDING, THE STRICT ADHERENCE TO THE PROVISIONS OF THIS RULE BY EACH TENANT IS A MATERIAL REQUIREMENT OF EACH LEASE. TENANTS’ FAILURE TO OBEY THIS RULE SHALL BE CONSIDERED A SERIOUS VIOLATION OF AN IMPORTANT OBLIGATION BY TENANT UNDER THIS LEASE. OWNER MAY ELECT TO END THIS LEASE BASED UPON THIS VIOLATION.</p>
					</li>
					<li>
						<p><strong>Moving</strong></p>
						<p>Tenants can use the elevator to move furniture and possessions only on designated days and hours. Owner shall not be liable for any costs, expenses or damages incurred by Tenants in moving because of delays caused by the unavailability of the elevator.</p>
					</li>
					<li>
						<p><strong>Floors</strong></p>
						<p>Apartment floors shall be covered with rugs or carpeting of at least 80% of the floor area of each room excepting only kitchens, pantries, bathrooms and hallways. The tacking strip for wall-to-wall carpeting will be glued, not nailed to the floor. </p>
					</li>
					<li>
						<p><strong>Window Guards</strong></p>
						<p>IT IS A VIOLATION OF LAW TO REFUSE, INTERFERE WITH INSTALLATION, OR REMOVE WINDOW GUARDS WHERE REQUIRED. (SEE ATTACHED WINDOW GUARD RIDER)</p>
					</li>
				</ol>
			</li>
		</ol>
		<p>By initialing below, you acknowledge and agree to the terms in Section 5.</p>

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

	</li>

 	<li>
 		<h1>Lease Rider</h1>
 		<ol>
 			<li>
 				<h4>LEASE RIDER</h4>
 				<p>This Rider is annexed to and made a part of the Agreement to Lease, drawn the <strong>{if $contract_info->signing}{$contract_info->date_signing|date_format:'%b %e, %Y'}{else}{$smarty.now|date_format:'%b %e, %Y'}{/if}</strong>, between, 186N6 Owner, LLC, as Landlord and <strong>{foreach $contract_users as $user}{if $contract_user->id != $user->id}{$user->name|escape}, {/if}{/foreach}{$contract_user->name|escape}</strong>, as Tenant(s) for apartment <strong>{$apartment->name}</strong>, located at {$contract_info->rental_address}</p>
 				<p>In the event any of the information contained in this Rider should conflict with the information contained in the boiler-plate portion of this Lease, the Rider will prevail.</p>
 				<ol>
 					<li>
 						<p>The monthly rent is due on the first of each calendar month through the length of the Lease. In the event the rent is not received by the Landlord by the 5th of the month, a 5% or $50.00 late fee, which ever is less, will be assessed on the 6th day without exception. The late fee will be considered additional rent, and should be included with the regular monthly payment. The fee will be carried over to the next month if amount on late notice is not paid in full. The amount will be removed from security deposit if ignored.</p>
 						<p>If partial rent is paid by the 5th, this fee will be applied to any outstanding balance remaining on the 6th day of the month.</p>
 					</li>
 					<li>
 						In the event any check rendered for payment of rent is returned by the Tenant’s bank, a $20.00 returned check fee, as well as applicable late fees, will be due and owing as additional rent without exception.
 					</li>
 					<li>
 						<p>The security deposit rendered by the Tenant at the execution of this Lease Agreement in the amount of <strong>{$contract_info->price_deposit|convert} (US Dollars)</strong> MAY NOT be used as the last month’s rent. In the event that the tenant finds a financially qualified and landlord approved roommate whose income is 40x the monthly rent the landlord agrees to return one month of security deposit back to the tenant. Refund of the Security Deposit will only be granted under the following terms:</p>
 						<ul type="a">
 							<li>The Tenant is completely current with all rent payments and additional rent payments;</li>
 							<li>The Tenant has not vacated the apartment prior to the end date of the Lease Agreement, or has not broken the Lease Agreement in any way;</li>
 							<li>The Tenant is not in default of any of the other terms of the boiler-plate portion or Rider to this Lease Agreement;</li>
 							<li>The Tenant delivers his apartment to the Landlord completely vacant of persons and belongings, without any damage (reasonable wear- and-tear excluded) and in broom-clean condition; The Landlord retains the right to charge the tenant for damage to any item listed on the inventory list and tenant agrees to pay for any such damage as per the attached FEE CATALOG. The charges will be deducted from the tenant's security deposit.</li>
 							<li>All appliances and fixtures belonging to the Landlord, and provided to the Tenant throughout the term of the Lease Agreement, are clean and in good working order;</li>
 							<li>After a walk-through by the Landlord and/or his Agent and the Tenant.</li>
 						</ul>
 					</li>
 					<li>Tenant may not sublet the apartment unless written permission has been granted by the landlord. All adult occupants of the apartment covered by this Lease Agreement must be listed as Tenants on the Lease. In the event Co-Tenant(s) wish to be added and/or changed during the Lease Term, the Landlord must be notified in writing of said addition within 30 days of occupancy. Changes in Co-Tenant(s) also require Landlord’s written permission and must be notified 30 days prior to change. New tenants/co-tenants are required to complete an application, credit check, and application fee of $50.00. Landlord reserves the right to refuse any sub or co-tenant based on application/ credit check. Landlord’s approval will only be granted if the current Tenant(s) is not in default of any of the terms of the Lease Agreement.</li>
 					<li>
 						<p>Each individual listed as Tenant is responsible for full payment of the rent. Rent payments will be accepted by Tenants listed on the lease ONLY.</p>
 						<p>Any agreement reached between Co-Tenants regarding payment of rent is unknown to the Landlord, and in the event that one or more Co-Tenants are in default of rent and additional rent payments (or is in default of any other terms of this Lease Agreement) then ALL CO- TENANTS will be considered in default, leaving the Landlord to enforce all of his rights and remedies against ALL CO-TENANTS under the terms of this Lease Agreement.</p>
 					</li>
 					<li>
 						<p>Tenant shall make all rent payments in full. Payment or receipt of a rental payment of less than the amount stated and agreed upon in the lease shall be deemed as nothing more than partial payment on that month’s account. Under no circumstances shall Landlord’s acceptance of a partial payment constitute accord and satisfaction. Nor will Landlord’s acceptance of a partial payment forfeit the Landlord’s right to collect the balance due on the account, despite any endorsement, stipulation, or other statement on check.</p>
 						<p>Any modification of this lease must be made in a letter signed by the Landlord, in which the Landlord states and agrees to the modification. The Landlord may accept any partial payment check with any conditional endorsement without prejudice to his/her right to recover the balance remaining due, or to pursue any other remedy available under this lease.</p>
 					</li>
 					<li>Tenant(s) agrees to abide by New York City’s local sanitation and recycling laws. Any ticket issued due to Tenant’s negligence will be passed on to said Tenant who will in turn, be responsible to pay the fine.</li>
 					<li>PETS. <strong>A Dog and may be kept in the Apartment (45lb limit & no pit bulls or other aggressive breeds allowed)</strong>. Tenants may keep a cat. This consent can be taken back by Owner at any time for good cause on reasonably given notice. Unless carried or on a leash, a dog shall not be permitted on any passenger elevator or in any public portion of the building. Also, dogs are not permitted on any grass or garden plot under any condition. BECAUSE OF THE HEALTH HAZARD AND POSSIBLE DISTURBANCE OF OTHER TENANTS WHICH ARISE FROM THE UNCONTROLLED PRESENCE OF ANIMALS, ESPECIALLY DOGS, IN THE BUILDING, THE STRICT ADHERENCE TO THE PROVISIONS OF THIS RULE BY EACH TENANT IS A MATERIAL REQUIREMENT OF EACH LEASE. TENANTS’ FAILURE TO OBEY THIS RULE SHALL BE CONSIDERED A SERIOUS VIOLATION OF AN IMPORTANT OBLIGATION BY TENANT UNDER THIS LEASE. OWNER MAY ELECT TO END THIS LEASE BASED UPON THIS VIOLATION.</li>
 					<li>All sinks, toilets, tub and shower drains will be inspected before the commencement of occupancy to ascertain their proper working order. During the tenancy, if any of the apartment drains become clogged, the Tenant will assume the full responsibility to clear the drain, including but not limited to the hiring of a plumber, unless it is proven to be a main building sewer or common drain- stack problem. In the event it is determined that a clog has occurred in the area between the private apartment fixture drain and the common drain-stack, the Tenant will assume responsibility for the plumbing expenses. In the event it is determined that a clog has occurred in the area of the common drain-stack and the sewer, the Landlord will assume responsibility for the plumbing expenses.</li>
 					<li>Tenant is responsible for maintaining and replacing batteries in smoke detectors. Tenant is forbidden from tampering with or removing batteries from any smoke detector.</li>
 					<li>Tenant is responsible to replace light bulbs inside their apartments at their own expense.</li>
 					<li>Tenant must not change any of the existing locks on any doors. A minimum of $500 or actual cost, which may be lower or higher, per lock fee will be charged to the tenant.</li>
 					<li>Tenant must not paint apartment dark colors. If the apartment is painted by the tenant it must be returned to the original color prior to the tenant's move out. If the apartment is painted and not restored to its original color a fee off not less than $2,500 will be removed from the security deposit. Tenant shall not paint exposed brick walls, wood trim, doors, and windows that are presently stained. The tenant shall not make holes in the brick, only in the mortar between the bricks to hang shelves or pictures. The tenant agrees not to wallpaper, tile or use any covering or to paint floors, walls or ceilings of the demised premises without the express written permission of the Landlord, otherwise it will be the tenant’s sole responsibility to remove or scrape all traces of unauthorized painting, wallpapering and floor covering at the tenant’s own expense, and or the cost thereof will be deducted and withheld from the tenant’s security deposit hereunder.</li>
 					<li>Tenant must purchase Renter’s Insurance for duration of lease and all renewals and provide proof of insurance to the landlord within 2 weeks of signing the lease.</li>
 					<li>If the landlord is compelled to incur any expenses (including reasonable attorney’s fees) in the instituting, prosecuting and or defending any action or proceeding instituted by reason of any default of tenant hereunder, the sum or sums so paid by landlord with all interest, cost and damages, shall be deemed to be additional rent hereunder and shall be due from tenant to landlord on the first day of the month following the incurring of such perspective expenses.</li>
 					<li>This apartment will be taken in “as is” condition.</li>
 					<li>If tenant does not renew the lease then he/she will allow landlord and or the landlord’s broker(s) to show the apartment a minimum of 30 days prior to the end of the lease. If the tenant does not intent on renewing, then a minimum of 30 days written notice must be given to the landlord. Failure to give 30 days written notice will result in the tenant’s forfeiture of the security deposit. Failure to cooperate in allowing the landlord or landlord’s agent(s) to show the unit or any action deemed to impair or sabotage to the re-rental of the apartment will result in the tenant’s forfeiture of the security deposit.</li>
 					<li>In the event of a <strong>holdover</strong>, the tenant agrees that the rent will be due and payable and all terms of the lease and riders will remain in effect.</li>
 					<li>In the event of a <strong>roommate switch prior to the lease expiration date</strong>, the tenant(s) agree to an administrative fee of $300.00 per roommate.</li>
 					<li><strong>If the tenant(s) wish to get out of this lease prior to the lease expiration date</strong>, they must submit a written request to the landlord. The landlord reserves the right to approve or deny this request at their own discretion. If the request is approved, the tenant(s) agree to an administrative fee of $500.00. The tenant will be solely responsible for finding a financially qualified replacement tenant to take their place for the remainder of the lease term. The replacement tenant(s) must submit an application package and go through the screening process and be approved by the Landlord and or their Agent. The Tenant(s) agrees to be fully responsible for all rent until they find a replacement tenant.</li>
 					<li>Outdoor space: The roof deck on the property it is considered shared space. You may not store anything on the roof deck. If the unit has a private yard/outdoor area, the tenant(s) agrees that the landlord is not required to maintain the yard and will not provide foliage or gardening services. The tenant agrees to keep any drains clear of leaves and to maintain the yard and to return it in mowed condition upon vacating the apartment. The tenant agrees to only keep outdoor furniture in the yard. If the unit has a balcony, deck or patio, the tenant agrees to only use outdoor furniture.</li>
 					<li>Tenant agrees to be fully responsible for any excessive noise created intentionally or unintentionally by tenant or their guest(s) and agrees to correct the cause of such noise upon notice by the landlord or property management.</li>
 					<li><strong>Airbnb</strong>. The lease has a no subletting clause. Furthermore, short term rentals under thirty (30) days are illegal in New York City. In the event that the landlord receives a violation and or fine associated with the tenant’s illegal rental of the apartment on AirBnB or by way of any other short term rental method, the tenant hereby agrees to reimburse the landlord for all fines and all associated costs, including legal fees, incurred in association with curing the violation(s).</li>
 					<li>This Lease shall not be binding unless executed by both Landlord and Tenant. Submission by Landlord of the within lease for execution by Tenant, shall confer no rights or impose any obligations on either party unless and until both Landlord and Tenant shall have executed this Lease and duplicate originals thereof shall have been delivered to the respective parties.</li>
 					<li>This rider is applicable to the original lease and any renewal thereof.</li>
 				</ol>
 			</li>
 		</ol>
 		<p>By initialing below, you acknowledge and agree to the terms in Section 6.</p>

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
 	</li>
 	<li>
 		<h1>House Rules & Code of Conduct</h1>
 		<ol>
 			<li>
 				<h4>HOUSE RULES & CODE OF CONDUCT</h4>
 				<h1>ATTACHED RULES WHICH ARE A PART OF THE LEASE HOUSE RULES AND REGULATIONS</h1>
 				<p>Terms and Conditions</p>
 				<ul>
	 				<li>
	 					<p><strong>Individual Tenant's signature on the Lease indicates that Individual Tenant agrees to and accepts the terms, conditions, rules and regulations set forth below ("House Rules"):</strong></p>
		 				<p>This is a legally binding contract rider to the Lease. Individual Tenant understands that any violation of the Lease or these House Rules may result in penalties ranging from a warning to Individual Tenant being permanently discharged from the Apartment Unit and the Apartment Building. Where appropriate for the personal safety of Individual Tenant or other Individual Tenants of the Apartment Building, Lessor reserves the right to remove an Individual Tenant from his/her Apartment Unit and the Apartment Building. Individual Tenants removed from the Apartment Building for violations of the Lease and/or these House Rules will still be held to his/her financial obligations for the remainder of the Term of the Lease.</p>
		 				<p>Lessor reserves the right to rescind or amend any of the Lessor's House Rules, and to institute such other rules from time-to-time as may be deemed necessary for the safety, care, or cleanliness of the Apartment Building and for securing the comfort and convenience of all Individual Tenants and their Authorized Occupants. The Lessor shall not be liable to Individual Tenants or their Authorized Occupants for the violation of any of the Lessor's rules or the breach of any of the items in any Lease by any other Individual Tenant, Authorized Occupant or occupant of the Apartment Building.</p>
	 				</li>
	 				<li>
	 					<p><strong>Initial Apartment Unit Condition, Occupancy, Keys and Lockout Fees</strong></p>
		 				<p>At the commencement of occupancy, Individual Tenant will have seven (7) days to note the condition of, and any damage to, the Apartment Unit and the Lessor provided furniture, fixtures, equipment, appliances and other property in the Apartment Unit identified on the Inventory List. Individual Tenants must take care in keeping their Apartment Units clean to prevent insect infestation.</p>
		 				<p>Individual Tenant may not change or add locks (including chain locks, deadbolts, etc.). Duplication of keys is prohibited. Individual Tenant must return his/her key tags any other access items to Lessor at the end of the Individual Tenant's tenancy under the Lease. Unauthorized copies of keys will not be accepted. At or following Individual Tenant's vacating of the Apartment Unit, the exclusive use Bedroom and non- exclusive use Living Room, Kitchen and Bathroom, they will be inspected and any damage not previously noted by Individual Tenant in the initial seven (7) day period of occupancy shall be charged to Individual Tenant.</p>
		 				<p>In the event that Individual Tenant or his or her Authorized Occupant, guests or invitees damage any locks, Individual Tenant shall pay for changes to the locks.</p>
		 				<p>In the event Individual Tenant loses or breaks any physical access tag or the digital access code needs to be changed because Individual Tenant has not keep the code secure from unauthorized person, Individual Tenant shall pay Lessor a replacement and/or access code resetting fee of One Hundred Dollars ($100). Individual Tenant shall advise Lessor of the loss of any physical access tag and compromise of the security of the digital access code as soon as possible but no later than twenty-four hours of such loss.</p>
		 				<p>Lessor shall charge Individual Tenant a fee of $150 to unlock the Apartment Unit. Lessor makes no representation that staff will be available at all times to provide access.</p>
	 				</li>
 					<li>
 						<p><strong>Damage/Loss Charges</strong></p>
 						<p>Individual Tenant is responsible for damages to his/her Apartment Unit, as well as damage and/or loss to the furnishings, fixtures, equipment, appliances and other property Lessor has provided, which are caused by the acts or omissions of such Individual Tenant, and his or her Authorized Occupants, guests and invitees. Individual Tenant agrees to pay for the restoration of the property to its condition at the time of initial occupancy or for repairs or replacement (except normal wear and tear), unless the identity of others responsible, including other Individual Tenants and their Authorized Occupants, guests and invitees, for the damage or loss is established and proven by Individual Tenant. This responsibility extends until the Apartment Unit is officially returned to Lessor as provided above. If the responsible party for the damages cannot be determined, charges for damages, cleaning, replacement of furniture, etc. shall be divided by the number of Individual Tenants leasing the Apartment Unit. If one or more Individual Tenants or their Authorized Occupants assume responsibility for damages, cleaning, replacement of furniture, etc., a written statement signed by the responsible party must be noted in writing and delivered to Lessor at the time of surrendering occupancy. Charges will not be assessed to one Individual Tenant based solely on another Individual Tenant's claim of wrongdoing. Individual Tenant should assure that all windows and doors to the Apartment Unit are locked and secured at all times and when vacating the Apartment Unit. It is understood that Individual Tenants are responsible for any damage or loss caused or non-routine cleaning or trash removal required to the common areas of the Apartment Building and their furnishings, including vending machines and other equipment placed in the Apartment Building as a convenience to Individual Tenants and Authorized Occupants. Common areas outside of Apartment Units may include corridors, recreation rooms, kitchens, study rooms, living rooms, laundry rooms, public bathrooms, lounges, terraces, roof top terraces, entry corridors and pavement in front of the Apartment Building, as specified for the Apartment Building on the Quarters website. When damage occurs, Individual Tenant(s) will be billed directly for the repairs. Lessor shall have the authority to assess and assign charges for these damages as set forth in the Fee Catalogue accessed through the Quarters App.</p>
 					</li>
 					<li>
 						<p><strong>Furnishings/Fixtures</strong></p>
 						<p>Furniture, fixtures, equipment, appliances and other property provided by Lessor may not be removed from an Apartment Unit or the Apartment Building and may not be switched between rooms. In addition, window screens, if any, shall not be removed.</p>
 					</li>
 					<li>
 						<p><strong>Guests/Visitation</strong></p>
 						<p>Guests and invitees are expected to abide by these House Rules and all other rules and regulations. Individual Tenant is responsible for the behavior of his/her guests and invitees, including restitution for damages caused by such Individual Tenant's guests and invitees. In order to have a guest(s) or invitee(s), Individual Tenant must have the consent of the other Individual Tenants of the Apartment Unit on each occasion. Extended visits (i.e., more than 3 consecutive days, or more than 5 days in any 2 week period) are not permitted, nor is cohabitation (residency with someone other than an Authorized Occupant provided for in the Lease).</p>
 					</li>
 					<li>
 						<p><strong>Housekeeping/Trash Removal</strong></p>
 						<p>Individual Tenants are responsible for routine cleaning of their Apartment Units, and maintaining order in all common areas, such as hallways, stairwells. Hallways and stairwells must be kept free of personal belongings. Lessor may offer optional housekeeping services for the Apartment Unit for a fee. Periodic cleaning of common areas of the Apartment Building outside of each Apartment Unit will be provided by Lessor. Individual Tenants shall maintain their exclusive use Bedrooms and non-exclusive use shared Living Room, Kitchen and Bathroom in an orderly and sanitary condition. This includes removal of personal trash (such as trash bags, pizza boxes, etc.) to a trash bin or dumpster and recycling as provided. Individual Tenants may be charged a fee for the removal of their personal trash from common areas in the Apartment Building.</p>
 					</li>
 					<li>
 						<p><strong>Inspections/Unit Entry</strong></p>
 						<p>Authorized representatives of Lessor may enter an Individual Tenant's Apartment Unit:</p>
 						<ol>
 							<li>For the purpose of assuring fire protection, life safety, sanitation or scheduled maintenance and proper use of Lessor's furnishings, fixtures, equipment, appliances, property and facilities. Any such inspections or entry, except in the case of emergencies, shall be announced twenty-four (24) hours in advance by providing notice to the Individual Tenants of the Apartment Unit or the posting of a notice in common areas of the Apartment Building. Individual Tenant's absence will not prevent the carrying out of such maintenance or safety inspections.</li>
 							<li> When Individual Tenant has requested repairs or extermination by delivering a written request for work to Lessor's representative, workers may enter Individual Tenant's Apartment Unit in his/her absence.</li>
 							<li>If an Individual Tenant moves out of an Apartment Unit, the Lessor or its representative may enter the Apartment Unit following the completion of the move to inspect for damages and insure space is available for a new occupant.</li>
 							<li>To verify that all vacancies are prepared for new occupants. Cleaning and other charges may be imposed on an Individual Tenant if his/her Apartment Unit is not ready for a new occupant.</li>
 							<li>If noise (unattended loud music, alarm clock, etc.) coming from an Apartment Unit where the occupants are not present is causing a disruption to the community.</li>
 							<li>In any circumstance where Lessor's representative reasonably believes in good faith that a health or safety issue or threat exists, including for example illegal drug use or illegal presence of weapons.</li>
 						</ol>
 					</li>
 					<li>
 						<p><strong>Maintenance</strong></p>
 						<p>While Lessor will be responsible for routine maintenance, Individual Tenant is responsible for reporting maintenance concerns. Lessor will provide electrical power, heat, air-conditioning and water and maintain these utilities under controllable conditions. Individual Tenants must understand that, as a condition of their tenancy under the Lease, Lessor shall not be responsible or liable for any damage or loss to Individual Tenant's personal property while in the Apartment Unit or the Apartment Building caused by the cessation or failure of such utilities. Moreover, Lessor will not be in breach of the Lease if such utility service is suspended for any reason.</p>
 					</li>
 					<li>
 						<p><strong>Repairs</strong></p>
 						<p>Requests for repairs should be made in writing to Lessor's on site representative. If the repair is not made within a reasonable amount of time, a second request should be submitted by Individual Tenant.</p>
 					</li>
 					<li>
 						<p><strong>Prohibited Items in the Building</strong></p>
 						<p>Some examples of items not permitted in the Apartment Building or any Apartment Unit are listed here; however, this list is not necessarily all-inclusive: animals (except service and comfort animals as permitted under applicable law), non-fused extension cords, outside antennas, bread machines, candles, incense, ceiling fans, chain locks, dead-bolt locks, explosives, firearms, fireworks, gasoline and other combustible liquids, hot pots, immersion coils, oil lamps, open flames, space heaters, torchiere-style (pole) halogen lamps, waterbeds and weapons. Live cut Christmas trees are not permitted in the Apartment Building or any Apartment Unit except with the prior written consent of Lessor.</p>
 					</li>
 					<li>
 						<p><strong>Unit Changes</strong></p>
 						<p>Individual Tenants may not move from one Apartment Unit to another without prior written consent from Lessor which consent may be withheld in Lessor's sole discretion. Violation of this requirement is a violation of the Lease which may result in termination or in a charge to Individual Tenant in an amount equal to one-month's rent under the Lease, and the failure of Individual Tenant to pay such charge by the deadline indicated by Lessor will result in the termination of the Lease.</p>
 					</li>
 					<li>
 						<p><strong>Safety and Security</strong></p>
 						<p>Lessor cannot guarantee the safety and security of Individual Tenants, and their Authorized Occupants, guests and invitees. Individual Tenants are responsible for their personal security and that of their belongings within the Apartment Unit and the Apartment Building.</p>
 						<ol>
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
 					</li>
 					<li>
 						<p><strong>Smoke-Free</strong></p>
 						<p>The Apartment Unit and the Apartment Building are smoke-free, unless expressly authorized by Landlord. Tenants and their guests must refrain from smoking at any time they are physically present in the Apartment Unit and other parts of the Apartment Building.</p>
 					</li>
 					<li>
 						<p><strong>Storage</strong></p>
 						<p>Lessor does not provide storage for use by Individual Tenants unless specified on the Quarters website for the Apartment Building. Nothing may be stored in any area outside of Individual Tenant's Apartment Unit.</p>
 					</li>
 					<li>
 						<p><strong>Capacity Numbers</strong></p>
 						<p>Based on fire safety no Individual Tenant shall exceed the maximum legal capacity of any Apartment Unit or his or her exclusive use Bedroom. Individual Tenants and their Authorized Occupants may not have assemblages or parties within their Apartment Units, or elsewhere in the Apartment Building except with the prior written consent of Lessor.</p>
 					</li>
 					<li>
 						<p><strong>Decorations Policy</strong></p>
 						<p>Individual Tenants are permitted to decorate their Apartment Units as long as they adhere to the following policies:</p>
 						<ol>
 							<li>Smoke detectors, sprinklers, fire alarms and light fixtures must remain uncovered. Tenants must not drape or attach decorations to these items.</li>
 							<li>Decorations must not obstruct hallways, fire exits, exit signs and access to fire safety equipment.</li>
 							<li>All light bulbs and light strings generate enough heat to ignite paper and cloth. Individual Tenants must ensure that light bulbs and light strings do not come into contact with anything flammable.</li>
 							<li>The use of string lights in public areas is prohibited.</li>
 							<li>No crimping of cords may occur, or no cords shall be placed under doorways or windows.</li>
 							<li>For everyone's safety, lights must be turned off when the area is unattended.</li>
 							<li>Use of live garland, greenery, wreaths, leaves, twigs, bamboo, branches, hay or sand as decoration is prohibited. Floors must not be covered with any material other than carpet or rugs.</li>
 						</ol>
 					</li>
 					<li>
 						<p><strong>Painting Rooms</strong></p>
 						<p>Individual Tenants and their Authorized Occupants may not paint their rooms in any other color, or add murals or border designs to their Apartment Unit walls or ceilings, including their exclusive use Bedrooms.</p>
 					</li>
 					<li>
 						<p><strong>Quiet Hours, Noise, Vibration and Odors</strong></p>
 						<p>No Individual Tenant shall make or permit any disturbing noises, vibration, odors or conduct activities in the Apartment Unit or the Apartment Building, nor do or permit anything by such persons that will constitute a nuisance to or interfere with the rights, comforts, or convenience of other Individual Tenants, Authorized Occupants, and their guess and invitees. No musical instruments, television, radio, CD player, videogames, loud speakers or similar devices shall be used in Individual Tenant's Apartment Unit between the hours of 10:00 PM and 8:00 AM. if the same shall disturb or annoy any other occupant of the Apartment Unit or the Apartment Building. No construction, repair work or other installation by Individual Tenant that involves noise or vibrations shall be conducted except on weekdays, excluding legal holidays, and only between the hours of 9:00 a.m. to 5:00 p.m.</p>
 					</li>
 					<li>
 						<p><strong>Substance-Free</strong></p>
 						<p>Smoking is not permitted anywhere in the Apartment Unit, the Apartment Building or immediately in front of the Apartment Building, unless expressly authorized by Landlord.</p>
 						<p>Moderate and lawful consumption of alcohol is permitted within the Apartment Unit and in common areas of the Apartment Building designated for social activities and gathering of Individual Tenants and their Authorized Occupants.</p>
 					</li>
 					<li>
 						<p><strong>Bicycles</strong></p>
 						<p>Individual Tenants and their Authorized Occupants, guests and invitees must store their bicycles in the Individual Tenant's Apartment Unit or in areas of the Apartment Building designated for bicycle storage, if any. Bicycles may not be left in the lobby, hallways, laundry room, maintenance rooms or any other common area of the Apartment Building.</p>
 					</li>
 					<li>
 						<p><strong>No AIRBNB or Other Short Term Rentals.</strong></p>
 						<p>Marketing any Apartment Unit or exclusive use Bedroom on Airbnb, Craigslist, Couchsurfer (and/or any similar marketing websites, media and/or services) or permitting the Apartment Unit or exclusive use Bedroom to be used for a short term rental, is strictly prohibited.</p>
 					</li>
 					<li>
 						<p><strong>Costs of Enforcement</strong></p>
 						<p>In the event legal action is required to enforce the provisions of these House Rules or the Lease, Lessor shall have the right to seek damages and/or equitable remedies (including eviction of the Individual Tenant and his or her Authorized Occupants) through the New York Superior Court, and in such event the prevailing party shall be entitled to recover reasonably incurred attorneys' fees and other related costs.</p>
 					</li>
 					<li>
 						<p><strong>Move-in and Move-out Times</strong></p>
 						<p>Move-in times are between 4pm - 8pm. Move-out must occur until 12pm on the last day of the Lease Agreement.</p>
 					</li>
 					<li>
 						<h4>CODE OF CONDUCT FOR ALL RESIDENTS</h4>
 						<ol>
 							<li>In order for you to have a pleasant experience in your apartment share with, you must abide by and accept the principles of cohabitation. This includes consideration, tolerance, and a willingness to compromise amongst each other as well as the neighbors. All Residents must organize amongst each other how to maintain their cohabitation fairly and with consideration of the interests of all Residents.</li>
 							<li>Residents may enjoy general community spaces and community facilities at {$contract_info->rental_address} buildings, which are not located in Individual Apartments. Amongst others and depending on availability, such may include bars, dining rooms, movie theatres, laundry rooms, outside areas, or reading corners. Enjoyment of such facilities is only permitted to Residents of the building. Without consent of the Owner or Manager, family Residents, friends, or visitors do not have the right to enjoy community spaces or facilities.</li>
 							<li>Guests and invitees are expected to abide by this Code and all other rules and regulations. Residents are responsible for the behavior of his/her guests and invitees, including restitution for damages caused by such Resident’s guests and invitees. Extended visits (i.e., more than 3 consecutive days, or more than 5 days in any 2-week period) are not permitted.</li>
 							<li>Individuals observed in the hall who are not Residents or their Authorized Occupants, guests or invitees that are not properly registered should be reported immediately to OWNERS’ representative or the police. All individuals who are not Residents or their Authorized Occupants, guests or invitees staying in the Apartment Building beyond a reasonable time for visitation constitute trespassers and may be removed with or without police assistance. No Resident shall allow any guest or invitee to stay overnight in any Common Area of the Apartment Building.</li>
 							<li>In order to avoid disturbing neighbors and other Residents, large private gatherings in the Apartment or the Building are generally prohibited. Everyone should be able to study, work or sleep undisturbed in their rooms if they wish. Therefore, you should not make or permit any disturbing noises, vibration, odors or conduct activities in the Apartment Unit or the Apartment Building, nor do or permit anything by such persons that will constitute a nuisance to or interfere with the rights, comforts, or convenience of the neighbors, other Residents and their guests and invitees. Noisy parties in the Apartment Building are generally prohibited. All loud activities should be decreased to room level volume by 10:00pm. Special care must be taken to avoid any noise disturbance between between 10:00pm and 8:00am. Loud noise is strictly forbidden on Sundays and the holidays. Stereos, televisions, etc. are to be operated at room level volume. Playing instruments during daytime hours, between 7:00pm and 8:00am is generally forbidden. Instruments should not be played for longer than two hours during the rest of the day.</li>
 							<li>In order to avoid disturbing neighbors and other Residents, large private gatherings in the Apartment or the Building are generally prohibited. Everyone should be able to study, work or sleep undisturbed in their rooms if they wish. Therefore, you should not make or permit any disturbing noises, vibration, odors or conduct activities in the Apartment Unit or the Apartment Building, nor do or permit anything by such persons that will constitute a nuisance to or interfere with the rights, comforts, or convenience of the neighbors, other Residents and their guests and invitees. Noisy parties in the Apartment Building are generally prohibited. All loud activities should be decreased to room level volume by 10:00pm. Special care must be taken to avoid any noise disturbance between between 10:00pm and 8:00am. Loud noise is strictly forbidden on Sundays and the holidays. Stereos, televisions, etc. are to be operated at room level volume. Playing instruments during daytime hours, between 7:00pm and 8:00am is generally forbidden. Instruments should not be played for longer than two hours during the rest of the day.</li>
 							<li>Residents and their Authorized Occupants' will follow NYC leash laws and all dogs must be on leash with their owner whenever they are walking through the common hallway. Dogs are not allowed in any of the common areas including roof deck.</li>
 							<li>Keep your Apartment and the Common Areas clean and uncluttered. Residents are responsible for routine cleaning and maintaining order in all Common Areas, such as hallways and stairwells. This includes removal of personal trash (ex: trash bags, pizza boxes, etc.) to a trash bin or dumpster and recycling as provided, according to the Statute Law of the city. You should break down cardboard boxes that you dispose of in the recycling areas. Any kind of rubbish, food rests, oils or other objects that could clog the drainage system should not be rinsed down the drainpipes - especially in the bath, kitchen and toilet. These objects are to be disposed of in the intended garbage containers. In case of non- compliance with these rules, you may be charged a fee for the removal of your personal trash from Common Areas in the Apartment Building.</li>
 							<li>Residents and their Authorized Occupants must store their bicycles in the areas designated for bicycle storage, if any. Bicycles may not be left in the lobby, hallways, laundry room, maintenance rooms or any other Common Areas of the Apartment Building.</li>
 							<li>The storage of hazardous, flammable or strong smelling substances on the property is not allowed. Some examples of items not permitted in the Apartment Building or any Apartment Unit are listed here; however, this list is not necessarily all-inclusive: animals (except service and comfort animals as permitted under applicable law), non-fused extension cords, outside antennas, bread machines, candles, incense, ceiling fans, chain locks, dead-bolt locks, explosives, firearms, fireworks, gasoline and other combustible liquids, hot pots, immersion coils, oil lamps, open flames, multi-plug adapters, cube adapters, unfused power strips or items such as air fresheners that include an outlet on them, space heaters, torchiere-style (pole) halogen lamps, waterbeds and weapons. Live cut Christmas trees are not permitted in the Apartment Building or any Apartment Unit.</li>
 							<li>We have absolutely no lenience towards illegal drugs. The possession or consumption of any illegal substance are strictly forbidden at the property. Smoking is also prohibited anywhere in the Apartment Unit, the Apartment Building or immediately in front of the Apartment Building. Moderate and lawful consumption of alcohol is permitted within the Apartment Unit and in common areas of the Apartment Building designated for social activities and gathering of Residents and their Authorized Occupants.</li>
 							<li>No Resident is allowed to remove, change or bring any furniture, fixtures, equipment, appliances and other property into the Common Areas of the Apartment Building. Attaching pictures, shelves, etc. with nails, screws or screw anchors, as weil as posting signs or inscriptions of any sort within the Apartments and the Common Rooms is strictly forbidden.</li>
 							<li>We have the doorbell nameplates standardly lettered with the building address, to insure the postal deliveries. The lettering on the mailboxes is not to be altered. lt's sufficient if you simply use the property’s address and your unit number to receive mail. Attaching personalized signs, warnings, etc. is only allowed if previously authorized by Management.</li>
 							<li>Pay your Rent and other charges on time and by the first working day of every month. This saves us and you a lot of stress. You will find the accepted forms and conditions of payment in your Lease.</li>
 							<li>Inform us of damages to the property as soon as possible. This will ensure your liability exclusion if you did not cause the damage. Requests for repairs should be made via the portal that Management provides. lf the repair is not made within a reasonable amount of time, a second request should be submitted. Residents are responsible for any damage or loss caused or non-routine cleaning or trash removal required to the common areas of the Apartment Building and their furnishings, including vending machines and other equipment placed in the Apartment Building as a convenience to Residents and Authorized Occupants. Common areas outside of Apartment Units include corridors, recreation rooms, kitchens, study rooms, living rooms, laundry rooms, public bathrooms and lounges. When damage occurs, Residents will be billed directly for the repairs. We shall have the authority to assess and assign charges for these damages. lf the responsible party for the damages cannot be determined, charges for damages, cleaning, replacement of furniture, etc. may be charged to all of the Residents of an apartment unit. lf one or more Residents or their Authorized Occupants assume responsibility for damages, cleaning, replacement of furniture, etc., a written statement signed by the responsible party must be noted in writing and delivered to us at the time of surrendering occupancy. Charges will not be assessed to one Resident based solely on another Resident’s claim of wrongdoing.</li>
 							<li>We will be responsible for routine maintenance, Residents are responsible for reporting maintenance concerns. We will provide electrical power, heat and water and maintain these utilities under controllable conditions. Management, as well as the gas or water supply service companies, must be informed immediately in case of leakage or other defects. lf a gas smell is noticed do not enter the room with open light and do not operate any electronic switches or devices. Open the windows and seal the man stopcock immediately. Residents must understand that, as a condition of their tenancy, we shall not be responsible or liable for any damage or loss to Resident’s personal property while in the Apartment Building caused by the cessation or failure of such utilities, no matter the reason. Moreover, we will not be in breach of the Lease if such utility service is suspended for any reason.</li>
 							<li>We cannot guarantee the safety and security of Residents and their Authorized Occupants, guests and invitees. Residents are responsible for their personal security and that of their belongings within the Apartment Building. For your and the other Residents safety, the entrance doors to the Apartment Building are to be closed between 10:00pm and 06:00am. Stairs, halls and entrances must remain accessible between 10:00pm and 06:00am to be used as escape routes in case of emergency.</li>
 							<li>Residents and their Authorized Occupants may not engage in any activity which creates a safety risk or which jeopardizes the security of the Apartment Building or other Residents and their Authorized Occupants. For safety reasons the roofs, porches, fire escapes, window ledges, unfinished attics and mechanical equipment rooms of the Apartment Building are restricted areas and may not be accessed. Grilling and barbeques are only allowed in the facilities available in the Apartment Building for that purpose, if applicable.</li>
 						</ol>
 					</li>
 				</ul>
 				<p>I have read all of this lease rider as well as my lease agreement and I understand my responsibilities as a Tenant. I am willing to abide by these rules.</p>
 			</li>
 		</ol>
 		<p>By initialing below, you acknowledge and agree to the terms in Section 7.</p>

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
		<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree9" for="agree9">I agree and sign</label><input type="checkbox" id="agree9" name="agree9" class="agree" value="1"></p>
		{/if} 
 	</li>

	<li>
		{include file='contracts/bx/rider_accommodations.tpl'}
	</li>

 	<li>
 		<h1>Fee Catalog</h1>
 		<ol>
 			<li>
 				<h4>Fee Catalog</h4>
 				<p>Rider - Fee Catalog</p>
 				<p>FEE CATALOG - 186N6 Owner LLC</p>
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
						<td>Smoking (room/shared spaces) – each incident</td>
						<td>$300.00</td>
					</tr>
					<tr>
						<td>Electric Socket replacement + Labor</td>
						<td>$75.00</td>
					</tr>
					<tr>
						<td>Minor Kitchen Appliances (Coffee Maker, Toaster, Electric Kettle, etc.)</td>
						<td>$100.00</td>
					</tr>
					<tr>
						<td>Microwave</td>
						<td>$400.00</td>
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
 	</li>
 	{if $contract_info->rider_type == 1}
		{include file='free_rent_doc/free_rent_month.tpl'}
	{elseif $contract_info->rider_type == 3}
		{include file='free_rent_doc/rider_earlymovein.tpl'}
	{elseif $contract_info->rider_type == 2 && $contract_info->free_rental_amount != 0}
 	<li>
		{include file='free_rent_doc/free_rent.tpl'}
		<p>By initialing below, you acknowledge and agree to the terms in Section 9.</p>

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
		<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree14" for="agree14">I agree and sign</label><input type="checkbox" id="agree14" name="agree14" class="agree" value="1"></p>
		{/if} 
	</li>
 	{/if}

 	<li>
 		<h1>Sign and Accept</h1>
 		<ol>
 			<li>
 				<h4>THIS LEASE SHALL NOT BE BINDING UNLESS EXECUTED BY BOTH LANDLORD AND TENANT.</h4>
 				<h3>TO CONFIRM OUR AGREEMENTS, OWNER AND YOU RESPECTIVELY SIGN THIS LEASE AS OF THE DAY AND YEAR FIRST WRITTEN ON PAGE 1.</h3>
 				<p>Your tenants will add their signature here.</p>
 			</li>
 		</ol>
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
{if $contract_info->signing == 1}
	DATE: {$contract_info->date_signing|date}<br/>
{/if}
</p>

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

{if $booking->client_type_id == 2 && $booking->airbnb_reservation_id}
		<p>Digital Signature ID: {$booking->airbnb_reservation_id}</p>
		{elseif $contract_info->signature2}
	<img src="{$contract_info->signature2}" alt="Signature {$contract_user->name|escape}" width="180" />
{/if} 

<br><br>

<hr>

<br>
<br>
<br>

<h1>Window Guard Notification and Disclosure</h1>

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
{if $contract_info->signature}
<ul>
	<li>[{if $contract_info->options['children']==1}x{else} {/if}] CHILDREN 10 YEARS OF AGE OR YOUNGER LIVE IN MY APARTMENT UNIT</li>
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
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree10" for="agree10">I agree and sign</label><input type="checkbox" id="agree10" name="agree10" class="agree" value="1"></p>
{/if} 


<br>

<br>

<hr>

<br>
<br>
<br>

<div class="center">
	<p><strong>NOTICE TO TENANT</strong></p>
	<h1>DISCLOSURE OF BEDBUG INFESTATION HISTORY</h1>
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
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree11" for="agree11">I agree and sign</label><input type="checkbox" id="agree11" name="agree11" class="agree" value="1"></p>
{/if} 

<br>
<br>

<hr>

<br>
<br>
<br>

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
<p><i>{$contract_user->first_name|truncate:1:""}. {$contract_user->last_name|truncate:1:""}.</i><br><label id="block_agree12" for="agree12">I agree and sign</label><input type="checkbox" id="agree12" name="agree12" class="agree" value="1"></p>
{/if} 

<br>

<hr>

<br>
<br>
<br>

<h1>Smoke Detector Acknowledgement</h1>

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

{if $contract_info->signature}
<p>TENANT NAME: {$contract_user->name|escape}<br/>
{if $booking->client_type_id != 2}
{if $contract_info->signing == 1}
	DATE: {$contract_info->date_signing|date}<br/>
{/if}
	SIGNATURE:<br>
{/if}
</p>
<img src="{$contract_info->signature}" alt="Signature {$contract_user->name|escape}" width="180" />
{/if}

