<!DOCTYPE html>
{*
    Общий вид страницы
    Этот шаблон отвечает за общий вид страниц без центрального блока.
*}
<html lang="en">
<head>



    <base href="{$config->root_url}/"/>
    <title>{$meta_title|escape}</title>
    
    {* Метатеги *}
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="description" content="{$meta_description|escape}" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <meta name="robots" content="noindex, nofollow">

    <link href="design/{$settings->theme|escape}/fonts/fa/font-awesome.min.css?v4.7.0" rel="stylesheet">
    <link href="design/{$settings->theme|escape}/css/rental.css?v1.0.19" rel="stylesheet">
    
    {literal}
	<script>
		(function() {
			window.print();
		})();
	</script>
	{/literal}
</head>
<body data-type="{$contract_info->type}" id="body">

{if $smarty.get.success=='sended'}
	<div class="page v_signed">
{else}
	<div class="main_width">
{/if}
		
		<div class="company_header">
			<div class="cont">
				<img class="logo_b" src="/design/{$settings->theme|escape}/images/logo_b.svg" alt="{$settings->company_name}">

				<p>Outpost Club Inc and Outpost Brokerage Inc are part of Outpost Group, which provides property management services in the states of New York, New Jersey and California. Should you have any questions, please feel free to call <a href="tel:+18337076611" target="_blank">+1 (833) 707-6611</a> or email <a href="mailto:info@outpost-club.com" target="_blank">info@outpost-club.com</a></p>
				<p>The registered address of Outpost Club Inc is P.O. 780316 Maspeth, NY, 11378<br>
				The registered address of Outpost Brokerage Inc is P.O. 780316 Maspeth, NY, 11378</p>


			</div>
		</div><!-- company_header -->
	<h1 class="bold_h1">Rental Application</h1>
	
	<div class="user_check hl_checklist">
		<form method="post" name="rental_application" enctype="multipart/form-data">


			<div class="content_block1 visible">
				<div class="padd_bx prop_info">

					<div class="input_block">
						<div class="fx ch3">
							<div class="input_wrapper">
								<div class="label_title">Property Address</div>
								<div class="val_bx">{$user->booking->house->blocks2['address']|escape}</div>
							</div>
							<div class="input_wrapper">
								<div class="label_title">Apartment</div>
								<div class="val_bx">{$user->booking->apartment->name|escape}</div>
							</div>
							{if $user->price_month > 0}
							<div class="input_wrapper">
								<div class="label_title">Monthly Rent</div>
								<div class="val_bx">$ {$user->price_month*1}</div>
							</div>	
							{/if}					
						</div>

					

						{*
						<div class="fx ch2">
							<div class="input_wrapper">
								<div class="label_title">Showed by</div>
								<div class="val_bx">Test</div>
							</div>
							<div class="input_wrapper">
								<div class="label_title">Date</div>
								<div class="val_bx">Aug 8, 2020</div>
							</div>							
						</div>
						*}


						<div class="fx ch3">
							<div class="input_wrapper">
								<div class="label_title">Move-in Date</div>
								<div class="val_bx">{$user->booking->arrive|date}</div>
							</div>	

							<div class="input_wrapper">
								<div class="label_title">Length of Lease</div>
								<div class="val_bx">
									{if $user->booking->calculate->lease_term}
										{$user->booking->calculate->lease_term} {$user->booking->calculate->lease_term|plural:'month':'months'}
									{else}
										{$user->booking->calculate->days} {$user->booking->calculate->days|plural:'day':'days'}
									{/if}
								</div>
							</div>

							<div class="input_wrapper">
								<div class="label_title">Total number of occupants</div>
								<div class="val_bx">{$user->booking->users_count}</div>
							</div>	

						</div>
					</div><!-- input_block -->


				</div><!-- padd_bx -->
			</div><!-- content_block1 -->




			<div class="input_block">
				<div class="fx ch3">
					<div class="input_wrapper">
						<label class="req" for="first_name">First name</label>
						<input class="inp_i required" id="first_name" type="text" name="first_name" value="{$user->first_name|escape}" data-pattern="{literal}[\w\s]{2,}{/literal}">
					</div>
					<div class="input_wrapper">
						<label for="middle_name">Middle name</label>
						<input id="middle_name" type="text" name="middle_name" value="{$user->middle_name|escape}">
					</div>
					<div class="input_wrapper">
						<label class="req" for="last_name">Last name</label>
						<input class="inp_i required" id="last_name" type="text" name="last_name" value="{$user->last_name|escape}" data-pattern="{literal}[\w\s]{2,}{/literal}">
					</div>
				</div>
			</div><!-- input_block -->


			<div class="input_block">
				<div class="fx ch2">
					<div class="input_wrapper">
						<label for="phone" class="req">Cell Phone</label>
						<input class="inp_i required" id="phone" type="text" name="phone" value="{$user->phone|escape}" data-required>
					</div>
					<div class="input_wrapper">
						<label for="email" class="req">Email</label>
						<input class="inp_i required" id="email" type="text" name="email" value="{$user->email|escape}" data-required disabled>
					</div>
					
				</div>
			</div><!-- input_block -->


			<div class="input_block">
				<div class="fx ch2">
					<div class="input_wrapper">
						<label class="req">Date of Birth</label>
						<div class="inp_i fx ch3_m10">

							<div>
								<div class="select_block">
									<select class="required" name="birth_month">
										<option value="0" disabled{if !$user->birthday|date_format:"%m"} selected{/if}>Month</option>
										{section name=for loop=12}
											<option value="{$smarty.section.for.iteration}"{if $smarty.section.for.iteration==$user->birthday|date_format:"%m"} selected{/if}>{$smarty.section.for.iteration}</option>
										{/section}
									</select>
								</div><!-- select_block -->
							</div>

							<div>
								<div class="select_block">
									<select class="required" name="birth_day">
										<option value="0" disabled{if !$user->birthday|date_format:"%d"} selected{/if}>Day</option>
										{section name=for loop=31}
											<option value="{$smarty.section.for.iteration}"{if $smarty.section.for.iteration==$user->birthday|date_format:"%d"} selected{/if}>{$smarty.section.for.iteration}</option>
										{/section}
									</select>
								</div><!-- select_block -->
							</div>

							<div>
								<div class="select_block">
									{$year = $smarty.now|date_format:"%Y"}
									{$min_age = 18}
									{$max_age = 90}
									{$year = $year - $min_age}
									<select class="required" name="birth_year">
										<option value="0" disabled{if !$user->birthday|date_format:"%Y"} selected{/if}>Year</option>
										{section name=for loop=$max_age-$min_age}
											<option value="{$year}"{if $year==$user->birthday|date_format:"%Y"} selected{/if}>{$year}</option>
		        							{$year = $year-1}
										{/section}
									</select>
								</div><!-- select_block -->
							</div>

						</div><!-- fx  ch3 -->

						<!-- <div class="req_info hide">Select Date of Birth</div> -->
						
					</div>


					<div class="input_wrapper">
						<label for="gender" class="req">Gender</label>
						<div class="select_block">
							<select class="required" id="gender" name="gender">
								<option value="0" disabled{if !$user->gender} selected{/if}>Choose</option>
								<option value="1"{if $user->gender==1} selected{/if}>Female</option>
								<option value="2"{if $user->gender==2} selected{/if}>Male</option>
								<option value="3"{if $user->gender==3} selected{/if}>Other</option>
							</select>
						</div>
					</div>

					
				</div><!--  fx ch2  -->
			</div><!-- input_block -->


			<div class="check_wrapper">
				<input class="radio_h" id="us_citizen_1" type="radio" name="us_citizen" value="1"{if $user->us_citizen==0 || $user->us_citizen==1} checked{/if}>
				<input class="radio_h" id="us_citizen_2" type="radio" name="us_citizen" value="2"{if $user->us_citizen==2} checked{/if}>

				<div class="input_block">
					<div class="fx ch2">
						<div class="radio_h_bx">
							<label class="req">Are you a U.S. citizen / Permanent Resident?</label>

							<div class="radio_buttons">
								<label for="us_citizen_1">Yes</label>
								<label for="us_citizen_2">No</label>
							</div><!-- radio_buttons -->
						</div>
					</div>
				</div><!-- input_block -->
			



			

			



				<div class="content_block1 v1 visible">

					<div class="padd_bx">
						<div class="input_block">
							<div class="fx ch3">
								{*
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="state">Employment status</label>
									<div class="select_block">
										<select {if $user->us_citizen!=2}class="required"{/if} id="state" name="employment_status" data-required>
											<option value="">- Select status -</option>
											<option value="1"{if $user->employment_status==1} selected{/if}>Employed</option>
											<option value="2"{if $user->employment_status==2} selected{/if}>Student</option>
											<option value="3"{if $user->employment_status==3} selected{/if}>Retired</option>
											<option value="4"{if $user->employment_status==4} selected{/if}>Other</option>
										</select>
									</div><!-- select_block -->
								</div>
								*}

								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="social_number">Social Security Number</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="social_number" type="text" name="social_number" value="{$user->social_number}" placeholder="123-45-6789" data-required>
								</div>

								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="driver_license">Driver License</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="driver_license" type="text" name="blocks[driver_license]" value="{$user->blocks['driver_license']}" placeholder="" data-required>
								</div>

								<div class="input_wrapper">
										<label {if $user->us_citizen!=2}class="req"{/if} for="zip">ZIP Code</label>
										<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="zip" type="text" name="zip" value="{$user->zip|escape}" placeholder="" data-required>
								</div>
								
							</div><!-- fx -->
							<p class="info_txt"> Your information is protected using encryption</p>
						</div><!-- input_block -->
						


					</div><!-- padd_bx -->

					

		

					
					<div class="padd_bx info_block">
						<p class="title">Current Address</p>


						<div class="input_block">
							<div class="fx ch2">
								<div class="fx ch2_m10">

									<div class="state_block">

										<div class="input_wrapper state_bx1">
											<label {if $user->us_citizen!=2}class="req"{/if} for="state">State</label>
											<div class="inp_i select_block">
												<select {if $user->us_citizen!=2}class="required"{/if} id="state" name="state_code" data-required>
													<option value="">- Select State -</option>
													{foreach $states as $state_code=>$state_name}
														<option value="{$state_code}"{if $user->state_code==$state_code} selected{/if}>{$state_name}</option>
													{/foreach}
												</select>
											</div><!-- select_block -->
										</div>

										<div class="input_wrapper state_bx2">
											<label for="state2">State</label>
											<input class="inp_i" id="state2" type="text" name="blocks[state]" value="{$user->blocks['state']|escape}" placeholder="New York" data-required>
										</div>

									</div><!-- state_block -->



									<div class="input_wrapper">
										<label {if $user->us_citizen!=2}class="req"{/if} for="city">City</label>
										<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="city" type="text" name="city" value="{$user->city|escape}" placeholder="New York" data-required data-pattern="{literal}[A-Za-z0-9\s\.\-\(\)'`,]{3,}{/literal}">
										<p class="info_txt">3 character minimum</p>
									</div>
								</div>


								
								<div class="fx ch2_1">
									<div class="input_wrapper">
										<label {if $user->us_citizen!=2}class="req"{/if} for="street_address">Address</label>
										<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="street_address" type="text" name="street_address" value="{$user->street_address|escape}" placeholder="" data-required data-pattern="{literal}[A-Za-z0-9\s\.\-\(\)'`,]{3,}{/literal}">
									</div>

									<div class="input_wrapper">
										<label for="apartment">Apartment</label>
										<input class="inp_i" id="apartment" type="text" name="apartment" value="{$user->apartment|escape}" placeholder="">
									</div>
								</div>

							</div><!-- fx -->
							{*
							<div class="fx ch2">
								<div class="fx ch2_m10">
									<div class="input_wrapper">
										<label {if $user->us_citizen!=2}class="req"{/if} for="zip">ZIP Code</label>
										<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="zip" type="text" name="zip" value="{$user->zip|escape}" placeholder="" data-required>
									</div>
								</div><!-- fx -->
							</div><!-- fx -->
							*}


							<div class="fx ch2">
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="lived_period">How long have you lived at your current address</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="lived_period" type="text" name="blocks[lived_period]" value="{$user->blocks['lived_period']|escape}" placeholder="12 months" data-required>
								</div>
								<div class="fx ch2 ch1_2">
									<div class="input_wrapper">
										<label {if $user->us_citizen!=2}class="req"{/if} for="pets">Number of pets</label>
										<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="pets" type="text" name="blocks[pets]" value="{$user->blocks['pets']|escape}" placeholder="" data-required>
									</div>

									<div class="input_wrapper">
										<label {if $user->us_citizen!=2}class="req"{/if} for="pets_breeds">Pets – Specify breeds</label>
										<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="pets_breeds" type="text" name="blocks[pets_breeds]" value="{$user->blocks['pets_breeds']|escape}" placeholder="" data-required>
									</div>
								</div><!-- fx -->
							</div><!-- fx -->

							<div class="fx ch2">
								<div class="fx ch2_m10">
									<div class="input_wrapper">
										<label {if $user->us_citizen!=2}class="req"{/if} for="reason_for_moving">Reason for moving</label>
										<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="reason_for_moving" type="text" name="blocks[reason_moving]" value="{$user->blocks['reason_moving']|escape}" placeholder="" data-required>
									</div>
									<div class="input_wrapper">
										<label {if $user->us_citizen!=2}class="req"{/if} for="current_monthly_payments">Current monthly payments</label>
										<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="current_monthly_payments" type="text" name="blocks[current_monthly_payments]" value="{$user->blocks['current_monthly_payments']|escape}" placeholder="" data-required>
									</div>
								</div><!-- fx -->

								<div class="fx ch2_m10">
									<div class="input_wrapper">
										<label {if $user->us_citizen!=2}class="req"{/if} for="rent">Rent</label>
										<div class="select_block">
											<select {if $user->us_citizen!=2}class="required"{/if} id="rent" name="blocks[rent]" data-required>
												<option value="">- Not selected -</option>
												<option value="1"{if $user->blocks['rent']==1} selected{/if}>Yes</option>
												<option value="2"{if $user->blocks['rent']==2} selected{/if}>No</option>
											</select>
										</div><!-- select_block -->
									</div>
									<div class="input_wrapper">
										<label {if $user->us_citizen!=2}class="req"{/if} for="mortgage">Mortgage</label>
										<div class="select_block">
											<select {if $user->us_citizen!=2}class="required"{/if} id="mortgage" name="blocks[mortgage]" data-required>
												<option value="">- Not selected -</option>
												<option value="1"{if $user->blocks['mortgage']==1} selected{/if}>Yes</option>
												<option value="2"{if $user->blocks['mortgage']==2} selected{/if}>No</option>
											</select>
										</div><!-- select_block -->
									</div>
								</div><!-- fx -->

							</div><!-- fx -->


							<div class="fx ch3">

								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="current_landlord">Current Landlord</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="current_landlord" type="text" name="blocks[current_landlord]" value="{$user->blocks['current_landlord']|escape}" placeholder="" data-required>
								</div>

								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="current_landlord_address">Their Address</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="current_landlord_address" type="text" name="blocks[cl_address]" value="{$user->blocks['cl_address']|escape}" placeholder="" data-required>
								</div>

								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="current_landlord_phone">Phone</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="current_landlord_phone" type="text" name="blocks[cl_phone]" value="{$user->blocks['cl_phone']|escape}" placeholder="" data-required>
								</div>

							</div><!-- fx / ch3 -->


							<hr>

							<p class="title">Previous Address</p>

							<div class="fx ch2">
								<div class="fx ch2_m10">
									<div class="input_wrapper">
										<label {if $user->us_citizen!=2}class="req"{/if} for="previous_state">State</label>
										<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="previous_state" type="text" name="blocks[prev_state]" value="{$user->blocks['prev_state']|escape}" placeholder="" data-required>
									</div>
									<div class="input_wrapper">
										<label {if $user->us_citizen!=2}class="req"{/if} for="previous_city">City</label>
										<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="previous_city" type="text" name="blocks[prev_city]" value="{$user->blocks['prev_city']|escape}" placeholder="" data-required>
									</div>
								</div>

								<div class="fx ch2_1">
									<div class="input_wrapper">
										<label {if $user->us_citizen!=2}class="req"{/if} for="previous_address">Address</label>
										<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="previous_address" type="text" name="blocks[prev_address]" value="{$user->blocks['prev_address']|escape}" placeholder="" data-required>
									</div>

									<div class="input_wrapper">
										<label for="previous_apartment">Apartment</label>
										<input id="previous_apartment" type="text" name="blocks[prev_apartment]" value="{$user->blocks['prev_apartment']|escape}" placeholder="">
									</div>
								</div>

							</div><!-- fx -->

							<div class="fx ch2">
								<div class="fx ch2_m10">
									<div class="input_wrapper">
										<label {if $user->us_citizen!=2}class="req"{/if} for="previous_zip">ZIP Code</label>
										<input class="inp_i input_zip{if $user->us_citizen!=2} required{/if}" id="previous_zip" type="text" name="blocks[prev_zip]" value="{$user->blocks['prev_zip']|escape}" placeholder="" data-required>
									</div>
								</div><!-- fx -->
							</div><!-- fx -->




							<div class="fx ch3">

								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="previous_landlord">Previous Landlord</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="previous_landlord" type="text" name="blocks[prev_landlord]" value="{$user->blocks['prev_landlord']|escape}" placeholder="" data-required>
								</div>

								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="previous_landlord_address">Their Address</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="previous_landlord_address" type="text" name="blocks[pl_address]" value="{$user->blocks['pl_address']|escape}" placeholder="" data-required>
								</div>

								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="previous_landlord_phone">Phone</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="previous_landlord_phone" type="text" name="blocks[pl_phone]" value="{$user->blocks['pl_phone']|escape}" placeholder="" data-required>
								</div>

							</div><!-- fx / ch3 -->


						</div><!-- input_block -->

					</div><!-- padd_bx info_block -->




					<div class="padd_bx">
						<div class="input_block">

							<div class="fx ch2">
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="state">Employment status</label>
									<div class="inp_i select_block{if $user->us_citizen!=2} required{/if}">
										<select {if $user->us_citizen!=2}class="required"{/if} id="state" name="employment_status" data-required>
											<option value="" disabled{if !$user->employment_status} selected{/if}>- Select status -</option>
											<option value="1"{if $user->employment_status==1} selected{/if}>Employed</option>
											<option value="2"{if $user->employment_status==2} selected{/if}>Student</option>
											<option value="3"{if $user->employment_status==3} selected{/if}>Retired</option>
											<option value="4"{if $user->employment_status==4} selected{/if}>Other</option>
										</select>
									</div><!-- select_block -->
								</div>

								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="emplloyer">Emplloyer</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="emplloyer" type="text" name="blocks[emplloyer]" value="{$user->blocks['emplloyer']|escape}" placeholder="" data-required>
								</div>
								
							</div><!-- fx -->


							<div class="fx ch2">
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="job_title">Job title</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="job_title" type="text" name="blocks[job_title]" value="{$user->blocks['job_title']|escape}" placeholder="" data-required>
								</div>
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="worked_period">How long have you worked there</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="worked_period" type="text" name="blocks[worked_period]" value="{$user->blocks['worked_period']|escape}" placeholder="" data-required>
								</div>
								
							</div><!-- fx -->

							<div class="fx ch2">
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="work_address">Work Address</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="work_address" type="text" name="blocks[work_address]" value="{$user->blocks['work_address']|escape}" placeholder="" data-required>
								</div>
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="supervisor">Supervisor</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="supervisor" type="text" name="blocks[supervisor]" value="{$user->blocks['supervisor']|escape}" placeholder="" data-required>
								</div>
								
							</div><!-- fx -->

							<div class="fx ch2">
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="job_phone">Phone</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="job_phone" type="text" name="blocks[job_phone]" value="{$user->blocks['job_phone']|escape}" placeholder="" data-required>
								</div>
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="annual_income">Income amount</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="annual_income" type="text" name="employment_income" value="{$user->employment_income|escape}" placeholder="" data-required data-pattern="{literal}[\d]*{/literal}" data-pattern1="{literal}[1-9][0-9]+{/literal}">
									<div class="unit">$/month</div>
								</div>
							</div><!-- fx -->

							<hr>


							<div class="fx ch2">
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="loan_payments">Alimony/Child support or Loan Payments</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="loan_payments" type="text" name="blocks[loan_payments]" value="{$user->blocks['loan_payments']|escape}" placeholder="" data-required>
								</div>
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="additional_income">Additional sources of income</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="additional_income" type="text" name="blocks[additional_income]" value="{$user->blocks['additional_income']|escape}" placeholder="" data-required>
								</div>
							</div><!-- fx -->


							<div class="fx ch3">
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="evicted">Have you been evicted</label>
									<div class="select_block">
										<select {if $user->us_citizen!=2}class="required"{/if} id="evicted" name="blocks[evicted]" data-required>
											<option value="">- Not selected -</option>
											<option value="1"{if $user->blocks['evicted']==1} selected{/if}>Yes</option>
											<option value="2"{if $user->blocks['evicted']==2} selected{/if}>No</option>
										</select>
									</div><!-- select_block -->
								</div>

								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="felony">Convicted of a felony</label>
									<div class="select_block">
										<select {if $user->us_citizen!=2}class="required"{/if} id="felony" name="blocks[felony]" data-required>
											<option value="">- Not selected -</option>
											<option value="1"{if $user->blocks['felony']==1} selected{/if}>Yes</option>
											<option value="2"{if $user->blocks['felony']==2} selected{/if}>No</option>
										</select>
									</div><!-- select_block -->
								</div>

								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="bankruptcy">Have you ever filed bankruptcy</label>
									<div class="select_block">
										<select {if $user->us_citizen!=2}class="required"{/if} id="bankruptcy" name="blocks[bankruptcy]" data-required>
											<option value="">- Not selected -</option>
											<option value="1"{if $user->blocks['bankruptcy']==1} selected{/if}>Yes</option>
											<option value="2"{if $user->blocks['bankruptcy']==2} selected{/if}>No</option>
										</select>
									</div><!-- select_block -->
								</div>

							</div><!-- fx -->							

						</div><!-- input_block -->
					</div><!-- padd_bx -->

				</div><!-- content_block1 v3 -->



				<div class="content_block1 bg_none v1">
					<div class="input_block">
						<div class="fx ch3">
							<div class="input_wrapper">
								<label class="req" for="usa_doc">Passport / ID / Driver licence</label>
								<div class="inp_i file_block">
									<div class="preview_block{if $user->files && $user->files['usa_doc']} active{/if}">
										{if $user->files && $user->files['usa_doc']}<img src="{$config->users_files_dir}{$user->id}/{$user->files['usa_doc']}">{/if}
									</div>
									<div class="select_file">
										<input {if $user->us_citizen==1 && (!$user->files || !$user->files['usa_doc'])}class="required"{/if} id="usa_doc" type="file" name="usa_doc" data-required-file>
									</div>
								</div><!-- file_block -->
							</div>
							<div class="input_wrapper">
								<label class="req" for="usa_selfie">Selfie with doc</label>
								<div class="inp_i file_block">
									<div class="preview_block{if $user->files && $user->files['usa_selfie']} active{/if}">
										{if $user->files && $user->files['usa_selfie']}<img src="{$config->users_files_dir}{$user->id}/{$user->files['usa_selfie']}">{/if}
									</div>
									<div class="select_file">
										<input {if $user->us_citizen==1 && (!$user->files || !$user->files['usa_selfie'])}class="required"{/if} id="usa_selfie" type="file" name="usa_selfie" data-required-file>
									</div>
								</div><!-- file_block -->
							</div>
						</div>
					</div><!-- input_block -->
				</div><!-- content_block1 v1 -->


				<div class="content_block1 bg_none v2">

					<div class="input_block">
						<div class="fx ch3">
							<div class="input_wrapper">
								<label class="req" for="visa">Upload a photo of your Visa</label>
								<div class="inp_i file_block">
									<div class="preview_block{if $user->files && $user->files['visa']} active{/if}">
										{if $user->files && $user->files['visa']}<img src="{$config->users_files_dir}{$user->id}/{$user->files['visa']}">{/if}
									</div>
									<div class="select_file">
										<input {if $user->us_citizen==2 && (!$user->files || !$user->files['visa'])}class="required"{/if} id="visa" type="file" name="visa" data-required-file>
									</div>
								</div><!-- file_block -->
							</div>

						
							

							<div class="input_wrapper">
								<label class="req" for="selfie">Selfie with doc</label>
								<div class="inp_i file_block">
									<div class="preview_block{if $user->files && $user->files['selfie']} active{/if}">
										{if $user->files && $user->files['selfie']}<img src="{$config->users_files_dir}{$user->id}/{$user->files['selfie']}">{/if}
									</div>
									<div class="select_file">
										<input {if $user->us_citizen==2 && (!$user->files || !$user->files['selfie'])}class="required"{/if} id="selfie" type="file" name="selfie" data-required-file>
									</div>
								</div><!-- file_block -->
							</div>
						</div>
						<p>To upload proof of your United States Visa, lay it on a flat, well-lit surface and take a photo of the front. Please make sure it's high-resolution and not blurry, otherwise we can't accept it.</p>
						<hr>
					</div><!-- input_block -->

				</div><!-- content_block1 v2 -->





				<div class="txt">
					<p>Outpost Brokerage Inc (Outpost Brokerage) is a part of Outpost Group, is a duly licensed real estate broker in the State of New York. Your trust is important to us. We respect your privacy and protect it with strict policies that govern how your information is handled. You have two days to complete all the necessary paperwork. The Rental Application fee is non-refundable and you’re not entitled to a refund if your application is denied. Outpost Brokerage Inc (Outpost Brokerage) and the landlord reserve the right to deny any rental application. Outpost Brokerage represents the apartment in an “AS IS” condition. I authorize Outpost Brokerage to use any third-party services to investigate my credit, employment and tenant history. I have been advised that I have the right under section 606(b) of the Fair Credit Reporting Act to make a written request for a complete and accurate disclosure of the nature and scope of any investigation. I have read, understand, and agree to the terms set forth in this agreement.</p>
					<br>
				</div>


				<div class="content_block2 txt">
					<h3 class="h1">Application requirements</h3>
					<ul>
						<li>Non-refundable application fee of $20 for each renter, payable to Outpost Club Inc.</li>
						<li>Signed Deposit Agreement and paid Application Deposit (equivalent to one month’s rent).</li>
						<li>Employment Verification (e.g. Employment Letter, Tax Return (eg. 1040/1099), Pay Stubs, Bank Statements.)</li>
						<li>A copy of each renter’s driver’s license or passport.</li>
					</ul>
					<p>Email your completed applications and supporting documents to your agent.</p>
				</div><!-- content_block2 -->


				<div class="ch_item">
					<input class="required" {if $signature}checked{/if} type="checkbox" name="processing_personal_data" id="processing_personal_data" value="1">
					<div class="ch_bx">
						<label for="processing_personal_data" class="req">
							I agree to the processing of personal data
						</label>
					</div>
				</div>
				<br>

				{if $signature}
					Signature:<br>
					<img src="{$signature}" alt="Signature {$user->name|escape}" width="180" />
				{/if}
			</div><!-- check_wrapper -->
			

		</form>
	</div><!-- user_check -->

</div>
</body>
</html>