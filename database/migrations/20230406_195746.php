<?php

use Libs\DBHelper\Schema;

class Migration_20230406_195746
{
    use Schema;

    public function up(): void
    {
        self::addRawSql("
CREATE TABLE `s_prebookings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` tinyint(2) UNSIGNED NOT NULL,
  `status` tinyint(2) UNSIGNED NOT NULL,
  `created` datetime NOT NULL,
  `reservation_id` varchar(255) NOT NULL,
  `booking_id` BIGINT(20) UNSIGNED NULL,
  `user_id` BIGINT(20) UNSIGNED NULL,
  `airbnb_id` varchar(100) NULL,
  `arrive` date NOT NULL,
  `depart` date NOT NULL,
  `days` float NOT NULL,
  `house_id` int(11) NULL,
  `guest_first_name` varchar(50) NULL,
  `guest_last_name` varchar(50) NULL,
  `guest_phone` varchar(50) NULL,
  `guest_email` varchar(70) NULL,
  `guest_airbnb_id` BIGINT(20) UNSIGNED NULL,
  `guest_airbnb2_id` BIGINT(20) UNSIGNED NULL,
  `guests_count` float NULL,
  `booking_type` tinyint(2) NULL,
  `beds` tinyint(2) NULL,
  `listing_name` varchar(255) NULL,
  `listing_title` varchar(255) NULL,
  `listing_house_address` varchar(255) NULL,
  `listing_image` varchar(255) NULL,
  `property_type` varchar(100) NULL,
  `room_type` varchar(100) NULL,
  `price` decimal(10,2) NULL,
  `invoice_items` json DEFAULT NULL,
  `payments` json DEFAULT NULL,
  `manager_login` varchar(100) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


ALTER TABLE `s_prebookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reservation_id` (`reservation_id`);


ALTER TABLE `s_prebookings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;


ALTER TABLE `s_logs` ADD INDEX(`parent_id`); 
ALTER TABLE `s_logs` ADD INDEX(`type`); 
ALTER TABLE `s_logs` ADD INDEX(`subtype`); 


ALTER TABLE `s_users` ADD `airbnb_id` BIGINT(20) UNSIGNED NULL AFTER `files`, ADD `airbnb2_id` BIGINT(20) UNSIGNED NULL AFTER `airbnb_id`; 


ALTER TABLE `s_bookings` ADD `prebooking_id` BIGINT(20) UNSIGNED NULL AFTER `contract_type`; 
        ");
    }

    public function down(): void
    {
        self::addRawSql("
            drop table s_prebookings;
            ALTER TABLE s_logs DROP INDEX parent_id;
            ALTER TABLE s_logs DROP INDEX type;
            ALTER TABLE s_logs DROP INDEX subtype;

            ALTER TABLE `s_users` drop column `airbnb_id`;
            ALTER TABLE `s_users` drop column `airbnb2_id`;

            ALTER TABLE `s_bookings` drop column `prebooking_id`;
        ");
    }
}