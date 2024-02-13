<?php

class DatabasePDO extends Backend
{
    use PdoCommand;

    /** @var Pdo */
    public $pdo;

    public function __construct()
    {
        parent::__construct();
        $this->open();
    }

    public function open(): void
    {
        if ($this->pdo !== null) {
            return;
        }

        if (empty($this->getDsn())) {
            throw new Exception('Connection::dsn cannot be empty.');
        }

        $this->createPdoInstance();
    }

    public function close(): void
    {
        if ($this->pdo !== null) {
            $this->pdo = null;
        }
    }

    public function isActive(): bool
    {
        return $this->pdo !== null;
    }

    private function createPdoInstance(): void
    {
        try {
            $this->pdo = new PDO($this->getDsn(), $this->getUsername(), $this->getPassword());
        } catch (PDOException $exception) {
            echo $exception->getMessage();
        }
    }

    private function getDsn(): ?string
    {
        $host = $this->config->db_server;

        $dbName = $this->config->db_name;

        return  "mysql:host={$host};dbname={$dbName}";
    }

    private function getUsername(): ?string
    {
        return $this->config->db_user;
    }

    private function getPassword(): ?string
    {
        return $this->config->db_password;
    }
}