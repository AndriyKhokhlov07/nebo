<?php

use Libs\DBHelper\Schema;

class Migration_20221102_131234
{
    use Schema;

    public function up(): void
    {
        self::addRawSql("
            create table s_districts
                (
                    id       int auto_increment primary key,
                    city_id  int         null,
                    name     varchar(50) null,
                    position int         null
                );
        ");
    }

    public function down(): void
    {
        self::addRawSql("drop table s_districts;");
    }
}