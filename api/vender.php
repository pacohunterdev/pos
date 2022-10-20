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
	case 'vender':
		echo json_encode(terminarVenta($payload->datos));
		break;

	case 'obtener_ventas':
		echo json_encode(
			[
				"totalVentas" => obtenerTotalVentas($payload->filtros),
				"ventas" => obtenerVentas($payload->filtros)
			]
		);
		break;

	case 'obtener_cuentas':
		echo json_encode(
			[
				"totalPagos" => obtenerPagosCuentasApartados($payload->filtros,'cuenta'),
				"totalCuentas" => obtenerTotalCuentasApartados($payload->filtros,'cuenta'),
				"totalPorPagar" => obtenerTotalPorPagarCuentasApartados($payload->filtros,'cuenta'),
				"cuentas" => obtenerCuentasApartados($payload->filtros, 'cuenta')
			])
		;
		break;

	case 'obtener_apartados':
		echo json_encode(
			[
				"totalPagos" => obtenerPagosCuentasApartados($payload->filtros,'apartado'),
				"totalApartados" => obtenerTotalCuentasApartados($payload->filtros,'apartado'),
				"totalPorPagar" => obtenerTotalPorPagarCuentasApartados($payload->filtros,'apartado'),
				"apartados" => obtenerCuentasApartados($payload->filtros, 'apartado')
			]
		);
		break;

	case 'obtener_cotizaciones':
		echo json_encode(
			[
				"cotizaciones" => obtenerCotizaciones($payload->filtros, 'cotiza')
			]
		);
		break;

	case 'eliminar_cotizacion':
		echo json_encode(eliminarCotizacion($payload->id));
		break;

	case 'abonar':
		echo json_encode(abonarACuentaApartado($payload->total, $payload->id));
		break;
	
	default:
		echo json_encode("No se reconoce");
		break;
}