
<template >
    <h1>Clock manager</h1>
</template>
  
<script>
  export default {
    data() {
         return {
          wT: [{
            id: this.$store.state.userConnected.id,
            isConnected: this.$store.state.userConnected.isConnected
          }]
          }
      },
      watch: {
        isConnected(ancien, nouveau) {
          this.getWorkingTimesUser();
        }
      },
  
      mounted () {
      },
      methods: {
        getWorkingTimesUser: function() {
          if (this.$store.state.userConnected.isConnected === true) {
            id = this.$store.state.userConnected.id
            fetch(import.meta.env.VITE_API_URL + "/workingtimes" + id, {
              mode: 'cors',
              headers: {
                "Content-type": "application/json; charset=UTF-8"
              }
            })
            .then(response => response.json())
            .then(json => console.log(json));
          }
        }
      }
  }
  </script>
  
  <style scoped>
  </style>
  