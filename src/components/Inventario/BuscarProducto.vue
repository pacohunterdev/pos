<template>
	<b-field label="Buscar producto por nombre o código de barras">
		<b-autocomplete
			v-model="producto"
			id="producto"
			placeholder="Escribe el nombre o el código de barras del producto"
			:keep-first="true"
			:data="productosFiltrados"
			field="nombre"
			@input="buscarProductos"
			@select="seleccionarProducto"
			size="is-large"
		>
		</b-autocomplete>
	</b-field>
</template>
<script>
	import HttpService from '../../Servicios/HttpService'

	export default {
		name: "BuscarProducto",

		data:()=>({
			producto: "",
			productosEncontrados: []
		}),

		mounted(){
			this.ponerFocus()
		},

		methods: {
			seleccionarProducto(opcion) {
				if(!opcion) return
		
				this.$emit("seleccionado", opcion)
			this.ponerFocus()
				setTimeout(() => this.producto = '', 10)
			},

			buscarProductos(){
				let payload = {
					accion: 'obtener_nombre_codigo',
					producto: this.producto
				}

				HttpService.obtenerConConsultas('productos.php', payload)
				.then(productos =>{ 
					this.productosEncontrados = productos
				})
			},

			ponerFocus(){
				document.querySelector("#producto").focus()
			}
		},

		computed: {
			productosFiltrados() {
				return this.productosEncontrados.filter(opcion => {
					return (
						opcion.nombre
							.toString()
							.toLowerCase()
							.indexOf(this.producto.toLowerCase()) >= 0
							||
						opcion.codigo
							.toString()
							.indexOf(this.producto) >= 0		
					)
				})
			}
		}


	}
</script>