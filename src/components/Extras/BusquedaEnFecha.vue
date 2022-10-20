<template>
	<section>
		<b-field label="Selecciona un periodo">
        <b-datepicker
            placeholder="Click para seleccionar..."
            v-model="fechasSeleccionadas"
            range
            @input="onFechaSeleccionada">
        </b-datepicker>
    </b-field>
	</section>
</template>
<script>
	export default {
		name: "BusquedaEnFecha",

		data:() => ({
			fechasSeleccionadas: []
		}),

		methods: {
			onFechaSeleccionada(){
				this.$emit("seleccionada", this.fechasSeleccionadas)
			}
		}
	}
</script>