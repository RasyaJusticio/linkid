{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page content -->
<div class="{if $system['fluid_design']}container-fluid{else}container{/if} sg-offcanvas">
  <div class="row">

    <!-- side panel -->
    <div class="col-12 d-block d-md-none sg-offcanvas-sidebar">
      {include file='_sidebar.tpl'}
    </div>
    <!-- side panel -->

    <!-- content panel -->
    <div class="col-12 sg-offcanvas-mainbar">
        <div class="card mt20">
          <div class="card-header with-icon jsc_top-bar">
            {include file='__svg_icons.tpl' icon="wallet_2" class="mr10" width="24px" height="24px"}
            {__("Transfer History")}
          </div>
          <div class="card-body page-content">
              <div class="col-12">
                {if $transactions}
                  <div class="table-responsive">
                    <table class="table table-striped table-bordered table-hover js_walletHistoryTable">
                      <thead>
                        <tr>
                          <th style="display: none;">{__("ID")}</th>
                          <th>{__("From / To")}</th>
                          <th>{__("Amount")}</th>
                          <th>{__("Time")}</th>
                        </tr>
                      </thead>
                      <tbody>
                        {foreach $transactions as $transaction}
                          <tr>
                            <td style="display: none;">{$transaction['transaction_id']}</td>
                            <td>
                              {if $transaction['type'] == "out"}
                                <span class="badge rounded-pill badge-lg bg-danger mr10">{__("To")}</span>
                              {else}
                                <span class="badge rounded-pill badge-lg bg-success mr10">{__("From")}</span>
                              {/if}
                              <a target="_blank" href="{$system['system_url']}/{$transaction['user_name']}">
                                <img class="tbl-image" src="{$transaction['user_picture']}" style="float: none;">
                                {if $system['show_usernames_enabled']}
                                  {$transaction['user_name']}
                                {else}
                                  {$transaction['user_firstname']} {$transaction['user_lastname']}
                                {/if}
                              </a>
                            </td>
                            <td>
                              {if $transaction['type'] == "out"}
                                <span class="badge rounded-pill badge-lg bg-danger mr5"><i class="far fa-arrow-alt-circle-down"></i></span>
                                <strong class="text-danger">{if $transaction['amount']}{print_money($transaction['amount']|format_number)}{/if}</strong>
                              {else}
                                <span class="badge rounded-pill badge-lg bg-success mr5"><i class="far fa-arrow-alt-circle-up"></i></span>
                                <strong class="text-success">{if $transaction['amount']}{print_money($transaction['amount']|format_number)}{/if}</strong>
                              {/if}
                            </td>
                            <td><span class="js_moment" data-time="{$transaction['date']}">{$transaction['date']}</span></td>
                          </tr>
                        {/foreach}
                      </tbody>
                    </table>
                  </div>
                {else}
                  {include file='_no_transactions.tpl'}
                {/if}
              </div>
            </div>
          </div>
        </div>
    </div>
    <!-- content panel -->

  </div>
</div>
<!-- page content -->

{include file='_footer.tpl'}
