{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page header -->
<div class="page-header">
  <img class="floating-img d-none d-md-block" src="{$system['system_url']}/content/themes/{$system['theme']}/images/headers/undraw_wallet_aym5.svg">
  <div class="circle-2"></div>
  <div class="circle-3"></div>
  <div class="inner">
    <h2>{__("Transfer")}</h2>
    <p class="text-xlg">{__("Send and Transfer Money")}</p>
  </div>
</div>
<!-- page header -->

<script src="{$system['system_url']}/node_modules/qrcodejs/qrcode.min.js"></script>

<!-- page content -->
<div class="{if $system['fluid_design']}container-fluid{else}container{/if} sg-offcanvas" style="margin-top: -25px;">
  <div class="row">

    <!-- side panel -->
    <div class="col-12 d-block d-md-none sg-offcanvas-sidebar">
      {include file='_sidebar.tpl'}
    </div>
    <!-- side panel -->

    <!-- content panel -->
    <div class="col-12 sg-offcanvas-mainbar">

      <!-- tabs -->
      <div class="position-relative">
        <div class="content-tabs rounded-sm shadow-sm clearfix">
          <ul class="d-flex justify-content-xl-start justify-content-evenly">
            <li {if $view == ""}class="active" {/if}>
              <a href="{$system['system_url']}/transfer">
                {include file='__svg_icons.tpl' icon="money_receive" class="mr10" width="24px" height="24px"}
                <span class="d-none d-xl-inline-block ml5">{__("Receive")}</span>
              </a>
            </li>
            <li {if $view == "send"}class="active" {/if}>
              <a href="{$system['system_url']}/transfer/send">
                {include file='__svg_icons.tpl' icon="money_send" class="mr10" width="24px" height="24px"}
                <span class="d-none d-xl-inline-block ml5">{__("Send")}</span>
              </a>
            </li>
          </ul>
        </div>
      </div>
      <!-- tabs -->

      {if $view == ""}

        <!-- wallet -->
        <div class="card mt20">
          <div class="card-header with-icon">
            {include file='__svg_icons.tpl' icon="money_receive" class="mr10" width="24px" height="24px"}
            {__("Receive")}
          </div>
          <div class="card-body page-content">
            {if $transfer_send_amount}
              <div class="alert alert-success mb20">
                <i class="fas fa-check-circle mr5"></i>
                {__("Your")} <span class="badge rounded-pill badge-lg bg-secondary">{print_money($transfer_send_amount|format_number)}</span> {__("transfer transaction successfuly sent")}
              </div>
            {/if}
            {if $wallet_replenish_amount}
              <div class="alert alert-success mb20">
                <i class="fas fa-check-circle mr5"></i>
                {__("Congratulation! Your wallet credit replenished successfully with")} <span class="badge rounded-pill badge-lg bg-secondary">{print_money($wallet_replenish_amount|format_number)}</span>
              </div>
            {/if}

            <div class="row">
              <!-- credit -->
              <div class="col">
                <div class="section-title mb20">
                  {__("QR Code")}
                </div>
                <div>{$transfer_token}</div>
                <div class="stat-panel" style="background-color: var(--card-dark-hover);">
                  <div class="stat-cell small" style="display: grid; place-items: center;">
                    <div class="stat-panel bg-gradient-info">
                      <div class="stat-cell small shadow-lg p-4" style="display: grid; place-items: center;">
                        <div id="qrcode" class="rounded overflow-hidden"></div>
                        <script type="text/javascript">
                          new QRCode(document.getElementById("qrcode"), "{$transfer_token}");
                          console.log("{$transfer_token}")
                        </script>
                        </div>
                    </div>
                </div>
              </div>
              <!-- credit -->
            </div>
          </div>
        </div>
        <!-- wallet -->

      {elseif $view == "payments"}

        <!-- payments -->
        <div class="card mt20">
          <div class="card-header with-icon">
            {include file='__svg_icons.tpl' icon="payments" class="main-icon mr10" width="24px" height="24px"}
            {__("Payments")}
          </div>
          <div class="card-body page-content">
            <div class="section-title mt10 mb20">
              {__("Withdrawal Request")}
            </div>
            <form class="js_ajax-forms" data-url="users/withdraw.php?type=wallet">
              <div class="row form-group">
                <label class="col-md-3 form-label">
                  {__("Your Balance")}
                </label>
                <div class="col-md-9">
                  <h6>
                    <span class="badge badge-lg bg-info">
                      {print_money($user->_data['user_wallet_balance']|format_number)}
                    </span>
                  </h6>
                </div>
              </div>

              <div class="row form-group">
                <label class="col-md-3 form-label">
                  {__("Amount")} ({$system['system_currency']})
                </label>
                <div class="col-md-9">
                  <input type="text" class="form-control" name="amount">
                  <div class="form-text">
                    {__("The minimum withdrawal request amount is")} {print_money($system['wallet_min_withdrawal'])}
                  </div>
                </div>
              </div>

              <div class="row form-group">
                <label class="col-md-3 form-label">
                  {__("Payment Method")}
                </label>
                <div class="col-md-9">
                  {if in_array("paypal", $system['wallet_payment_method_array'])}
                    <div class="form-check form-check-inline">
                      <input type="radio" name="method" id="method_paypal" value="paypal" class="form-check-input">
                      <label class="form-check-label" for="method_paypal">{__("PayPal")}</label>
                    </div>
                  {/if}
                  {if in_array("skrill", $system['wallet_payment_method_array'])}
                    <div class="form-check form-check-inline">
                      <input type="radio" name="method" id="method_skrill" value="skrill" class="form-check-input">
                      <label class="form-check-label" for="method_skrill">{__("Skrill")}</label>
                    </div>
                  {/if}
                  {if in_array("moneypoolscash", $system['wallet_payment_method_array'])}
                    <div class="form-check form-check-inline">
                      <input type="radio" name="method" id="method_moneypoolscash" value="moneypoolscash" class="form-check-input">
                      <label class="form-check-label" for="method_moneypoolscash">{__("MoneyPoolsCash")}</label>
                    </div>
                  {/if}
                  {if in_array("bank", $system['wallet_payment_method_array'])}
                    <div class="form-check form-check-inline">
                      <input type="radio" name="method" id="method_bank" value="bank" class="form-check-input">
                      <label class="form-check-label" for="method_bank">{__("Bank Transfer")}</label>
                    </div>
                  {/if}
                  {if in_array("custom", $system['wallet_payment_method_array'])}
                    <div class="form-check form-check-inline">
                      <input type="radio" name="method" id="method_custom" value="custom" class="form-check-input">
                      <label class="form-check-label" for="method_custom">{__($system['wallet_payment_method_custom'])}</label>
                    </div>
                  {/if}
                </div>
              </div>

              <div class="row form-group">
                <label class="col-md-3 form-label">
                  {__("Transfer To")}
                </label>
                <div class="col-md-9">
                  <input type="text" class="form-control" name="method_value">
                </div>
              </div>

              <div class="row">
                <div class="col-md-9 offset-md-3">
                  <button type="submit" class="btn btn-primary">{__("Make a withdrawal")}</button>
                </div>
              </div>

              <!-- success -->
              <div class="alert alert-success mt15 mb0 x-hidden"></div>
              <!-- success -->

              <!-- error -->
              <div class="alert alert-danger mt15 mb0 x-hidden"></div>
              <!-- error -->
            </form>

            <div class="section-title mt20 mb20">
              {__("Withdrawal History")}
            </div>
            {if $payments}
              <div class="table-responsive mt20">
                <table class="table table-striped table-bordered table-hover">
                  <thead>
                    <tr>
                      <th>{__("ID")}</th>
                      <th>{__("Amount")}</th>
                      <th>{__("Method")}</th>
                      <th>{__("Transfer To")}</th>
                      <th>{__("Time")}</th>
                      <th>{__("Status")}</th>
                    </tr>
                  </thead>
                  <tbody>
                    {foreach $payments as $payment}
                      <tr>
                        <td>{$payment@iteration}</td>
                        <td>{print_money($payment['amount']|format_number)}</td>
                        <td>
                          {if $payment['method'] == "custom"}
                            {$system['wallet_payment_method_custom']}
                          {else}
                            {$payment['method']|ucfirst}
                          {/if}
                        </td>
                        <td>{$payment['method_value']}</td>
                        <td>
                          <span class="js_moment" data-time="{$payment['time']}">{$payment['time']}</span>
                        </td>
                        <td>
                          {if $payment['status'] == '0'}
                            <span class="badge rounded-pill badge-lg bg-warning">{__("Pending")}</span>
                          {elseif $payment['status'] == '1'}
                            <span class="badge rounded-pill badge-lg bg-success">{__("Approved")}</span>
                          {else}
                            <span class="badge rounded-pill badge-lg bg-danger">{__("Declined")}</span>
                          {/if}
                        </td>
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
        <!-- payments -->

      {/if}
    </div>
    <!-- content panel -->

  </div>
</div>
<!-- page content -->

{include file='_footer.tpl'}
