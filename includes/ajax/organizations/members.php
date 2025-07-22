<?php

/**
 * ajax -> organizations -> members
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

// TODO prevent trying to doing anything to self

try {
  $organization = $user->get_org_by_slug($_POST['org_username']);
  if (empty($organization)) {
      throw new ValidationException(__("Organization not found"));
  } 

  if (!$user->org_is_member($organization['id'])) {
      throw new ValidationException(__("You are not a member of this organization"));
  }

  $connection = $user->org_get_connection($organization['id']);

  // initialize the return array
  $return = [];

  switch ($_GET['do']) {
    case '':
      return_json(['callback' => 'window.location.reload();']);

      break;

    case 'add':

      $user->org_create_member($_POST['user_id'], $organization['id'], $_POST['role'], $_POST['va_number']);
      //$user->post_notification(['to_user_id' => $_POST['user_id'], 'action' => 'org_sub_account_add', 'node_url' => $user->_data['user_name']]);

      return_json(['callback' => 'window.location = site_path + "/org/' . $organization['slug'] . '/members"']);

      break;

    case 'edit':

      $user->org_update_member($_POST['member_id'], $organization['id'], $_POST['role'], $_POST['va_number']);

      return_json(['callback' => 'window.location = site_path + "/org/' . $organization['slug'] . '/members"']);

      break;
    default:
      _error(400);
      break;
  }

  // return & exit
  return_json($return);
} catch (ValidationException $e) {
  return_json(['error' => true, 'message' => $e->getMessage()]);
} catch (Exception $e) {
  modal("ERROR", __("Error"), $e->getMessage());
}
