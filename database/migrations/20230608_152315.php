<?php

use Libs\DBHelper\Schema;

class Migration_20230608_152315
{
    use Schema;

    public function up(): void
    {
        self::addRawSql('
            ALTER TABLE `s_purchases` ADD `type` TINYINT(3) UNSIGNED NULL AFTER `order_id`;
        ');
    }

    public function down(): void
    {
        self::addRawSql('
            ALTER TABLE `s_purchases` drop column `type`;
        ');
    }
}