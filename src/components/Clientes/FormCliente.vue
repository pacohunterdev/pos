<template>
	<form>
		<b-field label="Nombre del cliente" >
            <b-input step="any" icon="account" type="text" placeholder="Ej. Don Paco" v-model="datosCliente.nombre"></b-input>
        </b-field>
        <b-field label="Teléfono del cliente" >
            <b-input step="any" icon="phone" type="number" placeholder="Ej. 2311459874" v-model="datosCliente.telefono"></b-input>
        </b-field>
         <div class="buttons has-text-centered">
            <b-button type="is-primary" size="is-large" icon-left="check" @click="registrar">Registrar</b-button>
            <b-button type="is-dark" size="is-large" icon-left="cancel" tag="router-link" to="/clientes">Cancelar</b-button>
        </div>
        <errores-component :errores="mensajesError" v-if="mensajesError.length > 0" />
	</form>
</template>
<script>
	import Utiles from '../../Servicios/Utiles'
	import ErroresComponent from '../Extras/ErroresComponent'
	export default {
		name: "FormCliente",
		props: ["cliente"],
		components: { ErroresComponent },

		data:()=>({
			datosCliente: {
				nombre: "",
				telefono: ""
			},
			mensajesError: []
		}),

		mounted(){
			this.datosCliente = this.cliente
		},

		methods: {
			registrar(){
				this.mensajesError = Utiles.validarDatos(this.datosCliente)
				if(this.mensajesError.length > 0) return
				this.$emit("registrar", this.datosCliente)
				this.datosCliente  = {
					nombre: "",
					telefono: ""
				}
			}
		}
	}
</script>