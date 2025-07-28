<div class="card-header with-icon wallet-header">
  <div class="header-title">
    <i class="fa fa-dollar fa-lg fa-fw mr10"></i>{__("All Transactions")}
  </div>
</div>
<div class="card-body page-content">
    <!-- wallet transactions -->
    <div class="col-12 mt20">
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
                <span class="badge rounded-pill badge-lg bg-success mr10">{__("From")}</span>
                {if $transaction['node_type'] == "member"}
                <a target="_blank" href="{$org_url}/members/find?query={$transaction['from_user_name']}">
                  <img class="tbl-image" src="{$transaction['from_user_picture']}" style="float: none;">
                  {if $system['show_usernames_enabled']}
                  {$transaction['from_user_name']}
                  {else}
                  {$transaction['from_user_firstname']} {$transaction['from_user_lastname']}
                  {/if}
                </a>
                {/if}
                <span class="badge rounded-pill badge-lg bg-danger ml10 mr10">{__("To")}</span>
                {if $transaction['node_type'] == "member"}
                <a target="_blank" href="{$org_url}/members/find?query={$transaction['to_user_name']}">
                  <img class="tbl-image" src="{$transaction['to_user_picture']}" style="float: none;">
                  {if $system['show_usernames_enabled']}
                  {$transaction['to_user_name']}
                  {else}
                  {$transaction['to_user_firstname']} {$transaction['to_user_lastname']}
                  {/if}
                </a>
                {/if}
              </td>
              <td>
                {if $transaction['type'] == "out"}
                <strong class="text-danger">{if $transaction['amount']}{print_money($transaction['amount']|format_number)}{/if}</strong>
                {else}
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
    <!-- wallet transactions -->
  </div>
</div>
