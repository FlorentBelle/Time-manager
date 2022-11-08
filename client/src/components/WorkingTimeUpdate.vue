
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
          fetch(process.env.VUE_APP_API_URL + "/workingtimes" + 1, {
            mode: 'cors',
            headers: {
              "Content-type": "application/json; charset=UTF-8",
              "Authorization": JSON.parse(localStorage.session).token
            }
          })
          .then(response => response.json())
          // .then(json => console.log(json));
        }
      }
  }
  </script>
  
  <style scoped>
  </style>
  