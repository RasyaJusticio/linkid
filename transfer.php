<?php

/**
 * transfer
 * 
 * @author RasyaJusticio
 */

// fetch bootloader
require('bootloader.php');

// user access
user_access(false, true);

try {

  // get view content
  switch ($_GET['view']) {
    case '':
      // page header
      page_header(__("Receive Money") . ' | ' . __($system['system_title']));

      // get transfer notifications
      if (isset($_GET['transfer_send_succeed']) && isset($_SESSION['transfer_send_amount'])) {
        /* assign variables */
        $smarty->assign('transfer_send_amount', $_SESSION['transfer_send_amount']);
        /* unset session */
        unset($_SESSION['transfer_send_amount']);
      }

      if (!isset($user->_data['user_transfer_token']) || $user->_data['user_transfer_token'] == "") {
        $transfer_token = $user->transfer_generate_token();      
      } else {
        $transfer_token = $user->_data['user_transfer_token'];
      }

      /* assign variables */
      $smarty->assign('transfer_token', $transfer_token);
      break;

    case 'send':
      // page header
      page_header(__("Send Money") . ' | ' . __($system['system_title']));

      // get transfer notifications
      if (isset($_GET['transfer_send_failed']) && isset($_SESSION['transfer_fail_message'])) {
        /* assign variables */
        $smarty->assign('transfer_fail_message', $_SESSION['transfer_fail_message']);
        /* unset session */
        unset($_SESSION['transfer_fail_message']);
      }

      /* assign variables */
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
page_footer('transfer');
