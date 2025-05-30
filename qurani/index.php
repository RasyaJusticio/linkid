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
$session_hash = get_hash_token();

$smarty->assign('c_user', $user_id);
$smarty->assign('s_lang', $current_language);
$smarty->assign('s_night_mode', $theme_mode_night);
$smarty->assign('user_session', $session_hash);

page_header("Qurani Page");
page_footer('qurani/index');
?>
