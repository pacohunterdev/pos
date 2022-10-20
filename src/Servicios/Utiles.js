   import Chart from 'chart.js'
   const RUTA = 'http://localhost/pos/api' 
   const MESES = ["Enero" ,"Febrero" ,"Marzo" ,"Abril" ,"Mayo" ,"Junio" ,"Julio" ,"Agosto" ,"Septiembre" ,"Octubre" ,"Noviembre" ,"Diciembre"]

   const Utiles = {

   resetearGrafica(contenedor, grafica, id){
      const $contenedorGrafica = document.querySelector(contenedor)
      let $grafica = document.querySelector(grafica)
      $grafica.remove()
      let $nuevaGrafica = document.createElement("canvas")
      $nuevaGrafica.setAttribute("id",id)
      $contenedorGrafica.appendChild($nuevaGrafica)
   },

   generarGrafica(tipo, array, contenedor, grafica, id){
      this.resetearGrafica(contenedor, grafica, id)

      const labels = this.generarEtiquetas(array)
      const totales = this.generarValores(array)

               
      const data = {
         labels: labels,
         datasets: [{
            label: "Total ",
            data: totales,
            backgroundColor: this.generarColores(labels.length),
            fill: false,
            tension: 0.1,
            borderWidth: 3
         }]
      }

      var ctx = document.getElementById(id).getContext('2d');

      var options = {
         responsive: true,
         maintainAspectRatio: false,
         scales: {
            y: {
               beginAtZero: true
            }
         }
      };
               
      new Chart(ctx, {
         responsive: true,
         type: tipo,
         data: data,
         options: options
      });
   },

   generarColores(tamanio){
      const colores = []
      for(let i = 0; i<tamanio; i++){
         colores.push("#" + Math.floor(Math.random()*16777215).toString(16))
      }

      return colores
   },
      
   cambiarNumeroANombreMes(array){
      for(let i = 0; i < array.length; i++){
          let pos = array[i].mes 
          array[i].mes = MESES[pos-1]
       }
       return array
   },

    generarEtiquetas(array){
      const labels = array.map(elemento => {
       return elemento[Object.keys(elemento)[0]]
    })
      return labels
   },

   generarValores(array){
      const totales = array.map(elemento => {
       return elemento.totalVentas
    })
      return totales
   },

   validarDatos(datos){
      let errores = []
      for (let [clave, valor] of Object.entries(datos)) {
       if(!valor) errores.push("Debes colocar el valor de " + clave)
    }
   return errores
   },

   calcularTotalGanancia(ventas) {
     let total = 0
     ventas.forEach(venta =>{
      venta.productos.forEach(producto => {
       total += parseFloat(producto.cantidad * producto.precio) - parseFloat(producto.cantidad * producto.precioCompra)
    })
   })
     return total
   },

   calcularProductosVendidos(ventas){
     let total = 0
     ventas.forEach(venta =>{
      venta.productos.forEach(producto => {
       total+= parseFloat(producto.cantidad)
    })
   })
     return total
   },

   regresarRuta(){
     return RUTA
   }
   }

   export default Utiles;