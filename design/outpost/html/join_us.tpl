{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}
{$this_page='join_us' scope=parent}
{$apply_form="1" scope=parent}

    <div class="main_width apply_text {if $page->image == ''}page_wrap{/if}">
        <p class="h5">After you fill out this form, you will be redirected to the next form, and receive an e-mail confirmation and/or a call from our booking department within 1-2 days. At that point, you will receive pricing and availability.</p>
        <div class="form_acnhor" id="apply"></div>
        <div class="press_form">
            <script src="//js.hsforms.net/forms/v2.js"></script>
            <script>
              hbspt.forms.create({
                portalId: "4068949",
                formId: "f7fcf175-50eb-4637-b9f8-996aacd3bd71"
            });
            </script>
        </div>
        <div class="hr m0"></div>
    </div>
    <div class="main_width steps txt">
        <h4 class="h5 center">How it works:</h4>
        <div class="fx ch3">
            <div>
                <img src="design/{$settings->theme|escape}/images/icons/form.svg" alt="Form">
                <p class="title">Step 1 <br> Fill out the form</p>
                <p class="text">To get pricing and availability, fill out the form on this page</p>

            </div>
            <div>
                <img src="design/{$settings->theme|escape}/images/icons/phone2.svg" alt="Interview">
                <p class="title">Step 2 <br> Have a Quick Interview</p>
                <p class="text">Schedule a time to talk or fill out our interview form</p>
            </div>
            <div>
                <img src="design/{$settings->theme|escape}/images/icons/house.svg" alt="Move-in house">
                <p class="title">Step 3 <br> Move-in!</p>
                <p class="text">You`re all set! We’re excited to welcome you to one of our coliving spaces here in NYC!</p>
            </div>
        </div>
        
    </div>  
    

