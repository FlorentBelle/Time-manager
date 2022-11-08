import { createRouter, createWebHistory } from 'vue-router'
import Login from '../components/Login.vue'
import Home from '../components/Home.vue'
import Profile from '../components/Profile.vue'
import WorkingTimesList from '../components/WorkingTimesList.vue'
import Dashboard from '../components/dashboard/Dashboard.vue'
import All from '../components/dashboard/graphs/All.vue'
import Bar from '../components/dashboard/graphs/Bar.vue'
import Line from '../components/dashboard/graphs/Line.vue'
import Doughnut from '../components/dashboard/graphs/Doughnut.vue'
import Manager from '../components/Manager.vue'
import Admin from '../components/Admin.vue'

import { createToaster } from "@meforma/vue-toaster";

const toaster = createToaster({position: "top-right"});

// Create a new router instance
const router = createRouter({
  history: createWebHistory(process.env.VUE_APP_BASE_URL),
  base: '/',
  routes: [
    {
      path: '/',
      name: 'login',
      component: Login,
    },
    {
      path: '/home',
      name: 'home',
      component: Home
    },
    {
      path: '/working_times/:userID',
      name: 'working_times',
      component: WorkingTimesList
    },
    // {
    //   path: '/working_time/:userID',
    //   component: WorkingTimeUpdate
    // },
    {
      path: '/chart_manager/:userID',
      name: 'chart_manager',
      component: Dashboard,
      children: [
        {
          path: '', 
          component: All,
          name: 'all'
        },
        {
          path: 'bar', 
          component: Bar,
          name: 'bar'
        },
        {
          path: 'line', 
          component: Line,
          name: 'line'
        },
        {
          path: 'doughnut', 
          component: Doughnut,
          name: 'doughnut'
        },
      ]
    },
    {
      path: '/chart_managerTeam/:teamID',
      name: 'chart_managerTeam',
      component: Dashboard,
      children: [
        {
          path: '', 
          component: All,
          name: 'allTeam'
        },
        {
          path: 'bar', 
          component: Bar,
          name: 'barTeam'
        },
        {
          path: 'line', 
          component: Line,
          name: 'lineTeam'
        },
        {
          path: 'doughnut', 
          component: Doughnut,
          name: 'doughnutTeam'
        },
      ]
    }
    ,
    {
      path: '/users/:userID',
      component: Profile,
      name: 'users/:userID'
    },
    {
      path: '/adminView',
      name: 'adminView',
      component: Admin,
      droitsAdmin: true,
      droitsManager: false,
    },{
      path: '/managerView',
      name: 'managerView',
      component: Manager,
      droitsAdmin: true,
      droitsManager: true,
    },
  ]
})

router.beforeEach(async (to, from) => {

  const userConnected = localStorage.session ? localStorage.session : null
  const isConnected = userConnected ? JSON.parse(userConnected).active : false
  const isAuthoriseAdmin = userConnected ? JSON.parse(userConnected).isAuthoriseAdmin : false
  const isAuthoriseManager = userConnected ? JSON.parse(userConnected).isAuthoriseManager : false
  const userID = userConnected ? parseInt(JSON.parse(userConnected).id) : -1

  if (isConnected && to.name === 'login') {
    return {name: 'home'}
  }
  else if (!isConnected && to.name !== 'login') {
    return { name: 'login' }
  } else if(isConnected && to.name === 'login') {
    return { name: 'home' }
  }
  else if (to.name === 'working_times' && parseInt(to.params.userID) !== userID && !isAuthoriseManager) {
    toaster.error(`Access not autorized !`);
    return {name:'home'}
  }
    else if (to.name === 'chart_manager' && parseInt(to.params.userID) !== userID && !isAuthoriseManager) {
    toaster.error(`Access not autorized !`);
    return {name:'home'}
  }
  else if (isConnected && to.name === 'adminView' && true !== isAuthoriseAdmin) {
    return { name: 'home' }
  } else if (isConnected && to.name === 'managerView' && true !== isAuthoriseManager) {
    return { name: 'home' }
  }
  else if (isConnected && to.name === 'chart_managerTeam' && isAuthoriseManager !== true) {
    return { name: 'home' }
  }
  // else if (to.name === undefined) {
  //   return {name : 'home'}
  // }
})

export default router