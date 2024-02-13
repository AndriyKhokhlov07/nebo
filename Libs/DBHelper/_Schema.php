<?php

namespace Libs\DBHelper;

require_once(realpath(ROOT_PATH . '/api/Config.php'));

use Config;
use Exception;
use Libs\Console\Message;
use Libs\DBHelper\QueryBuilder\QueryBuilder;
use mysqli;

trait _Schema
{
    protected static $config = null;
    protected static $dbMigrationTable = null;
    protected static $db;

    private static array $schema = [];

    /**
     * @var string[]
     */
    private static array $finallyQueries = [];

    public static function init()
    {
        self::getConnection();
        self::getSchema();

        self::createMigrationTableIfNotExists();
    }

    private static function getConfig()
    {
        if(empty(self::$config)){
            new Config();
            self::$config = Config::getConfig();
        }
        return self::$config;
    }

    private static function getDBMigrationTable(): string
    {
        if(empty(self::$dbMigrationTable)){
            self::$dbMigrationTable = self::getConfig()->db_migration_table ?? '_migrations';
        }

        return self::$dbMigrationTable;
    }

    public static function getConnection(): mysqli
    {
        if(empty(self::$db)){

            mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
            self::$db = new mysqli(self::getConfig()->db_server, self::getConfig()->db_user, self::getConfig()->db_password, self::getConfig()->db_name);
            if (mysqli_connect_errno()) {
                exitConsole('Error connecting to DB', Message::TYPE_MESSAGE_ERROR);
            }

            self::$config->db_timezone = self::getConfig()->db_timezone ?? 'UTC';
            self::execQuery('
                SET NAMES "' . self::getConfig()->db_charset . '";
                SET SESSION SQL_MODE = "' . self::getConfig()->db_sql_mode . '";
                SET time_zone = "' . self::getConfig()->db_timezone . '";
            ');
        }

        return self::$db;
    }

    public static function getFinallyQueries(): array
    {
        return self::$finallyQueries;
    }

    public static function clearFinallyQueries()
    {
        self::$finallyQueries = [];
    }

    private static function createMigrationTableIfNotExists(): void
    {
        if(self::isTableExits(self::getDBMigrationTable())){
            return;
        }

        $query = "
                CREATE TABLE `" . self::getDBMigrationTable() . "` (
                    `file_name` varchar(255) NOT NULL,
                    `class_name` varchar(255) NOT NULL,
                    `migrated_at` datetime
                ) ENGINE=InnoDB;
                ALTER TABLE `" . self::getDBMigrationTable() . "`
                    ADD UNIQUE KEY `file_name_uindex` (`file_name`),
                    ADD UNIQUE KEY `class_name_uindex` (`class_name`);
        ";

        self::execQuery($query);
    }

    public static function getSchema(): array
    {
        if(empty(self::$schema)){
            if(empty($result = self::$db->query('SHOW TABLES'))) {
                self::$schema = [];
            }

            while ($row = $result->fetch_array()) {
                $tables[] = $row[0];
            }
            if(!empty($tables)){
                foreach ($tables as $table){
                    $result = self::$db->query('SHOW COLUMNS FROM ' . $table);
                    while ($row = $result->fetch_assoc()) {
                        $field = [];
                        foreach ($row as $key => $value){
                            $field[strtolower($key)] = strtolower($value);
                        }
                        self::$schema['tables'][$table][$field['field']] = $field;
                    }
                }
            }
        }

        return self::$schema;
    }

    protected static function isTableExits(string $tableName): bool
    {
        return empty(!self::$schema['tables'][$tableName]);
    }

    protected static function getQuery(?QueryBuilder $queryBuilder = null)
    {
        if($queryBuilder === null){
            $queryBuilder = self::queryBuilder();
        }

        if(empty(self::$db)){
            self::init();
        }

        $result = self::$db->query($queryBuilder->getSql());

        return $result;
    }

    protected static function getQueryObjects(?QueryBuilder $queryBuilder = null)
    {
        if($result = self::getQuery($queryBuilder)){
            $data = [];
            while ($row = $result->fetch_object()){
                $data[] = $row;
            }

            return $data;
        }

        return null;
    }

    protected static function getQueryAssocs(?QueryBuilder $queryBuilder = null)
    {
        if($result = self::getQuery($queryBuilder)){
            $data = [];
            while ($row = $result->fetch_assoc()){
                $data[] = $row;
            }

            return $data;
        }

        return null;
    }

    public static function execQuery(string $query)
    {
        $query = preg_replace('/[\s]{2,}/', ' ', $query);
        $queries = explode(';', preg_replace('/[\r\n]/', '', $query));
        if(empty(self::$db)){
            self::init();
        }

        foreach ($queries as $query){
            $query = trim($query);
            if(!empty($query)){
                try {
                    $result = self::$db->query($query . ';');
                    if(!$result){
                        return $result;
                    }
                }catch (Exception $exception){
                    throw new Exception($exception->getMessage() . "\n" . $query, $exception->getCode());
                }
            }
        }

        return true;
    }

    protected static function addRawSql(string $rawSql)
    {
        self::$finallyQueries[] = $rawSql;
    }

    public static function addFinallyQuery(string $query)
    {
        self::$finallyQueries[] = $query;
    }
}