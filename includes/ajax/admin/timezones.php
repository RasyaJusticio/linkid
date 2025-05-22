<?php

/**
 * ajax -> admin -> timezones
 * 
 * @author RasyaJusticio
 */

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// check admin|moderator permission
if (!$user->_is_admin) {
  modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
}

// check demo account
if ($user->_data['user_demo']) {
  modal("ERROR", __("Demo Restriction"), __("You can't do this with demo account"));
}

// handle timezones
try {

  switch ($_GET['do']) {
    case 'edit':
      /* valid inputs */
      if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
        _error(400);
      }

      /* update */
      $db->query(sprintf("UPDATE system_time_zones SET time_zone_name = %s, utc_offset = %s WHERE time_zone_id = %s", secure($_POST['time_zone_name']), secure($_POST['utc_offset']), secure($_GET['id'], 'int')));
      /* return */
      return_json(['success' => true, 'message' => __("Timezone info have been updated")]);
      break;

    case 'add':
      /* insert */
      $db->query(sprintf("INSERT INTO system_time_zones (time_zone_name, utc_offset) VALUES (%s, %s)", secure($_POST['time_zone_name']), secure($_POST['utc_offset'])));
      /* return */
      return_json(['callback' => 'window.location = "' . $system['system_url'] . '/' . $control_panel['url'] . '/timezones";']);
      break;

    default:
      _error(400);
      break;
  }
} catch (Exception $e) {
  return_json(['error' => true, 'message' => $e->getMessage()]);
}
