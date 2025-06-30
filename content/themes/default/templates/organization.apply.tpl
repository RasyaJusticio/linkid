{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page header -->
<div class="page-header">
  <img class="floating-img d-none d-md-block" src="{$system['system_url']}/content/themes/{$system['theme']}/images/headers/undraw_business-deal_nx2n.svg">
  <div class="circle-2"></div>
  <div class="circle-3"></div>
  <div class="inner">
    <h2>{__("Apply for Organization")}</h2>
    <p class="text-xlg">{__("Fill in all your organizations information to become an organization account")}</p>
  </div>
</div>
<!-- page header -->

<!-- page content -->
<div class="{if $system['fluid_design']}container-fluid{else}container{/if} sg-offcanvas" style="margin-top: -25px;">
  <div class="row">

    <!-- side panel -->
    <div class="col-12 d-block d-md-none sg-offcanvas-sidebar">
      {include file='_sidebar.tpl'}
    </div>
    <!-- side panel -->

    <!-- content panel -->
    <div class="col-12 sg-offcanvas-mainbar">

      <!-- tabs -->
      <div class="position-relative">
        <div class="content-tabs rounded-sm shadow-sm clearfix">
          <ul>
            <li class="active">
              <a href="{$system['system_url']}/organizations/apply">
                {include file='__svg_icons.tpl' icon="jobs" class="main-icon mr10" width="24px" height="24px"}
                {__("Apply")}
              </a>
            </li>
          </ul>
        </div>
      </div>
      <!-- tabs -->

      <!-- new campaign -->
      <div class="card mt20">
        <div class="card-header with-icon">
          {__("Apply")}
        </div>
        <form class="js_ajax-forms" data-url="organizations/apply.php">
          <div class="card-body">
            <div class="row">
              <div class="col-12">

                <div class="row">
                  <div class="col-sm-6">
                    <div class="form-group">
                      <label class="form-label" for="name">{__("Organization Name")}</label>
                      <input type="text" class="form-control slugify-source" name="name" id="name" data-slug-id="organization">
                      <div class="form-text">
                        {__("Fill the of name your organization")}
                      </div>
                    </div>
                  </div>

                  <div class="col-sm-6">
                    <div class="form-group">
                      <label class="form-label" for="slug">{__("Organization Username")}</label>
                      <input type="text" class="form-control slugify-output" name="slug" id="slug" data-slug-id="organization">
                      <div class="form-text">
                        {__("Can only contain alphanumeric characters (A–Z, 0–9), periods ('.'), and hyphens ('-')")}
                      </div>
                    </div>
                  </div>
                </div>

              </div>
            </div>

            <!-- error -->
            <div class="alert alert-danger mt15 mb0 x-hidden"></div>
            <!-- error -->
          </div>
          <div class="card-footer text-end">
            <button type="submit" class="btn btn-primary">
              {__("Apply")}
            </button>
          </div>
        </form>
      </div>
      <!-- new campaign -->
    </div>
    <!-- content panel -->

  </div>
</div>
<!-- page content -->

{include file='_footer.tpl'}
