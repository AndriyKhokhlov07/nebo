
var VerifForm;


$(function(){

// $("input[name=phone]").mask("+999999999999");
$("input[name=social_number], input[name=itin]").mask("999-99-9999");
$("input[name=zip], .input_zip").mask("99999");

$("input#annual_income").on('keyup', function() {

    if (this.value.match(/[1-9]([0-9]*)?/g)) {
        this.value = this.value.replace(/[^0-9]/g, '');
    }
    else
    {
        this.value = '';
    }
});

$("input#social_number").on('change', function() {

    if ($(this).val()) {
        $('.content_block1.v1 *[data-required]:visible').addClass('required');
        $('.content_block1.v1 *[data-required]:visible').closest('.input_wrapper').find('label').addClass('req');

        $('.content_block1.v1 #to_check').addClass('required');
        $('.state_bx2').hide();
        $('.state_bx1').show();
    }
    else if( !$(this).val() && $('#us_citizen_2').is(':checked') )
    {
        $('.content_block1.v1 *[data-required]').removeClass('required');
        $('.content_block1.v1 *[data-required]:not(#annual_income)').closest('.input_wrapper').find('label').removeClass('req');
        $('.state_bx1').hide();
        $('.state_bx2').show();
    }


});





// off
function FileSelect(event){
    var el = this;
    var reader = new FileReader();
    reader.onload = function(){
        let output = el.closest('.file_block').querySelector("img");
        if (!empty(output)) {
            output.src = reader.result;
            output.closest('.preview_block').classList.add('active');

            $(el).removeClass('not_req');
            $(el).closest('.input_wrapper').find('.req_info').addClass('hide');
        }
    }
    reader.readAsDataURL(event.target.files[0]);
}

    let dropzone = $('#dropZone');
    let to_upload_files_btn = $('.to_upload_files_btn');
    let to_cancel_files_btn = $('.to_cancel_files_btn');
    let to_remove_files_btn = $('.to_remove_files_btn');
    if(window.File && window.FileReader && window.FileList)
    {
        dropzone.show();
        dropzone.on('dragover', function (e){
            $(this).css('border', '1px solid #8cbf32');
        });
        $(document).on('dragenter', function (e){
            dropzone.css('border', '1px dotted #8cbf32').css('background-color', '#c5ff8d');
        });
    
        dropInput = $('.dropInput').last().clone();
        
        function handleFileSelect(evt){
            let files = evt.target.files;
            for (var i = 0, f; f = files[i]; i++) {
                
                // let f_type = f.type.split('/');
                // let ff_type = f_type[1].split('.');
                // let file_type = ff_type[ff_type.length-1];
                // console.log(ff_type);

                let file_size = f.size;
                let file_unit = 'B';
                if(file_size > 999){
                    file_size = Math.ceil((file_size / 1024)*100)/100;
                    file_unit = 'KB'
                }
                if(f.size > (999 * 999)){
                    file_size = Math.ceil((f.size / 1024 / 1024)*100)/100;
                    file_unit = 'MB'
                }



                $('<div class="item new"><div class="icon"><i class="icon fa fa-file-o"></i></div><div class="cont"><div class="fx"><div class="filename">'+f.name+'</div><div class="file_info">'+file_size+' '+file_unit+'</div></div><input name=images_urls[] type=hidden value="'+f.name+'"></div></div>').appendTo('.files_list');

                // $('.dropInput').hide();

                $("#dropZone").css('border', '1px dashed #bbb').css('background-color', '#ffffff');



                
                // Only process image files.
                /*
                if (!f.type.match('image.*')) {
                    continue;
                }
                var reader = new FileReader();
                // Closure to capture the file information.
                reader.onload = (function(theFile) {
                    return function(e) {
                        // Render thumbnail.
                        $("<li class=wizard><a href='' class='delete'><img src='design/images/cross-circle-frame.png'></a><img onerror='$(this).closest(\"li\").remove();' src='"+e.target.result+"' /><input name=images_urls[] type=hidden value='"+theFile.name+"'></li>").appendTo('div .images ul');
                        temp_input =  dropInput.clone();
                        $('.dropInput').hide();
                        $('#dropZone').append(temp_input);
                        $("#dropZone").css('border', '1px solid #d0d0d0').css('background-color', '#ffffff');
                        clone_input.show();
                    };
                })(f);
        
                // Read in the image file as a data URL.
                reader.readAsDataURL(f);
                */
                
            }
            temp_input = dropInput.clone();
            temp_input.imageUploadResizer({
                max_width: 1000, // Defaults 1000
                max_height: 1000, // Defaults 1000
                quality: 0.8, // Defaults 1
                do_not_resize: ['gif', 'svg'], // Defaults []
            });
            temp_input
                .removeClass('main')
                .addClass('new');


            dropzone.append(temp_input);
            to_upload_files_btn.removeClass('hide');
            to_cancel_files_btn.removeClass('hide');
            to_remove_files_btn.addClass('hide');


            // console.log($('.dropInput').val());
        }
        $('.dropInput').live("change", handleFileSelect);
    };


    $('.files_list > .item .del').live('click', function(){
        let item = $(this).closest('.item');
        item.find('input[name^=delete_files]').val(item.find('.filename').text());
        item.addClass('hide');
        to_remove_files_btn.removeClass('hide');
    });

    to_cancel_files_btn.live('click', function(){
        $('.files_list > .item.new').remove();
        $('.dropInput.new').remove();
        $('.dropInput.main').val();
        to_upload_files_btn.addClass('hide');
        to_cancel_files_btn.addClass('hide');
        return false;
    });


$('input[type=file]').imageUploadResizer({
    max_width: 1000, // Defaults 1000
    max_height: 1000, // Defaults 1000
    quality: 0.8, // Defaults 1
    do_not_resize: ['gif', 'svg'], // Defaults []
});


VerifForm = function (this_form){

    this_form = $(this_form.selector);

    let r_error = false;
    let first_r_el = false;

    this_form.find('.required').each(function(){

        let wrapp = $(this).closest('.input_wrapper');
        let el_val = $(this).val();
        el_val = el_val.trim();

        let inp_err = false;

        let ssn_notvalid = ['123-45-6789', '987-65-4321', '000-00-0000', '111-11-1111', '222-22-2222', '333-33-3333', '444-44-4444', '555-55-5555', '666-66-6666', '777-77-7777', '888-88-8888', '999-99-9999'];
        if($(this).attr('name')=='social_number' && ssn_notvalid.includes(el_val)){
            console.log('err: ' + $(this).attr('name'));
            inp_err = true;
        }


        if($(this).attr('name')=='employment_income' && this.hasAttribute('data-pattern1')){
            if(el_val.match($(this).data('pattern1')) == null) {
                console.log('err: ' + $(this).attr('name'));
                inp_err = true;
            }  
        }
        else if(this.hasAttribute('data-pattern') && el_val.match($(this).data('pattern')) == null)
        {
            console.log('err: ' + $(this).attr('name'));
            inp_err = true;
        }
            

        if(this.tagName == 'INPUT' && $(this).attr('type') == 'checkbox'){
            if(!this.checked) {
                console.log('err: ' + $(this).attr('name'));
                inp_err = true;
            }    
        }
        if(this.tagName == 'INPUT' && $(this).attr('type') == 'hidden'){
            if(el_val == '') {
                inp_err = true;
                console.log('err: ' + $(this).attr('name'));
            }   
        }


        if(this.tagName == 'INPUT' && ($(this).attr('type') == 'text' || $(this).attr('type') == 'number' || $(this).attr('type') == 'file' || $(this).attr('type') == 'checkbox')){
            if(el_val == '' || inp_err == true){
                $(this).addClass('not_req');
                if(wrapp.find('.req_info').length > 0)
                    wrapp.find('.req_info').removeClass('hide');
                else
                {
                    let info = 'Enter '+ wrapp.find('label').text();
                    if($(this).attr('type') == 'file')
                        info = 'Upload file';
                    else if($(this).attr('type') == 'checkbox')
                        info = 'Must be checked';
                    wrapp.find('.inp_i').after('<div class="req_info">'+info+'</div>');
                }
                r_error = true;
                console.log('err: ' + $(this).attr('name'));
                if(first_r_el == false)
                   first_r_el =  wrapp;
            }
        }
        else if(this.tagName == 'SELECT'){
            if(el_val == 0){
                $(this).addClass('not_req');
                if(wrapp.find('.req_info').length > 0)
                    wrapp.find('.req_info').removeClass('hide');
                else
                    wrapp.find('.inp_i').after('<div class="req_info">Select '+ wrapp.find('label').text() +'</div>');
                r_error = true;
                console.log('err: ' + $(this).attr('name'));
                if(first_r_el == false)
                   first_r_el =  wrapp;
            }
        }
    });

    if(this_form.find('.radio_h').length > 0)
    {
        let radio_h_valid = false;
        if(this_form.find('.radio_h:checked').length > 0)
            radio_h_valid = true;
        if(radio_h_valid == false){
            let radio_h_bx = $(this).find('.radio_h_bx');

            this_form.find('.radio_h').addClass('not_req');

            if(radio_h_bx.find('.req_info').length > 0)
                radio_h_bx.find('.req_info').removeClass('hide');
            else
                radio_h_bx.append('<div class="req_info">Select '+ radio_h_bx.find('> label').text() +'</div>');

            first_r_el = radio_h_bx;
            r_error = true;
            console.log('err: ' + $(this).attr('name'));
        }
    }
    

    if(r_error == true){
        if(first_r_el != false){
            $('html, body').animate({
                scrollTop: first_r_el.offset().top
            }, 600);
            first_r_el.find('input').focus();
        }
        return false;
    }
    return true;
}




// $('.select_file input[type=file]').live("change", FileSelect);

$('.preview_block .delete').live('click', function(){
    $(this).closest('.preview_block').removeClass('active');
    // $(this).closest('.file_block').find('input[data-required]').prop('required', true);
    $(this).closest('.file_block').find('input[data-required-file]').addClass('required');
});


function us_citizen_checked(v){
    v = parseInt(v);
    if(v==1){
        // $('.content_block1.v2 *[data-required]').removeClass('required');
        $('.content_block1.v2 *[data-required-file]').removeClass('required');
        $('#state').addClass('required');
        $('#to_check').addClass('required'); 

        
        // $('.content_block1.v1 *[data-required]').addClass('required');
        $('.content_block1.v1 .preview_block').not('.active').next('.select_file').find('[data-required-file]').addClass('required');

        // $('.content_block1.v1 *[data-required]').closest('.input_wrapper').find('label').addClass('req');

        $('[for=social_number]').addClass('req');
        $('#social_number').addClass('required');
        $('.social_number_bx .info_txt').addClass('hide');
    }
    else if(v==2){
        // $('.content_block1.v1 *[data-required]:not(#annual_income)').removeClass('required');
        $('[for=social_number]').removeClass('req');
        $('#social_number').removeClass('required');
        $('#state').removeClass('required'); 
        $('#to_check').removeClass('required'); 

        $('.content_block1.v1 *[data-required-file]').removeClass('required');
        // $('.content_block1.v2 *[data-required]').addClass('required');
        $('.content_block1.v2 .preview_block').not('.active').next('.select_file').find('[data-required-file]').addClass('required');

        // $('.content_block1.v1 *[data-required]:not(#annual_income)').closest('.input_wrapper').find('label').removeClass('req');
        $('.social_number_bx .info_txt').removeClass('hide');
    }
}

us_citizen_checked($('input[name=us_citizen]:checked').val());
$('input[name=us_citizen]').live('change', function(){
    us_citizen_checked($(this).val());
});


let employmentStatusSelected = function(clear_val){
    let employment_status = $('select[name=employment_status] option:selected');
    let annual_income = $('#annual_income');
    let hide_for_student_bx = $('.hide_for_student');
    if(employment_status.val() == 2) { // student
        annual_income.val('1').closest('.input_wrapper').addClass('hide');
        hide_for_student_bx.find('[data-required]').removeClass('required');
        hide_for_student_bx.addClass('hide').find('input').val('');
    }
    else {
        if(clear_val == true) {
            annual_income.val('');
        }
        annual_income.closest('.input_wrapper').removeClass('hide');
        hide_for_student_bx.find('[data-required]').addClass('required');
        hide_for_student_bx.removeClass('hide');
    }
};
employmentStatusSelected(false);
$('select[name=employment_status]').live('change', function(){
    employmentStatusSelected(true);
});




$('input[name=student]').live('change', function(){
    hideForStudent(parseInt($(this).val()));
});

$('input[name=live_parents]').live('change', function(){
    hideForLiveParents(parseInt($(this).val()));
});
let hideForLiveParents = function (is_live_parents) {
    let hide_for_live_parents_y_bx = $('.hide_for_live_parents_y');
    if (is_live_parents) {
        hide_for_live_parents_y_bx.find('[data-required]').removeClass('required');
        hide_for_live_parents_y_bx.addClass('hide').find('input').val('');
    } else {
        hide_for_live_parents_y_bx.find('[data-required]').addClass('required');
        hide_for_live_parents_y_bx.removeClass('hide');
    }
}
hideForLiveParents(parseInt($('input[name=live_parents]:checked').val()));



let hideForStudent = function (is_student) {
    let hide_for_student_bx = $('.hide_for_student');
    let employment_status_sel = $('select[name=employment_status]');
    if (is_student) {
        hide_for_student_bx.find('[data-required]').removeClass('required');
        hide_for_student_bx.addClass('hide').find('input').val('');

        employment_status_sel.find('option[value=2]').attr('disabled', false);
        employment_status_sel.val(2).change();
        employment_status_sel.closest('.input_wrapper').addClass('hide');
    } else {
        employment_status_sel.val('').change();
        employment_status_sel.find('option[value=2]').attr('disabled', true);
        employment_status_sel.closest('.input_wrapper').removeClass('hide');

        hide_for_student_bx.find('[data-required]').addClass('required');
        hide_for_student_bx.removeClass('hide');

        $('#live_parents_n').trigger('click');
        // .change();
    }
}
hideForStudent(parseInt($('input[name=student]:checked').val()));


$('.user_check form').live('submit', function(e){
    return VerifForm($(this));
});

/*
$('.user_check__ form').live('submit', function(e){
    //$('body').addClass('sending');
    let r_error = false;
    let first_r_el = false;
    let this_form = $(this);

    $(this).find('.required').each(function(){

        let wrapp = $(this).closest('.input_wrapper');
        let el_val = $(this).val();
        el_val = el_val.trim();

        let inp_err = false;


        if($(this).attr('name')=='employment_income' && this.hasAttribute('data-pattern1')){
            if($('#state').val()=='1' && el_val.match($(this).data('pattern1')) == null)
                inp_err = true;
        }
        else if(this.hasAttribute('data-pattern') && el_val.match($(this).data('pattern')) == null)
            inp_err = true;

        if(this.tagName == 'INPUT' && $(this).attr('type') == 'checkbox'){
            if(!this.checked)
                inp_err = true;
        }
        if(this.tagName == 'INPUT' && $(this).attr('type') == 'hidden'){
            if(el_val == '')
                inp_err = true;
        }


        if(this.tagName == 'INPUT' && ($(this).attr('type') == 'text' || $(this).attr('type') == 'number' || $(this).attr('type') == 'file' || $(this).attr('type') == 'checkbox')){
            if(el_val == '' || inp_err == true){
                $(this).addClass('not_req');
                if(wrapp.find('.req_info').length > 0)
                    wrapp.find('.req_info').removeClass('hide');
                else
                {
                    let info = 'Enter '+ wrapp.find('label').text();
                    if($(this).attr('type') == 'file')
                        info = 'Upload file';
                    else if($(this).attr('type') == 'checkbox')
                        info = 'Must be checked';
                    wrapp.find('.inp_i').after('<div class="req_info">'+info+'</div>');
                }
                r_error = true;
                if(first_r_el == false)
                   first_r_el =  wrapp;
            }
        }
        else if(this.tagName == 'SELECT'){
            if(el_val == 0){
                $(this).addClass('not_req');
                if(wrapp.find('.req_info').length > 0)
                    wrapp.find('.req_info').removeClass('hide');
                else
                    wrapp.find('.inp_i').after('<div class="req_info">Select '+ wrapp.find('label').text() +'</div>');
                r_error = true;
                if(first_r_el == false)
                   first_r_el =  wrapp;
            }
        }
    });

    if(this_form.find('.radio_h').length > 0)
    {
        let radio_h_valid = false;
        if($(this).find('.radio_h:checked').length > 0)
            radio_h_valid = true;
        if(radio_h_valid == false){
            let radio_h_bx = $(this).find('.radio_h_bx');

            $(this).find('.radio_h').addClass('not_req');

            if(radio_h_bx.find('.req_info').length > 0)
                radio_h_bx.find('.req_info').removeClass('hide');
            else
                radio_h_bx.append('<div class="req_info">Select '+ radio_h_bx.find('> label').text() +'</div>');

            first_r_el = radio_h_bx;
            r_error = true;
        }
    }
    

    if(r_error == true){
        if(first_r_el != false){
            $('html, body').animate({
                scrollTop: first_r_el.offset().top
            }, 600);
            first_r_el.find('input').focus();
        }
        return false;
    }
    else{

    }
 
});
*/

$('.user_check form input[type=text].not_req').live('keyup', function(){
    if($(this).val().trim() != ''){
        $(this).removeClass('not_req');
        $(this).closest('.input_wrapper').find('.req_info').addClass('hide'); 
    }
});
$('.user_check form select.not_req').live('change', function(){
    if($(this).val() != 0){
        $(this).removeClass('not_req');
        $(this).closest('.input_wrapper').find('.req_info').addClass('hide'); 
    }
})
$('.user_check form .radio_h.not_req').live('change', function(){
    $(this).closest('.check_wrapper').find('.radio_h.not_req').removeClass('not_req');
    $(this).closest('.check_wrapper').find('.radio_h_bx .req_info').addClass('hide');
});

$('.user_check form input[type=checkbox].not_req').live('change', function(){
    if(this.checked){
        $(this).closest('.check_wrapper').find('.not_req').removeClass('not_req');
        $(this).closest('.check_wrapper').find('.req_info').addClass('hide');
    }
});

$('.req_info').live('click', function(){
    $(this).addClass('hide');
});


});


