<?php

use Libs\DBHelper\Schema;

class Migration_20221129_005905
{
    use Schema;

    public function up(): void
    {
        self::addRawSql("
            alter table `s_pages` add `parent3_id` INT(11) NULL DEFAULT NULL after `parent2_id`;
        ");
    }

    public function down(): void
    {
        self::addRawSql("
            alter table `s_pages` drop column `parent3_id`;
        ");
    }
}