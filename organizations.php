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

    case 'sub-accounts':
      switch ($_GET['sub_view']) {
        case "":
          // page header
          page_header(__("Organizations") . " &rsaquo; " . __("Sub-Accounts"));

          $sub_accounts = $user->get_org_sub_accounts($org['id']);
          $insights = [
            'users' => count($sub_accounts),
            'pending' => 0,
          ];

          $smarty->assign('rows', $sub_accounts);
          $smarty->assign('insights', $insights);
          break;

        case "find":
          page_header(__("Organizations") . " &rsaquo; " . __("Sub-Accounts") . " &rsaquo; " . __("Find"));

          if (is_empty($_GET['query'])) {
            redirect('/organizations/sub-accounts');
          }

          require('includes/class-pager.php');

          $org_id = $org['id'];
          $query = secure($_GET['query'], 'search');

          $params['selected_page'] = (!isset($_GET['page']) || (int) $_GET['page'] == 0) ? 1 : $_GET['page'];

          // Count matching rows
          $total = $db->query(sprintf(
            "SELECT COUNT(*) as count
             FROM org_users
             JOIN users ON org_users.user_id = users.user_id
             WHERE org_users.organization_id = %d
               AND org_users.role = 'sub-account'
               AND (
                 user_name LIKE %s OR
                 user_firstname LIKE %s OR
                 user_lastname LIKE %s OR
                 CONCAT(user_firstname, ' ', user_lastname) LIKE %s OR
                 user_email LIKE %s OR
                 user_phone LIKE %s
               )",
            $org_id, $query, $query, $query, $query, $query, $query
          ));

          $params['total_items'] = $total->fetch_assoc()['count'];
          $params['items_per_page'] = $system['max_results'];
          $params['url'] = $system['system_url'] . '/' . $control_panel['url'] . '/sub-accounts/find?query=' . $_GET['query'] . '&org_id=' . $org_id . '&page=%s';

          $pager = new Pager($params);
          $limit_query = $pager->getLimitSql();

          // Get matching rows
          $get_rows = $db->query(sprintf(
            "SELECT org_users.*, users.*
             FROM org_users
             JOIN users ON org_users.user_id = users.user_id
             WHERE org_users.organization_id = %d
               AND org_users.role = 'sub-account'
               AND (
                 user_name LIKE %s OR
                 user_firstname LIKE %s OR
                 user_lastname LIKE %s OR
                 CONCAT(user_firstname, ' ', user_lastname) LIKE %s OR
                 user_email LIKE %s OR
                 user_phone LIKE %s
               )
             %s",
            $org_id, $query, $query, $query, $query, $query, $query, $limit_query
          ));

          $rows = [];
          if ($get_rows->num_rows > 0) {
            while ($row = $get_rows->fetch_assoc()) {
              $row['user_picture'] = get_picture($row['user_picture'], $row['user_gender']);
              $row['user_fullname'] = ($system['show_usernames_enabled']) ? $row['user_name'] : $row['user_firstname'] . " " . $row['user_lastname'];
              $rows[] = $row;
            }
          }

          $smarty->assign('rows', $rows);
          $smarty->assign('pager', $pager->getPager());
          $smarty->assign('query', $_GET['query']);
          break;

        case "add":
          // page header
          page_header(__("Organizations") . " &rsaquo; " . __("Sub-Accounts") . " &rsaquo; " . __("Add"));

          break;
      }
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
