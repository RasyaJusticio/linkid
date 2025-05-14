{include file='../_head.tpl'}
{include file='../_header.tpl'}

<!-- Tambahkan Font Awesome untuk ikon -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<!-- Tambahkan Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

<style>
/* Pastikan container tidak mengganti background */
.container,
.container-fluid {
    background-color: transparent !important;
}

/* Pastikan heading terlihat */
h2, h3, h5 {
    color: #fff !important;
}

/* Styling untuk filter dan tabel */
.filter-section {
    background-color: #1f2937;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    margin-bottom: 20px;
    border: 1px solid #4b5563;
}

.filter-section label {
    color: #fff;
}

.filter-section .form-control,
.filter-section .form-select {
    background-color: #374151;
    color: #fff;
    border-color: #4b5563;
}

.filter-section .form-control::placeholder {
    color: #9ca3af;
}

/* Styling ikon date picker */
.filter-section .form-control[type="date"]::-webkit-calendar-picker-indicator {
    filter: invert(1);
}

/* Styling panah dropdown */
.filter-section .form-select {
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="white" class="bi bi-chevron-down" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"/></svg>');
    background-repeat: no-repeat;
    background-position: right 0.75rem center;
    background-size: 16px 16px;
}

.table-section {
    background-color: #1f2937;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    border: 1px solid #4b5563;
}

.table-section table {
    background-color: #1f2937;
    color: #fff;
}

.table-section th {
    background-color: #374151;
    color: #fff;
}

.table-section td {
    background-color: #1f2937;
    color: #fff;
}

.table-section a {
    color: #60a5fa;
    text-decoration: none;
}

.table-section a:hover {
    text-decoration: underline;
}

.btn-primary {
    background-color: #007bff;
    border-color: #007bff;
}

.btn-secondary {
    background-color: #6c757d;
    border-color: #6c757d;
}

.d-flex.align-items-end {
    gap: 10px;
}

/* Styling dropdown input */
.input-dropdown-container {
    position: relative;
    width: 100%;
}

.input-dropdown {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #4b5563;
    border-radius: 6px;
    box-sizing: border-box;
    font-size: 16px;
    background-color: #374151;
    color: #fff;
    transition: border-color 0.3s, box-shadow 0.3s;
}

.input-dropdown:focus {
    outline: none;
    border-color: #007bff;
    box-shadow: 0 0 5px rgba(0,123,255,0.3);
}

.dropdown-menu {
    display: none;
    position: absolute;
    width: 100%;
    max-height: 250px;
    overflow-y: auto;
    border: 1px solid #4b5563;
    border-radius: 6px;
    background-color: #1f2937;
    z-index: 1000;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    margin-top: 2px;
}

.dropdown-item {
    padding: 10px 12px;
    cursor: pointer;
    font-size: 15px;
    color: #fff;
    transition: background-color 0.2s;
}

.dropdown-item:hover {
    background-color: #374151;
}

.dropdown-item.selected {
    background-color: #4b5563;
    font-weight: 500;
}

.form-group.d-flex {
    align-items: center;
}

.form-label {
    white-space: nowrap;
}

/* Styling untuk field yang dinonaktifkan */
.form-control:disabled,
.form-select:disabled {
    background-color: #4b5563;
    opacity: 0.7;
    cursor: not-allowed;
}

/* Styling untuk pesan error */
.error-message {
    color: #dc3545;
    font-size: 14px;
    margin-top: 10px;
}

/* Styling untuk tab content */
.tab-content {
    display: none;
}

.tab-content.active {
    display: block !important;
}

/* Styling untuk chart */
.chart-container {
    position: relative;
    width: 100%;
    max-height: 400px;
}

.chart-container canvas {
    display: block;
    width: 100%;
    max-height: 400px;
}

/* Styling untuk tombol tab */
.tab-buttons {
    margin-bottom: 20px;
}

.tab-button {
    padding: 10px 20px;
    margin-right: 10px;
    background-color: #374151;
    color: #fff;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.2s;
}

.tab-button:hover {
    background-color: #4b5563;
}

.tab-button.active {
    background-color: #007bff;
}
</style>

<!-- Konten halaman -->
<div class="{if $system['fluid_design']}container-fluid{else}container{/if} mt-4">

    <!-- Tombol untuk beralih tab -->
   

    <!-- Bagian Filter -->
    <div id="filter-section" class="tab-content active">
        <div class="filter-section">
            <h5>{__("Filter")}</h5>
            <form method="POST" id="filterForm">
                <div class="row mb-2">
                    <div class="col-md-6 d-flex align-items-center mb-2">
                        <label for="waktu_start" class="form-label me-2 mb-0" style="width: 80px;">{__("Waktu")}</label>
                        <input type="date" name="waktu_start" id="waktu_start" class="form-control" value="{$waktu_start|escape:'html'}" />
                    </div>
                </div>
                <div class="row mb-2">
                    <div class="col-md-6 d-flex align-items-center mb-2">
                        <label for="penyetorInput" class="form-label me-2 mb-0" style="width: 80px;">{__("Penyetor")}</label>
                        <div class="input-dropdown-container">
                            <input type="text" id="penyetorInput" class="input-dropdown form-control" placeholder="{__('Pilih Penyetor')}" autocomplete="off" spellcheck="false">
                            <div id="penyetorDropdown" class="dropdown-menu">
                                {foreach $penyetor_options as $option}
                                    <div class="dropdown-item" data-value="{$option.user_id|escape:'html'}">{$option.user_name|escape:'html'}</div>
                                {/foreach}
                            </div>
                            <input type="hidden" id="selectedPenyetor" name="penyetor" value="{$penyetor|escape:'html'}">
                        </div>
                    </div>
                    <div class="col-md-6 d-flex align-items-center mb-2">
                        <label for="penerimaInput" class="form-label me-2 mb-0" style="width: 80px;">{__("Penerima")}</label>
                        <div class="input-dropdown-container">
                            <input type="text" id="penerimaInput" class="input-dropdown form-control" placeholder="{__('Pilih Penerima')}" autocomplete="off" spellcheck="false">
                            <div id="penerimaDropdown" class="dropdown-menu">
                                {foreach $penerima_options as $option}
                                    <div class="dropdown-item" data-value="{$option.user_id|escape:'html'}">{$option.user_name|escape:'html'}</div>
                                {/foreach}
                            </div>
                            <input type="hidden" id="selectedPenerima" name="penerima" value="{$penerima|escape:'html'}">
                        </div>
                    </div>
                </div>
                <div class="row mb-2">
                    <div class="col-md-6 d-flex align-items-center mb-2">
                        <label for="hasil" class="form-label me-2 mb-0" style="width: 80px;">{__("Hasil")}</label>
                        <select name="hasil" id="hasil" class="form-select">
                            <option value="semua" {if $hasil == 'semua'}selected{/if}>{__("Semua")}</option>
                            <option value="Lancar" {if $hasil == 'Lancar'}selected{/if}>{__("Lancar")}</option>
                            <option value="Tidak Lancar" {if $hasil == 'Tidak Lancar'}selected{/if}>{__("Tidak Lancar")}</option>
                            <option value="Lulus" {if $hasil == 'Lulus'}selected{/if}>{__("Lulus")}</option>
                            <option value="Tidak Lulus" {if $hasil == 'Tidak Lulus'}selected{/if}>{__("Tidak Lulus")}</option>
                            <option value="Mumtaz" {if $hasil == 'Mumtaz'}selected{/if}>{__("Mumtaz")}</option>
                            <option value="Dhoif" {if $hasil == 'Dhoif'}selected{/if}>{__("Dhoif")}</option>
                        </select>
                    </div>
                    <div class="col-md-6 d-flex align-items-center mb-2">
                        <label for="paraf" class="form-label me-2 mb-0" style="width: 80px;">{__("Paraf")}</label>
                        <select name="paraf" id="paraf" class="form-select">
                            <option value="semua" {if $paraf == 'semua'}selected{/if}>{__("Semua")}</option>
                            <option value="1" {if $paraf == '1'}selected{/if}>{__("Ada")}</option>
                            <option value="0" {if $paraf == '0'}selected{/if}>{__("Tidak Ada")}</option>
                        </select>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-6 d-flex" style="margin-left: 78px;">
                        <button type="submit" class="btn btn-primary me-3 px-7" style="min-width: 100px;">{__("Tampilkan")}</button>
                        <button type="button" class="btn btn-secondary px-7" style="min-width: 100px;" onclick="resetForm()">{__("Reset")}</button>
                    </div>
                </div>
            </form>
        </div>
        <!-- Tabel Riwayat -->
        <div class="table-section">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>{__("Waktu")}</th>
                        <th>{__("Penyetor")}</th>
                        <th>{__("Penerima")}</th>
                        <th>{__("Setoran")}</th>
                        <th>{__("Info")}</th>
                        <th>{__("Hasil")}</th>
                        <th>{__("Paraf")}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $recap_history as $history}
                        <tr>
                            <td>{$history.formatted_date|escape:'html'}</td>
                            <td><a href="{$system['system_url']|escape:'html'}/{$history.nama_peserta|escape:'url'}">{$history.nama_peserta|escape:'html'}</a></td>
                            <td><a href="{$system['system_url']|escape:'html'}/{$history.nama_penyimak|escape:'url'}">{$history.nama_penyimak|escape:'html'}</a></td>
                            <td>{$history.awal_surat|escape:'html'}</td>
                            <td>{$history.info|escape:'html'}</td>
                            <td>{$history.kesimpulan_utama|escape:'html'}</td>
                            <td class="text-center">
                                {if $history.paraf == 1}
                                    <i class="fas fa-check text-success"></i>
                                {else}
                                    <i class="fas fa-check text-gray"></i>
                                {/if}
                            </td>
                        </tr>
                    {foreachelse}
                        <tr>
                            <td colspan="7" class="text-center">{__("Tidak ada riwayat setoran")}</td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>

    <!-- Tab Lokasi -->
    <div id="locations" class="tab-content">
        <div class="table-section">
            <div class="row">
                <!-- Top 10 Provinsi -->
                <div class="col-md-6">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th colspan="3">{__("Top 10 Provinsi")}</th>
                            </tr>
                            <tr>
                                <th>{__("No")}</th>
                                <th>{__("Provinsi")}</th>
                                <th>{__("Total")}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach $top_provinces as $province}
                                <tr>
                                    <td>{$province.rank|escape:'html'}</td>
                                    <td>{$province.name|escape:'html'}</td>
                                    <td>{$province.total|escape:'html'}</td>
                                </tr>
                            {foreachelse}
                                <tr>
                                    <td colspan="3" class="text-center">{__("Tidak ada data provinsi")}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
                <!-- Top Kabupaten/Kota -->
                <div class="col-md-6">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th colspan="3">{__("Top Kabupaten/Kota")}</th>
                            </tr>
                            <tr>
                                <th>{__("No")}</th>
                                <th>{__("Kota")}</th>
                                <th>{__("Total")}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach $top_cities as $city}
                                <tr>
                                    <td>{$city.rank|escape:'html'}</td>
                                    <td>{$city.name|escape:'html'}</td>
                                    <td>{$city.total|escape:'html'}</td>
                                </tr>
                            {foreachelse}
                                <tr>
                                    <td colspan="3" class="text-center">{__("Tidak ada data kota")}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row">
                <!-- Polar Area Chart for Provinces -->
                <div class="col-md-6">
                    <div class="chart-container">
                        <canvas id="provinceChart"></canvas>
                    </div>
                </div>
                <!-- Bar Chart for Cities -->
                <div class="col-md-6">
                    <div class="chart-container">
                        <canvas id="cityChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
{literal}
document.addEventListener("DOMContentLoaded", function() {
    // Elemen DOM
    const filterSection = document.getElementById('filter-section');
    const locationsSection = document.getElementById('locations');
    const tabButtons = document.querySelectorAll('.tab-button');

    // Add resetForm to window so it can be called from the button's onclick
    window.resetForm = function() {
        // Reset all form inputs
        document.getElementById('filterForm').reset();
        document.getElementById('selectedPenyetor').value = '';
        document.getElementById('selectedPenerima').value = '';
        document.getElementById('penyetorInput').value = '';
        document.getElementById('penerimaInput').value = '';
        document.getElementById('waktu_start').value = '';
        document.getElementById('hasil').value = 'semua';
        document.getElementById('paraf').value = 'semua';
        // Submit the form with reset values
        document.getElementById('filterForm').submit();
    };

    // Fungsi untuk menampilkan tab tertentu
    window.showTab = function(tabId) {
        console.log('Showing tab:', tabId);
        // Update tab button active state
        tabButtons.forEach(btn => btn.classList.remove('active'));
        const activeButton = document.querySelector(`.tab-button[onclick="showTab('${tabId}')"]`);
        if (activeButton) activeButton.classList.add('active');

        // Update tab content visibility
        if (tabId === 'locations') {
            filterSection.classList.remove('active');
            locationsSection.classList.add('active');
            console.log('Calling loadCharts');
            loadCharts();
        } else {
            filterSection.classList.add('active');
            locationsSection.classList.remove('active');
        }
        // Simpan tab aktif ke localStorage
        localStorage.setItem('activeTab', tabId);
    };

    // Dropdown untuk penyetor dan penerima
    ['penyetor', 'penerima'].forEach(type => {
        const input = document.getElementById(`${type}Input`);
        const dropdown = document.getElementById(`${type}Dropdown`);
        const hiddenInput = document.getElementById(`selected${type.charAt(0).toUpperCase() + type.slice(1)}`);

        // Set nilai awal jika ada
        if (hiddenInput.value) {
            const selectedItem = dropdown.querySelector(`.dropdown-item[data-value="${hiddenInput.value}"]`);
            if (selectedItem) {
                input.value = selectedItem.textContent;
                selectedItem.classList.add('selected');
            }
        }

        input.addEventListener('input', function() {
            const filter = this.value.toLowerCase();
            const items = dropdown.querySelectorAll('.dropdown-item');
            items.forEach(item => {
                const text = item.textContent.toLowerCase();
                item.style.display = text.includes(filter) ? 'block' : 'none';
            });
            dropdown.style.display = 'block';
        });

        input.addEventListener('focus', () => {
            dropdown.style.display = 'block';
        });

        input.addEventListener('blur', () => {
            setTimeout(() => {
                dropdown.style.display = 'none';
            }, 200);
        });

        dropdown.querySelectorAll('.dropdown-item').forEach(item => {
            item.addEventListener('click', function() {
                input.value = this.textContent;
                hiddenInput.value = this.getAttribute('data-value');
                dropdown.style.display = 'none';
                dropdown.querySelectorAll('.dropdown-item').forEach(i => i.classList.remove('selected'));
                this.classList.add('selected');
            });
        });
    });

    // Function to load charts with dynamic data
    function loadCharts() {
        console.log('Loading charts...');
        try {
            // Dynamic data from Smarty for provinces
            const provinceData = {
                labels: [
                    {/literal}
                    {foreach $top_provinces as $province}
                        '{$province.name|escape:'javascript'}'{if !$province@last},{/if}
                    {/foreach}
                    {literal}
                ],
                totals: [
                    {/literal}
                    {foreach $top_provinces as $province}
                        {$province.total|escape:'javascript'}{if !$province@last},{/if}
                    {/foreach}
                    {literal}
                ]
            };

            // Dynamic data from Smarty for cities
            const cityData = {
                labels: [
                    {/literal}
                    {foreach $top_cities as $city}
                        '{$city.name|escape:'javascript'}'{if !$city@last},{/if}
                    {/foreach}
                    {literal}
                ],
                totals: [
                    {/literal}
                    {foreach $top_cities as $city}
                        {$city.total|escape:'javascript'}{if !$city@last},{/if}
                    {/foreach}
                    {literal}
                ]
            };

            // Warna untuk chart (mendukung hingga 10 item)
            const colors = [
                { bg: 'rgba(54, 162, 235, 0.6)', border: 'rgba(54, 162, 235, 1)' },
                { bg: 'rgba(255, 99, 132, 0.6)', border: 'rgba(255, 99, 132, 1)' },
                { bg: 'rgba(75, 192, 192, 0.6)', border: 'rgba(75, 192, 192, 1)' },
                { bg: 'rgba(255, 159, 64, 0.6)', border: 'rgba(255, 159, 64, 1)' },
                { bg: 'rgba(153, 102, 255, 0.6)', border: 'rgba(153, 102, 255, 1)' },
                { bg: 'rgba(255, 205, 86, 0.6)', border: 'rgba(255, 205, 86, 1)' },
                { bg: 'rgba(201, 203, 207, 0.6)', border: 'rgba(201, 203, 207, 1)' },
                { bg: 'rgba(255, 99, 71, 0.6)', border: 'rgba(255, 99, 71, 1)' },
                { bg: 'rgba(144, 238, 144, 0.6)', border: 'rgba(144, 238, 144, 1)' },
                { bg: 'rgba(199, 21, 133, 0.6)', border: 'rgba(199, 21, 133, 1)' }
            ];

            // Polar Area Chart for Provinces
            const provinceCanvas = document.getElementById('provinceChart');
            console.log('Province canvas:', provinceCanvas);
            if (!provinceCanvas) {
                console.error('Province chart canvas not found');
                return;
            }
            const provinceCtx = provinceCanvas.getContext('2d');
            new Chart(provinceCtx, {
                type: 'polarArea',
                data: {
                    labels: provinceData.labels,
                    datasets: [{
                        label: 'Total',
                        data: provinceData.totals,
                        backgroundColor: colors.slice(0, provinceData.labels.length).map(c => c.bg),
                        borderColor: colors.slice(0, provinceData.labels.length).map(c => c.border),
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: true,
                    aspectRatio: 1,
                    plugins: {
                        title: {
                            display: true,
                            text: 'Top Provinsi',
                            color: '#fff',
                            font: {
                                size: 16
                            }
                        },
                        legend: {
                            labels: {
                                color: '#fff'
                            }
                        }
                    },
                    scales: {
                        r: {
                            ticks: {
                                color: '#fff',
                                backdropColor: 'transparent'
                            },
                            grid: {
                                color: '#4b5563'
                            },
                            angleLines: {
                                color: '#4b5563'
                            }
                        }
                    }
                }
            });

            // Bar Chart for Cities
            const cityCanvas = document.getElementById('cityChart');
            console.log('City canvas:', cityCanvas);
            if (!cityCanvas) {
                console.error('City chart canvas not found');
                return;
            }
            const cityCtx = cityCanvas.getContext('2d');
            new Chart(cityCtx, {
                type: 'bar',
                data: {
                    labels: cityData.labels,
                    datasets: [{
                        label: 'Total',
                        data: cityData.totals,
                        backgroundColor: colors.slice(0, cityData.labels.length).map(c => c.bg),
                        borderColor: colors.slice(0, cityData.labels.length).map(c => c.border),
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: true,
                    aspectRatio: 1.5,
                    plugins: {
                        title: {
                            display: true,
                            text: 'Top Kabupaten/Kota',
                            color: '#fff',
                            font: {
                                size: 16
                            }
                        },
                        legend: {
                            labels: {
                                color: '#fff'
                            }
                        }
                    },
                    scales: {
                        x: {
                            ticks: {
                                color: '#fff'
                            },
                            grid: {
                                color: '#4b5563'
                            }
                        },
                        y: {
                            beginAtZero: true,
                            ticks: {
                                color: '#fff'
                            },
                            grid: {
                                color: '#4b5563'
                            }
                        }
                    }
                }
            });
        } catch (error) {
            console.error('Error loading charts:', error);
        }
    }

    // Cek localStorage saat halaman dimuat
    const activeTab = localStorage.getItem('activeTab');
    if (activeTab === 'locations') {
        showTab('locations');
    } else {
        showTab('filter');
    }
});
</script>
{/literal}

{include file='../_footer.tpl'}
