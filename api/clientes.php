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
		echo json_encode(registrarCliente($payload->cliente));
		break;

	case 'obtener':
		echo json_encode(obtenerClientes());
		break;
	
	case 'obtener_por_nombre':
		echo json_encode(obtenerClientesPorNombre($payload->nombre));
		break;

	case 'obtener_por_id':
		echo json_encode(obtenerClientePorId($payload->id));
		break;

	case 'editar':
		echo json_encode(editarCliente($payload->cliente));
		break;
	
	case 'eliminar':
		echo json_encode(eliminarCliente($payload->id));
		break;
	
	default:
		echo json_encode("No se reconoce");
		break;
}