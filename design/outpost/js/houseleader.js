$(function(){


var h_id = '';
$(".select_restocking_item_block select.house").change(function(){
    var house_id = $(this).find('option:selected').data('value');
    var item_block = $(this).closest('.select_restocking_item_block').find('.select_item');
    if(house_id!=0 && house_id!=h_id){
        $.ajax({
            url: "ajax/get_restocking_items.php",
            data: {
                house_id: house_id
            },
            dataType: 'json',
            type: 'POST',
            success: function(data){
                var options = '<option>--- Select ---</option>';;
                for(i=0; i<data.length; i++){
                    item = data[i];
                    options += '<option>'+item.name+'</option>';
                }
                item_block.html(options);
            }
        });
        h_id = house_id;
    }
});


$('.select_restocking_item_block .add').click(function(){
    var new_bx = $(".select_restocking_item > .wrapper:last").clone(false);
    var n = parseInt(new_bx.data('n'))+1;
    new_bx.attr('data-n', n);
    new_bx.find('select.select_item').attr('name', 'name[v'+n+']');
    new_bx.find('input.amount').attr('name', 'value[v'+n+']');

    new_bx.clone(false).appendTo('.select_restocking_item').fadeIn('slow').find('.amount').val('');
    return false;       
});

$('.select_restocking_item .del').live('click', function(){
    $(this).closest(".wrapper").fadeOut(200, function() { $(this).remove(); });
});

$('.select_wrapper select').change(function(){
    $("input#user").attr('data-id', $('.select_wrapper select option:selected').attr('data-id'));
});

// $("input#user").live("focus", function (event) {
//     $(this).autocomplete({
//         serviceUrl:'ajax/search_users.php',
//         params: {
//             search_house_id: $('.select_wrapper select option:selected').attr('data-id'),
//             get_booking_info: 1
//         },
//         minChars:2,
//         noCache: false, 
//         onSelect:
//             function(suggestion){
//                 $("input#user_id").val(suggestion.data.id);


//                 // $('.h_'+suggestion.data.bj_house_id).attr('selected', 'selected');

//                 let name = suggestion.data.first_name;
//                 if(suggestion.data.middle_name != '')
//                     name += ' ' + suggestion.data.middle_name;
//                 if(suggestion.data.last_name != '')
//                     name += ' ' + suggestion.data.last_name;
//                 $(this).val(name);

//                 $('.inp_first_name').val(suggestion.data.first_name);
//                 $('.inp_last_name').val(suggestion.data.last_name);
//                 $('.inp_phone').val(suggestion.data.phone);
//                 $('.inp_email').val(suggestion.data.email);

//                 let room_bed;
//                 if(suggestion.data.bed.name != '')
//                     room_bed = suggestion.data.bed.name;

//                 if(room_bed != '')
//                 {
//                     $('.inp_bed').val(room_bed);
//                     $('.inp_room_bed').val(room_bed);
//                 }

//                 if(suggestion.data.apartment != '')
//                     $('.inp_apt').val(suggestion.data.apartment.name);

                
//             },
//         formatResult:
//             function(suggestions, currentValue){
//                 var reEscape = new RegExp('(\\' + ['/', '.', '*', '+', '?', '|', '(', ')', '[', ']', '{', '}', '\\'].join('|\\') + ')', 'g');
//                 var pattern = '(' + currentValue.replace(reEscape, '\\$1') + ')';
//                 return (suggestions.data.image?"<img align=absmiddle src='"+suggestions.data.image+"'> ":'') + suggestions.value.replace(new RegExp(pattern, 'gi'), '<strong>$1<\/strong>');
//             }

//     });
// });


});