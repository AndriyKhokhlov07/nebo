<?php

use Libs\DBHelper\Schema;

class Migration_20221026_094127
{
    use Schema;

    public function up(): void
    {
        self::addRawSql("
            ALTER TABLE `s_orders` ADD `status_code` INT(4) NULL DEFAULT NULL AFTER `status`; 
        ");
    }

    public function down(): void
    {
        self::addRawSql("
            alter table `s_orders` drop column `status_code`;
        ");
    }
}