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
	case 'registrar':
		echo json_encode(registrarProducto($payload->producto));
		break;

	case 'obtener':
		echo json_encode(
			[
				"productos" => obtenerProductos(),
				"gananciaInventario" => calcularGananciaInventario(),
				"totalInventario" => calcularTotalInventario(),
				"totalProductos" => calcularNumeroTotalProductos()
			]
		);
		break;

	case 'obtener_nombre_codigo':
		echo json_encode(buscarProductoPorNombreOCodigo($payload->producto));
		break;

	case 'obtener_por_id':
		echo json_encode(obtenerProductoPorId($payload->id));
		break;

	case 'editar':
		echo json_encode(editarProducto($payload->producto));
		break;

	case 'eliminar':
		echo json_encode(eliminarProducto($payload->id));
		break;

	case 'agregar_existencia':
		echo json_encode(agregarExistenciaProducto($payload->cantidad, $payload->id));
		break;
	
	case 'restar_existencia':
		echo json_encode(restarExistenciaProducto($payload->cantidad, $payload->id));
		break;
	
	default:
		echo json_encode("No se reconoce");
		break;
}