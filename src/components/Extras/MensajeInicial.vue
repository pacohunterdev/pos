<template>
    <section class="hero is-medium is-primary">
      <div class="hero-body">
        <p class="title">
          {{ titulo }}
        </p>
        <p class="subtitle">
          {{ subtitulo }}
        </p>
      </div>
    </section>
</template>
<script>
    export default{
        name: "mensajeInicial",
        props: ["titulo", "subtitulo"]
    }
</script>