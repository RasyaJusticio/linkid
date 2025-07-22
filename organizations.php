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

  // get selected country
  if (isset($_GET['country'])) {
    /* get selected country */
    $selected_country = $user->get_country_by_name($_GET['country']);
    /* assign variables */
    $smarty->assign('selected_country', $selected_country);
  }

  // get view content
  switch ($_GET['view']) {
    case '':
      // user access
      if ($user->_logged_in || !$system['system_public']) {
        user_access();
      }

      // page header
      page_header(__("Groups") . ' | ' . __($system['system_title']), __($system['system_description_groups']));

      // get groups categories
      $smarty->assign('categories', $user->get_categories("groups_categories"));

      // get new groups
      $groups = $user->get_groups(['suggested' => true, 'country' => $selected_country['country_id']]);
      /* assign variables */
      $smarty->assign('groups', $groups);
      $smarty->assign('get', "suggested_groups");
      $smarty->assign('view_title', __("Discover"));
      break;

    case '':
      // user access
      if ($user->_logged_in || !$system['system_public']) {
        user_access();
      }

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
