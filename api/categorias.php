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
		echo json_encode(registrarCategoria($payload->categoria));
		break;

	case 'obtener':
		echo json_encode(obtenerCategorias());
		break;

	case 'editar':
		echo json_encode(editarCategoria($payload->categoria));
		break;

	case 'eliminar':
		echo json_encode(eliminarCategoria($payload->id));
		break;
	
	default:
		echo json_encode("No se reconoce");
		break;
}