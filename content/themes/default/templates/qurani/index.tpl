{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- Add Font Awesome for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!-- Load Leaflet from CDN -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/leaflet.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/leaflet.min.js"></script>
<!-- Load Leaflet MarkerCluster -->
<link rel="stylesheet" href="https://unpkg.com/leaflet.markercluster@1.5.3/dist/MarkerCluster.css" />
<link rel="stylesheet" href="https://unpkg.com/leaflet.markercluster@1.5.3/dist/MarkerCluster.Default.css" />
<script src="https://unpkg.com/leaflet.markercluster@1.5.3/dist/leaflet.markercluster.js"></script>
<!-- Load SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style><style>
/* Styling untuk peta dan kontrol */
body {
  background-color: #f8f9fa;
}

.map-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: -10px;
}

.map-controls {
  display: flex;
  gap: 8px;
}

.btn-sm.btn-outline-secondary {
  padding: 4px 8px;
  font-size: 14px;
  line-height: 1.5;
  border-radius: 4px;
  background-color: #6c757d; /* Abu-abu, sesuai dengan tema Bootstrap untuk secondary */
  border-color: #6c757d; /* Border sama dengan background agar terlihat menyatu */
  transition: none; /* Hapus transisi agar tidak ada animasi saat hover */
}

.btn-sm.btn-outline-secondary:hover {
  background-color: #6c757d; /* Pastikan background tetap abu-abu saat hover */
  border-color: #ffffff; /* Border tetap sama */
}

.fas {
  font-size: 16px;
  color: #ffffff; /* Putih */
  vertical-align: middle;
}


#userTable {
  display: none;
  position: absolute;
  top: 50px;
  right: 10px;
  background: white;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.15);
  z-index: 1000;
  max-height: 300px;
  overflow-y: auto;
  max-width: 300px;
}

#map {
  border-radius: 4px;
  overflow: hidden;
  width: 100%;
  height: 400px;
  position: relative;
  transition: height 0.3s ease;
}

.map-card {
  transition: all 0.3s ease;
  position: relative;
  z-index: 1;
}

.map-card.fullscreen {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 10000;
  background: #f8f9fa;
  margin: 0;
  padding: 0;
  box-shadow: none;
  border-radius: 0;
  height: 100vh;
  width: 100vw;
  display: flex;
  flex-direction: column;
}

.map-card.fullscreen .map-header {
  padding: 1rem;
  color: white;
  border-bottom: none;
  z-index: 10001;
}

.map-card.fullscreen #map {
  height: calc(100vh - 60px);
  flex-grow: 1;
}

/* Sembunyikan header utama saat fullscreen */
body.map-fullscreen .main-header,
body.map-fullscreen .js_sticky-header {
  display: none !important;
}

@media (max-width: 768px) {
  .map-card.fullscreen {
    padding: 0;
  }
  
  .map-card.fullscreen #map {
    height: calc(100vh - 50px);
  }

  .map-card {
    padding: 1rem;
    min-height: 200px;
  }

  #map {
    height: 200px;
    min-height: 150px;
  }

  #map p {
    font-size: 14px;
    color: #dc3545;
    text-align: center;
    margin: 0;
    padding: 1rem;
    background-color: #f8d7da;
    border-radius: 4px;
  }

  .map-controls {
    gap: 6px;
  }

  .btn-sm.btn-outline-secondary {
    padding: 4px 6px;
    font-size: 12px;
  }

  .fas {
    font-size: 14px;
  }
}

.leaflet-control-zoom {
  box-shadow: 0 2px 5px rgba(0,0,0,0.2) !important;
}

.leaflet-control-zoom a {
  transition: background-color 0.2s ease;
}

.cursor-pointer {
  cursor: pointer;
}

.input-dropdown-container {
  position: relative;
  width: 100%;
}

.input-dropdown {
  width: 100%;
  padding: 10px 12px;
  border: 1px solid #ced4da;
  border-radius: 6px;
  box-sizing: border-box;
  font-size: 16px;
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
  border: 1px solid #ced4da;
  border-radius: 6px;
  background-color: #fff;
  z-index: 1000;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  margin-top: 2px;
}

.dropdown-item {
  padding: 10px 12px;
  cursor: pointer;
  font-size: 15px;
  color: #333;
  transition: background-color 0.2s;
}

.form-group.d-flex {
  align-items: center;
  margin-bottom: 1.5rem;
}

.card {
  display: grid;
  grid-template-columns: 1fr;
  gap: 1.5rem;
}

.history-card {
  min-height: fit-content;
  max-height: none !important;
}

.radio-group-container {
  display: flex;
  align-items: center;
  margin-bottom: 1.5rem;
}

.radio-group-container .form-label {
  min-width: 110px;
  margin-bottom: 0;
  margin-right: 1rem;
}

.radio-group {
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 20px;
  margin-left: 0;
}

.radio-option {
  display: flex;
  align-items: center;
}

.radio-option input[type="radio"] {
  margin-right: 5px;
}

.form-group.d-flex {
  align-items: center;
}

.form-group.d-flex .form-label {
  min-width: 110px;
  margin-right: 1rem;
}

.input-dropdown-container {
  flex: 1;
}

.action-buttons {
  margin-top: 2rem;
  padding-left: 0;
  display: flex;
  align-items: center;
  gap: 15px;
  margin-left: 25%;
}

.action-buttons button {
  margin-right: 15px;
  margin-left: 0;
}

.form-group {
  margin-bottom: 1.5rem;
}

.form-label {
  margin-bottom: 0;
}

.paraf-clickable {
  cursor: pointer;
  transition: color 0.2s;
}

.paraf-clickable:hover i {
  color: #007bff !important;
}
/* Responsive table styles */
.table-responsive {
  overflow-x: auto;
  -webkit-overflow-scrolling: touch;
}

.table {
  width: 100%;
  margin-bottom: 1rem;
  font-size: 16px;
}

.table th,
.table td {
  padding: 12px 8px;
  vertical-align: middle;
  white-space: nowrap;
}

.table thead th {
  font-weight: 600;
}
.surah-quick-select {
  margin-top: 0.5rem;
  margin-left: 126px;
}

.surah-quick-btn {
  padding: 6px 12px;
  font-size: 14px;
  border-radius: 12px;
  transition: all 0.2s ease;
  white-space: nowrap;
}


/* Medium screens (tablets, 768px and below) */
@media (max-width: 768px) {
  .table {
    font-size: 14px;
  }
  
  .table th,
  .table td {
    padding: 8px 6px;
  }

  .form-group.d-flex {
    flex-direction: column;
    align-items: flex-start;
    gap: 0.5rem;
    padding: 0 0.5rem;
  }

  .form-group .form-label {
    min-width: 100%;
    margin-bottom: 0.25rem;
    font-weight: 600;
  }

  .input-dropdown-container {
    width: 100%;
  }

  .input-dropdown {
    font-size: 14px;
    padding: 8px;
  }

  .radio-group {
    flex-direction: column;
    align-items: flex-start;
    gap: 0.75rem;
    margin-left: 0;
  }

  .radio-option {
    margin-bottom: 0;
    font-size: 14px;
  }

  .radio-option input[type="radio"] {
    margin-right: 8px;
    transform: scale(1.2);
  }

  .surah-quick-select {
    margin-left: 0;
    flex-direction: column;
    gap: 0.5rem;
    width: 100%;
  }

  .surah-quick-btn {
    width: 100%;
    text-align: center;
    font-size: 14px;
    padding: 8px;
    border-radius: 8px;
  }

  .action-buttons {
    flex-direction: column;
    align-items: stretch;
    gap: 0.75rem;
    margin-left: 0;
    padding: 0 0.5rem;
  }

  .action-buttons button {
    width: 100%;
    padding: 10px;
    font-size: 16px;
  }

  .card {
    padding: 1rem;
    margin: 0 0.5rem;
    gap: 1rem;
  }

  @media (max-width: 768px) {
  .map-header {
    flex-direction: row; /* Tetap horizontal */
    justify-content: space-between; /* Memisahkan tulisan dan ikon */
    align-items: center; /* Rata tengah vertikal */
    gap: 0.5rem; /* Jarak antar elemen */
  }

  .map-header h3 {
    font-size: 1.25rem;
    margin-bottom: 0;
    margin-right: auto; /* Membuat tulisan menempel ke kiri */
  }

  .map-controls {
    display: flex;
    gap: 0.5rem;
  }

  .btn-sm.btn-outline-secondary {
    padding: 4px 6px;
    font-size: 12px;
  }

  .fas {
    font-size: 14px;
  }

  .container, .container-fluid {
    padding: 0 0.5rem;
  }

  .table-responsive {
    border: none;
  }

  .table {
    font-size: 13px;
    border-collapse: collapse;
  }

  .table thead {
    display: none;
  }

  .table tbody tr {
    display: block;
    margin-bottom: 1rem;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    background-color: #fff;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
  }

  .table tbody td {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
    border: none;
    border-bottom: 1px solid #dee2e6;
    text-align: left;
    white-space: normal;
  }

  .table tbody td:last-child {
    border-bottom: none;
  }

  .table tbody td:before {
    content: attr(data-label);
    font-weight: 600;
    color: #333;
    flex: 1;
    padding-right: 10px;
  }

  .table tbody td:nth-child(3),
  .table tbody td:nth-child(6) {
    display: none;
  }
}

.tooltip-inner {
  background-color: #007bff;
  color: white;
  font-size: 14px;
  padding: 6px 12px;
  border-radius: 4px;
}

.bs-tooltip-top .tooltip-arrow::before {
  border-top-color: #007bff;
}

.bs-tooltip-bottom .tooltip-arrow::before {
  border-bottom-color: #007bff;
}

.bs-tooltip-start .tooltip-arrow::before {
  border-left-color: #007bff;
}

.bs-tooltip-end .tooltip-arrow::before {
  border-right-color: #007bff;
}

.surah-quick-btn:active {
  transform: scale(0.95); /* Efek sedikit mengecil saat diklik */
  transition: transform 0.1s ease;
}

body.light-mode .fa-cog {
  color: #333;
}

body.dark-mode .fa-cog {
  color: #fff;
}

/* Hapus efek klik yang menyebabkan warna tetap */
  .surah-quick-btn:focus,
  .surah-quick-btn:active,
  .surah-quick-btn.active {
    background-color: transparent !important;
    color: #0d6efd !important;
    border-color: #0d6efd !important;
    box-shadow: none !important;
  }

  /* Warna hanya saat hover */
  .surah-quick-btn:hover {
    background-color: #0d6efd !important;
    color: #fff !important;
  }

/* Small screens (mobile, 576px and below) */
@media (max-width: 576px) {
  .table {
    font-size: 13px;
  }
}
}
</style>

<!-- page header -->
<div class="circle-2"></div>
<div class="circle-3"></div>
<div class="inner">
  <h2 class="fw-bold">{__("")}</h2>
  <p class="text-muted">{__("")}</p>
</div>

<!-- page content -->
<div class="{if $system['fluid_design']}container-fluid{else}container{/if} sg-offcanvas mt-3">
  <div class="row">
    <!-- Form Qurani -->
    <div class="col-lg-6 col-md-12 col-12 mb-3">
      <div class="card shadow-lg p-3 rounded h-100">
        <div class="map-header">
          <h3 class="text-start mb-0">{__("Qurani")}</h3>
          <div class="map-controls">
            <button class="btn btn-sm btn-outline-secondary" id="settingsBtn" title="{__("Qurani Setting")}" onclick="window.location.href='{$system['system_url']}/settings/qurani'">
              <i class="fas fa-cog text-gray-800 dark:text-white"></i>
            </button>
          </div>
        </div>
        <form method="POST" id="setoranForm">
          <!-- Penyetor -->
<div class="radio-group-container">
  <label class="form-label fw-bold">{__("Reciter")}</label>
  <div class="radio-group">
    <div class="radio-option">
      <input type="radio" id="grup" name="penyetor" value="grup" checked autocomplete="off" spellcheck="false">
      <label for="grup">{__("Group")}</label>
    </div>
    <div class="radio-option">
      <input type="radio" id="teman" name="penyetor" value="teman" autocomplete="off" spellcheck="false">
      <label for="teman">{__("Friend")}</label>
    </div>
  </div>
</div>

<!-- Grup-anggota section -->
<div class="mb-3" id="grup-anggota">
  <div class="radio-group-container">
    <label class="form-label fw-bold">{__("Group")}</label>
    <div class="input-dropdown-container w-100">
      <input type="text" id="groupInput" class="input-dropdown form-control" placeholder="{__("Select Group")}" autocomplete="off" spellcheck="false" {if isset($all_groups.no_groups)}disabled{/if}>
      <div id="groupDropdown" class="dropdown-menu">
        {if isset($all_groups.no_groups)}
          <div class="dropdown-item" data-value="0">{__("Join a group first")}</div>
        {else}
          {foreach $all_groups as $group}
            <div class="dropdown-item" data-value="{$group.group_id|escape:'html'}">{$group.group_title|escape:'html'}</div>
          {/foreach}
        {/if}
      </div>
      <input type="hidden" id="selectedGroup" name="grup">
    </div>
  </div>
  <div class="radio-group-container">
    <label class="form-label fw-bold">{__("Member")}</label>
    <div class="input-dropdown-container w-100">
      <input type="text" 
              id="memberInput" class="input-dropdown form-control" placeholder="{if isset($all_groups.no_groups)}{__("Join a group first")}{else}{__("Select a group first")}{/if}" disabled autocomplete="off" spellcheck="false">
      <div id="memberDropdown" class="dropdown-menu"></div>
      <input type="hidden" id="selectedMember" name="anggota">
    </div>
  </div>
</div>

<!-- Teman select -->
<div class="mb-3" id="teman-select" style="display: none;">
  <div class="radio-group-container">
    <label class="form-label fw-bold">Teman</label>
    <div class="input-dropdown-container w-100">
      <input type="text" id="temanInput" class="input-dropdown form-control" placeholder="Pilih teman" autocomplete="off" spellcheck="false">
      <div id="temanDropdown" class="dropdown-menu">
        {foreach $all_users as $user}
          <div class="dropdown-item" data-value="{$user.user_id|escape:'html'}" data-username="{$user.user_name|escape:'html'}">{$user.fullname|escape:'html'}</div>
        {/foreach}
      </div>
      <input type="hidden" id="selectedTeman" name="teman">
    </div>
  </div>
</div>

          <!-- Setoran -->
          <div class="radio-group-container">
            <label class="form-label fw-bold">{__("Recite")}</label>
            <div class="radio-group">
              <div class="radio-option">
                <input type="radio" id="tahsin" name="setoran" value="tahsin" checked>
                <label for="tahsin">Tahsin</label>
              </div>
              <div class="radio-option">
                <input type="radio" id="tahfidz" name="setoran" value="tahfidz">
                <label for="tahfidz">Tahfidz</label>
              </div>
            </div>
          </div>

          <!-- Tampilkan -->
          <div class="radio-group-container">
            <label class="form-label fw-bold">{__("Display")}</label>
            <div class="radio-group">
              <div class="radio-option">
                <input type="radio" id="surat" name="tampilkan" value="surat" checked>
                <label for="surat">Surat</label>
              </div>
              <div class="radio-option">
                <input type="radio" id="juz" name="tampilkan" value="juz">
                <label for="juz">Juz  </label>
              </div>
              <div class="radio-option">
                <input type="radio" id="halaman" name="tampilkan" value="halaman">
                <label for="halaman">Halaman</label>
              </div>
            </div>
          </div>

          <!-- Surat select -->
          <div class="mb-3" id="surat-select">
  <div class="radio-group-container">
    <label class="form-label fw-bold">{__("Surah")}</label>
    <div class="input-dropdown-container w-100">
      <input type="text" id="suratInput" class="input-dropdown form-control" placeholder="{__("Select Surah")}" autocomplete="off" spellcheck="false">
      <div id="suratDropdown" class="dropdown-menu">
        <div class="dropdown-item" data-value="1">Al-Fatihah (1)</div>
<div class="dropdown-item" data-value="2">Al-Baqarah (2)</div>
<div class="dropdown-item" data-value="3">Ali 'Imran (3)</div>
<div class="dropdown-item" data-value="4">An-Nisa (4)</div>
<div class="dropdown-item" data-value="5">Al-Ma'idah (5)</div>
<div class="dropdown-item" data-value="6">Al-An'am (6)</div>
<div class="dropdown-item" data-value="7">Al-A'raf (7)</div>
<div class="dropdown-item" data-value="8">Al-Anfal (8)</div>
<div class="dropdown-item" data-value="9">At-Taubah (9)</div>
<div class="dropdown-item" data-value="10">Yunus (10)</div>
<div class="dropdown-item" data-value="11">Hud (11)</div>
<div class="dropdown-item" data-value="12">Yusuf (12)</div>
<div class="dropdown-item" data-value="13">Ar-Ra'd (13)</div>
<div class="dropdown-item" data-value="14">Ibrahim (14)</div>
<div class="dropdown-item" data-value="15">Al-Hijr (15)</div>
<div class="dropdown-item" data-value="16">An-Nahl (16)</div>
<div class="dropdown-item" data-value="17">Al-Isra (17)</div>
<div class="dropdown-item" data-value="18">Al-Kahf (18)</div>
<div class="dropdown-item" data-value="19">Maryam (19)</div>
<div class="dropdown-item" data-value="20">Ta-Ha (20)</div>
<div class="dropdown-item" data-value="21">Al-Anbiya (21)</div>
<div class="dropdown-item" data-value="22">Al-Hajj (22)</div>
<div class="dropdown-item" data-value="23">Al-Mu'minun (23)</div>
<div class="dropdown-item" data-value="24">An-Nur (24)</div>
<div class="dropdown-item" data-value="25">Al-Furqan (25)</div>
<div class="dropdown-item" data-value="26">Asy-Syu'ara (26)</div>
<div class="dropdown-item" data-value="27">An-Naml (27)</div>
<div class="dropdown-item" data-value="28">Al-Qasas (28)</div>
<div class="dropdown-item" data-value="29">Al-Ankabut (29)</div>
<div class="dropdown-item" data-value="30">Ar-Rum (30)</div>
<div class="dropdown-item" data-value="31">Luqman (31)</div>
<div class="dropdown-item" data-value="32">As-Sajdah (32)</div>
<div class="dropdown-item" data-value="33">Al-Ahzab (33)</div>
<div class="dropdown-item" data-value="34">Saba' (34)</div>
<div class="dropdown-item" data-value="35">Fatir (35)</div>
<div class="dropdown-item" data-value="36">Yasin (36)</div>
<div class="dropdown-item" data-value="37">As-Saffat (37)</div>
<div class="dropdown-item" data-value="38">Sad (38)</div>
<div class="dropdown-item" data-value="39">Az-Zumar (39)</div>
<div class="dropdown-item" data-value="40">Ghafir (40)</div>
<div class="dropdown-item" data-value="41">Fussilat (41)</div>
<div class="dropdown-item" data-value="42">Asy-Syura (42)</div>
<div class="dropdown-item" data-value="43">Az-Zukhruf (43)</div>
<div class="dropdown-item" data-value="44">Ad-Dukhan (44)</div>
<div class="dropdown-item" data-value="45">Al-Jasiyah (45)</div>
<div class="dropdown-item" data-value="46">Al-Ahqaf (46)</div>
<div class="dropdown-item" data-value="47">Muhammad (47)</div>
<div class="dropdown-item" data-value="48">Al-Fath (48)</div>
<div class="dropdown-item" data-value="49">Al-Hujurat (49)</div>
<div class="dropdown-item" data-value="50">Qaf (50)</div>
<div class="dropdown-item" data-value="51">Adz-Dzariyat (51)</div>
<div class="dropdown-item" data-value="52">At-Tur (52)</div>
<div class="dropdown-item" data-value="53">An-Najm (53)</div>
<div class="dropdown-item" data-value="54">Al-Qamar (54)</div>
<div class="dropdown-item" data-value="55">Ar-Rahman (55)</div>
<div class="dropdown-item" data-value="56">Al-Waqi'ah (56)</div>
<div class="dropdown-item" data-value="57">Al-Hadid (57)</div>
<div class="dropdown-item" data-value="58">Al-Mujadilah (58)</div>
<div class="dropdown-item" data-value="59">Al-Hasyr (59)</div>
<div class="dropdown-item" data-value="60">Al-Mumtahanah (60)</div>
<div class="dropdown-item" data-value="61">As-Saff (61)</div>
<div class="dropdown-item" data-value="62">Al-Jumu'ah (62)</div>
<div class="dropdown-item" data-value="63">Al-Munafiqun (63)</div>
<div class="dropdown-item" data-value="64">At-Taghabun (64)</div>
<div class="dropdown-item" data-value="65">At-Talaq (65)</div>
<div class="dropdown-item" data-value="66">At-Tahrim (66)</div>
<div class="dropdown-item" data-value="67">Al-Mulk (67)</div>
<div class="dropdown-item" data-value="68">Al-Qalam (68)</div>
<div class="dropdown-item" data-value="69">Al-Haqqah (69)</div>
<div class="dropdown-item" data-value="70">Al-Ma'arij (70)</div>
<div class="dropdown-item" data-value="71">Nuh (71)</div>
<div class="dropdown-item" data-value="72">Al-Jinn (72)</div>
<div class="dropdown-item" data-value="73">Al-Muzzammil (73)</div>
<div class="dropdown-item" data-value="74">Al-Muddaththir (74)</div>
<div class="dropdown-item" data-value="75">Al-Qiyamah (75)</div>
<div class="dropdown-item" data-value="76">Al-Insan (76)</div>
<div class="dropdown-item" data-value="77">Al-Mursalat (77)</div>
<div class="dropdown-item" data-value="78">An-Naba' (78)</div>
<div class="dropdown-item" data-value="79">An-Nazi'at (79)</div>
<div class="dropdown-item" data-value="80">'Abasa (80)</div>
<div class="dropdown-item" data-value="81">At-Takwir (81)</div>
<div class="dropdown-item" data-value="82">Al-Infitar (82)</div>
<div class="dropdown-item" data-value="83">Al-Mutaffifin (83)</div>
<div class="dropdown-item" data-value="84">Al-Insyiqaq (84)</div>
<div class="dropdown-item" data-value="85">Al-Buruj (85)</div>
<div class="dropdown-item" data-value="86">At-Tariq (86)</div>
<div class="dropdown-item" data-value="87">Al-A'la (87)</div>
<div class="dropdown-item" data-value="88">Al-Ghasyiyah (88)</div>
<div class="dropdown-item" data-value="89">Al-Fajr (89)</div>
<div class="dropdown-item" data-value="90">Al-Balad (90)</div>
<div class="dropdown-item" data-value="91">Asy-Syams (91)</div>
<div class="dropdown-item" data-value="92">Al-Lail (92)</div>
<div class="dropdown-item" data-value="93">Ad-Duha (93)</div>
<div class="dropdown-item" data-value="94">Al-Insyirah (94)</div>
<div class="dropdown-item" data-value="95">At-Tin (95)</div>
<div class="dropdown-item" data-value="96">Al-'Alaq (96)</div>
<div class="dropdown-item" data-value="97">Al-Qadr (97)</div>
<div class="dropdown-item" data-value="98">Al-Bayyinah (98)</div>
<div class="dropdown-item" data-value="99">Az-Zalzalah (99)</div>
<div class="dropdown-item" data-value="100">Al-'Adiyat (100)</div>
<div class="dropdown-item" data-value="101">Al-Qari'ah (101)</div>
<div class="dropdown-item" data-value="102">At-Takathur (102)</div>
<div class="dropdown-item" data-value="103">Al-'Asr (103)</div>
<div class="dropdown-item" data-value="104">Al-Humazah (104)</div>
<div class="dropdown-item" data-value="105">Al-Fil (105)</div>
<div class="dropdown-item" data-value="106">Quraisy (106)</div>
<div class="dropdown-item" data-value="107">Al-Ma'un (107)</div>
<div class="dropdown-item" data-value="108">Al-Kautsar (108)</div>
<div class="dropdown-item" data-value="109">Al-Kafirun (109)</div>
<div class="dropdown-item" data-value="110">An-Nasr (110)</div>
<div class="dropdown-item" data-value="111">Al-Lahab (111)</div>
<div class="dropdown-item" data-value="112">Al-Ikhlas (112)</div>
<div class="dropdown-item" data-value="113">Al-Falaq (113)</div>
<div class="dropdown-item" data-value="114">An-Nas (114)</div>
      </div>
      <input type="hidden" id="selectedSurat" name="surat">
    </div>
  </div>
  <!-- Quick select boxes for popular surahs -->
  <div class="surah-quick-select mt-2 d-flex flex-wrap gap-1">
    <button type="button" class="btn btn-outline-primary btn-sm surah-quick-btn" data-value="1" data-name="Al-Fatihah (1)">Al-Fatihah</button>
    <button type="button" class="btn btn-outline-primary btn-sm surah-quick-btn" data-value="36" data-name="Yasin (36)">Yasin</button>
    <button type="button" class="btn btn-outline-primary btn-sm surah-quick-btn" data-value="112" data-name="Al-Ikhlas (112)">Al-Ikhlas</button>
    <button type="button" class="btn btn-outline-primary btn-sm surah-quick-btn" data-value="113" data-name="Al-Falaq (113)">Al-Falaq</button>
  </div>
</div>

          <!-- Juz select -->
          <div class="mb-3" id="juz-select" style="display: none;">
            <div class="radio-group-container">
              <label class="form-label fw-bold">Juz</label>
              <div class="input-dropdown-container w-100">
                <input type="text" id="juzInput" class="input-dropdown form-control" placeholder="Pilih Juz" autocomplete="off" spellcheck="false">
                <div id="juzDropdown" class="dropdown-menu">
                  <div class="dropdown-item" data-value="1">1</div>
                  <div class="dropdown-item" data-value="2">2</div>
                  <div class="dropdown-item" data-value="3">3</div>
                  <div class="dropdown-item" data-value="4">4</div>
                  <div class="dropdown-item" data-value="5">5</div>
                  <div class="dropdown-item" data-value="6">6</div>
                  <div class="dropdown-item" data-value="7">7</div>
                  <div class="dropdown-item" data-value="8">8</div>
                  <div class="dropdown-item" data-value="9">9</div>
                  <div class="dropdown-item" data-value="10">10</div>
                  <div class="dropdown-item" data-value="11">11</div>
                  <div class="dropdown-item" data-value="12">12</div>
                  <div class="dropdown-item" data-value="13">13</div>
                  <div class="dropdown-item" data-value="14">14</div>
                  <div class="dropdown-item" data-value="15">15</div>
                  <div class="dropdown-item" data-value="16">16</div>
                  <div class="dropdown-item" data-value="17">17</div>
                  <div class="dropdown-item" data-value="18">18</div>
                  <div class="dropdown-item" data-value="19">19</div>
                  <div class="dropdown-item" data-value="20">20</div>
                  <div class="dropdown-item" data-value="21">21</div>
                  <div class="dropdown-item" data-value="22">22</div>
                  <div class="dropdown-item" data-value="23">23</div>
                  <div class="dropdown-item" data-value="24">24</div>
                  <div class="dropdown-item" data-value="25">25</div>
                  <div class="dropdown-item" data-value="26">26</div>
                  <div class="dropdown-item" data-value="27">27</div>
                  <div class="dropdown-item" data-value="28">28</div>
                  <div class="dropdown-item" data-value="29">29</div>
                  <div class="dropdown-item" data-value="30">30</div>
                </div>
                <input type="hidden" id="selectedJuz" name="juz">
              </div>
            </div>
          </div>

          <!-- Halaman select -->
<div class="mb-3" id="halaman-select" style="display: none;">
  <div class="radio-group-container">
    <label class="form-label fw-bold">Halaman</label>
    <div class="input-dropdown-container w-100">
      <input type="text" id="halamanInput" class="input-dropdown form-control" placeholder="Pilih Halaman" autocomplete="off" spellcheck="false">
      <div id="halamanDropdown" class="dropdown-menu">
        {for $i=1 to 604}
          <div class="dropdown-item" data-value="{$i|escape:'html'}">{$i|escape:'html'}</div>
        {/for}
      </div>
      <input type="hidden" id="selectedHalaman" name="halaman">
    </div>
  </div>
</div>

          <!-- Buttons -->
          <div class="action-buttons d-flex justify-content-center flex-column flex-md-row gap-2">
            <button type="submit" class="btn btn-primary w-100 w-md-auto">{__("Start")}</button>
            <button type="button" id="resetButton" class="btn btn-outline-danger w-100 w-md-auto">{__("Reset")}</button>
          </div>
        </form>
      </div>
    </div>
    
    <!-- Peta -->
    <div class="col-lg-6 col-md-12 col-12 mb-3">
      <div class="card shadow-lg p-3 rounded h-100 map-card" id="mapCard">
        <div class="map-header">
          <h3 class="text-start">{__("Qurani History")}</h3>
          <div class="map-controls">
            <button class="btn btn-sm btn-outline-secondary me-2" id="showTableBtn" title="Show Location Data" onclick="localStorage.setItem('activeTab', 'locations'); window.location.href='{$system['system_url']}/qurani/riwayat';">
                <i class="fas fa-table"></i>
            </button>
            <button class="btn btn-sm btn-outline-secondary" id="toggleScreenBtn" title="Toggle Screen Size">
              <i class="fas fa-expand"></i>
            </button>
          </div>
        </div>
        <div id="map"></div>
      </div>
    </div>
  </div>
</div>

<!-- Table History -->
<div class="{if $system['fluid_design']}container-fluid{else}container{/if} sg-offcanvas mt-3">
  <div class="row justify-content-center">
    <div class="table-responsive">
      <div class="col-lg-12 col-md-12">
        <div class="card shadow-lg p-4 rounded history-card">
          <div class="d-flex justify-content-between align-items-center mb-3">
            <a href='{$system['system_url']|escape:'html'}'><h3 class="text-start mb-0 cursor-pointer">{__("History")}</h3></a>
            <div>
              <button class="btn btn-sm btn-outline-secondary me-2" onclick="window.location.href='{$system['system_url']}/qurani/riwayat'">
                <i class="fas fa-table"></i>
              </button>
              <button class="btn btn-sm btn-outline-secondary" id="settingsBtnHistory" title="{__("Qurani Setting")}" onclick="localStorage.setItem('activeTab', 'statistics'); window.location.href='{$system['system_url']}/qurani/riwayat';">
                <i class="fas fa-chart-line"></i>
              </button>
            </div>
          </div>
          <table class="table table-bordered table-hover">
  <thead>
    <tr>
      <th>{__("Time")}</th>
      <th>{__("Reciter")}</th>
      <th>{__("Recipient")}</th>
      <th>{__("Recite")}</th>
      <th>{__("Results")}</th>
      <th class="text-center">{__("Signature")}</th>
    </tr>
  </thead>
  <tbody>
    {foreach $riwayat_setoran as $setoran}
      <tr>
        <td data-label="{__("Time")}">
          <a href="{$system['system_url']|escape:'html'}/qurani/riwayat/{$setoran.id|escape:'html'}" class="cursor-pointer rekapan-link" data-id="{$setoran.id|escape:'html'}">
            {$setoran.formatted_date|escape:'html'}
          </a>
        </td>
<td data-label="Penyetor">
  <span class="js_user-popover" data-uid="{$history.penyetor_id}">
  <a href="{$system['system_url']|escape:'html'}/{$setoran.penyetor_name|escape:'url'}"
     target="_blank"
     rel="noopener noreferrer"
     data-bs-toggle="tooltip"
     title="{if $setoran.penyetor_fullname}{$setoran.penyetor_fullname|escape:'html'}{else}{$setoran.penyetor_name|escape:'html'}{/if}">
    {$setoran.penyetor_name|escape:'html'}
  </a>
  </span>
</td>
<td data-label="Penerima">
  <a href="{$system['system_url']|escape:'html'}/{$setoran.penerima_name|escape:'url'}"
     target="_blank"
     rel="noopener noreferrer"
     data-bs-toggle="tooltip"
     title="{if $setoran.penerima_fullname}{$setoran.penerima_fullname|escape:'html'}{else}{$setoran.penerima_name|escape:'html'}{/if}">
    {$setoran.penerima_name|escape:'html'}
  </a>
</td>

        <td data-label="Setoran">
          <a href="{$system['system_url']|escape:'html'}/qurani/riwayat/{$setoran.id|escape:'html'}" class="cursor-pointer rekapan-link" data-id="{$setoran.id|escape:'html'}">
            {$setoran.setoran|escape:'html'}
          </a>
        </td>
        <td data-label="Hasil">
          <a href="{$system['system_url']|escape:'html'}/qurani/riwayat/{$setoran.id|escape:'html'}" class="cursor-pointer rekapan-link" data-id="{$setoran.id|escape:'html'}">
            {__($setoran.hasil)}
          </a>
        </td>
        <td data-label="Paraf" class="text-center">
          {if $setoran.paraf == 1}
            <i class="fas fa-check text-success"></i>
          {else}
            <span class="paraf-clickable" data-id="{$setoran.id|escape:'html'}" data-penyetor-id="{$setoran.penyetor_id|escape:'html'}" data-penerima-id="{$setoran.penerima_id|escape:'html'}">
              <i class="fas fa-check text-gray"></i>
            </span>
          {/if}
        </td>
      </tr>
    {foreachelse}
      <tr>
        <td colspan="6" class="text-center" data-label="Pesan">{__("doesnt recite history")}</td>
      </tr>
    {/foreach}
  </tbody>
</table>

        </div>
      </div>
    </div>
  </div>
</div>

<script>
{literal}
document.addEventListener("DOMContentLoaded", function() {

  console.log(window.location.href);
  const user_settings = JSON.parse('{/literal}{$user_settings}{literal}');
  localStorage.setItem('qu_user_setting', JSON.stringify(user_settings));

  // Setup dropdowns
  setupDropdown('groupInput', 'groupDropdown', 'selectedGroup', function(groupId) {
    console.log('Selected group_id:', groupId); 
    fetchGroupSettings(groupId); 
    enableMemberInput(groupId);
  });
  setupDropdown('memberInput', 'memberDropdown', 'selectedMember');
  setupDropdown('temanInput', 'temanDropdown', 'selectedTeman', undefined, true);
  setupDropdown('suratInput', 'suratDropdown', 'selectedSurat');
  setupDropdown('juzInput', 'juzDropdown', 'selectedJuz');
  setupDropdown('halamanInput', 'halamanDropdown', 'selectedHalaman');

  const groupsData = {
    {/literal}
    {foreach $all_groups as $group}
    '{$group.group_id|escape:'javascript'}': [
      {foreach $group.members as $member}
      { id: '{$member.user_id|escape:'javascript'}', name: '{$member.user_name|escape:'javascript'}', fullname: '{$member.user_fullname|escape:'javascript'}' },
      {/foreach}
    ],
    {/foreach}
    {literal}
  };

    function fetchGroupSettings(groupId) {
    if (!groupId || groupId === '0') {
      console.log('No valid group_id selected');
      return;
    }

    fetch(`{/literal}{$system['system_url']|escape:'javascript'}{literal}/qurani/?action=get_group_settings&group_id=${groupId}`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      }
    })
    .then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }

      return response.json();
    })
    .then(data => {
      if (data.error) {
        console.error('Error fetching group settings:', data.error);
        return;
      }
      console.log('Group settings for group_id', groupId, ':', data);
      localStorage.setItem('qu_setting_group',JSON.stringify(data));
    })
    .catch(error => {
      console.error('Error fetching group settings:', error.message);
    });
  }

  // Handle rekapan links
  document.querySelectorAll('.rekapan-link').forEach(link => {
    link.addEventListener('click', function(e) {
      e.preventDefault();
      const setoranId = this.getAttribute('data-id');

      if (!setoranId || isNaN(parseInt(setoranId))) {
        Swal.fire({
          icon: 'error',
          title: 'Kesalahan',
          text: 'ID setoran tidak valid',
        });
        return;
      }

      fetch('{/literal}{$system['system_url']|escape:'javascript'}{literal}/qurani/rekapan', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ id: parseInt(setoranId) })
      })
      .then(response => {
        if (!response.ok) {
          throw new Error('Gagal mengambil data setoran: ' + response.status);
        }
        return response.json();
      })
      .then(data => {
        if (data.error) {
          throw new Error(data.error);
        }
        window.location.href = '{/literal}{$system['system_url']|escape:'javascript'}{literal}/qurani/riwayat/' + setoranId;
      })
      .catch(error => {
        console.error('Error mengambil data setoran:', error);
        Swal.fire({
          icon: 'error',
          title: 'Kesalahan',
          text: 'Gagal mengambil data setoran: ' + error.message,
        });
      });
    });
  });

  // Handle clickable paraf
  document.querySelectorAll('.paraf-clickable').forEach(span => {
    span.addEventListener('click', function() {
      const setoranId = this.getAttribute('data-id');
      const penyetorId = this.getAttribute('data-penyetor-id');
      const penerimaId = this.getAttribute('data-penerima-id');
      const currentUserId = {/literal}{$user->_data['user_id']|escape:'javascript'}{literal};

      if (currentUserId != penyetorId && currentUserId != penerimaId) {
        Swal.fire({
          icon: 'error',
          title: 'Tidak Diizinkan',
          text: 'Hanya penyetor atau penerima yang dapat menambahkan paraf.',
        });
        return;
      }

      Swal.fire({
        title: 'Konfirmasi Paraf',
        text: 'Apakah Anda yakin ingin menandai setoran ini sebagai diparaf?',
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: 'Ya, Paraf',
        cancelButtonText: 'Batal',
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33'
      }).then((result) => {
        if (result.isConfirmed) {
          fetch(`{/literal}{$system['system_url']|escape:'javascript'}{literal}/qurani/index.php?action=update_paraf`, {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify({ 
              id: parseInt(setoranId),
              user_id: parseInt(currentUserId)
            })
          })
          .then(response => {
            if (!response.ok) {
              throw new Error('Gagal memperbarui paraf: ' + response.status);
            }
            return response.json();
          })
          .then(data => {
            if (data.success) {
              Swal.fire({
                icon: 'success',
                title: 'Berhasil',
                text: 'Paraf telah ditambahkan.',
                timer: 1500,
                showConfirmButton: false
              }).then(() => {
                const icon = span.querySelector('i');
                icon.classList.remove('text-gray');
                icon.classList.add('text-success');
                span.classList.remove('paraf-clickable');
                span.style.cursor = 'default';
              });
            } else {
              throw new Error(data.error || 'Gagal menambahkan paraf.');
            }
          })
          .catch(error => {
            console.error('Error updating paraf:', error);
            Swal.fire({
              icon: 'error',
              title: 'Kesalahan',
              text: 'Gagal memperbarui paraf: ' + error.message,
            });
          });
        }
      });
    });
  });

  function enableMemberInput(groupId) {
    const memberInput = document.getElementById('memberInput');
    const memberDropdown = document.getElementById('memberDropdown');
    const selectedMember = document.getElementById('selectedMember');
    memberInput.disabled = false;
    memberInput.placeholder = "Pilih Anggota";
    memberDropdown.innerHTML = '';
    selectedMember.value = '';

    if (groupId && groupsData[groupId]) {
      groupsData[groupId].forEach(member => {
        console.log(member);
        const div = document.createElement('div');
        div.className = 'dropdown-item';
        div.setAttribute('data-value', member.id);
        div.setAttribute('data-username', member.name);
        div.textContent = member.fullname;
        memberDropdown.appendChild(div);
      });

      setupDropdown('memberInput', 'memberDropdown', 'selectedMember', undefined, true);
    } else {
      memberInput.disabled = true;
      memberInput.placeholder = "Pilih grup terlebih dahulu";
      memberInput.value = '';
      selectedMember.value = '';
    }
  }

  document.querySelectorAll('input[name="tampilkan"]').forEach(radio => {
    radio.addEventListener("change", function() {
      document.getElementById('surat-select').style.display = (this.value === "surat") ? 'block' : 'none';
      document.getElementById('juz-select').style.display = (this.value === "juz") ? 'block' : 'none';
      document.getElementById('halaman-select').style.display = (this.value === "halaman") ? 'block' : 'none';
    });
  });

  document.querySelectorAll('input[name="penyetor"]').forEach(radio => {
  radio.addEventListener("change", function() {
    const grupSection = document.getElementById('grup-anggota');
    const temanSection = document.getElementById('teman-select');
    
    if (this.value === "grup") {
      grupSection.style.display = 'block';
      temanSection.style.display = 'none';
      document.getElementById('temanInput').value = '';
      document.getElementById('selectedTeman').value = '';
    } else if (this.value === "teman") {
      grupSection.style.display = 'none';
      temanSection.style.display = 'block';
      document.getElementById('groupInput').value = '';
      document.getElementById('selectedGroup').value = '';
      document.getElementById('memberInput').value = '';
      document.getElementById('selectedMember').value = '';
      document.getElementById('memberInput').disabled = true;
      document.getElementById('memberInput').placeholder = "Pilih grup terlebih dahulu";
    }
  });
});
  document.querySelectorAll('.surah-quick-btn').forEach(button => {
  button.addEventListener('click', function() {
    const surahValue = this.getAttribute('data-value');
    const surahName = this.getAttribute('data-name');
    
    const suratInput = document.getElementById('suratInput');
    const selectedSurat = document.getElementById('selectedSurat');
    suratInput.value = surahName;
    selectedSurat.value = surahValue;
    
    const dropdownItems = document.querySelectorAll('#suratDropdown .dropdown-item');
    dropdownItems.forEach(item => {
      item.classList.remove('selected');
      if (item.getAttribute('data-value') === surahValue) {
        item.classList.add('selected');
      }
    });
    
    document.getElementById('suratDropdown').style.display = 'none';
  });
});

  function setupDropdown(inputId, dropdownId, hiddenInputId, callback, isPersonDropdown) {
    const inputElement = document.getElementById(inputId);
    const dropdownElement = document.getElementById(dropdownId);
    const hiddenInput = document.getElementById(hiddenInputId);
    let items = dropdownElement.querySelectorAll('.dropdown-item');

    const updateItems = () => {
      items = dropdownElement.querySelectorAll('.dropdown-item');
      items.forEach(item => {
        item.addEventListener('click', function() {
          inputElement.value = this.textContent;

          if (isPersonDropdown) {
            inputElement.setAttribute('data-username', this.getAttribute('data-username'));
          }

          const selectedValue = this.getAttribute('data-value');
          hiddenInput.value = selectedValue;
          dropdownElement.style.display = 'none';
          items.forEach(i => i.classList.remove('selected'));
          this.classList.add('selected');

          // Log group_id jika ini adalah dropdown groupInput
          if (inputId === 'groupInput') {
            console.log('Selected group_id:', selectedValue);
          }

          if (inputId === 'halamanInput') {
            const pageNumber = parseInt(selectedValue, 10);
            if (!isNaN(pageNumber) && pageNumber >= 1 && pageNumber <= 604) {
              console.log('Selected page value:', pageNumber);
            } else {
              console.error('Invalid page value selected:', selectedValue);
            }
          }

          if (callback && inputId === 'groupInput') {
            callback(selectedValue);
          }
        });
      });
    };

    updateItems();

    inputElement.addEventListener('focus', function() {
      dropdownElement.style.display = 'block';
    });

    inputElement.addEventListener('input', function() {
      const filter = this.value.toLowerCase();
      items.forEach(item => {
        const text = item.textContent.toLowerCase();
        item.style.display = text.includes(filter) ? '' : 'none';
      });
      dropdownElement.style.display = 'block';
    });

    document.addEventListener('click', function(e) {
      if (e.target !== inputElement && !dropdownElement.contains(e.target)) {
        dropdownElement.style.display = 'none';
      }
    });

    inputElement.addEventListener('keydown', function(e) {
      if (e.key === 'Escape') {
        dropdownElement.style.display = 'none';
      } else if (e.key === 'ArrowDown') {
        e.preventDefault();
        focusNextItem(1);
      } else if (e.key === 'ArrowUp') {
        e.preventDefault();
        focusNextItem(-1);
      } else if (e.key === 'Enter') {
        e.preventDefault();
        const focused = dropdownElement.querySelector('.dropdown-item:focus') || 
                        dropdownElement.querySelector('.dropdown-item.selected');
        if (focused) focused.click();
      }
    });

    function focusNextItem(direction) {
      const focused = dropdownElement.querySelector('.dropdown-item:focus') || 
                      dropdownElement.querySelector('.dropdown-item.selected');
      const visibleItems = Array.from(items).filter(item => 
        item.style.display !== 'none');
      
      if (!visibleItems.length) return;
      
      if (!focused) {
        visibleItems[0].focus();
        return;
      }
      
      const currentIndex = visibleItems.indexOf(focused);
      const nextIndex = (currentIndex + direction + visibleItems.length) % visibleItems.length;
      visibleItems[nextIndex].focus();
    }

    const observer = new MutationObserver(() => {
      updateItems();
    });
    observer.observe(dropdownElement, { childList: true });
  }

  document.getElementById('resetButton').addEventListener('click', function() {
  document.getElementById('grup').checked = true;
  document.getElementById('surat').checked = true;

  document.getElementById('groupInput').value = '';
  document.getElementById('selectedGroup').value = '';
  document.getElementById('memberInput').value = '';
  document.getElementById('selectedMember').value = '';
  document.getElementById('memberInput').disabled = true;
  document.getElementById('memberInput').placeholder = "Pilih grup terlebih dahulu...";
  document.getElementById('temanInput').value = '';
  document.getElementById('selectedTeman').value = '';
  document.getElementById('suratInput').value = '';
  document.getElementById('selectedSurat').value = '';
  document.getElementById('juzInput').value = '';
  document.getElementById('selectedJuz').value = '';
  document.getElementById('halamanInput').value = '';
  document.getElementById('selectedHalaman').value = '';

  document.getElementById('grup-anggota').style.display = 'block';
  document.getElementById('teman-select').style.display = 'none';
  document.getElementById('surat-select').style.display = 'block';
  document.getElementById('juz-select').style.display = 'none';
  document.getElementById('halaman-select').style.display = 'none';

  localStorage.removeItem('lastSelectedGroup');
  localStorage.removeItem('lastSelectedMember');
  localStorage.removeItem('lastSelectedFriend');
  localStorage.removeItem('lastSelectedSurah');
  localStorage.removeItem('lastSelectedJuz');
  localStorage.removeItem('lastSelectedPage');
  localStorage.removeItem('lastPenyetorType');
  localStorage.removeItem('lastTampilkanType');
  localStorage.removeItem('currentUserId');
  localStorage.removeItem('theme');
  localStorage.removeItem('setoranData');

  Swal.fire({
    icon: 'success',
    title: 'Reset Berhasil',
    text: 'Form telah direset.',
    timer: 1500,
    showConfirmButton: false
  });
});

  document.getElementById('setoranForm').addEventListener('submit', function(e) {
  e.preventDefault();
  
  let isValid = true;
  let errorMessages = [];
  
  const currentUserId = {/literal}{$user->_data['user_id']|escape:'javascript'}{literal};
  const currentUserName = {/literal}"{$user->_data['user_name']|escape:'javascript'}"{literal};
  
  // Retrieve settings from localStorage
  const qu_setting_user = JSON.parse(localStorage.getItem('qu_user_setting') || '{}');
  const qu_setting_group = JSON.parse(localStorage.getItem('qu_setting_group') || '{}');
  
  const penyetorType = document.querySelector('input[name="penyetor"]:checked')?.value;
  const setoranType = document.querySelector('input[name="setoran"]:checked')?.value;
  const tampilkanType = document.querySelector('input[name="tampilkan"]:checked')?.value;
  let penyetorId = null;
  let penyetorName = null;
  let penyetorFullname = null;
  let groupId = null;
  let qu_setting = null; // Initialize qu_setting
  
  // Validation for penyetorType
  if (!penyetorType) {
    isValid = false;
    errorMessages.push("Silakan pilih jenis penyetor (Grup atau Teman)");
  }
  if (!setoranType) {
    isValid = false;
    errorMessages.push("Silakan pilih jenis setoran (Tahsin atau Tahfidz)");
  }
  if (!tampilkanType) {
    isValid = false;
    errorMessages.push("Silakan pilih jenis tampilan (Surat, Juz, atau Halaman)");
  }
  
  // Handle penyetor type
  if (penyetorType === 'grup') {
    groupId = document.getElementById('selectedGroup').value;
    penyetorId = document.getElementById('selectedMember').value;
    penyetorFullname = document.getElementById('memberInput').value;
    penyetorName = document.getElementById('memberInput').getAttribute('data-username');
    
    if (!groupId) {
      isValid = false;
      errorMessages.push("Silakan pilih Grup terlebih dahulu");
    }
    if (!penyetorId) {
      isValid = false;
      errorMessages.push("Silakan pilih Anggota terlebih dahulu");
    }
    if (penyetorId == currentUserId) {
      isValid = false;
      errorMessages.push("Anda tidak dapat memilih diri sendiri sebagai penyetor");
    }
    
    // Assign qu_setting_group to qu_setting
    if (isValid && Object.keys(qu_setting_group).length > 0) {
      qu_setting = qu_setting_group;
    } else {
      isValid = false;
      errorMessages.push("Pengaturan grup tidak ditemukan. Silakan pilih grup yang valid.");
    }
    
    if (isValid) {
      localStorage.setItem('lastSelectedGroup', JSON.stringify({
        id: groupId,
        name: document.getElementById('groupInput').value
      }));
      localStorage.setItem('lastSelectedMember', JSON.stringify({
        id: penyetorId,
        name: penyetorName
      }));
    }
  } else if (penyetorType === 'teman') {
    penyetorId = document.getElementById('selectedTeman').value;
    penyetorFullname = document.getElementById('temanInput').value;
    penyetorName = document.getElementById('temanInput').getAttribute('data-username');
    
    if (!penyetorId) {
      isValid = false;
      errorMessages.push("Silakan pilih Teman terlebih dahulu");
    }
    if (penyetorId == currentUserId) {
      isValid = false;
      errorMessages.push("Anda tidak dapat memilih diri sendiri sebagai penyetor");
    }
    
    // Assign qu_setting_user to qu_setting
    if (isValid && Object.keys(qu_setting_user).length > 0) {
      qu_setting = qu_setting_user;
    } else {
      isValid = false;
      errorMessages.push("Pengaturan pengguna tidak ditemukan.");
    }
    
    if (isValid) {
      localStorage.setItem('lastSelectedFriend', JSON.stringify({
        id: penyetorId,
        name: penyetorName
      }));
    }
  }
  
  // Handle tampilkan type
  let suratId = null;
  let suratName = null;
  let juzId = null;
  let juzName = null;
  let halaman = null;
  
  if (tampilkanType === 'surat') {
    suratId = document.getElementById('selectedSurat').value;
    suratName = document.getElementById('suratInput').value;
    
    if (!suratId) {
      isValid = false;
      errorMessages.push("Silakan pilih Surat terlebih dahulu");
    } else {
      localStorage.setItem('lastSelectedSurah', JSON.stringify({
        id: suratId,
        name: suratName
      }));
    }
  } else if (tampilkanType === 'juz') {
    juzId = document.getElementById('selectedJuz').value;
    juzName = document.getElementById('juzInput').value;
    
    if (!juzId) {
      isValid = false;
      errorMessages.push("Silakan pilih Juz terlebih dahulu");
    } else {
      localStorage.setItem('lastSelectedJuz', JSON.stringify({
        id: juzId,
        name: juzName
      }));
    }
  } else if (tampilkanType === 'halaman') {
    halaman = document.getElementById('selectedHalaman').value;
    
    if (!halaman || isNaN(parseInt(halaman, 10))) {
      const lastSelectedPage = localStorage.getItem('lastSelectedPage');
      if (lastSelectedPage) {
        try {
          const pageData = JSON.parse(lastSelectedPage);
          halaman = pageData.id;
        } catch (error) {
          console.error('Gagal parse lastSelectedPage dari localStorage:', error);
        }
      }
    }
    
    if (!halaman) {
      isValid = false;
      errorMessages.push("Silakan pilih Halaman terlebih dahulu");
    } else {
      const pageNumber = parseInt(halaman, 10);
      if (isNaN(pageNumber) || pageNumber < 1 || pageNumber > 604) {
        isValid = false;
        errorMessages.push("Nomor halaman tidak valid. Harus antara 1 dan 604.");
      } else {
        localStorage.setItem('lastSelectedPage', JSON.stringify({
          id: halaman,
          name: document.getElementById('halamanInput').value
        }));
      }
    }
  }
  
  localStorage.setItem('lastPenyetorType', penyetorType);
  localStorage.setItem('lastTampilkanType', tampilkanType);
  
  if (!isValid) {
    Swal.fire({
      icon: 'error',
      title: 'Kesalahan',
      html: errorMessages.join('<br>'),
    });
    return;
  }
  
  // Construct the payload
  const payload = {
    user_id: Number(currentUserId),
    user_name: currentUserName,
    penyetor_type: penyetorType,
    penyetor_id: Number(penyetorId),
    penyetor_name: penyetorName,
    penyetor_fullname: penyetorFullname,
    setoran_type: setoranType,
    tampilkan_type: tampilkanType,
    surat_id: suratId ? Number(suratId) : null,
    surat_name: suratName,
    juz_id: juzId ? Number(juzId) : null,
    juz_name: juzName,
    halaman: halaman ? Number(halaman) : null,
    group_id: groupId ? Number(groupId) : null,
    qu_setting: qu_setting
  };
  
  try {
    localStorage.setItem('setoranPayload', JSON.stringify(payload));
  } catch (error) {
    Swal.fire({
      icon: 'error',
      title: 'Kesalahan',
      text: 'Gagal menyimpan data ke localStorage',
    });
    return;
  }
  
  let redirectUrl = '{/literal}{$system['system_url']|escape:'javascript'}{literal}/qurani/setoran';
  if (tampilkanType === 'surat' && suratId) {
    redirectUrl += '/surah/' + suratId;
  } else if (tampilkanType === 'juz' && juzId) {
    redirectUrl += '/juz/' + juzId;
  } else if (tampilkanType === 'halaman' && halaman) {
    const pageNumber = parseInt(halaman, 10);
    if (!isNaN(pageNumber) && pageNumber >= 1 && pageNumber <= 604) {
      redirectUrl += '/page/' + pageNumber;
    } else {
      Swal.fire({
        icon: 'error',
        title: 'Kesalahan',
        text: 'Nomor halaman tidak valid untuk redirect.',
      });
      return;
    }
  }
  
  window.location.href = redirectUrl;
});

  // Inisialisasi Peta
  try {
    if (typeof L === 'undefined') {
      document.getElementById('map').innerHTML = '<p>Error: Tidak dapat memuat pustaka peta.</p>';
      return;
    }

    const indonesiaBounds = L.latLngBounds(
      [-11, 95],
      [6, 141]
    );

    const map = L.map('map', {
      center: [-2.5, 118],
      zoom: 5,
      minZoom: 5,
      maxZoom: 18,
      maxBounds: indonesiaBounds,
      maxBoundsViscosity: 1.0,
      zoomControl: false
    });

    L.control.zoom({
      position: 'topright'
    }).addTo(map);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '© <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
      maxZoom: 19
    }).addTo(map);

    const markers = L.markerClusterGroup({
      disableClusteringAtZoom: 12,
      spiderfyOnMaxZoom: true,
      showCoverageOnHover: false,
      zoomToBoundsOnClick: true
    });

    fetch('/qurani/?action=get_cities')
      .then(response => {
        if (!response.ok) throw new Error('Gagal mengambil data kota. Silakan coba lagi nanti.');
        return response.json();
      })
      .then(cityData => {
        if (!Array.isArray(cityData) || cityData.length === 0) {
          document.getElementById('map').innerHTML = '<p>Tidak ada data kota untuk ditampilkan saat ini.</p>';
          return;
        }

        cityData.forEach(city => {
          if (city.kota && city.lat && city.long) {
            const lat = parseFloat(city.lat);
            const lng = parseFloat(city.long);
            if (!isNaN(lat) && !isNaN(lng) && lat >= -11 && lat <= 6 && lng >= 95 && lng <= 141) {
              const markerIcon = L.divIcon({
                html: `<div style="background-color: #007bff; color: white; border-radius: 50%; width: 30px; height: 30px; display: flex; justify-content: center; align-items: center; font-weight: bold; box-shadow: 0 2px 5px rgba(0,0,0,0.3);">${city.total_setoran || 0}</div>`,
                className: 'custom-marker',
                iconSize: [30, 30],
                iconAnchor: [15, 15],
                popupAnchor: [0, -15]
              });

              const marker = L.marker([lat, lng], { icon: markerIcon });
              marker.bindPopup(`
                <div style="text-align: center;">
                  <strong style="font-size: 16px;">${city.kota}</strong>
                  <hr style="margin: 8px 0;">
                  <div>Total Setoran: <b>${city.total_setoran || 0}</b></div>
                </div>
              `);
              markers.addLayer(marker);
            }
          }
        });

        map.addLayer(markers);

        if (markers.getLayers().length > 0) {
          map.fitBounds(markers.getBounds(), { padding: [50, 50] });
        }

        function toggleFullscreen() {
          const mapCard = document.getElementById('mapCard');
          const toggleIcon = document.querySelector('#toggleScreenBtn i');

          if (!mapCard.classList.contains('fullscreen')) {
            mapCard.classList.add('fullscreen');
            toggleIcon.classList.remove('fa-expand');
            toggleIcon.classList.add('fa-compress');
            document.body.style.overflow = 'hidden';
            document.body.classList.add('map-fullscreen');
            mapCard.style.height = '100vh';
            mapCard.style.width = '100vw';
          } else {
            mapCard.classList.remove('fullscreen');
            toggleIcon.classList.remove('fa-compress');
            toggleIcon.classList.add('fa-expand');
            document.body.style.overflow = '';
            document.body.classList.remove('map-fullscreen');
            mapCard.style.height = '';
            mapCard.style.width = '';
          }

          setTimeout(() => {
            map.invalidateSize();
            if (markers.getLayers().length > 0) {
              map.fitBounds(markers.getBounds(), { padding: [50, 50] });
            }
          }, 300);
        }

        document.getElementById('toggleScreenBtn').addEventListener('click', toggleFullscreen);

        document.addEventListener('keydown', function escKeyHandler(e) {
          if (e.key === 'Escape') {
            const mapCard = document.getElementById('mapCard');
            if (mapCard.classList.contains('fullscreen')) {
              toggleFullscreen();
            }
          }
        });

        window.addEventListener('resize', function() {
          map.invalidateSize();
          if (markers.getLayers().length > 0) {
            map.fitBounds(markers.getBounds(), { padding: [50, 50] });
          }
        });
      })
      .catch(error => {
        console.error('Error mengambil data kota dari API:', error);
        document.getElementById('map').innerHTML = `<p>${error.message}</p>`;
      });
  } catch (error) {
    console.error('Error inisialisasi peta:', error);
    document.getElementById('map').innerHTML = '<p>Error: Tidak dapat menginisialisasi peta.</p>';
  }
});
{/literal}
</script>

{include file='_footer.tpl'}
