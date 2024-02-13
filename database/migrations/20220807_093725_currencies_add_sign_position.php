<?php

use Libs\DBHelper\Schema;

class Migration_20220807_093725
{
    use Schema;

    public function up(): void
    {
        self::execQuery('
            alter table `s_currencies` add `sorting` int not null after `position`;
            create index `sorting` on `s_currencies` (`sorting`);
            update `s_currencies` set `sorting` = `position`;
            alter table `s_currencies` modify `position` varchar(10) default "before" not null;
            update `s_currencies` set `position` = "before";
            drop index `position` on `s_currencies`;
        ');
    }

    public function down(): void
    {
        self::addRawSql("
            update `s_currencies` set `position` = `sorting`;
            alter table `s_currencies` modify `position` int not null;
            create index `position` on `s_currencies` (`position`);
            drop index `sorting` on `s_currencies`;
            alter table `s_currencies` drop column `sorting`;
        ");
    }
}