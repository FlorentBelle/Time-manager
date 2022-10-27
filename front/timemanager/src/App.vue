<script setup>
import LoginButton from './components/LoginButton.vue';
import WorkingTimes from './components/WorkingTimes.vue';

</script>
<template>
  <header class="borderMe">
    <LoginButton/>
  </header>
  <body>
    <p>{{this.$store.state.userConnected.username}}</p>
    <WorkingTimes/>
  </body>
  <footer>

  </footer>

  <!--
    <main>
      <TheWelcome />
    </main>
  -->
</template>

<script>
export default {
  data: function() {
       return {
          userConnected: {
            isConnected: false,
            id:-1,
            username:"",
            email:""
          },
          wT: [{
            id: 3
          },
          {
            id: 4
          },
          {
            id: 5
          }
        ]
        }
    },
    mounted () {
    }
}

</script>

<style scoped>
header {
  line-height: 1.5;
}

.borderMe {
  border: solid;
  width: 100%;
  height: 100%;
}

.logo {
  display: block;
  margin: 0 auto 2rem;
}

</style>
