<?php

/**
 * ajax -> organizations -> add
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

try {
  $organization = $user->get_org($_REQUEST['org_id']);
  if (empty($organization)) {
    throw new ValidationException(__("Organization not found"));
  } 

  /* validate current user */ 
  if (!$user->org_is_member($organization['id'])) {
    throw new ValidationException(__("You are not a member of this organization"));
  }

  /* validate target user */ 
  if (!$user->org_is_member($organization['id'], $_REQUEST['user_id'])) {
    throw new ValidationException(__("This member are not of this organization"));
  }

  $org_url = '/org/' . $organization['slug'];

  // initialize the return array
  $return = [];

  switch ($_REQUEST['type']) {
    case 'bill':
      $member = $user->org_get_member_by_user($organization['id'], $_REQUEST['user_id']);

      /* assign variables */
      $smarty->assign('org_id', $_REQUEST['org_id']);
      $smarty->assign('member_id', $member['id']);

      // return
      $return['template'] = $smarty->fetch("ajax.org.bills.add.tpl");
      $return['callback'] = "$('#modal').modal('show'); $('.modal-content:last').html(response.template); initialize_modal();";
      break;

    default:
      _error(400);
      break;
  }

  // return & exit
  return_json($return);
} catch (Exception $e) {
  modal("ERROR", __("Error"), $e->getMessage());
}
