

{$canonical="/{$page->url}" scope=parent}

{$this_page='page' scope=parent}

{$meta_title='New house onboarding form' scope=parent}

<link href="design/{$settings->theme|escape}/css/forms/form_house.css?v1.0.5" rel="stylesheet">

{$javascripts[]="design/`$settings->theme`/js/forms/form_house.js?v1.0.5" scope=parent}

<div class="page_wrap">
    <div class="main_width">

        <h2 class="hf_title">New house onboarding form</h2>

        <div class="h_form">
            <form method="POST" action="" name="form_house" id="form_house">


                {if $message_success=='added'}
                    <div class="alert success">
                        <span class="closeBtn">&times;</span>
                        <span>Data added successfully.</span>
                    </div>
                {elseif $message_success=='updated'}
                    <div class="alert success">
                        <span class="closeBtn">&times;</span>
                        <span>Data updated successfully.</span>
                    </div>
                {/if}

                <div class="input_block"><!-- input_block -->
                    <div class="hf_block">
                        <label class="input_wrapper_left">
                            <span>Name of a house</span>
                            <input type="text" name="name_house" placeholder="The Rectory House" value="{if $house_form->name_house}{$house_form->name_house|escape}{else}{$house->name|escape}{/if}">
                        </label>
                        <label class="input_wrapper_right">
                            <span>Address of the house</span>
                            <input type="text" name="address_house" placeholder="780 Lafayette Avenue, Brooklyn, NY, 11221" value="{$house_form->address_house|escape}">
                        </label>
                    </div>
                    <div class="hf_block">
                        <label class="input_wrapper_left">
                            <span>House ID</span>
                            <input type="text" name="house_id" placeholder='Check "Landlords info" file' value="{$house_form->house_id|escape}">
                        </label>
                        <label class="input_wrapper_right">
                            <span>House Code</span>
                            <input type="text" name="house_code" placeholder="RCTR" value="{$house_form->house_code|escape}">
                        </label>
                    </div>

                    <hr class="hr-line">

                    <div class="hf_block">
                        <label class="input_wrapper_left">
                            <span>Company owner (LLC)</span>
                            <input type="text" name="company_owner" placeholder="The Lafayete LLC" value="{$house_form->company_owner|escape}">
                        </label>
                        <label class="input_wrapper_right">
                            <span>Company address</span>
                            <input type="text" name="company_address" placeholder="Can be different for house address" value="{$house_form->company_address|escape}">
                        </label>
                    </div>
                    <h3>Person for contacting for access (Landlord)</h3>
                    <div class="hf_block">
                        <label class="input_wrapper_left">
                            <span>Name</span>
                            <input type="text" name="person_name" placeholder="Name/Surname" value="{$house_form->person_name|escape}">
                        </label>
                        <label class="input_wrapper_right">
                            <span>Email</span>
                            <input type="text" name="person_email" placeholder="Email" value="{$house_form->person_email|escape}">
                        </label>
                    </div>
                    <div class="hf_block">
                        <label class="input_wrapper_left">
                            <span>Landlord ID</span>
                            <input type="text" name="landlord_id" placeholder='Check "Landlords info" file' value="{$house_form->landlord_id|escape}">
                        </label>
                        <label class="input_wrapper_right">
                            <span>Landlord Group</span>
                            <input type="text" name="landlord_group" placeholder='Check "Landlords info" file' value="{$house_form->landlord_group|escape}">
                        </label>
                    </div>
                </div><!-- input_block -->

                <!-- PRICES block -->
                <h4>Prices</h4><!-- prices_block -->
                <div class="prices_info h_form">
                    <div class="prices_block">
                        <div class="prices">
                            {if $house_form->prices}
                                {foreach $house_form->prices as $p_key=>$price}
                                    <div class="price_item" data-price_key="{$p_key}">
                                        <div class="close_price_btn"><i class="fa fa-close"></i></div>
                                        <input type="hidden" name="price[{$p_key}][id]" value="{$p_key}">
                                        <div class="input_wrapper">
                                            <label>Room type</label>
                                            <div class="select_block"><!-- select_block -->
                                                <select name="price[{$p_key}][room_type]">
                                                    {foreach $room_types as $rt}
                                                        <option value="{$rt->id}"{if $price->room_type==$rt->id} selected{/if}>{$rt->name|escape}</option>
                                                    {/foreach}
                                                </select>
                                            </div><!-- select_block -->
                                        </div>
                                        <div class="hf_block">
                                            <div class="input_wrapper price_input">
                                                <span>12+ Months</span>
                                                <input type="text" name="price[{$p_key}][twelve_months]" value="{$price->twelve_months}" placeholder="1000">
                                                <span class="unit">$/month</span>
                                            </div>
                                            <label class="input_wrapper_right price_input">
                                                <span>4-11 Months</span>
                                                <input type="text" name="price[{$p_key}][eleven_months]" value="{$price->eleven_months}" placeholder="1100">
                                                <span class="unit">$/month</span>
                                            </label>
                                            <label class="input_wrapper_right price_input">
                                                <span>1-3 Months</span>
                                                <input type="text" name="price[{$p_key}][three_months]" value="{$price->three_months}" placeholder="1200">
                                                <span class="unit">$/month</span>
                                            </label>
                                        </div>
                                    </div>
                                {/foreach}
                            {/if}
                        </div>
                        <div class="add_price">
                            <div class="add_new_price"><i class="fa fa-plus-circle"></i> Add prices for room type</div>
                        </div>
                        <div class="price_text"><i class="fa fa-exclamation-triangle"></i> Be sure to include all prices for all types of rooms that you have in your house</div>
                    </div>
                </div><!-- prices_block -->

                <!-- APART block -->
                <h4>Apartments info</h4><!-- apart_block -->
                <div class="apart_info h_form">

                    {if $house_form->apartments}
                        {foreach $house_form->apartments as $a_key=>$apart}
                            <div class="apart_block" data-apartment_key="{$a_key}">
                                <div class="close_apart_btn"><i class="fa fa-close"></i></div>
                                <div class="apartment_item" >
                                    <input type="hidden" class="apart_key" name="apart[{$a_key}][id]" value="{$a_key}">
                                    <div class="ap_block">
                                        <div class="hf_block">
                                            <label class="input_wrapper_left">
                                                <span>Apartment Name</span>
                                                <input type="text" name="apart[{$a_key}][name]" value="{$apart->name}">
                                            </label>
                                            <label class="input_wrapper_right">
                                                <span>Description of the apartments</span>
                                                <input type="text" name="apart[{$a_key}][description]" value="{$apart->description}" placeholder="3BR/2Bath, etc">
                                            </label>
                                        </div>

                                        <div class="hf_block_radio"><!-- Furnish_radio_buttons -->
                                            <div class="furnish">
                                                <label class="radio-title">Description of the apartments</label>
                                                <div class="radio-group">
                                                    <label class="radio_button">
                                                        <input class="radio_f" type="radio" name="apart[{$a_key}][furnish]" value="1" {if $apart->furnish==1 || !$apart->furnish}checked{/if}>
                                                        <span>Furnished</span>
                                                    </label>
                                                    <label class="radio_button">
                                                        <input class="radio_f" type="radio" name="apart[{$a_key}][furnish]" value="2" {if $apart->furnish==2}checked{/if}>
                                                        <span>Unfurnished</span>
                                                    </label>
                                                </div>
                                            </div><!-- Furnish_radio_buttons -->

                                            <div class="radio_t_bx"><!-- Type_apart_radio_buttons -->
                                                <label class="radio-title">Type of each apartment</label>
                                                <div class="radio-group">
                                                    <label class="radio_button">
                                                        <input class="radio_f" type="radio" name="apart[{$a_key}][type]" value="1" {if $apart->type==1 || !$apart->type}checked{/if}>
                                                        <span>Coliving</span>
                                                    </label>
                                                    <label class="radio_button">
                                                        <input class="radio_f" type="radio" name="apart[{$a_key}][type]" value="2" {if $apart->type==2}checked{/if}>
                                                        <span>Traditional</span>
                                                    </label>
                                                    <label class="radio_button">
                                                        <input class="radio_f" type="radio" name="apart[{$a_key}][type]" value="3" {if $apart->type==3}checked{/if}>
                                                        <span>Rent stabilized</span>
                                                    </label>
                                                </div>
                                            </div><!-- Type_apart_radio_buttons -->
                                        </div><!-- apart_block -->

                                        <div class="hf_block">
                                            <label class="input_wrapper_left">
                                                <span>Utilities (indicate utilities for each apartment)</span>
                                                <input type="text" name="apart[{$a_key}][utilities]" value="{$apart->utilities}" placeholder="Indicate utilities for each apartment">
                                            </label>
                                            <label class="input_wrapper_right">
                                                <span>Property price for each apartment (For lease and Rent roll)</span>
                                                <input type="text" name="apart[{$a_key}][price]" value="{$apart->price}" placeholder="For lease and Rent roll">
                                            </label>
                                        </div>
                                        <div class="hf_block">
                                            <label class="input_wrapper_left">
                                                <span>Deposit for each apartment</span>
                                                <input type="text" name="apart[{$a_key}][deposit]" value="{$apart->deposit}">
                                            </label>
                                        </div>

                                    <!-- LIST OF ROOMS -->
                                    <h3 class="l_rooms">List of rooms</h3><!-- list_of_rooms -->
                                    </div>
                                    <div class="list_r">
                                        <div class="list_rooms">
                                            {if $apart->rooms}
                                                {foreach $apart->rooms as $r_key=>$room}
                                                    <div class="room_item" data-room_key="{$r_key}">
                                                        <div class="close_room_btn"><i class="fa fa-close"></i></div>
                                                        <input type="hidden" name="room[{$r_key}][id]" value="">
                                                        <input type="hidden" class="apart_key" name="room[{$r_key}][apartment_key]" value="{$a_key}">
                                                        <div class="hf_block">
                                                            <label class="input_wrapper_left">
                                                                <span>Room Name</span>
                                                                <input type="text" name="room[{$r_key}][name]" value="{$room->name}">
                                                            </label>
                                                        </div>

                                                        <div class="hf_block">
                                                            <div class="hf_block_radio"><!-- Furnish_radio_buttons -->
                                                                <div class="types_rooms">
                                                                    <label class="radio-title">Types of the rooms</label>
                                                                    <div class="radio-group">
                                                                        <label class="radio_types_rooms">
                                                                            <input class="radio_types" type="radio" name="room[{$r_key}][types_rooms]" value="1" {if $room->types_rooms==1 || !$room->types_rooms}checked{/if}>
                                                                            <span>Private</span>
                                                                        </label>
                                                                        <label class="radio_types_rooms">
                                                                            <input class="radio_types" type="radio" name="room[{$r_key}][types_rooms]" value="2" {if $room->types_rooms==2}checked{/if}>
                                                                            <span>Shared</span>
                                                                        </label>
                                                                    </div>
                                                                </div><!-- Furnish_radio_buttons -->
                                                            </div>
                                                            <label class="input_wrapper_right roomPrice {if $room->types_rooms !=2}hide{/if}">
                                                                <span>Number of beds</span>
                                                                <input type="text" name="room[{$r_key}][beds_count]" value="{$room->beds_count}">
                                                            </label>
                                                        </div>

                                                        <div class="hf_block">
                                                            <div class="desc_rooms">
                                                                <label class="check-title">Description of the rooms</label><!-- list_rooms_checkbox -->
                                                                <div class="room_checkbox">
                                                                    <label class="inputGroup">
                                                                        <input type="checkbox" name="room[{$r_key}][description_rooms][]" value="1" {if $room->description_rooms && in_array(1, $room->description_rooms)}checked{/if}>
                                                                        <span class="d_rooms">Bath</span>
                                                                    </label>
                                                                    <label class="inputGroup">
                                                                        <input type="checkbox" name="room[{$r_key}][description_rooms][]" value="2" {if $room->description_rooms && in_array(2, $room->description_rooms)}checked{/if}>
                                                                        <span class="d_rooms">Desk</span>
                                                                    </label>
                                                                    <label class="inputGroup">
                                                                        <input type="checkbox" name="room[{$r_key}][description_rooms][]" value="3" {if $room->description_rooms && in_array(3, $room->description_rooms)}checked{/if}>
                                                                        <span class="d_rooms">Large</span>
                                                                    </label>
                                                                    <label class="inputGroup">
                                                                        <input type="checkbox" name="room[{$r_key}][description_rooms][]" value="4" {if $room->description_rooms && in_array(4, $room->description_rooms)}checked{/if}>
                                                                        <span class="d_rooms">Full bed</span>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div><!-- list_rooms_checkbox -->
                                                {/foreach}
                                            {/if}
                                        </div>
                                    </div><!-- list_of_rooms -->

                                    <div class="add_room">
                                        <div class="add_new_room"><i class="fa fa-plus-circle"></i>Add room</div>
                                    </div>
                                </div>
                            </div><!-- apart_block -->
                            {/foreach}
                            {/if}
                        </div>
                        <div class="add_apartment">
                            <div class="add_new_apartment"><i class="fa fa-plus-circle"></i>Add apartment</div>
                        </div>


                        <!-- MEDIA block -->
                        <h4>Media</h4><!-- media_block -->
                        <div class="media_info h_form">
                            <div class="media_block">
                                <div class="m_item">
                                    <h3 class="media_tours">3D tours</h3>
                                    <div class="media_t">
                                        <div class="m_tour">
                                            {if $house_form->medias}
                                            {foreach $house_form->medias as $m_key=>$media}
                                            <div class="media_item" data-media_key="{$m_key}">
                                                <div class="close_media_btn"><i class="fa fa-close"></i></div>
                                                <input type="hidden" name="media[{$m_key}][id]" value="{$m_key}">
                                                <div class="hf_block">
                                                    <label class="input_wrapper_left">
                                                        <span>Link</span>
                                                        <input type="text" name="media[{$m_key}][link]" value="{$media->link}">
                                                    </label>
                                                    <label class="input_wrapper_right">
                                                        <span>Description</span>
                                                        <input type="text" name="media[{$m_key}][description]" value="{$media->description}">
                                                    </label>
                                                </div>
                                            </div>
                                            {/foreach}
                                            {/if}
                                        </div>
                                    </div>

                                    <div class="add_3D_tour">
                                        <div class="add_new_3D_tour"><i class="fa fa-plus-circle"></i>Add 3D tour</div>
                                    </div>

                                    <div class="hf_block media_tour">
                                        <label class="input_wrapper_left">
                                            <span>Pictures</span>
                                            <input type="text" name="media_pictures" value="{$house_form->media_pictures|escape}" placeholder="Link to files(GoogleDrive, Dropbox)">
                                        </label>
                                        <label class="input_wrapper_right">
                                            <span>Copy for Outpost Club and Internes, NYC websites</span>
                                            <input type="text" name="media_copy_pictures" placeholder="Share this file with Tech team and add link here" value="{$house_form->media_copy_pictures|escape}">
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div><!-- media_block -->


                        <!-- TENANTS block -->
                        <h4>Tenants (Fill this block only if we transfer a house from other PM company)</h4><!-- tenants_block -->
                        <div class="tenants_block">
                            <div class="hf_block">
                                <label class="input_wrapper_left">
                                    <span>List of tenants / Date of lease / Monthly price</span>
                                    <input type="text" name="list_of_tenants" value="{$house_form->list_of_tenants|escape}" placeholder="Link to Google Doc">
                                </label>
                                <label class="input_wrapper_right">
                                    <span>Ladger for each tenant from previous paroperty company</span>
                                    <input type="text" name="ladger_each_tenant" value="{$house_form->ladger_each_tenant|escape}" placeholder="Link to Google Drive">
                                </label>
                            </div>
                        </div><!-- tenants_block END -->


                        <!-- FEE block -->
                        <h4>Fee</h4><!-- fee_block -->
                        <div class="fee_block">
                            <div class="hf_block">
                                <label class="input_wrapper_left">
                                    <span>Application</span>
                                    <input type="text" name="application" value="{$house_form->application|escape}" placeholder="20, 99">
                                </label>
                                <label class="input_wrapper_right">
                                    <span>Deposit</span>
                                    <input type="text" name="deposit" value="{$house_form->deposit|escape}" placeholder="1, 2, etc">
                                </label>
                            </div>
                        </div><!-- fee_block END -->


                        <!-- FINANCE block -->
                        <h4>Finance</h4><!-- finance_block -->
                        <div class="finance_block">
                            <div class="hf_block">
                                <label class="input_wrapper_left">
                                    <span>Finance docs from previous managment company</span>
                                    <input type="text" name="finance_docs" value="{$house_form->finance_docs|escape}" placeholder="Link to Google Doc/Drive">
                                </label>
                                <label class="input_wrapper_right">
                                    <span>Brokarage</span>
                                    <input type="text" name="brokarage" value="{$house_form->brokarage|escape}" placeholder="1, 2, etc">
                                </label>
                            </div>
                            <div class="hf_block">
                                <label class="input_wrapper_left">
                                    <span>PM Fee</span>
                                    <input type="text" name="pm_fee" value="{$house_form->pm_fee|escape}">
                                </label>
                                <label class="input_wrapper_right">
                                    <span>Bank</span>
                                    <input type="text" name="bank" value="{$house_form->bank|escape}">
                                </label>
                            </div>
                            <div class="hf_block">
                                <label class="input_wrapper_left">
                                    <span>Lender</span>
                                    <input type="text" name="lender" value="{$house_form->lender|escape}">
                                </label>
                                <label class="input_wrapper_right">
                                    <span>Morgage</span>
                                    <input type="text" name="morgage" value="{$house_form->morgage|escape}">
                                </label>
                            </div>
                            <div class="hf_block">
                                <label class="input_wrapper_left">
                                    <span>Identifier (PayeeId)</span>
                                    <input type="text" name="identifier" placeholder="We receive this ID after fill the form" value="{$house_form->identifier|escape}">
                                </label>

                                <div class="hf_block_radio"><!-- DEPOSIT ACCOUNT radio_buttons -->
                                    <div class="deposit_account">
                                        <label class="radio-title">Create deposit account in Qira</label>
                                        <div class="radio-group">
                                            <label class="radio_deposit_account">
                                                <input class="radio_f" type="radio" name="deposit_account" value="1" {if $house_form->deposit_account==1 || !$house_form->deposit_account}checked{/if}>
                                                <span>Yes</span>
                                            </label>
                                            <label class="radio_deposit_account">
                                                <input class="radio_f" type="radio" name="deposit_account" value="2" {if $house_form->deposit_account==2}checked{/if}>
                                                <span>No</span>
                                            </label>
                                        </div>
                                    </div>
                                </div><!-- DEPOSIT ACCOUNT END radio_buttons -->
                            </div>
                        </div><!-- finance_block END -->


                        <!-- ACCOUNTS block -->
                        <h4>Accounts</h4><!-- add_account_block -->
                        <div class="accounts_info h_form">
                            <div class="accounts_block">
                                <div class="accounts_item">
                                    <h3 class="utility_accounts">Utility accounts</h3>
                                    <div class="utility_a">
                                        <div class="u_account">
                                            {if $house_form->accounts}
                                            {foreach $house_form->accounts as $ai_key=>$account_item}
                                            <div class="account_item" data-account_item_key="{$ai_key}">
                                                <div class="close_account_item_btn"><i class="fa fa-close"></i></div>
                                                <input type="hidden" name="account_item[{$ai_key}][id]" value="{$ai_key}">

                                                <div class="hf_block_radio"><!-- UTILITY radio_buttons -->
                                                    <div class="utility">
            {*                                            <div class="radio-group">*}
                                                            <label class="radio_utility_account">
                                                                <input class="radio_f" type="radio" name="account_item[{$ai_key}][utility]" value="1" {if $account_item->utility==1 || !$account_item->utility}checked{/if}>
                                                                <span>Electricity</span>
                                                            </label>
                                                            <label class="radio_deposit_account">
                                                                <input class="radio_f" type="radio" name="account_item[{$ai_key}][utility]" value="2" {if $account_item->utility==2}checked{/if}>
                                                                <span>Internet</span>
                                                            </label>
                                                            <label class="radio_deposit_account">
                                                                <input class="radio_f" type="radio" name="account_item[{$ai_key}][utility]" value="3" {if $account_item->utility==3}checked{/if}>
                                                                <span>Water</span>
                                                            </label>
                                                            <label class="radio_deposit_account">
                                                                <input class="radio_f" type="radio" name="account_item[{$ai_key}][utility]" value="4" {if $account_item->utility==4}checked{/if}>
                                                                <span>Gas</span>
                                                            </label>
            {*                                            </div>*}
                                                    </div>
                                                </div><!-- UTILITY END radio_buttons -->

                                                <div class="hf_block">
                                                    <label class="input_wrapper_left">
                                                        <span>Link</span>
                                                        <input type="text" name="account_item[{$ai_key}][link]" value="{$account_item->link}">
                                                    </label>
                                                </div>
                                                <div class="hf_block">
                                                    <label class="input_wrapper_left">
                                                        <span>Login</span>
                                                        <input type="text" name="account_item[{$ai_key}][login]" value="{$account_item->login}">
                                                    </label>
                                                    <label class="input_wrapper_right">
                                                        <span>Password</span>
                                                        <input type="text" name="account_item[{$ai_key}][password]" value="{$account_item->password}">
                                                    </label>
                                                </div>
                                                <div class="hf_block">
                                                    <label class="input_wrapper_left">
                                                        <span>Secret Q</span>
                                                        <input type="text" name="account_item[{$ai_key}][secret_q]" value="{$account_item->secret_q}">
                                                    </label>
                                                </div>
                                            </div>
                                            {/foreach}
                                            {/if}
                                        </div>
                                    </div>
                                    <div class="add_account">
                                        <div class="add_new_account"><i class="fa fa-plus-circle"></i>Add account</div>
                                    </div>
                                </div>
                            </div>
                        </div><!-- add_account_block END -->


                <!-- ACCESS CODES block -->
                <h4>Access codes</h4><!-- prices_block -->
                <div class="access_codes_info h_form">
                    <div class="access_codes_block">
                        <div class="access_codes">
                            {if $house_form->access_codes}
                                {foreach $house_form->access_codes as $ac_key=>$access_code_item}
                                    <div class="access_code_item" data-access_code_key="{$ac_key}">
                                        <div class="close_access_code_btn"><i class="fa fa-close"></i></div>
                                        <input type="hidden" name="access_code_item[{$ac_key}][id]" value="{$ac_key}">

                                        <div class="hf_block">
                                            <label class="input_wrapper_left">
                                                <span>Name</span>
                                                <input type="text" name="access_code_item[{$ac_key}][name]" value="{$access_code_item->name}">
                                            </label>
                                            <label class="input_wrapper_right">
                                                <span>Code</span>
                                                <input type="text" name="access_code_item[{$ac_key}][code]" value="{$access_code_item->code}">
                                            </label>
                                        </div>
                                    </div>
                                {/foreach}
                            {/if}
                        </div>

                        <div class="add_access_code">
                            <div class="add_new_access_code"><i class="fa fa-plus-circle"></i> Add access code</div>
                        </div>
                    </div>
                </div><!-- ACCESS CODES END -->

                <div class="sticky_line"></div>
                <div class="sticky_unline"></div>
                <div class="save_btn">
                    <input type="submit" id="save" name="save" value="Save">
                </div>
        </form>
    </div><!-- h_form -->
</div>
