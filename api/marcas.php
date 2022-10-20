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
		echo json_encode(registrarMarca($payload->marca));
		break;

	case 'editar':
		echo json_encode(editarMarca($payload->marca));
		break;

	case 'eliminar':
		echo json_encode(eliminarMarca($payload->id));
		break;

	case 'obtener':
		echo json_encode(obtenerMarcas());
		break;
	
	default:
		echo json_encode("No se reconoce");
		break;
}