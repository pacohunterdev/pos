<template>
  <section>
    <p class="title is-1">Marcas y categorías</p>
    <b-breadcrumb
    align="is-left"
    >
    <b-breadcrumb-item tag='router-link' to="/">Inicio</b-breadcrumb-item>
    <b-breadcrumb-item active>Marcas y categorías</b-breadcrumb-item>
  </b-breadcrumb>
  <b-tabs v-model="tabActiva" size="is-large">
    <b-tab-item label="Marcas" icon="tag-multiple">
      <marcas-component/>
    </b-tab-item>

    <b-tab-item label="Categorías" icon="archive">
      <categorias-component />
    </b-tab-item>
  </b-tabs>
</section>
</template>
<script>
  import MarcasComponent from './MarcasComponent'
  import CategoriasComponent from './CategoriasComponent'
  export default{
    name: "MarcasCategorias",
    components: { MarcasComponent, CategoriasComponent },

    data:()=>({
      tabActiva: 0,      
    }),
  }
</script>