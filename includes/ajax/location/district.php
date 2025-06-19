<?php

/**
 * ajax -> location -> district
 * 
 * @package LinkID
 * @author  RasyaJusticio
 */

// fetch bootstrap
require '../../../bootstrap.php';

// check AJAX Request
is_ajax();

// user access
user_access(true);

// valid inputs
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    _error(400);
}

try {
    switch ($_GET['view']) {
    case "by_parent_id":
        $districts = $user->get_districts_by_city($_GET['id']);
        break;

    case "by_id":
        $district = $user->get_district($_GET['id']);
        if ($district) {
            $districts = $user->get_districts_by_city($district['city_id']);
        } else {
            $districts = [];
        }
        break;
    
    default:
        $districts = [];
        break;
    }

    return_json(
        [
        'data' => $districts
        ]
    );
} catch (Exception $e) {
    modal("ERROR", __("Error"), $e->getMessage());
}

