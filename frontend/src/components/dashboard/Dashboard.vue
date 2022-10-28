
<template>
    <h1>Dashboard</h1>
    <button>
        <router-link to="/">All</router-link>
    </button>
    <button>
        <router-link to="/bar">bar</router-link>
    </button>
    <button>
        <router-link to="/line">line</router-link>
    </button>
    <router-view></router-view>
</template>

<script>

export default {
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
