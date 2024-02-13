<?php

use Libs\DBHelper\Schema;

class Migration_20220907_102041
{
    use Schema;

    public function up(): void
    {
        $backend = new Backend();

        self::execQuery("
            alter table `s_users` add `hash_code` varchar(40) default null null after `id`;
        ");

        $query = 'SELECT u.id, u.created, u.hash_code FROM `s_users` u WHERE u.hash_code is null ORDER BY id';
        $data = self::getQueryObjects($query);

        foreach ($data as $user){
            $backend->users->add_hash_code_by_user_id($user->id);
        }
    }

    public function down(): void
    {
        self::addRawSql("
            alter table `s_users` drop column `hash_code`;
        ");
    }
}