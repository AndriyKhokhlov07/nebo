<?php

include_once(realpath(ROOT_PATH . '/api/Config.php'));
include_once(realpath(ROOT_PATH . '/api/Settings.php'));

$viewHelperPath = ROOT_PATH . '/Libs/ViewHelper/';
include_once($viewHelperPath . 'Functions/money_format.php');

function preloader(bool $disabledContainer = false)
{
    $html = '
        <div class="preloader" ' . ($disabledContainer ? ' disabled-container' : '') . ' style="display: none">
            <div class="preloader-animation"></div>
        </div>
    ';
    $css = '<link href="../Libs/ViewHelper/Preloader/preloader.css?v1.0.0" rel="stylesheet">';
    $js = '<script src="../Libs/ViewHelper/Preloader/preloader.js?v1.0.0"></script>';

    return $html . "\n" . $css . "\n" . $js . "\n";
}

/**
 * 1. Make sure the template contains
 *    "{googleSearchAddress()}"
 *
 * 2. Add class "google-search-address" into needle input
 *    <input type="text" class="google-search-address" name="<any-field-name>" id="<any-field-id>">
 *
 * 3. After selecting address on drop-box under current field creating a new hidden "input" with details of selected address,
 *    name for new "input" getting from attribute "name" of current field or "id" if "name" is empty with suffix "_google-search-address"
 */
function googleSearchAddress()
{
    $apiKey = (new Settings())->google_map_api_key ?? '';

    return '
        <link href="../Libs/ViewHelper/Google/search-address.css?v1.0.0" rel="stylesheet">
        <script src="../Libs/ViewHelper/Google/search-address.js?v1.0.0"></script>
        <script src="https://maps.googleapis.com/maps/api/js?libraries=places&language=en&output=json&key=' . $apiKey . '" defer></script>
    ';
}

















