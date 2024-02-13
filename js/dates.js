$(function () {
    let d_to = $('#date_to');
    let d_from = $('#date_from');

    $.fn.datepicker.language['en'] = {
        days: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
        daysShort: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
        daysMin: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'],
        months: ['January','February','March','April','May','June', 'July','August','September','October','November','December'],
        monthsShort: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        today: 'Today',
        clear: 'Clear',
        firstDay: 0
    };

    let date_to_init = 0;
    let date_to = d_to.datepicker({
        // minDate: new Date(),
        autoClose: true,
        // position: 'bottom right',
        language: 'en',
        dateFormat: 'yyyy-mm-dd',
        onSelect: function onSelect(fd, date) {
            if(date_to_init == 1)
            {
                date_from.update('maxDate', date);
            }
            else
                date_to_init = 1;
        }
    }).data('datepicker');

    let date_from_init = 0;
    let date_from = d_from.datepicker({
        // minDate: new Date(),
        autoClose: true,
        language: 'en',
        dateFormat: 'yyyy-mm-dd',
        onSelect: function onSelect(fd, date){
            if(date){
                if(date_from_init == 1)
                {
                    date_to.update('minDate', date);
                    date_to.show();
                }
                else
                    date_from_init = 1;

            }
        }
    }).data('datepicker');
});