
{$apply_button_hide=1 scope=parent}
{$members_menu=1 scope=parent}

<link href="design/{$settings->theme|escape}/css/landlord/landlord.css?v1.0.8.3" rel="stylesheet">
<link id="to_ptint_css" href="design/{$settings->theme|escape}/css/landlord/print_rentroll.css?v1.0.2" rel="stylesheet">

{if $houses|count > 1}
    {$nav_url = 'landlord/tenant-directory/'}
    {include file='landlord/bx/houses_nav.tpl'}
{/if}

<div class="page_wrapper">
    <div class="w1300">

        <div class="title_bx">
            <h1 class="title">{$selected_house->name|escape}</h1>
            {if $selected_house->blocks2['address']}
                <p class="tn_address">
                    <i class="fa fa-map-marker"></i>
                    {$selected_house->blocks2['address']}
                </p>
            {/if}
                
        </div><!-- title_bx -->
        <div class="fx tenants_cont1 sb">
            <div class="fx">
                <div class="tag_filter_block">
                    <p class="date_info">Tenants: Active</p>
                </div><!-- tag_filter_block -->
            </div>
            <div class="fx">
                <div class="tag_filter_block">
                    <div class="date_info" style="margin-right:50px">
                        <i class="fa fa-calendar"></i>
                        {$smarty.now|date_format:"%B %e, %Y"}
                    </div>
                </div><!-- tag_filter_block -->
            </div>
            <div class="fx">
                <a class="download_zip_button fx" href="{url f=xls}" download>
                        <span>Excel file</span>
                        <i class="icon"></i>
                </a>
                <a style="margin-left:10px;" class="download_zip_button fx" href="{url f=pdf}" download>
                    <span>PDF file</span>
                    <i class="icon"></i>
                </a>
            </div>
        </div><!-- fx -->
    </div><!-- w1300 -->
    {include file='landlord/bx/rentroll/tenant-directory_html.tpl'}
</div><!-- page_wrapper -->

{literal}
<script>
let to_print = document.getElementById('to_print');
let print_bx = document.getElementById('print_bx').innerHTML;
let to_ptint_css = document.getElementById('to_ptint_css');

function css_text(x) { return x.cssText; }

to_print.addEventListener('click', createPDF);

function createPDF() {
    let css_content = Array.prototype.map.call(to_ptint_css.sheet.cssRules, css_text).join('\n');
    var win = window.open('', '', 'height=auto,width=1400');
    win.document.write('<html><head>');
    win.document.write('<title>'+to_print.dataset.title1+'</title>');
    win.document.write('<style>'+css_content+'</style>'); 
    win.document.write('</head>');
    win.document.write('<body class="print_body">');
    win.document.write('<h1>'+to_print.dataset.title1+'</h1>');
    win.document.write('<h2>'+to_print.dataset.title3+'</h2>');
    win.document.write('<h2>'+to_print.dataset.title2+'</h2>');
    win.document.write(print_bx); 
    win.document.write('</body></html>');
    win.document.close();
    win.print();
}

</script>
{/literal}
