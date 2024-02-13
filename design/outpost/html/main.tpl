{* Главная страница *}

{* Для того чтобы обернуть центральный блок в шаблон, отличный от index.tpl *}
{* Укажите нужный шаблон строкой ниже. Это работает и для других модулей *}
{$wrapper = 'index.tpl' scope=parent}

{* Канонический адрес страницы *}
{$canonical="" scope=parent}

{$this_page='home' scope=parent}


<div class="home_block fx v c">

	<div class="wrapper">

		<div class="nb_logo">
			<img src="/design/{$settings->theme|escape}/images/nebo_logo_w.svg" alt="NeBo">
		</div>

		<p class="txt">Ne-Bo is a platform designed for co-living spaces to manage their tenant workflow, from lease signing to membership programs and payments.</p>

		
		<div class="partners main_width fx w">

            <a href="http://bit.ly/3aTrPUn" target="_blank">
                <img src="/design/{$settings->theme|escape}/images/logos/outpost_w.svg" alt="Outpost">
            </a>
            <a href="http://bit.ly/2te6ZhA" target="_blank">
                <img src="/design/{$settings->theme|escape}/images/logos/business_travelers_w.svg" alt="Business Travelers">
            </a>
            <a href="http://bit.ly/2ObNyNu" target="_blank">
                <img src="/design/{$settings->theme|escape}/images/logos/internhousingnyc_w.svg" alt="Intern Housing NYC">
            </a>
            <a href="http://bit.ly/2u4CMSl" target="_blank">
                <img src="/design/{$settings->theme|escape}/images/logos/bedly.svg" alt="Bedly">
            </a>

        </div><!-- partners -->

        {if $user->type == 4}
        <a class="login" href="/landlord">Log In</a>
        {else}
        <a class="login" href="/current-members">Log In</a>
        {/if}


	</div><!-- wrapper -->

	<div class="cop_bx fx sb">
		{* <div class="cop">2021 © Ne-Bo Services Corp.</div> *}
		<div class="dev">developer hard.code</div>
	</div>
	
</div><!-- home_block -->