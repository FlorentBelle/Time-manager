<script setup>
  import router from '../router';
</script>

<template>
    <div v-if="!this.$store.state.userConnected.isConnected" class="login">
        <div>
            <div class="input-field">
                <input id="Email" type="text" class="validate" v-model="user.email">
                <label for="Email">Email</label>
            </div>
            <div class="input-field">
                <input id="Username" type="text" class="validate" v-model="user.username">
                <label for="Username">Username</label>
            </div>
        </div>
        <div>
            <a class="waves-effect btn-flat" v-on:click="createUser()">Créer un compte</a>
        </div>
        <div class="">
            <a class="waves-effect btn-flat"  v-on:click="getUser()">Se connecter</a>
        </div>
    </div>
</template>

<script>

export default {
  data: function() {
    return {
        user: {
        username:"",
        id: "",
        email: ""
        },
        userConnected: {
            isConnected: false,
            id: null,
            username:"",
            email:""
        },
    }
  },
  mounted () {
    localStorage.userConnected = JSON.stringify(
        {
          isConnected: false,
          id: null,
          username: '',
          email: ''
        }
    )
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
            this.userConnected.isConnected = true;
            this.userConnected.id = json.content[0].id
            this.userConnected.username = json.content[0].username
            this.userConnected.email = json.content[0].email
          
            this.$store.state.userConnected.isConnected = true
            this.$store.state.userConnected.id = json.content[0].id
            this.$store.state.userConnected.username = json.content[0].username
            this.$store.state.userConnected.email = json.content[0].email

            localStorage.userConnected = JSON.stringify({
                isConnected: true,
                id: json.content[0].id,
                username: json.content[0].username,
                email: json.content[0].email,
            })

            router.push('/home')
        }
        );
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

</style>
