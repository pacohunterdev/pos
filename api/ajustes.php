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
		echo json_encode(registrarAjustes($payload->ajustes));
		break;

	case 'obtener':
		$ajustes = obtenerAjustes();
		if(!$ajustes){
			$ajustes = [
				"nombre" => "POSPacoHunterDev",
				"telefono" => "777666123",
				"logo" => "/logos/logo.png"
			];
		}
		echo json_encode($ajustes);
		break;

	
	default:
		echo json_encode("No se reconoce");
		break;
}