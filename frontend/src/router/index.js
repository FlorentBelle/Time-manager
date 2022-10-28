import { createRouter, createWebHistory } from 'vue-router'
import Login from '../components/Login.vue'
import Home from '../components/Home.vue'
import Profile from '../components/Profile.vue'
import WorkingTimesList from '../components/WorkingTimesList.vue'
import WorkingTimeUpdate from '../components/WorkingTimeUpdate.vue'
import ClockManager from '../components/ClockManager.vue'

import Dashboard from '../components/dashboard/Dashboard.vue'
import All from '../components/dashboard/graphs/All.vue'
import Bar from '../components/dashboard/graphs/Bar.vue'
import Line from '../components/dashboard/graphs/Line.vue'
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
      component: Dashboard,
      children: [
        {
          path: '', 
          component: All
        },
        {
          path: 'bar', 
          component: Bar
        },
        {
          path: 'line', 
          component: Line
        },
        {
          path: 'another', 
          component: Another
        },
      ]
    },
    {
      path: '/users/:userID',
      component: Profile
    }
  ]
})

export default router