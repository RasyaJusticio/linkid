{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page header -->
<div class="page-header">
  <img class="floating-img d-none d-md-block" src="{$system['system_url']}/content/themes/{$system['theme']}/images/headers/undraw_message_sent_1030.svg">
  <div class="circle-2"></div>
  <div class="circle-3"></div>
  <div class="inner">
    <h2>{__("Contact Us")}</h2>
    <p class="text-xlg">{__("Contact us and we will contact you back")}</p>
  </div>
</div>
<!-- page header -->

<!-- page content -->
<div class="{if $system['fluid_design']}container-fluid{else}container{/if} sg-offcanvas" style="margin-top: -25px;">
  <div class="row">

    <!-- side panel -->
    <div class="col-12 d-block d-md-none sg-offcanvas-sidebar mt20">
      {include file='_sidebar.tpl'}
    </div>
    <!-- side panel -->

    <!-- content panel -->
    <div class="col-12 col-md-8 col-lg-6 col-xl-5 mx-md-auto sg-offcanvas-mainbar">
      <div class="card px-4 py-4 shadow">
        <div class="card-body">
          <form class="js_ajax-forms" data-url="core/contact.php">
            <div class="form-group">
              <label class="form-label">{__("Name")} <span class="text-danger">*</span></label>
              <input type="text" class="form-control" name="name">
            </div>

            <div class="form-group">
              <label class="form-label">{__("Email")} <span class="text-danger">*</span></label>
              <input type="email" class="form-control" name="email">
            </div>

            <div class="form-group">
              <label class="form-label">{__("Subject")} <span class="text-danger">*</span></label>
              <input type="text" class="form-control" name="subject">
            </div>

            <div class="form-group">
              <label class="form-label">{__("Message")} <span class="text-danger">*</span></label>
              <textarea class="form-control" name="message" rows="5"></textarea>
            </div>

            {if $system['reCAPTCHA_enabled']}
              <div class="form-group">
                <!-- reCAPTCHA -->
                <script src='https://www.google.com/recaptcha/api.js' async defer></script>
                <div class="g-recaptcha" data-sitekey="{$system['reCAPTCHA_site_key']}"></div>
                <!-- reCAPTCHA -->
              </div>
            {/if}

            {if $system['turnstile_enabled']}
              <div class="form-group">
                <!-- Turnstile -->
                <script src="https://challenges.cloudflare.com/turnstile/v0/api.js" async defer></script>
                <div class="cf-turnstile" data-sitekey="{$system['turnstile_site_key']}" data-callback="javascriptCallback"></div>
                <!-- Turnstile -->
              </div>
            {/if}

            <div class="form-group d-grid">
              <button type="submit" class="btn btn-primary">
                {__("Send")}
              </button>
            </div>

            <!-- success -->
            <div class="alert alert-success x-hidden"></div>
            <!-- success -->

            <!-- error -->
            <div class="alert alert-danger x-hidden"></div>
            <!-- error -->

          </form>
        </div>
      </div>
    </div>
    <!-- content panel -->
  </div>
</div>
<!-- page content -->

{include file='_footer.tpl'}