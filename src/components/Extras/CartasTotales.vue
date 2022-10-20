<template>
	<div class="tile is-ancestor">
		<div class="tile is-parent">
			<div class="card tile is-child" v-for="(item,index) in totales" :key="index">
				<div class="card-content">
					<div class="level is-mobile">
						<div class="level-item">
							<div class="is-widget-label">
								<h3 class="subtitle is-spaced">{{ item.nombre }}</h3>
								<h1 class="title">
									<div>{{ item.total }}</div>
								</h1>
							</div>
							<div class="level-item has-widget-icon">
								<div class="is-widget-icon">
									<span class="icon is-large" :class="item.clase">
										<b-icon :icon="item.icono" size="is-large"/>
									</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>
<script>
	export default {
		name: "CartasTotales",
		props: ["totales"]
	}
</script>