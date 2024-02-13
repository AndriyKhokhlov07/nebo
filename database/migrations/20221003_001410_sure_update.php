<?php

use Libs\DBHelper\Schema;

class Migration_20221003_001410
{
    use Schema;

    public function up(): void
    {
        self::addRawSql("
            alter table `s_sures` add `payment_method_id` varchar(200) null after `quote_id`;
            alter table `s_sures` add `agreement_id` varchar(200) null after `payment_method_id`;
            alter table `s_sures` add `status_code` varchar(200) null after `agreement_id`;
            alter table `s_sures` add `policy_number` varchar(200) null after `status_code`;
        ");
    }

    public function down(): void
    {
        self::addRawSql("
            alter table `s_sures` drop column `payment_method_id`;
            alter table `s_sures` drop column `agreement_id`;
            alter table `s_sures` drop column `status_code`;
            alter table `s_sures` drop column `policy_number`;
        ");
    }
}