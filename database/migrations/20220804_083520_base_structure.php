<?php

use Libs\DBHelper\Schema;

class Migration_20220804_083520
{
    use Schema;

    public function up(): void
    {
        self::addRawSql("
CREATE TABLE `s_apartments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `house_id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `floor` int NOT NULL,
  `note` varchar(255) NOT NULL,
  `property_price` decimal(6,0) DEFAULT NULL,
  `price` decimal(6,0) DEFAULT NULL,
  `utility` tinyint(1) NOT NULL DEFAULT '1',
  `utility_price` decimal(6,0) DEFAULT NULL,
  `blocks` text NOT NULL,
  `images` text NOT NULL,
  `type` tinyint NOT NULL DEFAULT '1',
  `date_added` date DEFAULT NULL,
  `date_shutdown` date DEFAULT NULL,
  `rent_apartment` tinyint(1) NOT NULL,
  `tour_3d` varchar(255) NOT NULL,
  `visible` tinyint(1) NOT NULL,
  `position` int NOT NULL,
  `furnished` tinyint(1) NOT NULL DEFAULT '1',
  `stabilize` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=366 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_authors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `post` varchar(255) NOT NULL,
  `text` text NOT NULL,
  `image` varchar(255) NOT NULL DEFAULT '',
  `featured` tinyint(1) DEFAULT NULL,
  `position` int NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `position` (`position`),
  KEY `visible` (`visible`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_beds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` tinyint DEFAULT NULL,
  `room_id` int DEFAULT NULL,
  `floor` tinyint(1) NOT NULL,
  `name` varchar(50) NOT NULL,
  `note` varchar(255) NOT NULL,
  `position` int NOT NULL,
  `date_added` date DEFAULT NULL,
  `date_shutdown` date DEFAULT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `clean_date` date DEFAULT NULL,
  `clean_status` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `room_id` (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2021 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_beds_journal` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `parent_id` bigint NOT NULL DEFAULT '0',
  `group_id` bigint NOT NULL DEFAULT '0',
  `bed_id` int NOT NULL,
  `house_id` int NOT NULL,
  `user_id` int NOT NULL,
  `client_type_id` tinyint(1) NOT NULL DEFAULT '1',
  `price_month` decimal(10,2) NOT NULL,
  `price_day` decimal(10,2) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `arrive` date DEFAULT NULL,
  `depart` date DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `due` date DEFAULT NULL,
  `paid_to` date DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `substatus` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bed_id` (`bed_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2037 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_blog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(500) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) NOT NULL,
  `old_url` varchar(255) NOT NULL,
  `meta_title` varchar(500) NOT NULL,
  `meta_keywords` varchar(500) NOT NULL,
  `meta_description` varchar(500) NOT NULL,
  `annotation` text NOT NULL,
  `text` longtext NOT NULL,
  `image` varchar(255) NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT NOW(),
  `featured` tinyint(1) DEFAULT NULL,
  `rating` float NOT NULL,
  `votes` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `enabled` (`visible`),
  KEY `url` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=285 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_blog_tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL,
  `meta_title` varchar(255) NOT NULL,
  `meta_description` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `image` varchar(255) NOT NULL DEFAULT '',
  `related_posts` text NOT NULL,
  `featured` tinyint(1) DEFAULT NULL,
  `in_filter` tinyint(1) DEFAULT NULL,
  `position` int NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `url` (`url`),
  KEY `position` (`position`),
  KEY `visible` (`visible`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_bookings` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `sp_type` tinyint DEFAULT NULL,
  `sp_group_id` bigint DEFAULT NULL,
  `parent_id` bigint NOT NULL DEFAULT '0',
  `group_id` bigint NOT NULL DEFAULT '0',
  `object_id` int NOT NULL,
  `house_id` int NOT NULL,
  `apartment_id` int NOT NULL,
  `user_id` int NOT NULL,
  `client_type_id` tinyint(1) NOT NULL DEFAULT '1',
  `contract_type` int NOT NULL DEFAULT '0',
  `airbnb_reservation_id` varchar(255) NOT NULL,
  `price_month_airbnb` decimal(10,2) NOT NULL,
  `price_month` decimal(10,5) NOT NULL,
  `price_day` decimal(10,5) NOT NULL,
  `price_night` decimal(10,5) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `brokerfee_discount` decimal(6,2) DEFAULT NULL,
  `arrive` date DEFAULT NULL,
  `depart` date DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `due` date DEFAULT NULL,
  `paid_to` date DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `substatus` tinyint(1) NOT NULL,
  `living_status` tinyint(1) NOT NULL DEFAULT '0',
  `add_to_contract` tinyint(1) NOT NULL DEFAULT '0',
  `moved` tinyint NOT NULL,
  `manager_login` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bed_id` (`object_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18974 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_bookings_users` (
  `booking_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`booking_id`,`user_id`),
  KEY `product_id` (`booking_id`),
  KEY `category_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_brands` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `meta_title` varchar(500) NOT NULL,
  `meta_keywords` varchar(500) NOT NULL,
  `meta_description` varchar(500) NOT NULL,
  `description` text NOT NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `url` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `meta_title` varchar(255) NOT NULL,
  `meta_keywords` varchar(255) NOT NULL,
  `meta_description` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `image` varchar(255) NOT NULL DEFAULT '',
  `position` int NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `external_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `url` (`url`),
  KEY `parent_id` (`parent_id`),
  KEY `position` (`position`),
  KEY `visible` (`visible`),
  KEY `external_id` (`external_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_categories_features` (
  `category_id` int NOT NULL,
  `feature_id` int NOT NULL,
  PRIMARY KEY (`category_id`,`feature_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_cleaning_journal` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` int NOT NULL,
  `order_id` int NOT NULL,
  `house_id` int NOT NULL,
  `bed` varchar(255) NOT NULL,
  `date_from` date NOT NULL,
  `desired_date` date NOT NULL,
  `completion_date` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `cleaner_id` int NOT NULL,
  `note` text NOT NULL,
  `images` text NOT NULL,
  `images1` text NOT NULL,
  `images2` text NOT NULL,
  `images3` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=417 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_comments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL DEFAULT NOW(),
  `ip` varchar(20) NOT NULL,
  `object_id` int NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `text` text NOT NULL,
  `type` enum('product','blog') NOT NULL,
  `approved` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `product_id` (`object_id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_companies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `landlord_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `position` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_companies_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_companies_houses` (
  `company_id` int NOT NULL,
  `house_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_contracts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(255) DEFAULT NULL,
  `sku` varchar(255) NOT NULL,
  `type` int NOT NULL DEFAULT '1',
  `user_id` int NOT NULL,
  `reserv_id` bigint DEFAULT NULL,
  `house_id` int NOT NULL,
  `apartment_id` int NOT NULL,
  `bed_id` int NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rental_name` varchar(255) NOT NULL,
  `rental_address` varchar(255) NOT NULL,
  `date_from` date NOT NULL,
  `date_to` date NOT NULL,
  `price_month` decimal(10,2) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `price_deposit` decimal(10,2) NOT NULL,
  `price_utilites` decimal(10,2) NOT NULL,
  `split_deposit` tinyint(1) DEFAULT NULL,
  `membership` tinyint(1) NOT NULL,
  `signing` tinyint(1) DEFAULT NULL,
  `date_signing` datetime NOT NULL,
  `date_created` datetime NOT NULL,
  `date_viewed` datetime NOT NULL,
  `roomtype` int DEFAULT NULL,
  `room_type` tinyint NOT NULL,
  `link1_type` tinyint DEFAULT NULL,
  `note1` text NOT NULL,
  `sellflow` int DEFAULT NULL,
  `outpost_deposit` tinyint(1) DEFAULT '0',
  `sended` tinyint(1) NOT NULL DEFAULT '0',
  `options` text,
  `first_sellflow` tinyint(1) DEFAULT NULL,
  `approve` tinyint(1) NOT NULL DEFAULT '0',
  `approve_first_salesflow` tinyint(1) NOT NULL DEFAULT '0',
  `new_lease` tinyint(1) NOT NULL DEFAULT '0',
  `invoice_recreate` tinyint(1) NOT NULL DEFAULT '0',
  `rider_type` tinyint(1) NOT NULL,
  `rider_data` json NOT NULL,
  `free_rental_amount` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9049 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_contracts_users` (
  `contract_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`contract_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_costs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int NOT NULL,
  `house_id` int NOT NULL,
  `type` tinyint NOT NULL,
  `subtype` tinyint NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `sender_type` tinyint(1) NOT NULL,
  `sender` varchar(50) NOT NULL,
  `data` text,
  `note` varchar(255) NOT NULL,
  `ip` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2183 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_coupons` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(256) NOT NULL,
  `note` text NOT NULL,
  `expire` timestamp NULL DEFAULT NULL,
  `type` enum('absolute','percentage') NOT NULL DEFAULT 'absolute',
  `value` decimal(10,2) NOT NULL DEFAULT '0.00',
  `min_order_price` decimal(10,2) DEFAULT NULL,
  `single` int NOT NULL DEFAULT '0',
  `usages` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_currencies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '0',
  `sign` varchar(20) NOT NULL,
  `code` char(3) NOT NULL DEFAULT '',
  `rate_from` decimal(10,4) NOT NULL DEFAULT '1.0000',
  `rate_to` decimal(10,2) NOT NULL DEFAULT '1.00',
  `cents` int NOT NULL DEFAULT '2',
  `position` int NOT NULL,
  `enabled` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `position` (`position`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_delivery` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `free_from` decimal(10,2) NOT NULL DEFAULT '0.00',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `position` int NOT NULL,
  `separate_payment` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `position` (`position`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_delivery_payment` (
  `delivery_id` int NOT NULL,
  `payment_method_id` int NOT NULL,
  PRIMARY KEY (`delivery_id`,`payment_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Связка способом оплаты и способов доставки';

CREATE TABLE `s_features` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `position` int NOT NULL,
  `in_filter` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `position` (`position`),
  KEY `in_filter` (`in_filter`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_feedbacks` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `ip` varchar(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `message` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_forms_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` tinyint NOT NULL,
  `parent_id` int NOT NULL,
  `value` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `s_galleries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `meta_title` varchar(500) NOT NULL,
  `meta_description` varchar(500) NOT NULL,
  `meta_keywords` varchar(500) NOT NULL,
  `annotation` text NOT NULL,
  `body` longtext NOT NULL,
  `position` int NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `order_num` (`position`),
  KEY `url` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_galleries_cat` (
  `gallery_id` int NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`gallery_id`,`category_id`),
  KEY `product_id` (`gallery_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_galleries_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `meta_title` varchar(255) NOT NULL,
  `meta_keywords` varchar(255) NOT NULL,
  `meta_description` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `position` int NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `url` (`url`),
  KEY `parent_id` (`parent_id`),
  KEY `position` (`position`),
  KEY `visible` (`visible`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_gallery_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `annotation` text NOT NULL,
  `gallery_id` int NOT NULL DEFAULT '0',
  `filename` varchar(255) NOT NULL DEFAULT '',
  `main` tinyint(1) NOT NULL DEFAULT '0',
  `position` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `filename` (`filename`),
  KEY `product_id` (`gallery_id`),
  KEY `position` (`position`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `discount` decimal(5,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_housecleaners_houses` (
  `user_id` int NOT NULL,
  `house_id` int NOT NULL,
  `position` int NOT NULL,
  PRIMARY KEY (`user_id`,`house_id`),
  KEY `position` (`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_houseleaders_houses` (
  `user_id` int NOT NULL,
  `house_id` int NOT NULL,
  `position` int NOT NULL,
  PRIMARY KEY (`user_id`,`house_id`),
  KEY `position` (`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_houses_cleaning_days` (
  `house_id` int NOT NULL,
  `day` int NOT NULL,
  `type` int NOT NULL,
  PRIMARY KEY (`house_id`,`day`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `product_id` int NOT NULL DEFAULT '0',
  `filename` varchar(255) NOT NULL DEFAULT '',
  `position` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `filename` (`filename`),
  KEY `product_id` (`product_id`),
  KEY `position` (`position`)
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_inventories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL,
  `user_id` int NOT NULL,
  `house_id` int NOT NULL,
  `date` datetime NOT NULL,
  `note` text NOT NULL,
  `images` text NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `view` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

CREATE TABLE `s_inventories_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `type` tinyint(1) NOT NULL,
  `visible` tinyint(1) NOT NULL,
  `position` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

CREATE TABLE `s_inventories_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `unit` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `position` int NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=526 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

CREATE TABLE `s_inventories_items_chains` (
  `item_id` int NOT NULL,
  `parent_id` int NOT NULL,
  `type` enum('group','house') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

CREATE TABLE `s_inventories_values` (
  `id` int NOT NULL AUTO_INCREMENT,
  `inventory_id` int NOT NULL,
  `item_id` int NOT NULL,
  `group_id` int NOT NULL,
  `value` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2480 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

CREATE TABLE `s_issues` (
  `id` int NOT NULL AUTO_INCREMENT,
  `house_id` int NOT NULL,
  `email_guest` varchar(255) NOT NULL,
  `assignment` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `date_start` timestamp NULL DEFAULT NULL,
  `date_completion` timestamp NULL DEFAULT NULL,
  `assigned` varchar(255) NOT NULL,
  `details` varchar(255) NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

CREATE TABLE `s_labels` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `color` varchar(6) NOT NULL,
  `position` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_landlords_houses` (
  `user_id` int NOT NULL,
  `house_id` int NOT NULL,
  `position` int NOT NULL,
  PRIMARY KEY (`user_id`,`house_id`),
  KEY `position` (`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_leads` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `application_house_id` int NOT NULL,
  `move_in_date` date NOT NULL,
  `move_out_date` date DEFAULT NULL,
  `dates_flexible` varchar(50) DEFAULT NULL,
  `living_period` varchar(50) DEFAULT NULL,
  `budget` varchar(50) DEFAULT NULL,
  `room_type` varchar(50) DEFAULT NULL,
  `stay_alone` tinyint(1) DEFAULT NULL,
  `guest_first_name` varchar(50) DEFAULT NULL,
  `guest_last_name` varchar(50) DEFAULT NULL,
  `guest_email` varchar(50) DEFAULT NULL,
  `guest_phone` varchar(50) DEFAULT NULL,
  `listing_website` varchar(255) DEFAULT NULL,
  `apartment_listing_website` varchar(255) DEFAULT NULL,
  `friend_name` varchar(255) DEFAULT NULL,
  `corporate_referral_code` varchar(50) DEFAULT NULL,
  `code` varchar(100) DEFAULT NULL,
  `additional_info` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4274 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `s_leads_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lead_id` int NOT NULL,
  `type` tinyint(1) NOT NULL,
  `value_id` int DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16147 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `s_leases` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL,
  `contract_type` tinyint(1) DEFAULT NULL,
  `house_id` int NOT NULL,
  `apartment_id` int NOT NULL,
  `date_from` date DEFAULT NULL,
  `date_to` date DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `note` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `s_leases_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) DEFAULT NULL,
  `lease_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `bed_id` int DEFAULT NULL,
  `date_from` date DEFAULT NULL,
  `date_to` date DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `date_sign` date DEFAULT NULL,
  `client_type_id` tinyint DEFAULT NULL,
  `airbnb_id` varchar(255) DEFAULT NULL,
  `booking_id` bigint DEFAULT NULL,
  `contract_id` bigint DEFAULT NULL,
  `new` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=842 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `s_loans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL,
  `image` text NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `price` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `visible` tinyint(1) NOT NULL,
  `position` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_logs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `parent_id` bigint NOT NULL,
  `type` tinyint NOT NULL,
  `subtype` tinyint NOT NULL,
  `user_id` int NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sender_type` tinyint(1) NOT NULL,
  `sender` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `data` text,
  `ip` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=303706 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_managers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `login` varchar(255) NOT NULL,
  `type` tinyint NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `position` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_move_ins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `hl_id` int NOT NULL,
  `user_id` int NOT NULL,
  `type` tinyint(1) NOT NULL,
  `inputs` text NOT NULL,
  `date` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `notify_id` int NOT NULL,
  `booking_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8019 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_neighborhoods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `city_id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `position` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_notifications` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` tinyint NOT NULL,
  `subtype` tinyint DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  `user_id` int NOT NULL,
  `object_id` bigint DEFAULT NULL,
  `creator` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_viewed` datetime NOT NULL,
  `date` datetime NOT NULL,
  `time_from` time NOT NULL,
  `time_to` time NOT NULL,
  `priority` tinyint(1) DEFAULT NULL,
  `text` text NOT NULL,
  `auto_move` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19169 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_options` (
  `product_id` int NOT NULL,
  `feature_id` int NOT NULL,
  `value` varchar(1024) NOT NULL,
  PRIMARY KEY (`product_id`,`feature_id`),
  KEY `value` (`value`(333)),
  KEY `product_id` (`product_id`),
  KEY `feature_id` (`feature_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sku` varchar(255) DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '2',
  `contract_id` int DEFAULT NULL,
  `booking_id` bigint NOT NULL,
  `delivery_id` int DEFAULT NULL,
  `delivery_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `payment_method_id` int DEFAULT NULL,
  `paid` int NOT NULL DEFAULT '0',
  `payment_date` datetime NOT NULL,
  `payer_id` int DEFAULT NULL,
  `closed` tinyint(1) NOT NULL,
  `date` datetime DEFAULT NULL,
  `date_due` date DEFAULT NULL,
  `date_viewed` datetime NOT NULL,
  `date_from` date DEFAULT NULL,
  `date_to` date DEFAULT NULL,
  `user_id` int DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `address` varchar(255) NOT NULL DEFAULT '',
  `phone` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL,
  `comment` varchar(1024) NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `url` varchar(255) DEFAULT NULL,
  `payment_details` text NOT NULL,
  `ip` varchar(15) NOT NULL,
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `note` varchar(1024) NOT NULL,
  `discount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `discount_type` tinyint(1) NOT NULL DEFAULT '1',
  `discount_description` varchar(255) DEFAULT NULL,
  `coupon_discount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `coupon_code` varchar(255) NOT NULL,
  `separate_delivery` int NOT NULL DEFAULT '0',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `automatically` tinyint(1) DEFAULT '0',
  `deposit` tinyint(1) DEFAULT '0',
  `sended` tinyint(1) NOT NULL DEFAULT '0',
  `sended_owner` tinyint(1) DEFAULT NULL,
  `sended_owner_date` date DEFAULT NULL,
  `sended_owner_price` decimal(10,2) DEFAULT NULL,
  `child_refund_id` int NOT NULL,
  `parent_refund_id` int NOT NULL,
  `membership` tinyint(1) DEFAULT NULL,
  `transaction_id` varchar(36) NOT NULL,
  `payment_payer_id` varchar(36) NOT NULL,
  `last_checked_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `login` (`user_id`),
  KEY `written_off` (`closed`),
  KEY `date` (`date`),
  KEY `status` (`status`),
  KEY `code` (`url`),
  KEY `payment_status` (`paid`)
) ENGINE=InnoDB AUTO_INCREMENT=48146 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_orders_labels` (
  `order_id` int NOT NULL,
  `label_id` int NOT NULL,
  PRIMARY KEY (`order_id`,`label_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_orders_users` (
  `order_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`order_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_pages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int NOT NULL,
  `parent2_id` int DEFAULT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `sku` int NOT NULL,
  `old_url` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `meta_title` varchar(500) NOT NULL,
  `meta_description` varchar(500) NOT NULL,
  `meta_keywords` varchar(500) NOT NULL,
  `annotation` text NOT NULL,
  `bg_text` text NOT NULL,
  `body` longtext NOT NULL,
  `menu_id` int NOT NULL DEFAULT '0',
  `service_ids` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `bg_image` varchar(255) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `position` int NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '0',
  `header` varchar(1024) NOT NULL,
  `rating` float NOT NULL,
  `votes` int NOT NULL,
  `blocks` text NOT NULL,
  `blocks2` text NOT NULL,
  `related` text NOT NULL,
  `move_in` longtext NOT NULL,
  `last_invoice` int NOT NULL DEFAULT '0',
  `last_contract` int NOT NULL DEFAULT '0',
  `type` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `order_num` (`position`),
  KEY `url` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=438 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_payment_methods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `module` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `currency_id` float NOT NULL,
  `settings` text NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `for_all_houses` tinyint(1) NOT NULL DEFAULT '0',
  `position` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `position` (`position`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_payment_methods_houses` (
  `payment_method_id` int NOT NULL,
  `house_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_posts_authors` (
  `post_id` int NOT NULL,
  `author_id` int NOT NULL,
  `position` int NOT NULL,
  PRIMARY KEY (`post_id`,`author_id`),
  KEY `position` (`position`),
  KEY `product_id` (`post_id`),
  KEY `category_id` (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_posts_tags` (
  `post_id` int NOT NULL,
  `tag_id` int NOT NULL,
  `position` int NOT NULL,
  PRIMARY KEY (`post_id`,`tag_id`),
  KEY `position` (`position`),
  KEY `product_id` (`post_id`),
  KEY `category_id` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL DEFAULT '',
  `brand_id` int DEFAULT NULL,
  `city_id` int DEFAULT NULL,
  `name` varchar(500) NOT NULL,
  `annotation` text NOT NULL,
  `body` longtext NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `position` int NOT NULL DEFAULT '0',
  `meta_title` varchar(500) NOT NULL,
  `meta_keywords` varchar(500) NOT NULL,
  `meta_description` varchar(500) NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `featured` tinyint(1) DEFAULT NULL,
  `external_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `url` (`url`),
  KEY `brand_id` (`brand_id`),
  KEY `visible` (`visible`),
  KEY `position` (`position`),
  KEY `external_id` (`external_id`),
  KEY `hit` (`featured`),
  KEY `name` (`name`(333))
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_products_categories` (
  `product_id` int NOT NULL,
  `category_id` int NOT NULL,
  `position` int NOT NULL,
  PRIMARY KEY (`product_id`,`category_id`),
  KEY `position` (`position`),
  KEY `product_id` (`product_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_purchases` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL DEFAULT '0',
  `product_id` int DEFAULT '0',
  `variant_id` int DEFAULT NULL,
  `product_name` varchar(255) NOT NULL DEFAULT '',
  `variant_name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `amount` int NOT NULL DEFAULT '0',
  `sku` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  KEY `variant_id` (`variant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=72066 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_related_galleries` (
  `image_id` int NOT NULL,
  `related_id` int NOT NULL,
  `type` tinyint(1) NOT NULL,
  `position` int NOT NULL,
  KEY `position` (`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_related_products` (
  `product_id` int NOT NULL,
  `related_id` int NOT NULL,
  `position` int NOT NULL,
  PRIMARY KEY (`product_id`,`related_id`),
  KEY `position` (`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_rlabels` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `color` varchar(6) NOT NULL,
  `position` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_rooms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_id` int NOT NULL,
  `house_id` int NOT NULL,
  `apartment_id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `note` varchar(255) NOT NULL,
  `price1` decimal(5,0) NOT NULL,
  `price2` decimal(5,0) NOT NULL,
  `price3` decimal(5,0) NOT NULL,
  `square` decimal(10,3) NOT NULL DEFAULT '0.000',
  `visible` tinyint(1) NOT NULL,
  `position` int NOT NULL,
  `color` varchar(6) NOT NULL,
  `date_added` date DEFAULT NULL,
  `date_shutdown` date DEFAULT NULL,
  `title` varchar(500) NOT NULL,
  `description` varchar(500) NOT NULL,
  `images` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1888 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_rooms_rlabels` (
  `room_id` int NOT NULL,
  `label_id` int NOT NULL,
  PRIMARY KEY (`room_id`,`label_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_rooms_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `position` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_salesflows` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `booking_id` int NOT NULL,
  `type` tinyint NOT NULL,
  `application_data` text NOT NULL,
  `application_type` tinyint NOT NULL DEFAULT '1',
  `additional_files` text NOT NULL,
  `transunion_id` bigint NOT NULL,
  `transunion_data` text NOT NULL,
  `transunion_status` tinyint(1) NOT NULL,
  `ekata_status` varchar(255) NOT NULL,
  `ra_fee_status` int NOT NULL,
  `deposit_type` tinyint(1) NOT NULL,
  `deposit_status` tinyint(1) NOT NULL,
  `transfer_deposit` int NOT NULL DEFAULT '0',
  `approve` tinyint(1) NOT NULL,
  `landlord_approve` tinyint(1) NOT NULL DEFAULT '0',
  `contract_status` tinyint(1) NOT NULL DEFAULT '0',
  `covid_form_status` tinyint(1) NOT NULL,
  `invoice_status` tinyint(1) NOT NULL,
  `ekata_upd` tinyint(1) NOT NULL DEFAULT '0',
  `house_rules_status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15863 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_settings` (
  `setting_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  PRIMARY KEY (`setting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_sures` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `user_id` int NOT NULL,
  `payment_id` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_viewed` datetime NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sku` int NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `client_type_id` tinyint(1) DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL DEFAULT '',
  `first_pass` varchar(255) NOT NULL,
  `landlord_code` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(255) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `active_booking_id` bigint DEFAULT NULL,
  `active_salesflow_id` int DEFAULT NULL,
  `group_id` int NOT NULL DEFAULT '0',
  `house_id` int NOT NULL,
  `apartment_id` int DEFAULT NULL,
  `bed_name` varchar(8) DEFAULT NULL,
  `bed_id` int DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `moved_in` tinyint(1) NOT NULL,
  `valid_email` tinyint(1) NOT NULL DEFAULT '0',
  `last_ip` varchar(15) DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `facebook_id` bigint NOT NULL,
  `image` varchar(255) NOT NULL,
  `blocks` text NOT NULL,
  `inquiry_arrive` date NOT NULL,
  `inquiry_depart` date NOT NULL,
  `room_type` tinyint NOT NULL,
  `price_month` decimal(10,2) NOT NULL,
  `price_deposit` decimal(10,2) NOT NULL,
  `membership` tinyint(1) NOT NULL,
  `hide_ach` tinyint(1) NOT NULL DEFAULT '0',
  `note` varchar(1024) NOT NULL,
  `birthday` date DEFAULT NULL,
  `gender` tinyint(1) NOT NULL,
  `us_citizen` tinyint(1) NOT NULL,
  `social_number` varchar(500) NOT NULL,
  `zip` varchar(500) NOT NULL,
  `state_code` varchar(2) DEFAULT NULL,
  `city` varchar(30) NOT NULL,
  `street_address` varchar(50) NOT NULL,
  `apartment` varchar(20) NOT NULL,
  `employment_status` tinyint(1) DEFAULT NULL,
  `employment_income` decimal(8,0) DEFAULT NULL,
  `transunion_id` bigint DEFAULT NULL,
  `transunion_status` tinyint(1) DEFAULT NULL,
  `transunion_data` text,
  `checker_options` text NOT NULL,
  `checkr_candidate_id` varchar(50) DEFAULT NULL,
  `hellorented_tenant_id` varchar(50) DEFAULT NULL,
  `security_deposit_type` tinyint(1) DEFAULT NULL,
  `security_deposit_status` tinyint(1) DEFAULT NULL,
  `files` text NOT NULL,
  `auth_code` varchar(255) NOT NULL,
  `dont_extend` tinyint(1) NOT NULL DEFAULT '0',
  `block_notifies` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=29770 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_users_users` (
  `type` tinyint(1) NOT NULL,
  `parent_id` bigint NOT NULL,
  `child_id` bigint NOT NULL,
  PRIMARY KEY (`type`,`parent_id`,`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `s_variants` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `sku` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(14,2) NOT NULL DEFAULT '0.00',
  `compare_price` decimal(14,2) DEFAULT NULL,
  `stock` mediumint DEFAULT NULL,
  `position` int NOT NULL,
  `attachment` varchar(255) NOT NULL,
  `external_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `sku` (`sku`),
  KEY `price` (`price`),
  KEY `stock` (`stock`),
  KEY `position` (`position`),
  KEY `external_id` (`external_id`)
) ENGINE=InnoDB AUTO_INCREMENT=264 DEFAULT CHARSET=utf8mb4;
        ");
    }

    public function down(): void
    {
        self::addRawSql("");
    }
}