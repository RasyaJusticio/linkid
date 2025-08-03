<div class="card-header with-icon wallet-header">
  <div class="header-title">
    <i class="fa fa-cog fa-lg fa-fw mr10"></i>{__("Settings")}
  </div>
</div>
<form class="js_ajax-forms" data-url="organizations/settings.php?edit=organization-info">
  <div class="card-body">
    <div class="row">
      <div class="col-12">

        <div class="row">
          <div class="col-sm-6">
            <div class="form-group">
              <label class="form-label" for="name">{__("Organization Name")}</label>
              <input type="text" class="form-control slugify-source" name="name" id="name" value="{$organization['name']}" data-slug-id="organization">
              <div class="form-text">
                {__("Fill the name of your organization")}
              </div>
            </div>
          </div>

          <div class="col-sm-6">
            <div class="form-group">
              <label class="form-label" for="slug">{__("Organization Username")}</label>
              <input type="text" class="form-control slugify-output" name="slug" id="slug" value="{$organization['slug']}" data-slug-id="organization">
              <div class="form-text">
                {__("Can only contain alphanumeric characters (A–Z, 0–9), periods ('.'), and hyphens ('-')")}
              </div>
            </div>
          </div>


          <div class="form-group">
            <label class="form-label">{__("Organization Picture")}</label>
            <div class="x-image">
              <div class="x-image-loader">
                <div class="progress x-progress">
                  <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
              </div>
              <i class="fa fa-camera fa-lg js_x-uploader" data-handle="x-image"></i>
              <input type="hidden" class="js_x-image-input" name="picture" value="">
            </div>
          </div>

        </div>

      </div>
    </div>

    <!-- hidden -->
    <input type="hidden" name="org_id" value="{$organization['id']}">
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
