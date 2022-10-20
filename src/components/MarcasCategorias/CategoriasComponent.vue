<template>
	<section>
		<b-button type="is-primary" size="is-medium" class="is-rounded" icon-left="plus" @click="agregarCategoria">
			Agregar categoría
		</b-button>
		<b-table
		:data="categorias">
		<b-table-column field="nombreCategoria" label="Categoria" sortable searchable v-slot="props">
			{{ props.row.nombreCategoria }}
		</b-table-column>

		<b-table-column field="eliminar" label="Eliminar" v-slot="props">
			<b-button type="is-danger" icon-left="delete" @click="eliminar(props.row)">Eliminar</b-button>
		</b-table-column>

		<b-table-column field="editar" label="Editar" v-slot="props">
			<b-button type="is-info" icon-left="pen" @click="editar(props.row)">Editar</b-button>
		</b-table-column>
	</b-table>
	<b-modal
	v-model="mostrarDialogoCategorias"
	has-modal-card
	trap-focus
	:destroy-on-hide="false"
	aria-role="dialog"
	aria-label="Modal"
	close-button-aria-label="Close"
	aria-modal>
	<dialogo-categorias :titulo="tituloModal" :nombre="nombreCategoria" @close="onCerrarDialogo" @registrar="onRegistrar" v-if="mostrarDialogoCategorias"></dialogo-categorias>
</b-modal>

<b-loading :is-full-page="true" v-model="cargando" :can-cancel="false"></b-loading>
</section>
</template>
<script>
	import HttpService from '../../Servicios/HttpService'
	import DialogoCategorias from './DialogoCategorias'

	export default{
		name: "CategoriasComponent",
		components: { DialogoCategorias },
		data:()=>({     
			categorias: [],
			cargando: false,
			mostrarDialogoCategorias: false,
			tituloModal: "",
			nombreCategoria: "",
			idCategoria: "",
		}),

		mounted(){
			this.obtenerCategorias()
		},

		methods: {
			eliminar(categoria){
				this.$buefy.dialog.confirm({
					title: 'Eliminar categoría',
					message: 'Seguro que quieres <b>eliminar</b> la categoría ' + categoria.nombreCategoria +'? Esta acción no se puede revertir.',
					confirmText: 'Sí, eliminar',
					cancelText: 'Cancelar',
					type: 'is-danger',
					hasIcon: true,
					onConfirm: () => {
						this.cargando = true
						HttpService.eliminar('categorias.php',{
							accion: 'eliminar',
							id: categoria.id
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
									message: 'Categoría eliminada.'
								})
								this.obtenerCategorias()
							}
						})
					}
				})
			},

			editar(categoria){
				this.tituloModal = "Editar"
				this.mostrarDialogoCategorias = true
				this.idCategoria = categoria.id
				this.nombreCategoria = categoria.nombreCategoria
			}, 

			onCerrarDialogo(){
				this.mostrarDialogoCategorias = false
				this.nombreCategoria = "" 
			},

			onRegistrar(nombre) {
				this.cargando = true

				let accionARealizar = (this.tituloModal === 'Agregar') ? 'registrar' : (this.tituloModal === 'Editar') ? 'editar' : false

				HttpService.registrar('categorias.php', {
					accion: accionARealizar,
					categoria: {nombreCategoria:nombre, id: this.idCategoria }
				})
				.then(registrado => {
					if(registrado === 'existe'){
						this.$buefy.toast.open({
							type: 'is-primary',
							message: 'La categoría' + nombre +' ya existe, selecciona otra.'
						})
						this.cargando = false
						return 
					}

					if(registrado) {
						this.cargando = false
						this.$buefy.toast.open({
							type: 'is-info',
							message: 'Información de categoría registrada con éxito.'
						})
						this.obtenerCategorias()
						this.nombreCategoria = ""
						this.mostrarDialogoCategorias = false
					}
				})
			},

			agregarCategoria(){
				this.tituloModal = "Agregar"
				this.mostrarDialogoCategorias = true
			},

			obtenerCategorias(){
				this.cargando = true
				let payload = {
					accion: 'obtener'
				}
				HttpService.obtenerConConsultas('categorias.php', payload)
				.then(categorias => {
					this.categorias = categorias
					this.cargando = false
				})
			}
		}
	}
</script>