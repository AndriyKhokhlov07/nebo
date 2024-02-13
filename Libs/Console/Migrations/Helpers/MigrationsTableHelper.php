<?php

namespace Libs\Console\Migrations\Helpers;

use Libs\DBHelper\Schema;

trait MigrationsTableHelper
{
    use Schema;

    public static function getMigrationClassName(string $migrationFileName): string
    {
        $partItem = explode('_', explode('.', $migrationFileName)[0]);
        return 'Migration_' . $partItem[0] . '_' . $partItem[1];
    }

    public static function isMigrationDone(string $migrationFileName): bool
    {
        $migrationTableName = self::getDBMigrationTable();
        $sql = "SELECT * FROM `$migrationTableName` WHERE `file_name`='$migrationFileName'";
        $result = self::getQueryAssocs($sql);
        return !empty($result) && $result[0]['migrated_at'] !== null;
    }

    public static function setMigrationDone(string $migrationFileName): bool
    {
        $migrationTableName = self::getDBMigrationTable();

        $partItem = explode('_', explode('.', $migrationFileName)[0]);
        $className = 'Migration_' . $partItem[0] . '_' . $partItem[1];

        $sql = "SELECT * FROM `$migrationTableName` WHERE `file_name`='$migrationFileName';";
        if(!empty(self::getQueryAssocs($sql))){
            $sql = "
                UPDATE `$migrationTableName` 
                SET `class_name`='$className', `migrated_at`=now()
                WHERE `file_name`='$migrationFileName';
            ";
        }else {
            $sql = "
                INSERT INTO `$migrationTableName` (`file_name`, `class_name`, `migrated_at`)
                VALUES ('$migrationFileName', '$className', NOW());
            ";
        }
        return self::execQuery($sql);
    }

    public static function unsetMigrationDone(string $migrationFileName): bool
    {
        $migrationTableName = self::getDBMigrationTable();
        $sql = "DELETE FROM `$migrationTableName` where `file_name`='$migrationFileName';";
        return self::execQuery($sql);
    }
}