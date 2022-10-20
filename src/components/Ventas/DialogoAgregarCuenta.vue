<template>
	<form action="">
		<div class="modal-card" style="width: 600px">
			<header class="modal-card-head has-background-info">
				<p class="modal-card-title has-text-white">Agregar a cuenta</p>
				<button
					type="button"
					class="delete"
					@click="$emit('close', 'cuenta')"/>
			</header>
			<section class="modal-card-body">
				<p class="is-size-1 has-text-weight-bold">Total ${{ totalVenta }}</p>
				<busqueda-cliente @seleccionado="onSeleccionado"/>
				<b-field label="Pago inicial" >
					<b-input step="any" icon="currency-usd" type="number" placeholder="Cuánto deja el cliente" v-model="pagado" @input="calcularRestante" size="is-medium"></b-input>
				</b-field>
				<p class="is-size-1 has-text-weight-bold">Por Pagar ${{ porPagar }}</p>
			</section>
			<footer class="modal-card-foot">
				<b-button
					label="Cancelar"
					icon-left="cancel"
					size="is-medium"
					@click="$emit('close', 'cuenta')" />
				<b-button
					label="Agregar a cuenta"
					type="is-info"
					icon-left="wallet-plus"
					size="is-medium"
					@click="agregarCuenta" />
			</footer>
		</div>
	</form>
</template>
<script>
	import BusquedaCliente from '../Clientes/BusquedaCliente'

	export default{
		name:"DialogoAgregarCuenta",
		props: ['totalVenta'],
		components: { BusquedaCliente },

		data:()=>({
			pagado: "",
			porPagar: 0,
			cliente: {}
		}),


		mounted(){
				this.calcularRestante()
			},

		methods:{
			onSeleccionado(cliente){
				this.cliente = cliente
			},


			calcularRestante(){
				this.porPagar = parseFloat(this.totalVenta-this.pagado)
			},

			agregarCuenta(){
				if(Object.keys(this.cliente).length === 0) {
					this.$buefy.toast.open({
                         type: 'is-danger',
                         message: 'Debes seleccionar un cliente.'
                    })
                    return
				}

				let payload = {
					tipo: 'cuenta',
					pagado: this.pagado,
					porPagar: this.porPagar,
					cliente: this.cliente
				}

				this.$emit("terminar", payload)
			}	
		
		}
	}
</script>