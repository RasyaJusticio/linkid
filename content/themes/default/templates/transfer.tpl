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
<script src="{$system['system_url']}/node_modules/qr-scanner/qr-scanner.umd.min.js"></script>

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

            <div class="row">
              <!-- credit -->
              <div class="col">
                <div class="section-title mb20">
                  {__("QR Code")}
                </div>
                <div class="stat-panel" style="background-color: var(--card-dark-hover);">
                  <div class="stat-cell small" style="padding: 1rem; display: grid; place-items: center;">
                    <div class="stat-panel bg-gradient-info" style="margin: 0;">
                      <div class="stat-cell small shadow-lg p-3" style="display: grid; place-items: center; aspect-ratio: 1/1;">
                        <div id="qrcode" class="rounded overflow-hidden h-100 w-100"></div>
                        <script type="text/javascript">
                          new QRCode(document.getElementById("qrcode"), "{$transfer_token}");
                        </script>
                        <style>
                            #qrcode {
                                img {
                                    width: 100%;
                                }
                            }
                        </style>
                        </div>
                    </div>
                </div>
              </div>
              <!-- credit -->
            </div>
          </div>
        </div>
        <!-- wallet -->

      {elseif $view == "send"}

        <!-- payments -->
        <div class="card mt20">
          <div class="card-header with-icon">
            {include file='__svg_icons.tpl' icon="money_send" class="mr10" width="24px" height="24px"}
            {__("Send")}
          </div>
          <div class="card-body page-content">
            {if $transfer_fail_message}
              <div class="alert alert-danger mb20">
                <i class="fas fa-check-circle mr5"></i>
                {__($transfer_fail_message)}
              </div>
            {/if}

            <div class="section-title mt10 mb20">
              {__("Scan QR Code")}
            </div>

            <video id="reader" class="w-100 rounded" style="background-color: var(--card-dark-hover)"></video>

            <script>
              const readerElem = document.getElementById('reader');

              let isSuccessfull = false;
              let isProcessing = false;
              const onSuccess = (result) => {
                if (isSuccessfull || isProcessing) {
                    return;
                }
                isProcessing = true;

                $.post(ajax_path + "payments/transfer.php?do=check_token", {
                    transfer_token: result.data
                }, function (response) {
                    isProcessing = false;
                    qrScanner.stop();

                    if (response.result == "valid") {
                        isSuccessfull = true;
                        
                        const user = response.user;

                        modal("#transfer_money", { 'user_id': user['user_id'], 'user_fullname': user['user_firstname'] + " " + user['user_lastname'], 'user_picture': user['user_picture'] });
                    }
                }).fail(function() {
                    isProcessing = false;
                });
              }
    
              const qrScanner = new QrScanner(
                readerElem,
                onSuccess,
                {
                    returnDetailedScanResult: true,
                    highlightScanRegion: true,
                    highlightCodeOutline: true
                }
              );

              qrScanner.start();
            </script>

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
