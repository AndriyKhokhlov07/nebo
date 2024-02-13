<?php

use Libs\DBHelper\Schema;

class Migration_20230105_122450
{
    use Schema;

    public function up(): void
    {
        self::addRawSql("
            ALTER TABLE `s_contracts` ADD `utility_initiator` TINYINT(1) NOT NULL DEFAULT '0' AFTER `price_deposit`; 
        ");
    }

    public function down(): void
    {
        self::addRawSql("
            ALTER TABLE `s_contracts` drop column `utility_initiator`;
        ");
    }
}