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
      // valid inputs
      if (!isset($_POST['user_id']) || !is_numeric($_POST['user_id'])) {
        throw new ValidationException(__("Please insert a valid user id"));
      }
      if (!isset($_POST['va_number']) || !is_numeric($_POST['va_number'])) {
        throw new ValidationException(__("Please insert a valid VA number"));
      }
      if (!isset($_POST['role']) || !in_array($_POST['role'], ['admin', 'staff', 'account', 'sub-account'])) {
        throw new ValidationException(__("Please insert a valid role"));
      }

      // role control
      if (!in_array($connection, ['owner', 'admin', 'staff'])) {
        throw new ValidationException(__("You don't have enough privilege to do this action"));
      }

      $target_user = $user->get_user($_POST['user_id']);
      if (empty($target_user) || !isset($target_user)) {
        throw new ValidationException(__("User not found"));
      }

      if ($user->org_is_member($organization['id'], $_POST['user_id'])) {
        throw new ValidationException(__("User is already invited"));
      }

      if ($user->org_get_member_by_va($_POST['va_number'])) {
        throw new ValidationException(__("That VA number is in use. Please use another one."));
      }

      if ($_POST['role'] == 'admin' && !in_array($connection, ['owner'])) {
        throw new ValidationException(__("You don't have enough privilege to assign this role to this user"));
      }
      if ($_POST['role'] == 'staff' && !in_array($connection, ['owner', 'admin'])) {
        throw new ValidationException(__("You don't have enough privilege to assign this role to this user"));
      }
      if (in_array($_POST['role'], ['account', 'sub-account']) && !in_array($connection, ['owner', 'admin', 'staff'])) {
        throw new ValidationException(__("You don't have enough privilege to assign this role to this user"));
      }

      $user->org_create_member($_POST['user_id'], $organization['id'], $_POST['role'], $_POST['va_number']);
      //$user->post_notification(['to_user_id' => $_POST['user_id'], 'action' => 'org_sub_account_add', 'node_url' => $user->_data['user_name']]);

      return_json(['callback' => 'window.location = site_path + "/org/' . $organization['slug'] . '/members"']);

      break;

    case 'edit':
      // valid inputs
      if (!isset($_POST['user_id']) || !is_numeric($_POST['user_id'])) {
        _error(400);
      }
      if (!isset($_POST['va_number']) || !is_numeric($_POST['va_number'])) {
        _error(400);
      }

      // role control
      if (!in_array($org['connection_type'], ['owner', 'admin', 'staff'])) {
        _error(403);
      }

      $target_user = $user->get_user($_POST['user_id']);
      if (empty($target_user) || !isset($target_user)) {
        throw new ValidationException(__("User not found"));
      }

      $account = $user->get_org_account_from_user($_POST['user_id']);
      if (empty($account) || !isset($account)) {
        throw new ValidationException(__("User not found"));
      }

      $va_account = $user->get_org_account_from_va($_POST['va_number']);
      if (isset($va_account) && !empty($va_account) && $va_account['user_id'] != $account['id']) {
        throw new ValidationException(__("That VA number is in use. Please use another one"));
      }

      if (isset($va_account) && !empty($va_account)) {
        $balance = $va_account['balance'];
        $user->close_org_va_account($va_account['id']);
      }

      $user->add_org_va_account($account['id'], $org['id'], $_POST['va_number']);

      return_json(['callback' => 'window.location = site_path + "/organizations/' . $org['slug'] . '/sub-accounts"']);

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
