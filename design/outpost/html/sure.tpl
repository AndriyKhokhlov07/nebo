{* Sure *}
{$apply_button_hide=1 scope=parent}
{$members_menu=0 scope=parent}


{$meta_title='Sure' scope=parent}

{$js_include="design/`$settings->theme`/js/plans.js" scope=parent}
<div class="sure">

	<div>
		<iframe id="iFrameID" src="https://partner.trysureapp.com/embed/v1/_renters?first_name={$user->first_name|escape}&last_name={$user->last_name|escape}&email={$user->email|escape}&customID={$user->id}" style="display: block; border: 0px; margin: 0 auto; width: 100%; height: auto; min-height: 100vh; height: auto;  max-width: 600px;"></iframe>
	</div>

	<div class="disclaimer">
		<div class="text">
			<p>Content and associated insurance products are provided by Sure HIIS Insurance Services, LLC(“Sure”), a licensed seller of insurance. The above does not in any way constitute an endorsement orreferral by ​[ThePartner]​​ of Sure’s products or services.</p>
			<span class="button red">Apply</span>
		</div>
	</div>
	<div class="disclaimer2">
		<div>
			<p class="title center">Policies issued by</p>
			<div class="fx c">
				<img src="/design/{$settings->theme|escape}/images/assurant.png" alt="Assurant">
			</div>
			<p>Assurant is the holding company for various underwriting entities that provide Renters Insurance. In allstates, except Minnesota and Texas, Renters Insurance is underwritten by American BankersInsurance Company of Florida with its home office in Miami, Florida (ABIC NAIC# 10111). InMinnesota, the underwriter is American Security Insurance Company. In Texas, the renters propertyinsurance is underwritten by Ranchers and Farmers Mutual Insurance Company. Each insurer hassole responsibility for its own products. In Utah, coverage is provided under policy formAJ8850PC-0307. Sold by Sure HIIS Insurance Services, LLC.</p>
		</div>
	</div>
</div>





