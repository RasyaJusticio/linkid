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
      page_header(__("Receive") . ' | ' . __($system['system_title']));

      // get wallet notifications
      if (isset($_GET['wallet_transfer_succeed']) && isset($_SESSION['wallet_transfer_amount'])) {
        /* assign variables */
        $smarty->assign('wallet_transfer_amount', $_SESSION['wallet_transfer_amount']);
        /* unset session */
        unset($_SESSION['wallet_transfer_amount']);
      }
      if (isset($_GET['wallet_replenish_succeed']) && isset($_SESSION['wallet_replenish_amount'])) {
        /* assign variables */
        $smarty->assign('wallet_replenish_amount', $_SESSION['wallet_replenish_amount']);
        /* unset session */
        unset($_SESSION['wallet_replenish_amount']);
      }

      if (!isset($user->_data['user_transfer_token']) || $user->_data['user_transfer_token'] == "") {
        $transfer_token = $user->transfer_generate_token();      
      } else {
        $transfer_token = $user->_data['user_transfer_token'];
      }

      /* assign variables */
      $smarty->assign('transfer_token', $transfer_token);
      break;

    case 'payments':
      // check if wallet withdrawal enabled
      if (!$system['wallet_withdrawal_enabled']) {
        _error(404);
      }

      // page header
      page_header(__("Wallet Payments") . ' | ' . __($system['system_title']));

      // get payments
      $payments = $user->wallet_get_payments();
      /* assign variables */
      $smarty->assign('payments', $payments);
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
