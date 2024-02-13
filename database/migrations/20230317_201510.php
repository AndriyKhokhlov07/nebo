<?php

use Libs\DBHelper\Schema;

class Migration_20230317_201510
{
    use Schema;

    public function up(): void
    {
        self::addRawSql("
            ALTER TABLE `s_leads` ADD `site` varchar(255) NULL DEFAULT NULL AFTER `user_id`;
            ALTER TABLE `s_leads` ADD `form_type` tinyint(1) NOT NULL DEFAULT '0' AFTER `site`; 
        ");
    }

    public function down(): void
    {
        self::addRawSql("
            ALTER TABLE `s_leads` drop column `site`;
            ALTER TABLE `s_leads` drop column `form_type`;
        ");
    }
}