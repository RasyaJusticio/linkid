<!-- page content -->
<div class="{if $system['fluid_design']}container-fluid{else}container{/if}" style="margin-top: -25px;">
  <div class="row">
    <div class="col-12 col-md-10 mx-md-auto">
      <div class="card shadow">
        <form class="card-body js_ajax-forms" data-url="organizations/apply.php">

          <!-- nav -->
          <ul class="nav nav-pills nav-fill nav-started mb30 js_wizard-steps">
            <li class="nav-item">
              <a class="nav-link active" href="#step-1">
                <h4 class="mb5">{__("Step 1")}</h4>
                <p class="mb0">{__("Update your info")}</p>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link disabled" href="#step-2">
                <h4 class="mb5">{__("Step 2")}</h4>
                <p class="mb0">
                {__("Add Members")}
                </p>
              </a>
            </li>
          </ul>
          <!-- nav -->

          <!-- tabs -->
          <div class="js_wizard-content" id="step-1">
            <div class="text-center">
              <h3 class="mb5">{__("Update your info")}</h3>
              <p class="mb20">{__("Share your organization information")}</p>
            </div>

            <div class="heading-small mb20">
              {__("Identity")}
            </div>
            <div class="pl-md-4">
              <div class="row">

                <div class="form-group">
                  <label class="form-label" for="title">{__("Name Your Organization")}</label>
                  <input type="text" class="form-group-title form-control" name="name" id="name">
                </div>
                <div class="form-group">
                  <label class="form-label" for="username">{__("Organization Username")}</label>
                  <div class="input-group">
                    <span class="input-group-text d-none d-sm-block">{$system['system_url']}/org/</span>
                    <input type="text" class="form-group-username form-control" name="slug" id="slug">
                  </div>
                  <div class="form-text">
                    {__("Can only contain alphanumeric characters (A–Z, 0–9), periods ('.'), and hyphens ('-')")}
                  </div>
                </div>
              </div>
            </div>

            <div class="divider"></div>

            <div class="heading-small mb20">
              {__("Location")}
            </div>
            <div class="pl-md-4">
              <div class="row">
                <div class="form-group col">
                  {assign var="defaultCountryValue" value=$user->_data['user_country']|default:101}

                  <label class="form-label" for="_country">{__("Country")}</label>
                  <div class="combobox-container w-100" data-default="{$defaultCountryValue}" data-options="#country-combobox" data-hidden="#country" data-loc-type="country" data-next-input="#_province">
                    <input type="text" id="_country" class="combobox location-combobox form-control"  placeholder="{__('Select Country')}" autocomplete="off" spellcheck="false">
                    <div id="country-combobox" class="combobox-options">
                      {foreach $countries as $country}
                      <div class="combobox-option" data-value="{$country['country_id']}">{$country['country_name']}</div>
                      {/foreach}
                    </div>
                    <input type="hidden" id="country" name="country">
                  </div>
                </div>

                <div class="form-group col">
                  {assign var="defaultProvinceValue" value=$user->_data['user_province']|default:35}

                  <label class="form-label" for="_province">{__("Province")}</label>
                  <div class="combobox-container w-100" data-default="{$defaultProvinceValue}" data-options="#province-combobox" data-hidden="#province" data-loc-type="province" data-next-input="#_city">
                    <input type="text" id="_province" class="combobox location-combobox form-control" placeholder="{__('Select Province')}" autocomplete="off" spellcheck="false">
                    <div id="province-combobox" class="combobox-options"></div>
                    <input type="hidden" id="province" name="province">
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="form-group col">
                  {assign var="defaultCityValue" value=$user->_data['user_city']|default:3573}

                  <label class="form-label" for="_city">{__("City")}</label>
                  <div class="combobox-container w-100" data-default="{$defaultCityValue}" data-options="#city-combobox" data-hidden="#city" data-loc-type="city" data-next-input="#_district">
                    <input type="text" id="_city" class="combobox location-combobox form-control" placeholder="{__('Select City')}" autocomplete="off" spellcheck="false">
                    <div id="city-combobox" class="combobox-options"></div>
                    <input type="hidden" id="city" name="city">
                  </div>
                </div>

                <div class="form-group col">
                  {assign var="defaultDistrictValue" value=$user->_data['user_district']|default:357305}

                  <label class="form-label" for="_district">{__("District")}</label>
                  <div class="combobox-container w-100" data-default="{$defaultDistrictValue}" data-options="#district-combobox" data-hidden="#district" data-loc-type="district">
                    <input type="text" id="_district" class="combobox location-combobox form-control" placeholder="{__('Select District')}" autocomplete="off" spellcheck="false">
                    <div id="district-combobox" class="combobox-options"></div>
                    <input type="hidden" id="district" name="district">
                  </div>
                </div>
              </div>
            </div>

            <!-- buttons -->
            <div class="clearfix mt20">
              <div class="float-end">
                <button type="button" class="btn btn-primary" id="activate-step-2">{__("Next")}<i class="fas fa-arrow-circle-right ml5"></i></button>
              </div>
            </div>
            <!-- buttons -->
          </div>

          <div class="js_wizard-content x-hidden" id="step-2">
            <div class="text-center">
              <h3 class="mb5">
                {__("Add Members")}
              </h3>
              <p class="mb20">{__("Add members into your organization")}</p>
            </div>


            <!-- buttons -->
            <div class="clearfix mt20">
              <button type="submit" class="btn btn-danger float-end"><i class="fas fa-check-circle mr5"></i>{__("Finish")}</button>
            </div>
            <!-- buttons -->
          </div>
          <!-- tabs -->

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
</div>
<!-- page content -->

{include file='_footer.tpl'}

<script>
  $(function() {

    var wizard_steps = $('.js_wizard-steps li a');
    var wizard_content = $('.js_wizard-content');

    wizard_content.hide();

    wizard_steps.click(function(e) {
      e.preventDefault();
      var $target = $($(this).attr('href'));
      if (!$(this).hasClass('disabled')) {
        wizard_steps.removeClass('active');
        $(this).addClass('active');
        wizard_content.hide();
        $target.show();
      }
    });

    $('.js_wizard-steps li a.active').trigger('click');

    $('#activate-step-2').on('click', function(e) {
      $('.js_wizard-steps li:eq(1) a').removeClass('disabled');
      $('.js_wizard-steps li a[href="#step-2"]').trigger('click');
    });

    $('#activate-step-3').on('click', function(e) {
      $('.js_wizard-steps li:eq(2) a').removeClass('disabled');
      $('.js_wizard-steps li a[href="#step-3"]').trigger('click');
    });

    $('#activate-step-4').on('click', function(e) {
      $('.js_wizard-steps li:eq(3) a').removeClass('disabled');
      $('.js_wizard-steps li a[href="#step-4"]').trigger('click');
    });

  });
</script>
