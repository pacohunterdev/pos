<template>
	<form action="">
		<div class="modal-card" style="width: 600px">
			<header class="modal-card-head">
				<p class="modal-card-title">{{ titulo }} categoría</p>
				<button
					type="button"
					class="delete"
					@click="$emit('close')"/>
			</header>
			<section class="modal-card-body">
				<b-field label="Nombre de la categoría" >
					<b-input  type="text" placeholder="Ej. Libretas" v-model="nombreCategoria"></b-input>
				</b-field>
			</section>
			<footer class="modal-card-foot">
				<b-button
					label="Cancelar"
					icon-left="cancel"
					size="is-medium"
					@click="$emit('close')" />
				<b-button
					label="Registrar"
					type="is-primary"
					icon-left="check"
					@click="registrar" />
			</footer>
		</div>
	</form>
</template>
<script>
	export default{
		name: "DialogoCategorias",
		props: ['titulo', 'nombre'],

		data:()=>({
			nombreCategoria: "",
		}),

		mounted(){
			this.nombreCategoria = this.nombre
		},

		methods:{

			registrar(){
				if(!this.nombreCategoria){
					this.$buefy.toast.open({
                        type: 'is-danger',
                        message: 'Debes colocar el nombre de la categoría.'
                    })
					return
				}

				this.$emit("registrar", this.nombreCategoria)
			}	
		}
	}
</script>