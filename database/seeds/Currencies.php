<?php

use Libs\DBHelper\Schema;

class CurrenciesSeeds
{
    use Schema;

    public function seeding(): void
    {
        $currencies = [
            ['US Dollars', '$', 'USD', 1.0000, 1.00, 0, 1, 1],
            ['Euro', '€', 'EUR', 1.0000, 1.20, 0, 3, 0],
            ['US Dollars (Stripe)', '$', 'USD', 1.0375, 1.00, 2, 4, 0],
            ['US Dollars (PayPal)', '$', 'USD', 1.0600, 1.00, 2, 5, 0],
            ['US Dollars (PayPal Not US Citizen)', '$', 'USD', 1.0600, 1.00, 2, 7, 0],
        ];

        $sql = "
            insert into s_currencies (name, sign, code, rate_from, rate_to, cents, position, enabled)
            values (#data#);
        ";

        self::init();

        foreach ($currencies as $currency){
            foreach ($currency as &$param){
                if($param === '') {
                    $param = '""';
                }elseif ($param === null){
                    $param = "NULL";
                }elseif (is_string($param)){
                    $param = "'" . $param . "'";
                }
            }
            $query = str_replace('#data#', implode(',', $currency), $sql);
            self::$db->query($query);
        }
    }
}