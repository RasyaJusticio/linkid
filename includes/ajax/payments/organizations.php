<?php

/**
 * ajax -> payments -> organizations
 * 
 * @author RasyaJusticio
 */

// fetch bootstrap
require '../../../bootstrap.php';

// check AJAX Request
is_ajax();

// user access
user_access(true, true);

try {
    switch ($_REQUEST['do']) {
    case 'send_money':
        // valid inputs
        if (!isset($_POST['amount']) || !is_numeric($_POST['amount']) || $_POST['amount'] < 0) {
            throw new Exception(__("Enter valid amount of money"));
        }

        $member = $user->org_get_member_by_va($_POST['va_number']);

        // process
        $user->org_va_transfer($member['id'], $_POST['amount']);

        // return
        return_json(['callback' => 'window.location.reload()']);
        break;

    case 'pay_bill':
        // valid inputs
        if (!isset($_POST['amount']) || !is_numeric($_POST['amount']) || $_POST['amount'] < 0) {
            throw new Exception(__("Enter valid amount of money"));
        }

        // process
        $user->org_pay_bill($_POST);

        // return
        return_json(['callback' => 'window.location.reload()']);
        break;
    default:
        _error(400);
        break;
    }
} catch (Exception $e) {
    return_json(['error' => true, 'message' => $e->getMessage()]);
}
