<?php
/**
 * Rekapan Page
 * 
 * @package Sngine
 * @author Dimas
 */

require('../bootloader.php');

// Cek apakah pengguna sudah login
if (!$user->_logged_in) {
    http_response_code(401);
    echo json_encode(['error' => 'Anda harus login untuk mengakses halaman ini.']);
    exit;
}

// Periksa apakah permintaan adalah POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    header('Content-Type: application/json');
    // Ambil data dari body JSON
    $input = json_decode(file_get_contents('php://input'), true);
    $setoran_id = isset($input['id']) ? intval($input['id']) : null;

    if ($setoran_id) {
        // Query untuk mengambil data setoran berdasarkan ID
        $query = $db->prepare(
            "SELECT 
                qs.id,
                DATE_FORMAT(qs.tgl, '%d %b %Y, %H:%i') AS formatted_date,
                u1.user_name AS penyetor_name,
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
            WHERE qs.id = ?"
        );
        $query->bind_param('i', $setoran_id);
        $query->execute();
        $result = $query->get_result();
        $setoran_data = $result->fetch_assoc();

        if ($setoran_data) {
            echo json_encode($setoran_data);
        } else {
            http_response_code(404);
            echo json_encode(['error' => 'Data setoran tidak ditemukan']);
        }
    } else {
        http_response_code(400);
        echo json_encode(['error' => 'ID setoran tidak diberikan']);
    }
    exit;
}

// Jika GET, render halaman
$setoran_id = isset($_GET['id']) ? intval($_GET['id']) : null;

if ($setoran_id) {
    $query = $db->prepare(
        "SELECT 
            qs.id,
            DATE_FORMAT(qs.tgl, '%d %b %Y, %H:%i') AS formatted_date,
            u1.user_id AS penyetor,
            u1.user_name AS penyetor_name,
            u2.user_id AS penerima,
            u2.user_name AS penerima_name,
            qs.setoran,
            qs.info,
            qs.hasil,
            qs.paraf,
            qs.tampilan,
            qs.nomor,
            qs.ket,
            qs.kesalahan,
            qs.perhalaman,
            (SELECT COUNT(*) FROM groups_members gm WHERE gm.user_id = u2.user_id AND gm.group_id IN (SELECT group_id FROM groups_members WHERE user_id = u1.user_id)) AS is_group_member
        FROM qu_setoran qs
        JOIN users u1 ON qs.penyetor = u1.user_id
        JOIN users u2 ON qs.penerima = u2.user_id
        WHERE qs.id = ?"
    );
    $query->bind_param('i', $setoran_id);
    $query->execute();
    if ($query->error) {
        error_log("Database error in rekapan.php: " . $query->error);
        _error(500, 'Gagal mengambil data setoran');
    }
    $result = $query->get_result();
    $setoran_data = $result->fetch_assoc();

    if (!$setoran_data) {
        error_log("Data setoran tidak ditemukan untuk ID: $setoran_id");
        _error(404, 'Data setoran tidak ditemukan');
    }

    // Tentukan penyimak_type
    $setoran_data['penyimak_type'] = $setoran_data['is_group_member'] > 0 ? 'grup' : 'teman';

    $smarty->assign('setoran_data', $setoran_data);
} else {
    error_log("ID setoran tidak diberikan di rekapan.php");
    _error(400, 'ID setoran tidak diberikan');
}

error_log("Rendering qurani_rekapan.tpl untuk setoran_id: $setoran_id");
page_header("Rekapan Setoran");
page_footer('qurani/rekapan');
?>
