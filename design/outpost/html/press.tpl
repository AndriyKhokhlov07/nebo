{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}

{*
<div class="main_width page_wrap center">
	<h1 class="h1">{$page->header}</h1>
	<h5 class="h5">We'd be happy to speak with you, just fill out the form below</h5>
	<hr class="hr m0">
</div>
*}
<div class="main_width press">
    <div class="press_form">
        <!--[if lte IE 8]>
        <script charset="utf-8" type="text/javascript" src="//js.hsforms.net/forms/v2-legacy.js"></script>
        <![endif]-->
        <script charset="utf-8" type="text/javascript" src="//js.hsforms.net/forms/v2.js"></script>
        <script>
          hbspt.forms.create({
            portalId: "4068949",
            formId: "5a499813-0ec3-4c59-9ea7-5f43413ff61d"
        });
        </script>
    </div>
	<hr class="hr m0">
</div>
<div class="main_width">
	<h6 class="h5">If you want to know more about us check out our blog:</h6>
	<a href="blog" class="button1 black">Blog</a>
	<hr class="hr m0">
</div>
<div class="main_width center find_us">
	<h6 class="h1">Find us on</h6>
    <div class="fx c w vc ch3 partners_slider">
    	<div class="item">
    		<a href="https://medium.com/qwerkycoliving/the-worlds-first-coliving-conference-co-liv-review-85e8d1a7ac09" target="_blank" rel="nofollow">
    			<img src="design/{$settings->theme|escape}/images/icons/medium.svg" alt="Medium">
    		</a>
        </div>
        <div class="item">
        	<a href="https://coliving.com/blog/breaking-the-preconceived-notions-of-coliving" target="_blank" rel="nofollow">
        		<img src="design/{$settings->theme|escape}/images/icons/coliving_logo.svg" alt="Coloving">
        	</a>
        </div>
        <div class="item">
        	<a href="https://soundcloud.com/dislocationnyc/dislocation-episode-1-coliving" target="_blank" rel="nofollow">
        		<img src="design/{$settings->theme|escape}/images/dislocation.jpg" alt="Dislocation">
        	</a>
        </div>
    	<div class="item">
    		<a href="http://au.blurb.com/" target="_blank" rel="nofollow">
        		<img src="design/{$settings->theme|escape}/images/blurb-logo.png" alt="Blurb">
        	</a>
    	</div>
    </div>
</div>