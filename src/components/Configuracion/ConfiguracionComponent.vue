<template>
	<section>
		<h1 class="title is-1">Configuración general</h1>
		<b-breadcrumb
            align="is-left"
        >
            <b-breadcrumb-item tag='router-link' to="/">Inicio</b-breadcrumb-item>
            <b-breadcrumb-item acive>Configurar</b-breadcrumb-item>
        </b-breadcrumb>
		<form-configuracion :datos="datosNegocio" @registrar="onRegistrar" v-if="datosNegocio"/>
		<b-loading :is-full-page="true" v-model="cargando" :can-cancel="false"></b-loading>
	</section>
</template>
<script>
	import FormConfiguracion from './FormConfiguracion'
	import HttpService from '../../Servicios/HttpService'

	export default{
		name: "ConfiguracionComponent",
		components: { FormConfiguracion },

		data:()=>({
			cargando: false,
			datosNegocio: null
		}),

		mounted(){
			this.obtenerDatos()
		},

		methods: {
			onRegistrar(datos){
				console.log(datos)
				this.cargando = true
				HttpService.registrar('ajustes.php', {
					accion: 'registrar', 
					ajustes: datos
				})
				.then(resultado =>{
					if(resultado){
						this.cargando = false
						this.$buefy.toast.open({
                          type: 'is-info',
                          message: 'Información actualizada con éxito.'
                        })
                        this.obtenerDatos()
					}
				})
			},

			obtenerDatos(){
				this.cargando = true
				HttpService.obtenerConConsultas('ajustes.php', {
					accion: 'obtener'
				})
				.then(resultado => {
					this.datosNegocio = resultado
					this.cargando = false
				})
			}
		}
	}
</script>