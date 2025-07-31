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
    <button
        class="btn btn-outline-primary"
        data-toggle="modal"
        data-url="#org-my-qr"
        data-options='{
          "full_name": "{$user->_data['user_firstname']} {$user->_data['user_lastname']}",
          "user_name": "{$user->_data['user_name']}",
          "user_verified": "{$user->_data['user_verified']}",
          "qrcode_uri": "{$qrcode_uri}",
          "va_number": "{$data['va_number']|format_va_number}"
        }'
    >
        {include file='__svg_icons.tpl' icon="qr_code" width="24px" height="24px"}
        {__("My QR")}
    </button>
  </div>
</div>
<div class="card-body page-content">
  {if is_empty($data['transfer_pin'])}
    <div class="alert alert-warning">
      {__("You don't have a transfer PIN yet. Please make one.")}
    </div>
  {/if}

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
        <button class="btn btn-outline-primary" data-toggle="modal" data-url="#wallet-transfer">
          {include file='__svg_icons.tpl' icon="money_send" class="mr10" width="24px" height="24px"}
          {__("Send Money")}
        </button>
      </div>

      <div class="d-grid">
        <button class="btn btn-outline-primary" data-toggle="modal" data-url="#wallet-receive">
          {include file='__svg_icons.tpl' icon="money_receive" class="mr10" width="24px" height="24px"}
          {__("Receive Money")}
        </button>
      </div>

      <div class="d-grid">
        <a href="{$org_url}/me/transfer-pin" class="btn btn-outline-primary">
          {include file='__svg_icons.tpl' icon="security" class="mr10" width="24px" height="24px"}
          {if is_empty($data['transfer_pin'])}
            {__("Set Transfer Pin")}
          {else}
            {__("Change Transfer Pin")}
          {/if}
        </a>
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
                {if $transaction['node_type'] == "member"}
                <a target="_blank" href="{$org_url}/members/find?query={$transaction['member_user_name']}">
                  <img class="tbl-image" src="{$transaction['user_picture']}" style="float: none;">
                  {if $system['show_usernames_enabled']}
                  {$transaction['member_user_name']}
                  {else}
                  {$transaction['member_firstname']} {$transaction['member_lastname']}
                  {/if}
                </a>
                {elseif $transaction['node_type'] == "bill"}
                  Bill of 
                  {print_money($transaction['bill_amount']|format_number)}
                  -
                  {$transaction['bill_description']}
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
