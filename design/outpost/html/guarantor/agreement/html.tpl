<style>
.g_agreement,
.g_agreement p{
	font-family: 'Helvetica';
}
.g_agreement_head{
	margin: 0 0 40px;
}

.g_agreement_text p{
	text-indent: 30px;
}
.g_agreement_text p span{
	text-indent: 0;
}

.g_agreement .ga_val{
	border-bottom: #000 1px solid;
	font-weight: 600;
	padding: 0 15px;
}
.ga_val_name{
	min-width: 300px;
}
.g_agreement_bcont{
	margin: 10px 0;
}

.g_agreement .tt{
	width: 100%;
}
.g_agreement .tt td{
	vertical-align: bottom;
	padding: 10px 0;
}
.g_agreement .tt .pd{
	width: 40px;
}
.g_agreement .tt .sm{
	padding: 2px 0 0 15px;
}

{if $this_page=='pdf'}
.g_agreement,
.g_agreement .tt .sm{
	font-size: 12px;
	/*line-height: 1.4;*/
}
.g_agreement h1{
	font-size: 20px;
}
.g_agreement .ga_val{
	font-size: 13px;
}
{else}
.g_agreement,
.g_agreement .tt .sm{
	font-size: 15px;
	/*line-height: 1.4;*/
}
.g_agreement h1{
	font-size: 30px;
}
.g_agreement .ga_val{
	border-bottom-width: 2px;
	font-size: 16px;
}
@media (max-width: 600px){
	.g_agreement .tt,
	.g_agreement .tt tbody,
	.g_agreement .tt > tr,
	.g_agreement .tt > tbody > tr{
		display: block;
	}
	.g_agreement .tt > tr > td,
	.g_agreement .tt > tbody > tr > td{
		display: block;
		width: 100%;
	}
	.g_agreement .tt > tr > .pd,
	.g_agreement .tt > tbody > tr > .pd{
		display: none;
	}
}
{/if}
</style>

<div class="g_agreement">

	<div class="g_agreement_head">
		<h1 class="bold_h1_new">GUARANTOR AGREEMENT</h1>
		<p>This guaranty agreement (“Guaranty”) shall be deemed attached to and a part of the rental agreement {if $user->contract}dated <span class="ga_val">{$user->contract->date_created|date_format:"%m / %d / %Y"}</span>{/if} (“Lease”) between:</p>
		<br>
		<p>Owner: <span class="ga_val">{$user->llc_company->name|escape}</span> (along with the owner representative, collectively “Owners”), and</p>
		<p>Guarantor: <span class="ga_val">{$user->first_name|escape} {$user->middle_name|escape} {$user->last_name|escape}</span> (“Guarantor”) as the Guarantor for</p>
		<p>Tenant: <span class="ga_val">{$user->tenant->first_name|escape} {$user->tenant->middle_name|escape} {$user->tenant->last_name|escape}</span> (“Tenant”) for the rental of {if $user->booking->type==2 || 1}apartment{elseif $user->booking->type==1}room{/if} <span class="ga_val">{$user->booking->apartment->name|escape}</span> located</p>
		<p>Address: <span class="ga_val">{$user->booking->house->blocks2['address']}</span> (“{if $user->booking->type==2 || 1}Apartment{elseif $user->booking->type==1}Room{/if}”).</p>
	</div>
	<div class="g_agreement_text">
		<p>Guarantor is a co-signer and “guarantor” to the Lease for Tenant’s obligations thereunder. I have completed a guarantor application truthfully and honestly for the express purpose of enabling the owners to check my credit; and I authorize Owner, <span class="ga_val">Outpost Club Inc</span>., and their agents to verify my credit history and obtain any other information about me Owner deems necessary in determining my viability as a guarantor for Tenant. Should my personal information change during the application process, I shall promptly notify Owner.</p>
		<p>As Guarantor, I have no intention of occupying the {if $user->booking->type==2 || 1}Apartment{elseif $user->booking->type==1}Room{/if} and affirm that I have no possessory interest or right to the {if $user->booking->type==2 || 1}Apartment{elseif $user->booking->type==1}Room{/if}. Guarantor reviewed the Lease and agrees to be obligated to Owner for all of Tenant’s Lease obligations.</p>
		<p>Guarantor personally, and with Tenant jointly and severally, guarantees to Owner, Owner’s successors and assigns, the: i) payment of the rent and additional rents stated in in the Lease, without setoff or deduction; and ii) Tenant’s performance of all Tenant’s Lease obligations.</p>
		<p>Guarantor covenants and agrees that Guarantor shall not require any notice to Guarantor of nonpayment, or nonperformance, or proof, or notice of demand, to hold the undersigned responsible under this Guaranty, all of which the undersigned expressly waives. Guarantor expressly agrees that the legality of this Guaranty and obligations created herein shall not be ended or changed by reason of the claims by Owner against Tenant of the rights or remedies given to Owner under the Lease. Subject to the terms stated herein, Guarantor further agrees that this Guaranty shall remain and continue in full force and effect as to and during any renewal, change, or extension of the Lease and during any period when Tenant, its successors or assigns are occupying the premises under the Lease as a holdover Tenant. Guarantor expressly acknowledges that the Guaranty shall remain in full force and effect until Tenant vacates the {if $user->booking->type==2 || 1}Apartment{elseif $user->booking->type==1}Room{/if}, owing no arrears, and having satisfied all of Tenant’s Lease obligations.</p>
		<p>As a further inducement of Owner to enter into the Lease with Tenant, Guarantor agrees that all parties waive their right to a trial by jury in any action or proceeding brought by either party against the other on any matters concerning the Lease or of the Guaranty.</p>
		<p>This Guaranty shall be binding upon the Guarantor, its heirs, personal representatives, successors, and assigns.</p>
	</div>

	<div class="g_agreement_bcont">
		<table class="tt">
			{if $this_page=='pdf'}
			<tr>
				<td>
					<div class="ga_val">{$user->first_name|escape} {$user->middle_name|escape} {$user->last_name|escape}</div>
					<div class="sm">Guarantor name</div>
				</td>
				<td class="pd"></td>
				<td>
					<div class="ga_val"><img src="{$config->users_files_dir}{$user->id}/guarantor_agreement_signature.png" alt="Signature {$user->name|escape}" width="180"></div>
					<div class="sm">Guarantor Signature</div>
				</td>
			</tr>
			{/if}
			{*
			<tr>
				<td>
					<div class="ga_val">{$salesflow->application_data['street_address']|escape}, {$salesflow->application_data['city']|escape}, {if $salesflow->application_data['state_code']}{$salesflow->application_data['state_code']}{else}{$salesflow->application_data['state']|escape}{/if}, {$salesflow->application_data['zip']|escape}</div>
					<div class="sm">Address, City, State, Zip</div>
				</td>
				<td class="pd">&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td>
					<div class="ga_val">{$user->birthday|date_format:"%m / %d / %Y"}</div>
					<div class="sm">Date Of Birth</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="ga_val">{$user->phone|escape}</div>
					<div class="sm">Home Tel.</div>
				</td>
				<td class="pd"></td>
				<td>
					{if $salesflow->application_data['social_number']}
					<div class="ga_val">{$salesflow->application_data['social_number']|escape}</div>
					<div class="sm">SSN</div>
					{/if}
				</td>
			</tr>
			*}
		</table>
	</div>


	{*
	{if $this_page=='pdf'}
		<div class="g_agreement_text">
			<p>State of <span class="ga_val">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>  County of <span class="ga_val">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
			<p>On the <span class="ga_val">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> day of <span class="ga_val">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>, in year <span class="ga_val">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> before me, the undersigned, a notary public in and for said state, personally appeared to me and is personally known to me or proved to me on the basis of satisfactory evidence to be the individual whose name is subscribed to the within instrument and acknowledged to me the that he executed the same in his capacity, and that by his signature on the instrument, the individual acted, executed the instrument.</p>
			<br><br>
			<div style="width: 240px;">
				<div class="ga_val"></div>
				<div class="sm" style="font-size: 12px; text-align: center; padding: 2px 0 0;">Notary Public</div>
			</div>
		</div>
	{/if}
	*}
</div>
