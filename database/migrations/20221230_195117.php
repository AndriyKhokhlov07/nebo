<?php

use Libs\DBHelper\Schema;

class Migration_20221230_195117
{
    use Schema;

    public function up(): void
    {
        self::addRawSql("
            ALTER TABLE `s_bookings` ADD `price_utility_total` DECIMAL(10,2) NULL DEFAULT NULL AFTER `price_night`; 
            ALTER TABLE `s_contracts` ADD `price_utility_total` DECIMAL(10,2) NULL DEFAULT NULL AFTER `price_utilites`;
        ");
    }

    public function down(): void
    {
        self::addRawSql("
            ALTER TABLE `s_bookings` drop column `price_utility_total`;
            ALTER TABLE `s_contracts` drop column `price_utility_total`;
        ");
    }
}