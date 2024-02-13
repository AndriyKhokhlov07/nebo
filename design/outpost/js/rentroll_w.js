$(function(){

let init = 0;
let rr_form = $('.rr_form');
let selected_date = $('.s_date').val();



let dp_options = {
    language: 'en',
    dateFormat: 'yyyy-mm-dd',
    autoClose: true,
    // inline: true,
    onSelect: function onSelect(fd, date, inst){
        if(date && init==1){
            rr_form.submit();
        }
        init = 1;
    }
};

if($('.s_date[data-min]').length)
    dp_options.minDate = new Date($('.s_date').data('min'));

let dp = $('.s_date').datepicker(dp_options).data('datepicker');

dp.selectDate(new Date(selected_date));


});



/*let to_print = document.getElementById('to_print');
let to_ptint_css = document.getElementById('to_ptint_css');


function css_text(x) { return x.cssText; }

to_print.addEventListener('click', createPDF);*/

function createPDF() {

    let print_bx = document.getElementById('print_bx').cloneNode(true);



    // let rr_expenses_val = print_bx.querySelector('.rr_expenses').value;
    // print_bx.querySelector('.rr_expenses_bx').classList.add('val');
    // print_bx.querySelector('.rr_expenses_bx').innerHTML = rr_expenses_val;

    // print_bx.querySelector('.to_owner_bx').innerHTML = '';

    // print_bx.querySelectorAll('.brokerfee_discount_bx').forEach((el)=>{
    //     let val = el.querySelector('.brokerfee_discount').value;
    //     el.innerHTML=val==0?'':val+'%';
    //     el.classList.remove('brokerfee_discount_bx');
    // });

    // print_bx.querySelectorAll('.so_date .date_input').forEach((el)=>{
    //     el.closest('.so_date').innerHTML = el.value;
    // });

    // print_bx.querySelectorAll('.trig_chbx, input[name$="][sended]"]').forEach((el)=>{
    //     el.remove();
    // });
    

    let print_bx_html = print_bx.innerHTML;


    let css_content = Array.prototype.map.call(to_ptint_css.sheet.cssRules, css_text).join('\n');
    var win = window.open('', '', 'height=auto,width=1400');
    win.document.write('<html><head>');
    win.document.write('<title>'+to_print.dataset.title1+'</title>');
    win.document.write('<style>'+css_content+'</style>'); 
    win.document.write('</head>');
    win.document.write('<body class="print_body">');

    win.document.write('<h2>'+to_print.dataset.title1+'</h2>');
    win.document.write('<p>'+to_print.dataset.desc1+'</p>');
    win.document.write('<p>'+to_print.dataset.desc2+'</p>');
    win.document.write('<p>'+to_print.dataset.desc3+'</p>');
    win.document.write('<p>'+to_print.dataset.desc4+'</p>');
    win.document.write('<p>'+to_print.dataset.desc5+'</p>');

    win.document.write(print_bx_html); 
    win.document.write('</body></html>');
    win.document.close();
    win.print();
}
