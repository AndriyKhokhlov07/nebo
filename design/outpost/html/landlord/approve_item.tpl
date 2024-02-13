{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}
{$apply_button_hide=1 scope=parent}

{$members_menu=1 scope=parent}


<link href="design/{$settings->theme|escape}/css/landlord/landlord.css?v1.0.22" rel="stylesheet">



<div class="page_wrapper w900">


    <div class="notifications_block">
        <a href="/landlord/approve/">
            <i class="fa fa-angle-left"></i>
            Waiting list
        </a>
        <br>
        <br>
        <div class="title_bx">
            <h1 class="title">
                {$salesflow->tenant->first_name|escape}
                {$salesflow->tenant->middle_name|escape} 
                {$salesflow->tenant->last_name|escape}
            </h1>
        </div><!-- title_bx -->
        {if $salesflow}
            <div class="approve_block fx w">
                <div class="left_bx">
                    <div class="cont_box1">

                        {*
                        <div class="bx fx">
                            <div class="icon fx v">
                                <i class="fa fa-user"></i>
                            </div><!-- icon -->
                            <div class="cont fx v">
                                <div class="title">
                                    {if $salesflow->tenant->type==1}Guest{elseif $salesflow->tenant->type==2}House Leader{/if}
                                    {if $salesflow->booking->client_type_id>1 && $salesflow->booking->client_type}
                                        <div class="badge ct_{$salesflow->booking->client_type_id}">{$salesflow->booking->client_type}</div>
                                    {/if}
                                    <div class="badge">
                                        {if $salesflow->booking->type==1}
                                            Bed booking
                                        {elseif $salesflow->booking->type==2}
                                            Full apartment booking
                                        {/if}
                                    </div>
                                </div><!-- title -->
                                <div class="value m">
                                    {$salesflow->tenant->first_name|escape}
                                    {$salesflow->tenant->middle_name|escape} 
                                    {$salesflow->tenant->last_name|escape}
                                </div><!-- value -->
                            </div><!-- cont -->
                        </div><!-- bx -->
                        *}




                        <div class="bx fx">
                            <div class="icon fx v">
                                <i class="fa fa-calendar"></i>
                            </div><!-- icon -->
                            <div class="cont fx v">
                                <div class="title">
                                    Arrive / Depart
                                    <div class="badge">{$salesflow->booking->days_count} {$salesflow->booking->days_count|plural:'day':'days'}</div>
                                    <div class="badge">
                                        {if $salesflow->booking->type==1}
                                            Bed booking
                                        {elseif $salesflow->booking->type==2}
                                            Full apartment booking
                                        {/if}
                                    </div>
                                </div><!-- title -->
                                <div class="value m">
                                    {$salesflow->booking->arrive|date:'M j'}{if $salesflow->booking->arrive|date:'Y' != $salesflow->booking->depart|date:'Y'}, {$salesflow->booking->arrive|date:'Y'}{/if}
                                     <i class="fa fa-long-arrow-right"></i> 
                                    {$salesflow->booking->depart|date}
                                </div><!-- value -->
                            </div><!-- cont -->
                        </div><!-- bx -->


                        <div class="bx fx">
                            <div class="icon fx v">
                                <i class="fa fa-user"></i>
                            </div><!-- icon -->
                            <div class="cont fx v">
                                <div class="title">
                                    Tenant type
                                </div><!-- title -->
                                <div class="value m">
                                    {if $salesflow->tenant->type==2}
                                        House Leader
                                    {else}
                                        {$salesflow->booking->client_type}
                                    {/if}
                                </div><!-- value -->
                            </div><!-- cont -->
                        </div><!-- bx -->


                        {*

                        <div class="bx fx">
                            <div class="icon fx v c"><i class="fa fa-home"></i></div>
                            <div class="cont fx v">
                                {if $salesflow->house->blocks2['street_address']}
                                    <div class="title">
                                        {$salesflow->house->name|escape}
                                    </div>
                                    <div class="value">
                                        {$salesflow->house->blocks2['street_address']|escape}
                                    </div>
                                {else}
                                    <div class="title">
                                        House
                                    </div>
                                    <div class="value">
                                        {$salesflow->house->name|escape}
                                    </div>
                                {/if}
                            </div><!-- cont -->
                        </div><!-- bx -->
                        
                        {if $salesflow->booking->type==1}
                            {if $salesflow->booking->sp_bookings}
                                {foreach $salesflow->booking->sp_bookings as $b}
                                    <div class="bx fx_ s_bed{if $b@first} s_first{elseif $b@last} s_last{/if}">
                                        <div class="wrapper fx">
                                            <div class="icon fx v c"><i class="fa fa-bed"></i></div>
                                            <div class="cont fx v">
                                                <div class="title">
                                                    {if $apartments[$b->apartment_id]}
                                                        {$apartments[$b->apartment_id]->name|escape}
                                                    {/if}                                                 
                                                </div>
                                                <div class="value">
                                                    Bed: {$beds[$b->object_id]->name|escape} 
                                                </div>

                                                <div class="title">
                                                    {$b->arrive|date} 
                                                    <i class="fa fa-long-arrow-right"></i> 
                                                    {$b->depart|date}
                                                </div>

                                            </div><!-- cont -->
                                        </div><!-- wrapper -->
                                    </div><!-- bx -->
                                {/foreach}
                            {else}
                                <div class="bx fx">
                                    <div class="icon fx v c"><i class="fa fa-bed"></i></div>
                                    <div class="cont fx v">
                                        <div class="title">
                                            {if $apartments[$salesflow->booking->apartment_id]}
                                                {$apartments[$salesflow->booking->apartment_id]->name|escape}
                                            {/if}
                                        </div>
                                        <div class="value">
                                            Bed: {$beds[$salesflow->booking->object_id]->name|escape}
                                        </div>
                                    </div><!-- cont -->
                                </div><!-- bx -->
                            {/if}
                        {elseif $salesflow->booking->type==2}
                            <div class="bx fx">
                                <div class="icon fx v c"><i class="fa fa-bed"></i></div>
                                <div class="cont fx v">
                                    <div class="title">
                                        Apartment
                                    </div>
                                    <div class="value">
                                        {$apartments[$salesflow->booking->object_id]->name|escape}
                                    </div>
                                </div><!-- cont -->
                            </div><!-- bx -->
                        {/if}
                        *}


                        <div class="prices_bx bx fx">
                            <div class="icon fx v c"><i class="fa fa-usd"></i></div>
                            {if $salesflow->booking->price_month}
                                <div class="cont fx v c">
                                    <div class="title">Month</div>
                                    <div class="value price_value">
                                        {if $salesflow->contract->price_month}
                                            $ {$salesflow->contract->price_month|convert}
                                        {else}
                                            $ {$salesflow->booking->price_month|convert}
                                        {/if}
                                    </div>
                                </div>
                            {/if}

                            {if $salesflow->booking->total_price}
                                <div class="cont fx v c">
                                    <div class="title">Total</div>
                                    <div class="value price_value">
                                        {if $salesflow->contract->total_price}
                                            $ {$salesflow->contract->total_price|convert}
                                        {else}
                                            $ {$salesflow->booking->total_price|convert}
                                        {/if}
                                    </div>
                                </div>
                            {/if}

                            <div class="cont fx v c">
                                <div class="title">Deposit</div>
                                <div class="value price_value">
                                    {if $salesflow->contract->price_deposit > 0}
                                        $ {$salesflow->contract->price_deposit|convert}
                                    {elseif $salesflow->deposit_invoice}
                                        $ {$salesflow->deposit_invoice->total_price|convert}
                                    {elseif $salesflow->deposit_type==2 && $salesflow->deposit_status==4}
                                        {if $salesflow->contract->price_month}
                                            $ {$salesflow->contract->price_month|convert}
                                        {else}
                                            $ {$salesflow->booking->price_month|convert}
                                        {/if}
                                    {/if}
                                </div>
                            </div>
                        </div><!-- bx -->

                    </div><!-- cont_box1 -->

                    {if $salesflow->application_data['files'] || $salesflow->additional_files || $additional_files || $salesflow->isset_creditreport_file}
                        <div class="cont_box1">
                            {if $salesflow->application_data['files']}
                            <div class="doc_bx">
                                <div class="title">Documents</div>
                                <div class="docs1 fx w">
                                    {if $salesflow->application_data['files']['usa_doc']}
                                        <a class="item" href="/{$config->users_files_dir}{$salesflow->user_id}/{$salesflow->application_data['files']['usa_doc']}" data-fancybox="docs"{* data-caption="Doc (USA)"*}>
                                            <span class="wrapper">
                                                <img src="/{$config->users_files_dir}{$salesflow->user_id}/{$salesflow->application_data['files']['usa_doc']}" alt=" " />
                                                {* <span class="doc_img_title">Doc (USA)</span> *}
                                            </span>
                                        </a>
                                    {/if}
                                    {if $salesflow->application_data['files']['usa_selfie']}
                                        <a class="item" href="/{$config->users_files_dir}{$salesflow->user_id}/{$salesflow->application_data['files']['usa_selfie']}" data-fancybox="docs"{* data-caption="Selfie (USA)"*}>
                                            <span class="wrapper">
                                                <img src="/{$config->users_files_dir}{$salesflow->user_id}/{$salesflow->application_data['files']['usa_selfie']}" alt=" " />
                                                {* <span class="doc_img_title">Selfie (USA)</span> *}
                                            </span>
                                        </a>
                                    {/if}
                                    {if $salesflow->application_data['files']['visa']}
                                        <a class="item" href="/{$config->users_files_dir}{$salesflow->user_id}/{$salesflow->application_data['files']['visa']}" data-fancybox="docs"{* data-caption="Visa"*}>
                                            <span class="wrapper">
                                                <img src="/{$config->users_files_dir}{$salesflow->user_id}/{$salesflow->application_data['files']['visa']}" alt=" " />
                                                {* <span class="doc_img_title">Visa</span> *}
                                            </span>
                                        </a>
                                    {/if}
                                    {if $salesflow->application_data['files']['passport']}
                                        <a class="item" href="/{$config->users_files_dir}{$salesflow->user_id}/{$salesflow->application_data['files']['passport']}" data-fancybox="docs"{* data-caption="Passport"*}>
                                            <span class="wrapper">
                                                <img src="/{$config->users_files_dir}{$salesflow->user_id}/{$salesflow->application_data['files']['passport']}" alt=" " />
                                                {* <span class="doc_img_title">Passport</span> *}
                                            </span>
                                        </a>
                                    {/if}
                                    {if $salesflow->application_data['files']['selfie']}
                                        <a class="item" href="/{$config->users_files_dir}{$salesflow->user_id}/{$salesflow->application_data['files']['selfie']}" data-fancybox="docs"{* data-caption="Selfie"*}>
                                            <span class="wrapper">
                                                <img src="/{$config->users_files_dir}{$salesflow->user_id}/{$salesflow->application_data['files']['selfie']}" alt=" " />
                                                {* <span class="doc_img_title">Selfie</span> *}
                                            </span>
                                        </a>
                                    {/if}
                                </div><!-- docs1 -->
                            </div><!-- doc_bx -->
                            {/if}

                            {if $salesflow->additional_files || $additional_files}
                            <div class="doc_bx">
                                <div class="title">Additional Documents</div>
                                <div class="docs1 fx w">
                                    {if $salesflow->additional_files}
                                        {foreach $salesflow->additional_files as $f}
                                            <a class="item" href="/{$config->users_files_dir}{$salesflow->user_id}/{$f->filename}" data-fancybox="files" data-ext="{$f->ext}">
                                                <span class="wrapper">
                                                    <img src="/{$config->users_files_dir}{$salesflow->user_id}/{$f->filename}" alt=" ">
                                                    {* <span class="doc_img_title">Additional doc</span> *}
                                                </span>
                                            </a>
                                        {/foreach}
                                    {/if}
                                    {if $additional_files}
                                        {foreach $additional_files as $f}
                                             <a class="item" href="/{$config->users_files_dir}{$salesflow->user_id}/files/{$f->filename}" target="_blank"{if in_array($f->ext, array('png', 'jpg', 'jpeg', 'pdf'))} data-fancybox="files"{/if} data-ext="{$f->ext}">
                                                {if in_array($f->ext, array('png', 'jpg', 'jpeg'))}
                                                    <img src="/{$config->users_files_dir}{$salesflow->user_id}/files/{$f->filename}" alt=" ">
                                                {/if}
                                                <span class="wrapper"></span>
                                            </a>
                                        {/foreach}
                                    {/if}
                                </div><!-- docs1 -->
                            </div><!-- doc_bx -->
                            {/if}

                            {if $salesflow->isset_creditreport_file}
                                <div class="doc_bx">
                                    <div class="title">Credit Report</div>
                                    <div class="docs1 fx w">
                                        {foreach $user_files as $f}
                                            <a class="item" href="/{$config->users_files_dir}{$salesflow->user_id}/files/{$f->filename}" target="_blank"{if in_array($f->ext, array('png', 'jpg', 'jpeg', 'pdf'))} data-fancybox="files"{/if} data-ext="{$f->ext}">
                                                <span class="wrapper">
                                                    {* <span class="doc_img_title">{if $f->name}{$f->name}{else}{$f->filename}{/if}</span>*}
                                                </span>
                                            </a>
                                        {/foreach}
                                    </div><!-- docs1 -->
                                </div><!-- doc_bx -->
                            {/if}

                        </div><!-- cont_box1 -->
                    {/if}

                    {if $salesflow->ekata}
                        <div class="cont_box1 graph_logs">
                            <div class="graphs_bx fx c">

                                {if $salesflow->ekata->network_score}
                                <div class="item">
                                    <div class="graph">
                                        <svg viewBox="0 0 42 42" class="donut">
                                          <circle class="donut-ring" cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke-width="9"></circle>
                                          <circle class="donut-segment s{$salesflow->ekata->network_score->status->code}" cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke-width="9" stroke-dasharray="{$salesflow->ekata->network_score->pr} {100-$salesflow->ekata->network_score->pr}" stroke-dashoffset="25"></circle>
                                        </svg>
                                        <div class="val">{round($salesflow->ekata->network_score->score  * 100) / 100}</div>
                                    </div><!-- graph -->
                                    <div class="name">Identity network</div>

                                    <div class="info_bx">
                                        <div class="icon"><i class="fa fa-info"></i></div>
                                        <div class="info_cont">
                                            A higher score indicating a riskier transaction.<br> A number between 0 and 1
                                        </div>
                                    </div>
                                </div><!-- item -->
                                {/if}

                                {if $salesflow->ekata->check_score}
                                <div class="item">
                                    <div class="graph">
                                        <svg viewBox="0 0 42 42" class="donut">
                                          <circle class="donut-ring" cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke-width="9"></circle>
                                          <circle class="donut-segment s{$salesflow->ekata->check_score->status->code}" cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke-width="9" stroke-dasharray="{$salesflow->ekata->check_score->pr} {100-$salesflow->ekata->check_score->pr}" stroke-dashoffset="25"></circle>
                                        </svg>
                                        <div class="val">{round($salesflow->ekata->check_score->score * 100) / 100}</div>
                                    </div><!-- graph -->
                                    <div class="name">Identity check</div>

                                    <div class="info_bx">
                                        <div class="icon"><i class="fa fa-info"></i></div>
                                        <div class="info_cont">
                                            Comprehensive transaction risk score with a higher score indicating a riskier transaction.<br> A number between 0 and 500
                                        </div>
                                    </div>
                                </div><!-- item -->
                                {/if}

                                {if $salesflow->application_data['ekata_phone_check']}


                                <div class="item v2">
                                    <div class="box fx v c">
                                        <div class="ic {if in_array($salesflow->application_data['ekata_phone_check'], array('Non-fixed VOIP', 'Fixed VOIP'))}s2{else}s1{/if}">
                                            <i class="fa fa-mobile"></i>
                                        </div>
                                        {if !$salesflow->application_data['ekata_phone_check']}
                                            <div class="sbx s2">Not valid</div>
                                        {else}
                                            <div class="sbx {if in_array($salesflow->application_data['ekata_phone_check'], array('Non-fixed VOIP', 'Fixed VOIP'))}s2{else}s1{/if}">
                                                {$elog->fdata->primary_phone_checks->value->country_code->value}
                                                {$salesflow->application_data['ekata_phone_check']}
                                            </div>
                                        {/if}
                                    </div><!-- box -->
                                    <div class="name">Phone check</div>
                                </div><!-- item2 -->
                                {/if}





                                {if $elog->fdata->identity_network_score}
                                <div class="item">
                                    <div class="graph">
                                        <svg viewBox="0 0 42 42" class="donut">
                                          <circle class="donut-ring" cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke-width="9"></circle>
                                          <circle class="donut-segment s{$elog->fdata->identity_network_score->value->status->code}" cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke-width="9" stroke-dasharray="{$elog->fdata->identity_network_score->value->pr} {100-$elog->fdata->identity_network_score->value->pr}" stroke-dashoffset="25"></circle>
                                        </svg>
                                        <div class="val">{round($elog->fdata->identity_network_score->value->score * 100) / 100}</div>
                                    </div><!-- graph -->
                                    <div class="name">Identity network</div>

                                    <div class="info_bx">
                                        <div class="icon"><i class="fa fa-info"></i></div>
                                        <div class="info_cont">
                                            A higher score indicating a riskier transaction.<br> A number between 0 and 1
                                        </div>
                                    </div>
                                </div><!-- item -->
                                {/if}

                                {if $elog->fdata->identity_check_score}
                                <div class="item">
                                    <div class="graph">
                                        <svg viewBox="0 0 42 42" class="donut">
                                          <circle class="donut-ring" cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke-width="9"></circle>
                                          <circle class="donut-segment s{$elog->fdata->identity_check_score->value->status->code}" cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke-width="9" stroke-dasharray="{$elog->fdata->identity_check_score->value->pr} {100-$elog->fdata->identity_check_score->value->pr}" stroke-dashoffset="25"></circle>
                                        </svg>
                                        <div class="val">{round($elog->fdata->identity_check_score->value->score * 100) / 100}</div>
                                    </div><!-- graph -->
                                    <div class="name">Identity check</div>
                                    <div class="info_bx">
                                        <div class="icon"><i class="fa fa-info"></i></div>
                                        <div class="info_cont">
                                            Comprehensive transaction risk score with a higher score indicating a riskier transaction.<br> A number between 0 and 500
                                        </div>
                                    </div>
                                </div><!-- item -->
                                {/if}

                                {if $elog->fdata->primary_phone_checks}
                                <div class="item v2">
                                    <div class="box fx v c">
                                        <div class="ic {if in_array($elog->fdata->primary_phone_checks->value->line_type->value, array('Non-fixed VOIP', 'Fixed VOIP')) || !$elog->fdata->primary_phone_checks->value->is_valid->value}s2{else}s1{/if}">
                                            <i class="fa fa-mobile"></i>
                                        </div>
                                        {if !$elog->fdata->primary_phone_checks->value->is_valid->value}
                                            <div class="sbx s2">Not valid</div>
                                        {else}
                                            <div class="sbx {if in_array($elog->fdata->primary_phone_checks->value->line_type->value, array('Non-fixed VOIP', 'Fixed VOIP'))}s2{else}s1{/if}">
                                                {$elog->fdata->primary_phone_checks->value->country_code->value}
                                                {$elog->fdata->primary_phone_checks->value->line_type->value}
                                            </div>
                                        {/if}
                                    </div><!-- box -->
                                    <div class="name">Phone check</div>
                                </div><!-- item2 -->
                                {/if}

                            </div><!-- graphs_bx -->
                        </div>
                    {/if}


                </div><!-- left_bx -->
                <div class="right_bx">
                    <div class="approve_buttons_block">
                        <div class="item">
                            <form method="post">
                                <input type="hidden" name="approve" value="1">
                                <button class="approve_button approve_button1">Accept</button>
                            </form>
                        </div>

                        <div class="item approve_action">
                            <input class="chbx hide" id="approve_action_1" type="radio" name="approve_action" value="1">
                            <form method="post">
                                <input type="hidden" name="approve" value="2">
                                <textarea name="note" placeholder="Note [required]" required></textarea>
                                <button class="approve_button approve_button2">Request more info</button>
                            </form>
                            <label for="approve_action_1" class="approve_button approve_button2">Request more info</label>
                        </div>

                        <div class="item approve_action">
                            <input class="chbx hide" id="approve_action_2" type="radio" name="approve_action" value="2">
                            <form method="post">
                                <input type="hidden" name="approve" value="3">
                                <textarea name="note" placeholder="Note"></textarea>
                                <button class="approve_button approve_button3">Reject</button>
                            </form>
                            <label for="approve_action_2" class="approve_button approve_button3">Reject</label>
                        </div>

                    </div><!-- approve_buttons_block -->
                </div><!-- right_bx -->
            </div><!-- approve_block -->
        {else}
            No data
        {/if}
    </div><!-- notifications_block -->

</div><!-- page_wrapper -->

