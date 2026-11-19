<?php
header("Content-Type: application/json; charset=utf-8");
require_once __DIR__ . "/conexion.php";
$fila = $conexion->query("SELECT COALESCE(SUM(resultado = 'JUGADOR_1'), 0) AS victorias_jugador1, COALESCE(SUM(resultado = 'JUGADOR_2'), 0) AS victorias_jugador2 FROM peleas")->fetch_assoc();
$fila["victorias_jugador1"] = (int) $fila["victorias_jugador1"];
$fila["victorias_jugador2"] = (int) $fila["victorias_jugador2"];
echo json_encode($fila);