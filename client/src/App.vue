<script setup>
  import TimeManagerView from './views/TimeManagerView.vue';
</script>

<template>
  <TimeManagerView/>
</template>

<script>
export default {
  data: function() {
    return {
      session: {
        active: false,
        id: null,
        username: '',
        email: '',
        isAuthoriseAdmin: "",
        isAuthoriseManager: "",
        token: ""
      }
    }
  },
  mounted () {
    if (!localStorage.session) {
      localStorage.session = JSON.stringify({
        ...this.session
      })
    } else {
      this.session = JSON.parse(localStorage.session)
    }
  }
}

</script>

<style lang="scss">
</style>
