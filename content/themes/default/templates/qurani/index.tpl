{include file='_head.tpl'}
{include file='_header.tpl'}

<iframe src="{$system['qurani_url']}" name="qurani-iframe" id="qurani-iframe"></iframe>

<style>
  html, body {
    margin: 0;
    padding: 0;
    overflow: hidden;
    height: 100%;
  }

  #qurani-iframe {
    width: 100%;
    height: 100vh;
    border: none; /* Hilangkan garis border jika ada */
  }
</style>

{literal}
<script>
  const quraniUrl = "{/literal}{$system['qurani_url']}{literal}";
  const c_user = "{/literal}{$c_user}{literal}";
  const s_lang = "{/literal}{$s_lang}{literal}";
  const s_night_mode = "{/literal}{$s_night_mode}{literal}";
  const user_session = "{/literal}{$user_session}{literal}";
  const signature = "{/literal}{$signature}{literal}";

  const quraniIFrame = document.getElementById('qurani-iframe');

  quraniIFrame.onload = () => {
    // Kirim data ke iframe
    quraniIFrame.contentWindow.postMessage({
      data: {
        c_user,
        s_lang,
        s_night_mode,
        user_session,
        signature
      },
      type: 'parent_state',
    }, quraniUrl);

    // (Opsional) Jika kamu ingin mengembalikan scroll ke parent nanti:
    // document.body.style.overflow = 'auto';
  }
</script>
{/literal}
