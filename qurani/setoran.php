<?php
/**
 * Islamic Page
 * 
 * @package Sngine
 * @author Dimas
 */

require('../bootloader.php');

error_log('setoran.php accessed with URI: ' . $_SERVER['REQUEST_URI']);

// Parse URL segments
$uri = explode('/', trim($_SERVER['REQUEST_URI'], '/'));
$base_path = 'qurani'; // Adjust based on your base URL structure
$segments = array_slice($uri, array_search('setoran', $uri) + 1);

error_log('Parsed segments: ' . print_r($segments, true));

// Initialize variables
$surah = null;
$juz = null;
$halaman = null;

// Check the first segment to determine the type
if (!empty($segments)) {
    switch ($segments[0]) {
        case 'surah':
            $surah = isset($segments[1]) && is_numeric($segments[1]) ? intval($segments[1]) : null;
            error_log('Surah value: ' . $surah);
            break;
        case 'juz':
            $juz = isset($segments[1]) && is_numeric($segments[1]) ? intval($segments[1]) : null;
            error_log('Juz value: ' . $juz);
            break;
        case 'page':
            $halaman = isset($segments[1]) && is_numeric($segments[1]) ? intval($segments[1]) : null;
            error_log('Page value: ' . $halaman);
            break;
        default:
            error_log('Unknown segment type: ' . $segments[0]);
            break;
    }
}

// Validate page number
if ($halaman !== null && ($halaman < 1 || $halaman > 604)) {
    error_log("Invalid page number: $halaman");
    _error(404, 'Nomor halaman tidak valid. Harus antara 1 dan 604.');
}

// Assign parameters to template
$smarty->assign('surah', $surah);
$smarty->assign('juz', $juz);
$smarty->assign('halaman', $halaman);

// Tampilkan halaman
page_header("Qurani Page");
page_footer('qurani/setoran');
?>
