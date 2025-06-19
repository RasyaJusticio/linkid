<?php

/**
 * ajax -> location -> provinces
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
        $provinces = $user->get_provinces_by_country($_GET['id']);
        break;

    case "by_id":
        $province = $user->get_province($_GET['id']);
        if ($province) {
            $provinces = $user->get_provinces_by_country($province['country_id']);
        } else {
            $provinces = [];
        }
        break;
      
    default:
        $provinces = [];
        break; 
    }

    return_json(
        [
        'data' => $provinces
        ]
    );
} catch (Exception $e) {
    modal("ERROR", __("Error"), $e->getMessage());
}
