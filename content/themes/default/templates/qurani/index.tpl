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
  .header-hidden {
    display: none;
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

  // Listener buat pesan dari iframe
  window.addEventListener('message', function(event) {
    // Pastiin pesan dari iframe yang bener
    if (event.origin !== quraniUrl) {
      return;
    }

    // Cek tipe pesan: 'iframe_ready' (awal load) atau 'route_change' (URL berubah)
    if (event.data.type === 'iframe_ready' || event.data.type === 'route_change') {
      const header = document.querySelector('.main-header');
      if (event.data.path === '/') {
        header.classList.remove('header-hidden'); // Tampilin header
      } else {
        header.classList.add('header-hidden'); // Sembunyiin header
      }
    }
  });
</script>
{/literal}

{include file='_footer.tpl'}
