<?php
exit;
/*

2 0 * * 7
(в воскресенье, в 00:02)
/usr/bin/wget -O - -q -t 1 https://ne-bo.com/cr/backup.php


18 00 * * *
(в 00:18)
/usr/bin/wget -O - -q -t 1 https://ne-bo.com/cr/cancel_bookings_approved_notsigned.php


25 00 * * *
(в 00:25)
/usr/bin/wget -O - -q -t 1 https://ne-bo.com/cr/notify_approved_notsigned.php


15 00 * * *
(в 00:15)
/usr/bin/wget -O - -q -t 1 https://ne-bo.com/cr/cancel_bookings_without_appfee.php


20 00 * * *
(в 00:20)
/usr/bin/wget -O - -q -t 1 https://ne-bo.com/cr/notify_without_appfee.php


0 1 1 * *
(1 числа, в 01:00)
/usr/bin/wget -O - -q -t 1 https://ne-bo.com/cr/house_stat_update.php


*/

//   */10 * * * *
//   (каждые 10 минут)
//   /usr/bin/wget -O - -q -t 1 https://ne-bo.com/cr/qira_invoice_check.php

/*


*/

//   */11 * * * *
//   (каждые 11 минут)
//   /usr/bin/wget -O - -q -t 1 https://ne-bo.com/cr/qira_invoice_check.php?action=check_failed

/*


10 0 5 * *
(5 числа, в 00:10)
/usr/bin/wget -O - -q -t 1 https://ne-bo.com/cr/save_month_occupancy.php


0 9,10,11 * * *
(в 09:00, 10:00, 11:00)
/usr/bin/wget -O - -q -t 1 https://ne-bo.com/cr/send_invoice_email.php


 7 0 * * *
(в 00:07)
/usr/bin/wget -O - -q -t 1 https://ne-bo.com/cr/update_booking_living_status.php


5 0 5 * *
(5 числа, в 00:05)
/usr/bin/wget -O - -q -t 1 https://ne-bo.com/cr/update_month_stats.php


0 0 * * *
(в 00:00)
/usr/bin/wget -O - -q -t 1 https://ne-bo.com/cr/user_active_booking.php



10 0 5 * *
(5 числа, в 00:10)
/usr/bin/wget -O - -q -t 1 https://ne-bo.com/cr/autocharge_send_warning.php

10 10 * * *
(ежедневно, в 10:10)
/usr/bin/wget -O - -q -t 1 https://ne-bo.com/cr/autocharge_payment.php



(ежедневно, в 12:10)
/usr/bin/wget -O - -q -t 1  https://ne-bo.com/cr/invoices_dont_pay_info.php


(ежедневно, в 10:15)
/usr/bin/wget -O - -q -t 1  https://ne-bo.com/cr/invoices_late_payment_info.php

(ежедневно, в 10:20)
/usr/bin/wget -O - -q -t 1  https://ne-bo.com/cr/invoices_add_late_payment_fee.php

