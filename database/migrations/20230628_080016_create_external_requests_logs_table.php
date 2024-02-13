<?php

use Libs\DBHelper\Schema;

class Migration_20230628_080016
{
    use Schema;

    public function up(): void
    {
        self::addRawSql('
            create table s_external_logs
            (
                id            bigint auto_increment primary key,
                user_id       bigint null,
                provider      int null,
                method        varchar(10) not null,
                url           text not null,
                status_code   varchar(3) null,
                request       json null,
                response      json null,
                error         json null,
                additional    json null,
                created_at    datetime default CURRENT_TIMESTAMP not null
            );
        ');
    }

    public function down(): void
    {
        self::addRawSql('
            drop table s_external_logs;
        ');
    }
}