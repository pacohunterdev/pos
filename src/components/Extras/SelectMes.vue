<template>
	<b-field>
        <b-select placeholder="Selecciona el mes" v-model="mesActual" @change.native="seleccionar">
            <option
                v-for="mes in meses"
                :value="mes.numero"
                :key="mes.numero"
                >
                {{ mes.mes }}
            </option>
         </b-select>
    </b-field>
</template>
<script>
	export default{
		name: "SelectMes",

		data:()=>({
			mesActual: new Date().getMonth() + 1,
			meses: [
				{numero: 1, mes: "Enero"},
				{numero: 2, mes: "Febrero"},
				{numero: 3, mes: "Marzo"},
				{numero: 4, mes: "Abril"},
				{numero: 5, mes: "Mayo"} ,
				{numero: 6, mes: "Junio"} ,
				{numero: 7, mes: "Julio"} ,
				{numero: 8, mes: "Agosto" },
				{numero: 9, mes: "Septiembre" },
				{numero: 10, mes: "Octubre"} ,
				{numero: 11, mes: "Noviembre"} ,
				{numero: 12, mes: "Diciembre"}
			]
		}),

		methods:{
			seleccionar(){
				this.$emit("seleccionado", this.mesActual)
			}
		}
	}
</script>