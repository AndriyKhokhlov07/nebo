$(document).ready(function(){

    let getStripeToken = function(){
        return $.ajax({
            url: 'https://api.stripe.com/v1/tokens',
            type: 'POST',
            dataType: 'json',
            data: {
                // 'cardName': $('input[name="cardName"]').val(),
                // 'streetAddress': $('input[name="streetAddress"]').val(),
                // 'unit': $('input[name="unit"]').val(),
                // 'city': $('input[name="city"]').val(),
                // 'region': $('input[name="region"]').val(),
                'key': $('input[name="card_number"]').closest('.input_block_card').attr('data-key'),
                'card[cvc]': $('input[name="card_cvc"]').val(),
                'card[exp_month]': $('input[name="card_exp_month"]').val(),
                'card[exp_year]': $('input[name="card_exp_year"]').val(),
                'card[number]': $('input[name="card_number"]').val(),
            }
        })
            .done(function(data) {
                var token_to_send_to_sure = data.id;
            })
    }

    $('input[name="agreement"]').on('change', function(event){
        event.preventDefault();
        $('.button-next').prop('disabled', !$('input[name="agreement"]').is(':checked'));
    });
    $('.button-next').on('click', function(event){
        event.preventDefault();
        // preloader.show();
        if(!$('input[name="agreement"]').is(':checked')){
            return;
        }
        getStripeToken()
            .success(function(data){
                $('input[name="stripe_token"]').val(data.id);
                $('form#renters-purchase').trigger('submit');
            })
            .always(function(){
                // preloader.hide();
            });
    });
    $('input[name="agreement"]').trigger('change');

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
});