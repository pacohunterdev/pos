<template>
  <section>
    <buscar-producto @seleccionado="onSeleccionado" />
    <mensaje-inicial :titulo="'No has agregado productos'" :subtitulo="'Agrega algunos productos a la lista para venderlos :)'" v-if="productos.length<1"/>
    <div v-if="productos.length>0">
      <tabla-productos :listaProductos="productos" @quitar="onQuitar" @aumentar="onAumentar"  />
      <div class="notification is-primary mt-3">
        <p class=" has-text-weight-bold has-text-centered" style="font-size:5em">
          Total ${{ total }}
        </p>
        <nav class="level mt-2">
          <div class="level-item has-text-centered">
           <b-button class="button is-responsive" type="is-success" inverted  icon-left="check" size="is-large" @click=" abrirDialogo('venta') ">
            Terminar venta
          </b-button>
        </div>
        <div class="level-item has-text-centered">
         <b-button class="button is-responsive" type="is-info" inverted  icon-left="wallet-plus" size="is-large" @click=" abrirDialogo('cuenta') ">
          Agregar a cuenta
        </b-button>
      </div>
      <div class="level-item has-text-centered">
        <b-button class="button is-responsive" type="is-dark" inverted  icon-left="wallet-travel" size="is-large" @click=" abrirDialogo('apartado') ">
          Realizar apartado
        </b-button>
      </div>
      <div class="level-item has-text-centered">
        <b-button class="button is-responsive" type="is-danger" inverted  icon-left="cancel" size="is-large" @click="cancelarVenta">
          Cancelar
        </b-button>
      </div>
      <div class="level-item has-text-centered">
        <b-button class="button is-responsive" type="is-warning" inverted  icon-left="ticket-outline" size="is-large" @click="abrirDialogo('cotiza')">
          Cotizar
        </b-button>
      </div>
    </nav>
  </div>
</div>
<b-loading :is-full-page="true" v-model="cargando" :can-cancel="false"></b-loading>
<b-modal
v-model="mostrarDialogo"
has-modal-card
trap-focus
:destroy-on-hide="false"
aria-role="dialog"
aria-label="Modal Terminar Venta"
close-button-aria-label="Close"
aria-modal>
<dialogo-terminar-venta :totalVenta="total" @close="onCerrar" @terminar="onTerminar" v-if="mostrarTerminarVenta"></dialogo-terminar-venta>
<dialogo-agregar-cuenta :totalVenta="total" @close="onCerrar" @terminar="onTerminar" v-if="mostrarAgregarCuenta"></dialogo-agregar-cuenta>
<dialogo-agregar-apartado :totalVenta="total" @close="onCerrar" @terminar="onTerminar" v-if="mostrarAgregarApartado"></dialogo-agregar-apartado>
<dialogo-cotizar :totalVenta="total" @close="onCerrar" @terminar="onTerminar" v-if="mostrarRegistrarCotizacion"></dialogo-cotizar>
</b-modal>
<comprobante-compra :venta="this.ventaRealizada" :tipo="tipoVenta" @impreso="onImpreso" v-if="mostrarComprobante" />
</section>
</template>
<script>
  import BuscarProducto from '../Inventario/BuscarProducto.vue'
  import TablaProductos from './TablaProductos.vue'
  import DialogoTerminarVenta from './DialogoTerminarVenta'
  import DialogoAgregarCuenta from './DialogoAgregarCuenta'
  import DialogoAgregarApartado from './DialogoAgregarApartado'
  import DialogoCotizar from './DialogoCotizar'
  import ComprobanteCompra from './ComprobanteCompra'
  import MensajeInicial from '../Extras/MensajeInicial'
  import AyudanteSesion from '../../Servicios/AyudanteSesion'
  import HttpService from '../../Servicios/HttpService'

  export default{
    name: "RealizarVenta",
    components: { 
      BuscarProducto, 
      TablaProductos, 
      DialogoTerminarVenta, 
      DialogoAgregarCuenta,
      DialogoAgregarApartado,
      DialogoCotizar,
      MensajeInicial,
      ComprobanteCompra
    },

    data:()=>({
      cargando: false,
      productos: [],
      total: 0,
      mostrarDialogo: false,
      mostrarTerminarVenta: false,
      mostrarAgregarCuenta: false,
      mostrarAgregarApartado: false,
      mostrarRegistrarCotizacion: false,
      ventaRealizada: null,
      mostrarComprobante: false,
      tipoVenta: ""
    }),

    methods: {
      onImpreso(resultado){
        this.mostrarComprobante = resultado
      },

      onTerminar(venta){
        this.ventaRealizada = {
          total: this.total,
          productos: this.productos,
          cliente: venta.cliente.id,
          usuario: AyudanteSesion.obtenerDatosSesion().id,
          nombreCliente: (venta.cliente.nombre) ? venta.cliente.nombre : 'MOSTRADOR',
          nombreUsuario: AyudanteSesion.obtenerDatosSesion().usuario,
          fecha: new Date().toJSON().slice(0,10).replace(/-/g,'/')
        }

        let tipo = venta.tipo

        switch(tipo){
          case 'venta':
          this.ventaRealizada.tipo = 'venta'
          this.ventaRealizada.pagado = venta.pagado
          this.ventaRealizada.cambio = venta.cambio
          console.log(this.ventaRealizada)
          break
          case 'cuenta' :
          this.ventaRealizada.tipo = 'cuenta'
          this.ventaRealizada.pagado = venta.pagado
          this.ventaRealizada.porPagar = venta.porPagar
          console.log(this.ventaRealizada)
          break
          case 'apartado' :
          this.ventaRealizada.tipo = 'apartado'
          this.ventaRealizada.pagado = venta.pagado
          this.ventaRealizada.porPagar = venta.porPagar
          console.log(this.ventaRealizada)
          break
          case 'cotiza' :
          this.ventaRealizada.tipo = 'cotiza'
          console.log(this.ventaRealizada)
          break
        }


        this.tipoVenta = venta.tipo

        this.cargando = true
        let datos = {
          accion: 'vender',
          datos: this.ventaRealizada
        }

        HttpService.registrar('vender.php', datos)
        .then(registrado => {
          console.log(registrado)
          if(registrado){
            this.productos = []
            this.total = 0
            this.cargando = false
            this.mostrarTerminarVenta = this.mostrarAgregarCuenta = this.mostrarAgregarApartado = this.mostrarRegistrarCotizacion = false
            this.mostrarDialogo = false
            this.$buefy.toast.open({
              type: 'is-info',
              message: tipo.toUpperCase() + ' registrado con éxito'
            })
            this.mostrarComprobante = true
          }

        })


      },

      cancelarVenta(){   
        this.$buefy.dialog.confirm({
          title: 'Cancelar venta',
          message: '¿Seguro que deseas cancelar la venta?',
          confirmText: 'Sí, cancelar',
          cancelText: 'No, continuar',
          type: 'is-danger',
          hasIcon: true,
          onConfirm: () => {
            this.productos = []
            this.total = 0
            this.$buefy.toast.open('Venta cancelada')
          }
        })
      },


      abrirDialogo(opcion){
        this.mostrarDialogo = true
        switch (opcion){
          case "venta":
          this.mostrarTerminarVenta = true
          this.mostrarAgregarCuenta =  this.mostrarAgregarApartado = this.mostrarRegistrarCotizacion = false
          break
          case "cuenta":
          this.mostrarAgregarCuenta = true
          this.mostrarTerminarVenta = this.mostrarAgregarApartado = this.mostrarRegistrarCotizacion = false
          break
          case "apartado":
          this.mostrarAgregarApartado = true
          this.mostrarAgregarCuenta = this.mostrarTerminarVenta = this.mostrarRegistrarCotizacion = false 
          break
          case "cotiza":
          this.mostrarRegistrarCotizacion = true
          this.mostrarAgregarCuenta = this.mostrarTerminarVenta = this.mostrarAgregarApartado = false 
          break
        }
      },

      onCerrar(opcion){
        this.mostrarDialogo = false
        if(opcion === 'venta' || opcion === 'cuenta' || opcion === 'apartado' || opcion === 'cotiza')
          this.mostrarTerminarVenta = this.mostrarAgregarCuenta = this.mostrarAgregarApartado = this.mostrarRegistrarCotizacion = false
      },

      onQuitar(id){
        let indice = this.productos.findIndex(producto => producto.id === id)
        this.productos.splice(indice, 1)
      },

      onAumentar(producto){
        let verificaExistencia = this.verificarExistenciaAlcanzada(producto.existencia, producto.id)

        if(verificaExistencia) return

          if(producto.vendidoMayoreo){
            this.verificarMayoreo(producto.cantidadMayoreo, producto.id, producto.precioMayoreo)
          }
          this.total = this.calcularTotal()
        },

        onSeleccionado(producto){
          let verificaExistencia = this.verificarExistenciaAlcanzada(producto.existencia, producto.id)

          if(verificaExistencia) return

            console.log(producto)
          if(producto.vendidoMayoreo){
            this.verificarMayoreo(producto.cantidadMayoreo, producto.id, producto.precioMayoreo)
          }

          let existeEnLista = this.verificarSiEstaEnLista(producto.id)

          if(existeEnLista >= 0) {
            this.aumentarCantidad(existeEnLista)
            this.total = this.calcularTotal()
            return
          }

          this.agregarALista(producto)
          this.total = this.calcularTotal()
        },

        agregarALista(producto) {
          this.productos.push(
          {
            id: producto.id,
            codigo: producto.codigo,
            nombre: producto.nombre,
            precio: producto.precioVenta,
            cantidad: 1,
            existencia: producto.existencia,
            vendidoMayoreo: producto.vendidoMayoreo,
            cantidadMayoreo: producto.cantidadMayoreo,
            precioMayoreo: producto.precioMayoreo,
            mayoreoAplicado: false
          }   
          )
        },

        verificarExistenciaAlcanzada(existencia, id){
          let resultado = false
          this.productos.forEach(producto => {
            if(producto.id === id){
              if(parseInt(producto.cantidad) >= parseInt(existencia)){
                this.$buefy.toast.open({
                  type: 'is-danger',
                  message: 'El producto ' + producto.nombre + 'ha alcanzado la existencia máxima. Solo tienes ' + producto.existencia
                })
                producto.cantidad = existencia
                resultado = true
              }
            }

          })
          return resultado
        },

        verificarMayoreo(cantidadMayoreo, id, precioMayoreo) {

          this.productos.forEach(producto => {
            if(producto.mayoreoAplicado) return
              if(producto.id === id) {
                if(producto.cantidad >= parseInt(cantidadMayoreo)){
                  this.$buefy.dialog.confirm({
                    confirmText: 'Sí, aplicar',
                    cancelText: 'No aplicar',
                    message: 'El producto ' + producto.nombre + ' tiene mayoreo a partir de ' + cantidadMayoreo + ' piezas, ¿Desea aplicar el mayoreo?',
                    onConfirm: () => {
                      producto.precio = precioMayoreo
                      producto.mayoreoAplicado = true
                      this.$buefy.toast.open('Mayoreo aplicado correctamente a ' + producto.nombre)
                    }
                  })
                }
              }
            })
        },

        verificarSiEstaEnLista(id){
          return this.productos.findIndex(producto => producto.id === id)
        },

        aumentarCantidad(indice){
          let lista = this.productos
          let producto = lista[indice]
          producto.cantidad ++
          this.productos = lista

        },

        calcularTotal(){
          let total = 0
          this.productos.forEach(producto =>{
            total = parseFloat(producto.cantidad * producto.precio) + parseFloat(total)
          })
          return total
        }
      }
    }
  </script>