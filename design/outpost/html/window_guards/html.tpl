{* Window Guards html *}

{if $user->blocks['window_guards']['status']==1 && $signature}
{literal}
<style>
div,
p,
ul,
span{
	font-size: 9px;
}
h1{
	font-size: 13px;
}
h2{
	font-size: 11px;
}
p,
h1,
h2{
	margin-bottom: 3px;
}
.hide_child .ch_item.pd{
	padding-left: 15px;
}
</style>
{/literal}
{/if}

<div class="user_check">

<p>
To: <strong>{$user->name|escape}</strong><br>
From: <strong>Outpost Club Inc</strong><br>
Date: <strong>{$smarty.now|date_format:'m/d/Y'}</strong>
</p>
<br>
<h1>PROTECT YOUR CHILD FROM LEAD POISONING AND WINDOW FALLS</h1>

<h2>Annual Notice</h2>
<p>New York City law requires that tenants living in buildings with three or more apartments complete this form and return it to their landlord before February 15, each year. <strong>If you do not return this form, your landlord is required to visit your apartment to determine if a child resides in your apartment.</strong></p>
<br>


<div class="content_block1 visible">
<div class="padd_bx">
<h2>Peeling Lead Paint</h2>
<p><strong>By law</strong>, your landlord is required to inspect your apartment for peeling paint and other lead paint hazards at least once a year if a child 5 years or younger lives with you or routinely spends 10 or more hours each week in your apartment.</p>
<ul>
	<li>You must notify your landlord in writing if a child 5 years or younger comes to live with you during the year or routinely spends 10 or more hours each week in your apartment.</li>
	<li>If a child 5 years or younger lives with you or routinely spends 10 or more hours each week in your apartment, your landlord must inspect your apartment and provide you with the results of these paint inspections.</li>
	<li>Yourlandlordmustusesafeworkpracticestorepairallpeeling paint and other lead paint hazards.</li>
	<li><strong>Always report peeling paint to your landlord. Call 311 if your landlord does not respond.</strong></li>
</ul>
<p class="sm">These notice and inspection requirements apply to buildings with three or more apartments built before 1960. They also apply to such buildings built between 1960 and 1978 if the landlord knows that lead paint is present.</p>
<br>

{if !$user->blocks['window_guards']['status']}
<hr>
{/if}

<h2>Window Guards</h2>
<p><strong>By law</strong>, your landlord is required to install window guards in all of your windows if a child 10 years or younger lives with you, OR if you request window guards (even if no children live with you).</p>
<ul>
	<li>It is against the law for you to interfere with in stallation, or remove window guards where they are required. Air conditioners in windows must be permanently installed.</li>
	<li>Window guards must be installed so there is no space greater than 4 1⁄2 inches above or below the guard, on the side of the guard, or between the bars.</li>
	<li>ONLY windows that open to fire escapes, and one window in each first floor apartment when there is a fire escape on the outside of the building, are legally exempt from this requirement.</li>
</ul>
<p class="sm">These requirements apply to all buildings with three or more apartments, regardless of when they were built.</p>
</div><!-- padd_bx -->
</div><!-- content_block1 -->


<h2>Fill out and detach the bottom part of this form and return it to your landlord.</h2>



	<div class="content_block1 visible">
		<div class="padd_bx info_block">
			<p>Please check all boxes that apply:</p>

			<div class="hl_checklist">
				<div class="ch_item">
					<input class="required" type="checkbox" name="child5" id="child5years" value="1" {if $user->blocks['window_guards'] && $user->blocks['window_guards']['child5']}checked{/if}>
					<span class="ch_bx">
						<label class="strong" for="child5years">
							A child 5 years or younger lives in my apartment or routinely spends 10 or more hours each week in my apartment.
						</label>
					</span>
				</div><!-- ch_item -->
				<div class="ch_item">
					<input class="required" type="checkbox" name="child10" id="child10years" value="1" {if $user->blocks['window_guards']['child10']}checked{/if}>
					<span class="ch_bx">
						<label class="strong" for="child10years">
							A child 10 years or younger lives in my apartment and:
						</label>
					</span>
					<div class="hide_child">

						<div class="ch_item pd">
							<input class="required" type="checkbox" name="installed" id="wg_installed" value="1" {if $user->blocks['window_guards']['installed']}checked{/if}>
							<span class="ch_bx">
								<label for="wg_installed">
									Window guards are installed in all windows as required.
								</label>
							</span>
						</div>

						<div class="ch_item pd">
							<input class="required" type="checkbox" name="needrepair" id="wg_needrepair" value="1" {if $user->blocks['window_guards']['needrepair']}checked{/if}>
							<span class="ch_bx">
								<label for="wg_needrepair">
									Window guards need repair.
								</label>
							</span>
						</div>

						<div class="ch_item pd">
							<input class="required" type="checkbox" name="notinstalled" id="wg_notinstalled" value="1" {if $user->blocks['window_guards']['notinstalled']}checked{/if}>
							<span class="ch_bx">
								<label for="wg_notinstalled">
									Window guards are NOT installed in all windows as required.
								</label>
							</span>
						</div>

					</div><!-- hide_child -->
						
				</div><!-- ch_item -->

				<div class="ch_item">
					<input class="required" type="checkbox" name="child_no" id="child_no" value="1" {if $user->blocks['window_guards']['child_no'] || $childno_checked}checked{/if}>
					<span class="ch_bx">
						<label class="strong" for="child_no">
							No child 10 years or younger lives in my apartment:
						</label>
					</span>
					<div class="hide_child">

						<div class="ch_item pd">
							<input class="required" type="checkbox" name="installed_anyway" id="wg_installed_anyway" value="1" {if $user->blocks['window_guards']['installed_anyway']}checked{/if}>
							<span class="ch_bx">
								<label for="wg_installed_anyway">
									I want window guards installed anyway.
								</label>
							</span>
						</div>

						<div class="ch_item pd">
							<input class="required" type="checkbox" name="needrepair2" id="wg_needrepair2" value="1" {if $user->blocks['window_guards']['needrepair2']}checked{/if}>
							<span class="ch_bx">
								<label for="wg_needrepair2">
									I have window guards, but they need repair.
								</label>
							</span>
						</div>


					</div><!-- hide_child -->
						
				</div><!-- ch_item -->
				
			</div><!-- hl_checklist -->

		</div><!-- padd_bx -->
		<div class="padd_bx">
			<br>
			<div class="fx ch3 w">
				<div class="input_wrapper">
					<span class="label_title">Last Name:</span>
					<strong class="val_bx">{$user->last_name}</strong>
				</div><!-- input_wrapper -->

				<div class="input_wrapper">
					<span class="label_title">First Name:</span>
					<strong class="val_bx">{$user->first_name}</strong>
				</div><!-- input_wrapper -->

				<div class="input_wrapper">
					<span class="label_title">Middle Initial:</span>
					<strong class="val_bx">{$user->middle_name}</strong>
				</div><!-- input_wrapper -->


				<div class="input_wrapper">
					<span class="label_title">Street Address:</span>
					<strong class="val_bx">{$user->house_street_address|escape}</strong>
				</div><!-- input_wrapper -->

				<div class="input_wrapper">
					<span class="label_title">Apt.#:</span>
					<strong class="val_bx">{$user->apartment_name}</strong>
				</div><!-- input_wrapper -->

				<div class="input_wrapper">
					<span class="label_title">City:</span>
					<strong class="val_bx">{$user->house_city|escape}</strong>
				</div><!-- input_wrapper -->

				<div class="input_wrapper">
					<span class="label_title">State:</span>
					<strong class="val_bx">{$user->house_region|escape}</strong>
				</div><!-- input_wrapper -->

				<div class="input_wrapper">
					<span class="label_title">ZIP Code:</span>
					<strong class="val_bx">{$user->house_postal}</strong>
				</div><!-- input_wrapper -->


				<div class="input_wrapper">
					<span class="label_title">Telephone Number:</span>
					<strong class="val_bx">{$user->phone}</strong>
				</div><!-- input_wrapper -->


			</div><!-- fx -->


		
		</div><!-- padd_bx -->
	</div><!-- content_block1 -->
</div><!-- user_check -->



{if $user->blocks['window_guards']['status']==1 && $signature}
	<p>Date: <strong>{$date_signing|date:'m/d/Y'}</strong></p>
	Signature:<br>
	<img src="{$signature}" alt="Signature {$user->name|escape}" width="180" />
{else}
	<p>Date: <strong>{$smarty.now|date_format:'m/d/Y'}</strong></p>
{/if}
