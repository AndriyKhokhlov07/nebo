{if $next_step_link}
<div class="step fx c">
    <a href="{$next_step_link}" class="button_red" data-timer="10">Next step</a>
</div>
{/if}

<div class="steps_sell ch4">

    <div class="item{if $active_step>0} active{/if}">
        <div class="img">Step 1</div>
        {* <img src="design/{$settings->theme|escape}/images/icons/id.svg" alt="Background check"> *}
        <p class="title">Application</p>
    </div>

    <div class="item{if $active_step>1} active{/if}">
        <div class="img">Step 2</div>
        <p class="title">Application Fee</p>
    </div>

    <div class="item{if $active_step>2} active{/if}">
        <div class="img">Step 3</div>
        <p class="title">Guarantor Agreenemt</p>
    </div>

    <div class="item{if $active_step>3} active{/if}">
        <div class="img">Step 4</div>
        <p class="title">Download document</p>
    </div>

</div><!-- steps_sell -->


<br>
<br>