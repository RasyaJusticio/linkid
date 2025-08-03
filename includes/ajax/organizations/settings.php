<?php

/**
 * ajax -> organizations -> settings
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
    $organization = $user->get_org($_POST['org_id']);
  } 
  if (empty($organization)) {
    throw new ValidationException(__("Organization not found"));
  } 

  if (!$user->org_is_member($organization['id'])) {
    throw new ValidationException(__("You are not a member of this organization"));
  }

  $member = $user->org_get_member_by_user($organization['id']);
  $org_url = '/org/' . $organization['slug'];

  switch ($_GET['edit']) {
    case 'organization-info':
      // change settings
      $user->org_settings($organization['id'], $_GET['edit'], $_POST);

      // return
      return_json(['callback' => 'window.location = site_path + "' . $org_url . '/settings"']);
      break;

    case 'transfer-pin':
      // valid inputs
      if (!is_empty($member['transfer_pin'])) {
        if (!isset($_POST['current']) || !isset($_POST['new']) || !isset($_POST['confirm'])) {
          _error(400);
        }
      } else {
        if (!isset($_POST['new']) || !isset($_POST['confirm'])) {
          _error(400);
        }
      }

      // change settings
      $user->org_user_settings($member['id'], $_GET['edit'], $_POST);

      // return
      return_json(['callback' => 'window.location = site_path + "' . $org_url . '/me"']);
      break;

    default:
      _error(400);
      break;
  }
} catch (Exception $e) {
  return_json(['error' => true, 'message' => $e->getMessage()]);
}
