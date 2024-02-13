$(function(){

$('.md_link').on('click', function(){
    $('#cl_id').val($(this).attr('data-cl_id'));
    $('#add_note .date').val($(this).attr('data-date'));
    $('#add_note .house_id').val($(this).attr('data-house_id'));
});

var price = parseFloat($('.price span').html());
$('.ch_item.type_ch label').click(function(){
    if($(this).closest('.ch_item').hasClass('sheet_towel_plus') && $('#sheet_towel').is(':checked'))
    {
        price -= parseFloat($('#sheet_towel').val());
        $('#sheet_towel').removeAttr('checked');
    }
    if($(this).closest('.ch_item').hasClass('sheet_towel') && $('#sheet_towel_plus').is(':checked'))
    {
        price -= parseFloat($('#sheet_towel_plus').val());
        $('#sheet_towel_plus').removeAttr('checked');
    }
    if(!$(this).closest('.ch_item.type_ch').find('input').is(':checked')){
        price += parseFloat($(this).data('price'));
    }
    else{
        price -= parseFloat($(this).data('price'));
    }
    console.log(price);
    if(Math.round(price) == 0)
        $('.price span').html(Math.round(price));
    else
        $('.price span').html(price.toFixed(2));
});

// Images
if(window.File && window.FileReader && window.FileList)
{
    $("#dropZone, #dropZone1, #dropZone2, #dropZone3").show();
    $("#dropZone, #dropZone1, #dropZone2, #dropZone3").on('dragover', function (e){
        $(this).css('border', '1px solid #8cbf32');
    });
    // $(document).on('dragenter', function (e){
    //     $("#dropZone").css('border', '1px dotted #8cbf32').css('background-color', '#c5ff8d');
    // });

    
    function handleFileSelect(evt){
        console.log(evt);
        var files = evt.target.files; // FileList object
        var id = evt.target.parentNode.id;
        console.log(id);
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
                dropInput = $('#'+id+' .dropInput').last().clone();

                // Render thumbnail.
                $("<li class=wizard><div><img onerror='$(this).closest(\"li\").remove();' src='"+e.target.result+"' /><input name=images_urls_"+id+"[] type=hidden value='"+theFile.name+"'><i class='delete fa fa-times-circle'></i></div></li>").appendTo('.'+id+'.images ul');
                temp_input =  dropInput.clone();
                $('#'+id+' .dropInput').hide();
                $('#'+id).append(temp_input);
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
