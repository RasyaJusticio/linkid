<?php

/**
 * mutabaah -> index 
 * 
 * @package LinkID 
 * @author RasyaJusticio 
 */

// fetch bootloader
require('../bootloader.php');

// user access
if ($user->_logged_in || !$system['system_public']) {
  user_access();
}

try {

  // page header
  page_header(__("Mutabaah") . ' | ' . __($system['system_title']), __($system['system_description_mutabaah']));

} catch (Exception $e) {
  _error(__("Error"), $e->getMessage());
}

// page footer
page_footer('mutabaah/inprogress');
