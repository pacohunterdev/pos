<template>
    <section>
        <p class="title is-1">Agregar usuario</p> 
         <b-breadcrumb
            align="is-left"
        >
            <b-breadcrumb-item tag='router-link' to="/">Inicio</b-breadcrumb-item>
            <b-breadcrumb-item tag='router-link' to="/usuarios">Usuarios</b-breadcrumb-item>
            <b-breadcrumb-item active>Agregar usuario</b-breadcrumb-item>
        </b-breadcrumb>
        <form-usuario @registrar="onRegistrar" :usuario="datosUsuario"/> 
        <b-loading :is-full-page="true" v-model="cargando" :can-cancel="false"></b-loading>
    </section>
</template>
<script>
    import FormUsuario from './FormUsuario'
    import HttpService from '../../Servicios/HttpService'

    export default{
        name: "AgregarUsuario",
        components: { FormUsuario },

        data:()=>({
            cargando: false,
            datosUsuario: {
                usuario: "",
                nombre: "",
                telefono: ""
            }
        }),

        methods: {
            onRegistrar(usuario) {
                console.log(usuario)
                this.cargando = true
                let payload = {
                    accion: 'registrar',
                    usuario: usuario
                }

                HttpService.registrar('usuarios.php', payload)
                .then(registrado => {
                    if(registrado) {
                        this.cargando = false
                        this.$buefy.toast.open({
                          type: 'is-info',
                          message: 'Usuario registrado con éxito. Recuerda que la contraseña es PacoHunterDev'
                        })
                    }
                })
            }   
        }

    }
</script>