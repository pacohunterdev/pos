<template>
    <section>
        <b-field label="Escribe la contraseña actual">
            <b-input type="password"
            placeholder="Contraseña actual"
            password-reveal
            v-model="password.passwordActual">
        </b-input>
    </b-field>
    <b-field label="Escribe la contraseña nueva" message="Al menos un número, Al menos una mayúscula, Al menos una minúscula, Mínimo 8 caracteres">
        <b-input type="password"
        placeholder="Contraseña nueva"
        password-reveal
        v-model="password.passwordNueva">
        </b-input>
    </b-field>
    <b-field label="Repite la nueva contraseña">
        <b-input type="password"
        placeholder="Repite nueva contraseña"
        password-reveal
        v-model="password.passwordRepetida">
    </b-input>
    </b-field>
    <div class="buttons has-text-centered">
        <b-button type="is-primary" size="is-large" icon-left="check" @click="registrar">Cambiar contraseña</b-button>
        <b-button type="is-dark" size="is-large" icon-left="cancel" tag="router-link" to="/perfil">Cancelar</b-button>
    </div>
    <errores-component :errores="mensajesErrores" v-if="mensajesErrores.length > 0" />
    <b-loading :is-full-page="true" v-model="cargando" :can-cancel="false"></b-loading>
</section>
</template>
<script>
    import Utiles from '../../Servicios/Utiles'
    import AyudanteSesion from '../../Servicios/AyudanteSesion'
    import HttpService from '../../Servicios/HttpService'
    import ErroresComponent from '../Extras/ErroresComponent'

    export default {
        name: "CambiarPassword",
        components: { ErroresComponent },

        data:()=>({
            password: {
                passwordActual: "",
                passwordNueva: "",
                passwordRepetida: "",
                
            },
            mensajesErrores: [],
            cargando: false
        }),

        methods: {
            async registrar(){
                this.mensajesErrores = []
                this.mensajesErrores = Utiles.validarDatos(this.password)
                let verificaPass = await this.verificarPasswordActual()
                if(!verificaPass) this.mensajesErrores.push("La contraseña actual ingresada es incorrecta")
                    if(this.password.passwordNueva !== this.password.passwordRepetida) this.mensajesErrores.push("La contraseña repetida no coincide con la nueva")
                        let passwordValida = this.validarPassword(this.password.passwordNueva)
                    if(!passwordValida) this.mensajesErrores.push("La contraseña nueva debe ser válida")
                        if(this.mensajesErrores.length > 0) return

                            this.$buefy.dialog.confirm({
                                message: '¿Seguro que deseas cambiar la contraseña?',
                                confirmText: 'Sí, cambiar',
                                cancelText: 'Cancelar',
                                onConfirm: async() => {
                                    this.cargando = true
                                    let resultado = await HttpService.registrar('usuarios.php',{
                                        accion: 'cambiar_password',
                                        idUsuario: AyudanteSesion.obtenerDatosSesion().id,
                                        password: this.password.passwordRepetida
                                    })
                                    if(resultado){
                                        this.$buefy.toast.open('Contraseña actualizada')
                                        this.cargando = false
                                    }
                                    console.log(resultado)
                                    
                                }
                            })

                    },

                    async verificarPasswordActual(){
                        let paylaod = {
                            accion: "verificar_password",
                            idUsuario: AyudanteSesion.obtenerDatosSesion().id,
                            password: this.password.passwordActual
                        }

                        return await HttpService.obtenerConConsultas('usuarios.php', paylaod)
                    },

                    validarPassword (password) {
                        var re = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/;
                        return re.test(password);
                    }


                }
            }
        </script>