{* Contract Page *}

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

		<link href="design/{$settings->theme|escape}/css/contracts.css?v1.0.23" rel="stylesheet">

		<script src="js/jquery/jquery.js?v1.0.0"></script>
		<script type="text/javascript" src="design/{$settings->theme}/js/signature_pad.umd.js"></script>

</head>
<body data-type="{$contract_info->type}" id="body">






<div id="page" class="page{if $contract_info->signature && !$smarty.get.w} v_signed{/if}">
{if $contract_info->signature && !$smarty.get.w}

		<div class="signed_block">
				<p class="title">Thank You!</p>
				<div class="txt">
					{*<p>Your signed contract will be available after receiving payments and after background check within 1-7 days in your personal cabinet on <a href="{$config->root_url}/">ne-bo.com</a></p>*}
						<p>
							Your signed contract will be available in your tenant portal at <a href="{$config->root_url}/">ne-bo.com</a> 
							{if $booking->client_type_id != 2}
								within 1-7 days of Outpost  Club receiving your payment.
							{/if}
						</p>
						{if $is_airbnb_contract}
							{*<p>We will send your an email and ask to sign up a lease agreement and a COVID waiver.</p>*}
						{/if}
					{if $contract_info->sellflow == 1 || $salesflow->type==1}
						{$active_step=4}
						{$steps_type='bg_check'}
						{* {$next_step_link = "user/covid_form/{$contract_user->auth_code}?c={$contract_info->id}"}*}
						{if $invoice && $booking->client_type_id != 2}
							{$next_step_link = "order/{$invoice->url}?u={$user->id}"}
						{/if}
						{include file='bx/steps_apps.tpl'}
					{/if}
					
					<p class="center">Questions? Contact Outpost Club Inc at <a href="mailto:info@outpost-club.com">info@outpost-club.com</a> or call at <a href="tel:+18337076611">+1 (833) 707-6611</a>.</p>
					
				</div>
				{*
				{if $sended}
						<p class="sended_info">Done</p>
				{else}
						<form class="send_form" method="post">
								<input name="email_notify" type="email" required value="{$contract_user->email|escape}" placeholder="Your email">
								<button>Send</button>
						</form>
				{/if}
				*}
				
		</div><!-- signed_block -->

		{*
		<script src="js/jquery/jquery.js?v1.0.0"></script>
		{literal}
		{/literal}
		*}



{else}

	{*  

	Contracts types ON: 1, 3, 5
	
	*}

	{*
		{if $contract_info->membership==1}
				{include file='contracts/contract_gold_html.tpl'}
		{else}
				{include file='contracts/contract_silver_html.tpl'}
		{/if}
	*}

	{* {if !$contract_info->signature && $booking->client_type_id != 2} *}
	{if !$contract_info->signature}
		<form class="signature_form" name="signature_form" method="POST" enctype="multipart/form-data">
	{/if}


	{include file="contracts/`$contracttype['tpl']`.tpl"}




	{if !$contract_info->signature && !$smarty.session.admin && $contract_info->status != 9}

		<div id="signature_block">
				<p class="signature_title">Signature:</p>
			<div class="wrapper">
				<canvas id="signature-pad" class="signature-pad" width=460 height=240></canvas>
			</div>
				{*
			<div>
				<button id="save-png">Save as PNG</button>
				<button id="save-jpeg">Save as JPEG</button>
				<button id="save-svg">Save as SVG</button>
				<button id="draw">Draw</button>
				<button id="erase">Erase</button>
				<button id="clear">Clear</button>
			</div>
				*}


				<input id="signature" type="hidden" name="signature" value="">
				<div class="button_block">
						<div id="clear" class="clear">Clear</div>
						<div id="save" class="save">Save</div>
				</div>
			
		</div><!-- signature_block -->
		<div id="signature_img"></div>

	{/if}

	{* {if !$contract_info->signing && $booking->client_type_id != 2} *}
	{if !$contract_info->signing}
		</form>
	{/if}
{/if}
</div><!-- page -->


{if $contract_info->signature}
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


{* {if !$contract_info->signature && $booking->client_type_id != 2} *}
{if !$contract_info->signature}
{literal}
<script>
$(function() {


var signature = 0;
var canvas = document.getElementById('signature-pad');

// function resizeCanvas() {
//     var ratio =  Math.max(window.devicePixelRatio || 1, 1);
//     canvas.width = canvas.offsetWidth * ratio;
//     canvas.height = canvas.offsetHeight * ratio;
//     canvas.getContext("2d").scale(ratio, ratio);
// }

function resizeCanvas() {
		canvas.width = canvas.offsetWidth;
		canvas.height = canvas.offsetHeight;
}

//window.onresize = resizeCanvas;
resizeCanvas();

var signaturePad = new SignaturePad(canvas, {
	backgroundColor: 'rgb(255, 255, 255)', // necessary for saving image as JPEG; can be removed is only saving as PNG or SVG
	penColor: 'rgb(1, 31, 117)'
});

document.getElementById('save').addEventListener('click', function () {
		
		// if(signature===0 || signature2===0 || signature3===0 || signature4===0)
		//     return alert("Please provide a all signatures first 1");
		// else if(signaturePad.isEmpty() || signaturePad2.isEmpty() || signaturePad3.isEmpty() || signaturePad4.isEmpty()) {
		//     return alert("Please provide a all signatures first");
		// }

		var body = document.getElementById('body');
		var type = body.getAttribute("data-type");
		let scrolled = 0;

		if(type == 1 || type == 3 || type == 5){

			if(signaturePad.isEmpty())
			{
				scrollTo(signaturePad.canvas);
				return alert("Please provide a all signatures first");
			}
			else if((typeof signature2 !== 'undefined') && (signature2===0 && signaturePad2.isEmpty()))
			{
				scrollTo(signaturePad2.canvas);
				return alert("Please provide a all signatures first");
			}
			else if((typeof(document.getElementById("block_agree1")) != 'undefined' && document.getElementById("block_agree1") != null && document.getElementById("agree1").checked == false) || (typeof(document.getElementById("block_agree2")) != 'undefined' && document.getElementById("block_agree2") != null && document.getElementById("agree2").checked == false) || (typeof(document.getElementById("block_agree3")) != 'undefined' && document.getElementById("block_agree3") != null && document.getElementById("agree3").checked == false) || (typeof(document.getElementById("block_agree4")) != 'undefined' && document.getElementById("block_agree4") != null) && document.getElementById("agree4").checked == false || (typeof(document.getElementById("block_agree5")) != 'undefined' && document.getElementById("block_agree5") != null && document.getElementById("agree5").checked == false) || (typeof(document.getElementById("block_agree6")) != 'undefined' && document.getElementById("block_agree6") != null && document.getElementById("agree6").checked == false) || (typeof(document.getElementById("block_agree7")) != 'undefined' && document.getElementById("block_agree7") != null && document.getElementById("agree7").checked == false) || (typeof(document.getElementById("block_agree8")) != 'undefined' && document.getElementById("block_agree8") != null && document.getElementById("agree8").checked == false) || (typeof(document.getElementById("block_agree9")) != 'undefined' && document.getElementById("block_agree9") != null && document.getElementById("agree9").checked == false) || (typeof(document.getElementById("block_agree10")) != 'undefined' &&document.getElementById("block_agree10") != null && document.getElementById("agree10").checked == false) || (typeof(document.getElementById("block_agree11")) != 'undefined' &&document.getElementById("block_agree11") != null && document.getElementById("agree11").checked == false) || (typeof(document.getElementById("block_agree12")) != 'undefined' &&document.getElementById("block_agree12") != null && document.getElementById("agree12").checked == false) || (typeof(document.getElementById("block_agree13")) != 'undefined' &&document.getElementById("block_agree13") != null && document.getElementById("agree13").checked == false) || (typeof(document.getElementById("block_agree14")) != 'undefined' &&document.getElementById("block_agree14") != null && document.getElementById("agree14").checked == false) || (typeof(document.getElementById("block_agree15")) != 'undefined' &&document.getElementById("block_agree15") != null && document.getElementById("agree15").checked == false))
			{
				scrolled = 0;
				if(document.getElementById("agree1").checked == false)
				{
					if(scrolled == 0)
					{
						document.getElementById("agree1").scrollIntoView({behavior: "smooth"});
						scrolled = 1;
					}
					document.getElementById("block_agree1").classList.add("red");
				}
				if(document.getElementById("agree2").checked == false)
				{
					if(scrolled == 0)
					{
						document.getElementById("agree2").scrollIntoView({behavior: "smooth"});
						scrolled = 1;
					}
					document.getElementById("block_agree2").classList.add("red");
				}
				if(document.getElementById("agree3").checked == false)
				{
					if(scrolled == 0)
					{
						document.getElementById("agree3").scrollIntoView({behavior: "smooth"});
						scrolled = 1;
					}
					document.getElementById("block_agree3").classList.add("red");
				}
				if(document.getElementById("agree4").checked == false)
				{
					if(scrolled == 0)
					{
						document.getElementById("agree4").scrollIntoView({behavior: "smooth"});
						scrolled = 1;
					}
					document.getElementById("block_agree4").classList.add("red");
				}
				if(document.getElementById("agree5").checked == false)
				{
					if(scrolled == 0)
					{
						document.getElementById("agree5").scrollIntoView({behavior: "smooth"});
						scrolled = 1;
					}
					document.getElementById("block_agree5").classList.add("red");
				}
				if (typeof(document.getElementById("block_agree6")) != 'undefined' && document.getElementById("block_agree6") != null)
				{
					if(document.getElementById("agree6").checked == false)
					{
						if(scrolled == 0)
						{
							document.getElementById("agree6").scrollIntoView({behavior: "smooth"});
							scrolled = 1;
						}
						document.getElementById("block_agree6").classList.add("red");
					}
				}
				if (typeof(document.getElementById("block_agree7")) != 'undefined' && document.getElementById("block_agree7") != null)
				{
					if(document.getElementById("agree7").checked == false)
					{
						if(scrolled == 0)
						{
							document.getElementById("agree7").scrollIntoView({behavior: "smooth"});
							scrolled = 1;
						}
						document.getElementById("block_agree7").classList.add("red");
					}
				}
				if (typeof(document.getElementById("block_agree8")) != 'undefined' && document.getElementById("block_agree8") != null)
				{
					if(document.getElementById("agree8").checked == false)
					{
						if(scrolled == 0)
						{
							document.getElementById("agree8").scrollIntoView({behavior: "smooth"});
							scrolled = 1;
						}
						document.getElementById("block_agree8").classList.add("red");
					}
				}
				if (typeof(document.getElementById("block_agree9")) != 'undefined' && document.getElementById("block_agree9") != null)
				{
					if(document.getElementById("agree9").checked == false)
					{
						if(scrolled == 0)
						{
							document.getElementById("agree9").scrollIntoView({behavior: "smooth"});
							scrolled = 1;
						}
						document.getElementById("block_agree9").classList.add("red");
					}
				}
				if (typeof(document.getElementById("block_agree10")) != 'undefined' && document.getElementById("block_agree10") != null)
				{
					if(document.getElementById("agree10").checked == false)
					{
						if(scrolled == 0)
						{
							document.getElementById("agree10").scrollIntoView({behavior: "smooth"});
							scrolled = 1;
						}
						document.getElementById("block_agree10").classList.add("red");
					}
				}
				if (typeof(document.getElementById("block_agree11")) != 'undefined' && document.getElementById("block_agree11") != null)
				{
					if(document.getElementById("agree11").checked == false)
					{
						if(scrolled == 0)
						{
							document.getElementById("agree11").scrollIntoView({behavior: "smooth"});
							scrolled = 1;
						}
						document.getElementById("block_agree11").classList.add("red");
					}
				}
				if (typeof(document.getElementById("block_agree12")) != 'undefined' && document.getElementById("block_agree12") != null)
				{
					if(document.getElementById("agree12").checked == false)
					{
						if(scrolled == 0)
						{
							document.getElementById("agree12").scrollIntoView({behavior: "smooth"});
							scrolled = 1;
						}
						document.getElementById("block_agree12").classList.add("red");
					}
				}
				if (typeof(document.getElementById("block_agree13")) != 'undefined' && document.getElementById("block_agree13") != null)
				{
					if(document.getElementById("agree13").checked == false)
					{
						if(scrolled == 0)
						{
							document.getElementById("agree13").scrollIntoView({behavior: "smooth"});
							scrolled = 1;
						}
						document.getElementById("block_agree13").classList.add("red");
					}
				}
				if (typeof(document.getElementById("block_agree14")) != 'undefined' && document.getElementById("block_agree14") != null)
				{
					if(document.getElementById("agree14").checked == false)
					{
						if(scrolled == 0)
						{
							document.getElementById("agree14").scrollIntoView({behavior: "smooth"});
							scrolled = 1;
						}
						document.getElementById("block_agree14").classList.add("red");
					}
				}
				if (typeof(document.getElementById("block_agree15")) != 'undefined' && document.getElementById("block_agree15") != null)
				{
					if(document.getElementById("agree15").checked == false)
					{
						if(scrolled == 0)
						{
							document.getElementById("agree15").scrollIntoView({behavior: "smooth"});
							scrolled = 1;
						}
						document.getElementById("block_agree15").classList.add("red");
					}
				}

				return alert("Please check a all checkboxs first");
			}
		}
		else
		{

			if(signaturePad.isEmpty())
			{
				scrollTo(signaturePad.canvas);
				return alert("Please provide a all signatures first");
			}
		}
		


		var el_page = document.getElementById('page');
		el_page.classList.add('sending');

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

		if(type == 1)
		{
				saveSignature2();
				// saveSignature3();
				// saveSignature4();
		}
		if(type == 3)
		{
				saveSignature2();
		}
	 

		// signaturePad.clear();
		// signaturePad2.clear();
		// signaturePad3.clear();
		// signaturePad4.clear();

		// document.forms["signature_form"].submit();
		// $.ajax({
		//     type: "POST",
		//     data: $('form.signature_form').serialize(),
		//     success: function(data){
		//         console.info('User updated');
		//     }
		// });

		ajax_s1();

});

document.getElementById('clear').addEventListener('click', function () {
	signaturePad.clear();
});

function scrollTo(el){
	$('html, body').animate({
		scrollTop: $('#'+el.id).offset().top - 50
	}, 800);
}


function ajax_s1(){
		$.ajax({
				type: "POST",
				data: $('form.signature_form').serialize() + "&step=1",
				success: function(data){
						if(data == 'success')
						{
								window.location.replace(window.location.href + '?ast=2');
						}
				}
		});
}


});
</script>
{/literal}
{/if}


{if $smarty.get.ast==2}
{literal}
<script>
$(function() {

let old_url = window.location.href;
let new_url = old_url.substring(0, old_url.indexOf('?'));
history.pushState(null, null, new_url);
function ajax_s2(){
		$.ajax({
				type: "POST",
				data: {
						'step': 2
				},
				success: function(data){
						if(data == 'success')
						{      
						}
				}
		}); 
}
ajax_s2();
});
</script>
{/literal}
{/if}




{*
<script>

$(function() {






var canvas = document.getElementById('signature-pad');

// Adjust canvas coordinate space taking into account pixel ratio,
// to make it look crisp on mobile devices.
// This also causes canvas to be cleared.
function resizeCanvas() {
		// When zoomed out to less than 100%, for some very strange reason,
		// some browsers report devicePixelRatio as less than 1
		// and only part of the canvas is cleared then.
		var ratio =  Math.max(window.devicePixelRatio || 1, 1);
		canvas.width = canvas.offsetWidth * ratio;
		canvas.height = canvas.offsetHeight * ratio;
		canvas.getContext("2d").scale(ratio, ratio);
}

window.onresize = resizeCanvas;
resizeCanvas();

var signaturePad = new SignaturePad(canvas, {
	backgroundColor: 'rgb(255, 255, 255)' // necessary for saving image as JPEG; can be removed is only saving as PNG or SVG
});

document.getElementById('save-png').addEventListener('click', function () {
	if (signaturePad.isEmpty()) {
		return alert("Please provide a signature first.");
	}
	
	var data = signaturePad.toDataURL('image/png');
	console.log(data);
	window.open(data);
});

document.getElementById('save-jpeg').addEventListener('click', function () {
	if (signaturePad.isEmpty()) {
		return alert("Please provide a signature first.");
	}

	var data = signaturePad.toDataURL('image/jpeg');
	console.log(data);
	window.open(data);
});

document.getElementById('save-svg').addEventListener('click', function () {
	if (signaturePad.isEmpty()) {
		return alert("Please provide a signature first.");
	}

	var data = signaturePad.toDataURL('image/svg+xml');
	console.log(data);
	console.log(atob(data.split(',')[1]));
	window.open(data);
});

document.getElementById('clear').addEventListener('click', function () {
	signaturePad.clear();
});

document.getElementById('draw').addEventListener('click', function () {
	var ctx = canvas.getContext('2d');
	console.log(ctx.globalCompositeOperation);
	ctx.globalCompositeOperation = 'source-over'; // default value
});

document.getElementById('erase').addEventListener('click', function () {
	var ctx = canvas.getContext('2d');
	ctx.globalCompositeOperation = 'destination-out';
});







$('.signature_form').live('submit', function(e){
	e.preventDefault();

	//$(this).find('.signature').val() = canvas.toDataURL('image/png');
	if (signaturePad.isEmpty()) {
			return alert("Please provide a signature first.");
	}
		
	var data = signaturePad.toDataURL('image/png');
	$(this).find('.signature').val(data);
	//console.log(data);

	console.log($(this).find('.signature').val());

	//document.getElementById('my_hidden').value = canvas.toDataURL('image/png');
	//console.log('fff');
});

});
</script>
*}

</body>