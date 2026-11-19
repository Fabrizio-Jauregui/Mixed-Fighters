<?php
require_once __DIR__ . "/conexion.php";
$resultado = $_POST["resultado"] ?? "";
if (!in_array($resultado, ["JUGADOR_1", "JUGADOR_2", "EMPATE"], true)) {
    http_response_code(400);
    exit;
}
$consulta = $conexion->prepare("INSERT INTO peleas (resultado) VALUES (?)");
$consulta->bind_param("s", $resultado);
$consulta->execute();
echo "OK";