<div class="card-header with-icon">
  {if $sub_view == ""}
  <div class="float-end">
    <a href="{$org_url}/members/add" class="btn btn-md btn-primary d-none d-lg-block">
      <i class="fa fa-plus-circle mr5"></i>{__("Add")}
    </a>
  </div>
  {elseif in_array($sub_view, ['add', 'edit', 'find'])}
  <div class="float-end">
    <a href="{$org_url}/members" class="btn btn-md btn-light">
      <i class="fa fa-arrow-circle-left"></i><span class="ml5 d-none d-lg-inline-block">{__("Go Back")}</span>
    </a>
  </div>
  {/if}
  <i class="fa fa-users mr10"></i>{__("Members")}
  {if $sub_view == "find"} &rsaquo; <span>{__("Find")}</span>{/if}
  {if $sub_view == "add"} &rsaquo; <span>{__("Add")}</span>{/if}
  {if $sub_view == "edit"} &rsaquo; <a href="{$system['system_url']}/{$data['user_name']}">{$data['user_fullname']}</a>{/if}
</div>

{if $sub_view == "" || $sub_view == "find"}

<div class="card-body">
  <!-- search form -->
  <div class="mb20">
    <form class="d-flex flex-row align-items-center flex-wrap" action="{$org_url}/members/find" method="get">
      <div class="form-group mb0">
        <div class="input-group">
          <input type="text" class="form-control" name="query" value="{$query}">
          <button type="submit" class="btn btn-sm btn-light"><i class="fas fa-search mr5"></i>{__("Search")}</button>
        </div>
      </div>
    </form>
    <div class="form-text small">
      {__("Search by Username, First Name, Last Name, Email, VA Number, or Role")}
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
          <th>{__("Role")}</th>
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
          <td>{$row['va_number']|format_va_number}</td>
          <td>{print_money($row['balance']|format_number)}</td>
          <td>{$row['role']|format_org_role}</td>
          <td>
            <a data-bs-toggle="tooltip" title='{__("Edit")}' href="{$org_url}/members/edit/{$row['id']}" class="btn btn-sm btn-icon btn-rounded btn-primary">
              <i class="fa fa-pencil-alt"></i>
            </a>
            <button data-bs-toggle="tooltip" title='{__("Delete")}' class="btn btn-sm btn-icon btn-rounded btn-danger js_admin-deleter" data-handle="user" data-id="{$row['user_id']}">
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

<div class="card-body">
  <form class="js_ajax-forms" data-url="organizations/members.php?do=add">
    <div class="row">
      <div class="form-group col-md-8">
        <label class="form-label" for="user_id_ac">{__("User")}</label>
        <div class="position-relative js_autocomplete">
          <input class="form-control" type="text" placeholder="{__("Search for user name or email")}" name="user_id_ac" id="user_id_ac" autocomplete="off" readonly onfocus="this.removeAttribute('readonly');">
          <input type="hidden" class="js_auto-va-input" data-va-org-id="{$organization['id']}" data-auto-va-id="user_id" name="user_id">
        </div>
      </div>

      <div class="form-group col-md-4">
        <label class="form-label">{__("Role")}</label>
        <select class="form-select" name="role">
          <option value="none">{__("Select Role")}</option>
          <option value="admin">{__("Admin")}</option>
          <option value="staff">{__("Staff")}</option>
          <option value="account">{__("Account")}</option>
          <option value="sub-account">{__("Sub-Account")}</option>
        </select>
      </div>
    </div>

    <div class="row">
      <div class="form-group col-12">
        <label class="form-label" for="va_number">{__("VA Number")}</label>
        <input type="text" class="form-control js_digit-only js_auto-va-output" data-auto-va-id="user_id" name="va_number">
        <div class="form-text">
          {__("Assign this member a unique virtual account number")}
        </div>
      </div>
    </div>

    <!-- hidden -->
    <input type="hidden" name="org_username" value="{$username}">
    <!-- hidden -->

    <!-- success -->
    <div class="alert alert-success mb0 mt20 x-hidden"></div>
    <!-- success -->

    <!-- error -->
    <div class="alert alert-danger mb0 mt20 x-hidden"></div>
    <!-- error -->

    <div class="card-footer-fake text-end">
      <button type="submit" class="btn btn-primary">{__("Add Member")}</button>
    </div>
  </form>
</div>

{elseif $sub_view == "edit"}

<div class="card-body">
  <div class="row">
    <div class="col-12 col-md-2 text-center mb20">
      <img class="img-fluid img-thumbnail rounded-circle" src="{$data['user_picture']}">
    </div>
    <div class="col-12 col-md-10 mb20">
      <ul class="list-group">
        <li class="list-group-item">
          <span class="float-end badge badge-lg rounded-pill bg-secondary">{$data['id']}</span>
          {__("Member ID")}
        </li>
        <li class="list-group-item">
          <span class="float-end badge badge-lg rounded-pill bg-secondary">{$data['user_id']}</span>
          {__("User ID")}
        </li>
        <li class="list-group-item">
          <span class="float-end badge badge-lg rounded-pill bg-secondary">{$data['va_number']|format_va_number}</span>
          {__("Virtual Account")}
        </li>
      </ul>
    </div>
  </div>


  <!-- tabs content -->
  <div class="tab-content">
    <form class="js_ajax-forms" data-url="organizations/members.php?do=edit">
      <div class="row">
        <div class="form-group col-12">
          <label class="form-label" for="va_number">{__("VA Number")}</label>
          <input type="text" class="form-control js_digit-only js_auto-va-output" value="{$data['va_number']}" name="va_number">
          <div class="form-text">
            {__("Assign this member a unique virtual account number")}
          </div>
        </div>
      </div>

      <div class="row">
        <div class="form-group">
          <label class="form-label">{__("Role")}</label>
          <select class="form-select" name="role">
            <option value="none">{__("Select Role")}</option>
            <option {if $data['role'] == "admin"}selected{/if} value="admin">{__("Admin")}</option>
            <option {if $data['role'] == "staff"}selected{/if} value="staff">{__("Staff")}</option>
            <option {if $data['role'] == "account"}selected{/if} value="account">{__("Account")}</option>
            <option {if $data['role'] == "sub-account"}selected{/if} value="sub-account">{__("Sub-Account")}</option>
          </select>
        </div>
      </div>

      <!-- hidden -->
      <input type="hidden" name="org_username" value="{$username}">
      <input type="hidden" name="member_id" value="{$id}">
      <!-- hidden -->

      <!-- success -->
      <div class="alert alert-success mb0 mt20 x-hidden"></div>
      <!-- success -->

      <!-- error -->
      <div class="alert alert-danger mb0 mt20 x-hidden"></div>
      <!-- error -->

      <div class="card-footer-fake text-end">
        <button type="button" class="btn btn-danger js_admin-deleter" data-handle="user" data-id="{$data['user_id']}" data-redirect="{$system['system_url']}/{$control_panel['url']}/users">
          <i class="fa fa-trash-alt mr5"></i>{__("Delete Member")}
        </button>
        <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
      </div>
    </form>
  </div>
</div>
<!-- tabs content -->
</div>

{/if}
