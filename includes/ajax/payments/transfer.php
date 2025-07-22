<?php

/**
 * ajax -> payments -> transfer
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

        $target_user = $user->get_user($_POST['send_to_id']);
        if (!isset($target_user)) {
            throw new Exception(__("QR Code are invalid"));    
        }

        // process
        $user->transfer_money($target_user['user_id'], $_POST['amount']);

        // return
        return_json(['callback' => 'window.location = site_path + "/wallet?transfer_send_succeed"']);
        break;
    case 'check_identity':
        // valid inputs
        if (!isset($_POST['identity'])) {
            return_json(['result' => 'invalid', 'callback' => 'window.location.reload()']);
            break;
        }

        $target_user = $user->transfer_get_user($_POST['identity']);
        if (!empty($target_user)) {
            return_json(['result' => 'valid', 'user' => $target_user]);
            break;
        }

        $member = $user->org_get_member_by_va($_POST['identity']);
        if (!empty($member)) {
            return_json(['result' => 'valid', 'user' => $member]);
            break;
        }

        return_json(['result' => 'invalid', 'callback' => 'window.location.reload()']);
        break;
    default:
        _error(400);
        break;
    }
} catch (Exception $e) {
    return_json(['error' => true, 'message' => $e->getMessage()]);
}
