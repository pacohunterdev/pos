<template>
	<section>
		<nav-component :titulo="nombreUsuario" :link="{ path: '/cambiar-password' }" :texto="'Cambiar contraseña'" />
		<cartas-totales :totales="ingresos" />
		<div class="box">
            <p class="title is-4">Tus ventas por meses</p>
            <select-anio :grafica="'1'" @seleccionado="busquedaAnio"/>
            <div id="contenedor-meses">
                <canvas id="grafica-meses"></canvas>
            </div>
        </div>
	</section>
</template>
<script>
	import HttpService from '../../Servicios/HttpService'
	import Utiles from '../../Servicios/Utiles'
	import SelectAnio from '../Extras/SelectAnio'
	import NavComponent from '../Extras/NavComponent'
	import CartasTotales from '../Extras/CartasTotales'
	export default{
		name: "PerfilComponent",
		components: { NavComponent, CartasTotales, SelectAnio },

		data: ()=>({
			nombreUsuario: "",
			ingresos: [],
			anioSeleccionado: new Date().getFullYear(),
			totalesMeses: []
		}),

		mounted(){
			this.nombreUsuario = localStorage.getItem('nombre')
			this.obtenerIngresos()
			this.obtenerTotalesMeses(this.anioSeleccionado)
		},

		methods: {
			busquedaAnio(datos){
				this.obtenerTotalesMeses(datos.anio)
			},

			obtenerTotalesMeses(anio){
                HttpService.obtenerConConsultas('perfil.php',{
                    accion: 'obtener_ventas',
                    anioSeleccionado: anio,
                    idUsuario: localStorage.getItem('id')
                })
                .then(resultado => {
                    this.totalesMeses = Utiles.cambiarNumeroANombreMes(resultado)
                    this.crearGraficaVentasMeses(this.totalesMeses)
                }) 
            },

            crearGraficaVentasMeses(array){
                Utiles.generarGrafica('bar', array, "#contenedor-meses", "#grafica-meses", "grafica-meses")
            },

			obtenerIngresos(){
                HttpService.obtenerConConsultas('perfil.php',{
                    accion: 'obtener_ingresos',
                    idUsuario: localStorage.getItem('id')
                })
                .then(resultado => {
                    this.crearCartas(resultado)
                })
            },

            crearCartas(ingresos){
                this.ingresos = [
                    {nombre: "Total ingresos", total: '$' + ingresos.totalIngresos, icono: "currency-usd", clase: "has-text-success"},
                    {nombre: "Ingresos hoy", total: '$' + ingresos.ingresosHoy, icono: "calendar", clase: "has-text-primary"},
                    {nombre: "Ingresos semana", total: '$' + ingresos.ingresosSemana, icono: "calendar-range", clase: "has-text-info"},
                    {nombre: "Ingresos mes", total: '$' + ingresos.ingresosMes, icono: "calendar-month", clase: "has-text-dark"}
                    ]
            },
		}

		
	}
</script>