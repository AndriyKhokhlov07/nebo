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

    <link href="design/{$settings->theme|escape}/css/brochure.css?v1.0.14" rel="stylesheet">

    <script src="js/jquery/jquery.js?v1.0.0"></script>
</head>
<body id="body">
	<header>
		<div class="logo"><img src="{$config->root_url}/design/{$settings->theme|escape}/images/logo_b.svg" alt="Outpost logo"></div>
		<div class="fx menu">
			<ul>
				<li class="active"><a href="#account" class="anchor">Your account</a></li>
				<li><a href="#services" class="anchor">Outpost services</a></li>
				<li><a href="#requests" class="anchor">Maintenance request</a></li>
				<li><a href="#refer" class="anchor">Refer a friend</a></li>
			</ul>
			<div class="open_sidebar">
                <i></i>
            </div>
		</div>
	</header>
	<div class="brochures">
		<div class="brochure_block ">
			<div class="anchor_block active" id="account"></div>
			<div></div>
			<h2 class="title v1"><span>Your account</span></h2>
			<div class="text">
				<p>With our online member portal, you can pay rent, submit maintenance requests, view upcoming community events, view announcements, read important documents and update your personal information at any time. Here's how to set up your account:</p>
			</div>
			<div class="text">
				<div class="white_title"><span>STEP 1:</span></div>
				<div class="cloud v2"><img src="{$config->root_url}/design/{$settings->theme|escape}/images/icons/cloud_w.svg" alt="Outpost NeBo"></div>
				<p>Visit <a class="red" href="https://ne-bo.com/user/login" target="_blank">ne-bo.com/user/login</a></p>
			</div>
			<div class="text text light_green">
				<div class="white_title"><span>STEP 2:</span></div>
				<div class="cloud"><img src="{$config->root_url}/design/{$settings->theme|escape}/images/icons/cloud.svg" alt="Outpost NeBo"></div>
				<p>Enter the email you use for your invoice and click “password reset”</p>

			</div>
			<div class="text">
				<div class="white_title"><span>STEP 3:</span></div>
				<p>Follow the instructions in your email (check spam!) to choose your new password.</p>

			</div>
			<div class="text">
				<div class="white_title"><span>STEP 4:</span></div>
				<p>You now have access to your member portal! Don't forget to check back often so you don't miss out on fun opportunities to get involved in the community.</p>
			</div>
			<div class="house_img">
				<picture>
				  	<source srcset="{$config->root_url}/design/{$settings->theme|escape}/images/icons/houses_3.1.webp" type="image/webp">
				  	<source srcset="{$config->root_url}/design/{$settings->theme|escape}/images/houses_3.1.png" type="image/png"> 
				  	<img src="{$config->root_url}/design/{$settings->theme|escape}/images/houses_3.1.png" alt="Outpost">
				</picture>
			</div>
		</div>
		<div class="brochure_block circle_in_end">
			<div class="anchor_block" id="services"></div>
			<div></div>
			<h2 class="title v1 light_green"><span>Outpost services</span></h2>
			<div class="text light_green">
				<div class="white_title"><span>In general</span></div>
				<p>Outpost services for Coliving units include the following: your room, furnishings, utilities, WiFi, cleaning services, security systems, community activities and common household supplies:*</p>
				<div class="text advantages fx c w">
					<div class="item">
				        <img src="/design/{$settings->theme|escape}/images/landing/living-room.svg" alt="Fully furnished">
				        <p>Fully furnished</p>
				    </div>
					<div class="item">
						<img src="/design/{$settings->theme|escape}/images/landing/shield_.svg" alt="Security">
						<p>Security</p>
					</div>
					<div class="item">
						<img src="/design/{$settings->theme|escape}/images/landing/invoice.svg" alt="Utilities">
						<p>Utilities</p>
					</div>
					<div class="item">
						<img src="/design/{$settings->theme|escape}/images/landing/brush.svg" alt="Cleaning and maintenance">
						<p>Cleaning and maintenance</p>
					</div>
				</div>
			</div>
			<div class="text">
				<div class="white_title"><span>Your house leader</span></div>
				<p>will be your main line of communication to Outpost. They can help you with supplies and general questions about your house. Please submit all maintenance requests through your member portal. (See YOUR ACCOUNT for information on how to access your portal).</p>
			</div>
			<div class="text">
				<p>For questions related to your invoice, extending your stay or similar, contact</p>
				<div class="white_title"><span>Customer service</span></div>
				<p>Between the hours of 1 a.m. and 8 p.m. Eastern, you can reach us at</p>
				<div class="white_title"><span><a href="tel:+18337076611">+1 833-707-6611</a></span></div>
				<p>Outside of those hours, please email Customer Service:</p>
				<div class="white_title"><span><a href="mailto:customer-service@outpost-club.com">customer-service@outpost-club.com</a></span></div>
			</div>
			<p class="notice">*utilities are provided by third-party companies and Outpost doesn't guarantee uninterrupted service. Supplies and additional to housing services are subject to availability and may be changed according to availability.</p>
		</div>
		<div class="brochure_block">
			<div class="anchor_block" id="requests"></div>
			<div></div>
			<h2 class="title v2"><span>Maintenance request</span></h2>
			<div class="text light_green">
				<span>Submitting a </span><div class="white_bg upper"><a class="red" href="https://ne-bo.com/technical-issues" target="_blank">Maintenance request on line</a></div><span> is the easiest way to start the process of a work order.</span>
			</div>
			<div class="text">
				<p>In order to submit a maintenance request, you'll need access to your member portal.</p>
				<span>Follow the steps listed on the </span><div class="white_bg upper"><span>Your account</span></div><span> card in this packet to begin.</span>
			</div>
			<div class="text">
				<p>Log in to your member portal. From the main page, click "MAINTENANCE REQUEST" at the top right of the screen. Fill out the form, including as much detail as possible to make sure we can address your request in a timely manner.</p>
			</div>
			<div class="text">
				<div class="white_title"><span>Identify your room:</span></div>
				<p>Your room letter or number can be found at the top outside corner of your bedroom door.</p>
			</div>
			<div class="text red_bg">
				<div class="white_title"><span>Urgency:</span></div>
				<p>Please only select "Very Urgent" if your issue is truly an emergency (e.g., no hot water, no electricity, flooding).</p>
			</div>
			<div class="house_img">
				<picture>
				  	<source srcset="{$config->root_url}/design/{$settings->theme|escape}/images/icons/houses_1.webp" type="image/webp">
				  	<source srcset="{$config->root_url}/design/{$settings->theme|escape}/images/houses_1.png" type="image/png"> 
				  	<img src="{$config->root_url}/design/{$settings->theme|escape}/images/houses_1.png" alt="Outpost">
				</picture>
			</div>
		</div>
		<div class="brochure_block ">
			<div class="anchor_block" id="refer"></div>
			<div></div>
			<h2 class="title v1 green"><span>Refer a friend</span></h2>
			<div class="text">
				<p>We appreciate your contribution to our community and we’d love it if your friends could join us. If you know someone who's looking for an all-inclusive membership in a great community, send them our way!</p>
			</div>
			<div class="text">
				<div>You'll <div class="white_bg"><span>earn $250 cash</span></div> when your friend signs up for at least 2 months at Outpost, and they'll <div class="white_bg"><span>get a $250 discount</span></div> on their last month's rent — just as thanks for choosing to be part of our community.</div>
				<div>Have your friend submit their email address at: <div class="white_bg"><strong><a class="red" href="https://outpost-club.com/join-us" target="_blank">outpost-club.com/join-us</a></strong></div></div>
				<div class="star_six">
					<span>Earn $250</span>
				</div>
			</div>
			<div class="text">
				<p>On their application, ask them to put your first and last name when asked where they heard about us.</p>
				<p>Once your referral has signed a membership agreement for two months or more and completed their second month, you'll get $250!</p>
			</div>
			<p class="thank_you_title">THANKS FOR BEING AN OUTPOST MEMBER!</p>

			<div class="house_img">
				<picture>
				  	<source srcset="{$config->root_url}/design/{$settings->theme|escape}/images/icons/houses_2.webp" type="image/webp">
				  	<source srcset="{$config->root_url}/design/{$settings->theme|escape}/images/houses_2.png" type="image/png"> 
				  	<img src="{$config->root_url}/design/{$settings->theme|escape}/images/houses_2.png" alt="Outpost">
				</picture>
			</div>
		</div>
	</div>

	<div class="sidebar_bg"></div>

    <div class="sidebar">   
        <div class="wrapper">
            <ul class="menu">
         		<li class="active"><a href="#account" class="anchor">Your account</a></li>
				<li><a href="#services" class="anchor">Outpost services</a></li>
				<li><a href="#requests" class="anchor">Maintenance request</a></li>
				<li><a href="#refer" class="anchor">Refer a friend</a></li>
            </ul>
            
            <div class="info">
                <a href="tel:+18337076611">+1 (833) 707-6611</a>
                <a href="mailto:customer-service@outpost-club.com">customer-service@outpost-club.com</a>
            </div>
           
        </div><!-- wrapper -->  
        <div class="close">
            <i></i>
        </div>
    </div><!-- sidebar -->
    <div class="info desctop_info">
        <a href="tel:+18337076611">+1 (833) 707-6611</a>
        <a href="mailto:customer-service@outpost-club.com">customer-service@outpost-club.com</a>
    </div>
</body>
{literal}
<script>
	$(function(){
		$('.anchor').click(function(event){
		    event.preventDefault();
		    $('html, body').animate({
		        scrollTop: $( $.attr(this, 'href') ).offset().top
		    }, 800);
		});

		$(window).on('scroll', function(){
			$('.brochure_block').each(function(){
			  if( $(this).offset().top <= $(window).scrollTop() + 50 && 
			      !$(this).hasClass('active') &&
			      ($(this).offset().top + $(this).innerHeight() > $(window).scrollTop() + 50)
			  )
			  {
			      $('.brochure_block.active').removeClass('active');
			      $(this).addClass('active');
			      $('header li.active, .sidebar li.active').removeClass('active');
			      $('header li a[href=#'+$(this).find('.anchor_block').attr('id')+'], .sidebar li a[href=#'+$(this).find('.anchor_block').attr('id')+']').closest('li').addClass('active');
			  }
			});
		});

		$('.open_sidebar').click(function(){
		  $('.sidebar').addClass('active');
		  $('.sidebar_bg').addClass('active');
		  $('body').css({'overflow':'hidden'});
		});
		$('.sidebar_bg, .sidebar .close, .sidebar .anchor').click(function(){
		  $('.sidebar_bg').removeClass('active');
		  $('.sidebar').removeClass('active');
		  $('body').css({'overflow-y':'auto'});
		});
	});
</script>
{/literal}