{* Sure *}
{$apply_button_hide=1 scope=parent}
{$members_menu=0 scope=parent}
{$preloader=true scope=parent}

{$meta_title='Sure' scope=parent}
<link href="/design/outpost/css/sure.css" rel="stylesheet">

{$javascripts[]="design/`$settings->theme`/js/sure/checkout.js?v.1.0.1" scope=parent}

<div class="sure">
    <form id="renters-quote" method="post" params="{$json_params}">
        <div class="form-section">
            <div class="sure_form">
                <div class="form-block quote-title">
                    <input name="plan_id" value="{$params->plan_id}" style="display: none">
                    <input name="quote_id" value="{$params->quote_id}" style="display: none">
                    <div class="annual" tag="annual"{if $params->payment_cadence != 'annual'} style="display: none;"{/if}>
                        <a href="https://s3.amazonaws.com/sure-production-connect-media/pdf/policy/8c75e/4baf5/5995ccdd4600a0040c48699e/policy.pdf">View Sample Policy</a>
                        <h2 class="p_title">Your Renters Quote</h2>
                        <h2 class="payment downpayment"><span>$ {number_format($payments['annual']['downpayment_amount'], 2, '.', ',')}</span>/year</h2>
                    </div>
                    <div class="eleven_pay" tag="eleven_pay"{if $params->payment_cadence != 'eleven_pay'} style="display: none;"{/if}>
                        <a href="https://s3.amazonaws.com/sure-production-connect-media/pdf/policy/8c75e/4baf5/5995ccdd4600a0040c48699e/policy.pdf">View Sample Policy</a>
                        <h2 class="p_title">First Payment</h2>
                        <h2 class="payment downpayment"><span>$ {number_format($payments['eleven_pay']['downpayment_amount'], 2, '.', ',')}</span></h2>
                        <h3 class="h3_style">Followed by 10 monthly payments</h3>
                        <h2 class="payment installment"><span>$ {number_format($payments['eleven_pay']['full_installment_amount'], 2, '.', ',')}</span>/month</h2>
                        <i>(Billing Fees Included)</i>
                    </div>
                </div>
                <div class="sticky_line"></div>
                <div class="sticky_unline"></div>

                <div class="form-block">
                    <div class="select_block_payment">
                        <div class="sure_select">
                            <select name="payment_cadence">
                                <option value="annual"{if $params->payment_cadence === 'annual'} selected{/if}>Annual (1 payment)</option>
                                <option value="eleven_pay"{if $params->payment_cadence === 'eleven_pay'} selected{/if}>Monthly (11 payments)</option>
                            </select>
                        </div>
                    </div>
                    <hr class="hr-line">
                    <div class="input_block">
                        <span><label for="policy_effective_date">Start date</label></span>
                        <input name="policy_effective_date" type="date" required value="{$params->policy_effective_date}">
                        <p class="select_note">The date you want your policy to take effect.</p>
                    </div>
                    <hr class="hr-line">
                    <div class="select_block">
                        <span><label for="personal_property_coverage">Personal Property</label></span>
                        <div class="sure_select">
                            <select name="personal_property_coverage">
                                {foreach $personal_property as $item}
                                    {if $params->all_peril_deductible == $item->all_peril_deductible}
                                        <option
                                                value="{$item->personal_property_coverage}"
                                                apd="{$item->all_peril_deductible}"
                                                {if $params->all_peril_deductible != $item->all_peril_deductible} style="display: none;"
                                                {elseif $params->personal_property_coverage == $item->personal_property_coverage} selected{/if}
                                        >
                                            $ {number_format($item->personal_property_coverage, 0, '.', ',')}
                                        </option>
                                    {/if}
                                {/foreach}
                            </select>
                        </div>
                        <p class="select_note">Personal Property coverage pays for your personal belongings if they are damaged anywhere in the world as a result of various named perils. Some examples are: fire or lightning, windstorm or hail, explosion, smoke, vandalism or malicious mischief, theft, accidental discharge or overflow of water or steam. For a detailed listing of covered perils, please refer to the policy</p>
                    </div>
                    <hr class="hr-line">
                    <div class="select_block">
                        <span><label for="all_peril_deductible">Deductible</label></span>
                        <div class="sure_select">
                            <select name="all_peril_deductible">
                                {foreach $personal_property as $item}
                                    {if $params->personal_property_coverage == $item->personal_property_coverage}
                                        <option
                                                value="{$item->all_peril_deductible}"
                                                ppc="{$item->personal_property_coverage}"
                                                {if $params->personal_property_coverage != $item->personal_property_coverage} style="display: none"
                                                {elseif $params->all_peril_deductible == $item->all_peril_deductible} selected{/if}
                                        >
                                            $ {number_format($item->all_peril_deductible, 0, '.', ',')}
                                        </option>
                                    {/if}
                                {/foreach}
                            </select>
                        </div>
                        <p class="select_note">The deductible is the per-occurrence portion of your loss that you are financially responsible for paying before the insurance carrier pays the rest of your claim. The higher the deductible, the lower your premium.</p>
                    </div>
                    <hr class="hr-line">
                    <div class="select_block">
                        <span><label for="liability_limit">Personal Liability</label></span>
                        <div class="sure_select">
                            <select name="liability_limit">
                                {foreach $liability as $item}
                                    <option
                                            value="{$item->liability_limit}"
                                            {if $params->liability_limit == $item->liability_limit} selected{/if}
                                    >
                                        $ {number_format($item->liability_limit, 0, '.', ',')}
                                    </option>
                                {/foreach}
                            </select>
                        </div>
                        <p class="select_note">Liability coverage protects you in the event of bodily injury or damage to someone else's property for which you are legally liable. The liability coverage has no deductible. This coverage pays the property manager/owner for damages to the unit caused by you as a result of the following perils: Fire, water damage, smoke, and explosion. Your policy also covers damages to your neighbor's property, up to the policy limit, if you are negligent. In addition, liability coverage will also pay medical expenses up to the policy limits, in the event a guest is injured in your apartment.</p>
                    </div>
                    <hr class="hr-line">
                    <div class="select_block">
                        <span><label for="loss_of_use">Loss of Use</label></span>
                        <div class="sure_select">
                            <select name="loss_of_use" disabled>
                                <option value="true" selected>Included</option>
                                <option value="false">Not Included</option>
                            </select>
                        </div>
                        <p class="select_note">If your property becomes unlivable, costs relating to housing and increased living expenses will be covered.</p>
                    </div>
                    <hr class="hr-line">
                    <div class="select_block">
                        <span><label for="include_replacement_cost">Replacement Cost</label></span>
                        <div class="sure_select">
                            <select name="include_replacement_cost">
                                <option value="false"{if !$params->include_replacement_cost} selected{/if}>Not Included</option>
                                <option value="true"{if $params->include_replacement_cost} selected{/if}>Included</option>
                            </select>
                        </div>
                        <p class="select_note">If your personal property is damaged by a covered peril we will pay the cost of replacement of the item without deduction for depreciation (what it was worth when you bought it). The item(s) must first be replaced before the full replacement cost can be paid.</p>
                    </div>
                    <hr class="hr-line">
                    <div class="select_block">
                        <span><label for="include_water_backup">Sewer or Drain Backup</label></span>
                        <div class="sure_select">
                            <select name="include_water_backup">
                                <option value="false"{if !$params->include_water_backup} selected{/if}>Not Included</option>
                                <option value="true"{if $params->include_water_backup} selected{/if}>Included</option>
                            </select>
                        </div>
                        <p class="select_note">This coverage pays for damage to your personal property as a result of water backup of sewers or drains. The maximum benefit for this endorsement is $2,500 for each "occurrence". In North Carolina the maximum benefit is $5,000. In Maryland, the maximum benefit is equal to the personal property limit selected. In all states a $250 deductible applies.</p>
                    </div>
                    <hr class="hr-line">
                    <div class="select_block">
                        <span><label for="include_identity_fraud">Identity Fraud</label></span>
                        <div class="sure_select">
                            <select name="include_identity_fraud">
                                <option value="false"{if !$params->include_identity_fraud} selected{/if}>Not Included</option>
                                <option value="true"{if $params->include_identity_fraud} selected{/if}>Included</option>
                            </select>
                        </div>
                        <p class="select_note">Identity Fraud Expense Coverage is an endorsement to the Renters Insurance program that helps cover the cost and time it will take to restore your identity. These "expenses" include, but are not limited to, attorney's fees and loss of income, up to $5,000, as a result of time taken off work to talk with law enforcement agencies and credit agencies. Having Identity Fraud Expense Coverage can reimburse you up to $15,000 for expenses as a direct result of identity fraud. Identity theft and fraud refers to the use of wrongfully obtaining someone else's personal information and using it in a way that includes deception, usually for an economic gain. Identity theft can include stealing your bank account number or credit card number, which can lead to large financial and credibility loss.</p>
                    </div>
                </div>
            </div>
            <div class="form-block-button">
                <div class="button_block">
{*                    <button class="button-back">Back</button>*}
                    <button class="button-next">Submit</button>
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
