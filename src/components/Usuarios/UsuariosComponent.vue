<template>
    <section>
        <nav-component :titulo="'Usuarios'" :link="{ path: '/agregar-usuario' }" :texto="'Agregar usuario'" />
        <mensaje-inicial :titulo="'No se han registrado usuarios'" :subtitulo="'Agrega algunos usuarios'" v-if="usuarios.length < 1" />
        <b-table
        :data="usuarios">
            <b-table-column field="usuario" label="Nombre de usuario" sortable searchable v-slot="props">
                {{ props.row.usuario }}
            </b-table-column>

            <b-table-column field="nombre" label="Nombre completo" sortable searchable v-slot="props">
                {{ props.row.nombre }}
            </b-table-column>

            <b-table-column field="telefono" label="Teléfono" sortable searchable v-slot="props">
                {{ props.row.telefono }}
            </b-table-column>

            <b-table-column field="eliminar" label="Eliminar" v-slot="props">
                <b-button type="is-danger" icon-left="delete" @click="eliminar(props.row.id)">Eliminar</b-button>
            </b-table-column>

            <b-table-column field="editar" label="Editar" v-slot="props">
                <b-button type="is-info" icon-left="pen" @click="editar(props.row.id)">Editar</b-button>
            </b-table-column>
        </b-table>
        <b-loading :is-full-page="true" v-model="cargando" :can-cancel="false"></b-loading>
    </section>
</template>
<script>
    import MensajeInicial from '../Extras/MensajeInicial'
    import NavComponent from '../Extras/NavComponent'
    import HttpService from '../../Servicios/HttpService'

    export default {
        name: "UsuariosComponent",
        components: { MensajeInicial, NavComponent },

        data:()=>({
            cargando: false,
            usuarios: []
        }),

        mounted(){
            this.obtenerUsuarios()
        },

        methods: {
            async eliminar(idUsuario){
                this.$buefy.dialog.confirm({
                    title: 'Eliminar usuario',
                    message: 'Seguro que quieres <b>eliminar</b> este usuario? Esta acción no se puede revertir.',
                    confirmText: 'Sí, eliminar',
                    cancelText: 'Cancelar',
                    type: 'is-danger',
                    hasIcon: true,
                    onConfirm: () => {
                        this.cargando = true
                        HttpService.eliminar('usuarios.php',{
                            accion: 'eliminar',
                            id: idUsuario
                        })
                        .then(resultado => {
                            if(!resultado) {
                                this.$buefy.toast.open('Error al eliminar')
                                this.cargando = false
                                return
                            }

                            if(resultado){
                                this.cargando = false
                                this.$buefy.toast.open({
                                    type: 'is-info',
                                    message: 'Usuario eliminado.'
                                })
                                this.obtenerUsuarios()
                            }
                        })
                    }
                })
            },

            editar(idUsuario){
                this.$router.push({
                    name: "EditarUsuario",
                    params: { id: idUsuario}
                })
            },

            obtenerUsuarios(){
                this.cargando = true
                let payload = {
                    accion: 'obtener'
                }
                HttpService.obtenerConConsultas('usuarios.php', payload)
                .then(usuarios => {
                    this.usuarios = usuarios
                    this.cargando = false
                })
            }
        }
    }
</script>