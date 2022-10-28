<script setup>
  import { RouterLink } from 'vue-router'
  import router from '../router';
</script>

<template>
<nav>
    <div class="nav-wrapper">
      <a class="brand-logo center">Time Manager</a>
      <ul v-if="this.$store.state.userConnected.isConnected">
        <li><a><RouterLink to="/home">Home</RouterLink></a></li>
        <li><a><RouterLink :to="'/clock/' + this.$store.state.userConnected.username">Clock</RouterLink></a></li>
        <li><a><RouterLink :to="'/working_times/' + this.$store.state.userConnected.id">Working times</RouterLink></a></li>
        <li><a><RouterLink :to="'/chart_manager/' + this.$store.state.userConnected.id">Dashboard</RouterLink></a></li>
        <li><a><RouterLink :to="'/users/' + this.$store.state.userConnected.id">Profile</RouterLink></a></li>
      </ul>
      <ul v-if="this.$store.state.userConnected.isConnected">
        <li >
          <a class="white-button waves-effect waves-light btn" v-on:click="disconnectUser()">Disconnect</a>
        </li>
      </ul>
    </div>
  </nav>
</template>

<script>
  export default {
    data() {
      return {
        user: {
          username:"",
          id: "",
          email: ""
        },
        userConnected: {
          isConnected: false,
          id:-1,
          username:"",
          email:""
        },
        // isSession: false
      }
    },
    // mounted() {
    //   if(localStorage && localStorage.userConnected) {
    //     const parsedUserConnected = JSON.parse(localStorage.userConnected)
    //     console.log("parsedUserConnected", parsedUserConnected)
    //     if(parsedUserConnected !== this.$store.state.userConnected && 
    //       this.$store.state.userConnected.isConnected !== parsedUserConnected.isConnected) 
    //     {
    //       this.$store.state.userConnected = parsedUserConnected
    //     }
    //   }
    // },
    // updated() {
    //   if(localStorage && localStorage.userConnected) {
    //     const parsedUserConnected = JSON.parse(localStorage.userConnected)
    //     if(this.$store.state.userConnected.isConnected !== this.isSession) 
    //     {
    //       this.$store.state.userConnected = parsedUserConnected
    //     }
    //   }
    // },
    // computed: {
    //   isSession() {
    //     console.log("isSession()", this.isSession)
    //     return this.isSession
    //   }
    // },
    methods: {
      disconnectUser: function() {
        this.$store.state.userConnected.isConnected = false
        this.$store.state.userConnected.id = null
        this.$store.state.userConnected.username = ""
        this.$store.state.userConnected.email = ""
        localStorage.userConnected = JSON.stringify({
          isConnected: false,
          id: null,
          username: '',
          email: ''
        })
        router.push('/')
      },
    }
  }
</script>

<style scoped>
h1 {
  font-weight: 500;
  font-size: 2.6rem;
  top: -10px;
}

h3 {
  font-size: 1.2rem;
}

.white-button {
  background-color: #ffffff;
  color: #ee6e73;
}

.white-button:hover {
  background-color: #ffffff;
  color: #ee6e73;
}

</style>
