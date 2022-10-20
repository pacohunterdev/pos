<template>
    <section>
        <p class="title is-1">Agregar productos</p>
        <b-breadcrumb
            align="is-left"
        >
            <b-breadcrumb-item tag='router-link' to="/">Inicio</b-breadcrumb-item>
            <b-breadcrumb-item tag='router-link' to="/inventario">Inventario</b-breadcrumb-item>
            <b-breadcrumb-item  active>Agregar producto</b-breadcrumb-item>
        </b-breadcrumb>     
        <form-producto @registrado="onRegistrado" :productoProp="producto"/>
        <b-loading :is-full-page="true" v-model="cargando" :can-cancel="false"></b-loading>
    </section>
</template>
<script>
    import FormProducto from './FormProducto.vue'
    import HttpService from '../../Servicios/HttpService'

    export default {
        name: "AgregarProducto",
        components: { FormProducto },

        data:()=>({
            cargando: false,
            producto: {
                codigo: "",
                nombre: "",
                precioCompra: "",
                precioVenta: "",
                existencia: 0,
                vendidoMayoreo: false,
                precioMayoreo: "",
                cantidadMayoreo: 0,
                categoria: "",
                marca:""
            },
        }),

        methods: {
            onRegistrado(producto) {
                console.log(producto)
                this.cargando = true
                let payload = {
                    accion: 'registrar',
                    producto: producto
                }
                HttpService.registrar("productos.php", payload)
                .then(registrado => {
                    if(registrado) {
                        this.cargando = false
                        this.$buefy.toast.open({
                          type: 'is-info',
                          message: 'Producto registrado con éxito.'
                        })
                    }
                })
            }
        }

    }
</script>