<?php

use Libs\DBHelper\Schema;

class Migration_20230717_110205
{
    use Schema;

    public function up(): void
    {
        self::addRawSql('
            ALTER TABLE `s_apartments` 
                ADD `occupancy_start` DATE NULL DEFAULT NULL AFTER `date_shutdown`, 
                ADD `occupancy_end` DATE NULL DEFAULT NULL AFTER `occupancy_start`;
            UPDATE `s_apartments` SET `occupancy_start`=`date_added`, `occupancy_end`=`date_shutdown`;
        ');
    }

    public function down(): void
    {
        self::addRawSql('
            ALTER TABLE `s_apartments` drop column `occupancy_start`;
            ALTER TABLE `s_apartments` drop column `occupancy_end`;
        ');
    }
}