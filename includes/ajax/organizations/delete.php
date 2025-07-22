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

    case 'member':
      $member = $user->org_get_member($_POST['id']);
      if (empty($member)) {
          throw new ValidationException(__("Member not found"));
      } 

      $organization = $user->get_org($member['organization_id']);
      if (empty($organization)) {
          throw new ValidationException(__("Organization not found"));
      } 

      if (!$user->org_is_member($organization['id'])) {
          throw new ValidationException(__("You are not a member of this organization"));
      }

      $connection = $user->org_get_connection($organization['id']);

      // permission check 
      if (!in_array($connection, ['owner', 'admin', 'staff'])) {
        throw new ValidationException(__("You don't have enough privilege to do this action"));
      }
      if ($member['role'] == 'admin' && !in_array($connection, ['owner'])) {
        throw new ValidationException(__("You don't have enough privilege to do this action"));
      }
      if ($member['role'] == 'staff' && !in_array($connection, ['owner', 'admin'])) {
        throw new ValidationException(__("You don't have enough privilege to do this action"));
      }
      if (in_array($member['role'], ['account', 'sub-account']) && !in_array($connection, ['owner', 'admin', 'staff'])) {
        throw new ValidationException(__("You don't have enough privilege to do this action"));
      }

      // TODO: Allocate money (VA) from deleted member to the owner of the organization
      $db->query(sprintf("DELETE FROM org_members WHERE id = %s", secure($_POST['id'], 'int')));
      break;
  }
  // return & exist
  return_json();
} catch (Exception $e) {
  modal("ERROR", __("Error"), $e->getMessage());
}
