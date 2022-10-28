<script setup>
  import router from '../router';
</script>

<template>
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

<style lang="scss" scoped>
  .login-form-container {
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    .login-form {
      width: 500px;
      height: 650px;
      margin: auto;
      background-color: #000000;
      border-radius: 10px;
      padding: 60px 30px;
      .login-form-title {
        width: 80%;
        margin: auto;
        font-size: 26px;
        color: #ffffff;
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
            font-size: 14px;
            margin-bottom: 10px;
          }
          input {
            background-color: rgba($color: #ffffff, $alpha: 0.95);
            border-radius: 5px;
            width: calc(100% - 20px);
          }
          input[type="text"] {
            padding: 0 10px;
          }
        }
      }
      .login-form-buttons {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        margin-top: 75px;
        .login-form-button-create {
          border: none;
          padding: 10px;
          background-color: #1BA8F0;
          border-radius: 5px;
          color: #ffffff;
          margin-top: 20px;
          width: 160px;
          height: 55px;
          font-size: 18px;
          font-weight: 500;
          &:hover {
            filter: brightness(1.25);
            cursor: pointer;
          }
        }
        .login-form-button-separator {
          width: 80%;
          border-top: 1px solid white;
        }
        .login-form-button-connect {
          border: none;
          padding: 10px;
          background-color: #01AE66;
          border-radius: 5px;
          color: #ffffff;
          margin-bottom: 20px;
          width: 160px;
          height: 55px;
          font-size: 18px;
          font-weight: 500;
          &:hover {
            filter: brightness(1.25);
            cursor: pointer;
          }
        }
      }
    }
  }
</style>
