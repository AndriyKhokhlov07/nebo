$(document).ready(function(){

    const GOOGLE_SEARCH_ADDRESS_CLASS = 'google-search-address';

    function initAutocomplete() {

        var inputs = document.querySelectorAll('input.google-search-address');
        var options = {
            fields: ['name', 'address_components', 'formatted_address', 'place_id', 'geometry'],
            types: ['geocode']
        };
        for (var i = 0; i < inputs.length; i++) {

            var autocomplete = new google.maps.places.Autocomplete(inputs[i], options);
            autocomplete.index = i;
            inputs[i].setAttribute('google-index', i);

            google.maps.event.addListener(autocomplete, 'place_changed', function () {
                let place = this.getPlace();
                let currentInput = $('input.' + GOOGLE_SEARCH_ADDRESS_CLASS + '[google-index="' + this.index + '"]');
                currentInput.attr('selected_address', currentInput.val());
                let dataInputName = (currentInput.attr('name') || currentInput.attr('id')) + '_' + GOOGLE_SEARCH_ADDRESS_CLASS;
                $('input[name="' + dataInputName + '"]').remove();
                let dataInput = $('<input>', {
                    name: dataInputName,
                    type: 'hidden',
                    hidden: true
                }).val(JSON.stringify(place));
                currentInput.after(dataInput);
            });
        };
    }

    $('form').bind('submit', function(event){
        if(document.activeElement.classList.contains(GOOGLE_SEARCH_ADDRESS_CLASS)){
            event.preventDefault();
        }else{
            $('input.google-search-address').each(function(){
                if(
                    this.hasAttribute('selected_address')
                    && $(this).attr('selected_address') !== $(this).val()
                ){
                    let errorLabel = $('<label/>')
                        .css('color', 'red')
                        .text('Address is not valid, please try again');
                    $(this).after(errorLabel)
                    $(this).focus();
                    event.preventDefault();
                }
            });
        }
    })

    initAutocomplete();

});


