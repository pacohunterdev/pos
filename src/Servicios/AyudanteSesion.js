const AyudateSesion = {
	verificarSesion(){
		let sesion = localStorage.getItem('id')
		if(sesion) return true
		return false
	},

	obtenerDatosSesion(){
		const id = localStorage.getItem('id')
		const usuario = localStorage.getItem('usuario')
		const nombre = localStorage.getItem('nombre')

		return {
			id: id,
			usuario: usuario,
			nombre: nombre
		}
	},

	establecerSesion(usuario){
		localStorage.setItem('id', usuario.id)
		localStorage.setItem('usuario', usuario.usuario)
		localStorage.setItem('nombre', usuario.nombre)
	},

	establecerDatosNegocio(datos){
		localStorage.setItem('nombreNegocio', datos.nombre)
		localStorage.setItem('telefonoNegocio', datos.telefono)
		localStorage.setItem('logoNegocio', datos.logo)
	},	

	obtenerDatosNegocio(){
		return {
			nombre: localStorage.getItem('nombreNegocio'),
			telefono: localStorage.getItem('telefonoNegocio'),
			logo: localStorage.getItem('logoNegocio')
		}
	},

	cerrarSesion(){
		localStorage.removeItem('id')
		localStorage.removeItem('usuario')
		localStorage.removeItem('nombre')
		location.reload()
	}
}

export default AyudateSesion