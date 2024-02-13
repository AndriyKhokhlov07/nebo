$(function(){

    // PRICES
    let clear_price_bx = get_clear_price_bx();
    let price_max_key = 0;

    $('.price_item').each(function(){
        price_max_key = Math.max(price_max_key, parseInt($(this).data('price_key')));
    })

    function get_clear_price_bx(){
        let price_bx = $('.price_item:first').clone(true);
        price_bx.find('input').attr('value', '');
        return price_bx;
    }

    function set_price_key(){
        price_max_key++;
        const re = /(price\[)(\d*)(\]\[.*\])/g;
        clear_price_bx.attr('data-price_key', price_max_key);
        clear_price_bx.find('input, select').each(function(){
            $(this).attr('name', $(this).attr('name').replace(re, "$1"+price_max_key+"$3"));
        });
    }

    $('.add_price').live('click', function(){
        set_price_key();
        let new_price = clear_price_bx.clone().appendTo('.prices').css({'border-radius': '0'});
        new_price.find('input[type=text]:first').focus();
    });

    $('.price_item .close_price_btn').live('click', function(){
        $(this).closest('.price_item').fadeOut(200, function(){
            $(this).remove();
        });
        return false;
    });



    // APARTMENTS
    let clear_apartment_bx = get_clear_apartment_bx();
    let apartment_max_key = 0;

    $('.apart_block').each(function(){
        apartment_max_key = Math.max(apartment_max_key, parseInt($(this).data('apartment_key')));
    })

    function get_clear_apartment_bx(){
        let apartment_bx = $('.apart_block:first').clone(true);
        apartment_bx.find('input[type=text], input[type=hidden]').attr('value', '');
        apartment_bx.find('.room_item').remove();
        return apartment_bx;
    }

    function set_apartment_key(){
        apartment_max_key++;
        const re = /(apart\[)(\d*)(]\[.*])/g;
        clear_apartment_bx.attr('data-apartment_key', apartment_max_key);
        clear_apartment_bx.find('input').each(function(){
            $(this).attr('name', $(this).attr('name').replace(re, "$1"+apartment_max_key+"$3"));
        });
    }

    $('.add_apartment').live('click', function(){
        set_apartment_key();
        set_room_key();
        let new_room = clear_room_bx.clone().appendTo(clear_apartment_bx.find('.list_rooms'));
        // new_room.find('input[name*=id]').attr('value', room_max_key);
        new_room.find('input[name*=apartment_key]').attr('value', apartment_max_key);
        let new_apartment = clear_apartment_bx.clone().appendTo('.apart_info');
        new_apartment.find('input[name*=id]').attr('value', apartment_max_key);
        new_apartment.find('input[type=text]:first').focus();
    });

    $('.apart_block .close_apart_btn').live('click', function(){
        $(this).closest('.apart_block').fadeOut(200, function(){$(this).remove();});
        return false;
    });


    // ROOMS
    let clear_room_bx = get_clear_room_bx();
    let room_max_key = 0;

    $('.room_item').each(function(){
        room_max_key = Math.max(room_max_key, parseInt($(this).data('room_key')));
    })

    function get_clear_room_bx() {
        let room_bx = $('.room_item:first').clone(true);
        room_bx.find('input[type=text], input[type=hidden]').attr('value', '');
        return room_bx;
    }

    function set_room_key() {
        room_max_key++;
        const re = /(room\[)(\d*)(\]\[.*\])/g;

        clear_room_bx.each(function(){
            $(this).attr('data-room_key', room_max_key);
        });

        clear_room_bx.find('input').each(function(){
            $(this).attr('name', $(this).attr('name').replace(re, "$1"+room_max_key+"$3"));
        });
    }

    $('.add_new_room').live('click', function(){
        let this_apartment = $(this).closest('.apart_block');
        let this_apartment_key = this_apartment.data('apartment_key');
        set_room_key();
        let new_room = clear_room_bx.clone().appendTo(this_apartment.find('.list_rooms'));
        // new_room.find('input[name*=id]').attr('value', room_max_key);
        new_room.find('input[name*=apartment_key]').attr('value', this_apartment_key);
        new_room.find('input[type=text]:first').focus();
    });

    $('.room_item .close_room_btn').live('click', function(){
        $(this).closest('.room_item').fadeOut(200, function(){$(this).remove();});
        return false;
    });


    // MEDIA
    let clear_media_bx = get_clear_media_bx();
    let media_max_key = 0;

    $('.media_item').each(function(){
        media_max_key = Math.max(media_max_key, parseInt($(this).data('media_key')));
    })

    function get_clear_media_bx(){
        let media_bx = $('.media_item:first').clone(true);
        media_bx.find('input').attr('value', '');
        return media_bx;
    }

    function set_media_key(){
        media_max_key++;
        const re = /(media\[)(\d*)(\]\[.*\])/g;
        clear_media_bx.attr('data-media_key', media_max_key);
        clear_media_bx.find('input').each(function(){
            $(this).attr('name', $(this).attr('name').replace(re, "$1"+media_max_key+"$3"));
        });
    }

    $('.add_3D_tour').live('click', function(){
        set_media_key();
        let new_media = clear_media_bx.clone().appendTo('.m_tour');
        new_media.find('input[type=text]:first').focus();
    });

    $('.media_item .close_media_btn').live('click', function(){
        $(this).closest('.media_item').fadeOut(200, function(){
            $(this).remove();
        });
        return false;
    });


    // ACCOUNTS
    let clear_account_item_bx = get_clear_account_item_bx();
    let account_item_max_key = 0;

    $('.account_item').each(function(){
        account_item_max_key = Math.max(account_item_max_key, parseInt($(this).data('account_item_key')));
    })

    function get_clear_account_item_bx(){
        let account_item_bx = $('.account_item:first').clone(true);
        account_item_bx.find('input').attr('value', '');
        return account_item_bx;
    }

    function set_account_item_key(){
        account_item_max_key++;
        const re = /(account_item\[)(\d*)(\]\[.*\])/g;
        clear_account_item_bx.attr('data-account_item_key', account_item_max_key);
        clear_account_item_bx.find('input').each(function(){
            $(this).attr('name', $(this).attr('name').replace(re, "$1"+account_item_max_key+"$3"));
        });
    }

    $('.add_account').live('click', function(){
        set_account_item_key();
        let new_account_item = clear_account_item_bx.clone().appendTo('.u_account');
        new_account_item.find('input[type=text]:first').focus();
    });

    $('.account_item .close_account_item_btn').live('click', function(){
        $(this).closest('.account_item').fadeOut(200, function(){$(this).remove();});
        return false;
    });


    // ACCESS CODES
    let clear_access_code_item_bx = get_clear_access_code_item_bx();
    let access_code_item_max_key = 0;

    $('.access_code_item').each(function(){
        access_code_item_max_key = Math.max(access_code_item_max_key, parseInt($(this).data('access_code_key')));
    })

    function get_clear_access_code_item_bx(){
        let access_code_item_bx = $('.access_code_item:first').clone(true);
        access_code_item_bx.find('input').attr('value', '');
        return access_code_item_bx;
    }

    function set_access_code_item_key(){
        access_code_item_max_key++;
        const re = /(access_code_item\[)(\d*)(\]\[.*\])/g;
        clear_access_code_item_bx.attr('data-access_code_key', access_code_item_max_key);
        clear_access_code_item_bx.find('input').each(function(){
            $(this).attr('name', $(this).attr('name').replace(re, "$1"+access_code_item_max_key+"$3"));
        });
    }

    $('.add_new_access_code').live('click', function(){
        set_access_code_item_key();
        let new_access_code_item = clear_access_code_item_bx.clone().appendTo('.access_codes').css({'border-radius': '0'});
        new_access_code_item.find('input[type=text]:first').focus();
    });

    $('.access_code_item .close_access_code_btn').live('click', function(){
        $(this).closest('.access_code_item').fadeOut(200, function(){
            $(this).remove();
        });
        return false;
    });
});

$('#save').click(function () {
    $('.alert.success').addClass('show');
});


let close = $('.closeBtn');
let i;

for (i = 0; i < close.length; i++) {
    close[i].onclick = function(){
        let div = $('.alert.success').css('opacity', '0');
        setTimeout(function(){
            div.css('display', 'none')
        }, 600);
    }
}


$(".radio_types").live('click',function (){
    if($(this).is(":checked") && $(this).val()=='2'){
        let room_price = $(this).closest('.room_item').find('.roomPrice').removeClass('hide');
        room_price.find('input[type=text]:first').focus();
    }else{
        $(this).closest('.room_item').find('.roomPrice').addClass('hide');
    }
});


