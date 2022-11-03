<template>
    <div style="color:black; ">
      <h2 class="h2" style="color:white">Manager View</h2>
      <input style="color:white" v-model="newteam" placeholder="Nouvelle Equipe" />
        <button @click="addTeam()">Ajouter une nouvelle équipe</button>
  
      <div style="color:white">
        Liste des équipes : 
        <div v-for="item in teams" :key="item.id">
            {{ item.team_name }}
            <div v-for="member in item.members" :key="member.id">
              {{ member.user }}
        </div>
        </div>
  
      </div>
      <div style="background-color: white;">
        <div class="drop-zone"
          @drop="onDrop($event, 1)"
          @dragenter.prevent
          @dragover.prevent
        >
          <div v-for="item in getList(1)" :key="item.title" class="drag-el" draggable="true" @dragstart="startDrag($event, item)">
            {{ item.title }}
          </div>
        </div>
  
  
        <div class="drop-zone" 
          @drop="onDrop($event, 2)"
          @dragenter.prevent
          @dragover.prevent>
          <div v-for="item in getList(2)" :key="item.title" class="drag-el" draggable="true" @dragstart="startDrag($event, item)">
            {{ item.title }}
          </div>
        </div>
      </div>
     </div>
  </template>
  
  <script>
  const isInside = function (list, id) {
                    var bool = false;
                    if (list) {
                      list.forEach(element => {
                        //element.user = id
                        if (element.user === id) {
                          bool = true;
                          //console.log('l :', list)
                        }
                        //console.log("user id :",  element.user)
                      });
                    }
                    //console.log('bool', bool, "id ", id)
                    return bool;
                  }
  const modUsers = function (teams) {
    /*
    teams.forEach(elem => {
      console.log("el id ",elem.id);
      console.log("el elem ",elem);
      console.log("el users ",elem["users"]);
      console.log("el members ",elem["members"]);
      if (elem["users"] !== undefined) {
        elem["users"].forEach(element2 => {
          var val = isInside(elem["members"], element2.id)
          var plus = val === true ? 0 : 1;
          var valtwo = elem.id * 10 + plus
          element2["list"] = valtwo
        });
      }
    })*/
    var teamCpy = teams
    if (teamCpy["users"] !== undefined) {
      for (var i = 0; i < teamCpy.users.length ; i++) {
        teamCpy.users[i].listssss = teamCpy.id + i;
      }
      console.log('ok', teamCpy.id, teamCpy)
      /*
      teamCpy["users"].forEach(element2 => {
          var val = isInside(teamCpy["members"], element2.id)
          var plus = val === true ? 0 : 1;
          var valtwo = teamCpy.id * 10 + plus
          //valtwo = 18762
          console.log("valtwo", valtwo)
          element2["list"] = valtwo
          console.log("element 2 : ", element2)
      });
      elem["users"].forEach(element2 => {
          var val = isInside(elem["members"], element2.id)
          var plus = val === true ? 0 : 1;
          var valtwo = elem.id * 10 + plus
          element2["list"] = valtwo
        });*/
        console.log("teamCpy : ", teamCpy);
  }
  }
  export default {
    
    data() {
      return {
        newteam:"",
        users:[],
        roles:[],
        teams:[],
        items: [
          {
            id: 0,
            title: 'Item A',
            list: 1,
          },
          {
            id: 1,
            title: 'Item B',
            list: 1,
          },
          {
            id: 2,
            title: 'Item C',
            list: 2,
          },{
            id: 3,
            title: 'Item D',
            list: 2,
          },
        ],
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
        this.getTeams();
      },
      methods: {
        startDrag(evt, item) {
          console.log(item)
        evt.dataTransfer.dropEffect = 'move'
        evt.dataTransfer.effectAllowed = 'move'
        evt.dataTransfer.setData('itemID', item.id)
      },
      onDrop(evt, list) {
        const itemID = evt.dataTransfer.getData('itemID')
        const item = this.items.find((item) => item.id == itemID)
        item.list = list
      },
      getList: function (list) {
        return this.items.filter((item) => item.list === list)
      },
      getUsersList: function(list) {
        var l = this.teams.filter((item) => item.id === list)
        console.log('L : ' , this.teams);
      },
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
              this.roles = json.content
            })
        },
        getTeams: function() {
            fetch(process.env.VUE_APP_API_URL + "/teams/" + this.$store.state.userConnected.id,{
              mode: 'cors',
              headers: {
                "Content-type": "application/json; charset=UTF-8"
              }
            })
            .then(response => response.json())
            .then(json => {
              this.teams = json.content
            }).then(() => {
              this.teams.forEach(element => {
                fetch(process.env.VUE_APP_API_URL + "/teamMember/" + element.id,{
                  mode: 'cors',
                  headers: {
                    "Content-type": "application/json; charset=UTF-8"
                  }
                })
                .then(response2 => response2.json())
                .then(json2 => {
                  element["members"] = json2.content
                  element["users"] = this.users
                  modUsers(element);
                })
              })
            }).then(() => {
            })
        },
        addTeam: function () {
          fetch(process.env.VUE_APP_API_URL + "/teams/"+ this.$store.state.userConnected.id ,{
              method:'POST',
              mode: 'cors',
              body: JSON.stringify({
                team_name: this.newteam,
                }),
              headers: {
                "Content-type": "application/json; charset=UTF-8"
              }
            })
            .then(response => response.json())
            .then(json => {
              console.log('response :', json);
            })
        }
      }
  };
  /*
              this.teams = json.content
              this.teams.forEach(element => {
                fetch(process.env.VUE_APP_API_URL + "/teamMember/" + element.id,{
                  mode: 'cors',
                  headers: {
                    "Content-type": "application/json; charset=UTF-8"
                  }
                }).then(responses => responses.json())
                .then(json2 => {  
                  console.log('members :  ', json2);
                  element["members"] = json2.content
                  
                  element["users"] = this.users
                  var isInside = function (list, id) {
                    var bool = false;
                    if (list) {
                      list.forEach(element => {
                        element.user = id
                        console.log("user id :",  element.user)
                      });
                    }
                    return bool;
                  }
                  element["users"].forEach(element2 => {
                    element2["list"] = element.id * 10 + (
                      isInside(element["members"]) === true ? 0 : 1
                    )
                  });
                  })
              }
              );
  */
  </script>
  
  
  <style scoped>
  .drop-zone {
    background-color: #eee;
    margin-bottom: 10px;
    padding: 10px;
  }
  .drag-el {
    background-color: rgb(43, 10, 192);
    margin-bottom: 10px;
    color:white;
    padding: 5px;
  }
  </style>