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
          {include file='__feeds_group.tpl' _tpl='box'}
          {/foreach}
        </ul>

        <!-- see-more -->
        {if count($groups) >= $system['groups_results']}
        <div class="alert alert-post see-more js_see-more" data-get="{$get}" {if $view == "category"}data-id="{$current_category['category_id']}" {/if} {if $view == "joined" || $view == "manage"}data-uid="{$user->_data['user_id']}" {/if} data-country="{if $selected_country}{$selected_country['country_id']}{else}all{/if}">
          <span>{__("See More")}</span>
          <div class="loader loader_small x-hidden"></div>
        </div>
        {/if}
        <!-- see-more -->
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

