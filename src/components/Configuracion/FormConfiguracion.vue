<template>
    <form>
        <b-field label="Nombre del negocio" >
            <b-input step="any" icon="store" type="text" placeholder="Ej. Tienda Doña Panque" v-model="datosNegocio.nombre"></b-input>
        </b-field>
        <b-field label="Teléfono" >
            <b-input step="any" icon="phone" type="number" placeholder="Ej. 2311459874" v-model="datosNegocio.telefono"></b-input>
        </b-field>

        <div class="field is-horizontal">   
            <div class="field-body">
                <div class="file is-primary">
                    <label class="file-label">
                        <input class="file-input" type="file" name="resume" @input="onFileChange"  ref="fileInput">
                        <span class="file-cta">
                            <span class="file-label">
                                Seleccionar logo
                            </span>
                        </span>
                    </label>
                </div>
            </div>
        </div>
    <img :src="urlImagen" width="150" height="200">
    <div class="buttons has-text-centered">
        <b-button type="is-primary" size="is-large" icon-left="check" @click="registrar">Registrar</b-button>
        <b-button type="is-dark" size="is-large" icon-left="cancel" tag="router-link" to="/">Cancelar</b-button>
    </div>
    <errores-component :errores="mensajesError" v-if="mensajesError.length > 0" />
</form>
</template>
<script>
    import Utiles from '../../Servicios/Utiles'
    import ErroresComponent from '../Extras/ErroresComponent'

    export default{
        name: "FormConfiguracion",
        props: ["datos"],
        components: { ErroresComponent },

        data:()=>({
            datosNegocio: {
                nombre: "",
                telefono: ""
            },
            urlImagen: null,
            mensajesError: []
        }),

        mounted(){
            this.datosNegocio = this.datos
            this.urlImagen = Utiles.regresarRuta() + this.datos.logo
        },

        methods: {
            onFileChange() {
              let input = this.$refs.fileInput
              let file = input.files
              if (file && file[0]) {
                let reader = new FileReader
                reader.onload = e => {
                    this.urlImagen = e.target.result
                }
                reader.readAsDataURL(file[0])
                this.$emit('input', file[0])
            }
        },

        registrar(){
            this.mensajesError = Utiles.validarDatos(this.datosNegocio)
            if(this.mensajesError.length > 0) return
            let cambiaLogo = (this.urlImagen.includes("data:image")) 
            this.datosNegocio.logo = (cambiaLogo) ? this.urlImagen : this.urlImagen.split('api')[1]
            this.datosNegocio.cambiaLogo = cambiaLogo
            this.$emit("registrar", this.datosNegocio)
        }
    }


}
</script>