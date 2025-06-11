<div class="card">
  <div class="card-header with-icon">
    {if $sub_view == ""}
      <div class="float-end">
        <a href="{$system['system_url']}/{$control_panel['url']}/provinces/add" class="btn btn-md btn-primary">
          <i class="fa fa-plus mr5"></i>{__("Add New Provinces")}
        </a>
      </div>
    {elseif $sub_view == "add" || $sub_view == "edit"}
      <div class="float-end">
        <a href="{$system['system_url']}/{$control_panel['url']}/provinces" class="btn btn-md btn-light">
          <i class="fa fa-arrow-circle-left mr5"></i>{__("Go Back")}
        </a>
      </div>
    {/if}
    <i class="fa fa-globe mr10"></i>{__("Provinces")}
    {if $sub_view == "edit"} &rsaquo; {$data['province_name']}{/if}
    {if $sub_view == "add"} &rsaquo; {__("Add New Provinces")}{/if}
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
              <th>{__("Country")}</th>
              <th>{__("Actions")}</th>
            </tr>
          </thead>
          <tbody>
            {foreach $rows as $row}
              <tr>
                <td>{$row['province_id']}</td>
                <td>
                  <a href="{$system['system_url']}/{$control_panel['url']}/provinces/edit/{$row['province_id']}">
                    {$row['province_name']}
                  </a>
                </td>
                <td>{$row['province_alt_name']}</td>
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
                  <a href="{$system['system_url']}/{$control_panel['url']}/countries/edit/{$row['country_id']}">
                    {$row['country_name']}
                  </a>
                </td>
                <td>
                  <a data-bs-toggle="tooltip" title='{__("Edit")}' href="{$system['system_url']}/{$control_panel['url']}/provinces/edit/{$row['province_id']}" class="btn btn-sm btn-icon btn-rounded btn-primary">
                    <i class="fa fa-pencil-alt"></i>
                  </a>
                  <button data-bs-toggle="tooltip" title='{__("Delete")}' class="btn btn-sm btn-icon btn-rounded btn-danger js_admin-deleter" data-handle="province" data-id="{$row['province_id']}">
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

    <form class="js_ajax-forms" data-url="admin/provinces.php?do=edit&id={$data['province_id']}">
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
              {__("Make it the default province of the site")}
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
            {__("Province Name")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="province_name" value="{$data['province_name']}">
          </div>
        </div>

        <div class="row form-group">
          <label class="col-md-3 form-label">
            {__("Province Alternative Name")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="province_alt_name" value="{$data['province_alt_name']}">
          </div>
        </div>

        <div class="row form-group">
          <label class="col-md-3 form-label">
            {__("Country")}
          </label>
          <div class="col-md-9">
            <div class="combobox-container w-100" data-default="{$data['country_id']}" data-options="#country-combobox" data-hidden="#country">
              <input type="text" id="_country" class="combobox form-control" placeholder="{__('Select Country')}" autocomplete="off" spellcheck="false">
              <div id="country-combobox" class="combobox-options">
                {foreach $country_data as $country}
                <div class="combobox-option" data-value="{$country['country_id']}">{$country['country_name']}</div>
                {/foreach}
              </div>
              <input type="hidden" id="country" name="country_id">
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

    <form class="js_ajax-forms" data-url="admin/provinces.php?do=add">
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
              {__("Make it the default provinces of the site")}
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
            {__("Province Name")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="province_name">
          </div>
        </div>

        <div class="row form-group">
          <label class="col-md-3 form-label">
            {__("Province Alt Name")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="province_alt_name">
          </div>
        </div>

        <div class="row form-group">
          <label class="col-md-3 form-label">
            {__("Country")}
          </label>
          <div class="col-md-9">
            <div class="combobox-container w-100" data-default="{$data['country_id']}" data-options="#country-combobox" data-hidden="#country">
              <input type="text" id="_country" class="combobox form-control" placeholder="{__('Select Country')}" autocomplete="off" spellcheck="false">
              <div id="country-combobox" class="combobox-options">
                {foreach $country_data as $country}
                <div class="combobox-option" data-value="{$country['country_id']}">{$country['country_name']}</div>
                {/foreach}
              </div>
              <input type="hidden" id="country" name="country_id">
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
