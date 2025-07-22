<div class="card-header with-icon wallet-header">
  <div class="header-title">
    <i class="fa fa-user fa-lg fa-fw mr10"></i>{__("Me")}
  </div>

  <div class="qr-btns-container">
    <button class="btn btn-outline-primary" data-toggle="modal" data-url="#wallet-qr-scan-pay">
      {include file='__svg_icons.tpl' icon="money_send" width="24px" height="24px"}
      {__("QR Pay")}
    </button>
    <button class="btn btn-outline-primary" data-toggle="modal" data-url="#wallet-qr-scan-receive">
      {include file='__svg_icons.tpl' icon="money_receive" width="24px" height="24px"}
      {__("QR Receive")}
    </button>
    <button class="btn btn-outline-primary" data-toggle="modal" data-url="#wallet-qr" data-options='{ "qrcode_uri": "$qrcode_uri" }'>
      {include file='__svg_icons.tpl' icon="qr_code" width="24px" height="24px"}
      {__("My QR")}
    </button>
  </div>
</div>
<div class="card-body page-content">
  <div class="row">
    <!-- credit -->
    <div class="col-md-5">
      <div class="section-title d-none d-md-block mb20">
        {__("Your Balance")}
      </div>
      <div class="stat-panel bg-gradient-info">
        <div class="stat-cell small">
          <i class="fa fa-money-bill-alt bg-icon"></i>
          <div class="h3 mtb10">
            {print_money($data['balance']|format_number)}
          </div>
          <div class="h6">
            {$data['va_number']|format_va_number}
          </div>
        </div>
      </div>
    </div>
    <!-- credit -->

    <!-- send & recieve money -->
    <div class="col-md-7 send-receive-money">
      <div class="section-title mb20 d-none d-md-block">
        {__("Send & Recieve Money")}
      </div>
      <div class="d-grid">
        {if $system['wallet_transfer_enabled']}
        <button class="btn btn-outline-primary" data-toggle="modal" data-url="#wallet-transfer">
          {include file='__svg_icons.tpl' icon="money_send" class="mr10" width="24px" height="24px"}
          {__("Send Money")}
        </button>
        {/if}
      </div>

      <div class="d-grid">
        {if $system['wallet_transfer_enabled']}
        <button class="btn btn-outline-primary" data-toggle="modal" data-url="#wallet-receive">
          {include file='__svg_icons.tpl' icon="money_receive" class="mr10" width="24px" height="24px"}
          {__("Receive Money")}
        </button>
        {/if}
      </div>
    </div>
    <!-- send & recieve money -->

    <!-- wallet transactions -->
    <div class="col-12 mt20">
      <div class="section-title mt10 mb20">
        {__("Account Transactions")}
      </div>
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
                {if $transaction['node_type'] == "user" || $transaction['node_type'] == "tip"}
                {if $transaction['node_type'] == "tip"}
                <span class="badge rounded-pill badge-lg bg-secondary mr10">{__("Tip")}</span>
                {/if}
                <a target="_blank" href="{$system['system_url']}/{$transaction['user_name']}">
                  <img class="tbl-image" src="{$transaction['user_picture']}" style="float: none;">
                  {if $system['show_usernames_enabled']}
                  {$transaction['user_name']}
                  {else}
                  {$transaction['user_firstname']} {$transaction['user_lastname']}
                  {/if}
                </a>
                {elseif $transaction['node_type'] == "recharge"}
                {__("Top Up Credit")}
                {elseif $transaction['node_type'] == "withdraw_wallet"}
                {__("Wallet Withdrawal")}
                {elseif $transaction['node_type'] == "withdraw_affiliates"}
                {__("Affiliates Credit")}
                {elseif $transaction['node_type'] == "withdraw_points"}
                {__("Points Credit")}
                {elseif $transaction['node_type'] == "withdraw_market"}
                {__("Market Credit")}
                {elseif $transaction['node_type'] == "withdraw_funding"}
                {__("Funding Credit")}
                {elseif $transaction['node_type'] == "withdraw_monetization"}
                {__("Monetization Credit")}
                {elseif $transaction['node_type'] == "package_payment"}
                {__("Buy Pro Package")}
                {elseif $transaction['node_type'] == "subscribe_profile" || $transaction['node_type'] == "subscribe_user"}
                {__("Subscribe to Profile")}
                {elseif $transaction['node_type'] == "subscribe_page"}
                {__("Subscribe to Page")}
                {elseif $transaction['node_type'] == "subscribe_group"}
                {__("Subscribe to Group")}
                {elseif $transaction['node_type'] == "paid_post"}
                {__("Paid Post")}
                {elseif $transaction['node_type'] == "donate"}
                {__("Donate")}
                {elseif $transaction['node_type'] == "market" || $transaction['node_type'] == "market_payment"}
                {__("Market Purchase")}
                {elseif $transaction['node_type'] == "paid_chat_message"}
                {__("Paid Chat Message")}
                {elseif $transaction['node_type'] == "paid_call"}
                {__("Paid Call")}
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
