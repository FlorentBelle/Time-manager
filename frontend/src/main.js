import { createApp } from 'vue'
import { createStore } from 'vuex'
import App from './App.vue'
import router from './router'
import './assets/main.css'
import VCalendar from 'v-calendar';
import { SetupCalendar, Calendar, DatePicker } from 'v-calendar';
import Toaster from "@meforma/vue-toaster";

// Create a new store instance.
const store = createStore({
  state () {
    return {
      userConnected: {
        isConnected: localStorage && localStorage.userConnected ? JSON.parse(localStorage.userConnected)['isConnected'] : false,
        id: localStorage && localStorage.userConnected ? JSON.parse(localStorage.userConnected)['id'] : null,
        username: localStorage && localStorage.userConnected ? JSON.parse(localStorage.userConnected)['username'] : '',
        email: localStorage && localStorage.userConnected ? JSON.parse(localStorage.userConnected)['email'] : ''
      }
    }
  }
})


const app = createApp(App)
app.component('Calendar', Calendar)
app.component('DatePicker', DatePicker)
app.use(VCalendar, {})
app.use(store)
app.use(router)
app.use(Toaster)
app.mount('#app')
