<template>
	<b-table
		:data="productos"
		class="is-size-7">
			<b-table-column field="nombre" label="Nombre" v-slot="props">
				{{ props.row.nombre }}
			</b-table-column>

			<b-table-column field="precio" label="Precio" v-slot="props">
				${{ props.row.precio }}
			</b-table-column>

			<b-table-column field="cantidad" label="Cantidad" v-slot="props">
				{{ props.row.cantidad}}
			</b-table-column>

			<b-table-column field="subtotal" label="Subtotal" v-slot="props">
				<b>${{ props.row.precio * props.row.cantidad }}</b>
			</b-table-column>
		</b-table>
</template>
<script>
	export default {
		name: "TablaProductosVendidos",
		props: ["productos"]
	}
</script>