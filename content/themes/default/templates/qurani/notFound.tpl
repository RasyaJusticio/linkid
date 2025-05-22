{* CSS untuk styling halaman 404 *}
<style>
body {
  overflow: hidden;
}

.notFoundContainer {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  font-family: 'Inter', sans-serif;
}

.notFoundContent {
  text-align: center;
  padding: 2.5rem;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  max-width: 400px;
  width: 90%;
}

.container1 {
  margin-top: -50px;
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.icon {
  position: relative;
  width: 100%;
  max-width: 150px;
  margin-bottom: 1rem;
}

.mainMessage {
  font-size: 1.5rem;
  color: #333;
  margin-top: -30px;
  margin-bottom: 2rem;
  font-weight: 700;
}

.message {
  font-size: 1.1rem;
  color: #666;
  margin-bottom: 1.5rem;
}

.countdown {
  font-weight: bold;
  color: #007bff;
}

.loader {
  width: 40px;
  height: 40px;
  border: 4px solid #f3f3f3;
  border-top: 4px solid #007bff;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin: 0 auto 1.5rem;
}

.info {
  font-size: 0.9rem;
  color: #666;
}

.link {
  color: #007bff;
  text-decoration: none;
  font-weight: 500;
}

.link:hover {
  text-decoration: underline;
}

@keyframes spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

@media (max-width: 480px) {
  .notFoundContent {
    padding: 1.5rem;
  }

  .mainMessage {
    font-size: 1.3rem;
  }

  .message {
    font-size: 1rem;
  }
}

html[data-bs-theme=dark] {
  .notFoundContent {
    background: #343a40; /* Ganti dengan $body-secondary-bg-dark jika variabel tersedia */
  }

  .mainMessage {
    color: #fff;
  }

  .message,
  .info {
    color: #ccc;
  }
}
</style>

{* Konten Halaman 404 *}
<div class="notFoundContainer">
  <div class="notFoundContent">
    <div class="container1">
      <a href="{$system['system_url']}/qurani">
        <img src="{$system['system_url']}/content/themes/default/images/svg/1.svg" class="icon" alt="404 Icon" />
      </a>
      <h1 class="mainMessage text-center">Error 404 - Halaman Tidak Ditemukan</h1>
    </div>
    <p class="message">
      Halaman yang Anda cari tidak ada. Anda akan dialihkan ke halaman utama <a class="link" href="{$system['system_url']}/qurani">Link.id</a> dalam <span class="countdown" id="countdown">10</span> detik
    </p>
    <div class="loader"></div>
    <p class="info">
      Jika tidak dialihkan secara otomatis, <a href="{$system['system_url']}/qurani" class="link">klik di sini</a>
    </p>
  </div>
</div>

{* JavaScript untuk countdown dan redirect *}
<script>
{literal}
document.addEventListener('DOMContentLoaded', function() {
  const countdownElement = document.getElementById('countdown');
  let countdown = 10; // Nilai awal countdown

  const startCountdown = () => {
    const timer = setInterval(() => {
      countdown--;
      countdownElement.textContent = countdown;
      if (countdown <= 0) {
        clearInterval(timer);
        window.location.href = '{/literal}{$system['system_url']}{literal}/qurani';
      }
    }, 1000);
  };

  // Mulai countdown saat halaman dimuat
  startCountdown();
});
{/literal}
</script>
