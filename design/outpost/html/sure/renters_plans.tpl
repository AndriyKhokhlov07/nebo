{* Sure *}
{$apply_button_hide=1 scope=parent}
{$members_menu=0 scope=parent}
{$preloader=true scope=parent}


{$meta_title='Sure' scope=parent}
<link href="/design/outpost/css/sure.css" rel="stylesheet">

{$javascripts[]="design/`$settings->theme`/js/imask.js" scope=parent}
{$javascripts[]="design/`$settings->theme`/js/sure/plans.js?v.1.0.2" scope=parent}

<div class="sure">
	<form id="renters-plans" method="post">
		<div class="errors-data" data="{$errors|escape}" style="display: none"></div>
		<div class="step-progressbar">
			<ul class="steps">
{*				<li class="not-active" tag="1"><span class="progress-count"></span><p class="step_p">Personal Information</p></li>*}
{*				<li class="not-active" tag="2"><span class="progress-count"></span><p class="step_p">Property Address</p></li>*}
{*				<li class="not-active" tag="3"><span class="progress-count"></span><p class="step_p">Residence Class</p></li>*}
{*				<li class="not-active" tag="4"><span class="progress-count"></span><p class="step_p">Renters Insurance</p></li>*}
{*				<li class="not-active" tag="5"><span class="progress-count"></span><p class="step_p">Tenant's Losses</p></li>*}
{*				<li class="not-active" tag="6"><span class="progress-count"></span><p class="step_p">Animal Care</p></li>*}
{*				<li class="not-active" tag="7"><span class="progress-count"></span><p class="step_p">Add Another Person</p></li>*}
{*				<li class="not-active" tag="8"><span class="progress-count"></span><p class="step_p">Coverage Information </p></li>*}
{*				<li class="not-active" tag="9"><span class="progress-count"></span><p class="step_p">Start Date Policy</p></li>*}
			</ul>
		</div>
		<div class="form-section" tag="1" pb="1">
			<h2 class="sf_title">What is your address and personal information?</h2>
			<div class="sure_form">
				<div class="form-block">
					<div class="sf">
						<div class="input_block_l">
							<span><label for="street_address">Address Line 1</label></span>
							<input name="street_address" type="text" maxlength="30" class="need_require" value="{$params->street_address}" readonly>
						</div>
						<div class="input_block_r">
							<span><label for="unit">Address Line 2 (optional)</label></span>
							<input name="unit" type="text" maxlength="30" value="{$params->unit}" readonly>
						</div>
					</div>
					<div class="sf">
						<div class="input_block_l">
							<span><label for="city">City</label></span>
							<input name="city" type="text" maxlength="30" class="need_require" value="{$params->city}" readonly>
						</div>
						<div class="select_block">
							<span><label for="region"></label>State/Province/Region</span>
							<input name="region" type="text" class="need_require" value="{strtoupper($params->region)}" style="display: none">
							<div class="sure_select">
								<select name="region_selector" class="need_require" disabled>
									{foreach $regions as $key => $val}
										<option value="{$key}"{if $params->region == $key} selected{/if}>{$val} ({$key})</option>
									{/foreach}
								</select>
							</div>
						</div>
					</div>
					<div class="sf">
						<div class="input_block_l">
							<span><label for="postal">Zip/Postal Code</label></span>
							<input name="postal" type="text" maxlength="30" class="need_require" value="{$params->postal}" readonly>
						</div>
						<div class="input_block_r">
							<span><label for="country_code">Country Code</label></span>
							<input name="country_code" type="text" maxlength="3" class="need_require" value="{$params->country_code}" readonly>
						</div>
					</div>
				</div>
				<hr class="hr-line">
				<div class="form-block">
					<div class="sf">
						<div class="input_block_l">
							<span><label for="pni_first_name">First Name</label></span>
							<input name="pni_first_name" type="text" maxlength="20" pattern="[a-zA-Z ]+" class="need_require" value="{$params->pni_first_name}">
						</div>
						<div class="input_block_r">
							<span><label for="pni_middle_name">Middle Name (optional)</label></span>
							<input name="pni_middle_name" type="text" maxlength="20" pattern="[a-zA-Z ]*" value="{$params->pni_middle_name}">
						</div>
					</div>
					<div class="sf">
						<div class="input_block_l">
							<span><label for="pni_last_name">Last Name</label></span>
							<input name="pni_last_name" type="text" maxlength="20" pattern="[a-zA-Z ]+" value="{$params->pni_last_name}">
						</div>
						<div class="select_block">
							<span><label for="pni_suffix">Suffix (optional)</label></span>
							<div class="sure_select">
								<select name="pni_suffix">
									{foreach $suffixes as $key => $val}
										<option value="{$key}"{if $params->pni_suffix == $key} selected{/if}>{$val}</option>
									{/foreach}
								</select>
							</div>
						</div>
					</div>
					<div class="sf">
						<div class="input_block_l">
							<span><label for="pni_phone_number">Phone Number (e.g. 555-555-5555)</label></span>
							<input name="pni_phone_number" type="text" datatype="phone" placeholder="555-555-5555" class="need_require" value="{$params->pni_phone_number}">
						</div>
						<div class="input_block_r">
							<span><label for="pni_email">Email Address</label></span>
							<input name="pni_email" type="email" maxlength="50" class="need_require" value="{$params->pni_email}">
						</div>
					</div>
				</div>
			</div>
			<div class="form-block-button">
				<div class="button_block">
					<button  class="button-next">Next</button>
				</div>
			</div>
		</div>
{*		<div class="form-section" tag="2" pb="2">*}
{*			<h2 class="sf_title">Is your mailing address different from your main address?</h2>*}
{*			<div class="sure_form">*}
{*				<div class="form-block">*}
{*					<h3 class="h3_style">Property Address</h3>*}
{*				</div>*}
{*				<hr class="hr-line">*}
{*				<div class="form-block-radio">*}
{*					<div class="input_block">*}
{*						<label class="radio_sure">*}
{*							<input class="radio_sf" name="has_mailing_address" type="radio" value="true"{if $params->has_mailing_address == 'true'} checked{/if}>*}
{*							<span>Yes</span>*}
{*						</label>*}
{*						<label class="radio_sure">*}
{*							<input class="radio_sf" name="has_mailing_address" type="radio" value="false"{if $params->has_mailing_address == 'false'} checked{/if}>*}
{*							<span>No</span>*}
{*						</label>*}
{*					</div>*}
{*				</div>*}
{*			</div>*}
{*			<div class="form-block-button">*}
{*				<div class="button_block">*}
{*					<button class="button-back">Back</button>*}
{*					<button  class="button-next">Next</button>*}
{*				</div>*}
{*			</div>*}
{*		</div>*}
{*		<div class="form-section" tag="3" pb="2">*}
{*			<h2 class="sf_title">What is your mailing address?</h2>*}
{*			<div class="sure_form">*}
{*				<div class="form-block">*}
{*					<div class="sf">*}
{*						<div class="input_block_l">*}
{*							<span><label for="mailing_address_line1">Address Line 1</label></span>*}
{*							<input name="mailing_address_line1" type="text" maxlength="30" class="need_require" value="{$params->mailing_address_line1}">*}
{*						</div>*}
{*						<div class="input_block_r">*}
{*							<span><label for="mailing_address_line2">Address Line 2</label></span>*}
{*							<input name="mailing_address_line2" type="text" maxlength="30" value="{$params->mailing_address_line2}">*}
{*						</div>*}
{*					</div>*}
{*					<div class="sf">*}
{*						<div class="input_block_l">*}
{*							<span><label for="mailing_address_city">City</label></span>*}
{*							<input name="mailing_address_city" type="text" minlength="3" class="need_require" value="{$params->mailing_address_city}">*}
{*						</div>*}
{*						<div class="select_block">*}
{*							<span><label for="mailing_address_state"></label>State/Province/Region</span>*}
{*							<div class="sure_select">*}
{*								<select name="mailing_address_state" class="need_require">*}
{*									{foreach $regions as $key => $val}*}
{*										<option value="{$key}"{if $params->mailing_address_state == $key} selected{/if}>{$val} ({$key})</option>*}
{*									{/foreach}*}
{*								</select>*}
{*							</div>*}
{*						</div>*}
{*					</div>*}
{*					<div class="sf">*}
{*						<div class="input_block">*}
{*							<span><label for="mailing_address_postal">Zip/Postal Code</label></span>*}
{*							<input name="mailing_address_postal" type="text" maxlength="30" class="need_require" value="{$params->mailing_address_postal}">*}
{*						</div>*}
{*					</div>*}
{*				</div>*}
{*			</div>*}
{*			<div class="form-block-button">*}
{*				<div class="button_block">*}
{*					<button class="button-back">Back</button>*}
{*					<button  class="button-next">Next</button>*}
{*				</div>*}
{*			</div>*}
{*		</div>*}
{*		<div class="form-section" tag="4" pb="3">*}
{*			<h2 class="sf_title">How would you classify your current residence?</h2>*}
{*			<div class="sure_form">*}
{*				<div class="form-block-radio">*}
{*					<div class="input_block_radio">*}
{*						<label class="radio_sure">*}
{*							<input class="radio_sf" name="dwelling_type" type="radio" value="A"{if $params->dwelling_type == 'A'} checked{/if}>*}
{*							<span>Apartment / Condominium</span>*}
{*						</label>*}
{*						<label class="radio_sure">*}
{*							<input class="radio_sf" name="dwelling_type" type="radio" value="T"{if $params->dwelling_type == 'T'} checked{/if}>*}
{*							<span>Townhouse / Duplex / Triplex</span>*}
{*						</label>*}
{*						<label class="radio_sure">*}
{*							<input class="radio_sf" name="dwelling_type" type="radio" value="S"{if $params->dwelling_type == 'S'} checked{/if}>*}
{*							<span>Single family home</span>*}
{*						</label>*}
{*						<label class="radio_sure">*}
{*							<input class="radio_sf" name="dwelling_type" type="radio" value="D"{if $params->dwelling_type == 'D'} checked{/if}>*}
{*							<span>Dorm / Student Housing</span>*}
{*						</label>*}
{*					</div>*}
{*				</div>*}
{*			</div>*}
{*			<div class="form-block-button">*}
{*				<div class="button_block">*}
{*					<button class="button-back">Back</button>*}
{*					<button  class="button-next">Next</button>*}
{*				</div>*}
{*			</div>*}
{*		</div>*}
{*		<div class="form-section" tag="5" pb="3">*}
{*			<h2 class="sf_title">Is it a mobile or manufactured home?</h2>*}
{*			<div class="sure_form">*}
{*				<div class="form-block-radio">*}
{*					<div class="input_block">*}
{*						<label class="radio_sure">*}
{*							<input class="radio_sf" name="is_mobile_or_manufactured_home" type="radio" value="true"{if $params->is_mobile_or_manufactured_home == 'true'} checked{/if}>*}
{*							<span>Yes</span>*}
{*						</label>*}
{*						<label class="radio_sure">*}
{*							<input class="radio_sf" name="is_mobile_or_manufactured_home" type="radio" value="false"{if $params->is_mobile_or_manufactured_home == 'false'} checked{/if}>*}
{*							<span>No</span>*}
{*						</label>*}
{*					</div>*}
{*				</div>*}
{*			</div>*}
{*			<div class="form-block-button">*}
{*				<div class="button_block">*}
{*					<button class="button-back">Back</button>*}
{*					<button  class="button-next">Next</button>*}
{*				</div>*}
{*			</div>*}
{*		</div>*}
{*		<div class="form-section" tag="6" pb="4">*}
{*			<h2 class="sf_title">Does your lease require all residents at the property to carry renters insurance?</h2>*}
{*			<div class="sure_form">*}
{*				<div class="form-block-radio">*}
{*					<div class="input_block">*}
{*						<label class="radio_sure">*}
{*							<input class="radio_sf" name="mandatory_insurance_requirement" type="radio" value="true"{if $params->mandatory_insurance_requirement == 'true'} checked{/if}>*}
{*							<span>Yes</span>*}
{*						</label>*}
{*						<label class="radio_sure">*}
{*							<input class="radio_sf" name="mandatory_insurance_requirement" type="radio" value="false"{if $params->mandatory_insurance_requirement == 'false'} checked{/if}>*}
{*							<span>No</span>*}
{*						</label>*}
{*					</div>*}
{*				</div>*}
{*			</div>*}
{*			<div class="form-block-button">*}
{*				<div class="button_block">*}
{*					<button class="button-back">Back</button>*}
{*					<button  class="button-next">Next</button>*}
{*				</div>*}
{*			</div>*}
{*		</div>*}
{*		<div class="form-section" tag="7" pb="5">*}
{*			<h2 class="sf_title">Excluding storms, floods, and other natural causes, how many losses have you had in the past three years?</h2>*}
{*			<a href="#nh_link" class="md_link">Need Help?*}
{*			<div class="hide need_help" id="nh_link">*}
{*				<content class="nh_content">Natural Causes: Losses caused by lightning, windstorm, hurricane, tornado, sinkhole collapse, flood or rising water, earthquake, earth movement, freezing, hail, sinking, landslide, snowstorm, volcanic eruption and wildfire.*}
{*					Losses: Occurrences such as theft or physical damage to property, whether covered by insurance or not or occurrences such as property stolen or physical damage to property, whether covered by insurance or not.*}
{*				</content>*}
{*			</div>*}
{*			</a>*}
{*			<div class="sure_form">*}
{*				<div class="form-block-radio">*}
{*					<div class="input_block_radio">*}
{*						<label class="radio_sure">*}
{*							<input class="radio_sf" name="number_of_losses" type="radio" value="0"{if $params->number_of_losses == '0'} checked{/if}>*}
{*							<span>None</span>*}
{*						</label>*}
{*						<label class="radio_sure">*}
{*							<input class="radio_sf" name="number_of_losses" type="radio" value="1"{if $params->number_of_losses == '1'} checked{/if}>*}
{*							<span>One</span>*}
{*						</label>*}
{*						<label class="radio_sure">*}
{*							<input class="radio_sf" name="number_of_losses" type="radio" value="2+"{if $params->number_of_losses == '2+'} checked{/if}>*}
{*							<span>Two or more</span>*}
{*						</label>*}
{*					</div>*}
{*				</div>*}
{*			</div>*}
{*			<div class="form-block-button">*}
{*				<div class="button_block">*}
{*					<button class="button-back">Back</button>*}
{*					<button  class="button-next">Next</button>*}
{*				</div>*}
{*			</div>*}
{*		</div>*}
{*		<div class="form-section" tag="8" pb="5">*}
{*			<h2 class="sf_title">What was the date of the most recent loss?</h2>*}
{*			<div class="sure_form">*}
{*				<div class="form-block">*}
{*					<div class="sf">*}
{*						<div class="input_block">*}
{*							<span><label for="loss_date">Date of Loss</label></span>*}
{*							<input name="loss_date" type="date" class="need_require" value="{$params->loss_date}">*}
{*						</div>*}
{*					</div>*}
{*				</div>*}
{*			</div>*}
{*			<div class="form-block-button">*}
{*				<div class="button_block">*}
{*					<button class="button-back">Back</button>*}
{*					<button  class="button-next">Next</button>*}
{*				</div>*}
{*			</div>*}
{*		</div>*}
{*		<div class="form-section" tag="9" pb="6">*}
{*			<h2 class="sf_title">Do you own or care for an animal that has caused bodily injury or harm? (Excluding service animals)</h2>*}
{*			<a href="#nh_link1" class="md_link">Need Help?*}
{*				<div class="hide need_help" id="nh_link1">*}
{*					<content class="nh_content">Service animal is defined as guide dogs, signal dogs, or any other service animals that are trained to do work or perform a task for the benefit of an individual with a disability.</content>*}
{*				</div>*}
{*			</a>*}
{*			<div class="sure_form">*}
{*				<div class="form-block-radio">*}
{*					<div class="input_block">*}
{*						<label class="radio_sure">*}
{*							<input class="radio_sf" name="animal_injury" type="radio" value="true"{if $params->animal_injury == 'true'} checked{/if}>*}
{*							<span>Yes</span>*}
{*						</label>*}
{*						<label class="radio_sure">*}
{*							<input class="radio_sf" name="animal_injury" type="radio" value="false"{if $params->animal_injury == 'false'} checked{/if}>*}
{*							<span>No</span>*}
{*						</label>*}
{*					</div>*}
{*				</div>*}
{*			</div>*}
{*			<div class="form-block-button">*}
{*				<div class="button_block">*}
{*					<button class="button-back">Back</button>*}
{*					<button  class="button-next">Next</button>*}
{*				</div>*}
{*			</div>*}
{*		</div>*}
{*		<div class="form-section" tag="10" pb="7">*}
{*			<h2 class="sf_title">Would you like to add another person (unrelated to you) to your rental policy?</h2>*}
{*			<a href="#nh_link2" class="md_link">Need Help?*}
{*				<div class="hide need_help" id="nh_link2">*}
{*					<content class="nh_content">An Additional Applicant is a person that is not related to the primary applicant but resides in the same location as the primary applicant. This additional applicant would like protection under this policy.</content>*}
{*				</div>*}
{*			</a>*}
{*			<div class="sure_form">*}
{*				<div class="form-block-radio">*}
{*					<div class="input_block">*}
{*						<label class="radio_sure">*}
{*							<input class="radio_sf" name="has_sni" type="radio" value="true"{if $params->has_sni == 'true'} checked{/if}>*}
{*							<span>Yes</span>*}
{*						</label>*}
{*						<label class="radio_sure">*}
{*							<input class="radio_sf" name="has_sni" type="radio" value="false"{if $params->has_sni == 'false'} checked{/if}>*}
{*							<span>No</span>*}
{*						</label>*}
{*					</div>*}
{*				</div>*}
{*			</div>*}
{*			<div class="form-block-button">*}
{*				<div class="button_block">*}
{*					<button class="button-back">Back</button>*}
{*					<button  class="button-next">Next</button>*}
{*				</div>*}
{*			</div>*}
{*		</div>*}
{*		<div class="form-section" tag="11" pb="7">*}
{*			<h2 class="sf_title">What is the name of the additional person you want named on the policy?</h2>*}
{*			<div class="sure_form">*}
{*				<div class="form-block">*}
{*					<div class="sf">*}
{*						<div class="input_block_l">*}
{*							<span><label for="sni_first_name">First Name</label></span>*}
{*							<input name="sni_first_name" type="text" maxlength="25" class="need_require" value="{$params->sni_first_name}">*}
{*						</div>*}
{*						<div class="input_block_r">*}
{*							<span><label for="sni_last_name">Last Name</label></span>*}
{*							<input name="sni_last_name" type="text" maxlength="25" class="need_require" value="{$params->sni_last_name}">*}
{*						</div>*}
{*					</div>*}
{*				</div>*}
{*			</div>*}
{*			<div class="form-block-button">*}
{*				<div class="button_block">*}
{*					<button class="button-back">Back</button>*}
{*					<button  class="button-next">Next</button>*}
{*				</div>*}
{*			</div>*}
{*		</div>*}
{*		<div class="form-section" tag="12" pb="8">*}
{*			<h2 class="sf_title">Do you want to inform an interested party about your coverage? (i.e. Rental community or property manager)?</h2>*}
{*			<a href="#nh_link3" class="md_link">Need Help?*}
{*				<div class="hide need_help" id="nh_link3">*}
{*					<content class="nh_content">Interested party is your rental community or property manager who requires to be informed of your coverage. You acknowledge we will send this information to the Interested Party.</content>*}
{*				</div>*}
{*			</a>*}
{*			<div class="sure_form">*}
{*				<div class="form-block-radio">*}
{*					<div class="input_block">*}
{*						<label class="radio_sure">*}
{*							<input class="radio_sf" name="has_intrested_party" type="radio" value="true"{if $params->has_intrested_party == 'true'} checked{/if}>*}
{*							<span>Yes</span>*}
{*						</label>*}
{*						<label class="radio_sure">*}
{*							<input class="radio_sf" name="has_intrested_party" type="radio" value="false"{if $params->has_intrested_party == 'false'} checked{/if}>*}
{*							<span>No</span>*}
{*						</label>*}
{*					</div>*}
{*				</div>*}
{*			</div>*}
{*			<div class="form-block-button">*}
{*				<div class="button_block">*}
{*					<button class="button-back">Back</button>*}
{*					<button  class="button-next">Next</button>*}
{*				</div>*}
{*			</div>*}
{*		</div>*}
{*		<div class="form-section" tag="13" pb="8">*}
{*			<h2 class="sf_title">What is your interested party’s name?</h2>*}
{*			<div class="sure_form">*}
{*				<div class="form-block">*}
{*					<div class="sf">*}
{*						<div class="input_block_l">*}
{*							<span><label for="intrested_party_name">Name</label></span>*}
{*							<input name="intrested_party_name" type="text" minlength="3" maxlength="30" class="need_require" value="{$params->intrested_party_name}">*}
{*						</div>*}
{*						<div class="input_block_r">*}
{*							<span><label for="intrested_party_address_line1">Address Line 1</label></span>*}
{*							<input name="intrested_party_address_line1" type="text" minlength="3" maxlength="30" class="need_require" value="{$params->intrested_party_address_line1}">*}
{*						</div>*}
{*					</div>*}
{*				</div>*}
{*				<div class="form-block">*}
{*					<div class="sf">*}
{*						<div class="input_block_l">*}
{*							<span><label for="intrested_party_address_line2">Address Line 2</label></span>*}
{*							<input name="intrested_party_address_line2" type="text" minlength="3" maxlength="30" value="{$params->intrested_party_address_line2}">*}
{*						</div>*}
{*						<div class="input_block_r">*}
{*							<span><label for="intrested_party_address_city">City</label></span>*}
{*							<input name="intrested_party_address_city" type="text" minlength="3" maxlength="30" class="need_require" value="{$params->intrested_party_address_city}">*}
{*						</div>*}
{*					</div>*}
{*				</div>*}
{*				<div class="form-block">*}
{*					<div class="sf">*}
{*						<div class="select_block_r">*}
{*							<span><label for="intrested_party_address_state"></label>State/Province/Region</span>*}
{*							<div class="sure_select">*}
{*								<select name="intrested_party_address_state" class="need_require">*}
{*									{foreach $regions as $key => $val}*}
{*										<option value="{$key}"{if $params->intrested_party_address_state == $key} selected{/if}>{$val} ({$key})</option>*}
{*									{/foreach}*}
{*								</select>*}
{*							</div>*}
{*						</div>*}
{*						<div class="input_block_r">*}
{*							<span><label for="intrested_party_address_postal">Zip/Postal Code</label></span>*}
{*							<input name="intrested_party_address_postal" type="text" maxlength="30" class="need_require" value="{$params->intrested_party_address_postal}">*}
{*						</div>*}
{*					</div>*}
{*				</div>*}

{*					</div>*}
{*				</div>*}
{*			</div>*}
{*			<div class="form-block-button">*}
{*				<div class="button_block">*}
{*					<button class="button-back">Back</button>*}
{*					<button  class="button-next">Next</button>*}
{*				</div>*}
{*			</div>*}
{*		</div>*}
		<div class="form-section" tag="14" pb="9">
			<h2 class="sf_title">When should this policy take effect?</h2>
			<div class="sure_form">
				<div class="form-block">
					<div class="sf">
						<div class="input_block">
							<span><label for="policy_effective_date">Start Date</label></span>
							<input name="policy_effective_date" type="date" class="need_require" value="{$params->policy_effective_date}" readonly>
{*							<input name="policy_effective_date" class="datepicker-here" data-language='en' class="need_require">*}
						</div>
					</div>
				</div>
			</div>
			<div class="form-block-button">
				<div class="button_block">
					<button class="button-back">Back</button>
					<input type="submit" class="button-next" value="Send">
				</div>
			</div>
		</div>
		<div class="form-section" tag="100">
			<h2 class="sf_title">Section 100</h2>
			<div class="sure_form">
				<div class="form-block">
					<h1 style="color: red">Sorry, your case is out in served yet</h1>
				</div>
			</div>
			<div class="form-block-button">
				<div class="button_block">
					<button class="button-back">Back</button>
					<button  class="button-next">Next</button>
				</div>
			</div>
		</div>
		<div class="sure_logo">
			<img src="/design/{$settings->theme|escape}/images/logos/assurant_logo.png" alt="Assurant Logo">
			<p>Assurant is the holding company for various underwriting entities that provide Renters Insurance. In all states, except Minnesota and Texas, Renters Insurance is underwritten by American Bankers Insurance Company of Florida with its home office in Miami, Florida (ABIC NAIC# 10111). In Minnesota, the underwriter is American Security Insurance Company. In Texas, the renters property insurance is underwritten by Ranchers and Farmers Mutual Insurance Company. Each insurer has sole responsibility for its own products. In Utah, coverage is provided under policy form AJ8850PC-0307. Sold by Sure HIIS Insurance Services, LLC.</p>
		</div>
		<div class="sure_logo">
			<img src="/design/{$settings->theme|escape}/images/logos/sure_logo.png" alt="Sure Logo">
			<p>Content and associated insurance products are provided by Sure HIIS Insurance Services, LLC (“Sure”), a licensed seller of insurance. The above does not in any way constitute an endorsement or referral by Outpost Club. Products may not be offered in all states.</p>
		</div>
	</form>
</div>





