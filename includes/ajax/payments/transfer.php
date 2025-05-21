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
    case 'check_token':
        // valid inputs
        if (!isset($_POST['transfer_token'])) {
            $_SESSION['transfer_fail_message'] = "Scanned QR Code invalid";
            return_json(['result' => 'invalid', 'callback' => 'window.location = site_path + "/wallet?transfer_send_failed"']);
            break;
        }

        $target_user = $user->transfer_get_user($_POST['transfer_token']);
        if (!isset($target_user)) {
            $_SESSION['transfer_fail_message'] = "Scanned QR Code invalid";
            return_json(['result' => 'invalid', 'callback' => 'window.location = site_path + "/wallet?transfer_send_failed"']);
            break;
        }
        
        $target_user['user_picture'] = get_picture($target_user['user_picture'], $target_user['user_gender']);

        return_json(['result' => 'valid', 'user' => $target_user]);
        break;
    default:
        _error(400);
        break;
    }
} catch (Exception $e) {
    return_json(['error' => true, 'message' => $e->getMessage()]);
}
