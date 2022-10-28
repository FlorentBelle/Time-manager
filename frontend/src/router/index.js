import { createRouter, createWebHistory } from 'vue-router'
import Login from '../components/Login.vue'
import Home from '../components/Home.vue'
import Profile from '../components/Profile.vue'
import WorkingTimesList from '../components/WorkingTimesList.vue'
import WorkingTimeUpdate from '../components/WorkingTimeUpdate.vue'
import ClockManager from '../components/ClockManager.vue'
import Dashboard from '../components/Dashboard.vue'

// Create a new router instance
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      component: Login,
    },
    {
      path: '/home',
      component: Home
    },
    {
      path: '/clock/:username',
      component: ClockManager
    },
    {
      path: '/working_times/:userID',
      component: WorkingTimesList
    },
    {
      path: '/working_times/:userID',
      component: WorkingTimeUpdate
    },
    {
      path: '/chart_manager/:userID',
      component: Dashboard
    },
    {
      path: '/users/:userID',
      component: Profile
    }
  ]
})

export default router