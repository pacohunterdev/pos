<template>
    <section>
        <p class="title is-1">Agregar cliente</p>
         <b-breadcrumb
            align="is-left"
        >
            <b-breadcrumb-item tag='router-link' to="/">Inicio</b-breadcrumb-item>
            <b-breadcrumb-item tag='router-link' to="/cientes">Clientes</b-breadcrumb-item>
            <b-breadcrumb-item active>Agregar cliente</b-breadcrumb-item>
        </b-breadcrumb>
        <form-cliente :cliente="datosCliente" @registrar="onRegistrar"/>
        <b-loading :is-full-page="true" v-model="cargando" :can-cancel="false"></b-loading>
    </section>
</template>
<script>
    import FormCliente from './FormCliente'
    import HttpService from '../../Servicios/HttpService'

    export default{
        name: "AgregarCliente",
        components: { FormCliente },

        data: ()=>({
            cargando: false,
            datosCliente: {
                nombre: "",
                telefono: ""
            }
        }),

        methods: {
            onRegistrar(cliente){
                console.log(cliente)
                this.cargando = true
                let payload = {
                    accion: "registrar",
                    cliente: cliente
                }
                HttpService.registrar("clientes.php", payload)
                .then(registrado =>{
                    if(registrado){
                        this.$buefy.toast.open({
                          type: 'is-info',
                          message: 'Cliente registrado con éxito.'
                        })
                        this.cargando = false
                    }
                })
            }
        }
    }
</script>