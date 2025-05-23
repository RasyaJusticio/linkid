{assign var="iframe_url" value="{$system['qurani_url']}/riwayat"}

<!-- page header -->
<div class="circle-2"></div>
<div class="circle-3"></div>

<!-- Iframe untuk rekapan -->
<div class="iframe-container" style="position: relative; width: 100%; min-height: calc(100vh - 20px); margin: 0; padding: 0; overflow: hidden;">
  <iframe id="rekapanFrame" src="{$iframe_url}" 
          style="position: absolute; top: 0px; left: 0; width: 100%; height: calc(100% + 20px); border: none;"
          frameborder="0"
          allowfullscreen
          allow="geolocation; microphone; camera"
          scrolling="auto">
  </iframe>
</div>

<script>
{literal}
document.addEventListener("DOMContentLoaded", function() {
  const iframe = document.getElementById('rekapanFrame');
  console.log('Iframe URL:', iframe.src);
  const quraniUrl = "{/literal}{$system['qurani_url']}{literal}";

  // Fungsi untuk mengatur title dengan format [Spesifik Title] | Link.id - Sosmed Islami
  function setPageTitleFromData(data) {
    try {
      let baseTitle = 'Riwayat Setoran';
      if (data && data.id) {
        baseTitle = `Setoran #${data.id}`; // Gunakan data.id alih-alih setoran_id
      }
      const fullTitle = `${baseTitle} | Link.id - Sosmed Islami`;
      document.title = fullTitle;
      console.log('✅ Title diperbarui dari data:', fullTitle);
    } catch (error) {
      console.error('❌ Gagal mengatur title:', error);
      document.title = 'Riwayat Setoran | Link.id - Sosmed Islami';
    }
  }

  // Fungsi untuk mengatur favicon dengan URL yang diberikan
  function setFavicon() {
    try {
      const existingFavicons = document.querySelectorAll('link[rel="icon"], link[rel="shortcut icon"]');
      existingFavicons.forEach(favicon => favicon.remove());

      const newFavicon = document.createElement('link');
      newFavicon.rel = 'icon';
      newFavicon.type = 'image/png';
      newFavicon.href = '{/literal}{$system['system_url']}{literal}/content/themes/default/images/LinkId-Icon.png';
      
      newFavicon.onerror = () => {
        console.warn('⚠️ Gagal memuat favicon, menggunakan favicon default.');
        newFavicon.href = '/favicon.ico';
      };
      
      document.head.appendChild(newFavicon);
      console.log('✅ Favicon diperbarui:', newFavicon.href);
    } catch (error) {
      console.error('❌ Gagal mengatur favicon:', error);
    }
  }

  // Fungsi untuk mengambil setoranId dari URL (mendukung /riwayat/265)
  const getSetoranId = () => {
    const pathSegments = window.location.pathname.split('/');
    const setoranId = pathSegments[pathSegments.length - 1];
    return isNaN(parseInt(setoranId)) ? null : parseInt(setoranId);
  };

  // Fungsi untuk mengirim postMessage
  const sendPostMessage = (data) => {
    try {
      const targetOrigin = quraniUrl;
      const messageData = {
        ...data,
        language_code: language_code
      };
      iframe.contentWindow.postMessage(messageData, targetOrigin);
      console.log('✅ postMessage dikirim ke iframe:', data, 'Waktu:', new Date().toISOString());
    } catch (error) {
      console.error('Gagal mengirim postMessage:', error);
      window.location.href = '{/literal}{$system['system_url']}{literal}/qurani/notFound';
    }
  };

  // Fungsi untuk mengalihkan ke halaman notFound
  const redirectToNotFound = () => {
    window.location.href = '{/literal}{$system['system_url']}{literal}/qurani/notFound';
  };

  // Fungsi untuk mengambil data setoran
  const fetchSetoranData = (setoranId) => {
    fetch('{/literal}{$system['system_url']|escape:'javascript'}{literal}/qurani/rekapan', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ id: setoranId })
    })
    .then(response => {
      if (!response.ok) {
        redirectToNotFound(); // Langsung redirect tanpa pesan
        return null;
      }
      return response.json();
    })
    .then(data => {
      if (!data) return; // Jika redirect sudah dipanggil, skip
      if (data.error) {
        redirectToNotFound(); // Langsung redirect tanpa pesan
        return;
      }
      setPageTitleFromData(data);
      sendPostMessage(data);
    })
    .catch(() => {
      redirectToNotFound(); // Langsung redirect tanpa pesan
    });
  };

  // Set favicon segera saat halaman dimuat
  setFavicon();

  // Ambil setoranId awal
  const initialSetoranId = getSetoranId();
  if (!initialSetoranId) {
    redirectToNotFound(); // Langsung redirect tanpa pesan
    return;
  }

  // Kirim data saat iframe dimuat
  iframe.onload = () => {
    fetchSetoranData(initialSetoranId);
  };

  // Deteksi perubahan URL (misalnya, navigasi kembali atau maju)
  let lastSetoranId = initialSetoranId;
  window.addEventListener('popstate', () => {
    const currentSetoranId = getSetoranId();
    if (currentSetoranId && currentSetoranId !== lastSetoranId) {
      console.log('URL berubah, mengambil data untuk setoranId:', currentSetoranId);
      fetchSetoranData(currentSetoranId);
      lastSetoranId = currentSetoranId;
    } else if (!currentSetoranId) {
      redirectToNotFound(); // Langsung redirect tanpa pesan
    }
  });

  // Listener untuk menerima metadata dari iframe
  window.addEventListener('message', (event) => {
    if (event.origin !== quraniUrl) {
      console.warn('⚠️ Pesan dari origin tidak dikenal:', event.origin);
      return;
    }

    const data = event.data;
    if (data.type === 'updateMetadata' && data.title) {
      const fullTitle = data.title.includes('| Link.id - Sosmed Islami') 
        ? data.title 
        : `${data.title} | Link.id - Sosmed Islami`;
      document.title = fullTitle;
      console.log('✅ Title diperbarui via postMessage:', fullTitle);
      console.log('ℹ️ Mengabaikan favicon dari iframe, menggunakan favicon yang ditentukan');
    }
  });
});
{/literal}
</script>

{include file='_js_files.tpl'}