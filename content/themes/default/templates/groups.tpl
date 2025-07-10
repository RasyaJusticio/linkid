{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page header -->
<div class="page-header">
  <img class="floating-img d-none d-md-block" src="{$system['system_url']}/content/themes/{$system['theme']}/images/headers/undraw_community_re_cyrm.svg">
  <div class="circle-2"></div>
  <div class="circle-3"></div>
  <div class="{if $system['fluid_design']}container-fluid{else}container{/if}">
    <h2>{__("Groups")}</h2>
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

<!-- page content -->
<div class="{if $system['fluid_design']}container-fluid{else}container{/if} sg-offcanvas" style="margin-top: -25px;">

  <div class="position-relative">
    <!-- tabs -->
    <div class="content-tabs rounded-sm shadow-sm clearfix">
      <ul>
        {if $user->_logged_in}
          <li {if $view == ""}class="active" {/if}>
            <a href="{$system['system_url']}/organizations">{__("My Organizations")}</a>
          </li>
          <li {if $view == "manage"}class="active" {/if}>
            <a href="{$system['system_url']}/organizations/invites">{__("Invites")}</a>
          </li>
        {/if}
      </ul>
    </div>
    <!-- tabs -->
  </div>

  <div class="row">

    <!-- content panel -->
    <div class="{if $view == "" || $view == "category"}col-md-8 col-lg-9 sg-offcanvas-mainbar{else}col-12 sg-offcanvas-mainbar{/if}">
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

{include file='_footer.tpl'}
