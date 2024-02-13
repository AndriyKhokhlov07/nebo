{* Restocking *}

{if $user->type == 5} 
{$handyman_menu=1 scope=parent}
{else}
{$members_menu=1 scope=parent}
{/if}

<div class="restocking_wrapper main_width">


	<div class="restocking_block">

		<div class="title2">{$title}</div>


		{if $message_success}
			<div class="message_success fx sb w100">
				<div class="fx v c">
					<span>Notification {if $message_success=='updated'}updated{elseif $message_success=='added'}added{/if}</span>
				</div>
				<div>
					<a class="back" href="notifications-journal"><i class="fa fa-angle-left"></i> Back</a>
				</div>
				
			</div>
		{else}
		<form method="post" enctype="multipart/form-data" class="hl_checklist">
			<input type=hidden name="session_id" value="{$smarty.session.id}">
			<input name='user_id' type="hidden" value="{$user->id}">

			<div class="block layer">
				<h1>Add Notification</h1>
				<div class="fx ch2 w">
					<div class="input_block">
						<label class=property>House <span class="red_color">*</span></label>
						<div class="select_block">
							<select class="select_house" name="house_id" required>
								<option disabled selected>Select</option>
								{if $houses}
								{foreach $houses as $city}
					   			{if $city->subcategories}
						   			<optgroup label="{$city->name|escape}">
						   			{foreach $city->subcategories as $house}
						        		<option value='{$house->id}'>{$house->name|escape}</option>
						        	{/foreach}
						        	</optgroup>
					        	{/if}
						    	{/foreach}
						    	{elseif $h_houses}
						    	{foreach $h_houses as $house}
						        	<option value='{$house->id}'>{$house->name|escape}</option>
						    	{/foreach}
						    	{/if}
							</select>
						</div>
					</div>
					<div class="input_block select_apt hide">
						<label class=property>Apt</label>
						<div class="select_block">
							<select name="object_id">
							{*
							{foreach $apts as $k=>$h_apts}
								{foreach $h_apts as $apt}
								<option value="{$apt->id}"  class="apt_h_{$k}">{$apt->name}</option>
								{/foreach}
							{/foreach}
							*}
							</select>

						</div>
					</div>

					<div class="input_block">
						<label class=property>Type <span class="red_color">*</span></label>
						<div class="select_block">
							<select name="type">
								<option value="9">(Apartment) Visit</option>
								<option value="11">(Entire house) Visit</option>
								<option value="12">(Apartment) Alert</option>
								<option value="10">(Entire house) Alert</option>
							</select>
						</div>
					</div>
					<div class="input_block">
						<label class=property>Choose the date <span class="red_color">*</span></label>
						<input name="date" class="datepicker_not_inline" type="text" value="">
					</div>
					<div class="input_block">
						<label class=property>Time from</label>
						<div class="select_block">
							<select name="time_from">
								<option value="0">Select time</option>
								<option value="00:00">12:00 AM</option>
								<option value="01:00">01:00 AM</option>
								<option value="02:00">02:00 AM</option>
								<option value="02:00">03:00 AM</option>
								<option value="04:00">04:00 AM</option>
								<option value="05:00">05:00 AM</option>
								<option value="06:00">06:00 AM</option>
								<option value="07:00">07:00 AM</option>
								<option value="08:00">08:00 AM</option>
								<option value="09:00">09:00 AM</option>
								<option value="10:00">10:00 AM</option>
								<option value="11:00">11:00 AM</option>
								<option value="12:00">12:00 PM</option>
								<option value="13:00">01:00 PM</option>
								<option value="14:00">02:00 PM</option>
								<option value="15:00">03:00 PM</option>
								<option value="16:00">04:00 PM</option>
								<option value="17:00">05:00 PM</option>
								<option value="18:00">06:00 PM</option>
								<option value="19:00">07:00 PM</option>
								<option value="20:00">08:00 PM</option>
								<option value="21:00">09:00 PM</option>
								<option value="22:00">10:00 PM</option>
								<option value="23:00">11:00 PM</option>
							</select>
						</div>
					</div>
					<div class="input_block">
						<label class=property>Time to</label>
						<div class="select_block">
							<select name="time_to">
								<option value="0">Select time</option>
								<option value="00:00">12:00 AM</option>
								<option value="01:00">01:00 AM</option>
								<option value="02:00">02:00 AM</option>
								<option value="02:00">03:00 AM</option>
								<option value="04:00">04:00 AM</option>
								<option value="05:00">05:00 AM</option>
								<option value="06:00">06:00 AM</option>
								<option value="07:00">07:00 AM</option>
								<option value="08:00">08:00 AM</option>
								<option value="09:00">09:00 AM</option>
								<option value="10:00">10:00 AM</option>
								<option value="11:00">11:00 AM</option>
								<option value="12:00">12:00 PM</option>
								<option value="13:00">01:00 PM</option>
								<option value="14:00">02:00 PM</option>
								<option value="15:00">03:00 PM</option>
								<option value="16:00">04:00 PM</option>
								<option value="17:00">05:00 PM</option>
								<option value="18:00">06:00 PM</option>
								<option value="19:00">07:00 PM</option>
								<option value="20:00">08:00 PM</option>
								<option value="21:00">09:00 PM</option>
								<option value="22:00">10:00 PM</option>
								<option value="23:00">11:00 PM</option>
							</select>
						</div>
					</div>
				</div>
				<div class="fx ch2 w">
					<div class="input_block">
						<label class=property>Template</label>
						<div class="select_block">
							<select name="template" class="template">
								<option value="">Select template</option>
								<option value="This is a notice to inform you that a cleaning will take place at your apartment. Please be aware of the cleaning team’s arrival as they will need to access the common areas of the apartment. The cleaning team will knock before entering the apartment, but if no one answers, our team does have access to the apartment, and will enter using their own access device. Please find the time and date of their arrival below.">Cleaning visit</option>
								<option value="This is a notice to inform you that our handyman will need access to your apartment in order to diagnose, repair and/or fix an issue in your apartment. Please be aware of our team’s arrival as they will need to access the common areas of the apartment. The handyman will knock before entering the apartment, but if no one answers, our team does have access to the apartment, and will enter using their own access device. Please find the time and date of their arrival below.">Handyman visit</option>
								<option value="This is a notice to inform you that contractor will need access to your apartment in order to diagnose, repair and/or fix an issue in your apartment. Please be aware of our team’s arrival as they will need to access the common areas of the apartment. The our team will knock before entering the apartment, but if no one answers, our team does have access to the apartment, and will enter using their own access device. Please find the time and date of their arrival below.">Contractor</option>
							</select>
						</div>
					</div>
				</div>
				<div class="input_block" style="margin: 0 0 25px; width: 100%;">
					<label class=property>Text <span class="red_color">*</span></label>
					<textarea name="text" required class="backend_inp" id='notify_text'/></textarea>
				</div>
				
			</div>

			<div class="button_block">
				<button class="button green" type="submit">Apply</button>
			</div><!-- button_block -->
		</form>
		{/if}

	</div><!-- restocking_houses_block -->
</div>
{literal}
<script>
$(function() {

	$('#product_categories .add').click(function() {
		$("#product_categories ul li:last").clone(false).appendTo('#product_categories ul').fadeIn('slow').find("select:last").focus();
		$("#product_categories ul li:last span.add").hide();
		$("#product_categories ul li:last span.delete").show();
		return false;		
	});

	$("#product_categories .delete").live('click', function() {
		$(this).closest("li").fadeOut(200, function() { $(this).remove(); });
		return false;
	});

	$('.template').live('change', function(){
		$('#notify_text').val($(this).val());
	});

	// $('.select_house').live('change', function(){
	// 	$('.select_house').attr('disabled', 'disabled');
	// 	$('.select_apt').removeClass('hide');
	// 	$('.select_apt option:not(.apt_h_'+$('.select_house').val()+')').hide().remove();
	// 	$('.select_apt .apt_h_'+$('.select_house').val()).show();
	// });

	$('.select_house').change(function(){
		$('.select_apt').removeClass('hide');
	    let house_id = $(this).find('option:selected').val();
	    if(house_id!=0){
	        $.ajax({
	            url: "ajax/get_apartments.php",
	            data: {
	                house_id: house_id
	            },
	            dataType: 'json',
	            type: 'POST',
	            success: function(data){
	                var options = '<option>--- Select ---</option>';;
	                for(i=0; i<data.length; i++){
	                    item = data[i];
	                    options += '<option value='+item.id+'>'+item.name+'</option>';
	                }
	                $('.select_apt select').html(options);
	            }
	        });
	    }
	});


});
</script>
{/literal}
