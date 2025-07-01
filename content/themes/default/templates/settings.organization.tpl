  <div class="card-header with-icon">
    {include file='__svg_icons.tpl' icon="work" class="main-icon mr15" width="24px" height="24px"}{__("Organization Info")}
  </div>
  <form class="js_ajax-forms" data-url="users/settings.php?edit=org_info">
    <div class="card-body">
      <div class="row">
        <div class="col-12">

          <div class="row">
            <div class="col-sm-6">
              <div class="form-group">
                <label class="form-label" for="name">{__("Organization Name")}</label>
                <input type="text" class="form-control slugify-source" name="name" id="name" value="{$org['name']}" data-slug-id="organization">
                <div class="form-text">
                  {__("Fill the of name your organization")}
                </div>
              </div>
            </div>

            <div class="col-sm-6">
              <div class="form-group">
                <label class="form-label" for="slug">{__("Organization Username")}</label>
                <input type="text" class="form-control slugify-output" name="slug" id="slug" value="{$org['slug']}" data-slug-id="organization">
                <div class="form-text">
                  {__("Can only contain alphanumeric characters (A–Z, 0–9), periods ('.'), and hyphens ('-')")}
                </div>
              </div>
            </div>
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
