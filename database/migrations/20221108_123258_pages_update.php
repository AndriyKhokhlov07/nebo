<?php

use Libs\DBHelper\Schema;

class Migration_20221108_123258
{
    use Schema;

    public function up(): void
    {
        self::addRawSql("
            alter table `s_pages` add `blocks3` text null after `blocks2`;
        ");
    }

    public function down(): void
    {
        self::addRawSql("
            alter table `s_pages` drop column `blocks3`;
        ");
    }
}