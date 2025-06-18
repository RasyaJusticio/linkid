<?php

/**
 * ajax -> location -> city
 * 
 * @package LinkID
 * @author RasyaJusticio
 */

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// user access
user_access(true);

// valid inputs
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
  _error(400);
}

try {
  $cities = $user->get_cities_by_province($_GET['id']);

  return_json([
    'data' => $cities
  ]);
} catch (Exception $e) {
  modal("ERROR", __("Error"), $e->getMessage());
}
