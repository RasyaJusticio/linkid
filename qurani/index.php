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

$token = generate_sub_app_token();

$smarty->assign('token', $token);

page_header("Qurani | Link.id - Sosmed Islami");
page_footer('qurani/index');
?>
