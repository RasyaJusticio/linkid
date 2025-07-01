{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page content -->
<div class="{if $system['fluid_design']}container-fluid{else}container{/if} mt20 sg-offcanvas {if $view == "" && $show_categories}active{/if}" {if $view == ""}style="min-height: 100%;" {/if}>
  <div class="row">

    <!-- left panel -->
    <div class="col-md-4 col-lg-3 sg-offcanvas-sidebar">
      <div class="card">
        <div class="card-body with-nav">
          <ul class="side-nav">
            <li {if $view == ""}class="active" {/if}>
              <a href="{$system['system_url']}/organizations">
                {include file='__svg_icons.tpl' icon="settings" class="main-icon mr10" width="24px" height="24px"}
                {__("Dashboard")}
              </a>
            </li>
            <li {if $view == "informations"}class="active" {/if}>
              <a href="{$system['system_url']}/organizations/informations">
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
                    <a href="{$system['system_url']}/organizations/sub-accounts">
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
      <div class="card">
        {if $view == ""}
          {include file='settings.account.tpl'}
        {elseif $view == "informations"}
          {include file='organizations.informations.tpl'}
        {elseif $view == "sub-accounts"}
          {include file='organizations.sub-accounts.tpl'}
        {elseif $view == "apply"}
          {include file='organizations.apply.tpl'}
        {/if}
      </div>
    </div>
    <!-- right panel -->

  </div>
</div>
<!-- page content -->

{include file='_footer.tpl'}
