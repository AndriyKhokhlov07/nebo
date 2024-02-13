{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}
{$apply_button_hide=1 scope=parent}
{$members_menu=1 scope=parent}


{if $issues}
<div class="page_wrap">
    <div class="guest_home w100">
        <div class="technical_issues fx w w100">
            
            <div class="item user_bookings booking_invoices">
                <div class="header_bx fx w w100">
                    <div class="icon">
                        <i class="fa fa-wrench"></i>
                    </div>
                    <div class="title_bx fx v c">
                        <div class="title">
                            Assignment tracker
                            {if $user->house_id && $rooms[$user->house_id]}
                            | {$rooms[$user->house_id]->header|escape}
                            {/if}
                        </div>
                    </div><!-- title_bx -->
                </div><!-- header_bx -->
                <div class="box">

                    <table class="table_s">
                        <tr>
                            <th>Start Date</th>
                            {if !$user->house_id}
                                <th>House</th>
                            {/if}
                            <th>Assignment</th>
                            <th>Status</th>
                            <th>Assigned</th>
                            <th>Due on</th>
                            <th>Details</th>
                        </tr>
                        {if $issues}
                            {foreach $issues as $issue}
                            <tr>
                                <td>
                                    {$issue->date_start|date_format:'%d-%b-%y'}<br>
                                    {$issue->date_start|date_format:'%I:%M %p'}
                                </td>
                                {if !$user->house_id}
                                    <td>
                                        {if $issue->house_id}
                                            {$rooms[$issue->house_id]->header|escape}
                                        {/if}
                                    </td>
                                {/if}
                                <td>{$issue->assignment|escape}</td>
                                <td>{$issues_statuses[$issue->status]}</td>
                                <td>{$issue->assigned|escape}</td>
                                <td>
                                    {$issue->date_completion|date_format:'%d-%b-%y'}<br>
                                    {$issue->date_completion|date_format:'%I:%M %p'}
                                </td>
                                <td class="text_left">
                                    <span class="invoice_desc">{$issue->details|escape}</span>
                                </td>
                            </tr>
                            {/foreach}
                        {/if}
                    </table>
                </div><!-- box -->
            </div><!-- item  -->
            


            <div class="item">
                <div class="id" id="request_form"></div>
                <div class="header_bx fx w w100">
                    <div class="icon">
                        <i class="fa fa-bullhorn"></i>
                    </div>
                    <div class="title_bx fx v c">
                        <div class="title">New Technical Request</div>
                    </div><!-- title_bx -->
                </div><!-- header_bx -->
                <div class="box">
                    <div class="press_form">
                    {if !in_array($user->house_id, [349, 368])}
                    {literal}
                    <!--[if lte IE 8]>
                    <script charset="utf-8" type="text/javascript" src="//js.hsforms.net/forms/v2-legacy.js"></script>
                    <![endif]-->
                    <script charset="utf-8" type="text/javascript" src="//js.hsforms.net/forms/v2.js"></script>
                    <script>
                    hbspt.forms.create({
                    portalId: "4068949",
                    formId: "4bfb8920-65c7-4de6-b9be-7ecaceaa8ab6"
                    });
                    </script>
                    {/literal}
                    {else}
                    {literal}
                    <!--[if lte IE 8]>
                    <script charset="utf-8" type="text/javascript" src="//js.hsforms.net/forms/v2-legacy.js"></script>
                    <![endif]-->
                        <script charset="utf-8" type="text/javascript" src="//js.hsforms.net/forms/embed/v2.js"></script>
                        <script>
                            hbspt.forms.create({
                                region: "na1",
                                portalId: "4068949",
                                formId: "a6663bac-2c14-483c-8b43-2315b3cb6459"
                            });
                        </script>
                    {/literal}
                    {/if}
                    </div>
                </div><!-- box -->
            </div><!-- item / user_files -->
            

        </div><!-- fx -->
    </div><!-- guest_home -->
</div><!-- page_wrap -->
{else}

<div class="main_width {if $page->image == ''}page_wrap{/if}">
    <h1 class="text_center">New Request</h1>

    <div class="press_form">
    {if !in_array($user->house_id, [349, 368])}
    {literal}
    <!--[if lte IE 8]>
    <script charset="utf-8" type="text/javascript" src="//js.hsforms.net/forms/v2-legacy.js"></script>
    <![endif]-->
    <script charset="utf-8" type="text/javascript" src="//js.hsforms.net/forms/v2.js"></script>
    <script>
    hbspt.forms.create({
    portalId: "4068949",
    formId: "4bfb8920-65c7-4de6-b9be-7ecaceaa8ab6"
    });
    </script>
    {/literal}
    {else}
    {literal}
    <!--[if lte IE 8]>
    <script charset="utf-8" type="text/javascript" src="//js.hsforms.net/forms/v2-legacy.js"></script>
    <![endif]-->
    <script charset="utf-8" type="text/javascript" src="//js.hsforms.net/forms/v2.js"></script>
    <script>
      hbspt.forms.create({
        region: "na1",
        portalId: "4068949",
        formId: "a6663bac-2c14-483c-8b43-2315b3cb6459"
    });
    </script>
    {/literal}
    {/if}
    </div>
</div>

{/if}




