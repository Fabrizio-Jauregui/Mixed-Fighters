<?php
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
$host = "localhost";
$usuario = "root";
$contrasena = "";
$baseDatos = "mixed_fighters";

if (!in_array($_SERVER["REMOTE_ADDR"] ?? "", ["127.0.0.1", "::1"], true)) {
    http_response_code(403);
    exit;
}

$conexion = new mysqli($host, $usuario, $contrasena, $baseDatos);
$conexion->set_charset("utf8mb4");