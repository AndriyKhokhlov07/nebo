{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}

<div class="main_width">
    <h4 class="h1 center">We co-house today’s workforce</h4>
    <h5 class="h5">We are building a digital housing service offering a network of properties tailored for modern co-living  – with a complete range of add-on services.</h5>
    <div class="fx c w big_dg ch3">
        <div class="item">
            <p class="title">32%</p>
            <p class="text">American adults who live with either a roommate or parent</p>
        </div>
        <div class="item">
            <p class="title">88%</p>
            <p class="text">Renters age 24 or younger nationwide who are searching for a home they intend to share</p>
        </div>
        <div class="item">
            <p class="title">25M</p>
            <p class="text">Americans who live with roommates, up 26% from 1995</p>
        </div>
    </div>
</div>
<div class="main_width partners_sb">
    <div class="second_block fx w">
        <div class="ico"><img src="/design/{$settings->theme|escape}/images/landing/logo.svg" alt="Outpost Club logo"></div>
        <div class="text">
            <h4 class="h1">What we do</h4>
            <p>Outpost Club is a property management company that enters into long-term Lease Agreements or Management Agreements with Landlords and real-estate developers to become a long-term tenant or operate their properties.</p>
        </div>
    </div>
</div>
<div class="main_width">
    <p class="h1 center">We partner with landlords and real-estate developers in the following areas:</p>
    <div class="fx c w ch4 areas_list">
        <a class="item anchor" href="#consult">
            <p class="title">Consulting on <br>Co-living</p>
        </a>
        <a class="item anchor" href="#manag">
            <p class="title">Management <br>Agreement</p>
        </a>
        <a class="item anchor" href="#lease">
            <p class="title">Lease <br>Agreements</p>
        </a>
        <a class="item anchor" href="#service">
            <p class="title">Co-living <br>Services</p>
        </a>
    </div>
</div>
<div class="main_width">
    <div class="areas_ul text_block">
        <div class="item">
            <div class="form_acnhor" id="consult"></div>
            <p class="h5">Consulting on Co-living</p>
            <div class="text">
                <p>Over the past few years, we have gained a lot of experience in the performance of different residential properties, the redevelopment of  residential properties and in competitive leasing. We are capable of consulting on how to enhance the performance of future and existing residential properties through co-living strategy. We help our partners to optimize floorplan efficiency and the experience of future tenants, thus generating more revenue for the owner.</p>
                <p><strong>Our consulting services include:</strong></p>
                <ul>
                    <li>Location feasibility study in relation to potential co-living space</li>
                    <li>Reviewing house layouts for potential co-living use</li>
                    <li>Price and market analysis</li>
                </ul>
                <p><strong>Pre-construction phase services include:</strong></p>
                <ul>
                    <li>Creation of co-living-optimized floor plans </li>
                    <li>Concept and interior design</li>
                    <li>Selection of the proper equipment, furniture and decorative materials to enhance the co-living experience</li>
                </ul>
                <p><strong>Construction phase services include:</strong></p>
                <ul>
                    <li>Procurement and installation of the proper equipment, furniture and decorative materials to enhance the co-living experience</li>
                </ul>
            </div>
        </div>
        <div class="item">
            <div class="form_acnhor" id="manag"></div>
            <p class="h5">Management Agreement</p>
            <div class="text">
                <p>We welcome the opportunity to discuss a long-term co-living management relationship through a Management Agreement for selected properties. We will utilize a structure in which the owner gets 100% of NOI until the market return is achieved, and afterward, the higher return will be shared with the owner.</p>
                <p><strong>An Outpost Club Management Agreement includes, but is not limited to:</strong></p>
                <ul>
                    <li>Co-living services</li>
                    <li>Property management services: We can discuss the details and what is included</li>
                    <li>Marketing and leasing of the co-living property to tenants</li>
                </ul>
            </div>
        </div>
        <div class="item">
            <div class="form_acnhor" id="lease"></div>
            <p class="h5">Lease Agreements</p>
            <div class="text">
                <p>For a very few selected properties, we may offer a multi-year Master Lease agreement on a wholesale prices basis. We will occupy the property and be responsible for further leasing out of the property to tenants.</p>
            </div>
        </div>
        <div class="item">
            <div class="form_acnhor" id="service"></div>
            <p class="h5">Co-living Services</p>
            <div class="text">
                <p>We may provide Co-living Services for a select number of properties. In this setup,the owner will be able to white label the Co-living Space under their own brand and will be responsible for leasing the property to tenants. We will provide a monthly set of the Co-living Services.</p>
            </div>
        </div>
    </div>
    <p class="h1 center">Feel free to reach out if you have more questions!</p>
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
    <p class="h1 center">Current Partners:</p>
    {get_partners var=partners limit=20}
    <div class="fx c w vc ch3 partners_slider">
        {foreach $partners as $p}
            <div class="item fx c vc">
                <img src="{$p->filename|resize:gallery:300:150}" alt="{$p->name|escape}">           
            </div>
        {/foreach}
    </div>
</div>