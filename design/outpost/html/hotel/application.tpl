{* User Check *}
{$apply_button_hide=1 scope=parent}
{$members_menu=0 scope=parent}
{$preloader=true scope=parent}

{$meta_title='Pre Check-In Form' scope=parent}

{$head_javascripts[]="js/heic2any.min.js" scope=parent}
{$javascripts[]="js/jquery.image-upload-resizer.js?v1.1.0" scope=parent}
{$javascripts[]="design/`$settings->theme`/js/user_check.js?v1.0.27" scope=parent}

{if $smarty.get.success=='sended'}
<div class="page v_signed">
{else}
<div class="main_width">
{/if}

	{if $salesflow->type == 3} 
    	{$next_step_link = "user/house_rules_form/{$user->auth_code}?s={$salesflow->id}"}
	{elseif $salesflow->type == 1 && $booking->interval <= 30} 
    	{* {$next_step_link = "order/{$tax_invoice->url}?s={$salesflow->id}"} *}
    {else}
    	{* {$next_step_link = "user/covid_form/{$user->auth_code}"} *}
    {/if}

	{*
	{if $smarty.get.success=='sended' && $booking->interva < 30 && $smarty.get.add_docs!='sended'}
		<h1 class="bold_h1_new">Additional documents</h1>
		<div class="txt">
			<ul>
				<li>Please, add your ID</li>
				<li>If you have a roommate, add their photo</li>
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
				{$next_step_link="{$config->root_url}/guarantor/agreement"}
				{include file='guarantor/bx/steps_apps.tpl'}
				<div class="step fx c">
					<a href="{$next_step_link}" class="button2" >Skip this step</a>
				</div>
			{/if}
		</form>
		</div><!-- user_check -->

	{elseif $smarty.get.success=='sended' || $smarty.get.add_docs=='sended'}
	*}
	{if $smarty.get.success=='sended'}
				<div class="info">
					<h1 class="bold_h1_new center">Thank You!</h1>
					<p class="center"></p>
				</div>
			<br>
			<div class="txt">
				{*
				{$active_step=1}
				{if $salesflow->type == 3}
					{$steps_type = 'hotel'}
				{elseif $salesflow->type == 1 && $booking->interval <= 30} 
					{$steps_type = 'hotel_airbnb'}
				{else}
					{$steps_type = 'hotel_airbnb_no_tax'}
				{/if}
				{include file='bx/steps_apps.tpl'}
				<br>
				*}

				{if $salesflow->type == 3 && $booking->interval >= 30}
					{$steps_type = 'hotel'}
					{$active_step = 1}
					{include file='bx/steps_apps.tpl'}
					<br>
				{/if}
				<p class="center">Questions? Contact Outpost Club Inc at <a href="mailto:info@outpost-club.com">info@outpost-club.com</a> or call at <a href="tel:+18337076611">+1 (833) 707-6611</a>.</p>
			</div>
		</div>
	{else}
	<h1 class="bold_h1_new">Pre Check-In Form</h1>
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
			{if $booking->interval > 29}
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
			{/if}

			<div class="input_block">
				<div class="fx ch2">
					<div class="input_wrapper">
						<label for="email" class="req">Email</label>
						<input class="inp_i required" id="email" type="text" name="email" value="" required>
					</div>
					<div class="input_wrapper">
						<label for="phone" class="req">Phone</label>
						<input class="inp_i required" id="phone" type="text" name="phone" value="{$user->phone|escape}" required__>
					</div>
				</div>
			</div><!-- input_block -->




			<div class="check_wrapper">
				{if $booking->interval > 29}

				<input class="radio_h" id="us_citizen_1" type="radio" name="us_citizen" required value="1"{if $user->us_citizen==0 || $user->us_citizen==1} checked{/if}>
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
					{* {if $booking->interval > 25} *}
					<div class="padd_bx">
						
						<div class="input_block">

							<div class="fx ch3">
								<div class="input_wrapper social_number_bx">
									<label for="social_number" class="req">Social Security Number</label>
									<input class="inp_i{if $user->us_citizen==1} required{/if}" id="social_number" type="text" name="social_number" value="{$salesflow->application_data['social_number']}" placeholder="123-45-6789" data-required>
									<p class="info_txt{if $user->us_citizen==1} hide{/if}">*Fill this field ONLY if you have SSN</p>
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
										<label class="req" for="city">City</label>
										<input class="inp_i required" id="city" type="text" name="city" value="{$salesflow->application_data['city']|escape}" placeholder="New York" data-pattern="{literal}[A-Za-z0-9\s\.\-\(\)'`,]{3,}{/literal}">
										<p class="info_txt">3 character minimum</p>
									</div>
								</div>


								
								<div class="fx ch2_1">
									<div class="input_wrapper">
										<label class="req" for="street_address">Address</label>
										<input class="inp_i required" id="street_address" type="text" name="street_address" value="{$salesflow->application_data['street_address']|escape}" placeholder="" data-pattern="{literal}[A-Za-z0-9\s\.\-\(\)'`,]{3,}{/literal}">
									</div>

									<div class="input_wrapper">
										<label for="apartment">Apartment</label>
										<input class="inp_i" id="apartment" type="text" name="apartment" value="{$salesflow->application_data['apartment']|escape}" placeholder="">
									</div>
								</div>

							</div><!-- fx -->
						</div>
					</div>

					<div class="padd_bx">
						<div class="input_block">

							<div class="fx ch2">
								<div class="input_wrapper">
									<label {if $user->us_citizen!=2}class="req"{/if} for="employment_status">Employment status</label>
									<div class="inp_i select_block{if $user->us_citizen!=2} required{/if}">
										<select {if $user->us_citizen!=2}class="required"{/if} id="state" name="employment_status" data-required>
											<option value="" disabled{if !$salesflow->application_data['employment_status']} selected{/if}>- Select status -</option>
											<option value="1"{if $salesflow->application_data['employment_status']==1} selected{/if}>Employed</option>
											<option value="2"{if $salesflow->application_data['employment_status']==2} selected{/if}>Student</option>
											<option value="3"{if $salesflow->application_data['employment_status']==3} selected{/if}>Retired</option>
											<option value="4"{if $salesflow->application_data['employment_status']==4} selected{/if}>Other</option>
										</select>
									</div><!-- select_block -->
								</div>
								<div class="input_wrapper">
									<label class="req" for="annual_income">Income amount</label>
									<input class="inp_i required" id="annual_income" type="text" name="employment_income" value="{$salesflow->application_data['employment_income']|escape}" placeholder="" data-required data-pattern="{literal}[\d]*{/literal}" data-pattern1="{literal}[1-9]([0-9]*)?{/literal}">
									<div class="unit">$/month</div>
								</div>

								
							</div><!-- fx -->

						</div><!-- input_block -->
					</div><!-- padd_bx -->
					{* {/if} *}

				</div><!-- content_block1 v3 -->

				{* {if $booking->interval > 25} *}
				<div class="content_block1 v1">
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
								<label class="req" for="usa_selfie">Selfie with  Passport / ID / Driver licence</label>
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
							<p>In connection with my rental application, I hereby authorize and direct Ne-Bo Services Corp., either itself or through a third-party consumer reporting agency, to obtain “consumer reports” about me including information concerning my character, general reputation, personal characteristics, mode of living, and credit history/standing. The consumer report may include, but is not limited to: social security number verification; criminal records, verification of prior; and credit reports.</p>
							<p>Selection criteria that may result in denial of my rental application includes: criminal history, previous rental history, credit history, or failure to provide accurate or complete information on the application form.</p>
							<p>I agree the Ne-Bo Services Corp. may rely on this form to order background reports throughout my tenancy without asking me for my authorization again as allowed by law. I also agree that a copy of this form is valid like the signed original.</p>
							<p>Signing this acknowledgment indicates that you have had the opportunity to review the landlord's tenant selection criteria. The tenant selection criteria may include factors such as criminal history, credit history, current income, and rental history. If you do not meet the selection criteria, or if you provide inaccurate or incomplete information, your application may be rejected and your application fee will not be refunded.</p>
						</div>
						Outpost Club Inc. (Outpost Club) is a duly licensed real estate broker in the State of New York. Your trust is important to us. We respect your privacy and protect it with strict policies that govern how your information is handled. The Rental Application fee is non-refundable and you, the tenant applicant, are not entitled to a refund if your application is denied. Outpost Club and the landlord reserve the right to deny any rental application. By completing the rental application and the application fee, you authorize Outpost Club to use any third-party services to investigate your credit, employment and tenant history. You have been advised that you have the right under section 606(b) of the Fair Credit Reporting Act to make a written request for a complete and accurate disclosure of the nature and scope of any investigation. You have read, understand, and agree to the terms set forth in this notice.
					</div><!-- padd_bx info_block -->


					<div class="padd_bx">
						<div class="input_wrapper ch_item">
							<input {if $user->us_citizen==1}class="required"{/if} type="checkbox" name="to_check" id="to_check" value="1"{if $salesflow->application_data && $salesflow->application_data['to_check']==1} checked{/if} data-required>
							<div class="inp_i ch_bx">
								<label for="to_check" class="req">
									I agree to the processing of personal data.
								</label>
							</div>
						</div>

						<div class="ch_item">
							<input type="checkbox" name="california_app" id="california_app" value="1"{if $salesflow->application_data && $salesflow->application_data['california_app']==1} checked{/if}>
							<div class="ch_bx">
								<label for="california_app">
									California Applicants: Check if you would like a free copy of your background check report.
								</label>
							</div>
						</div>

						<div class="ch_item">
							<input type="checkbox" name="washington_app" id="washington_app" value="1"{if $salesflow->application_data && $salesflow->application_data['washington_app']==1} checked{/if}>
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
								<label class="req" for="visa">Upload a photo of your travel document/visa</label>
								<div class="inp_i file_block">
									<div class="preview_block{if $salesflow->application_data['files'] && $salesflow->application_data['files']['visa']} active{/if}">
										<img {if $salesflow->application_data['files'] && $salesflow->application_data['files']['visa']}src="{$config->users_files_dir}{$user->id}/{$salesflow->application_data['files']['visa']}"{/if}>
										<i class="delete fa fa-times-circle"></i>
									</div>
									<div class="select_file">
										<input {if $user->us_citizen==2 && (!$salesflow->application_data['files'] || !$salesflow->application_data['files']['visa'])}class="required"{/if} id="visa" type="file" name="visa" data-required-file>
										<div class="title"><i class="fa fa-upload"></i> Upload a photo of your travel document/visa</div>
									</div>
								</div><!-- file_block -->
							</div>

							<div class="input_wrapper">
								<label class="req" for="selfie">Selfie with ID</label>
								<div class="inp_i file_block">
									<div class="preview_block{if $salesflow->application_data['files'] && $salesflow->application_data['files']['selfie']} active{/if}">
										<img {if $salesflow->application_data['files'] && $salesflow->application_data['files']['selfie']}src="{$config->users_files_dir}{$user->id}/{$salesflow->application_data['files']['selfie']}"{/if}>
										<i class="delete fa fa-times-circle"></i>
									</div>
									<div class="select_file">
										<input {if $user->us_citizen==2 && (!$salesflow->application_data['files'] || !$salesflow->application_data['files']['selfie'])}class="required"{/if} id="selfie" type="file" name="selfie" data-required-file>
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
							<input {if $user->us_citizen==2}class="required"{/if} type="checkbox" name="to_check_not_us" id="to_check_not_us" value="1"{if $salesflow->application_data && $salesflow->application_data['to_check']==1} checked{/if} data-required>
							<div class="inp_i ch_bx">
								<label for="to_check_not_us" class="req">
									I agree to the processing of personal data.
								</label>
							</div>
						</div>
					</div>
				</div><!-- content_block1 v2 -->
				{* {/if} *}
				{else}
				<div class="content_block1" style="display: block">
					<div class="padd_bx">
						<div class="input_block">
							<div class="fx ch3">
								<div class="input_wrapper">
									<label class="req" for="visa">Your ID</label>
									<div class="inp_i file_block">
										<div class="preview_block{if $salesflow->application_data['files'] && $salesflow->application_data['files']['visa']} active{/if}">
											<img {if $salesflow->application_data['files'] && $salesflow->application_data['files']['visa']}src="{$config->users_files_dir}{$user->id}/{$salesflow->application_data['files']['visa']}"{/if}>
											<i class="delete fa fa-times-circle"></i>
										</div>
										<div class="select_file">
											<input class="required" id="visa" type="file" name="visa" data-required-file>
											<div class="title"><i class="fa fa-upload"></i> Please, add your ID</div>
										</div>
									</div><!-- file_block -->
								</div>

								{*
								<div class="input_wrapper">
									<label for="selfie">Photo of roommate</label>

									<div class="inp_i file_block">
										<div class="preview_block{if $salesflow->application_data['files'] && $salesflow->application_data['files']['selfie']} active{/if}">
											<img {if $salesflow->application_data['files'] && $salesflow->application_data['files']['selfie']}src="{$config->users_files_dir}{$user->id}/{$salesflow->application_data['files']['selfie']}"{/if}>
											<i class="delete fa fa-times-circle"></i>
										</div>
										<div class="select_file">
											<input id="selfie" type="file" name="selfie">
											<div class="title"><i class="fa fa-upload"></i> Add photo</div>
										</div>
										<p>If you have a roommate, add their photo</p>
									</div><!-- file_block -->
								</div>
								*}
							</div>
						</div><!-- input_block -->
					</div><!-- padd_bx -->
				</div><!-- content_block1 -->
				{/if}

				{if $signature}
					Signature:<br>
					<img src="{$signature}" alt="Signature {$user->name|escape}" width="180" />
				{else}
				<div class="signature_block" id="signature_block">
					{*
					<p class="signature_title">Signature:</p>
			    	<div class="wrapper">
			    		<canvas id="signature-pad" class="signature-pad" width=460 height=240></canvas>
			    	</div>
			        <input id="signature" class="required" type="hidden" name="signature" value="">
			        *}
			        <div class="button_block">
			            {*<div id="clear" class="clear">Clear</div>*}
			            <div id="save" class="save">Save</div>
			        </div><br>
					<p><strong>Please do not close this page, we need a few minutes to upload your photos.</strong></p>
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

	/*
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

	 */

	document.getElementById('save').addEventListener('click', function () {
		let f = VerifForm($('.user_check form'));
		console.log(f);

		if(f!=false){

			var body = document.getElementById('body');
		    // var type = body.getAttribute("data-type");

			/*
		    if(signaturePad.isEmpty())
		    {
		        return alert("Please provide a signature first");
		    }
			 */

		    // var el_page = document.getElementById('page');
		    // el_page.classList.add('sending');

			/*
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
			 */
			$('.preloader').show();
		    document.forms["rental_application"].submit();
		}
	});
	/*
	document.getElementById('clear').addEventListener('click', function () {
		signaturePad.clear();
	});
	 */


	});
	</script>
	{/literal}


	{/if}
</div>