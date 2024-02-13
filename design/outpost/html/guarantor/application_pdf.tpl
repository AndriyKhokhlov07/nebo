<style>
.page,
table{
	font-family: 'Helvetica';
	font-size: 10px;
	max-width: 800px;
}
h1{
	font-size: 20px;
	text-transform: uppercase;
}
.ts{
	/*background: #f5f5f5;*/
	border: #000 1px solid;
	width: 100%;
	padding: 5px;
	margin: 0 0 20px;
}
.ts td{
	padding: 5px;
}
.ts .t{
	font-weight: 300;
}
.ts .v{
	font-weight: 600;
	font-size: 13px;
	margin: 5px 0 0;
}
.tt{
	width: 100%;
}
.tt.w1_3{
	width: 33%;
}
.tt td{
	padding: 4px 6px;
}
.tt td.f{
	padding-left: 0;
}
.tt td.l{
	padding-right: 0;
}
.tt table{
	width: 100%;
}
.tt td td{
	padding: 2px;
}
.tt .t{
	white-space: nowrap;
	width: 10%;
	padding-left: 0;
}
.tt .v{
	border-bottom: #000 1px solid;
	font-weight: 600;
	font-size: 13px;
	padding-left: 4px;
}

.txt_b1{
	font-weight: 600;
	text-align: justify;
}
.signature_t{
	width: 70%;
	margin: 0 0 10px;
}
.signature_t td{
	vertical-align: bottom;
	padding-bottom: 0;
}
.signature_t .g_name td{
	padding-top: 0;
}
.signature_t .g_name td.t{
	text-align: center;
	padding-left: 98px;
}

.nowrap{
	white-space: nowrap;
}
.clear{
	clear: both;
}
</style>
<div class="page">
	

<img src="design/{$settings->theme|escape}/images/logo_b_382_56.png" alt="Outpost" width="150" height="22">

<p>Outpost Club Inc and Outpost Brokerage Inc are part of Outpost Group, which provides property management services in the states of New York, New Jersey and California. Should you have any questions, please feel free to call <span class="nowrap">+1 (833) 707-6611</span> or email <a href="mailto:info@outpost-club.com" target="_blank">info@outpost-club.com</a></p>
<p>The registered address of Outpost Club Inc is P.O. 780316 Maspeth, NY, 11378<br>
The registered address of Outpost Brokerage Inc is P.O. 780316 Maspeth, NY, 11378</p>
<br>

<h1>Guarantor Application</h1>

<table class="ts">
	<tr>
		<td>
			<div class="t">Property Address</div>
			<div class="v">{$user->booking->house->blocks2['address']|escape}</div>
		</td>
		<td>
			<div class="t">Apartment</div>
			<div class="v">{$user->booking->apartment->name|escape}</div>
		</td>
		<td>
			{if $user->price_month > 0}
				<div class="t">Monthly Rent</div>
				<div class="v">$ {$user->price_month*1}</div>
			{/if}	
		</td>
	</tr>
	<tr>
		<td>
			<div class="t">Move-in Date</div>
			<div class="v">{$user->booking->arrive|date}</div>
		</td>
		<td>
			<div class="t">Length of Lease</div>
			<div class="v">
				{if $user->booking->calculate->lease_term}
					{$user->booking->calculate->lease_term} {$user->booking->calculate->lease_term|plural:'month':'months'}
				{else}
					{$user->booking->calculate->days} {$user->booking->calculate->days|plural:'day':'days'}
				{/if}
			</div>
		</td>
		<td>
			<div class="t">Total number of occupants</div>
			<div class="v">{$user->booking->users_count}</div>
		</td>
	</tr>
</table>


<table class="tt">
	<tr>
		<td class="f"><table><tr><td class="t">First name:</td><td class="v">{$user->first_name|escape}</td></tr></table></td>
		{if $user->middle_name}
			<td><table><tr><td class="t">Middle name:</td><td class="v">{$user->middle_name|escape}</td></tr></table></td>
		{/if}
		<td class="l"><table><tr><td class="t">Last name:</td><td class="v">{$user->last_name|escape}</td></tr></table></td>
	</tr>
</table>
<table class="tt">
	<tr>
		<td class="f"><table><tr><td class="t">Email:</td><td class="v">{$user->email|escape}</td></tr></table></td>
		<td><table><tr><td class="t">Phone:</td><td class="v">{$user->phone|escape}</td></tr></table></td>
		<td class="l"><table><tr><td class="t">D.O.B.:</td><td class="v">{$user->birthday|date_format:"%m / %d / %Y"}</td></tr></table></td>
	</tr>
</table>
<table class="tt">
	<tr>
		<td class="f"><table><tr><td class="t">SSN:</td><td class="v">{$salesflow->application_data['social_number']}</td></tr></table></td>
		<td class="l"><table><tr><td class="t">Driver License #:</td><td class="v">{$salesflow->application_data['driver_license']}</td></tr></table></td>
	</tr>
</table>
<table class="tt">
	<tr>
		<td class="f"><table><tr><td class="t">Current Address:</td><td class="v">{$salesflow->application_data['street_address']|escape}</td></tr></table></td>
		<td><table><tr><td class="t">Apt #:</td><td class="v">{$salesflow->application_data['apartment']|escape}</td></tr></table></td>

		<td><table><tr><td class="t">City:</td><td class="v">{$salesflow->application_data['city']|escape}</td></tr></table></td>
		<td><table><tr><td class="t">State:</td><td class="v">{if $salesflow->application_data['state_code']}{$salesflow->application_data['state_code']}{else}{$salesflow->application_data['state']|escape}{/if}</td></tr></table></td>
		<td class="l"><table><tr><td class="t">Zip:</td><td class="v">{$salesflow->application_data['zip']|escape}</td></tr></table></td>
	</tr>
</table>
<table class="tt">
	<tr>
		<td class="f"><table><tr><td class="t">How long have you lived at your current address:</td><td class="v">{$salesflow->application_data['lived_period']|escape}</td></tr></table></td>
		<td><table><tr><td class="t">Current monthly payments:</td><td class="v">{$salesflow->application_data['current_monthly_payments']|escape}</td></tr></table></td>
		<td><table><tr><td class="t">Rent:</td><td class="v">{if $salesflow->application_data['rent']==1}Yes{elseif $salesflow->application_data['rent']==2}No{/if}</td></tr></table></td>
		<td class="l"><table><tr><td class="t">Mortgage:</td><td class="v">{if $salesflow->application_data['mortgage']==1}Yes{elseif $salesflow->application_data['mortgage']==2}No{/if}</td></tr></table></td>
	</tr>
</table>
<table class="tt">
	<tr>
		<td class="f"><table><tr><td class="t">Current Landlord:</td><td class="v">{$salesflow->application_data['current_landlord']|escape}</td></tr></table></td>
		<td><table><tr><td class="t">Their Address:</td><td class="v">{$salesflow->application_data['cl_address']|escape}</td></tr></table></td>
		<td class="l"><table><tr><td class="t">Phone:</td><td class="v">{$salesflow->application_data['cl_phone']|escape}</td></tr></table></td>
	</tr>
</table>
<table class="tt">
	<tr>
		<td class="f"><table><tr><td class="t">Previous Address:</td><td class="v">{$salesflow->application_data['prev_address']|escape}</td></tr></table></td>
		<td><table><tr><td class="t">Apt #:</td><td class="v">{$salesflow->application_data['prev_apartment']|escape}</td></tr></table></td>
		<td><table><tr><td class="t">City:</td><td class="v">{$salesflow->application_data['prev_city']|escape}</td></tr></table></td>
		<td><table><tr><td class="t">State:</td><td class="v">{$salesflow->application_data['prev_state']|escape}</td></tr></table></td>
		<td class="l"><table><tr><td class="t">Zip:</td><td class="v">{$salesflow->application_data['prev_zip']|escape}</td></tr></table></td>
	</tr>
</table>
<table class="tt">
	<tr>
		<td class="f"><table><tr><td class="t">Employer:</td><td class="v">{$salesflow->application_data['emplloyer']|escape}</td></tr></table></td>
		<td><table><tr><td class="t">Job title:</td><td class="v">{$salesflow->application_data['job_title']|escape}</td></tr></table></td>
		<td class="l"><table><tr><td class="t">How long have you worked there:</td><td class="v">{$salesflow->application_data['worked_period']|escape}</td></tr></table></td>
	</tr>
</table>
<table class="tt">
	<tr>
		<td class="f"><table><tr><td class="t">Work Address:</td><td class="v">{$salesflow->application_data['work_address']|escape}</td></tr></table></td>
		<td><table><tr><td class="t">Supervisor:</td><td class="v">{$salesflow->application_data['supervisor']|escape}</td></tr></table></td>
		<td class="l"><table><tr><td class="t">Phone:</td><td class="v">{$salesflow->application_data['job_phone']|escape}</td></tr></table></td>
	</tr>
</table>
<table class="tt w1_3">
	<tr>
		<td class="f"><table><tr><td class="t">Income amount:</td><td class="v">{$salesflow->application_data['employment_income']|escape}</td></tr></table></td>
	</tr>
</table>
<table class="tt">
	<tr>
		<td class="f"><table><tr><td class="t">Alimony/Child support or Loan Payments:</td><td class="v">{$salesflow->application_data['loan_payments']|escape}</td></tr></table></td>
		<td class="l"><table><tr><td class="t">Additional sources of income:</td><td class="v">{$salesflow->application_data['additional_income']|escape}</td></tr></table></td>
	</tr>
</table>
<table class="tt">
	<tr>
		<td class="f"><table><tr><td class="t">Have you been evicted:</td><td class="v">{if $salesflow->application_data['evicted']==1}Yes{elseif $salesflow->application_data['evicted']==2}No{/if}</td></tr></table></td>
		<td><table><tr><td class="t">Convicted of a felony:</td><td class="v">{if $salesflow->application_data['felony']==1}Yes{elseif $salesflow->application_data['felony']==2}No{/if}</td></tr></table></td>
		<td class="l"><table><tr><td class="t">Have you ever filed bankruptcy:</td><td class="v">{if $salesflow->application_data['bankruptcy']==1}Yes{elseif $salesflow->application_data['bankruptcy']==2}No{/if}</td></tr></table></td>
	</tr>
</table>

<br><br>

<div class="txt_b1">
	<p>Outpost Club Inc. (Outpost Club) is a duly licensed real estate broker in the State of New York. Your trust is important to us. We respect your privacy and protect it with strict policies that govern how your information is handled. The Rental Application fee is non-refundable and you, the tenant applicant, are not entitled to a refund if your application is denied. Outpost Club and the landlord reserve the right to deny any rental application. By completing the rental application and the application fee, you authorize Outpost Club to use any third-party services to investigate your credit, employment and tenant history. You have been advised that you have the right under section 606(b) of the Fair Credit Reporting Act to make a written request for a complete and accurate disclosure of the nature and scope of any investigation. You have read, understand, and agree to the terms set forth in this notice.</p>
</div>

<table class="tt signature_t">
	<tr>
		<td class="f"><table><tr><td class="t">Guarantor signature:</td><td class="v"><img src="{$config->users_files_dir}{$user->id}/rental_application_signature.png" alt="Signature {$user->name|escape}" width="180"></td></tr></table></td>

		<td class="l"><table><tr><td class="t">Date:</td><td class="v">{$user->sign_log->date|date_format:"%m / %d / %Y"}</td></tr></table></td>
	</tr>
	<tr class="g_name">
		<td class="t">{$user->first_name|escape} {$user->middle_name|escape} {$user->last_name|escape}</td>
		<td></td>
	</tr>
</table>



</div>
