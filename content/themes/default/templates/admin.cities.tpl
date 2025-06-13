<div class="card">
  <div class="card-header with-icon">
    {if $sub_view == ""}
      <div class="float-end">
        <a href="{$system['system_url']}/{$control_panel['url']}/cities/add" class="btn btn-md btn-primary">
          <i class="fa fa-plus mr5"></i>{__("Add New Cities")}
        </a>
      </div>
    {elseif $sub_view == "add" || $sub_view == "edit"}
      <div class="float-end">
        <a href="{$system['system_url']}/{$control_panel['url']}/cities" class="btn btn-md btn-light">
          <i class="fa fa-arrow-circle-left mr5"></i>{__("Go Back")}
        </a>
      </div>
    {/if}
    <i class="fa fa-globe mr10"></i>{__("Cities")}
    {if $sub_view == "edit"} &rsaquo; {$data['city_name']}{/if}
    {if $sub_view == "add"} &rsaquo; {__("Add New Cities")}{/if}
  </div>

  {if $sub_view == ""}

    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover js_dataTable">
          <thead>
            <tr>
              <th>{__("ID")}</th>
              <th>{__("Name")}</th>
              <th>{__("Alt Name")}</th>
              <th>{__("Default")}</th>
              <th>{__("Enabled")}</th>
              <th>{__("Province")}</th>
              <th>{__("Actions")}</th>
            </tr>
          </thead>
          <tbody>
            {foreach $rows as $row}
              <tr>
                <td>{$row['city_id']}</td>
                <td>
                  <a href="{$system['system_url']}/{$control_panel['url']}/cities/edit/{$row['city_id']}">
                    {$row['city_name']}
                  </a>
                </td>
                <td>{$row['city_alt_name']}</td>
                <td>
                  {if $row['default']}
                    <span class="badge rounded-pill badge-lg bg-success">{__("Yes")}</span>
                  {else}
                    <span class="badge rounded-pill badge-lg bg-danger">{__("No")}</span>
                  {/if}
                </td>
                <td>
                  {if $row['enabled']}
                    <span class="badge rounded-pill badge-lg bg-success">{__("Yes")}</span>
                  {else}
                    <span class="badge rounded-pill badge-lg bg-danger">{__("No")}</span>
                  {/if}
                </td>
                <td>
                  <a href="{$system['system_url']}/{$control_panel['url']}/provinces/edit/{$row['province_id']}">
                    {$row['province_name']}
                  </a>
                </td>
                <td>
                  <a data-bs-toggle="tooltip" title='{__("Edit")}' href="{$system['system_url']}/{$control_panel['url']}/cities/edit/{$row['city_id']}" class="btn btn-sm btn-icon btn-rounded btn-primary">
                    <i class="fa fa-pencil-alt"></i>
                  </a>
                  <button data-bs-toggle="tooltip" title='{__("Delete")}' class="btn btn-sm btn-icon btn-rounded btn-danger js_admin-deleter" data-handle="city" data-id="{$row['city_id']}">
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

    <form class="js_ajax-forms" data-url="admin/cities.php?do=edit&id={$data['city_id']}">
      <div class="card-body">
        <div class="row form-group">
          <label class="col-md-3 form-label">
            {__("Default")}
          </label>
          <div class="col-md-9">
            <label class="switch" for="default">
              <input type="checkbox" name="default" id="default" {if $data['default']}checked{/if}>
              <span class="slider round"></span>
            </label>
            <div class="form-text">
              {__("Make it the default city of the site")}
            </div>
          </div>
        </div>

        <div class="row form-group">
          <label class="col-md-3 form-label">
            {__("Enabled")}
          </label>
          <div class="col-md-9">
            <label class="switch" for="enabled">
              <input type="checkbox" name="enabled" id="enabled" {if $data['enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
            <div class="form-text">
              {__("Make it enbaled so the user can select it")}
            </div>
          </div>
        </div>

        <div class="row form-group">
          <label class="col-md-3 form-label">
            {__("City Name")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="city_name" value="{$data['city_name']}">
          </div>
        </div>

        <div class="row form-group">
          <label class="col-md-3 form-label">
            {__("City Alt Name")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="city_alt_name" value="{$data['city_alt_name']}">
          </div>
        </div>

        <div class="row form-group">
          <label class="col-md-3 form-label">
            {__("Province")}
          </label>
          <div class="col-md-9">
            <div class="combobox-container w-100" data-default="{$data['province_id']}" data-options="#province-combobox" data-hidden="#province">
              <input type="text" id="_province" class="combobox form-control" placeholder="{__('Select Province')}" autocomplete="off" spellcheck="false">
              <div id="province-combobox" class="combobox-options">
                {foreach $provinces as $province}
                <div class="combobox-option" data-value="{$province['province_id']}">{$province['province_name']}</div>
                {/foreach}
              </div>
              <input type="hidden" id="province" name="province_id">
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

    <form class="js_ajax-forms" data-url="admin/cities.php?do=add">
      <div class="card-body">
        <div class="row form-group">
          <label class="col-md-3 form-label">
            {__("Default")}
          </label>
          <div class="col-md-9">
            <label class="switch" for="default">
              <input type="checkbox" name="default" id="default">
              <span class="slider round"></span>
            </label>
            <div class="form-text">
              {__("Make it the default city of the site")}
            </div>
          </div>
        </div>

        <div class="row form-group">
          <label class="col-md-3 form-label">
            {__("Enabled")}
          </label>
          <div class="col-md-9">
            <label class="switch" for="enabled">
              <input type="checkbox" name="enabled" id="enabled">
              <span class="slider round"></span>
            </label>
            <div class="form-text">
              {__("Make it enbaled so the user can select it")}
            </div>
          </div>
        </div>

        <div class="row form-group">
          <label class="col-md-3 form-label">
            {__("City Name")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="city_name">
          </div>
        </div>

        <div class="row form-group">
          <label class="col-md-3 form-label">
            {__("City Alt Name")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="city_alt_name">
          </div>
        </div>

        <div class="row form-group">
          <label class="col-md-3 form-label">
            {__("Province")}
          </label>
          <div class="col-md-9">
            <div class="combobox-container w-100" data-default="{$data['province_id']}" data-options="#province-combobox" data-hidden="#province">
              <input type="text" id="_province" class="combobox form-control" placeholder="{__('Select Province')}" autocomplete="off" spellcheck="false">
              <div id="province-combobox" class="combobox-options">
                {foreach $provinces as $province}
                <div class="combobox-option" data-value="{$province['province_id']}">{$province['province_name']}</div>
                {/foreach}
              </div>
              <input type="hidden" id="province" name="province_id">
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
