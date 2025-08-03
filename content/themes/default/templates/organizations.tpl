{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page header -->
<div class="page-header">
  <img class="floating-img d-none d-md-block" src="{$system['system_url']}/content/themes/{$system['theme']}/images/headers/undraw_team-collaboration_phnf.svg">
  <div class="circle-2"></div>
  <div class="circle-3"></div>
  <div class="{if $system['fluid_design']}container-fluid{else}container{/if}">
    {if $view == "apply"}
    <h2>{__("Apply as an Organization")}</h2>
    <p class="text-xlg">{__("Apply to become an organization account")}</p>
    {else}
    <h2>{__("Organizations")}</h2>
    <p class="text-xlg">{__("List of joined organizations")}</p>
    {/if}
  </div>
</div>
<!-- page header -->

{if $view == ""}
<!-- page content -->
<div class="{if $system['fluid_design']}container-fluid{else}container{/if} sg-offcanvas" style="margin-top: -25px;">

  <div class="position-relative">
    <!-- tabs -->
    <div class="content-tabs rounded-sm shadow-sm clearfix">
      <ul>
        <li {if $view == ""}class="active" {/if}>
          <a href="{$system['system_url']}/groups">{__("Joined Organizations")}</a>
        </li>
      </ul>
      {if !$user->is_org_user()}
      <div class="mt10 float-end">
        <a class="btn btn-md btn-primary d-none d-lg-block" href="{$system['system_url']}/organizations/apply">
          <i class="fa fa-suitcase mr5"></i>{__("Become an Organization")}
        </a>
        <button class="btn btn-sm btn-icon btn-primary d-block d-lg-none" href="{$system['system_url']}/organizations/apply">
          <i class="fa fa-suitcase"></i>
        </button>
      </div>
      {/if}
    </div>
    <!-- tabs -->
  </div>

  <div class="row">
    <!-- content panel -->
    <div class="col-12">

      <!-- content -->
      <div>
        {if $organizations}
        <ul class="row">
          {foreach $organizations as $_organization}
          <li class="col-md-6 col-lg-3">
            <div class="ui-box">
              <div class="img">
                <a href="{$system['system_url']}/org/{$_organization['slug']}">
                  <img alt="{$_organization['name']}" src="{$system['system_uploads']}/{$_organization['picture']}" />
                </a>
              </div>

              <div class="mt10">
                <a class="h6" href="{$system['system_url']}/org/{$_organization['slug']}">{$_organization['name']|truncate:30}</a>
                <div>{$_organization['connection']|format_org_role}</div>
              </div>
              <div class="mt10">
                <button type="button" class="btn btn-sm btn-success js_leave-org-plan" data-id="{$_group['id']}">
                  <i class="fa fa-check mr5"></i> {__("Joined")}
                </button>
              </div>
            </div>
          </li>
          {/foreach}
        </ul>
        {else}
        {include file='_no_data.tpl'}
        {/if}
      </div>
      <!-- content -->

    </div>
    <!-- content panel -->

  </div>
</div>
<!-- page content -->

{include file='_footer.tpl'}
{else}
{include file='organizations.apply.tpl'}
{/if}

