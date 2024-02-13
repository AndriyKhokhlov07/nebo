{* User Check *}
{$apply_button_hide=1 scope=parent}
{$members_menu=0 scope=parent}
{$preloader=true scope=parent}


{$meta_title='Guarantor Application' scope=parent}


{$head_javascripts[]="js/heic2any.min.js" scope=parent}
{$javascripts[]="js/jquery.image-upload-resizer.js?v1.1.0" scope=parent}
{$javascripts[]="design/`$settings->theme`/js/user_check.js?v1.0.27" scope=parent}

{if $smarty.get.success=='sended'}
<div class="page v_signed">
{else}
<div class="main_width">
{/if}

	{if $smarty.get.success=='sended' && $smarty.get.add_docs!='sended'}
	<h1 class="bold_h1_new">Additional documents</h1>
	<div class="txt">
		<p>In order to verify your employment, we are requesting:</p>
		<ul>
			<li><strong>Tax Return:</strong> Most recent year, normally the summary pages (Gross Income).</li>
			<li><strong>Pay Stubs:</strong> Most recent 3 pay receipts/ payroll statements from job(s).</li>
			<li><strong>Bank Statements:</strong> Most recent 3 bank statements (especially balance summary). This should be the full downloaded PDF or physical document showing your name and address.</li>
			<li><strong>Proof of Income:</strong> Eg. A job offer letter, a letter from a supervisor on company letterhead, or an employment verification from an HR office. Should ideally include our name, position, and exact compensation. (For a freelancer or independent contractor, this could also be recent months’ invoices & payments and/or a business statement.)</li>
		</ul>
	</div>
	<div class="user_check hl_checklist">
		<form method="post" name="rental_application" enctype="multipart/form-data">

			<div class="input_block">
				<div class="fx ">
					<div class="input_wrapper w100">
						<div class="files_list fx w">
							{foreach $user_files as $f}
								<div class="item">
									<input type="hidden" name="delete_files[]">
									<div class="icon">
										<i class="icon fa fa-file-o"></i>
									</div><!-- icon -->
									<div class="cont">
										<div class="fx">
											<a class="filename" href="/{$config->users_files_dir}{$user->id}/files/{$f->filename}" target="_blank"{if in_array($f->ext, array('png', 'jpg', 'jpeg', 'pdf'))} data-fancybox="files"{/if} data-ext="{$f->ext}">{$f->filename}</a>
											<div class="file_info">{$f->size} &nbsp;&nbsp; {$f->date|date_format:'m/d/Y H:i:s'}</div>
										</div>
										<div class="del">
											<i class="fa fa-times-circle"></i>
										</div>
									</div><!-- cont -->
								</div>
							{/foreach}
						</div>

						<div class="inp_i file_block">
							<div id=dropZone class="select_file">
								<div id=dropMessage class="title"><i class="fa fa-upload"></i> Select/Drop files to upload</div>
								<input class="dropInput" type="file" name="dropped_files[]" multiple>
							</div>
							<div id="add_image"></div>
						</div>
						<p class="fx mb10">
							<button class="to_cancel_files_btn button cancel hide">Cancel</button>
							<button class="to_upload_files_btn button hide" type="submit" name="user_info" value="Save">Send files</button>
							<button class="to_remove_files_btn button hide" type="submit" name="user_info" value="Save">Apply remove files</button>
						</p>
					</div>
				</div>
			</div><!-- input_block -->
			{if $user_type=='guarantor'}
				{$active_step=1}
				{$steps_type='bg_check'}
				{include file='guarantor/bx/steps_apps.tpl'}
				{*
				<div class="step fx c">
					<a href="{$next_step_link}" class="button2" >Skip this step</a>
				</div>
				*}
			{/if}
		</form>
	</div><!-- user_check -->


	{elseif $smarty.get.success=='sended' && $smarty.get.add_docs=='sended'}
			<div class="info">
				<h1 class="bold_h1_new center">Thank You!</h1>
				<p class="center"></p>
			</div>
			<br>
			<div class="txt">

				{$active_step=1}
				{$steps_type='bg_check'}
				{* $next_step_link="{$config->root_url}/guarantor/agreement" *}

				{$next_step_link = "/order/{$invoicefee->url}?u={$user->id}"}
				{include file='guarantor/bx/steps_apps.tpl'}

				<p class="center">Questions? Contact Outpost Club Inc at <a href="mailto:info@outpost-club.com">info@outpost-club.com</a> or call at <a href="tel:+18337076611">+1 (833) 707-6611</a>.</p>
			</div>
		</div>
	
	{else}
	<h1 class="bold_h1_new">Guarantor Application</h1>
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



			<div class="input_block">
				<div class="fx ch2">
					<div class="input_wrapper">
						<label for="email" class="req">Email</label>
						<input class="inp_i required" id="email" type="text" name="email" value="{$user->email|escape}" required disabled>
					</div>
					<div class="input_wrapper">
						<label for="phone" class="req">Phone</label>
						<input class="inp_i required" id="phone" type="text" name="phone" value="{$user->phone|escape}" required__>
					</div>
				</div>
			</div><!-- input_block -->

			
			<div class="check_wrapper">


				<input class="radio_h" id="us_citizen_1" type="radio" name="us_citizen" required value="1"{if $user->us_citizen==0 || $user->us_citizen==1} checked{/if}>
				<input class="radio_h" id="us_citizen_2" type="radio" name="us_citizen" required value="2"{if $user->us_citizen==2} checked{/if}>

				<div class="input_block hide">
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


				<div class="content_block1 visible v1">

					<div class="padd_bx">
						
						<div class="input_block">


							<div class="fx ch3">
								<div class="input_wrapper">
									<label for="social_number" class="req">Social Security Number</label>
									<input class="inp_i{if $user->us_citizen==1} required{/if}" id="social_number" type="text" name="social_number" value="{$salesflow->application_data['social_number']}" placeholder="123-45-6789" data-required>
								</div>
								<div class="input_wrapper">
									<label for="driver_license">Driver License</label>
									<input class="inp_i" id="driver_license" type="text" name="blocks[driver_license]" value="{$salesflow->application_data['driver_license']}" placeholder="">
								</div>
								<div class="input_wrapper">
									<label for="zip" class="req">ZIP Code</label>
									<input class="inp_i{if $user->us_citizen==1} required{/if}" id="zip" type="text" name="zip" value="{$salesflow->application_data['zip']|escape}" placeholder="01234" data-required>
								</div>
							</div><!-- fx -->
							<div class="fx ch2">
								
							</div><!-- fx -->
							
							<p class="info_txt"><i class="fa fa-lock"></i> Your information is protected using encryption</p>
						</div><!-- input_block -->
					</div>

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
														<option value="{$state_code}"{if $salesflow->application_data['state_code']==$state_code} selected{/if}>{$state_name}</option>
													{/foreach}
												</select>
											</div><!-- select_block -->
										</div>

										<div class="input_wrapper state_bx2">
											<label for="state2">State</label>
											<input class="inp_i" id="state2" type="text" name="blocks[state]" value="{$salesflow->application_data['state']|escape}" placeholder="New York">
										</div>

									</div><!-- state_block -->



									<div class="input_wrapper">
										<label {if $user->us_citizen!=2}class="req"{/if} for="city">City</label>
										<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="city" type="text" name="city" value="{$salesflow->application_data['city']|escape}" placeholder="New York" data-required data-pattern="{literal}[A-Za-z0-9\s\.\-\(\)'`,]{3,}{/literal}">
										<p class="info_txt">3 character minimum</p>
									</div>
								</div>


								
								<div class="fx ch2_1">
									<div class="input_wrapper">
										<label {if $user->us_citizen!=2}class="req"{/if} for="street_address">Address</label>
										<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="street_address" type="text" name="street_address" value="{$salesflow->application_data['street_address']|escape}" placeholder="" data-required data-pattern="{literal}[A-Za-z0-9\s\.\-\(\)'`,]{3,}{/literal}">
									</div>

									<div class="input_wrapper">
										<label for="apartment">Apartment</label>
										<input class="inp_i" id="apartment" type="text" name="apartment" value="{$salesflow->application_data['apartment']|escape}" placeholder="">
									</div>
								</div>

							</div><!-- fx -->

							<div class="fx ch2">
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="lived_period">How long have you lived at your current address</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="lived_period" type="text" name="blocks[lived_period]" value="{$salesflow->application_data['lived_period']|escape}" placeholder="12 months" data-required>
								</div>

							</div><!-- fx -->

							<div class="fx ch2">
								
									<div class="input_wrapper">
										<label {if $user->us_citizen!=2}class="req"{/if} for="current_monthly_payments">Current monthly payments</label>
										<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="current_monthly_payments" type="text" name="blocks[current_monthly_payments]" value="{$salesflow->application_data['current_monthly_payments']|escape}" placeholder="" data-required>
									</div>
								

								<div class="fx ch2_m10">
									<div class="input_wrapper">
										<label {if $user->us_citizen!=2}class="req"{/if} for="rent">Rent</label>
										<div class="select_block">
											<select {if $user->us_citizen!=2}class="required"{/if} id="rent" name="blocks[rent]" data-required>
												<option value="">- Not selected -</option>
												<option value="1"{if $salesflow->application_data['rent']==1} selected{/if}>Yes</option>
												<option value="2"{if $salesflow->application_data['rent']==2} selected{/if}>No</option>
											</select>
										</div><!-- select_block -->
									</div>
									<div class="input_wrapper">
										<label {if $user->us_citizen!=2}class="req"{/if} for="mortgage">Mortgage</label>
										<div class="select_block">
											<select {if $user->us_citizen!=2}class="required"{/if} id="mortgage" name="blocks[mortgage]" data-required>
												<option value="">- Not selected -</option>
												<option value="1"{if $salesflow->application_data['mortgage']==1} selected{/if}>Yes</option>
												<option value="2"{if $salesflow->application_data['mortgage']==2} selected{/if}>No</option>
											</select>
										</div><!-- select_block -->
									</div>
								</div><!-- fx -->

							</div><!-- fx -->


							<div class="fx ch3">

								<div class="input_wrapper">
									<label for="current_landlord">Current Landlord</label>
									<input class="inp_i" id="current_landlord" type="text" name="blocks[current_landlord]" value="{$salesflow->application_data['current_landlord']|escape}" placeholder="">
								</div>

								<div class="input_wrapper">
									<label for="current_landlord_address">Their Address</label>
									<input class="inp_i" id="current_landlord_address" type="text" name="blocks[cl_address]" value="{$salesflow->application_data['cl_address']|escape}" placeholder="">
								</div>

								<div class="input_wrapper">
									<label for="current_landlord_phone">Phone</label>
									<input class="inp_i" id="current_landlord_phone" type="text" name="blocks[cl_phone]" value="{$salesflow->application_data['cl_phone']|escape}" placeholder="">
								</div>

							</div><!-- fx / ch3 -->


							<hr>

							<p class="title">Previous Address</p>

							<div class="fx ch2">
								<div class="fx ch2_m10">
									<div class="input_wrapper">
										<label for="previous_state">State</label>
										<input class="inp_i" id="previous_state" type="text" name="blocks[prev_state]" value="{$salesflow->application_data['prev_state']|escape}" placeholder="">
									</div>
									<div class="input_wrapper">
										<label for="previous_city">City</label>
										<input class="inp_i" id="previous_city" type="text" name="blocks[prev_city]" value="{$salesflow->application_data['prev_city']|escape}" placeholder="">
									</div>
								</div>

								<div class="fx ch2_1">
									<div class="input_wrapper">
										<label for="previous_address">Address</label>
										<input class="inp_i" id="previous_address" type="text" name="blocks[prev_address]" value="{$salesflow->application_data['prev_address']|escape}" placeholder="">
									</div>

									<div class="input_wrapper">
										<label for="previous_apartment">Apartment</label>
										<input id="previous_apartment" type="text" name="blocks[prev_apartment]" value="{$salesflow->application_data['prev_apartment']|escape}" placeholder="">
									</div>
								</div>

							</div><!-- fx -->

							<div class="fx ch2">
								<div class="fx ch2_m10">
									<div class="input_wrapper">
										<label for="previous_zip">ZIP Code</label>
										<input class="inp_i input_zip" id="previous_zip" type="text" name="blocks[prev_zip]" value="{$salesflow->application_data['prev_zip']|escape}" placeholder="">
									</div>
								</div><!-- fx -->
							</div><!-- fx -->

						</div><!-- input_block -->
					</div><!-- padd_bx info_block -->


					<div class="padd_bx">
						<div class="input_block">

							<div class="fx ch2">
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="state">Employment status</label>
									<div class="inp_i select_block{if $user->us_citizen!=2} required{/if}">
										<select {if $user->us_citizen!=2}class="required"{/if} id="state" name="employment_status" data-required>
											<option value="" disabled{if !$salesflow->application_data['employment_status']} selected{/if}>- Select status -</option>
											<option value="1"{if $salesflow->application_data['employment_status==1']} selected{/if}>Employed</option>
											<option value="2"{if $salesflow->application_data['employment_status==2']} selected{/if}>Student</option>
											<option value="3"{if $salesflow->application_data['employment_status==3']} selected{/if}>Retired</option>
											<option value="4"{if $salesflow->application_data['employment_status==4']} selected{/if}>Other</option>
										</select>
									</div><!-- select_block -->
								</div>
								<div class="input_wrapper">
									<label class="req" for="annual_income">Income amount</label>
									<input class="inp_i required" id="annual_income" type="text" name="employment_income" value="{$salesflow->application_data['employment_income']|escape}" placeholder="" data-required data-pattern="{literal}[\d]*{/literal}" data-pattern1="{literal}[1-9][0-9]+{/literal}">
									<div class="unit">$/month</div>
								</div>

								
							</div><!-- fx -->


							<div class="fx ch2">
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="job_title">Job title</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="job_title" type="text" name="blocks[job_title]" value="{$salesflow->application_data['job_title']|escape}" placeholder="" data-required>
								</div>
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="worked_period">How long have you worked there</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="worked_period" type="text" name="blocks[worked_period]" value="{$salesflow->application_data['worked_period']|escape}" placeholder="" data-required>
								</div>
								
							</div><!-- fx -->

							<div class="fx ch2">
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="work_address">Work Address</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="work_address" type="text" name="blocks[work_address]" value="{$salesflow->application_data['work_address']|escape}" placeholder="" data-required>
								</div>
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="supervisor">Supervisor</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="supervisor" type="text" name="blocks[supervisor]" value="{$salesflow->application_data['supervisor']|escape}" placeholder="" data-required>
								</div>
								
							</div><!-- fx -->

							<div class="fx ch2">
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="emplloyer">Employer</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="emplloyer" type="text" name="blocks[emplloyer]" value="{$salesflow->application_data['emplloyer']|escape}" placeholder="" data-required>
								</div>
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="job_phone">Phone</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="job_phone" type="text" name="blocks[job_phone]" value="{$salesflow->application_data['job_phone']|escape}" placeholder="" data-required>
								</div>
							</div><!-- fx -->

							<hr>


							<div class="fx ch2">
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="loan_payments">Alimony/Child support or Loan Payments</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="loan_payments" type="text" name="blocks[loan_payments]" value="{$salesflow->application_data['loan_payments']|escape}" placeholder="" data-required>
								</div>
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="additional_income">Additional sources of income</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="additional_income" type="text" name="blocks[additional_income]" value="{$salesflow->application_data['additional_income']|escape}" placeholder="" data-required>
								</div>
							</div><!-- fx -->


							<div class="fx ch3">
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="evicted">Have you been evicted</label>
									<div class="select_block">
										<select {if $user->us_citizen!=2}class="required"{/if} id="evicted" name="blocks[evicted]" data-required>
											<option value="">- Not selected -</option>
											<option value="1"{if $salesflow->application_data['evicted']==1} selected{/if}>Yes</option>
											<option value="2"{if $salesflow->application_data['evicted']==2} selected{/if}>No</option>
										</select>
									</div><!-- select_block -->
								</div>

								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="felony">Convicted of a felony</label>
									<div class="select_block">
										<select {if $user->us_citizen!=2}class="required"{/if} id="felony" name="blocks[felony]" data-required>
											<option value="">- Not selected -</option>
											<option value="1"{if $salesflow->application_data['felony']==1} selected{/if}>Yes</option>
											<option value="2"{if $salesflow->application_data['felony']==2} selected{/if}>No</option>
										</select>
									</div><!-- select_block -->
								</div>

								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="bankruptcy">Have you ever filed bankruptcy</label>
									<div class="select_block">
										<select {if $user->us_citizen!=2}class="required"{/if} id="bankruptcy" name="blocks[bankruptcy]" data-required>
											<option value="">- Not selected -</option>
											<option value="1"{if $salesflow->application_data['bankruptcy']==1} selected{/if}>Yes</option>
											<option value="2"{if $salesflow->application_data['bankruptcy']==2} selected{/if}>No</option>
										</select>
									</div><!-- select_block -->
								</div>

							</div><!-- fx -->							
						</div><!-- input_block -->
					</div><!-- padd_bx -->

				</div><!-- content_block1 v3 -->

				<div class="content_block1 v1_ visible">


					<div class="padd_bx">
					<div class="input_block">
						<div class="fx ch3">
							<div class="input_wrapper">
								<label class="req" for="usa_doc">Passport / ID / Driver licence</label>
								<div class="inp_i file_block">
									<div class="preview_block{if $salesflow->application_data['files'] && $salesflow->application_data['files']['usa_doc']} active{/if}">
										<img {if $salesflow->application_data['files'] && $salesflow->application_data['files']['usa_doc']}src="{$config->users_files_dir}{$user->id}/{$salesflow->application_data['files']['usa_doc']}"{/if}>
										<i class="delete fa fa-times-circle"></i>
									</div>
									<div class="select_file">
										<input {if $user->us_citizen==1 && (!$salesflow->application_data['files'] || !$salesflow->application_data['files']['usa_doc'])}class="required"{/if} id="usa_doc" type="file" name="usa_doc" data-required-file>
										<div class="title"><i class="fa fa-upload"></i> Upload a photo of your doc</div>
									</div>
								</div><!-- file_block -->
							</div>
							<div class="input_wrapper">
								<label class="req" for="usa_selfie">Selfie with doc</label>
								<div class="inp_i file_block">
									<div class="preview_block{if $salesflow->application_data['files'] && $salesflow->application_data['files']['usa_selfie']} active{/if}">
										<img {if $salesflow->application_data['files'] && $salesflow->application_data['files']['usa_selfie']}src="{$config->users_files_dir}{$user->id}/{$salesflow->application_data['files']['usa_selfie']}"{/if}>
										<i class="delete fa fa-times-circle"></i>
									</div>
									<div class="select_file">
										<input {if $user->us_citizen==1 && (!$salesflow->application_data['files'] || !$salesflow->application_data['files']['usa_selfie'])}class="required"{/if} id="usa_selfie" type="file" name="usa_selfie" data-required-file>
										<div class="title"><i class="fa fa-upload"></i> Upload a photo of your selfie</div>
									</div>
								</div><!-- file_block -->
							</div>
						</div>
					</div><!-- input_block -->
					</div><!-- padd_bx -->

					
					<div class="padd_bx info_block">
						<p class="title">Consent to background check</p>
						<div class="txt">
							<p>Outpost Club Inc. (Outpost Club) and Outpost Brokerage are the parts of Outpost Group, are duly licensed real estate brokers in the State of New York.</p>
							<p>Your trust is important to us. We respect your privacy and protect it with strict policies that govern how your information is handled. You have two days to complete all the necessary paperwork. The Rental Application fee is non-refundable and you’re not entitled to a refund if your application is denied.</p>
							<p>Outpost Club Inc. (Outpost Club) and the landlord reserve the right to deny any rental application. Outpost Club represents the apartment in an “AS IS” condition. I authorise Outpost Club. to use any third-party services to investigate my credit, employment and tenant history. I have been advised that I have the right under section 606(b) of the Fair Credit Reporting Act to make a written request for a complete and accurate disclosure of the nature and scope of any investigation. I have read, understand, and agree to the terms set forth in this agreement.</p>
						</div>
					</div><!-- padd_bx info_block -->		
				</div><!-- content_block1 v1 -->


				{if $signature}
					Signature:<br>
					<img src="{$signature}" alt="Signature {$user->name|escape}" width="180" />
				{else}
				<div class="signature_block" id="signature_block">
			      <p class="signature_title">Signature:</p>
			    	<div class="wrapper">
			    		<canvas id="signature-pad" class="signature-pad" width=460 height=240></canvas>
			    	</div>
			        <input id="signature" class="required" type="hidden" name="signature" value="">
			        <div class="button_block">
			            <div id="clear" class="clear">Clear</div>
			            <div id="save" class="save">Sign and Save</div>
			        </div>
			    </div><!-- signature_block -->
			    <div id="signature_img"></div>
				{/if}


			</div><!-- check_wrapper -->


			{*<button class="button red v2" type="submit">Submit</button>*}

		</form>
	</div><!-- user_check -->
<script type="text/javascript" src="design/{$settings->theme}/js/signature_pad.umd.js"></script>

	{literal}
	<script>
	$(function() {


	var signature = 0;
	var canvas = document.getElementById('signature-pad');

	function resizeCanvas() {
	    canvas.width = canvas.offsetWidth;
	    canvas.height = canvas.offsetHeight;
	}

	resizeCanvas();

	var signaturePad = new SignaturePad(canvas, {
	  backgroundColor: 'rgb(255, 255, 255)', // necessary for saving image as JPEG; can be removed is only saving as PNG or SVG
	  penColor: 'rgb(1, 31, 117)'
	});

	document.getElementById('save').addEventListener('click', function () {
		let f = VerifForm($('.user_check form'));
		console.log(f);

		if(f!=false){

			var body = document.getElementById('body');
		    // var type = body.getAttribute("data-type");

		    if(signaturePad.isEmpty())
		    {
		        return alert("Please provide a signature first");
		    }

		    // var el_page = document.getElementById('page');
		    // el_page.classList.add('sending');

		    var data = signaturePad.toDataURL('image/png');
		    var img_data = canvas.toDataURL('image/png');
		    document.getElementById('signature_img').innerHTML += '<img src="'+img_data+'" width="240" />';
		    document.getElementById('signature_block').hidden = true;
		    document.getElementById('signature').value = img_data;

		    signaturePad.clear();
		    delete data;
		    delete img_data;
		    delete signaturePad;
		    signature = 1;
		    delete canvas;
			$('.preloader').show();
		    document.forms["rental_application"].submit();
		}
	});

	document.getElementById('clear').addEventListener('click', function () {
		signaturePad.clear();
	});


	});
	</script>
	{/literal}


	{/if}
</div>





