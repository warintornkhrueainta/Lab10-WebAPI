<?php
header("Content-Type: application/json");

// เชื่อมต่อฐานข้อมูล
$host = "localhost";
$user = "root"; // เปลี่ยนตามของคุณ
$pass = "";     // เปลี่ยนตามของคุณ
$db   = "webapi_demo";

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(["error" => "Database connection failed"]);
    exit;
}

// ดึง path และลบ index.php
$path = parse_url($_SERVER["REQUEST_URI"], PHP_URL_PATH);
$script = $_SERVER["SCRIPT_NAME"];
$endpoint = trim(str_replace($script, '', $path), '/');
$endpoint = preg_replace('#^index\.php/?#', '', $endpoint);

$method = $_SERVER['REQUEST_METHOD'];

// GET all products
if ($endpoint === 'products' && $method === 'GET') {
    $result = $conn->query("SELECT * FROM products");
    $products = [];
    while ($row = $result->fetch_assoc()) {
        $products[] = $row;
    }
    echo json_encode($products);
}
// GET product by ID
else if (preg_match('/^products\/(\d+)$/', $endpoint, $matches) && $method === 'GET') {
    $id = (int)$matches[1];
    $stmt = $conn->prepare("SELECT * FROM products WHERE id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($product = $result->fetch_assoc()) {
        echo json_encode($product);
    } else {
        http_response_code(404);
        echo json_encode(["error" => "Product not found"]);
    }
}
else {
    http_response_code(404);
    echo json_encode(["error" => "Invalid endpoint"]);
}

$conn->close();
