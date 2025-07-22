<div class="card-header with-icon wallet-header">
  <div class="header-title">
    {include file='__svg_icons.tpl' icon="wallet" class="main-icon mr10" width="24px" height="24px"}
    {__("Wallet")}
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
  {if $wallet_transfer_amount}
  <div class="alert alert-success mb20">
    <i class="fas fa-check-circle mr5"></i>
    {__("Your")} <span class="badge rounded-pill badge-lg bg-secondary">{print_money($wallet_transfer_amount|format_number)}</span> {__("transfer transaction successfuly sent")}
  </div>
  {/if}
  {if $wallet_receive_amount}
  <div class="alert alert-success mb20">
    <i class="fas fa-check-circle mr5"></i>
    {__("Your")} <span class="badge rounded-pill badge-lg bg-secondary">{print_money($wallet_receive_amount|format_number)}</span> {__("transfer transaction successfuly received")}
  </div>
  {/if}
  {if $wallet_replenish_amount}
  <div class="alert alert-success mb20">
    <i class="fas fa-check-circle mr5"></i>
    {__("Congratulation! Your wallet credit replenished successfully with")} <span class="badge rounded-pill badge-lg bg-secondary">{print_money($wallet_replenish_amount|format_number)}</span>
  </div>
  {/if}
  {if $wallet_withdraw_affiliates_amount}
  <div class="alert alert-success mb20">
    <i class="fas fa-check-circle mr5"></i>
    {__("Congratulation! Your wallet credit replenished successfully with")} <span class="badge rounded-pill badge-lg bg-secondary">{print_money($wallet_withdraw_affiliates_amount|format_number)}</span> {__("from your affiliates credit")}
  </div>
  {/if}
  {if $wallet_withdraw_points_amount}
  <div class="alert alert-success mb20">
    <i class="fas fa-check-circle mr5"></i>
    {__("Congratulation! Your wallet credit replenished successfully with")} <span class="badge rounded-pill badge-lg bg-secondary">{print_money($wallet_withdraw_points_amount|format_number)}</span> {__("from your points credit")}
  </div>
  {/if}
  {if $wallet_withdraw_market_amount}
  <div class="alert alert-success mb20">
    <i class="fas fa-check-circle mr5"></i>
    {__("Congratulation! Your wallet credit replenished successfully with")} <span class="badge rounded-pill badge-lg bg-secondary">{print_money($wallet_withdraw_market_amount|format_number)}</span> {__("from your market credit")}
  </div>
  {/if}
  {if $wallet_withdraw_funding_amount}
  <div class="alert alert-success mb20">
    <i class="fas fa-check-circle mr5"></i>
    {__("Congratulation! Your wallet credit replenished successfully with")} <span class="badge rounded-pill badge-lg bg-secondary">{print_money($wallet_withdraw_funding_amount|format_number)}</span> {__("from your funding credit")}
  </div>
  {/if}
  {if $wallet_withdraw_monetization_amount}
  <div class="alert alert-success mb20">
    <i class="fas fa-check-circle mr5"></i>
    {__("Congratulation! Your wallet credit replenished successfully with")} <span class="badge rounded-pill badge-lg bg-secondary">{print_money($wallet_withdraw_monetization_amount|format_number)}</span> {__("from your monetization credit")}
  </div>
  {/if}
  {if $wallet_package_payment_amount}
  <div class="alert alert-success mb20">
    <i class="fas fa-check-circle mr5"></i>
    {__("Your")} <span class="badge rounded-pill badge-lg bg-secondary">{print_money($wallet_package_payment_amount|format_number)}</span> {__("payment transaction successfuly done")}
  </div>
  {/if}
  {if $wallet_monetization_payment_amount}
  <div class="alert alert-success mb20">
    <i class="fas fa-check-circle mr5"></i>
    {__("Your")} <span class="badge rounded-pill badge-lg bg-secondary">{print_money($wallet_monetization_payment_amount|format_number)}</span> {__("payment transaction successfuly done")}
  </div>
  {/if}
  {if $wallet_paid_post_amount}
  <div class="alert alert-success mb20">
    <i class="fas fa-check-circle mr5"></i>
    {__("Your")} <span class="badge rounded-pill badge-lg bg-secondary">{print_money($wallet_paid_post_amount|format_number)}</span> {__("payment transaction successfuly done")}
  </div>
  {/if}
  {if $wallet_donate_amount}
  <div class="alert alert-success mb20">
    <i class="fas fa-check-circle mr5"></i>
    {__("Your")} <span class="badge rounded-pill badge-lg bg-secondary">{print_money($wallet_donate_amount|format_number)}</span> {__("payment transaction successfuly done")}
  </div>
  {/if}
  {if $wallet_marketplace_amount}
  <div class="alert alert-success mb20">
    <i class="fas fa-check-circle mr5"></i>
    {__("Your")} <span class="badge rounded-pill badge-lg bg-secondary">{print_money($wallet_marketplace_amount|format_number)}</span> {__("payment transaction successfuly done")}
  </div>
  {/if}
  {if $transfer_send_amount}
  <div class="alert alert-success mb20">
    <i class="fas fa-check-circle mr5"></i>
    {__("Your")} <span class="badge rounded-pill badge-lg bg-secondary">{print_money($transfer_send_amount|format_number)}</span> {__("transfer transaction successfuly sent")}
  </div>
  {/if}

  <div class="row">
    <!-- credit -->
    <div class="col-md-5">
      <div class="section-title d-none d-md-block mb20">
        {__("Your Credit")}
      </div>
      <div class="stat-panel bg-gradient-info">
        <div class="stat-cell small">
          <i class="fa fa-money-bill-alt bg-icon"></i>
          <div class="h3 mtb10">
            {print_money($user->_data['user_wallet_balance']|format_number)}
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

      <div class="d-grid withdraws">
        <button class="btn btn-outline-primary" data-toggle="modal" data-url="#wallet-replenish">
          {include file='__svg_icons.tpl' icon="payments" class="main-icon mr10" width="24px" height="24px"}
          {__("Top Up Credit")}
        </button>
        {if $system['affiliates_enabled'] && $system['affiliates_money_transfer_enabled']}
        <button class="btn btn-outline-primary" data-toggle="modal" data-url="#wallet-withdraw-affiliates">
          {include file='__svg_icons.tpl' icon="affiliates" class="main-icon mr10" width="24px" height="24px"}
          {__("Affiliates Credit")}
        </button>
        {/if}
        {if $system['points_enabled'] && $system['points_per_currency'] > 0 && $system['points_money_transfer_enabled']}
        <button class="btn btn-outline-primary" data-toggle="modal" data-url="#wallet-withdraw-points">
          {include file='__svg_icons.tpl' icon="points" class="main-icon mr10" width="24px" height="24px"}
          {__("Points Credit")}
        </button>
        {/if}
        {if $user->_data['can_sell_products'] && $system['market_money_transfer_enabled'] && $system['market_shopping_cart_enabled']}
        <button class="btn btn-outline-primary" data-toggle="modal" data-url="#wallet-withdraw-market">
          {include file='__svg_icons.tpl' icon="market" class="main-icon mr10" width="24px" height="24px"}
          {__("Marketplace Credit")}
        </button>
        {/if}
        {if $user->_data['can_raise_funding'] && $system['funding_money_transfer_enabled']}
        <button class="btn btn-outline-primary" data-toggle="modal" data-url="#wallet-withdraw-funding">
          {include file='__svg_icons.tpl' icon="funding" class="main-icon mr10" width="24px" height="24px"}
          {__("Funding Credit")}
        </button>
        {/if}
        {if $user->_data['can_monetize_content'] && $system['monetization_money_transfer_enabled']}
        <button class="btn btn-outline-primary" data-toggle="modal" data-url="#wallet-withdraw-monetization">
          {include file='__svg_icons.tpl' icon="monetization" class="main-icon mr10" width="24px" height="24px"}
          {__("Monetization Credit")}
        </button>
        {/if}
        {if $system['wallet_withdrawal_enabled']}
        <button class="btn btn-outline-primary" data-toggle="modal" data-url="#wallet-withdraw">
          {include file='__svg_icons.tpl' icon="payments" class="main-icon mr10" width="24px" height="24px"}
          {__("Withdraw Credit")}
        </button>
        {/if}
      </div>
    </div>
    <!-- send & recieve money -->

    <!-- wallet transactions -->
    <div class="col-12 mt20">
      <div class="section-title mt10 mb20">
        {__("Wallet Transactions")}
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
