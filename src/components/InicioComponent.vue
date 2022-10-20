<template>
    <section>
        <cartas-totales :totales="ingresos" />
        <div class="columns is-desktop">
            <div class="column">
                <div class="box">
                    <p class="title is-4">Ventas por meses</p>
                    <select-anio :grafica="'1'" @seleccionado="busquedaAnio"/>
                    <div id="contenedor-meses">
                        <canvas id="grafica-meses"></canvas>
                    </div>
                </div>
            </div>
            <div class="column">
                <div class="box">
                    <p class="title is-4">Ventas por día</p>
                        <b-field grouped group-multiline>
                            <b-field >
                                <select-mes @seleccionado="busquedaMes"/>
                            </b-field>
                            <b-field >
                                <select-anio :grafica="'2'" @seleccionado="busquedaAnio"/>
                            </b-field>
                        </b-field>
                    <div id="contenedor-dias">
                        <canvas id="grafica-dias"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <div class="columns is-desktop">
            <div class="column">
                <div class="box">
                    <p class="title is-4">Ventas por usuarios</p>
                    <div id="contenedor-usuarios">
                        <canvas id="grafica-usuarios"></canvas>
                    </div>
                </div>
            </div>
            <div class="column">
                <div class="box">
                    <p class="title is-4">Ventas por clientes</p>
                    <div id="contenedor-clientes">
                        <canvas id="grafica-clientes"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <div class="columns is-desktop">
            <div class="column">
                <div class="box">
                    <p class="title is-4">Ventas por categorías</p>
                    <div id="contenedor-categorias">
                        <canvas id="grafica-categorias"></canvas>
                    </div>
                </div>
            </div>
            <div class="column">
                <div class="box">
                    <p class="title is-4">Ventas por marcas</p>
                    <div id="contenedor-marcas">
                        <canvas id="grafica-marcas"></canvas>
                    </div>
                </div>
            </div>
        </div>


        <div class="columns is-desktop">
            <div class="column">
                <div class="box">
                    <b-field class="is-pulled-right" >
                        <b-select placeholder="Selecciona el limite" v-model="limite" @change.native="seleccionarLimite">
                            <option value="5">5</option>
                            <option value="10">10</option>
                            <option value="15">15</option>
                            <option value="20">20</option>
                         </b-select>
                    </b-field>
                    <p class="title is-4">Productos más vendidos</p>
                    
                    <b-table
                    :data="productosMayoresVentas">
                        <b-table-column field="nombre" label="Producto" v-slot="props">
                            {{ props.row.nombre }}
                        </b-table-column>

                        <b-table-column field="unidades" label="Unidades vendidas" v-slot="props">
                            {{ props.row.unidades }}
                        </b-table-column>

                        <b-table-column field="total" label="Total ventas" v-slot="props">
                            ${{ props.row.total }}
                        </b-table-column>

                        <b-table-column field="progreso" label="Progreso" v-slot="props">
                            <b-progress 
                                :type="generarColorPorcentaje(props.row.total)" 
                                :value="calcularPorcentajeProducto(props.row.total)" 
                                show-value
                            ></b-progress>
                        </b-table-column>
                    </b-table>
                </div>
            </div>
        </div>
        
    </section>
</template>
<script>
    import HttpService from '../Servicios/HttpService'
    import Utiles from '../Servicios/Utiles'
    import CartasTotales from './Extras/CartasTotales'
    import SelectAnio from './Extras/SelectAnio'
    import SelectMes from './Extras/SelectMes'

    export default{
        name: "InicioComponent",
        components: { CartasTotales, SelectAnio, SelectMes },

        data:()=>({
            ingresos: [],
            totalesMeses: [],
            totalesUsuarios: [],
            totalesClientes: [],
            totalesDia: [],
            productosMayoresVentas: [],
            mesSeleccionado: new Date().getMonth()+1,
            anioSeleccionado: new Date().getFullYear(),
            limite: 5
        }),

        mounted(){
            this.obtenerIngresos()
            this.obtenerTotalesMeses(this.anioSeleccionado)
            this.obtenerTotalesUsuarios()
            this.obtenerTotalesClientes()
            this.obtenerTotalesDiaMes(this.mesSeleccionado, this.anioSeleccionado)
            this.obtenerProductosMayoresVentas(this.limite)
            this.obtenerMarcasCategorias()
        },

        methods: {
            seleccionarLimite(){
                this.obtenerProductosMayoresVentas(this.limite)
            },

            busquedaMes(mes){
                this.mesSeleccionado = mes
                this.obtenerTotalesDiaMes(this.mesSeleccionado, this.anioSeleccionado)
            },

            busquedaAnio(datos){
                switch(datos.noGrafica){
                    case "1":
                        this.obtenerTotalesMeses(datos.anio)
                        break

                    case "2":
                        this.anioSeleccionado = datos.anio
                        this.obtenerTotalesDiaMes(this.mesSeleccionado, this.anioSeleccionado)
                        break

                    default:
                        console.log("No reconocido")
                }
            },

            generarColorPorcentaje(total){
                let porcentaje = this.calcularPorcentajeProducto(total)
                return (porcentaje >= 90) ? 'is-success' :
                (porcentaje < 90 && porcentaje >= 80) ? 'is-info' :
                (porcentaje < 80 && porcentaje >= 60) ? 'is-warning' :
                'is-danger'
            },

            calcularPorcentajeProducto(valor){
                if(this.productosMayoresVentas.length > 0){
                    let totalMayor = this.productosMayoresVentas[0].total
                    return parseInt(valor * 100 / totalMayor)
                }
            },

            obtenerIngresos(){
                HttpService.obtenerConConsultas('inicio.php',{
                    accion: 'obtener_ingresos'
                })
                .then(resultado => {
                    this.crearCartas(resultado)
                })
            },

            obtenerMarcasCategorias(){
                HttpService.obtenerConConsultas('inicio.php',{
                    accion: 'obtener_marcas_categorias'
                })
                .then(resultado => {
                    this.crearGraficaVentasCategorias(resultado.categorias)
                    this.crearGraficaVentasMarcas(resultado.marcas)
                })
            },

            obtenerTotalesMeses(anio){
                HttpService.obtenerConConsultas('inicio.php',{
                    accion: 'obtener_totales_meses',
                    anioSeleccionado: anio
                })
                .then(resultado => {
                    this.totalesMeses = Utiles.cambiarNumeroANombreMes(resultado)
                    this.crearGraficaVentasMeses(this.totalesMeses)
                }) 
            },

            obtenerTotalesDiaMes(mes, anio){
                HttpService.obtenerConConsultas('inicio.php',{
                    accion: 'obtener_totales_dia',
                    mesSeleccionado: mes,
                    anioSeleccionado: anio
                })
                .then(resultado => {
                    this.totalesDia = resultado
                    this.crearGraficaVentasDiasMes(this.totalesDia)
                }) 
            },

            obtenerTotalesUsuarios(){
                HttpService.obtenerConConsultas('inicio.php',{
                    accion: 'obtener_totales_usuarios'
                })
                .then(resultado => {
                    this.totalesUsuarios = resultado
                    this.crearGraficaVentasUsuarios(this.totalesUsuarios)
                }) 
            },

            obtenerTotalesClientes(){
                HttpService.obtenerConConsultas('inicio.php',{
                    accion: 'obtener_totales_clientes'
                })
                .then(resultado => {
                    this.totalesClientes = resultado
                    this.crearGraficaVentasClientes(this.totalesClientes)
                }) 
            },

            obtenerProductosMayoresVentas(limiteSeleccionado){
                HttpService.obtenerConConsultas('inicio.php',{
                    accion: 'obtener_productos_mayores', 
                    limite: limiteSeleccionado
                })
                .then(resultado => {
                    this.productosMayoresVentas = resultado
                }) 
            },

            crearCartas(ingresos){
                this.ingresos = [
                        {nombre: "Total ingresos", total: '$' + ingresos.totalIngresos, icono: "currency-usd", clase: "has-text-success"},
                        {nombre: "Ingresos hoy", total: '$' + ingresos.ingresosHoy, icono: "calendar", clase: "has-text-primary"},
                        {nombre: "Ingresos semana", total: '$' + ingresos.ingresosSemana, icono: "calendar-range", clase: "has-text-info"},
                        {nombre: "Ingresos mes", total: '$' + ingresos.ingresosMes, icono: "calendar-month", clase: "has-text-dark"},
                        {nombre: "Ingresos pendientes", total: '$' + ingresos.ingresosPendientes, icono: "alert", clase: "has-text-danger"},
                    ]
            },

            crearGraficaVentasMeses(array){
                Utiles.generarGrafica('bar', array, "#contenedor-meses", "#grafica-meses", "grafica-meses")
            },

            crearGraficaVentasUsuarios(array){
                Utiles.generarGrafica('pie', array, "#contenedor-usuarios", "#grafica-usuarios", "grafica-usuarios")
            },

            crearGraficaVentasClientes(array){
                Utiles.generarGrafica('pie', array, "#contenedor-clientes", "#grafica-clientes", "grafica-clientes")
            },

            crearGraficaVentasDiasMes(array){
                Utiles.generarGrafica('bar', array, "#contenedor-dias", "#grafica-dias", "grafica-dias")
            },

            crearGraficaVentasCategorias(array){
                Utiles.generarGrafica('line', array, "#contenedor-categorias", "#grafica-categorias", "grafica-categorias")
            },

            crearGraficaVentasMarcas(array){
                Utiles.generarGrafica('line', array, "#contenedor-marcas", "#grafica-marcas", "grafica-marcas")
            }
        }
    }
</script>