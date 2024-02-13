var empty = function(value){
    if (['undefined', 'infinity'].includes(typeof value)){
        return true;
    }
    return ['', null, {}, 0, undefined].includes(value);
}

$(function(){

// Returns the ISO week of the date.
Date.prototype.getWeek = function() {
  var date = new Date(this.getTime());
  date.setHours(0, 0, 0, 0);
  // Thursday in current week decides the year.
  date.setDate(date.getDate() + 3 - (date.getDay() + 6) % 7);
  // January 4 is always in week 1.
  var week1 = new Date(date.getFullYear(), 0, 4);
  // Adjust to Thursday in week 1 and count number of weeks from date to week1.
  return 1 + Math.round(((date.getTime() - week1.getTime()) / 86400000
                        - 3 + (week1.getDay() + 6) % 7) / 7);
}

var body = $('body');

$.fn.datepicker.language['en'] = {
    days: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
    daysShort: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
    daysMin: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'],
    months: ['January','February','March','April','May','June', 'July','August','September','October','November','December'],
    monthsShort: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
    today: 'Today',
    clear: 'Clear',
    firstDay: 1
};
var str_able = $('.datepicker').attr('data-able');

let disabledDays = '['+str_able+']';

var date = new Date();
var curr_date = date.getDate();
var curr_month = date.getMonth();
var curr_year = date.getFullYear();

var tommorow = new Date(date);
tommorow.setDate(curr_date + 7);

var date_end = new Date(date);
date_end.setDate(curr_date + 30);

$('.datepicker').datepicker({
    language: 'en',
    inline: true,
    minDate: tommorow,
    maxDate: date_end,
    onRenderCell: function (date, cellType) {
        if (cellType == 'day') {
            var day = date.getDay();
            var week = date.getWeek();
            if(day == 0)
              day = 7;

              if(week & 1)
              {
                isDisabled = disabledDays.indexOf('+'+day) === -1;
              }
              else
              {
                isDisabled = disabledDays.indexOf('-'+day) === -1;
              }

            return {
                disabled: isDisabled
            }
        }
    }
})

$('.datepicker_not_inline').datepicker({
    language: 'en'
})

$('.reviews_slider').slick({
  infinite: true,
  slidesToShow: 1,
  slidesToScroll: 1,
  dots: false,
  adaptiveHeight: true,
  responsive: [
  {
      breakpoint: 700,
      settings: {
        slidesToShow: 1,
        slidesToScroll: 1,
        dots: false
      }
    }
  ]
});

$('.img_slider').slick({
  lazyLoad: 'ondemand',
  infinite: true,
  slidesToShow: 1,
  slidesToScroll: 1,
  dots: true,
  adaptiveHeight: true,
  responsive: [
  {
      breakpoint: 800,
      settings: {
        slidesToShow: 1,
        slidesToScroll: 1,
        dots: true
      }
    }
  ]
});

$('.land_slider').slick({
  lazyLoad: 'ondemand',
  infinite: true,
  slidesToShow: 1,
  slidesToScroll: 1,
  arrows: true,
  dots: false,
  adaptiveHeight: true,
  autoplay: true,
  autoplaySpeed: 3000,
  infinite: true
});



$('.blog_slider').slick({
  infinite: true,
  slidesToShow: 4,
  slidesToScroll: 4,
  arrows: true,
  dots: false,
  adaptiveHeight: true,
  responsive: [
  {
      breakpoint: 800,
      settings: {
        slidesToShow: 3,
        slidesToScroll: 3,
        arrows: true,
        dots: false
      }
    },
    {
      breakpoint: 500,
      settings: {
        slidesToShow: 2,
        slidesToScroll: 2,
        arrows: true,
        dots: false
      }
    },
    {
      breakpoint: 420,
      settings: {
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: true,
        dots: false
      }
    }
  ]
});

if($(window).width() < 650){
  $(".blog_grid .blog").slick({
    infinite: true,
    slidesToShow: 2,
      slidesToScroll: 2,
      dots: false,
      autoplay: false,
      autoplaySpeed: 7000,
      adaptiveHeight: true,
      responsive: [
      {
          breakpoint: 420,
          settings: {
            slidesToShow: 1,
            slidesToScroll: 1,
            arrows: true,
            dots: false
          }
        }
      ]
    });
}


$("input#faq_search").autocomplete({
    serviceUrl:'ajax/search_faq.php',
    minChars:2,
    noCache: false, 
    onSelect:
        function(suggestion){
            $("input#faq_search").val('').focus().blur(); 
            id = suggestion.data.id;
            $('html, body').animate({
                scrollTop: $('.pc_'+id).offset().top - 100
            }, 800);
            setTimeout(function(){
                $('.pc_'+id).trigger( "click" );
            }, 1000);
        },
    formatResult:
        function(suggestions, currentValue){
            var reEscape = new RegExp('(\\' + ['/', '.', '*', '+', '?', '|', '(', ')', '[', ']', '{', '}', '\\'].join('|\\') + ')', 'g');
            var pattern = '(' + currentValue.replace(reEscape, '\\$1') + ')';
            return (suggestions.data.image?"<img align=absmiddle src='"+suggestions.data.image+"'> ":'') + suggestions.value.replace(new RegExp(pattern, 'gi'), '<strong>$1<\/strong>');
        }

});


// Forms (old)
/*$('form.ajax').on('submit', function(e){
  var form_block = $(this).closest('.form2');
  var convers = $(this).find('button.button2').data('convers');
  e.preventDefault();
  $.ajax({
    dataType: 'json',
    url: 'ajax/form.php',
    type: 'POST',
    data: $(this).serialize(),
    success: function(data){
      if(form_block.find('input[value=service_id]').length > 0)
        $('.counter_block .count span').html( parseInt($('.counter_block .count span').html())+1 );
      form_block.find('form').slideUp(1000);
      form_block.find('.info > span').html(data.content);
      form_block.find('.info').slideDown(1000);
      if(form_block.hasClass('hl_checklist')){
        setCookie('mmr', '', {path : window.location.pathname});
      }

      //goggle report conversion
      //goog_report_conversion(convers);
    }
  });
});
*/
// Forms
$('form.ajax').live('submit', function(e){
    e.preventDefault();
  
    var form_block = $(this).closest('.form2');
    var convers = $(this).find('button.button2').data('convers');

    body.addClass('sending');

    $(this).ajaxSubmit({
        dataType: 'json',
        url: 'ajax/form.php',
        type: 'POST',
        success: function(data){
            body.removeClass('sending');
            if(form_block.find('input[value=service_id]').length > 0) {
                $('.counter_block .count span').html( parseInt($('.counter_block .count span').html())+1);
            }
            form_block.find('form').slideUp(1000);
            form_block.find('.info > span').html(data.content);
            form_block.find('.info').slideDown(1000);
            if(form_block.hasClass('hl_checklist')) {
                setCookie('mmr', '', {path : window.location.pathname});
            }
            // form_block.find('form').submit();
        }
    });
});

// HouseLeader form
function mmr(){
  var mmr = '';
  $('.mmr[type=checkbox]:checked, .mmr[type=radio]:checked, .mmr[type=text], textarea.mmr, select.mmr option:selected').each(function(){
    if($(this).val() != '')
      mmr += '__'+$(this).attr('id')+'--'+$(this).val();
  });
  mmr = mmr.slice(2);

  setCookie('mmr', mmr, {path : window.location.pathname});

  if(mmr=='')
    $('.hl_checklist .clear_form').addClass('hide');
  else
    $('.hl_checklist .clear_form').removeClass('hide');
}
$('.mmr[type=checkbox], .mmr[type=radio]').on('change', mmr);
$('.mmr[type=text], textarea.mmr').keyup(mmr);

$('.hl_checklist .clear_form').on('click', function(){
  if(!confirm('Please, confirm reset'))
    return false; 

  $('.mmr[type=checkbox]:checked, .mmr[type=radio]:checked').prop('checked', false);
  $('.mmr[type=text], textarea.mmr').val('');
  mmr();
});


$('.tabs.houses label').click(function(){
    $('.landlord_home .item').hide();
    $('.'+$(this).data('class')).show();
});

$('a.md_link').fancybox({
  transitionIn: 'none',
  transitionOut: 'none',
  padding: 20
});


$('.anchor').live('click', function(event){
    event.preventDefault();
    if($(window).width() < 801 && $.attr(this, 'href') == '#apply'){
      location = location.protocol + '//' + location.hostname + '/join-us';
    }
    $('html, body').animate({
        scrollTop: $( $.attr(this, 'href') ).offset().top
    }, 800);
});

$('.open_sidebar').click(function(){
  $('.sidebar').addClass('active');
  $('.sidebar_bg').addClass('active');
  $('body').css({'overflow':'hidden'});
});
$('.sidebar_bg, .sidebar .close').click(function(){
  $('.sidebar_bg').removeClass('active');
  $('.sidebar').removeClass('active');
  $('body').css({'overflow':'auto'});
});

var arrow_scroll = 0;
$(window).scroll(function(){
  if (arrow_scroll == 0){
    if($(this).scrollTop() > 1000 && !$('.scroll_top').hasClass('active')){
      $('.scroll_top').addClass('active');
      arrow_scroll = 1;
    }
  }
  else if($(this).scrollTop() < 1000){
    $('.scroll_top').removeClass('active');
    arrow_scroll = 0;
  }
});
$('.scroll_top').click(function(){
  $("html, body").animate({scrollTop: 0},
       800);
});

// Copy Link
function CopyToClipboard(containerid) {
  try {
    window.getSelection().removeAllRanges();
  } catch (e) {
    document.selection.empty();
  }
  if (document.selection) { 
      var range = document.body.createTextRange();
      range.moveToElementText(document.getElementById(containerid));
      range.select().createTextRange();
      document.execCommand("Copy"); 

  }else if (window.getSelection) {
    var range = document.createRange();
      range.selectNode(document.getElementById(containerid));
      window.getSelection().addRange(range);
      document.execCommand("Copy");
      //alert("text copied") 
      $('.copy_link').addClass('copied');
      setTimeout(
        "$('.copy_link').removeClass('copied')",
        2000
      )
  }
}
$('.copy_link').click(function(){
  CopyToClipboard('link_to_copy');
});

$(".qira .input_block_card input[name=expiration]").mask("99/99",{
	placeholder: "__/__"
});
$(".qira .input_block_card input[name=cardCvv]").mask("9999?",{
	placeholder: '',
	autoclear: false
});
$(".qira .input_block_card input[name=cardNumber]").mask("9999 9999 9999 9999?",{
	placeholder: '',
	autoclear: false
});
$(".qira .input_block_card input[name=zip]").mask("99999",{placeholder:"_____"});

// Cookies
// documentation: https://learn.javascript.ru/cookie
function getCookie(name) {
  var matches = document.cookie.match(new RegExp(
    "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
  ));
  return matches ? decodeURIComponent(matches[1]) : undefined;
}

function setCookie(name, value, options){
  options = options || {};
  var expires = options.expires;
  if(typeof expires == "number" && expires){
    var d = new Date();
    d.setTime(d.getTime() + expires * 1000);
    expires = options.expires = d;
  }
  if(expires && expires.toUTCString){
    options.expires = expires.toUTCString();
  }
  value = encodeURIComponent(value);
  var updatedCookie = name + "=" + value;
  for(var propName in options){
    updatedCookie += "; " + propName;
    var propValue = options[propName];
    if(propValue !== true){
      updatedCookie += "=" + propValue;
    }
  }
  document.cookie = updatedCookie;
}

function deleteCookie(name){
  setCookie(name, "",{
    expires: -1
  })
}
// Cookies (End)

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


//
// if (body.hasClass('c_order')) {
//     if (!getCookie('init_location')) {
//         navigator.geolocation.getCurrentPosition(showPosition);
//
//         function showPosition(position) {
//             console.log("Latitude: " + position.coords.latitude);
//             console.log("Longitude: " + position.coords.longitude);
//
//             setCookie('init_location', true, {path : window.location.pathname});
//         }
//     }
//
// }


});