<div class="card-header with-icon">
  {include file='__svg_icons.tpl' icon="security" class="main-icon mr15" width="24px" height="24px"}
  {__("My Transfer PIN")}
</div>
<form class="js_ajax-forms" data-url="organizations/settings.php?edit=transfer-pin">
  <div class="card-body">
    {if $set_transfer_pin_succeed}
    <div class="alert alert-success mb20">
      <i class="fas fa-check-circle mr5"></i>
      {__("Your transfer PIN has been updated")}
    </div>
    {/if}

    {if !is_empty($data['transfer_pin'])}
    <div class="form-group">
      <label class="form-label">{__("Current Transfer PIN")}</label>
      <input type="password" class="form-control pin-input" name="current">
    </div>
    {/if}

    <div class="row">
      <div class="form-group col-md-6">
        <label class="form-label">{__("Your New Transfer PIN")}</label>
        <input type="password" class="form-control pin-input" name="new">
      </div>
      <div class="form-group col-md-6">
        <label class="form-label">{__("Confirm New Transfer PIN")}</label>
        <input type="password" class="form-control pin-input" name="confirm">
      </div>
    </div>

    <!-- hidden -->
    <input type="hidden" name="org_username" value={$username}>
    <!-- hidden -->

    <!-- success -->
    <div class="alert alert-success mt15 mb0 x-hidden"></div>
    <!-- success -->

    <!-- error -->
    <div class="alert alert-danger mt15 mb0 x-hidden"></div>
    <!-- error -->
  </div>
  <div class="card-footer text-end">
    <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
  </div>
</form>
