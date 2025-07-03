/**
 * core js
 * 
 * @package LinkID 
 * @author RasyaJusticio
 */

// initialize API URLs
// organizations
api['organizations/delete'] = ajax_path + "organizations/delete.php";

function generateVaNumber(orgId, userId, prefix = '62') {
  const vaCore = orgId.toString().padStart(4, '0') + userId.toString().padStart(6, '0');
  return prefix + vaCore;
}

$(function () {
  // org deleter
  $('body').on('click', '.js_org-deleter', function () {
    var handle = $(this).data('handle');
    var id = $(this).data('id');
    var node = $(this).data('node');
    var redirect_url = $(this).data("redirect");
    var message = $(this).data('delete-message') || __['Are you sure you want to delete this?'];
    confirm(__['Delete'], message, function () {
      $.post(api['organizations/delete'], { 'handle': handle, 'id': id, 'node': node }, function (response) {
        /* check the response */
        if (response.callback) {
          eval(response.callback);
        } else {
          if (redirect_url !== undefined) {
            window.location = redirect_url;
          } else {
            window.location.reload();
          }
        }
      }, 'json')
        .fail(function () {
          modal('#modal-message', { title: __['Error'], message: __['There is something that went wrong!'] });
        });
    });
  });

  // automatic VA Number generation
  $('.js_auto-va-input[data-disabled]').each(function () {
    var $this = $(this);

    var orgID = $this.data('va-org-id');
    var autoVaID = $this.data('auto-va-id');

    var $output = $(`.js_auto-va-output[data-auto-va-id="${autoVaID}"]`);

    if ($output.length) {
      $output.attr("placeholder", generateVaNumber(orgID, $this.data('uid')));
    }
  });
  $('body').on('input change', '.js_auto-va-input', function () {
    var $this = $(this);
    
    var orgID = $this.data('va-org-id');
    var autoVaID = $this.data('auto-va-id');

    var $output = $(`.js_auto-va-output[data-auto-va-id="${autoVaID}"]`);

    if ($output.length) {
      $output.val(generateVaNumber(orgID, $this.data('uid')));
    }
  });
});
