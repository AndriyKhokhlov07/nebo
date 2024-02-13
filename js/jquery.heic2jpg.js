(function( $ ) {

    $.fn.heic2jpg = function(options) {
        var settings = $.extend({
            toType: 'image/jpg'
        }, options );

        this.filter('input[type="file"]').each(function () {

            this.onchange = function() {
                let that = this; // input node
                let originalFile = this.files[0];

                console.log('heic2jpg');

                if (!originalFile || !originalFile.type.startsWith('image')) {
                    return;
                }

                console.log('heic2jpg: ' + originalFile.type.split('/')[1]);

                if (originalFile.type.split('/')[1] != 'heic') {
                    return;
                }
                //if (originalFile.type.split('/')[1] == 'heic') {
                    heic2any({
                        blob: originalFile,
                        toType: settings.toType
                    })
                        .then(function (resultBlob) {

                            // let url = URL.createObjectURL(resultBlob);
                            // $(input).parent().find(".upload-file").css("background-image", "url("+url+")"); //previewing the uploaded picture
                            //adding converted picture to the original <input type="file">
                            // let fileInputElement = $(input)[0];
                            //let container = new DataTransfer();
                            let file = new File([resultBlob], "heic"+".jpg",{type:"image/jpeg", lastModified:new Date().getTime()});
                            //container.items.add(file);

                            //fileInputElement.files = container.files;
                            //that.files = container.files;
                            //console.log("added");


                            originalFile = file;

                            // that.files = dataTransfer.files;

                            // console.log('heic2any: ' + originalFile.type.split('/')[1]);


                            // that.onchange = currentOnChange;

                            let dataTransfer = new DataTransfer();
                            dataTransfer.items.add(file);

                            // temporary remove event listener, change and restore
                            // var currentOnChange = that.onchange;

                            //that.onchange = null;
                            that.files = dataTransfer.files;
                            //that.onchange = currentOnChange;

                            let reader = new FileReader();
                            reader.onload = function (e) {

                            }

                            reader.readAsDataURL(originalFile);

                            console.log('heic2jpg result: ' + originalFile.type.split('/')[1]);
                        });
                //}

                /*
                var reader = new FileReader();

                reader.onload = function (e) {
                    var img = document.createElement('img');
                    var canvas = document.createElement('canvas');

                    img.src = e.target.result
                    img.onload = function () {
                        var ctx = canvas.getContext('2d');
                        ctx.drawImage(img, 0, 0);

                        if (img.width < settings.max_width && img.height < settings.max_height) {
                            // Resize not required
                            return;
                        }

                        const ratio = Math.min(settings.max_width / img.width, settings.max_height / img.height);
                        const width = Math.round(img.width * ratio);
                        const height = Math.round(img.height * ratio);

                        canvas.width = width;
                        canvas.height = height;

                        var ctx = canvas.getContext('2d');
                        ctx.drawImage(img, 0, 0, width, height);

                        canvas.toBlob(function (blob) {
                            var resizedFile = new File([blob], 'resized_'+originalFile.name, originalFile);

                            var dataTransfer = new DataTransfer();
                            dataTransfer.items.add(resizedFile);

                            // temporary remove event listener, change and restore
                            var currentOnChange = that.onchange;

                            that.onchange = null;
                            that.files = dataTransfer.files;
                            that.onchange = currentOnChange;

                        }, 'image/jpeg', settings.quality);
                    }
                }

                reader.readAsDataURL(originalFile);

                 */
            }
        });

        return this;
    };

}(jQuery));