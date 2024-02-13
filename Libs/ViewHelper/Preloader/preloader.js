$(document).ready(function(){

    var preloader = {
        preloader: null,
        container: null,
        disabledContainer: true,
        init: function(){
            this.preloader = $('.preloader')[0];
            this.container = $('body')[0];
            this.disabledContainer = this.preloader.hasAttribute('disabled-container');
        },
        show: function(){
            $(this.preloader).show();
            if(this.disabledContainer){
                $(this.container).attr("disabled", true);
            }
        },
        hide: function(){
            $(this.preloader).hide();
            $(this.container).removeAttr("disabled");
        }
    }
    preloader.init();

    $('a[href!="#"]').bind('click', function(event){
        preloader.show();
    });
    $('form').bind('submit', function(event){
        preloader.show();
    });
    $('button[data-fancybox-close]').bind('click', function(event){
        preloader.hide();
    });
    $(document).ajaxSend(function(event, request, settings){
        let urlSearchParams = new URLSearchParams(settings.url);
        let urlParams = Object.fromEntries(urlSearchParams.entries());
        if (typeof urlParams.preloader == 'undefined' || urlParams.preloader != 'off') {
            preloader.show();
        }
        request.always(function(){
            preloader.hide();
        });
    });

});
