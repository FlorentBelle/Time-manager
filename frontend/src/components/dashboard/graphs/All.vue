<template>
	<div class="row">
		<div class="col s4">
			<Bar/>
		</div>
		<div class="col s4">
			<Line/>
		</div>
		<div class="col s4">
			<Another/>
		</div>
	</div>
</template>

<script>

import Bar from './Bar.vue'
import Line from './Line.vue'
import Another from './Another.vue'

export default {
  components: {
		Bar,
		Line,
		Another
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
