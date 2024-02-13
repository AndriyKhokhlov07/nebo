{* Sure *}
{$apply_button_hide=1 scope=parent}
{$members_menu=0 scope=parent}
{$preloader=true scope=parent}


{$meta_title='Sure' scope=parent}
<link href="/design/outpost/css/sure.css" rel="stylesheet">

{$javascripts[]="design/`$settings->theme`/js/sure/purchase.js?v.1.0.1" scope=parent}

<style>
    div.agreement {
        display: inline-block;
        align-items: center;
    }
    div.agreement div {
        margin-right: 10px;
        display: inline-block;
        max-width: 500px;
        height: 40px;
        vertical-align: middle;
    }
    div.agreement div a{
        color: blue;
    }
    .error_info{
        background: #1c1c1c;
        border-radius: 6px;
        color: #ff8484;
        font-family: 'futura_l';
        padding: 15px;
        margin: 40px 0;
    }
</style>

<div class="sure">
    <form id="renters-purchase" method="post">
        <div class="form-section">
            <h2 class="sf_title">Payment method</h2>
            {if $error}
                <div class="error_info">
                    Something went wrong. Please contact customer service.
                </div>
            {/if}
            <div class="sure_form qira">
                <input type="text" name="stripe_token" style="display: none">
{*                <div class="input_block">*}
{*                    <span><label for="cardName">Cardholder Name</label></span>*}
{*                    <input name="cardName" placeholder="Name on card" required>*}
{*                </div>*}
{*                <hr class="hr-line">*}
                <div class="form-block">
                    <span><label>Card Owner</label></span>
                    <div class="sf">
                        <div class="input_block_l">
                            <input name="first_name" type="text" maxlength="30" placeholder="First Name" required>
                        </div>
                        <div class="input_block_r">
                            <input name="last_name" type="text" maxlength="30" placeholder="Last Name" required>
                        </div>
                    </div>
                    <div class="sf">
                        <div class="input_block">
                            <input name="email" type="email" placeholder="Email" required>
                        </div>
                    </div>
                </div>
                <hr class="hr-line">
                <div class="form-block">
                    <span><label>Cardholder Address</label></span>
                    <div class="sf">
                        <div class="input_block_l">
                            <input name="streetAddress" type="text" maxlength="30" placeholder="Address Line 1" required>
                        </div>
                        <div class="input_block_r">
                            <input name="unit" type="text" maxlength="30" placeholder="Address Line 2 (optional)">
                        </div>
                    </div>
                    <div class="sf">
                        <div class="input_block_l">
                            <input name="city" type="text" maxlength="30" placeholder="City" required>
                        </div>
                        <div class="input_block_r">
                            <input name="region" type="text" maxlength="30" placeholder="State/Province/Region" required>
                        </div>
                    </div>
                </div>
                <hr class="hr-line">
                <div class="form-block">
                    <span><label>Card Details</label></span>
                    <div class="input_block_card" data-key="{$stripe_key}">
{*                        <input type="text" name="card_number" placeholder="Card number">*}
{*                        <input type="text" name="card_exp_month" placeholder="MM" style="width: 35px">/*}
{*                        <input type="text" name="card_exp_year" placeholder="YY" style="width: 35px; margin-right: 60px;">*}
{*                        <input type="text" name="card_cvc" placeholder="CVC">*}

                        <input type="text" name="card_number" placeholder="Card number" value="">
                        <div>
                            <input type="text" name="card_exp_month" placeholder="MM" style="width: 35px" value="">/
                            <input type="text" name="card_exp_year" placeholder="YYYY" value="">
                            <input type="text" name="card_cvc" placeholder="CVC" value="">
                        </div>

                        {*                        <input type="tel" name="cardNumber" placeholder="Card number" value="">*}
{*                        <input type="tel" name="expiration" placeholder="MM/YY"  value="">*}
{*                        <input type="tel" name="cardCvv" placeholder="CVC"  value="">*}
                    </div>
                </div>
                <hr class="hr-line">
                <div class="form-block agreement">
                    <div>
                        <input type="checkbox" name="agreement">
                    </div>
                    <div>
                        <label>
                            I acknowledge that I have read and understand all applicable
                            <a href="https://sure-media.s3.amazonaws.com/html/assurant-disclosures.html" target="_blank" rel="noopener noreferrer">
                                state disclosures, fraud notices, the notice of cancellation
                            </a>,
                            and the
                            <a href="https://sure-media.s3.amazonaws.com/html/assurant-electronic-business-consent.html" target="_blank" rel="noopener noreferrer">
                                electronic business consent
                            </a>.
                        </label>
                    </div>
                </div>
            </div>
            <div class="form-block-button">
                <div class="button_block">
{*                    <button class="button-back">Back</button>*}
                    <button class="button-next" disabled>Complete Your Order</button>
                </div>
            </div>
        </div>
        <div class="sure_logo">
            <img src="/design/{$settings->theme|escape}/images/logos/assurant_logo.png" alt="Assurant Logo">
            <p>Assurant is the holding company for various underwriting entities that provide Renters Insurance. In all states, except Minnesota and Texas, Renters Insurance is underwritten by American Bankers Insurance Company of Florida with its home office in Miami, Florida (ABIC NAIC# 10111). In Minnesota, the underwriter is American Security Insurance Company. In Texas, the renters property insurance is underwritten by Ranchers and Farmers Mutual Insurance Company. Each insurer has sole responsibility for its own products. In Utah, coverage is provided under policy form AJ8850PC-0307. Sold by Sure HIIS Insurance Services, LLC.</p>
        </div>
        <div class="sure_logo">
            <img src="/design/{$settings->theme|escape}/images/logos/sure_logo.png" alt="Sure Logo">
            <p> Content and associated insurance products are provided by Sure HIIS Insurance Services, LLC (“Sure”), a licensed seller of insurance. The above does not in any way constitute an endorsement or referral by Outpost Club. Products may not be offered in all states.</p>
        </div>
    </form>
</div>