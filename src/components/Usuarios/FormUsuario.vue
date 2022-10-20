<template>
	<form>
		<b-field label="Nombre de usuario" >
            <b-input  icon="shield-account" type="text" placeholder="Ej. paco" v-model="datosUsuario.usuario"></b-input>
        </b-field>
        <b-field label="Nombre completo " >
            <b-input  icon="account" type="text" placeholder="Ej. Francisco Perez Tezcatlipoca" v-model="datosUsuario.nombre"></b-input>
        </b-field>
        <b-field label="Teléfono del usuario" >
            <b-input step="any" icon="phone" type="number" placeholder="Ej. 2311459874" v-model="datosUsuario.telefono"></b-input>
        </b-field>

         <div class="buttons has-text-centered">
            <b-button type="is-primary" size="is-large" icon-left="check" @click="registrar">Registrar</b-button>
            <b-button type="is-dark" size="is-large" icon-left="cancel" tag="router-link" to="/usuarios">Cancelar</b-button>
        </div>
        <errores-component :errores="mensajesError" v-if="mensajesError.length > 0" />
	</form>
</template>
<script>
	import Utiles from '../../Servicios/Utiles'
	import ErroresComponent from '../Extras/ErroresComponent'

	export default {
		name: "FormUsuario",
		props: ["usuario"],
		components: { ErroresComponent },

		data:()=>({
			datosUsuario: {
				usuario: "",
				nombre: "",
				telefono: ""
			},
			mensajesError: [] 
		}),

		mounted(){
			this.datosUsuario = this.usuario
		},

		methods: {
			registrar(){
				this.mensajesError = Utiles.validarDatos(this.datosUsuario)
				if(this.mensajesError.length > 0) return
				this.$emit("registrar", this.datosUsuario)
				this.datosUsuario  = {
					usuario: "",
					nombre: "",
					telefono: ""
				}
			}
		}
	}
</script>