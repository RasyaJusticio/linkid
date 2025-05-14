<div class="card">
    <div class="card-header d-flex justify-content-between">
      <h4 class="card-title">{__('Settings')} › {__('Qurani')} (User)</h4>
    </div>
    <form class="js_ajax-forms" id="user-qurani-settings-form" data-url="settings/qurani">
      <div class="card-body custom-scrollbar">
        <!-- Tata Letak -->
        <div class="d-flex align-items-center mt-1 mb-3">
          <h6 class="heading-small me-5 mt-1">{__('Tata Letak')}</h6>
          <div>
            <div class="form-check ms-4 form-check-inline">
              <input 
                class="form-check-input" 
                type="radio" 
                name="quran_layout" 
                id="layout_fleksibel" 
                value="fleksibel" 
                {if isset($qurani_settings.quran_layout) && $qurani_settings.quran_layout.setting_value == 'fleksibel'}checked{/if}
                data-setting-id="{if isset($qurani_settings.quran_layout)}{$qurani_settings.quran_layout.id}{/if}"
              >
              <label class="form-check-label" for="layout_fleksibel">{__('Fleksibel')}</label>
            </div>
            <div class="form-check form-check-inline ms-4">
              <input 
                class="form-check-input" 
                type="radio" 
                name="quran_layout" 
                id="layout_mushaf" 
                value="mushaf_ustmani" 
                {if isset($qurani_settings.quran_layout) && $qurani_settings.quran_layout.setting_value == 'mushaf_ustmani'}checked{/if}
                data-setting-id="{if isset($qurani_settings.quran_layout)}{$qurani_settings.quran_layout.id}{/if}"
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
            id="font_type" 
            class="form-select" 
            name="font_type" 
            style="width: 48%; height: 30%; margin-left: 70px;" 
            data-setting-id="{if isset($qurani_settings.font_type)}{$qurani_settings.font_type.id}{/if}"
          >
            <option value="IndoPak" {if isset($qurani_settings.font_type) && $qurani_settings.font_type.setting_value == 'IndoPak'}selected{/if}>IndoPak</option>
            <option value="Uthmanic" {if isset($qurani_settings.font_type) && $qurani_settings.font_type.setting_value == 'Uthmanic'}selected{/if}>Uthmanic</option>
          </select>
        </div>

        <!-- Ukuran Font -->
        <div class="d-flex mt-3">
          <h6 class="heading-small me-4 mt-3">{__('Ukuran Font')}</h6>
          <div class="d-flex align-items-center">
            <button type="button" class="btn me-2" style="display: flex; align-items: center; margin-left: -8px; cursor: pointer;" data-action="decrease-font">–</button>
            <span class="h6 fw-bold mt-1" id="font-size-value">{if isset($qurani_settings.font_index)}{$qurani_settings.font_index.setting_value|default:5}{else}5{/if}</span>
            <button type="button" class="btn outline-none ms-2" data-action="increase-font">+</button>
            <input 
              type="hidden" 
              name="font_index" 
              id="font_index" 
              value="{if isset($qurani_settings.font_index)}{$qurani_settings.font_index.setting_value|default:5}{else}5{/if}" 
              data-setting-id="{if isset($qurani_settings.font_index)}{$qurani_settings.font_index.id}{/if}"
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
              id="summary_tampilkan" 
              name="summary_per_page" 
              value="tampilkan" 
              {if isset($qurani_settings.summary_per_page) && $qurani_settings.summary_per_page.setting_value == 'tampilkan'}checked{/if}
              data-setting-id="{if isset($qurani_settings.summary_per_page)}{$qurani_settings.summary_per_page.id}{/if}" 
              class="form-check-input accent-primary" 
              style="margin: 0 4px 0 0;"
            >
            {__('Tampilkan')}
          </label>
          <label for="summary_sembunyikan" style="display: flex; align-items: center; margin-left: 32px; cursor: pointer;">
            <input 
              type="radio" 
              id="summary_sembunyikan" 
              name="summary_per_page" 
              value="sembunyikan" 
              {if isset($qurani_settings.summary_per_page) && $qurani_settings.summary_per_page.setting_value == 'sembunyikan'}checked{/if}
              data-setting-id="{if isset($qurani_settings.summary_per_page)}{$qurani_settings.summary_per_page.id}{/if}" 
              class="form-check-input accent-secondary" 
              style="margin: 0 4px 0 0;"
            >
            {__('Sembunyikan')}
          </label>
        </div>
        <hr />

        <!-- Pengaturan Kesalahan Ayat -->
        <div class="error-labels">
          <div class="d-flex align-items-start mb-3">
            <h6 class="heading-small mb-0">{__('Kesalahan Ayat')}</h6>
            <div class="short-errors d-flex flex-column" style="margin-left: 34px;" id="ayat-errors-container">
              {foreach $qurani_settings as $setting}
                {if in_array($setting.setting_key, ['sa-1', 'sa-2', 'sa-3', 'sa-4', 'sa-5'])}
                  <label class="d-flex align-items-center gap-2 p-2 rounded mb-2" data-setting-id="{$setting.id}" data-setting-key="{$setting.setting_key}">
                    <input 
                      class="form-check-input m-0 flex-shrink-0" 
                      type="checkbox" 
                      id="error_{$setting.setting_key}" 
                      name="error_{$setting.setting_key}" 
                      value="1" 
                      data-setting-id="{$setting.id}" 
                      {if $setting.status}checked{/if}
                    >
                    <span>{$setting.setting_name}</span>
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

        <!-- Pengaturan Kesalahan Kata -->
        <div class="error-labels">
          <div class="d-flex align-items-start mb-3">
            <h6 class="heading-small mb-0">{__('Kesalahan Kata')}</h6>
            <div class="short-errors d-flex flex-column" style="margin-left: 34px;" id="kata-errors-container">
              {foreach $qurani_settings as $setting}
                {if in_array($setting.setting_key, ['sk-1', 'sk-2', 'sk-3', 'sk-4', 'sk-5', 'sk-6', 'sk-7', 'sk-8', 'sk-9', 'sk-10', 'sk-11', 'sk-12', 'sk-13', 'sk-14'])}
                  <label class="d-flex align-items-center gap-2 p-2 rounded mb-2" data-setting-id="{$setting.id}" data-setting-key="{$setting.setting_key}">
                    <input 
                      class="form-check-input m-0 flex-shrink-0" 
                      type="checkbox" 
                      id="error_{$setting.setting_key}" 
                      name="error_{$setting.setting_key}" 
                      value="1" 
                      data-setting-id="{$setting.id}" 
                      {if $setting.status}checked{/if}
                    >
                    <span>{$setting.setting_name}</span>
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
          <button type="button" class="btn btn-primary me-2" name="reset_Default">{__('Reset')}</button>
          <button type="submit" class="btn btn-primary">{__('Simpan')}</button>
        </div>

        <!-- SweetAlert2 & Skrip JavaScript -->
        {literal}
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
          document.addEventListener('DOMContentLoaded', function() {
            const origLabels = {};
            const pendingChanges = {};

            // Color mapping untuk setiap setting_key
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

            // Terapkan warna ke label berdasarkan setting_key
            document.querySelectorAll('.error-labels label[data-setting-key]').forEach(label => {
              const settingKey = label.getAttribute('data-setting-key');
              if (labelColors[settingKey]) {
                label.style.backgroundColor = labelColors[settingKey];
                label.style.color = '#000'; // Pastikan teks tetap terbaca
              }
            });

            // Font size handler
            const fontSizes = [null, '18px', '24px', '30px', '36px', '42px', '48px', '54px', '60px', '66px', '72px'];
            const MIN = 1, MAX = 10;
            const btnDec = document.querySelector('[data-action="decrease-font"]');
            const btnInc = document.querySelector('[data-action="increase-font"]');
            const valEl = document.getElementById('font-size-value');
            const fontIndexInput = document.getElementById('font_index');
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
                updateSetting(fontIndexInput.dataset.settingId, { font_index: fontIndex.toString() });
              }
            });

            btnInc.addEventListener('click', () => {
              if (fontIndex < MAX) {
                fontIndex++;
                updateFontUI();
                updateSetting(fontIndexInput.dataset.settingId, { font_index: fontIndex.toString() });
              }
            });

            updateFontUI();

            // Initialize original labels
            document.querySelectorAll('.error-labels input[type="checkbox"]').forEach(checkbox => {
              const span = checkbox.nextElementSibling;
              origLabels[checkbox.id] = span.textContent.trim();
            });

            // Fungsi untuk mengupdate pengaturan
            function updateSetting(settingId, data) {
              if (settingId && settingId !== 'undefined') {
                pendingChanges[settingId] = { ...pendingChanges[settingId], ...data };
                console.log('Updated pendingChanges:', pendingChanges); // Debugging
              } else {
                console.error('Invalid settingId:', settingId);
              }
            }

            // Handler untuk radio buttons
            document.querySelectorAll('input[type="radio"]').forEach(radio => {
              radio.addEventListener('change', function() {
                const settingId = this.dataset.settingId;
                if (settingId) {
                  updateSetting(settingId, { [this.name]: this.value });
                }
              });
            });

            // Handler untuk select (font_type)
            document.querySelector('#font_type').addEventListener('change', function() {
              const settingId = this.dataset.settingId;
              if (settingId) {
                updateSetting(settingId, { font_type: this.value });
              }
            });

            // Handler untuk checkbox
            document.querySelectorAll('.error-labels input[type="checkbox"]').forEach(checkbox => {
              checkbox.addEventListener('change', function() {
                const settingId = this.dataset.settingId;
                const key = this.name;
                if (settingId) {
                  updateSetting(settingId, { [key]: { status: this.checked ? '1' : '0' } });
                }
              });
            });

            // Handler untuk inline edit
            document.querySelectorAll('.error-labels .edit-icon').forEach(svg => {
              svg.addEventListener('click', function(e) {
                e.preventDefault();
                e.stopPropagation();
                const label = svg.closest('label');
                if (label.querySelector('input.custom-label-input')) return;
                const span = label.querySelector('span');
                const orig = span.textContent.trim();
                const settingId = label.dataset.settingId;
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
                  span.style.display = '';
                  input.remove();
                  if (newValue !== orig && settingId) {
                    updateSetting(settingId, { [label.querySelector('input').name]: { value: newValue } });
                  }
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

            // Reset handler
            const resetBtn = document.querySelector('button[name="reset_Default"]');
            resetBtn.addEventListener('click', async function(e) {
              e.preventDefault();
              Swal.fire({
                title: 'Yakin mau reset?',
                text: 'Semua pengaturan user akan dikembalikan ke pengaturan global.',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Reset',
                cancelButtonText: 'Tidak',
                reverseButtons: true
              }).then(async result => {
                if (result.isConfirmed) {
                  try {
                    const response = await fetch(form.action, {
                      method: 'POST',
                      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                      body: 'reset_Default=1'
                    });
                    const result = await response.json();
                    if (result.success) {
                      Swal.fire({
                        icon: 'success',
                        title: 'Sukses',
                        text: result.message,
                        timer: 1500,
                        showConfirmButton: false
                      }).then(() => {
                        window.location.reload();
                      });
                    } else {
                      Swal.fire({ icon: 'error', title: 'Error', text: result.message });
                    }
                  } catch (error) {
                    Swal.fire({ icon: 'error', title: 'Error', text: 'Gagal mereset: ' + error.message });
                  }
                }
              });
            });

            // Submit form handler
            const form = document.querySelector('#user-qurani-settings-form');
            form.addEventListener('submit', async function(e) {
              e.preventDefault();
              if (Object.keys(pendingChanges).length === 0) {
                Swal.fire({
                  icon: 'info',
                  title: 'Tidak Ada Perubahan',
                  text: 'Tidak ada perubahan untuk disimpan.',
                  timer: 1500,
                  showConfirmButton: false
                });
                return;
              }

              const formData = new FormData();
              Object.entries(pendingChanges).forEach(([settingId, data]) => {
                Object.entries(data).forEach(([key, value]) => {
                  if (typeof value === 'object') {
                    if ('status' in value) {
                      formData.append(key, value.status);
                    } else if ('value' in value) {
                      formData.append(key, value.value);
                    }
                  } else {
                    formData.append(key, value);
                  }
                });
              });

              console.log('Sending formData:', Object.fromEntries(formData)); // Debugging

              try {
                const response = await fetch(form.action, {
                  method: 'POST',
                  body: new URLSearchParams(formData)
                });
                const result = await response.json();
                if (result.success) {
                  Swal.fire({
                    icon: 'success',
                    title: 'Sukses',
                    text: result.message,
                    timer: 1500,
                    showConfirmButton: false
                  }).then(() => {
                    Object.keys(pendingChanges).forEach(key => delete pendingChanges[key]);
                    window.location.reload();
                  });
                } else {
                  Swal.fire({ icon: 'error', title: 'Error', text: result.message });
                }
              } catch (error) {
                Swal.fire({ icon: 'error', title: 'Error', text: 'Gagal menyimpan: ' + error.message });
              }
            });
          });
        </script>
        {/literal}
      </div>
    </form>
  </div>
