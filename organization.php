
<?php

/**
 * organization
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
  $organization = $user->get_org_by_slug($_GET['username']);
  if (empty($organization)) {
      _error(404);
      return;
  } 

  if (!$user->org_is_member($organization['id'])) {
      _error(401);
      return;
  }
  
  // get view content
  switch ($_GET['view']) {
    case '':
      // page header
      page_header($organization['name'] . ' &rsaquo; ' . __("Me") . ' | ' . __($system['system_title']), __($system['system_description_groups']));
      break;

    case 'dashboard':
      // page header
      page_header($organization['name'] . ' &rsaquo; ' . __("Dashboard") . ' | ' . __($system['system_title']), __($system['system_description_groups']));
      break;

    case 'members':
      switch ($_GET['sub_view']) {
        case '':
        // page header

        page_header($organization['name'] . ' &rsaquo; ' . __("Members") . ' | ' . __($system['system_title']), __($system['system_description_groups']));
        break;

        case 'add':
        page_header($organization['name'] . ' &rsaquo; ' . __("Members") . ' &rsaquo; ' . __("Add") . ' | ' . __($system['system_title']), __($system['system_description_groups']));

        break;


      
      }
      break;

    default:
      _error(404);
      break;
  }

  /* assign variables */
  $smarty->assign('username', $_GET['username']);
  $smarty->assign('view', $_GET['view']);
  $smarty->assign('sub_view', $_GET['sub_view']);
  $smarty->assign('organization', $organization);
} catch (Exception $e) {
  _error(__("Error"), $e->getMessage());
}

// page footer
page_footer('organization');
