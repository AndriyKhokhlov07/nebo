{* User Check *}
{$apply_button_hide=1 scope=parent}
{$members_menu=0 scope=parent}


{$meta_title='Authorization for background check' scope=parent}
{*{$js_include="design/`$settings->theme`/js/user_check.js?v1.0.5" scope=parent}*}

{$javascripts[]="design/`$settings->theme`/js/user_check.js?v1.0.11" scope=parent}

{if $smarty.get.success=='sended'}
<div class="page v_signed">
{else}
<div class="main_width">
{/if}
	{*<h1 class="bold_h1_new">Authorization for background check</h1>*}
	{if $invoicefee}
		{$steps_count = 3}
    	{$next_step_link = "/order/{$invoicefee->url}?u={$user->id}"}
	{elseif $contract->price_deposit > 0 && $contract->outpost_deposit == 0}
    	{$next_step_link = "/hellorented/{$user->auth_code}?c={$contract->id}"}
    {elseif $contract->price_deposit > 0 && $contract->outpost_deposit == 1}
    	{$next_step_link = "order/{$deposit_invoice->url}?u={$user->id}"}
    {else}
    	{$next_step_link = "/thank-you"}
    {/if}
    <!-- if ($smarty.get.success=='sended' && $contract->interval < 365) || $smarty.get.add_docs=='sended' -->
	{if ($smarty.get.success=='sended' && $contract->interval < 180) || $smarty.get.add_docs=='sended'}
				<div class="info">
					<h1 class="bold_h1_new center">Thank You!</h1>
					<p class="center"></p>
				</div>
			<br>
			<div class="txt">
				{if $contract}
					{$active_step=1}
					{$steps_type='bg_check'}
					
					{include file='bx/steps_apps.tpl'}
				{/if}
				<p class="center">Questions? Contact Outpost Club Inc at <a href="mailto:info@outpost-club.com">info@outpost-club.com</a> or call at <a href="tel:+18337076611">+1 (833) 707-6611</a>.</p>
			</div>
		</div>
	{elseif $smarty.get.success=='sended' && $contract->interval >= 180}
	<h1 class="bold_h1_new">Additional documents</h1>
	<div class="txt">
		<p>In order to verify your employment, we are requesting:</p>
		<ul>
			<li>Your two most recent bank statements</li>
			<li>Your three most recent pay stubs</li>
			<li>The first 2 pages of your tax return/W2</li>
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
			{*
			<div class="step fx c">
				<a href="{$next_step_link}" class="button2" >Add this docs later</a>
			</div>
			*}
		</form>
	</div><!-- user_check -->
	{else}
	<h1 class="bold_h1_new">Rental Application</h1>
	<div class="user_check hl_checklist">
		<form method="post" name="rental_application" enctype="multipart/form-data">

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
				<input class="radio_h" id="us_citizen_1" type="radio" name="us_citizen" required value="1"{if $user->us_citizen==1} checked{/if} >
				<input class="radio_h" id="us_citizen_2" type="radio" name="us_citizen" required value="2"{if $user->us_citizen==2} checked{/if}>

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


				<div class="content_block1 visible v1">

					<div class="padd_bx">
						
						<div class="input_block">
							<div class="fx ch3">
								{*
								<div class="input_wrapper">
									<label for="state" class="req">Employment status</label>
									<div class="select_block">
										<select {if $user->us_citizen==1}class="required"{/if} id="state" name="employment_status" data-required>
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
									<label for="social_number" class="req">Social Security Number</label>
									<input class="inp_i{if $user->us_citizen==1} required{/if}" id="social_number" type="text" name="social_number" value="{$user->social_number}" placeholder="123-45-6789" data-required>
								</div>
								<div class="input_wrapper">
									<label for="driver_license">Driver License</label>
									<input class="inp_i" id="driver_license" type="text" name="blocks[driver_license]" value="{$user->blocks['driver_license']}" placeholder="">
								</div>

								<div class="input_wrapper">
									<label for="zip" class="req">ZIP Code</label>
									<input class="inp_i{if $user->us_citizen==1} required{/if}" id="zip" type="text" name="zip" value="{$user->zip|escape}" placeholder="01234" data-required>
								</div>
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
														<option value="{$state_code}"{if $user->state_code==$state_code} selected{/if}>{$state_name}</option>
													{/foreach}
												</select>
											</div><!-- select_block -->
										</div>

										<div class="input_wrapper state_bx2">
											<label for="state2">State</label>
											<input class="inp_i" id="state2" type="text" name="blocks[state]" value="{$user->blocks['state']|escape}" placeholder="New York">
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

							<!-- если контракт индивидуальный на комнату и меньше 12 месяцев -->
							{if ($contract->interval < 180 && $contract->reserv->type == 1) || !$contract}
							

							{else}
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
							{/if}
						</div><!-- input_block -->
					</div><!-- padd_bx info_block -->


					<div class="padd_bx">
						{*<div class="input_block">
							<div class="fx ch2">
								<div class="input_wrapper">
									<label for="state" class="req">Employment status</label>
									<div class="inp_i select_block{if $user->us_citizen==1} required{/if}">
										<select {if $user->us_citizen==1}class="required"{/if} id="state" name="employment_status" data-required>
											<option value="" disabled{if !$user->employment_status} selected{/if}>- Select status -</option>
											<option value="1"{if $user->employment_status==1} selected{/if}>Employed</option>
											<option value="2"{if $user->employment_status==2} selected{/if}>Student</option>
											<option value="3"{if $user->employment_status==3} selected{/if}>Retired</option>
											<option value="4"{if $user->employment_status==4} selected{/if}>Other</option>
										</select>
									</div><!-- select_block -->
								</div>
								<div class="input_wrapper">
									<label for="employment_income" class="req">Employment income</label>
									<input class="inp_i{if $user->us_citizen==1} required{/if}" id="employment_income" type="number" name="employment_income" value="{$user->employment_income}" placeholder="" data-required data-pattern="{literal}[\d]*{/literal}" data-pattern1="{literal}[1-9][0-9]+{/literal}">
									<div class="unit">$/month</div>
								</div>
							</div><!-- fx -->
						</div><!-- input_block -->*}
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
									<label class="req" for="annual_income">Income amount</label>
									<input class="inp_i required" id="annual_income" type="text" name="employment_income" value="{$user->employment_income|escape}" placeholder="" data-required data-pattern="{literal}[\d]*{/literal}" data-pattern1="{literal}[1-9][0-9]+{/literal}">
									<div class="unit">$/month</div>
								</div>

								
							</div><!-- fx -->

							{if ($contract->interval < 180 && $contract->reserv->type == 1) || !$contract}
							{else}
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
									<label {if $user->us_citizen!=2}class="req"{/if} for="emplloyer">Employer</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="emplloyer" type="text" name="blocks[emplloyer]" value="{$user->blocks['emplloyer']|escape}" placeholder="" data-required>
								</div>
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="job_phone">Phone</label>
									<input class="inp_i{if $user->us_citizen!=2} required{/if}" id="job_phone" type="text" name="blocks[job_phone]" value="{$user->blocks['job_phone']|escape}" placeholder="" data-required>
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
							{/if}
						</div><!-- input_block -->
					</div><!-- padd_bx -->

				</div><!-- content_block1 v3 -->
				<div class="content_block1 v1">
					<div class="padd_bx">
					<div class="input_block">
						<div class="fx ch3">
							<div class="input_wrapper">
								<label class="req" for="usa_doc">Passport / ID / Driver licence</label>
								<div class="inp_i file_block">
									<div class="preview_block{if $user->files && $user->files['usa_doc']} active{/if}">
										<img {if $user->files && $user->files['usa_doc']}src="{$config->users_files_dir}{$user->id}/{$user->files['usa_doc']}"{/if}>
										<i class="delete fa fa-times-circle"></i>
									</div>
									<div class="select_file">
										<input {if $user->us_citizen==1 && (!$user->files || !$user->files['usa_doc'])}class="required"{/if} id="usa_doc" type="file" name="usa_doc" data-required-file>
										<div class="title"><i class="fa fa-upload"></i> Upload a photo of your doc</div>
									</div>
								</div><!-- file_block -->
							</div>
							<div class="input_wrapper">
								<label class="req" for="usa_selfie">Selfie with doc</label>
								<div class="inp_i file_block">
									<div class="preview_block{if $user->files && $user->files['usa_selfie']} active{/if}">
										<img {if $user->files && $user->files['usa_selfie']}src="{$config->users_files_dir}{$user->id}/{$user->files['usa_selfie']}"{/if}>
										<i class="delete fa fa-times-circle"></i>
									</div>
									<div class="select_file">
										<input {if $user->us_citizen==1 && (!$user->files || !$user->files['usa_selfie'])}class="required"{/if} id="usa_selfie" type="file" name="usa_selfie" data-required-file>
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
							<p>In connection with my rental application, I hereby authorize and direct Ne-Bo Services Corp., either itself or through a third-party consumer reporting agency, to obtain “consumer reports” about me including information concerning my character, general reputation, personal characteristics, mode of living, and credit history/standing. The consumer report may include, but is not limited to: social security number verification; criminal records, verification of prior; and credit reports.</p>
							<p>Selection criteria that may result in denial of my rental application includes: criminal history, previous rental history, credit history, or failure to provide accurate or complete information on the application form.</p>
							<p>I agree the Ne-Bo Services Corp. may rely on this form to order background reports throughout my tenancy without asking me for my authorization again as allowed by law. I also agree that a copy of this form is valid like the signed original.</p>
							<p>Signing this acknowledgment indicates that you have had the opportunity to review the landlord's tenant selection criteria. The tenant selection criteria may include factors such as criminal history, credit history, current income, and rental history. If you do not meet the selection criteria, or if you provide inaccurate or incomplete information, your application may be rejected and your application fee will not be refunded.</p>
						</div>
						Outpost Club Inc. (Outpost Club) is a duly licensed real estate broker in the State of New York. Your trust is important to us. We respect your privacy and protect it with strict policies that govern how your information is handled. The Rental Application fee is non-refundable and you, the tenant applicant, are not entitled to a refund if your application is denied. Outpost Club and the landlord reserve the right to deny any rental application. By completing the rental application and the application fee, you authorize Outpost Club to use any third-party services to investigate your credit, employment and tenant history. You have been advised that you have the right under section 606(b) of the Fair Credit Reporting Act to make a written request for a complete and accurate disclosure of the nature and scope of any investigation. You have read, understand, and agree to the terms set forth in this notice.
					</div><!-- padd_bx info_block -->


					<div class="padd_bx">
						<div class="input_wrapper ch_item">
							<input {if $user->us_citizen==1}class="required"{/if} type="checkbox" name="to_check" id="to_check" value="1"{if $user->checker_options && $user->checker_options['to_check']==1} checked{/if} data-required>
							<div class="inp_i ch_bx">
								<label for="to_check" class="req">
									I agree to the processing of personal data.
								</label>
							</div>
						</div>

						<div class="ch_item">
							<input type="checkbox" name="california_app" id="california_app" value="1"{if $user->checker_options && $user->checker_options['california_app']==1} checked{/if}>
							<div class="ch_bx">
								<label for="california_app">
									California Applicants: Check if you would like a free copy of your background check report.
								</label>
							</div>
						</div>

						<div class="ch_item">
							<input type="checkbox" name="washington_app" id="washington_app" value="1"{if $user->checker_options && $user->checker_options['washington_app']==1} checked{/if}>
							<div class="ch_bx">
								<label for="washington_app">
									Washington State applicants or employees: You also have the right to request from the consumer reporting agency a written summary of your rights and remedies under the Washington Fair Credit Reporting Act.
								</label>
							</div>
						</div>

					</div>

					
					
				</div><!-- content_block1 v1 -->

				<div class="content_block1 v2">
					<div class="padd_bx">
					<div class="input_block">
						<div class="fx ch3">
							<div class="input_wrapper">
								<label class="req" for="visa">Upload a photo of your Visa</label>
								<div class="inp_i file_block">
									<div class="preview_block{if $user->files && $user->files['visa']} active{/if}">
										<img {if $user->files && $user->files['visa']}src="{$config->users_files_dir}{$user->id}/{$user->files['visa']}"{/if}>
										<i class="delete fa fa-times-circle"></i>
									</div>
									<div class="select_file">
										<input {if $user->us_citizen==2 && (!$user->files || !$user->files['visa'])}class="required"{/if} id="visa" type="file" name="visa" data-required-file>
										<div class="title"><i class="fa fa-upload"></i> Upload a photo of your visa</div>
									</div>
								</div><!-- file_block -->
							</div>

							{*
							<div class="input_wrapper">
								<label class="req" for="passport">Upload a photo of your passport</label>
								<div class="inp_i file_block">
									<div class="preview_block{if $user->files && $user->files['passport']} active{/if}">
										<img {if $user->files && $user->files['passport']}src="{$config->users_files_dir}{$user->id}/{$user->files['passport']}"{/if}>
										<i class="delete fa fa-times-circle"></i>
									</div>
									<div class="select_file">
										<input id="passport" type="file" name="passport" data-required-file{if $user->us_citizen==2 && (!$user->files || !$user->files['passport'])} required{/if}>
										<div class="title"><i class="fa fa-upload"></i> Upload a photo of your passport</div>
									</div>
									<p class="fl_note">The first page with information</p>
								</div><!-- file_block -->
							</div>
							*}
							

							<div class="input_wrapper">
								<label class="req" for="selfie">Selfie with doc</label>
								<div class="inp_i file_block">
									<div class="preview_block{if $user->files && $user->files['selfie']} active{/if}">
										<img {if $user->files && $user->files['selfie']}src="{$config->users_files_dir}{$user->id}/{$user->files['selfie']}"{/if}>
										<i class="delete fa fa-times-circle"></i>
									</div>
									<div class="select_file">
										<input {if $user->us_citizen==2 && (!$user->files || !$user->files['selfie'])}class="required"{/if} id="selfie" type="file" name="selfie" data-required-file>
										<div class="title"><i class="fa fa-upload"></i> Upload a photo of your selfie</div>
									</div>
								</div><!-- file_block -->
							</div>
						</div>
						<p>To upload proof of your United States Visa, lay it on a flat, well-lit surface and take a photo of the front. Please make sure it's high-resolution and not blurry, otherwise we can't accept it.</p>
					</div><!-- input_block -->
					</div>
					<div class="padd_bx">
						<div class="input_wrapper ch_item">
							<input {if $user->us_citizen==2}class="required"{/if} type="checkbox" name="to_check_not_us" id="to_check_not_us" value="1"{if $user->checker_options && $user->checker_options['to_check']==1} checked{/if} data-required>
							<div class="inp_i ch_bx">
								<label for="to_check_not_us" class="req">
									I agree to the processing of personal data.
								</label>
							</div>
						</div>
					</div>
				</div><!-- content_block1 v2 -->

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





