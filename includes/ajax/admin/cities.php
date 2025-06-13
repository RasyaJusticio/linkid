<?php

/**
 * ajax -> admin -> cities 
 * 
 * @package LinkID
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

// handle cities 
try {

  switch ($_GET['do']) {
    case 'edit':
      /* valid inputs */
      if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
        _error(400);
      }
      /* prepare */
      $_POST['default'] = (isset($_POST['default'])) ? '1' : '0';
      $_POST['enabled'] = (isset($_POST['enabled'])) ? '1' : '0';
      /* if default is set -> set all provinces as not default first */
      if ($_POST['default']) {
        $db->query("UPDATE system_cities SET system_cities.default = '0'");
      }
      /* update */
      $db->query(sprintf("UPDATE system_cities SET system_cities.default = %s, `enabled` = %s, city_name = %s, city_alt_name = %s, province_id = %s WHERE city_id = %s", secure($_POST['default']), secure($_POST['enabled']), secure($_POST['city_name']), secure($_POST['city_alt_name']), secure($_POST['province_id']), secure($_GET['id'], 'int')));
      /* return */
      return_json(['success' => true, 'message' => __("City info have been updated")]);
      break;

    case 'add':
      /* prepare */
      $_POST['default'] = (isset($_POST['default'])) ? '1' : '0';
      $_POST['enabled'] = (isset($_POST['enabled'])) ? '1' : '0';
      /* if default is set -> set all provinces as not default first */
      if ($_POST['default']) {
        $db->query("UPDATE system_cities SET system_cities.default = '0'");
      }
      /* insert */
      $db->query(sprintf("INSERT INTO system_cities (system_cities.default, `enabled`, city_name, city_alt_name, province_id) VALUES (%s, %s, %s, %s, %s)", secure($_POST['default']), secure($_POST['enabled']), secure($_POST['city_name']), secure($_POST['city_alt_name']), secure($_POST['province_id'])));
      /* return */
      return_json(['callback' => 'window.location = "' . $system['system_url'] . '/' . $control_panel['url'] . '/cities";']);
      break;

    default:
      _error(400);
      break;
  }
} catch (Exception $e) {
  return_json(['error' => true, 'message' => $e->getMessage()]);
}
