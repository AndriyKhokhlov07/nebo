Number.prototype.toMoney = function(decimals = 2, decimalSeparator = '.', thousandsSeparator = ',', prefix = '$ ', suffix = ''){
    let [whole = '0', fract = ''] = this.toFixed(decimals).split('.');
    let partWhole = [];
    let i = whole.length - 3;
    while (i > 0){
        partWhole.unshift(whole.substring(i, i + 3));
        i -= 3;
    }
    partWhole.unshift(whole.substring(0, i + 3));
    return prefix + partWhole.join(thousandsSeparator) + (fract !== '' ? decimalSeparator + fract : '') + suffix;
}

$(document).ready(function(){

    var $form = $('form#renters-quote');
    var params = JSON.parse(atob($form.attr('params')));

    let getSureRates = function(params){
        request('getSureRates', params)
            .success(function(data){
                params.quote_id = data.quote_id;
                let preparedData = [];
                data.rates.personal_property.forEach(function(item){
                    let prepareData = {
                        value: item.personal_property_coverage,
                        caption: item.personal_property_coverage.toMoney(0),
                        attrs: [{ name: 'apd', value: item.all_peril_deductible }]
                    }
                    if(params.all_peril_deductible != item.all_peril_deductible){
                        prepareData.attrs.push({ name: 'style', value: 'display: none' });
                    }else if(params.personal_property_coverage == item.personal_property_coverage){
                        prepareData.attrs.push({ name: 'selected' });
                    }
                    preparedData.push(prepareData);
                });
                buildSelectorOptions($form.find('select[name="personal_property_coverage"]'), preparedData);
                preparedData = [];
                data.rates.personal_property.forEach(function(item){
                    let prepareData = {
                        value: item.all_peril_deductible,
                        caption: item.all_peril_deductible.toMoney(0),
                        attrs: [{ name: 'apd', value: item.personal_property_coverage }]
                    }
                    if(params.personal_property_coverage != item.personal_property_coverage){
                        prepareData.attrs.push({ name: 'style', value: 'display: none'});
                    }else if(params.all_peril_deductible == item.all_peril_deductible){
                        prepareData.attrs.push({ name: 'selected' });
                    }
                    preparedData.push(prepareData);
                });
                buildSelectorOptions($form.find('select[name="all_peril_deductible"]'), preparedData);
                preparedData = [];
                data.rates.liability.forEach(function(item){
                    let prepareData = {
                        value: item.liability_limit,
                        caption: item.liability_limit.toMoney(0)
                    }
                    if(params.liability_limit == item.liability_limit){
                        prepareData.attrs.push({ name: 'selected' });
                    }
                });
                buildSelectorOptions($form.find('select[name="liability_limit"]'), preparedData);
            });
    }
    let getSureCheckout = function(params){
        request('getSureCheckout', params)
            .success(function(data){
                params.quote_id = data.quote.id;
                $('input[name="quote_id"]').val(data.quote.id);
                getSureCadences(params);
            });
    }
    let getSureCadences = function(params){
        request('getSureCadences', params)
            .success(function(data){
                let $block = $('.form-block.quote-title');
                data.cadences.map(function(cadence){
                    let $subblock = $block.find('.' + cadence.payment_cadence);
                    if(cadence.payment_cadence === 'annual'){
                        $subblock.find('.downpayment span').text(cadence.downpayment_amount.toMoney());
                    }
                    if(cadence.payment_cadence === 'eleven_pay'){
                        $subblock.find('.downpayment span').text(cadence.downpayment_amount.toMoney());
                        $subblock.find('.installment span').text(cadence.full_installment_amount.toMoney());
                    }
                });
            });
    }
    let request = function(method, params){
        // preloader.show();
        let data = params;
        data.method = method;
        return $.ajax({
            dataType: 'json',
            url: 'ajax/sure.php?' + $.param(data),
            method: 'GET'
        })
            .success(function(data){
                if(typeof data.error !== 'undefined'){
                    console.error(data.error);
                }
            })
            .always(function(data){
                // preloader.hide();
            })
    }
    let getFormData = function(){
        let result = {};
        $form.find ('input').each(function() {
            result[this.name] = $(this).val();
        });
        $form.find('select').each(function() {
            if(['all_peril_deductible', 'liability_limit', 'personal_property_coverage'].includes(this.name)){
                result[this.name] = parseInt($(this).val());
            }else{
                result[this.name] = $(this).val();
            }
        });
        return result;
    }
    let updateParamsFromFormData = function(){
        let formData = getFormData();
        for(let key in formData){
            params[key] = formData[key];
        }
    }
    let updateForm = function(){
        // getSureRates(params);
        getSureCheckout(params);
    }
    let buildSelectorOptions = function($selector, data){
        let options = '';
        data.forEach(function (item) {
            options += '<option value="' + item.value + '"';
            if(typeof item.attrs !== 'undefined'){
                item.attrs.forEach(function(attr){
                    options += ' ' + attr.name;
                    if(typeof attr.value !== 'undefined'){
                        options += '="' + attr.value + '"';
                    }
                });
            }
            options += '">' + item.caption + '</option>'
        });
        $selector.html(options);
    }

    $form.find('input').on('change', function(event){
        updateParamsFromFormData();
        updateForm();
    });

    $form.find('select').on('change', function(event){
        updateParamsFromFormData();
        let elementName = $(this).attr('name');
        if(elementName === 'payment_cadence'){
            $form.find('.quote-title>div').hide();
            $form.find('.quote-title>div[tag="' + $(this).val() + '"]').show();
        }else{
            updateForm();
        }
    });
    $form.on('submit', function(event){
        // preloader.show();
    });
});