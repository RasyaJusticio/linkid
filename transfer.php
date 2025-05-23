<?php

/**
 * wallet
 * 
 * @author RasyaJusticio 
 */

// fetch bootloader
require('bootloader.php');

// check if wallet enabled
if (!$system['wallet_enabled']) {
  _error(404);
}

// user access
user_access(false, true);

try {

  // get view content
  switch ($_GET['view']) {
    case '':
      // page header
      page_header(__("Transfer History") . ' | ' . __($system['system_title']));

      // get transfer transactions
      $transactions = $user->transfer_get_transactions();

      /* assign variables */
      $smarty->assign('transactions', $transactions);
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
