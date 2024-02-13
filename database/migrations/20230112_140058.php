<?php

use Libs\DBHelper\Schema;

class Migration_20230112_140058
{
    use Schema;

    public function up(): void
    {
        self::addRawSql("
            ALTER TABLE `s_leads` ADD `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `additional_info`; 
        ");
    }

    public function down(): void
    {
        self::addRawSql("
            ALTER TABLE `s_leads` drop column `created`;
        ");
    }
}