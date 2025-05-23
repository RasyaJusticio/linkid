<?php

/**
 * ajax -> chat -> conversation ✅
 * 
 * @package Sngine
 * @author Zamblek
 */

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// user access
user_access(true);

try {

  // initialize the return array
  $return = [];

  switch ($_GET['do']) {
    case 'get':
      // get conversation
      $conversation = $user->get_conversation($_GET['conversation_id']);
      if ($conversation) {
        /* get conversation messages */
        $conversation['messages'] = $user->get_conversation_messages($conversation['conversation_id'])['messages'];
        /* assign variables */
        $smarty->assign('conversation', $conversation);
        /* return */
        $return['conversation'] = $conversation;
        $return['conversation_html'] = $smarty->fetch("ajax.chat.conversation.tpl");
      }
      break;

    case 'check':
      // check mutual conversation (even deleted)
      $mutual_conversation = $user->get_mutual_conversation_id((array)$_GET['uid'], true);
      if ($mutual_conversation) {
        $return['conversation_id'] = $mutual_conversation;
      }
      break;

    default:
      throw new BadRequestException(__("Invalid request"));
      break;
  }

  // return & exit
  return_json($return);
} catch (BadRequestException $e) {
  _error(400);
} catch (AuthorizationException $e) {
  _error(403);
} catch (Exception $e) {
  modal("ERROR", __("Error"), $e->getMessage());
}
