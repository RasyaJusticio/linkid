{include file='_head.tpl'}
{include file='_header.tpl'}

<iframe src="{$system['qurani_url']}" name="qurani-iframe" id="qurani-iframe"></iframe>

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
</style>

{include file='_footer.tpl'}
