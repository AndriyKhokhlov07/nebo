{if $steps_type=='bg_check' && ($active_step == 2 || $active_step == 1)}
<div class="txt center">
  <p>Outpost Club assumes that by paying the security deposit, you, the tenant applicant, are fully committed to staying the property you are paying for. Therefore, if you decide to cancel after paying security deposit and signing the lease agreement, Outpost Club reserves the right to keep your security deposit under the following conditions: If you need to cancel more than 60 days before your arrival, you will be refunded your entire first month’s rent and your entire security deposit. If you need to cancel between 30 days before your arrival, you will receive your payment for the first month's rent back (minus fees). If you cancel less than 30 days before your arrival, you will receive no refund. If you pay for your security deposit, but have not signed your lease agreement, you are entitled to a full refund of your security deposit, but please keep in mind that your spot is not secured until you've completed the steps (including signing your lease) and therefore someone else may rent the room you have chosen.</p>
</div>
<br>
{/if}
{if $next_step_link}
  {$is_params = $next_step_link|strpos:'?'}
	<div class="step fx c">
		<a href="{$next_step_link}{if $is_params}&{else}?{/if}{if $salesflow}s={$salesflow->id}{/if}" class="button_red" >Next step</a>
	</div>
{/if}

{if $steps_type == ''}
<div class="steps_sell ch3">

	<div class="item{if $active_step>0} active{/if}">
	    <div class="img">Step 1</div>
	    <img src="design/{$settings->theme|escape}/images/icons/id.svg" alt="Rental Application">
	    <p class="title">Rental Application</p>
	</div>

	<div class="item{if $active_step>1} active{/if}">
	    <div class="img">Step 2</div>
	    <img src="design/{$settings->theme|escape}/images/icons/invoice.svg" alt="Rental Application Fee">
	    <p class="title">Rental Application Fee</p>
	</div>

	{if !$steps_count || $steps_count>2}
	<div class="item{if $active_step>2} active{/if}">
	    <div class="img">Step 3</div>
	    <img src="design/{$settings->theme|escape}/images/icons/invoice.svg" alt="Prepayment for the first month">
	    <p class="title">Prepayment for the first month</p>
	</div>
	{/if}

</div><!-- steps_sell -->
{elseif $steps_type=='bg_check'}
<div class="steps_sell ">
    {if !$contract && $contract_info}
      {$contract = $contract_info}
    {/if}
    {if $active_step<4}
    <div class="item{if $active_step>0} active{/if}">
      <div class="img">Step 1</div>
      <img src="design/{$settings->theme|escape}/images/icons/id.svg" alt="Background check">
      <p class="title">Rental application</p>
    </div>
    {if $steps_count>2}
    <div class="item{if $active_step>1} active{/if}">
        <div class="img">Step 2</div>
        <img src="design/{$settings->theme|escape}/images/icons/invoice.svg" alt="Rental Application Fee">
        <p class="title">Rental Application Fee</p>
    </div>
    {/if}
    <div class="item{if $active_step>2} active{/if}">
      <div class="img">Step 3</div>
      <img src="design/{$settings->theme|escape}/images/icons/invoice.svg" alt="invoice">
      {*<p class="title">{if $contract->price_deposit > 0 && $contract->outpost_deposit == 1}Security Deposit{else}Deposit by Qira{/if}</p>*}
      <p class="title">Deposit</p>
    </div>
    {/if}

    {if $active_step>3}
    <div class="item{if $active_step>3} active{/if}">
      <div class="img">Step 1</div>
      <img src="design/{$settings->theme|escape}/images/icons/contract.svg" alt="Contract">
      <p class="title">Contract</p>
    </div>
    <div class="item{if $active_step>4} active{/if}">
      <div class="img">Step 2</div>
      <img src="design/{$settings->theme|escape}/images/icons/contract.svg" alt="Covid form">
      <p class="title">Covid form</p>
    </div>
    <div class="item{if $active_step>5} active{/if}">
      <div class="img">Step 3</div>
      <img src="design/{$settings->theme|escape}/images/icons/invoice.svg" alt="invoice">
      <p class="title">First month`s rent</p>
    </div>
    <div class="item{if $active_step>6} active{/if}">
      <div class="img">Step 4</div>
      <img src="design/{$settings->theme|escape}/images/icons/user.svg" alt="invoice">
      <p class="title">Insurance</p>
    </div>
    {/if}
</div>
{elseif $steps_type=='covid'}
<div class="steps_sell">
  	<div class="item{if $active_step>0} active{/if}">
    	<div class="img">Step 1</div>
    	<img src="design/{$settings->theme|escape}/images/icons/contract.svg" alt="Covid form">
    	<p class="title">Covid form</p>
  	</div>
  	{if !$contract && $contract_info}
  		{$contract = $contract_info}
  	{/if}
  	{if $contract->type != 3}
  	<div class="item{if $active_step>1} active{/if}">
   		<div class="img">Step 2</div>
    	<img src="design/{$settings->theme|escape}/images/icons/id.svg" alt="Background check">
    	<p class="title">Background check</p>
  	</div>
  	{else}
  		{$active_step = $active_step-1}
  	{/if}
  	<div class="item{if $active_step>2} active{/if}">
    	<div class="img">Step {if $contract->type != 3}3{else}2{/if}</div>
    	<img src="design/{$settings->theme|escape}/images/icons/contract.svg" alt="Contract">
    	<p class="title">Contract</p>
  	</div>
  	<div class="item{if $active_step>3} active{/if}">
    	<div class="img">Step {if $contract->type != 3}4{else}3{/if}</div>
    	<img src="design/{$settings->theme|escape}/images/icons/invoice.svg" alt="invoice">
    	<p class="title">First month`s rent</p>
  	</div>

  	<div class="item{if $active_step>4} active{/if}">
    	<div class="img">Step {if $contract->type != 3}5{else}4{/if}</div>
    	<img src="design/{$settings->theme|escape}/images/icons/invoice.svg" alt="invoice">
    	<p class="title">{if $contract->price_deposit > 0 && $contract->outpost_deposit == 1}Security Deposit{else}Deposit by Qira{/if}</p>
 	</div>
</div>
{elseif $steps_type=='airbnb'}
<div class="steps_sell">
    <div class="item{if $active_step>0} active{/if}">
      <div class="img">Step 1</div>
      <img src="design/{$settings->theme|escape}/images/icons/id.svg" alt="Background check">
      <p class="title">Rental application</p>
    </div>
    <div class="item{if $active_step>1} active{/if}">
      <div class="img">Step 2</div>
      <img src="design/{$settings->theme|escape}/images/icons/contract.svg" alt="Covid form">
      <p class="title">Covid form</p>
    </div>
</div>
{elseif $steps_type=='hotel'}
<div class="steps_sell">
    <div class="item{if $active_step>0} active{/if}">
      <div class="img">Step 1</div>
      <img src="design/{$settings->theme|escape}/images/icons/id.svg" alt="Background check">
      <p class="title">Rental application</p>
    </div>
    <div class="item{if $active_step>1} active{/if}">
      <div class="img">Step 2</div>
      <img src="design/{$settings->theme|escape}/images/icons/contract.svg" alt="House Rules form">
      <p class="title">House Rules form</p>
    </div>
    <div class="item{if $active_step>2} active{/if}">
      <div class="img">Step 3</div>
      <img src="design/{$settings->theme|escape}/images/icons/contract.svg" alt="Covid form">
      <p class="title">Covid form</p>
    </div>
    <div class="item{if $active_step>3} active{/if}">
      <div class="img">Step 4</div>
      <img src="design/{$settings->theme|escape}/images/icons/invoice.svg" alt="deposit">
      <p class="title">Deposit</p>
    </div>
    <div class="item{if $active_step>4} active{/if}">
      <div class="img">Step 5</div>
      <img src="design/{$settings->theme|escape}/images/icons/invoice.svg" alt="invoice">
      <p class="title">first rent invoice</p>
    </div>
</div>
{elseif $steps_type=='hotel_airbnb'}
<div class="steps_sell">
    <div class="item{if $active_step>0} active{/if}">
      <div class="img">Step 1</div>
      <img src="design/{$settings->theme|escape}/images/icons/id.svg" alt="Background check">
      <p class="title">Rental application</p>
    </div>
    <div class="item{if $active_step>1} active{/if}">
      <div class="img">Step 2</div>
      <img src="design/{$settings->theme|escape}/images/icons/invoice.svg" alt="Taxes">
      <p class="title">Taxes</p>
    </div>
    <div class="item{if $active_step>2} active{/if}">
      <div class="img">Step 3</div>
      <img src="design/{$settings->theme|escape}/images/icons/contract.svg" alt="Covid form">
      <p class="title">Covid form</p>
    </div>
</div>
{elseif $steps_type=='hotel_airbnb_no_tax'}
<div class="steps_sell">
    <div class="item{if $active_step>0} active{/if}">
      <div class="img">Step 1</div>
      <img src="design/{$settings->theme|escape}/images/icons/id.svg" alt="Background check">
      <p class="title">Rental application</p>
    </div>
    <div class="item{if $active_step>2} active{/if}">
      <div class="img">Step 2</div>
      <img src="design/{$settings->theme|escape}/images/icons/contract.svg" alt="Covid form">
      <p class="title">Covid form</p>
    </div>
</div>
{/if}