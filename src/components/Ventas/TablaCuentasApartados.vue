<template>
	<section>
		<b-select v-model="perPage">
            <option value="5">5 por página</option>
            <option value="10">10 por página</option>
            <option value="15">15 por página</option>
            <option value="20">20 por página</option>
            </b-select>

        <b-table
            class="box"
            :data="datos"
            :paginated="isPaginated"
            :per-page="perPage"
            :current-page.sync="currentPage"
            :pagination-simple="isPaginationSimple"
            :pagination-position="paginationPosition"
            :default-sort-direction="defaultSortDirection"
            :pagination-rounded="isPaginationRounded"
            :sort-icon="sortIcon"
            :sort-icon-size="sortIconSize"
            default-sort="user.first_name"
            aria-next-label="Next page"
            aria-previous-label="Previous page"
            aria-page-label="Page"
            aria-current-label="Current page"
            >
            <b-table-column field="fecha" label="Fecha" sortable searchable v-slot="props">
                {{ props.row.fecha }}
            </b-table-column>

            <b-table-column field="nombreCliente" label="Cliente" sortable searchable v-slot="props">
                {{ props.row.nombreCliente }}
            </b-table-column>

            <b-table-column field="nombreUsuario" label="Usuario" sortable searchable v-slot="props">
                {{ props.row.nombreUsuario }}
            </b-table-column>

            <b-table-column field="pagado" label="Pago" sortable v-slot="props" >
                <span class="has-text-info has-text-weight-bold">${{ props.row.pagado }}</span>
            </b-table-column>

            <b-table-column field="porPagar" label="Por pagar" sortable v-slot="props" >
                <span class="has-text-danger has-text-weight-bold"> ${{ props.row.porPagar }}</span>
            </b-table-column>

            <b-table-column field="total" label="Total" sortable  v-slot="props">
                <b>${{ props.row.total }}</b>
            </b-table-column>

            <b-table-column field="productos" label="Productos" sortable  v-slot="props">
                <tabla-productos-vendidos :productos="props.row.productos" />
            </b-table-column>

            <b-table-column field="estado" label="Estado" sortable searchable v-slot="props">
                <span class="tag is-success is-large" v-if="props.row.porPagar < 1">LIQUIDADO</span>
                <span class="tag is-danger is-large" v-if="props.row.porPagar > 0">PENDIENTE</span>
            </b-table-column>

            <b-table-column field="ticket" label="Comprobante" v-slot="props">
                <b-button type="is-info" @click="generarComprobante(props.row)">
                    <b-icon
                    icon="ticket-outline">
                    </b-icon>   
                </b-button>
            </b-table-column> 

            <b-table-column field="abonar" label="Abonar" v-slot="props">
                <b-button type="is-primary" @click="abonar(props.row)" v-if="props.row.porPagar > 0">
                    <b-icon
                    icon="wallet-plus">
                    </b-icon>   
                </b-button>
            </b-table-column>

            <b-table-column field="liquidar" label="Liquidar" v-slot="props">
                <b-button type="is-success" @click="liquidar(props.row)" v-if="props.row.porPagar > 0">
                    <b-icon
                    icon="check-underline-circle">
                    </b-icon>   
                </b-button>
            </b-table-column>
        </b-table>
	</section>	
</template>
<script>
	import TablaProductosVendidos from './TablaProductosVendidos'
	export default{
		name: "TablaProductosApartados",
		props: ["datos"],
		components: { TablaProductosVendidos },

		data:()=>({
			isPaginated: true,
            isPaginationSimple: false,
            isPaginationRounded: true,
            paginationPosition: 'bottom',
            defaultSortDirection: 'asc',
            sortIcon: 'arrow-up',
            sortIconSize: 'is-medium',
            currentPage: 1,
            perPage: 5,
		}),

        methods: {
            generarComprobante(item){
                this.$emit("imprimir", item)
            },

            abonar(item){
                this.$emit("abonar", item)
            },

            liquidar(item){
                this.$emit("liquidar", item)
            }
        }
	}
</script>