<template>
	<b-field>
        <b-select 
        placeholder="Selecciona el año" 
        v-model="anioActual"
        @change.native="seleccionar">
            <option
                v-for="anio in anios"
                :value="anio"
                :key="anio"
                >
                {{ anio }}
            </option>
            </b-select>
        </b-field>
</template>
<script>
	export default{
		name: "SelectAnio",
		props: ["grafica"],

		data:()=>({
			anioActual: new Date().getFullYear(),
			anios: []
		}),

		mounted(){
			for(let i = 2015; i <= this.anioActual; i++){
				this.anios.push(i)
			}
		},

		methods:{
			seleccionar(){
				let datos = { noGrafica: this.grafica, anio: this.anioActual }
				this.$emit("seleccionado", datos)
			}
		}

	}
</script>