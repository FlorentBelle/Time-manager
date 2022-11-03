<template>
	<div class="row">
		<div class="col s4">
			<Bar/>
		</div>
		<div class="col s4">
			<Line/>
		</div>
		<div class="col s4">
			<Doughnut/>
		</div>
	</div>
</template>

<script>
import Bar from './Bar.vue'
import Line from './Line.vue'
import Doughnut from './Doughnut.vue'
export default {
  components: {
		Bar,
		Line,
		Doughnut
	},
	data: function() {
		return {
		}
	},
	mounted () {
	}
}
</script>

<style scoped>
</style>