{include file='_head.tpl'}
{include file='_header.tpl'}

<iframe src="{$system['qurani_url']}" id="qurani-iframe"></iframe>

<style>
  #qurani-iframe {
    width: 100%;
    height: 100vh;
  }
</style>

{literal}
<script>
  const quraniUrl = "{/literal}{$system['qurani_url']}{literal}";
  const c_user = "{/literal}{$c_user}{literal}";
  const s_lang = "{/literal}{$s_lang}{literal}";
  const s_night_mode = "{/literal}{$s_night_mode}{literal}";
  const user_session = "{/literal}{$user_session}{literal}";

  const quraniIFrame = document.getElementById('qurani-iframe');

  quraniIFrame.onload = () => {
    quraniIFrame.contentWindow.postMessage({
      c_user,
      s_lang,
      s_night_mode,
      user_session
    }, quraniUrl);
  }


</script>
{/literal}

{include file='_footer.tpl'}
