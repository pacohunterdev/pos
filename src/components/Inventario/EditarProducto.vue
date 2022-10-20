<template>
	<section>
		<h1 class="title is-1">Editar producto</h1>
		<b-breadcrumb
            align="is-left"
        >
            <b-breadcrumb-item tag='router-link' to="/">Inicio</b-breadcrumb-item>
            <b-breadcrumb-item tag='router-link' to="/inventario">Inventario</b-breadcrumb-item>
            <b-breadcrumb-item  active>Editar producto</b-breadcrumb-item>
        </b-breadcrumb>     
		<form-producto :productoProp="datosProducto" @registrado="onEditar" v-if="datosProducto" />
	</section>
</template>
<script>
	import HttpService from '../../Servicios/HttpService'
	import FormProducto from './FormProducto'
	export default{
		name: "EditarProducto",
		components: { FormProducto },

		data:()=>({
			cargando: false,
			datosProducto: null
		}),

		async mounted(){
			this.cargando = true
			const producto = await HttpService.obtenerConConsultas('productos.php', {
				accion: 'obtener_por_id',
				id: this.$route.params.id
			})
			this.datosProducto = producto
			this.cargando = false
		},

		methods: {
			async onEditar(datosProducto) {
				this.cargando = true
				const resultado = await HttpService.editar('productos.php',{
					accion: 'editar',
					producto: datosProducto
				})

				if(resultado) {
					this.cargando = false
					this.$buefy.toast.open({
                         type: 'is-info',
                         message: 'Información de producto actualizada con éxito.'
                    })
                    this.$router.push({ name: 'ProductosComponent'})
				}
			}
		}
	}
</script>