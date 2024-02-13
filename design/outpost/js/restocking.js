$(function(){

var frg = $('form > .restocking_group');
if(frg.length == 1){
    frg.find('> .title').trigger('click');
}

$('.restocking_group .i_nav > *').click(function(){
    var inv_input = $(this).closest('.i_inp_block').find('input');
    var inv_val = parseInt(inv_input.val());
    if(isNaN(inv_val))
        inv_val = 0;
    if($(this).hasClass('plus'))
        inv_val++;
    else if($(this).hasClass('minus'))
        inv_val--;
    if(inv_val<1)
        inv_val = '';
    inv_input.val(inv_val);
});

// $('.restocking_group .i_inp input[type=number]').keyup(function(){
//     var inv_val = $(this).val().replace(/\D+/g, '');
//     $(this).val(parseInt(inv_val));
// });


$('.to_add_note').click(function(){
    $(this).addClass('hide');
    $('textarea.note').removeClass('hide').focus();
});



// Images
if(window.File && window.FileReader && window.FileList)
{
    $("#dropZone").show();
    $("#dropZone").on('dragover', function (e){
        $(this).css('border', '1px solid #8cbf32');
    });
    // $(document).on('dragenter', function (e){
    //     $("#dropZone").css('border', '1px dotted #8cbf32').css('background-color', '#c5ff8d');
    // });

    dropInput = $('.dropInput').last().clone();
    
    function handleFileSelect(evt){
        var files = evt.target.files; // FileList object
        // Loop through the FileList and render image files as thumbnails.
        for (var i = 0, f; f = files[i]; i++) {
            // Only process image files.
            if (!f.type.match('image.*')) {
                continue;
            }
        var reader = new FileReader();
        // Closure to capture the file information.
        reader.onload = (function(theFile) {
            return function(e) {
                // Render thumbnail.
                $("<li class=wizard><div><img onerror='$(this).closest(\"li\").remove();' src='"+e.target.result+"' /><input name=images_urls[] type=hidden value='"+theFile.name+"'><i class='delete fa fa-times-circle'></i></div></li>").appendTo('div .images ul');
                temp_input =  dropInput.clone();
                $('.dropInput').hide();
                $('#dropZone').append(temp_input);
                //$("#dropZone").css('border', '1px solid #d0d0d0').css('background-color', '#ffffff');
                //clone_input.show();
            };
          })(f);
    
          // Read in the image file as a data URL.
          reader.readAsDataURL(f);
        }
    }
    $('.dropInput').live("change", handleFileSelect);
};

// Удаление изображений
$(".images .delete").live('click', function() {
     $(this).closest("li").fadeOut(200, function() { $(this).remove(); });
     return false;
});


});