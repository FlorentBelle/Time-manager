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
import Another from '../components/dashboard/graphs/Another.vue'

// Create a new router instance
const router = createRouter({
  history: createWebHistory(),
  base: '/login',
  routes: [
    {
      path: '/',
      alias: '/login',
      name: 'login',
      component: Login,
    },
    {
      path: '/home',
      component: Home
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

router.beforeEach(async (to, from) => {
  if (
    // make sure the user is authenticated
    !JSON.parse(localStorage.userConnected).isConnected &&
    // ❗️ Avoid an infinite redirect
    to.name !== 'login'
  ) {
    // redirect the user to the login page
    return { name: 'login' }
  }
})

export default router