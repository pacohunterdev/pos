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
		$password =  password_hash(PASSWORD_DEFECTO, PASSWORD_DEFAULT);
		$usuario = $payload->usuario;
		$usuario->password = $password;
		echo json_encode(registrarUsuario($usuario));
		break;

	case 'obtener':
		echo json_encode(obtenerUsuarios());
		break;

	case 'iniciar_sesion':
		echo json_encode(iniciarSesion($payload->usuario));
		break;
	
	case 'obtener_por_nombre':
		echo json_encode(obtenerClientesPorNombre($payload->nombre));
		break;

	case 'obtener_por_id':
		echo json_encode(obtenerUsuarioPorId($payload->id));
		break;

	case 'editar':
		echo json_encode(editarUsuario($payload->usuario));
		break;
	
	case 'eliminar':
		echo json_encode(eliminarUsuario($payload->id));
		break;
	
	case 'verificar_password':
		echo json_encode(verificarPassword($payload->idUsuario, $payload->password));
		break;

	case 'cambiar_password':
		$password =  password_hash($payload->password, PASSWORD_DEFAULT);
		echo json_encode(cambiarPassword($payload->idUsuario, $password));
		break;
	
	default:
		echo json_encode("No se reconoce");
		break;
}