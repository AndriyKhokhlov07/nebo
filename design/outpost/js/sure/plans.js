$(document).ready(function(){

    let pbTabs = $('.step-progressbar .steps li');
    let errors = $('#renters-plans .errors-data').attr('data');
    if(errors !== ''){
        var errorsData = JSON.parse(errors);
    }

    let insertFormData = function(formData){
        Object.keys(formData).forEach(function(key){
            let value = formData[key];
            if(typeof value === 'object'){
                insertFormData(value);

            }else{
                let input = $('[name=' + key + ']');
                if(input.length > 0){
                    if(input[0].tagName.toLowerCase() === 'input'){
                        switch (input.attr('type')){
                            case 'text':
                            case 'email':
                                input.val(value);
                                break;
                            case 'date':
                                input.val(value);
                                break;
                            case 'radio':
                                input.removeProp('checked');
                                if(typeof value === 'boolean'){
                                    value = value ? 'true' : 'false';
                                }
                                $('input[type="radio"][name="' + key + '"][value="' + value + '"]').prop('checked', true);
                                break;
                        }
                    }else if(input[0].tagName.toLowerCase() === 'select'){
                        input.find('option').removeAttr('selected');
                        input.val(value);
                        input.find('option[value="' + value + '"]').attr('selected', 'selected');
                    }
                }
            }
        });
    }
    let buildSelectorOptions = function($selector, data){
        let options = '';
        data.forEach(function (state) {
            options += '<option value="' + state.value + '">' + state.caption + '</option>'
        });
        $selector.html(options);
    }
    let getSection = function(tag){
        return $('#renters-plans .form-section[tag="' + tag + '"]');
    }
    let setBackSection = function(recipientSectionTag, destinationSectionTag){
        getSection(recipientSectionTag).find('.button-back').attr('back-to-section', destinationSectionTag);
    }
    let getBackSection = function($currentSection){
        let tag = $currentSection.find('.button-back').attr('back-to-section');
        return getSection(tag);
    }
    let showSection = function(showingSectionTag, addedBackTag = null){
        $('html, body').animate({scrollTop: 0}, 800);
        if(addedBackTag !== null){
            setBackSection(showingSectionTag, addedBackTag);
        }
        let $showingSection = getSection(showingSectionTag);
        if(typeof $showingSection.attr('pb') !== 'undefined'){
            let pbTab = parseInt($showingSection.attr('pb'));
            for(let i=0; i<pbTabs.length; i++){
                let $tab = $(pbTabs[i]);
                if(parseInt($tab.attr('tag')) < pbTab){
                    $tab.removeClass('is-active not-active').addClass('actived');
                }else if(parseInt($tab.attr('tag')) === pbTab){
                    $tab.removeClass('actived not-active').addClass('is-active');
                }else{
                    $tab.removeClass('is-active actived').addClass('not-active');
                }
            }
        }
        $showingSection.show();
    }

    // insertFormData(formData);

    $('#renters-plans .form-section').hide();

    $('.step-progressbar .steps li>span.progress-count').each(function(i){
        this.innerText = i + 1;
    });
    showSection(1);

    $('#renters-plans .form-section .button-back').on('click', function(event){
        event.preventDefault();
        let currentSection = $(this.closest('.form-section'));
        currentSection.hide();
        showSection(getBackSection(currentSection).attr('tag'));
    });

    $('#renters-plans .form-section .button-next').on('click', function(event){
        event.preventDefault();
        $('.--error').remove();
        let $activeSection = $(this).closest('.form-section');
        let activeTag = parseInt($activeSection.attr('tag'));
        if(activeTag === 1){
            let $inputPhone = $('input[name="pni_phone_number"]');
            if($inputPhone.val().replace(/\D/g, '').length !== 10){
                $inputPhone.after('<span class="--error"><label>Incorrect Phone Number!</label></span>');
                $('input[name="pni_phone_number"]').focus();
                return false;
            }
        }
        $activeSection.hide();
        let val;
        switch (activeTag){
            case 1:
                // showSection(2, activeTag);
                showSection(14, activeTag);
                break;
            // case 2:
            //     val = $activeSection.find('input[name="has_mailing_address"]:checked').val();
            //     if(val === 'true'){
            //         showSection(3, activeTag);
            //     }else if(val === 'false'){
            //         showSection(4, activeTag);
            //     }
            //     break;
            // case 3:
            //     showSection(4, activeTag);
            //     break;
            // case 4:
            //     val = $activeSection.find('input[name="dwelling_type"]:checked').val();
            //     if(['A', 'T', 'D'].includes(val)){
            //         showSection(6, activeTag);
            //     }else if(val === 'S'){
            //         showSection(5, activeTag);
            //     }
            //     break;
            // case 5:
            //     val = $activeSection.find('input[name="is_mobile_or_manufactured_home"]:checked').val();
            //     if(val === 'true'){
            //         showSection(100, activeTag);
            //     }else if(val === 'false'){
            //         showSection(6, activeTag);
            //     }
            //     break;
            // case 6:
            //     val = $activeSection.find('input[name="mandatory_insurance_requirement"]:checked').val();
            //     if(val === 'true'){
            //         showSection(10, activeTag);
            //     }else if(val === 'false'){
            //         showSection(7, activeTag);
            //     }
            //     break;
            // case 7:
            //     val = $activeSection.find('input[name="number_of_losses"]:checked').val();
            //     if(val === '0'){
            //         // showSection(9, activeTag);
            //         showSection(14, activeTag);
            //     }else if(val === '1'){
            //         showSection(8, activeTag);
            //     }else if(val === '2+'){
            //         showSection(100, activeTag);
            //     }
            //     break;
            // case 8:
            //     // showSection(9, activeTag);
            //     showSection(14, activeTag);
            //     break;
            // case 9:
            //     val = $activeSection.find('input[name="animal_injury"]:checked').val();
            //     if(val === 'true'){
            //         showSection(100, activeTag);
            //     }else if(val === 'false'){
            //         showSection(12, activeTag);
            //     }
            //     break;
            // case 10:
            //     val = $activeSection.find('input[name="has_sni"]:checked').val();
            //     if(val === 'true'){
            //         showSection(11, activeTag);
            //     }else if(val === 'false'){
            //         showSection(12, activeTag);
            //     }
            //     break;
            // case 11:
            //     showSection(12, activeTag);
            //     break;
            // case 12:
            //     val = $activeSection.find('input[name="has_intrested_party"]:checked').val();
            //     if(val === 'true'){
            //         showSection(13, activeTag);
            //     }else if(val === 'false'){
            //         showSection(14, activeTag);
            //     }
            //     break;
            // case 13:
            //     showSection(14, activeTag);
            //     break;
            case 14:
                // preloader.show();
                $('#renters-plans').submit();
                break;
        }
    });
    $('input[datatype="phone"]').each(function(input){
        IMask(this, {mask: '000-000-0000'});
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

    if(typeof errorsData != 'undefined'){
        alert(errorsData.message);
    }

    // https://maps.googleapis.com/maps/api/place/js/AutocompletionService.GetPredictions?1s75%20Van%20Buren%20Street&4sru&9sgeocode&15e3&20sF659F4CE-C2A6-4236-966C-12C359FA5EA62ryza1ew3uez&21m1&2e1&callback=_xdc_._mupyk&key=AIzaSyDT59at8lkwzsFjtmTtaEpgM64xS1aAX3E&token=120699
});