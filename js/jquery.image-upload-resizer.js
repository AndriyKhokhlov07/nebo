(function( $ ) {

    $.fn.imageUploadResizer = function(options) {
        var settings = $.extend({
            max_width: 1000,
            max_height: 1000,
            quality: 1,
            do_not_resize: [],
        }, options );

        let updatePreview = function (el, fileData) {
            if (empty(el)) {
                return false;
            }
            if ($(el).closest('.file_block')) {
                let file_block = $(el).closest('.file_block');
                file_block.find('img').attr('src', URL.createObjectURL(fileData));

                file_block.find('.preview_block').addClass('active');
                $(el).removeClass('not_req');
                $(el).closest('.input_wrapper').find('.req_info').addClass('hide');
            }
        }

        this.filter('input[type="file"]').each(function () {

            const el = this;
            let dataTransfer = new DataTransfer();

            let returnOrigunalFile = function (fileSet) {
                setTimeout(()=>{
                    dataTransfer.items.add(fileSet.originalFile);
                    el.files = dataTransfer.files;
                    updatePreview(el, fileSet.originalFile);
                });
                fileSet.to_resize = false;
                // return;
            }



            this.onchange = function() {

                for (var i = 0, f; f = this.files[i]; i++) {
                    let fileSet = {
                        originalFile: f,
                        // el: el,
                        file_key: i,
                        to_resize: true,
                    };
                    if (!fileSet.originalFile || !fileSet.originalFile.type.startsWith('image')) {
                        returnOrigunalFile(fileSet);
                    }

                    // Don't resize if doNotResize is set
                    if (settings.do_not_resize.includes('*') || settings.do_not_resize.includes( fileSet.originalFile.type.split('/')[1])) {
                        returnOrigunalFile(fileSet);
                    }


                    if (fileSet.to_resize) {

                        let getRender = function () {

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
                                        returnOrigunalFile(fileSet);
                                    }
                                    if (fileSet.to_resize) {
                                        const ratio = Math.min(settings.max_width / img.width, settings.max_height / img.height);
                                        const width = Math.round(img.width * ratio);
                                        const height = Math.round(img.height * ratio);

                                        canvas.width = width;
                                        canvas.height = height;

                                        var ctx = canvas.getContext('2d');
                                        ctx.drawImage(img, 0, 0, width, height);

                                        canvas.toBlob(function (blob) {
                                            let resizedFile = new File([blob], 'resized_' + fileSet.originalFile.name, fileSet.originalFile);

                                            dataTransfer.items.add(resizedFile);

                                            // temporary remove event listener, change and restore
                                            let currentOnChange = el.onchange;

                                            el.onchange = null;
                                            el.files = dataTransfer.files;
                                            el.onchange = currentOnChange;

                                            updatePreview(el, resizedFile);
                                        }, 'image/jpeg', settings.quality);
                                    }
                                }
                            }

                            reader.readAsDataURL(fileSet.originalFile);

                        }

                        if (fileSet.originalFile.type.split('/')[1] == 'heic') {
                            $('.preloader').show();
                            heic2any({
                                blob: fileSet.originalFile,
                                toType: "image/jpg",
                            })
                                .then(function (resultBlob) {
                                    fileSet.originalFile = new File([resultBlob], "heic" + fileSet.file_key + ".jpg", {
                                        type: "image/jpeg",
                                        lastModified: new Date().getTime()
                                    });
                                    $('.preloader').hide();

                                    getRender(fileSet);
                                });
                        } else {
                            getRender(fileSet);
                        }
                    }
                }
            }

        });

        return this;
    };

}(jQuery));