<template>
    <div style="color:black; ">
      <h2 class="h2" style="color:white">Admin View</h2>
      <table style="background-color: white;">
          <thead>
            <tr>
              <th style="text-align: center;">
                ID
              </th>
              <th  style="text-align: center;">
                Username
              </th>
              <th  style="text-align: center;">
                Email
              </th>
              <th>
                Roles
              </th>
              <th>
                Voir WorkingTime
              </th>
              <th>
                Save
              </th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="item in users"
              :key="item.username"
              style="border-style: solid;"
            >
            <td style="text-align: center;">{{ item.id }}</td>
              <td style="text-align: center;">{{ item.username }}</td>
              <td style="text-align: center;">{{ item.email }}</td>
              <td>
                <!--{{(item.role_id === null ? item.role : this.roles.find(element => element.id === item.role_id).role_name)}}-->
                <select v-model="item.role_id"  style="display:block">
                  <option v-for="option in roles" v-bind:value="option.id">
                    {{ option.role_name }}
                  </option>
                </select>
              </td>
              <RouterLink :to="'/working_times/' + item.id">
                <button class="card-menu-button">Go to</button>
              </RouterLink>
              <td>
              <button class="card-menu-button" @click="modifyUser(item);">Edit</button>
            </td>
            </tr>
  
          </tbody>
      </table>
  
      <div style="margin-top: 25%;">
        <table style="background-color: white;">
          <thead>
            <tr>
              <th style="text-align: center;">
                ID
              </th>
              <th  style="text-align: center;">
                role_name
              </th>
            </tr>
          </thead>
          <tbody>
            <tr
            v-for="role in roles"
            :key="role.role_name"
            style="border-style: solid;"
            >
            <td style="text-align: center;">{{ role.id }}</td>
            <td style="text-align: center;">{{ role.role_name }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
    <input style="color:white" v-model="newrole" placeholder="Nouveau Role" />
    <button @click="addRoles()">Ajouter un nouveau role</button>
  </template>
  
  <script>
  import { RouterLink } from 'vue-router'
  export default {
    
    data() {
      return {
        users:[],
        roles:[],
        newrole:"",
        selected:""
      }
    }
    ,
      components: {
      },
      computed: {
      },
      watch: {
      },
      mounted () {
        this.getUsers();
        this.getRoles();
      },
      methods: {
        getUsers: function() {
              fetch(process.env.VUE_APP_API_URL + "/users" ,{
              mode: 'cors',
              headers: {
                "Content-type": "application/json; charset=UTF-8"
              }
            })
            .then(response => response.json())
            .then(json => {
              console.log("users : ", json)
              this.users = json.content
              
            })
        },
        getRoles: function() {
            fetch(process.env.VUE_APP_API_URL + "/roles" ,{
              mode: 'cors',
              headers: {
                "Content-type": "application/json; charset=UTF-8"
              }
            })
            .then(response => response.json())
            .then(json => {
              console.log("roles :  : ", json)
              this.roles = json.content
            })
        },
        addRoles: function() {
              fetch(process.env.VUE_APP_API_URL + "/roles" ,{
              method:'POST',
              mode: 'cors',
              body: JSON.stringify({
                role_name:this.newrole
                }),
              headers: {
                "Content-type": "application/json; charset=UTF-8"
              }
            })
            .then(response => response.json())
            .then(json => {
              console.log("newrole : ", json)
            })
        },
        modifyUser: function(roles) {
          console.log(roles.role_id);
              fetch(process.env.VUE_APP_API_URL + "/users/" + roles.id ,{
              method:'PUT',
              mode: 'cors',
              body: JSON.stringify({
                role_id: roles.role_id
                }),
              headers: {
                "Content-type": "application/json; charset=UTF-8"
              }
            })
            .then(response => response.json())
            .then(json => {
              console.log("newrole : ", json)
            })
        }
      }
  };
  </script>
  
  <style >
  </style>
