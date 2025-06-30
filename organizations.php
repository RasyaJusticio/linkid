<?php

/**
 * organizations
 * 
 * @package LinkID
 * @author RasyaJusticio
 */

// fetch bootloader
require('bootloader.php');

// user access
user_access(false, true);

try {
  switch ($_GET['view']) {
    case "":
      break;
    case "apply":
      // page header
      page_header(__("Organization") . " &rsaquo; " . __("Apply"));

      page_footer("organization.apply");
      break;
  
  }

} catch (Exception $e) {
  _error(__("Error"), $e->getMessage());
}
