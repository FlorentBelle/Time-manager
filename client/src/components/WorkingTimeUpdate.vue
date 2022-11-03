
<template >
    <h1>Update working time</h1>
</template>
  
<script>
  export default {
    data() {
         return {
          // wT: [{
          //   id: JSON.parse(localStorage.session).id,
          //   isConnected: this.$store.state.userConnected.isConnected
          // }]
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
          // if (this.$store.state.userConnected.isConnected === true) {
            // const id = JSON.parse(localStorage.session).id
            fetch(process.env.VUE_APP_API_URL + "/workingtimes" + 1, {
              mode: 'cors',
              headers: {
                "Content-type": "application/json; charset=UTF-8"
              }
            })
            .then(response => response.json())
            .then(json => console.log(json));
          // }
        }
      }
  }
  </script>
  
  <style scoped>
  </style>
  