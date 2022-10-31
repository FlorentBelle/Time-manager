<script setup>
  import router from '../router';
</script>

<template>
  <div class="login-logo-container">
    <img class="login-logo" src="../assets/tm_logo_lighter.png">
  </div>
  <div v-if="!this.$store.state.userConnected.isConnected" class="login-form-container">
    <div class="login-form" role="form">
      <h5 class="login-form-title">Login</h5>
      <div class="login-form-fields">
        <div class="login-form-field">
          <label for="Email">Email</label>
          <input id="Email" type="text" v-model="user.email">
        </div>
        <div class="login-form-field">
          <label for="Username">Username</label>
          <input id="Username" type="text" v-model="user.username">
        </div>
      </div>
      <div class="login-form-buttons">
        <button class="login-form-button-connect" v-on:click="getUser()">Log in</button>
        <span class="login-form-button-separator"></span>
        <button class="login-form-button-create" v-on:click="createUser()">Register</button>
      </div>
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
        fetch(import.meta.env.VITE_API_URL + "/users", {
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
        fetch(import.meta.env.VITE_API_URL + "/users?username=" + this.user.username + "&email=" + this.user.email, {
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

              router.replace('/home')
          }
          );
      }
    }
  }
</script>

<style lang="scss" scoped>
  .login-logo-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 30%;
    .login-logo {
      width: 200px;
    }
  }
  .login-form-container {
    width: 100%;
    height: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
    .login-form {
      width: 20em;
      height: 30em;
      margin: auto;
      background-color: var(--bg-4);
      border-radius: 10px;
      padding: 50px 25px;
      .login-form-title {
        width: 80%;
        margin: auto;
        font-size: 18px;
        color: var(--color-2);
        margin-top: 0;
        margin-bottom: 30px;
      }
      .login-form-fields {
        width: 80%;
        display: flex;
        flex-direction: column;
        justify-content: center;
        margin: auto;
        .login-form-field {
          width: 100%;
          margin-bottom: 30px;
          label {
            font-size: 12px;
            margin-bottom: 10px;
            color: var(--color-2);
          }
          input {
            background-color: rgba($color: #ffffff, $alpha: 0.95);
            border-radius: 10px;
            width: calc(100% - 20px);
            height: 20px;
            border: 1px solid #ffffff;
            &:hover {
              border: 1px solid var(--color-1);
            }
          }
          input[type="text"] {
            padding: 0 10px;
            font-size: 12px;
          }
        }
      }
      .login-form-buttons {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        margin-top: 25px;
        .login-form-button-create {
          border: none;
          border-radius: 10px;
          padding: 5px;
          background-color: var(--color-1);
          color: var(--color-2);
          margin-top: 20px;
          width: 80px;
          height: 25px;
          font-size: 12px;
          font-weight: 400;
          text-align: center;
          &:hover {
            filter: brightness(1.25);
            cursor: pointer;
          }
        }
        .login-form-button-separator {
          width: 80%;
          border-top: 1px solid var(--color-1);
        }
        .login-form-button-connect {
          border: none;
          padding: 5px;
          background-color: var(--color-3);
          border-radius: 10px;
          color: var(--color-2);
          margin-bottom: 20px;
          width: 80px;
          height: 30px;
          font-size: 12px;
          font-weight: 400;
          text-align: center;
          &:hover {
            filter: brightness(1.25);
            cursor: pointer;
          }
        }
      }
    }
  }
</style>
