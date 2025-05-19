{assign var="iframe_url" value="`$qurani_url`riwayat"}

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

  // Fungsi untuk mengatur title dengan format [Spesifik Title] | Link.id - Sosmed Islami
  function setPageTitleFromData(data) {
    try {
      let baseTitle = 'Riwayat Setoran';
      if (data && data.setoran_id) {
        baseTitle = `Setoran #${data.setoran_id}`; // Misalnya, "Setoran #123"
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
      // Hapus favicon yang ada
      const existingFavicons = document.querySelectorAll('link[rel="icon"], link[rel="shortcut icon"]');
      existingFavicons.forEach(favicon => favicon.remove());

      // Buat favicon baru dengan URL yang diberikan
      const newFavicon = document.createElement('link');
      newFavicon.rel = 'icon';
      newFavicon.type = 'image/png';
      // Gunakan URL favicon yang sama seperti di kode kedua
      newFavicon.href = '{/literal}{$system['system_url']|escape:'javascript'}{literal}/content/themes/default/images/LinkId-Icon.png';
      
      // Fallback jika file tidak ditemukan
      newFavicon.onerror = () => {
        console.warn('⚠️ Gagal memuat favicon, menggunakan favicon default.');
        newFavicon.href = '/favicon.ico'; // Favicon default Sngine
      };
      
      document.head.appendChild(newFavicon);
      console.log('✅ Favicon diperbarui:', newFavicon.href);
    } catch (error) {
      console.error('❌ Gagal mengatur favicon:', error);
    }
  }

  // Fungsi untuk mengambil setoranId dari URL
  const getSetoranId = () => {
    const pathSegments = window.location.pathname.split('/');
    const setoranId = pathSegments[pathSegments.length - 1];
    return isNaN(parseInt(setoranId)) ? null : parseInt(setoranId);
  };

  // Fungsi untuk mengirim postMessage
  const sendPostMessage = (data) => {
    try {
      const targetOrigin = `{/literal}{$qurani_url}{literal}`;
      iframe.contentWindow.postMessage(data, targetOrigin);
      console.log('✅ postMessage dikirim ke iframe:', data, 'Waktu:', new Date().toISOString());
    } catch (error) {
      console.error('Gagal mengirim postMessage:', error);
      Swal.fire({
        icon: 'error',
        title: 'Kesalahan',
        text: 'Gagal mengirim data ke iframe: ' + error.message,
      });
    }
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
        throw new Error('Gagal mengambil data setoran: ' + response.status);
      }
      return response.json();
    })
    .then(data => {
      console.log('Data setoran diterima:', data);
      if (data.error) {
        console.error('Error dari server:', data.error);
        Swal.fire({
          icon: 'error',
          title: 'Kesalahan',
          text: data.error,
        });
        return;
      }
      // Atur title berdasarkan data setoran
      setPageTitleFromData(data);
      sendPostMessage(data);
    })
    .catch(error => {
      console.error('Error mengambil data setoran:', error);
      Swal.fire({
        icon: 'error',
        title: 'Kesalahan',
        text: 'Gagal mengambil data setoran: ' + error.message,
      });
      // Set title default jika gagal
      setPageTitleFromData(null);
    });
  };

  // Set favicon segera saat halaman dimuat
  setFavicon();

  // Ambil setoranId awal
  const initialSetoranId = getSetoranId();
  if (!initialSetoranId) {
    console.error("ID setoran tidak valid di URL:", window.location.pathname);
    Swal.fire({
      icon: 'error',
      title: 'Kesalahan',
      text: 'ID setoran tidak valid. Silakan kembali ke halaman riwayat.',
    });
    document.title = 'Riwayat Setoran | Link.id - Sosmed Islami';
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
    }
  });

  // Listener untuk menerima metadata dari iframe (opsional, untuk konsistensi)
  window.addEventListener('message', (event) => {
    if (event.origin !== `{/literal}{$qurani_url}{literal}`) {
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
      // Abaikan favicon dari iframe, gunakan yang sudah ditentukan
      console.log('ℹ️ Mengabaikan favicon dari iframe, menggunakan favicon yang ditentukan');
    }
  });
});
{/literal}
</script>
