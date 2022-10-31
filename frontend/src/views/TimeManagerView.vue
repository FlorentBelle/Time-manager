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
</template>

<style scoped lang="scss">
  .header {
    height: 95%;
    width: 7em;
    position: absolute;
    z-index: 2;
  }
  .main-content {
    background-color: var(--bg-3);
    height: 100%;
    width: calc(100% - 7em);
    margin-left: 7em;
    padding: 2vh 1vw;
    border-radius: 15px;
  }
</style>
