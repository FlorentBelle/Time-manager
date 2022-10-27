import { createApp } from 'vue'
import App from './App.vue'
import { createStore } from 'vuex'

import './assets/main.css'

// Create a new store instance.
const store = createStore({
  state () {
    return {
      count: 0,
      userConnected: {
        isConnected: false,
        id:-1,
        username:"",
        email:""
      }, 
      userWorkingTime: {
        
      }
    }
  },
  mutations: {
    increment (state) {
      state.count++
    }
  }
})


//const app = createApp(App).mount('#app')
const app = createApp(App)
app.use(store)
app.mount('#app')
