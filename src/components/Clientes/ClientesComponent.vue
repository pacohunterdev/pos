<template>
	<section>
		<nav-component :titulo="'Clientes'" :link="{ path: '/agregar-cliente' }" :texto="'Agregar cliente'" />
		<b-table
		:data="clientes">
			<b-table-column field="nombre" label="Nombre del cliente" sortable searchable v-slot="props">
				{{ props.row.nombre }}
			</b-table-column>

			<b-table-column field="telefono" label="Teléfono" sortable searchable v-slot="props">
				{{ props.row.telefono }}
			</b-table-column>

			<b-table-column field="eliminar" label="Eliminar" v-slot="props">
				<b-button type="is-danger" icon-left="delete" @click="eliminar(props.row.id)">Eliminar</b-button>
			</b-table-column>

			<b-table-column field="editar" label="Editar" v-slot="props">
				<b-button type="is-info" icon-left="pen" @click="editar(props.row.id)">Editar</b-button>
			</b-table-column>
		</b-table>
		<b-loading :is-full-page="true" v-model="cargando" :can-cancel="false"></b-loading>
	</section>
</template>
<script>
	import NavComponent from '../Extras/NavComponent'
	import HttpService from '../../Servicios/HttpService'

	export default{
		name: "ClientesComponent",
		components: { NavComponent },

		data:()=>({
			cargando: false,
			clientes: []
		}),

		mounted(){
			this.obtenerClientes()
		},

		methods:{
			async eliminar(idCliente){
                this.$buefy.dialog.confirm({
                    title: 'Eliminar cliente',
                    message: 'Seguro que quieres <b>eliminar</b> este cliente? Esta acción no se puede revertir.',
                    confirmText: 'Sí, eliminar',
                    cancelText: 'Cancelar',
                    type: 'is-danger',
                    hasIcon: true,
                    onConfirm: () => {
                        this.cargando = true
                        HttpService.eliminar('clientes.php',{
                            accion: 'eliminar',
                            id: idCliente
                        })
                        .then(resultado => {
                            if(!resultado) {
                                this.$buefy.toast.open('Error al eliminar')
                                this.cargando = false
                                return
                            }

                            if(resultado){
                                this.cargando = false
                                this.$buefy.toast.open({
                                    type: 'is-info',
                                    message: 'Cliente eliminado.'
                                })
                                this.obtenerClientes()
                            }
                        })
                    }
                })
            },

			editar(idCliente){
				this.$router.push({
					name: "EditarCliente",
					params: { id: idCliente}
				})
			},

			obtenerClientes(){
				this.cargando = true
				let payload = {
					accion: "obtener",
				}

				HttpService.obtenerConConsultas("clientes.php", payload)
				.then(clientes =>{
					this.clientes = clientes
					this.cargando = false
				})
			}
		}
	}
</script>