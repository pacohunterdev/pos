const  RUTA_GLOBAL = "http://localhost/pos/api/"
const HttpService =  {
	async registrar(ruta, datos) {
		let respuesta = await fetch(RUTA_GLOBAL + ruta, {
			method: "post",				
			body: JSON.stringify(datos),
		});
		let resultado = await respuesta.json()
		return resultado
	},

	async obtener(ruta) {
		let respuesta = await fetch(RUTA_GLOBAL + ruta)
		let resultado = await respuesta.json()
		return resultado
	},

	async editar(ruta, datos) {
		let respuesta = await fetch(RUTA_GLOBAL + ruta, {
			method: "post",				
			body: JSON.stringify(datos),
		});
		let resultado = await respuesta.json()
		return resultado
	},

	async eliminar(ruta, datos) {
		let respuesta = await fetch(RUTA_GLOBAL + ruta, {
			method: "post",				
			body: JSON.stringify(datos),
		});
		let resultado = await respuesta.json()
		return resultado
	},

	async obtenerConConsultas(ruta, payload){
		let respuesta = await fetch(RUTA_GLOBAL + ruta, {
			method: "post",				
			body: JSON.stringify(payload),
		});
		let resultado = await respuesta.json()
		return resultado
	},

	obtenerDatosNegocio(){
		return this.obtener("configuracion/obtener_datos.php")
	}
}

export default HttpService