<script setup>
  import { RouterView } from 'vue-router'
  import Navbar from '../components/Navbar.vue';
</script>

<template>
  <header class="header">
    <Navbar/>
  </header>
  <main class="main-content">
    <RouterView />
  </main>
  <footer class="footer">
    <h5 class="footer-copyright">©2022 Time manager. All rights reserved</h5>
  </footer>
</template>

<style scoped lang="scss">
  .header {
    background-color: black;
    height: 7.5%;
  }
  .main-content {
    background-color: white;
    height: 85%;
    margin: 0;
    padding: 2vh 1vw;
  }
  .footer {
    background-color: black;
    height: 7.5%;
    padding: 2vh 1vw;
    display: flex;
    justify-content: center;
    align-items: center;
    .footer-copyright {
      margin: 0;
      color: white;
      font-size: 14px;
    }
  }
</style>
