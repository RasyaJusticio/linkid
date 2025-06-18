<?php

/**
 * ajax -> location -> district
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
  $districts = $user->get_districts_by_city($_GET['id']);

  return_json([
    'data' => $districts
  ]);
} catch (Exception $e) {
  modal("ERROR", __("Error"), $e->getMessage());
}

