<template>
    <section class="hero is-danger">
      <div class="hero-body">
        <p class="title">
          Debes completar los siguientes campos
        </p>
        <p class="subtitle" v-for="(error, index) in errores" :key="index">
          {{ error }}
        </p>
      </div>
</section>
</template>
<script>
    export default{
        name: "ErroresComponent",
        props: ["errores"]
    }
</script>