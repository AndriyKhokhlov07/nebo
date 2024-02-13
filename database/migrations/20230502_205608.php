<?php

use Libs\DBHelper\Schema;

class Migration_20230502_205608
{
    use Schema;

    public function up(): void
    {
        self::addRawSql('
            ALTER TABLE `s_prebookings` ADD `guest_name` VARCHAR(100) NULL AFTER `house_id`; 
        ');
    }

    public function down(): void
    {
        self::addRawSql('
            ALTER TABLE `s_prebookings` drop column `guest_name`;
        ');
    }
}