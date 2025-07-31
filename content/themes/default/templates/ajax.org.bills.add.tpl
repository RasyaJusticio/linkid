<div class="modal-header">
  <h6 class="modal-title">
    {include file='__svg_icons.tpl' icon="groups" class="main-icon mr10" width="24px" height="24px"}
    {__("Add New Bill")}
  </h6>
  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
</div>
<form class="js_ajax-forms" data-url="organizations/bills.php?do=add">
  <div class="modal-body">
    <div class="form-group">
      <label class="form-label">{__("Amount")}</label>
      <div class="input-money {$system['system_currency_dir']}">
        <span>{$system['system_currency_symbol']}</span>
        <input class="form-control input_money-IDR" type="text" placeholder="0" min="1.00" max="1000" name="amount">
      </div>
      {include file="__money_amounts.tpl"}
    </div>
    <div class="form-group">
      <label class="form-label" for="due_date">{__("Due Date")}</label>
      <input type="datetime-local" class="form-control" name="due_date">
    </div>
    <div class="form-group">
      <label class="form-label" for="description">{__("Description")}</label>
      <textarea class="form-control" name="description"></textarea>
    </div>

    <!-- hidden -->
    <input type="hidden" name="org_id" value="{$org_id}">
    <input type="hidden" name="member_id" value="{$member_id}">
    <!-- hidden -->

    <!-- error -->
    <div class="alert alert-danger mb0 mt10 x-hidden"></div>
    <!-- error -->
  </div>
  <div class="modal-footer">
    <button type="submit" class="btn btn-primary">{__("Create")}</button>
  </div>
</form>
