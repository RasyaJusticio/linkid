<?php

/**
 * ajax -> organizations -> bills
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
  $organization = $user->get_org($_POST['org_id']);
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
      $user->org_create_bill($organization['id'], $_POST);

      return_json(['callback' => 'window.location.reload();']);

      break;

    case 'edit':

      $user->org_update_bill($organization['id'], $_GET['bill_id'], $_POST);

      return_json(['callback' => 'window.location.reload();']);

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
