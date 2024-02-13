<?php

use Libs\DBHelper\Schema;

class Migration_20220825_160209
{
    use Schema;

    public function up(): void
    {
        self::addRawSql("
            truncate table `s_sures`;

            alter table `s_sures` drop column `date_viewed`;
            alter table `s_sures` drop column `status`;
            alter table `s_sures` drop column `url`;
            alter table `s_sures` drop column `user_id`;
            alter table `s_sures` drop column `payment_id`;

            alter table `s_sures` change `date_created` `created_at` datetime default NOW() not null;

            alter table `s_sures` add `user_id` int after `id`;
            alter table `s_sures` add `booking_id` bigint after `user_id`;
            alter table `s_sures` add `plan_id` varchar(250) null after `booking_id`;
            alter table `s_sures` add `quote_id` varchar(250) null after `plan_id`;
            alter table `s_sures` add `params` text null after `quote_id`;
        ");
    }

    public function down(): void
    {
        self::addRawSql("
            truncate table `s_sures`;

            alter table `s_sures` drop column `user_id`;
            alter table `s_sures` drop column `booking_id`;
            alter table `s_sures` drop column `plan_id`;
            alter table `s_sures` drop column `quote_id`;
            alter table `s_sures` drop column `params`;

            alter table `s_sures` change `created_at` `date_created` datetime default NOW() not null;

            alter table `s_sures` add `url` varchar(255) NOT NULL;
            alter table `s_sures` add `user_id` int NOT NULL;
            alter table `s_sures` add `payment_id` varchar(255) NOT NULL;
            alter table `s_sures` add `date_viewed` datetime NOT NULL default NOW();
            alter table `s_sures` add `status` varchar(255) DEFAULT NULL;
        ");
    }
}