<?php

/**
 * qurani -> index
 * 
 * @package LinkID 
 * @author RasyaJusticio
 */

// fetch bootloader
require('../bootloader.php');

// user access
user_access();

$user_id = $user->_data['user_id'];
$current_language = $system['current_language'];
$theme_mode_night = $system['theme_mode_night'];
$session_hash = $user->_data['session_token'];

$data = [
  'c_user' => $user_id,
  's_lang' => $current_language,
  's_night_mode' => $theme_mode_night,
  'user_session' => $session_hash
];
ksort($data);
$data_query = http_build_query($data);

$hmac = hash_hmac('sha256', $data_query, JWT_SECRET);

$smarty->assign('c_user', $user_id);
$smarty->assign('s_lang', $current_language);
$smarty->assign('s_night_mode', $theme_mode_night);
$smarty->assign('user_session', $session_hash);
$smarty->assign('signature', $hmac);

page_header("Qurani Page");
page_footer('qurani/index');
?>
