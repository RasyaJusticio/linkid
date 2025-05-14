<?php
// Aktifkan debugging sementara
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require('../bootloader.php');

// Set timezone to Asia/Jakarta (UTC+7)
date_default_timezone_set('Asia/Jakarta');

// [1] Get logged in user data
if (!isset($user->_data)) {
    die('Error: User not logged in or session invalid.');
}
$user = $user->_data;
$current_user = [
    'user_id' => $user['user_id'],
    'user_name' => $user['user_name']
];

// [2] Fetch all unique penyetor and penerima for filter options
$penyetor_options = [];
$penerima_options = [];
$get_users = $db->query("SELECT user_id, user_name FROM `users` ORDER BY user_name");
if ($db->error) {
    die('Users query error: ' . $db->error);
}
while ($u = $get_users->fetch_assoc()) {
    $penyetor_options[] = $u;
    $penerima_options[] = $u;
}

// [3] Handle filter parameters from POST
$waktu_start = isset($_POST['waktu_start']) && !empty(trim($_POST['waktu_start'])) ? trim($_POST['waktu_start']) : '';
$penyetor = isset($_POST['penyetor']) && !empty(trim($_POST['penyetor'])) ? (int)$_POST['penyetor'] : 0;
$penerima = isset($_POST['penerima']) && !empty(trim($_POST['penerima'])) ? (int)$_POST['penerima'] : 0;
$hasil = isset($_POST['hasil']) && !empty(trim($_POST['hasil'])) && $_POST['hasil'] !== 'semua' ? trim($_POST['hasil']) : '';
$paraf = isset($_POST['paraf']) && !empty(trim($_POST['paraf'])) && $_POST['paraf'] !== 'semua' ? trim($_POST['paraf']) : '';

// [4] Fetch all history data from qu_setoran table
$recap_history = [];
$query = "SELECT 
    qs.id,
    DATE_FORMAT(CONVERT_TZ(qs.tgl, '+00:00', '+07:00'), '%d-%b %H:%i') AS formatted_date,
    u1.user_name AS nama_peserta,
    u2.user_name AS nama_penyimak,
    qs.setoran AS awal_surat,
    qs.info,
    qs.hasil AS kesimpulan_utama,
    qs.paraf,
    qs.penyetor,
    qs.penerima
FROM `qu_setoran` qs
JOIN `users` u1 ON qs.penyetor = u1.user_id
JOIN `users` u2 ON qs.penerima = u2.user_id
ORDER BY qs.tgl DESC";

$get_history = $db->query($query);
if ($db->error) {
    die('History query error: ' . $db->error);
}

while ($history = $get_history->fetch_assoc()) {
    $recap_history[] = $history;
}

// [4.1] Handle AJAX request for rekap by selectedClicked data
if (isset($_GET['action']) && $_GET['action'] === 'get_rekap_by_data' && isset($_GET['data'])) {
    header('Content-Type: application/json');

    error_log('Received AJAX request: action=get_rekap_by_data, data=' . $_GET['data']);
    $selected_data = json_decode(urldecode($_GET['data']), true);
    
    if (json_last_error() !== JSON_ERROR_NONE || !is_array($selected_data)) {
        error_log('Invalid JSON data: ' . json_last_error_msg());
        echo json_encode(['error' => 'Invalid JSON data']);
        exit;
    }

    error_log('Decoded selected_data: ' . print_r($selected_data, true));

    $critical_fields = ['formatted_date', 'penyetor_name', 'penerima_name', 'setoran', 'hasil', 'paraf'];
    foreach ($critical_fields as $field) {
        if (!isset($selected_data[$field])) {
            error_log("Missing critical field: $field");
            echo json_encode(['error' => "Missing field: $field"]);
            exit;
        }
    }

    $selected_data['penyetor_name'] = trim($selected_data['penyetor_name']);
    $selected_data['penerima_name'] = trim($selected_data['penerima_name']);
    $selected_data['setoran'] = trim($selected_data['setoran']);
    $selected_data['hasil'] = trim($selected_data['hasil']);
    $selected_data['info'] = isset($selected_data['info']) ? stripslashes(trim($selected_data['info'])) : '';

    // Parse tanggal dari format '13-Mei 13:45'
    $datetime = DateTime::createFromFormat('d-M H:i', $selected_data['formatted_date'], new DateTimeZone('Asia/Jakarta'));
    if ($datetime === false) {
        error_log('Invalid date format: ' . $selected_data['formatted_date']);
        echo json_encode(['error' => 'Invalid date format']);
        exit;
    }
    $db_date = $datetime->format('Y-m-d H:i:00');

    $query = "SELECT 
        qs.id,
        DATE_FORMAT(CONVERT_TZ(qs.tgl, '+00:00', '+07:00'), '%d-%b %H:%i') AS formatted_date,
        u1.user_name AS nama_peserta,
        u2.user_name AS nama_penyimak,
        qs.setoran AS awal_surat,
        qs.info AS info,
        qs.ket AS catatan,
        qs.hasil AS kesimpulan_utama,
        qs.paraf,
        qs.tampilan,
        qs.nomor,
        qs.perhalaman,
        qs.kesalahan
    FROM `qu_setoran` qs
    JOIN `users` u1 ON qs.penyetor = u1.user_id
    JOIN `users` u2 ON qs.penerima = u2.user_id
    WHERE qs.tgl = ?
        AND u1.user_name = ?
        AND u2.user_name = ?
        AND qs.setoran = ?
        AND qs.hasil = ?
        AND qs.paraf = ?";
    
    if (!empty($selected_data['info'])) {
        $query .= " AND qs.info = ?";
    } else {
        $query .= " AND (qs.info IS NULL OR qs.info = '')";
    }

    $stmt = $db->prepare($query);
    if (!$stmt) {
        error_log('Prepare statement failed: ' . $db->error);
        echo json_encode(['error' => 'Prepare statement failed: ' . $db->error]);
        exit;
    }
    
    $params = [
        $db_date,
        $selected_data['penyetor_name'],
        $selected_data['penerima_name'],
        $selected_data['setoran'],
        $selected_data['hasil'],
        $selected_data['paraf']
    ];
    if (!empty($selected_data['info'])) {
        $params[] = $selected_data['info'];
    }

    $types = str_repeat('s', count($params));
    $stmt->bind_param($types, ...$params);
    
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows === 0) {
        error_log('No data found for query: ' . $query);
        error_log('Parameters: ' . print_r($params, true));
        echo json_encode(['error' => 'No data found for the selected criteria']);
        exit;
    }
    
    $data = $result->fetch_assoc();
    error_log('Data found: ' . print_r($data, true));
    echo json_encode($data);
    $stmt->close();
    exit;
}

// [4.2] Handle AJAX request for city data
if (isset($_GET['action']) && $_GET['action'] === 'get_cities') {
    header('Content-Type: application/json');

    $city_data = [];
    $query = "SELECT 
        kota,
        lat,
        `long`,
        (COALESCE(t1, 0) + COALESCE(t2, 0) + COALESCE(t3, 0) + COALESCE(t4, 0) + 
         COALESCE(t5, 0) + COALESCE(t6, 0) + COALESCE(t7, 0) + COALESCE(t8, 0) + 
         COALESCE(t9, 0) + COALESCE(t10, 0) + COALESCE(t11, 0) + COALESCE(t12, 0) + 
         COALESCE(t13, 0) + COALESCE(t14, 0) + COALESCE(t15, 0) + COALESCE(t16, 0) + 
         COALESCE(t17, 0) + COALESCE(t18, 0) + COALESCE(t19, 0) + COALESCE(t20, 0) + 
         COALESCE(t21, 0) + COALESCE(t22, 0) + COALESCE(t23, 0) + COALESCE(t24, 0) + 
         COALESCE(t25, 0) + COALESCE(t26, 0) + COALESCE(t27, 0) + COALESCE(t28, 0) + 
         COALESCE(t29, 0) + COALESCE(t30, 0) + COALESCE(t31, 0)) as total_setoran
    FROM qu_setoran_rekap
    WHERE lat IS NOT NULL AND `long` IS NOT NULL";
    
    $get_cities = $db->query($query);
    if ($db->error) {
        error_log('Cities query error: ' . $db->error);
        echo json_encode(['error' => 'Failed to fetch city data: ' . $db->error]);
        exit;
    }

    while ($city = $get_cities->fetch_assoc()) {
        $city_data[] = [
            'kota' => $city['kota'],
            'lat' => (float)$city['lat'],
            'long' => (float)$city['long'],
            'total_setoran' => (int)$city['total_setoran']
        ];
    }

    if (empty($city_data)) {
        error_log('No city data found with valid lat/long');
        echo json_encode(['error' => 'No city data available']);
        exit;
    }

    error_log('City data fetched: ' . count($city_data) . ' cities');
    echo json_encode($city_data);
    exit;
}

// [5] Filter data based on POST values
$filtered_history = array_filter($recap_history, function($history) use ($waktu_start, $penyetor, $penerima, $hasil, $paraf) {
    $match = true;

    if ($waktu_start) {
        $history_date = date('Y-m-d', strtotime($history['formatted_date']));
        $match = $match && ($history_date === $waktu_start);
    }

    if ($penyetor) {
        $match = $match && ($history['penyetor'] == $penyetor);
    }

    if ($penerima) {
        $match = $match && ($history['penerima'] == $penerima);
    }

    if ($hasil) {
        $match = $match && ($history['kesimpulan_utama'] === $hasil);
    }

    // Special handling for paraf filter
    if ($paraf === '0' || $paraf === '1') {  // Check if it's specifically '0' or '1'
        $match = $match && ($history['paraf'] == $paraf);
    }

    return $match;
});

$filtered_history = array_values($filtered_history);

$top_provinces = [];
$province_query = "SELECT 
    provinsi as name,
    SUM(COALESCE(t1, 0) + COALESCE(t2, 0) + COALESCE(t3, 0) + COALESCE(t4, 0) + 
        COALESCE(t5, 0) + COALESCE(t6, 0) + COALESCE(t7, 0) + COALESCE(t8, 0) + 
        COALESCE(t9, 0) + COALESCE(t10, 0) + COALESCE(t11, 0) + COALESCE(t12, 0) + 
        COALESCE(t13, 0) + COALESCE(t14, 0) + COALESCE(t15, 0) + COALESCE(t16, 0) + 
        COALESCE(t17, 0) + COALESCE(t18, 0) + COALESCE(t19, 0) + COALESCE(t20, 0) + 
        COALESCE(t21, 0) + COALESCE(t22, 0) + COALESCE(t23, 0) + COALESCE(t24, 0) + 
        COALESCE(t25, 0) + COALESCE(t26, 0) + COALESCE(t27, 0) + COALESCE(t28, 0) + 
        COALESCE(t29, 0) + COALESCE(t30, 0) + COALESCE(t31, 0)) as total
FROM `qu_setoran_rekap`
GROUP BY provinsi
ORDER BY total DESC
LIMIT 10";

$get_provinces = $db->query($province_query);
if (!$db->error) {
    $rank = 1;
    while ($province = $get_provinces->fetch_assoc()) {
        $province['rank'] = $rank++;
        $top_provinces[] = $province;
    }
}

$top_cities = [];
$city_query = "SELECT 
    kota as name,
    SUM(COALESCE(t1, 0) + COALESCE(t2, 0) + COALESCE(t3, 0) + COALESCE(t4, 0) + 
        COALESCE(t5, 0) + COALESCE(t6, 0) + COALESCE(t7, 0) + COALESCE(t8, 0) + 
        COALESCE(t9, 0) + COALESCE(t10, 0) + COALESCE(t11, 0) + COALESCE(t12, 0) + 
        COALESCE(t13, 0) + COALESCE(t14, 0) + COALESCE(t15, 0) + COALESCE(t16, 0) + 
        COALESCE(t17, 0) + COALESCE(t18, 0) + COALESCE(t19, 0) + COALESCE(t20, 0) + 
        COALESCE(t21, 0) + COALESCE(t22, 0) + COALESCE(t23, 0) + COALESCE(t24, 0) + 
        COALESCE(t25, 0) + COALESCE(t26, 0) + COALESCE(t27, 0) + COALESCE(t28, 0) + 
        COALESCE(t29, 0) + COALESCE(t30, 0) + COALESCE(t31, 0)) as total
FROM `qu_setoran_rekap`
GROUP BY kota
ORDER BY total DESC
LIMIT 10";

$get_cities = $db->query($city_query);
if (!$db->error) {
    $rank = 1;
    while ($city = $get_cities->fetch_assoc()) {
        $city['rank'] = $rank++;
        $top_cities[] = $city;
    }
}

$city_data = [];
$get_cities_map = $db->query(
    "SELECT 
        kota,
        lat,
        `long`,
        (COALESCE(t1, 0) + COALESCE(t2, 0) + COALESCE(t3, 0) + COALESCE(t4, 0) + 
         COALESCE(t5, 0) + COALESCE(t6, 0) + COALESCE(t7, 0) + COALESCE(t8, 0) + 
         COALESCE(t9, 0) + COALESCE(t10, 0) + COALESCE(t11, 0) + COALESCE(t12, 0) + 
         COALESCE(t13, 0) + COALESCE(t14, 0) + COALESCE(t15, 0) + COALESCE(t16, 0) + 
         COALESCE(t17, 0) + COALESCE(t18, 0) + COALESCE(t19, 0) + COALESCE(t20, 0) + 
         COALESCE(t21, 0) + COALESCE(t22, 0) + COALESCE(t23, 0) + COALESCE(t24, 0) + 
         COALESCE(t25, 0) + COALESCE(t26, 0) + COALESCE(t27, 0) + COALESCE(t28, 0) + 
         COALESCE(t29, 0) + COALESCE(t30, 0) + COALESCE(t31, 0)) as total_setoran
    FROM qu_setoran_rekap
    WHERE lat IS NOT NULL AND `long` IS NOT NULL"
);
if ($db->error) {
    error_log('Cities map query error: ' . $db->error);
} else {
    while ($city = $get_cities_map->fetch_assoc()) {
        $city_data[] = [
            'kota' => $city['kota'],
            'lat' => (float)$city['lat'],
            'long' => (float)$city['long'],
            'total_setoran' => (int)$city['total_setoran']
        ];
    }
    error_log('City data for map: ' . count($city_data) . ' cities');
}

$smarty->assign('recap_history', $filtered_history);
$smarty->assign('penyetor_options', $penyetor_options);
$smarty->assign('penerima_options', $penerima_options);
$smarty->assign('waktu_start', $waktu_start);
$smarty->assign('penyetor', $penyetor);
$smarty->assign('penerima', $penerima);
$smarty->assign('hasil', $hasil !== '' ? $hasil : 'semua');
$smarty->assign('paraf', $paraf !== '' ? $paraf : 'semua');

error_log("Assigned to Smarty: paraf=" . ($paraf !== '' ? $paraf : 'semua'));
$smarty->assign('top_provinces', $top_provinces);
$smarty->assign('top_cities', $top_cities);
$smarty->assign('city_data', $city_data);
$smarty->assign('system', $system);

try {
    $smarty->display('qurani/riwayat.tpl');
} catch (Exception $e) {
    die('Template error: ' . $e->getMessage());
}
?>
