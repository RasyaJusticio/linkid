{include file='_head.tpl'}
{include file='_header.tpl'}

{if $org}
<!-- page content -->
<div class="{if $system['fluid_design']}container-fluid{else}container{/if} mt20 sg-offcanvas {if $view == "" && $show_categories}active{/if}" {if $view == ""}style="min-height: 100%;" {/if}>
  <div class="row">

    <!-- left panel -->
    <div class="col-md-4 col-lg-3 sg-offcanvas-sidebar">
      <div class="card">
        <div class="card-body with-nav">
          <ul class="side-nav">
            <li {if $view == ""}class="active" {/if}>
              <a href="{$system['system_url']}/organizations/{$username}">
                <i class="fa fa-tachometer-alt fa-lg fa-fw mr10" style="color: #5e72e4"></i>
                {__("Dashboard")}
              </a>
            </li>
            <li {if $view == "informations"}class="active" {/if}>
              <a href="{$system['system_url']}/organizations/{$username}/informations">
                {include file='__svg_icons.tpl' icon="company" class="main-icon no-fill mr10" width="24px" height="24px"}
                {__("Informations")}
              </a>
            </li>

            {assign var="is_accounts" value="{in_array($view, ['sub-accounts'])}"}
            <li {if $is_accounts}class="active" {/if}>
              <a href="#accounts" data-bs-toggle="collapse" {if $is_accounts}aria-expanded="true" {/if}>
                {include file='__svg_icons.tpl' icon="edit_profile" class="main-icon mr10" width="24px" height="24px"}
                {__("Accounts")}
              </a>
              <div class='collapse {if $is_accounts}show{/if}' id="accounts">
                <ul>
                  <li {if $view == "sub-accounts"}class="active" {/if}>
                    <a href="{$system['system_url']}/organizations/{$username}/sub-accounts">
                      {__("Sub-Accounts")}
                    </a>
                  </li>
                </ul>
              </div>
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
      {if $view == ""}
        {include file='organizations.dashboard.tpl'}
      {elseif $view == "informations"}
        {include file='organizations.informations.tpl'}
      {elseif $view == "sub-accounts"}
        {include file='organizations.sub-accounts.tpl'}
      {elseif $view == "apply"}
        {include file='organizations.apply.tpl'}
      {/if}
    </div>
    <!-- right panel -->

  </div>
</div>
<!-- page content -->

{else}
<!-- page header -->
<div class="page-header">
  <img class="floating-img d-none d-md-block" src="{$system['system_url']}/content/themes/{$system['theme']}/images/headers/undraw_community_re_cyrm.svg">
  <div class="circle-2"></div>
  <div class="circle-3"></div>
  <div class="{if $system['fluid_design']}container-fluid{else}container{/if}">
    <h2>{__("My Organizations")}</h2>
    <p class="text-xlg">{__($system['system_description_groups'])}</p>
    <div class="row mt20">
      <div class="col-sm-9 col-lg-6 mx-sm-auto">
        <form class="js_search-form" data-filter="groups">
          <div class="input-group">
            <input type="text" class="form-control" name="query" placeholder='{__("Search for groups")}'>
            <button type="submit" class="btn btn-light">{__("Search")}</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<!-- page header -->

<div class="{if $system['fluid_design']}container-fluid{else}container{/if} sg-offcanvas" style="margin-top: -25px;">

  <div class="position-relative">
    <!-- tabs -->
    <div class="content-tabs rounded-sm shadow-sm clearfix">
      <ul>
        <li {if $view == ""}class="active" {/if}>
          <a href="{$system['system_url']}/groups">{__("Discover")}</a>
        </li>
        {if $user->_logged_in}
          <li {if $view == "joined"}class="active" {/if}>
            <a href="{$system['system_url']}/groups/joined">{__("Joined Groups")}</a>
          </li>
          <li {if $view == "manage"}class="active" {/if}>
            <a href="{$system['system_url']}/groups/manage">{__("My Groups")}</a>
          </li>
        {/if}
      </ul>
      {if $user->_data['can_create_groups']}
        <div class="mt10 float-end">
          <button class="btn btn-md btn-primary d-none d-lg-block" data-toggle="modal" data-url="modules/add.php?type=group">
            <i class="fa fa-plus-circle mr5"></i>{__("Create Group")}
          </button>
          <button class="btn btn-sm btn-icon btn-primary d-block d-lg-none" data-toggle="modal" data-url="modules/add.php?type=group">
            <i class="fa fa-plus-circle"></i>
          </button>
        </div>
      {/if}
    </div>
    <!-- tabs -->
  </div>

  <div class="row">
    <!-- content panel -->
    <div class="{if $view == "" || $view == "category"} col-12 sg-offcanvas-mainbar{/if}">
      <!-- location filter -->
      {if $system['newsfeed_location_filter_enabled']}
        <div class="posts-filter">
          <span>{$view_title}</span>
          <div class="float-end">
            <a href="#" data-bs-toggle="dropdown" class="countries-filter">
              <i class="fa fa-globe fa-fw"></i>
              {if $selected_country}
                <span>{$selected_country['country_name']}</span>
              {else}
                <span>{__("All Countries")}</span>
              {/if}
            </a>
            <div class="dropdown-menu dropdown-menu-end countries-dropdown">
              <div class="js_scroller">
                <a class="dropdown-item" href="?country=all">
                  {__("All Countries")}
                </a>
                {foreach $countries as $country}
                  <a class="dropdown-item" href="?country={$country['country_name_native']}">
                    {$country['country_name']}
                  </a>
                {/foreach}
              </div>
            </div>
          </div>
        </div>
      {/if}
      <!-- location filter -->

      <!-- content -->
      <div>
        {if $groups}
          <ul class="row">
            {foreach $groups as $_group}
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

{/if}

{include file='_footer.tpl'}
