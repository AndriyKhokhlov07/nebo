<?php

require_once('Backend.php');

class Houses extends Backend
{
    function __construct()
    {
        $this->common_for_building = self::childrenToObj($this->common_for_building);

        $this->internal_in_unit = self::childrenToObj($this->internal_in_unit);
    }

    private $common_for_building = [
        'backyard' => [
            'name' => 'Backyard'
        ],
        'balcony' => [
            'name' => 'Balcony'
        ],
        'Rooftop' => [
            'name' => 'Rooftop access'
        ],
        'CommonSpaces' => [
            'name' => 'Common Spaces Furnished (for work / for chill)'
        ],
        'Elevator' => [
            'name' => 'Elevator'
        ],
        'Keyless' => [
            'name' => 'Keyless access'
        ],
        'MonthlyCleaning' => [
            'name' => 'Monthly Cleaning Service'
        ],
        'Events' => [
            'name' => 'Community Events'
        ],
        'WiFi' => [
            'name' => 'High Speed Wi-Fi'
        ],
        'Lockers' => [
            'name' => 'Lockers'
        ],
        'Grill' => [
            'name' => 'Grill BBQ'
        ],
        'Securitysystem' => [
            'name' => 'Security system in place'
        ],
    ];


    private $internal_in_unit = [
        'ac_unit' => [
            'name' => 'A/C unit',
            'options' => [
                1 => [
                    'name' => 'Window'
                ],
                2 => [
                    'name' => 'Personal A/C'
                ],
                3 => [
                    'name' => 'Central'
                ],
                4 => [
                    'name' => 'No'
                ]
            ]
        ],
        'washer' => [
            'name' => 'Washer / Dryer',
            'options' => [
                1 => [
                    'name' => 'Unit'
                ],
                2 => [
                    'name' => 'Basement'
                ],
                3 => [
                    'name' => 'No'
                ]
            ],
            'options2' => [
                1 => [
                    'name' => 'Free'
                ],
                2 => [
                    'name' => 'Paid'
                ],
                3 => [
                    'name' => 'No'
                ]
            ],
        ],
        'dishwasher' => [
            'name' => 'Dishwasher'
        ],
        'microwave' => [
            'name' => 'Microwave'
        ],
        'coffee_machine' => [
            'name' => 'Coffee machine'
        ],
        'flat-screen_tv' => [
            'name' => 'Flat-screen TV',
            'options' => [
                1 => [
                    'name' => 'Unit'
                ],
                2 => [
                    'name' => 'Basement'
                ],
                3 => [
                    'name' => 'No'
                ]
            ]
        ],
        'tv_provider' => [
            'name' => 'TV Provider',
            'options' => [
                1 => [
                    'name' => 'Chromecast'
                ],
                2 => [
                    'name' => 'Netflix'
                ],
                3 => [
                    'name' => 'Hulu'
                ],
                4 => [
                    'name' => 'Apple +'
                ]
            ],
            'options_type' => 'multiselect'
        ],
        'iron' => [
            'name' => 'Iron',
            'options' => [
                1 => [
                    'name' => 'Unit'
                ],
                2 => [
                    'name' => 'Basement'
                ],
                3 => [
                    'name' => 'No'
                ]
            ]
        ],
    ];

    private function childrenToObj(array $data)
    {
        $result = [];
        if (is_array($data)) {
            foreach ($data as $k => $d) {
                if (is_array($d)) {
                    if (isset($d['options'])) {
                        $d['options'] = self::childrenToObj($d['options']);
                    }
                    if (isset($d['options2'])) {
                        $d['options2'] = self::childrenToObj($d['options2']);
                    }
                    $result[$k] = (object)$d;
                }
            }
        }
        return (!empty($result) ? $result : $data);
    }

    function getCommonForBuilding()
    {
        return $this->common_for_building;
    }

    function getInternalInUnit()
    {
        return $this->internal_in_unit;
    }

}
