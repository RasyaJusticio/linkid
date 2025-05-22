<div class="card">
  <div class="card-header with-icon">
    {if $sub_view == ""}
      <div class="float-end">
        <a href="{$system['system_url']}/{$control_panel['url']}/timezones/add" class="btn btn-md btn-primary">
          <i class="fa fa-plus mr5"></i>{__("Add New Timezones")}
        </a>
      </div>
    {elseif $sub_view == "add" || $sub_view == "edit"}
      <div class="float-end">
        <a href="{$system['system_url']}/{$control_panel['url']}/timezones" class="btn btn-md btn-light">
          <i class="fa fa-arrow-circle-left mr5"></i>{__("Go Back")}
        </a>
      </div>
    {/if}
    <i class="fa fa-globe mr10"></i>{__("Timezones")}
    {if $sub_view == "edit"} &rsaquo; {$data['time_zone_name']}{/if}
    {if $sub_view == "add"} &rsaquo; {__("Add New Timezone")}{/if}
  </div>

  {if $sub_view == ""}

    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover js_dataTable">
          <thead>
            <tr>
              <th>{__("ID")}</th>
              <th>{__("Title")}</th>
              <th>{__("UTC Offset")}</th>
              <th>{__("Actions")}</th>
            </tr>
          </thead>
          <tbody>
            {foreach $rows as $row}
              <tr>
                <td>{$row['time_zone_id']}</td>
                <td>
                  <a href="{$system['system_url']}/{$control_panel['url']}/timezones/edit/{$row['time_zone_id']}">
                    {$row['time_zone_name']}
                  </a>
                </td>
                <td>
                    {$row['utc_offset']}
                </td>
                <td>
                  <a data-bs-toggle="tooltip" title='{__("Edit")}' href="{$system['system_url']}/{$control_panel['url']}/timezones/edit/{$row['time_zone_id']}" class="btn btn-sm btn-icon btn-rounded btn-primary">
                    <i class="fa fa-pencil-alt"></i>
                  </a>
                  <button data-bs-toggle="tooltip" title='{__("Delete")}' class="btn btn-sm btn-icon btn-rounded btn-danger js_admin-deleter" data-handle="timezone" data-id="{$row['time_zone_id']}">
                    <i class="fa fa-trash-alt"></i>
                  </button>
                </td>
              </tr>
            {/foreach}
          </tbody>
        </table>
      </div>
    </div>

  {elseif $sub_view == "edit"}

    <form class="js_ajax-forms" data-url="admin/timezones.php?do=edit&id={$data['time_zone_id']}">
      <div class="card-body">
        <div class="row form-group">
          <label class="col-md-3 form-label">
            {__("Timezone Name")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="time_zone_name" value="{$data['time_zone_name']}">
          </div>
        </div>

        <div class="row form-group">
          <label class="col-md-3 form-label">
            {__("UTC Offset")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="utc_offset" value="{$data['utc_offset']}" type="number">
            <div class="form-text">
              {__("UTC Offset, for example: 7.00, -7.00, 12.30")}
            </div>
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

  {elseif $sub_view == "add"}

    <form class="js_ajax-forms" data-url="admin/timezones.php?do=add">
      <div class="card-body">
        <div class="row form-group">
          <label class="col-md-3 form-label">
            {__("Timezone Name")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="time_zone_name">
          </div>
        </div>

        <div class="row form-group">
          <label class="col-md-3 form-label">
            {__("UTC Offset")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="utc_offset" type="number">
            <div class="form-text">
              {__("UTC Offset, for example: 7.00, -7.00, 12.30")}
            </div>
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
