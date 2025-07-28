
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

  $connection = $user->org_get_connection($organization['id']);
  $org_url = '/org/' . $_GET['username'];

  // get view content
  switch ($_GET['view']) {
    case '':
      redirect($org_url . '/me');

      break;

    case 'me':
      switch ($_GET['sub_view']) {
        case '':
          // page header
          page_header($organization['name'] . ' &rsaquo; ' . __("Me") . ' | ' . __($system['system_title']), __($system['system_description_groups']));

          $member = $user->org_get_member_by_user($organization['id']);

          // get qrcode image
          $qrcode = $user->org_generate_va_qrcode($member['va_number']);

          // get account transactions
          $transactions = $user->org_get_transactions($organization['id']);

          /* assign variables */
          $smarty->assign('data', $member);
          $smarty->assign('transactions', $transactions);
          $smarty->assign('qrcode_uri', $qrcode);

          break;

        case 'transfer-pin':
          // page header
          page_header($organization['name'] . ' &rsaquo; ' . __("Me") . ' &rsaquo; ' . __("Transfer PIN") . ' | ' . __($system['system_title']), __($system['system_description_groups']));

          $member = $user->org_get_member_by_user($organization['id']);

          /* assign variables */
          $smarty->assign('data', $member);

          break;

        default:
          _error(404);
          break;
      }

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

          $members = $user->org_get_members($organization['id']);

          foreach ($members as &$member) {
            $member['qrcode_uri'] = $user->org_generate_va_qrcode($member['va_number']); 
          }

          $smarty->assign('rows', $members);
          break;

        case 'add':
          page_header($organization['name'] . ' &rsaquo; ' . __("Members") . ' &rsaquo; ' . __("Add") . ' | ' . __($system['system_title']), __($system['system_description_groups']));

          break;

        case 'edit':
          page_header($organization['name'] . ' &rsaquo; ' . __("Members") . ' &rsaquo; ' . __("Edit") . ' | ' . __($system['system_title']), __($system['system_description_groups']));

          // get data
          $member = $user->org_get_member_with_org($organization['id'], $_GET['id']);

          $smarty->assign('data', $member);

          break;

        case 'find':
          // page header
          page_header($organization['name'] . ' &rsaquo; ' . __("Members") . ' &rsaquo; ' . __("Find") . ' | ' . __($system['system_title']), __($system['system_description_groups']));

          if (is_empty($_GET['query'])) {
            redirect('/organizations/' . $_GET['username'] . '/sub-accounts');
          }

          require('includes/class-pager.php');

          $org_id = $organization['id'];
          $query = secure($_GET['query'], 'search');

          $params['selected_page'] = (!isset($_GET['page']) || (int) $_GET['page'] == 0) ? 1 : $_GET['page'];

          // Count matching rows
          $total = $db->query(sprintf(
            "SELECT COUNT(*) as count

            FROM org_members m 
            JOIN users u ON m.user_id = u.user_id
            LEFT JOIN org_virtual_accounts va ON va.id = m.virtual_account_id

            WHERE m.organization_id = %d
            AND (
            user_name LIKE %s OR
            user_firstname LIKE %s OR
            user_lastname LIKE %s OR
            CONCAT(user_firstname, ' ', user_lastname) LIKE %s OR
            user_email LIKE %s OR
            user_phone LIKE %s OR
            role LIKE %s OR
            va_number LIKE %s
            )",
            $org_id, $query, $query, $query, $query, $query, $query, $query, $query
          ));

          $params['total_items'] = $total->fetch_assoc()['count'];
          $params['items_per_page'] = $system['max_results'];
          $params['url'] = $system['system_url'] . '/' . $control_panel['url'] . '/sub-accounts/find?query=' . $_GET['query'] . '&org_id=' . $org_id . '&page=%s';

          $pager = new Pager($params);
          $limit_query = $pager->getLimitSql();

          // Get matching rows
          $get_rows = $db->query(sprintf(
            "SELECT 
            m.*, 
            va.va_number, va.balance,
            u.user_id, u.user_firstname, u.user_lastname, u.user_name, u.user_email, u.user_picture

            FROM org_members m
            JOIN users u ON m.user_id = u.user_id
            LEFT JOIN org_virtual_accounts va ON va.id = m.virtual_account_id
            WHERE m.organization_id = %d

            AND (
            user_name LIKE %s OR
            user_firstname LIKE %s OR
            user_lastname LIKE %s OR
            CONCAT(user_firstname, ' ', user_lastname) LIKE %s OR
            user_email LIKE %s OR
            user_phone LIKE %s OR
            role LIKE %s OR
            va_number LIKE %s
            )
            %s",
            $org_id, $query, $query, $query, $query, $query, $query, $query, $query, $limit_query
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

        default:
          _error(404);
          break;
      }
      break;

    case 'all-transactions':
      // page header
      page_header($organization['name'] . ' &rsaquo; ' . __("All Transactions") . ' | ' . __($system['system_title']), __($system['system_description_groups']));

      // get all transactions
      $transactions = $user->org_get_all_transactions($organization['id']);

      /* assign variables */
      $smarty->assign('transactions', $transactions);

      break;

    default:
      _error(404);
      break;
  }

  /* assign variables */
  $smarty->assign('username', $_GET['username']);
  $smarty->assign('view', $_GET['view']);
  $smarty->assign('sub_view', $_GET['sub_view']);
  $smarty->assign('id', $_GET['id']);
  $smarty->assign('organization', $organization);
  $smarty->assign('connection', $connection);
} catch (Exception $e) {
  _error(__("Error"), $e->getMessage());
}

// page footer
page_footer('organization');
