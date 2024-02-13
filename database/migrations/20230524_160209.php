<?php

use Libs\DBHelper\Schema;

class Migration_20230524_160209
{
    use Schema;

    public function up(): void
    {
        self::addRawSql('
            ALTER TABLE `s_prebookings` ADD `reservation_status` VARCHAR(20) NULL DEFAULT NULL AFTER `reservation_id`;
            UPDATE `s_prebookings` SET `airbnb_id`=null;
        ');
    }

    public function down(): void
    {
        self::addRawSql('
            ALTER TABLE `s_prebookings` drop column `reservation_status`;
        ');
    }
}