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
                {include file='__svg_icons.tpl' icon="user_information" class="main-icon mr10" width="24px" height="24px"}
                {__("Me")}
              </a>
            </li>

            <li {if ($user->org_is_owner($organization['id']) && $view == "") || $view == "dashboard"}class="active" {/if}>
              <a
                {if $user->org_is_owner($organization['id'])}href="{$org_url}/"{else}href="{$org_url}/dashboard"{/if}
              >
                {include file='__svg_icons.tpl' icon="notifications" class="main-icon mr10" width="24px" height="24px"}
                {__("Dashboard")}
              </a>
            </li>

            <div class="divider mtb5"></div>

            <li {if $view == "members"}class="active" {/if}>
              <a href="{$org_url}/members">
                <i class="fa fa-users fa-lg fa-fw mr10" style="color: #5e72e4"></i>{__("Members")}
              </a>
            </li>

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
