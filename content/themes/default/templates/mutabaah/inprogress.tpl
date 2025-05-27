{include file='_head.tpl'}
{include file='_header.tpl'}

{if $view == ""}
  <!-- page header -->
  <div class="page-header">
    <img class="floating-img d-none d-md-block" src="{$system['system_url']}/content/themes/{$system['theme']}/images/headers/undraw_online-calendar_zaoc.svg">
    <div class="circle-2"></div>
    <div class="circle-3"></div>
    <div class="inner d-flex flex-column justify-content-center align-items-center">
      <h2>{__("Mutabaah")}</h2>
      <p class="text-xlg w-50">{__($system['system_description_mutabaah'])}</p>
    </div>
  </div>
  <!-- page header -->
{/if}


<!-- page content -->
<div class="mutabaah-coming-soon {if $system['fluid_design']}container-fluid{else}container{/if} mt20 sg-offcanvas">
  <div class="row">

    <!-- side panel -->
    <div class="col-12 d-block d-md-none sg-offcanvas-sidebar">
      {include file='_sidebar.tpl'}
    </div>
    <!-- side panel -->

    <!-- content panel -->
    <div class="col-12 coming-soon-mainbar">
      <div class="coming-soon-card">
        <img class="floating-img" src="{$system['system_url']}/content/themes/{$system['theme']}/images/headers/undraw_under-construction_c2y1.svg">
        <h2>{__('Coming Soon')}</h2>
      </div>
    </div>
    <!-- content panel -->

  </div>
</div>
<!-- page content -->
<style>
.mutabaah-coming-soon {
  .coming-soon-mainbar {
    width: 100%;
    display: flex;
    padding-block: 6rem;
    justify-content: center;
    border: 1px dashed;
    border-radius: 2rem;
    border-color: #bbbbbb;
  }

  .coming-soon-card {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    gap: 2rem;
    max-width: 24rem;

    > img {
      width: 100%;
    }
  }
}

body.night-mode {
  .mutabaah-coming-soon {
    .coming-soon-mainbar {
      border-color: #66707b;
    }
  }
}

</style>

{include file='_footer.tpl'}
