{* User Check *}
{$apply_button_hide=1 scope=parent}
{$members_menu=0 scope=parent}
{$preloader=true scope=parent}


{$meta_title='Guarantor Agreement' scope=parent}

{$head_javascripts[]="js/heic2any.min.js" scope=parent}
{$javascripts[]="js/jquery.image-upload-resizer.js?v1.1.0" scope=parent}
{$javascripts[]="design/`$settings->theme`/js/user_check.js?v1.0.27" scope=parent}


{if $smarty.get.success=='sended' || $smarty.get.add_docs=='f' || $smarty.get.add_docs=='sended'}
<div class="page v_signed">
{else}
<div class="main_width">
{/if}


	{if $smarty.get.add_docs=='sended'}
			<div class="info">
				<h1 class="bold_h1_new center">Thank You!</h1>
			</div>
			<br>
			<div class="txt">
				<p class="center">Thank you for signing and submitting the guarantor agreement! Please let the tenant your are sponsoring know that you have completed the steps, so that they can continue the process of security their spot.</p>

				{$active_step=4}
				{$next_step_link=0}
				{include file='guarantor/bx/steps_apps.tpl'}

				<p class="center">Questions? Contact Outpost Club Inc at <a href="mailto:info@outpost-club.com">info@outpost-club.com</a> or call at <a href="tel:+18337076611">+1 (833) 707-6611</a>.</p>
			</div>
		</div>
	{elseif $smarty.get.success=='sended'}
		{$active_step=3}
		{$next_step_link="{$config->root_url}/guarantor/agreement?add_docs=f"}
		{include file='guarantor/bx/steps_apps.tpl'}
		<br>
		<p class="center">Questions? Contact Outpost Club Inc at <a href="mailto:info@outpost-club.com">info@outpost-club.com</a> or call at <a href="tel:+18337076611">+1 (833) 707-6611</a>.</p>


	{elseif $smarty.get.add_docs==f}

	<h1 class="bold_h1_new">Thank You</h1>
	<div class="txt">
		<p>
			You can download your signed Guarantor Agreement:
			<br>
			<br>
			<a class="button_red" style="margin: 5px 0 10px;" href="{$config->root_url}/files/users_files/{$user->id}/guarantor_agreement.pdf" download>Download doc</a>
		</p>
		<br>
		<br>
		<br>
	</div>

	{*
	<div class="user_check hl_checklist">
		<form method="post" name="rental_application" enctype="multipart/form-data">

			<div class="input_block">
				<div class="fx ">
					<div class="input_wrapper w100">
						<div class="files_list fx w">
							{foreach $user_files as $f}
							<div class="item">
								<input type="hidden" name="delete_files[]">
								<div class="icon">
									<i class="icon fa fa-file-o"></i>
								</div><!-- icon -->
								<div class="cont">
									<div class="fx">
										<a class="filename" href="/{$config->users_files_dir}{$user->id}/files/{$f->filename}" target="_blank"{if in_array($f->ext, array('png', 'jpg', 'jpeg', 'pdf'))} data-fancybox="files"{/if} data-ext="{$f->ext}">{$f->filename}</a>
										<div class="file_info">{$f->size} &nbsp;&nbsp; {$f->date|date_format:'m/d/Y H:i:s'}</div>
									</div>
									<div class="del">
										<i class="fa fa-times-circle"></i>
									</div>
								</div><!-- cont -->
							</div>
							{/foreach}
						</div>
						
						<div class="inp_i file_block">
							<div id=dropZone class="select_file">
								<div id=dropMessage class="title"><i class="fa fa-upload"></i> Select/Drop files to upload</div>
								<input class="dropInput" type="file" name="dropped_files[]" multiple>
							</div>
							<div id="add_image"></div>
						</div>
						<p class="fx mb10">
							<button class="to_cancel_files_btn button cancel hide">Cancel</button>
							<button class="to_upload_files_btn button hide" type="submit" name="user_info" value="Save">Send files</button>
							<button class="to_remove_files_btn button hide" type="submit" name="user_info" value="Save">Apply remove files</button>
						</p>
					</div>
				</div>
			</div><!-- input_block -->
			<div class="step fx c">
				<a href="{$next_step_link}" class="button2">Add this docs later</a>
			</div>
			
		</form>
	</div><!-- user_check -->
	*}
	<div class="txt">
		<br>
		<p>If you have any questions, please contact the sales person you are working with on becoming a tenant of Outpost Club.</p>
	</div>
	{else}




	<div class="user_check hl_checklist">
		<form method="post" name="rental_application" enctype="multipart/form-data">
			
			{include file='guarantor/agreement/html.tpl'}

			


			

			{if $signature}
				Signature:<br>
				<img src="{$signature}" alt="Signature {$user->name|escape}" width="180" />
			{else}
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
			{/if}




			{*<button class="button red v2" type="submit">Submit</button>*}

		</form>
	</div><!-- user_check -->
<script type="text/javascript" src="design/{$settings->theme}/js/signature_pad.umd.js"></script>

	{literal}
	<script>
	$(function() {


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

	    document.forms["rental_application"].submit();
	});

	document.getElementById('clear').addEventListener('click', function () {
		signaturePad.clear();
	});


	});
	</script>
	{/literal}


	{/if}
</div>





