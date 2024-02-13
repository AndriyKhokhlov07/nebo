<?php

use Libs\DBHelper\Schema;

class Migration_20230411_152745
{
    use Schema;

    public function up(): void
    {
        self::addRawSql("
            alter table s_users
                add payment_methods_details json null after blocks;        
        ");
    }

    public function down(): void
    {
        self::addRawSql("");
    }
}