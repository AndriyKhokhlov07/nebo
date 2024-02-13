{* Window Guards Page *}
<!DOCTYPE html>
<html lang="en">
<head>
	<base href="{$config->root_url}/"/>
	<title>{$meta_title|escape}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="robots" content="noindex, nofollow">
	<link href="design/{$settings->theme|escape}/images/favicon.ico" rel="icon"          type="image/x-icon"/>
    <link href="design/{$settings->theme|escape}/images/favicon.ico" rel="shortcut icon" type="image/x-icon"/>

    <link href="design/{$settings->theme|escape}/fonts/fa/font-awesome.min.css?v4.7.0" rel="stylesheet">
    <link href="design/{$settings->theme|escape}/css/rental.css?v1.0.20" rel="stylesheet">

    <link href="design/{$settings->theme|escape}/css/contracts.css?v1.0.20" rel="stylesheet">



    <script type="text/javascript" src="design/{$settings->theme}/js/signature_pad.umd.js"></script>
    {if $smarty.get.success=='sended'}
    <script src="js/jquery/jquery.js?v1.0.0"></script>
    {/if}
</head>
<body data-type="{$contract_info->type}" id="body">

{if $salesflow->type == 3} 
  {$next_step_link = "user/covid_form/{$user->auth_code}"}
{/if}
{if $smarty.get.success=='sended'}
	<div class="page v_signed">
{else}
	<div class="page main_width">
{/if}
	{if $smarty.get.success=='sended'}
	<div class="signed_block">
			<h1 class="bold_h1 center">Thank You!</h1>
		<div class="txt">
			<div class="txt">
				{if $salesflow->type == 3}
					{$active_step=2}
					{$steps_type = 'hotel'}
					{include file='bx/steps_apps.tpl'}
					<br>
				{/if}
				<p class="center">Questions? Contact Outpost Club Inc at <a href="mailto:info@outpost-club.com">info@outpost-club.com</a> or call at <a href="tel:+18337076611">+1 (833) 707-6611</a>.</p>
			</div>
		</div>
	</div>
	</div>
	{else}
		<form class="signature_form" name="window_guards" method="POST" enctype="multipart/form-data">

			<div class="check_wrapper">
				{$childno_checked=1}
				{include file='cassa_house_rules/html.tpl'}


				{if !$signature && !$smarty.session.admin}
				<div class="signature_block" id="signature_block">
			        <p class="signature_title">Signature:</p>
			    	<div class="wrapper">
			    		<canvas id="signature-pad" class="signature-pad" width=460 height=240></canvas>
			    	</div>
			        <input id="signature" class="required" type="hidden" name="signature" value="">
			        <div class="button_block">
			            <div id="clear" class="clear">Clear</div>
			            <div id="save" class="save">Sign and Save</div>
			        </div>
			    </div><!-- signature_block -->
			    <div id="signature_img"></div>
			    {else}
			    {/if}

			</div><!-- check_wrapper -->



		</form>

{literal}
<script>
var signature = 0;
var canvas = document.getElementById('signature-pad');

function resizeCanvas() {
    canvas.width = canvas.offsetWidth;
    canvas.height = canvas.offsetHeight;
}

resizeCanvas();

var signaturePad = new SignaturePad(canvas, {
  backgroundColor: 'rgb(255, 255, 255)', // necessary for saving image as JPEG; can be removed is only saving as PNG or SVG
  penColor: 'rgb(1, 31, 117)'
});

document.getElementById('save').addEventListener('click', function () {

		var body = document.getElementById('body');
	    // var type = body.getAttribute("data-type");

	    if(signaturePad.isEmpty())
	    {
	        return alert("Please provide a signature first");
	    }

	    // var el_page = document.getElementById('page');
	    // el_page.classList.add('sending');

	    var data = signaturePad.toDataURL('image/png');
	    var img_data = canvas.toDataURL('image/png');
	    document.getElementById('signature_img').innerHTML += '<img src="'+img_data+'" width="240" />';
	    document.getElementById('signature_block').hidden = true;
	    document.getElementById('signature').value = img_data;

	    signaturePad.clear();
	    delete data;
	    delete img_data;
	    delete signaturePad;
	    signature = 1;
	    delete canvas;

	    document.forms["window_guards"].submit();
});

document.getElementById('clear').addEventListener('click', function () {
	signaturePad.clear();
});


</script>
{/literal}


	{/if}

{if $smarty.get.success=='sended'}
{literal}
<script>
$(function() {
function tm(el, t){
  setTimeout(()=>{
    if(t > 0){
      el.find('.tcount').text(t);
      t = t-1;
      tm(el, t);
    }
    else{
      window.location.replace(el.attr('href'));
    }
  }, 1000);
}

$('a[data-timer]').each(function(){
  let t = parseInt($(this).data('timer'))
  $(this).append($('<span class="tcount">'+t+'</span>'));
  tm($(this), t);
});
});
</script>
{/literal}
{/if}

</div>



</body>