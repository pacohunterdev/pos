<template>
    <section>
        <div class="comprobante" id="comprobante" v-if="datosNegocio">
            <p><b>{{ titulo }}</b></p>
            <p>{{ datosNegocio.nombre }} Teléfono: {{ datosNegocio.telefono }}</p>
            <img :src="datosNegocio.logo" alt="Aqui el logo" width="30">
            <p><b>Cliente:</b>{{ venta.nombreCliente }}</p>
            <p><b>Atiende:</b>{{ venta.nombreUsuario }}</p>
            <p><b>Fecha: </b>{{ venta.fecha }}</p>
            <table>
                <thead>
                    <th>Producto</th>
                    <th></th>
                    <th>Total</th>
                </thead>
                <tbody>
                    <tr v-for="(producto, index) in venta.productos" :key="index">
                        <td>{{ producto.nombre }}</td>
                        <td>${{ producto.precio}} X {{ producto.cantidad }}</td>
                        <td>${{ producto.precio * producto.cantidad }}</td>
                    </tr>
                </tbody>
            </table>
            <p><b>Total:</b>${{ venta.total }}</p>
            <p v-if="tipo !== 'cotiza'"><b>Su pago:</b>${{ venta.pagado }}</p>
            <p v-if="tipo === 'venta'"><b>Cambio:</b>${{ venta.pagado - venta.total }}</p>
            <p v-if="tipo === 'cuenta' || tipo === 'apartado'"><b>Por pagar:</b>${{ venta.porPagar }}</p>
            <p><b>Gracias por su preferencia</b></p>
            <p>----------------------------</p>
            <p>Sistema de ventas por</p>
            <img src="@/assets/logo.png" width="120">
        </div>
    </section>
</template>
<script>
    import AyudanteSesion from '../../Servicios/AyudanteSesion'
    import Utiles from '../../Servicios/Utiles'
    import Printd from "printd";

    

    export default{
        name: "ComprobanteCompra",
        props: ["venta", "tipo"],

        data:()=>({
            titulo: "",
            datosNegocio: null,
            cssText: `
                .comprobante{
                    width: 250px;
                    font-family: monospace;
                    font-size: 14px;
                }

                .comprobante > p{
                    margin: 0!important;
                    padding: 0!important;
                    text-align: center;
                }

                .comprobante > img{
                    display: block;
                    margin: 0 auto;
                }

                .comprobante > th, td {
                  border-bottom: 1px solid #ddd;
                  font-size: 12px !important;
                  margin: 0!important;
                  padding: 0!important;
                }
            `,

        }),

        beforeMount(){
            this.generarTitulo()
            this.obtenerDatosNegocio()
        },

        mounted(){
            

            this.d = new Printd();
            const { contentWindow } = this.d.getIFrame();
            contentWindow.addEventListener("beforeprint", () =>
              console.log("before print event!")
            );
            contentWindow.addEventListener("afterprint", () =>
              console.log("after print event!")
            );

            this.imprimir();
        },

        methods:{
            generarTitulo(){
                switch(this.tipo){
                    case "venta":
                        this.titulo = "COMPROBANTE DE COMPRA"
                        break
                    case "cuenta":
                        this.titulo = "COMPROBANTE DE CUENTA"
                        break

                    case "apartado":
                        this.titulo = "COMPROBANTE DE APARTADO"
                        break

                    case "cotiza":
                        this.titulo = "COTIZACIÓN"
                        break

                    default:
                        this.titulo = "COMPROBANTE"
                }
            },

            obtenerDatosNegocio(){
                this.datosNegocio = AyudanteSesion.obtenerDatosNegocio()
                this.datosNegocio.logo = Utiles.regresarRuta() + this.datosNegocio.logo
            },

            imprimir() {
              let zona = document.getElementById("comprobante");
              setTimeout(() => this.d.print(zona, [this.cssText]), 10);
              this.$emit("impreso", false);
            },
        }
    }
</script>
<style scoped>
    .comprobante{
        width: 250px;
        font-family: monospace;
        font-size: 14px;
    }

    .comprobante > p{
        margin: 0!important;
        padding: 0!important;
        text-align: center;
    }

    .comprobante > img{
        display: block;
        margin: 0 auto;
    }

    .comprobante > th, td {
      border-bottom: 1px solid #ddd;
      font-size: 12px !important;
      margin: 0!important;
      padding: 0!important;
    }
    
</style>