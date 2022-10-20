<template>
    <section>
        <p class="title is-1">Reporte de cotizaciones</p>
         <b-breadcrumb
            align="is-left"
        >
            <b-breadcrumb-item tag='router-link' to="/">Inicio</b-breadcrumb-item>
            <b-breadcrumb-item active>Cotizaciones</b-breadcrumb-item> 
        </b-breadcrumb>
        <busqueda-en-fecha @seleccionada="onBusquedaEnFecha"/>
        <mensaje-inicial class="mt-2" :titulo="'No se han encontrado cotizaciones :('" :subtitulo="'Aquí aparecerán las cotizaciones registradas'" v-if="cotizaciones.length<1"/>
        <div class="mt-2" v-if="cotizaciones.length>0">
            <cartas-totales :totales="totalesGenerales" />
            <b-select v-model="perPage">
                <option value="5">5 por página</option>
                <option value="10">10 por página</option>
                <option value="15">15 por página</option>
                <option value="20">20 por página</option>
            </b-select>

            <b-table
                class="box"
                :data="cotizaciones"
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

                <b-table-column field="total" label="Total" sortable  v-slot="props">
                    <b>${{ props.row.total }}</b>
                </b-table-column>

                <b-table-column field="productos" label="Productos" sortable  v-slot="props">
                    <tabla-productos-vendidos :productos="props.row.productos" />
                </b-table-column>

                <b-table-column field="ticket" label="Comprobante" v-slot="props">
                    <b-button type="is-info" @click="generarComprobante(props.row)">
                        <b-icon
                        icon="ticket-outline">
                        </b-icon>   
                    </b-button>
                </b-table-column> 

                <b-table-column field="eliminar" label="Eliminar" v-slot="props">
                    <b-button type="is-danger" @click="eliminar(props.row.id)">
                        <b-icon
                        icon="delete">
                        </b-icon>   
                    </b-button>
                </b-table-column> 
            </b-table>
        </div>
        <comprobante-compra :venta="this.cotizacionSeleccionada" :tipo="'cotiza'" @impreso="onImpreso" v-if="mostrarComprobante" />
        <b-loading :is-full-page="true" v-model="cargando" :can-cancel="false"></b-loading>
    </section>
</template>
<script>
    import BusquedaEnFecha from '../Extras/BusquedaEnFecha'
    import MensajeInicial from '../Extras/MensajeInicial'
    import CartasTotales from '../Extras/CartasTotales'
    import TablaProductosVendidos from './TablaProductosVendidos'
    import ComprobanteCompra from './ComprobanteCompra'
    import HttpService from '../../Servicios/HttpService'

    export default {
        name: "ReporteCotizaciones",
        components: { BusquedaEnFecha, MensajeInicial, CartasTotales, TablaProductosVendidos, ComprobanteCompra },

        data:()=>({
            filtros: {
                fechaInicio: "",
                fechaFin: ""
            },
            cargando: false,
            cotizaciones: [],
            totalesGenerales: [],
            isPaginated: true,
            isPaginationSimple: false,
            isPaginationRounded: true,
            paginationPosition: 'bottom',
            defaultSortDirection: 'asc',
            sortIcon: 'arrow-up',
            sortIconSize: 'is-medium',
            currentPage: 1,
            perPage: 5,
            cotizacionSeleccionada: null,
            mostrarComprobante: false
        }),

        mounted(){
            this.obtenerCotizaciones()
        },

        methods: {
            onImpreso(resultado){
                this.mostrarComprobante = resultado
            }, 
            
            generarComprobante(cotizacion){
                this.cotizacionSeleccionada = cotizacion
                this.mostrarComprobante = true
            },

            eliminar(id){
                this.$buefy.dialog.confirm({
                    title: 'Eliminar cotización',
                    message: '¿Seguro que deseas eliminar esta cotizacion?',
                    confirmText: 'Sí, eliminar',
                    cancelText: 'Cancelar',
                    type: 'is-danger',
                    hasIcon: true,
                    onConfirm: () => {
                        this.cargando = true
                        HttpService.eliminar('vender.php',{
                            accion: 'eliminar_cotizacion',
                            id:id
                        })
                        .then(resultado =>{
                            if(resultado){
                                this.cargando = false
                                this.$buefy.toast.open('cotización eliminada')
                                this.obtenerCotizaciones()
                            }
                        })
                        
                    }
                })
            },

            onBusquedaEnFecha(fechas){
                this.filtros.fechaInicio = fechas[0].toISOString().split('T')[0]
                this.filtros.fechaFin = fechas[1].toISOString().split('T')[0]
                this.obtenerCotizaciones()
            },

            obtenerCotizaciones(){
                this.cargando = true
                let payload = {
                    filtros: this.filtros,
                    accion: 'obtener_cotizaciones'
                }
                HttpService.obtenerConConsultas('vender.php', payload)
                .then(resultado => {
                    this.cotizaciones = resultado.cotizaciones

                    this.totalesGenerales = [
                        {nombre: "Cotizaciones registradas", total: this.cotizaciones.length, icono: "ticket-outline", clase: "has-text-primary"},
                    ]
                    this.cargando = false
                })
            }
        }
    }
</script>