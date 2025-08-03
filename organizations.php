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
if ($user->_logged_in || !$system['system_public']) {
  user_access();
}

try {
  // get view content
  switch ($_GET['view']) {
    case '':
      // user access
      if ($user->_logged_in || !$system['system_public']) {
        user_access();
      }
      if ($user->is_org_user()) {
        redirect('/');
      }

      // get data
      $orgs = $user->get_orgs($user->_data['user_id']);

      /* assign variables */
      $smarty->assign('organizations', $orgs);

      // page header
      page_header(__("Organizations") . ' | ' . __($system['system_title']), __($system['system_description_groups']));
      break;

    case 'apply':
      // user access
      if ($user->_logged_in || !$system['system_public']) {
        user_access();
      }
      if ($user->is_org_user()) {
        redirect('/');
      }

      // page header
      page_header(__("Organizations") . ' &rsaquo; ' . __("Apply") . ' | ' . __($system['system_title']), __($system['system_description_groups']));

      break;

    default:
      _error(404);
      break;
  }

  /* assign variables */
  $smarty->assign('view', $_GET['view']);
} catch (Exception $e) {
  _error(__("Error"), $e->getMessage());
}

// page footer
page_footer('organizations');
