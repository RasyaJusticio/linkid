{assign var="qurani_url" value="{$system['qurani_url']}"}
{if $surah}
    {assign var="iframe_url" value="{$system['qurani_url']}/surah/$surah"}
{elseif $juz}
    {assign var="iframe_url" value="{$system['qurani_url']}/juz/$juz"}
{elseif $halaman}
    {if $halaman >= 1 && $halaman <= 604}
        {assign var="iframe_url" value="{$system['qurani_url']}/page/$halaman"}
    {else}
        {assign var="iframe_url" value="{$system['qurani_url']}/"}
        <div class="alert alert-danger">Nomor halaman tidak valid. Harus antara 1 dan 604 = {$halaman}.</div>
    {/if}
{else}
    {assign var="iframe_url" value="{$system['qurani_url']}/"}
{/if}

<div class="iframe-container" style="position: relative; width: 100%; min-height: calc(100vh - 20px); margin: 0; padding: 0; overflow: hidden;">
  <iframe id="quranFrame" src="{$iframe_url}" 
          style="position: absolute; top: 0px; left: 0; width: 100%; height: calc(100% + 20px); border: none;"
          frameborder="0"
          allowfullscreen
          allow="geolocation; microphone; camera"
          scrolling="auto">
  </iframe>
</div>

<script>
{literal}
document.addEventListener('DOMContentLoaded', function() {
  const iframe = document.getElementById('quranFrame');
  const quraniUrl = "{/literal}{$system['qurani_url']}{literal}";
  console.log('Iframe URL:', iframe.src);
  // Fungsi untuk mengatur title dengan format [Spesifik Title] | Link.id - Sosmed Islami
  function setPageTitleFromPayload(payload) {
    try {
      let baseTitle = 'Quran';
      if (payload.tampilkan_type === 'surat' && payload.surat_name) {
        baseTitle = payload.surat_name; // Misalnya, "Al-Fatihah"
      } else if (payload.tampilkan_type === 'juz' && payload.juz_name) {
        baseTitle = payload.juz_name; // Misalnya, "Juz 2"
      } else if (payload.tampilkan_type === 'halaman' && payload.halaman) {
        baseTitle = `Halaman ${payload.halaman}`; // Misalnya, "Halaman 34"
      }
      const fullTitle = `${baseTitle} | Link.id - Sosmed Islami`;
      document.title = fullTitle;
      console.log('✅ Title diperbarui dari payload:', fullTitle);
    } catch (error) {
      console.error('❌ Gagal mengatur title dari payload:', error);
      document.title = 'Quran | Link.id - Sosmed Islami';
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
      // Gunakan URL favicon yang diberikan
      newFavicon.href = "{/literal}{$system['system_url']|escape:'javascript'}{literal}/content/themes/default/images/LinkId-Icon.png";
      
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

  // Tangani payload
  const payload = localStorage.getItem('setoranPayload');
  let hasSentMessage = false;

  // Fungsi untuk memvalidasi payload
  function validatePayload(payload) {
    const requiredFields = [
      'user_id', 'user_name', 'penyetor_type', 'penyetor_id', 'penyetor_name',
      'setoran_type', 'tampilkan_type'
    ];
    const errors = [];

    requiredFields.forEach(field => {
      if (!payload[field]) {
        errors.push(`Field ${field} tidak boleh kosong`); }
    });

    if (!['grup', 'teman'].includes(payload.penyetor_type)) {
      errors.push('penyetor_type harus "grup" atau "teman"');
    }

    if (!['tahsin', 'tahfidz'].includes(payload.setoran_type)) {
      errors.push('set Favicon harus "tahsin" atau "tahfidz"');
    }

    if (!['surat', 'juz', 'halaman'].includes(payload.tampilkan_type)) {
      errors.push('tampilkan_type harus "surat", "juz", atau "halaman"');
    } else {
      if (payload.tampilkan_type === 'surat' && (!payload.surat_id || !payload.surat_name)) {
        errors.push('surat_id dan surat_name diperlukan untuk tampilkan_type "surat"');
      }
      if (payload.tampilkan_type === 'juz' && (!payload.juz_id || !payload.juz_name)) {
        errors.push('juz_id dan juz_name diperlukan untuk tampilkan_type "juz"');
      }
      if (payload.tampilkan_type === 'halaman' && (!payload.halaman || isNaN(payload.halaman) || payload.halaman < 1 || payload.halaman > 604)) {
        errors.push('halaman harus berupa angka antara 1 dan 604 untuk tampilkan_type "halaman"');
      }
    }

    if (payload.penyetor_type === 'grup' && !payload.group_id) {
      errors.push('group_id diperlukan untuk penyetor_type "grup"');
    }

    if (payload.penyetor_id === payload.user_id) {
      errors.push('penyetor_id tidak boleh sama dengan user_id');
    }

    return errors;
  }

  // Set favicon segera saat halaman dimuat
  setFavicon();

  if (iframe) {
    iframe.onload = () => {
      if (hasSentMessage) {
        console.log('⚠️ postMessage sudah dikirim, melewati pengiriman ulang');
        return;
      }

      if (payload) {
        try {
          const parsedPayload = JSON.parse(payload);

          // Sanitasi dan default values
          const sanitizedPayload = {
            user_id: Number(parsedPayload.user_id) || 0,
            user_name: parsedPayload.user_name || '',
            penyimak_type: ['grup', 'teman'].includes(parsedPayload.penyetor_type) ? parsedPayload.penyetor_type : 'teman',
            penyimak_id: Number(parsedPayload.penyetor_id) || 0,
            penyimak_name: parsedPayload.penyetor_name || '',
            setoran_type: ['tahsin', 'tahfidz'].includes(parsedPayload.setoran_type) ? parsedPayload.setoran_type : 'tahfidz',
            tampilkan_type: ['surat', 'juz', 'halaman'].includes(parsedPayload.tampilkan_type) ? parsedPayload.tampilkan_type : 'surat',
            surat_id: parsedPayload.surat_id ? Number(parsedPayload.surat_id) : null,
            surat_name: parsedPayload.surat_name || '',
            juz_id: parsedPayload.juz_id ? Number(parsedPayload.juz_id) : null,
            juz_name: parsedPayload.juz_name || '',
            halaman: parsedPayload.halaman ? Number(parsedPayload.halaman) : null,
            group_id: parsedPayload.penyetor_type === 'grup' ? (Number(parsedPayload.group_id) || null) : null,
            penyetor_fullname : parsedPayload.penyetor_fullname || '',
          };

          // Validasi payload
          const validationErrors = validatePayload(parsedPayload);
          if (validationErrors.length > 0) {
            console.error('❌ Validasi payload gagal:', validationErrors);
            return;
          }

          // Atur title berdasarkan payload
          setPageTitleFromPayload(sanitizedPayload);

          // Kirim postMessage ke iframe
          iframe.contentWindow.postMessage(sanitizedPayload, quraniUrl);
          console.log('✅ postMessage dikirim ke iframe:', sanitizedPayload);
          hasSentMessage = true;
        } catch (error) {
          console.error('Gagal mengirim postMessage:', error);
          document.title = 'Quran | Link.id - Sosmed Islami';
        }
      } else {
        console.warn('⚠️ Tidak ada payload.');
        document.title = 'Quran | Link.id - Sosmed Islami';
      }
    };
  } else {
    console.warn('⚠️ Iframe tidak ditemukan.');
    document.title = 'Quran | Link.id - Sosmed Islami';
  }
});

// Listener untuk menerima metadata dari iframe (fallback)
window.addEventListener('message', (event) => {
  if (event.origin !== quraniUrl) {
    console.warn('⚠️ Pesan dari origin tidak dikenal:', event.origin);
    return;
  }

  const data = event.data;
  if (data.type === 'updateMetadata') {
    if (data.title) {
      // Pastikan title sudah dalam format yang benar, jika tidak tambahkan akhiran
      const fullTitle = data.title.includes('| Link.id - Sosmed Islami') 
        ? data.title 
        : `${data.title} | Link.id - Sosmed Islami`;
      document.title = fullTitle;
      console.log('✅ Title diperbarui via postMessage:', fullTitle);
    } else {
      console.warn('⚠️ Title tidak ditemukan di postMessage.');
      document.title = 'Quran | Link.id - Sosmed Islami';
    }

    // Untuk metadata dari iframe, tetap gunakan favicon yang ditentukan
    console.log('ℹ️ Mengabaikan favicon dari iframe, menggunakan favicon yang ditentukan');
  }
});
{/literal}
</script>
