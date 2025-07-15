<div class="card">
  <div class="card-header with-icon">
    {if $sub_view == ""}
      <div class="float-end">
        <a href="{$system['system_url']}/organizations/{$username}/sub-accounts/add" class="btn btn-md btn-primary">
          <i class="fa fa-plus mr5"></i>{__("Add")}
        </a>
      </div>
    {else}
      <div class="float-end">
        <a href="{$system['system_url']}/organizations/{$username}/sub-accounts" class="btn btn-md btn-light">
          <i class="fa fa-arrow-circle-left"></i><span class="ml5 d-none d-lg-inline-block">{__("Go Back")}</span>
        </a>
      </div>
    {/if}
    <i class="fa fa-film mr10"></i>{__("Sub-Accounts")}
    {if $sub_view == "add"} &rsaquo; {__("Add New Account")}{/if}
  </div>
  {if $sub_view == "" || $sub_view == "find"}
    <div class="card-body">
      {if $org_topup_amount}
        <div class="alert alert-success mb20">
          <i class="fas fa-check-circle mr5"></i>
          {__("Your")} <span class="badge rounded-pill badge-lg bg-secondary">{print_money($org_topup_amount|format_number)}</span> {__(" top up successfuly sent")}
        </div>
      {/if}

      {if $sub_view == ""}
        <div class="row">
          <div class="col-md-6 col-lg-6 col-xl-6">
            <div class="stat-panel bg-gradient-primary">
              <div class="stat-cell narrow">
                <i class="fa fa-users bg-icon"></i>
                <span class="text-xxlg">{$insights['users']}</span><br>
                <span class="text-lg">{__("Accounts")}</span><br>
              </div>
            </div>
          </div>
          <div class="col-md-6 col-lg-6 col-xl-6">
            <div class="stat-panel bg-gradient-warning">
              <div class="stat-cell narrow">
                <i class="fa fa-clock bg-icon"></i>
                <span class="text-xxlg">{$insights['pending']}</span><br>
                <span class="text-lg">{__("Pending Accounts")}</span><br>
              </div>
            </div>
          </div>
        </div>
      {/if}

      <!-- search form -->
      <div class="mb20">
        <form class="d-flex flex-row align-items-center flex-wrap" action="{$system['system_url']}/organizations/{$username}/sub-accounts/find" method="get">
          <div class="form-group mb0">
            <div class="input-group">
              <input type="text" class="form-control" name="query" value="{$query}">
              <button type="submit" class="btn btn-sm btn-light"><i class="fas fa-search mr5"></i>{__("Search")}</button>
            </div>
          </div>
        </form>
        <div class="form-text small">
          {__("Search by Username, First Name, Last Name, Email or Phone")}
        </div>
      </div>
      <!-- search form -->

      <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover">
          <thead>
            <tr>
              <th>{__("ID")}</th>
              <th>{__("Name")}</th>
              <th>{__("Username")}</th>
              <th>{__("VA Number")}</th>
              <th>{__("Balance")}</th>
              <th>{__("Actions")}</th>
            </tr>
          </thead>
          <tbody>
            {if $rows}
              {foreach $rows as $row}
                <tr>
                  <td><a href="{$system['system_url']}/{$row['user_name']}" target="_blank">{$row['user_id']}</a></td>
                  <td>
                    <a target="_blank" href="{$system['system_url']}/{$row['user_name']}">
                      <img class="tbl-image" src="{$row['user_picture']}">
                      {$row['user_firstname']} {$row['user_lastname']}
                    </a>
                  </td>
                  <td>
                    <a href="{$system['system_url']}/{$row['user_name']}" target="_blank">
                      {$row['user_name']}
                    </a>
                  </td>
                  <td>
                    {$row['va_number'] ?? '-'}
                  </td>
                  <td>
                    {print_money($row['balance']|format_number)}
                  </td>
                  <td>
                    <a data-bs-toggle="tooltip" title='{__("Edit")}' href="{$system['system_url']}/organizations/{$username}/sub-accounts/edit/{$row['id']}" class="btn btn-sm btn-icon btn-rounded btn-primary">
                      <i class="fa fa-pencil-alt"></i>
                    </a>
                    <button data-bs-toggle="tooltip" title='{__("Top up")}' class="btn btn-sm btn-icon btn-rounded btn-primary" data-toggle="modal" data-url="#account-transfer" data-options='{ "id": {$row['id']} }'>
                      <i class="fa fa-credit-card"></i>
                    </button>
                    <button data-bs-toggle="tooltip" title='{__("QR Code")}' class="btn btn-sm btn-icon btn-rounded btn-primary">
                      <i class="fa fa-qrcode"></i>
                    </button>
                    <button data-bs-toggle="tooltip" title='{__("Delete")}' class="btn btn-sm btn-icon btn-rounded btn-danger js_org-deleter" data-handle="account" data-id="{$row['id']}">
                      <i class="fa fa-trash-alt"></i>
                    </button>
                  </td>
                </tr>
              {/foreach}
            {else}
              <tr>
                <td colspan="7" class="text-center">
                  {__("No data to show")}
                </td>
              </tr>
            {/if}
          </tbody>
        </table>
      </div>
      {$pager}
    </div>
  {elseif $sub_view == "add"}
    <form class="js_ajax-forms" data-url="organizations/sub-accounts.php?do=add">
      <div class="card-body">
        <div class="form-group">
          <label class="form-label" for="user_id_ac">{__("User")}</label>
          <div class="position-relative js_autocomplete">
            <input class="form-control" type="text" placeholder="{__("Search for user name or email")}" name="user_id_ac" id="user_id_ac" autocomplete="off" readonly onfocus="this.removeAttribute('readonly');">
            <input type="hidden" class="js_auto-va-input" data-va-org-id="{$org['id']}" data-auto-va-id="user_id" name="user_id">
          </div>
        </div>

        <div class="form-group">
          <label class="form-label" for="va_number">{__("VA Number")}</label>
          <input type="text" class="form-control js_digit-only js_auto-va-output" data-auto-va-id="user_id" name="va_number">
          <div class="form-text">
            {__("Assign this account a unique virtual account number")}
          </div>
        </div>

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
  {elseif $sub_view == "edit"}
    <form class="js_ajax-forms" data-url="organizations/sub-accounts.php?do=edit">
      <div class="card-body">
        <div class="form-group">
          <label class="form-label" for="user_id_ac">{__("User")}</label>
          <div class="position-relative js_autocomplete">
            <input class="form-control opacity-50" type="text" value="{$account['user_firstname']} {$account['user_lastname']}" name="user_id_ac" id="user_id_ac" disabled>
            <input type="hidden" name="user_id" value="{$account['user_id']}" class="js_auto-va-input" data-uid="{$account['user_id']}" data-va-org-id="{$org['id']}" data-auto-va-id="user_id" data-disabled>
          </div>
        </div>

        <div class="form-group">
          <label class="form-label" for="va_number">{__("VA Number")}</label>
          <input type="text" class="form-control js_digit-only js_auto-va-output" data-auto-va-id="user_id" name="va_number" value="{$account['va_number']}">
          <div class="form-text">
            {__("Assign this account a unique virtual account number")}
          </div>
        </div>

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
  {/if}
</div>
