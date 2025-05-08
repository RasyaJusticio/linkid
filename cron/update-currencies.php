<?php

require "../bootstrap.php";

function json_response($status, $data, $code = 200)
{
    http_response_code($code);
    header('Content-Type: application/json');

    echo json_encode(
        [
        'status' => $status,
        'data' => $data,
        ]
    );

    exit;
}

if (!isset($_GET['token']) || $_GET['token'] !== CRON_KEY) {
    json_response(
        'fail', [
        'message' => 'Unauthenticated'
        ], 401
    );
}

$API_KEY = EXCHANGE_RATE_API_KEY;
$url = "https://v6.exchangerate-api.com/v6/{$API_KEY}/latest/USD";

$response = file_get_contents($url);

if (!$response) {
    json_response(
        'fail', [
        'message' => 'Failed to connect with exchangerate-api',
        ], 500
    ); 
}

$data = json_decode($response, true);

if ($data['result'] != 'success') {
    json_response(
        'fail', [
        'message' => 'Failed to fetch conversion rates',
        'response' => $data
        ], 500
    );
}

$conversion_rates = $data["conversion_rates"];

$get_currencies = $db->query('SELECT currency_id, code FROM system_currencies');
$currencies = [];

if ($get_currencies->num_rows > 0) {
    while ($currency = $get_currencies->fetch_assoc()) {
        $currencies[] = $currency;
    }
}

foreach ($currencies as $currency) {
    $code = $currency['code']; 
    $id = $currency['currency_id'];
    
    if (isset($conversion_rates[$code])) {
        $db->query(
            sprintf(
                "UPDATE system_currencies SET exchange_rate = %s WHERE currency_id = %s",
                secure($conversion_rates[$code], 'float'), 
                secure($id, 'int')
            )
        );
    }
}

json_response("success", [
    'message' => 'Successfully updated the conversion rates of the currencies',
], 200);
