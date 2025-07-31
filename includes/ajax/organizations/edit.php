<?php

/**
 * ajax -> organizations -> edit
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

  $org_url = '/org/' . $organization['slug'];

  // initialize the return array
  $return = [];

  switch ($_REQUEST['type']) {
    case 'bill':
      $bill = $user->org_get_bill_with_org($organization['id'], $_REQUEST['bill_id']);

      if (empty($bill)) {
        throw new ValidationException(__("Bill not found") . $_REQUEST['bill_id']);
      }

      /* assign variables */
      $smarty->assign('org_id', $_REQUEST['org_id']);
      $smarty->assign('data', $bill);

      // return
      $return['template'] = $smarty->fetch("ajax.org.bills.edit.tpl");
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
