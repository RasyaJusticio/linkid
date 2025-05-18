<!-- Tentukan URL iframe berdasarkan parameter yang diterima -->
{if $surah}
    {assign var="iframe_url" value="http://localhost:5173/surah/$surah"}
{elseif $juz}
    {assign var="iframe_url" value="http://localhost:5173/juz/$juz"}
{elseif $halaman}
    {if $halaman >= 1 && $halaman <= 604}
        {assign var="iframe_url" value="http://localhost:5173/page/$halaman"}
    {else}
        {assign var="iframe_url" value="http://localhost:5173/"}
        <div class="alert alert-danger">Nomor halaman tidak valid. Harus antara 1 dan 604 = {$halaman}.</div>
    {/if}
{else}
    {assign var="iframe_url" value="http://localhost:5173/"}
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
  console.log('Iframe URL:', iframe.src);
  const payload = localStorage.getItem('setoranPayload');
  let hasSentMessage = false;

  // Fungsi untuk memvalidasi payload
  function validatePayload(payload) {
    const requiredFields = [
      'user_id', 'user_name', 'penyetor_type', 'penyetor_id', 'penyetor_name',
      'setoran_type', 'tampilkan_type'
    ];
    const errors = [];

    // Cek field yang wajib ada
    requiredFields.forEach(field => {
      if (!payload[field]) {
        errors.push(`Field ${field} tidak boleh kosong`);
      }
    });

    // Validasi penyetor_type
    if (!['grup', 'teman'].includes(payload.penyetor_type)) {
      errors.push('penyetor_type harus "grup" atau "teman"');
    }

    // Validasi setoran_type
    if (!['tahsin', 'tahfidz'].includes(payload.setoran_type)) {
      errors.push('setoran_type harus "tahsin" atau "tahfidz"');
    }

    // Validasi tampilkan_type dan field terkait
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

    // Validasi group_id untuk penyetor_type 'grup'
    if (payload.penyetor_type === 'grup' && !payload.group_id) {
      errors.push('group_id diperlukan untuk penyetor_type "grup"');
    }

    // Validasi bahwa penyetor_id tidak sama dengan user_id
    if (payload.penyetor_id === payload.user_id) {
      errors.push('penyetor_id tidak boleh sama dengan user_id');
    }

    return errors;
  }

  if (payload && iframe && !hasSentMessage) {
    iframe.onload = () => {
      if (hasSentMessage) {
        console.log('⚠️ postMessage sudah dikirim, melewati pengiriman ulang');
        return;
      }

      try {
        const parsedPayload = JSON.parse(payload);

        // Sanitasi dan default values
        const sanitizedPayload = {
          user_id: Number(parsedPayload.user_id) || 0, // Penerima (current user)
          user_name: parsedPayload.user_name || '',
          penyimak_type: ['grup', 'teman'].includes(parsedPayload.penyetor_type) ? parsedPayload.penyetor_type : 'teman',
          penyimak_id: Number(parsedPayload.penyetor_id) || 0, // Penyetor (peserta yang dipilih)
          penyimak_name: parsedPayload.penyetor_name || '',
          setoran_type: ['tahsin', 'tahfidz'].includes(parsedPayload.setoran_type) ? parsedPayload.setoran_type : 'tahfidz',
          tampilkan_type: ['surat', 'juz', 'halaman'].includes(parsedPayload.tampilkan_type) ? parsedPayload.tampilkan_type : 'surat',
          surat_id: parsedPayload.surat_id ? Number(parsedPayload.surat_id) : null,
          surat_name: parsedPayload.surat_name || '',
          juz_id: parsedPayload.juz_id ? Number(parsedPayload.juz_id) : null,
          juz_name: parsedPayload.juz_name || '',
          halaman: parsedPayload.halaman ? Number(parsedPayload.halaman) : null,
          group_id: parsedPayload.penyetor_type === 'grup' ? (Number(parsedPayload.group_id) || null) : null
        };

        // Validasi payload
        const validationErrors = validatePayload(parsedPayload);
        if (validationErrors.length > 0) {
          console.error('❌ Validasi payload gagal:', validationErrors);
          return;
        }

        // Log untuk debugging
        console.log('Parsed payload sebelum postMessage:', sanitizedPayload);

        // Kirim postMessage ke iframe
        iframe.contentWindow.postMessage(sanitizedPayload, 'http://localhost:5173');
        console.log('✅ postMessage dikirim ke iframe:', sanitizedPayload);
        hasSentMessage = true;
        // Jangan hapus setoranPayload dari localStorage agar tetap tersedia jika diperlukan
      } catch (error) {
        console.error('Gagal mengirim postMessage:', error);
      }
    };
  } else {
    console.warn('⚠️ Tidak ada payload atau iframe tidak ditemukan:', { payload, iframe });
  }
});
{/literal}
</script>
