<?php

/**
 * ajax -> location -> city
 * 
 * @package LinkID
 * @author  RasyaJusticio
 */

// fetch bootstrap
require '../../../bootstrap.php';

// check AJAX Request
is_ajax();

// valid inputs
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    _error(400);
}

try {
   
    switch ($_GET['view']) {
    case "by_parent_id":
        $cities = $user->get_cities_by_province($_GET['id']);
        break;

    case "by_id":
        $city = $user->get_city($_GET['id']);
        if ($city) {
            $cities = $user->get_cities_by_province($city['province_id']);
        } else {
            $cities = [];
        }
        break;
      
    default:
        $cities = [];
        break; 
    }

    return_json(
        [
        'data' => $cities
        ]
    );
} catch (Exception $e) {
    modal("ERROR", __("Error"), $e->getMessage());
}
