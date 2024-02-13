<?php

namespace Libs\Console\Migrations;

use DateTime;
use Libs\Console\Message;
use Libs\Console\Migrations\Helpers\MigrationsTableHelper as MTH;
use Libs\StringHelper as Str;

class Migrations
{
    use MTH;

    /**
     * For create new migration file
     *      php bin/console migrations:create [--description=eny_description]
     * For migrate all new files
     *      php bin/console migrations:migrate
     * For migrate from custom file
     *      php bin/console migrations:up --file=migration_file_name [--force]
     * For rollback from custom file
     *      php bin/console migrations:down --file=migration_file_name [--force]
     * For seeding into DB call
     *      php bin/console migrations:seeding
     */

    const ACTION_CREATE     = 'create';
    const ACTION_MIGRATE    = 'migrate';
    const ACTION_UP         = 'up';
    const ACTION_DOWN       = 'down';
    const ACTION_SEEDING    = 'seeding';
    const SUPPORTED_ACTIONS = [
        self::ACTION_CREATE,
        self::ACTION_MIGRATE,
        self::ACTION_UP,
        self::ACTION_DOWN,
        self::ACTION_SEEDING,
    ];

    const PARAM_DESCRIPTION = 'description';
    const PARAM_FILE        = 'file';
    const PARAM_FORCE       = 'force';
    const PARAMS_PROPERTIES = [
        self::PARAM_DESCRIPTION => [
            'type' => 'string',
            'default' => null,
        ],
        self::PARAM_FILE => [
            'type' => 'string',
            'default' => null,
        ],
        self::PARAM_FORCE => [
            'type' => 'bool',
            'default' => false,
        ],
    ];

    const ARG_KEY_DESCRIPTION = '--description';
    const ARG_KEY_FILE = '--file';
    const ARG_KEY_FORCE = '--force';
    const ARG_KEYS_ASSOC = [
        self::ARG_KEY_DESCRIPTION   => self::PARAM_DESCRIPTION,
        self::ARG_KEY_FILE          => self::PARAM_FILE,
        self::ARG_KEY_FORCE         => self::PARAM_FORCE,
    ];

    const TEMPLATE_FILE     = ROOT_PATH . '/libs/Console/Migrations/templates/_template';
    const MIGRATIONS_PATH   = ROOT_PATH . '/database/migrations';
    const SEEDS_PATH        = ROOT_PATH . '/database/seeds';

    private array $params = [];

    public function __construct(?string $action, array $args)
    {
        $this->initParams($args);

        switch ($action){
            case self::ACTION_CREATE:
                $this->createMigration();
                break;
            case self::ACTION_MIGRATE:
                $this->makeMigrations();
                break;
            case self::ACTION_UP:
            case self::ACTION_DOWN:
                $this->makeMigration($action);
                break;
            case self::ACTION_SEEDING:
                $this->makeSeeding();
                break;
            default:
                exitConsoleWithWarning(['UNDEFINED SUPPORTED ACTION, LET`S TRY AGAIN']);
        }

        exitConsole();
    }

    private function initParams(array $args)
    {
        $this->params = [];
        foreach ($args as $arg){
            [$key, $value] = explode('=', $arg);
            if(isset(self::ARG_KEYS_ASSOC[$key])){
                $paramKey = self::ARG_KEYS_ASSOC[$key];

                switch (self::PARAMS_PROPERTIES[$paramKey]['type']){
                    case 'string':
                        $this->params[$paramKey] = trim($value);
                        break;
                    case 'bool':
                        $this->params[$paramKey] = empty($value) || (bool)$value;
                        break;
                }

            }
        }
    }

    private function createMigration(): void
    {
        $migrationContent = file_get_contents(self::TEMPLATE_FILE);

        $description = !empty($this->params[self::PARAM_DESCRIPTION])
            ? '_' . Str::ConvertToSnakeCase($this->params[self::PARAM_DESCRIPTION])
            : '';
        $fileName = (new DateTime('now', new \DateTimeZone('UTC')))->format('Ymd_His') . $description . '.php';
        $fullFileName = self::MIGRATIONS_PATH . '/' . $fileName;

        $className = self::getMigrationClassName($fileName);
        $file = fopen($fullFileName, 'w');
        fwrite($file, str_replace('#className#', $className, $migrationContent));
        fclose($file);

        exitConsoleWithInform(["Migration file `$fileName` was successfully created"]);
    }

    private function makeMigrations(): void
    {
        $dir = scandir(self::MIGRATIONS_PATH);

        foreach ($dir as $file){
            if(
                is_file(self::MIGRATIONS_PATH . '/' . $file)
                && preg_match('/\.php$/', $file)
                && !self::isMigrationDone($file)
            ){
                if($this->processMigration($file, 'up')){
                    self::setMigrationDone($file);
                }
            }
        }
        exitConsoleWithInform('All migrations done!');
    }

    private function makeMigration(string $action)
    {
        if(
            !($file = $this->getFileName())
            || !file_exists(self::MIGRATIONS_PATH . '/' . $file)
        ){
            exitConsoleWithError('File undefined!');
        }

        switch ($action){
            case self::ACTION_UP:
                if(self::isMigrationDone($file) and !$this->isForce()){
                    exitConsoleWithError('Migration from file ' . $file . ' was already done!');
                }
                if($this->processMigration($file, $action)) {
                    self::setMigrationDone($file);
                }
                break;
            case self::ACTION_DOWN:
                if(!self::isMigrationDone($file) and !$this->isForce()){
                    exitConsoleWithError('Can`t make rollback, migration from file ' . $file . ' was not executed!');
                }
                if($this->processMigration($file, $action)) {
                    self::unsetMigrationDone($file);
                }
                break;
        }
    }

    private function processMigration(string $file, string $action): bool
    {
        include_once(self::MIGRATIONS_PATH . '/' . $file);
        $className = self::getMigrationClassName($file);

        Message::message('Trying migrate ' . $className, Message::TYPE_MESSAGE_INFORM);
        $migration = new $className();
        $migration::clearFinallyQueries();
        $migration->{$action}();
        foreach ($migration->getFinallyQueries() as $query){
            try{
                $migration::execQuery($query);
            }catch (\Exception $exception){
                exitConsoleWithError([$exception->xdebug_message, explode("\n", $exception->getMessage()), "Error on migration `$className`"]);
                break;
            }
        }
        Message::message(
            (($action === self::ACTION_UP) ? 'Migration' : 'Rollback migration')
            . " `$className` was successfully", Message::TYPE_MESSAGE_SUCCESS);
        return true;
    }

    private function getFileName()
    {
        return !empty($this->params[self::PARAM_FILE])
            ? preg_replace('/\.php$/', '', trim($this->params[self::PARAM_FILE])) . '.php'
            : false;
    }

    private function isForce(): bool
    {
        return $this->params[self::PARAM_FORCE] ?? self::PARAMS_PROPERTIES[self::PARAM_FORCE]['default'];

//        return isset($this->params[self::PARAM_FORCE])
//            ? $this->params[self::PARAM_FORCE]
//            : self::PARAMS_PROPERTIES[self::PARAM_FORCE]['default'];
    }

    private function makeSeeding()
    {
        $dir = scandir(self::SEEDS_PATH);

        foreach ($dir as $item){
            if(
                is_file(self::SEEDS_PATH . '/' . $item)
                && preg_match('/\.php$/', $item)
            ){
                include_once(self::SEEDS_PATH . '/' . $item);
                $className = explode('.', $item)[0] . 'Seeds';

                Message::message('Trying seeding ' . $className, Message::TYPE_MESSAGE_INFORM);
                $seeder = new $className();

                try{
                    $seeder->seeding();
                }catch (\Exception $exception){
                    Message::messages([$exception->xdebug_message, "ON QUERY \"{$exception->getMessage()}\""], Message::TYPE_MESSAGE_ERROR);
                    exitConsoleWithError("Error on seeding `$className`");
                    break;
                }

                Message::message("Seeding `$className` was successfully", Message::TYPE_MESSAGE_SUCCESS);
            }
        }
        exitConsoleWithInform('All seeding done!');
    }
}