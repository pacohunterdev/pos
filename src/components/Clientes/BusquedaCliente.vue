<template>
	<section>
		<b-field label="Nombre del cliente">
			<b-autocomplete
				v-model="cliente"
				id="cliente"
				placeholder="Escribe el nombre del cliente"
				:keep-first="true"
				:data="clientesFiltrados"
				field="nombre"
				@input="buscarClientes"
				@select="seleccionarCliente"
				size="is-medium"
			>
			</b-autocomplete>
		</b-field>
		<div class="notification is-info mt-2" v-if="clienteSeleccionado">
			<button class="delete" @click="deseleccionarCliente"></button>
			<p>Cliente: <b>{{ clienteSeleccionado.nombre }}</b></p>
			<p>Teléfono: <b>{{ clienteSeleccionado.telefono }}</b></p>
		</div>
	</section>
</template>
<script>
	import HttpService from '../../Servicios/HttpService'

	export default{
		name: "BusquedaCliente",

		data:()=>({
			cliente: "",
			clientesEncontrados: [],
			clienteSeleccionado: null
		}),

		methods: {
			deseleccionarCliente(){
				this.clienteSeleccionado = null
			},
			seleccionarCliente(opcion) {
				if(!opcion) return
				this.clienteSeleccionado = opcion
				this.$emit("seleccionado", this.clienteSeleccionado)
				setTimeout(() => this.cliente = '', 10)
			},

			buscarClientes(){
				let payload = {
					accion: 'obtener_por_nombre',
					nombre: this.cliente
				}

				HttpService.obtenerConConsultas('clientes.php', payload)
				.then(clientes =>{ 
					this.clientesEncontrados = clientes
				})
			},
		},

		computed: {
			clientesFiltrados() {
				return this.clientesEncontrados.filter(opcion => {
					return (
						opcion.nombre
							.toString()
							.toLowerCase()
							.indexOf(this.cliente.toLowerCase()) >= 0
					)
				})
			}
		}

	}
</script>