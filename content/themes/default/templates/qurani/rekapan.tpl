<!-- Load SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- Tentukan URL iframe -->
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

  // Fungsi untuk mengambil setoranId dari URL
  const getSetoranId = () => {
    const pathSegments = window.location.pathname.split('/');
    const setoranId = pathSegments[pathSegments.length - 1];
    return isNaN(parseInt(setoranId)) ? null : parseInt(setoranId);
  };

  // Fungsi untuk mengirim postMessage
  const sendPostMessage = (data) => {
    try {
      const targetOrigin = iframe.src;
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
      sendPostMessage(data);
    })
    .catch(error => {
      console.error('Error mengambil data setoran:', error);
      Swal.fire({
        icon: 'error',
        title: 'Kesalahan',
        text: 'Gagal mengambil data setoran: ' + error.message,
      });
    });
  };

  // Ambil setoranId awal
  const initialSetoranId = getSetoranId();
  if (!initialSetoranId) {
    console.error("ID setoran tidak valid di URL:", window.location.pathname);
    Swal.fire({
      icon: 'error',
      title: 'Kesalahan',
      text: 'ID setoran tidak valid. Silakan kembali ke halaman riwayat.',
    });
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
});
{/literal}
</script>
