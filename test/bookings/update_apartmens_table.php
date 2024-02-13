<?php
ini_set('error_reporting', E_ALL);

chdir('../../');
require_once('api/Backend.php');

class Init extends Backend
{
    function fetch()
    {
        $query = $this->db->placehold("UPDATE s_apartments
            SET bed = CAST(SUBSTRING_INDEX(note, '/', 1) AS UNSIGNED),
            bathroom = CAST(SUBSTRING_INDEX(note, '/', -1) AS UNSIGNED)
        ");
        
        $this->db->query($query);
    }
}

$init = new Init();
$init->fetch();
