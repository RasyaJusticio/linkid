<?php

/**
 * organizations
 * 
 * @package LinkID
 * @author RasyaJusticio
 */

// fetch bootloader
require('bootloader.php');

// user access
user_access(false, true);

try {
  $org = $user->get_organization_from_user($user->_data['user_id']);

  switch ($_GET['view']) {
    case "":
      // page header
      page_header(__("Organizations") . " &rsaquo; " . __("Dashboard"));

      break;
    case "informations":
      // page header
      page_header(__("Organizations") . " &rsaquo; " . __("Informations"));

      break;
    case "apply":
      // page header
      page_header(__("Organizations") . " &rsaquo; " . __("Apply"));

      if ($user->_is_organization) {
        redirect('/organizations');
        break;
      }

      page_footer('organizations.apply');

      break;
  }

  /* assign variables */
  $smarty->assign('org', $org);
  $smarty->assign('view', $_GET['view']);
  $smarty->assign('sub_view', $_GET['sub_view']);
} catch (Exception $e) {
  _error(__("Error"), $e->getMessage());
}

// page footer
if ($_GET['view'] != "apply") {
  page_footer('organizations');
}
