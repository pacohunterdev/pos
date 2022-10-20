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

				"totalIngresos" => calcularTotalIngresos(),
				"ingresosHoy" => calcularTotalIngresosHoy(),
				"ingresosSemana" => calcularTotalIngresosSemana(),
				"ingresosMes" => calcularTotalIngresosMes(),
				"ingresosPendientes" => calcularIngresosPendientes()
				
			]
		);
		break;

	case 'obtener_totales_meses':
		echo json_encode(obtenerTotalesVentasPorMes($payload->anioSeleccionado));
		break;

	case 'obtener_totales_usuarios':
		echo json_encode(obtenerVentasPorUsuario());
		break;

	case 'obtener_totales_clientes':
		echo json_encode(obtenerVentasPorCliente());
		break;

	case 'obtener_totales_dia':
		echo json_encode(obtenerVentasPorDiaMes($payload->mesSeleccionado, $payload->anioSeleccionado));
		break;

	case 'obtener_productos_mayores':
		echo json_encode(obtenerProductosMasVendidos($payload->limite));
		break;

	case 'obtener_marcas_categorias':
		echo json_encode(
			[
				"marcas" => obtenerTotalesMarca(),
				"categorias" => obtenerTotalesCategoria()
			]
		);
		break;
	
	default:
		echo json_encode("No se reconoce");
		break;
}