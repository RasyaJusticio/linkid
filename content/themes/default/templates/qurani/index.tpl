{include file='_head.tpl'}
{include file='_header.tpl'}

<iframe src="{$system['qurani_url']}?token={$token}" name="qurani-iframe" id="qurani-iframe"></iframe>

<style>
  html, body {
    margin: 0;
    padding: 0;
    height: 100%;
  }

  #qurani-iframe {
    width: 100%;
    height: 100vh;
  }

  .main-header {
    transition: opacity ease-in-out 300ms, transform ease-in-out 300ms;
  }

  .main-header.hidden {
    opacity: 0;
    transform: translateY(-100%);
  }
</style>

{include file='_footer.tpl'}