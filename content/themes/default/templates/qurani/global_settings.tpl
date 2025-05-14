<!-- Qurani Settings Start -->
  <div class="card">
    <div class="card-header d-flex justify-content-between">
      <h4 class="card-title">{__('Settings')} › {__('Qurani')}</h4>
      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
    </div>
    <form method="POST" action="{$system['system_url']}/admincp/settings/qurani" id="qurani-settings-form">
      <div class="card-body custom-scrollbar">
        {if $success_message}
          <div class="alert alert-success">{__($success_message)}</div>
        {/if}
        {if $error_message}
          <div class="alert alert-danger">{__($error_message)}</div>
        {/if}

        <!-- Tata Letak -->
        <div class="d-flex align-items-center mt-1 mb-3">
          <h6 class="heading-small me-5 mt-1">{__('Tata Letak')}</h6>
          <div>
            <div class="form-check ms-4 form-check-inline">
              <input 
                class="form-check-input" 
                type="radio" 
                name="settings[tata-letak][value]" 
                id="layout_fleksibel" 
                value="fleksibel" 
                {if $qurani_settings['tata-letak']['value'] == 'fleksibel'}checked{/if}
              >
              <label class="form-check-label" for="layout_fleksibel">{__('Fleksibel')}</label>
            </div>
            <div class="form-check form-check-inline ms-4">
              <input 
                class="form-check-input" 
                type="radio" 
                name="settings[tata-letak][value]" 
                id="layout_mushaf" 
                value="mushaf_ustmani" 
                {if $qurani_settings['tata-letak']['value'] == 'mushaf_ustmani'}checked{/if}
              >
              <label class="form-check-label" for="layout_mushaf">{__('Mushaf Ustmani')}</label>
            </div>
          </div>
        </div>
        <hr />

        <!-- Jenis Font -->
        <div class="d-flex align-items-center mb-3">
          <h6 class="heading-small mb-0">{__('Jenis Font')}</h6>
          <select 
            class="form-select" 
            name="settings[font][value]" 
            style="width: 48%; height: 30%; margin-left: 70px;"
          >
            <option value="IndoPak" {if $qurani_settings['font']['value'] == 'IndoPak'}selected{/if}>IndoPak</option>
            <option value="Uthmanic" {if $qurani_settings['font']['value'] == 'Uthmanic'}selected{/if}>Uthmanic</option>
          </select>
        </div>

        <!-- Ukuran Font -->
        <div class="d-flex mt-3">
          <h6 class="heading-small me-4 mt-3">{__('Ukuran Font')}</h6>
          <div class="d-flex align-items-center">
            <button type="button" class="btn me-2" style="display: flex; align-items: center; margin-left: -8px; cursor: pointer;" data-action="decrease-font">–</button>
            <span class="h6 fw-bold mt-1" id="font-size-value">{$qurani_settings['font-size']['value']|default:5}</span>
            <button type="button" class="btn outline-none ms-2" data-action="increase-font">+</button>
            <input 
              type="hidden" 
              name="settings[font-size][value]" 
              id="font-size" 
              value="{$qurani_settings['font-size']['value']|default:5}"
            >
          </div>
        </div>
        <div id="bismillah-text" style="margin-left: 144px;">
          بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ
        </div>
        <hr />

        <!-- Kesimpulan Per Halaman -->
        <div style="display: flex; align-items: center; margin: 4px 0 12px;">
          <h6 class="heading-small" style="margin: 0 20px 0 0;">{__('Kesimpulan Per <br> Halaman')}</h6>
          <label for="summary_tampilkan" style="display: flex; align-items: center; margin-left: 22px; cursor: pointer;">
            <input 
              type="radio" 
              name="settings[kesimpulan][value]" 
              id="summary_tampilkan" 
              value="tampilkan" 
              {if $qurani_settings['kesimpulan']['value'] == 'tampilkan'}checked{/if} 
              class="form-check-input accent-primary" 
              style="margin: 0 4px 0 0;"
            >
            {__('Tampilkan')}
          </label>
          <label for="summary_sembunyikan" style="display: flex; align-items: center; margin-left: 32px; cursor: pointer;">
            <input 
              type="radio" 
              name="settings[kesimpulan][value]" 
              id="summary_sembunyikan" 
              value="sembunyikan" 
              {if $qurani_settings['kesimpulan']['value'] == 'sembunyikan'}checked{/if} 
              class="form-check-input accent-secondary" 
              style="margin: 0 4px 0 0;"
            >
            {__('Sembunyikan')}
          </label>
        </div>
        <hr />

        <!-- Pengaturan Global Per Ayat -->
        <div class="error-labels">
          <div class="d-flex align-items-start mb-3">
            <h6 class="heading-small mb-0">{__('Kesalahan Ayat')}</h6>
            <div class="short-errors d-flex flex-column" style="margin-left: 34px;">
              {foreach $qurani_settings as $key => $setting}
                {if in_array($key, ['sa-1', 'sa-2', 'sa-3', 'sa-4', 'sa-5'])}
                  <label 
                    class="d-flex align-items-center gap-2 p-2 rounded mb-2" 
                    data-key="{$key}" 
                    id="label-{$key}"
                  >
                    <input 
                      type="hidden" 
                      name="settings[{$key}][value]" 
                      value="{$setting['value']}" 
                      class="setting-value"
                    >
                    <input 
                      class="form-check-input m-0 flex-shrink-0" 
                      type="checkbox" 
                      name="settings[{$key}][status]" 
                      value="1" 
                      {if $setting['status']}checked{/if}
                    >
                    <span>{if $setting['value']}{$setting['value']}{else}Tidak Diketahui{/if}</span>
                    <svg 
                      xmlns="http://www.w3.org/2000/svg" 
                      width="18" 
                      height="18" 
                      viewBox="0 0 24 24" 
                      fill="none" 
                      class="ms-auto edit-icon" 
                      style="cursor: pointer;"
                    >
                      <path d="M11 4H7.2C6.08 4 5.52 4 5.09 4.22C4.72 4.41 4.41 4.72 4.22 5.09C4 5.52 4 6.08 4 7.2V16.8C4 17.92 4 18.48 4.22 18.91C4.41 19.28 4.72 19.59 5.09 19.78C5.52 20 6.08 20 7.2 20H16.8C17.92 20 18.48 20 18.91 19.78C19.28 19.59 19.59 19.28 19.78 18.91C20 18.48 20 17.92 20 16.8V12.5M15.5 5.5L18.33 8.33M10.76 10.24L17.41 3.59C18.19 2.81 19.46 2.81 20.24 3.59C21.02 4.37 21.02 5.64 20.24 6.42L13.38 13.28C12.62 14.04 12.24 14.42 11.80 14.72C11.42 14.99 11.00 15.22 10.56 15.39C10.07 15.58 9.57 15.69 8.49 15.90L8 16L8.05 15.67C8.22 14.49 8.30 13.90 8.49 13.36C8.66 12.87 8.89 12.41 9.18 11.98C9.50 11.50 9.92 11.08 10.76 10.24Z" stroke="#000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                  </label>
                {/if}
              {/foreach}
            </div>
          </div>
        </div>
        <hr />

        <!-- Pengaturan Global Per Kata -->
        <div class="error-labels">
          <div class="d-flex align-items-start mb-3">
            <h6 class="heading-small mb-0">{__('Kesalahan Kata')}</h6>
            <div class="short-errors d-flex flex-column" style="margin-left: 34px;">
              {foreach $qurani_settings as $key => $setting}
                {if in_array($key, ['sk-1', 'sk-2', 'sk-3', 'sk-4', 'sk-5', 'sk-6', 'sk-7', 'sk-8', 'sk-9', 'sk-10', 'sk-11', 'sk-12', 'sk-13', 'sk-14'])}
                  <label 
                    class="d-flex align-items-center gap-2 p-2 rounded mb-2" 
                    data-key="{$key}" 
                    id="label-{$key}"
                  >
                    <input 
                      type="hidden" 
                      name="settings[{$key}][value]" 
                      value="{$setting['value']}" 
                      class="setting-value"
                    >
                    <input 
                      class="form-check-input m-0 flex-shrink-0" 
                      type="checkbox" 
                      name="settings[{$key}][status]" 
                      value="1" 
                      {if $setting['status']}checked{/if}
                    >
                    <span>{if $setting['value']}{$setting['value']}{else}Tidak Diketahui{/if}</span>
                    <svg 
                      xmlns="http://www.w3.org/2000/svg" 
                      width="18" 
                      height="18" 
                      viewBox="0 0 24 24" 
                      fill="none" 
                      class="ms-auto edit-icon" 
                      style="cursor: pointer;"
                    >
                      <path d="M11 4H7.2C6.08 4 5.52 4 5.09 4.22C4.72 4.41 4.41 4.72 4.22 5.09C4 5.52 4 6.08 4 7.2V16.8C4 17.92 4 18.48 4.22 18.91C4.41 19.28 4.72 19.59 5.09 19.78C5.52 20 6.08 20 7.2 20H16.8C17.92 20 18.48 20 18.91 19.78C19.28 19.59 19.59 19.28 19.78 18.91C20 18.48 20 17.92 20 16.8V12.5M15.5 5.5L18.33 8.33M10.76 10.24L17.41 3.59C18.19 2.81 19.46 2.81 20.24 3.59C21.02 4.37 21.02 5.64 20.24 6.42L13.38 13.28C12.62 14.04 12.24 14.42 11.80 14.72C11.42 14.99 11.00 15.22 10.56 15.39C10.07 15.58 9.57 15.69 8.49 15.90L8 16L8.05 15.67C8.22 14.49 8.30 13.90 8.49 13.36C8.66 12.87 8.89 12.41 9.18 11.98C9.50 11.50 9.92 11.08 10.76 10.24Z" stroke="#000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                  </label>
                {/if}
              {/foreach}
            </div>
          </div>
        </div>

        <div class="d-flex justify-content-end mt-4 me-3">
          <button type="button" id="reset-qurani-settings" class="btn btn-secondary me-2">{__('Reset')}</button>
          <button type="submit" name="update_qurani_settings" class="btn btn-primary">{__('Simpan')}</button>
        </div>
      </div>
    </form>

    <!-- JavaScript untuk Ukuran Font, Inline Editing, Reset, dan Submit Alert -->
    {literal}
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
      // Peta warna untuk label berdasarkan kunci database
      const labelColors = {
        "sa-1": "#CCCCCC",
        "sa-2": "#99CCFF",
        "sa-3": "#DFF18F",
        "sa-4": "#F4ACB6", 
        "sa-5": "#FA7656",
        "sk-1": "#FFCC99",
        "sk-2": "#F4A384",
        "sk-3": "#F8DD74",
        "sk-4": "#D5B6D4",
        "sk-5": "#B5C9DF",
        "sk-6": "#FE7D8F",
        "sk-7": "#A1D4CF",
        "sk-8": "#90CBAA",
        "sk-9": "#FA7656",
        "sk-10": "#FE7D8F",
        "sk-11": "#90CBAA",
        "sk-12": "#F8DD74",
        "sk-13": "#CC99CC",
        "sk-14": "#CCCCCC" 
      };

      // Terapkan warna ke label saat halaman dimuat
      document.querySelectorAll('.error-labels label').forEach(label => {
        const key = label.getAttribute('data-key');
        const color = labelColors[key] || '#CCCCCC'; // Fallback
        label.style.backgroundColor = color;
        label.style.color = ['#F8DD74', '#DFF18F'].includes(color) ? '#333' : '#000'; // Kontras untuk warna terang
      });

      // Ukuran Font
      const fontSizes = [null, '18px', '24px', '30px', '36px', '42px', '48px', '54px', '60px', '66px', '72px'];
      const MIN = 1, MAX = 10;
      const btnDec = document.querySelector('[data-action="decrease-font"]');
      const btnInc = document.querySelector('[data-action="increase-font"]');
      const valEl = document.getElementById('font-size-value');
      const fontIndexInput = document.getElementById('font-size');
      const textEl = document.getElementById('bismillah-text');
      let fontIndex = parseInt(valEl.textContent, 10);
      if (isNaN(fontIndex) || fontIndex < MIN || fontIndex > MAX) fontIndex = 5;

      function updateFontUI() {
        valEl.textContent = fontIndex;
        fontIndexInput.value = fontIndex;
        textEl.style.fontSize = fontSizes[fontIndex];
        btnDec.disabled = fontIndex === MIN;
        btnInc.disabled = fontIndex === MAX;
      }

      btnDec.addEventListener('click', () => {
        if (fontIndex > MIN) {
          fontIndex--;
          updateFontUI();
        }
      });

      btnInc.addEventListener('click', () => {
        if (fontIndex < MAX) {
          fontIndex++;
          updateFontUI();
        }
      });

      updateFontUI();

      // Inline Editing
      document.querySelectorAll('.edit-icon').forEach(svg => {
        svg.addEventListener('click', function(e) {
          e.preventDefault();
          e.stopPropagation();
          const label = svg.closest('label');
          if (label.querySelector('input.custom-label-input')) return;
          const span = label.querySelector('span');
          const hiddenInput = label.querySelector('.setting-value');
          const orig = span.textContent.trim();
          const input = document.createElement('input');
          input.type = 'text';
          input.value = orig;
          input.className = 'form-control form-control-sm custom-label-input';
          input.style.maxWidth = '100%';
          label.insertBefore(input, span);
          span.style.display = 'none';
          input.focus();

          function commit() {
            const newValue = input.value.trim() || orig;
            span.textContent = newValue;
            hiddenInput.value = newValue;
            span.style.display = '';
            input.remove();
            // Warna tidak berubah karena terkait kunci, bukan nilai
          }

          input.addEventListener('blur', commit);
          input.addEventListener('keydown', ev => {
            if (ev.key === 'Enter') {
              ev.preventDefault();
              input.blur();
            }
          });
        });
      });

      // Reset Confirmation
      const resetBtn = document.querySelector('#reset-qurani-settings');
      resetBtn.addEventListener('click', function(e) {
        e.preventDefault();
        Swal.fire({
          title: 'Yakin mau reset?',
          text: 'Semua pengaturan akan dikembalikan ke default.',
          icon: 'warning',
          showCancelButton: true,
          confirmButtonText: 'Reset',
          cancelButtonText: 'Batal',
          reverseButtons: true
        }).then(result => {
          if (result.isConfirmed) {
            const form = document.querySelector('#qurani-settings-form');
            const formData = new FormData(form);
            formData.append('reset_qurani_settings', '1');
            fetch(form.action, {
              method: 'POST',
              body: formData
            })
            .then(response => response.json())
            .then(data => {
              if (data.success) {
                Swal.fire({
                  icon: 'success',
                  title: 'Sukses',
                  text: data.message,
                  timer: 1500,
                  showConfirmButton: false
                }).then(() => {
                  window.location.reload();
                });
              } else {
                Swal.fire({
                  icon: 'error',
                  title: 'Error',
                  text: data.message
                });
              }
            })
            .catch(error => {
              Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'Gagal mereset: ' + error.message
              });
            });
          }
        });
      });

      // Form Submit Handler dengan AJAX
      const form = document.querySelector('#qurani-settings-form');
      form.addEventListener('submit', function(e) {
        e.preventDefault();
        const formData = new FormData(form);
        formData.append('update_qurani_settings', '1');
        fetch(form.action, {
          method: 'POST',
          body: formData
        })
        .then(response => response.json())
        .then(data => {
          if (data.success) {
            Swal.fire({
              icon: 'success',
              title: 'Sukses',
              text: data.message,
              timer: 1500,
              showConfirmButton: false
            }).then(() => {
              window.location.reload();
            });
          } else {
            Swal.fire({
              icon: 'error',
              title: 'Error',
              text: data.message
            });
          }
        })
        .catch(error => {
          Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'Gagal menyimpan: ' + error.message
          });
        });
      });
    </script>
    {/literal}
  </div>
<!-- Qurani Settings End -->
