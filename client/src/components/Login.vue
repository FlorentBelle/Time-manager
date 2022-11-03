<script setup>
  import router from '../router';
</script>

<template>
  <div class="login-logo-container">
    <img class="login-logo" src="../assets/tm_logo_lighter.png">
  </div>
  <div v-if="!session || !session.active" class="login-form-container">
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
        session: {
          active: false,
          id: null,
          username: '',
          email: ''
        }
      }
    },
    mounted () {
      if (!localStorage.session) {
        localStorage.session = JSON.stringify({
          ...this.session
        })} else {
          this.session = JSON.parse(localStorage.session)
      }
    },
    methods: {
      createUser: function() {
        fetch(process.env.VUE_APP_API_URL + "/users", {
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
          .then(response => {
            if(response.success) {
              console.log(response)
              this.$toast.success('User created !', {
                  position: "top-right"
              });
              this.registerUser(true, response.content.user.id, response.content.user.username, response.content.user.email)
              router.replace('/home')
            } else {
              console.log(response)
              this.$toast.error(response.error, {
                position: "top-right"
              });
            }
          });
      },
      getUser: function() {
        fetch(process.env.VUE_APP_API_URL + "/users?username=" + this.user.username + "&email=" + this.user.email, {
              mode: 'cors',
              headers: {
                  "Content-type": "application/json; charset=UTF-8"
              }
          })
          .then(response => response.json())
          .then(response => {
            if(response.success && response.content.length === 1) {
              this.$toast.success('Login succes !', {
                  position: "top-right"
              });
              this.registerUser(true, response.content[0].id, response.content[0].username, response.content[0].email)
              router.push('/home')
            } else {
              this.$toast.error(response.error, {
                position: "top-right"
              });
            }
          }
        )
      },
      registerUser: function(active, id, username, email) {
        if(this.checkUserInfos(active, id, username, email)) {
          const newSession = {
            active: active,
            id: id,
            username: username,
            email: email
          }
          this.session = newSession
          localStorage.session = JSON.stringify(newSession)
        } else {
          const newSession = {
            active: false,
            id: null,
            username: '',
            email: ''
          }
          this.session = newSession
          localStorage.session = JSON.stringify(newSession)
        }
      },
      checkUserInfos: function(active, id, username, email) {
        return typeof active === 'boolean' && 
          typeof id === 'number' && 
            typeof username === 'string' && username.length > 0 &&
              typeof email === 'string' && email.length > 0
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
