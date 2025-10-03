<?php
require_once __DIR__ . "/Database.php";
require_once __DIR__ . "/Response.php";

class ApplianceController {
    private $conn;

    public function __construct() {
        $database = new Database();
        $this->conn = $database->getConnection();
    }

    // GET /api/products
    public function index() {
        $stmt = $this->conn->query("SELECT * FROM products ORDER BY id DESC");
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        Response::json(["data" => $data]);
    }

    // GET /api/products/{id}
    public function show($id) {
        $stmt = $this->conn->prepare("SELECT * FROM products WHERE id = ?");
        $stmt->execute([$id]);
        $data = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$data) Response::json(["error" => "Not found"], 404);
        Response::json(["data" => $data]);
    }

    // POST /api/products
    public function store($input) {
        try {
            $stmt = $this->conn->prepare("INSERT INTO products (sku, name, brand, category, price, stock, warranty_months) VALUES (?, ?, ?, ?, ?, ?, ?)");
            $stmt->execute([
                $input['sku'], $input['name'], $input['brand'], $input['category'],
                $input['price'], $input['stock'], $input['warranty_months']
            ]);
            $id = $this->conn->lastInsertId();
            $this->show($id);
        } catch(PDOException $e) {
            if ($e->getCode() == 23000) Response::json(["error" => "SKU already exists"], 409);
            Response::json(["error" => $e->getMessage()], 400);
        }
    }

    // PUT /api/products/{id}
    public function update($id, $input) {
        $set = [];
        $values = [];
        foreach ($input as $key => $value) {
            $set[] = "$key = ?";
            $values[] = $value;
        }
        $values[] = $id;
        $sql = "UPDATE products SET " . implode(", ", $set) . " WHERE id = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute($values);

        $this->show($id);
    }

    // DELETE /api/products/{id}
    public function destroy($id) {
        $stmt = $this->conn->prepare("DELETE FROM products WHERE id = ?");
        $stmt->execute([$id]);
        if ($stmt->rowCount() === 0) Response::json(["error" => "Not found"], 404);
        Response::json(["message" => "Deleted"]);
    }
}
