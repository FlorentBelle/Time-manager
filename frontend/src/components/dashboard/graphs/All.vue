<template>
  <h1>All</h1>
	<div class="row">
		<div class="col s4">
		<Bar/>
		</div>
		<div class="col s4">
		<Line/>
		</div>
		<div class="col s4">
		<Line/>
		</div>
	</div>
</template>

<script>

import Bar from './Bar.vue'
import Line from './Line.vue'

export default {
  components: {
		Bar,
		Line
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
