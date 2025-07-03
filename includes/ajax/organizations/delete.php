<?php

/**
 * ajax -> organizations -> delete
 * 
 * @package LinkID
 * @author RasyaJusticio
 */

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// check demo account
if ($user->_data['user_demo']) {
  modal("ERROR", __("Demo Restriction"), __("You can't do this with demo account"));
}

// handle delete
try {

  switch ($_POST['handle']) {

    case 'account':
      $account = $user->get_org_account($_POST['id']);

      if (empty($account) || !isset($account)) {
        throw new Exception(__("Account not found"));
      }

      $org = $user->get_organization_from_user($account['user_id']);

      if ($org['created_by'] != $user->_data['user_id']) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
        break;
      }

      $db->query(sprintf("DELETE FROM org_users WHERE id = %s", secure($_POST['id'], 'int')));
      break;
  }
  // return & exist
  return_json();
} catch (Exception $e) {
  modal("ERROR", __("Error"), $e->getMessage());
}
