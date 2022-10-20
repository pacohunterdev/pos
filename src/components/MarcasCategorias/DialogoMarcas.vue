<template>
	<form action="">
		<div class="modal-card" style="width: 600px">
			<header class="modal-card-head">
				<p class="modal-card-title">{{ titulo }} marca</p>
				<button
					type="button"
					class="delete"
					@click="$emit('close')"/>
			</header>
			<section class="modal-card-body">
				<b-field label="Nombre de la marca" >
					<b-input  type="text" placeholder="Ej. Pelikan" v-model="nombreMarca"></b-input>
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
		name: "DialogoMarcas",
		props: ['titulo', 'nombre'],

		data:()=>({
			nombreMarca: "",
		}),

		mounted(){
			this.nombreMarca = this.nombre
		},

		methods:{

			registrar(){
				if(!this.nombreMarca){
					this.$buefy.toast.open({
                        type: 'is-danger',
                        message: 'Debes colocar el nombre de la marca.'
                    })
					return
				}

				this.$emit("registrar", this.nombreMarca)
			}	
		}
	}
</script>