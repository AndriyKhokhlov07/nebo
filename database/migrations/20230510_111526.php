<?php

use Libs\DBHelper\Schema;

class Migration_20230510_111526
{
    use Schema;

    public function up(): void
    {
        self::addRawSql("
            ALTER TABLE `s_apartments` ADD `bed` int(11) NOT NULL AFTER `name`;
            ALTER TABLE `s_apartments` ADD `bathroom` float NOT NULL AFTER `bed`;
        ");
    }

    public function down(): void
    {
        self::addRawSql("            
            ALTER TABLE `s_apartments` drop column `bed`;
            ALTER TABLE `s_apartments` drop column `bathroom`;
        ");
    }
}