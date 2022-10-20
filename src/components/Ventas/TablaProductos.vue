<template>
	<b-table
		:data="listaProductos">
			<b-table-column field="codigo" label="Código" v-slot="props">
				{{ props.row.codigo }}
			</b-table-column>

			<b-table-column field="nombre" label="Nombre" v-slot="props">
				{{ props.row.nombre }}
			</b-table-column>

			<b-table-column field="precio" label="Precio" v-slot="props">
				${{ props.row.precio }}
			</b-table-column>

			<b-table-column field="cantidad" label="Cantidad" v-slot="props">
				<b-field>
					<b-numberinput @input="aumentar(props.row)" min="1" :max="props.row.existencia" v-model="props.row.cantidad" style="width: 13em">
					</b-numberinput>
				</b-field>
			</b-table-column>

			<b-table-column field="subtotal" label="Subtotal" v-slot="props">
				<b>${{ props.row.precio * props.row.cantidad }}</b>
			</b-table-column>

			<b-table-column field="quitar" label="Quitar" v-slot="props">
				<b-button icon-left="delete" type="is-danger" @click="quitar(props.row.id)">
					Quitar
				</b-button>
			</b-table-column>


		</b-table>
</template>
<script>
	export default {
		name: "TablaProductos",
		props: ["listaProductos"],

		data:()=>({

		}),

		methods: {
			quitar(id){
				this.$emit("quitar", id)
			},

			aumentar(producto){
				this.$emit("aumentar", producto)
			}
		}
	}
</script>