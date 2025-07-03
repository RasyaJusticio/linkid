<?php

/**
 * ajax -> organizations -> sub-accounts
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

// check demo account
if ($user->_data['user_demo']) {
  modal("ERROR", __("Demo Restriction"), __("You can't do this with demo account"));
}
if (!$user->_is_organization) {
  _error(__('System Message'), __("You don't have the right permission to access this"));
}

try {
  $org = $user->get_organization_from_user($user->_data['user_id']);

  // initialize the return array
  $return = [];

  switch ($_GET['do']) {
    case '':

      return_json(['callback' => 'window.location.reload();']);

      break;

    case 'add':
      // valid inputs
      if (!isset($_POST['user_id']) || !is_numeric($_POST['user_id'])) {
        _error(400);
      }
      if (!isset($_POST['va_number']) || !is_numeric($_POST['va_number'])) {
        _error(400);
      }

      $target_user = $user->get_user($_POST['user_id']);
      if (empty($target_user) || !isset($target_user)) {
        throw new ValidationException(__("User not found"));
      }

      if ($user->get_org_account_from_va($_POST['va_number'])) {
        throw new ValidationException(__("That VA number is in use. Please use another one."));
      }

      if ($user->is_in_organization($_POST['user_id'], $org['id'])) {
        throw new ValidationException(__("User is already invited"));
      }

      $user->add_org_sub_account($_POST['user_id'], $org['id'], $_POST['va_number']);
      $user->post_notification(['to_user_id' => $_POST['user_id'], 'action' => 'org_sub_account_add', 'node_url' => $user->_data['user_name']]);

      return_json(['callback' => 'window.location = site_path + "/organizations/sub-accounts"']);

      break;

    case 'edit':
      // valid inputs
      if (!isset($_POST['user_id']) || !is_numeric($_POST['user_id'])) {
        _error(400);
      }
      if (!isset($_POST['va_number']) || !is_numeric($_POST['va_number'])) {
        _error(400);
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

      return_json(['callback' => 'window.location = site_path + "/organizations/sub-accounts"']);

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
