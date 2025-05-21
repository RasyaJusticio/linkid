<?php
/**
 * Qurani Form Page
 * 
 * @package Sngine
 * @author Dimas
 */

require('../bootloader.php');
$user_id = $_SESSION['user_id'];


// Set timezone
date_default_timezone_set('Asia/Jakarta');

// Cek apakah pengguna sudah login
if (!$user->_logged_in) {
    header('HTTP/1.0 401 Unauthorized');
    _error(401, 'Anda harus login untuk mengakses halaman ini.');
}

// Handle AJAX request for searching setoran
if (isset($_GET['action']) && $_GET['action'] === 'search_setoran') {
    header('Content-Type: application/json; charset=UTF-8');

    // Ambil parameter pencarian
    $formatted_date = isset($_GET['formatted_date']) ? $_GET['formatted_date'] : '';
    $penyetor_name = isset($_GET['penyetor_name']) ? $_GET['penyetor_name'] : '';
    $penerima_name = isset($_GET['penerima_name']) ? $_GET['penerima_name'] : '';
    $setoran = isset($_GET['setoran']) ? $_GET['setoran'] : '';

    // Validasi input
    if (empty($formatted_date) || empty($penyetor_name) || empty($penerima_name) || empty($setoran)) {
        http_response_code(400);
        echo json_encode(['error' => 'Parameter pencarian tidak lengkap']);
        exit;
    }

    // Validasi format tanggal (tetap gunakan format input 'd M Y, H:i')
    $date = DateTime::createFromFormat('d M Y, H:i', $formatted_date, new DateTimeZone('Asia/Jakarta'));
    if ($date === false) {
        http_response_code(400);
        echo json_encode(['error' => 'Format tanggal tidak valid. Gunakan format seperti "05 May 2025, 08:38"']);
        exit;
    }
    $db_datetime = $date->format('Y-m-d H:i');

    // Query untuk mencari setoran
    $query = $db->prepare(
        "SELECT 
            qs.id,
            DATE_FORMAT(qs.tgl, '%d-%b %H:%i') AS formatted_date, -- Ubah format ke 'tgl-bulan jam:menit'
            u1.user_id AS penyetor_id,
            u1.user_name AS penyetor_name,
            u2.user_id AS penerima_id,
            u2.user_name AS penerima_name,
            qs.setoran,
            qs.info,
            qs.hasil,
            qs.paraf,
            qs.tampilan,
            qs.nomor,
            qs.ket,
            qs.kesalahan,
            qs.perhalaman
        FROM qu_setoran qs
        JOIN users u1 ON qs.penyetor = u1.user_id
        JOIN users u2 ON qs.penerima = u2.user_id
        WHERE DATE_FORMAT(qs.tgl, '%Y-%m-%d %H:%i') = ?
            AND u1.user_name = ?
            AND u2.user_name = ?
            AND qs.setoran = ?
        LIMIT 1"
    );

    $query->bind_param('ssss', $db_datetime, $penyetor_name, $penerima_name, $setoran);
    $query->execute();
    $result = $query->get_result();
    $setoran_data = $result->fetch_assoc();

    if (!$setoran_data) {
        http_response_code(404);
        echo json_encode(['error' => 'Setoran tidak ditemukan']);
        exit;
    }

    echo json_encode($setoran_data);
    exit;
}

// Handle AJAX request for updating paraf
if (isset($_GET['action']) && $_GET['action'] === 'update_paraf') {
    header('Content-Type: application/json; charset=UTF-8');

    // Get JSON input
    $input = json_decode(file_get_contents('php://input'), true);

    // Validasi input
    if (!isset($input['id']) || !isset($input['user_id'])) {
        http_response_code(400);
        echo json_encode(['error' => 'Parameter id atau user_id tidak ditemukan']);
        exit;
    }

    $setoran_id = (int)$input['id'];
    $user_id = (int)$input['user_id'];

    if ($setoran_id <= 0 || $user_id <= 0) {
        http_response_code(400);
        echo json_encode(['error' => 'ID setoran atau pengguna tidak valid']);
        exit;
    }

    // Mulai transaksi untuk memastikan integritas data
    $db->begin_transaction();

    try {
        // Verifikasi bahwa setoran ada dan belum diparaf
        $query = $db->prepare(
            "SELECT penyetor, penerima, paraf 
             FROM qu_setoran 
             WHERE id = ?"
        );
        $query->bind_param('i', $setoran_id);
        $query->execute();
        $result = $query->get_result();
        $setoran = $result->fetch_assoc();

        if (!$setoran) {
            http_response_code(404);
            echo json_encode(['error' => 'Setoran tidak ditemukan']);
            $db->rollback();
            exit;
        }

        if ($setoran['paraf'] == 1) {
            http_response_code(400);
            echo json_encode(['error' => 'Setoran sudah diparaf']);
            $db->rollback();
            exit;
        }

        // Verifikasi bahwa pengguna adalah penyetor atau penerima
        if ($user_id != $setoran['penyetor'] && $user_id != $setoran['penerima']) {
            http_response_code(403);
            echo json_encode(['error' => 'Anda tidak diizinkan untuk memparaf setoran ini']);
            $db->rollback();
            exit;
        }

        // Update paraf field
        $query = $db->prepare("UPDATE qu_setoran SET paraf = 1 WHERE id = ?");
        $query->bind_param('i', $setoran_id);
        $query->execute();

        if ($query->affected_rows > 0) {
            $db->commit();
            echo json_encode(['success' => true]);
        } else {
            $db->rollback();
            http_response_code(500);
            echo json_encode(['error' => 'Gagal memperbarui paraf: Tidak ada perubahan dilakukan']);
        }
    } catch (Exception $e) {
        $db->rollback();
        http_response_code(500);
        echo json_encode(['error' => 'Gagal memperbarui paraf: ' . $e->getMessage()]);
    }
    exit;
}

// Handle AJAX request for city data
if (isset($_GET['action']) && $_GET['action'] === 'get_cities') {
    header('Content-Type: application/json; charset=UTF-8');

    // Query untuk mengambil data kota
    $query = $db->query(
        "SELECT 
            kota,
            lat,
            `long`,
            SUM(COALESCE(t1, 0) + COALESCE(t2, 0) + COALESCE(t3, 0) + COALESCE(t4, 0) +
                COALESCE(t5, 0) + COALESCE(t6, 0) + COALESCE(t7, 0) + COALESCE(t8, 0) +
                COALESCE(t9, 0) + COALESCE(t10, 0) + COALESCE(t11, 0) + COALESCE(t12, 0) +
                COALESCE(t13, 0) + COALESCE(t14, 0) + COALESCE(t15, 0) + COALESCE(t16, 0) +
                COALESCE(t17, 0) + COALESCE(t18, 0) + COALESCE(t19, 0) + COALESCE(t20, 0) +
                COALESCE(t21, 0) + COALESCE(t22, 0) + COALESCE(t23, 0) + COALESCE(t24, 0) +
                COALESCE(t25, 0) + COALESCE(t26, 0) + COALESCE(t27, 0) + COALESCE(t28, 0) +
                COALESCE(t29, 0) + COALESCE(t30, 0) + COALESCE(t31, 0)) AS total_setoran
        FROM qu_setoran_rekap
        WHERE lat IS NOT NULL
            AND `long` IS NOT NULL
        GROUP BY kota, lat, `long`"
    );

    $cities = [];
    while ($row = $query->fetch_assoc()) {
        $cities[] = [
            'kota' => htmlspecialchars($row['kota'], ENT_QUOTES, 'UTF-8'),
            'lat' => floatval($row['lat']),
            'long' => floatval($row['long']),
            'total_setoran' => intval($row['total_setoran'])
        ];
    }

    echo json_encode($cities);
    exit;
}

// Get logged in user data
$user_data = $user->_data;
$current_user = [
    'user_id' => $user_data['user_id'],
    'user_name' => $user_data['user_name']
];


$all_groups = [];
$get_groups = $db->query("
    SELECT g.group_id, g.group_title
    FROM `groups` g
    INNER JOIN `groups_members` gm ON g.group_id = gm.group_id
    WHERE gm.user_id = {$current_user['user_id']}
    ORDER BY g.group_title
");

if ($db->error) {
    _error('Database Error', 'Group query error: ' . $db->error);
}

while ($group = $get_groups->fetch_assoc()) {
    $group_members = [];
    $get_members = $db->query(sprintf(
        "SELECT u.user_id, CONCAT(u.user_firstname, ' ', u.user_lastname) AS user_name 
        FROM `groups_members` gm
        JOIN `users` u ON gm.user_id = u.user_id
        WHERE gm.group_id = %d
        ORDER BY u.user_firstname, u.user_lastname",
        $group['group_id']
    ));

    if ($db->error) {
        _error('Database Error', 'Members query error: ' . $db->error);
    }

    while ($member = $get_members->fetch_assoc()) {
        // Lewati user yang sedang login
        if ($member['user_id'] == $current_user['user_id']) {
            continue;
        }
        $group_members[] = $member;
    }

    $group['members'] = $group_members;
    $all_groups[] = $group;
}



// Get all users for select options
$all_users = [];
$get_users = $db->query("
    SELECT 
        u.user_id,
        CONCAT(u.user_firstname, ' ', u.user_lastname) AS fullname
    FROM friends f
    JOIN users u 
        ON (u.user_id = f.user_one_id AND f.user_two_id = {$current_user['user_id']})
        OR (u.user_id = f.user_two_id AND f.user_one_id = {$current_user['user_id']})
    WHERE f.status = 1 AND u.user_id != {$current_user['user_id']}
    ORDER BY fullname
");

if ($db->error) {
    _error('Database Error', 'Users query error: ' . $db->error);
}
while ($u = $get_users->fetch_assoc()) {
    $all_users[] = $u;
}


$riwayat_setoran = [];
$get_history = $db->query(
    "SELECT 
        qs.id,
        DATE_FORMAT(qs.tgl, '%d-%b %H:%i') AS formatted_date,
        u1.user_id AS penyetor_id,
        u1.user_name AS penyetor_name,
        CONCAT(u1.user_firstname, ' ', u1.user_lastname) AS penyetor_fullname,
        u2.user_id AS penerima_id,
        u2.user_name AS penerima_name,
        CONCAT(u2.user_firstname, ' ', u2.user_lastname) AS penerima_fullname,
        CONCAT(
            CONCAT(UPPER(LEFT(qs.setoran, 1)), LOWER(SUBSTRING(qs.setoran, 2))),
            ' ',
            qs.tampilan,
            CASE 
                WHEN qs.tampilan = 'juz' AND qs.nomor IS NOT NULL AND qs.nomor != '' THEN CONCAT(' ', qs.nomor)
                WHEN qs.tampilan = 'surat' AND qs.info IS NOT NULL AND qs.info != '' THEN CONCAT(' ', qs.info)
                ELSE ''
            END,
            CASE 
                WHEN qs.tampilan != 'juz' AND qs.perhalaman IS NOT NULL AND JSON_VALID(qs.perhalaman) THEN
                    CONCAT(' Ayat ', JSON_UNQUOTE(JSON_EXTRACT(qs.perhalaman, '$.ayat.awal')), '-', JSON_UNQUOTE(JSON_EXTRACT(qs.perhalaman, '$.ayat.akhir')))
                ELSE ''
            END
        ) AS setoran,
        qs.hasil,
        qs.paraf
    FROM qu_setoran qs
    JOIN users u1 ON qs.penyetor = u1.user_id
    JOIN users u2 ON qs.penerima = u2.user_id
    WHERE qs.penyetor = {$current_user['user_id']} OR qs.penerima = {$current_user['user_id']}
    ORDER BY qs.tgl DESC
    LIMIT 10
"
);
if ($db->error) {
    _error('Database Error', 'History query error: ' . $db->error);
}
while ($history = $get_history->fetch_assoc()) {
    $riwayat_setoran[] = $history;
}

// Get city data for map
$city_data = [];
$get_cities = $db->query(
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
         COALESCE(t29, 0) + COALESCE(t30, 0) + COALESCE(t31, 0)) AS total_setoran
    FROM qu_setoran_rekap
    WHERE lat IS NOT NULL AND `long` IS NOT NULL"
);
if ($db->error) {
    _error('Database Error', 'Cities query error: ' . $db->error);
}
while ($city = $get_cities->fetch_assoc()) {
    $city_data[] = [
        'kota' => $city['kota'],
        'lat' => (float) $city['lat'],
        'long' => (float) $city['long'],
        'total_setoran' => (int) $city['total_setoran']
    ];
}

// Settings Grup 

// Assign data to template
$smarty->assign('current_user', $current_user);
$smarty->assign('all_groups', $all_groups);
$smarty->assign('all_users', $all_users);
$smarty->assign('riwayat_setoran', $riwayat_setoran);
$smarty->assign('city_data', $city_data);

// Display page
page_header("Qurani Page");
page_footer('qurani-form');
?>
