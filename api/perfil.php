<?php

include_once "encabezado.php";
$payload = json_decode(file_get_contents("php://input"));
if (!$payload) {
    http_response_code(500);
    exit;
}

include_once "funciones.php";

$accion = $payload->accion;

switch ($accion) {
	case 'obtener_ingresos':
		echo json_encode(
			[

				"totalIngresos" => calcularTotalIngresosUsuario($payload->idUsuario),
				"ingresosHoy" => calcularTotalIngresosHoyUsuario($payload->idUsuario),
				"ingresosSemana" => calcularTotalIngresosSemanaUsuario($payload->idUsuario),
				"ingresosMes" => calcularTotalIngresosMesUsuario($payload->idUsuario),				
			]
		);
		break;

	case 'obtener_ventas':
		echo json_encode(obtenerTotalVentasPorMesUsuario($payload->idUsuario, $payload->anioSeleccionado));
		break;

	default:
		echo json_encode("No se reconoce");
		break;
}