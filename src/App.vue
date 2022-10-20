<template>
  <div id="app">
    <inicio-sesion @login="onLogin" v-if="!logeado"/>
    <div v-if="logeado">
      <encabezado-component />
      <div class="container">
        <router-view/>
      </div>
    </div>    
  </div>
</template>
<script>
  import EncabezadoComponent from './components/EncabezadoComponent'
  import InicioSesion from './components/Usuarios/InicioSesion'
  import AyudanteSesion from './Servicios/AyudanteSesion'

  export default {
    name: "App", 
    components: {
      EncabezadoComponent,
      InicioSesion
    },

    data:()=>({
      logeado: false
    }),

    mounted(){
      const log = AyudanteSesion.verificarSesion()
      this.logeado = log
      console.log(this.logeado)
    },

    methods: {
      onLogin(resultado){
        console.log(resultado)
        if(resultado.estado) {
          AyudanteSesion.establecerSesion(resultado.usuario)
          this.logeado = AyudanteSesion.verificarSesion()
        }
      }
    }
  }
</script>