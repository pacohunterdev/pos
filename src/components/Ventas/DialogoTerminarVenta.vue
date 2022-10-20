<template>
	<form action="">
		<div class="modal-card" style="width: 600px">
			<header class="modal-card-head has-background-success">
				<p class="modal-card-title has-text-white">Terminar venta</p>
				<button
					type="button"
					class="delete"
					@click="$emit('close', 'venta')"/>
			</header>
			<section class="modal-card-body">
				<p class="is-size-1 has-text-weight-bold">Total ${{ totalVenta }}</p>
				<busqueda-cliente @seleccionado="onSeleccionado" />
				<b-field label="El cliente paga con" >
					<b-input step="any" ref="pagado" icon="currency-usd" type="number" placeholder="Monto pagado" v-model="pagado" @input="calcularCambio" @keyup.enter.native="terminarVenta" size="is-medium"></b-input>
				</b-field>
				<p class="is-size-1 has-text-weight-bold">Cambio ${{ cambio }}</p>
			</section>
			<footer class="modal-card-foot">
				<b-button
					label="Cancelar"
					icon-left="cancel"
					size="is-medium"
					@click="$emit('close', 'venta')" />
				<b-button
					label="Terminar venta"
					type="is-success"
					icon-left="check"
					size="is-medium"
					@click="terminarVenta" />
			</footer>
		</div>
	</form>
</template>
<script>
	import BusquedaCliente from '../Clientes/BusquedaCliente'

	export default{
		name:"DialogoTerminarVenta",
		props: ['totalVenta'],
		components: { BusquedaCliente },

		data:()=>({
			pagado: "",
			cambio: 0,
			cliente: {}
		}),

		mounted(){
			this.$refs.pagado.focus()
		},

		methods:{
			onSeleccionado(cliente){
				this.cliente = cliente
			},

			calcularCambio(){
				this.cambio = parseFloat(this.pagado-this.totalVenta)
			},

			terminarVenta(){
				if(this.pagado === "" || this.pagado < this.totalVenta) {
					this.$buefy.toast.open({
                         type: 'is-danger',
                         message: 'Debes colocar el total pagado.'
                    })
                    return
				}

				let payload = {
					tipo: 'venta',
					pagado: this.pagado,
					cambio: this.cambio,
					cliente: this.cliente
				}

				this.$emit("terminar", payload)
			}	
		}
	}
</script>