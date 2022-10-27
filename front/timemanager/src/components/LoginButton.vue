
<template>
<nav>
    <div class="nav-wrapper">
      <a class="brand-logo center">Time Manager</a>
      <ul class="left hide-on-med-and-down">
        <li><a>Sass</a></li>
        <li><a>Components</a></li>
        <li><a>JavaScript</a></li>
      </ul>
      <ul id="nav-mobile" class="right hide-on-med-and-down">
        <li><a class="waves-effect waves-light btn" :class="this.$store.state.userConnected.isConnected === false ? 'noDisplay' : ''" v-on:click="disconnectUser()">disconnect</a></li>
        <li :class="this.$store.state.userConnected.isConnected === false ? '' : 'noDisplay'"><a class="waves-effect waves-light btn modal-trigger" href="#modal1">Login</a></li>
      </ul>
    </div>
  </nav>
  <div id="loginButton" :class="noDisplay">
  <!-- Modal Structure -->
  <div id="modal1" class="modal">
    <div class="modal-content">
      <div class="input-field">
          <input id="Email" type="text" class="validate" v-model="user.email">
          <label for="Email">Email</label>
        </div>
        <div class="input-field">
          <input id="Username" type="text" class="validate" v-model="user.username">
          <label for="Username">Username</label>
        </div>
        You typed: <b>{{ user.username }}</b>
    </div>
    <div class="modal-footer">
      <a class="waves-effect waves-green btn-flat" v-on:click="createUser()">Créer un compte</a>
    </div>
    <div class="modal-close modal-footer">
      <a class="waves-effect waves-green btn-flat"  v-on:click="getUser()">Se connecter</a>
    </div>
  </div>
  </div>
</template>

<script>

export default {
  data: function() {
       return {
          user: {username:"",
                  id: "",
                  email: ""},
          userConnected: {
            isConnected: false,
            id:-1,
            username:"",
            email:""
          }
        }
    },
    mounted () {
        var elems = document.querySelectorAll('.modal');
        M.Modal.init(elems);
    },

    methods: {
      createUser: function() {
        fetch("http://localhost:4000/api/users", {
              mode: 'cors',
              method: "POST",
              body: JSON.stringify({
                username: this.user.username,
                email: this.user.email
              }),
              headers: {
                  "Content-type": "application/json; charset=UTF-8"
              }
          })
          .then(response => response.json())
          .then(json => console.log(json));
      },
      getUser: function() {
        fetch("http://localhost:4000/api/users?username=" + this.user.username + "&email=" + this.user.email, {
              mode: 'cors',
              headers: {
                  "Content-type": "application/json; charset=UTF-8"
              }
          })
          .then(response => response.json())
          .then(json => {
            console.log(json)
            this.userConnected.isConnected = true;
            this.userConnected.id = json.user.id
            this.userConnected.username = json.user.username
            this.userConnected.email = json.user.email

            
            this.$store.state.userConnected.isConnected = true
            this.$store.state.userConnected.id = json.user.id
            this.$store.state.userConnected.username = json.user.username
            this.$store.state.userConnected.email = json.user.email
            //console.log(this.$store.state.userConnected.isConnected)
          }
          );
      },
      disconnectUser() {
        this.$store.state.userConnected.isConnected = false
            this.$store.state.userConnected.id = -1
            this.$store.state.userConnected.username = ""
            this.$store.state.userConnected.email = ""
      }
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

.greetings h1,
.greetings h3 {
  text-align: center;
}

.noDisplay {
  display:none
}

.display {
  display:block
}

</style>
