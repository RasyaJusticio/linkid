{include file='_head.tpl'}
{include file='_header.tpl'}

{assign var="org_url" value="{$system['system_url']}/org/{$organization['slug']}"}

<!-- page content -->
<div class="{if $system['fluid_design']}container-fluid{else}container{/if} mt20 sg-offcanvas {if $view == "" && $show_categories}active{/if}" {if $view == ""}style="min-height: 100%;" {/if}>
  <div class="row">

    <!-- left panel -->
    <div class="col-md-4 col-lg-3 sg-offcanvas-sidebar">
      <div class="card">
        <div class="card-body with-nav">
          <ul class="side-nav">
            <li {if $view == ""}class="active" {/if}>
              <a href="{$org_url}">
                <i class="fa fa-user fa-lg fa-fw mr10" style="color: #5e72e4"></i>{__("Me")}
              </a>
            </li>

            {if in_array($connection, ['owner', 'admin', 'staff'])}
              <li {if $view == "dashboard"}class="active" {/if}>
                <a href="{$org_url}/dashboard">
                  <i class="fa fa-tachometer-alt fa-lg fa-fw mr10" style="color: #5e72e4"></i>{__("Dashboard")}
                </a>
              </li>

              <div class="divider mtb5"></div>

              <li {if $view == "members"}class="active" {/if}>
                <a href="{$org_url}/members">
                  <i class="fa fa-users fa-lg fa-fw mr10" style="color: #5e72e4"></i>{__("Members")}
                </a>
              </li>
            {/if}

          </ul>
        </div>
      </div>
    </div>
    <!-- left panel -->

    <!-- right panel -->
    <div class="col-md-8 col-lg-9 sg-offcanvas-mainbar">
      <div class="mb10 pb10 border-bottom d-block d-md-none">
        <small class="text-link" data-bs-toggle="sg-offcanvas">
          <i class="fa-solid fa-chevron-left mr5"></i>{__("Back To Settings")}
        </small>
      </div>
      <div class="card">
        {if $view == ""}
        {include file='organization.me.tpl'}
        {elseif $view == "dashboard"}
        {include file='organization.dashboard.tpl'}
        {elseif $view == "members"}
        {include file='organization.members.tpl'}
        {/if}
      </div>
    </div>
    <!-- right panel -->

  </div>
</div>
<!-- page content -->

{include file='_footer.tpl'}
