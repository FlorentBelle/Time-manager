
<template>
  <v-table :data="wT">
    <thead slot="head">
        <th>id</th>
    </thead>
    <tbody slot="body" slot-scope="{displayData}">
        <tr v-for="row in wT">
          <td>{{ row.id }}</td>
        </tr>
    </tbody>
  </v-table>
</template>

<script>

export default {
  data() {
       return {
        wT: [{
          id:5,
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
          fetch("http://localhost:4000/api/workingtimes" + id, {
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
