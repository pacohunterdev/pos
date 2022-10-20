<template>
    <section class="hero  is-fullheight fondo">

        <div class="hero-body">
            <div class="container">

                <div class="box">
                     <h1 class="title is-1 has-text-centered is-family-monospace">Sistema de ventas by</h1>
                    <img src="@/assets/logo.png" width="300" style="display: block; margin:0 auto;">
                    <b-field label="Nombre de usuario" >
                        <b-input  icon="shield-account" type="text" placeholder="Ej. paco" v-model="usuario.usuario"></b-input>
                    </b-field>
                    <b-field label="Contraseña" >
                        <b-input type="password"
                            placeholder="Contraseña"
                            v-model="usuario.password"
                            password-reveal>
                        </b-input>
                    </b-field>
                    <b-button type="is-primary" size="is-large" icon-left="check" @click="iniciarSesion">Ingresar</b-button>
                </div>
                <div v-if="informacionNegocio" class="has-text-centered">
                    <h2 class="title is-2 has-text-danger-dark has-text-weight-bold">{{ informacionNegocio.nombre }}</h2>
                    <h3 class="title is-3 has-text-info-dark has-text-weight-bold">Teléfono: {{ informacionNegocio.telefono }}</h3>
                </div>
                
                <img src="http://localhost/pos/api/logos/logo.png" width="300" height="300" style="display: block; margin:0 auto;">
            </div>
      </div>
    </section>
</template>
<script>
    import HttpService from '../../Servicios/HttpService'
    import AyudanteSesion from '../../Servicios/AyudanteSesion'

    export default {
        name: "InicioSesion",
        
        data:()=>({
            usuario: {
                usuario: "",
                password: ""
            },

            informacionNegocio: null
        }),

        mounted(){
            this.obtenerInformacionLocal()
            this.informacionNegocio = AyudanteSesion.obtenerDatosNegocio()
        },

        methods:{
            iniciarSesion(){
                let payload = {
                    accion: 'iniciar_sesion',
                    usuario: this.usuario
                }

                HttpService.obtenerConConsultas('usuarios.php', payload)
                .then(resultado => {
                    if(!resultado){
                        this.$buefy.toast.open({
                          type: 'is-danger',
                          message: 'Información incorrecta. Verifica.'
                        })
                        return
                    }

                    if(resultado.estado){
                        this.$buefy.toast.open({
                          type: 'is-info',
                          message: 'Información correcta. Bienvenido.'
                        })
                        this.$router.push({ name: 'InicioComponent' })
                        this.$emit("login", resultado)
                    }
                })
            },

            obtenerInformacionLocal(){
                HttpService.obtenerConConsultas('ajustes.php',{
                    accion: 'obtener'
                })
                .then(resultado =>{
                    AyudanteSesion.establecerDatosNegocio(resultado)
                })
            }
        }
        
    }
</script>
<style>
    .fondo{
        background-color: #FF7F13;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='100%25'%3E%3Cdefs%3E%3ClinearGradient id='a' gradientUnits='userSpaceOnUse' x1='0' x2='0' y1='0' y2='100%25' gradientTransform='rotate(264,512,333)'%3E%3Cstop offset='0' stop-color='%23FF7F13'/%3E%3Cstop offset='1' stop-color='%23FFC026'/%3E%3C/linearGradient%3E%3Cpattern patternUnits='userSpaceOnUse' id='b' width='507' height='422.5' x='0' y='0' viewBox='0 0 1080 900'%3E%3Cg fill-opacity='0.08'%3E%3Cpolygon fill='%23444' points='90 150 0 300 180 300'/%3E%3Cpolygon points='90 150 180 0 0 0'/%3E%3Cpolygon fill='%23AAA' points='270 150 360 0 180 0'/%3E%3Cpolygon fill='%23DDD' points='450 150 360 300 540 300'/%3E%3Cpolygon fill='%23999' points='450 150 540 0 360 0'/%3E%3Cpolygon points='630 150 540 300 720 300'/%3E%3Cpolygon fill='%23DDD' points='630 150 720 0 540 0'/%3E%3Cpolygon fill='%23444' points='810 150 720 300 900 300'/%3E%3Cpolygon fill='%23FFF' points='810 150 900 0 720 0'/%3E%3Cpolygon fill='%23DDD' points='990 150 900 300 1080 300'/%3E%3Cpolygon fill='%23444' points='990 150 1080 0 900 0'/%3E%3Cpolygon fill='%23DDD' points='90 450 0 600 180 600'/%3E%3Cpolygon points='90 450 180 300 0 300'/%3E%3Cpolygon fill='%23666' points='270 450 180 600 360 600'/%3E%3Cpolygon fill='%23AAA' points='270 450 360 300 180 300'/%3E%3Cpolygon fill='%23DDD' points='450 450 360 600 540 600'/%3E%3Cpolygon fill='%23999' points='450 450 540 300 360 300'/%3E%3Cpolygon fill='%23999' points='630 450 540 600 720 600'/%3E%3Cpolygon fill='%23FFF' points='630 450 720 300 540 300'/%3E%3Cpolygon points='810 450 720 600 900 600'/%3E%3Cpolygon fill='%23DDD' points='810 450 900 300 720 300'/%3E%3Cpolygon fill='%23AAA' points='990 450 900 600 1080 600'/%3E%3Cpolygon fill='%23444' points='990 450 1080 300 900 300'/%3E%3Cpolygon fill='%23222' points='90 750 0 900 180 900'/%3E%3Cpolygon points='270 750 180 900 360 900'/%3E%3Cpolygon fill='%23DDD' points='270 750 360 600 180 600'/%3E%3Cpolygon points='450 750 540 600 360 600'/%3E%3Cpolygon points='630 750 540 900 720 900'/%3E%3Cpolygon fill='%23444' points='630 750 720 600 540 600'/%3E%3Cpolygon fill='%23AAA' points='810 750 720 900 900 900'/%3E%3Cpolygon fill='%23666' points='810 750 900 600 720 600'/%3E%3Cpolygon fill='%23999' points='990 750 900 900 1080 900'/%3E%3Cpolygon fill='%23999' points='180 0 90 150 270 150'/%3E%3Cpolygon fill='%23444' points='360 0 270 150 450 150'/%3E%3Cpolygon fill='%23FFF' points='540 0 450 150 630 150'/%3E%3Cpolygon points='900 0 810 150 990 150'/%3E%3Cpolygon fill='%23222' points='0 300 -90 450 90 450'/%3E%3Cpolygon fill='%23FFF' points='0 300 90 150 -90 150'/%3E%3Cpolygon fill='%23FFF' points='180 300 90 450 270 450'/%3E%3Cpolygon fill='%23666' points='180 300 270 150 90 150'/%3E%3Cpolygon fill='%23222' points='360 300 270 450 450 450'/%3E%3Cpolygon fill='%23FFF' points='360 300 450 150 270 150'/%3E%3Cpolygon fill='%23444' points='540 300 450 450 630 450'/%3E%3Cpolygon fill='%23222' points='540 300 630 150 450 150'/%3E%3Cpolygon fill='%23AAA' points='720 300 630 450 810 450'/%3E%3Cpolygon fill='%23666' points='720 300 810 150 630 150'/%3E%3Cpolygon fill='%23FFF' points='900 300 810 450 990 450'/%3E%3Cpolygon fill='%23999' points='900 300 990 150 810 150'/%3E%3Cpolygon points='0 600 -90 750 90 750'/%3E%3Cpolygon fill='%23666' points='0 600 90 450 -90 450'/%3E%3Cpolygon fill='%23AAA' points='180 600 90 750 270 750'/%3E%3Cpolygon fill='%23444' points='180 600 270 450 90 450'/%3E%3Cpolygon fill='%23444' points='360 600 270 750 450 750'/%3E%3Cpolygon fill='%23999' points='360 600 450 450 270 450'/%3E%3Cpolygon fill='%23666' points='540 600 630 450 450 450'/%3E%3Cpolygon fill='%23222' points='720 600 630 750 810 750'/%3E%3Cpolygon fill='%23FFF' points='900 600 810 750 990 750'/%3E%3Cpolygon fill='%23222' points='900 600 990 450 810 450'/%3E%3Cpolygon fill='%23DDD' points='0 900 90 750 -90 750'/%3E%3Cpolygon fill='%23444' points='180 900 270 750 90 750'/%3E%3Cpolygon fill='%23FFF' points='360 900 450 750 270 750'/%3E%3Cpolygon fill='%23AAA' points='540 900 630 750 450 750'/%3E%3Cpolygon fill='%23FFF' points='720 900 810 750 630 750'/%3E%3Cpolygon fill='%23222' points='900 900 990 750 810 750'/%3E%3Cpolygon fill='%23222' points='1080 300 990 450 1170 450'/%3E%3Cpolygon fill='%23FFF' points='1080 300 1170 150 990 150'/%3E%3Cpolygon points='1080 600 990 750 1170 750'/%3E%3Cpolygon fill='%23666' points='1080 600 1170 450 990 450'/%3E%3Cpolygon fill='%23DDD' points='1080 900 1170 750 990 750'/%3E%3C/g%3E%3C/pattern%3E%3C/defs%3E%3Crect x='0' y='0' fill='url(%23a)' width='100%25' height='100%25'/%3E%3Crect x='0' y='0' fill='url(%23b)' width='100%25' height='100%25'/%3E%3C/svg%3E");
    background-attachment: fixed;
    background-size: cover;
    }
</style>