
<template>
  <div class="calendar-container">
    <div class="menu-title-container">
      <div class="greeting-card">
        <h1 class="menu-title">Working times</h1>
      </div>
    </div>
    <button @click="openCreateWt('create')" class="app-button">
      <svg viewBox="0 0 457.47 457.469">
        <path d="M228.734,0C102.41,0,0,102.41,0,228.735C0,355.06,102.41,457.469,228.734,457.469
          c126.325,0,228.735-102.409,228.735-228.734C457.47,102.41,355.06,0,228.734,0z M359.268,265.476h-97.326v97.315
          c0,16.668-13.506,30.186-30.181,30.186c-16.668,0-30.189-13.518-30.189-30.186v-97.315h-97.309
          c-16.674,0-30.192-13.512-30.192-30.187c0-16.674,13.518-30.188,30.192-30.188h97.315v-97.31c0-16.674,13.515-30.183,30.189-30.183
          c16.675,0,30.187,13.509,30.187,30.183v97.315h97.314c16.669,0,30.192,13.515,30.192,30.188
          C389.46,251.97,375.937,265.476,359.268,265.476z"
        />
      </svg>
      New working time
    </button>
    <v-calendar
      class="custom-calendar max-w-full"
      :masks="masks"
      :attributes="attributes"
      disable-page-swipe
      is-expanded
    >
      <template v-slot:day-content="{ day, attributes }">
        <div class="cell-container-cell-2 flex flex-col h-full z-10 overflow-hidden" >
          <span class="cell-container-cell-1 day-label text-sm text-gray-900">{{ day.day }}</span>
          <div class="cell-container-cell flex-grow overflow-y-auto overflow-x-auto" v-on:click="" style="z-index: 0">
            <div
              v-for="attr in attributes"
              :key="attr.key"
              class="cell-container text-xs leading-tight rounded-sm p-1 mt-0 mb-1 calendarBorder"
              :class="attr.customData.class"
              :id="attr.customData.id"
              style="z-index: 0"
            >
              <p @click="openSelectedWorkingTime(attr, 'update')" class="cell">
                <span class="dot"></span>
                {{ attr.customData.start }} - {{attr.customData.end}}
              </p>
              
            </div>
          </div>
        </div>
      </template>
    </v-calendar>
  </div>
  <div class="modal-update-wt" v-show="editVisible">
    <div class="modal-mask">
    <div class="modal-wrapper">
      <div class="modal-container">
        <div class="modal-header">
          <slot name="header"></slot>
        </div>
        <div class="modal-body">
          <label for="selectedStart" class="block text-sm font-medium text-gray-700">Start</label>
          <input type="datetime-local" name="selectedStart" id="selectedStart" v-model="selectedStart" class="mt-1 block w-full rounded-md border border p-2" />
          <label for="selectedEnd" class="block text-sm font-medium text-gray-700">End</label>
          <input type="datetime-local" name="selectedEnd" id="selectedEnd" v-model="selectedEnd" class="mt-1 block w-full rounded-md border border p-2" />
        </div>
        <div class="modal-footer">
            <button class="app-button" v-on:click="mode === 'create' ? createWorkingTime() : updateWorkingTime()">
              <span v-if="mode === 'create'">Create</span>
              <span v-else="mode === 'update'">Update</span>
              <span></span>
            </button>
            <button class="app-button" @click="hideModal()">Cancel</button>
        </div>
      </div>
    </div>
  </div>
  </div>

</template>

<script>
  import 'v-calendar/dist/style.css';
  import WorkingTime from '../api/WorkingTime.js'
  import router from '../router';


  export default {
    data() {
      return {
        wT: [{
          id: 1,
          isConnected: ""
        }],
        visible: false,
        masks: {
          weekdays: 'WWW',
        },
        attributes: [
        ],
        selectedStart: "2000-01-01T00:00:00",
        selectedEnd: "2000-01-01T01:00:00",
        editVisible: false,
        wtId: null,
        mode: null
      }
    },
    async created () {
      await this.getWorkingTimesUser();
    },
    methods: {
      getWorkingTimesUser: async function() {
          const id = parseInt(this.$route.params.userID)  

          const userConnected = localStorage.session ? localStorage.session : null
          const isAuthoriseManager = userConnected ? JSON.parse(userConnected).isAuthoriseManager : false
          var userConnectedID = userConnected ? JSON.parse(userConnected).id : -1;
          var is_authorise = false;

          if (userConnectedID !== id && isAuthoriseManager === true) {
            is_authorise = true;
          }
          else if (userConnectedID === id) {
            
            is_authorise = true;
          }
          if (is_authorise) {
            const response = await fetch(process.env.VUE_APP_API_URL + "/workingtimes/" + id, {
              mode: 'cors',
              headers: {
                "Content-type": "application/json; charset=UTF-8",
                "Authorization": JSON.parse(localStorage.session).token
              }
            })
            const { content: workingTimes, success: success } = await response.json()

            if(success && workingTimes && workingTimes.length > 0) {
                this.wT = workingTimes
                var myObjs = []
                var cpt = 1;
                this.wT.forEach(element => {
                  var dateStart = element.start.slice(0, -1);
                  var dateEnd = element.end.slice(0, -1);
                  //date de départ
                  var date = element.start
                  date = date.split('T')
                  var dateYMD = date[0].split('-')
                  var hours = date[1].slice(0,-1);
                  //date de fin
                  var endDate =  element.end
                  endDate = endDate.split('T')
                  var hoursend = endDate[1].slice(0,-1);
                  var myobj = {
                    key: cpt,
                    isVisible:false,
                    customData: {
                      id: element.id,
                      title: 'workingTime',
                      class: 'bg-red-600 text-white',
                      startTime: dateStart,
                      endTime: dateEnd,
                      start: hours,
                      end: hoursend
                    },
                    dates: new Date(dateYMD[0], parseInt(dateYMD[1]) - 1, dateYMD[2])
                  }
                  myObjs.push(myobj)
                  cpt++
                })
                this.attributes = myObjs
            } else {
              this.$toast.error("No working time for this user", {position: "top-right"});
            }
          } else {
            this.$toast.error("Access not autorized !", {position: "top-right"});
            router.replace('/home')
          }
      },
      openSelectedWorkingTime: function(attr, mode) {
        this.mode = mode
        this.editVisible = true
        this.selectedStart = attr.customData.startTime
        this.selectedEnd = attr.customData.endTime
        this.wtId = attr.customData.id
      },
      openCreateWt: function (mode) {
        this.mode = mode
        this.editVisible = true
        this.selectedStart = null
        this.selectedEnd = null
        this.wtId = null
      },
      createWorkingTime: async function () {      
        this.selectedStart = this.selectedStart.split(':').length === 2 ? this.selectedStart + ":00Z" : this.selectedStart + 'Z'
        this.selectedEnd = this.selectedEnd.split(':').length === 2 ? this.selectedEnd + ":00Z" : this.selectedEnd + 'Z'
        fetch(process.env.VUE_APP_API_URL +"/workingtimes/" + JSON.parse(localStorage.session).id, {
            mode: 'cors',
            method: "POST",
            body: JSON.stringify({
              start: this.selectedStart,
              end: this.selectedEnd
            }),
            headers: {
                "Content-type": "application/json; charset=UTF-8",
                "Authorization": JSON.parse(localStorage.session).token
            }
        })
        .then(response => response.json())
        .then(json => {
          this.editVisible = false;
        })
      },
      updateWorkingTime: function () {
        var newSt = this.selectedStart;
        newSt = newSt.split(':').length === 2 ? newSt + ":00Z" : newSt + 'Z'
        var newEt = this.selectedEnd;
        newEt = newEt.split(':').length === 2 ? newEt + ":00Z" : newEt + 'Z'

        fetch(process.env.VUE_APP_API_URL +"/workingtimes/" + this.wtId, {          
            mode: 'cors',
            method: "PUT",
            body: JSON.stringify({
              start: newSt,
              end: newEt
            }),
            headers: {
                "Content-type": "application/json; charset=UTF-8",
                "Authorization": JSON.parse(localStorage.session).token
            }
        })
        .then(response => response.json())
        .then(json => {
          this.editVisible = false;
        });
      },
      hideModal: function () {
        this.editVisible = false
      }
    },
    watch: {
      async editVisible () {
        await this.getWorkingTimesUser();
      }
    }
  }
</script>

<style lang="scss" scoped>
  .calendar-container {
    overflow: auto;
  }
  .modal-update-wt {
    position: absolute;
    z-index: 10;
  }
  .app-button {
    border: none;
    border-radius: 10px;
    padding: 7.5px;
    background-color: var(--color-1);
    color: var(--color-2);
    margin-top: 10px;
    width: fit-content;
    height: 40px;
    font-size: 12px;
    font-weight: 400;
    text-align: center;
    color: white;
    margin-right: 10px;
    margin-bottom: 15px;
    display: flex;
    align-items: center;
    &:hover {
    filter: brightness(1.25);
    cursor: pointer;
    }
    svg {
      fill: white;
      width: 15px;
      margin-right: 5px;
    }
  }

  .menu-title-container {
      display: flex;
      justify-content: center;
      align-items: center;
      width: 100%;
      height: 20%;
      margin-bottom: 2.5%;
      .greeting-card {
        width: 25%;
        display: flex;
        justify-content: center;
        background: rgb(170,111,207);
        background: linear-gradient(45deg, rgba(170,111,207,1) 0%, rgba(28,28,32,0.2861519607843137) 50%);
        padding: 15px;
        border-radius: 15px;
        .menu-title {
          color: var(--color-2);
          margin: 0;
          font-size: 24px;
        }
      }
  }
  .custom-calendar {
    background-color: var(--bg-4);
    border: none;
    border-radius: 10px;
    padding: 10px 30px;
  }
  .cell-container-cell-2 {
    border-radius: 10px !important;
    padding: 10px 10px 15px 10px !important;
    height: fit-content;
    min-height: 80px;
    margin-right: 5px;
    margin-bottom: 5px;
    background-color: var(--bg-1);
  }
  .cell-container-cell-1 {
    background-color: var(--color-1);
    color: var(--color-2);
    height: 25px;
    width: 25px;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 5px;
  }
  .cell {
    color: var(--color-2);
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 14px;
    &:hover {
      color: var(--color-1);
      cursor: pointer;
    }
  }
  .dot {
    background-color: var(--color-1);
    height: 5px;
    width: 5px;
    border-radius: 50%;
    margin-right: 5px;
    margin-top: 2px;
  }

  @keyframes a {
    to {background-position:0 -200%}
  }

  .modal-mask {
      position: fixed;
      z-index: 9998;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.75);
      display: table;
      transition: opacity 0.3s ease;
  }
  
  .modal-wrapper {
    display: table-cell;
    vertical-align: middle;
  }
  
  .modal-container {
    width: 300px;
    margin: 0px auto;
    padding: 20px 30px;
    background-color: var(--bg-4);
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.33);
    transition: all 0.3s ease;
  }
  
  .modal-body {
    margin: 20px 0;
    label {
      color: var(--color-2);
    };
    input[type="datetime-local"] {
      color: var(--color-2);
      font-size: 14px;
      &::-webkit-calendar-picker-indicator {
      // background: #ffffff;
      filter: invert(100%);
    }
    }
  }

  .modal-footer {
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
  
  .modal-default-button {
    float: right;
  }
  
  /*
   * The following styles are auto-applied to elements with
   * transition="modal" when their visibility is toggled
   * by Vue.js.
   *
   * You can easily play with the modal transition by editing
   * these styles.
   */
  
  .modal-enter-from {
    opacity: 0;
  }
  
  .modal-leave-to {
    opacity: 0;
  }
  
  .modal-enter-from .modal-container,
  .modal-leave-to .modal-container {
    -webkit-transform: scale(1.1);
    transform: scale(1.1);
  }
</style>
