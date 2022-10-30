
<template>
    <h3>Dashboard</h3>
    <button class="btn waves-effect waves-light color white">
        <router-link :to="{path: `/${userID}`}">All</router-link>
    </button>
    <button class="btn waves-effect waves-light color white">
        <router-link :to="{path: `/${userID}/bar`}">bar</router-link>
    </button>
    <button class="btn waves-effect waves-light color white">
        <router-link :to="{path: `/${userID}/line`}">line</router-link>
    </button>
    <button class="btn waves-effect waves-light color white">
        <router-link :to="{path: `/${userID}/line`}">line</router-link>
    </button>
    <router-view></router-view>
</template>

<script>

export default {
  data: function() {
       return {
        userID: this.$route.params.userID
        }
    },
    mounted () {
    }
}
</script>

<style scoped>
</style>
