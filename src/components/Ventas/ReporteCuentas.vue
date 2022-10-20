<template>
    <section>
        <p class="title is-1">Reporte de cuentas</p> 
         <b-breadcrumb
            align="is-left"
        >
            <b-breadcrumb-item tag='router-link' to="/">Inicio</b-breadcrumb-item>
            <b-breadcrumb-item active>Cuentas</b-breadcrumb-item>
        </b-breadcrumb>
        <busqueda-en-fecha @seleccionada="onBusquedaEnFecha"/>
        <mensaje-inicial class="mt-2" :titulo="'No se han encontrado cuentas :('" :subtitulo="'Aquí aparecerán las cuentas registradas'" v-if="cuentas.length<1"/>
        <div class="mt-2" v-if="cuentas.length>0">
            <cartas-totales :totales="totalesGenerales" />
            <tabla-cuentas-apartados :datos="cuentas" @abonar="onAbonar" @liquidar="onLiquidar" @imprimir="onGenerarComprobante"/>
        </div>
        <comprobante-compra :venta="this.cuentaSeleccionada" :tipo="'cuenta'" @impreso="onImpreso" v-if="mostrarComprobante" />
        <b-loading :is-full-page="true" v-model="cargando" :can-cancel="false"></b-loading>
    </section>
</template>
<script>
    import BusquedaEnFecha from '../Extras/BusquedaEnFecha'
    import MensajeInicial from '../Extras/MensajeInicial'
    import CartasTotales from '../Extras/CartasTotales'
    import HttpService from '../../Servicios/HttpService'
    import Utiles from '../../Servicios/Utiles'
    import TablaCuentasApartados from './TablaCuentasApartados'
    import ComprobanteCompra from './ComprobanteCompra'

    export default {
        name: "ReporteCuentas",
        components: { BusquedaEnFecha, TablaCuentasApartados, MensajeInicial, CartasTotales, ComprobanteCompra },

        data:()=>({
            filtros: {
                fechaInicio: "",
                fechaFin: ""
            },
            cargando: false,
            cuentas: [],
            totalesGenerales: [],
            cuentaSeleccionada: null,
            mostrarComprobante: false
        }),

        mounted(){
            this.obtenerCuentas()
        },

        methods: {
            onImpreso(resultado){
                this.mostrarComprobante = resultado
            },
            
            onGenerarComprobante(cuenta){
                this.cuentaSeleccionada = cuenta
                this.mostrarComprobante = true
            },

            onLiquidar(cuenta) {
                this.$buefy.dialog.confirm({
                    message: '¿Liquidar cuenta? El cliente debe pagar: $' + cuenta.porPagar,
                    cancelText: 'Cancelar',
                    confirmText: 'Liquidar',
                    onConfirm: () => {
                        this.cargando = true
                        HttpService.registrar('vender.php',{
                            accion: 'abonar',
                            total: cuenta.porPagar,
                            id: cuenta.id
                        })
                        .then(resultado =>{
                            if(resultado){
                                this.cargando = false
                                this.$buefy.toast.open(`Cuenta liquidada`)
                                this.obtenerCuentas()
                            }
                        })
                    }
                })
            },

            onAbonar(cuenta) {
                this.$buefy.dialog.prompt({
                    message: `Escribe el total del abono. Restan: $` + cuenta.porPagar,
                    cancelText: 'Cancelar',
                    confirmText: 'Abonar',
                    inputAttrs: {
                        type: 'number',
                        placeholder: 'Abono',
                        value: '',
                        min: 1,
                        max: cuenta.porPagar
                    },
                    trapFocus: true,
                    onConfirm: (value) => {
                        this.cargando = true
                        HttpService.registrar('vender.php',{
                            accion: 'abonar',
                            total: value,
                            id: cuenta.id
                        })
                        .then(resultado =>{
                            if(resultado){
                                this.cargando = false
                                this.$buefy.toast.open(`Abono registrado`)
                                this.obtenerCuentas()
                            }
                        })
                    }
                })
            },
            
            onBusquedaEnFecha(fechas){
                this.filtros.fechaInicio = fechas[0].toISOString().split('T')[0]
                this.filtros.fechaFin = fechas[1].toISOString().split('T')[0]
                this.obtenerCuentas()
            },

            obtenerCuentas(){
                this.cargando = true
                let payload = {
                    filtros: this.filtros,
                    accion: 'obtener_cuentas'
                }
                HttpService.obtenerConConsultas('vender.php', payload)
                .then(resultado => {
                    this.cuentas = resultado.cuentas

                    this.totalesGenerales = [
                        {nombre: "# Cuentas", total: this.cuentas.length, icono: "wallet", clase: "has-text-primary"},
                        {nombre: "Total ", total: '$' + resultado.totalCuentas, icono: "cash-fast", clase: "has-text-success"},
                        {nombre: "Por pagar", total: '$' + resultado.totalPorPagar, icono: "alert", clase: "has-text-danger"},
                        {nombre: "Pagos", total: '$' + resultado.totalPagos, icono: "account-cash", clase: "has-text-grey-light"},
                        {nombre: "# Productos", total: Utiles.calcularProductosVendidos(this.cuentas), icono: "package-variant", clase: "has-text-warning"},
                        {nombre: "Ganancia", total: '$' + Utiles.calcularTotalGanancia(this.cuentas), icono: "currency-usd", clase: "has-text-info"}
                    ]
                    this.cargando = false
                })
            }
        }
    }
</script>